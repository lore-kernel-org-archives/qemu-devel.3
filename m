Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A944C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFFO-0003D9-GS; Tue, 08 Jul 2025 16:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uZDsA-0000c4-Ah
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:21:08 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uZDs4-00086x-SB
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752002453; x=1783538453;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SJ9E8XxsukQQm9xPWcv7N2WNYua0+CpREJT6UgZ1flM=;
 b=jg98cl6gpu5zGsBLLB6YfyHNFkt4KAoApjo6ZlMkao7PklOXWRAqLAnx
 V76frv4EwGl2pvaNYzasSQ5SKTxLOymMLIwgkAEmyXJHEP2aErSoHhD+Y
 /iXDUCxzp+Zh+GUCK50XcXM8Vvr8uO2WuliraynfEVn4JKCDoRRQWJr0Y
 KbQeUkzrToyWf/SbfZc2RpNjeXMqIDAgmunQ6/1HyDCTRgxiX9lGF1Tqy
 2JQOPnA7tcs/GvrFDHLbQ8PhKhxpKnq4S7ToIuq5YqI82IMwJxvsryOTg
 yyozPMInyhzVqeERT1Zr+ylNWk168m9guyKepGR41Qwsq2tor+JPUSnhh g==;
X-CSE-ConnectionGUID: AZlF9zn6R6m7O/+KOeGMyQ==
X-CSE-MsgGUID: FfKI+16/RP+hRvxrtMekzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="57974058"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="57974058"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 04:07:12 -0700
X-CSE-ConnectionGUID: k+C/iyZmS5e8Ervoo0YZRw==
X-CSE-MsgGUID: YAYHSZNfTMyGGhmRs0Fsxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="192647997"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 04:07:08 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>
Subject: [PATCH v3 14/20] intel_iommu: Bind/unbind guest page table to host
Date: Tue,  8 Jul 2025 07:05:55 -0400
Message-ID: <20250708110601.633308-15-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250708110601.633308-1-zhenzhong.duan@intel.com>
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14;
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
 hw/i386/intel_iommu.c          | 221 ++++++++++++++++++++++++++++++++-
 hw/i386/intel_iommu_internal.h |  14 ++-
 hw/i386/trace-events           |   3 +
 include/hw/i386/intel_iommu.h  |   1 +
 4 files changed, 233 insertions(+), 6 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 030862fb2f..c35673eb58 100644
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
@@ -50,10 +54,9 @@
 
 /* pe operations */
 #define VTD_PE_GET_TYPE(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_PGTT)
-#define VTD_PE_GET_FL_LEVEL(pe) \
-    (4 + (((pe)->val[2] >> 2) & VTD_SM_PASID_ENTRY_FLPM))
 #define VTD_PE_GET_SL_LEVEL(pe) \
     (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
+#define VTD_PE_GET_FL_LEVEL(pe) (VTD_SM_PASID_ENTRY_FSPM(pe) + 4)
 
 /*
  * PCI bus number (or SID) is not reliable since the device is usaully
@@ -834,6 +837,31 @@ static inline uint32_t vtd_sm_ce_get_pdt_entry_num(VTDContextEntry *ce)
     return 1U << (VTD_SM_CONTEXT_ENTRY_PDTS(ce) + 7);
 }
 
+static inline dma_addr_t vtd_pe_get_flpt_base(VTDPASIDEntry *pe)
+{
+    return pe->val[2] & VTD_SM_PASID_ENTRY_FSPTPTR;
+}
+
+/*
+ * Stage-1 IOVA address width: 48 bits for 4-level paging(FSPM=00)
+ *                             57 bits for 5-level paging(FSPM=01)
+ */
+static inline uint32_t vtd_pe_get_fl_aw(VTDPASIDEntry *pe)
+{
+    return 48 + VTD_SM_PASID_ENTRY_FSPM(pe) * 9;
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
@@ -1131,7 +1159,7 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
     if (s->root_scalable) {
         vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
         if (s->flts) {
-            return pe.val[2] & VTD_SM_PASID_ENTRY_FLPTPTR;
+            return pe.val[2] & VTD_SM_PASID_ENTRY_FSPTPTR;
         } else {
             return pe.val[0] & VTD_SM_PASID_ENTRY_SLPTPTR;
         }
@@ -1766,7 +1794,7 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
              */
             return false;
         }
-        return (VTD_PE_GET_TYPE(&pe) == VTD_SM_PASID_ENTRY_PT);
+        return vtd_pe_pgtt_is_pt(&pe);
     }
 
     return (vtd_ce_get_type(ce) == VTD_CONTEXT_TT_PASS_THROUGH);
@@ -2428,6 +2456,178 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
     vtd_iommu_replay_all(s);
 }
 
+#ifdef CONFIG_IOMMUFD
+static void vtd_init_s1_hwpt_data(struct iommu_hwpt_vtd_s1 *vtd,
+                                  VTDPASIDEntry *pe)
+{
+    memset(vtd, 0, sizeof(*vtd));
+
+    vtd->flags =  (VTD_SM_PASID_ENTRY_SRE_BIT(pe) ? IOMMU_VTD_S1_SRE : 0) |
+                  (VTD_SM_PASID_ENTRY_WPE_BIT(pe) ? IOMMU_VTD_S1_WPE : 0) |
+                  (VTD_SM_PASID_ENTRY_EAFE_BIT(pe) ? IOMMU_VTD_S1_EAFE : 0);
+    vtd->addr_width = vtd_pe_get_fl_aw(pe);
+    vtd->pgtbl_addr = (uint64_t)vtd_pe_get_flpt_base(pe);
+}
+
+static int vtd_create_s1_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                              VTDPASIDEntry *pe, uint32_t *s1_hwpt,
+                              Error **errp)
+{
+    struct iommu_hwpt_vtd_s1 vtd;
+
+    vtd_init_s1_hwpt_data(&vtd, pe);
+
+    return !iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
+                                       idev->hwpt_id, 0, IOMMU_HWPT_DATA_VTD_S1,
+                                       sizeof(vtd), &vtd, s1_hwpt, errp);
+}
+
+static void vtd_destroy_s1_hwpt(HostIOMMUDeviceIOMMUFD *idev,
+                                VTDAddressSpace *vtd_as)
+{
+    if (!vtd_as->s1_hwpt) {
+        return;
+    }
+    iommufd_backend_free_id(idev->iommufd, vtd_as->s1_hwpt);
+    vtd_as->s1_hwpt = 0;
+}
+
+static int vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
+                                     VTDAddressSpace *vtd_as, Error **errp)
+{
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+    VTDPASIDEntry *pe = &vtd_as->pasid_cache_entry.pasid_entry;
+    uint32_t hwpt_id;
+    int ret;
+
+    /*
+     * We can get here only if flts=on, the supported PGTT is FLT and PT.
+     * Catch invalid PGTT when processing invalidation request to avoid
+     * attaching to wrong hwpt.
+     */
+    if (!vtd_pe_pgtt_is_flt(pe) && !vtd_pe_pgtt_is_pt(pe)) {
+        error_setg(errp, "Invalid PGTT type");
+        return -EINVAL;
+    }
+
+    if (vtd_pe_pgtt_is_flt(pe)) {
+        /* Should fail if the FLPT base is 0 */
+        if (!vtd_pe_get_flpt_base(pe)) {
+            error_setg(errp, "FLPT base is 0");
+            return -EINVAL;
+        }
+
+        if (vtd_create_s1_hwpt(idev, pe, &hwpt_id, errp)) {
+            return -EINVAL;
+        }
+    } else {
+        hwpt_id = idev->hwpt_id;
+    }
+
+    ret = !host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp);
+    trace_vtd_device_attach_hwpt(idev->devid, vtd_as->pasid, hwpt_id, ret);
+    if (!ret) {
+        vtd_destroy_s1_hwpt(idev, vtd_as);
+        if (vtd_pe_pgtt_is_flt(pe)) {
+            vtd_as->s1_hwpt = hwpt_id;
+        }
+    } else if (vtd_pe_pgtt_is_flt(pe)) {
+        iommufd_backend_free_id(idev->iommufd, hwpt_id);
+    }
+
+    return ret;
+}
+
+static int vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
+                                     VTDAddressSpace *vtd_as, Error **errp)
+{
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+    uint32_t pasid = vtd_as->pasid;
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
+    if (!ret) {
+        vtd_destroy_s1_hwpt(idev, vtd_as);
+    }
+
+    return ret;
+}
+
+static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, VTDPASIDOp op,
+                                Error **errp)
+{
+    IntelIOMMUState *s = vtd_as->iommu_state;
+    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(s, vtd_as);
+    int ret;
+
+    if (!vtd_hiod) {
+        /* No need to go further, e.g. for emulated device */
+        return 0;
+    }
+
+    if (vtd_as->pasid != PCI_NO_PASID) {
+        error_setg(errp, "Non-rid_pasid %d not supported yet", vtd_as->pasid);
+        return -EINVAL;
+    }
+
+    switch (op) {
+    case VTD_PASID_UPDATE:
+    case VTD_PASID_BIND:
+    {
+        ret = vtd_device_attach_iommufd(vtd_hiod, vtd_as, errp);
+        break;
+    }
+    case VTD_PASID_UNBIND:
+    {
+        ret = vtd_device_detach_iommufd(vtd_hiod, vtd_as, errp);
+        break;
+    }
+    default:
+        error_setg(errp, "Unknown VTDPASIDOp!!!");
+        break;
+    }
+
+    return ret;
+}
+#else
+static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, VTDPASIDOp op,
+                                Error **errp)
+{
+    return 0;
+}
+#endif
+
+static int vtd_bind_guest_pasid_report_err(VTDAddressSpace *vtd_as,
+                                           VTDPASIDOp op)
+{
+    Error *local_err = NULL;
+    int ret;
+
+    /*
+     * vIOMMU calls into kernel to do BIND/UNBIND, the failure reason
+     * can be kernel, QEMU bug or invalid guest config. None of them
+     * should be reported to guest in PASID cache invalidation
+     * processing path. But at least, we can report it to QEMU console.
+     *
+     * TODO: for invalid guest config, DMA translation fault will be
+     * caught by host and passed to QEMU to inject to guest in future.
+     */
+    ret = vtd_bind_guest_pasid(vtd_as, op, &local_err);
+    if (ret) {
+        error_report_err(local_err);
+    }
+
+    return ret;
+}
+
 /* Do a context-cache device-selective invalidation.
  * @func_mask: FM field after shifting
  */
@@ -3234,10 +3434,20 @@ static gboolean vtd_flush_pasid_locked(gpointer key, gpointer value,
     /* No need to update if cached pasid entry is latest */
     if (!vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
         pc_entry->pasid_entry = pe;
+        if (vtd_bind_guest_pasid_report_err(vtd_as, VTD_PASID_UPDATE)) {
+            /*
+             * In case update binding fails, tear down existing binding to
+             * catch invalid pasid entry config during DMA translation.
+             */
+            goto remove;
+        }
     }
     return false;
 
 remove:
+    if (vtd_bind_guest_pasid_report_err(vtd_as, VTD_PASID_UNBIND)) {
+        return false;
+    }
     pc_entry->valid = false;
 
     /*
@@ -3317,6 +3527,9 @@ static void vtd_sm_pasid_table_walk_one(IntelIOMMUState *s,
             if (!pc_entry->valid) {
                 pc_entry->pasid_entry = pe;
                 pc_entry->valid = true;
+                if (vtd_bind_guest_pasid_report_err(vtd_as, VTD_PASID_BIND)) {
+                    pc_entry->valid = false;
+                }
             }
         }
         pasid++;
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 887f93bac9..c87e59554d 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -563,6 +563,12 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
 
+typedef enum VTDPASIDOp {
+    VTD_PASID_BIND,
+    VTD_PASID_UPDATE,
+    VTD_PASID_UNBIND,
+} VTDPASIDOp;
+
 typedef enum VTDPCInvType {
     /* VTD spec defined PASID cache invalidation type */
     VTD_PASID_CACHE_DOMSI = VTD_INV_DESC_PASIDC_G_DSI,
@@ -611,8 +617,12 @@ typedef struct VTDPASIDCacheInfo {
 #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
 #define VTD_SM_PASID_ENTRY_DID(x)      extract64((x)->val[1], 0, 16)
 
-#define VTD_SM_PASID_ENTRY_FLPM          3ULL
-#define VTD_SM_PASID_ENTRY_FLPTPTR       (~0xfffULL)
+#define VTD_SM_PASID_ENTRY_FSPTPTR       (~0xfffULL)
+#define VTD_SM_PASID_ENTRY_SRE_BIT(x)    extract64((x)->val[2], 0, 1)
+/* 00: 4-level paging, 01: 5-level paging, 10-11: Reserved */
+#define VTD_SM_PASID_ENTRY_FSPM(x)       extract64((x)->val[2], 2, 2)
+#define VTD_SM_PASID_ENTRY_WPE_BIT(x)    extract64((x)->val[2], 4, 1)
+#define VTD_SM_PASID_ENTRY_EAFE_BIT(x)   extract64((x)->val[2], 7, 1)
 
 /* First Level Paging Structure */
 /* Masks for First Level Paging Entry */
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
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 0e3826f6f0..2affab36b2 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -104,6 +104,7 @@ struct VTDAddressSpace {
     PCIBus *bus;
     uint8_t devfn;
     uint32_t pasid;
+    uint32_t s1_hwpt;
     AddressSpace as;
     IOMMUMemoryRegion iommu;
     MemoryRegion root;          /* The root container of the device */
-- 
2.47.1


