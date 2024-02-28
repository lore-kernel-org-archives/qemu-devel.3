Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BF5C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 09:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfGWx-00062Z-GB; Wed, 28 Feb 2024 04:47:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfGWv-0005ud-2j
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 04:47:14 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfGWs-0002AQ-QG
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 04:47:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709113631; x=1740649631;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yx9WnW6FzZkOMX5scTMftIZD9XRWJ/2axLjB+XskyEI=;
 b=XRWid4vpS1vKFbYw7WtpCvhLbGo2IxvKD3lsmj0iZqLi6in84vz48/At
 ekz9saQC9vUwLHf2LHg6NVrRkWOwmLOpRxZXEiuf80sqyhFoC6x56uEIz
 HomlQM3BtP/8OvriwGOg/vuOxygfsVgrLTUtrO8JzMS8DFA08Zm72wVds
 2qv+IzMVvKVDkDtzD+CWgk/5wdvPQtwtB9gCQNceiPcbghYGxW9PYFfLt
 m0XCPGFAJYD8Z7HRtAZAIH1WpoN5BMsZw/caYTyvZbOWkv2MAKJn3Ncz0
 CvylBey8fELtC/e4TnttmXoS18xi9hUMYiI08IbpfnP74xHYBOo/PERpd w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="25970016"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; d="scan'208";a="25970016"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 01:47:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7810092"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 01:47:05 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v1 5/6] intel_iommu: Use mgaw instead of s->aw_bits
Date: Wed, 28 Feb 2024 17:44:31 +0800
Message-Id: <20240228094432.1092748-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228094432.1092748-1-zhenzhong.duan@intel.com>
References: <20240228094432.1092748-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
index 2a55268538..e474284e43 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -42,6 +42,8 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 
+#define S_AW_BITS (VTD_MGAW_FROM_CAP(s->cap) + 1)
+
 /* context entry operations */
 #define VTD_CE_GET_RID2PASID(ce) \
     ((ce)->val[1] & VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK)
@@ -1410,13 +1412,13 @@ static int vtd_root_entry_rsvd_bits_check(IntelIOMMUState *s,
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
@@ -1433,7 +1435,7 @@ static inline int vtd_context_entry_rsvd_bits_check(IntelIOMMUState *s,
 {
     if (!s->root_scalable &&
         (ce->hi & VTD_CONTEXT_ENTRY_RSVD_HI ||
-         ce->lo & VTD_CONTEXT_ENTRY_RSVD_LO(s->aw_bits))) {
+         ce->lo & VTD_CONTEXT_ENTRY_RSVD_LO(S_AW_BITS))) {
         error_report_once("%s: invalid context entry: hi=%"PRIx64
                           ", lo=%"PRIx64" (reserved nonzero)",
                           __func__, ce->hi, ce->lo);
@@ -1441,7 +1443,7 @@ static inline int vtd_context_entry_rsvd_bits_check(IntelIOMMUState *s,
     }
 
     if (s->root_scalable &&
-        (ce->val[0] & VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(s->aw_bits) ||
+        (ce->val[0] & VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(S_AW_BITS) ||
          ce->val[1] & VTD_SM_CONTEXT_ENTRY_RSVD_VAL1 ||
          ce->val[2] ||
          ce->val[3])) {
@@ -1572,7 +1574,7 @@ static int vtd_sync_shadow_page_table_range(VTDAddressSpace *vtd_as,
         .hook_fn = vtd_sync_shadow_page_hook,
         .private = (void *)&vtd_as->iommu,
         .notify_unmap = true,
-        .aw = s->aw_bits,
+        .aw = S_AW_BITS,
         .as = vtd_as,
         .domain_id = vtd_get_domain_id(s, ce, vtd_as->pasid),
     };
@@ -1991,7 +1993,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     }
 
     ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &slpte, &level,
-                               &reads, &writes, s->aw_bits, pasid);
+                               &reads, &writes, S_AW_BITS, pasid);
     if (ret_fr) {
         vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
                          addr, is_write, pasid != PCI_NO_PASID, pasid);
@@ -2005,7 +2007,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
 out:
     vtd_iommu_unlock(s);
     entry->iova = addr & page_mask;
-    entry->translated_addr = vtd_get_slpte_addr(slpte, s->aw_bits) & page_mask;
+    entry->translated_addr = vtd_get_slpte_addr(slpte, S_AW_BITS) & page_mask;
     entry->addr_mask = ~page_mask;
     entry->perm = access_flags;
     return true;
@@ -2022,7 +2024,7 @@ error:
 static void vtd_root_table_setup(IntelIOMMUState *s)
 {
     s->root = vtd_get_quad_raw(s, DMAR_RTADDR_REG);
-    s->root &= VTD_RTADDR_ADDR_MASK(s->aw_bits);
+    s->root &= VTD_RTADDR_ADDR_MASK(S_AW_BITS);
 
     vtd_update_scalable_state(s);
 
@@ -2040,7 +2042,7 @@ static void vtd_interrupt_remap_table_setup(IntelIOMMUState *s)
     uint64_t value = 0;
     value = vtd_get_quad_raw(s, DMAR_IRTA_REG);
     s->intr_size = 1UL << ((value & VTD_IRTA_SIZE_MASK) + 1);
-    s->intr_root = value & VTD_IRTA_ADDR_MASK(s->aw_bits);
+    s->intr_root = value & VTD_IRTA_ADDR_MASK(S_AW_BITS);
     s->intr_eime = value & VTD_IRTA_EIME;
 
     /* Notify global invalidation */
@@ -2323,7 +2325,7 @@ static void vtd_handle_gcmd_qie(IntelIOMMUState *s, bool en)
     trace_vtd_inv_qi_enable(en);
 
     if (en) {
-        s->iq = iqa_val & VTD_IQA_IQA_MASK(s->aw_bits);
+        s->iq = iqa_val & VTD_IQA_IQA_MASK(S_AW_BITS);
         /* 2^(x+8) entries */
         s->iq_size = 1UL << ((iqa_val & VTD_IQA_QS) + 8 - (s->iq_dw ? 1 : 0));
         s->qi_enabled = true;
@@ -3966,12 +3968,12 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
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
@@ -3979,7 +3981,7 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
 
     while (remain >= VTD_PAGE_SIZE) {
         IOMMUTLBEvent event;
-        uint64_t mask = dma_aligned_pow2_mask(start, end, s->aw_bits);
+        uint64_t mask = dma_aligned_pow2_mask(start, end, S_AW_BITS);
         uint64_t size = mask + 1;
 
         assert(size);
@@ -4058,7 +4060,7 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
                 .hook_fn = vtd_replay_hook,
                 .private = (void *)n,
                 .notify_unmap = false,
-                .aw = s->aw_bits,
+                .aw = S_AW_BITS,
                 .as = vtd_as,
                 .domain_id = vtd_get_domain_id(s, &ce, vtd_as->pasid),
             };
@@ -4161,15 +4163,15 @@ static void vtd_init(IntelIOMMUState *s)
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


