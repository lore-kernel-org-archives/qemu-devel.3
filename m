Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B54C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 13:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXi4C-0006j0-7C; Wed, 07 Feb 2024 08:34:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org>)
 id 1rXi49-0006hC-Nk
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:34:17 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org>)
 id 1rXi47-0008QI-OM
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:34:17 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TVLgT5H73z4x0t;
 Thu,  8 Feb 2024 00:34:13 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TVLgR6pGtz4x0m;
 Thu,  8 Feb 2024 00:34:11 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 07/14] vfio: Add Error** argument to
 vfio_devices_dma_logging_stop()
Date: Wed,  7 Feb 2024 14:33:40 +0100
Message-ID: <20240207133347.1115903-8-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207133347.1115903-1-clg@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This improves error reporting in the log_global_stop() VFIO handler.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index a5d53e67efaa921e89ad918390a22506c7b1ed66..82173b039c47150f5edd05d329192c5b9c8a9a0f 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -938,12 +938,14 @@ static void vfio_dirty_tracking_init(VFIOContainerBase *bcontainer,
     memory_listener_unregister(&dirty.listener);
 }
 
-static void vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
+static int vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer,
+                                          Error **errp)
 {
     uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
                               sizeof(uint64_t))] = {};
     struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
     VFIODevice *vbasedev;
+    int ret = 0;
 
     feature->argsz = sizeof(buf);
     feature->flags = VFIO_DEVICE_FEATURE_SET |
@@ -955,11 +957,17 @@ static void vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
         }
 
         if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
-            warn_report("%s: Failed to stop DMA logging, err %d (%s)",
-                        vbasedev->name, -errno, strerror(errno));
+            /* Keep first error */
+            if (!ret) {
+                ret = -errno;
+                error_setg(errp, "%s: Failed to stop DMA logging, err %d (%s)",
+                           vbasedev->name, -errno, strerror(errno));
+            }
         }
         vbasedev->dirty_tracking = false;
     }
+
+    return ret;
 }
 
 static struct vfio_device_feature *
@@ -1068,7 +1076,8 @@ static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
 
 out:
     if (ret) {
-        vfio_devices_dma_logging_stop(bcontainer);
+        /* Ignore the potential errors when doing rollback */
+        vfio_devices_dma_logging_stop(bcontainer, NULL);
     }
 
     vfio_device_feature_dma_logging_start_destroy(feature);
@@ -1102,7 +1111,7 @@ static void vfio_listener_log_global_stop(MemoryListener *listener,
     int ret = 0;
 
     if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
-        vfio_devices_dma_logging_stop(bcontainer);
+        ret = vfio_devices_dma_logging_stop(bcontainer, errp);
     } else {
         ret = vfio_container_set_dirty_page_tracking(bcontainer, false, errp);
     }
-- 
2.43.0


