Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A331EC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 07:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjvNg-0004Rg-KM; Mon, 17 Feb 2025 02:17:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tjvNf-0004Qh-0g; Mon, 17 Feb 2025 02:17:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tjvNb-0002eb-QW; Mon, 17 Feb 2025 02:17:26 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H5OGJS031595;
 Mon, 17 Feb 2025 07:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=7UJK8v025MOPcI/1imgWEJ6GBHkm
 08zRHG6zR2BIgs0=; b=DuP2RPeBWmTWJ0tIW57oL6bmk/IJ7XJv1H1R4P9PNwvJ
 wxrYCbD1n1ucS1MBjhRj6Xh5iIKb5utd7X5yuKGJuT+LgPPsChhqOTrHp9RTcuoP
 h6uM0XaWnjBrRAH9OSRUZcKssefjzEyP/tPpqTt+K/x0kg8C/dAphc4lHi09VJGq
 P2r4pyKd7xtuEQvALPBOkPZrDlMPCiEK0d1/ubFY+8l61nGWapGxg4PwF33pqd1c
 ZYy1I6Qdc1Z4Bj4sGWpp0cGIvhe90jCnzLyn3bgDnZ0m7Lepuvm3gGZcwfCHuf7u
 u+c4WZ7MibbuLdp6OZibikGDkjKRrOlYk/0c47OF9A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44uxx7rf31-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:17:20 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51H7CgK3031236;
 Mon, 17 Feb 2025 07:17:20 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44uxx7rf2e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:17:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51H355cs008164;
 Mon, 17 Feb 2025 07:17:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44u58td4uu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Feb 2025 07:17:17 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51H7HECe14549412
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Feb 2025 07:17:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EBD142004B;
 Mon, 17 Feb 2025 07:17:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5ECAE20049;
 Mon, 17 Feb 2025 07:17:12 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.160])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Feb 2025 07:17:12 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH 0/6] Implement Firmware Assisted Dump for PSeries
Date: Mon, 17 Feb 2025 12:47:05 +0530
Message-ID: <20250217071711.83735-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bjBM9U3pWHg8uhDqBo1M_19cV_oZCBxX
X-Proofpoint-ORIG-GUID: On-fbh8--SaluoyP_SLTjTayUZnTsnYs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502170060
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Overview
=========

Implemented Firmware Assisted Dump (fadump) on PSeries machine in QEMU.

Fadump is an alternative dump mechanism to kdump, in which we the firmware
does a memory preserving boot, and the second/crashkernel is booted fresh
like a normal system reset, instead of the crashed kernel loading the
second/crashkernel in case of kdump.

This requires implementing the "ibm,configure-kernel-dump" RTAS call in
QEMU.

While booting with fadump=on, Linux will register fadump memory regions.

Some memory regions like Real Mode Memory regions, and custom memory
regions declared by OS basically require copying the requested memory
range to a destination

While other memory regions are populated by the firmware/platform (QEMU in
this case), such as CPU State Data and HPTE.
We pass the sizes for these data segment to the kernel as it needs to know
how much memory to reserve (ibm,configure-kernel-dump-sizes).

Then after a crash, once Linux does a OS terminate call, we trigger fadump
if fadump was registered.

Implementing the fadump boot as:
    * pause all vcpus (will save registers later)
    * preserve memory regions specified by fadump
    * do a memory preserving reboot (using GUEST_RESET as it doesn't clear
      the memory)

And then we pass a metadata (firmware memory structure) as
"ibm,kernel-dump" in the device tree, containing all details of the
preserved memory regions to the kernel.

Testing
=======

Has been tested with following QEMU options:

* firmware: x-vof and SLOF
* tcg & kvm
* l1 guest and l2 guest
* with/without smp
* cma/nocma
* default crashkernel values and crashkernel=1G

Logs of a linux boot with firmware assisted dump:

    ./build/qemu-system-ppc64 -M pseries,x-vof=on --cpu power10 --smp 4 -m 4G -kernel some-vmlinux -initrd some-initrd -append "debug fadump=on crashkernel=1G" -nographic
    [    0.000000] random: crng init done
    [    0.000000] fadump: Reserved 1024MB of memory at 0x00000040000000 (System RAM: 4096MB)
    ...
    [    1.084686] rtas fadump: Registration is successful!
    ...
    # cat /sys/kernel/debug/powerpc/fadump_region
    CPU :[0x00000040000000-0x000000400013d3] 0x13d4 bytes, Dumped: 0x0
    HPTE:[0x000000400013d4-0x000000400013d3] 0x0 bytes, Dumped: 0x0
    DUMP: Src: 0x00000000000000, Dest: 0x00000040010000, Size: 0x40000000, Dumped: 0x0 bytes

    [0x000000fffff800-0x000000ffffffff]: cmdline append: ''
    # echo c > /proc/sysrq-trigger

The fadump boot after crash:

    [    0.000000] rtas fadump: Firmware-assisted dump is active.
    [    0.000000] fadump: Updated cmdline: debug fadump=on crashkernel=1G
    [    0.000000] fadump: Firmware-assisted dump is active.
    [    0.000000] fadump: Reserving 3072MB of memory at 0x00000040000000 for preserving crash data
    ....
    # file /proc/vmcore
    /proc/vmcore: ELF 64-bit LSB core file, 64-bit PowerPC or cisco 7500, OpenPOWER ELF V2 ABI, version 1 (SYSV), SVR4-style

Analysing the vmcore with crash-utility:

          KERNEL: vmlinux-6.14-rc2
        DUMPFILE: vmcore-a64dcfb451e2-nocma
            CPUS: 4
            DATE: Thu Jan  1 05:30:00 IST 1970
          UPTIME: 00:00:30
    LOAD AVERAGE: 0.74, 0.21, 0.07
           TASKS: 94
        NODENAME: buildroot
         RELEASE: 6.14.0-rc2+
         VERSION: #1 SMP Wed Feb 12 06:49:59 CST 2025
         MACHINE: ppc64le  (1000 Mhz)
          MEMORY: 4 GB
           PANIC: "Kernel panic - not syncing: sysrq triggered crash"
             PID: 270
         COMMAND: "sh"
            TASK: c000000009e7cc00  [THREAD_INFO: c000000009e7cc00]
             CPU: 3
           STATE: TASK_RUNNING (PANIC)



Git Tree for Testing
====================

https://github.com/adi-g15-ibm/qemu/tree/fadump-pseries-v1

Known Issues
============

* CPU register saving seems to have cases where it's showing all registers
with the same value

* The implementation doesn't pass all the registers mentioned in PAPR since
  QEMU doesn't implement them/doesn't need them.
  The linux kernel uses only 9 of the 45 registers we are passing in QEMU.

Aditya Gupta (6):
  hw/ppc: Implement skeleton code for fadump in PSeries
  hw/ppc: Trigger Fadump boot if fadump is registered
  hw/ppc: Preserve memory regions registered for fadump
  hw/ppc: Implement saving CPU state in Fadump
  hw/ppc: Pass device tree properties for Fadump
  hw/ppc: Enable Fadump for PSeries

 hw/ppc/spapr.c         |  62 ++++++
 hw/ppc/spapr_rtas.c    | 456 +++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h | 172 +++++++++++++++-
 3 files changed, 689 insertions(+), 1 deletion(-)

-- 
2.48.1


