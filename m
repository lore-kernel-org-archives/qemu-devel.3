Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2F4C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 07:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSW5r-0005uE-Pf; Fri, 20 Jun 2025 03:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW5q-0005pv-GZ
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:23:22 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW5n-0008IS-O8
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750404200; x=1781940200;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lsVWpiXaJ141hti9PvpnrW7Otyc28/GLwcTz3BUtzHA=;
 b=miExXOE2Il8rZKBMwPTNMZZ3mO/+vi2A/aLxf7O3U9WzJDfdOTctMD1l
 Z76a/kKaTXiGrtnBDuFjaAxB9IVRWzn+mhM3+xcfBsG26Re4Emo+sekH+
 pUhAd2/NAWly8rcBjlguyJw1RksThSeLalAHkM5r1yM1/6F538vbYY06d
 ZvWNLCQ8mUm3yIrrspXWQkfYJ+XJQjQTMS9YOjQxlbFjNq+RIcsCHFC3A
 nJwlk5gZZ2/d56ExvN6miJLqKj7b4pUPi4zgDAuV5ciSVUI2eEKjoB+Xs
 D/yBPvfml4gLLHHVnffu09vLpFyG70MV3/eABxHVQniTCd5JCHyQQpFDh g==;
X-CSE-ConnectionGUID: hzA0Hn43TOiBhkrY9MOuKw==
X-CSE-MsgGUID: kfOSD24gT6arbQiJ/A07Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52532471"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="52532471"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:23:19 -0700
X-CSE-ConnectionGUID: BDOTkgCnT5Gyl4ke7QfsFw==
X-CSE-MsgGUID: pIlCF0RIQlehZdTXmvWaUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="181863257"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:23:15 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 14/19] intel_iommu: Bind/unbind guest page table to host
Date: Fri, 20 Jun 2025 15:18:08 +0800
Message-Id: <20250620071813.55571-15-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620071813.55571-1-zhenzhong.duan@intel.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

This captures the guest PASID table entry modifications and
propagates the changes to host to attach a hwpt with type determined
per guest IOMMU mdoe and PGTT configuration.

When PGTT is Pass-through(100b), the hwpt on host side is a stage-2
page table(GPA->HPA). When PGTT is First-stage Translation only(001b),
vIOMMU reuse hwpt(GPA->HPA) provided by VFIO as nested parent to
construct nested page table.

When guest decides to use legacy mode then vIOMMU switches the MRs of
the device's AS, hence the IOAS created by VFIO container would be
switched to using the IOMMU_NOTIFIER_IOTLB_EVENTS since the MR is
switched to IOMMU MR. So it is able to support shadowing the guest IO
page table.

Co-Authored-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  11 ++
 hw/i386/intel_iommu.c          | 244 +++++++++++++++++++++++++++++++--
 hw/i386/trace-events           |   3 +
 3 files changed, 243 insertions(+), 15 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 5ed76864be..92a533db54 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -563,6 +563,13 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
 
+typedef enum VTDPASIDOp {
+    VTD_PASID_BIND,
+    VTD_PASID_UPDATE,
+    VTD_PASID_UNBIND,
+    VTD_OP_NUM
+} VTDPASIDOp;
+
 typedef enum VTDPCInvType {
     /* Force reset all */
     VTD_PASID_CACHE_FORCE_RESET = 0,
@@ -607,6 +614,9 @@ typedef struct VTDPASIDCacheInfo {
 
 #define VTD_SM_PASID_ENTRY_FLPM          3ULL
 #define VTD_SM_PASID_ENTRY_FLPTPTR       (~0xfffULL)
+#define VTD_SM_PASID_ENTRY_SRE_BIT(val)  (!!((val) & 1ULL))
+#define VTD_SM_PASID_ENTRY_WPE_BIT(val)  (!!(((val) >> 4) & 1ULL))
+#define VTD_SM_PASID_ENTRY_EAFE_BIT(val) (!!(((val) >> 7) & 1ULL))
 
 /* First Level Paging Structure */
 /* Masks for First Level Paging Entry */
@@ -644,5 +654,6 @@ typedef struct VTDHostIOMMUDevice {
     PCIBus *bus;
     uint8_t devfn;
     HostIOMMUDevice *hiod;
+    uint32_t s1_hwpt;
 } VTDHostIOMMUDevice;
 #endif
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index be01f8885f..1c94a0033c 100644
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
 #define VTD_CE_GET_RID2PASID(ce) \
@@ -839,6 +843,27 @@ static inline uint16_t vtd_pe_get_did(VTDPASIDEntry *pe)
     return VTD_SM_PASID_ENTRY_DID((pe)->val[1]);
 }
 
+static inline dma_addr_t vtd_pe_get_flpt_base(VTDPASIDEntry *pe)
+{
+    return pe->val[2] & VTD_SM_PASID_ENTRY_FLPTPTR;
+}
+
+static inline uint32_t vtd_pe_get_fl_aw(VTDPASIDEntry *pe)
+{
+    return 48 + ((pe->val[2] >> 2) & VTD_SM_PASID_ENTRY_FLPM) * 9;
+}
+
+static inline bool vtd_pe_pgtt_is_pt(VTDPASIDEntry *pe)
+{
+    return (VTD_PE_GET_TYPE(pe) == VTD_SM_PASID_ENTRY_PT);
+}
+
+/* check if pgtt is first stage translation */
+static inline bool vtd_pe_pgtt_is_flt(VTDPASIDEntry *pe)
+{
+    return (VTD_PE_GET_TYPE(pe) == VTD_SM_PASID_ENTRY_FLT);
+}
+
 static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
 {
     return pdire->val & 1;
@@ -2431,6 +2456,188 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
     vtd_iommu_replay_all(s);
 }
 
+#ifdef CONFIG_IOMMUFD
+static void vtd_init_s1_hwpt_data(struct iommu_hwpt_vtd_s1 *vtd,
+                                  VTDPASIDEntry *pe)
+{
+    memset(vtd, 0, sizeof(*vtd));
+
+    vtd->flags =  (VTD_SM_PASID_ENTRY_SRE_BIT(pe->val[2]) ?
+                                        IOMMU_VTD_S1_SRE : 0) |
+                  (VTD_SM_PASID_ENTRY_WPE_BIT(pe->val[2]) ?
+                                        IOMMU_VTD_S1_WPE : 0) |
+                  (VTD_SM_PASID_ENTRY_EAFE_BIT(pe->val[2]) ?
+                                        IOMMU_VTD_S1_EAFE : 0);
+    vtd->addr_width = vtd_pe_get_fl_aw(pe);
+    vtd->pgtbl_addr = (uint64_t)vtd_pe_get_flpt_base(pe);
+}
+
+static int vtd_create_s1_hwpt(VTDHostIOMMUDevice *vtd_hiod,
+                              VTDPASIDEntry *pe, Error **errp)
+{
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+    struct iommu_hwpt_vtd_s1 vtd;
+    uint32_t s1_hwpt;
+
+    vtd_init_s1_hwpt_data(&vtd, pe);
+
+    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
+                                    idev->hwpt_id, 0, IOMMU_HWPT_DATA_VTD_S1,
+                                    sizeof(vtd), &vtd, &s1_hwpt, errp)) {
+        return -EINVAL;
+    }
+
+    vtd_hiod->s1_hwpt = s1_hwpt;
+
+    return 0;
+}
+
+static void vtd_destroy_s1_hwpt(VTDHostIOMMUDevice *vtd_hiod)
+{
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+
+    iommufd_backend_free_id(idev->iommufd, vtd_hiod->s1_hwpt);
+    vtd_hiod->s1_hwpt = 0;
+}
+
+static int vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
+                                     uint32_t pasid, VTDPASIDEntry *pe,
+                                     Error **errp)
+{
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+    uint32_t hwpt_id;
+    int ret;
+
+    if (vtd_pe_pgtt_is_flt(pe)) {
+        ret = vtd_create_s1_hwpt(vtd_hiod, pe, errp);
+        if (ret) {
+            return ret;
+        }
+        hwpt_id = vtd_hiod->s1_hwpt;
+    } else {
+        hwpt_id = idev->hwpt_id;
+    }
+
+    ret = !host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp);
+    trace_vtd_device_attach_hwpt(idev->devid, pasid, hwpt_id, ret);
+    if (ret && vtd_pe_pgtt_is_flt(pe)) {
+        vtd_destroy_s1_hwpt(vtd_hiod);
+    }
+
+    return ret;
+}
+
+static int vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
+                                     uint32_t pasid, VTDPASIDEntry *pe,
+                                     Error **errp)
+{
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+    int ret;
+
+    if (vtd_hiod->iommu_state->dmar_enabled) {
+        ret = !host_iommu_device_iommufd_detach_hwpt(idev, errp);
+        trace_vtd_device_detach_hwpt(idev->devid, pasid, ret);
+    } else {
+        ret = !host_iommu_device_iommufd_attach_hwpt(idev, idev->hwpt_id, errp);
+        trace_vtd_device_reattach_def_hwpt(idev->devid, pasid, idev->hwpt_id,
+                                           ret);
+    }
+
+    if (vtd_pe_pgtt_is_flt(pe)) {
+        vtd_destroy_s1_hwpt(vtd_hiod);
+    }
+
+    return ret;
+}
+
+static int vtd_device_attach_pgtbl(VTDHostIOMMUDevice *vtd_hiod,
+                                   VTDAddressSpace *vtd_as, VTDPASIDEntry *pe)
+{
+    /*
+     * If pe->gptt == FLT, should be go ahead to do bind as host only
+     * accepts guest FLT under nesting. If pe->pgtt==PT, should setup
+     * the pasid with GPA page table. Otherwise should return failure.
+     */
+    if (!vtd_pe_pgtt_is_flt(pe) && !vtd_pe_pgtt_is_pt(pe)) {
+        return -EINVAL;
+    }
+
+    /* Should fail if the FLPT base is 0 */
+    if (vtd_pe_pgtt_is_flt(pe) && !vtd_pe_get_flpt_base(pe)) {
+        return -EINVAL;
+    }
+
+    return vtd_device_attach_iommufd(vtd_hiod, vtd_as->pasid, pe, &error_abort);
+}
+
+static int vtd_device_detach_pgtbl(VTDHostIOMMUDevice *vtd_hiod,
+                                   VTDAddressSpace *vtd_as)
+{
+    VTDPASIDEntry *cached_pe = vtd_as->pasid_cache_entry.cache_filled ?
+                       &vtd_as->pasid_cache_entry.pasid_entry : NULL;
+
+    if (!cached_pe ||
+        (!vtd_pe_pgtt_is_flt(cached_pe) && !vtd_pe_pgtt_is_pt(cached_pe))) {
+        return 0;
+    }
+
+    return vtd_device_detach_iommufd(vtd_hiod, vtd_as->pasid, cached_pe,
+                                     &error_abort);
+}
+
+/**
+ * Caller should hold iommu_lock.
+ */
+static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as,
+                                VTDPASIDEntry *pe, VTDPASIDOp op)
+{
+    IntelIOMMUState *s = vtd_as->iommu_state;
+    VTDHostIOMMUDevice *vtd_hiod;
+    int devfn = vtd_as->devfn;
+    int ret = -EINVAL;
+    struct vtd_as_key key = {
+        .bus = vtd_as->bus,
+        .devfn = devfn,
+    };
+
+    vtd_hiod = g_hash_table_lookup(s->vtd_host_iommu_dev, &key);
+    if (!vtd_hiod || !vtd_hiod->hiod) {
+        /* means no need to go further, e.g. for emulated devices */
+        return 0;
+    }
+
+    if (vtd_as->pasid != PCI_NO_PASID) {
+        error_report("Non-rid_pasid %d not supported yet", vtd_as->pasid);
+        return ret;
+    }
+
+    switch (op) {
+    case VTD_PASID_UPDATE:
+    case VTD_PASID_BIND:
+    {
+        ret = vtd_device_attach_pgtbl(vtd_hiod, vtd_as, pe);
+        break;
+    }
+    case VTD_PASID_UNBIND:
+    {
+        ret = vtd_device_detach_pgtbl(vtd_hiod, vtd_as);
+        break;
+    }
+    default:
+        error_report_once("Unknown VTDPASIDOp!!!\n");
+        break;
+    }
+
+    return ret;
+}
+#else
+static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as,
+                                VTDPASIDEntry *pe, VTDPASIDOp op)
+{
+    return 0;
+}
+#endif
+
 /* Do a context-cache device-selective invalidation.
  * @func_mask: FM field after shifting
  */
@@ -3181,20 +3388,23 @@ static int vtd_fill_pe_in_cache(IntelIOMMUState *s, VTDAddressSpace *vtd_as,
                                 VTDPASIDEntry *pe)
 {
     VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
+    int ret;
 
-    if (vtd_pasid_entry_compare(pe, &pc_entry->pasid_entry)) {
-        /* No need to go further as cached pasid entry is latest */
-        return 0;
+    if (pc_entry->cache_filled) {
+        if (vtd_pasid_entry_compare(pe, &pc_entry->pasid_entry)) {
+            /* No need to go further as cached pasid entry is latest */
+            return 0;
+        }
+        ret = vtd_bind_guest_pasid(vtd_as, pe, VTD_PASID_UPDATE);
+    } else {
+        ret = vtd_bind_guest_pasid(vtd_as, pe, VTD_PASID_BIND);
     }
 
-    pc_entry->pasid_entry = *pe;
-    pc_entry->cache_filled = true;
-
-    /*
-     * TODO: send pasid bind to host for passthru devices
-     */
-
-    return 0;
+    if (!ret) {
+        pc_entry->pasid_entry = *pe;
+        pc_entry->cache_filled = true;
+    }
+    return ret;
 }
 
 /*
@@ -3265,10 +3475,14 @@ static gboolean vtd_flush_pasid(gpointer key, gpointer value,
     return false;
 
 remove:
-    /*
-     * TODO: send pasid unbind to host for passthru devices
-     */
-    pc_entry->cache_filled = false;
+    if (pc_entry->cache_filled) {
+        if (vtd_bind_guest_pasid(vtd_as, NULL, VTD_PASID_UNBIND)) {
+            pasid_cache_info_set_error(pc_info);
+            return false;
+        } else {
+            pc_entry->cache_filled = false;
+        }
+    }
 
     /*
      * Don't remove address space of PCI_NO_PASID which is created by PCI
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index c8a936eb46..1c31b9a873 100644
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
2.34.1


