Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BA7C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 10:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ih1-0003Yg-PN; Wed, 22 May 2024 05:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9igw-0003VU-Tt
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9igu-0001g3-Rs
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bWjCvBHLClbA3cqzzO6MNrC/zHAI88qWAW+VrP5Fssw=;
 b=EUS1hJafovU7Z/0RNyAE7IZUxxSeBojUo3UuJGX3OwnYgNLa48Rxayg7OJuAB6q/5v2Efv
 KHJ19L/pYJTXV2ShDtUVcg/b5uMB5WqikfegC/tCFIWtRrQpcchsNa5BL0OAClbXVIjuBJ
 r+EjaETEp77yxooN3xAWiKZEM7MjgHQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-q5fNgkBxNVS6bRFaFmjvZA-1; Wed, 22 May 2024 05:55:20 -0400
X-MC-Unique: q5fNgkBxNVS6bRFaFmjvZA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41D608058D1;
 Wed, 22 May 2024 09:55:20 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 216E47414;
 Wed, 22 May 2024 09:55:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 21/47] vfio: Make VFIOIOMMUClass::attach_device() and its
 wrapper return bool
Date: Wed, 22 May 2024 11:54:16 +0200
Message-ID: <20240522095442.195243-22-clg@redhat.com>
In-Reply-To: <20240522095442.195243-1-clg@redhat.com>
References: <20240522095442.195243-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

Make VFIOIOMMUClass::attach_device() and its wrapper function
vfio_attach_device() return bool.

This is to follow the coding standand to return bool if 'Error **'
is used to pass error.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h         |  4 ++--
 include/hw/vfio/vfio-container-base.h |  4 ++--
 hw/vfio/ap.c                          |  6 ++----
 hw/vfio/ccw.c                         |  6 ++----
 hw/vfio/common.c                      |  4 ++--
 hw/vfio/container.c                   | 14 +++++++-------
 hw/vfio/iommufd.c                     | 11 +++++------
 hw/vfio/pci.c                         |  5 ++---
 hw/vfio/platform.c                    |  7 +++----
 9 files changed, 27 insertions(+), 34 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 878e34a12874f63fcb8bbc8dc8ca3d2dfa84fdb4..e85817e65e65317d08bc2b17b738449198784796 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -222,8 +222,8 @@ void vfio_region_exit(VFIORegion *region);
 void vfio_region_finalize(VFIORegion *region);
 void vfio_reset_handler(void *opaque);
 struct vfio_device_info *vfio_get_device_info(int fd);
-int vfio_attach_device(char *name, VFIODevice *vbasedev,
-                       AddressSpace *as, Error **errp);
+bool vfio_attach_device(char *name, VFIODevice *vbasedev,
+                        AddressSpace *as, Error **errp);
 void vfio_detach_device(VFIODevice *vbasedev);
 
 int vfio_kvm_device_add_fd(int fd, Error **errp);
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index b04057ad1aff73d974ecec718d0fe45f7a930b59..44927ca8c3583246145defe043ac34da604d39bf 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -117,8 +117,8 @@ struct VFIOIOMMUClass {
     int (*dma_unmap)(const VFIOContainerBase *bcontainer,
                      hwaddr iova, ram_addr_t size,
                      IOMMUTLBEntry *iotlb);
-    int (*attach_device)(const char *name, VFIODevice *vbasedev,
-                         AddressSpace *as, Error **errp);
+    bool (*attach_device)(const char *name, VFIODevice *vbasedev,
+                          AddressSpace *as, Error **errp);
     void (*detach_device)(VFIODevice *vbasedev);
 
     /* migration feature */
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 8bb024e2fde4a1d72346dee4b662d762374326b9..ba653ef70f08ebdf482009baafc62eb33ebda9a8 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -154,7 +154,6 @@ static void vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
 static void vfio_ap_realize(DeviceState *dev, Error **errp)
 {
     ERRP_GUARD();
-    int ret;
     Error *err = NULL;
     VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
     VFIODevice *vbasedev = &vapdev->vdev;
@@ -163,9 +162,8 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    ret = vfio_attach_device(vbasedev->name, vbasedev,
-                             &address_space_memory, errp);
-    if (ret) {
+    if (!vfio_attach_device(vbasedev->name, vbasedev,
+                            &address_space_memory, errp)) {
         goto error;
     }
 
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 1c630f6e9abe93ae0c2b5615d4409669f096c8c9..89bb98016764e65cf826183d7a38c59d429f6eeb 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -579,7 +579,6 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
     S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
     VFIODevice *vbasedev = &vcdev->vdev;
     Error *err = NULL;
-    int ret;
 
     /* Call the class init function for subchannel. */
     if (cdc->realize) {
@@ -593,9 +592,8 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    ret = vfio_attach_device(cdev->mdevid, vbasedev,
-                             &address_space_memory, errp);
-    if (ret) {
+    if (!vfio_attach_device(cdev->mdevid, vbasedev,
+                            &address_space_memory, errp)) {
         goto out_attach_dev_err;
     }
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 1fbd10801d35079341a833fa68a43de2b758cde0..c04a259ffd7cfcfba480335bea1ddff787f47bdc 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1523,8 +1523,8 @@ retry:
     return info;
 }
 
-int vfio_attach_device(char *name, VFIODevice *vbasedev,
-                       AddressSpace *as, Error **errp)
+bool vfio_attach_device(char *name, VFIODevice *vbasedev,
+                        AddressSpace *as, Error **errp)
 {
     const VFIOIOMMUClass *ops =
         VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 9534120d4ac835bb58e37667dad8d39205404c08..e7c416774791d506cc7c4696fb6a6d94dc809c8e 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -910,8 +910,8 @@ static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
  * @name and @vbasedev->name are likely to be different depending
  * on the type of the device, hence the need for passing @name
  */
-static int vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
-                                     AddressSpace *as, Error **errp)
+static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
+                                      AddressSpace *as, Error **errp)
 {
     int groupid = vfio_device_groupid(vbasedev, errp);
     VFIODevice *vbasedev_iter;
@@ -920,27 +920,27 @@ static int vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
     int ret;
 
     if (groupid < 0) {
-        return groupid;
+        return false;
     }
 
     trace_vfio_attach_device(vbasedev->name, groupid);
 
     group = vfio_get_group(groupid, as, errp);
     if (!group) {
-        return -ENOENT;
+        return false;
     }
 
     QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
         if (strcmp(vbasedev_iter->name, vbasedev->name) == 0) {
             error_setg(errp, "device is already attached");
             vfio_put_group(group);
-            return -EBUSY;
+            return false;
         }
     }
     ret = vfio_get_device(group, name, vbasedev, errp);
     if (ret) {
         vfio_put_group(group);
-        return ret;
+        return false;
     }
 
     bcontainer = &group->container->bcontainer;
@@ -948,7 +948,7 @@ static int vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
     QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
     QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
 
-    return ret;
+    return true;
 }
 
 static void vfio_legacy_detach_device(VFIODevice *vbasedev)
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index c6441279728fcede1dde2a099c076ad04c464a1f..4c6992fca11969bc8fe26c11e902e2521d6bff7a 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -299,8 +299,8 @@ error:
     return ret;
 }
 
-static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
-                               AddressSpace *as, Error **errp)
+static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
+                                AddressSpace *as, Error **errp)
 {
     VFIOContainerBase *bcontainer;
     VFIOIOMMUFDContainer *container;
@@ -315,7 +315,7 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
     if (vbasedev->fd < 0) {
         devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
         if (devfd < 0) {
-            return devfd;
+            return false;
         }
         vbasedev->fd = devfd;
     } else {
@@ -392,7 +392,6 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
     memory_listener_register(&bcontainer->listener, bcontainer->space->as);
 
     if (bcontainer->error) {
-        ret = -1;
         error_propagate_prepend(errp, bcontainer->error,
                                 "memory listener initialization failed: ");
         goto err_listener_register;
@@ -431,7 +430,7 @@ found_container:
 
     trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
                                    vbasedev->num_regions, vbasedev->flags);
-    return 0;
+    return true;
 
 err_listener_register:
     iommufd_cdev_ram_block_discard_disable(false);
@@ -444,7 +443,7 @@ err_alloc_ioas:
     iommufd_cdev_unbind_and_disconnect(vbasedev);
 err_connect_bind:
     close(vbasedev->fd);
-    return ret;
+    return false;
 }
 
 static void iommufd_cdev_detach(VFIODevice *vbasedev)
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 84f7bff664fd7595b75cce1f6974068144f0d42d..c1adef5cf8fb241df510514610f05c8a0d51a9f9 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3027,9 +3027,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         name = g_strdup(vbasedev->name);
     }
 
-    ret = vfio_attach_device(name, vbasedev,
-                             pci_device_iommu_address_space(pdev), errp);
-    if (ret) {
+    if (!vfio_attach_device(name, vbasedev,
+                            pci_device_iommu_address_space(pdev), errp)) {
         goto error;
     }
 
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index dcd2365fb35344d4383989169fa23bab7cc3d8de..2bd16096bbd1b4a1da579448e931cb0803d54bb6 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -552,10 +552,9 @@ static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
         return ret;
     }
 
-    ret = vfio_attach_device(vbasedev->name, vbasedev,
-                             &address_space_memory, errp);
-    if (ret) {
-        return ret;
+    if (!vfio_attach_device(vbasedev->name, vbasedev,
+                            &address_space_memory, errp)) {
+        return -EINVAL;
     }
 
     ret = vfio_populate_device(vbasedev, errp);
-- 
2.45.1


