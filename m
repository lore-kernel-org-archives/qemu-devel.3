Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CDDCCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 08:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCDPh-00041b-SD; Fri, 24 Oct 2025 04:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vCDPf-00041M-Kd
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:44:43 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vCDPd-0006FA-HQ
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761295482; x=1792831482;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=c9of0UclJQmLyHa0/9PJZU4Dj1FHfNG/72sNwO/gpcw=;
 b=n+C0tJJLu30N+87/T0tMheSnpzIuWtaMTChXneW3PkCp9/IWWjX0yXFQ
 AR/XeHR2Z/Fdl5WqlLLyz9ONFhXD+XOmSmmOASJheZ/kMnxebL31K6qk3
 Mn54QRzki3uEu5xHUNxTCDsRzXqmAlqEjL3O25fcsbTYYciQb6+Y1ztXJ
 ORgN4gYXTwIOfelTiesQMfh6wMruTDMPr3KxvPGSglu81Il2VKuWjq6dj
 MdikiJy5XtfIQmUE0EmkVHtthMv2QlUohanJ5MGJuXyU8Te7xWeumIJGH
 iGwzBOZZsiw8/Ao0c9wWwQK3bmU6icadBbQdVkfqddaXHshr/5qcox5kF w==;
X-CSE-ConnectionGUID: IG2dH9L3SkeS1qPF/9oM/Q==
X-CSE-MsgGUID: RDl0oHQYQ4GRKdqTp0swuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62504823"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="62504823"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 01:44:40 -0700
X-CSE-ConnectionGUID: eshNN0p8QIyDdGDFNK2wyA==
X-CSE-MsgGUID: RPFw+1Q3TaGmDIds/0rYZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="183985791"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 01:44:36 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, skolothumtho@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v7 02/23] intel_iommu: Delete RPS capability related
 supporting code
Date: Fri, 24 Oct 2025 04:43:26 -0400
Message-ID: <20251024084349.102322-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251024084349.102322-1-zhenzhong.duan@intel.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

RID-PASID Support(RPS) is not set in vIOMMU ECAP register, the supporting
code is there but never takes effect.

Meanwhile, according to VTD spec section 3.4.3:
"Implementations not supporting RID_PASID capability (ECAP_REG.RPS is 0b),
use a PASID value of 0 to perform address translation for requests without
PASID."

We should delete the supporting code which fetches RID_PASID field from
scalable context entry and use 0 as RID_PASID directly, because RID_PASID
field is ignored if no RPS support according to spec.

This simplifies the code and doesn't bring any penalty.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  1 -
 hw/i386/intel_iommu.c          | 82 +++++++++++-----------------------
 2 files changed, 27 insertions(+), 56 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 75bafdf0cd..bf8fb2aa80 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -609,7 +609,6 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_CTX_ENTRY_LEGACY_SIZE     16
 #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
 
-#define VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK 0xfffff
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
 #define VTD_SM_CONTEXT_ENTRY_PRE            0x10ULL
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 70746e3080..06065d16b6 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -42,8 +42,7 @@
 #include "trace.h"
 
 /* context entry operations */
-#define VTD_CE_GET_RID2PASID(ce) \
-    ((ce)->val[1] & VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK)
+#define PASID_0    0
 #define VTD_CE_GET_PASID_DIR_TABLE(ce) \
     ((ce)->val[0] & VTD_PASID_DIR_BASE_ADDR_MASK)
 #define VTD_CE_GET_PRE(ce) \
@@ -963,7 +962,7 @@ static int vtd_ce_get_pasid_entry(IntelIOMMUState *s, VTDContextEntry *ce,
     int ret = 0;
 
     if (pasid == PCI_NO_PASID) {
-        pasid = VTD_CE_GET_RID2PASID(ce);
+        pasid = PASID_0;
     }
     pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
     ret = vtd_get_pe_from_pasid_table(s, pasid_dir_base, pasid, pe);
@@ -982,7 +981,7 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
     VTDPASIDEntry pe;
 
     if (pasid == PCI_NO_PASID) {
-        pasid = VTD_CE_GET_RID2PASID(ce);
+        pasid = PASID_0;
     }
     pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
 
@@ -1522,17 +1521,15 @@ static inline int vtd_context_entry_rsvd_bits_check(IntelIOMMUState *s,
     return 0;
 }
 
-static int vtd_ce_rid2pasid_check(IntelIOMMUState *s,
-                                  VTDContextEntry *ce)
+static int vtd_ce_pasid_0_check(IntelIOMMUState *s, VTDContextEntry *ce)
 {
     VTDPASIDEntry pe;
 
     /*
      * Make sure in Scalable Mode, a present context entry
-     * has valid rid2pasid setting, which includes valid
-     * rid2pasid field and corresponding pasid entry setting
+     * has valid pasid entry setting at PASID_0.
      */
-    return vtd_ce_get_pasid_entry(s, ce, &pe, PCI_NO_PASID);
+    return vtd_ce_get_pasid_entry(s, ce, &pe, PASID_0);
 }
 
 /* Map a device to its corresponding domain (context-entry) */
@@ -1593,12 +1590,11 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
         }
     } else {
         /*
-         * Check if the programming of context-entry.rid2pasid
-         * and corresponding pasid setting is valid, and thus
-         * avoids to check pasid entry fetching result in future
-         * helper function calling.
+         * Check if the programming of pasid setting of PASID_0
+         * is valid, and thus avoids to check pasid entry fetching
+         * result in future helper function calling.
          */
-        ret_fr = vtd_ce_rid2pasid_check(s, ce);
+        ret_fr = vtd_ce_pasid_0_check(s, ce);
         if (ret_fr) {
             return ret_fr;
         }
@@ -2110,7 +2106,6 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     bool reads = true;
     bool writes = true;
     uint8_t access_flags, pgtt;
-    bool rid2pasid = (pasid == PCI_NO_PASID) && s->root_scalable;
     VTDIOTLBEntry *iotlb_entry;
     uint64_t xlat, size;
 
@@ -2122,21 +2117,23 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
 
     vtd_iommu_lock(s);
 
-    cc_entry = &vtd_as->context_cache_entry;
+    if (pasid == PCI_NO_PASID && s->root_scalable) {
+        pasid = PASID_0;
+    }
 
-    /* Try to fetch pte from IOTLB, we don't need RID2PASID logic */
-    if (!rid2pasid) {
-        iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
-        if (iotlb_entry) {
-            trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->pte,
-                                     iotlb_entry->domain_id);
-            pte = iotlb_entry->pte;
-            access_flags = iotlb_entry->access_flags;
-            page_mask = iotlb_entry->mask;
-            goto out;
-        }
+    /* Try to fetch pte from IOTLB */
+    iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
+    if (iotlb_entry) {
+        trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->pte,
+                                 iotlb_entry->domain_id);
+        pte = iotlb_entry->pte;
+        access_flags = iotlb_entry->access_flags;
+        page_mask = iotlb_entry->mask;
+        goto out;
     }
 
+    cc_entry = &vtd_as->context_cache_entry;
+
     /* Try to fetch context-entry from cache first */
     if (cc_entry->context_cache_gen == s->context_cache_gen) {
         trace_vtd_iotlb_cc_hit(bus_num, devfn, cc_entry->context_entry.hi,
@@ -2173,10 +2170,6 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
         cc_entry->context_cache_gen = s->context_cache_gen;
     }
 
-    if (rid2pasid) {
-        pasid = VTD_CE_GET_RID2PASID(&ce);
-    }
-
     /*
      * We don't need to translate for pass-through context entries.
      * Also, let's ignore IOTLB caching as well for PT devices.
@@ -2202,19 +2195,6 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
         return true;
     }
 
-    /* Try to fetch pte from IOTLB for RID2PASID slow path */
-    if (rid2pasid) {
-        iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
-        if (iotlb_entry) {
-            trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->pte,
-                                     iotlb_entry->domain_id);
-            pte = iotlb_entry->pte;
-            access_flags = iotlb_entry->access_flags;
-            page_mask = iotlb_entry->mask;
-            goto out;
-        }
-    }
-
     if (s->flts && s->root_scalable) {
         ret_fr = vtd_iova_to_flpte(s, &ce, addr, is_write, &pte, &level,
                                    &reads, &writes, s->aw_bits, pasid);
@@ -2477,20 +2457,14 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
         ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
                                        vtd_as->devfn, &ce);
         if (!ret && domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
-            uint32_t rid2pasid = PCI_NO_PASID;
-
-            if (s->root_scalable) {
-                rid2pasid = VTD_CE_GET_RID2PASID(&ce);
-            }
-
             /*
              * In legacy mode, vtd_as->pasid == pasid is always true.
              * In scalable mode, for vtd address space backing a PCI
              * device without pasid, needs to compare pasid with
-             * rid2pasid of this device.
+             * PASID_0 of this device.
              */
             if (!(vtd_as->pasid == pasid ||
-                  (vtd_as->pasid == PCI_NO_PASID && pasid == rid2pasid))) {
+                  (vtd_as->pasid == PCI_NO_PASID && pasid == PASID_0))) {
                 continue;
             }
 
@@ -2995,9 +2969,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
         if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
                                       vtd_as->devfn, &ce) &&
             domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
-            uint32_t rid2pasid = VTD_CE_GET_RID2PASID(&ce);
-
-            if ((vtd_as->pasid != PCI_NO_PASID || pasid != rid2pasid) &&
+            if ((vtd_as->pasid != PCI_NO_PASID || pasid != PASID_0) &&
                 vtd_as->pasid != pasid) {
                 continue;
             }
-- 
2.47.1


