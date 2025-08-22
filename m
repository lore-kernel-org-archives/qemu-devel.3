Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE1FCA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 06:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upLT7-0007vB-QN; Fri, 22 Aug 2025 02:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1upLT4-0007u2-KJ
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 02:41:43 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1upLT2-0000jU-66
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 02:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755844900; x=1787380900;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=j9BUDEdPkepsUPSsAMfsaiLzD6xBlNlki1/uTIHYAWc=;
 b=VolTzfVLRBskIG8obH8wvk50uXwqzIWPCdKd4ANRq6tLkXjBQV5h/XuP
 qZGvrxO8MW1nrpWZU6xS+K5GvTrxDIFYzPgb12gUjg0Efg3YZKfVhV7Vu
 3pmvcbueNeSZK6PrnipARi5P3EyJSOUMrk7aWYpKr+YnDWQFWsmKEgkQC
 OuWzyDt/nwIwib3+TY593F9WFpiihN7eEx245drtMAdLaXQK7q4pk1cvo
 BKyyKc69u+d2lnFYpY8AxoDJzohrle3QRHwKTBqyWvmF9JEOLcCo9iCo2
 oyinw7c0JDRGRomFS/G3oK4azC7goto5ETHdwPzTYHfSZmbO8reHnQxH2 w==;
X-CSE-ConnectionGUID: Ehvfy0/+QWi1+y6Vcaq53Q==
X-CSE-MsgGUID: AhP9MUSgRemwL6mdCN690Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68851813"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; d="scan'208";a="68851813"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 23:41:39 -0700
X-CSE-ConnectionGUID: ixvjr/V5RESm482mdX4WQg==
X-CSE-MsgGUID: RIZVvEuKQEOg+gYy53aMEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; d="scan'208";a="168244907"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 23:41:36 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 04/21] vfio: Introduce helper vfio_pci_from_vfio_device()
Date: Fri, 22 Aug 2025 02:40:42 -0400
Message-ID: <20250822064101.123526-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250822064101.123526-1-zhenzhong.duan@intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Introduce helper vfio_pci_from_vfio_device() to transform from VFIODevice
to VFIOPCIDevice, also to hide low level VFIO_DEVICE_TYPE_PCI type check.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250801023533.1458644-1-zhenzhong.duan@intel.com
[ clg: Added documentation ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h       | 12 ++++++++++++
 hw/vfio/container.c |  4 ++--
 hw/vfio/device.c    |  2 +-
 hw/vfio/iommufd.c   |  4 ++--
 hw/vfio/listener.c  |  4 ++--
 hw/vfio/pci.c       |  9 +++++++++
 6 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 810a842f4a..beb8fb9ee7 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -221,6 +221,18 @@ void vfio_pci_write_config(PCIDevice *pdev,
 uint64_t vfio_vga_read(void *opaque, hwaddr addr, unsigned size);
 void vfio_vga_write(void *opaque, hwaddr addr, uint64_t data, unsigned size);
 
+/**
+ * vfio_pci_from_vfio_device: Transform from VFIODevice to
+ * VFIOPCIDevice
+ *
+ * This function checks if the given @vbasedev is a VFIO PCI device.
+ * If it is, it returns the containing VFIOPCIDevice.
+ *
+ * @vbasedev: The VFIODevice to transform
+ *
+ * Return: The VFIOPCIDevice on success, NULL on failure.
+ */
+VFIOPCIDevice *vfio_pci_from_vfio_device(VFIODevice *vbasedev);
 void vfio_sub_page_bar_update_mappings(VFIOPCIDevice *vdev);
 bool vfio_opt_rom_in_denylist(VFIOPCIDevice *vdev);
 bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp);
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 3e13feaa74..134ddccc52 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1087,7 +1087,7 @@ static int vfio_legacy_pci_hot_reset(VFIODevice *vbasedev, bool single)
         /* Prep dependent devices for reset and clear our marker. */
         QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
             if (!vbasedev_iter->dev->realized ||
-                vbasedev_iter->type != VFIO_DEVICE_TYPE_PCI) {
+                !vfio_pci_from_vfio_device(vbasedev_iter)) {
                 continue;
             }
             tmp = container_of(vbasedev_iter, VFIOPCIDevice, vbasedev);
@@ -1172,7 +1172,7 @@ out:
 
         QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
             if (!vbasedev_iter->dev->realized ||
-                vbasedev_iter->type != VFIO_DEVICE_TYPE_PCI) {
+                !vfio_pci_from_vfio_device(vbasedev_iter)) {
                 continue;
             }
             tmp = container_of(vbasedev_iter, VFIOPCIDevice, vbasedev);
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 52a1996dc4..08f12ac31f 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -129,7 +129,7 @@ static inline const char *action_to_str(int action)
 
 static const char *index_to_str(VFIODevice *vbasedev, int index)
 {
-    if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
+    if (!vfio_pci_from_vfio_device(vbasedev)) {
         return NULL;
     }
 
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 48c590b6a9..8c27222f75 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -737,8 +737,8 @@ iommufd_cdev_dep_get_realized_vpdev(struct vfio_pci_dependent_device *dep_dev,
     }
 
     vbasedev_tmp = iommufd_cdev_pci_find_by_devid(dep_dev->devid);
-    if (!vbasedev_tmp || !vbasedev_tmp->dev->realized ||
-        vbasedev_tmp->type != VFIO_DEVICE_TYPE_PCI) {
+    if (!vfio_pci_from_vfio_device(vbasedev_tmp) ||
+        !vbasedev_tmp->dev->realized) {
         return NULL;
     }
 
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index f498e23a93..903dfd8bf2 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -450,7 +450,7 @@ static void vfio_device_error_append(VFIODevice *vbasedev, Error **errp)
      * MMIO region mapping failures are not fatal but in this case PCI
      * peer-to-peer transactions are broken.
      */
-    if (vbasedev && vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
+    if (vfio_pci_from_vfio_device(vbasedev)) {
         error_append_hint(errp, "%s: PCI peer-to-peer transactions "
                           "on BARs are not supported.\n", vbasedev->name);
     }
@@ -751,7 +751,7 @@ static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
     owner = memory_region_owner(section->mr);
 
     QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
-        if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
+        if (!vfio_pci_from_vfio_device(vbasedev)) {
             continue;
         }
         pcidev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 07257d0fa0..3fe5b03eb1 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2833,6 +2833,15 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
     return ret;
 }
 
+/* Transform from VFIODevice to VFIOPCIDevice. Return NULL if fails. */
+VFIOPCIDevice *vfio_pci_from_vfio_device(VFIODevice *vbasedev)
+{
+    if (vbasedev && vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
+        return container_of(vbasedev, VFIOPCIDevice, vbasedev);
+    }
+    return NULL;
+}
+
 void vfio_sub_page_bar_update_mappings(VFIOPCIDevice *vdev)
 {
     PCIDevice *pdev = &vdev->pdev;
-- 
2.47.1


