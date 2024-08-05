Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA81C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 06:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sarFM-0002uD-Ef; Mon, 05 Aug 2024 02:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sarF5-0002n7-8M
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 02:30:57 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sarEr-00029G-63
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 02:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722839437; x=1754375437;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZMD1nZYXnxUStb0fZkTlvaJ3hXuOvSHu+K3/+x7BoH8=;
 b=eETMDC4J5XyQciKp4YmTQfk9/x6gX8YorDY548ovldlHSO/VeRoYtAD4
 DDWuvLlCffcuNxP6WMfp0B05FHe7e8GcewDHNT0hpF7XegWDBufAxEKTh
 dgBDPaodsG1CV+Oq03q0i4TY/IQ2K3Dvk9T7S7yYDc+twfqGUcLTRe2DQ
 dF7ojD3SLGaHQadTHNls5KMm0PigxNGnIvCSR/4HsrCjLSgVe1aYqszFm
 JCCNy4ASnOBhbOQcBqeBS/JDdyAF3cOI2A93vH0NKziRWMfyIHr2Kmu45
 UwCsDU4VRXFDgGI9SZ2qQ//iW/0jJOpyOe3FA4OFAfnKPrihpuUUU4J0n g==;
X-CSE-ConnectionGUID: 8LLwEKhtQgmvpb2R/m02/Q==
X-CSE-MsgGUID: WMW2Va4RR7W50tbm8j4TKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="38282716"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; d="scan'208";a="38282716"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2024 23:30:36 -0700
X-CSE-ConnectionGUID: HpS6XagMTRCC9ybZLq/9nw==
X-CSE-MsgGUID: pB672pTLTxWvcTTZlui/lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; d="scan'208";a="56786724"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2024 23:30:31 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 06/17] intel_iommu: Implement stage-1 translation
Date: Mon,  5 Aug 2024 14:27:16 +0800
Message-Id: <20240805062727.2307552-7-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
transltion in scalable modern mode.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Co-developed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  23 ++++++
 hw/i386/intel_iommu.c          | 146 ++++++++++++++++++++++++++++++++-
 2 files changed, 165 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 1fa4add9e2..51e9b1fc43 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -433,6 +433,21 @@ typedef union VTDInvDesc VTDInvDesc;
         (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
         (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 
+/* Rsvd field masks for fpte */
+#define VTD_FS_UPPER_IGNORED 0xfff0000000000000ULL
+#define VTD_FPTE_PAGE_L1_RSVD_MASK(aw) \
+        (~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
+#define VTD_FPTE_PAGE_L2_RSVD_MASK(aw) \
+        (~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
+#define VTD_FPTE_PAGE_L3_RSVD_MASK(aw) \
+        (~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
+#define VTD_FPTE_PAGE_L3_FS1GP_RSVD_MASK(aw) \
+        (0x3fffe000ULL | ~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
+#define VTD_FPTE_PAGE_L2_FS2MP_RSVD_MASK(aw) \
+        (0x1fe000ULL | ~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
+#define VTD_FPTE_PAGE_L4_RSVD_MASK(aw) \
+        (0x80ULL | ~(VTD_HAW_MASK(aw) | VTD_FS_UPPER_IGNORED))
+
 /* Masks for PIOTLB Invalidate Descriptor */
 #define VTD_INV_DESC_PIOTLB_G             (3ULL << 4)
 #define VTD_INV_DESC_PIOTLB_ALL_IN_PASID  (2ULL << 4)
@@ -525,6 +540,14 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
 #define VTD_SM_PASID_ENTRY_DID(val)    ((val) & VTD_DOMAIN_ID_MASK)
 
+#define VTD_SM_PASID_ENTRY_FLPM          3ULL
+#define VTD_SM_PASID_ENTRY_FLPTPTR       (~0xfffULL)
+
+/* First Level Paging Structure */
+/* Masks for First Level Paging Entry */
+#define VTD_FL_P                    1ULL
+#define VTD_FL_RW_MASK              (1ULL << 1)
+
 /* Second Level Page Translation Pointer*/
 #define VTD_SM_PASID_ENTRY_SLPTPTR     (~0xfffULL)
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 46d64a38b2..0bcbd5b777 100644
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
+    assert(level < VTD_SPTE_RSVD_LEN);
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
+        *writes = (*writes) && (flpte & VTD_FL_RW_MASK);
+        if (is_write && !(flpte & VTD_FL_RW_MASK)) {
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
@@ -4239,6 +4362,21 @@ static void vtd_init(IntelIOMMUState *s)
     vtd_spte_rsvd_large[3] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits,
                                                     x86_iommu->dt_supported);
 
+    /*
+     * Rsvd field masks for fpte
+     */
+    vtd_fpte_rsvd[0] = ~0ULL;
+    vtd_fpte_rsvd[1] = VTD_FPTE_PAGE_L1_RSVD_MASK(s->aw_bits);
+    vtd_fpte_rsvd[2] = VTD_FPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
+    vtd_fpte_rsvd[3] = VTD_FPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
+    vtd_fpte_rsvd[4] = VTD_FPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
+
+    vtd_fpte_rsvd_large[0] = ~0ULL;
+    vtd_fpte_rsvd_large[1] = ~0ULL;
+    vtd_fpte_rsvd_large[2] = VTD_FPTE_PAGE_L2_FS2MP_RSVD_MASK(s->aw_bits);
+    vtd_fpte_rsvd_large[3] = VTD_FPTE_PAGE_L3_FS1GP_RSVD_MASK(s->aw_bits);
+    vtd_fpte_rsvd_large[4] = ~0ULL;
+
     if (s->scalable_mode || s->snoop_control) {
         vtd_spte_rsvd[1] &= ~VTD_SPTE_SNP;
         vtd_spte_rsvd_large[2] &= ~VTD_SPTE_SNP;
-- 
2.34.1


