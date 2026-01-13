Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF97D29DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfaqC-0007cW-67; Tue, 13 Jan 2026 04:37:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaqA-0007bE-Ix
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:37:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaq8-0003Kr-Ii
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:37:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mv0EwYzlFCvikSoABPO1ryNNzeN1Wj7ju0V4ba1YJwM=;
 b=LuT4AD0dVZy7JB4TKT5xpy/iZLM5c1yXHr/frfALRgqhpH5T10phDY7TEl8UJMBa4p/NHd
 T5oxlbrBuaSlZrhdjSrk6lgs09nVgEq6P/IIPFmMpCvRYpb1ZcRlxTcPMTqcICrunQJCrD
 I0OYq3nIO48Mp6cXPqBfBFgc6yTlQbQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-spmEiJ6IO1m3vWU7A9aaPw-1; Tue,
 13 Jan 2026 04:37:24 -0500
X-MC-Unique: spmEiJ6IO1m3vWU7A9aaPw-1
X-Mimecast-MFC-AGG-ID: spmEiJ6IO1m3vWU7A9aaPw_1768297043
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 23442195608F; Tue, 13 Jan 2026 09:37:23 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C6AE230001A2; Tue, 13 Jan 2026 09:37:20 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/41] intel_iommu: Add some macros and inline functions
Date: Tue, 13 Jan 2026 10:36:10 +0100
Message-ID: <20260113093637.1549214-15-clg@redhat.com>
In-Reply-To: <20260113093637.1549214-1-clg@redhat.com>
References: <20260113093637.1549214-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Add some macros and inline functions that will be used by following patch.

This patch also make a cleanup to change below macros to use extract64()
just like what smmu does, because they are either used in following patches
or used indirectly by new introduced inline functions.

  VTD_INV_DESC_PIOTLB_IH
  VTD_SM_PASID_ENTRY_PGTT
  VTD_SM_PASID_ENTRY_DID
  VTD_SM_PASID_ENTRY_FSPM
  VTD_SM_PASID_ENTRY_FSPTPTR

But we doesn't aim to change the huge amount of bit mask style macro
definitions in this patch, that should be in a separate patch.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260106061304.314546-13-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i386/intel_iommu_internal.h | 50 ++++++++++++++++++++++++++++------
 hw/i386/intel_iommu.c          | 27 +++++++++---------
 2 files changed, 55 insertions(+), 22 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index d8dad183043798d7c052a5b0767ab662ef3e9960..e987322e93ab05db2873d550de78abca268ca8c9 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -516,7 +516,7 @@ typedef union VTDPRDesc VTDPRDesc;
 #define VTD_INV_DESC_PIOTLB_DID(val)      (((val) >> 16) & VTD_DOMAIN_ID_MASK)
 #define VTD_INV_DESC_PIOTLB_PASID(val)    (((val) >> 32) & 0xfffffULL)
 #define VTD_INV_DESC_PIOTLB_AM(val)       ((val) & 0x3fULL)
-#define VTD_INV_DESC_PIOTLB_IH(val)       (((val) >> 6) & 0x1)
+#define VTD_INV_DESC_PIOTLB_IH(x)         extract64((x)->val[1], 6, 1)
 #define VTD_INV_DESC_PIOTLB_ADDR(val)     ((val) & ~0xfffULL)
 #define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000f1c0ULL
 #define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
@@ -636,17 +636,20 @@ typedef struct VTDPASIDCacheInfo {
 
 /* PASID Granular Translation Type Mask */
 #define VTD_PASID_ENTRY_P              1ULL
-#define VTD_SM_PASID_ENTRY_PGTT        (7ULL << 6)
-#define VTD_SM_PASID_ENTRY_FST         (1ULL << 6)
-#define VTD_SM_PASID_ENTRY_SST         (2ULL << 6)
-#define VTD_SM_PASID_ENTRY_NESTED      (3ULL << 6)
-#define VTD_SM_PASID_ENTRY_PT          (4ULL << 6)
+#define VTD_SM_PASID_ENTRY_PGTT(x)     extract64((x)->val[0], 6, 3)
+#define VTD_SM_PASID_ENTRY_FST         1
+#define VTD_SM_PASID_ENTRY_SST         2
+#define VTD_SM_PASID_ENTRY_NESTED      3
+#define VTD_SM_PASID_ENTRY_PT          4
 
 #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
-#define VTD_SM_PASID_ENTRY_DID(val)    ((val) & VTD_DOMAIN_ID_MASK)
+#define VTD_SM_PASID_ENTRY_DID(x)      extract64((x)->val[1], 0, 16)
 
-#define VTD_SM_PASID_ENTRY_FSPM          3ULL
-#define VTD_SM_PASID_ENTRY_FSPTPTR       (~0xfffULL)
+#define VTD_SM_PASID_ENTRY_SRE(x)      extract64((x)->val[2], 0, 1)
+#define VTD_SM_PASID_ENTRY_FSPM(x)     extract64((x)->val[2], 2, 2)
+#define VTD_SM_PASID_ENTRY_WPE(x)      extract64((x)->val[2], 4, 1)
+#define VTD_SM_PASID_ENTRY_EAFE(x)     extract64((x)->val[2], 7, 1)
+#define VTD_SM_PASID_ENTRY_FSPTPFN(x)  extract64((x)->val[2], 12, 52)
 
 /* First Stage Paging Structure */
 /* Masks for First Stage Paging Entry */
@@ -696,4 +699,33 @@ struct vtd_as_key {
     uint8_t devfn;
     uint32_t pasid;
 };
+
+static inline dma_addr_t vtd_pe_get_fspt_base(VTDPASIDEntry *pe)
+{
+    return VTD_SM_PASID_ENTRY_FSPTPFN(pe) << VTD_PAGE_SHIFT;
+}
+
+/*
+ * First stage IOVA address width: 48 bits for 4-level paging(FSPM=00)
+ *                                 57 bits for 5-level paging(FSPM=01)
+ */
+static inline uint32_t vtd_pe_get_fs_aw(VTDPASIDEntry *pe)
+{
+    /*
+     * Paging mode for first-stage translation (VTD spec Figure 9-6)
+     * 00: 4-level paging, 01: 5-level paging
+     */
+    return VTD_HOST_AW_48BIT + VTD_SM_PASID_ENTRY_FSPM(pe) * 9;
+}
+
+static inline bool vtd_pe_pgtt_is_pt(VTDPASIDEntry *pe)
+{
+    return (VTD_SM_PASID_ENTRY_PGTT(pe) == VTD_SM_PASID_ENTRY_PT);
+}
+
+/* check if PGTT is first stage translation */
+static inline bool vtd_pe_pgtt_is_fst(VTDPASIDEntry *pe)
+{
+    return (VTD_SM_PASID_ENTRY_PGTT(pe) == VTD_SM_PASID_ENTRY_FST);
+}
 #endif
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index d5a4e02fa1138e0195b6ac225512dafe041e0605..9edd625b1a5d246c311efd510df3967749690c29 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -48,10 +48,11 @@
 #define VTD_CE_GET_PRE(ce) \
     ((ce)->val[0] & VTD_SM_CONTEXT_ENTRY_PRE)
 
-/* pe operations */
-#define VTD_PE_GET_TYPE(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_PGTT)
-#define VTD_PE_GET_FS_LEVEL(pe) \
-    (4 + (((pe)->val[2] >> 2) & VTD_SM_PASID_ENTRY_FSPM))
+/*
+ * Paging mode for first-stage translation (VTD spec Figure 9-6)
+ * 00: 4-level paging, 01: 5-level paging
+ */
+#define VTD_PE_GET_FS_LEVEL(pe) (VTD_SM_PASID_ENTRY_FSPM(pe) + 4)
 #define VTD_PE_GET_SS_LEVEL(pe) \
     (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
 
@@ -807,7 +808,7 @@ static inline bool vtd_is_fs_level_supported(IntelIOMMUState *s, uint32_t level)
 /* Return true if check passed, otherwise false */
 static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
 {
-    switch (VTD_PE_GET_TYPE(pe)) {
+    switch (VTD_SM_PASID_ENTRY_PGTT(pe)) {
     case VTD_SM_PASID_ENTRY_FST:
         return !!(s->ecap & VTD_ECAP_FSTS);
     case VTD_SM_PASID_ENTRY_SST:
@@ -882,7 +883,7 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
         return -VTD_FR_PASID_TABLE_ENTRY_INV;
     }
 
-    pgtt = VTD_PE_GET_TYPE(pe);
+    pgtt = VTD_SM_PASID_ENTRY_PGTT(pe);
     if (pgtt == VTD_SM_PASID_ENTRY_SST &&
         !vtd_is_ss_level_supported(s, VTD_PE_GET_SS_LEVEL(pe))) {
             return -VTD_FR_PASID_TABLE_ENTRY_INV;
@@ -1116,7 +1117,7 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
     if (s->root_scalable) {
         vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
         if (s->fsts) {
-            return pe.val[2] & VTD_SM_PASID_ENTRY_FSPTPTR;
+            return vtd_pe_get_fspt_base(&pe);
         } else {
             return pe.val[0] & VTD_SM_PASID_ENTRY_SSPTPTR;
         }
@@ -1605,7 +1606,7 @@ static uint16_t vtd_get_domain_id(IntelIOMMUState *s,
 
     if (s->root_scalable) {
         vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
-        return VTD_SM_PASID_ENTRY_DID(pe.val[1]);
+        return VTD_SM_PASID_ENTRY_DID(&pe);
     }
 
     return VTD_CONTEXT_ENTRY_DID(ce->hi);
@@ -1687,7 +1688,7 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
              */
             return false;
         }
-        return (VTD_PE_GET_TYPE(&pe) == VTD_SM_PASID_ENTRY_PT);
+        return vtd_pe_pgtt_is_pt(&pe);
     }
 
     return (vtd_ce_get_type(ce) == VTD_CONTEXT_TT_PASS_THROUGH);
@@ -3108,9 +3109,9 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
         /* Fall through */
     case VTD_INV_DESC_PASIDC_G_DSI:
         if (pc_entry->valid) {
-            did = VTD_SM_PASID_ENTRY_DID(pc_entry->pasid_entry.val[1]);
+            did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
         } else {
-            did = VTD_SM_PASID_ENTRY_DID(pe.val[1]);
+            did = VTD_SM_PASID_ENTRY_DID(&pe);
         }
         if (pc_info->did != did) {
             return;
@@ -5154,8 +5155,8 @@ static int vtd_pri_perform_implicit_invalidation(VTDAddressSpace *vtd_as,
     if (ret) {
         return -EINVAL;
     }
-    pgtt = VTD_PE_GET_TYPE(&pe);
-    domain_id = VTD_SM_PASID_ENTRY_DID(pe.val[1]);
+    pgtt = VTD_SM_PASID_ENTRY_PGTT(&pe);
+    domain_id = VTD_SM_PASID_ENTRY_DID(&pe);
     ret = 0;
     switch (pgtt) {
     case VTD_SM_PASID_ENTRY_FST:
-- 
2.52.0


