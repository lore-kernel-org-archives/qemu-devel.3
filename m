Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B364C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Ejf-0004JU-FW; Fri, 25 Apr 2025 04:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EjX-0003ss-CL
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EjU-0003Im-Ue
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JuyI2BP2Uw5ICAcdUFrJFyVDVLPFvBreXiY90oKENKo=;
 b=I07MxPa4xT/130dKtOQceYSHnnNAihfsIxlHq4Q7tLgCaZMaU5ClIGLQnS3WBrlwb56vKI
 n+OlEENFlrvLYk1QQikTHIyA0FPs8JRynfNvuu5Sosir9Yatp5iNTb/GJ+gMRPmrXXuyeC
 GsEO6F9gS86ykbeipK+vl9V5yjqfuug=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-8IJjDR2-NxC7JaPsctzZ8g-1; Fri,
 25 Apr 2025 04:48:26 -0400
X-MC-Unique: 8IJjDR2-NxC7JaPsctzZ8g-1
X-Mimecast-MFC-AGG-ID: 8IJjDR2-NxC7JaPsctzZ8g_1745570906
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F21631956089; Fri, 25 Apr 2025 08:48:25 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0017630001A2; Fri, 25 Apr 2025 08:48:23 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PULL 29/50] vfio: Move vfio_reset_handler() into device.c
Date: Fri, 25 Apr 2025 10:46:22 +0200
Message-ID: <20250425084644.102196-30-clg@redhat.com>
In-Reply-To: <20250425084644.102196-1-clg@redhat.com>
References: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Pass-through devices of a VM are not necessarily in the same group and
all groups/address_spaces need to be scanned when the machine is
reset. Commit f16f39c3fc97 ("Implement PCI hot reset") introduced a VM
reset handler for this purpose. Move it under device.c

Also reintroduce the comment which explained the context and was lost
along the way.

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-26-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c     | 18 ------------------
 hw/vfio/device.c     | 35 +++++++++++++++++++++++++++++++++++
 hw/vfio/trace-events |  2 +-
 3 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index a85ed364090f6676cbbc9b513f6afbf26b5a894b..45ac8b7d8bdda391b1f8e04704908f2c0ef47aa8 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1300,21 +1300,3 @@ const MemoryListener vfio_memory_listener = {
     .log_global_stop = vfio_listener_log_global_stop,
     .log_sync = vfio_listener_log_sync,
 };
-
-void vfio_reset_handler(void *opaque)
-{
-    VFIODevice *vbasedev;
-
-    trace_vfio_reset_handler();
-    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
-        if (vbasedev->dev->realized) {
-            vbasedev->ops->vfio_compute_needs_reset(vbasedev);
-        }
-    }
-
-    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
-        if (vbasedev->dev->realized && vbasedev->needs_reset) {
-            vbasedev->ops->vfio_hot_reset_multi(vbasedev);
-        }
-    }
-}
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 179c9fb8decc42dcd8d1b4fe10e7acaa2a6f2c7c..e122c797c206c285ef26c3a56d841d8c3be8b58b 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -34,6 +34,41 @@
 VFIODeviceList vfio_device_list =
     QLIST_HEAD_INITIALIZER(vfio_device_list);
 
+/*
+ * We want to differentiate hot reset of multiple in-use devices vs
+ * hot reset of a single in-use device. VFIO_DEVICE_RESET will already
+ * handle the case of doing hot resets when there is only a single
+ * device per bus. The in-use here refers to how many VFIODevices are
+ * affected. A hot reset that affects multiple devices, but only a
+ * single in-use device, means that we can call it from our bus
+ * ->reset() callback since the extent is effectively a single
+ * device. This allows us to make use of it in the hotplug path. When
+ * there are multiple in-use devices, we can only trigger the hot
+ * reset during a system reset and thus from our reset handler. We
+ * separate _one vs _multi here so that we don't overlap and do a
+ * double reset on the system reset path where both our reset handler
+ * and ->reset() callback are used. Calling _one() will only do a hot
+ * reset for the one in-use devices case, calling _multi() will do
+ * nothing if a _one() would have been sufficient.
+ */
+void vfio_reset_handler(void *opaque)
+{
+    VFIODevice *vbasedev;
+
+    trace_vfio_reset_handler();
+    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
+        if (vbasedev->dev->realized) {
+            vbasedev->ops->vfio_compute_needs_reset(vbasedev);
+        }
+    }
+
+    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
+        if (vbasedev->dev->realized && vbasedev->needs_reset) {
+            vbasedev->ops->vfio_hot_reset_multi(vbasedev);
+        }
+    }
+}
+
 /*
  * Common VFIO interrupt disable
  */
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 590d9674cf7bc47171516082abaf398dda72b86d..9fee7df8764978723f79dc60d3dc796777278858 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -108,7 +108,6 @@ vfio_put_base_device(int fd) "close vdev->fd=%d"
 vfio_legacy_dma_unmap_overflow_workaround(void) ""
 vfio_get_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
 vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
-vfio_reset_handler(void) ""
 
 # region.c
 vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
@@ -196,3 +195,4 @@ iommufd_cdev_pci_hot_reset_dep_devices(int domain, int bus, int slot, int functi
 
 # device.c
 vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%08x"
+vfio_reset_handler(void) ""
-- 
2.49.0


