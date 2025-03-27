Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AAFC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 20:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txtWB-0003Zq-E9; Thu, 27 Mar 2025 16:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1txtW6-0003ZV-4D; Thu, 27 Mar 2025 16:07:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1txtW3-0000bu-EX; Thu, 27 Mar 2025 16:07:53 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RE37Vf008008;
 Thu, 27 Mar 2025 20:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=KBCt0NpS+ZIoKkiDy0tBfDOKZsUi
 n+JyqQTTgGx3WCs=; b=avE7eJ1tPFfbB50zqs9DR9W3KGd3OySpxbzLrIIqwVlW
 oJaefPEkIJu4rab/5kGWeoo172NQjejtYCKVN+FmLA4Sj1VBWIJJCXqpK9wedhvE
 36Nq9DzpFRogiXwEEP83Tske2u3/mS5hbcYG5gxDX39nBFIKLXRRfz2j48G2tVRd
 1v9sO1mjJy6+o/vNcHk/TjURS3o2EEC2n2nvymqA/81Dun6x595IWKP1RCpDYkZJ
 rj6gzYiEzHuDpS87iw6C1mvMpz6Lzu4jgiidXVVbkbqtnex7TJ+YvHcAS5hMbHdz
 ghO/1Pmtmp74G3T2XXLACwcWRv5c4Ba+iyzDdzZDkg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45n83pa2t2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Mar 2025 20:07:46 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52RK7kuI016053;
 Thu, 27 Mar 2025 20:07:46 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45n83pa2t1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Mar 2025 20:07:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52RH0Wsj005796;
 Thu, 27 Mar 2025 20:07:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ja82psf2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Mar 2025 20:07:45 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52RK7fJO56885716
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Mar 2025 20:07:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5FCED20043;
 Thu, 27 Mar 2025 20:07:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53AE020040;
 Thu, 27 Mar 2025 20:07:39 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.214.220])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Mar 2025 20:07:39 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: [PATCH v7 0/7] Power11 support for QEMU [PowerNV]
Date: Fri, 28 Mar 2025 01:37:31 +0530
Message-ID: <20250327200738.1524401-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: f7sqKknOuXZ63H3cs1RwnVn9cCHb8eAm
X-Proofpoint-ORIG-GUID: phGja_sIMDv5yMQcpKY96NkToi9LmcZI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_03,2025-03-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503270135
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Split Powernv11 chip/machine code into commits introducing: chip,machine,xive,phb
This is to try to keep the code smaller in each commit, but can squash the
xive/phb commits into respective chip/machine commit

Power11 PSeries already added in QEMU in:
  commit 273db89bcaf4 ("ppc/pseries: Add Power11 cpu type")

Git Tree for Testing
====================

QEMU: https://github.com/adi-g15-ibm/qemu/tree/p11-powernv-v7

Has been tested with following cases:
* '-M powernv' / '-M powernv10' / '-M powernv11'
* '-smp' option tested

skiboot with Power11 support: https://github.com/open-power/skiboot, since
commit 785a5e3

Linux with Power11 support: https://github.com/torvalds/linux, since v6.9-rc1

Changelog
=========
v7:
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

Aditya Gupta (7):
  ppc/pnv: Introduce Pnv11Chip
  ppc/pnv: Introduce Power11 PowerNV machine
  ppc/pnv: Add XIVE2 controller to Power11
  ppc/pnv: Add PHB5 PCIe Host bridge to Power11
  ppc/pnv: Add ChipTOD model for Power11
  tests/powernv: Switch to buildroot images instead of op-build
  tests/powernv: Add PowerNV test for Power11

 docs/system/ppc/powernv.rst            |   9 +-
 hw/ppc/pnv.c                           | 546 +++++++++++++++++++++++++
 hw/ppc/pnv_chiptod.c                   |  59 +++
 hw/ppc/pnv_core.c                      |  17 +
 include/hw/ppc/pnv.h                   |  38 ++
 include/hw/ppc/pnv_chip.h              |   7 +
 include/hw/ppc/pnv_chiptod.h           |   2 +
 include/hw/ppc/pnv_xscom.h             |  49 +++
 tests/functional/test_ppc64_powernv.py |  34 +-
 9 files changed, 743 insertions(+), 18 deletions(-)

-- 
2.49.0


