Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EF1C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 17:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPK8-0002Cf-2V; Sun, 23 Mar 2025 13:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1twPJ8-00016U-OE; Sun, 23 Mar 2025 13:40:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1twPJ5-0003Ng-Vp; Sun, 23 Mar 2025 13:40:21 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52NCU79g014706;
 Sun, 23 Mar 2025 17:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=/9mc9zLo6KKvP3lRz/RVJ207Z1BK
 nmgzYZKK/iIQEAg=; b=D/ju49PCwdmptLn6sASOBDQOZR5BYRht4okmdvtMKSvQ
 lYeg7sWs9WB54pDkdkh+Et4KZ4lnyYMgApN5U5akTuZsE9nmyfX4VuzuSoRFVSTQ
 TH7aqLEY2v5gvp/r83X4tjSHWooxIA0qjq5jsykVMy20kDCbx6HnOHmaAIWIw45x
 UZ25Zu/SE3Nv2JSsKXs5Huaw+ebrGtamreIhy/Bj2fekzMzRjL6Wo6SeQg67NLS+
 5Rf3vKjXsJ+FlA7mAN/6SGi9JJNNvJ3q7mk/Ea0io+4J4/Ap+nR3MRAY6fPlvaZx
 QP7v3C5qDMX1ikEzqy14aGXckoZgEFDYLhU8lP488A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45j4dyk0g2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Mar 2025 17:40:16 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52NHeFog024479;
 Sun, 23 Mar 2025 17:40:15 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45j4dyk0fy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Mar 2025 17:40:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52NHLU0d020001;
 Sun, 23 Mar 2025 17:40:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j8hnjp00-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Mar 2025 17:40:14 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52NHeBo837683490
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 23 Mar 2025 17:40:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4AC9C20043;
 Sun, 23 Mar 2025 17:40:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E81A120040;
 Sun, 23 Mar 2025 17:40:08 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.214.162])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 23 Mar 2025 17:40:08 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH v4 0/8] Implement Firmware Assisted Dump for PSeries
Date: Sun, 23 Mar 2025 23:09:59 +0530
Message-ID: <20250323174007.221116-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oqK7kP2d10dOphp_2X4w0Hr9L2-AX9yX
X-Proofpoint-ORIG-GUID: 8N75WWpzJWZeaDWivaw0QFon8SfmjQ3B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-23_08,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503230123
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

https://github.com/adi-g15-ibm/qemu/tree/fadump-pseries-v4

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
v4
  + [patch #8/8]: fixed kvm testcase, add license

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
 tests/functional/test_ppc64_fadump.py     | 182 ++++++
 9 files changed, 1203 insertions(+), 1 deletion(-)
 create mode 100644 hw/ppc/spapr_fadump.c
 create mode 100644 include/hw/ppc/spapr_fadump.h
 create mode 100755 tests/functional/test_ppc64_fadump.py

-- 
2.49.0


