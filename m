Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41415C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 10:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ihM-0004Kn-6I; Wed, 22 May 2024 05:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ih5-0003af-N0
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ih3-0001k3-ND
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kFtutvjf0zUiypPGo01idxZBqeuziW+TRjNWvGNy6Ss=;
 b=Tqpr4uC1JyWmnQHm9+vAJXFI2N4uCbf6mEg5o/wKA/P0olWsdHMpiO7ShNI2H8CWvT/VTi
 kPnJ+/k3yQF+MSiujyGpbOWMVS/RjvsoaIV40wsyUgarQxfBnZ+XxLCqXW1jYYsl/xLHHq
 fKWZTlDdehmJHPR5wyJMUQDW8WQ4rOo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-e5yMDknzPVqf9QHJK-GQ5g-1; Wed,
 22 May 2024 05:55:28 -0400
X-MC-Unique: e5yMDknzPVqf9QHJK-GQ5g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 607733C0009E;
 Wed, 22 May 2024 09:55:28 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40C2F28E2;
 Wed, 22 May 2024 09:55:27 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 27/47] vfio/iommufd: Make iommufd_cdev_*() return bool
Date: Wed, 22 May 2024 11:54:22 +0200
Message-ID: <20240522095442.195243-28-clg@redhat.com>
In-Reply-To: <20240522095442.195243-1-clg@redhat.com>
References: <20240522095442.195243-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/iommufd.c | 88 +++++++++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 49 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 4c6992fca11969bc8fe26c11e902e2521d6bff7a..84c86b970e756d34b202d5b18ae51c30c730e092 100644
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
2.45.1


