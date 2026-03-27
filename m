Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4764C10A62FF
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 02:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5xJh-0005ar-Um; Thu, 26 Mar 2026 22:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5xJf-0005aO-W0
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 22:52:56 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5xJd-00084r-W0
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 22:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774579974; x=1806115974;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2NHqSXESvD6JPIlwczaZ1cD/lSOgxjXB8JfRBi7E928=;
 b=Z1m6Ud2/hA9+9V2WMd3yjkJTbYYHymRmWyQO6wd5olOpC4h20DgXh/dg
 SGEblmQqUEx+sdkZJti93JQ4XtFWxBTOr2H63ZW6XOtfW22fpNCRcxLVz
 WMj7rJNqjc/I/tkdd1qudysRi9302Y+hQRrDh8X8kJkaprqzFGSa+Yhak
 JiD9pxOMj4c0ji2VwS5LsnjS3wDdrw25qo/p2dwvIj9ZFtpqJu/g2RCI0
 lC8oTEzggGAZyY96VQV4Q2dckMCQRIhh1YwX8sjJgidbfGbUuF8WOvpy3
 Wv+wWJhbRifEaYVhci9P6DOBXmAvi5UE8sjXU19zrtr0h8ZwKOleILzHv Q==;
X-CSE-ConnectionGUID: EZXbEOsFR0mAAXHPHU00Rw==
X-CSE-MsgGUID: dKQXmQQiQY+sts71CyTsrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75719908"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="75719908"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 19:52:53 -0700
X-CSE-ConnectionGUID: AWgkCBLDTRubp9msX1uCow==
X-CSE-MsgGUID: FCal3sZ8QWKziI/LNLR9+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="221874391"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 19:52:49 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 4/5] intel_iommu_accel: Accept PRQ response for passthrough
 device
Date: Thu, 26 Mar 2026 22:52:26 -0400
Message-ID: <20260327025228.474257-5-zhenzhong.duan@intel.com>
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

Propagate guest's PRQ response to host by writing to fault_fd.
Create a new VTDPRQEntry to cache cookie for each fault group,
this cookie is used to mark the fault group on host side.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_accel.h   | 14 ++++++++
 include/hw/i386/intel_iommu.h |  6 ++++
 hw/i386/intel_iommu.c         |  4 +++
 hw/i386/intel_iommu_accel.c   | 65 +++++++++++++++++++++++++++++++++++
 hw/i386/trace-events          |  1 +
 5 files changed, 90 insertions(+)

diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index 10e6ee5722..b46c7126f7 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -19,6 +19,9 @@ typedef struct VTDAccelPASIDCacheEntry {
     uint32_t fs_hwpt_id;
     uint32_t fault_id;
     int fault_fd;
+    QLIST_HEAD(, VTDPRQEntry) vtd_prq_list;
+    IOMMUPRINotifier pri_notifier_entry;
+    IOMMUPRINotifier *pri_notifier;
     QLIST_ENTRY(VTDAccelPASIDCacheEntry) next;
 } VTDAccelPASIDCacheEntry;
 
@@ -31,6 +34,9 @@ void vtd_flush_host_piotlb_all_accel(IntelIOMMUState *s, uint16_t domain_id,
                                      uint64_t npages, bool ih);
 void vtd_pasid_cache_sync_accel(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info);
 void vtd_pasid_cache_reset_accel(IntelIOMMUState *s);
+bool vtd_propagate_page_group_response_accel(IntelIOMMUState *s,
+                                             uint16_t rid, uint32_t pasid,
+                                             IOMMUPRIResponse *response);
 void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops);
 #else
 static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
@@ -69,6 +75,14 @@ static inline void vtd_pasid_cache_reset_accel(IntelIOMMUState *s)
 {
 }
 
+static inline
+bool vtd_propagate_page_group_response_accel(IntelIOMMUState *s,
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
index 96b4102ab9..d670a0377b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3390,6 +3390,10 @@ static bool vtd_process_page_group_response_desc(IntelIOMMUState *s,
         response.response_code = IOMMU_PRI_RESP_FAILURE;
     }
 
+    if (vtd_propagate_page_group_response_accel(s, rid, pasid, &response)) {
+        return true;
+    }
+
     if (vtd_dev_as->pri_notifier) {
         vtd_dev_as->pri_notifier->notify(vtd_dev_as->pri_notifier, &response);
     }
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 0fce62ff75..44af534c55 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -102,6 +102,30 @@ VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
     return NULL;
 }
 
+bool vtd_propagate_page_group_response_accel(IntelIOMMUState *s,
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
+            if (vtd_pce->pri_notifier) {
+                vtd_pce->pri_notifier->notify(vtd_pce->pri_notifier, response);
+            }
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
@@ -117,6 +141,13 @@ static void vtd_prq_report_fault(VTDAccelPASIDCacheEntry *vtd_pce,
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
 
@@ -150,6 +181,36 @@ static void vtd_prq_read_fault(void *opaque)
     vtd_prq_report_fault(vtd_pce, fault, bytes / sizeof(fault[0]));
 }
 
+static void vtd_prq_response_notify(struct IOMMUPRINotifier *notifier,
+                                    IOMMUPRIResponse *response)
+{
+    VTDAccelPASIDCacheEntry *vtd_pce =
+        container_of(notifier, VTDAccelPASIDCacheEntry, pri_notifier_entry);
+    uint32_t id = vtd_pce->fault_id, fd = vtd_pce->fault_fd;
+    struct iommu_hwpt_page_response resp;
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
 static void vtd_destroy_fs_faultq(VTDHostIOMMUDevice *vtd_hiod,
                                   uint32_t fault_id, uint32_t fault_fd)
 {
@@ -213,6 +274,7 @@ static void vtd_destroy_old_fs_faultq(VTDHostIOMMUDevice *vtd_hiod,
         return;
     }
 
+    vtd_pce->pri_notifier = NULL;
     qemu_set_fd_handler(vtd_pce->fault_fd, NULL, NULL, NULL);
     vtd_destroy_fs_faultq(vtd_hiod, vtd_pce->fault_id, vtd_pce->fault_fd);
     vtd_pce->fault_id = 0;
@@ -228,6 +290,8 @@ static void vtd_setup_fs_faultq(VTDAccelPASIDCacheEntry *vtd_pce,
 
     vtd_pce->fault_id = fault_id;
     vtd_pce->fault_fd = fault_fd;
+    vtd_pce->pri_notifier_entry.notify = vtd_prq_response_notify;
+    vtd_pce->pri_notifier = &vtd_pce->pri_notifier_entry;
     qemu_set_fd_handler(fault_fd, vtd_prq_read_fault, NULL, vtd_pce);
 }
 
@@ -492,6 +556,7 @@ static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
     vtd_pce->vtd_hiod = vtd_hiod;
     vtd_pce->pasid = pasid;
     vtd_pce->pasid_entry = *pe;
+    QLIST_INIT(&vtd_pce->vtd_prq_list);
     QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
 
     if (!vtd_device_attach_iommufd(vtd_pce, &local_err)) {
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index bf139338f7..52dab0b508 100644
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
2.47.3


