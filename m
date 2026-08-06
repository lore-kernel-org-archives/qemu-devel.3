Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DE9C55838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 07:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrsh7-0001rK-Nc; Thu, 06 Aug 2026 03:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wrsh3-0001qr-4Q
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 03:39:09 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wrsh0-0001eG-Hp
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 03:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786001947; x=1817537947;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EVCkBNgEpYeizPbjWNqywyWom3UyubjG9UxKr+A5loE=;
 b=Lht/bYDizjeIaR3Q79015qp84NVFewJmgP7erCofCn8ho7O3447TqLgy
 QpnHBxkzQ9acMVR5IdmXMEfH321lTMUUFaQEn/9M/oMaw+8TzwX+vw8Aq
 L/5Y8H2Sce34FJoB7BSb4U/i/KjnIbhffsl90ZpWqPVKBkltMibTW3i3R
 9kQjjwRCJhdEWxyTBndj1TYuFA1AfosFwoorf82D5aysItFarfqsZeW7O
 6bGNqIPc8ocYz3SZSt16HDR6JinDFbIt0Ck4d0ph4btCHZK2lwGL+TMYe
 UkyV2IW9kKQHtBqVSQ6j6uQnwBXmfmhIwLaT5W0+NhoW9Sh9X1Oa1sWSX w==;
X-CSE-ConnectionGUID: 1aaNag9LQkiRYCeM5GqVgA==
X-CSE-MsgGUID: c13jyGVpQOeSHbj8xYNAdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86662725"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="86662725"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 00:39:06 -0700
X-CSE-ConnectionGUID: 1abs3O5ySqOWYi1YJGIREg==
X-CSE-MsgGUID: yM2i3Kq6R2yFmuOI5f+ykg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="265507001"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 00:39:03 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 4/6] intel_iommu_accel: Add PRQ injection for passthrough
 device
Date: Thu,  6 Aug 2026 03:38:22 -0400
Message-ID: <20260806073825.363468-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260806073825.363468-1-zhenzhong.duan@intel.com>
References: <20260806073825.363468-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
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

When the guest enables the PRQ in vIOMMU, allocate a FAULTQ object so that
host-side recoverable fault events can be received and propagated back to
the guest.

Install an event handler on the FAULTQ fd to read and propagate host
generated recoverable fault events to the guest.

The handler runs in QEMU's main loop, using a non-blocking fd registered
via qemu_set_fd_handler().

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 hw/i386/intel_iommu_accel.h    |   2 +
 hw/i386/intel_iommu_internal.h |   3 +
 hw/i386/intel_iommu.c          |   7 +-
 hw/i386/intel_iommu_accel.c    | 161 +++++++++++++++++++++++++++++++--
 hw/i386/trace-events           |   1 +
 5 files changed, 164 insertions(+), 10 deletions(-)

diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index 46c1a29409..e0319749a5 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -18,6 +18,8 @@ typedef struct VTDAccelPASIDCacheEntry {
     VTDPASIDEntry pasid_entry;
     uint32_t pasid;
     uint32_t fs_hwpt_id;
+    uint32_t fault_id;
+    int fault_fd;
     QLIST_ENTRY(VTDAccelPASIDCacheEntry) next;
 } VTDAccelPASIDCacheEntry;
 
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 924e91cb8a..5ebc204e9a 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -786,4 +786,7 @@ int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
 VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUState *s, uint16_t sid);
 int vtd_dev_get_pe_from_pasid(IntelIOMMUState *s, PCIBus *bus, uint8_t devfn,
                               uint32_t pasid, VTDPASIDEntry *pe);
+int vtd_pri_request_page(PCIBus *bus, void *opaque, int devfn, uint32_t pasid,
+                         bool priv_req, bool exec_req, hwaddr addr, bool lpig,
+                         uint16_t prgi, bool is_read, bool is_write);
 #endif
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 82c3c3b2c3..cc8c9205df 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -5370,10 +5370,9 @@ static int vtd_pri_perform_implicit_invalidation(VTDAddressSpace *vtd_as,
 }
 
 /* Page Request Descriptor : 7.4.1.1 */
-static int vtd_pri_request_page(PCIBus *bus, void *opaque, int devfn,
-                                uint32_t pasid, bool priv_req, bool exec_req,
-                                hwaddr addr, bool lpig, uint16_t prgi,
-                                bool is_read, bool is_write)
+int vtd_pri_request_page(PCIBus *bus, void *opaque, int devfn, uint32_t pasid,
+                         bool priv_req, bool exec_req, hwaddr addr, bool lpig,
+                         uint16_t prgi, bool is_read, bool is_write)
 {
     IntelIOMMUState *s = opaque;
     VTDAddressSpace *vtd_as;
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index d2f41f18f1..79bfe763fc 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -9,6 +9,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "system/iommufd.h"
 #include "intel_iommu_internal.h"
 #include "intel_iommu_accel.h"
@@ -77,14 +78,151 @@ VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
     return NULL;
 }
 
-static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
-                               VTDPASIDEntry *pe, uint32_t *fs_hwpt_id,
-                               Error **errp)
+static void vtd_prq_report_fault(VTDAccelPASIDCacheEntry *vtd_pce,
+                                 struct iommu_hwpt_pgfault *fault, int cnt)
+{
+    VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
+    /* vtd_pri_request_page() accept PCI pasid as input */
+    uint32_t pasid =
+        vtd_pce->pasid == IOMMU_NO_PASID ? PCI_NO_PASID : vtd_pce->pasid;
+
+    for (; cnt--; fault++) {
+        bool last_page = fault->flags & IOMMU_PGFAULT_FLAGS_LAST_PAGE;
+
+        vtd_pri_request_page(vtd_hiod->bus, vtd_hiod->iommu_state,
+                             vtd_hiod->devfn, pasid,
+                             fault->perm & IOMMU_PGFAULT_PERM_PRIV,
+                             fault->perm & IOMMU_PGFAULT_PERM_EXEC,
+                             fault->addr, last_page, fault->grpid,
+                             fault->perm & IOMMU_PGFAULT_PERM_READ,
+                             fault->perm & IOMMU_PGFAULT_PERM_WRITE);
+    }
+}
+
+/* Batch size per read(); remaining faults trigger another callback */
+#define FAULTQ_BUF_SIZE 100
+
+static void vtd_prq_read_fault(void *opaque)
+{
+    VTDAccelPASIDCacheEntry *vtd_pce = opaque;
+    struct iommu_hwpt_pgfault fault[FAULTQ_BUF_SIZE];
+    uint32_t id = vtd_pce->fault_id;
+    int fd = vtd_pce->fault_fd;
+    ssize_t bytes, last_bytes;
+
+    bytes = read(fd, fault, sizeof(fault));
+    trace_vtd_prq_read_fault(id, fd, bytes);
+    if (bytes < 0) {
+        if (errno != EAGAIN && errno != EINTR) {
+            error_report_once("FAULTQ(id %u): read failed (%m)", id);
+        }
+        return;
+    } else if (!bytes) {
+        error_report_once("FAULTQ(id %u): fault group too big", id);
+        return;
+    }
+
+    last_bytes = bytes % sizeof(fault[0]);
+    if (last_bytes) {
+        error_report_once("FAULTQ(id %u): discard partial fault data: %zd/%zu",
+                          id, last_bytes, sizeof(fault));
+    }
+
+    vtd_prq_report_fault(vtd_pce, fault, bytes / sizeof(fault[0]));
+}
+
+static void vtd_destroy_fs_faultq(VTDHostIOMMUDevice *vtd_hiod,
+                                  uint32_t fault_id, int fault_fd)
+{
+    HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+
+    if (fault_fd < 0) {
+        return;
+    }
+
+    close(fault_fd);
+    iommufd_backend_free_id(hiodi->iommufd, fault_id);
+}
+
+static bool vtd_create_fs_faultq(VTDHostIOMMUDevice *vtd_hiod,
+                                 uint32_t *fault_id_p, int *fault_fd_p,
+                                 Error **errp)
+{
+    HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+    IntelIOMMUState *s = vtd_hiod->iommu_state;
+    uint8_t bus_n = pci_bus_num(vtd_hiod->bus);
+    uint32_t fault_id;
+    VTDContextEntry ce;
+    int flags, fault_fd;
+
+    if (!s->svm ||
+        vtd_dev_to_context_entry(s, bus_n, vtd_hiod->devfn, &ce) ||
+        !VTD_CE_GET_PRE(&ce)) {
+        *fault_id_p = 0;
+        *fault_fd_p = -1;
+        return true;
+    }
+
+    if (!iommufd_backend_alloc_faultq(hiodi->iommufd, &fault_id, &fault_fd,
+                                      errp)) {
+        return false;
+    }
+
+    flags = fcntl(fault_fd, F_GETFL);
+    if (flags < 0) {
+        error_setg_errno(errp, errno, "Failed to get flags for FAULTQ fd");
+        goto free_faultq;
+    }
+
+    if (fcntl(fault_fd, F_SETFL, flags | O_NONBLOCK) < 0) {
+        error_setg_errno(errp, errno, "Failed to set O_NONBLOCK on FAULTQ fd");
+        goto free_faultq;
+    }
+
+    *fault_id_p = fault_id;
+    *fault_fd_p = fault_fd;
+    return true;
+
+free_faultq:
+    vtd_destroy_fs_faultq(vtd_hiod, fault_id, fault_fd);
+    return false;
+}
+
+static void vtd_destroy_old_fs_faultq(VTDAccelPASIDCacheEntry *vtd_pce)
+{
+    if (vtd_pce->fault_fd < 0) {
+        return;
+    }
+
+    qemu_set_fd_handler(vtd_pce->fault_fd, NULL, NULL, NULL);
+    vtd_destroy_fs_faultq(vtd_pce->vtd_hiod, vtd_pce->fault_id,
+                          vtd_pce->fault_fd);
+    vtd_pce->fault_id = 0;
+    vtd_pce->fault_fd = -1;
+}
+
+static void vtd_setup_fs_faultq(VTDAccelPASIDCacheEntry *vtd_pce,
+                                uint32_t fault_id, int fault_fd)
+{
+    if (fault_fd < 0) {
+        return;
+    }
+
+    vtd_pce->fault_id = fault_id;
+    vtd_pce->fault_fd = fault_fd;
+    qemu_set_fd_handler(fault_fd, vtd_prq_read_fault, NULL, vtd_pce);
+}
+
+static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod, VTDPASIDEntry *pe,
+                               bool has_fault_id, uint32_t fault_id,
+                               uint32_t *fs_hwpt_id, Error **errp)
 {
     HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
     struct iommu_hwpt_vtd_s1 vtd = {};
     uint32_t flags = vtd_hiod->iommu_state->pasid ? IOMMU_HWPT_ALLOC_PASID : 0;
 
+    flags |= has_fault_id ? IOMMU_HWPT_FAULT_ID_VALID : 0;
+
     vtd.flags = (VTD_SM_PASID_ENTRY_SRE(pe) ? IOMMU_VTD_S1_SRE : 0) |
                 (VTD_SM_PASID_ENTRY_WPE(pe) ? IOMMU_VTD_S1_WPE : 0) |
                 (VTD_SM_PASID_ENTRY_EAFE(pe) ? IOMMU_VTD_S1_EAFE : 0);
@@ -94,7 +232,7 @@ static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
     return iommufd_backend_alloc_hwpt(hiodi->iommufd, hiodi->devid,
                                       hiodi->hwpt_id, flags,
                                       IOMMU_HWPT_DATA_VTD_S1, sizeof(vtd), &vtd,
-                                      0, fs_hwpt_id, errp);
+                                      fault_id, fs_hwpt_id, errp);
 }
 
 static void vtd_destroy_old_fs_hwpt(VTDAccelPASIDCacheEntry *vtd_pce)
@@ -115,7 +253,8 @@ static bool vtd_device_attach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
     VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
     HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
     VTDPASIDEntry *pe = &vtd_pce->pasid_entry;
-    uint32_t hwpt_id = hiodi->hwpt_id, pasid = vtd_pce->pasid;
+    uint32_t hwpt_id = hiodi->hwpt_id, pasid = vtd_pce->pasid, fault_id = 0;
+    int fault_fd = -1;
     bool ret;
 
     /*
@@ -130,7 +269,12 @@ static bool vtd_device_attach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
     }
 
     if (vtd_pe_pgtt_is_fst(pe)) {
-        if (!vtd_create_fs_hwpt(vtd_hiod, pe, &hwpt_id, errp)) {
+        if (!vtd_create_fs_faultq(vtd_hiod, &fault_id, &fault_fd, errp)) {
+            return false;
+        }
+        if (!vtd_create_fs_hwpt(vtd_hiod, pe, fault_fd >= 0, fault_id,
+                                &hwpt_id, errp)) {
+            vtd_destroy_fs_faultq(vtd_hiod, fault_id, fault_fd);
             return false;
         }
     }
@@ -140,11 +284,14 @@ static bool vtd_device_attach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
     if (ret) {
         /* Destroy old fs_hwpt if it's a replacement */
         vtd_destroy_old_fs_hwpt(vtd_pce);
+        vtd_destroy_old_fs_faultq(vtd_pce);
         if (vtd_pe_pgtt_is_fst(pe)) {
             vtd_pce->fs_hwpt_id = hwpt_id;
+            vtd_setup_fs_faultq(vtd_pce, fault_id, fault_fd);
         }
     } else if (vtd_pe_pgtt_is_fst(pe)) {
         iommufd_backend_free_id(hiodi->iommufd, hwpt_id);
+        vtd_destroy_fs_faultq(vtd_hiod, fault_id, fault_fd);
     }
 
     return ret;
@@ -177,6 +324,7 @@ static bool vtd_device_detach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
 
     if (ret) {
         vtd_destroy_old_fs_hwpt(vtd_pce);
+        vtd_destroy_old_fs_faultq(vtd_pce);
     }
 
     return ret;
@@ -276,6 +424,7 @@ static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
     vtd_pce->vtd_hiod = vtd_hiod;
     vtd_pce->pasid = pasid;
     vtd_pce->pasid_entry = *pe;
+    vtd_pce->fault_fd = -1;
     QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
 
     if (!vtd_device_attach_iommufd(vtd_pce, &local_err)) {
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index a1a50d0910..dca726c9b8 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -77,6 +77,7 @@ vtd_reset_exit(void) ""
 vtd_device_attach_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
 vtd_device_detach_hwpt(uint32_t dev_id, uint32_t pasid, int ret) "dev_id %d pasid %d ret: %d"
 vtd_device_reattach_def_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
+vtd_prq_read_fault(uint32_t fault_id, uint32_t fault_fd, ssize_t bytes) "fault_id %d fault_fd %d ret: %zd"
 
 # amd_iommu.c
 amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32
-- 
2.52.0


