Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15017C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 22:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKP6B-0003Dp-Ev; Wed, 28 May 2025 18:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uKP5y-0003AL-Em
 for qemu-devel@nongnu.org; Wed, 28 May 2025 18:17:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uKP5n-0000x6-Al
 for qemu-devel@nongnu.org; Wed, 28 May 2025 18:17:57 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SINGNg016566;
 Wed, 28 May 2025 22:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=Egc+IEAK8xK9d1mFEWcQ3F87RLNH8
 TDRBsX2no6+Mz8=; b=ZbeU9PpKqijE1W/qpd5P1rqkBSaY5nJYi5NONh9HbBbOF
 gyr4NfAUnH8nkGYII5CT2souu/AOkg8ApBoQNQ0aQ/KVEowgC6rnDaVx9K30Amap
 lFq9zBy3uyK81tT1xXVD2Ow4JNw6uPiFdD6Sipsyi9Y4AmzVsaqjO4en2rDeU1Dz
 xMxR7U2KVNdwC4Ts5pygjiX0PweYOzPw0gb32+2oY2Jxw0CIDdB3x6CpVLbSRZ1Z
 zjHE1G7M/bH8DCMhNKILHHL3Ax2IhGu5DAv+m4omFni6cFuYsEU8yj4YMQaBNRid
 rD2Pz79N3YBXS+Tw45aWFbG7QnYKvO3g6N34sVOIA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v33my2jf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 22:17:28 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54SKQgOV024586; Wed, 28 May 2025 22:17:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jb86ua-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 22:17:26 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54SMHQsP018695;
 Wed, 28 May 2025 22:17:26 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 46u4jb86u3-1; Wed, 28 May 2025 22:17:25 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, richard.henderson@linaro.org,
 eduardo@habkost.net, vasant.hegde@amd.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH v2 0/7] amd_iommu: Fixes to align with AMDVi specification
Date: Wed, 28 May 2025 22:17:17 +0000
Message-ID: <20250528221725.3554040-1-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_11,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280194
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE5NCBTYWx0ZWRfXyaIbU8Ic5/gI
 Ha0DaJTdLPLsbOzKcbfxhtws7Qt9MwX9RdT/Kofl7W9gOqfIMGva8RaYYgng8GR30F3p8beWBpJ
 qa/Lo5fCS/2z5mr5DSlinZhmBTDRNPxuIdbRAUycYw43SIgYoQDtYEoliegyczhYKmTPrWD2hE9
 we+04N90OutWmuma901Jbn+ZVmhVXyc/sAyxBsBL6X5A6QidBciUmHE0xtswZa/9KZxYvaJgYmr
 Z+OPZxt423dF2uVsDL8Jkhys/HipBv75wwyrJrjx0sXjF0i+8amkC/I3cCXdfcA1IUvha6hV7bU
 qb/FZPwV7o53M6+ZkyIygbsj9L/nUmNso9WTaVZA4ltKKtpacua+lKV2LVjrF23/WNWg2r2E+p5
 7AAsWVlMrMH5TmOl29DB5V1VChxFRuDEQgMK/z/7yvnmGyEkxOrFWXufHPcEpcYX0keuEkeV
X-Proofpoint-GUID: Y3G7OdfaYnmWgVKYXB-nrClzbUAbpU5t
X-Authority-Analysis: v=2.4 cv=aO/wqa9m c=1 sm=1 tr=0 ts=68378b78 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=WbZ-VVUJ9A6HQNJnBWEA:9
 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: Y3G7OdfaYnmWgVKYXB-nrClzbUAbpU5t
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) DKIMWL_WL_MED=-0.498, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Correct mistakes in bitmasks, offsets, decoding of fields, and behavior that
do not match the latest AMD I/O Virtualization Technology (IOMMU)
Specification. These bugs do not trigger problems today in the limited mode
of operation supported by the AMD vIOMMU (passthrough), but upcoming
functionality and tests will require them (and additional fixes).

These are all minor and hopefully not controversial fixes, so I am sending
them separately rather than including them on the DMA remap support
series[0].

It is unclear how relevant these changes will be to stable releases
considering the state of the AMD vIOMMU, but the fixes on this series should
be simple enough to apply, so I Cc'd stable for consideration.

Changes since v1[1]:
- Added R-b's from Vasant on PATCH 1-3, 5.
- P3: Match the spec, although vIOMMU case does not use DTE[3] (Vasant)
- P4: Fix more definitions using GENMASK64 for consistency. (Sairaj, Vasant)
- Dropped PATCH 6 from v1 and included it in DMA remap series[0] (Vasant: I
didn't want to assume approval so I dropped your R-b for this patch when
moving it to the other series).
- Fix issue with mask that retrieves the IRT pointer from DTE.
- Remove duplicated code. Although trivial, I didn't want to sneak this into
other unrelated commits.

Tested booting guest with AMD vIOMMU and guest kernel in passthrough mode.

Thank you,
Alejandro

[0] https://lore.kernel.org/qemu-devel/20250502021605.1795985-20-alejandro.j.jimenez@oracle.com/
[1] https://lore.kernel.org/all/20250311152446.45086-1-alejandro.j.jimenez@oracle.com/

Alejandro Jimenez (7):
  amd_iommu: Fix Miscellanous Information Register 0 offsets
  amd_iommu: Fix Device ID decoding for INVALIDATE_IOTLB_PAGES command
  amd_iommu: Update bitmasks representing DTE reserved fields
  amd_iommu: Fix masks for various IOMMU MMIO Registers
  amd_iommu: Fix mask to retrieve Interrupt Table Root Pointer from DTE
  amd_iommu: Fix the calculation for Device Table size
  amd_iommu: Remove duplicated definitions

 hw/i386/amd_iommu.c | 15 ++++++------
 hw/i386/amd_iommu.h | 59 ++++++++++++++++++++++-----------------------
 2 files changed, 37 insertions(+), 37 deletions(-)


base-commit: 80db93b2b88f9b3ed8927ae7ac74ca30e643a83e
-- 
2.43.5


