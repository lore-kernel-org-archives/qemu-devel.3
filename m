Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FE8606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MAAyp6IQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ61R-0006eF-2X; Tue, 20 Oct 2026 05:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xJ61M-0006dy-1L
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 05:20:36 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xJ61J-0005a1-VG
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 05:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792488034; x=1824024034;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HTWeiTScuBzcGAmB63p8YfXT4wQ4XcOXONb8/5dvYvE=;
 b=MAAyp6IQ9zA881mlWLkv1SjSAI9O21uT5x0L5YPBhgA8b1S4RREW2HvQ
 d/oVVpFF+/h/XaWIZIpgOsZiQ+iU/ki2aiGYztdLD8kXzZRJCT5sCbmOf
 XiDApliQz9j/yhTXu3+BGe9GulP+E+hqrWiWBb6SIJDNxBPO3FaKWhyJI
 lYvF/T8VH192KvbMQnhEMltXh9XrQ9UH8Ldzzk76Q0xVB+E4v7stZBQr8
 xM8foxjadGTi4p3nvrq/6Ic8WvlmBPMBAePUTyYYrF9rUZvE7PbYlHoKU
 MG4LgdVIJpIJZj4z+en8iqP44GZHQN7rpdpoaMRy2RIZKul+dRLHFboKs w==;
X-CSE-ConnectionGUID: URihJDCCRH+YO7/CcOqvdA==
X-CSE-MsgGUID: Cji2x2uqTuiJyO9Me2hRlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1080673"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1080673"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 02:20:33 -0700
X-CSE-ConnectionGUID: 6ZYlZQTJRLqii+XM3oAoaw==
X-CSE-MsgGUID: XVt+FbnWQ1mLauISdKETEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3138378"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.229.148])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 02:20:30 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v9 5/6] intel_iommu_accel: Accept PRQ response for passthrough
 device
Date: Tue, 20 Oct 2026 17:19:53 +0800
Message-ID: <20261020091955.1607161-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261020091955.1607161-1-zhenzhong.duan@intel.com>
References: <20261020091955.1607161-1-zhenzhong.duan@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Propagate guest's PRQ response to host by writing to fault_fd.
Create a new VTDPRQEntry to cache cookie for each fault group,
this cookie is used to mark the fault group on host side.

If there is either PRQ overflow or full error condition, propagate
a success response to host for LPIG request with the PRQ requests
dropped. For other error conditions, propagate response of invalid
request.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 hw/i386/intel_iommu_accel.h   |  12 ++++
 include/hw/i386/intel_iommu.h |   6 ++
 hw/i386/intel_iommu.c         |   4 ++
 hw/i386/intel_iommu_accel.c   | 102 +++++++++++++++++++++++++++++++---
 hw/i386/trace-events          |   1 +
 5 files changed, 118 insertions(+), 7 deletions(-)

diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index e0319749a5..0cc22b2cbb 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -20,6 +20,7 @@ typedef struct VTDAccelPASIDCacheEntry {
     uint32_t fs_hwpt_id;
     uint32_t fault_id;
     int fault_fd;
+    QLIST_HEAD(, VTDPRQEntry) vtd_prq_list;
     QLIST_ENTRY(VTDAccelPASIDCacheEntry) next;
 } VTDAccelPASIDCacheEntry;
 
@@ -31,6 +32,9 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
                                       uint64_t npages, bool ih);
 void vtd_accel_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info);
 void vtd_accel_pasid_cache_reset(IntelIOMMUState *s);
+bool vtd_accel_propagate_page_group_response(IntelIOMMUState *s,
+                                             uint16_t rid, uint32_t pasid,
+                                             IOMMUPRIResponse *response);
 void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops);
 #else
 static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
@@ -69,6 +73,14 @@ static inline void vtd_accel_pasid_cache_reset(IntelIOMMUState *s)
 {
 }
 
+static inline
+bool vtd_accel_propagate_page_group_response(IntelIOMMUState *s,
+                                             uint16_t rid, uint32_t pasid,
+                                             IOMMUPRIResponse *response)
+{
+    return false;
+}
+
 static inline void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)
 {
 }
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 1842ba5840..5d44eac0ed 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -100,6 +100,12 @@ typedef struct VTDPASIDCacheEntry {
     bool valid;
 } VTDPASIDCacheEntry;
 
+typedef struct VTDPRQEntry {
+    uint32_t grpid;
+    uint32_t cookie;
+    QLIST_ENTRY(VTDPRQEntry) next;
+} VTDPRQEntry;
+
 struct VTDAddressSpace {
     PCIBus *bus;
     uint8_t devfn;
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 81c53c6f5a..4c2347e7d2 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3380,6 +3380,10 @@ static bool vtd_process_page_group_response_desc(IntelIOMMUState *s,
         response.response_code = IOMMU_PRI_RESP_FAILURE;
     }
 
+    if (vtd_accel_propagate_page_group_response(s, rid, pasid, &response)) {
+        return true;
+    }
+
     if (vtd_dev_as->pri_notifier) {
         vtd_dev_as->pri_notifier->notify(vtd_dev_as->pri_notifier, &response);
     }
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index bcd361bae3..243501f137 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -17,6 +17,9 @@
 #include "hw/pci/pci_bus.h"
 #include "trace.h"
 
+static void vtd_write_fs_faultq(VTDAccelPASIDCacheEntry *vtd_pce,
+                                uint32_t cookie, uint32_t code);
+
 bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                           Error **errp)
 {
@@ -84,6 +87,46 @@ VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
     return NULL;
 }
 
+static void vtd_prq_handle_pasid_response(VTDAccelPASIDCacheEntry *vtd_pce,
+                                          IOMMUPRIResponse *response)
+{
+    VTDPRQEntry *prqe, *tmp;
+
+    QLIST_FOREACH_SAFE(prqe, &vtd_pce->vtd_prq_list, next, tmp) {
+        if (prqe->grpid != response->prgi) {
+            continue;
+        }
+
+        vtd_write_fs_faultq(vtd_pce, prqe->cookie, response->response_code);
+
+        QLIST_REMOVE(prqe, next);
+        g_free(prqe);
+        break;
+    }
+}
+
+bool vtd_accel_propagate_page_group_response(IntelIOMMUState *s,
+                                             uint16_t rid, uint32_t pasid,
+                                             IOMMUPRIResponse *response)
+{
+    VTDAddressSpace *vtd_as = vtd_get_as_by_sid(s, rid);
+    VTDAccelPASIDCacheEntry *vtd_pce;
+    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(vtd_as);
+
+    if (!vtd_hiod) {
+        return false;
+    }
+
+    QLIST_FOREACH(vtd_pce, &vtd_hiod->pasid_cache_list, next) {
+        if (vtd_pce->pasid == pasid) {
+            vtd_prq_handle_pasid_response(vtd_pce, response);
+            return true;
+        }
+    }
+
+    return false;
+}
+
 static void vtd_propagate_recoverable_faults(VTDAccelPASIDCacheEntry *vtd_pce,
                                              struct iommu_hwpt_pgfault *fault,
                                              unsigned cnt)
@@ -94,14 +137,42 @@ static void vtd_propagate_recoverable_faults(VTDAccelPASIDCacheEntry *vtd_pce,
 
     for (; cnt--; fault++) {
         bool last_page = fault->flags & IOMMU_PGFAULT_FLAGS_LAST_PAGE;
+        int ret;
+
+        ret = vtd_pri_request_page(vtd_hiod->bus, vtd_hiod->iommu_state,
+                                   vtd_hiod->devfn, pasid,
+                                   fault->perm & IOMMU_PGFAULT_PERM_PRIV,
+                                   fault->perm & IOMMU_PGFAULT_PERM_EXEC,
+                                   fault->addr, last_page, fault->grpid,
+                                   fault->perm & IOMMU_PGFAULT_PERM_READ,
+                                   fault->perm & IOMMU_PGFAULT_PERM_WRITE);
+        if (!last_page) {
+            continue;
+        }
+
+        if (!ret) {
+            VTDPRQEntry *prqe = g_malloc0(sizeof(*prqe));
 
-        vtd_pri_request_page(vtd_hiod->bus, vtd_hiod->iommu_state,
-                             vtd_hiod->devfn, pasid,
-                             fault->perm & IOMMU_PGFAULT_PERM_PRIV,
-                             fault->perm & IOMMU_PGFAULT_PERM_EXEC,
-                             fault->addr, last_page, fault->grpid,
-                             fault->perm & IOMMU_PGFAULT_PERM_READ,
-                             fault->perm & IOMMU_PGFAULT_PERM_WRITE);
+            prqe->grpid = fault->grpid;
+            prqe->cookie = fault->cookie;
+            QLIST_INSERT_HEAD(&vtd_pce->vtd_prq_list, prqe, next);
+            continue;
+        }
+
+        /*
+         * vt-d spec 7.4.1:
+         *
+         * Hardware generates page group response with code of success for
+         * PRQ overflow and PRQ full, with code of invalid request for
+         * other error conditions.
+         */
+        if (ret == -ENOSPC) {
+            vtd_write_fs_faultq(vtd_pce, fault->cookie,
+                                IOMMUFD_PAGE_RESP_SUCCESS);
+        } else {
+            vtd_write_fs_faultq(vtd_pce, fault->cookie,
+                                IOMMUFD_PAGE_RESP_INVALID);
+        }
     }
 }
 
@@ -138,6 +209,22 @@ static void vtd_read_fs_faultq(void *opaque)
                                      bytes / sizeof(faults[0]));
 }
 
+static void vtd_write_fs_faultq(VTDAccelPASIDCacheEntry *vtd_pce,
+                                uint32_t cookie, uint32_t code)
+{
+    struct iommu_hwpt_page_response resp = {.cookie = cookie, .code = code};
+    uint32_t id = vtd_pce->fault_id;
+    int fd = vtd_pce->fault_fd;
+    ssize_t bytes;
+
+    bytes = write(fd, &resp, sizeof(resp));
+    trace_vtd_write_fs_faultq(id, fd, cookie, code, bytes);
+    if (bytes < 0) {
+        error_report_once("FAULTQ(id %u): write failed "
+                          "[cookie 0x%x code 0x%x] (%m)", id, cookie, code);
+    }
+}
+
 static void vtd_destroy_fs_faultq(VTDHostIOMMUDevice *vtd_hiod,
                                   uint32_t fault_id, int fault_fd)
 {
@@ -438,6 +525,7 @@ static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
     vtd_pce->pasid = pasid;
     vtd_pce->pasid_entry = *pe;
     vtd_pce->fault_fd = -1;
+    QLIST_INIT(&vtd_pce->vtd_prq_list);
     QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
 
     if (!vtd_device_attach_iommufd(vtd_pce, &local_err)) {
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index ad84d106a4..7bf4cddd38 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -78,6 +78,7 @@ vtd_device_attach_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int re
 vtd_device_detach_hwpt(uint32_t dev_id, uint32_t pasid, int ret) "dev_id %d pasid %d ret: %d"
 vtd_device_reattach_def_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
 vtd_read_fs_faultq(uint32_t fault_id, uint32_t fault_fd, ssize_t ret) "fault_id %d fault_fd %d ret: %zd"
+vtd_write_fs_faultq(uint32_t fault_id, uint32_t fault_fd, uint32_t cookie, uint32_t code, ssize_t ret) "fault_id %d fault_fd %d cookie %d code %d ret: %zd"
 
 # amd_iommu.c
 amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32
-- 
2.52.0


