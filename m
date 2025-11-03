Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F43CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 20:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1E9-0008Ve-Hh; Mon, 03 Nov 2025 15:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vG1E5-0008ID-HO
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 15:32:29 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vG1Dv-00008J-E7
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 15:32:29 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3KTnwu015014;
 Mon, 3 Nov 2025 20:32:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=d4Q1b
 S/B5AYZ7OmTxVGQCxlQj5fv4tDwrtU15ojiu5U=; b=bBHq+H7trMEfpbZajgVIu
 TtUD5msEmKkrJWPqrYK5zVDLKr0a1cuHh/lzSlWu0X/tLsG2cp2kxJyoys+rYw8C
 /H6aYKJLq7rkVJICpkXQ9JRVTcyKwo5ScUfT5L69TFst+pfylF2Jp+Qw0H5fBTYI
 n2nIOj2at6pVOZRe5CJ4kGscUUCR+bNsGUi77r+H92XzbPUNc6GcQ37+i96YEPSc
 aTNU0xnWHeGu4fXp/oTtTn0juhGG3b77tkMK8M1eh5UH1dbeNuc2Cz1eEGODpGrF
 i96RDJb6SsFs1GxYpqnc3TiFVtCEOzMPJwoSjmWKgKfUbehfQv7Z/sZfkULLrfjd
 g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a73fqr057-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Nov 2025 20:32:12 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5A3JpNMT010221; Mon, 3 Nov 2025 20:32:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4a58nc6ebk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Nov 2025 20:32:11 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A3KSvS5040083;
 Mon, 3 Nov 2025 20:32:11 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4a58nc6e9h-4; Mon, 03 Nov 2025 20:32:10 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: mst@redhat.com, qemu-devel@nongnu.org, sarunkod@amd.com
Cc: alejandro.j.jimenez@oracle.com
Subject: [PATCH 3/3] amd_iommu: Support 64-bit address for IOTLB lookup
Date: Mon,  3 Nov 2025 20:32:09 +0000
Message-ID: <20251103203209.645434-4-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251103203209.645434-1-alejandro.j.jimenez@oracle.com>
References: <20251103203209.645434-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030183
X-Proofpoint-ORIG-GUID: UVmPV_A66X1ZrtiBIRVLtsZCQCuW6e6L
X-Authority-Analysis: v=2.4 cv=G6AR0tk5 c=1 sm=1 tr=0 ts=6909114c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=zd2uoN0lAAAA:8 a=yPCof4ZbAAAA:8
 a=y9DNqzNOOROiqJ2FHEcA:9 cc=ntf awl=host:13657
X-Proofpoint-GUID: UVmPV_A66X1ZrtiBIRVLtsZCQCuW6e6L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE4MyBTYWx0ZWRfX3mHN2Kj76Tl6
 KKQ0YYMXXJrfhoZXqFiZ2CReBTky25Lh+mVOO1g/x/FLlSHJqoxzvaTbXl2Z/kHpXYyIK7kp8Q8
 0KBdcoh4ZC9wjCBM4jvk3tTnhWNVpZypXfIWDnXp0Xe/KJ/4hw/qG9VNXAteCfV1KTbqdRkeBTU
 fQZwoWYg7I6cLGuavSNdLtMfqGgOB/Al2Y3wYGimp/2bMxD1wxLmzBwrSNazXPRwwhc9lOF7sQb
 55pb6r8zsniqUWn2zRia9mdHEb8lecsU8O0WvOky8iyLpTS/9Ik4breCyUO/02/KHe4Pm0D4xwg
 HGbydcQ6C+eENDfnIHvBoicVlUPgThgjZ8/EP3yydcp/BKXMuGGE3EAhz2nC/lMPzDfv2WlEMVb
 2KJ3cq2lDdfINH75AzRkLSImuOTUZd1WnFq/15skaoCAuHl43lI=
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Sairaj Kodilkar <sarunkod@amd.com>

The physical AMD IOMMU supports up to 64 bits of IOVA. When a device tries
to read or write from a given DMA address, the IOMMU translates the address
using the I/O page tables assigned to that device. Since the emulated IOMMU
uses per-device page tables, an ideal cache tag would need to be 68 bits
(64-bit address - 12-bit page alignment + 16-bit device ID).

The current software IOTLB implementation uses a GLib hash table with a
64-bit key to hash both the IOVA and device ID, which limits the IOVA to 60
bits. This causes a failure while setting up the device when a guest is
booted with "iommu.forcedac=1", which forces the use of DMA addresses at the
top of the 64-bit address space.

To address this issue, construct the 64-bit hash key using the upper 52 bits
of IOVA (GFN) and lower 12 bits of the device ID to avoid truncation as much
as possible (reducing hash collisions).

Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 57 ++++++++++++++++++++++++++++++---------------
 hw/i386/amd_iommu.h |  4 ++--
 2 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 78407ead80..5ccb30aa7f 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -106,6 +106,11 @@ typedef struct AMDVIAsKey {
     uint8_t devfn;
 } AMDVIAsKey;
 
+typedef struct AMDVIIOTLBKey {
+    uint64_t gfn;
+    uint16_t devid;
+} AMDVIIOTLBKey;
+
 uint64_t amdvi_extended_feature_register(AMDVIState *s)
 {
     uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
@@ -377,16 +382,6 @@ static void amdvi_log_pagetab_error(AMDVIState *s, uint16_t devid,
              PCI_STATUS_SIG_TARGET_ABORT);
 }
 
-static gboolean amdvi_uint64_equal(gconstpointer v1, gconstpointer v2)
-{
-    return *((const uint64_t *)v1) == *((const uint64_t *)v2);
-}
-
-static guint amdvi_uint64_hash(gconstpointer v)
-{
-    return (guint)*(const uint64_t *)v;
-}
-
 static gboolean amdvi_as_equal(gconstpointer v1, gconstpointer v2)
 {
     const AMDVIAsKey *key1 = v1;
@@ -425,11 +420,30 @@ static AMDVIAddressSpace *amdvi_get_as_by_devid(AMDVIState *s, uint16_t devid)
                              amdvi_find_as_by_devid, &devid);
 }
 
+static gboolean amdvi_iotlb_equal(gconstpointer v1, gconstpointer v2)
+{
+    const AMDVIIOTLBKey *key1 = v1;
+    const AMDVIIOTLBKey *key2 = v2;
+
+    return key1->devid == key2->devid && key1->gfn == key2->gfn;
+}
+
+static guint amdvi_iotlb_hash(gconstpointer v)
+{
+    const AMDVIIOTLBKey *key = v;
+    /* Use GPA and DEVID to find the bucket */
+    return (guint)(key->gfn << AMDVI_PAGE_SHIFT_4K |
+                   (key->devid & ~AMDVI_PAGE_MASK_4K));
+}
+
+
 static AMDVIIOTLBEntry *amdvi_iotlb_lookup(AMDVIState *s, hwaddr addr,
                                            uint64_t devid)
 {
-    uint64_t key = (addr >> AMDVI_PAGE_SHIFT_4K) |
-                   ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
+    AMDVIIOTLBKey key = {
+        .gfn = AMDVI_GET_IOTLB_GFN(addr),
+        .devid = devid,
+    };
     return g_hash_table_lookup(s->iotlb, &key);
 }
 
@@ -451,8 +465,10 @@ static gboolean amdvi_iotlb_remove_by_devid(gpointer key, gpointer value,
 static void amdvi_iotlb_remove_page(AMDVIState *s, hwaddr addr,
                                     uint64_t devid)
 {
-    uint64_t key = (addr >> AMDVI_PAGE_SHIFT_4K) |
-                   ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
+    AMDVIIOTLBKey key = {
+        .gfn = AMDVI_GET_IOTLB_GFN(addr),
+        .devid = devid,
+    };
     g_hash_table_remove(s->iotlb, &key);
 }
 
@@ -463,8 +479,10 @@ static void amdvi_update_iotlb(AMDVIState *s, uint16_t devid,
     /* don't cache erroneous translations */
     if (to_cache.perm != IOMMU_NONE) {
         AMDVIIOTLBEntry *entry = g_new(AMDVIIOTLBEntry, 1);
-        uint64_t *key = g_new(uint64_t, 1);
-        uint64_t gfn = gpa >> AMDVI_PAGE_SHIFT_4K;
+        AMDVIIOTLBKey *key = g_new(AMDVIIOTLBKey, 1);
+
+        key->gfn = AMDVI_GET_IOTLB_GFN(gpa);
+        key->devid = devid;
 
         trace_amdvi_cache_update(domid, PCI_BUS_NUM(devid), PCI_SLOT(devid),
                 PCI_FUNC(devid), gpa, to_cache.translated_addr);
@@ -477,7 +495,8 @@ static void amdvi_update_iotlb(AMDVIState *s, uint16_t devid,
         entry->perms = to_cache.perm;
         entry->translated_addr = to_cache.translated_addr;
         entry->page_mask = to_cache.addr_mask;
-        *key = gfn | ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
+        entry->devid = devid;
+
         g_hash_table_replace(s->iotlb, key, entry);
     }
 }
@@ -2526,8 +2545,8 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
-                                     amdvi_uint64_equal, g_free, g_free);
+    s->iotlb = g_hash_table_new_full(amdvi_iotlb_hash,
+                                     amdvi_iotlb_equal, g_free, g_free);
 
     s->address_spaces = g_hash_table_new_full(amdvi_as_hash,
                                      amdvi_as_equal, g_free, g_free);
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 38471b95d1..302ccca512 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -220,8 +220,8 @@
 #define PAGE_SIZE_PTE_COUNT(pgsz)       (1ULL << ((ctz64(pgsz) - 12) % 9))
 
 /* IOTLB */
-#define AMDVI_IOTLB_MAX_SIZE 1024
-#define AMDVI_DEVID_SHIFT    36
+#define AMDVI_IOTLB_MAX_SIZE        1024
+#define AMDVI_GET_IOTLB_GFN(addr)   (addr >> AMDVI_PAGE_SHIFT_4K)
 
 /* default extended feature */
 #define AMDVI_DEFAULT_EXT_FEATURES \
-- 
2.43.5


