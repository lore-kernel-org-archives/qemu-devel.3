Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6C2C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 06:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4EaU-00046O-Sd; Tue, 07 May 2024 02:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4Ea3-0003Pc-27
 for qemu-devel@nongnu.org; Tue, 07 May 2024 02:45:42 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4Ea0-00064P-39
 for qemu-devel@nongnu.org; Tue, 07 May 2024 02:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715064336; x=1746600336;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YuEjad/QSOPspcVfj2yLb1aBm53LwZcTA/VVfm+isMg=;
 b=BNFGvSLwJqvEFatzYUPccETOg84ZOsUfBc+24oasP5m0EUZ+TnRFBjvS
 10vazDpaHH07yxqHC3MzC9j0mbyLcVqI8XLDnxOjAXcMA4NKDrIcrvIQt
 XCPLDpXP5oCt4DnqOki2AyQ8eImAesmWlbkn6h6co572nrtRGuYZ045GO
 kb9nsdEFQIUcvxk+v/9lmYX0S2rdzzfDfHQafWh19bDGQvTE4FX6UOLmB
 ZuLmuZkLzpu1KQ2AB6nglo7XdroxzbGWnvCa8Kn5M7iN6vX5x5X/YPs+1
 A4KBGUq3ztaHIk0wI7KNFFEqjZmSF1Su72RucwC7HgrX4uTrCcO4wdvKC A==;
X-CSE-ConnectionGUID: fOlNLZgVSCqndYruf66xjg==
X-CSE-MsgGUID: 1JtEDd0uQka9ijDCCXG6MQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="22240270"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="22240270"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 23:45:34 -0700
X-CSE-ConnectionGUID: /mUK/NehTcmHpqs7zRtX4Q==
X-CSE-MsgGUID: W0bmYEPuQNKQD4U7kMa9yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="28407542"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 23:45:32 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 09/11] vfio/iommufd: Make iommufd_cdev_*() return bool
Date: Tue,  7 May 2024 14:42:50 +0800
Message-Id: <20240507064252.457884-10-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507064252.457884-1-zhenzhong.duan@intel.com>
References: <20240507064252.457884-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is to follow the coding standand to return bool if 'Error **'
is used to pass error.

The changed functions include:

iommufd_cdev_kvm_device_add
iommufd_cdev_connect_and_bind
iommufd_cdev_attach_ioas_hwpt
iommufd_cdev_detach_ioas_hwpt
iommufd_cdev_attach_container
iommufd_cdev_get_info_iova_range

After the change, all functions in hw/vfio/iommufd.c follows the
standand.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/iommufd.c | 88 +++++++++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 49 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 4c6992fca1..84c86b970e 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -49,9 +49,9 @@ static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
                                      container->ioas_id, iova, size);
 }
 
-static int iommufd_cdev_kvm_device_add(VFIODevice *vbasedev, Error **errp)
+static bool iommufd_cdev_kvm_device_add(VFIODevice *vbasedev, Error **errp)
 {
-    return vfio_kvm_device_add_fd(vbasedev->fd, errp);
+    return !vfio_kvm_device_add_fd(vbasedev->fd, errp);
 }
 
 static void iommufd_cdev_kvm_device_del(VFIODevice *vbasedev)
@@ -63,18 +63,16 @@ static void iommufd_cdev_kvm_device_del(VFIODevice *vbasedev)
     }
 }
 
-static int iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
+static bool iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
 {
     IOMMUFDBackend *iommufd = vbasedev->iommufd;
     struct vfio_device_bind_iommufd bind = {
         .argsz = sizeof(bind),
         .flags = 0,
     };
-    int ret;
 
-    ret = iommufd_backend_connect(iommufd, errp);
-    if (ret) {
-        return ret;
+    if (iommufd_backend_connect(iommufd, errp)) {
+        return false;
     }
 
     /*
@@ -82,15 +80,13 @@ static int iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
      * in KVM. Especially for some emulated devices, it requires
      * to have kvm information in the device open.
      */
-    ret = iommufd_cdev_kvm_device_add(vbasedev, errp);
-    if (ret) {
+    if (!iommufd_cdev_kvm_device_add(vbasedev, errp)) {
         goto err_kvm_device_add;
     }
 
     /* Bind device to iommufd */
     bind.iommufd = iommufd->fd;
-    ret = ioctl(vbasedev->fd, VFIO_DEVICE_BIND_IOMMUFD, &bind);
-    if (ret) {
+    if (ioctl(vbasedev->fd, VFIO_DEVICE_BIND_IOMMUFD, &bind)) {
         error_setg_errno(errp, errno, "error bind device fd=%d to iommufd=%d",
                          vbasedev->fd, bind.iommufd);
         goto err_bind;
@@ -99,12 +95,12 @@ static int iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
     vbasedev->devid = bind.out_devid;
     trace_iommufd_cdev_connect_and_bind(bind.iommufd, vbasedev->name,
                                         vbasedev->fd, vbasedev->devid);
-    return ret;
+    return true;
 err_bind:
     iommufd_cdev_kvm_device_del(vbasedev);
 err_kvm_device_add:
     iommufd_backend_disconnect(iommufd);
-    return ret;
+    return false;
 }
 
 static void iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
@@ -176,10 +172,10 @@ out:
     return ret;
 }
 
-static int iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, uint32_t id,
+static bool iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, uint32_t id,
                                          Error **errp)
 {
-    int ret, iommufd = vbasedev->iommufd->fd;
+    int iommufd = vbasedev->iommufd->fd;
     struct vfio_device_attach_iommufd_pt attach_data = {
         .argsz = sizeof(attach_data),
         .flags = 0,
@@ -187,38 +183,38 @@ static int iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, uint32_t id,
     };
 
     /* Attach device to an IOAS or hwpt within iommufd */
-    ret = ioctl(vbasedev->fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data);
-    if (ret) {
+    if (ioctl(vbasedev->fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data)) {
         error_setg_errno(errp, errno,
                          "[iommufd=%d] error attach %s (%d) to id=%d",
                          iommufd, vbasedev->name, vbasedev->fd, id);
-    } else {
-        trace_iommufd_cdev_attach_ioas_hwpt(iommufd, vbasedev->name,
-                                            vbasedev->fd, id);
+        return false;
     }
-    return ret;
+
+    trace_iommufd_cdev_attach_ioas_hwpt(iommufd, vbasedev->name,
+                                        vbasedev->fd, id);
+    return true;
 }
 
-static int iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
+static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
 {
-    int ret, iommufd = vbasedev->iommufd->fd;
+    int iommufd = vbasedev->iommufd->fd;
     struct vfio_device_detach_iommufd_pt detach_data = {
         .argsz = sizeof(detach_data),
         .flags = 0,
     };
 
-    ret = ioctl(vbasedev->fd, VFIO_DEVICE_DETACH_IOMMUFD_PT, &detach_data);
-    if (ret) {
+    if (ioctl(vbasedev->fd, VFIO_DEVICE_DETACH_IOMMUFD_PT, &detach_data)) {
         error_setg_errno(errp, errno, "detach %s failed", vbasedev->name);
-    } else {
-        trace_iommufd_cdev_detach_ioas_hwpt(iommufd, vbasedev->name);
+        return false;
     }
-    return ret;
+
+    trace_iommufd_cdev_detach_ioas_hwpt(iommufd, vbasedev->name);
+    return true;
 }
 
-static int iommufd_cdev_attach_container(VFIODevice *vbasedev,
-                                         VFIOIOMMUFDContainer *container,
-                                         Error **errp)
+static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
+                                          VFIOIOMMUFDContainer *container,
+                                          Error **errp)
 {
     return iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
 }
@@ -228,7 +224,7 @@ static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
 {
     Error *err = NULL;
 
-    if (iommufd_cdev_detach_ioas_hwpt(vbasedev, &err)) {
+    if (!iommufd_cdev_detach_ioas_hwpt(vbasedev, &err)) {
         error_report_err(err);
     }
 }
@@ -254,20 +250,19 @@ static int iommufd_cdev_ram_block_discard_disable(bool state)
     return ram_block_uncoordinated_discard_disable(state);
 }
 
-static int iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
-                                            uint32_t ioas_id, Error **errp)
+static bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
+                                             uint32_t ioas_id, Error **errp)
 {
     VFIOContainerBase *bcontainer = &container->bcontainer;
     g_autofree struct iommu_ioas_iova_ranges *info = NULL;
     struct iommu_iova_range *iova_ranges;
-    int ret, sz, fd = container->be->fd;
+    int sz, fd = container->be->fd;
 
     info = g_malloc0(sizeof(*info));
     info->size = sizeof(*info);
     info->ioas_id = ioas_id;
 
-    ret = ioctl(fd, IOMMU_IOAS_IOVA_RANGES, info);
-    if (ret && errno != EMSGSIZE) {
+    if (ioctl(fd, IOMMU_IOAS_IOVA_RANGES, info) && errno != EMSGSIZE) {
         goto error;
     }
 
@@ -275,8 +270,7 @@ static int iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
     info = g_realloc(info, sizeof(*info) + sz);
     info->allowed_iovas = (uintptr_t)(info + 1);
 
-    ret = ioctl(fd, IOMMU_IOAS_IOVA_RANGES, info);
-    if (ret) {
+    if (ioctl(fd, IOMMU_IOAS_IOVA_RANGES, info)) {
         goto error;
     }
 
@@ -291,12 +285,11 @@ static int iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
     }
     bcontainer->pgsizes = info->out_iova_alignment;
 
-    return 0;
+    return true;
 
 error:
-    ret = -errno;
     error_setg_errno(errp, errno, "Cannot get IOVA ranges");
-    return ret;
+    return false;
 }
 
 static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
@@ -322,8 +315,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         devfd = vbasedev->fd;
     }
 
-    ret = iommufd_cdev_connect_and_bind(vbasedev, errp);
-    if (ret) {
+    if (!iommufd_cdev_connect_and_bind(vbasedev, errp)) {
         goto err_connect_bind;
     }
 
@@ -336,7 +328,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
             vbasedev->iommufd != container->be) {
             continue;
         }
-        if (iommufd_cdev_attach_container(vbasedev, container, &err)) {
+        if (!iommufd_cdev_attach_container(vbasedev, container, &err)) {
             const char *msg = error_get_pretty(err);
 
             trace_iommufd_cdev_fail_attach_existing_container(msg);
@@ -369,8 +361,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
     vfio_container_init(bcontainer, space, iommufd_vioc);
     QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
 
-    ret = iommufd_cdev_attach_container(vbasedev, container, errp);
-    if (ret) {
+    if (!iommufd_cdev_attach_container(vbasedev, container, errp)) {
         goto err_attach_container;
     }
 
@@ -379,8 +370,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         goto err_discard_disable;
     }
 
-    ret = iommufd_cdev_get_info_iova_range(container, ioas_id, &err);
-    if (ret) {
+    if (!iommufd_cdev_get_info_iova_range(container, ioas_id, &err)) {
         error_append_hint(&err,
                    "Fallback to default 64bit IOVA range and 4K page size\n");
         warn_report_err(err);
-- 
2.34.1


