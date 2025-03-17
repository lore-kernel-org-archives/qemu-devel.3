Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD06AC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 22:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuJHd-00029n-2J; Mon, 17 Mar 2025 18:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misanjum@linux.ibm.com>)
 id 1tuHCV-0004D2-Bk; Mon, 17 Mar 2025 16:36:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misanjum@linux.ibm.com>)
 id 1tuHCS-0006Hd-FB; Mon, 17 Mar 2025 16:36:42 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HKZgTc027943;
 Mon, 17 Mar 2025 20:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=OpmjceqB1D4VUFrCFoMn/Vn079rP
 1CQKXGez7l/jBKs=; b=EpiZPbLf1CEfadVwk64Q1WhORz+yW1xBiasbhADkks+G
 h35wj5+xjoBkRIcnmR1mTIO/SgFrrO9h6vVNU0nyIENv5K8m5rvwtcXR3qx42WZa
 IjQkLXDzOD2KWJNFTOFQF1buzFAqiDxqhhHLM5xjN5rdvWC6id0CQcx8/ElY7f1L
 +80u3n1NJDofbmvAcqxVJc/4691kpgHgT1imLuSYb5DVcU6RjNCMGk8d68r32sP5
 WUw/FXLX8A3PYPkznI+6MXZaY09RLAqFcCzMpZcVB5DFXu+tt77ylXqAVL8DNZwy
 ZriKQtbbXCoIrHeCAi6rLey4v9TkR+xTqSPLZSMjQQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45etwq8020-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Mar 2025 20:36:37 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52HKaaGo029507;
 Mon, 17 Mar 2025 20:36:36 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45etwq801y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Mar 2025 20:36:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52HGkt6p005741;
 Mon, 17 Mar 2025 20:36:36 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dpk27tru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Mar 2025 20:36:35 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52HKaZuK28836360
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Mar 2025 20:36:35 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8999A5805A;
 Mon, 17 Mar 2025 20:36:35 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CFEB58051;
 Mon, 17 Mar 2025 20:36:35 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Mar 2025 20:36:35 +0000 (GMT)
MIME-Version: 1.0
Date: Tue, 18 Mar 2025 02:06:35 +0530
From: misanjum <misanjum@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com
Subject: [BUG][powerpc] KVM Guest Boot Failure and Hang at "Booting Linux via
 __start()"
Message-ID: <7820ffeff34ce93a3ee1f6157a1f44d9@imap.linux.ibm.com>
X-Sender: misanjum@linux.ibm.com
Organization: IBM
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: khMgWQfzbKH7sv_huYVjp8kSTK1BWKfQ
X-Proofpoint-ORIG-GUID: yUna8Wm9gkNlHT7wlQPMkNVZCK1FQmAv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_08,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 spamscore=0 clxscore=1011 impostorscore=0 mlxscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503170148
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=misanjum@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 17 Mar 2025 18:50:06 -0400
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

Bug Description:
Encountering a boot failure when launching a KVM guest with 
'qemu-system-ppc64'. The guest hangs at boot, and the QEMU monitor 
crashes.


Reproduction Steps:
# qemu-system-ppc64 --version
QEMU emulator version 9.2.50 (v9.2.0-2799-g0462a32b4f)
Copyright (c) 2003-2025 Fabrice Bellard and the QEMU Project developers

# /usr/bin/qemu-system-ppc64 -name avocado-vt-vm1 -machine 
pseries,accel=kvm \
   -m 32768 -smp 32,sockets=1,cores=32,threads=1 -nographic \
   -device virtio-scsi-pci,id=scsi \
   -drive 
file=/home/kvmci/tests/data/avocado-vt/images/rhel8.0devel-ppc64le.qcow2,if=none,id=drive0,format=qcow2 
\
   -device scsi-hd,drive=drive0,bus=scsi.0 \
   -netdev bridge,id=net0,br=virbr0 \
   -device virtio-net-pci,netdev=net0 \
   -serial pty \
   -device virtio-balloon-pci \
   -cpu host
QEMU 9.2.50 monitor - type 'help' for more information
char device redirected to /dev/pts/2 (label serial0)
(qemu)
(qemu) qemu-system-ppc64: warning: kernel_irqchip allowed but 
unavailable: IRQ_XIVE capability must be present for KVM
Falling back to kernel-irqchip=off
** Qemu Hang

(In another ssh session)
# screen /dev/pts/2
Preparing to boot Linux version 6.10.4-200.fc40.ppc64le 
(mockbuild@c23cc4e677614c34bb22d54eeea4dc1f) (gcc (GCC) 14.2.1 20240801 
(Red Hat 14.2.1-1), GNU ld version 2.41-37.fc40) #1 SMP Sun Aug 11 
15:20:17 UTC 2024
Detected machine type: 0000000000000101
command line: 
BOOT_IMAGE=(ieee1275/disk,msdos2)/vmlinuz-6.10.4-200.fc40.ppc64le 
root=/dev/mapper/fedora-root ro rd.lvm.lv=fedora/root crashkernel=1024M
Max number of cores passed to firmware: 2048 (NR_CPUS = 2048)
Calling ibm,client-architecture-support... done
memory layout at init:
   memory_limit : 0000000000000000 (16 MB aligned)
   alloc_bottom : 0000000008200000
   alloc_top    : 0000000030000000
   alloc_top_hi : 0000000800000000
   rmo_top      : 0000000030000000
   ram_top      : 0000000800000000
instantiating rtas at 0x000000002fff0000... done
prom_hold_cpus: skipped
copying OF device tree...
Building dt strings...
Building dt structure...
Device tree strings 0x0000000008210000 -> 0x0000000008210bd0
Device tree struct  0x0000000008220000 -> 0x0000000008230000
Quiescing Open Firmware ...
Booting Linux via __start() @ 0x0000000000440000 ...
** Guest Console Hang


Git Bisect:
Performing git bisect points to the following patch:
# git bisect bad
e8291ec16da80566c121c68d9112be458954d90b is the first bad commit
commit e8291ec16da80566c121c68d9112be458954d90b (HEAD)
Author: Nicholas Piggin <npiggin@gmail.com>
Date:   Thu Dec 19 13:40:31 2024 +1000

     target/ppc: fix timebase register reset state

     (H)DEC and PURR get reset before icount does, which causes them to 
be
     skewed and not match the init state. This can cause replay to not
     match the recorded trace exactly. For DEC and HDEC this is usually 
not
     noticable since they tend to get programmed before affecting the
     target machine. PURR has been observed to cause replay bugs when
     running Linux.

     Fix this by resetting using a time of 0.

     Message-ID: <20241219034035.1826173-2-npiggin@gmail.com>
     Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

  hw/ppc/ppc.c | 11 ++++++++---
  1 file changed, 8 insertions(+), 3 deletions(-)


Reverting the patch helps boot the guest.
Thanks,
Misbah Anjum N

