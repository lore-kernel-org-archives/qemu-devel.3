Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F742CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 03:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa3kf-0004tp-Tq; Wed, 17 Jun 2026 23:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wa3ke-0004tc-RL
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 23:49:12 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wa3kc-0008Ok-Uo
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 23:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781754551; x=1813290551;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rEpujAGK/nt0r4LFddKz9PkxpaKym/EJ7c+0UEF3XSA=;
 b=NsD8gAH9dYID0+hlAiNlIWPd1YNMjPHt1cNqHJoPRK/U3OXTzPF/Ra4R
 01/AIW+6B++SVU6VBhvBJeUWuhBiX3JIAv0Z2T14ZkGx+PuybMKyzZnO7
 /Lgn5nGhAyKyyskXYdAUKgXUw51CieWh22SwnbjprPOZExyij/aBhLEXg
 lWAYJj1CEMZ8CGTFankIYVZpTUdIEPDBZkivgLhH/wuVj9XNoJ8rgKpJt
 wIXlsLyiblKeQ79HosbR1OWHtr5HPAG8CJwF6nhUXcTux1XUWPucCTYRM
 qkZFsILBh3i25kNv5XtV7pqi6uNmsuScXSo+pjV2AvHz4qn99wCk5JMmT A==;
X-CSE-ConnectionGUID: qpDXRK6tRJWkBuRF/WrMCw==
X-CSE-MsgGUID: fBDyhce4QWqpu8ulPTU+dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82776852"
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; d="scan'208";a="82776852"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 20:49:10 -0700
X-CSE-ConnectionGUID: jzcHC2UxR9KVCM+9fZxw+Q==
X-CSE-MsgGUID: 0w905qVFTCalmrdZ52nS6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; d="scan'208";a="253352732"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 20:49:07 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 4/5] intel_iommu_accel: Accept PRQ response for passthrough
 device
Date: Wed, 17 Jun 2026 23:48:42 -0400
Message-ID: <20260618034844.618011-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260618034844.618011-1-zhenzhong.duan@intel.com>
References: <20260618034844.618011-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Propagate guest's PRQ response to host by writing to fault_fd.
Create a new VTDPRQEntry to cache cookie for each fault group,
this cookie is used to mark the fault group on host side.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 hw/i386/intel_iommu_accel.h   | 12 +++++++
 include/hw/i386/intel_iommu.h |  6 ++++
 hw/i386/intel_iommu.c         |  4 +++
 hw/i386/intel_iommu_accel.c   | 59 +++++++++++++++++++++++++++++++++++
 hw/i386/trace-events          |  1 +
 5 files changed, 82 insertions(+)

diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index d861f0f648..b508f05cde 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -19,6 +19,7 @@ typedef struct VTDAccelPASIDCacheEntry {
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
index 744cdfd2e6..2e867817aa 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3371,6 +3371,10 @@ static bool vtd_process_page_group_response_desc(IntelIOMMUState *s,
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
index fe09de07e2..9746355cd6 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -80,6 +80,57 @@ VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
     return NULL;
 }
 
+static void vtd_prq_response_notify(VTDAccelPASIDCacheEntry *vtd_pce,
+                                    IOMMUPRIResponse *response)
+{
+    struct iommu_hwpt_page_response resp;
+    uint32_t id = vtd_pce->fault_id;
+    int fd = vtd_pce->fault_fd;
+    VTDPRQEntry *prqe, *tmp;
+    ssize_t bytes;
+
+    QLIST_FOREACH_SAFE(prqe, &vtd_pce->vtd_prq_list, next, tmp) {
+        if (prqe->grpid != response->prgi) {
+            continue;
+        }
+
+        resp.cookie = prqe->cookie;
+        resp.code = response->response_code;
+        bytes = write(fd, &resp, sizeof(resp));
+        trace_vtd_prq_response_notify(id, fd, resp.cookie, resp.code, bytes);
+        if (bytes < 0) {
+            error_report_once("FAULTQ(id %u): write failed "
+                              "[cookie 0x%x code 0x%x] (%m)",
+                              id, resp.cookie, resp.code);
+        }
+
+        QLIST_REMOVE(prqe, next);
+        g_free(prqe);
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
+            vtd_prq_response_notify(vtd_pce, response);
+            return true;
+        }
+    }
+
+    return false;
+}
+
 static void vtd_prq_report_fault(VTDAccelPASIDCacheEntry *vtd_pce,
                                  struct iommu_hwpt_pgfault *fault, int cnt)
 {
@@ -95,6 +146,13 @@ static void vtd_prq_report_fault(VTDAccelPASIDCacheEntry *vtd_pce,
                                     fault->addr, last_page, fault->grpid,
                                     fault->perm & IOMMU_PGFAULT_PERM_READ,
                                     fault->perm & IOMMU_PGFAULT_PERM_WRITE);
+        if (last_page) {
+            VTDPRQEntry *prqe = g_malloc0(sizeof(*prqe));
+
+            prqe->grpid = fault->grpid;
+            prqe->cookie = fault->cookie;
+            QLIST_INSERT_HEAD(&vtd_pce->vtd_prq_list, prqe, next);
+        }
     }
 }
 
@@ -424,6 +482,7 @@ static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
     vtd_pce->pasid = pasid;
     vtd_pce->pasid_entry = *pe;
     vtd_pce->fault_fd = -1;
+    QLIST_INIT(&vtd_pce->vtd_prq_list);
     QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
 
     if (!vtd_device_attach_iommufd(vtd_pce, &local_err)) {
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 5168e00ad8..bbb2350f1d 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -78,6 +78,7 @@ vtd_device_attach_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int re
 vtd_device_detach_hwpt(uint32_t dev_id, uint32_t pasid, int ret) "dev_id %d pasid %d ret: %d"
 vtd_device_reattach_def_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
 vtd_prq_read_fault(uint32_t fault_id, uint32_t fault_fd, ssize_t bytes) "fault_id %d fault_fd %d ret: %zd"
+vtd_prq_response_notify(uint32_t fault_id, uint32_t fault_fd, uint32_t cookie, uint32_t code, ssize_t bytes) "fault_id %d fault_fd %d cookie %d code %d ret: %zd"
 
 # amd_iommu.c
 amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32
-- 
2.52.0


