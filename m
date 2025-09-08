Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E0BCA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 17:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvf8u-00074e-Gr; Mon, 08 Sep 2025 12:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf8b-0006fe-JK
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:54:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf8T-0001ax-OT
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757350469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xZbfSTP/JfACJayh18nuWhbeIHHE2nsgBhjOK4FY6p8=;
 b=US3Kh+SDzR40BAQ6WgR5acmmYkcEXxOeNoHmMz4bLfaFvXbFF+Qxqdbgm8RxbFzlisAJe8
 erRkQDMR0BIOf06YOJ27l/DuOMI0skGe9uX10dhC1VRbWpSjZNoFQXmV8uURHTnOaY54ER
 1sHKBnfgSgrQhwd11K1eJjxWa0vlhqU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-l2WNfykDOmidbRKWdO0cTw-1; Mon,
 08 Sep 2025 12:54:28 -0400
X-MC-Unique: l2WNfykDOmidbRKWdO0cTw-1
X-Mimecast-MFC-AGG-ID: l2WNfykDOmidbRKWdO0cTw_1757350467
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9CF819560A1; Mon,  8 Sep 2025 16:54:27 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.50])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1267A30001B5; Mon,  8 Sep 2025 16:54:25 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/31] vfio: Introduce helper vfio_pci_from_vfio_device()
Date: Mon,  8 Sep 2025 18:53:33 +0200
Message-ID: <20250908165354.1731444-11-clg@redhat.com>
In-Reply-To: <20250908165354.1731444-1-clg@redhat.com>
References: <20250908165354.1731444-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Introduce helper vfio_pci_from_vfio_device() to transform from VFIODevice
to VFIOPCIDevice, also to hide low level VFIO_DEVICE_TYPE_PCI type check.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250822064101.123526-5-zhenzhong.duan@intel.com
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
index 923cf9c2f79d078546239bf67195d6ba8157265a..96144b6fdeb94dccf6c0beecf039a12b9845c59b 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -226,6 +226,18 @@ void vfio_pci_write_config(PCIDevice *pdev,
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
index 3e13feaa74c30e8d7f5a0978e15824cecbf6d674..134ddccc52449cd7d4ac90d17075e9fca5439674 100644
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
index 52a1996dc4e122499a978cc8a5ce7e01620a9639..08f12ac31f44fdebc9fc1f23f716c52f391ed53e 100644
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
index 48c590b6a9467c8139131bef8b92864893a8f2e6..8c27222f754a22f47fda6b6a1a86005341ec0d7f 100644
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
index c244be5e218ae60e2b9c8a29d2d4b9dad86fc77a..e0938331659833bdca98e700ac42651a90fb1571 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -453,7 +453,7 @@ static void vfio_device_error_append(VFIODevice *vbasedev, Error **errp)
      * MMIO region mapping failures are not fatal but in this case PCI
      * peer-to-peer transactions are broken.
      */
-    if (vbasedev && vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
+    if (vfio_pci_from_vfio_device(vbasedev)) {
         error_append_hint(errp, "%s: PCI peer-to-peer transactions "
                           "on BARs are not supported.\n", vbasedev->name);
     }
@@ -759,7 +759,7 @@ static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
     owner = memory_region_owner(section->mr);
 
     QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
-        if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
+        if (!vfio_pci_from_vfio_device(vbasedev)) {
             continue;
         }
         pcidev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 07257d0fa049b09fc296ac2279a6fafbdf93d277..3fe5b03eb1160bb66fc4ae3942d14a2d71b4431a 100644
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
2.51.0


