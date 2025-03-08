Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A4DC28B28
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 20:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr19T-0002Xn-1U; Sat, 08 Mar 2025 15:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tr19Q-0002XC-SC; Sat, 08 Mar 2025 15:52:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tr19N-0006NX-S4; Sat, 08 Mar 2025 15:52:04 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 528Kppnl011767;
 Sat, 8 Mar 2025 20:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=5uGD1k/agtUlz4NnyLx8pUY2N3ri
 kFm6vWTHEjhn1kc=; b=SvlIAq2wx9/ghGhCFWOs/OHghNdYxQZsO6qlYYwa77GR
 /rji6HYGllkNEp8rUPYJoMmgeFKw0n/E6S7ZK1QozY30l0Cn2PtoBOmmEyHO+dp6
 S5gLWD0EP6QL4i7avz9Mi/ArvrCPfpR22sCWWet6miuI0AM1ZZf5F7al1wK+cQ3G
 mO5Oyyr3a5YXccZ3FapIxSF5bsNgsDe0Ri7vm/+eeGWtIA3wU/qWze8t4LoOUQ7e
 d8LKtZwtfMqJW3AT8yVsAw3kUKGdO2tgoHJ6n+lV7ED6nuFNjIZXTiGMPtTMaihW
 0T2udEDMcuiKhjOBgJ3tTP1kTFmeegYXUSmOCfWiyg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 458wa4g009-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 08 Mar 2025 20:51:50 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 528KpnI7011710;
 Sat, 8 Mar 2025 20:51:50 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 458wa4g007-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 08 Mar 2025 20:51:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 528I6RHU025031;
 Sat, 8 Mar 2025 20:51:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 454f92neh1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 08 Mar 2025 20:51:49 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 528KpjoJ17760752
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 8 Mar 2025 20:51:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F2DB20040;
 Sat,  8 Mar 2025 20:51:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A216B20043;
 Sat,  8 Mar 2025 20:51:42 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.22.32]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  8 Mar 2025 20:51:42 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: [PATCH v5 0/8] Power11 support for QEMU [PowerNV]
Date: Sun,  9 Mar 2025 02:21:33 +0530
Message-ID: <20250308205141.3219333-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -uCHPMqJ5N-RE8IMB0IpOj2HB4E9yGOG
X-Proofpoint-ORIG-GUID: pcaSbKiVwZuCztwoO2Ct5FtR5n1HJvnN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503080159
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Add support for Power11 powernv machine type, to emulate PowerNV VMs
running on Power11.

As Power11 core is same as Power10, hence much of the code has been reused
from Power10. And Power10 PNV Chip has been declared as parent of Power11
PNV Chip so that any existing/new functionality can also be reused for
Power11.

This parent/child hierarchy causes an issue in .instance_init, as parent's
instance_init is also called for the child object. Skip initialising child
objects in P10's instance init if we have a P11 chip, this prevents
initialising same objects twice by p10 and p11 instance inits.

Power11 PSeries already added in QEMU in:
  commit 273db89bcaf4 ("ppc/pseries: Add Power11 cpu type")

Git Tree for Testing
====================

QEMU: https://github.com/adi-g15-ibm/qemu/tree/p11-powernv-v5

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
v5:
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
  ppc/pnv: Add HOMER for POWER11
  ppc/pnv: Add a LPC controller for POWER11
  ppc/pnv: Add OCC for Power11
  ppc/pnv: Add a PSI bridge model for Power11
  ppc/pnv: Add SBE model for Power11
  ppc/pnv: Add ChipTOD model for Power11
  ppc/pnv: Add a Power11 Pnv11Chip, and a Power11 Machine
  ppc/pnv: Update skiboot to support Power11

 docs/system/ppc/powernv.rst            |   9 +-
 hw/ppc/pnv.c                           | 177 ++++++++++++++++++++++++-
 hw/ppc/pnv_chiptod.c                   |  37 ++++++
 hw/ppc/pnv_core.c                      |  11 ++
 hw/ppc/pnv_homer.c                     |   8 ++
 hw/ppc/pnv_lpc.c                       |  14 ++
 hw/ppc/pnv_occ.c                       |  14 ++
 hw/ppc/pnv_psi.c                       |  24 ++++
 hw/ppc/pnv_sbe.c                       |  15 +++
 include/hw/ppc/pnv.h                   |   5 +
 include/hw/ppc/pnv_chip.h              |   7 +
 include/hw/ppc/pnv_chiptod.h           |   2 +
 include/hw/ppc/pnv_core.h              |   1 +
 include/hw/ppc/pnv_homer.h             |   3 +
 include/hw/ppc/pnv_lpc.h               |   4 +
 include/hw/ppc/pnv_occ.h               |   2 +
 include/hw/ppc/pnv_psi.h               |   2 +-
 include/hw/ppc/pnv_sbe.h               |   2 +
 pc-bios/skiboot.lid                    | Bin 2527328 -> 2527424 bytes
 19 files changed, 321 insertions(+), 10 deletions(-)

-- 
2.48.1


