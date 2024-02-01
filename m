Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30292C47DDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 07:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVRX9-0005VQ-TX; Thu, 01 Feb 2024 02:30:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRX8-0005UK-Fo; Thu, 01 Feb 2024 02:30:50 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRX4-0001ck-1Q; Thu, 01 Feb 2024 02:30:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706772646; x=1738308646;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TgSkZfw+it2zJiFcuri/JTQyY0VaeQ1D5N/sRZjophw=;
 b=JX6ODzplnBgH+po5S9cAPaejaiR/If0WC7RtpNl8YcSDQa5iMRo529xT
 OX7iKnPsSuWu+18btu+0tFf4a3Cq0EiUMaWjBXfRnEE8Q0p0vDQGrXG4F
 dJuhghg7xNXYAsWKmOReteCZyovjvIcGa1AT5G+vKTMRS5QSmLvVL27fl
 e+VQ0ylxmyn38WdlXK+6Jo9vsGtNV+lECzxfm2phwnhC8SM07uiIRIhVE
 zhrKtjSyvROskVY2i1sWRrkwE588OaC/3RTdxjLtJsU85sZ3HqTkRJ+58
 YKDModsGZmBYHt76m3SpVdwSt5yCVshXNvY/1Z7eFKbRMU9G1k/G1Eilw w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="402676690"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; d="scan'208";a="402676690"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:30:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4443226"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:30:37 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Thomas Huth <thuth@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:S390 general arch...)
Subject: [PATCH rfcv2 05/18] vfio: Remove redundant iommufd and devid elements
 in VFIODevice
Date: Thu,  1 Feb 2024 15:28:05 +0800
Message-Id: <20240201072818.327930-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201072818.327930-1-zhenzhong.duan@intel.com>
References: <20240201072818.327930-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

iommufd and devid in VFIODevice are redundant with the ones
in IOMMUFDDevice, so remove them.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h |  2 --
 hw/vfio/ap.c                  |  2 +-
 hw/vfio/ccw.c                 |  2 +-
 hw/vfio/common.c              |  2 +-
 hw/vfio/helpers.c             |  2 +-
 hw/vfio/iommufd.c             | 26 ++++++++++++++------------
 hw/vfio/pci.c                 |  2 +-
 hw/vfio/platform.c            |  3 ++-
 8 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 1bbad003ee..24e3eaaf3d 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -131,8 +131,6 @@ typedef struct VFIODevice {
     OnOffAuto pre_copy_dirty_page_tracking;
     bool dirty_pages_supported;
     bool dirty_tracking;
-    int devid;
-    IOMMUFDBackend *iommufd;
     union {
         HostIOMMUDevice base_hdev;
         IOMMULegacyDevice legacy_dev;
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index e157aa1ff7..11526d93d4 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -198,7 +198,7 @@ static void vfio_ap_unrealize(DeviceState *dev)
 static Property vfio_ap_properties[] = {
     DEFINE_PROP_STRING("sysfsdev", VFIOAPDevice, vdev.sysfsdev),
 #ifdef CONFIG_IOMMUFD
-    DEFINE_PROP_LINK("iommufd", VFIOAPDevice, vdev.iommufd,
+    DEFINE_PROP_LINK("iommufd", VFIOAPDevice, vdev.iommufd_dev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
 #endif
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 90e4a53437..b1b75ffa2a 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -667,7 +667,7 @@ static Property vfio_ccw_properties[] = {
     DEFINE_PROP_STRING("sysfsdev", VFIOCCWDevice, vdev.sysfsdev),
     DEFINE_PROP_BOOL("force-orb-pfch", VFIOCCWDevice, force_orb_pfch, false),
 #ifdef CONFIG_IOMMUFD
-    DEFINE_PROP_LINK("iommufd", VFIOCCWDevice, vdev.iommufd,
+    DEFINE_PROP_LINK("iommufd", VFIOCCWDevice, vdev.iommufd_dev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
 #endif
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 059bfdc07a..8b3b575c9d 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1505,7 +1505,7 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
     const VFIOIOMMUClass *ops =
         VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
 
-    if (vbasedev->iommufd) {
+    if (vbasedev->iommufd_dev.iommufd) {
         ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
     }
 
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 6789870802..e5457ca326 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -626,7 +626,7 @@ int vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
             vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
         }
     } else {
-        if (!vbasedev->iommufd) {
+        if (!vbasedev->iommufd_dev.iommufd) {
             error_setg(errp, "Use FD passing only with iommufd backend");
             return -EINVAL;
         }
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 9bfddc1360..5d50549713 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -65,7 +65,7 @@ static void iommufd_cdev_kvm_device_del(VFIODevice *vbasedev)
 
 static int iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
 {
-    IOMMUFDBackend *iommufd = vbasedev->iommufd;
+    IOMMUFDBackend *iommufd = vbasedev->iommufd_dev.iommufd;
     struct vfio_device_bind_iommufd bind = {
         .argsz = sizeof(bind),
         .flags = 0,
@@ -96,9 +96,10 @@ static int iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
         goto err_bind;
     }
 
-    vbasedev->devid = bind.out_devid;
+    vbasedev->iommufd_dev.devid = bind.out_devid;
     trace_iommufd_cdev_connect_and_bind(bind.iommufd, vbasedev->name,
-                                        vbasedev->fd, vbasedev->devid);
+                                        vbasedev->fd,
+                                        vbasedev->iommufd_dev.devid);
     return ret;
 err_bind:
     iommufd_cdev_kvm_device_del(vbasedev);
@@ -111,7 +112,7 @@ static void iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
 {
     /* Unbind is automatically conducted when device fd is closed */
     iommufd_cdev_kvm_device_del(vbasedev);
-    iommufd_backend_disconnect(vbasedev->iommufd);
+    iommufd_backend_disconnect(vbasedev->iommufd_dev.iommufd);
 }
 
 static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
@@ -181,7 +182,7 @@ out_free_path:
 static int iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, uint32_t id,
                                          Error **errp)
 {
-    int ret, iommufd = vbasedev->iommufd->fd;
+    int ret, iommufd = vbasedev->iommufd_dev.iommufd->fd;
     struct vfio_device_attach_iommufd_pt attach_data = {
         .argsz = sizeof(attach_data),
         .flags = 0,
@@ -203,7 +204,7 @@ static int iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, uint32_t id,
 
 static int iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
 {
-    int ret, iommufd = vbasedev->iommufd->fd;
+    int ret, iommufd = vbasedev->iommufd_dev.iommufd->fd;
     struct vfio_device_detach_iommufd_pt detach_data = {
         .argsz = sizeof(detach_data),
         .flags = 0,
@@ -337,7 +338,7 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
     QLIST_FOREACH(bcontainer, &space->containers, next) {
         container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
         if (bcontainer->ops != iommufd_vioc ||
-            vbasedev->iommufd != container->be) {
+            vbasedev->iommufd_dev.iommufd != container->be) {
             continue;
         }
         if (iommufd_cdev_attach_container(vbasedev, container, &err)) {
@@ -358,15 +359,16 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
     }
 
     /* Need to allocate a new dedicated container */
-    ret = iommufd_backend_alloc_ioas(vbasedev->iommufd, &ioas_id, errp);
+    ret = iommufd_backend_alloc_ioas(vbasedev->iommufd_dev.iommufd,
+                                     &ioas_id, errp);
     if (ret < 0) {
         goto err_alloc_ioas;
     }
 
-    trace_iommufd_cdev_alloc_ioas(vbasedev->iommufd->fd, ioas_id);
+    trace_iommufd_cdev_alloc_ioas(vbasedev->iommufd_dev.iommufd->fd, ioas_id);
 
     container = g_malloc0(sizeof(*container));
-    container->be = vbasedev->iommufd;
+    container->be = vbasedev->iommufd_dev.iommufd;
     container->ioas_id = ioas_id;
 
     bcontainer = &container->bcontainer;
@@ -479,7 +481,7 @@ static VFIODevice *iommufd_cdev_pci_find_by_devid(__u32 devid)
         if (vbasedev_iter->bcontainer->ops != iommufd_vioc) {
             continue;
         }
-        if (devid == vbasedev_iter->devid) {
+        if (devid == vbasedev_iter->iommufd_dev.devid) {
             return vbasedev_iter;
         }
     }
@@ -492,7 +494,7 @@ iommufd_cdev_dep_get_realized_vpdev(struct vfio_pci_dependent_device *dep_dev,
 {
     VFIODevice *vbasedev_tmp;
 
-    if (dep_dev->devid == reset_dev->devid ||
+    if (dep_dev->devid == reset_dev->iommufd_dev.devid ||
         dep_dev->devid == VFIO_PCI_DEVID_OWNED) {
         return NULL;
     }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 4fa387f043..d1e1b8cb89 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3385,7 +3385,7 @@ static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice, msix_relo,
                                 OFF_AUTOPCIBAR_OFF),
 #ifdef CONFIG_IOMMUFD
-    DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
+    DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd_dev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
 #endif
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index a8d9b7da63..823a17b9c5 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -646,7 +646,8 @@ static Property vfio_platform_dev_properties[] = {
                        mmap_timeout, 1100),
     DEFINE_PROP_BOOL("x-irqfd", VFIOPlatformDevice, irqfd_allowed, true),
 #ifdef CONFIG_IOMMUFD
-    DEFINE_PROP_LINK("iommufd", VFIOPlatformDevice, vbasedev.iommufd,
+    DEFINE_PROP_LINK("iommufd", VFIOPlatformDevice,
+                     vbasedev.iommufd_dev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
 #endif
     DEFINE_PROP_END_OF_LIST(),
-- 
2.34.1


