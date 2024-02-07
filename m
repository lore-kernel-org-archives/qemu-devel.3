Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4E7C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 13:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXi4D-0006lN-Um; Wed, 07 Feb 2024 08:34:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org>)
 id 1rXi4C-0006j9-AB
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:34:20 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org>)
 id 1rXi4A-0008Qq-1p
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:34:20 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TVLgX0DQRz4x0r;
 Thu,  8 Feb 2024 00:34:16 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TVLgV1nDjz4x0m;
 Thu,  8 Feb 2024 00:34:13 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 08/14] vfio: Use new Error** argument in vfio_save_setup()
Date: Wed,  7 Feb 2024 14:33:41 +0100
Message-ID: <20240207133347.1115903-9-clg@redhat.com>
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

Add an Error** argument to vfio_migration_set_state() and adjust
callers, including vfio_save_setup(). The error will be propagated up
to qemu_savevm_state_setup() where the save_setup() handler is
executed.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/migration.c | 62 +++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 2dfbe671f6f45aa530c7341177bb532d8292cecd..2e0a79967cc97f44d9be5575c3cfe18c9f349dab 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -84,7 +84,8 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
 
 static int vfio_migration_set_state(VFIODevice *vbasedev,
                                     enum vfio_device_mig_state new_state,
-                                    enum vfio_device_mig_state recover_state)
+                                    enum vfio_device_mig_state recover_state,
+                                    Error **errp)
 {
     VFIOMigration *migration = vbasedev->migration;
     uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
@@ -104,15 +105,15 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
         ret = -errno;
 
         if (recover_state == VFIO_DEVICE_STATE_ERROR) {
-            error_report("%s: Failed setting device state to %s, err: %s. "
-                         "Recover state is ERROR. Resetting device",
-                         vbasedev->name, mig_state_to_str(new_state),
-                         strerror(errno));
+            error_setg(errp, "%s: Failed setting device state to %s, err: %s. "
+                       "Recover state is ERROR. Resetting device",
+                       vbasedev->name, mig_state_to_str(new_state),
+                       strerror(errno));
 
             goto reset_device;
         }
 
-        error_report(
+        error_setg(errp,
             "%s: Failed setting device state to %s, err: %s. Setting device in recover state %s",
                      vbasedev->name, mig_state_to_str(new_state),
                      strerror(errno), mig_state_to_str(recover_state));
@@ -120,7 +121,7 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
         mig_state->device_state = recover_state;
         if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
             ret = -errno;
-            error_report(
+            error_setg(errp,
                 "%s: Failed setting device in recover state, err: %s. Resetting device",
                          vbasedev->name, strerror(errno));
 
@@ -139,7 +140,7 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
              * This can happen if the device is asynchronously reset and
              * terminates a data transfer.
              */
-            error_report("%s: data_fd out of sync", vbasedev->name);
+            error_setg(errp, "%s: data_fd out of sync", vbasedev->name);
             close(mig_state->data_fd);
 
             return -EBADF;
@@ -170,10 +171,11 @@ reset_device:
  */
 static int
 vfio_migration_set_state_or_reset(VFIODevice *vbasedev,
-                                  enum vfio_device_mig_state new_state)
+                                  enum vfio_device_mig_state new_state,
+                                  Error **errp)
 {
     return vfio_migration_set_state(vbasedev, new_state,
-                                    VFIO_DEVICE_STATE_ERROR);
+                                    VFIO_DEVICE_STATE_ERROR, errp);
 }
 
 static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
@@ -391,8 +393,8 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
                                       stop_copy_size);
     migration->data_buffer = g_try_malloc0(migration->data_buffer_size);
     if (!migration->data_buffer) {
-        error_report("%s: Failed to allocate migration data buffer",
-                     vbasedev->name);
+        error_setg(errp, "%s: Failed to allocate migration data buffer",
+                   vbasedev->name);
         return -ENOMEM;
     }
 
@@ -402,7 +404,7 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
         switch (migration->device_state) {
         case VFIO_DEVICE_STATE_RUNNING:
             ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_PRE_COPY,
-                                           VFIO_DEVICE_STATE_RUNNING);
+                                           VFIO_DEVICE_STATE_RUNNING, errp);
             if (ret) {
                 return ret;
             }
@@ -429,13 +431,18 @@ static void vfio_save_cleanup(void *opaque)
 {
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
+    Error *local_err = NULL;
 
     /*
      * Changing device state from STOP_COPY to STOP can take time. Do it here,
      * after migration has completed, so it won't increase downtime.
      */
     if (migration->device_state == VFIO_DEVICE_STATE_STOP_COPY) {
-        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_STOP);
+        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_STOP,
+                                          &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+        }
     }
 
     g_free(migration->data_buffer);
@@ -541,11 +548,13 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
     VFIODevice *vbasedev = opaque;
     ssize_t data_size;
     int ret;
+    Error *local_err = NULL;
 
     /* We reach here with device state STOP or STOP_COPY only */
     ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
-                                   VFIO_DEVICE_STATE_STOP);
-    if (ret) {
+                                   VFIO_DEVICE_STATE_STOP, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
         return ret;
     }
 
@@ -585,7 +594,7 @@ static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
     VFIODevice *vbasedev = opaque;
 
     return vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
-                                   vbasedev->migration->device_state);
+                                    vbasedev->migration->device_state, errp);
 }
 
 static int vfio_load_cleanup(void *opaque)
@@ -701,20 +710,22 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
     enum vfio_device_mig_state new_state;
+    Error *local_err = NULL;
     int ret;
 
     new_state = migration->device_state == VFIO_DEVICE_STATE_PRE_COPY ?
                     VFIO_DEVICE_STATE_PRE_COPY_P2P :
                     VFIO_DEVICE_STATE_RUNNING_P2P;
 
-    ret = vfio_migration_set_state_or_reset(vbasedev, new_state);
+    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
     if (ret) {
         /*
          * Migration should be aborted in this case, but vm_state_notify()
          * currently does not support reporting failures.
          */
         if (migrate_get_current()->to_dst_file) {
-            qemu_file_set_error(migrate_get_current()->to_dst_file, ret);
+            qemu_file_set_error_obj(migrate_get_current()->to_dst_file, ret,
+                                    local_err);
         }
     }
 
@@ -727,6 +738,7 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
 {
     VFIODevice *vbasedev = opaque;
     enum vfio_device_mig_state new_state;
+    Error *local_err = NULL;
     int ret;
 
     if (running) {
@@ -739,14 +751,15 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
                 VFIO_DEVICE_STATE_STOP;
     }
 
-    ret = vfio_migration_set_state_or_reset(vbasedev, new_state);
+    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
     if (ret) {
         /*
          * Migration should be aborted in this case, but vm_state_notify()
          * currently does not support reporting failures.
          */
         if (migrate_get_current()->to_dst_file) {
-            qemu_file_set_error(migrate_get_current()->to_dst_file, ret);
+            qemu_file_set_error_obj(migrate_get_current()->to_dst_file, ret,
+                                    local_err);
         }
     }
 
@@ -760,6 +773,7 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
     VFIOMigration *migration = container_of(notifier, VFIOMigration,
                                             migration_state);
     VFIODevice *vbasedev = migration->vbasedev;
+    Error *local_err = NULL;
 
     trace_vfio_migration_state_notifier(vbasedev->name,
                                         MigrationStatus_str(s->state));
@@ -768,7 +782,11 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
     case MIGRATION_STATUS_CANCELLING:
     case MIGRATION_STATUS_CANCELLED:
     case MIGRATION_STATUS_FAILED:
-        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_RUNNING);
+        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_RUNNING,
+                                          &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+        }
     }
 }
 
-- 
2.43.0


