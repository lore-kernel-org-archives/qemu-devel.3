Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D121C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 13:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXi4B-0006iE-9w; Wed, 07 Feb 2024 08:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org>)
 id 1rXi46-0006fn-VE
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:34:15 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org>)
 id 1rXi44-0008PL-QL
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:34:14 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TVLgP16d9z4x0n;
 Thu,  8 Feb 2024 00:34:09 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TVLgM2gc0z4x0m;
 Thu,  8 Feb 2024 00:34:07 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 05/14] vfio: Add Error** argument to
 .set_dirty_page_tracking() handler
Date: Wed,  7 Feb 2024 14:33:38 +0100
Message-ID: <20240207133347.1115903-6-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207133347.1115903-1-clg@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

We will use the Error object to improve error reporting in the
.log_global*() handlers of VFIO.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h | 4 ++--
 hw/vfio/common.c                      | 4 ++--
 hw/vfio/container-base.c              | 4 ++--
 hw/vfio/container.c                   | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index b2813b0c117985425c842d91f011bb895955d738..f22fcb5a214be2717b42815371346401bb7fce51 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -81,7 +81,7 @@ int vfio_container_add_section_window(VFIOContainerBase *bcontainer,
 void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
                                        MemoryRegionSection *section);
 int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
-                                           bool start);
+                                           bool start, Error **errp);
 int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                                       VFIOBitmap *vbmap,
                                       hwaddr iova, hwaddr size);
@@ -122,7 +122,7 @@ struct VFIOIOMMUClass {
     void (*detach_device)(VFIODevice *vbasedev);
     /* migration feature */
     int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
-                                   bool start);
+                                   bool start, Error **errp);
     int (*query_dirty_bitmap)(const VFIOContainerBase *bcontainer,
                               VFIOBitmap *vbmap,
                               hwaddr iova, hwaddr size);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 45af5c675584e1931dfba3b4f78469cc4c00014e..03f2059d903eca335b02f633b07cd35ef3dd6237 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1085,7 +1085,7 @@ static void vfio_listener_log_global_start(MemoryListener *listener,
     if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
         ret = vfio_devices_dma_logging_start(bcontainer);
     } else {
-        ret = vfio_container_set_dirty_page_tracking(bcontainer, true);
+        ret = vfio_container_set_dirty_page_tracking(bcontainer, true, NULL);
     }
 
     if (ret) {
@@ -1105,7 +1105,7 @@ static void vfio_listener_log_global_stop(MemoryListener *listener,
     if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
         vfio_devices_dma_logging_stop(bcontainer);
     } else {
-        ret = vfio_container_set_dirty_page_tracking(bcontainer, false);
+        ret = vfio_container_set_dirty_page_tracking(bcontainer, false, NULL);
     }
 
     if (ret) {
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 913ae49077c4f09b7b27517c1231cfbe4befb7fb..7c0764121d24b02b6c4e66e368d7dff78a6d65aa 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -53,14 +53,14 @@ void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
 }
 
 int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
-                                           bool start)
+                                           bool start, Error **errp)
 {
     if (!bcontainer->dirty_pages_supported) {
         return 0;
     }
 
     g_assert(bcontainer->ops->set_dirty_page_tracking);
-    return bcontainer->ops->set_dirty_page_tracking(bcontainer, start);
+    return bcontainer->ops->set_dirty_page_tracking(bcontainer, start, errp);
 }
 
 int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index bd25b9fbad2e717e63c2ab0e331186e5f63cef49..f772ac79b9c413c86d7e60f6dc4e6699852d5aac 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -210,7 +210,7 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
 
 static int
 vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
-                                    bool start)
+                                    bool start, Error **errp)
 {
     const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                                   bcontainer);
@@ -228,8 +228,8 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
     ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, &dirty);
     if (ret) {
         ret = -errno;
-        error_report("Failed to set dirty tracking flag 0x%x errno: %d",
-                     dirty.flags, errno);
+        error_setg(errp, "Failed to set dirty tracking flag 0x%x errno: %d",
+                   dirty.flags, errno);
     }
 
     return ret;
-- 
2.43.0


