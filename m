Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6EBCD343F
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 04:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLZ0G-0001Jj-L8; Sat, 09 May 2026 00:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wLZ08-0001Hd-Bn
 for qemu-devel@nongnu.org; Sat, 09 May 2026 00:09:17 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wLZ05-0000NM-Ob
 for qemu-devel@nongnu.org; Sat, 09 May 2026 00:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778299754; x=1809835754;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=T88r7SnHFE2VntpJfCVjtmEinhaTwNoMqGvVwGGBa5Y=;
 b=RZfl2GfksKB+8aAT2BriXOupamIX48Vc8GgsA7wkWf3c8GrWMhsiL64n
 lKzwzPdT9SJgmmzv5IKU8iqyLW5AWGQrPKRV3XzmROHuyAEEOjVTQlf+v
 FI6bHfTN+gQxslowflnoW4Zp8Y5+Gd3S0k1Obkqi4njCVDt8VWybg1S7l
 RbYnZdU2QpbhMGIN+3Gpe9SCPyOXELyH7Pd2d86xmhuxsmco2doa80mI4
 2BCeMlGfQQIMfs7mdL+7Ap5MlPGCepZKj6fkfPWsXKZuXM/1aH76BaqwL
 59hbvw/0i8UacYV/5JGPnes3JSPLToqyMklIE4EcK+mKyZ9xGl8JpdO0l w==;
X-CSE-ConnectionGUID: WeQzf27LQTOnDtqcFZTNOQ==
X-CSE-MsgGUID: g9+LFyUZSlGhSp64IRws4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="90654464"
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; d="scan'208";a="90654464"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 21:09:09 -0700
X-CSE-ConnectionGUID: GRrqEgmlTFW+i6s1HrF23w==
X-CSE-MsgGUID: V42dFSmeQGutzOaXyLuV/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; d="scan'208";a="235966539"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 21:09:06 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 08/15] intel_iommu: Refactor PASID processing to use
 IOMMU_NO_PASID internally
Date: Sat,  9 May 2026 00:08:01 -0400
Message-ID: <20260509040819.1044702-9-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The PCI subsystem uses PCI_NO_PASID for requests-without-PASID, but VT-d
uses IOMMU_NO_PASID internally. This leads to conversion and checking code
between PCI_NO_PASID and IOMMU_NO_PASID throughout the implementation.

Refactor to use IOMMU PASID consistently within Intel IOMMU by storing
IOMMU PASID value in vtd_as->pasid. After this change, PCI_NO_PASID is
only used at three boundary points:

1. PCI_NO_PASID -> IOMMU_NO_PASID: Convert PCI PASID to IOMMU PASID in
   vtd_find_add_as() and cache in vtd_as->pasid.
2. IOMMU_NO_PASID -> PCI_NO_PASID: Convert when notifying UNMAP events
   via memory_region_notify_iommu() and returning IOMMUTLBEntry in
   vtd_iommu_translate().

This eliminates conversion/checks in PASID table lookups, simplifies
invalidation logic with consistent PASID values, and improves code
readability. The PCI subsystem interface remains unchanged to maintain
compatibility with other IOMMU implementations that may not use PASID 0
for requests-without-PASID.

Suggested-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/system/memory.h     |   2 +-
 hw/i386/intel_iommu.c       | 164 +++++++++++++++++-------------------
 hw/i386/intel_iommu_accel.c |   2 +-
 3 files changed, 80 insertions(+), 88 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 1417132f6d..1edb38b07d 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -150,7 +150,7 @@ struct IOMMUTLBEntry {
     hwaddr           translated_addr;
     hwaddr           addr_mask;  /* 0xfff = 4k translation */
     IOMMUAccessFlags perm;
-    uint32_t         pasid;
+    uint32_t         pasid; /* PCI pasid */
 };
 
 /*
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 5e5dcdc274..b50c556c40 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -938,12 +938,8 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
 int vtd_ce_get_pasid_entry(IntelIOMMUState *s, VTDContextEntry *ce,
                            VTDPASIDEntry *pe, uint32_t pasid)
 {
-    dma_addr_t pasid_dir_base;
+    dma_addr_t pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
 
-    if (pasid == PCI_NO_PASID) {
-        pasid = IOMMU_NO_PASID;
-    }
-    pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
     return vtd_get_pe_from_pasid_table(s, pasid_dir_base, pasid, pe);
 }
 
@@ -953,15 +949,10 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
                                 uint32_t pasid)
 {
     int ret;
-    dma_addr_t pasid_dir_base;
+    dma_addr_t pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
     VTDPASIDDirEntry pdire;
     VTDPASIDEntry pe;
 
-    if (pasid == PCI_NO_PASID) {
-        pasid = IOMMU_NO_PASID;
-    }
-    pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
-
     /*
      * No present bit check since fpd is meaningful even
      * if the present bit is clear.
@@ -1750,7 +1741,7 @@ static bool vtd_switch_address_space(VTDAddressSpace *as)
          *
          * Need to disable ir for as with PASID.
          */
-        if (as->pasid != PCI_NO_PASID) {
+        if (as->pasid != IOMMU_NO_PASID) {
             memory_region_set_enabled(&as->iommu_ir, false);
         } else {
             memory_region_set_enabled(&as->iommu_ir, true);
@@ -1780,7 +1771,7 @@ static bool vtd_switch_address_space(VTDAddressSpace *as)
      * We enable per as memory region (iommu_ir_fault) for catching
      * the translation for interrupt range through PASID + PT.
      */
-    if (pt && as->pasid != PCI_NO_PASID) {
+    if (pt && as->pasid != IOMMU_NO_PASID) {
         memory_region_set_enabled(&as->iommu_ir_fault, true);
     } else {
         memory_region_set_enabled(&as->iommu_ir_fault, false);
@@ -1892,7 +1883,7 @@ static VTDAddressSpace *vtd_get_as_by_sid_and_pasid(IntelIOMMUState *s,
 
 VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUState *s, uint16_t sid)
 {
-    return vtd_get_as_by_sid_and_pasid(s, sid, PCI_NO_PASID);
+    return vtd_get_as_by_sid_and_pasid(s, sid, IOMMU_NO_PASID);
 }
 
 static void vtd_pt_enable_fast_path(IntelIOMMUState *s, uint16_t source_id)
@@ -2121,10 +2112,6 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
 
     vtd_iommu_lock(s);
 
-    if (pasid == PCI_NO_PASID && s->root_scalable) {
-        pasid = IOMMU_NO_PASID;
-    }
-
     /* Try to fetch pte from IOTLB */
     iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
     if (iotlb_entry) {
@@ -2235,7 +2222,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     if (ret_fr) {
         if (!vtd_is_recoverable_fault(-ret_fr, iommu_idx)) {
             vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
-                            addr, is_write, pasid != PCI_NO_PASID, pasid);
+                            addr, is_write, s->root_scalable, pasid);
         }
         goto error;
     }
@@ -2489,7 +2476,7 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
 /*
  * There is no pasid field in iotlb invalidation descriptor, so IOMMU_NO_PASID
  * is passed as parameter. Piotlb invalidation supports pasid, pasid in its
- * descriptor is passed which should not be PCI_NO_PASID.
+ * descriptor is passed.
  */
 static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
                                              uint16_t domain_id, hwaddr addr,
@@ -2503,48 +2490,41 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
     QLIST_FOREACH(vtd_as, &(s->vtd_as_with_notifiers), next) {
         ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
                                        vtd_as->devfn, &ce);
-        if (!ret && domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
+        if (ret || vtd_as->pasid != pasid ||
+            domain_id != vtd_get_domain_id(s, &ce, pasid)) {
+            continue;
+        }
+
+        if (vtd_as_has_map_notifier(vtd_as)) {
             /*
-             * In legacy mode, vtd_as->pasid == pasid is always true.
-             * In scalable mode, for vtd address space backing a PCI
-             * device without pasid, needs to compare pasid with
-             * IOMMU_NO_PASID of this device.
+             * When first stage translation is off, as long as we have MAP
+             * notifications registered in any of our IOMMU notifiers,
+             * we need to sync the shadow page table. Otherwise VFIO
+             * device attaches to nested page table instead of shadow
+             * page table, so no need to sync.
              */
-            if (!(vtd_as->pasid == pasid ||
-                  (vtd_as->pasid == PCI_NO_PASID && pasid == IOMMU_NO_PASID))) {
-                continue;
-            }
-
-            if (vtd_as_has_map_notifier(vtd_as)) {
-                /*
-                 * When first stage translation is off, as long as we have MAP
-                 * notifications registered in any of our IOMMU notifiers,
-                 * we need to sync the shadow page table. Otherwise VFIO
-                 * device attaches to nested page table instead of shadow
-                 * page table, so no need to sync.
-                 */
-                if (!s->fsts || !s->root_scalable) {
-                    vtd_sync_shadow_page_table_range(vtd_as, &ce, addr, size);
-                }
-            } else {
-                /*
-                 * For UNMAP-only notifiers, we don't need to walk the
-                 * page tables.  We just deliver the PSI down to
-                 * invalidate caches.
-                 */
-                const IOMMUTLBEvent event = {
-                    .type = IOMMU_NOTIFIER_UNMAP,
-                    .entry = {
-                        .target_as = &address_space_memory,
-                        .iova = addr,
-                        .translated_addr = 0,
-                        .addr_mask = size - 1,
-                        .perm = IOMMU_NONE,
-                        .pasid = vtd_as->pasid,
-                    },
-                };
-                memory_region_notify_iommu(&vtd_as->iommu, 0, event);
+            if (!s->fsts || !s->root_scalable) {
+                vtd_sync_shadow_page_table_range(vtd_as, &ce, addr, size);
             }
+        } else {
+            /*
+             * For UNMAP-only notifiers, we don't need to walk the
+             * page tables.  We just deliver the PSI down to
+             * invalidate caches.
+             */
+            const IOMMUTLBEvent event = {
+                .type = IOMMU_NOTIFIER_UNMAP,
+                .entry = {
+                    .target_as = &address_space_memory,
+                    .iova = addr,
+                    .translated_addr = 0,
+                    .addr_mask = size - 1,
+                    .perm = IOMMU_NONE,
+                     /* Other sub-systems use PCI pasid */
+                    .pasid = pasid == IOMMU_NO_PASID ? PCI_NO_PASID : pasid,
+                },
+            };
+            memory_region_notify_iommu(&vtd_as->iommu, 0, event);
         }
     }
 }
@@ -3007,6 +2987,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
     VTDIOTLBPageInvInfo info;
     VTDAddressSpace *vtd_as;
     VTDContextEntry ce;
+    int ret;
 
     info.domain_id = domain_id;
     info.pasid = pasid;
@@ -3019,17 +3000,15 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
     vtd_iommu_unlock(s);
 
     QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
-        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
-                                      vtd_as->devfn, &ce) &&
-            domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
-            if ((vtd_as->pasid != PCI_NO_PASID || pasid != IOMMU_NO_PASID) &&
-                vtd_as->pasid != pasid) {
-                continue;
-            }
+        ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
+                                       vtd_as->devfn, &ce);
+        if (ret || vtd_as->pasid != pasid ||
+            domain_id != vtd_get_domain_id(s, &ce, pasid)) {
+            continue;
+        }
 
-            if (!s->fsts || !vtd_as_has_map_notifier(vtd_as)) {
-                vtd_address_space_sync(vtd_as);
-            }
+        if (!s->fsts || !vtd_as_has_map_notifier(vtd_as)) {
+            vtd_address_space_sync(vtd_as);
         }
     }
 }
@@ -3239,7 +3218,7 @@ static bool vtd_process_pasid_desc(IntelIOMMUState *s,
         /* PASID selective implies a DID selective */
         trace_vtd_inv_desc_pasid_cache_psi(did, pasid);
         pc_info.did = did;
-        pc_info.pasid = pasid ?: PCI_NO_PASID;
+        pc_info.pasid = pasid;
         break;
 
     case VTD_INV_DESC_PASIDC_G_GLOBAL:
@@ -3291,6 +3270,7 @@ static void do_invalidate_device_tlb(VTDAddressSpace *vtd_dev_as,
      * ...
      */
 
+    uint32_t pasid = vtd_dev_as->pasid;
     IOMMUTLBEvent event;
     uint64_t sz;
 
@@ -3307,7 +3287,8 @@ static void do_invalidate_device_tlb(VTDAddressSpace *vtd_dev_as,
     event.entry.iova = addr;
     event.entry.perm = IOMMU_NONE;
     event.entry.translated_addr = 0;
-    event.entry.pasid = vtd_dev_as->pasid;
+    /* Other sub-systems use PCI pasid */
+    event.entry.pasid = pasid == IOMMU_NO_PASID ? PCI_NO_PASID : pasid;
     memory_region_notify_iommu(&vtd_dev_as->iommu, 0, event);
 }
 
@@ -3335,7 +3316,7 @@ static bool vtd_process_device_piotlb_desc(IntelIOMMUState *s,
     sid = VTD_INV_DESC_PASID_DEVICE_IOTLB_SID(inv_desc->lo);
     if (global) {
         QLIST_FOREACH(vtd_dev_as, &s->vtd_as_with_notifiers, next) {
-            if ((vtd_dev_as->pasid != PCI_NO_PASID) &&
+            if ((vtd_dev_as->pasid != IOMMU_NO_PASID) &&
                 (PCI_BUILD_BDF(pci_bus_num(vtd_dev_as->bus),
                                            vtd_dev_as->devfn) == sid)) {
                 do_invalidate_device_tlb(vtd_dev_as, size, addr);
@@ -3983,13 +3964,12 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
 }
 
 static void vtd_prepare_identity_entry(hwaddr addr, IOMMUAccessFlags perm,
-                                         uint32_t pasid, IOMMUTLBEntry *iotlb)
+                                       IOMMUTLBEntry *iotlb)
 {
     iotlb->iova = addr & VTD_PAGE_MASK_4K;
     iotlb->translated_addr = addr & VTD_PAGE_MASK_4K;
     iotlb->addr_mask = ~VTD_PAGE_MASK_4K;
     iotlb->perm = perm;
-    iotlb->pasid = pasid;
 }
 
 static inline void vtd_prepare_error_entry(IOMMUTLBEntry *entry)
@@ -4001,6 +3981,10 @@ static inline void vtd_prepare_error_entry(IOMMUTLBEntry *entry)
     entry->pasid = PCI_NO_PASID;
 }
 
+/*
+ * This function returns translation result to other sub-system such as PCI,
+ * so iommu pasid is converted to PCI pasid and returned in IOMMUTLBEntry.
+ */
 static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
                                          IOMMUAccessFlags flag, int iommu_idx)
 {
@@ -4009,7 +3993,7 @@ static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
     IOMMUTLBEntry iotlb = {
         /* We'll fill in the rest later. */
         .target_as = &address_space_memory,
-        .pasid = vtd_as->pasid,
+        .pasid = vtd_as->pasid == IOMMU_NO_PASID ? PCI_NO_PASID : vtd_as->pasid,
     };
     bool success;
     bool is_write = flag & IOMMU_WO;
@@ -4017,9 +4001,8 @@ static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
     if (likely(s->dmar_enabled)) {
         /* Only support translated requests in scalable mode */
         if (iommu_idx == VTD_IDX_TRANSLATED && s->root_scalable) {
-            if (vtd_as->pasid == PCI_NO_PASID) {
-                vtd_prepare_identity_entry(addr, IOMMU_RW, PCI_NO_PASID,
-                                           &iotlb);
+            if (vtd_as->pasid == IOMMU_NO_PASID) {
+                vtd_prepare_identity_entry(addr, IOMMU_RW, &iotlb);
                 success = true;
             } else {
                 vtd_prepare_error_entry(&iotlb);
@@ -4034,7 +4017,7 @@ static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
         }
     } else {
         /* DMAR disabled, passthrough, use 4k-page*/
-        vtd_prepare_identity_entry(addr, IOMMU_RW, vtd_as->pasid, &iotlb);
+        vtd_prepare_identity_entry(addr, IOMMU_RW, &iotlb);
         success = true;
     }
 
@@ -4460,7 +4443,7 @@ static void vtd_report_sid_ir_illegal_access(IntelIOMMUState *s, uint16_t sid,
     }
 
     vtd_report_fault(s, VTD_FR_SM_INTERRUPT_ADDR, is_fpd_set, sid, addr,
-                     is_write, pasid != PCI_NO_PASID, pasid);
+                     is_write, pasid != IOMMU_NO_PASID, pasid);
 }
 
 static void vtd_report_ir_illegal_access(VTDAddressSpace *vtd_as,
@@ -4488,7 +4471,6 @@ static MemTxResult vtd_mem_ir_write(void *opaque, hwaddr addr,
     int ret = 0;
     MSIMessage from = {}, to = {};
     uint16_t sid = X86_IOMMU_SID_INVALID;
-    uint32_t pasid;
 
     from.address = (uint64_t) addr + VTD_INTERRUPT_ADDR_FIRST;
     from.data = (uint32_t) value;
@@ -4496,11 +4478,11 @@ static MemTxResult vtd_mem_ir_write(void *opaque, hwaddr addr,
     if (!attrs.unspecified) {
         /* We have explicit Source ID */
         sid = attrs.requester_id;
-        pasid = attrs.pid != 0 ? attrs.pid : PCI_NO_PASID;
 
         if (attrs.address_type == PCI_AT_TRANSLATED &&
             sid != X86_IOMMU_SID_INVALID) {
-            vtd_report_sid_ir_illegal_access(s, sid, pasid, from.address, true);
+            vtd_report_sid_ir_illegal_access(s, sid, attrs.pid, from.address,
+                                             true);
             return MEMTX_ERROR;
         }
     }
@@ -4562,9 +4544,19 @@ static const MemoryRegionOps vtd_mem_ir_fault_ops = {
     },
 };
 
+/*
+ * This function is called by many PCIIOMMUOps callbacks to get
+ * VTDAddressSpace or create one if non-exist. Those callbacks are
+ * used by PCI sub-system and are passed in a PCI pasid value.
+ *
+ * VTD honors iommu pasid, so the first thing is to convert PCI
+ * pasid to iommu pasid.
+ */
 VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
                                  int devfn, unsigned int pasid)
 {
+    pasid = pasid == PCI_NO_PASID ? IOMMU_NO_PASID : pasid;
+
     /*
      * We can't simply use sid here since the bus number might not be
      * initialized by the guest.
@@ -4606,7 +4598,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
         new_key->devfn = devfn;
         new_key->pasid = pasid;
 
-        if (pasid == PCI_NO_PASID) {
+        if (pasid == IOMMU_NO_PASID) {
             snprintf(name, sizeof(name), "vtd-%02x.%x", PCI_SLOT(devfn),
                      PCI_FUNC(devfn));
         } else {
@@ -5290,7 +5282,7 @@ error_get_fpd_and_report:
     vtd_ce_get_pasid_fpd(s, &ce, &is_fpd_set, vtd_as->pasid);
 error_report:
     vtd_report_fault(s, -ret, is_fpd_set, sid, addr, is_write,
-                     vtd_as->pasid != PCI_NO_PASID, vtd_as->pasid);
+                     vtd_as->pasid != IOMMU_NO_PASID, vtd_as->pasid);
     return false;
 }
 
@@ -5381,7 +5373,7 @@ static int vtd_pri_request_page(PCIBus *bus, void *opaque, int devfn,
      */
 
     /* We do not support PRI without PASID */
-    if (vtd_as->pasid == PCI_NO_PASID) {
+    if (vtd_as->pasid == IOMMU_NO_PASID) {
         return -EPERM;
     }
     if (exec_req && !is_read) {
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 8940d240a1..10bdbba632 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -207,7 +207,7 @@ static void vtd_flush_host_piotlb_locked(gpointer key, gpointer value,
         return;
     }
 
-    assert(vtd_as->pasid == PCI_NO_PASID);
+    assert(vtd_as->pasid == IOMMU_NO_PASID);
 
     /* Nothing to do if there is no first stage HWPT attached */
     if (!pc_entry->valid ||
-- 
2.47.3


