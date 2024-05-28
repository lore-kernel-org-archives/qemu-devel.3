Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE51CC27C43
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 07:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBqv3-0007Nx-2j; Tue, 28 May 2024 03:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sBqun-0007AN-Ai; Tue, 28 May 2024 03:06:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sBquc-0004k4-8s; Tue, 28 May 2024 03:06:28 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44S6Ad0U004346; Tue, 28 May 2024 07:05:26 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Dibm.com; _h=3Dcc?=
 =?UTF-8?Q?:content-transfer-encoding:content-type:date:from:message-id:mi?=
 =?UTF-8?Q?me-version:subject:to;_s=3Dpp1;_bh=3DA01WiibRNdODy+rGo32jGVjWL9?=
 =?UTF-8?Q?OUEuZ+a+uyT/wwEcw=3D;_b=3DY3i/iPMj9RmuQB5XIJlDAuaNcThmR1K3R6M7M?=
 =?UTF-8?Q?ggdKlHSiS/jEt5DvisB8zlImA/VcIoJ_vHshULtgip/W7yTmUTgw8Lad4bKD7DW?=
 =?UTF-8?Q?Ei57cMrW4sFfDIxFMXcLl1N4XeZGO4P3U2jl3_0G5sMbHdSxJPi0W0JOcyBaXgp?=
 =?UTF-8?Q?O1FqMAMCQDXJuMYCmwMZmPnZk7tLaBUtqFW+x7gAU79_s7HLzq9FBrdvb2QVpCK?=
 =?UTF-8?Q?rBOVlAdJr37PUxdvxnH8Kw1DZkag5Au45H6h9rwHQLHSoxIaf_vvxJMyN7oc58p?=
 =?UTF-8?Q?sGvLFuLuqc0vKjIdIhsMUfb23Ol/nuCAZqNp3xhOLD2j02+hZl2YHT1_hg=3D?=
 =?UTF-8?Q?=3D_?=
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yd971r6xe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 07:05:25 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44S75O2T025644;
 Tue, 28 May 2024 07:05:24 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yd971r6xc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 07:05:24 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44S4ab0w006716; Tue, 28 May 2024 07:05:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ybtatdqf4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 May 2024 07:05:23 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44S75IOP33030898
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 May 2024 07:05:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2843320043;
 Tue, 28 May 2024 07:05:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6971820063;
 Tue, 28 May 2024 07:05:16 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.72]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 May 2024 07:05:16 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: [PATCH v4 00/11] Power11 support for QEMU
Date: Tue, 28 May 2024 12:35:04 +0530
Message-ID: <20240528070515.117160-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oedztlpwJyUkCppgv-ZdjgIk5WJJmNwS
X-Proofpoint-GUID: -8J4ReOSp1MooaXIqxS1TWqfsF6eKCBN
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_04,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280050
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
============

Add support for Power11 pseries and powernv machine types, to emulate VMs
running on Power11.

As Power11 core is same as Power10, hence much of the code has been reused from
Power10.

Power11 was added in Linux in:
  commit c2ed087ed35c ("powerpc: Add Power11 architected and raw mode")

Git Tree for Testing
====================

QEMU: https://github.com/adi-g15-ibm/qemu/tree/p11-v3

Has been tested with following cases:
* '-M pseries' / '-M pseries -cpu Power11'
* '-M powernv' / '-M powernv10' / '-M powernv11'
* '-smp' option tested
* with compat mode: 'max-cpu-compat=power10' and 'max-cpu-compat=power9'
* with/without device 'virtio-scsi-pci'
* with/without -kernel and -drive with qcow_file

skiboot with Power11 support: https://github.com/maheshsal/skiboot/tree/upstream_power11

Linux with Power11 support: https://github.com/torvalds/linux, since v6.9-rc1

Note: This patch series does not add tests as of now, and will be done as
soon as skiboot support for Power11 gets merged, and op-build adds a
release for Power11

Changelog
=========
v4:
  + patch #5: fix memory leak in pnv_chip_power10_quad_realize
  - no change in other patches

v3:
  + patch #1: version power11 as power11_v2.0
  + patch #2: split target hw/pseries code into patch #2
  + patch #3,#4: fix regression due to Power10 and Power11 having same PCR
  + patch #5: create pnv_chip_power11_dt_populate and split pnv_chip_power10_common_realize as per review
  + patch #6-#11: no change
  - remove commit to make Power11 as default

v2:
  + split powernv patch into homer,lpc,occ,psi,sbe
  + reduce code duplication by reusing power10 code
  + make power11 as default
  + rebase on qemu upstream/master
  + add more information in commit descriptions
  + update docs
  + update skiboot.lid


Aditya Gupta (11):
  ppc: Add Power11 DD2.0 processor
  ppc/pseries: Add Power11 cpu type
  target/ppc: Introduce 'PowerPCCPUClass::logical_pvr'
  target/ppc: Fix regression due to Power10 and Power11 having same PCR
  ppc/pnv: Add a Power11 Pnv11Chip, and a Power11 Machine
  ppc/pnv: Add HOMER for POWER11
  ppc/pnv: Add a LPC controller for POWER11
  ppc/pnv: Add OCC for Power11
  ppc/pnv: Add a PSI bridge model for Power11
  ppc/pnv: Add SBE model for Power11
  ppc/pnv: Update skiboot.lid to support Power11

 docs/system/ppc/powernv.rst |   9 +--
 docs/system/ppc/pseries.rst |   6 +-
 hw/ppc/pnv.c                | 120 ++++++++++++++++++++++++++++++++++--
 hw/ppc/pnv_core.c           |  11 ++++
 hw/ppc/pnv_homer.c          |   8 +++
 hw/ppc/pnv_lpc.c            |  14 +++++
 hw/ppc/pnv_occ.c            |  14 +++++
 hw/ppc/pnv_psi.c            |  24 ++++++++
 hw/ppc/pnv_sbe.c            |  15 +++++
 hw/ppc/spapr_cpu_core.c     |   1 +
 include/hw/ppc/pnv.h        |   5 ++
 include/hw/ppc/pnv_chip.h   |   7 +++
 include/hw/ppc/pnv_core.h   |   1 +
 include/hw/ppc/pnv_homer.h  |   3 +
 include/hw/ppc/pnv_lpc.h    |   4 ++
 include/hw/ppc/pnv_occ.h    |   2 +
 include/hw/ppc/pnv_psi.h    |   2 +
 include/hw/ppc/pnv_sbe.h    |   2 +
 pc-bios/skiboot.lid         | Bin 2527328 -> 2527328 bytes
 target/ppc/compat.c         |  11 ++++
 target/ppc/cpu-models.c     |   3 +
 target/ppc/cpu-models.h     |   3 +
 target/ppc/cpu.h            |   1 +
 target/ppc/cpu_init.c       | 107 ++++++++++++++++++++++++++++++++
 24 files changed, 362 insertions(+), 11 deletions(-)

-- 
2.45.1


