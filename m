Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A204CF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 09:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svCjQ-0000VQ-Fz; Mon, 30 Sep 2024 05:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1svCjK-00008h-OR
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:30:10 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1svCjI-0006o0-Fq
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727688608; x=1759224608;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PoaUB1lja7a3IOrNyq+mIsxqdd4MUfBZ9vlCrc+P2xA=;
 b=KztbMar/DNOnzo+fnfItM0DeeO4iNjyK2ZoilwTbFiZv8jQ2gYYq04E2
 SeXyyycOmKrDDsKayRFHLmD7g1ysLnLUOxHHfDvw57qd+Olo0U7NSt5Oz
 qIlcuDsglvpRTL+IfKxisx/kipziR1c7O3SQ/9qnoxWU4k2AAdbTtzGEx
 oX/Yvvsjrs4DUijNYG+PYOIbHcKO6s+RvZXCwZSJ18oJ6ls4+OMZ15j1R
 RNLbQJ3fUChe+mtDn0sPUg5/RC2RuCO4T2pFex1653alEwdyVy00VpGY2
 kuYbBuAH+wb6LocPdBIp/pri7nnPcckDCbrQ7DYA74h8S036iZs0EVqLJ Q==;
X-CSE-ConnectionGUID: nYRjBgHNSXiiWy/bUJJfCg==
X-CSE-MsgGUID: Ln50ZSqLRjGX/3+QkwF5gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26721744"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; d="scan'208";a="26721744"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2024 02:30:07 -0700
X-CSE-ConnectionGUID: 0eE3hrHkQsaAqllrJVMV0A==
X-CSE-MsgGUID: GfpxLqBgQH6EMzq5BSXK7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; d="scan'208";a="77749598"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2024 02:30:00 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v4 06/17] intel_iommu: Implement stage-1 translation
Date: Mon, 30 Sep 2024 17:26:20 +0800
Message-Id: <20240930092631.2997543-7-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Yi Liu <yi.l.liu@intel.com>

This adds stage-1 page table walking to support stage-1 only
translation in scalable modern mode.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Co-developed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 hw/i386/intel_iommu_internal.h |  24 ++++++
 hw/i386/intel_iommu.c          | 143 ++++++++++++++++++++++++++++++++-
 2 files changed, 163 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 20fcc73938..38bf0c7a06 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -428,6 +428,22 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw) \
         (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 
+/* Rsvd field masks for fpte */
+#define VTD_FS_UPPER_IGNORED 0xfff0000000000000ULL
+#define VTD_FPTE_PAGE_L1_RSVD_MASK(aw) \
+        (~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
+#define VTD_FPTE_PAGE_L2_RSVD_MASK(aw) \
+        (~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
+#define VTD_FPTE_PAGE_L3_RSVD_MASK(aw) \
+        (~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
+#define VTD_FPTE_PAGE_L4_RSVD_MASK(aw) \
+        (0x80ULL | ~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
+
+#define VTD_FPTE_LPAGE_L2_RSVD_MASK(aw) \
+        (0x1fe000ULL | ~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
+#define VTD_FPTE_LPAGE_L3_RSVD_MASK(aw) \
+        (0x3fffe000ULL | ~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
+
 /* Masks for PIOTLB Invalidate Descriptor */
 #define VTD_INV_DESC_PIOTLB_G             (3ULL << 4)
 #define VTD_INV_DESC_PIOTLB_ALL_IN_PASID  (2ULL << 4)
@@ -520,6 +536,14 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
 #define VTD_SM_PASID_ENTRY_DID(val)    ((val) & VTD_DOMAIN_ID_MASK)
 
+#define VTD_SM_PASID_ENTRY_FLPM          3ULL
+#define VTD_SM_PASID_ENTRY_FLPTPTR       (~0xfffULL)
+
+/* First Level Paging Structure */
+/* Masks for First Level Paging Entry */
+#define VTD_FL_P                    1ULL
+#define VTD_FL_RW                   (1ULL << 1)
+
 /* Second Level Page Translation Pointer*/
 #define VTD_SM_PASID_ENTRY_SLPTPTR     (~0xfffULL)
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 6f2414898c..56d5933e93 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -48,6 +48,8 @@
 
 /* pe operations */
 #define VTD_PE_GET_TYPE(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_PGTT)
+#define VTD_PE_GET_FL_LEVEL(pe) \
+    (4 + (((pe)->val[2] >> 2) & VTD_SM_PASID_ENTRY_FLPM))
 #define VTD_PE_GET_SL_LEVEL(pe) \
     (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
 
@@ -755,6 +757,11 @@ static inline bool vtd_is_sl_level_supported(IntelIOMMUState *s, uint32_t level)
            (1ULL << (level - 2 + VTD_CAP_SAGAW_SHIFT));
 }
 
+static inline bool vtd_is_fl_level_supported(IntelIOMMUState *s, uint32_t level)
+{
+    return level == VTD_PML4_LEVEL;
+}
+
 /* Return true if check passed, otherwise false */
 static inline bool vtd_pe_type_check(X86IOMMUState *x86_iommu,
                                      VTDPASIDEntry *pe)
@@ -838,6 +845,11 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
             return -VTD_FR_PASID_TABLE_ENTRY_INV;
     }
 
+    if (pgtt == VTD_SM_PASID_ENTRY_FLT &&
+        !vtd_is_fl_level_supported(s, VTD_PE_GET_FL_LEVEL(pe))) {
+            return -VTD_FR_PASID_TABLE_ENTRY_INV;
+    }
+
     return 0;
 }
 
@@ -973,7 +985,11 @@ static uint32_t vtd_get_iova_level(IntelIOMMUState *s,
 
     if (s->root_scalable) {
         vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
-        return VTD_PE_GET_SL_LEVEL(&pe);
+        if (s->scalable_modern) {
+            return VTD_PE_GET_FL_LEVEL(&pe);
+        } else {
+            return VTD_PE_GET_SL_LEVEL(&pe);
+        }
     }
 
     return vtd_ce_get_level(ce);
@@ -1060,7 +1076,11 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
 
     if (s->root_scalable) {
         vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
-        return pe.val[0] & VTD_SM_PASID_ENTRY_SLPTPTR;
+        if (s->scalable_modern) {
+            return pe.val[2] & VTD_SM_PASID_ENTRY_FLPTPTR;
+        } else {
+            return pe.val[0] & VTD_SM_PASID_ENTRY_SLPTPTR;
+        }
     }
 
     return vtd_ce_get_slpt_base(ce);
@@ -1862,6 +1882,104 @@ out:
     trace_vtd_pt_enable_fast_path(source_id, success);
 }
 
+/*
+ * Rsvd field masks for fpte:
+ *     vtd_fpte_rsvd 4k pages
+ *     vtd_fpte_rsvd_large large pages
+ *
+ * We support only 4-level page tables.
+ */
+#define VTD_FPTE_RSVD_LEN 5
+static uint64_t vtd_fpte_rsvd[VTD_FPTE_RSVD_LEN];
+static uint64_t vtd_fpte_rsvd_large[VTD_FPTE_RSVD_LEN];
+
+static bool vtd_flpte_nonzero_rsvd(uint64_t flpte, uint32_t level)
+{
+    uint64_t rsvd_mask;
+
+    /*
+     * We should have caught a guest-mis-programmed level earlier,
+     * via vtd_is_fl_level_supported.
+     */
+    assert(level < VTD_FPTE_RSVD_LEN);
+    /*
+     * Zero level doesn't exist. The smallest level is VTD_PT_LEVEL=1 and
+     * checked by vtd_is_last_pte().
+     */
+    assert(level);
+
+    if ((level == VTD_PD_LEVEL || level == VTD_PDP_LEVEL) &&
+        (flpte & VTD_PT_PAGE_SIZE_MASK)) {
+        /* large page */
+        rsvd_mask = vtd_fpte_rsvd_large[level];
+    } else {
+        rsvd_mask = vtd_fpte_rsvd[level];
+    }
+
+    return flpte & rsvd_mask;
+}
+
+static inline bool vtd_flpte_present(uint64_t flpte)
+{
+    return !!(flpte & VTD_FL_P);
+}
+
+/*
+ * Given the @iova, get relevant @flptep. @flpte_level will be the last level
+ * of the translation, can be used for deciding the size of large page.
+ */
+static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
+                             uint64_t iova, bool is_write,
+                             uint64_t *flptep, uint32_t *flpte_level,
+                             bool *reads, bool *writes, uint8_t aw_bits,
+                             uint32_t pasid)
+{
+    dma_addr_t addr = vtd_get_iova_pgtbl_base(s, ce, pasid);
+    uint32_t level = vtd_get_iova_level(s, ce, pasid);
+    uint32_t offset;
+    uint64_t flpte;
+
+    while (true) {
+        offset = vtd_iova_level_offset(iova, level);
+        flpte = vtd_get_pte(addr, offset);
+
+        if (flpte == (uint64_t)-1) {
+            if (level == vtd_get_iova_level(s, ce, pasid)) {
+                /* Invalid programming of context-entry */
+                return -VTD_FR_CONTEXT_ENTRY_INV;
+            } else {
+                return -VTD_FR_PAGING_ENTRY_INV;
+            }
+        }
+        if (!vtd_flpte_present(flpte)) {
+            *reads = false;
+            *writes = false;
+            return -VTD_FR_PAGING_ENTRY_INV;
+        }
+        *reads = true;
+        *writes = (*writes) && (flpte & VTD_FL_RW);
+        if (is_write && !(flpte & VTD_FL_RW)) {
+            return -VTD_FR_WRITE;
+        }
+        if (vtd_flpte_nonzero_rsvd(flpte, level)) {
+            error_report_once("%s: detected flpte reserved non-zero "
+                              "iova=0x%" PRIx64 ", level=0x%" PRIx32
+                              "flpte=0x%" PRIx64 ", pasid=0x%" PRIX32 ")",
+                              __func__, iova, level, flpte, pasid);
+            return -VTD_FR_PAGING_ENTRY_RSVD;
+        }
+
+        if (vtd_is_last_pte(flpte, level)) {
+            *flptep = flpte;
+            *flpte_level = level;
+            return 0;
+        }
+
+        addr = vtd_get_pte_addr(flpte, aw_bits);
+        level--;
+    }
+}
+
 static void vtd_report_fault(IntelIOMMUState *s,
                              int err, bool is_fpd_set,
                              uint16_t source_id,
@@ -2010,8 +2128,13 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
         }
     }
 
-    ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &pte, &level,
-                               &reads, &writes, s->aw_bits, pasid);
+    if (s->scalable_modern && s->root_scalable) {
+        ret_fr = vtd_iova_to_flpte(s, &ce, addr, is_write, &pte, &level,
+                                   &reads, &writes, s->aw_bits, pasid);
+    } else {
+        ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &pte, &level,
+                                   &reads, &writes, s->aw_bits, pasid);
+    }
     if (ret_fr) {
         vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
                          addr, is_write, pasid != PCI_NO_PASID, pasid);
@@ -4239,6 +4362,18 @@ static void vtd_init(IntelIOMMUState *s)
     vtd_spte_rsvd_large[2] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits);
     vtd_spte_rsvd_large[3] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits);
 
+    /*
+     * Rsvd field masks for fpte
+     */
+    vtd_fpte_rsvd[0] = ~0ULL;
+    vtd_fpte_rsvd[1] = VTD_FPTE_PAGE_L1_RSVD_MASK(s->aw_bits);
+    vtd_fpte_rsvd[2] = VTD_FPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
+    vtd_fpte_rsvd[3] = VTD_FPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
+    vtd_fpte_rsvd[4] = VTD_FPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
+
+    vtd_fpte_rsvd_large[2] = VTD_FPTE_LPAGE_L2_RSVD_MASK(s->aw_bits);
+    vtd_fpte_rsvd_large[3] = VTD_FPTE_LPAGE_L3_RSVD_MASK(s->aw_bits);
+
     if (s->scalable_mode || s->snoop_control) {
         vtd_spte_rsvd[1] &= ~VTD_SPTE_SNP;
         vtd_spte_rsvd_large[2] &= ~VTD_SPTE_SNP;
-- 
2.34.1


