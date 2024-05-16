Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9679BC25B77
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 12:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7aWJ-00032m-KS; Thu, 16 May 2024 08:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7aW2-0002ua-VX
 for qemu-devel@nongnu.org; Thu, 16 May 2024 08:47:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7aW0-0001BP-8C
 for qemu-devel@nongnu.org; Thu, 16 May 2024 08:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715863639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ON6C8iAf1dBhotyCm8clsf4ZXeBcVxIKd4Ymb+tRWjQ=;
 b=dfTER2m4M3jaApRdau3mOwAxrNoDlpl7maLilmG+myIvdr4aTCLY+DV2PV8EZLDZwk5Em7
 FcVypDwgJjZyfP66I1vV3B+sRYZwLrj/wP4dblBKsj6Pmihqe92mkubBsl3PCbI1UK4dEv
 Us0FERUo3u8vCB4Q5riuij/20AMC9DQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-WZ1NbTV8Nh21oX0a3UDkgg-1; Thu, 16 May 2024 08:47:18 -0400
X-MC-Unique: WZ1NbTV8Nh21oX0a3UDkgg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC20C85A58C;
 Thu, 16 May 2024 12:47:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85681200B3A1;
 Thu, 16 May 2024 12:47:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v7 4/9] vfio/migration: Add an Error** argument to
 vfio_migration_set_state()
Date: Thu, 16 May 2024 14:46:53 +0200
Message-ID: <20240516124658.850504-5-clg@redhat.com>
In-Reply-To: <20240516124658.850504-1-clg@redhat.com>
References: <20240516124658.850504-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add an Error** argument to vfio_migration_set_state() and adjust
callers, including vfio_save_setup(). The error will be propagated up
to qemu_savevm_state_setup() where the save_setup() handler is
executed.

Modify vfio_vmstate_change_prepare() and vfio_vmstate_change() to
store a reported error under the migration stream if a migration is in
progress.

Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 Changes in v7:

 - vfio_migration_set_state() :
   Introduced an error prefix to remove redundancy in error messages (Eric)
   Commented error_report when setting the device in recover state fails (Eric)
 - vfio_migration_state_notifier() :
   Remove useless assignment of local ret variable (Avihai) 
   Rephrased comment regarding MigrationNotifyFunc API (Avihai)
   
 hw/vfio/migration.c | 81 +++++++++++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 29 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index bf2fd0759ba6e4fb103cc5c1a43edb180a3d0de4..43fed0dbdbe3415ae2dd68fbe45b302b85a80fa4 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -82,7 +82,8 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
 
 static int vfio_migration_set_state(VFIODevice *vbasedev,
                                     enum vfio_device_mig_state new_state,
-                                    enum vfio_device_mig_state recover_state)
+                                    enum vfio_device_mig_state recover_state,
+                                    Error **errp)
 {
     VFIOMigration *migration = vbasedev->migration;
     uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
@@ -92,6 +93,9 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
     struct vfio_device_feature_mig_state *mig_state =
         (struct vfio_device_feature_mig_state *)feature->data;
     int ret;
+    g_autofree char *error_prefix =
+        g_strdup_printf("%s: Failed setting device state to %s.",
+                        vbasedev->name, mig_state_to_str(new_state));
 
     feature->argsz = sizeof(buf);
     feature->flags =
@@ -102,22 +106,24 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
         ret = -errno;
 
         if (recover_state == VFIO_DEVICE_STATE_ERROR) {
-            error_report("%s: Failed setting device state to %s, err: %s. "
-                         "Recover state is ERROR. Resetting device",
-                         vbasedev->name, mig_state_to_str(new_state),
-                         strerror(errno));
+            error_setg_errno(errp, errno,
+                             "%s Recover state is ERROR. Resetting device",
+                             error_prefix);
 
             goto reset_device;
         }
 
-        error_report(
-            "%s: Failed setting device state to %s, err: %s. Setting device in recover state %s",
-                     vbasedev->name, mig_state_to_str(new_state),
-                     strerror(errno), mig_state_to_str(recover_state));
+        error_setg_errno(errp, errno,
+                         "%s Setting device in recover state %s",
+                         error_prefix, mig_state_to_str(recover_state));
 
         mig_state->device_state = recover_state;
         if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
             ret = -errno;
+            /*
+             * If setting the device in recover state fails, report
+             * the error here and propagate the first error.
+             */
             error_report(
                 "%s: Failed setting device in recover state, err: %s. Resetting device",
                          vbasedev->name, strerror(errno));
@@ -137,7 +143,7 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
              * This can happen if the device is asynchronously reset and
              * terminates a data transfer.
              */
-            error_report("%s: data_fd out of sync", vbasedev->name);
+            error_setg(errp, "%s: data_fd out of sync", vbasedev->name);
             close(mig_state->data_fd);
 
             return -EBADF;
@@ -168,10 +174,11 @@ reset_device:
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
@@ -399,10 +406,8 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
         switch (migration->device_state) {
         case VFIO_DEVICE_STATE_RUNNING:
             ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_PRE_COPY,
-                                           VFIO_DEVICE_STATE_RUNNING);
+                                           VFIO_DEVICE_STATE_RUNNING, errp);
             if (ret) {
-                error_setg(errp, "%s: Failed to set new PRE_COPY state",
-                           vbasedev->name);
                 return ret;
             }
 
@@ -435,13 +440,20 @@ static void vfio_save_cleanup(void *opaque)
 {
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
+    Error *local_err = NULL;
+    int ret;
 
     /*
      * Changing device state from STOP_COPY to STOP can take time. Do it here,
      * after migration has completed, so it won't increase downtime.
      */
     if (migration->device_state == VFIO_DEVICE_STATE_STOP_COPY) {
-        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_STOP);
+        ret = vfio_migration_set_state_or_reset(vbasedev,
+                                                VFIO_DEVICE_STATE_STOP,
+                                                &local_err);
+        if (ret) {
+            error_report_err(local_err);
+        }
     }
 
     g_free(migration->data_buffer);
@@ -549,11 +561,13 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
     VFIODevice *vbasedev = opaque;
     ssize_t data_size;
     int ret;
+    Error *local_err = NULL;
 
     /* We reach here with device state STOP or STOP_COPY only */
     ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
-                                   VFIO_DEVICE_STATE_STOP);
+                                   VFIO_DEVICE_STATE_STOP, &local_err);
     if (ret) {
+        error_report_err(local_err);
         return ret;
     }
 
@@ -591,14 +605,9 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
 static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     VFIODevice *vbasedev = opaque;
-    int ret;
 
-    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
-                                   vbasedev->migration->device_state);
-    if (ret) {
-        error_setg(errp, "%s: Failed to set RESUMING state", vbasedev->name);
-    }
-    return ret;
+    return vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
+                                    vbasedev->migration->device_state, errp);
 }
 
 static int vfio_load_cleanup(void *opaque)
@@ -714,19 +723,20 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
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
-        migration_file_set_error(ret, NULL);
+        migration_file_set_error(ret, local_err);
     }
 
     trace_vfio_vmstate_change_prepare(vbasedev->name, running,
@@ -738,6 +748,7 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
 {
     VFIODevice *vbasedev = opaque;
     enum vfio_device_mig_state new_state;
+    Error *local_err = NULL;
     int ret;
 
     if (running) {
@@ -750,13 +761,13 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
                 VFIO_DEVICE_STATE_STOP;
     }
 
-    ret = vfio_migration_set_state_or_reset(vbasedev, new_state);
+    ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
     if (ret) {
         /*
          * Migration should be aborted in this case, but vm_state_notify()
          * currently does not support reporting failures.
          */
-        migration_file_set_error(ret, NULL);
+        migration_file_set_error(ret, local_err);
     }
 
     trace_vfio_vmstate_change(vbasedev->name, running, RunState_str(state),
@@ -769,11 +780,23 @@ static int vfio_migration_state_notifier(NotifierWithReturn *notifier,
     VFIOMigration *migration = container_of(notifier, VFIOMigration,
                                             migration_state);
     VFIODevice *vbasedev = migration->vbasedev;
+    Error *local_err = NULL;
+    int ret;
 
     trace_vfio_migration_state_notifier(vbasedev->name, e->type);
 
     if (e->type == MIG_EVENT_PRECOPY_FAILED) {
-        vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_RUNNING);
+        /*
+         * MigrationNotifyFunc may not return an error code and an Error
+         * object for MIG_EVENT_PRECOPY_FAILED. Hence, report the error
+         * locally and ignore the errp argument.
+         */
+        ret = vfio_migration_set_state_or_reset(vbasedev,
+                                                VFIO_DEVICE_STATE_RUNNING,
+                                                &local_err);
+        if (ret) {
+            error_report_err(local_err);
+        }
     }
     return 0;
 }
-- 
2.45.0


