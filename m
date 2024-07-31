Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80093C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 05:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ2EW-0002R0-7U; Wed, 31 Jul 2024 01:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sZ2ER-0002Ix-Bp; Wed, 31 Jul 2024 01:50:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sZ2EP-0007MB-09; Wed, 31 Jul 2024 01:50:39 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46V4x7hv026992;
 Wed, 31 Jul 2024 05:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:content-type
 :content-transfer-encoding:mime-version; s=pp1; bh=6PUwUUuAaqT/1
 anauwpLbxDLyFSKsLmlyllK/6ZNB4Y=; b=XpV7UvaLhjOzyhjxvPhNOc2ZY2Jjs
 1QRvmxvKrgSoQGqt3Ftnlbcj9km+0eh8Lirt1t3nZBJI/dTrq7GsdzI8fqE7NP7M
 4qhwlloySHoFBbRw8if2mrFyt1ETgx/GxLoEpt3ZQvnXUkXxokoFLazO2nF5lEns
 wyGXWz92t7iRfkB5UvMH51mdlIzEEoSrZUrA7aljUkjKLY2cInujH6dKMJ+7+2bR
 NYg7A8z+35RfWRD9mf3v9bIqkGmAF/cV7WJlZgJJ5AWblYXE6+jYaUJZYvUmnSmv
 M6JFqpI4XWwGYRXaHEXMMUEgmpZj5pCS0qnrtdZXkdHe63+2MLKRh2Scw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qeqbg2ux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 05:50:32 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46V5oVBF015704;
 Wed, 31 Jul 2024 05:50:31 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qeqbg2uv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 05:50:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46V4lNnw007467; Wed, 31 Jul 2024 05:50:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40nb7u9u57-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 05:50:30 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46V5oPeH54264202
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jul 2024 05:50:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D3A42004D;
 Wed, 31 Jul 2024 05:50:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F3F152004E;
 Wed, 31 Jul 2024 05:50:22 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.72]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 31 Jul 2024 05:50:22 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: [PATCH v6 RESEND 0/5] Power11 support for QEMU [PSeries]
Date: Wed, 31 Jul 2024 11:20:17 +0530
Message-ID: <20240731055022.696051-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MV2HEtyJWljBSXnu38FQn6s5fJACoNam
X-Proofpoint-GUID: bSxxobMsGAySG-feTKNrcThYfTZE0fjI
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_02,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310039
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Split "Power11 support for QEMU" into 2 patch series: pseries & powernv.

This patch series is for pseries support for Power11.

As Power11 core is same as Power10, hence much of the code has been reused from
Power10.

Power11 was added in Linux in:
  commit c2ed087ed35c ("powerpc: Add Power11 architected and raw mode")

Git Tree for Testing
====================

QEMU: https://github.com/adi-g15-ibm/qemu/tree/p11-v6-pseries

Has been tested with following cases:
* '-M pseries' / '-M pseries -cpu Power11'
* '-smp' option tested
* with compat mode: 'max-cpu-compat=power10' and 'max-cpu-compat=power9'
* with/without device 'virtio-scsi-pci'
* with/without -kernel and -drive with qcow_file

Linux with Power11 support: https://github.com/torvalds/linux, since v6.9-rc1

Changelog
=========
v6 RESEND:
  + added my initials instead of PMM in patch #1 description

v6: 
  + reorganised patches such that Power11 introduction is at end, and
  cleanups and fixes is done before
  + patch #1: renamed macros from POWER_* to PCC_*
  + patch #2: rename 'logical_pvr' to 'spapr_logical_pvr' to better convey
  the context

v5:
  + split patch series into pseries+powernv
  + patch #1: apply harsh's patch to reduce duplication
  + patch #2: simplified, by removing duplication
  + patch #3: update docs, according to harsh's suggestion
  + patch #4: no functional change, #define used for P9 & P10 pcr_supported
  + patch #5: no change

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


Aditya Gupta (4):
  target/ppc: Introduce 'PowerPCCPUClass::spapr_logical_pvr'
  target/ppc: Fix regression due to Power10 and Power11 having same PCR
  target/ppc: Add Power11 DD2.0 processor
  ppc/pseries: Add Power11 cpu type

Harsh Prateek Bora (1):
  target/ppc: Reduce code duplication across Power9/10 init code

 docs/system/ppc/pseries.rst |  17 +++-
 hw/ppc/spapr_cpu_core.c     |   1 +
 target/ppc/compat.c         |  11 +++
 target/ppc/cpu-models.c     |   3 +
 target/ppc/cpu-models.h     |   3 +
 target/ppc/cpu.h            |   3 +
 target/ppc/cpu_init.c       | 188 +++++++++++++++---------------------
 target/ppc/cpu_init.h       |  92 ++++++++++++++++++
 8 files changed, 205 insertions(+), 113 deletions(-)
 create mode 100644 target/ppc/cpu_init.h

-- 
2.45.2


