Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA6E606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 19:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKKlQ-00033d-JN; Fri, 23 Oct 2026 15:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKlD-0002zs-Hu
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:17:03 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKl9-00022U-HT
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:17:03 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKl5-00000007BFB-1gvj; Fri, 23 Oct 2026 21:16:55 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 05/13] vfio/migration: Parallelize device state transitions
Date: Fri, 23 Oct 2026 21:16:16 +0200
Message-ID: <192e01ee9a2d89825c8455e48cdfa7ee893173cb.1792758435.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792758435.git.maciej.szmigiero@oracle.com>
References: <cover.1792758435.git.maciej.szmigiero@oracle.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

Instead of performing these state transitions synchronously launch a
per-device thread performing them at VM_CHANGE_STATE_PRI_HIGH.

Since no VFIO device should start the second state transition until
all VFIO devices have completed the first transition also register a
single VM_CHANGE_STATE_PRI_SYNC handler common for all VFIO devices that
serves as a synchronization point/barrier between these transitions.

This synchronization point also serves to fulfill similar requirement with
respect to non-VFIO devices that require particular sequencing with respect
to running their VM state change handlers versus VFIO devices.
In particular, this requirement applies to DMA-generating devices and
interrupt controllers.

These VFIO device state change threads are joined (waited for) from a
per-device VM_CHANGE_STATE_PRI_NORMAL handler.

This way these state transitions can happen in parallel not only with
respect to other VFIO device instances but also ordinary (serialized)
handlers for other devices at other qdev tree depths - as long as these
handlers at other qdev tree depths would be previously ordered earlier than
the synchronous VFIO device state change handler.

Data used by common VM_CHANGE_STATE_PRI_SYNC handler is shared between
all TYPE_VFIO_PCI_DEVICE instances, so it is kept in its VFIOPCIDeviceClass
struct as new "vm_state_change_sync" field.
This data is allocated on demand during initialization of the migration
part of the first migratable VFIO device.
Since derived classes (like TYPE_VFIO_PCI and TYPE_VFIO_PCI_NOHOTPLUG)
inherit this class field as a shallow copy, one extra level of pointer
indirection is necessary for this data.

Enable the feature by default since it has no impact on the migration bit
stream protocol - it shouldn't need disabling for anything else but
debugging scenarios.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/vfio/migration.c               | 228 +++++++++++++++++++++++++++++-
 hw/vfio/pci.c                     |   6 +
 hw/vfio/pci.h                     |   4 +
 hw/vfio/trace-events              |   2 +
 hw/vfio/vfio-migration-internal.h |   2 +
 include/hw/vfio/vfio-device.h     |   1 +
 6 files changed, 237 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 76ede0efbf02..2300a6e3ec16 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1053,6 +1053,202 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
                               mig_state_to_str(new_state));
 }
 
+typedef struct VMStateChangeThreadData {
+    VFIODevice *vbasedev;
+    VFIOVMStateChangeSync *sync;
+    bool running;
+    RunState state;
+} VMStateChangeThreadData;
+
+struct VFIOVMStateChangeSync {
+    VMChangeStateEntry *vm_state;
+
+    /* Only counts devices with parallel state change ON */
+    unsigned int device_count;
+    unsigned int thread_count;
+
+    unsigned int p2p_done_count;
+    QemuEvent p2p_all_done;
+    QemuEvent final_transition_start;
+};
+
+static void vfio_vmstate_change_sync_handler(void *opaque, bool running,
+                                             RunState state)
+{
+    VFIOVMStateChangeSync *sync = opaque;
+
+    assert(qatomic_read(&sync->thread_count) ==
+           qatomic_read(&sync->device_count));
+
+    trace_vfio_vmstate_change_sync_wait();
+    qemu_event_wait(&sync->p2p_all_done);
+
+    trace_vfio_vmstate_change_sync_done();
+    qemu_event_set(&sync->final_transition_start);
+}
+
+static VFIOVMStateChangeSync **
+vfio_vmstate_change_sync_ptr(VFIODevice *vbasedev)
+{
+    VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
+    VFIOPCIDeviceClass *vpc;
+
+    assert(vdev);
+    vpc = VFIO_PCI_DEVICE_GET_CLASS(vdev);
+    assert(vpc);
+    assert(vpc->vm_state_change_sync);
+
+    return vpc->vm_state_change_sync;
+}
+
+static VFIOVMStateChangeSync *
+vfio_vmstate_change_sync_ref(VFIODevice *vbasedev)
+{
+    VFIOVMStateChangeSync **syncp = vfio_vmstate_change_sync_ptr(vbasedev);
+    VFIOVMStateChangeSync *sync = *syncp;
+
+    if (!sync) {
+        sync = g_new0(VFIOVMStateChangeSync, 1);
+        qemu_event_init(&sync->p2p_all_done, false);
+        qemu_event_init(&sync->final_transition_start, false);
+
+        sync->vm_state = qemu_add_vm_change_state_handler_prio(
+            vfio_vmstate_change_sync_handler, sync,
+            VM_CHANGE_STATE_PRI_SYNC);
+
+        *syncp = sync;
+    }
+
+    qatomic_fetch_inc(&sync->device_count);
+
+    return sync;
+}
+
+static void vfio_vmstate_change_sync_unref(VFIODevice *vbasedev)
+{
+    VFIOVMStateChangeSync **syncp = vfio_vmstate_change_sync_ptr(vbasedev);
+    VFIOVMStateChangeSync *sync = *syncp;
+    unsigned int device_count;
+
+    assert(sync);
+
+    device_count = qatomic_fetch_dec(&sync->device_count);
+    assert(device_count > 0);
+
+    if (device_count != 1) {
+        return;
+    }
+
+    assert(qatomic_read(&sync->thread_count) == 0);
+
+    qemu_del_vm_change_state_handler(sync->vm_state);
+    qemu_event_destroy(&sync->final_transition_start);
+    qemu_event_destroy(&sync->p2p_all_done);
+
+    g_clear_pointer(syncp, g_free);
+}
+
+static VFIOVMStateChangeSync *
+vfio_vmstate_change_sync_get(VFIODevice *vbasedev)
+{
+    VFIOVMStateChangeSync *sync = *vfio_vmstate_change_sync_ptr(vbasedev);
+
+    assert(sync);
+
+    return sync;
+}
+
+static void
+vfio_vmstate_change_sync_thread_pre_start(VFIOVMStateChangeSync *sync)
+{
+    if (qatomic_fetch_inc(&sync->thread_count) == 0) {
+        /*
+         * Reset the sync data at the first thread launch time since
+         * the whole struct survives VM start/stop sequence.
+         */
+        qatomic_set(&sync->p2p_done_count, 0);
+        qemu_event_reset(&sync->p2p_all_done);
+        qemu_event_reset(&sync->final_transition_start);
+    }
+}
+
+static void
+vfio_vmstate_change_sync_p2p_done(VFIOVMStateChangeSync *sync)
+{
+    unsigned int done;
+
+    done = qatomic_fetch_inc(&sync->p2p_done_count) + 1;
+    if (done == qatomic_read(&sync->device_count)) {
+        qemu_event_set(&sync->p2p_all_done);
+    }
+
+    qemu_event_wait(&sync->final_transition_start);
+}
+
+static void
+vfio_vmstate_change_sync_thread_finished(VFIOVMStateChangeSync *sync)
+{
+    unsigned int thread_count;
+
+    thread_count = qatomic_fetch_dec(&sync->thread_count);
+    assert(thread_count > 0);
+}
+
+static void *vfio_vmstate_change_thread(void *opaque)
+{
+    g_autofree VMStateChangeThreadData *data = opaque;
+    VFIOMigration *migration = data->vbasedev->migration;
+
+    if (migration->mig_flags & VFIO_MIGRATION_P2P) {
+        vfio_vmstate_change_prepare(data->vbasedev, data->running, data->state);
+    }
+
+    vfio_vmstate_change_sync_p2p_done(data->sync);
+
+    vfio_vmstate_change(data->vbasedev, data->running, data->state);
+
+    return NULL;
+}
+
+static void vfio_vmstate_change_thread_launch(void *opaque, bool running,
+                                              RunState state)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    VMStateChangeThreadData *data = g_new(VMStateChangeThreadData, 1);
+    VFIOVMStateChangeSync *sync = vfio_vmstate_change_sync_get(vbasedev);
+
+    data->vbasedev = vbasedev;
+    data->sync = sync;
+    data->running = running;
+    data->state = state;
+
+    assert(!migration->vm_state_thread_running);
+    migration->vm_state_thread_running = true;
+
+    vfio_vmstate_change_sync_thread_pre_start(sync);
+
+    qemu_thread_create(&migration->vm_state_thread,
+                       "vfio_vmstate_change",
+                       vfio_vmstate_change_thread, data,
+                       QEMU_THREAD_JOINABLE);
+}
+
+static void vfio_vmstate_change_thread_join(void *opaque, bool running,
+                                            RunState state)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    VFIOVMStateChangeSync *sync = vfio_vmstate_change_sync_get(vbasedev);
+
+    assert(migration->vm_state_thread_running);
+
+    qemu_thread_join(&migration->vm_state_thread);
+    migration->vm_state_thread_running = false;
+
+    vfio_vmstate_change_sync_thread_finished(sync);
+}
+
 static int vfio_migration_state_notifier(NotifierWithReturn *notifier,
                                          MigrationEvent *e, Error **errp)
 {
@@ -1069,6 +1265,8 @@ static int vfio_migration_state_notifier(NotifierWithReturn *notifier,
          * MigrationNotifyFunc may not return an error code and an Error
          * object for MIG_EVENT_FAILED. Hence, report the error
          * locally and ignore the errp argument.
+         * This state change is not parallelized as it is not expected to be
+         * performance critical.
          */
         ret = vfio_migration_set_state_or_reset(vbasedev,
                                                 VFIO_DEVICE_STATE_RUNNING,
@@ -1209,13 +1407,25 @@ static bool vfio_migration_init(VFIODevice *vbasedev, Error **errp)
     register_savevm_live(id, VMSTATE_INSTANCE_ID_ANY, 1, &savevm_vfio_handlers,
                          vbasedev);
 
-    if (migration->mig_flags & VFIO_MIGRATION_P2P) {
-        migration->vm_state_prepare = qdev_add_vm_change_state_handler_full(
-            vbasedev->dev, vfio_vmstate_change_prepare, NULL, vbasedev,
-            VM_CHANGE_STATE_PRI_HIGH);
+    if (vbasedev->migration_parallel_states) {
+        vfio_vmstate_change_sync_ref(vbasedev);
+        migration->vm_state_prepare =
+            qdev_add_vm_change_state_handler_full(
+                vbasedev->dev, vfio_vmstate_change_thread_launch, NULL,
+                vbasedev, VM_CHANGE_STATE_PRI_HIGH);
+        migration->vm_state = qdev_add_vm_change_state_handler(
+            vbasedev->dev, vfio_vmstate_change_thread_join, NULL, vbasedev);
+    } else {
+        if (migration->mig_flags & VFIO_MIGRATION_P2P) {
+            migration->vm_state_prepare =
+                qdev_add_vm_change_state_handler_full(
+                    vbasedev->dev, vfio_vmstate_change_prepare, NULL,
+                    vbasedev, VM_CHANGE_STATE_PRI_HIGH);
+        }
+        migration->vm_state = qdev_add_vm_change_state_handler(
+            vbasedev->dev, vfio_vmstate_change, NULL, vbasedev);
     }
-    migration->vm_state = qdev_add_vm_change_state_handler(
-        vbasedev->dev, vfio_vmstate_change, NULL, vbasedev);
+
     migration_add_notifier(&migration->migration_state,
                            vfio_migration_state_notifier);
 
@@ -1292,6 +1502,12 @@ static void vfio_migration_deinit(VFIODevice *vbasedev)
     migration_remove_notifier(&migration->migration_state);
     qemu_del_vm_change_state_handler(migration->vm_state_prepare);
     qemu_del_vm_change_state_handler(migration->vm_state);
+
+    if (vbasedev->migration_parallel_states) {
+        assert(!migration->vm_state_thread_running);
+        vfio_vmstate_change_sync_unref(vbasedev);
+    }
+
     unregister_savevm(VMSTATE_IF(vbasedev->dev), "vfio", vbasedev);
     vfio_migration_free(vbasedev);
     vfio_unblock_multiple_devices_migration();
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 31699422f238..e9794a5964aa 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3839,9 +3839,13 @@ static void vfio_pci_init(Object *obj)
 
 static void vfio_pci_device_class_init(ObjectClass *klass, const void *data)
 {
+    VFIOPCIDeviceClass *vpc = VFIO_PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
 
+    /* Derived classes inherit this field as a copy */
+    vpc->vm_state_change_sync = g_new0(VFIOVMStateChangeSync *, 1);
+
     dc->desc = "VFIO PCI base device";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     pdc->exit = vfio_exitfn;
@@ -3902,6 +3906,8 @@ static const Property vfio_pci_properties[] = {
                             ON_OFF_AUTO_AUTO),
     DEFINE_PROP_SIZE("x-migration-max-queued-buffers-size", VFIOPCIDevice,
                      vbasedev.migration_max_queued_buffers_size, UINT64_MAX),
+    DEFINE_PROP_BOOL("x-migration-parallel-states", VFIOPCIDevice,
+                     vbasedev.migration_parallel_states, true),
     DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
                      vbasedev.migration_events, false),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 70c46add8fe4..598472050f59 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -120,10 +120,14 @@ typedef struct VFIOMSIXInfo {
     MemoryRegion *pba_region;
 } VFIOMSIXInfo;
 
+typedef struct VFIOVMStateChangeSync VFIOVMStateChangeSync;
+
 OBJECT_DECLARE_TYPE(VFIOPCIDevice, VFIOPCIDeviceClass, VFIO_PCI_DEVICE)
 
 struct VFIOPCIDeviceClass {
     PCIDeviceClass parent_class;
+
+    VFIOVMStateChangeSync **vm_state_change_sync;
 };
 
 struct VFIOPCIDevice {
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index bfdaf229e42b..6225d7661c67 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -183,6 +183,8 @@ vfio_state_pending(const char *name, uint64_t stopcopy_size, uint64_t precopy_in
 vfio_send_init_data_flag(const char *name) " (%s)"
 vfio_vmstate_change(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
 vfio_vmstate_change_prepare(const char *name, int running, const char *reason, const char *dev_state) " (%s) running %d reason %s device state %s"
+vfio_vmstate_change_sync_wait(void) ""
+vfio_vmstate_change_sync_done(void) ""
 
 #iommufd.c
 
diff --git a/hw/vfio/vfio-migration-internal.h b/hw/vfio/vfio-migration-internal.h
index b3c2f86cae78..5be321527a42 100644
--- a/hw/vfio/vfio-migration-internal.h
+++ b/hw/vfio/vfio-migration-internal.h
@@ -40,6 +40,8 @@ typedef struct VFIOMigration {
     struct VFIODevice *vbasedev;
     VMChangeStateEntry *vm_state_prepare;
     VMChangeStateEntry *vm_state;
+    QemuThread vm_state_thread;
+    bool vm_state_thread_running;
     NotifierWithReturn migration_state;
     uint32_t device_state;
     int data_fd;
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 8472420d3fac..5a96aab20700 100644
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

