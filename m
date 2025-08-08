Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19473C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 12:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukLlE-0002UD-Jv; Fri, 08 Aug 2025 07:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ukLlA-00025H-Po; Fri, 08 Aug 2025 07:59:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ukLl8-0006fT-1z; Fri, 08 Aug 2025 07:59:44 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5787gxLU002582;
 Fri, 8 Aug 2025 11:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=9hSuo0f6Xr1SVWZmKbNMCKsF8RWk
 3oSieJRNwTXgxM8=; b=K23SfqqK5rCqJqX1xKxs/smGas0h6lTHjF11G4OVPgP5
 LXAgjRvyANOP+4dF/maF/WJoF/NIWO6g3oet6P5lqkH1t5andsbHoPMwMYmW5xj2
 LpiDS48IwkrL4yW3IhVZ2Q5Erx6I3YmNNI7je5Wl79FyQh3bE9IrFgpYQbhZMsVW
 BQzmvBrAtqjjfOLLHDOhZx4pKagUVakpd4rmUoF4YbBlSc24MlqvFQgHgyGJZNYH
 4XQRbuEQ5dVBwtj9Ua8S/vWWTYO9rx0X319E+kAXFABwTMjtLRw/xEMNs7lO2t6E
 Xfqr7ROgtOyWw4cl52oRzdfdSdQ1Blaq1mj8JqM2eg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63fubw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 11:59:39 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 578BxE70023267;
 Fri, 8 Aug 2025 11:59:39 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63fubu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 11:59:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 578AUJMx022647;
 Fri, 8 Aug 2025 11:59:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwqngue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 11:59:38 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 578BxYsr27656522
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Aug 2025 11:59:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C1A820043;
 Fri,  8 Aug 2025 11:59:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC14C20040;
 Fri,  8 Aug 2025 11:59:31 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.124.216.151])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Aug 2025 11:59:31 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Subject: [PATCH v9 0/7] Power11 support for QEMU [PowerNV]
Date: Fri,  8 Aug 2025 17:29:22 +0530
Message-ID: <20250808115929.1073910-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NInV+16g c=1 sm=1 tr=0 ts=6895e6ab cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=aow-egSQAAAA:8 a=7eAAimpLQsCGizItPeEA:9 a=QEXdDO2ut3YA:10
 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: 1A7tG83eHi6F6J-xprPcXat_pv2TfIMa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA5NiBTYWx0ZWRfXyhl/3far5BOu
 72VmSXZfES3WdXShWRa8uCbccKq7hQz8JD30fd71vQS0R+FoI7pVwflU5pZCGtNle756vTSlTxo
 ipM9tsb2XruBlvj90/VisPIUN8QTIcX00+tm8kS7OaddJP42rgUHH9m5UAgY+C9ESAqmmkXAINN
 5rZHD9aRfTopo7COkJOCRcV/4M6tfexYFYxRx+IXAX6BGLe2dKgTpiEzkyJIIwVulOJic8m1mNG
 A9V8GAzi2WBH9XouV+kWQrg/KZxwalgDzdUvw5+Xxd8oJlcxz4Lf5N54FhfyqVg5YlpX8jdjgcx
 QrqmAC7ofjPSBqDJ70r4LyZRHHSo7I0YrNaGnVKW0pNuh3MwKtt0ZeWVdDiDGaCyXFHixareOTd
 XBQQf/Wz5mrTE3Rw5cqm7u+4UlL1UY+3fQsXFScCJIX9Uke0biGfoKjViTYq5G1BUd6KHhWi
X-Proofpoint-ORIG-GUID: Rboel17HhDEZhystZBuIhvA8QqK2tGvy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508080096
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

QEMU: https://github.com/adi-g15-ibm/qemu/tree/p11-powernv-v9

Has been tested with following cases:
* '-M powernv' / '-M powernv10' / '-M powernv11'
* '-smp' option tested

skiboot with Power11 support: https://github.com/open-power/skiboot, since
commit 785a5e3

Linux with Power11 support: https://github.com/torvalds/linux, since v6.9-rc1

Changelog
=========
v9:
  + [PATCH 1/7]: apply hunks from commit cf0eb929e59cb, and commit
    24c8fa968a6d8, for changes that were done for Power10, as those changes
    make sense for Power11 also
  + [PATCH 3/7]: fixed build breakage identified with QEMU CI, due to changes
    in upstream function pointer types

v8:
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


Aditya Gupta (7):
  ppc/pnv: Introduce Pnv11Chip
  ppc/pnv: Introduce Power11 PowerNV machine
  ppc/pnv: Add XIVE2 controller to Power11
  ppc/pnv: Add PHB5 PCIe Host bridge to Power11
  ppc/pnv: Add ChipTOD model for Power11
  tests/powernv: Switch to buildroot images instead of op-build
  tests/powernv: Add PowerNV test for Power11

 docs/system/ppc/powernv.rst            |   9 +-
 hw/ppc/pnv.c                           | 540 +++++++++++++++++++++++++
 hw/ppc/pnv_chiptod.c                   |  59 +++
 hw/ppc/pnv_core.c                      |  17 +
 include/hw/ppc/pnv.h                   |  38 ++
 include/hw/ppc/pnv_chip.h              |   7 +
 include/hw/ppc/pnv_chiptod.h           |   2 +
 include/hw/ppc/pnv_xscom.h             |  49 +++
 tests/functional/test_ppc64_powernv.py |  34 +-
 9 files changed, 737 insertions(+), 18 deletions(-)

-- 
2.50.1


