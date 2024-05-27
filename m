Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682E1C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 07:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBUVd-0003dO-3k; Mon, 27 May 2024 03:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sBUVa-0003ay-HQ; Mon, 27 May 2024 03:11:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sBUVY-0003QR-Kp; Mon, 27 May 2024 03:11:02 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44R77Tm1008474; Mon, 27 May 2024 07:10:54 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Dibm.com; _h=3Dcc?=
 =?UTF-8?Q?:content-transfer-encoding:content-type:date:from:message-id:mi?=
 =?UTF-8?Q?me-version:subject:to;_s=3Dpp1;_bh=3DNWHwRz3bxTbfgrvGvQqDoswFR3?=
 =?UTF-8?Q?uwAP5W6OoXAIJ4xcI=3D;_b=3DTH6nqrCWxAbny/Hz3GNbDs9x/8PRwdrCJB52E?=
 =?UTF-8?Q?KBs2JK0cXBvdpiYfoWiDajw8H+UOHO7_fZ6hBD78ZtfkldgfqYwA63YSxiFkoMg?=
 =?UTF-8?Q?xJO+AjlT4u/eaRKv9iZFxykNoh8Nl8QNhQrNz_zWFwAoIb2K/kO6vbEpJrCBItd?=
 =?UTF-8?Q?a2Uy5EV+Et2YCtgJ/AoS/hYTmuWDBGgNOVYOO2SGpt6_MJZ+/UXOWbgPF8dFz3s?=
 =?UTF-8?Q?5qQyDpm2W5P/FdQxlLrWnahRKJMll8WTVMeXanK2lwGBZ66MX_fijXKiMMEyKXz?=
 =?UTF-8?Q?pyNw1/Qr2cGGMabxc+tVRypM2X0c5Xa8i/0rl2jIcG3fjTW0kQggbqs_Nw=3D?=
 =?UTF-8?Q?=3D_?=
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ycngng0ad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 May 2024 07:10:54 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44R7As2l013931;
 Mon, 27 May 2024 07:10:54 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ycngng0a8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 May 2024 07:10:53 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44R5s8JE032078; Mon, 27 May 2024 07:10:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ybutkyc96-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 May 2024 07:10:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44R7AkPU37486990
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 May 2024 07:10:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BCB8520043;
 Mon, 27 May 2024 07:10:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C6D5020040;
 Mon, 27 May 2024 07:10:44 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.179.2.64]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 May 2024 07:10:44 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: [PATCH v3 00/11] Power11 support for QEMU
Date: Mon, 27 May 2024 12:40:31 +0530
Message-ID: <20240527071042.489540-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ycCtJdR3Ldu8Dtnf6genxIoAo1kDgdJV
X-Proofpoint-GUID: xb6DD0_8Su9KcTPMLPZOek0TxePXzsGE
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1011 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2405270057
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 hw/ppc/pnv.c                | 119 ++++++++++++++++++++++++++++++++++--
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
 24 files changed, 361 insertions(+), 11 deletions(-)

-- 
2.45.1


