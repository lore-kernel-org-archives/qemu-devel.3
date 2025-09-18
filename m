Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1802ACAC59F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 09:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzAUS-0002II-Ff; Thu, 18 Sep 2025 04:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzAUR-0002Ev-It
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:59:43 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzAUI-0004kz-0K
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758185974; x=1789721974;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YZtYmMerLULntaEfYrrV6J14Z6Y7whKRv8qYk4H8Brw=;
 b=RdvImZTDN5QfOX7qtrW/AsOepiJ71SlGJC8fg2CjHzfngpbAXGQRyXG+
 TeNP9ml/luWkDVnf12ka8Ccs2meGF4yZxVv5DB6YTZfKpHPzjwa//Gil7
 vhxZXIbpFgf2pV9IyghEj6zqBbQD6RYFz6mNUmgGhuzJJmi83l3HNMDKn
 SZinj3J1iCskR/myyH+WKdPQCkJeR0d17OM5rkuKCZbErhm8NkrnDWbXK
 hm0lE5t/NEdQk8a3GGJO1Mqdr5M/xiruS4BgRKU1XyEYw6GXM/tjswOgh
 YgRVudTqrK7S8RTnQouBr6Jp+YGH4kBVVPrjM1661muw0Mw6queyk8LHA A==;
X-CSE-ConnectionGUID: WfXNmCnQQGensuVUcrSD6A==
X-CSE-MsgGUID: 1aV5tU8VQLaENLosLDNVnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="78109544"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="78109544"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:59:31 -0700
X-CSE-ConnectionGUID: teERsLLoQu2LVGVlWUsq5w==
X-CSE-MsgGUID: MYoA7UFIStyrGTMhtAej3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="175930449"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:59:27 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, skolothumtho@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>
Subject: [PATCH v6 15/22] intel_iommu: Bind/unbind guest page table to host
Date: Thu, 18 Sep 2025 04:57:54 -0400
Message-ID: <20250918085803.796942-16-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250918085803.796942-1-zhenzhong.duan@intel.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

When PGTT=PT, attach RID_PASID to a second stage HWPT(GPA->HPA).
When PGTT=FST, attach RID_PASID to nested HWPT with nesting parent
HWPT coming from VFIO.

Co-Authored-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/i386/intel_iommu.h |   1 +
 hw/i386/intel_iommu.c         | 152 +++++++++++++++++++++++++++++++++-
 hw/i386/trace-events          |   3 +
 3 files changed, 154 insertions(+), 2 deletions(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index ff01e5c82d..86614fbb31 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -104,6 +104,7 @@ struct VTDAddressSpace {
     PCIBus *bus;
     uint8_t devfn;
     uint32_t pasid;
+    uint32_t fs_hwpt;
     AddressSpace as;
     IOMMUMemoryRegion iommu;
     MemoryRegion root;          /* The root container of the device */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 5908368c44..bfe229d0dc 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -20,6 +20,7 @@
  */
 
 #include "qemu/osdep.h"
+#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qapi/error.h"
@@ -41,6 +42,9 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 #include "system/iommufd.h"
+#ifdef CONFIG_IOMMUFD
+#include <linux/iommufd.h>
+#endif
 
 /* context entry operations */
 #define RID_PASID    0
@@ -2398,6 +2402,125 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
     vtd_iommu_replay_all(s);
 }
 
+#ifdef CONFIG_IOMMUFD
+static int vtd_create_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                              VTDPASIDEntry *pe, uint32_t *fs_hwpt,
+                              Error **errp)
+{
+    struct iommu_hwpt_vtd_s1 vtd = {};
+
+    vtd.flags = (VTD_SM_PASID_ENTRY_SRE_BIT(pe) ? IOMMU_VTD_S1_SRE : 0) |
+                (VTD_SM_PASID_ENTRY_WPE_BIT(pe) ? IOMMU_VTD_S1_WPE : 0) |
+                (VTD_SM_PASID_ENTRY_EAFE_BIT(pe) ? IOMMU_VTD_S1_EAFE : 0);
+    vtd.addr_width = vtd_pe_get_fs_aw(pe);
+    vtd.pgtbl_addr = (uint64_t)vtd_pe_get_fspt_base(pe);
+
+    return !iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
+                                       idev->hwpt_id, 0, IOMMU_HWPT_DATA_VTD_S1,
+                                       sizeof(vtd), &vtd, fs_hwpt, errp);
+}
+
+static void vtd_destroy_old_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                    VTDAddressSpace *vtd_as)
+{
+    if (!vtd_as->fs_hwpt) {
+        return;
+    }
+    iommufd_backend_free_id(idev->iommufd, vtd_as->fs_hwpt);
+    vtd_as->fs_hwpt = 0;
+}
+
+static int vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
+                                     VTDAddressSpace *vtd_as, Error **errp)
+{
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+    VTDPASIDEntry *pe = &vtd_as->pasid_cache_entry.pasid_entry;
+    uint32_t hwpt_id;
+    bool ret;
+
+    /*
+     * We can get here only if flts=on, the supported PGTT is FST and PT.
+     * Catch invalid PGTT when processing invalidation request to avoid
+     * attaching to wrong hwpt.
+     */
+    if (!vtd_pe_pgtt_is_fst(pe) && !vtd_pe_pgtt_is_pt(pe)) {
+        error_setg(errp, "Invalid PGTT type");
+        return -EINVAL;
+    }
+
+    if (vtd_pe_pgtt_is_pt(pe)) {
+        hwpt_id = idev->hwpt_id;
+    } else if (vtd_create_fs_hwpt(idev, pe, &hwpt_id, errp)) {
+        return -EINVAL;
+    }
+
+    ret = host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp);
+    trace_vtd_device_attach_hwpt(idev->devid, vtd_as->pasid, hwpt_id, !ret);
+    if (ret) {
+        /* Destroy old fs_hwpt if it's a replacement */
+        vtd_destroy_old_fs_hwpt(idev, vtd_as);
+        if (vtd_pe_pgtt_is_fst(pe)) {
+            vtd_as->fs_hwpt = hwpt_id;
+        }
+    } else if (vtd_pe_pgtt_is_fst(pe)) {
+        iommufd_backend_free_id(idev->iommufd, hwpt_id);
+    }
+
+    return !ret;
+}
+
+static int vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
+                                     VTDAddressSpace *vtd_as, Error **errp)
+{
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+    IntelIOMMUState *s = vtd_as->iommu_state;
+    uint32_t pasid = vtd_as->pasid;
+    bool ret;
+
+    if (s->dmar_enabled && s->root_scalable) {
+        ret = host_iommu_device_iommufd_detach_hwpt(idev, errp);
+        trace_vtd_device_detach_hwpt(idev->devid, pasid, !ret);
+    } else {
+        /*
+         * If DMAR remapping is disabled or guest switches to legacy mode,
+         * we fallback to the default HWPT which contains shadow page table.
+         * So guest DMA could still work.
+         */
+        ret = host_iommu_device_iommufd_attach_hwpt(idev, idev->hwpt_id, errp);
+        trace_vtd_device_reattach_def_hwpt(idev->devid, pasid, idev->hwpt_id,
+                                           !ret);
+    }
+
+    if (ret) {
+        vtd_destroy_old_fs_hwpt(idev, vtd_as);
+    }
+
+    return !ret;
+}
+
+static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, Error **errp)
+{
+    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
+    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(vtd_as);
+    int ret;
+
+    assert(vtd_hiod);
+
+    if (pc_entry->valid) {
+        ret = vtd_device_attach_iommufd(vtd_hiod, vtd_as, errp);
+    } else {
+        ret = vtd_device_detach_iommufd(vtd_hiod, vtd_as, errp);
+    }
+
+    return ret;
+}
+#else
+static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, Error **errp)
+{
+    return 0;
+}
+#endif
+
 /* Do a context-cache device-selective invalidation.
  * @func_mask: FM field after shifting
  */
@@ -3131,6 +3254,11 @@ static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
     return vtd_ce_get_pasid_entry(s, &ce, pe, vtd_as->pasid);
 }
 
+static int vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
+{
+    return memcmp(p1, p2, sizeof(*p1));
+}
+
 /*
  * For each IOMMUFD backed device, update or invalidate pasid cache based on
  * the value in memory.
@@ -3143,6 +3271,8 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
     VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
     VTDPASIDEntry pe;
     uint16_t did;
+    const char *err_prefix;
+    Error *local_err = NULL;
 
     /* Ignore emulated device or legacy VFIO backed device */
     if (!vtd_find_hiod_iommufd(vtd_as)) {
@@ -3153,13 +3283,18 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
     assert(vtd_as->pasid == PCI_NO_PASID);
 
     if (pc_info->reset || vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
+        if (!pc_entry->valid) {
+            return;
+        }
+
         /*
          * No valid pasid entry in guest memory. e.g. pasid entry was modified
          * to be either all-zero or non-present. Either case means existing
          * pasid cache should be invalidated.
          */
         pc_entry->valid = false;
-        return;
+        err_prefix = "Detaching from HWPT failed: ";
+        goto do_bind_unbind;
     }
 
     /*
@@ -3184,7 +3319,20 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
     }
 
     pc_entry->pasid_entry = pe;
-    pc_entry->valid = true;
+    if (!pc_entry->valid) {
+        pc_entry->valid = true;
+        err_prefix = "Attaching to HWPT failed: ";
+    } else if (vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
+        err_prefix = "Replacing HWPT attachment failed: ";
+    } else {
+        return;
+    }
+
+do_bind_unbind:
+    /* TODO: Fault event injection into guest, report error to QEMU for now */
+    if (vtd_bind_guest_pasid(vtd_as, &local_err)) {
+        error_reportf_err(local_err, "%s", err_prefix);
+    }
 }
 
 static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
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


