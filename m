Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A37C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 19:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYsRu-0002MO-4q; Tue, 30 Jul 2024 15:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sYsRq-0002K6-Rz; Tue, 30 Jul 2024 15:23:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1sYsRn-0002FH-1I; Tue, 30 Jul 2024 15:23:49 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46UHnkS5028503;
 Tue, 30 Jul 2024 19:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:content-type
 :content-transfer-encoding:mime-version; s=pp1; bh=YnurlzIFcO7b4
 UsWOrgNQZ1rfjQQTPlXcfGrhS1whpc=; b=JghO36KKiJB4RAXuKOfoaho/IX4W1
 GW+01GW+dV+5GK4yil3e8evXySb5FI62mHADGQ0bVQbb2F4cg3ftX8QYjSndiBr9
 gj7EmxTItPVdhegyduHl+4XMbtaKxM17ThB/2mP/GcMG26VQtHbgM3WLyUGgt0mC
 2+3Rg6gCZqJTEkMrc/yWWuuQmQ7omkkT4CJvwKhWJDL6oMeDxdUBIW2WcefkX968
 Uqz7568T3/YcyZ2onmVafVTVPqILsNmCSzEedpHfeolYs3fDFrlAhTuunSf7EAwh
 aDU+Kb9Nmp55mNzvikrqDxTxtntKmP0sropemWnzgpw4qQ0vYbKHY1d+Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40q13a8vta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2024 19:23:36 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46UJNa6H028201;
 Tue, 30 Jul 2024 19:23:36 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40q13a8vt8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2024 19:23:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46UIF1L2009211; Tue, 30 Jul 2024 19:23:35 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndx2xby3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2024 19:23:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46UJNTqE46268844
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jul 2024 19:23:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7DD2520043;
 Tue, 30 Jul 2024 19:23:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 717C920040;
 Tue, 30 Jul 2024 19:23:27 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.195.42.9]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jul 2024 19:23:27 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: [PATCH v6 0/5] Power11 support for QEMU [PSeries]
Date: Wed, 31 Jul 2024 00:53:20 +0530
Message-ID: <20240730192325.669771-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zgU6KvpnQhOyWk16CnjmdpybQzlz56cG
X-Proofpoint-GUID: XriJUK-Q7-3wL7IgPFe0M9gwjWEgVfhV
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_15,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300134
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


