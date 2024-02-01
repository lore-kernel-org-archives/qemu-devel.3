Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6ABC47DDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 07:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVRYH-0007UM-H7; Thu, 01 Feb 2024 02:32:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRYA-0006qI-KO
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:31:58 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRY4-0001lf-Lv
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:31:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706772708; x=1738308708;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BrGr1sksyixCvlwpq+tJwUA82IYeGZtvh6mz2FrbZg4=;
 b=bHAODC7OXgSG5t88frW7ahNNldIaqWbWuyfQD9zWDhFTGEXEoItZ0xBB
 PDLJy+iszW0l6426UufwygJNFq0Wk210q3XW7lI0TrpuLYM8qH7hDWQLT
 JjNqGCjFrY6HOoIeSavxinjo/2HhDqwT5ngQSLm+2oZ52gICEiJ7Rt+0s
 dcApCZImgw8m0LKsou8E74DsWB2LHgw3SkFCdLdwiejm8ceGNTWHvzy1Y
 J0mHSEBVOd0CU5O+o78NjpJTuNH6OXC/v8vnYHTGZxMc+cpprbADOnWel
 RGnUD6XIXb2Dl1FCUymJb0n5z4AGFnr+5u+wvI/nHbWsO/t4I1Gm7JVEW Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="402676996"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; d="scan'208";a="402676996"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:31:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4443418"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:31:40 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH rfcv2 17/18] intel_iommu: Use mgaw instead of s->aw_bits
Date: Thu,  1 Feb 2024 15:28:17 +0800
Message-Id: <20240201072818.327930-18-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201072818.327930-1-zhenzhong.duan@intel.com>
References: <20240201072818.327930-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Because vIOMMU mgaw can be updated based on host IOMMU mgaw, s->aw_bits
does't necessarily represent the final mgaw now but the mgaw field in
s->cap does.

Replace reference to s->aw_bits with a MACRO S_AW_BITS to fetch mgaw
from s->cap. There are two exceptions on this, aw_bits value sanity
check and s->cap initialization.

ACPI DMAR table is also updated with right mgaw value.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/acpi-build.c  |  3 ++-
 hw/i386/intel_iommu.c | 44 ++++++++++++++++++++++---------------------
 2 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index edc979379c..6467157686 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2159,7 +2159,8 @@ build_dmar_q35(GArray *table_data, BIOSLinker *linker, const char *oem_id,
 
     acpi_table_begin(&table, table_data);
     /* Host Address Width */
-    build_append_int_noprefix(table_data, intel_iommu->aw_bits - 1, 1);
+    build_append_int_noprefix(table_data,
+                              VTD_MGAW_FROM_CAP(intel_iommu->cap), 1);
     build_append_int_noprefix(table_data, dmar_flags, 1); /* Flags */
     g_array_append_vals(table_data, rsvd10, sizeof(rsvd10)); /* Reserved */
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 409f8a59c3..72cc8b2c71 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -41,6 +41,8 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 
+#define S_AW_BITS (VTD_MGAW_FROM_CAP(s->cap) + 1)
+
 /* context entry operations */
 #define VTD_CE_GET_RID2PASID(ce) \
     ((ce)->val[1] & VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK)
@@ -1409,13 +1411,13 @@ static int vtd_root_entry_rsvd_bits_check(IntelIOMMUState *s,
 {
     /* Legacy Mode reserved bits check */
     if (!s->root_scalable &&
-        (re->hi || (re->lo & VTD_ROOT_ENTRY_RSVD(s->aw_bits))))
+        (re->hi || (re->lo & VTD_ROOT_ENTRY_RSVD(S_AW_BITS))))
         goto rsvd_err;
 
     /* Scalable Mode reserved bits check */
     if (s->root_scalable &&
-        ((re->lo & VTD_ROOT_ENTRY_RSVD(s->aw_bits)) ||
-         (re->hi & VTD_ROOT_ENTRY_RSVD(s->aw_bits))))
+        ((re->lo & VTD_ROOT_ENTRY_RSVD(S_AW_BITS)) ||
+         (re->hi & VTD_ROOT_ENTRY_RSVD(S_AW_BITS))))
         goto rsvd_err;
 
     return 0;
@@ -1432,7 +1434,7 @@ static inline int vtd_context_entry_rsvd_bits_check(IntelIOMMUState *s,
 {
     if (!s->root_scalable &&
         (ce->hi & VTD_CONTEXT_ENTRY_RSVD_HI ||
-         ce->lo & VTD_CONTEXT_ENTRY_RSVD_LO(s->aw_bits))) {
+         ce->lo & VTD_CONTEXT_ENTRY_RSVD_LO(S_AW_BITS))) {
         error_report_once("%s: invalid context entry: hi=%"PRIx64
                           ", lo=%"PRIx64" (reserved nonzero)",
                           __func__, ce->hi, ce->lo);
@@ -1440,7 +1442,7 @@ static inline int vtd_context_entry_rsvd_bits_check(IntelIOMMUState *s,
     }
 
     if (s->root_scalable &&
-        (ce->val[0] & VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(s->aw_bits) ||
+        (ce->val[0] & VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(S_AW_BITS) ||
          ce->val[1] & VTD_SM_CONTEXT_ENTRY_RSVD_VAL1 ||
          ce->val[2] ||
          ce->val[3])) {
@@ -1571,7 +1573,7 @@ static int vtd_sync_shadow_page_table_range(VTDAddressSpace *vtd_as,
         .hook_fn = vtd_sync_shadow_page_hook,
         .private = (void *)&vtd_as->iommu,
         .notify_unmap = true,
-        .aw = s->aw_bits,
+        .aw = S_AW_BITS,
         .as = vtd_as,
         .domain_id = vtd_get_domain_id(s, ce, vtd_as->pasid),
     };
@@ -1990,7 +1992,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     }
 
     ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &slpte, &level,
-                               &reads, &writes, s->aw_bits, pasid);
+                               &reads, &writes, S_AW_BITS, pasid);
     if (ret_fr) {
         vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
                          addr, is_write, pasid != PCI_NO_PASID, pasid);
@@ -2004,7 +2006,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
 out:
     vtd_iommu_unlock(s);
     entry->iova = addr & page_mask;
-    entry->translated_addr = vtd_get_slpte_addr(slpte, s->aw_bits) & page_mask;
+    entry->translated_addr = vtd_get_slpte_addr(slpte, S_AW_BITS) & page_mask;
     entry->addr_mask = ~page_mask;
     entry->perm = access_flags;
     return true;
@@ -2021,7 +2023,7 @@ error:
 static void vtd_root_table_setup(IntelIOMMUState *s)
 {
     s->root = vtd_get_quad_raw(s, DMAR_RTADDR_REG);
-    s->root &= VTD_RTADDR_ADDR_MASK(s->aw_bits);
+    s->root &= VTD_RTADDR_ADDR_MASK(S_AW_BITS);
 
     vtd_update_scalable_state(s);
 
@@ -2039,7 +2041,7 @@ static void vtd_interrupt_remap_table_setup(IntelIOMMUState *s)
     uint64_t value = 0;
     value = vtd_get_quad_raw(s, DMAR_IRTA_REG);
     s->intr_size = 1UL << ((value & VTD_IRTA_SIZE_MASK) + 1);
-    s->intr_root = value & VTD_IRTA_ADDR_MASK(s->aw_bits);
+    s->intr_root = value & VTD_IRTA_ADDR_MASK(S_AW_BITS);
     s->intr_eime = value & VTD_IRTA_EIME;
 
     /* Notify global invalidation */
@@ -2322,7 +2324,7 @@ static void vtd_handle_gcmd_qie(IntelIOMMUState *s, bool en)
     trace_vtd_inv_qi_enable(en);
 
     if (en) {
-        s->iq = iqa_val & VTD_IQA_IQA_MASK(s->aw_bits);
+        s->iq = iqa_val & VTD_IQA_IQA_MASK(S_AW_BITS);
         /* 2^(x+8) entries */
         s->iq_size = 1UL << ((iqa_val & VTD_IQA_QS) + 8 - (s->iq_dw ? 1 : 0));
         s->qi_enabled = true;
@@ -3958,12 +3960,12 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
      * VT-d spec), otherwise we need to consider overflow of 64 bits.
      */
 
-    if (end > VTD_ADDRESS_SIZE(s->aw_bits) - 1) {
+    if (end > VTD_ADDRESS_SIZE(S_AW_BITS) - 1) {
         /*
          * Don't need to unmap regions that is bigger than the whole
          * VT-d supported address space size
          */
-        end = VTD_ADDRESS_SIZE(s->aw_bits) - 1;
+        end = VTD_ADDRESS_SIZE(S_AW_BITS) - 1;
     }
 
     assert(start <= end);
@@ -3971,7 +3973,7 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
 
     while (remain >= VTD_PAGE_SIZE) {
         IOMMUTLBEvent event;
-        uint64_t mask = dma_aligned_pow2_mask(start, end, s->aw_bits);
+        uint64_t mask = dma_aligned_pow2_mask(start, end, S_AW_BITS);
         uint64_t size = mask + 1;
 
         assert(size);
@@ -4050,7 +4052,7 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
                 .hook_fn = vtd_replay_hook,
                 .private = (void *)n,
                 .notify_unmap = false,
-                .aw = s->aw_bits,
+                .aw = S_AW_BITS,
                 .as = vtd_as,
                 .domain_id = vtd_get_domain_id(s, &ce, vtd_as->pasid),
             };
@@ -4153,15 +4155,15 @@ static void vtd_init(IntelIOMMUState *s)
      * Rsvd field masks for spte
      */
     vtd_spte_rsvd[0] = ~0ULL;
-    vtd_spte_rsvd[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits,
+    vtd_spte_rsvd[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(S_AW_BITS,
                                                   x86_iommu->dt_supported);
-    vtd_spte_rsvd[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
-    vtd_spte_rsvd[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
-    vtd_spte_rsvd[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
+    vtd_spte_rsvd[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(S_AW_BITS);
+    vtd_spte_rsvd[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(S_AW_BITS);
+    vtd_spte_rsvd[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(S_AW_BITS);
 
-    vtd_spte_rsvd_large[2] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits,
+    vtd_spte_rsvd_large[2] = VTD_SPTE_LPAGE_L2_RSVD_MASK(S_AW_BITS,
                                                     x86_iommu->dt_supported);
-    vtd_spte_rsvd_large[3] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits,
+    vtd_spte_rsvd_large[3] = VTD_SPTE_LPAGE_L3_RSVD_MASK(S_AW_BITS,
                                                     x86_iommu->dt_supported);
 
     if (s->scalable_mode || s->snoop_control) {
-- 
2.34.1


