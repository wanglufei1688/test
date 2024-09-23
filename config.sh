#!/bin/bash

[ -d /tmp/repo_conf ] || mkdir -p /tmp/repo_conf 

mv /etc/yum.repos.d/* /tmp/repo_conf

[ -d /iso ] || mkdir /iso

[ -f /etc/yum.repos.d/local.repo ] || touch /etc/yum.repos.d/local.repo

if `ping -c 2 www.baidu.com &> /dev/null`; then

wget -r -np -P /iso https://updates.os.nfschina.com/NFS4.0/GenOS/RPMS/	

cat > /etc/yum.repos.d/local.repo <<-EOF
	[base]
	name=base
	baseurl=file:///iso/
	enabled=1
	gpgcheck=0
EOF

yum clean all && yum makecache

echo -e "[\033[32m This task was successfully executed \033[0m]"

else

echo -e "[\033[31m The network is not working, please check the network configuration \033[0m]"
exit 1

fi
