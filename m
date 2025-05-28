Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FA9C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 22:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKP6J-0003FI-LM; Wed, 28 May 2025 18:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uKP5z-0003Ai-PV
 for qemu-devel@nongnu.org; Wed, 28 May 2025 18:18:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uKP5n-0000xC-Vk
 for qemu-devel@nongnu.org; Wed, 28 May 2025 18:17:58 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SIN0Su008656;
 Wed, 28 May 2025 22:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=xoaod
 ebjDpIOvPap0NvvnVV5FCuu/94S3gWgc+lEQ08=; b=hld2qR+9J8FezpholuJ+K
 o/EbQTrwl2gFEkXN/3wyKLPe/9lxM7ikpNUgkXAOkgsZ28UJbFGXxU8SmJxfrsUC
 4C1o/wdQak5X5JpvhaWzA3WoF+JdW1QatT3n+VZhp8hMwJ+ZE2XZhWhM9d38Cshr
 6xA2bD1fyexzr43HpmpOT+2FqBrSeIHmk19Wu4Hr4WlfMH49B9yGeh6cNSJo6m1j
 Y589aRshFMzfwmpR1KB6xxkMOCNJ1u0fp8iXAfyTUEegzZZkXF4nKRsz4qIFTf8c
 opERfcdck6nr0LSiamomSMmC0JQVlnZQuzDLJuseF9rwwHL0z9Ee1g4YuoSbGpws
 w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0g2f4bc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 22:17:31 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54SKYaPt024426; Wed, 28 May 2025 22:17:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jb86wa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 22:17:30 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54SMHQsf018695;
 Wed, 28 May 2025 22:17:30 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 46u4jb86u3-9; Wed, 28 May 2025 22:17:30 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, richard.henderson@linaro.org,
 eduardo@habkost.net, vasant.hegde@amd.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH v2 7/7] amd_iommu: Remove duplicated definitions
Date: Wed, 28 May 2025 22:17:25 +0000
Message-ID: <20250528221725.3554040-9-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250528221725.3554040-1-alejandro.j.jimenez@oracle.com>
References: <20250528221725.3554040-1-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE5NCBTYWx0ZWRfX/IkAn6DefiES
 M8WZ//QKsYQWt2OfQpfWTHFgRKHxSOhOF6QhyPO87tRUyDvSJy0yRvo8SaWhiq7UgMYeiHh4a5+
 La8apcmyaeOIl0fXVrjwJPNUTl45gUvuYJgy4ARKK/bff99RjPub1Qg/Stp9XOQUpBSKhzQxqIN
 6CO8LmDOa137zxvedxCFR1/m8k0t+rJyBpLPjWruA544KmpeMLj/2zfea92dov2ctW7b9vihXMU
 RaXX5H5ln1/oI/Pl9s7wgLclM2wmj8OU7mj17A5ETyfrL+esskwysqpNGt9lbkOEItbFuUbK2B+
 zVwwL4YcKJbaUQ+mXwo+MMBknc8ZPT04RqbM9A/Ay9/Y1KhADsHjaeVUQ3dFzuKkCIq1YL5SO3t
 RavKchHaAlmzuQBv1KeL+JFwdaOag8STw4N9PHIjqjSc8U+wFfTkKkxFkMYhik0kc3ViLePZ
X-Authority-Analysis: v=2.4 cv=NJLV+16g c=1 sm=1 tr=0 ts=68378b7b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=LyhGpKROpydgPnGzpJcA:9 cc=ntf
 awl=host:13206
X-Proofpoint-ORIG-GUID: ExmBXqFJDi1-R7cRYdcPppFJC3HsrH58
X-Proofpoint-GUID: ExmBXqFJDi1-R7cRYdcPppFJC3HsrH58
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
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

No functional change.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 1836b7061d848..31e473924fa20 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -206,10 +206,6 @@
 /* Completion Wait data size */
 #define AMDVI_COMPLETION_DATA_SIZE    8
 
-#define AMDVI_COMMAND_SIZE   16
-/* Completion Wait data size */
-#define AMDVI_COMPLETION_DATA_SIZE    8
-
 #define AMDVI_COMMAND_SIZE   16
 
 #define AMDVI_INT_ADDR_FIRST    0xfee00000
-- 
2.43.5


