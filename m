Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A571C30653
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 21:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLrD7-0006on-V8; Mon, 24 Jun 2024 17:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrD2-0006Z7-4D
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCz-0006sf-NC
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719264401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tRSs/QpalEU8cRTeXtkphTZ9aUiwpnONE3iCzq698lU=;
 b=ItoA+zq+HmyOSMX6aXw4GZHUvQqUuqSrXAmlzkL9cuuvN97hpXPNfiZMf4Zj7dYkuCxjhK
 kKuzCoKGeHFKwHhr2Ci5/mpCn3xs4mCTavvngFjgzGiqVJjTIy4usIDXeVzTIsVviye/93
 CKVWiuSMViY1b0re/6TW7YsEB32/Sco=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-B5D5e-lbMQGss5WfqL3cSQ-1; Mon,
 24 Jun 2024 17:26:37 -0400
X-MC-Unique: B5D5e-lbMQGss5WfqL3cSQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BF2519560B6; Mon, 24 Jun 2024 21:26:36 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EDA671956057; Mon, 24 Jun 2024 21:26:34 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 39/42] vfio/container: Remove VFIOContainerBase::ops
Date: Mon, 24 Jun 2024 23:24:53 +0200
Message-ID: <20240624212456.350919-40-clg@redhat.com>
In-Reply-To: <20240624212456.350919-1-clg@redhat.com>
References: <20240624212456.350919-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Instead, use VFIO_IOMMU_GET_CLASS() to get the class pointer.

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h |  1 -
 hw/vfio/common.c                      |  2 +-
 hw/vfio/container-base.c              | 37 +++++++++++++++++----------
 hw/vfio/container.c                   | 15 ++++++-----
 hw/vfio/iommufd.c                     |  4 +--
 hw/vfio/pci.c                         |  4 +--
 6 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index b079b76f68975c5701a289ce9012e912a8e44fc6..6b57cd8e7f5d7d2817f6e3b96ce4566d2630bb12 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -35,7 +35,6 @@ typedef struct VFIOAddressSpace {
  */
 typedef struct VFIOContainerBase {
     Object parent;
-    const VFIOIOMMUClass *ops;
     VFIOAddressSpace *space;
     MemoryListener listener;
     Error *error;
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 1686a0bed23bd95467bfb00a0c39a4d966e49cae..7cdb969fd396ae3815cb175ad631d93d7cca7006 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1573,5 +1573,5 @@ void vfio_detach_device(VFIODevice *vbasedev)
         return;
     }
     object_unref(vbasedev->hiod);
-    vbasedev->bcontainer->ops->detach_device(vbasedev);
+    VFIO_IOMMU_GET_CLASS(vbasedev->bcontainer)->detach_device(vbasedev);
 }
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 3858f5ab1d68e897f9013161d7c5c20c0553029d..24669d4d7472f49ac3adf2618a32bf7d82c5c344 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -19,62 +19,73 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            hwaddr iova, ram_addr_t size,
                            void *vaddr, bool readonly)
 {
-    g_assert(bcontainer->ops->dma_map);
-    return bcontainer->ops->dma_map(bcontainer, iova, size, vaddr, readonly);
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+
+    g_assert(vioc->dma_map);
+    return vioc->dma_map(bcontainer, iova, size, vaddr, readonly);
 }
 
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
                              IOMMUTLBEntry *iotlb)
 {
-    g_assert(bcontainer->ops->dma_unmap);
-    return bcontainer->ops->dma_unmap(bcontainer, iova, size, iotlb);
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+
+    g_assert(vioc->dma_unmap);
+    return vioc->dma_unmap(bcontainer, iova, size, iotlb);
 }
 
 bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
                                        MemoryRegionSection *section,
                                        Error **errp)
 {
-    if (!bcontainer->ops->add_window) {
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+
+    if (!vioc->add_window) {
         return true;
     }
 
-    return bcontainer->ops->add_window(bcontainer, section, errp);
+    return vioc->add_window(bcontainer, section, errp);
 }
 
 void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
                                        MemoryRegionSection *section)
 {
-    if (!bcontainer->ops->del_window) {
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+
+    if (!vioc->del_window) {
         return;
     }
 
-    return bcontainer->ops->del_window(bcontainer, section);
+    return vioc->del_window(bcontainer, section);
 }
 
 int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
                                            bool start, Error **errp)
 {
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+
     if (!bcontainer->dirty_pages_supported) {
         return 0;
     }
 
-    g_assert(bcontainer->ops->set_dirty_page_tracking);
-    return bcontainer->ops->set_dirty_page_tracking(bcontainer, start, errp);
+    g_assert(vioc->set_dirty_page_tracking);
+    return vioc->set_dirty_page_tracking(bcontainer, start, errp);
 }
 
 int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                    VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
 {
-    g_assert(bcontainer->ops->query_dirty_bitmap);
-    return bcontainer->ops->query_dirty_bitmap(bcontainer, vbmap, iova, size,
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+
+    g_assert(vioc->query_dirty_bitmap);
+    return vioc->query_dirty_bitmap(bcontainer, vbmap, iova, size,
                                                errp);
 }
 
 void vfio_container_init(VFIOContainerBase *bcontainer,
                          const VFIOIOMMUClass *ops)
 {
-    bcontainer->ops = ops;
 }
 
 void vfio_container_destroy(VFIOContainerBase *bcontainer)
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index ff3a6831da83c0fe11060cd57918c4d87b10197c..a2f5fbad00cd228e27a47df5cd683dbb34296113 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -548,6 +548,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     VFIOContainerBase *bcontainer;
     int ret, fd;
     VFIOAddressSpace *space;
+    VFIOIOMMUClass *vioc;
 
     space = vfio_get_address_space(as);
 
@@ -632,9 +633,10 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         goto unregister_container_exit;
     }
 
-    assert(bcontainer->ops->setup);
+    vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    assert(vioc->setup);
 
-    if (!bcontainer->ops->setup(bcontainer, errp)) {
+    if (!vioc->setup(bcontainer, errp)) {
         goto enable_discards_exit;
     }
 
@@ -663,8 +665,8 @@ listener_release_exit:
     QLIST_REMOVE(bcontainer, next);
     vfio_kvm_device_del_group(group);
     memory_listener_unregister(&bcontainer->listener);
-    if (bcontainer->ops->release) {
-        bcontainer->ops->release(bcontainer);
+    if (vioc->release) {
+        vioc->release(bcontainer);
     }
 
 enable_discards_exit:
@@ -689,6 +691,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
 {
     VFIOContainer *container = group->container;
     VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
 
     QLIST_REMOVE(group, container_next);
     group->container = NULL;
@@ -700,8 +703,8 @@ static void vfio_disconnect_container(VFIOGroup *group)
      */
     if (QLIST_EMPTY(&container->group_list)) {
         memory_listener_unregister(&bcontainer->listener);
-        if (bcontainer->ops->release) {
-            bcontainer->ops->release(bcontainer);
+        if (vioc->release) {
+            vioc->release(bcontainer);
         }
     }
 
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index d59df858407f3cadb9405386ad673c99cdad61d0..7bc76f80b48ea5422e68fd4d4cb3f5bca90993f6 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -324,7 +324,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
     /* try to attach to an existing container in this space */
     QLIST_FOREACH(bcontainer, &space->containers, next) {
         container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
-        if (bcontainer->ops != iommufd_vioc ||
+        if (VFIO_IOMMU_GET_CLASS(bcontainer) != iommufd_vioc ||
             vbasedev->iommufd != container->be) {
             continue;
         }
@@ -465,7 +465,7 @@ static VFIODevice *iommufd_cdev_pci_find_by_devid(__u32 devid)
         VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
 
     QLIST_FOREACH(vbasedev_iter, &vfio_device_list, global_next) {
-        if (vbasedev_iter->bcontainer->ops != iommufd_vioc) {
+        if (VFIO_IOMMU_GET_CLASS(vbasedev_iter->bcontainer) != iommufd_vioc) {
             continue;
         }
         if (devid == vbasedev_iter->devid) {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d8a76c1ee003e6f5669e8390271836fd9d839a8a..e03d9f3ba5461f55f6351d937aba5d522a9128ec 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2511,9 +2511,9 @@ int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
 static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
-    const VFIOIOMMUClass *ops = vbasedev->bcontainer->ops;
+    const VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(vbasedev->bcontainer);
 
-    return ops->pci_hot_reset(vbasedev, single);
+    return vioc->pci_hot_reset(vbasedev, single);
 }
 
 /*
-- 
2.45.2


