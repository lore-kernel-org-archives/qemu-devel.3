Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D171ECAC59F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 08:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzATX-0000kL-HA; Thu, 18 Sep 2025 04:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzATV-0000iE-MD
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:58:45 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzATT-0004j2-9W
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758185923; x=1789721923;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Fe/PC2nZXH6grKp3LPD3ZFdzpbbw2sGj0bmB0sD4EDA=;
 b=CR1HXvwzGic8RM3FkMD9vTJEjU87vpWlD1OkznUSa7uXfLbu3DLsD02h
 lrTVBu0y3Vs6Rpez1QaA4g7JZlD/ns21KvgDU9/fMLEqDAQJFQZDOSPkz
 Mitd9643uUjrUNyXMOkkXyBs9WBHonZf3kj0fYqySIGtn/A2dpfKa+Mux
 Uha2qPfnDSm0vTRbTC3532SElwn7e+s0Q7FxRa0RtyVZkhTKDwzYa/Lxe
 TMIY4z2crrRjnahLO7zjweBEidC2LuH5tvtvnRRYwh0eNvA010m4OqhRC
 J3dk+f1N1Ae61pwgRy/yY3pp+Py+NtWAgHo1f9EsmDHyNfonn1XdRUfK+ w==;
X-CSE-ConnectionGUID: zUock9ELQI65vbsa+Gf14Q==
X-CSE-MsgGUID: V3sbUdp6SziwGIyKKpwY1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="78109383"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="78109383"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:58:41 -0700
X-CSE-ConnectionGUID: EIBwaUZKQ7mrUGStAQpqTQ==
X-CSE-MsgGUID: 6ZO2TeYdSUOMkPAlp8SnnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="175930290"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:58:38 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, skolothumtho@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 02/22] intel_iommu: Delete RPS capability related
 supporting code
Date: Thu, 18 Sep 2025 04:57:41 -0400
Message-ID: <20250918085803.796942-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250918085803.796942-1-zhenzhong.duan@intel.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

RID-PASID Support(RPS) is not set in vIOMMU ECAP register, the supporting
code is there but never take effect.

Meanwhile, according to VTD spec section 3.4.3:
"Implementations not supporting RID_PASID capability (ECAP_REG.RPS is 0b),
use a PASID value of 0 to perform address translation for requests without
PASID."

We should delete the supporting code which fetches RID_PASID field from
scalable context entry and use 0 as RID_PASID directly, because RID_PASID
field is ignored if no RPS support according to spec.

This simplify the code and doesn't bring any penalty.

Opportunistically, s/rid2pasid/rid_pasid and s/RID2PASID/RID_PASID as
VTD spec uses RID_PASID terminology.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  1 -
 hw/i386/intel_iommu.c          | 49 +++++++++++++---------------------
 2 files changed, 19 insertions(+), 31 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 360e937989..6abe76556a 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -547,7 +547,6 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_CTX_ENTRY_LEGACY_SIZE     16
 #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
 
-#define VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK 0xfffff
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 71b70b795d..b976b251bc 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -41,8 +41,7 @@
 #include "trace.h"
 
 /* context entry operations */
-#define VTD_CE_GET_RID2PASID(ce) \
-    ((ce)->val[1] & VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK)
+#define RID_PASID    0
 #define VTD_CE_GET_PASID_DIR_TABLE(ce) \
     ((ce)->val[0] & VTD_PASID_DIR_BASE_ADDR_MASK)
 
@@ -951,7 +950,7 @@ static int vtd_ce_get_pasid_entry(IntelIOMMUState *s, VTDContextEntry *ce,
     int ret = 0;
 
     if (pasid == PCI_NO_PASID) {
-        pasid = VTD_CE_GET_RID2PASID(ce);
+        pasid = RID_PASID;
     }
     pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
     ret = vtd_get_pe_from_pasid_table(s, pasid_dir_base, pasid, pe);
@@ -970,7 +969,7 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
     VTDPASIDEntry pe;
 
     if (pasid == PCI_NO_PASID) {
-        pasid = VTD_CE_GET_RID2PASID(ce);
+        pasid = RID_PASID;
     }
     pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
 
@@ -1510,15 +1509,14 @@ static inline int vtd_context_entry_rsvd_bits_check(IntelIOMMUState *s,
     return 0;
 }
 
-static int vtd_ce_rid2pasid_check(IntelIOMMUState *s,
+static int vtd_ce_rid_pasid_check(IntelIOMMUState *s,
                                   VTDContextEntry *ce)
 {
     VTDPASIDEntry pe;
 
     /*
      * Make sure in Scalable Mode, a present context entry
-     * has valid rid2pasid setting, which includes valid
-     * rid2pasid field and corresponding pasid entry setting
+     * has valid pasid entry setting at RID_PASID(0).
      */
     return vtd_ce_get_pasid_entry(s, ce, &pe, PCI_NO_PASID);
 }
@@ -1581,12 +1579,11 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
         }
     } else {
         /*
-         * Check if the programming of context-entry.rid2pasid
-         * and corresponding pasid setting is valid, and thus
-         * avoids to check pasid entry fetching result in future
-         * helper function calling.
+         * Check if the programming of pasid setting at RID_PASID(0)
+         * is valid, and thus avoids to check pasid entry fetching
+         * result in future helper function calling.
          */
-        ret_fr = vtd_ce_rid2pasid_check(s, ce);
+        ret_fr = vtd_ce_rid_pasid_check(s, ce);
         if (ret_fr) {
             return ret_fr;
         }
@@ -2097,7 +2094,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     bool reads = true;
     bool writes = true;
     uint8_t access_flags, pgtt;
-    bool rid2pasid = (pasid == PCI_NO_PASID) && s->root_scalable;
+    bool rid_pasid = (pasid == PCI_NO_PASID) && s->root_scalable;
     VTDIOTLBEntry *iotlb_entry;
     uint64_t xlat, size;
 
@@ -2111,8 +2108,8 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
 
     cc_entry = &vtd_as->context_cache_entry;
 
-    /* Try to fetch pte from IOTLB, we don't need RID2PASID logic */
-    if (!rid2pasid) {
+    /* Try to fetch pte from IOTLB, we don't need RID_PASID(0) logic */
+    if (!rid_pasid) {
         iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
         if (iotlb_entry) {
             trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->pte,
@@ -2160,8 +2157,8 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
         cc_entry->context_cache_gen = s->context_cache_gen;
     }
 
-    if (rid2pasid) {
-        pasid = VTD_CE_GET_RID2PASID(&ce);
+    if (rid_pasid) {
+        pasid = RID_PASID;
     }
 
     /*
@@ -2189,8 +2186,8 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
         return true;
     }
 
-    /* Try to fetch pte from IOTLB for RID2PASID slow path */
-    if (rid2pasid) {
+    /* Try to fetch pte from IOTLB for RID_PASID(0) slow path */
+    if (rid_pasid) {
         iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
         if (iotlb_entry) {
             trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->pte,
@@ -2464,20 +2461,14 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
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
+             * RID_PASID(0) of this device.
              */
             if (!(vtd_as->pasid == pasid ||
-                  (vtd_as->pasid == PCI_NO_PASID && pasid == rid2pasid))) {
+                  (vtd_as->pasid == PCI_NO_PASID && pasid == RID_PASID))) {
                 continue;
             }
 
@@ -2976,9 +2967,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
         if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
                                       vtd_as->devfn, &ce) &&
             domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
-            uint32_t rid2pasid = VTD_CE_GET_RID2PASID(&ce);
-
-            if ((vtd_as->pasid != PCI_NO_PASID || pasid != rid2pasid) &&
+            if ((vtd_as->pasid != PCI_NO_PASID || pasid != RID_PASID) &&
                 vtd_as->pasid != pasid) {
                 continue;
             }
-- 
2.47.1


