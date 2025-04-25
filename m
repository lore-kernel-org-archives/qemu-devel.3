Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5B8C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Ejr-0005K0-Pi; Fri, 25 Apr 2025 04:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Ejj-0004kH-RN
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Ejg-0003JH-Vh
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NZKksoeGPtA0x0TVLG+fslSMScBsvNvXl+GKLyJ6Rgg=;
 b=dYMyt/aySPIN69tVI3Zk8JWQG25S++Bei2+5zLJJFBWZWoOImid7VUacPUFTkegtw+IBJT
 jojZpKCPebkPr8FjrqtKK/V7EP6SYRgPJXFIoWgzUVBsHBM76rdDhD2kAQutZixTj0tX0i
 0xMbodVdL+Y7Izit1tlj9a5lJgfiMY4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-Al44SyVGNLGATDeVJBWqhw-1; Fri,
 25 Apr 2025 04:48:31 -0400
X-MC-Unique: Al44SyVGNLGATDeVJBWqhw-1
X-Mimecast-MFC-AGG-ID: Al44SyVGNLGATDeVJBWqhw_1745570909
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0217E1956087; Fri, 25 Apr 2025 08:48:29 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7BF7030001A2; Fri, 25 Apr 2025 08:48:26 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, Avihai Horon <avihaih@nvidia.com>
Subject: [PULL 30/50] vfio: Move dirty tracking related services into
 container-base.c
Date: Fri, 25 Apr 2025 10:46:23 +0200
Message-ID: <20250425084644.102196-31-clg@redhat.com>
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

Routines of common.c :

 vfio_devices_all_dirty_tracking_started
 vfio_devices_all_device_dirty_tracking
 vfio_devices_query_dirty_bitmap
 vfio_get_dirty_bitmap

are all related to dirty page tracking directly at the container level
or at the container device level. Naming is a bit confusing. We will
propose new names in the following changes.

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-27-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h         |   9 --
 include/hw/vfio/vfio-container-base.h |   7 ++
 hw/vfio/common.c                      | 130 ------------------------
 hw/vfio/container-base.c              | 138 ++++++++++++++++++++++++++
 hw/vfio/meson.build                   |   2 +-
 hw/vfio/trace-events                  |   4 +-
 6 files changed, 149 insertions(+), 141 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 06178cf2828bdeb5e4881b6b3e2f67708a6df218..0dfae24b72906fa01c5003d1858d4dc101a5012e 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -141,15 +141,6 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
 bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type);
 #endif
 
-bool vfio_devices_all_dirty_tracking_started(
-    const VFIOContainerBase *bcontainer);
-bool
-vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
-int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
-                VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
-int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
-                          uint64_t size, ram_addr_t ram_addr, Error **errp);
-
 /* Returns 0 on success, or a negative errno. */
 bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index e0c458d487b8b6fc7ec7fb17bae84b4a937e6e2c..41ca27b3f0b72929d851f2cef4812c7a8003f916 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -91,6 +91,13 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
                                            bool start, Error **errp);
 int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                    VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
+bool vfio_devices_all_dirty_tracking_started(const VFIOContainerBase *bcontainer);
+bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
+int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
+                                    VFIOBitmap *vbmap, hwaddr iova, hwaddr size,
+                                    Error **errp);
+int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
+                          uint64_t size, ram_addr_t ram_addr, Error **errp);
 
 GList *vfio_container_get_iova_ranges(const VFIOContainerBase *bcontainer);
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 45ac8b7d8bdda391b1f8e04704908f2c0ef47aa8..ed49ef88a865521e16584844721b6ffa09427f18 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -51,27 +51,6 @@
  */
 
 
-static bool vfio_devices_all_device_dirty_tracking_started(
-    const VFIOContainerBase *bcontainer)
-{
-    VFIODevice *vbasedev;
-
-    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
-        if (!vbasedev->dirty_tracking) {
-            return false;
-        }
-    }
-
-    return true;
-}
-
-bool vfio_devices_all_dirty_tracking_started(
-    const VFIOContainerBase *bcontainer)
-{
-    return vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
-           bcontainer->dirty_pages_started;
-}
-
 static bool vfio_log_sync_needed(const VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
@@ -96,22 +75,6 @@ static bool vfio_log_sync_needed(const VFIOContainerBase *bcontainer)
     return true;
 }
 
-bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
-{
-    VFIODevice *vbasedev;
-
-    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
-        if (vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF) {
-            return false;
-        }
-        if (!vbasedev->dirty_pages_supported) {
-            return false;
-        }
-    }
-
-    return true;
-}
-
 static bool vfio_listener_skipped_section(MemoryRegionSection *section)
 {
     return (!memory_region_is_ram(section->mr) &&
@@ -1009,99 +972,6 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
     }
 }
 
-static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
-                                          hwaddr size, void *bitmap)
-{
-    uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
-                        sizeof(struct vfio_device_feature_dma_logging_report),
-                        sizeof(uint64_t))] = {};
-    struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
-    struct vfio_device_feature_dma_logging_report *report =
-        (struct vfio_device_feature_dma_logging_report *)feature->data;
-
-    report->iova = iova;
-    report->length = size;
-    report->page_size = qemu_real_host_page_size();
-    report->bitmap = (uintptr_t)bitmap;
-
-    feature->argsz = sizeof(buf);
-    feature->flags = VFIO_DEVICE_FEATURE_GET |
-                     VFIO_DEVICE_FEATURE_DMA_LOGGING_REPORT;
-
-    if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
-        return -errno;
-    }
-
-    return 0;
-}
-
-int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
-                 VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
-{
-    VFIODevice *vbasedev;
-    int ret;
-
-    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
-        ret = vfio_device_dma_logging_report(vbasedev, iova, size,
-                                             vbmap->bitmap);
-        if (ret) {
-            error_setg_errno(errp, -ret,
-                             "%s: Failed to get DMA logging report, iova: "
-                             "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRIx,
-                             vbasedev->name, iova, size);
-
-            return ret;
-        }
-    }
-
-    return 0;
-}
-
-int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
-                          uint64_t size, ram_addr_t ram_addr, Error **errp)
-{
-    bool all_device_dirty_tracking =
-        vfio_devices_all_device_dirty_tracking(bcontainer);
-    uint64_t dirty_pages;
-    VFIOBitmap vbmap;
-    int ret;
-
-    if (!bcontainer->dirty_pages_supported && !all_device_dirty_tracking) {
-        cpu_physical_memory_set_dirty_range(ram_addr, size,
-                                            tcg_enabled() ? DIRTY_CLIENTS_ALL :
-                                            DIRTY_CLIENTS_NOCODE);
-        return 0;
-    }
-
-    ret = vfio_bitmap_alloc(&vbmap, size);
-    if (ret) {
-        error_setg_errno(errp, -ret,
-                         "Failed to allocate dirty tracking bitmap");
-        return ret;
-    }
-
-    if (all_device_dirty_tracking) {
-        ret = vfio_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
-                                              errp);
-    } else {
-        ret = vfio_container_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
-                                                errp);
-    }
-
-    if (ret) {
-        goto out;
-    }
-
-    dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
-                                                         vbmap.pages);
-
-    trace_vfio_get_dirty_bitmap(iova, size, vbmap.size, ram_addr, dirty_pages);
-out:
-    g_free(vbmap.bitmap);
-
-    return ret;
-}
-
 typedef struct {
     IOMMUNotifier n;
     VFIOGuestIOMMU *giommu;
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 2c2d8329e3cf0f21386cb0896dd366c8d0ccdb60..f9cf317018b7ad8bfc2e013ce59c75a100eda7de 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -10,12 +10,20 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
+#include <sys/ioctl.h>
+#include <linux/vfio.h>
+
 #include "qemu/osdep.h"
+#include "system/tcg.h"
+#include "system/ram_addr.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/vfio/vfio-container-base.h"
 #include "hw/vfio/vfio-common.h" /* vfio_reset_handler */
 #include "system/reset.h"
+#include "vfio-helpers.h"
+
+#include "trace.h"
 
 static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =
     QLIST_HEAD_INITIALIZER(vfio_address_spaces);
@@ -143,6 +151,136 @@ int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                                                errp);
 }
 
+static bool vfio_devices_all_device_dirty_tracking_started(
+    const VFIOContainerBase *bcontainer)
+{
+    VFIODevice *vbasedev;
+
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
+        if (!vbasedev->dirty_tracking) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+bool vfio_devices_all_dirty_tracking_started(
+    const VFIOContainerBase *bcontainer)
+{
+    return vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
+           bcontainer->dirty_pages_started;
+}
+
+bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
+{
+    VFIODevice *vbasedev;
+
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
+        if (vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF) {
+            return false;
+        }
+        if (!vbasedev->dirty_pages_supported) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
+                                          hwaddr size, void *bitmap)
+{
+    uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
+                        sizeof(struct vfio_device_feature_dma_logging_report),
+                        sizeof(uint64_t))] = {};
+    struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
+    struct vfio_device_feature_dma_logging_report *report =
+        (struct vfio_device_feature_dma_logging_report *)feature->data;
+
+    report->iova = iova;
+    report->length = size;
+    report->page_size = qemu_real_host_page_size();
+    report->bitmap = (uintptr_t)bitmap;
+
+    feature->argsz = sizeof(buf);
+    feature->flags = VFIO_DEVICE_FEATURE_GET |
+                     VFIO_DEVICE_FEATURE_DMA_LOGGING_REPORT;
+
+    if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
+        return -errno;
+    }
+
+    return 0;
+}
+
+int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
+                 VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
+{
+    VFIODevice *vbasedev;
+    int ret;
+
+    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
+        ret = vfio_device_dma_logging_report(vbasedev, iova, size,
+                                             vbmap->bitmap);
+        if (ret) {
+            error_setg_errno(errp, -ret,
+                             "%s: Failed to get DMA logging report, iova: "
+                             "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRIx,
+                             vbasedev->name, iova, size);
+
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
+int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
+                          uint64_t size, ram_addr_t ram_addr, Error **errp)
+{
+    bool all_device_dirty_tracking =
+        vfio_devices_all_device_dirty_tracking(bcontainer);
+    uint64_t dirty_pages;
+    VFIOBitmap vbmap;
+    int ret;
+
+    if (!bcontainer->dirty_pages_supported && !all_device_dirty_tracking) {
+        cpu_physical_memory_set_dirty_range(ram_addr, size,
+                                            tcg_enabled() ? DIRTY_CLIENTS_ALL :
+                                            DIRTY_CLIENTS_NOCODE);
+        return 0;
+    }
+
+    ret = vfio_bitmap_alloc(&vbmap, size);
+    if (ret) {
+        error_setg_errno(errp, -ret,
+                         "Failed to allocate dirty tracking bitmap");
+        return ret;
+    }
+
+    if (all_device_dirty_tracking) {
+        ret = vfio_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
+                                              errp);
+    } else {
+        ret = vfio_container_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
+                                                errp);
+    }
+
+    if (ret) {
+        goto out;
+    }
+
+    dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
+                                                         vbmap.pages);
+
+    trace_vfio_get_dirty_bitmap(iova, size, vbmap.size, ram_addr, dirty_pages);
+out:
+    g_free(vbmap.bitmap);
+
+    return ret;
+}
+
 static gpointer copy_iova_range(gconstpointer src, gpointer data)
 {
      Range *source = (Range *)src;
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 1f89bd28c13dea55bcfff476ce99d51b453d8533..9c8a989db2d4578e97d864c5fd8bcba125eab66a 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -1,6 +1,7 @@
 vfio_ss = ss.source_set()
 vfio_ss.add(files(
   'common.c',
+  'container-base.c',
   'container.c',
   'helpers.c',
 ))
@@ -19,7 +20,6 @@ specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
 system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
 system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
 system_ss.add(when: 'CONFIG_VFIO', if_true: files(
-  'container-base.c',
   'cpr.c',
   'device.c',
   'migration.c',
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 9fee7df8764978723f79dc60d3dc796777278858..d4cd09cb0f93485fe06984346f6ac927603c5745 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -106,9 +106,11 @@ vfio_put_group(int fd) "close group->fd=%d"
 vfio_get_device(const char * name, unsigned int flags, unsigned int num_regions, unsigned int num_irqs) "Device %s flags: %u, regions: %u, irqs: %u"
 vfio_put_base_device(int fd) "close vdev->fd=%d"
 vfio_legacy_dma_unmap_overflow_workaround(void) ""
-vfio_get_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
 vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
 
+# container-base.c
+vfio_get_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
+
 # region.c
 vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
 vfio_region_read(char *name, int index, uint64_t addr, unsigned size, uint64_t data) " (%s:region%d+0x%"PRIx64", %d) = 0x%"PRIx64
-- 
2.49.0


