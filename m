Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3B2C36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 11:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx2Nn-0005Kg-ME; Tue, 25 Mar 2025 07:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tx2Nk-0005K9-2E; Tue, 25 Mar 2025 07:23:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tx2Ng-00047E-U0; Tue, 25 Mar 2025 07:23:42 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ONBB1v032720;
 Tue, 25 Mar 2025 11:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=Hw6nulnmfXh5Vjun/4XKwjfYVy0F
 r0WlXwnfFZZVEb8=; b=DImnToOBc9Kv2KGBb8X668xFyStZdw9YqeOHNXrD9cyx
 kaA2IzJCOyRVCbw50UySU70p3711xIHs3aF2+HeURFY0Miv1fziEPjXXW7CbxySf
 StocC1xdoWBnvAHEGdABs7bX2V7uEWNfezwi4m9TULOD1NiPbE7PDsy6vwN7ggNC
 3vFc7Pzp/WJktdSSpto9w8tMyvP0Ajsl2g6DNah0VUK9xUtJ8bOM7R9synTM5wto
 Su39UdZz89T8SNdzaqJBbxG9ap0OVrAKwUOQJBMgjN6oyqId/rh+NdesW2HrTXRj
 sUBZWZjdL73qZg1/o5QPDjvT3uiZH3wwOH3R18/Cnw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45k8tpdfgc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 11:23:28 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52PBMRVH031281;
 Tue, 25 Mar 2025 11:23:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45k8tpdfg9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 11:23:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52P80AqV025463;
 Tue, 25 Mar 2025 11:23:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j7x038k7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 11:23:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52PBNNkE32572140
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Mar 2025 11:23:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F240E2004B;
 Tue, 25 Mar 2025 11:23:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D163F20043;
 Tue, 25 Mar 2025 11:23:20 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.216.239])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 25 Mar 2025 11:23:20 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: [PATCH v6 00/10] Power11 support for QEMU [PowerNV]
Date: Tue, 25 Mar 2025 16:53:09 +0530
Message-ID: <20250325112319.927190-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dYZgCrbfnu5SBkeuFWm4rvdszEj6JoRO
X-Proofpoint-ORIG-GUID: EZrKgYFzVbWCQF59tjkfabBRpHYIHJud
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_04,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503250076
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
============

Add support for Power11 powernv machine type.

As Power11 core is same as Power10, hence much of the code has been reused
from Power10.

Split Powernv11 chip/machine code into commits introducing: chip,machine,xive,phb
This is to try to keep the code smaller in each commit, but can squash the
xive/phb commits into respective chip/machine commit

Power11 PSeries already added in QEMU in:
  commit 273db89bcaf4 ("ppc/pseries: Add Power11 cpu type")

Git Tree for Testing
====================

QEMU: https://github.com/adi-g15-ibm/qemu/tree/p11-powernv-v6

Has been tested with following cases:
* '-M powernv' / '-M powernv10' / '-M powernv11'
* '-smp' option tested

skiboot with Power11 support: https://github.com/open-power/skiboot, since
commit 785a5e3

Linux with Power11 support: https://github.com/torvalds/linux, since v6.9-rc1

Note: Functional test not added now, will add as soon as op-build releases
new kernel image with Power11 support

Changelog
=========
v6:
  + make Pnv11Chip's parent as PnvChip, instead of Pnv10Chip
  + rebase on upstream/master

v5 (https://lore.kernel.org/qemu-devel/57ce8d50-db92-44f0-96a9-e1297eea949f@kaod.org/):
  + add chiptod
  + add instance_init for P11 to use P11 models
  + move patch introducing Pnv11Chip to the last
  + update skiboot.lid to skiboot's upstream/master

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

Aditya Gupta (10):
  ppc/pnv: Add HOMER for Power11
  ppc/pnv: Add a LPC controller for Power11
  ppc/pnv: Add OCC for Power11
  ppc/pnv: Add a PSI bridge model for Power11
  ppc/pnv: Add SBE model for Power11
  ppc/pnv: Introduce Pnv11Chip
  ppc/pnv: Introduce Power11 PowerNV machine
  ppc/pnv: Add XIVE2 controller to Power11
  ppc/pnv: Add PHB5 PCIe Host bridge to Power11
  ppc/pnv: Add ChipTOD model for Power11

 docs/system/ppc/powernv.rst  |   9 +-
 hw/ppc/pnv.c                 | 542 +++++++++++++++++++++++++++++++++++
 hw/ppc/pnv_chiptod.c         |  59 ++++
 hw/ppc/pnv_core.c            |  17 ++
 hw/ppc/pnv_homer.c           |   8 +
 hw/ppc/pnv_lpc.c             |  14 +
 hw/ppc/pnv_occ.c             |  14 +
 hw/ppc/pnv_psi.c             |  24 ++
 hw/ppc/pnv_sbe.c             |  15 +
 include/hw/ppc/pnv.h         |  38 +++
 include/hw/ppc/pnv_chip.h    |   7 +
 include/hw/ppc/pnv_chiptod.h |   2 +
 include/hw/ppc/pnv_homer.h   |   3 +
 include/hw/ppc/pnv_lpc.h     |   4 +
 include/hw/ppc/pnv_occ.h     |   2 +
 include/hw/ppc/pnv_psi.h     |   2 +-
 include/hw/ppc/pnv_sbe.h     |   2 +
 include/hw/ppc/pnv_xscom.h   |  49 ++++
 18 files changed, 806 insertions(+), 5 deletions(-)

-- 
2.49.0


