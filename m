Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7914EC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 23:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpcl4-0000ds-6C; Wed, 27 Mar 2024 19:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wucf@linux.vnet.ibm.com>)
 id 1rpcl2-0000dW-F5
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 19:32:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wucf@linux.vnet.ibm.com>)
 id 1rpckz-0008BH-7t
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 19:32:36 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42RMk32Z001346
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 23:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=content-type :
 message-id : date : to : from : subject : mime-version; s=pp1;
 bh=+UXyVeuarkKqWKK0rLc970iyM7paLfu7b/0+q4ciMeQ=;
 b=R1D9Zm6o78WQix66rEZuWZG2WvuPlCyiSlN34A/8vrT825mpKyz3d56hSeOPkQNge2yh
 f3hfBgEz4a4iHNMM3Mp4gSSxD/0YMzyoHs9EV1hCadWDk68tR5lgLj32C57xgkbWUGpu
 BPThzzJNkUkKS7E6XAHmVfpANjRYJYdWua0wEj7KkLNRu4jQjJ5HdaOKYQLPIoqpbnTM
 2de+HGDqSyXZY7MoPF/m8PrbMGLVa8YAYbVmV+ZZP4wdWu0mWH5EimcaXP+aI5yFq6f0
 1GyOb1Jw4KaEiQl6f4yGZp05IkZAFx+9DyU3wi+T+kuDkKiwNV0SugOcShfOwXsJSK5y Xw== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x4txmg8av-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 23:32:30 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42RLZcLo012975
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 23:32:29 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x29t0t5s9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 23:32:29 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42RNWRvk21758668
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 23:32:29 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00B2458045
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 23:32:27 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 38EEF58054
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 23:32:26 +0000 (GMT)
Received: from [9.200.52.3] (unknown [9.200.52.3])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 23:32:25 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------w04fsHtgZsRtOKWQjk029wJ0"
Message-ID: <c2bad656-0231-4113-af5b-75e4247d2ee2@linux.vnet.ibm.com>
Date: Thu, 28 Mar 2024 07:32:24 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org
From: Chun Feng Wu <wucf@linux.vnet.ibm.com>
Subject: qemu process consumes 100% host CPU after reverting snapshot
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QcKVqrdZ6jwJtkorBe10ETz3ubIcGrhZ
X-Proofpoint-ORIG-GUID: QcKVqrdZ6jwJtkorBe10ETz3ubIcGrhZ
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_18,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 clxscore=1011 mlxscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403270164
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=wucf@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is a multi-part message in MIME format.
--------------w04fsHtgZsRtOKWQjk029wJ0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I am testing throttle filter chain(multiple throttle-groups on disk) 
with the following steps:
1. start guest vm(chained throttle filters applied on disk per 
https://github.com/qemu/qemu/blob/master/docs/throttle.txt)
2. take snapshot
3. revert snapshot

after step3, I noticed qemu process in host consumes 100% cpu, and after 
I login guest vm, vm cannot(or slowly) response my cmd (it works well 
before reverting).

/    PID     USER      PR  NI    VIRT    RES         SHR    S %CPU  
%MEM     TIME+ COMMAND
    65455 root      20   0 9659924 891328  20132 R 100.3   5.4 29:39.93 
qemu-system-x86/

/
/

Does anybody know why such issue happens?  is it a bug or I 
misunderstand something?

my cmd:

/qemu-system-x86_64 \
   -name ubuntu-20.04-vm,debug-threads=on \
   -machine pc-i440fx-jammy,usb=off,dump-guest-core=off \
   -accel kvm \
   -cpu 
Broadwell-IBRS,vme=on,ss=on,vmx=on,f16c=on,rdrand=on,hypervisor=on,arat=on,tsc-adjust=on,md-clear=on,stibp=on,ssbd=on,xsaveopt=on,pdpe1gb=on,abm=on,tsx-ctrl=off,hle=off,rtm=off 
\
   -m 8192 \
   -overcommit mem-lock=off \
   -smp 2,sockets=1,dies=1,cores=1,threads=2 \
   -numa node,nodeid=0,cpus=0-1,memdev=ram \
   -object memory-backend-ram,id=ram,size=8192M \
   -uuid d2d68f5d-bff0-4167-bbc3-643e3566b8fb \
   -display none \
   -nodefaults \
   -monitor stdio \
   -rtc base=utc,driftfix=slew \
   -no-shutdown \
   -boot strict=on \
   -device piix3-usb-uhci,id=usb,bus=pci.0,addr=0x1.0x2 \
   -object 
'{"qom-type":"throttle-group","id":"limit0","limits":{"bps-total":0,"bps-read":0,"bps-write":0,"iops-total":200,"iops-read":0,"iops-write":0,"bps-total-max":0,"bps-read-max":0,"bps-write-max":0,"iops-total-max":200,"iops-read-max":0,"iops-write-max":0,"iops-size":0,"bps-total-max-length":1,"bps-read-max-length":1,"bps-write-max-length":1,"iops-total-max-length":1,"iops-read-max-length":1,"iops-write-max-length":1}}' 
\
     -object 
'{"qom-type":"throttle-group","id":"limit1","limits":{"bps-total":0,"bps-read":0,"bps-write":0,"iops-total":250,"iops-read":0,"iops-write":0,"bps-total-max":0,"bps-read-max":0,"bps-write-max":0,"iops-total-max":250,"iops-read-max":0,"iops-write-max":0,"iops-size":0,"bps-total-max-length":1,"bps-read-max-length":1,"bps-write-max-length":1,"iops-total-max-length":1,"iops-read-max-length":1,"iops-write-max-length":1}}' 
\
     -object 
'{"qom-type":"throttle-group","id":"limit2","limits":{"bps-total":0,"bps-read":0,"bps-write":0,"iops-total":300,"iops-read":0,"iops-write":0,"bps-total-max":0,"bps-read-max":0,"bps-write-max":0,"iops-total-max":300,"iops-read-max":0,"iops-write-max":0,"iops-size":0,"bps-total-max-length":1,"bps-read-max-length":1,"bps-write-max-length":1,"iops-total-max-length":1,"iops-read-max-length":1,"iops-write-max-length":1}}' 
\
     -object 
'{"qom-type":"throttle-group","id":"limit012","limits":{"bps-total":0,"bps-read":0,"bps-write":0,"iops-total":400,"iops-read":0,"iops-write":0,"bps-total-max":0,"bps-read-max":0,"bps-write-max":0,"iops-total-max":400,"iops-read-max":0,"iops-write-max":0,"iops-size":0,"bps-total-max-length":1,"bps-read-max-length":1,"bps-write-max-length":1,"iops-total-max-length":1,"iops-read-max-length":1,"iops-write-max-length":1}}' 
\
   -blockdev 
'{"driver":"file","filename":"/virt/images/focal-server-cloudimg-amd64.img","node-name":"libvirt-4-storage","auto-read-only":true,"discard":"unmap"}' 
\
   -blockdev 
'{"node-name":"libvirt-4-format","read-only":false,"driver":"qcow2","file":"libvirt-4-storage","backing":null}' 
\
   -device 
virtio-blk-pci,bus=pci.0,addr=0x4,drive=libvirt-4-format,id=virtio-disk0,bootindex=1 
\
   -blockdev 
'{"driver":"file","filename":"/virt/disks/vm1_disk_1.qcow2","node-name":"libvirt-3-storage","auto-read-only":true,"discard":"unmap"}' 
\
   -blockdev 
'{"node-name":"libvirt-3-format","read-only":false,"driver":"qcow2","file":"libvirt-3-storage","backing":null}' 
\
   -blockdev 
'{"driver":"throttle","node-name":"libvirt-5-filter","throttle-group":"limit0","file":"libvirt-3-format"}' 
\
   -blockdev 
'{"driver":"throttle","node-name":"libvirt-6-filter","throttle-group":"limit012","file":"libvirt-5-filter"}' 
\
   -device 
virtio-blk-pci,bus=pci.0,addr=0x5,drive=libvirt-6-filter,id=virtio-disk1 \
   -blockdev 
'{"driver":"file","filename":"/virt/disks/vm1_disk_2.qcow2","node-name":"libvirt-2-storage","auto-read-only":true,"discard":"unmap"}' 
\
   -blockdev 
'{"node-name":"libvirt-2-format","read-only":false,"driver":"qcow2","file":"libvirt-2-storage","backing":null}' 
\
   -blockdev 
'{"driver":"throttle","node-name":"libvirt-3-filter","throttle-group":"limit1","file":"libvirt-2-format"}' 
\
   -blockdev 
'{"driver":"throttle","node-name":"libvirt-4-filter","throttle-group":"limit012","file":"libvirt-3-filter"}' 
\
   -device 
virtio-blk-pci,bus=pci.0,addr=0x6,drive=libvirt-4-filter,id=virtio-disk2 \
   -blockdev 
'{"driver":"file","filename":"/virt/disks/vm1_disk_3.qcow2","node-name":"libvirt-1-storage","auto-read-only":true,"discard":"unmap"}' 
\
   -blockdev 
'{"node-name":"libvirt-1-format","read-only":false,"driver":"qcow2","file":"libvirt-1-storage","backing":null}' 
\
   -blockdev 
'{"driver":"throttle","node-name":"libvirt-1-filter","throttle-group":"limit2","file":"libvirt-1-format"}' 
\
   -blockdev 
'{"driver":"throttle","node-name":"libvirt-2-filter","throttle-group":"limit012","file":"libvirt-1-filter"}' 
\
   -device 
virtio-blk-pci,bus=pci.0,addr=0x7,drive=libvirt-2-filter,id=virtio-disk3 \
   -netdev user,id=user0,hostfwd=tcp::2222-:22 \
   -device 
virtio-net-pci,netdev=user0,id=net0,mac=52:54:00:12:34:56,bus=pci.0,addr=0x3 
\
   -chardev pty,id=charserial0 \
   -device isa-serial,chardev=charserial0,id=serial0,index=0 \
   -device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x2 \
   -sandbox 
on,obsolete=deny,elevateprivileges=deny,spawn=deny,resourcecontrol=deny \
   -msg timestamp=on/


snapshot and reverting:

/(qemu) info status
VM status: running
(qemu) savevm snapshot1
(qemu) loadvm snapshot1/


my env:
/:~# qemu-system-x86_64 --version
QEMU emulator version 6.2.0 (Debian 1:6.2+dfsg-2ubuntu6.17)
Copyright (c) 2003-2021 Fabrice Bellard and the QEMU Project developers

:~# lsb_release -a
No LSB modules are available.
Distributor ID:    Ubuntu
Description:    Ubuntu 22.04.4 LTS
Release:    22.04
Codename:    jammy/

-- 
Thanks and Regards,

Wu

--------------w04fsHtgZsRtOKWQjk029wJ0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi,</p>
    <p>I am testing throttle filter chain(multiple throttle-groups on
      disk) with the following steps:<br>
      1. start guest vm(chained throttle filters applied on disk per <a
        class="moz-txt-link-freetext"
href="https://github.com/qemu/qemu/blob/master/docs/throttle.txt">https://github.com/qemu/qemu/blob/master/docs/throttle.txt</a>)<br>
      2. take snapshot<br>
      3. revert snapshot</p>
    <p>after step3, I noticed qemu process in host consumes 100% cpu,
      and after I login guest vm, vm cannot(or slowly) response my cmd
      (it works well before reverting).<br>
    </p>
    <p><i>    PID     USER      PR  NI    VIRT    RES         SHR    S 
        %CPU  %MEM     TIME+ COMMAND<br>
           65455 root      20   0 9659924 891328  20132 R 100.3   5.4   
        29:39.93 qemu-system-x86</i></p>
    <p><i><br>
      </i></p>
    <p>Does anybody know why such issue happens?  is it a bug or I
      misunderstand something?<br>
    </p>
    <p>my cmd:</p>
    <p><i>qemu-system-x86_64 \<br>
          -name ubuntu-20.04-vm,debug-threads=on \<br>
          -machine pc-i440fx-jammy,usb=off,dump-guest-core=off \<br>
          -accel kvm \<br>
          -cpu
Broadwell-IBRS,vme=on,ss=on,vmx=on,f16c=on,rdrand=on,hypervisor=on,arat=on,tsc-adjust=on,md-clear=on,stibp=on,ssbd=on,xsaveopt=on,pdpe1gb=on,abm=on,tsx-ctrl=off,hle=off,rtm=off
        \<br>
          -m 8192 \<br>
          -overcommit mem-lock=off \<br>
          -smp 2,sockets=1,dies=1,cores=1,threads=2 \<br>
          -numa node,nodeid=0,cpus=0-1,memdev=ram \<br>
          -object memory-backend-ram,id=ram,size=8192M \<br>
          -uuid d2d68f5d-bff0-4167-bbc3-643e3566b8fb \<br>
          -display none \<br>
          -nodefaults \<br>
          -monitor stdio \<br>
          -rtc base=utc,driftfix=slew \<br>
          -no-shutdown \<br>
          -boot strict=on \<br>
          -device piix3-usb-uhci,id=usb,bus=pci.0,addr=0x1.0x2 \<br>
          -object
'{"qom-type":"throttle-group","id":"limit0","limits":{"bps-total":0,"bps-read":0,"bps-write":0,"iops-total":200,"iops-read":0,"iops-write":0,"bps-total-max":0,"bps-read-max":0,"bps-write-max":0,"iops-total-max":200,"iops-read-max":0,"iops-write-max":0,"iops-size":0,"bps-total-max-length":1,"bps-read-max-length":1,"bps-write-max-length":1,"iops-total-max-length":1,"iops-read-max-length":1,"iops-write-max-length":1}}'
        \<br>
            -object
'{"qom-type":"throttle-group","id":"limit1","limits":{"bps-total":0,"bps-read":0,"bps-write":0,"iops-total":250,"iops-read":0,"iops-write":0,"bps-total-max":0,"bps-read-max":0,"bps-write-max":0,"iops-total-max":250,"iops-read-max":0,"iops-write-max":0,"iops-size":0,"bps-total-max-length":1,"bps-read-max-length":1,"bps-write-max-length":1,"iops-total-max-length":1,"iops-read-max-length":1,"iops-write-max-length":1}}'
        \<br>
            -object
'{"qom-type":"throttle-group","id":"limit2","limits":{"bps-total":0,"bps-read":0,"bps-write":0,"iops-total":300,"iops-read":0,"iops-write":0,"bps-total-max":0,"bps-read-max":0,"bps-write-max":0,"iops-total-max":300,"iops-read-max":0,"iops-write-max":0,"iops-size":0,"bps-total-max-length":1,"bps-read-max-length":1,"bps-write-max-length":1,"iops-total-max-length":1,"iops-read-max-length":1,"iops-write-max-length":1}}'
        \<br>
            -object
'{"qom-type":"throttle-group","id":"limit012","limits":{"bps-total":0,"bps-read":0,"bps-write":0,"iops-total":400,"iops-read":0,"iops-write":0,"bps-total-max":0,"bps-read-max":0,"bps-write-max":0,"iops-total-max":400,"iops-read-max":0,"iops-write-max":0,"iops-size":0,"bps-total-max-length":1,"bps-read-max-length":1,"bps-write-max-length":1,"iops-total-max-length":1,"iops-read-max-length":1,"iops-write-max-length":1}}'
        \<br>
          -blockdev
'{"driver":"file","filename":"/virt/images/focal-server-cloudimg-amd64.img","node-name":"libvirt-4-storage","auto-read-only":true,"discard":"unmap"}'
        \<br>
          -blockdev
'{"node-name":"libvirt-4-format","read-only":false,"driver":"qcow2","file":"libvirt-4-storage","backing":null}'
        \<br>
          -device
virtio-blk-pci,bus=pci.0,addr=0x4,drive=libvirt-4-format,id=virtio-disk0,bootindex=1
        \<br>
          -blockdev
'{"driver":"file","filename":"/virt/disks/vm1_disk_1.qcow2","node-name":"libvirt-3-storage","auto-read-only":true,"discard":"unmap"}'
        \<br>
          -blockdev
'{"node-name":"libvirt-3-format","read-only":false,"driver":"qcow2","file":"libvirt-3-storage","backing":null}'
        \<br>
          -blockdev
'{"driver":"throttle","node-name":"libvirt-5-filter","throttle-group":"limit0","file":"libvirt-3-format"}'
        \<br>
          -blockdev
'{"driver":"throttle","node-name":"libvirt-6-filter","throttle-group":"limit012","file":"libvirt-5-filter"}'
        \<br>
          -device
        virtio-blk-pci,bus=pci.0,addr=0x5,drive=libvirt-6-filter,id=virtio-disk1
        \<br>
          -blockdev
'{"driver":"file","filename":"/virt/disks/vm1_disk_2.qcow2","node-name":"libvirt-2-storage","auto-read-only":true,"discard":"unmap"}'
        \<br>
          -blockdev
'{"node-name":"libvirt-2-format","read-only":false,"driver":"qcow2","file":"libvirt-2-storage","backing":null}'
        \<br>
          -blockdev
'{"driver":"throttle","node-name":"libvirt-3-filter","throttle-group":"limit1","file":"libvirt-2-format"}'
        \<br>
          -blockdev
'{"driver":"throttle","node-name":"libvirt-4-filter","throttle-group":"limit012","file":"libvirt-3-filter"}'
        \<br>
          -device
        virtio-blk-pci,bus=pci.0,addr=0x6,drive=libvirt-4-filter,id=virtio-disk2
        \<br>
          -blockdev
'{"driver":"file","filename":"/virt/disks/vm1_disk_3.qcow2","node-name":"libvirt-1-storage","auto-read-only":true,"discard":"unmap"}'
        \<br>
          -blockdev
'{"node-name":"libvirt-1-format","read-only":false,"driver":"qcow2","file":"libvirt-1-storage","backing":null}'
        \<br>
          -blockdev
'{"driver":"throttle","node-name":"libvirt-1-filter","throttle-group":"limit2","file":"libvirt-1-format"}'
        \<br>
          -blockdev
'{"driver":"throttle","node-name":"libvirt-2-filter","throttle-group":"limit012","file":"libvirt-1-filter"}'
        \<br>
          -device
        virtio-blk-pci,bus=pci.0,addr=0x7,drive=libvirt-2-filter,id=virtio-disk3
        \<br>
          -netdev user,id=user0,hostfwd=tcp::2222-:22 \<br>
          -device
virtio-net-pci,netdev=user0,id=net0,mac=52:54:00:12:34:56,bus=pci.0,addr=0x3
        \<br>
          -chardev pty,id=charserial0 \<br>
          -device isa-serial,chardev=charserial0,id=serial0,index=0 \<br>
          -device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x2 \<br>
          -sandbox
        on,obsolete=deny,elevateprivileges=deny,spawn=deny,resourcecontrol=deny
        \<br>
          -msg timestamp=on</i></p>
    <p><br>
    </p>
    <p>snapshot and reverting:<br>
      <br>
      <i>(qemu) info status<br>
        VM status: running<br>
        (qemu) savevm snapshot1<br>
        (qemu) loadvm snapshot1</i></p>
    <p><br>
    </p>
    <p>my env:<br>
      <i>:~# qemu-system-x86_64 --version<br>
        QEMU emulator version 6.2.0 (Debian 1:6.2+dfsg-2ubuntu6.17)<br>
        Copyright (c) 2003-2021 Fabrice Bellard and the QEMU Project
        developers<br>
        <br>
        :~# lsb_release -a<br>
        No LSB modules are available.<br>
        Distributor ID:    Ubuntu<br>
        Description:    Ubuntu 22.04.4 LTS<br>
        Release:    22.04<br>
        Codename:    jammy</i></p>
    <p></p>
    <pre class="moz-signature" cols="72">-- 
Thanks and Regards,

Wu</pre>
  </body>
</html>

--------------w04fsHtgZsRtOKWQjk029wJ0--


