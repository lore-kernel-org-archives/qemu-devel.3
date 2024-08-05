Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FD5C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 06:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sarEv-0002hx-Nz; Mon, 05 Aug 2024 02:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sarEs-0002ZB-9D
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 02:30:38 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sarEo-0002As-2n
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 02:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722839434; x=1754375434;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fWZ1WlrVINaIDCPhcdvPghs2mVgyi9km0PrX588cEfA=;
 b=GNksszw4DKUs1ZuwDNrCQaOsg8/Wi457tYjRh3ukDnXf4IYSOR+WEsF2
 z78a28iDXuIENMnmRfXudu6EXYpBb/f0ZLp7xXmjnXRfrTb4qG33uS+HO
 503HjXMtK4i9DC+mBSnCZa4ei4iWREdLoTkYatGhlnx+xLAGorHfLtgUR
 2NuEFlOyMDhNEX35P3SFU0r+LGMbGfmpIv0F60yGnSuFCslZTV7J1OUEP
 NMCiAS2TxyWhuD2vlvxTvquzzeHHqkY/8UPpJ0Z0iCnLLbwZyjMaCnu80
 EGP6Q9ho/l9afwSIzE5tNWw67a+G9NrJG/Pmyr97aUY1sMtzX/1oq+92E A==;
X-CSE-ConnectionGUID: 1UhcLr8iT5OUot55DJGp+g==
X-CSE-MsgGUID: iZA+scaSQNahZGHGXNMaVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="38282707"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; d="scan'208";a="38282707"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2024 23:30:31 -0700
X-CSE-ConnectionGUID: CDKQ4TiNT7qVg1H4ede6RA==
X-CSE-MsgGUID: rPzjJYx8ROykk2H1dkUF+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; d="scan'208";a="56786692"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2024 23:30:26 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 05/17] intel_iommu: Rename slpte to pte
Date: Mon,  5 Aug 2024 14:27:15 +0800
Message-Id: <20240805062727.2307552-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Yi Liu <yi.l.liu@intel.com>

Because we will support both FST(a.k.a, FLT) and SST(a.k.a, SLT) translation,
rename variable and functions from slpte to pte whenever possible.

But some are SST only, they are renamed with sl_ prefix.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Co-developed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  24 +++---
 include/hw/i386/intel_iommu.h  |   2 +-
 hw/i386/intel_iommu.c          | 129 +++++++++++++++++----------------
 3 files changed, 78 insertions(+), 77 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 19e4ed52ca..1fa4add9e2 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -528,24 +528,24 @@ typedef struct VTDRootEntry VTDRootEntry;
 /* Second Level Page Translation Pointer*/
 #define VTD_SM_PASID_ENTRY_SLPTPTR     (~0xfffULL)
 
-/* Paging Structure common */
-#define VTD_SL_PT_PAGE_SIZE_MASK    (1ULL << 7)
-/* Bits to decide the offset for each level */
-#define VTD_SL_LEVEL_BITS           9
-
 /* Second Level Paging Structure */
-#define VTD_SL_PML4_LEVEL           4
-#define VTD_SL_PDP_LEVEL            3
-#define VTD_SL_PD_LEVEL             2
-#define VTD_SL_PT_LEVEL             1
-#define VTD_SL_PT_ENTRY_NR          512
-
 /* Masks for Second Level Paging Entry */
 #define VTD_SL_RW_MASK              3ULL
 #define VTD_SL_R                    1ULL
 #define VTD_SL_W                    (1ULL << 1)
-#define VTD_SL_PT_BASE_ADDR_MASK(aw) (~(VTD_PAGE_SIZE - 1) & VTD_HAW_MASK(aw))
 #define VTD_SL_IGN_COM              0xbff0000000000000ULL
 #define VTD_SL_TM                   (1ULL << 62)
 
+/* Common for both First Level and Second Level */
+#define VTD_PML4_LEVEL           4
+#define VTD_PDP_LEVEL            3
+#define VTD_PD_LEVEL             2
+#define VTD_PT_LEVEL             1
+#define VTD_PT_ENTRY_NR          512
+#define VTD_PT_PAGE_SIZE_MASK    (1ULL << 7)
+#define VTD_PT_BASE_ADDR_MASK(aw) (~(VTD_PAGE_SIZE - 1) & VTD_HAW_MASK(aw))
+
+/* Bits to decide the offset for each level */
+#define VTD_LEVEL_BITS           9
+
 #endif
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 788ed42477..fe9057c50d 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -152,7 +152,7 @@ struct VTDIOTLBEntry {
     uint64_t gfn;
     uint16_t domain_id;
     uint32_t pasid;
-    uint64_t slpte;
+    uint64_t pte;
     uint64_t mask;
     uint8_t access_flags;
 };
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index df591419b7..46d64a38b2 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -48,7 +48,8 @@
 
 /* pe operations */
 #define VTD_PE_GET_TYPE(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_PGTT)
-#define VTD_PE_GET_LEVEL(pe) (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
+#define VTD_PE_GET_SL_LEVEL(pe) \
+    (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
 
 /*
  * PCI bus number (or SID) is not reliable since the device is usaully
@@ -284,15 +285,15 @@ static gboolean vtd_hash_remove_by_domain(gpointer key, gpointer value,
 }
 
 /* The shift of an addr for a certain level of paging structure */
-static inline uint32_t vtd_slpt_level_shift(uint32_t level)
+static inline uint32_t vtd_pt_level_shift(uint32_t level)
 {
     assert(level != 0);
-    return VTD_PAGE_SHIFT_4K + (level - 1) * VTD_SL_LEVEL_BITS;
+    return VTD_PAGE_SHIFT_4K + (level - 1) * VTD_LEVEL_BITS;
 }
 
-static inline uint64_t vtd_slpt_level_page_mask(uint32_t level)
+static inline uint64_t vtd_pt_level_page_mask(uint32_t level)
 {
-    return ~((1ULL << vtd_slpt_level_shift(level)) - 1);
+    return ~((1ULL << vtd_pt_level_shift(level)) - 1);
 }
 
 static gboolean vtd_hash_remove_by_page(gpointer key, gpointer value,
@@ -349,7 +350,7 @@ static void vtd_reset_caches(IntelIOMMUState *s)
 
 static uint64_t vtd_get_iotlb_gfn(hwaddr addr, uint32_t level)
 {
-    return (addr & vtd_slpt_level_page_mask(level)) >> VTD_PAGE_SHIFT_4K;
+    return (addr & vtd_pt_level_page_mask(level)) >> VTD_PAGE_SHIFT_4K;
 }
 
 /* Must be called with IOMMU lock held */
@@ -360,7 +361,7 @@ static VTDIOTLBEntry *vtd_lookup_iotlb(IntelIOMMUState *s, uint16_t source_id,
     VTDIOTLBEntry *entry;
     unsigned level;
 
-    for (level = VTD_SL_PT_LEVEL; level < VTD_SL_PML4_LEVEL; level++) {
+    for (level = VTD_PT_LEVEL; level < VTD_PML4_LEVEL; level++) {
         key.gfn = vtd_get_iotlb_gfn(addr, level);
         key.level = level;
         key.sid = source_id;
@@ -377,7 +378,7 @@ out:
 
 /* Must be with IOMMU lock held */
 static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
-                             uint16_t domain_id, hwaddr addr, uint64_t slpte,
+                             uint16_t domain_id, hwaddr addr, uint64_t pte,
                              uint8_t access_flags, uint32_t level,
                              uint32_t pasid)
 {
@@ -385,7 +386,7 @@ static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
     struct vtd_iotlb_key *key = g_malloc(sizeof(*key));
     uint64_t gfn = vtd_get_iotlb_gfn(addr, level);
 
-    trace_vtd_iotlb_page_update(source_id, addr, slpte, domain_id);
+    trace_vtd_iotlb_page_update(source_id, addr, pte, domain_id);
     if (g_hash_table_size(s->iotlb) >= VTD_IOTLB_MAX_SIZE) {
         trace_vtd_iotlb_reset("iotlb exceeds size limit");
         vtd_reset_iotlb_locked(s);
@@ -393,9 +394,9 @@ static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
 
     entry->gfn = gfn;
     entry->domain_id = domain_id;
-    entry->slpte = slpte;
+    entry->pte = pte;
     entry->access_flags = access_flags;
-    entry->mask = vtd_slpt_level_page_mask(level);
+    entry->mask = vtd_pt_level_page_mask(level);
     entry->pasid = pasid;
 
     key->gfn = gfn;
@@ -710,32 +711,32 @@ static inline dma_addr_t vtd_ce_get_slpt_base(VTDContextEntry *ce)
     return ce->lo & VTD_CONTEXT_ENTRY_SLPTPTR;
 }
 
-static inline uint64_t vtd_get_slpte_addr(uint64_t slpte, uint8_t aw)
+static inline uint64_t vtd_get_pte_addr(uint64_t pte, uint8_t aw)
 {
-    return slpte & VTD_SL_PT_BASE_ADDR_MASK(aw);
+    return pte & VTD_PT_BASE_ADDR_MASK(aw);
 }
 
 /* Whether the pte indicates the address of the page frame */
-static inline bool vtd_is_last_slpte(uint64_t slpte, uint32_t level)
+static inline bool vtd_is_last_pte(uint64_t pte, uint32_t level)
 {
-    return level == VTD_SL_PT_LEVEL || (slpte & VTD_SL_PT_PAGE_SIZE_MASK);
+    return level == VTD_PT_LEVEL || (pte & VTD_PT_PAGE_SIZE_MASK);
 }
 
-/* Get the content of a spte located in @base_addr[@index] */
-static uint64_t vtd_get_slpte(dma_addr_t base_addr, uint32_t index)
+/* Get the content of a pte located in @base_addr[@index] */
+static uint64_t vtd_get_pte(dma_addr_t base_addr, uint32_t index)
 {
-    uint64_t slpte;
+    uint64_t pte;
 
-    assert(index < VTD_SL_PT_ENTRY_NR);
+    assert(index < VTD_PT_ENTRY_NR);
 
     if (dma_memory_read(&address_space_memory,
-                        base_addr + index * sizeof(slpte),
-                        &slpte, sizeof(slpte), MEMTXATTRS_UNSPECIFIED)) {
-        slpte = (uint64_t)-1;
-        return slpte;
+                        base_addr + index * sizeof(pte),
+                        &pte, sizeof(pte), MEMTXATTRS_UNSPECIFIED)) {
+        pte = (uint64_t)-1;
+        return pte;
     }
-    slpte = le64_to_cpu(slpte);
-    return slpte;
+    pte = le64_to_cpu(pte);
+    return pte;
 }
 
 /* Given an iova and the level of paging structure, return the offset
@@ -743,12 +744,12 @@ static uint64_t vtd_get_slpte(dma_addr_t base_addr, uint32_t index)
  */
 static inline uint32_t vtd_iova_level_offset(uint64_t iova, uint32_t level)
 {
-    return (iova >> vtd_slpt_level_shift(level)) &
-            ((1ULL << VTD_SL_LEVEL_BITS) - 1);
+    return (iova >> vtd_pt_level_shift(level)) &
+            ((1ULL << VTD_LEVEL_BITS) - 1);
 }
 
 /* Check Capability Register to see if the @level of page-table is supported */
-static inline bool vtd_is_level_supported(IntelIOMMUState *s, uint32_t level)
+static inline bool vtd_is_sl_level_supported(IntelIOMMUState *s, uint32_t level)
 {
     return VTD_CAP_SAGAW_MASK & s->cap &
            (1ULL << (level - 2 + VTD_CAP_SAGAW_SHIFT));
@@ -833,7 +834,7 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
 
     pgtt = VTD_PE_GET_TYPE(pe);
     if (pgtt == VTD_SM_PASID_ENTRY_SLT &&
-        !vtd_is_level_supported(s, VTD_PE_GET_LEVEL(pe))) {
+        !vtd_is_sl_level_supported(s, VTD_PE_GET_SL_LEVEL(pe))) {
             return -VTD_FR_PASID_TABLE_ENTRY_INV;
     }
 
@@ -972,7 +973,7 @@ static uint32_t vtd_get_iova_level(IntelIOMMUState *s,
 
     if (s->root_scalable) {
         vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
-        return VTD_PE_GET_LEVEL(&pe);
+        return VTD_PE_GET_SL_LEVEL(&pe);
     }
 
     return vtd_ce_get_level(ce);
@@ -1040,9 +1041,9 @@ static inline uint64_t vtd_iova_limit(IntelIOMMUState *s,
 }
 
 /* Return true if IOVA passes range check, otherwise false. */
-static inline bool vtd_iova_range_check(IntelIOMMUState *s,
-                                        uint64_t iova, VTDContextEntry *ce,
-                                        uint8_t aw, uint32_t pasid)
+static inline bool vtd_iova_sl_range_check(IntelIOMMUState *s,
+                                           uint64_t iova, VTDContextEntry *ce,
+                                           uint8_t aw, uint32_t pasid)
 {
     /*
      * Check if @iova is above 2^X-1, where X is the minimum of MGAW
@@ -1083,17 +1084,17 @@ static bool vtd_slpte_nonzero_rsvd(uint64_t slpte, uint32_t level)
 
     /*
      * We should have caught a guest-mis-programmed level earlier,
-     * via vtd_is_level_supported.
+     * via vtd_is_sl_level_supported.
      */
     assert(level < VTD_SPTE_RSVD_LEN);
     /*
-     * Zero level doesn't exist. The smallest level is VTD_SL_PT_LEVEL=1 and
-     * checked by vtd_is_last_slpte().
+     * Zero level doesn't exist. The smallest level is VTD_PT_LEVEL=1 and
+     * checked by vtd_is_last_pte().
      */
     assert(level);
 
-    if ((level == VTD_SL_PD_LEVEL || level == VTD_SL_PDP_LEVEL) &&
-        (slpte & VTD_SL_PT_PAGE_SIZE_MASK)) {
+    if ((level == VTD_PD_LEVEL || level == VTD_PDP_LEVEL) &&
+        (slpte & VTD_PT_PAGE_SIZE_MASK)) {
         /* large page */
         rsvd_mask = vtd_spte_rsvd_large[level];
     } else {
@@ -1119,7 +1120,7 @@ static int vtd_iova_to_slpte(IntelIOMMUState *s, VTDContextEntry *ce,
     uint64_t access_right_check;
     uint64_t xlat, size;
 
-    if (!vtd_iova_range_check(s, iova, ce, aw_bits, pasid)) {
+    if (!vtd_iova_sl_range_check(s, iova, ce, aw_bits, pasid)) {
         error_report_once("%s: detected IOVA overflow (iova=0x%" PRIx64 ","
                           "pasid=0x%" PRIx32 ")", __func__, iova, pasid);
         return -VTD_FR_ADDR_BEYOND_MGAW;
@@ -1130,7 +1131,7 @@ static int vtd_iova_to_slpte(IntelIOMMUState *s, VTDContextEntry *ce,
 
     while (true) {
         offset = vtd_iova_level_offset(iova, level);
-        slpte = vtd_get_slpte(addr, offset);
+        slpte = vtd_get_pte(addr, offset);
 
         if (slpte == (uint64_t)-1) {
             error_report_once("%s: detected read error on DMAR slpte "
@@ -1161,17 +1162,17 @@ static int vtd_iova_to_slpte(IntelIOMMUState *s, VTDContextEntry *ce,
             return -VTD_FR_PAGING_ENTRY_RSVD;
         }
 
-        if (vtd_is_last_slpte(slpte, level)) {
+        if (vtd_is_last_pte(slpte, level)) {
             *slptep = slpte;
             *slpte_level = level;
             break;
         }
-        addr = vtd_get_slpte_addr(slpte, aw_bits);
+        addr = vtd_get_pte_addr(slpte, aw_bits);
         level--;
     }
 
-    xlat = vtd_get_slpte_addr(*slptep, aw_bits);
-    size = ~vtd_slpt_level_page_mask(level) + 1;
+    xlat = vtd_get_pte_addr(*slptep, aw_bits);
+    size = ~vtd_pt_level_page_mask(level) + 1;
 
     /*
      * From VT-d spec 3.14: Untranslated requests and translation
@@ -1322,14 +1323,14 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
 
     trace_vtd_page_walk_level(addr, level, start, end);
 
-    subpage_size = 1ULL << vtd_slpt_level_shift(level);
-    subpage_mask = vtd_slpt_level_page_mask(level);
+    subpage_size = 1ULL << vtd_pt_level_shift(level);
+    subpage_mask = vtd_pt_level_page_mask(level);
 
     while (iova < end) {
         iova_next = (iova & subpage_mask) + subpage_size;
 
         offset = vtd_iova_level_offset(iova, level);
-        slpte = vtd_get_slpte(addr, offset);
+        slpte = vtd_get_pte(addr, offset);
 
         if (slpte == (uint64_t)-1) {
             trace_vtd_page_walk_skip_read(iova, iova_next);
@@ -1352,12 +1353,12 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
          */
         entry_valid = read_cur | write_cur;
 
-        if (!vtd_is_last_slpte(slpte, level) && entry_valid) {
+        if (!vtd_is_last_pte(slpte, level) && entry_valid) {
             /*
              * This is a valid PDE (or even bigger than PDE).  We need
              * to walk one further level.
              */
-            ret = vtd_page_walk_level(vtd_get_slpte_addr(slpte, info->aw),
+            ret = vtd_page_walk_level(vtd_get_pte_addr(slpte, info->aw),
                                       iova, MIN(iova_next, end), level - 1,
                                       read_cur, write_cur, info);
         } else {
@@ -1374,7 +1375,7 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
             event.entry.perm = IOMMU_ACCESS_FLAG(read_cur, write_cur);
             event.entry.addr_mask = ~subpage_mask;
             /* NOTE: this is only meaningful if entry_valid == true */
-            event.entry.translated_addr = vtd_get_slpte_addr(slpte, info->aw);
+            event.entry.translated_addr = vtd_get_pte_addr(slpte, info->aw);
             event.type = event.entry.perm ? IOMMU_NOTIFIER_MAP :
                                             IOMMU_NOTIFIER_UNMAP;
             ret = vtd_page_walk_one(&event, info);
@@ -1408,11 +1409,11 @@ static int vtd_page_walk(IntelIOMMUState *s, VTDContextEntry *ce,
     dma_addr_t addr = vtd_get_iova_pgtbl_base(s, ce, pasid);
     uint32_t level = vtd_get_iova_level(s, ce, pasid);
 
-    if (!vtd_iova_range_check(s, start, ce, info->aw, pasid)) {
+    if (!vtd_iova_sl_range_check(s, start, ce, info->aw, pasid)) {
         return -VTD_FR_ADDR_BEYOND_MGAW;
     }
 
-    if (!vtd_iova_range_check(s, end, ce, info->aw, pasid)) {
+    if (!vtd_iova_sl_range_check(s, end, ce, info->aw, pasid)) {
         /* Fix end so that it reaches the maximum */
         end = vtd_iova_limit(s, ce, info->aw, pasid);
     }
@@ -1527,7 +1528,7 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
 
     /* Check if the programming of context-entry is valid */
     if (!s->root_scalable &&
-        !vtd_is_level_supported(s, vtd_ce_get_level(ce))) {
+        !vtd_is_sl_level_supported(s, vtd_ce_get_level(ce))) {
         error_report_once("%s: invalid context entry: hi=%"PRIx64
                           ", lo=%"PRIx64" (level %d not supported)",
                           __func__, ce->hi, ce->lo,
@@ -1897,7 +1898,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     VTDContextEntry ce;
     uint8_t bus_num = pci_bus_num(bus);
     VTDContextCacheEntry *cc_entry;
-    uint64_t slpte, page_mask;
+    uint64_t pte, page_mask;
     uint32_t level, pasid = vtd_as->pasid;
     uint16_t source_id = PCI_BUILD_BDF(bus_num, devfn);
     int ret_fr;
@@ -1918,13 +1919,13 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
 
     cc_entry = &vtd_as->context_cache_entry;
 
-    /* Try to fetch slpte form IOTLB, we don't need RID2PASID logic */
+    /* Try to fetch pte form IOTLB, we don't need RID2PASID logic */
     if (!rid2pasid) {
         iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
         if (iotlb_entry) {
-            trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->slpte,
+            trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->pte,
                                      iotlb_entry->domain_id);
-            slpte = iotlb_entry->slpte;
+            pte = iotlb_entry->pte;
             access_flags = iotlb_entry->access_flags;
             page_mask = iotlb_entry->mask;
             goto out;
@@ -1996,20 +1997,20 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
         return true;
     }
 
-    /* Try to fetch slpte form IOTLB for RID2PASID slow path */
+    /* Try to fetch pte form IOTLB for RID2PASID slow path */
     if (rid2pasid) {
         iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
         if (iotlb_entry) {
-            trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->slpte,
+            trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->pte,
                                      iotlb_entry->domain_id);
-            slpte = iotlb_entry->slpte;
+            pte = iotlb_entry->pte;
             access_flags = iotlb_entry->access_flags;
             page_mask = iotlb_entry->mask;
             goto out;
         }
     }
 
-    ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &slpte, &level,
+    ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &pte, &level,
                                &reads, &writes, s->aw_bits, pasid);
     if (ret_fr) {
         vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
@@ -2017,14 +2018,14 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
         goto error;
     }
 
-    page_mask = vtd_slpt_level_page_mask(level);
+    page_mask = vtd_pt_level_page_mask(level);
     access_flags = IOMMU_ACCESS_FLAG(reads, writes);
     vtd_update_iotlb(s, source_id, vtd_get_domain_id(s, &ce, pasid),
-                     addr, slpte, access_flags, level, pasid);
+                     addr, pte, access_flags, level, pasid);
 out:
     vtd_iommu_unlock(s);
     entry->iova = addr & page_mask;
-    entry->translated_addr = vtd_get_slpte_addr(slpte, s->aw_bits) & page_mask;
+    entry->translated_addr = vtd_get_pte_addr(pte, s->aw_bits) & page_mask;
     entry->addr_mask = ~page_mask;
     entry->perm = access_flags;
     return true;
-- 
2.34.1


