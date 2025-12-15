Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23C6D59D99
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 06:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV2RX-0008VX-Eu; Mon, 15 Dec 2025 01:52:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vV2RI-0008Fk-Eb
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 01:52:13 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vV2RF-0000u9-PB
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 01:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765781530; x=1797317530;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ctOGbbkyAeu6taefT4X2QSoL5UJ6D+CW401dwvnWWQY=;
 b=Q8tFoilVpeNoF5HqHbMlkdXMJxDdCWmBkIGHwv+Wadt1KPoUjFFi9SFg
 ltCwpkQdumQRq/jvFQwNWrOAK5Ht68PbgKcjeH0JVgsnCZL1aKMjcpviv
 uronG0YPzpr6YUfpWteJSPOVu4ITe7ZAFzwOJJht5nAg7nAgjSlDUBgef
 uiCwqtB/KUJ3iI/cxclUC/c6OHIY58qjRbEq9WqUAAPq3mvbNQQiw8ziQ
 HN8GBLn2n9ndYKGfMaZdCQq8GwBwApOQmvZuydi7uQjsZtVGW55QtoxM+
 LY4reRrO919NAGPEYkqqsEPtOBbmpsS5w3SnX8etze2gAZs95QJ+HgxtT w==;
X-CSE-ConnectionGUID: cVf9Q3AnTpyNpY2MtQ5ipg==
X-CSE-MsgGUID: h8fgNyY7SLyi7n765tTBpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="71305030"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="71305030"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2025 22:52:10 -0800
X-CSE-ConnectionGUID: PPt06TIkSpmwl3mwI/iV1Q==
X-CSE-MsgGUID: 0EO9v6LIQbqGY1TDl9nU1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="197408827"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2025 22:52:05 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>
Subject: [PATCH v9 13/19] intel_iommu_accel: Bind/unbind guest page table to
 host
Date: Mon, 15 Dec 2025 01:50:37 -0500
Message-ID: <20251215065046.86991-14-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251215065046.86991-1-zhenzhong.duan@intel.com>
References: <20251215065046.86991-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This captures the guest PASID table entry modifications and propagates
the changes to host to attach a hwpt with type determined per guest IOMMU
PGTT configuration.

When PGTT=PT, attach PASID_0 to a second stage HWPT(GPA->HPA).
When PGTT=FST, attach PASID_0 to nested HWPT with nesting parent HWPT
coming from VFIO.

Co-Authored-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_accel.h   |   7 +++
 include/hw/i386/intel_iommu.h |   2 +
 hw/i386/intel_iommu.c         |  22 ++++++-
 hw/i386/intel_iommu_accel.c   | 114 ++++++++++++++++++++++++++++++++++
 hw/i386/trace-events          |   3 +
 5 files changed, 145 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index d049cab3e1..82821ec0ef 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -16,6 +16,7 @@
 bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                           Error **errp);
 VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as);
+bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as, Error **errp);
 #else
 static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
                                         VTDHostIOMMUDevice *vtd_hiod,
@@ -30,5 +31,11 @@ static inline VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
 {
     return NULL;
 }
+
+static inline bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as,
+                                             Error **errp)
+{
+    return true;
+}
 #endif
 #endif
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 401322665a..6c61fd39c7 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -154,6 +154,8 @@ struct VTDAddressSpace {
      * with the guest IOMMU pgtables for a device.
      */
     IOVATree *iova_tree;
+
+    uint32_t fs_hwpt_id;
 };
 
 struct VTDIOTLBEntry {
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index ace046836f..fd58fbdac7 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -87,7 +87,11 @@ static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
     g_hash_table_iter_init(&as_it, s->vtd_address_spaces);
     while (g_hash_table_iter_next(&as_it, NULL, (void **)&vtd_as)) {
         VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
-        pc_entry->valid = false;
+        if (pc_entry->valid) {
+            pc_entry->valid = false;
+            /* It's fatal to get failure during reset */
+            vtd_propagate_guest_pasid(vtd_as, &error_fatal);
+        }
     }
 }
 
@@ -3073,6 +3077,8 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
     VTDPASIDEntry pe;
     IOMMUNotifier *n;
     uint16_t did;
+    const char *err_prefix = "Attaching to HWPT failed: ";
+    Error *local_err = NULL;
 
     if (vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
         if (!pc_entry->valid) {
@@ -3093,7 +3099,9 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
             vtd_address_space_unmap(vtd_as, n);
         }
         vtd_switch_address_space(vtd_as);
-        return;
+
+        err_prefix = "Detaching from HWPT failed: ";
+        goto do_bind_unbind;
     }
 
     /*
@@ -3121,12 +3129,20 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
     if (!pc_entry->valid) {
         pc_entry->pasid_entry = pe;
         pc_entry->valid = true;
-    } else if (!vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
+    } else if (vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
+        err_prefix = "Replacing HWPT attachment failed: ";
+    } else {
         return;
     }
 
     vtd_switch_address_space(vtd_as);
     vtd_address_space_sync(vtd_as);
+
+do_bind_unbind:
+    /* TODO: Fault event injection into guest, report error to QEMU for now */
+    if (!vtd_propagate_guest_pasid(vtd_as, &local_err)) {
+        error_reportf_err(local_err, "%s", err_prefix);
+    }
 }
 
 static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index ebfc503d64..748a6c7e1c 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -13,6 +13,7 @@
 #include "intel_iommu_internal.h"
 #include "intel_iommu_accel.h"
 #include "hw/pci/pci_bus.h"
+#include "trace.h"
 
 bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                           Error **errp)
@@ -68,3 +69,116 @@ VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
     }
     return NULL;
 }
+
+static bool vtd_create_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                               VTDPASIDEntry *pe, uint32_t *fs_hwpt_id,
+                               Error **errp)
+{
+    struct iommu_hwpt_vtd_s1 vtd = {};
+
+    vtd.flags = (VTD_SM_PASID_ENTRY_SRE(pe) ? IOMMU_VTD_S1_SRE : 0) |
+                (VTD_SM_PASID_ENTRY_WPE(pe) ? IOMMU_VTD_S1_WPE : 0) |
+                (VTD_SM_PASID_ENTRY_EAFE(pe) ? IOMMU_VTD_S1_EAFE : 0);
+    vtd.addr_width = vtd_pe_get_fs_aw(pe);
+    vtd.pgtbl_addr = (uint64_t)vtd_pe_get_fspt_base(pe);
+
+    return iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, idev->hwpt_id,
+                                      0, IOMMU_HWPT_DATA_VTD_S1, sizeof(vtd),
+                                      &vtd, fs_hwpt_id, errp);
+}
+
+static void vtd_destroy_old_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                    VTDAddressSpace *vtd_as)
+{
+    if (!vtd_as->fs_hwpt_id) {
+        return;
+    }
+    iommufd_backend_free_id(idev->iommufd, vtd_as->fs_hwpt_id);
+    vtd_as->fs_hwpt_id = 0;
+}
+
+static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
+                                      VTDAddressSpace *vtd_as, Error **errp)
+{
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+    VTDPASIDEntry *pe = &vtd_as->pasid_cache_entry.pasid_entry;
+    uint32_t hwpt_id = idev->hwpt_id;
+    bool ret;
+
+    /*
+     * We can get here only if flts=on, the supported PGTT is FST or PT.
+     * Catch invalid PGTT when processing invalidation request to avoid
+     * attaching to wrong hwpt.
+     */
+    if (!vtd_pe_pgtt_is_fst(pe) && !vtd_pe_pgtt_is_pt(pe)) {
+        error_setg(errp, "Invalid PGTT type %d",
+                   (uint8_t)VTD_SM_PASID_ENTRY_PGTT(pe));
+        return false;
+    }
+
+    if (vtd_pe_pgtt_is_fst(pe)) {
+        if (!vtd_create_fs_hwpt(idev, pe, &hwpt_id, errp)) {
+            return false;
+        }
+    }
+
+    ret = host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp);
+    trace_vtd_device_attach_hwpt(idev->devid, vtd_as->pasid, hwpt_id, ret);
+    if (ret) {
+        /* Destroy old fs_hwpt if it's a replacement */
+        vtd_destroy_old_fs_hwpt(idev, vtd_as);
+        if (vtd_pe_pgtt_is_fst(pe)) {
+            vtd_as->fs_hwpt_id = hwpt_id;
+        }
+    } else if (vtd_pe_pgtt_is_fst(pe)) {
+        iommufd_backend_free_id(idev->iommufd, hwpt_id);
+    }
+
+    return ret;
+}
+
+static bool vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
+                                      VTDAddressSpace *vtd_as, Error **errp)
+{
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+    IntelIOMMUState *s = vtd_as->iommu_state;
+    uint32_t pasid = vtd_as->pasid;
+    bool ret;
+
+    if (s->dmar_enabled && s->root_scalable) {
+        ret = host_iommu_device_iommufd_detach_hwpt(idev, errp);
+        trace_vtd_device_detach_hwpt(idev->devid, pasid, ret);
+    } else {
+        /*
+         * If DMAR remapping is disabled or guest switches to legacy mode,
+         * we fallback to the default HWPT which contains shadow page table.
+         * So guest DMA could still work.
+         */
+        ret = host_iommu_device_iommufd_attach_hwpt(idev, idev->hwpt_id, errp);
+        trace_vtd_device_reattach_def_hwpt(idev->devid, pasid, idev->hwpt_id,
+                                           ret);
+    }
+
+    if (ret) {
+        vtd_destroy_old_fs_hwpt(idev, vtd_as);
+    }
+
+    return ret;
+}
+
+bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as, Error **errp)
+{
+    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
+    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(vtd_as);
+
+    /* Ignore emulated device or legacy VFIO backed device */
+    if (!vtd_as->iommu_state->fsts || !vtd_hiod) {
+        return true;
+    }
+
+    if (pc_entry->valid) {
+        return vtd_device_attach_iommufd(vtd_hiod, vtd_as, errp);
+    }
+
+    return vtd_device_detach_iommufd(vtd_hiod, vtd_as, errp);
+}
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index b704f4f90c..5a3ee1cf64 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -73,6 +73,9 @@ vtd_warn_invalid_qi_tail(uint16_t tail) "tail 0x%"PRIx16
 vtd_warn_ir_vector(uint16_t sid, int index, int vec, int target) "sid 0x%"PRIx16" index %d vec %d (should be: %d)"
 vtd_warn_ir_trigger(uint16_t sid, int index, int trig, int target) "sid 0x%"PRIx16" index %d trigger %d (should be: %d)"
 vtd_reset_exit(void) ""
+vtd_device_attach_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
+vtd_device_detach_hwpt(uint32_t dev_id, uint32_t pasid, int ret) "dev_id %d pasid %d ret: %d"
+vtd_device_reattach_def_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
 
 # amd_iommu.c
 amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32
-- 
2.47.1


