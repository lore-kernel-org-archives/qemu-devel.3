Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DD7CD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 14:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPi7j-0002rg-SH; Wed, 20 May 2026 10:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wPi7c-0002rC-66
 for qemu-devel@nongnu.org; Wed, 20 May 2026 10:42:08 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wPi7Z-0002Gn-Tp
 for qemu-devel@nongnu.org; Wed, 20 May 2026 10:42:07 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wPi7P-00000001uqk-361g; Wed, 20 May 2026 16:41:55 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 2/2] vfio/migration: Parallelize device state transitions
Date: Wed, 20 May 2026 16:41:38 +0200
Message-ID: <743f03758d2a30df4093db140ccdd0f91f69bd7e.1779217494.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779217494.git.maciej.szmigiero@oracle.com>
References: <cover.1779217494.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

When multiple VFIO devices are present in a VM the fact that their state
transitions on migration happen sequentially has a visible impact on
migration downtime.

This is because both PRE_COPY -> PRE_COPY_P2P -> STOP_COPY transitions on
the source and RESUMING -> RUNNING_P2P -> RUNNING transitions on the target
happen during the switchover phase.
During this phase the VM is stopped so the downtime is ticking.

These device state transitions are performed by VM state change handlers
registered by the VFIO device migration code.

Instead of performing such state transition synchronously use the priority
adjustment mechanism from the previous patch to launch a thread performing
the state change at the priority level *before* all other VM state change
handlers at the particular VFIO device qdev tree depth.
Only wait for this thread to finish at the priority level ordered *after*
all other handlers at this tree depth.

This way these state transitions can happen in parallel not only with
respect to other VFIO device instances but also ordinary (serialized)
handlers for other devices at this qdev tree depth while still being
properly ordered with respect to handlers registered at other tree depths.

Unfortunately, the order in which VM state handlers are called depends
on whether the VM is starting or stopping.
Because of this, one extra layer of indirection is necessary to make the
(first, second) ordering of these handlers constant.

Enable the feature by default since it has no impact on the migration bit
stream protocol - it shouldn't need disabling for anything else but
debugging scenarios.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/vfio/migration.c               | 174 ++++++++++++++++++++++++++++--
 hw/vfio/pci.c                     |   2 +
 hw/vfio/vfio-migration-internal.h |   4 +-
 include/hw/vfio/vfio-device.h     |   1 +
 4 files changed, 173 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 9889b20ad7dd..fd2b37a85f4b 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1047,6 +1047,135 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
                               mig_state_to_str(new_state));
 }
 
+typedef struct VMStateChangeThreadData {
+    VFIODevice *vbasedev;
+    bool is_prepare;
+    bool running;
+    RunState state;
+} VMStateChangeThreadData;
+
+static void *vfio_vmstate_change_thread(void *opaque)
+{
+    g_autofree VMStateChangeThreadData *data = opaque;
+
+    if (data->is_prepare) {
+        vfio_vmstate_change_prepare(data->vbasedev, data->running, data->state);
+    } else {
+        vfio_vmstate_change(data->vbasedev, data->running, data->state);
+    }
+
+    return NULL;
+}
+
+static void vfio_vmstate_change_thread_launch(VFIODevice *vbasedev,
+                                              bool is_prepare,
+                                              bool running,
+                                              RunState state)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    VMStateChangeThreadData *data = g_new(VMStateChangeThreadData, 1);
+
+    data->vbasedev = vbasedev;
+    data->is_prepare = is_prepare;
+    data->running = running;
+    data->state = state;
+
+    assert(!migration->vm_state_thread_running);
+    migration->vm_state_thread_running = true;
+
+    qemu_thread_create(&migration->vm_state_thread,
+                       is_prepare ? "vfio_vmstate_change_prepare" :
+                       "vfio_vmstate_change",
+                       vfio_vmstate_change_thread, data,
+                       QEMU_THREAD_JOINABLE);
+}
+
+static void vfio_vmstate_change_thread_join(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    assert(migration->vm_state_thread_running);
+
+    qemu_thread_join(&migration->vm_state_thread);
+
+    migration->vm_state_thread_running = false;
+}
+
+/*
+ * The first handler called during a vmstate change at a particular depth -
+ * launch the VFIO device state change thread.
+ */
+static void vfio_vmstate_change_first(VFIODevice *vbasedev,
+                                      bool is_prepare,
+                                      bool running, RunState state)
+{
+    vfio_vmstate_change_thread_launch(vbasedev,
+                                      is_prepare,
+                                      running,
+                                      state);
+}
+
+/*
+ * The last handler called during a vmstate change at a particular depth -
+ * wait for the VFIO device state change thread to finish.
+ */
+static void vfio_vmstate_change_second(VFIODevice *vbasedev)
+{
+    vfio_vmstate_change_thread_join(vbasedev);
+}
+
+/*
+ * Lower priority number handler:
+ * Called before higher number handler when VM is starting
+ * but after higher number handler when VM is stopping.
+ */
+static void vfio_vmstate_change_prepare_lower_prio(void *opaque, bool running,
+                                                   RunState state)
+{
+    if (running) {
+        vfio_vmstate_change_first(opaque, true, running, state);
+    } else {
+        vfio_vmstate_change_second(opaque);
+    }
+}
+
+/*
+ * Higher priority number handler:
+ * Called after lower number handler when VM is starting
+ * but before lower number handler when VM is stopping.
+ */
+static void vfio_vmstate_change_prepare_higher_prio(void *opaque, bool running,
+                                                    RunState state)
+{
+    if (running) {
+        vfio_vmstate_change_second(opaque);
+    } else {
+        vfio_vmstate_change_first(opaque, true, running, state);
+    }
+}
+
+/* Same ordering issues as for vfio_vmstate_change_prepare_lower_prio() */
+static void vfio_vmstate_change_lower_prio(void *opaque, bool running,
+                                           RunState state)
+{
+    if (running) {
+        vfio_vmstate_change_first(opaque, false, running, state);
+    } else {
+        vfio_vmstate_change_second(opaque);
+    }
+}
+
+/* Same ordering issues as for vfio_vmstate_change_prepare_higher_prio() */
+static void vfio_vmstate_change_higher_prio(void *opaque, bool running,
+                                            RunState state)
+{
+    if (running) {
+        vfio_vmstate_change_second(opaque);
+    } else {
+        vfio_vmstate_change_first(opaque, false, running, state);
+    }
+}
+
 static int vfio_migration_state_notifier(NotifierWithReturn *notifier,
                                          MigrationEvent *e, Error **errp)
 {
@@ -1063,6 +1192,8 @@ static int vfio_migration_state_notifier(NotifierWithReturn *notifier,
          * MigrationNotifyFunc may not return an error code and an Error
          * object for MIG_EVENT_FAILED. Hence, report the error
          * locally and ignore the errp argument.
+         * This state change is not parallelized as it is not expected to be
+         * performance critical.
          */
         ret = vfio_migration_set_state_or_reset(vbasedev,
                                                 VFIO_DEVICE_STATE_RUNNING,
@@ -1143,7 +1274,7 @@ static int vfio_migration_init(VFIODevice *vbasedev, Error **errp)
     char id[256] = "";
     g_autofree char *path = NULL, *oid = NULL;
     uint64_t mig_flags = 0;
-    VMChangeStateHandler *prepare_cb;
+    VMChangeStateHandler *prepare_cb, *prepare_cb_lower, *prepare_cb_higher;
 
     if (!vbasedev->ops->vfio_get_object) {
         ret = -EINVAL;
@@ -1223,11 +1354,34 @@ static int vfio_migration_init(VFIODevice *vbasedev, Error **errp)
     register_savevm_live(id, VMSTATE_INSTANCE_ID_ANY, 1, &savevm_vfio_handlers,
                          vbasedev);
 
-    prepare_cb = migration->mig_flags & VFIO_MIGRATION_P2P ?
-                     vfio_vmstate_change_prepare :
-                     NULL;
-    migration->vm_state = qdev_add_vm_change_state_handler_full(
-        vbasedev->dev, vfio_vmstate_change, prepare_cb, NULL, vbasedev, 0);
+    if (vbasedev->migration_parallel_states) {
+        /*
+         * Unfortunately, the order in which vmstate handlers are called depends
+         * on whether the VM is starting or stopping.
+         * Because of this, one extra layer of indirection is necessary
+         * to make the (first, second) ordering of these handlers constant.
+         */
+        prepare_cb_lower = migration->mig_flags & VFIO_MIGRATION_P2P ?
+            vfio_vmstate_change_prepare_lower_prio : NULL;
+        prepare_cb_higher = migration->mig_flags & VFIO_MIGRATION_P2P ?
+            vfio_vmstate_change_prepare_higher_prio : NULL;
+        migration->vm_state_lower_prio = qdev_add_vm_change_state_handler_full(
+            vbasedev->dev, vfio_vmstate_change_lower_prio, prepare_cb_lower,
+            NULL, vbasedev, -1);
+        migration->vm_state_higher_prio = qdev_add_vm_change_state_handler_full(
+            vbasedev->dev, vfio_vmstate_change_higher_prio, prepare_cb_higher,
+            NULL, vbasedev, 1);
+    } else {
+        prepare_cb = migration->mig_flags & VFIO_MIGRATION_P2P ?
+            vfio_vmstate_change_prepare : NULL;
+        /* Arbitrarily use lower_prio field to store non-parallel handler */
+        migration->vm_state_lower_prio =
+            qdev_add_vm_change_state_handler_full(vbasedev->dev,
+                                                  vfio_vmstate_change,
+                                                  prepare_cb, NULL,
+                                                  vbasedev, 0);
+    }
+
     migration_add_notifier(&migration->migration_state,
                            vfio_migration_state_notifier);
 
@@ -1302,7 +1456,13 @@ static void vfio_migration_deinit(VFIODevice *vbasedev)
     VFIOMigration *migration = vbasedev->migration;
 
     migration_remove_notifier(&migration->migration_state);
-    qemu_del_vm_change_state_handler(migration->vm_state);
+
+    if (vbasedev->migration_parallel_states) {
+        qemu_del_vm_change_state_handler(migration->vm_state_higher_prio);
+    }
+    /* Non-parallel state change uses lower_prio field to store its handler */
+    qemu_del_vm_change_state_handler(migration->vm_state_lower_prio);
+
     unregister_savevm(VMSTATE_IF(vbasedev->dev), "vfio", vbasedev);
     vfio_migration_free(vbasedev);
     vfio_unblock_multiple_devices_migration();
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b2a07f6bb421..fa2411474c9b 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3777,6 +3777,8 @@ static const Property vfio_pci_properties[] = {
                             ON_OFF_AUTO_AUTO),
     DEFINE_PROP_SIZE("x-migration-max-queued-buffers-size", VFIOPCIDevice,
                      vbasedev.migration_max_queued_buffers_size, UINT64_MAX),
+    DEFINE_PROP_BOOL("x-migration-parallel-states", VFIOPCIDevice,
+                     vbasedev.migration_parallel_states, true),
     DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
                      vbasedev.migration_events, false),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
diff --git a/hw/vfio/vfio-migration-internal.h b/hw/vfio/vfio-migration-internal.h
index a1c58b112685..9fb00f9f4d7d 100644
--- a/hw/vfio/vfio-migration-internal.h
+++ b/hw/vfio/vfio-migration-internal.h
@@ -38,7 +38,9 @@ typedef struct VFIOMultifd VFIOMultifd;
 
 typedef struct VFIOMigration {
     struct VFIODevice *vbasedev;
-    VMChangeStateEntry *vm_state;
+    VMChangeStateEntry *vm_state_lower_prio, *vm_state_higher_prio;
+    QemuThread vm_state_thread;
+    bool vm_state_thread_running;
     NotifierWithReturn migration_state;
     uint32_t device_state;
     int data_fd;
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 380a55d6e5ea..28004e1e99f4 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -69,6 +69,7 @@ typedef struct VFIODevice {
     OnOffAuto migration_multifd_transfer;
     OnOffAuto migration_load_config_after_iter;
     uint64_t migration_max_queued_buffers_size;
+    bool migration_parallel_states;
     bool migration_events;
     bool use_region_fds;
     VFIODeviceOps *ops;

