Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EC2C5B552
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Jun 2025 18:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOKlU-00031d-Sz; Sun, 08 Jun 2025 14:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1uOKlN-00030Y-Jm; Sun, 08 Jun 2025 14:28:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1uOKlK-0001EW-Vs; Sun, 08 Jun 2025 14:28:57 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5581aLFK005022;
 Sun, 8 Jun 2025 18:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=AGbn4pKU3z6fXUYf/J1W9ERKFxV8
 uFEQCEMIhCYxyNI=; b=sHabTLjT82iKZeU6s4whhY2c5mjM9HnIGkBfcUL2U8oy
 UIlw/kHh9GDW5+f8s4OVZoIX8TbTc3lgPRNe0OI4SrXdethECN2B061zWh0Ag6AP
 azm9huUiOTwikgzh5dJGLDqTuCwi/HF5pzav41FKadG59oKsFyhu9k/9INnQILsO
 iKoE0R4xjqru+qovHg1VAXXkOpc6jtgbPU97UhX7kr4uVMQguGoG8Dry2mFhmwsj
 tZHYuNsj9fltqRlpJpJ0L7jAftsbk+w7mAOF2XfXcE/42AGzMHIocxZ6EEsnQ9D3
 3Z0XbVdlJaXRsOmyXMxHMBXtx9cvk8qbBVm/yo1Gng==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4ktkn9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 08 Jun 2025 18:28:50 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 558ISoFv024245;
 Sun, 8 Jun 2025 18:28:50 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4ktkn8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 08 Jun 2025 18:28:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 558Dp15U003329;
 Sun, 8 Jun 2025 18:28:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4751ykafu3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 08 Jun 2025 18:28:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 558ISj6h28639920
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 8 Jun 2025 18:28:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D0B6F20049;
 Sun,  8 Jun 2025 18:28:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02FB920040;
 Sun,  8 Jun 2025 18:28:44 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.39.24.199]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun,  8 Jun 2025 18:28:43 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Subject: [PATCH v8 0/8] Power11 support for QEMU [PowerNV]
Date: Sun,  8 Jun 2025 23:58:34 +0530
Message-ID: <20250608182842.2717225-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Y4X4sgeN c=1 sm=1 tr=0 ts=6845d662 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=aow-egSQAAAA:8
 a=7eAAimpLQsCGizItPeEA:9 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: aWO938zAWyE7AcFhowtr-qc2FRIeUyzF
X-Proofpoint-ORIG-GUID: H6QzLnnQFfsPMPg8I3yBsBJoRZ2EKHUe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA4MDE0NyBTYWx0ZWRfX4PfYpb5Rregu
 eTNwNNt9uMYTjHW7M1hjlBDZLQBuBajvX1XrcsCcvRgO9ufWDbEfDo0KtSqmTyErQcvZzTVL7Vp
 VoDw1uecWBIOvSJXxIW6ByExLUO3u0AFbebzAlkKFoJ9/LP33Au+668Jig3CBKH5jLePkOZLrUo
 mlMzsnP/RHrgCI33Iu/ilcA4aufAo4MBVpuTgkG56XTm7/xyqjxDzMVuVj333Z4HCCHJfJGxl4J
 4lscMSWO1J6AA1img5+/ZbJ42PCfIwL117zNrjvErQB/v/Gl8G1PAGhNe1SzP7CmQKhCchsqJZ4
 RD5g4F48WmvaASwJz2A0hyB08phGlLdGRwLu25MDRMaDc1ajh0ZYHyq3pQ3BeUOtDPA1S0uj1ap
 yKPQw6Hy0eyhuP4v49hJY84KuNmM/QTa/ZFnN9+P2VQYMP2vfA+u4KR2rAmsoKws89w9jlxI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-08_03,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506080147
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Note: No changes from v7, fixed minor merge conflicts on rebase.

Add support for Power11 powernv machine type.

As Power11 core is same as Power10, hence much of the code has been reused
from Power10.

Split Powernv11 chip/machine code into commits introducing: chip,machine,xive,phb
This is to try to keep the code smaller in each commit, but can squash the
xive/phb commits into respective chip/machine commit

Power11 PSeries already added in QEMU in:
  commit 273db89bcaf4 ("ppc/pseries: Add Power11 cpu type")

Note: Also added a patch proposing myself as a reviewer.

Git Tree for Testing
====================

QEMU: https://github.com/adi-g15-ibm/qemu/tree/p11-powernv-v8

Has been tested with following cases:
* '-M powernv' / '-M powernv10' / '-M powernv11'
* '-smp' option tested

skiboot with Power11 support: https://github.com/open-power/skiboot, since
commit 785a5e3

Linux with Power11 support: https://github.com/torvalds/linux, since v6.9-rc1

Changelog
=========
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


Aditya Gupta (8):
  ppc/pnv: Introduce Pnv11Chip
  ppc/pnv: Introduce Power11 PowerNV machine
  ppc/pnv: Add XIVE2 controller to Power11
  ppc/pnv: Add PHB5 PCIe Host bridge to Power11
  ppc/pnv: Add ChipTOD model for Power11
  tests/powernv: Switch to buildroot images instead of op-build
  tests/powernv: Add PowerNV test for Power11
  MAINTAINERS: Add myself as a reviewer of PowerNV emulation

 MAINTAINERS                            |   1 +
 docs/system/ppc/powernv.rst            |   9 +-
 hw/ppc/pnv.c                           | 546 +++++++++++++++++++++++++
 hw/ppc/pnv_chiptod.c                   |  59 +++
 hw/ppc/pnv_core.c                      |  17 +
 include/hw/ppc/pnv.h                   |  38 ++
 include/hw/ppc/pnv_chip.h              |   7 +
 include/hw/ppc/pnv_chiptod.h           |   2 +
 include/hw/ppc/pnv_xscom.h             |  49 +++
 tests/functional/test_ppc64_powernv.py |  34 +-
 10 files changed, 744 insertions(+), 18 deletions(-)

-- 
2.49.0


