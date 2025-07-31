Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C780C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 03:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhK1K-00062o-DW; Wed, 30 Jul 2025 23:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uhK15-0005yD-HI
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 23:31:40 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uhK11-00060Q-MZ
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 23:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753932696; x=1785468696;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VhtcVmUm2FzZ61Vipj+EjWtzKKxvGDSpiLjIWnbDdmY=;
 b=UoPpdG5MhZQNW7em0e2gmPiw1aqUrupaY/n6L0WD2VYmqKdhSUnSWz2z
 hpeQrv35iuxYQK0BrXdqfdOun7TbvJzGfyLYDyhWuMGd3IH1EVIH6w6Hv
 iqthnts1L3LUPtdOZZTc2W6l1LIv2uU0WI0gLibroul57XXtta13X4aCa
 DMzkr4f6/rcwhGyw34X5E6eJ1B7H19csBG29LWdrJ68YD3EBFFd05SxVP
 cbBC+1IlRjLuiq/b+IipBinV25238sSk0IBK49ApmjD/hsKguWllQYNik
 nT7t0Ew+AtukJdEuSgBkZsgFSmdZS6+Bb0OOdMPwR+zkfjajjtDIJlKKk Q==;
X-CSE-ConnectionGUID: 5zPh1Ii2T4ymrU0cc0u7oA==
X-CSE-MsgGUID: SWQ5KhqJSHylc1tvqyfWmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56112876"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; d="scan'208";a="56112876"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 20:31:34 -0700
X-CSE-ConnectionGUID: Gu05R+DzTs+gMuNnZG7CIw==
X-CSE-MsgGUID: hiuYuwlpRa2O0O+OWzKVgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; d="scan'208";a="163505658"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 20:31:32 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH] vfio: Introduce helper vfio_device_to_vfio_pci()
Date: Wed, 30 Jul 2025 23:31:23 -0400
Message-ID: <20250731033123.1093663-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Introduce helper vfio_device_to_vfio_pci() to transform from VFIODevice to
VFIOPCIDevice, also to hide low level VFIO_DEVICE_TYPE_PCI type check.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-device.h |  1 +
 hw/vfio/container.c           |  4 ++--
 hw/vfio/device.c              | 10 +++++++++-
 hw/vfio/iommufd.c             |  4 ++--
 hw/vfio/listener.c            |  4 ++--
 5 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 6e4d5ccdac..00df40d997 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -157,6 +157,7 @@ bool vfio_device_attach_by_iommu_type(const char *iommu_type, char *name,
                                       Error **errp);
 void vfio_device_detach(VFIODevice *vbasedev);
 VFIODevice *vfio_get_vfio_device(Object *obj);
+struct VFIOPCIDevice *vfio_device_to_vfio_pci(VFIODevice *vbasedev);
 
 typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIODeviceList vfio_device_list;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 3e13feaa74..f847e3e429 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1087,7 +1087,7 @@ static int vfio_legacy_pci_hot_reset(VFIODevice *vbasedev, bool single)
         /* Prep dependent devices for reset and clear our marker. */
         QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
             if (!vbasedev_iter->dev->realized ||
-                vbasedev_iter->type != VFIO_DEVICE_TYPE_PCI) {
+                !vfio_device_to_vfio_pci(vbasedev_iter)) {
                 continue;
             }
             tmp = container_of(vbasedev_iter, VFIOPCIDevice, vbasedev);
@@ -1172,7 +1172,7 @@ out:
 
         QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
             if (!vbasedev_iter->dev->realized ||
-                vbasedev_iter->type != VFIO_DEVICE_TYPE_PCI) {
+                !vfio_device_to_vfio_pci(vbasedev_iter)) {
                 continue;
             }
             tmp = container_of(vbasedev_iter, VFIOPCIDevice, vbasedev);
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 52a1996dc4..a4f9c9216c 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -129,7 +129,7 @@ static inline const char *action_to_str(int action)
 
 static const char *index_to_str(VFIODevice *vbasedev, int index)
 {
-    if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
+    if (!vfio_device_to_vfio_pci(vbasedev)) {
         return NULL;
     }
 
@@ -429,6 +429,14 @@ VFIODevice *vfio_get_vfio_device(Object *obj)
     }
 }
 
+VFIOPCIDevice *vfio_device_to_vfio_pci(VFIODevice *vbasedev)
+{
+    if (vbasedev && vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
+        return container_of(vbasedev, VFIOPCIDevice, vbasedev);
+    }
+    return NULL;
+}
+
 bool vfio_device_attach_by_iommu_type(const char *iommu_type, char *name,
                                       VFIODevice *vbasedev, AddressSpace *as,
                                       Error **errp)
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 48c590b6a9..c5c89a700e 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -737,8 +737,8 @@ iommufd_cdev_dep_get_realized_vpdev(struct vfio_pci_dependent_device *dep_dev,
     }
 
     vbasedev_tmp = iommufd_cdev_pci_find_by_devid(dep_dev->devid);
-    if (!vbasedev_tmp || !vbasedev_tmp->dev->realized ||
-        vbasedev_tmp->type != VFIO_DEVICE_TYPE_PCI) {
+    if (!vfio_device_to_vfio_pci(vbasedev_tmp) ||
+        !vbasedev_tmp->dev->realized) {
         return NULL;
     }
 
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index f498e23a93..fe15172f22 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -450,7 +450,7 @@ static void vfio_device_error_append(VFIODevice *vbasedev, Error **errp)
      * MMIO region mapping failures are not fatal but in this case PCI
      * peer-to-peer transactions are broken.
      */
-    if (vbasedev && vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
+    if (vfio_device_to_vfio_pci(vbasedev)) {
         error_append_hint(errp, "%s: PCI peer-to-peer transactions "
                           "on BARs are not supported.\n", vbasedev->name);
     }
@@ -751,7 +751,7 @@ static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
     owner = memory_region_owner(section->mr);
 
     QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
-        if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
+        if (!vfio_device_to_vfio_pci(vbasedev)) {
             continue;
         }
         pcidev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
-- 
2.47.1


