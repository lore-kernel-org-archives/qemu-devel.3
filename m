Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69E6C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wymNA-0001tN-Iw; Tue, 25 Aug 2026 04:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wymN8-0001sg-Cd
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 04:19:06 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wymN6-0002Te-K9
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 04:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787645944; x=1819181944;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RF884tCrDh/H7+bOVL2xTPWGSNUO6ownEOTiJdOSHjI=;
 b=e/Kb+ZrEns6CJ43krM0hbcDy70EG+Oj+piQRB/kC47ct5QOw44ws6wQ2
 2cwUcolKQahGAVZUoepFmq4off2q5YBWhB/QiFsRS45dfWsLWR6snAe/Y
 D9HAYyCwCdmbq96MjaiFhbaFqULaoU7IQzKrVFVqSu5wIbhwAiC7BCjPX
 zO0RYjzIFejCwZlNfGBfrG7+JekvInMeavGyVgFgNsoJTlzk7wWEXnZtI
 SRWuQ8QTe6rnhpXNZu1gPTSA0JUFGPS7vDISx9I15EtKWHWopAb3D7q7e
 0YoBWCnRbZ2heA+vR3fYhLDYjwYkHHXd6w/DiyH4tAKIanWo8u6eH6t8n A==;
X-CSE-ConnectionGUID: I4y5lqUlQSW4itM1eW3XJQ==
X-CSE-MsgGUID: H1pGZTLoRg+CUtp5EhbB+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="87967101"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="87967101"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 01:19:04 -0700
X-CSE-ConnectionGUID: ZEIgmQjCRK+QXTjob8ieLA==
X-CSE-MsgGUID: Ur3mqWIFTCqtNbXuq28zmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="265905416"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.229.148])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 01:18:56 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v4 5/6] intel_iommu_accel: Accept PRQ response for passthrough
 device
Date: Tue, 25 Aug 2026 16:18:12 +0800
Message-ID: <20260825081814.138140-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260825081814.138140-1-zhenzhong.duan@intel.com>
References: <20260825081814.138140-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
index cc8c9205df..e34cbf2b10 100644
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
index da262b7863..e0bf0fbe60 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -78,6 +78,57 @@ VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
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
 /**
  * vtd_prq_report_fault - Report page requests / page faults to the guest
  * @vtd_pce: Pointer to the VTD accelerator PASID cache entry
@@ -103,6 +154,13 @@ static void vtd_prq_report_fault(VTDAccelPASIDCacheEntry *vtd_pce,
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
 
@@ -432,6 +490,7 @@ static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
     vtd_pce->pasid = pasid;
     vtd_pce->pasid_entry = *pe;
     vtd_pce->fault_fd = -1;
+    QLIST_INIT(&vtd_pce->vtd_prq_list);
     QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
 
     if (!vtd_device_attach_iommufd(vtd_pce, &local_err)) {
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index dca726c9b8..d3e83292d7 100644
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


