Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897B3D73090
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 03:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8VdX-00018B-BD; Thu, 02 Apr 2026 23:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w8VdV-00017b-LZ
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 23:55:57 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w8VdT-0004Lu-P0
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 23:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775188556; x=1806724556;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vv9aGh3p6ZT5Ue5A4+Q0A/R3dYVysZvAy1NgM3aG/4I=;
 b=QLXRhI+Ny3osZkn6Ta7CBMswPgaVJ0JPeOFl38dVjBtxyh9cB5+8bxNP
 A7ilGOUrq4mMmm3dYaW5OzkwD25C6Fam5uDThqjsKry6yE9QO7QMQSwAX
 DYLICBPkXqHENm/H/atnGyemozHRB6uyDX1+NYCpnueBFr7U4Z2hQYX/v
 YmHtfOLqJ8kQCflzaloijt6cIV9A4d1VTY+533LBFMsknxixfe80FaCqy
 m/D2O4JkVMlq+WETts5PjPEJoonZkW+/Lgjs8bw7FYc7BwZRd5a1IlMhH
 TBhfYDb/c8f7s0Y1nRuhvE3RKMgH4svjavlHqQ+J85rfmdsL+C3ffDMFJ g==;
X-CSE-ConnectionGUID: lMz1cD8UTT2nRuUigvSMmA==
X-CSE-MsgGUID: FdpnL/Q2S8eDTSI+gTjfWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76140587"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="76140587"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 20:55:54 -0700
X-CSE-ConnectionGUID: 3cRVvxOpTkW1aMJrC25h+Q==
X-CSE-MsgGUID: 5EbvvaoJRQuolO+iJQDHNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="223884845"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 20:55:51 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 01/14] vfio/iommufd: Extend attach/detach_hwpt callback
 implementations with pasid
Date: Thu,  2 Apr 2026 23:55:25 -0400
Message-ID: <20260403035541.18355-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403035541.18355-1-zhenzhong.duan@intel.com>
References: <20260403035541.18355-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

For attachment with pasid, pasid together with flag VFIO_DEVICE_ATTACH_PASID
should be passed in.

Define IOMMU_NO_PASID to represent device attachment without pasid same as
in kernel.

The implementation is similar for detachment.

Suggested-by: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 include/hw/core/iommu.h |  2 ++
 hw/vfio/iommufd.c       | 44 +++++++++++++++++++++++++----------------
 hw/vfio/trace-events    |  4 ++--
 3 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
index 86af315c15..bfcd511013 100644
--- a/include/hw/core/iommu.h
+++ b/include/hw/core/iommu.h
@@ -28,4 +28,6 @@ enum host_iommu_quirks {
     HOST_IOMMU_QUIRK_NESTING_PARENT_BYPASS_RO = BIT_ULL(0),
 };
 
+#define IOMMU_NO_PASID 0
+
 #endif /* HW_IOMMU_H */
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 399b36aa75..f020b56208 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -20,6 +20,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "system/iommufd.h"
+#include "hw/core/iommu.h"
 #include "hw/core/qdev.h"
 #include "hw/vfio/vfio-cpr.h"
 #include "system/reset.h"
@@ -305,43 +306,48 @@ out:
     return ret;
 }
 
-static int iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, uint32_t id,
-                                         Error **errp)
+static int iommufd_cdev_pasid_attach_ioas_hwpt(VFIODevice *vbasedev,
+                                               uint32_t pasid, uint32_t id,
+                                               Error **errp)
 {
     int iommufd = vbasedev->iommufd->fd;
     struct vfio_device_attach_iommufd_pt attach_data = {
         .argsz = sizeof(attach_data),
-        .flags = 0,
+        .flags = pasid == IOMMU_NO_PASID ? 0 : VFIO_DEVICE_ATTACH_PASID,
+        .pasid = pasid,
         .pt_id = id,
     };
 
     /* Attach device to an IOAS or hwpt within iommufd */
     if (ioctl(vbasedev->fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data)) {
         error_setg_errno(errp, errno,
-                         "[iommufd=%d] error attach %s (%d) to id=%d",
-                         iommufd, vbasedev->name, vbasedev->fd, id);
+                         "[iommufd=%d] error attach %s (%d) pasid %d to id=%d",
+                         iommufd, vbasedev->name, vbasedev->fd, pasid, id);
         return -errno;
     }
 
-    trace_iommufd_cdev_attach_ioas_hwpt(iommufd, vbasedev->name,
-                                        vbasedev->fd, id);
+    trace_iommufd_cdev_pasid_attach_ioas_hwpt(iommufd, vbasedev->name,
+                                              vbasedev->fd, pasid, id);
     return 0;
 }
 
-static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
+static bool iommufd_cdev_pasid_detach_ioas_hwpt(VFIODevice *vbasedev,
+                                                uint32_t pasid, Error **errp)
 {
     int iommufd = vbasedev->iommufd->fd;
     struct vfio_device_detach_iommufd_pt detach_data = {
         .argsz = sizeof(detach_data),
-        .flags = 0,
+        .flags = pasid == IOMMU_NO_PASID ? 0 : VFIO_DEVICE_DETACH_PASID,
+        .pasid = pasid,
     };
 
     if (ioctl(vbasedev->fd, VFIO_DEVICE_DETACH_IOMMUFD_PT, &detach_data)) {
-        error_setg_errno(errp, errno, "detach %s failed", vbasedev->name);
+        error_setg_errno(errp, errno, "detach %s pasid %d failed",
+                         vbasedev->name, pasid);
         return false;
     }
 
-    trace_iommufd_cdev_detach_ioas_hwpt(iommufd, vbasedev->name);
+    trace_iommufd_cdev_pasid_detach_ioas_hwpt(iommufd, vbasedev->name, pasid);
     return true;
 }
 
@@ -362,7 +368,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     /* Try to find a domain */
     QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
         if (!cpr_is_incoming()) {
-            ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
+            ret = iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, IOMMU_NO_PASID,
+                                                      hwpt->hwpt_id, errp);
         } else if (vbasedev->cpr.hwpt_id == hwpt->hwpt_id) {
             ret = 0;
         } else {
@@ -435,7 +442,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
         return false;
     }
 
-    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp);
+    ret = iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, IOMMU_NO_PASID, hwpt_id,
+                                              errp);
     if (ret) {
         iommufd_backend_free_id(container->be, hwpt_id);
         return false;
@@ -488,7 +496,8 @@ static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
 
     /* If CPR, we are already attached to ioas_id. */
     return cpr_is_incoming() ||
-           !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
+           !iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, IOMMU_NO_PASID,
+                                                container->ioas_id, errp);
 }
 
 static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
@@ -496,7 +505,7 @@ static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
 {
     Error *err = NULL;
 
-    if (!iommufd_cdev_detach_ioas_hwpt(vbasedev, &err)) {
+    if (!iommufd_cdev_pasid_detach_ioas_hwpt(vbasedev, IOMMU_NO_PASID, &err)) {
         error_report_err(err);
     }
 
@@ -922,7 +931,8 @@ host_iommu_device_iommufd_vfio_attach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
 {
     VFIODevice *vbasedev = HOST_IOMMU_DEVICE(hiodi)->agent;
 
-    return !iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp);
+    return !iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, IOMMU_NO_PASID,
+                                                hwpt_id, errp);
 }
 
 static bool
@@ -931,7 +941,7 @@ host_iommu_device_iommufd_vfio_detach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
 {
     VFIODevice *vbasedev = HOST_IOMMU_DEVICE(hiodi)->agent;
 
-    return iommufd_cdev_detach_ioas_hwpt(vbasedev, errp);
+    return iommufd_cdev_pasid_detach_ioas_hwpt(vbasedev, IOMMU_NO_PASID, errp);
 }
 
 static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 846e3625c5..764a3e4855 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -182,8 +182,8 @@ vfio_vmstate_change_prepare(const char *name, int running, const char *reason, c
 
 iommufd_cdev_connect_and_bind(int iommufd, const char *name, int devfd, int devid) " [iommufd=%d] Successfully bound device %s (fd=%d): output devid=%d"
 iommufd_cdev_getfd(const char *dev, int devfd) " %s (fd=%d)"
-iommufd_cdev_attach_ioas_hwpt(int iommufd, const char *name, int devfd, int id) " [iommufd=%d] Successfully attached device %s (%d) to id=%d"
-iommufd_cdev_detach_ioas_hwpt(int iommufd, const char *name) " [iommufd=%d] Successfully detached %s"
+iommufd_cdev_pasid_attach_ioas_hwpt(int iommufd, const char *name, int devfd, uint32_t pasid, int id) " [iommufd=%d] Successfully attached device %s (%d) pasid %d to id=%d"
+iommufd_cdev_pasid_detach_ioas_hwpt(int iommufd, const char *name, uint32_t pasid) " [iommufd=%d] Successfully detached %s pasid %d"
 iommufd_cdev_fail_attach_existing_container(const char *msg) " %s"
 iommufd_cdev_alloc_ioas(int iommufd, int ioas_id) " [iommufd=%d] new IOMMUFD container with ioasid=%d"
 iommufd_cdev_device_info(char *name, int devfd, int num_irqs, int num_regions, int flags) " %s (%d) num_irqs=%d num_regions=%d flags=%d"
-- 
2.47.3


