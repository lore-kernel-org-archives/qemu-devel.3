Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5FF606A32C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X7qSllUu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ61T-0006en-QX; Tue, 20 Oct 2026 05:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xJ61R-0006eQ-4s
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 05:20:41 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xJ61P-0005b6-Bb
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 05:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792488039; x=1824024039;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aE0zRH6rlS8CPTLr1w2HcBEqdr/y7TC2FCuZpHX1UqY=;
 b=X7qSllUu1imOYGqYjNb3MjKf7S4LVt/hPvevzhXlRPXqIz33bssIVivs
 eLrtaWkGRsMlLKEA6a33B+KMFNWyd91MBiUserQL33V4BkKRA0aVEmnQL
 1T/dTbywIfBEwWVqYwRglANpxT8OZKuKqfjn7/FA8uE+3zmrvkDKfeF6R
 woGdg3QkkuGoKsyuIjAAsfUfGkel7VRcik0Ybclpiqy6VMKYWE3tKZYfv
 /+s4uiDYCATwLbI1recQsYQllHvsqbXehC/8sRuUa3ox7jO1Y60nW9+or
 vqQ20pUR9YDOzhnYcXyeoBhA8T+lv4ITkygr5Yuk+XUf0ZBvvKVY0bDy4 g==;
X-CSE-ConnectionGUID: yRBuPZtcSD2jJkNmBauTCw==
X-CSE-MsgGUID: lKeKxBKKRz+2OaCo46IMZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1080688"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1080688"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 02:20:37 -0700
X-CSE-ConnectionGUID: JZLlYIq0RqSfuHGJAEtTOQ==
X-CSE-MsgGUID: hAk2skcbQl+4sUTK94flfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3138404"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.229.148])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 02:20:33 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v9 6/6] intel_iommu_accel: Teardown FAULTQ resources in bottom
 half
Date: Tue, 20 Oct 2026 17:19:54 +0800
Message-ID: <20261020091955.1607161-7-zhenzhong.duan@intel.com>
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

When a PASID entry becomes invalid, all resources allocated for that entry,
including the FAULTQ object and fault_fd, must be released.

Calling qemu_set_fd_handler() detaches the fault_fd I/O read handler and
wakes up the main loop thread from poll(). However, a race window exists
where iommufd_backend_free_id(fault_id) can be invoked before poll() exits
and releases its reference to the fault_fd file. In this scenario, freeing
the FAULTQ object returns -EBUSY because the opened fault_fd file still
holds an active reference to the FAULTQ object.

Defer FAULTQ resource teardown to a bottom half. This ensures poll() has
fully exited and dropped the file reference before the fault_fd is closed
and the FAULTQ object ID is freed. Additionally, keep the IOMMUFD backend
FD open via iommufd_backend_connect() across the asynchronous bottom half
execution to ensure FAULTQ object freed successfully.

Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 hw/i386/intel_iommu_accel.c | 59 +++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 243501f137..7db8319ad4 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -271,17 +271,70 @@ free_faultq:
     return false;
 }
 
+typedef struct IOMMUFaultQueue {
+    IOMMUFDBackend *iommufd;
+    uint32_t id;
+    int fd;
+    QLIST_HEAD(, VTDPRQEntry) vtd_prq_list;
+} IOMMUFaultQueue;
+
+static void faultq_teardown_bh(void *opaque)
+{
+    IOMMUFaultQueue *fq = opaque;
+    VTDPRQEntry *prqe, *next;
+
+    QLIST_FOREACH_SAFE(prqe, &fq->vtd_prq_list, next, next) {
+        QLIST_REMOVE(prqe, next);
+        g_free(prqe);
+    }
+
+    qemu_set_fd_handler(fq->fd, NULL, NULL, NULL);
+    close(fq->fd);
+    iommufd_backend_free_id(fq->iommufd, fq->id);
+    iommufd_backend_disconnect(fq->iommufd);
+
+    g_free(fq);
+}
+
 static void vtd_destroy_old_fs_faultq(VTDAccelPASIDCacheEntry *vtd_pce)
 {
+    HostIOMMUDeviceIOMMUFD *idev =
+        HOST_IOMMU_DEVICE_IOMMUFD(vtd_pce->vtd_hiod->hiod);
+    IOMMUFaultQueue *fq;
+
     if (vtd_pce->fault_fd < 0) {
         return;
     }
 
-    qemu_set_fd_handler(vtd_pce->fault_fd, NULL, NULL, NULL);
-    vtd_destroy_fs_faultq(vtd_pce->vtd_hiod, vtd_pce->fault_id,
-                          vtd_pce->fault_fd);
+    fq = g_malloc(sizeof(*fq));
+    fq->iommufd = idev->iommufd;
+    fq->fd = vtd_pce->fault_fd;
+    fq->id = vtd_pce->fault_id;
     vtd_pce->fault_id = 0;
     vtd_pce->fault_fd = -1;
+    fq->vtd_prq_list.lh_first = vtd_pce->vtd_prq_list.lh_first;
+    QLIST_INIT(&vtd_pce->vtd_prq_list);
+
+    /*
+     * During a VFIO device hot-unplug, if this is the last device connected
+     * to the IOMMUFDBackend, the backend user count (iommufd->users) will
+     * drop to zero, triggering iommufd_backend_disconnect() which closes
+     * the backend's opened container FD.
+     *
+     * Since the teardown of this fault queue (faultq_teardown_bh) is
+     * scheduled asynchronously as a bottom half, we must temporarily
+     * increment the connection user count of the iommufd backend here.
+     * This guarantees the backend connection remains open and its opened
+     * FD remains active until the async BH completes.
+     *
+     * Incrementing the user count is guaranteed to succeed here because the
+     * VFIO device is still registered as an active user of the backend at
+     * this point in the teardown sequence.
+     */
+    iommufd_backend_connect(fq->iommufd, &error_abort);
+
+    aio_bh_schedule_oneshot(iohandler_get_aio_context(),
+                            faultq_teardown_bh, fq);
 }
 
 static void vtd_setup_fs_faultq(VTDAccelPASIDCacheEntry *vtd_pce,
-- 
2.52.0


