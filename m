Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87991CD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 05:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS77N-0006C3-Tp; Wed, 27 May 2026 01:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wS77J-0006Bd-9D
 for qemu-devel@nongnu.org; Wed, 27 May 2026 01:47:45 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wS77E-0000YZ-Ks
 for qemu-devel@nongnu.org; Wed, 27 May 2026 01:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779860861; x=1811396861;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ObrnK8sswiz7nE7VythAfsMjXrhnyul9Z0RsYGLoX80=;
 b=bK4THnaVgLMgkBi6Il1Q4NXLoT2Q/zOB71dXEnZYuWMBwigc2jmpb6SU
 nxLQwLztkXryoZFvnUb+My4qLhy6hMJi5GEWxbngTLfpAVHmREGEehvsQ
 our8sSBgFiFkeBWINvTEX+t8YrgN5HDMVGClR5m1om6b5OADoVZoslGl0
 XanCp+HpoTVIofOQzWNUEmpUokoWRQ9z47zGZ8kk2V+WdpVEgGkisxQo2
 cpv+SD/ID9r6b2IfjNzb3TUYKHP68gu2meg0YABJDa4gFAK2x39Ny8fM+
 +t4kW6Rut9A20F8puazsNunvsyP9PzWXqR6JIruAUvwG8rFjglLbLEifi w==;
X-CSE-ConnectionGUID: l04daoHTRR+G5wTjCjIzcA==
X-CSE-MsgGUID: lC8H+RX8Qeqn33RAWpN5aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="90988074"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="90988074"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 22:47:37 -0700
X-CSE-ConnectionGUID: IaNpUcevTnqBqv3/bZhwCw==
X-CSE-MsgGUID: b2inOO3vR1+l9Gwcf9GSjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="241086659"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 22:47:34 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 01/17] vfio/iommufd: Extend attach/detach_hwpt callback
 implementations with pasid
Date: Wed, 27 May 2026 01:46:39 -0400
Message-ID: <20260527054658.1021096-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260527054658.1021096-1-zhenzhong.duan@intel.com>
References: <20260527054658.1021096-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11;
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 include/hw/core/iommu.h |  3 +++
 hw/vfio/iommufd.c       | 44 +++++++++++++++++++++++++----------------
 hw/vfio/trace-events    |  4 ++--
 3 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
index cd59a367ce..7fb5c81c9f 100644
--- a/include/hw/core/iommu.h
+++ b/include/hw/core/iommu.h
@@ -30,4 +30,7 @@ enum host_iommu_quirks {
     HOST_IOMMU_QUIRK_NESTING_PARENT_BYPASS_RO = BIT_ULL(0),
 };
 
+/* ABI constant: IOMMU_NO_PASID must always be 0 (keep in sync with kernel) */
+#define IOMMU_NO_PASID 0
+
 #endif /* HW_IOMMU_H */
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index df148a49a7..f86f6f0d7b 100644
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
 
@@ -363,7 +369,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     /* Try to find a domain */
     QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
         if (!cpr_is_incoming()) {
-            ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
+            ret = iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, IOMMU_NO_PASID,
+                                                      hwpt->hwpt_id, errp);
         } else if (vbasedev->cpr.hwpt_id == hwpt->hwpt_id) {
             ret = 0;
         } else {
@@ -442,7 +449,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
         return false;
     }
 
-    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp);
+    ret = iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, IOMMU_NO_PASID, hwpt_id,
+                                              errp);
     if (ret) {
         iommufd_backend_free_id(container->be, hwpt_id);
         return false;
@@ -495,7 +503,8 @@ static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
 
     /* If CPR, we are already attached to ioas_id. */
     return cpr_is_incoming() ||
-           !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
+           !iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, IOMMU_NO_PASID,
+                                                container->ioas_id, errp);
 }
 
 static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
@@ -503,7 +512,7 @@ static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
 {
     Error *err = NULL;
 
-    if (!iommufd_cdev_detach_ioas_hwpt(vbasedev, &err)) {
+    if (!iommufd_cdev_pasid_detach_ioas_hwpt(vbasedev, IOMMU_NO_PASID, &err)) {
         error_report_err(err);
     }
 
@@ -929,7 +938,8 @@ host_iommu_device_iommufd_vfio_attach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
 {
     VFIODevice *vbasedev = HOST_IOMMU_DEVICE(hiodi)->agent;
 
-    return !iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp);
+    return !iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, IOMMU_NO_PASID,
+                                                hwpt_id, errp);
 }
 
 static bool
@@ -938,7 +948,7 @@ host_iommu_device_iommufd_vfio_detach_hwpt(HostIOMMUDeviceIOMMUFD *hiodi,
 {
     VFIODevice *vbasedev = HOST_IOMMU_DEVICE(hiodi)->agent;
 
-    return iommufd_cdev_detach_ioas_hwpt(vbasedev, errp);
+    return iommufd_cdev_pasid_detach_ioas_hwpt(vbasedev, IOMMU_NO_PASID, errp);
 }
 
 static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 2049159015..8dbb477298 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -183,8 +183,8 @@ vfio_vmstate_change_prepare(const char *name, int running, const char *reason, c
 
 iommufd_cdev_connect_and_bind(int iommufd, const char *name, int devfd, int devid) " [iommufd=%d] Successfully bound device %s (fd=%d): output devid=%d"
 iommufd_cdev_getfd(const char *dev, int devfd) " %s (fd=%d)"
-iommufd_cdev_attach_ioas_hwpt(int iommufd, const char *name, int devfd, int id) " [iommufd=%d] Successfully attached device %s (%d) to id=%d"
-iommufd_cdev_detach_ioas_hwpt(int iommufd, const char *name) " [iommufd=%d] Successfully detached %s"
+iommufd_cdev_pasid_attach_ioas_hwpt(int iommufd, const char *name, int devfd, uint32_t pasid, int id) " [iommufd=%d] Successfully attached device %s (%d) pasid %u to id=%d"
+iommufd_cdev_pasid_detach_ioas_hwpt(int iommufd, const char *name, uint32_t pasid) " [iommufd=%d] Successfully detached %s pasid %u"
 iommufd_cdev_fail_attach_existing_container(const char *msg) " %s"
 iommufd_cdev_alloc_ioas(int iommufd, int ioas_id) " [iommufd=%d] new IOMMUFD container with ioasid=%d"
 iommufd_cdev_device_info(char *name, int devfd, int num_irqs, int num_regions, int flags) " %s (%d) num_irqs=%d num_regions=%d flags=%d"
-- 
2.47.3


