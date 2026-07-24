Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CAF8C5321B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 22:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnOT0-0001T3-A3; Fri, 24 Jul 2026 18:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wnOSo-0001Rf-ON
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 18:33:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wnOSn-0001HQ-5v
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 18:33:54 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OJdJcL804660; Fri, 24 Jul 2026 22:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=NZ0zW
 3aWnjmLoZ7d0QPdZZceg8Dr/tt46AUVHskmBZ8=; b=Kz0tlzXI2kxvUoauTm4Nj
 rX1nfiHvNVDmjHDKcEIZ9hy+8bmYws3tjtGWetSLuWapr9DXWxz1yHtINB+BUXRS
 6ikN0TyXuXsI47TI4vJ2TDeZEq5FTJYWWaumOoDwbrGWU/jZcIKnMD7mcz1tmTjr
 eGwYK7bMZ++Y41GBlIjd2xJkEF0Yo1Zy5EamOJt2za5MPeiAUy0Fbx3aD3/hYEMi
 W1uP82GpWqy1PqGSMwnXM/LQEzHXmhwPKsW9qWv7aEqB4z2FFnrHNOAwRx/oeDMx
 JJ8WvZgi1Rb+DU8Y+M3r1csWp+dVliLc97D10r0gFTGAKmxxdAv6j9gcC5iueP5d
 w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fg1n39e1j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 22:33:49 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 66OMXa8S028390; Fri, 24 Jul 2026 22:33:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4ffyxtq3ds-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 22:33:49 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66OMXiTU029565;
 Fri, 24 Jul 2026 22:33:48 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4ffyxtq3a1-5; Fri, 24 Jul 2026 22:33:48 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: alejandro.j.jimenez@oracle.com, sarunkod@amd.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, mst@redhat.com, joe.jin@oracle.com
Subject: [PATCH v2 4/5] amd_iommu: Make extended feature register read-only
Date: Fri, 24 Jul 2026 15:31:30 -0700
Message-ID: <20260724223216.108667-5-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260724223216.108667-1-dongli.zhang@oracle.com>
References: <20260724223216.108667-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2606160000
 definitions=main-2607240203
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDIwMiBTYWx0ZWRfX+cFinA2Wy1li
 P9qHmyskTbULh1bougRDraQiXqU5OzSvdmwnTKPXBwb78KIW1hnvh1xtjbWfPTXst7KBWjaT8Cl
 OPngGx9IKETDVTf62nFBKegigneXadIh5aIM1mEs0wPLKwrNV3UArOnIM20Kg/ZfF8mG5Yy8jYF
 hzxwkEm6zHg8GuFErj9vy+AKxUyfrWUWJ15XNWJPsGsEq6CN/bTtSkIfiH9vS8tNfk7OWvRh/3W
 MECw24TT6yS1xOUClBR7KAiWcB45iLGReJHVJyYLBb3NUxVR15KNSsiA7kfzz2alRmJBGkkVrKE
 FzuLvHwoBiKdV7/HTrc0zEA46i7u3y0/fY6XWA3pF2zR67bP0xMjerNQoNjFvO01GEPmBeJYf/8
 1ZBSqc+kJz5av8mVYmf1aAzUB544dhGbysapNkjoAkAaClL6mXfjo2VjFPtsVa9YLumVY+bDq/f
 0h8Er28HDsynH5uitxPgyFpmHoHBoFhwAo2my660=
X-Proofpoint-GUID: njZ1xNnuSpTR5B0Jd5Dr5wvtT0flDNz3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDIwMiBTYWx0ZWRfX3ZT+fva5VD6X
 3stur+PQQYpqNcYS4PkyoAl1sOT1tyilQ54xcv9eFFQk0EMxOW74DAVDYSS8FASNqr9OLnEpF+z
 tzhNq5TYNYjv11pq2AM+AcaSNpI0/PTs4IxkBGtbGSC/Q96GvgQf
X-Authority-Analysis: v=2.4 cv=JrfBas4C c=1 sm=1 tr=0 ts=6a63e84d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=zd2uoN0lAAAA:8 a=yPCof4ZbAAAA:8
 a=WXpONT3DEgEzS31w2TMA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12114
X-Proofpoint-ORIG-GUID: njZ1xNnuSpTR5B0Jd5Dr5wvtT0flDNz3
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

AMDVI_MMIO_EXT_FEATURES is populated from QEMU's advertised AMD-Vi
extended feature set during reset. Guest writes to this register do not
enable or disable any corresponding QEMU emulation behavior.

The current mask leaves bit 4 writable, which only allows the guest to
modify the stored feature value without changing the device model. Make
the register fully read-only so the visible feature bits remain controlled
by QEMU.

According to the AMD IOMMU SDM, bits 25:24 (DualPprLogSup),
29:28 (DualEventLogSup), and 37 (USSup) are not specified as RO.
This commit modifies only bit 4 (GTSup), while leaving the rest as they
are.

Suggested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 hw/i386/amd_iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index f86e37fe93..9cd510d790 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -241,7 +241,7 @@
         AMDVI_FEATURE_IA | AMDVI_FEATURE_GT | AMDVI_FEATURE_HE | \
         AMDVI_GATS_MODE | AMDVI_HATS_MODE | AMDVI_FEATURE_GA)
 
-#define AMDVI_MMIO_EXT_FEATURE_RO_MASK 0xffffffffffffffefULL
+#define AMDVI_MMIO_EXT_FEATURE_RO_MASK (~0ULL)
 
 /* capabilities header */
 #define AMDVI_CAPAB_FEATURES (AMDVI_CAPAB_FLAT_EXT | \
-- 
2.39.3


