Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9556CC3600D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 07:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txLZi-0001SX-Tj; Wed, 26 Mar 2025 03:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txLZa-0001JU-8y
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:53:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txLZY-0006LZ-It
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742975592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gj/gFT8FN/ASp8mRiX7o0p410g5BSlQcpz9PIz0IlUY=;
 b=a+EhdOJdJ6QZJhngjjRPIiLPDN8/ClwNXqIJZjpYVbvDiq14g9bF1rKwB/87sfmyr49E1b
 6bVD6LKaRq28g0jzHes++CtCj7GXsIH2y1fY/IWbaY6tSnPmFF6RJjwboXEpe/W4lFkkBQ
 yjw7lsh1RSewoeMZ+WK3D6P2NFYzV08=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-tf_PRfX_OqW0ys_siVN3Aw-1; Wed,
 26 Mar 2025 03:53:08 -0400
X-MC-Unique: tf_PRfX_OqW0ys_siVN3Aw-1
X-Mimecast-MFC-AGG-ID: tf_PRfX_OqW0ys_siVN3Aw_1742975587
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B362E180AF4D; Wed, 26 Mar 2025 07:53:07 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.226.180])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8A93E19560AB; Wed, 26 Mar 2025 07:53:04 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 v2 25/37] vfio: Move vfio_reset_handler() into
 device.c
Date: Wed, 26 Mar 2025 08:51:10 +0100
Message-ID: <20250326075122.1299361-26-clg@redhat.com>
In-Reply-To: <20250326075122.1299361-1-clg@redhat.com>
References: <20250326075122.1299361-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c     | 18 ------------------
 hw/vfio/device.c     | 35 +++++++++++++++++++++++++++++++++++
 hw/vfio/trace-events |  2 +-
 3 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index a4052526ece5fdee0e690ad133416d1dc4eb1815..e62bb3818c55a789e81fe50cebf7c6693228db31 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1301,21 +1301,3 @@ const MemoryListener vfio_memory_listener = {
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


