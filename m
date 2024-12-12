Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05D9E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 08:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLelU-0004br-CF; Thu, 12 Dec 2024 03:41:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tLelS-0004Vn-Mb
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:41:42 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tLelQ-0007zv-Dx
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733992900; x=1765528900;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OzAwnHnB7T+weBmUtGAXh7/K6XuyAKA5urrB93trCBc=;
 b=fZCXnJaZE4kvzAvNt8a3tKdkZIonhP00ZEKIb89JkukqJNvMu9l03ibV
 Poaz/Wwh6z19v392V0ImGkRi+W6BAIC2ZogqORP6Owt8ixqdnTKRKDP/C
 WOKBY6cG/XE6WmnNnsP9xmLHde+1IzZXGC8o7gbTB4FFfQtw/H1IRytq4
 DDQCKRGZpDc5LvPl5LnxT35Of3GkOPhkvFxA/x94BnkVYhmDj1IPiQQHZ
 DkCv96hQ6DYWZqCNUxZrxF/LfI985xY7Qd7S7+GvMPdR15HBfnxJoBtYw
 ymx8cxMJb1egIg6KrqISD2NzGJ6KHh/4astLvMsZkbcBhow+ieG83mfb/ g==;
X-CSE-ConnectionGUID: cvTJX3xWQsOwg6atDO/BfQ==
X-CSE-MsgGUID: MeR9ncK/SIW9D84ncmJ6uA==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34124844"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; d="scan'208";a="34124844"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 00:41:40 -0800
X-CSE-ConnectionGUID: D2QKmrpqQQi8wQg6FkD7Zg==
X-CSE-MsgGUID: JVSMw3QqRNqUzLpP602G5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119407016"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 00:41:35 -0800
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
Subject: [PATCH v6 06/20] intel_iommu: Implement stage-1 translation
Date: Thu, 12 Dec 2024 16:37:43 +0800
Message-Id: <20241212083757.605022-7-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212083757.605022-1-zhenzhong.duan@intel.com>
References: <20241212083757.605022-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This adds stage-1 page table walking to support stage-1 only
translation in scalable mode.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Co-developed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 hw/i386/intel_iommu_internal.h |  34 +++++++
 hw/i386/intel_iommu.c          | 158 ++++++++++++++++++++++++++++++++-
 2 files changed, 188 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index e810b0071f..86d3354198 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -320,6 +320,15 @@ typedef enum VTDFaultReason {
     VTD_FR_PASID_ENTRY_P = 0x59,
     VTD_FR_PASID_TABLE_ENTRY_INV = 0x5b,  /*Invalid PASID table entry */
 
+    /* Fail to access a first-level paging entry (not FS_PML4E) */
+    VTD_FR_FS_PAGING_ENTRY_INV = 0x70,
+    VTD_FR_FS_PAGING_ENTRY_P = 0x71,
+    /* Non-zero reserved field in present first-stage paging entry */
+    VTD_FR_FS_PAGING_ENTRY_RSVD = 0x72,
+    VTD_FR_PASID_ENTRY_FSPTPTR_INV = 0x73, /* Invalid FSPTPTR in PASID entry */
+    VTD_FR_FS_PAGING_ENTRY_US = 0x81,      /* Privilege violation */
+    VTD_FR_SM_WRITE = 0x85,                /* No write permission */
+
     /* Output address in the interrupt address range for scalable mode */
     VTD_FR_SM_INTERRUPT_ADDR = 0x87,
     VTD_FR_MAX,                 /* Guard */
@@ -438,6 +447,22 @@ typedef union VTDInvDesc VTDInvDesc;
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
@@ -530,6 +555,15 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
 #define VTD_SM_PASID_ENTRY_DID(val)    ((val) & VTD_DOMAIN_ID_MASK)
 
+#define VTD_SM_PASID_ENTRY_FLPM          3ULL
+#define VTD_SM_PASID_ENTRY_FLPTPTR       (~0xfffULL)
+
+/* First Level Paging Structure */
+/* Masks for First Level Paging Entry */
+#define VTD_FL_P                    1ULL
+#define VTD_FL_RW                   (1ULL << 1)
+#define VTD_FL_US                   (1ULL << 2)
+
 /* Second Level Page Translation Pointer*/
 #define VTD_SM_PASID_ENTRY_SLPTPTR     (~0xfffULL)
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index e32c61c7dc..dbfd48fb65 100644
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
+        if (s->flts) {
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
+        if (s->flts) {
+            return pe.val[2] & VTD_SM_PASID_ENTRY_FLPTPTR;
+        } else {
+            return pe.val[0] & VTD_SM_PASID_ENTRY_SLPTPTR;
+        }
     }
 
     return vtd_ce_get_slpt_base(ce);
@@ -1800,6 +1820,12 @@ static const bool vtd_qualified_faults[] = {
     [VTD_FR_PASID_TABLE_ACCESS_ERR] = false,
     [VTD_FR_PASID_ENTRY_P] = true,
     [VTD_FR_PASID_TABLE_ENTRY_INV] = true,
+    [VTD_FR_FS_PAGING_ENTRY_INV] = true,
+    [VTD_FR_FS_PAGING_ENTRY_P] = true,
+    [VTD_FR_FS_PAGING_ENTRY_RSVD] = true,
+    [VTD_FR_PASID_ENTRY_FSPTPTR_INV] = true,
+    [VTD_FR_FS_PAGING_ENTRY_US] = true,
+    [VTD_FR_SM_WRITE] = true,
     [VTD_FR_SM_INTERRUPT_ADDR] = true,
     [VTD_FR_MAX] = false,
 };
@@ -1862,6 +1888,113 @@ out:
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
+                /* Invalid programming of pasid-entry */
+                return -VTD_FR_PASID_ENTRY_FSPTPTR_INV;
+            } else {
+                return -VTD_FR_FS_PAGING_ENTRY_INV;
+            }
+        }
+
+        if (!vtd_flpte_present(flpte)) {
+            *reads = false;
+            *writes = false;
+            return -VTD_FR_FS_PAGING_ENTRY_P;
+        }
+
+        /* No emulated device supports supervisor privilege request yet */
+        if (!(flpte & VTD_FL_US)) {
+            *reads = false;
+            *writes = false;
+            return -VTD_FR_FS_PAGING_ENTRY_US;
+        }
+
+        *reads = true;
+        *writes = (*writes) && (flpte & VTD_FL_RW);
+        if (is_write && !(flpte & VTD_FL_RW)) {
+            return -VTD_FR_SM_WRITE;
+        }
+        if (vtd_flpte_nonzero_rsvd(flpte, level)) {
+            error_report_once("%s: detected flpte reserved non-zero "
+                              "iova=0x%" PRIx64 ", level=0x%" PRIx32
+                              "flpte=0x%" PRIx64 ", pasid=0x%" PRIX32 ")",
+                              __func__, iova, level, flpte, pasid);
+            return -VTD_FR_FS_PAGING_ENTRY_RSVD;
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
@@ -2010,8 +2143,13 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
         }
     }
 
-    ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &pte, &level,
-                               &reads, &writes, s->aw_bits, pasid);
+    if (s->flts && s->root_scalable) {
+        ret_fr = vtd_iova_to_flpte(s, &ce, addr, is_write, &pte, &level,
+                                   &reads, &writes, s->aw_bits, pasid);
+    } else {
+        ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &pte, &level,
+                                   &reads, &writes, s->aw_bits, pasid);
+    }
     if (ret_fr) {
         vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
                          addr, is_write, pasid != PCI_NO_PASID, pasid);
@@ -4287,6 +4425,18 @@ static void vtd_init(IntelIOMMUState *s)
     vtd_spte_rsvd_large[3] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits,
                                         x86_iommu->dt_supported && s->stale_tm);
 
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


