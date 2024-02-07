Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A46EC4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 13:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXi4B-0006in-Qf; Wed, 07 Feb 2024 08:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org>)
 id 1rXi48-0006gm-JE
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:34:17 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org>)
 id 1rXi46-0008Pj-NM
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:34:16 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TVLgR3C6dz4x0q;
 Thu,  8 Feb 2024 00:34:11 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TVLgP4jzXz4x0m;
 Thu,  8 Feb 2024 00:34:09 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 06/14] vfio: Add Error** argument to
 vfio_devices_dma_logging_start()
Date: Wed,  7 Feb 2024 14:33:39 +0100
Message-ID: <20240207133347.1115903-7-clg@redhat.com>
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

This allows to update the Error argument of the VFIO log_global_start()
handler. Errors detected when device level logging is started will be
propagated up to qemu_savevm_state_setup() when the ram save_setup()
handler is executed.

The vfio_set_migration_error() call becomes redudant. Remove it.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 03f2059d903eca335b02f633b07cd35ef3dd6237..a5d53e67efaa921e89ad918390a22506c7b1ed66 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1036,7 +1036,8 @@ static void vfio_device_feature_dma_logging_start_destroy(
     g_free(feature);
 }
 
-static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer)
+static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
+                                          Error **errp)
 {
     struct vfio_device_feature *feature;
     VFIODirtyRanges ranges;
@@ -1058,8 +1059,8 @@ static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer)
         ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
         if (ret) {
             ret = -errno;
-            error_report("%s: Failed to start DMA logging, err %d (%s)",
-                         vbasedev->name, ret, strerror(errno));
+            error_setg(errp, "%s: Failed to start DMA logging, err %d (%s)",
+                       vbasedev->name, ret, strerror(errno));
             goto out;
         }
         vbasedev->dirty_tracking = true;
@@ -1083,15 +1084,13 @@ static void vfio_listener_log_global_start(MemoryListener *listener,
     int ret;
 
     if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
-        ret = vfio_devices_dma_logging_start(bcontainer);
+        ret = vfio_devices_dma_logging_start(bcontainer, errp);
     } else {
-        ret = vfio_container_set_dirty_page_tracking(bcontainer, true, NULL);
+        ret = vfio_container_set_dirty_page_tracking(bcontainer, true, errp);
     }
 
     if (ret) {
-        error_report("vfio: Could not start dirty page tracking, err: %d (%s)",
-                     ret, strerror(-ret));
-        vfio_set_migration_error(ret);
+        error_prepend(errp, "vfio: Could not start dirty page tracking - ");
     }
 }
 
@@ -1105,13 +1104,11 @@ static void vfio_listener_log_global_stop(MemoryListener *listener,
     if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
         vfio_devices_dma_logging_stop(bcontainer);
     } else {
-        ret = vfio_container_set_dirty_page_tracking(bcontainer, false, NULL);
+        ret = vfio_container_set_dirty_page_tracking(bcontainer, false, errp);
     }
 
     if (ret) {
-        error_report("vfio: Could not stop dirty page tracking, err: %d (%s)",
-                     ret, strerror(-ret));
-        vfio_set_migration_error(ret);
+        error_prepend(errp, "vfio: Could not stop dirty page tracking - ");
     }
 }
 
-- 
2.43.0


