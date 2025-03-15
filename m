Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E39C28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 06:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttLIl-0007rF-DT; Sat, 15 Mar 2025 02:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ttLIK-0007ox-RP; Sat, 15 Mar 2025 02:46:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ttLII-00071r-Jj; Sat, 15 Mar 2025 02:46:52 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52F3hinB004192;
 Sat, 15 Mar 2025 06:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=Wpqmmli5CNdgTOsAcMrsHK9XzdSq
 GPcMoCvJfYxyDnE=; b=Ly6HbN5c2H50lwdSkFrGPFg/QKdiX6L+VwWqFIki53h4
 5nySYdJQ6bXY3uPWKYyqTaEsxyFOCwctF/kZo18rcQFiausCwfIKIYl7kLrWF9JB
 0Dxie5EnseNYI7fA3TnbmPp+C7RtWbMn9XzfVrimjDkchJ0ZwWEsojqLdkJaTAFi
 lyPgLdXss5oma0kfVWyOMC93fIIb0wImuoxZN5iZdHVzsrJubJfs6DLDJVDrJSkn
 Vzdq28YBQu99jbs9j32rmetVse0YmC9kcKLb8ozX/m1QqJvJzFCAH9IYq2kKuDTd
 Y/pgxnfwQ4Lis69xaJ8CyWoXrhe/SzeKiylZEmo/nw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45d1vwgemr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 15 Mar 2025 06:46:46 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52F6kki9014463;
 Sat, 15 Mar 2025 06:46:46 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45d1vwgemm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 15 Mar 2025 06:46:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52F3aIFY026548;
 Sat, 15 Mar 2025 06:46:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45d1ssgj5v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 15 Mar 2025 06:46:44 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52F6keGS19792154
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 15 Mar 2025 06:46:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DEFAF20040;
 Sat, 15 Mar 2025 06:46:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4F6B20043;
 Sat, 15 Mar 2025 06:46:38 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.208.229])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 15 Mar 2025 06:46:38 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH v3 0/8] Implement Firmware Assisted Dump for PSeries
Date: Sat, 15 Mar 2025 12:16:28 +0530
Message-ID: <20250315064636.611714-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: g2OhaE5AFtqXMEd--jTI87_qEiLUg_zv
X-Proofpoint-ORIG-GUID: c818QM1KHrckWm7o8KzaKndfXZ-sQqFu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-15_02,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0
 mlxscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503150041
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Refer the Patch #7/8: "hw/ppc: Enable fadump for PSeries" for logs of a
succesfful fadump crash

Note: HPTE region has not been implemented. It's not planned as of now.

Testing
=======

Has been tested with following QEMU options:

* firmware: x-vof and SLOF
* tcg & kvm
* l1 guest and l2 guest
* with/without smp
* cma/nocma
* default crashkernel values (can fail with big initrd) and crashkernel=1G

Git Tree for Testing
====================

https://github.com/adi-g15-ibm/qemu/tree/fadump-pseries-v3

Note: You will need a way to get the /proc/vmcore out of the VM for testing
with crash-utility

I use the following command line which sets up networking:
    "-net user,hostfwd=tcp::10022-:22 -net nic"

And a rootfs with ssh support, then copy the /proc/vmcore with networking
(can do compression using gzip before ssh, but compression might take lot
of time if done inside the VM)

Test vmcore for Testing with crash-utility
==========================================

Can use vmlinux and vmcore available at https://github.com/adi-g15-ibm/qemu/releases/tag/test-images-fadump-pseries-v2
Above vmcore was generated with upstream qemu with these fadump patches
applied, and in a KVM VM
A limitation with above vmcore is it was a single CPU VM

Changelog
=========
v3: 
  + [patch #3,7]: fix compile errors (#define declared in a later patch
                  but used in this patch, unused var)
  + [patch #4/8]: use 'g_autofree' for cpu buffer, and replace g_malloc with
                  g_try_malloc
  + [patch #5/8]: use 'g_new' instead of 'malloc', add null check for cpu
                  region
  - nothing in other patches has been changed compared to v2

v2:
  + rearrange code so that no unused functions get introduced in any patch
  + add functional test for pseries as suggested by nick
  + fix multiple issues pointed by harsh and nick
  + fix bug in cpu register saving where it was being stored in
    little-endian
  - removed 'is_next_boot_fadump' and used fadump header's status flag to
    store it
  + fixed multiple style issues (naming, unneeded diffs etc)


Aditya Gupta (8):
  hw/ppc: Implement skeleton code for fadump in PSeries
  hw/ppc: Implement fadump register command
  hw/ppc: Trigger Fadump boot if fadump is registered
  hw/ppc: Preserve memory regions registered for fadump
  hw/ppc: Implement saving CPU state in Fadump
  hw/ppc: Pass dump-sizes property for fadump in device tree
  hw/ppc: Enable fadump for PSeries
  tests/functional: Add test for fadump in PSeries

 hw/ppc/meson.build                        |   1 +
 hw/ppc/spapr.c                            |  72 +++
 hw/ppc/spapr_fadump.c                     | 685 ++++++++++++++++++++++
 hw/ppc/spapr_rtas.c                       |  71 +++
 include/hw/ppc/spapr.h                    |  11 +-
 include/hw/ppc/spapr_fadump.h             | 121 ++++
 tests/functional/meson.build              |   2 +
 tests/functional/qemu_test/linuxkernel.py |  59 ++
 tests/functional/test_ppc64_fadump.py     | 185 ++++++
 9 files changed, 1206 insertions(+), 1 deletion(-)
 create mode 100644 hw/ppc/spapr_fadump.c
 create mode 100644 include/hw/ppc/spapr_fadump.h
 create mode 100755 tests/functional/test_ppc64_fadump.py

-- 
2.48.1


