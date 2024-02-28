Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC5CC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 05:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfCJ2-00019s-UC; Wed, 28 Feb 2024 00:16:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCIC-0000Yr-M5
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:15:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCI8-0006vK-FH
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:15:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709097339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=15Vi8iKrrKtjdGksBgiWczidIHqvhphywpKv1t8TsM8=;
 b=Lndc/gvNbTW4ogcQPs9uCwPpoLAX//+95FkFeZz+uyuHOBP9vK/syW7SbHkvvODg+eOEc/
 sRvjNjLNFOA4MwhuGevTMoRkrWgJV0sACDzGYCDxDqk+Oh9kwBNawZCemD534x9U64fCFQ
 jS4nRPRAocuCEztaaxMvgB3iwdjqKg0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-mZAMKIV_PhG-6YuJtdol_w-1; Wed,
 28 Feb 2024 00:15:37 -0500
X-MC-Unique: mZAMKIV_PhG-6YuJtdol_w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D4693C11CC5;
 Wed, 28 Feb 2024 05:15:37 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1EB9B1C06710;
 Wed, 28 Feb 2024 05:15:27 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 14/25] migration: MigrationEvent for notifiers
Date: Wed, 28 Feb 2024 13:13:04 +0800
Message-ID: <20240228051315.400759-15-peterx@redhat.com>
In-Reply-To: <20240228051315.400759-1-peterx@redhat.com>
References: <20240228051315.400759-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Passing MigrationState to notifiers is unsound because they could access
unstable migration state internals or even modify the state.  Instead, pass
the minimal info needed in a new MigrationEvent struct, which could be
extended in the future if needed.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/1708622920-68779-5-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 23 ++++++++++++++++++++++-
 hw/net/virtio-net.c      | 11 ++++++-----
 hw/vfio/migration.c      | 10 +++-------
 migration/migration.c    | 17 ++++++++++++-----
 net/vhost-vdpa.c         |  6 +++---
 ui/spice-core.c          |  9 ++++-----
 hw/vfio/trace-events     |  2 +-
 7 files changed, 51 insertions(+), 27 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index b62e351d96..9e4abae97f 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -60,10 +60,31 @@ void migration_object_init(void);
 void migration_shutdown(void);
 bool migration_is_idle(void);
 bool migration_is_active(MigrationState *);
+
+typedef enum MigrationEventType {
+    MIG_EVENT_PRECOPY_SETUP,
+    MIG_EVENT_PRECOPY_DONE,
+    MIG_EVENT_PRECOPY_FAILED,
+    MIG_EVENT_MAX
+} MigrationEventType;
+
+typedef struct MigrationEvent {
+    MigrationEventType type;
+} MigrationEvent;
+
+/*
+ * Register the notifier @notify to be called when a migration event occurs
+ * for MIG_MODE_NORMAL, as specified by the MigrationEvent passed to @func.
+ * Notifiers may receive events in any of the following orders:
+ *    - MIG_EVENT_PRECOPY_SETUP -> MIG_EVENT_PRECOPY_DONE
+ *    - MIG_EVENT_PRECOPY_SETUP -> MIG_EVENT_PRECOPY_FAILED
+ *    - MIG_EVENT_PRECOPY_FAILED
+ */
 void migration_add_notifier(NotifierWithReturn *notify,
                             NotifierWithReturnFunc func);
+
 void migration_remove_notifier(NotifierWithReturn *notify);
-void migration_call_notifiers(MigrationState *s);
+void migration_call_notifiers(MigrationState *s, MigrationEventType type);
 bool migration_in_setup(MigrationState *);
 bool migration_has_finished(MigrationState *);
 bool migration_has_failed(MigrationState *);
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 75f4e8664d..e803f98c3a 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3504,7 +3504,7 @@ out:
     return !err;
 }
 
-static void virtio_net_handle_migration_primary(VirtIONet *n, MigrationState *s)
+static void virtio_net_handle_migration_primary(VirtIONet *n, MigrationEvent *e)
 {
     bool should_be_hidden;
     Error *err = NULL;
@@ -3516,7 +3516,7 @@ static void virtio_net_handle_migration_primary(VirtIONet *n, MigrationState *s)
 
     should_be_hidden = qatomic_read(&n->failover_primary_hidden);
 
-    if (migration_in_setup(s) && !should_be_hidden) {
+    if (e->type == MIG_EVENT_PRECOPY_SETUP && !should_be_hidden) {
         if (failover_unplug_primary(n, dev)) {
             vmstate_unregister(VMSTATE_IF(dev), qdev_get_vmsd(dev), dev);
             qapi_event_send_unplug_primary(dev->id);
@@ -3524,7 +3524,7 @@ static void virtio_net_handle_migration_primary(VirtIONet *n, MigrationState *s)
         } else {
             warn_report("couldn't unplug primary device");
         }
-    } else if (migration_has_failed(s)) {
+    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
         /* We already unplugged the device let's plug it back */
         if (!failover_replug_primary(n, dev, &err)) {
             if (err) {
@@ -3537,9 +3537,10 @@ static void virtio_net_handle_migration_primary(VirtIONet *n, MigrationState *s)
 static int virtio_net_migration_state_notifier(NotifierWithReturn *notifier,
                                                void *data, Error **errp)
 {
-    MigrationState *s = data;
+    MigrationEvent *e = data;
+
     VirtIONet *n = container_of(notifier, VirtIONet, migration_state);
-    virtio_net_handle_migration_primary(n, s);
+    virtio_net_handle_migration_primary(n, e);
     return 0;
 }
 
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 6b6acc4140..869d8417d6 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -757,18 +757,14 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
 static int vfio_migration_state_notifier(NotifierWithReturn *notifier,
                                          void *data, Error **errp)
 {
-    MigrationState *s = data;
+    MigrationEvent *e = data;
     VFIOMigration *migration = container_of(notifier, VFIOMigration,
                                             migration_state);
     VFIODevice *vbasedev = migration->vbasedev;
 
-    trace_vfio_migration_state_notifier(vbasedev->name,
-                                        MigrationStatus_str(s->state));
+    trace_vfio_migration_state_notifier(vbasedev->name, e->type);
 
-    switch (s->state) {
-    case MIGRATION_STATUS_CANCELLING:
-    case MIGRATION_STATUS_CANCELLED:
-    case MIGRATION_STATUS_FAILED:
+    if (e->type == MIG_EVENT_PRECOPY_FAILED) {
         vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_RUNNING);
     }
     return 0;
diff --git a/migration/migration.c b/migration/migration.c
index 6d4072e8e9..4650c21f67 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1319,6 +1319,8 @@ void migrate_set_state(int *state, int old_state, int new_state)
 
 static void migrate_fd_cleanup(MigrationState *s)
 {
+    MigrationEventType type;
+
     g_free(s->hostname);
     s->hostname = NULL;
     json_writer_free(s->vmdesc);
@@ -1367,7 +1369,9 @@ static void migrate_fd_cleanup(MigrationState *s)
         /* It is used on info migrate.  We can't free it */
         error_report_err(error_copy(s->error));
     }
-    migration_call_notifiers(s);
+    type = migration_has_failed(s) ? MIG_EVENT_PRECOPY_FAILED :
+                                     MIG_EVENT_PRECOPY_DONE;
+    migration_call_notifiers(s, type);
     block_cleanup_parameters();
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }
@@ -1474,9 +1478,12 @@ void migration_remove_notifier(NotifierWithReturn *notify)
     }
 }
 
-void migration_call_notifiers(MigrationState *s)
+void migration_call_notifiers(MigrationState *s, MigrationEventType type)
 {
-    notifier_with_return_list_notify(&migration_state_notifiers, s, 0);
+    MigrationEvent e;
+
+    e.type = type;
+    notifier_with_return_list_notify(&migration_state_notifiers, &e, 0);
 }
 
 bool migration_in_setup(MigrationState *s)
@@ -2537,7 +2544,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      * spice needs to trigger a transition now
      */
     ms->postcopy_after_devices = true;
-    migration_call_notifiers(ms);
+    migration_call_notifiers(ms, MIG_EVENT_PRECOPY_DONE);
 
     migration_downtime_end(ms);
 
@@ -3601,7 +3608,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         rate_limit = migrate_max_bandwidth();
 
         /* Notify before starting migration thread */
-        migration_call_notifiers(s);
+        migration_call_notifiers(s, MIG_EVENT_PRECOPY_SETUP);
     }
 
     migration_rate_set(rate_limit);
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 1c00519f10..a29d18a9ef 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -325,13 +325,13 @@ static void vhost_vdpa_net_log_global_enable(VhostVDPAState *s, bool enable)
 static int vdpa_net_migration_state_notifier(NotifierWithReturn *notifier,
                                              void *data, Error **errp)
 {
-    MigrationState *migration = data;
+    MigrationEvent *e = data;
     VhostVDPAState *s = container_of(notifier, VhostVDPAState,
                                      migration_state);
 
-    if (migration_in_setup(migration)) {
+    if (e->type == MIG_EVENT_PRECOPY_SETUP) {
         vhost_vdpa_net_log_global_enable(s, true);
-    } else if (migration_has_failed(migration)) {
+    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
         vhost_vdpa_net_log_global_enable(s, false);
     }
     return 0;
diff --git a/ui/spice-core.c b/ui/spice-core.c
index b3cd229023..0a59876da2 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -571,19 +571,18 @@ static SpiceInfo *qmp_query_spice_real(Error **errp)
 static int migration_state_notifier(NotifierWithReturn *notifier,
                                     void *data, Error **errp)
 {
-    MigrationState *s = data;
+    MigrationEvent *e = data;
 
     if (!spice_have_target_host) {
         return 0;
     }
 
-    if (migration_in_setup(s)) {
+    if (e->type == MIG_EVENT_PRECOPY_SETUP) {
         spice_server_migrate_start(spice_server);
-    } else if (migration_has_finished(s) ||
-               migration_in_postcopy_after_devices(s)) {
+    } else if (e->type == MIG_EVENT_PRECOPY_DONE) {
         spice_server_migrate_end(spice_server, true);
         spice_have_target_host = false;
-    } else if (migration_has_failed(s)) {
+    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
         spice_server_migrate_end(spice_server, false);
         spice_have_target_host = false;
     }
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 8fdde54456..f0474b244b 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -153,7 +153,7 @@ vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
 vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size 0x%"PRIx64" ret %d"
 vfio_migration_realize(const char *name) " (%s)"
 vfio_migration_set_state(const char *name, const char *state) " (%s) state %s"
-vfio_migration_state_notifier(const char *name, const char *state) " (%s) state %s"
+vfio_migration_state_notifier(const char *name, int state) " (%s) state %d"
 vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
 vfio_save_cleanup(const char *name) " (%s)"
 vfio_save_complete_precopy(const char *name, int ret) " (%s) ret %d"
-- 
2.43.0


