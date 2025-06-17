Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757BFC71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYJ1-0002UJ-IV; Tue, 17 Jun 2025 11:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uRYI8-0000vN-PO
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:32:04 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uRXrZ-0006sI-R8
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:04:41 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HEWvn5026848;
 Tue, 17 Jun 2025 15:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=ZqOhT920eqw9YCQhmQxgCpf2P1FgN
 n31awBbj1+yBzk=; b=Ru5E3HU7GhewkOlclaf7Atjd4xh+Y0+oubdBizGcIJEi8
 xzvgkB0/QVqXCKKDuhMyf+9XwhMAB4O9SlMLXWHhiBbQGSaCU8wIGjpAVW5gqTd1
 5vtRodgvVQLqF+JLLYUoy33JQGE7Boer8utQ9J25ju7cJ3dqjtKp2/qolMBGuJ/d
 BJfIslw+OmyxPJvW6u2sR0D/x72u2bAxzMYkZ3cn5f+MFFBHSIQD3UZ8MJ9jES78
 CB2zWvbGWhXjQBw651asHsEll4FWVUxP5L6ae8GTkM1pxU1TNniTwQKFI3qhmiMz
 wmIQ4hBP6GZ3u6h38l0Xp1Q70hdB0BzYpmOa4frMg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 479hvn4vxt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Jun 2025 15:04:29 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55HDjRfe001627; Tue, 17 Jun 2025 15:04:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 478yh9bxq0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Jun 2025 15:04:28 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55HF4SvX014869;
 Tue, 17 Jun 2025 15:04:28 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 478yh9bxny-1; Tue, 17 Jun 2025 15:04:28 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: ethan.milon@eviden.com, mst@redhat.com, pbonzini@redhat.com,
 mjt@tls.msk.ru, marcel.apfelbaum@gmail.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, brijesh.singh@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com, philmd@linaro.org
Subject: [PATCH v4 0/8] amd_iommu: Fixes to align with AMDVi specification
Date: Tue, 17 Jun 2025 15:04:19 +0000
Message-ID: <20250617150427.20585-1-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_06,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506170117
X-Authority-Analysis: v=2.4 cv=XeSJzJ55 c=1 sm=1 tr=0 ts=685183fd b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=Q-oLH4KKFRsqSvFVkUQA:9
 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: mXv-Pv-3bQOBXCDuyi5hDo7kyFH5FL_Y
X-Proofpoint-GUID: mXv-Pv-3bQOBXCDuyi5hDo7kyFH5FL_Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDExOCBTYWx0ZWRfXxF43o/5BxeOJ
 fG2eUH1lP3RWUYN6w7TNkxwdFZMhIVELty+cHWORt4zI2CCxYLjOge0NGyi663CWGzivB/5j7+C
 juoJVEHJc2uVngaNa03klzutPyzPd6n9YNeaMfA4Ib+JEEZJxkfyitHNVL89OIh+A3Wzn6vVS/m
 nXvxj/EgXZifclWQQgB6mOCDSBZ5fBuGQmACVI46nDpFxQiYs4zLWM5Fv0xYdUfKONaVgrW+P/X
 UmqqYkKUR+c94xWw7TsaHd81azXOaXE0gRddpgUNh6d/GggImYzF7nnOcA61dhexvyW2ouPmzbg
 q56ChtPK9UjI+m1w6laYpVcMmOzxchQsiOPT/mqzVl67bUkN+LUVMEdLG2DAUXXObot7yuA0GT8
 tDjXpCG4dr96GLx2vOjy27n2Bh1oMonQ7CtE1ZMfGJi95xg5eNlo5hR1tE6taWIN8JUxjGGr
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Added two new changes based on observations from Ethan. Like the rest of
the fixes in this series, these do not trigger problems today given the
limited feature set supported. Re-tested the series with emulated devices,
VFIO passthrough usage with amd-iommu is not possible since merge of commit
31753d5a336f ("hw/i386/amd_iommu: Fix device setup failure when PT is on.")
regardless of guest kernel iommu mode.

Changes since v3:
- Made an additional change in PATCH 1 with correct encoding for
AMDVI_MAX_GVA_ADDR, adding Ethan as co-author. Dropped Vasant R-b.
- Added patch by Ethan fixing truncation bug.

Thank you,
Alejandro

v3: https://lore.kernel.org/all/20250529193023.3590780-1-alejandro.j.jimenez@oracle.com/

Alejandro Jimenez (7):
  amd_iommu: Fix Miscellaneous Information Register 0 encoding
  amd_iommu: Fix Device ID decoding for INVALIDATE_IOTLB_PAGES command
  amd_iommu: Update bitmasks representing DTE reserved fields
  amd_iommu: Fix masks for various IOMMU MMIO Registers
  amd_iommu: Fix mask to retrieve Interrupt Table Root Pointer from DTE
  amd_iommu: Fix the calculation for Device Table size
  amd_iommu: Remove duplicated definitions

Ethan Milon (1):
  amd_iommu: Fix truncation of oldval in amdvi_writeq

 hw/i386/amd_iommu.c | 17 +++++++------
 hw/i386/amd_iommu.h | 59 ++++++++++++++++++++++-----------------------
 2 files changed, 38 insertions(+), 38 deletions(-)


base-commit: a6f02277595136832c9e9bcaf447ab574f7b1128
-- 
2.43.5


