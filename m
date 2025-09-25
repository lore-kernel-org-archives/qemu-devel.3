Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C130CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 17:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1poQ-0001kU-7b; Thu, 25 Sep 2025 13:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v1poK-0001jk-WB; Thu, 25 Sep 2025 13:31:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v1poA-00069i-UK; Thu, 25 Sep 2025 13:31:16 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PAQwFj007389;
 Thu, 25 Sep 2025 17:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=VsVL4pObjC/Xnc91HoR/e0tV8WsA
 98RiueCGsMA5pSk=; b=Yg68EQZpg2aNmZ5GLgVjf690YhecQZsz7j8QPFay8kdq
 ULj3auJZ1sfvitoeER3vdk+fDr3uwCKzFDI++9g1g6wA+VfMnutqbtd0VNVB2h/T
 TkUpJIahdetcYp0VxoHroH66TDR/pvQvGEtv/WC2pfh7uKfGnyEC39kYSTLd1Z3E
 X3vtALemxNR2wwpHLNBnL5nqTAmAf+o1lHO+gwl/ZRn0JyKFXS1R+E7GeHuSzq6t
 Y2LQyI8opq1tcNeSSvJpwPxq8Tymieu3ADUAKkc4NX/ofc0+0vGO2sAd3SF6696T
 7nhxDqdZdtMx2GTOSuEaq42P+Q71DZGHivxuHXd5vQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499n0jy6ur-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:30:59 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58PHS7av021722;
 Thu, 25 Sep 2025 17:30:58 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499n0jy6uj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:30:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PHSrxO030336;
 Thu, 25 Sep 2025 17:30:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a1exxs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:30:57 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58PHUsxO44695946
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 17:30:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 181B320040;
 Thu, 25 Sep 2025 17:30:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 344192004B;
 Thu, 25 Sep 2025 17:30:51 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.124.220.124])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Sep 2025 17:30:51 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 Mike Kowal <kowal@linux.ibm.com>, Miles Glenn <milesg@linux.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Subject: [PATCH v10 0/8] Power11 support for QEMU [PowerNV]
Date: Thu, 25 Sep 2025 23:00:41 +0530
Message-ID: <20250925173049.891406-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX81st1+RPaXXh
 AXlnkjvaOKXTYTmyczEZmT+E8u1gn93ZIa01biEH+Qoc8I3zyWbbBPURG5vHC+ULmgd042cJcLe
 mA+YrMpIhNXdtOB+QU2fOLKA9JzMTotHsWsof5gfl3j7xZnxv44vSs1SVIaLZfv6gc3FUKRD5l2
 tYJMjYNie7bB4ZyYQOTHWFrJjSz/Pr5+DVcYF8awOsxeSZt8vSEXbEjQJ42kaPXbz7RB4JuxTTP
 BsjSZ9q+CBTH+jcCQx8Wgd8idOYjXq9hjhJvIbiYZapmEx6CndhoVQ5nljixlS/icvC4daoKbnX
 fRwQByv5i0f17ffufZwWqoU2/Ntbcrc+wd8sIv7VsmlUfH6eSi9g5WvXeUzQuPDxjsknoWFpST3
 5WiEQSGk
X-Authority-Analysis: v=2.4 cv=TOlFS0la c=1 sm=1 tr=0 ts=68d57c53 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=aow-egSQAAAA:8 a=D-MH1O1gfgBD2lvPr1gA:9
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-ORIG-GUID: Sz8zJxOMAcp4YkqMyvpCHoeatOsn4kFv
X-Proofpoint-GUID: pi9NLMNsDDc3MtPxej7Pa2yaCwN1aOwt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Power11 PSeries already added in QEMU in:
  commit 273db89bcaf4 ("ppc/pseries: Add Power11 cpu type")

Git Tree for Testing
====================

QEMU: https://github.com/adi-g15-ibm/qemu/tree/p11-powernv-v10

The patches apply cleanly on below commit:
  95b9e0d2ade5 ("Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging")

Tests ran:
* `make check`
* '-M powernv' / '-M powernv10' / '-M powernv11'
* '-smp' option tested
* 'e1000e' device
* tested changing irq affinities to remote chips for xive functionality
* compile test with --without-default-devices

skiboot with Power11 support: https://github.com/open-power/skiboot, since
commit 785a5e3

Linux with Power11 support: https://github.com/torvalds/linux, since v6.9-rc1

Changelog
=========
v10:
  + [PATCH 1/8]: Do same change for Power11 as done for Power10 in commit 46d03b,
    as changes required for successful build with --without-default-devices
  + [PATCH 3/8]: Added new patch to remove assuming chip as Power10 in xive2
  + rebase to upstream

v9 (https://lore.kernel.org/qemu-devel/20250808115929.1073910-1-adityag@linux.ibm.com/):
  + [PATCH 1/7]: apply hunks from commit cf0eb929e59cb, and commit
    24c8fa968a6d8, for changes that were done for Power10, as those changes
    make sense for Power11 also
  + [PATCH 3/7]: fixed build breakage identified with QEMU CI, due to changes
    in upstream function pointer types

v8 (https://lore.kernel.org/qemu-devel/20250608182842.2717225-1-adityag@linux.ibm.com/):
  + rebase to upstream
  + propose myself as a powernv reviewer

v7 (https://lore.kernel.org/qemu-devel/20250327200738.1524401-1-adityag@linux.ibm.com/):
  + use Power10 models of homer, sbe, occ, psi, lpc. As they are same.
  + switch powernv tests to use buildroot images instead of op-build images
  + add functional test for powernv11
  - remove dynamic sysbus device for PHBs, so no more dynamic number of
  PHBs in Power11 as it became complex to handle it and not much used

v6 (https://lore.kernel.org/qemu-devel/20250325112319.927190-1-adityag@linux.ibm.com/):
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


Aditya Gupta (8):
  ppc/pnv: Introduce Pnv11Chip
  ppc/pnv: Introduce Power11 PowerNV machine
  ppc/pnv: Add PnvChipClass handler to get reference to interrupt
    controller
  ppc/pnv: Add XIVE2 controller to Power11
  ppc/pnv: Add PHB5 PCIe Host bridge to Power11
  ppc/pnv: Add ChipTOD model for Power11
  tests/powernv: Switch to buildroot images instead of op-build
  tests/powernv: Add PowerNV test for Power11

 docs/system/ppc/powernv.rst            |   9 +-
 hw/intc/pnv_xive2.c                    |   4 +-
 hw/ppc/pnv.c                           | 560 +++++++++++++++++++++++++
 hw/ppc/pnv_chiptod.c                   |  59 +++
 hw/ppc/pnv_core.c                      |  17 +
 include/hw/ppc/pnv.h                   |  38 ++
 include/hw/ppc/pnv_chip.h              |   8 +
 include/hw/ppc/pnv_chiptod.h           |   2 +
 include/hw/ppc/pnv_xscom.h             |  49 +++
 tests/functional/ppc64/test_powernv.py |  34 +-
 10 files changed, 760 insertions(+), 20 deletions(-)

-- 
2.50.1


