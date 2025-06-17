Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BE2C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYJ1-0002Ua-JU; Tue, 17 Jun 2025 11:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uRYI7-0001Fx-Sq
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:32:04 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uRXrb-0006sY-Q8
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:04:41 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HEX1kC003995;
 Tue, 17 Jun 2025 15:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=hnK14
 NSncMR/M7NA29/0z4zuv66VAbToBpQ0LVKOuYE=; b=F0OOm+v8oJ7bgomGlnn1D
 qdj6ASxwGuDg738VV+qj2Lp5P9nyPGhFGswWdlBe8N7fxIpdNtGdUz4nfF6Hyq6Q
 Dog+/AYNm8196qgAFQiRWUQ+v/IWYyF+h7lnfmbRohlNQ5qK7CoPPZxdN25Zh1hA
 grfLe8o3ZUZhSSHDMrrehzi8Tqpj/kUDWcnoRyhv3wKzvSaL0OHbvvg+syErQRay
 dW1wXG2zTA3whXl+hOpABPb7bfb1jZshKULG7DYgepBOTgBUBHObQO8IVWGnTpcs
 yJp4v8IHGxvnGaBqYxr+bMU2bSl821ESQsJdaI/bmBJHP/GhzIv5DSMomCH2TtMr
 w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 478yv55eyd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Jun 2025 15:04:32 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55HEKQPs000872; Tue, 17 Jun 2025 15:04:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 478yh9bxsw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Jun 2025 15:04:31 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55HF4Svf014869;
 Tue, 17 Jun 2025 15:04:30 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 478yh9bxny-5; Tue, 17 Jun 2025 15:04:30 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: ethan.milon@eviden.com, mst@redhat.com, pbonzini@redhat.com,
 mjt@tls.msk.ru, marcel.apfelbaum@gmail.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, brijesh.singh@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com, philmd@linaro.org
Subject: [PATCH v4 4/8] amd_iommu: Fix masks for various IOMMU MMIO Registers
Date: Tue, 17 Jun 2025 15:04:23 +0000
Message-ID: <20250617150427.20585-5-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250617150427.20585-1-alejandro.j.jimenez@oracle.com>
References: <20250617150427.20585-1-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDExOCBTYWx0ZWRfX6Ry377NW1TH4
 vREryrsiokI19VhS9lLSmikeCsLr/gfDfkwOSVy4VQTrVsMZSSmgWVqRIS4ml/o1yoPH9twMxXK
 uEmBHTJWLAk4e8XG4hRrQz47q3xEFlV3AaAVep+weQiNtOCKYo+ZkQxXvY/9Zto4wBOd5m2G8TL
 dBs3yjL6q07C/h2DAR+MV26tf30sPyomfdNhsgbHK3BFKoWrCPIPD6ep6BBwOv8gR9/gGMB9TXY
 sU+iTksGvW/1mkgsLYRnniK0Ol4QhXE7wSHZS9Bg/rTuO7li6tufanCUUyPoeTZL+R4IN00SCD7
 o4Sz1goM/aU/6Z5XBHk3VzxfQL662SqRV/faRtPx4FXE5C7FIDQ1GFn89dyHEXCNUsBdY1YFwfe
 eVG3U7zbBCA96mRUnP0XwzmShWRNsd0W3hDDsv/kNGfJILarWEPEySlP3dLg27jltZoO7rLH
X-Proofpoint-GUID: MHXJIC3fdcSG3rMdbWEQ6jAo2xTO_8lG
X-Proofpoint-ORIG-GUID: MHXJIC3fdcSG3rMdbWEQ6jAo2xTO_8lG
X-Authority-Analysis: v=2.4 cv=W9c4VQWk c=1 sm=1 tr=0 ts=68518400 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6IFa9wvqVegA:10 a=69wJf7TsAAAA:8 a=yPCof4ZbAAAA:8 a=zd2uoN0lAAAA:8
 a=x93to4iw_sD-aHtwAakA:9
 a=Fg1AiH1G6rFz08G2ETeA:22 cc=ntf awl=host:13206
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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

Address various issues with definitions of the MMIO registers e.g. for the
Device Table Address Register, the size mask currently encompasses reserved
bits [11:9], so change it to only extract the bits [8:0] encoding size.

Convert masks to use GENMASK64 for consistency, and make unrelated
definitions independent.

Cc: qemu-stable@nongnu.org
Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.h | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index aacb29b617aec..988a485f808cc 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -68,34 +68,34 @@
 
 #define AMDVI_MMIO_SIZE               0x4000
 
-#define AMDVI_MMIO_DEVTAB_SIZE_MASK   ((1ULL << 12) - 1)
-#define AMDVI_MMIO_DEVTAB_BASE_MASK   (((1ULL << 52) - 1) & ~ \
-                                       AMDVI_MMIO_DEVTAB_SIZE_MASK)
+#define AMDVI_MMIO_DEVTAB_SIZE_MASK     GENMASK64(8, 0)
+#define AMDVI_MMIO_DEVTAB_BASE_MASK     GENMASK64(51, 12)
+
 #define AMDVI_MMIO_DEVTAB_ENTRY_SIZE  32
 #define AMDVI_MMIO_DEVTAB_SIZE_UNIT   4096
 
 /* some of this are similar but just for readability */
 #define AMDVI_MMIO_CMDBUF_SIZE_BYTE       (AMDVI_MMIO_COMMAND_BASE + 7)
 #define AMDVI_MMIO_CMDBUF_SIZE_MASK       0x0f
-#define AMDVI_MMIO_CMDBUF_BASE_MASK       AMDVI_MMIO_DEVTAB_BASE_MASK
-#define AMDVI_MMIO_CMDBUF_HEAD_MASK       (((1ULL << 19) - 1) & ~0x0f)
-#define AMDVI_MMIO_CMDBUF_TAIL_MASK       AMDVI_MMIO_EVTLOG_HEAD_MASK
+#define AMDVI_MMIO_CMDBUF_BASE_MASK       GENMASK64(51, 12)
+#define AMDVI_MMIO_CMDBUF_HEAD_MASK       GENMASK64(18, 4)
+#define AMDVI_MMIO_CMDBUF_TAIL_MASK       GENMASK64(18, 4)
 
 #define AMDVI_MMIO_EVTLOG_SIZE_BYTE       (AMDVI_MMIO_EVENT_BASE + 7)
-#define AMDVI_MMIO_EVTLOG_SIZE_MASK       AMDVI_MMIO_CMDBUF_SIZE_MASK
-#define AMDVI_MMIO_EVTLOG_BASE_MASK       AMDVI_MMIO_CMDBUF_BASE_MASK
-#define AMDVI_MMIO_EVTLOG_HEAD_MASK       (((1ULL << 19) - 1) & ~0x0f)
-#define AMDVI_MMIO_EVTLOG_TAIL_MASK       AMDVI_MMIO_EVTLOG_HEAD_MASK
+#define AMDVI_MMIO_EVTLOG_SIZE_MASK       0x0f
+#define AMDVI_MMIO_EVTLOG_BASE_MASK       GENMASK64(51, 12)
+#define AMDVI_MMIO_EVTLOG_HEAD_MASK       GENMASK64(18, 4)
+#define AMDVI_MMIO_EVTLOG_TAIL_MASK       GENMASK64(18, 4)
 
-#define AMDVI_MMIO_PPRLOG_SIZE_BYTE       (AMDVI_MMIO_EVENT_BASE + 7)
-#define AMDVI_MMIO_PPRLOG_HEAD_MASK       AMDVI_MMIO_EVTLOG_HEAD_MASK
-#define AMDVI_MMIO_PPRLOG_TAIL_MASK       AMDVI_MMIO_EVTLOG_HEAD_MASK
-#define AMDVI_MMIO_PPRLOG_BASE_MASK       AMDVI_MMIO_EVTLOG_BASE_MASK
-#define AMDVI_MMIO_PPRLOG_SIZE_MASK       AMDVI_MMIO_EVTLOG_SIZE_MASK
+#define AMDVI_MMIO_PPRLOG_SIZE_BYTE       (AMDVI_MMIO_PPR_BASE + 7)
+#define AMDVI_MMIO_PPRLOG_SIZE_MASK       0x0f
+#define AMDVI_MMIO_PPRLOG_BASE_MASK       GENMASK64(51, 12)
+#define AMDVI_MMIO_PPRLOG_HEAD_MASK       GENMASK64(18, 4)
+#define AMDVI_MMIO_PPRLOG_TAIL_MASK       GENMASK64(18, 4)
 
 #define AMDVI_MMIO_EXCL_ENABLED_MASK      (1ULL << 0)
 #define AMDVI_MMIO_EXCL_ALLOW_MASK        (1ULL << 1)
-#define AMDVI_MMIO_EXCL_LIMIT_MASK        AMDVI_MMIO_DEVTAB_BASE_MASK
+#define AMDVI_MMIO_EXCL_LIMIT_MASK        GENMASK64(51, 12)
 #define AMDVI_MMIO_EXCL_LIMIT_LOW         0xfff
 
 /* mmio control register flags */
@@ -132,14 +132,14 @@
 #define AMDVI_DEV_TRANSLATION_VALID       (1ULL << 1)
 #define AMDVI_DEV_MODE_MASK               0x7
 #define AMDVI_DEV_MODE_RSHIFT             9
-#define AMDVI_DEV_PT_ROOT_MASK            0xffffffffff000
+#define AMDVI_DEV_PT_ROOT_MASK            GENMASK64(51, 12)
 #define AMDVI_DEV_PT_ROOT_RSHIFT          12
 #define AMDVI_DEV_PERM_SHIFT              61
 #define AMDVI_DEV_PERM_READ               (1ULL << 61)
 #define AMDVI_DEV_PERM_WRITE              (1ULL << 62)
 
 /* Device table entry bits 64:127 */
-#define AMDVI_DEV_DOMID_ID_MASK          ((1ULL << 16) - 1)
+#define AMDVI_DEV_DOMID_ID_MASK             GENMASK64(15, 0)
 
 /* Event codes and flags, as stored in the info field */
 #define AMDVI_EVENT_ILLEGAL_DEVTAB_ENTRY  (0x1U << 12)
@@ -197,7 +197,7 @@
 #define AMDVI_PAGE_SIZE  (1ULL << AMDVI_PAGE_SHIFT)
 
 #define AMDVI_PAGE_SHIFT_4K 12
-#define AMDVI_PAGE_MASK_4K  (~((1ULL << AMDVI_PAGE_SHIFT_4K) - 1))
+#define AMDVI_PAGE_MASK_4K      GENMASK64(63, 12)
 
 #define AMDVI_MAX_GVA_ADDR      (2UL << 5)
 #define AMDVI_MAX_PH_ADDR       (40UL << 8)
-- 
2.43.5


