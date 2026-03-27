Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67ACA10A1E63
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 02:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5xJc-0005ZP-GI; Thu, 26 Mar 2026 22:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5xJb-0005Yv-Q0
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 22:52:51 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5xJZ-00083n-RR
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 22:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774579970; x=1806115970;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=T8DAD5tE38GCGGVWeB3QBF5UFIhEbTKi26Zdi2eyGqo=;
 b=nGJ936MV90CBV5zJwkHYFM8X8xHwKEbr1WUCAMhtdyF5FVKjPMfZhrDb
 37hiTUnXWVtfO/rEP2Z5u7zxP0iJNpfjcHR1xXEuMxbB/PweKSHT1BdhG
 mZ+rHbMarVBS/YNdJbsAqHoyZ5P2O8CqeLls6LQxbtQBJeI8OvjhObn/Z
 ItVaHlP0CXk8ueiRFZVkVtXmDTfLX5H5Bdn1fERh707rBb+3ShpH0Zjf8
 dX7dDNBZy7qLG9//iUE2t/mYGtsZ3AVoa6QIeRgKTM58OW+x94B78xOqu
 Y9jSBsuDu2GhZ5k8YalAK+X26wq6J0nvtDHDgwqkkm0I55jdXkpJ+Iwdb g==;
X-CSE-ConnectionGUID: wFM//lVwRK+T6PVzzZfBgQ==
X-CSE-MsgGUID: facymgSJS3WC+JWycgoVyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75719900"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="75719900"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 19:52:49 -0700
X-CSE-ConnectionGUID: v8u9LllDT4+5BHkm1Z2odQ==
X-CSE-MsgGUID: RPBLwyPuQbyKxSdBf4Zt0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="221874388"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 19:52:46 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 3/5] intel_iommu_accel: Add PRQ injection for passthrough
 device
Date: Thu, 26 Mar 2026 22:52:25 -0400
Message-ID: <20260327025228.474257-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327025228.474257-1-zhenzhong.duan@intel.com>
References: <20260327025228.474257-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
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
---
 hw/i386/intel_iommu_accel.h |   2 +
 hw/i386/intel_iommu_accel.c | 151 +++++++++++++++++++++++++++++++++++-
 hw/i386/trace-events        |   1 +
 3 files changed, 150 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index 45a12e0292..10e6ee5722 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -17,6 +17,8 @@ typedef struct VTDAccelPASIDCacheEntry {
     VTDPASIDEntry pasid_entry;
     uint32_t pasid;
     uint32_t fs_hwpt_id;
+    uint32_t fault_id;
+    int fault_fd;
     QLIST_ENTRY(VTDAccelPASIDCacheEntry) next;
 } VTDAccelPASIDCacheEntry;
 
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 32cca7672a..0fce62ff75 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -9,6 +9,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "system/iommufd.h"
 #include "intel_iommu_internal.h"
 #include "intel_iommu_accel.h"
@@ -38,6 +39,8 @@ static inline int vtd_hiod_get_pe_from_pasid(VTDAccelPASIDCacheEntry *vtd_pce,
     return vtd_ce_get_pasid_entry(s, &ce, pe, pasid);
 }
 
+static PCIIOMMUOps *accel_ops;
+
 bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                           Error **errp)
 {
@@ -99,8 +102,137 @@ VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
     return NULL;
 }
 
-static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
-                               VTDPASIDEntry *pe, uint32_t *fs_hwpt_id,
+static void vtd_prq_report_fault(VTDAccelPASIDCacheEntry *vtd_pce,
+                                 struct iommu_hwpt_pgfault *fault, int cnt)
+{
+    VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
+
+    for (; cnt--; fault++) {
+        bool last_page = fault->flags & IOMMU_PGFAULT_FLAGS_LAST_PAGE;
+
+        accel_ops->pri_request_page(vtd_hiod->bus, vtd_hiod->iommu_state,
+                                    vtd_hiod->devfn, vtd_pce->pasid,
+                                    fault->perm & IOMMU_PGFAULT_PERM_PRIV,
+                                    fault->perm & IOMMU_PGFAULT_PERM_EXEC,
+                                    fault->addr, last_page, fault->grpid,
+                                    fault->perm & IOMMU_PGFAULT_PERM_READ,
+                                    fault->perm & IOMMU_PGFAULT_PERM_WRITE);
+    }
+}
+
+#define FAULTQ_BUF_SIZE 100 /* Large enough in regular test */
+
+static void vtd_prq_read_fault(void *opaque)
+{
+    VTDAccelPASIDCacheEntry *vtd_pce = opaque;
+    struct iommu_hwpt_pgfault fault[FAULTQ_BUF_SIZE];
+    uint32_t id = vtd_pce->fault_id, fd = vtd_pce->fault_fd;
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
+                                  uint32_t fault_id, uint32_t fault_fd)
+{
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+
+    if (!fault_id) {
+        return;
+    }
+
+    close(fault_fd);
+    iommufd_backend_free_id(idev->iommufd, fault_id);
+}
+
+static bool vtd_create_fs_faultq(VTDHostIOMMUDevice *vtd_hiod,
+                                 uint32_t *fault_id_p, uint32_t *fault_fd_p,
+                                 Error **errp)
+{
+    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
+    IntelIOMMUState *s = vtd_hiod->iommu_state;
+    uint8_t bus_n = pci_bus_num(vtd_hiod->bus);
+    uint32_t fault_id, fault_fd;
+    VTDContextEntry ce;
+    int flags;
+
+    if (!s->svm ||
+        vtd_dev_to_context_entry(s, bus_n, vtd_hiod->devfn, &ce) ||
+        !VTD_CE_GET_PRE(&ce)) {
+        *fault_id_p = 0;
+        return true;
+    }
+
+    if (!iommufd_backend_alloc_faultq(idev->iommufd, &fault_id, &fault_fd,
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
+static void vtd_destroy_old_fs_faultq(VTDHostIOMMUDevice *vtd_hiod,
+                                      VTDAccelPASIDCacheEntry *vtd_pce)
+{
+    if (!vtd_pce->fault_id) {
+        return;
+    }
+
+    qemu_set_fd_handler(vtd_pce->fault_fd, NULL, NULL, NULL);
+    vtd_destroy_fs_faultq(vtd_hiod, vtd_pce->fault_id, vtd_pce->fault_fd);
+    vtd_pce->fault_id = 0;
+    vtd_pce->fault_fd = -1;
+}
+
+static void vtd_setup_fs_faultq(VTDAccelPASIDCacheEntry *vtd_pce,
+                                uint32_t fault_id, uint32_t fault_fd)
+{
+    if (!fault_id) {
+        return;
+    }
+
+    vtd_pce->fault_id = fault_id;
+    vtd_pce->fault_fd = fault_fd;
+    qemu_set_fd_handler(fault_fd, vtd_prq_read_fault, NULL, vtd_pce);
+}
+
+static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod, VTDPASIDEntry *pe,
+                               uint32_t fault_id, uint32_t *fs_hwpt_id,
                                Error **errp)
 {
     HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
@@ -115,7 +247,8 @@ static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
 
     return iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, idev->hwpt_id,
                                       flags, IOMMU_HWPT_DATA_VTD_S1,
-                                      sizeof(vtd), &vtd, 0, fs_hwpt_id, errp);
+                                      sizeof(vtd), &vtd, fault_id, fs_hwpt_id,
+                                      errp);
 }
 
 static void vtd_destroy_old_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
@@ -137,6 +270,7 @@ static bool vtd_device_attach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
     HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
     VTDPASIDEntry *pe = &vtd_pce->pasid_entry;
     uint32_t hwpt_id = idev->hwpt_id, pasid = vtd_pce->pasid;
+    uint32_t fault_id = 0, fault_fd;
     bool ret;
 
     /*
@@ -151,7 +285,11 @@ static bool vtd_device_attach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
     }
 
     if (vtd_pe_pgtt_is_fst(pe)) {
-        if (!vtd_create_fs_hwpt(vtd_hiod, pe, &hwpt_id, errp)) {
+        if (!vtd_create_fs_faultq(vtd_hiod, &fault_id, &fault_fd, errp)) {
+            return false;
+        }
+        if (!vtd_create_fs_hwpt(vtd_hiod, pe, fault_id, &hwpt_id, errp)) {
+            vtd_destroy_fs_faultq(vtd_hiod, fault_id, fault_fd);
             return false;
         }
     }
@@ -161,11 +299,14 @@ static bool vtd_device_attach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
     if (ret) {
         /* Destroy old fs_hwpt if it's a replacement */
         vtd_destroy_old_fs_hwpt(vtd_hiod, vtd_pce);
+        vtd_destroy_old_fs_faultq(vtd_hiod, vtd_pce);
         if (vtd_pe_pgtt_is_fst(pe)) {
             vtd_pce->fs_hwpt_id = hwpt_id;
+            vtd_setup_fs_faultq(vtd_pce, fault_id, fault_fd);
         }
     } else if (vtd_pe_pgtt_is_fst(pe)) {
         iommufd_backend_free_id(idev->iommufd, hwpt_id);
+        vtd_destroy_fs_faultq(vtd_hiod, fault_id, fault_fd);
     }
 
     return ret;
@@ -197,6 +338,7 @@ static bool vtd_device_detach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
 
     if (ret) {
         vtd_destroy_old_fs_hwpt(vtd_hiod, vtd_pce);
+        vtd_destroy_old_fs_faultq(vtd_hiod, vtd_pce);
     }
 
     return ret;
@@ -549,4 +691,5 @@ static uint64_t vtd_get_host_iommu_quirks(uint32_t type,
 void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)
 {
     ops->get_host_iommu_quirks = vtd_get_host_iommu_quirks;
+    accel_ops = ops;
 }
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 5fa5e93b68..bf139338f7 100644
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
2.47.3


