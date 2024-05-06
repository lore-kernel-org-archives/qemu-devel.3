Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFDFC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tqK-0001Ij-83; Mon, 06 May 2024 04:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s3tpn-0000VF-3B; Mon, 06 May 2024 04:36:31 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s3tpi-0000Q6-PE; Mon, 06 May 2024 04:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714984587; x=1746520587;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qe7G5EC+ySROJ5Ikq4WbKg9BctwH2HhrSQ63UTLxdTE=;
 b=SwN0EQX1WirSw8eFZIslBfjybxpxMlJczWPpZygnX4WNxSdkPF154huf
 k6kBDTOxANNYaYwoIzR6f/ZhMnD3CB26Q0C6+jNd0dC9rj+9qDJy6cd1w
 KlH5YSOxbKYa/FijUV06c1EmtD3qKyKM774whOZu4e5eexb9QT6CJBooM
 o714Sk75D2oXq1zrZUVv/QNNmxY3a4fOQkjJuLnCBqLrkZWvbZPMJ1L6s
 GkINq8kHkYrLrUYXX+JB6t9qhv1K3ZyP0gQfRVS8OACbchdLvs8kDHkdd
 A0EUfGLk3QkGyjWeAUNX60kX7QUIlk/UhEZLTqPOoY1/pcswP9jg1Ua3V w==;
X-CSE-ConnectionGUID: AkBYtP62SFWmlhpCbQOQhw==
X-CSE-MsgGUID: tRlMSy/kSm2p7DsVeiN/8g==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10647849"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="10647849"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 01:36:20 -0700
X-CSE-ConnectionGUID: wYecNJHyQ9iqAAE2M4I2sA==
X-CSE-MsgGUID: ZAKYxFXUTG2Xn8Qp6SWbyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="28606570"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 01:36:16 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:vfio-ap)
Subject: [PATCH 1/3] vfio: Make VFIOIOMMUClass::attach_device() and its
 wrapper return bool
Date: Mon,  6 May 2024 16:33:50 +0800
Message-Id: <20240506083352.4037226-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506083352.4037226-1-zhenzhong.duan@intel.com>
References: <20240506083352.4037226-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
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

Make VFIOIOMMUClass::attach_device() and its wrapper function
vfio_attach_device() return bool.

This is to follow the coding standand to return bool if 'Error **'
is used to pass error.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h         |  4 ++--
 include/hw/vfio/vfio-container-base.h |  4 ++--
 hw/vfio/ap.c                          |  6 ++----
 hw/vfio/ccw.c                         |  6 ++----
 hw/vfio/common.c                      |  4 ++--
 hw/vfio/container.c                   | 14 +++++++-------
 hw/vfio/iommufd.c                     | 11 +++++------
 hw/vfio/pci.c                         |  8 +++-----
 hw/vfio/platform.c                    |  7 +++----
 9 files changed, 28 insertions(+), 36 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index b9da6c08ef..a7b6fc8f46 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -198,8 +198,8 @@ void vfio_region_exit(VFIORegion *region);
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
index 3582d5f97a..c839cfd9cb 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -118,8 +118,8 @@ struct VFIOIOMMUClass {
     int (*dma_unmap)(const VFIOContainerBase *bcontainer,
                      hwaddr iova, ram_addr_t size,
                      IOMMUTLBEntry *iotlb);
-    int (*attach_device)(const char *name, VFIODevice *vbasedev,
-                         AddressSpace *as, Error **errp);
+    bool (*attach_device)(const char *name, VFIODevice *vbasedev,
+                          AddressSpace *as, Error **errp);
     void (*detach_device)(VFIODevice *vbasedev);
     /* migration feature */
     int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 7c4caa5938..d50600b702 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -156,7 +156,6 @@ static void vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
 static void vfio_ap_realize(DeviceState *dev, Error **errp)
 {
     ERRP_GUARD();
-    int ret;
     Error *err = NULL;
     VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
     VFIODevice *vbasedev = &vapdev->vdev;
@@ -165,9 +164,8 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
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
index 90e4a53437..782bd4bed7 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -580,7 +580,6 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
     S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
     VFIODevice *vbasedev = &vcdev->vdev;
     Error *err = NULL;
-    int ret;
 
     /* Call the class init function for subchannel. */
     if (cdc->realize) {
@@ -594,9 +593,8 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
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
index 8f9cbdc026..890d30910e 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1492,8 +1492,8 @@ retry:
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
index 77bdec276e..ea3b145913 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -908,8 +908,8 @@ static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
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
@@ -918,27 +918,27 @@ static int vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
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
@@ -946,7 +946,7 @@ static int vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
     QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
     QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
 
-    return ret;
+    return true;
 }
 
 static void vfio_legacy_detach_device(VFIODevice *vbasedev)
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 8827ffe636..9aa0dd6d8e 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -301,8 +301,8 @@ error:
     return ret;
 }
 
-static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
-                               AddressSpace *as, Error **errp)
+static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
+                                AddressSpace *as, Error **errp)
 {
     VFIOContainerBase *bcontainer;
     VFIOIOMMUFDContainer *container;
@@ -317,7 +317,7 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
     if (vbasedev->fd < 0) {
         devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
         if (devfd < 0) {
-            return devfd;
+            return false;
         }
         vbasedev->fd = devfd;
     } else {
@@ -394,7 +394,6 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
     memory_listener_register(&bcontainer->listener, bcontainer->space->as);
 
     if (bcontainer->error) {
-        ret = -1;
         error_propagate_prepend(errp, bcontainer->error,
                                 "memory listener initialization failed: ");
         goto err_listener_register;
@@ -433,7 +432,7 @@ found_container:
 
     trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
                                    vbasedev->num_regions, vbasedev->flags);
-    return 0;
+    return true;
 
 err_listener_register:
     iommufd_cdev_ram_block_discard_disable(false);
@@ -446,7 +445,7 @@ err_alloc_ioas:
     iommufd_cdev_unbind_and_disconnect(vbasedev);
 err_connect_bind:
     close(vbasedev->fd);
-    return ret;
+    return false;
 }
 
 static void iommufd_cdev_detach(VFIODevice *vbasedev)
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 64780d1b79..952e4b1a25 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2951,7 +2951,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     int i, ret;
     bool is_mdev;
     char uuid[UUID_STR_LEN];
-    char *name;
+    g_autofree char *name = NULL;
 
     if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
         if (!(~vdev->host.domain || ~vdev->host.bus ||
@@ -3001,10 +3001,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         name = g_strdup(vbasedev->name);
     }
 
-    ret = vfio_attach_device(name, vbasedev,
-                             pci_device_iommu_address_space(pdev), errp);
-    g_free(name);
-    if (ret) {
+    if (!vfio_attach_device(name, vbasedev,
+                            pci_device_iommu_address_space(pdev), errp)) {
         goto error;
     }
 
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index dcd2365fb3..2bd16096bb 100644
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
2.34.1


