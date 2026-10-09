Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 170CECA5FED
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 09:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF6aU-0005QF-IB; Fri, 09 Oct 2026 05:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xF6aO-0005Pw-7r
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 05:08:16 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xF6aM-0000ik-LQ
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 05:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791536895; x=1823072895;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kL6hqHJrIZpjQkUGYwa/xXC6JCE9utzkkyhm5O/MxRs=;
 b=hVVsTflqjtPa3FgajDfKAXS3d6Usmeu+ne9rZX+X/KmPkqDnWZcL6JNp
 uTDy57TG2Hl2ql/mfUhF3RgGF+0a7XcWehdNX3WDER9TF5dQmh6fTngwS
 LcQERzpQEq/nnhffcvm8TFFRkBeX9m0jQVNbW8X7jYUhRMMljuFmzVakt
 IcnJQruvsLbE9xEMq7t3AHobyUBl1HEuRTffLokCm/rABNmB5/5MTUPAM
 KF7nZFqhsW1KWHAADFsZtX+s+DA3KrA2umAhhY8kK9/HkvoAvSldsjd/8
 Y8m7NhNLidO4i48KvK6JqWb9tgLZoB85grMtqciVECEqf+EQIM2S4k+r8 Q==;
X-CSE-ConnectionGUID: BkYsZ6ukRMizGRmdCUzU6g==
X-CSE-MsgGUID: c+RF3izdRimoX2gWEIm0Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="328543"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="328543"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 02:08:14 -0700
X-CSE-ConnectionGUID: 0pDgyYHZTFSaaFKhjZqKPA==
X-CSE-MsgGUID: BbN40xiuSmiKl48i+bc5WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="431470"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.229.148])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 02:08:11 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v8 6/6] intel_iommu_accel: teardown FAULTQ resources in bottom
 half
Date: Fri,  9 Oct 2026 17:07:36 +0800
Message-ID: <20261009090737.3930000-7-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261009090737.3930000-1-zhenzhong.duan@intel.com>
References: <20261009090737.3930000-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

When a pasid entry becomes invalid, we need to release all resources
allocated for that entry including FAULTQ object and fault_fd.

We call qemu_set_fd_handler() to detach fault_fd's io_read handler and
wakes up main thread from poll(), but there could still be a small
window we call iommufd_backend_free_id(fault_id) before poll() exit
and release fault_id file reference. In this rare case, FAULTQ object
free return -EBUSY because opened fault_id file keeps reference of
FAULTQ object.

Teardown FAULTQ resources in bottom half to ensure poll() has released
fault_id file reference.

Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 hw/i386/intel_iommu_accel.c | 40 ++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index cd227315da..c07ffa68e0 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -268,17 +268,51 @@ free_faultq:
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
+    aio_bh_schedule_oneshot(iohandler_get_aio_context(),
+                            faultq_teardown_bh, fq);
 }
 
 static void vtd_setup_fs_faultq(VTDAccelPASIDCacheEntry *vtd_pce,
-- 
2.52.0


