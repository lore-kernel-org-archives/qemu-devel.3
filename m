Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D987BC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 13:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhrRS-0001CM-Ka; Wed, 06 Mar 2024 08:36:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrRI-00016R-Ls
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:36:11 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrRG-0006Bz-1p
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:36:08 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TqYNh09tfz4x0r;
 Thu,  7 Mar 2024 00:36:04 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqYNc5xwcz4wcF;
 Thu,  7 Mar 2024 00:36:00 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 17/25] vfio: Add Error** argument to
 vfio_devices_dma_logging_start()
Date: Wed,  6 Mar 2024 14:34:32 +0100
Message-ID: <20240306133441.2351700-18-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306133441.2351700-1-clg@redhat.com>
References: <20240306133441.2351700-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

This allows to update the Error argument of the VFIO log_global_start()
handler. Errors detected when device level logging is started will be
propagated up to qemu_savevm_state_setup() when the ram save_setup()
handler is executed.

The vfio_set_migration_error() call becomes redundant. Remove it.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 Changes in v4:

 - Dropped log_global_stop() and log_global_sync() changes
   
 Changes in v3:

 - Use error_setg_errno() in vfio_devices_dma_logging_start() 
 - ERRP_GUARD() because of error_prepend use in
   vfio_listener_log_global_start()
   
 hw/vfio/common.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 5598a508399a6c0b3a20ba17311cbe83d84250c5..d6790557da2f2890398fa03dbbef18129cd2c1bb 100644
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
+            error_setg_errno(errp, errno, "%s: Failed to start DMA logging",
+                             vbasedev->name);
             goto out;
         }
         vbasedev->dirty_tracking = true;
@@ -1078,20 +1079,19 @@ out:
 static bool vfio_listener_log_global_start(MemoryListener *listener,
                                            Error **errp)
 {
+    ERRP_GUARD(); /* error_prepend use */
     VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
                                                  listener);
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
     return !ret;
 }
@@ -1100,17 +1100,20 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
 {
     VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
                                                  listener);
+    Error *local_err = NULL;
     int ret = 0;
 
     if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
         vfio_devices_dma_logging_stop(bcontainer);
     } else {
-        ret = vfio_container_set_dirty_page_tracking(bcontainer, false, NULL);
+        ret = vfio_container_set_dirty_page_tracking(bcontainer, false,
+                                                     &local_err);
     }
 
     if (ret) {
-        error_report("vfio: Could not stop dirty page tracking, err: %d (%s)",
-                     ret, strerror(-ret));
+        error_prepend(&local_err,
+                      "vfio: Could not stop dirty page tracking - ");
+        error_report_err(local_err);
         vfio_set_migration_error(ret);
     }
 }
-- 
2.44.0


