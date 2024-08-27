Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C61C54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 17:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj0RF-00030C-TS; Tue, 27 Aug 2024 13:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0QZ-0007xy-Vi
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:56:24 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0QX-0001da-8j
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:56:23 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0QN-0002Q1-Tw; Tue, 27 Aug 2024 19:56:11 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 15/17] vfio/migration: Multifd device state transfer
 support - receive side
Date: Tue, 27 Aug 2024 19:54:34 +0200
Message-ID: <4133ce80174fa3b81070adaeeb068554beba2854.1724701542.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1724701542.git.maciej.szmigiero@oracle.com>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

The multifd received data needs to be reassembled since device state
packets sent via different multifd channels can arrive out-of-order.

Therefore, each VFIO device state packet carries a header indicating
its position in the stream.

The last such VFIO device state packet should have
VFIO_DEVICE_STATE_CONFIG_STATE flag set and carry the device config
state.

Since it's important to finish loading device state transferred via
the main migration channel (via save_live_iterate handler) before
starting loading the data asynchronously transferred via multifd
a new VFIO_MIG_FLAG_DEV_DATA_STATE_COMPLETE flag is introduced to
mark the end of the main migration channel data.

The device state loading process waits until that flag is seen before
commencing loading of the multifd-transferred device state.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/vfio/migration.c           | 338 +++++++++++++++++++++++++++++++++-
 hw/vfio/pci.c                 |   2 +
 hw/vfio/trace-events          |   9 +-
 include/hw/vfio/vfio-common.h |  17 ++
 4 files changed, 362 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 24679d8c5034..57c1542528dc 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -15,6 +15,7 @@
 #include <linux/vfio.h>
 #include <sys/ioctl.h>
 
+#include "io/channel-buffer.h"
 #include "sysemu/runstate.h"
 #include "hw/vfio/vfio-common.h"
 #include "migration/misc.h"
@@ -47,6 +48,7 @@
 #define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
 #define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
 #define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
+#define VFIO_MIG_FLAG_DEV_DATA_STATE_COMPLETE    (0xffffffffef100006ULL)
 
 /*
  * This is an arbitrary size based on migration of mlx5 devices, where typically
@@ -55,6 +57,15 @@
  */
 #define VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE (1 * MiB)
 
+#define VFIO_DEVICE_STATE_CONFIG_STATE (1)
+
+typedef struct VFIODeviceStatePacket {
+    uint32_t version;
+    uint32_t idx;
+    uint32_t flags;
+    uint8_t data[0];
+} QEMU_PACKED VFIODeviceStatePacket;
+
 static int64_t bytes_transferred;
 
 static const char *mig_state_to_str(enum vfio_device_mig_state state)
@@ -254,6 +265,188 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
     return ret;
 }
 
+typedef struct LoadedBuffer {
+    bool is_present;
+    char *data;
+    size_t len;
+} LoadedBuffer;
+
+static void loaded_buffer_clear(gpointer data)
+{
+    LoadedBuffer *lb = data;
+
+    if (!lb->is_present) {
+        return;
+    }
+
+    g_clear_pointer(&lb->data, g_free);
+    lb->is_present = false;
+}
+
+static int vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
+                                  Error **errp)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    VFIODeviceStatePacket *packet = (VFIODeviceStatePacket *)data;
+    QEMU_LOCK_GUARD(&migration->load_bufs_mutex);
+    LoadedBuffer *lb;
+
+    if (data_size < sizeof(*packet)) {
+        error_setg(errp, "packet too short at %zu (min is %zu)",
+                   data_size, sizeof(*packet));
+        return -1;
+    }
+
+    if (packet->version != 0) {
+        error_setg(errp, "packet has unknown version %" PRIu32,
+                   packet->version);
+        return -1;
+    }
+
+    if (packet->idx == UINT32_MAX) {
+        error_setg(errp, "packet has too high idx %" PRIu32,
+                   packet->idx);
+        return -1;
+    }
+
+    trace_vfio_load_state_device_buffer_incoming(vbasedev->name, packet->idx);
+
+    /* config state packet should be the last one in the stream */
+    if (packet->flags & VFIO_DEVICE_STATE_CONFIG_STATE) {
+        migration->load_buf_idx_last = packet->idx;
+    }
+
+    assert(migration->load_bufs);
+    if (packet->idx >= migration->load_bufs->len) {
+        g_array_set_size(migration->load_bufs, packet->idx + 1);
+    }
+
+    lb = &g_array_index(migration->load_bufs, typeof(*lb), packet->idx);
+    if (lb->is_present) {
+        error_setg(errp, "state buffer %" PRIu32 " already filled", packet->idx);
+        return -1;
+    }
+
+    assert(packet->idx >= migration->load_buf_idx);
+
+    migration->load_buf_queued_pending_buffers++;
+    if (migration->load_buf_queued_pending_buffers >
+        vbasedev->migration_max_queued_buffers) {
+        error_setg(errp,
+                   "queuing state buffer %" PRIu32 " would exceed the max of %" PRIu64,
+                   packet->idx, vbasedev->migration_max_queued_buffers);
+        return -1;
+    }
+
+    lb->data = g_memdup2(&packet->data, data_size - sizeof(*packet));
+    lb->len = data_size - sizeof(*packet);
+    lb->is_present = true;
+
+    qemu_cond_broadcast(&migration->load_bufs_buffer_ready_cond);
+
+    return 0;
+}
+
+static void *vfio_load_bufs_thread(void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    Error **errp = &migration->load_bufs_thread_errp;
+    g_autoptr(QemuLockable) locker = qemu_lockable_auto_lock(
+        QEMU_MAKE_LOCKABLE(&migration->load_bufs_mutex));
+    LoadedBuffer *lb;
+
+    while (!migration->load_bufs_device_ready &&
+           !migration->load_bufs_thread_want_exit) {
+        qemu_cond_wait(&migration->load_bufs_device_ready_cond, &migration->load_bufs_mutex);
+    }
+
+    while (!migration->load_bufs_thread_want_exit) {
+        bool starved;
+        ssize_t ret;
+
+        assert(migration->load_buf_idx <= migration->load_buf_idx_last);
+
+        if (migration->load_buf_idx >= migration->load_bufs->len) {
+            assert(migration->load_buf_idx == migration->load_bufs->len);
+            starved = true;
+        } else {
+            lb = &g_array_index(migration->load_bufs, typeof(*lb), migration->load_buf_idx);
+            starved = !lb->is_present;
+        }
+
+        if (starved) {
+            trace_vfio_load_state_device_buffer_starved(vbasedev->name, migration->load_buf_idx);
+            qemu_cond_wait(&migration->load_bufs_buffer_ready_cond, &migration->load_bufs_mutex);
+            continue;
+        }
+
+        if (migration->load_buf_idx == migration->load_buf_idx_last) {
+            break;
+        }
+
+        if (migration->load_buf_idx == 0) {
+            trace_vfio_load_state_device_buffer_start(vbasedev->name);
+        }
+
+        if (lb->len) {
+            g_autofree char *buf = NULL;
+            size_t buf_len;
+            int errno_save;
+
+            trace_vfio_load_state_device_buffer_load_start(vbasedev->name,
+                                                           migration->load_buf_idx);
+
+            /* lb might become re-allocated when we drop the lock */
+            buf = g_steal_pointer(&lb->data);
+            buf_len = lb->len;
+
+            /* Loading data to the device takes a while, drop the lock during this process */
+            qemu_mutex_unlock(&migration->load_bufs_mutex);
+            ret = write(migration->data_fd, buf, buf_len);
+            errno_save = errno;
+            qemu_mutex_lock(&migration->load_bufs_mutex);
+
+            if (ret < 0) {
+                error_setg(errp, "write to state buffer %" PRIu32 " failed with %d",
+                           migration->load_buf_idx, errno_save);
+                break;
+            } else if (ret < buf_len) {
+                error_setg(errp, "write to state buffer %" PRIu32 " incomplete %zd / %zu",
+                           migration->load_buf_idx, ret, buf_len);
+                break;
+            }
+
+            trace_vfio_load_state_device_buffer_load_end(vbasedev->name,
+                                                         migration->load_buf_idx);
+        }
+
+        assert(migration->load_buf_queued_pending_buffers > 0);
+        migration->load_buf_queued_pending_buffers--;
+
+        if (migration->load_buf_idx == migration->load_buf_idx_last - 1) {
+            trace_vfio_load_state_device_buffer_end(vbasedev->name);
+        }
+
+        migration->load_buf_idx++;
+    }
+
+    if (migration->load_bufs_thread_want_exit &&
+        !*errp) {
+        error_setg(errp, "load bufs thread asked to quit");
+    }
+
+    g_clear_pointer(&locker, qemu_lockable_auto_unlock);
+
+    qemu_loadvm_load_finish_ready_lock();
+    migration->load_bufs_thread_finished = true;
+    qemu_loadvm_load_finish_ready_broadcast();
+    qemu_loadvm_load_finish_ready_unlock();
+
+    return NULL;
+}
+
 static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
                                          Error **errp)
 {
@@ -285,6 +478,8 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
     VFIODevice *vbasedev = opaque;
     uint64_t data;
 
+    trace_vfio_load_device_config_state_start(vbasedev->name);
+
     if (vbasedev->ops && vbasedev->ops->vfio_load_config) {
         int ret;
 
@@ -303,7 +498,7 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
         return -EINVAL;
     }
 
-    trace_vfio_load_device_config_state(vbasedev->name);
+    trace_vfio_load_device_config_state_end(vbasedev->name);
     return qemu_file_get_error(f);
 }
 
@@ -687,16 +882,70 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
 static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    int ret;
+
+    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
+                                   vbasedev->migration->device_state, errp);
+    if (ret) {
+        return ret;
+    }
+
+    assert(!migration->load_bufs);
+    migration->load_bufs = g_array_new(FALSE, TRUE, sizeof(LoadedBuffer));
+    g_array_set_clear_func(migration->load_bufs, loaded_buffer_clear);
+
+    qemu_mutex_init(&migration->load_bufs_mutex);
+
+    migration->load_bufs_device_ready = false;
+    qemu_cond_init(&migration->load_bufs_device_ready_cond);
+
+    migration->load_buf_idx = 0;
+    migration->load_buf_idx_last = UINT32_MAX;
+    migration->load_buf_queued_pending_buffers = 0;
+    qemu_cond_init(&migration->load_bufs_buffer_ready_cond);
+
+    migration->config_state_loaded_to_dev = false;
+
+    assert(!migration->load_bufs_thread_started);
 
-    return vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
-                                    vbasedev->migration->device_state, errp);
+    migration->load_bufs_thread_finished = false;
+    migration->load_bufs_thread_want_exit = false;
+    qemu_thread_create(&migration->load_bufs_thread, "vfio-load-bufs",
+                       vfio_load_bufs_thread, opaque, QEMU_THREAD_JOINABLE);
+
+    migration->load_bufs_thread_started = true;
+
+    return 0;
 }
 
 static int vfio_load_cleanup(void *opaque)
 {
     VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+
+    if (migration->load_bufs_thread_started) {
+        qemu_mutex_lock(&migration->load_bufs_mutex);
+        migration->load_bufs_thread_want_exit = true;
+        qemu_mutex_unlock(&migration->load_bufs_mutex);
+
+        qemu_cond_broadcast(&migration->load_bufs_device_ready_cond);
+        qemu_cond_broadcast(&migration->load_bufs_buffer_ready_cond);
+
+        qemu_thread_join(&migration->load_bufs_thread);
+
+        assert(migration->load_bufs_thread_finished);
+
+        migration->load_bufs_thread_started = false;
+    }
 
     vfio_migration_cleanup(vbasedev);
+
+    g_clear_pointer(&migration->load_bufs, g_array_unref);
+    qemu_cond_destroy(&migration->load_bufs_buffer_ready_cond);
+    qemu_cond_destroy(&migration->load_bufs_device_ready_cond);
+    qemu_mutex_destroy(&migration->load_bufs_mutex);
+
     trace_vfio_load_cleanup(vbasedev->name);
 
     return 0;
@@ -705,6 +954,7 @@ static int vfio_load_cleanup(void *opaque)
 static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
 {
     VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
     int ret = 0;
     uint64_t data;
 
@@ -716,6 +966,7 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
         switch (data) {
         case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
         {
+            migration->config_state_loaded_to_dev = true;
             return vfio_load_device_config_state(f, opaque);
         }
         case VFIO_MIG_FLAG_DEV_SETUP_STATE:
@@ -742,6 +993,15 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
             }
             break;
         }
+        case VFIO_MIG_FLAG_DEV_DATA_STATE_COMPLETE:
+        {
+            QEMU_LOCK_GUARD(&migration->load_bufs_mutex);
+
+            migration->load_bufs_device_ready = true;
+            qemu_cond_broadcast(&migration->load_bufs_device_ready_cond);
+
+            break;
+        }
         case VFIO_MIG_FLAG_DEV_INIT_DATA_SENT:
         {
             if (!vfio_precopy_supported(vbasedev) ||
@@ -774,6 +1034,76 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
     return ret;
 }
 
+static int vfio_load_finish(void *opaque, bool *is_finished, Error **errp)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    g_autoptr(QemuLockable) locker = NULL;
+    LoadedBuffer *lb;
+    g_autoptr(QIOChannelBuffer) bioc = NULL;
+    QEMUFile *f_out = NULL, *f_in = NULL;
+    uint64_t mig_header;
+    int ret;
+
+    if (migration->config_state_loaded_to_dev) {
+        *is_finished = true;
+        return 0;
+    }
+
+    if (!migration->load_bufs_thread_finished) {
+        assert(migration->load_bufs_thread_started);
+        *is_finished = false;
+        return 0;
+    }
+
+    if (migration->load_bufs_thread_errp) {
+        error_propagate(errp, g_steal_pointer(&migration->load_bufs_thread_errp));
+        return -1;
+    }
+
+    locker = qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE(&migration->load_bufs_mutex));
+
+    assert(migration->load_buf_idx == migration->load_buf_idx_last);
+    lb = &g_array_index(migration->load_bufs, typeof(*lb), migration->load_buf_idx);
+    assert(lb->is_present);
+
+    bioc = qio_channel_buffer_new(lb->len);
+    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-load");
+
+    f_out = qemu_file_new_output(QIO_CHANNEL(bioc));
+    qemu_put_buffer(f_out, (uint8_t *)lb->data, lb->len);
+
+    ret = qemu_fflush(f_out);
+    if (ret) {
+        error_setg(errp, "load device config state file flush failed with %d", ret);
+        g_clear_pointer(&f_out, qemu_fclose);
+        return -1;
+    }
+
+    qio_channel_io_seek(QIO_CHANNEL(bioc), 0, 0, NULL);
+    f_in = qemu_file_new_input(QIO_CHANNEL(bioc));
+
+    mig_header = qemu_get_be64(f_in);
+    if (mig_header != VFIO_MIG_FLAG_DEV_CONFIG_STATE) {
+        error_setg(errp, "load device config state invalid header %"PRIu64, mig_header);
+        g_clear_pointer(&f_out, qemu_fclose);
+        g_clear_pointer(&f_in, qemu_fclose);
+        return -1;
+    }
+
+    ret = vfio_load_device_config_state(f_in, opaque);
+    g_clear_pointer(&f_out, qemu_fclose);
+    g_clear_pointer(&f_in, qemu_fclose);
+    if (ret < 0) {
+        error_setg(errp, "load device config state failed with %d", ret);
+        return -1;
+    }
+
+    migration->config_state_loaded_to_dev = true;
+    *is_finished = true;
+    return 0;
+}
+
 static bool vfio_switchover_ack_needed(void *opaque)
 {
     VFIODevice *vbasedev = opaque;
@@ -794,6 +1124,8 @@ static const SaveVMHandlers savevm_vfio_handlers = {
     .load_setup = vfio_load_setup,
     .load_cleanup = vfio_load_cleanup,
     .load_state = vfio_load_state,
+    .load_state_buffer = vfio_load_state_buffer,
+    .load_finish = vfio_load_finish,
     .switchover_ack_needed = vfio_switchover_ack_needed,
 };
 
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 2407720c3530..08cb56d27a05 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3378,6 +3378,8 @@ static Property vfio_pci_dev_properties[] = {
                     VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
     DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
                             vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_UINT64("x-migration-max-queued-buffers", VFIOPCIDevice,
+                       vbasedev.migration_max_queued_buffers, UINT64_MAX),
     DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
                      vbasedev.migration_events, false),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 013c602f30fa..9d2519a28a7e 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -149,9 +149,16 @@ vfio_display_edid_write_error(void) ""
 
 # migration.c
 vfio_load_cleanup(const char *name) " (%s)"
-vfio_load_device_config_state(const char *name) " (%s)"
+vfio_load_device_config_state_start(const char *name) " (%s)"
+vfio_load_device_config_state_end(const char *name) " (%s)"
 vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
 vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size 0x%"PRIx64" ret %d"
+vfio_load_state_device_buffer_incoming(const char *name, uint32_t idx) " (%s) idx %"PRIu32
+vfio_load_state_device_buffer_start(const char *name) " (%s)"
+vfio_load_state_device_buffer_starved(const char *name, uint32_t idx) " (%s) idx %"PRIu32
+vfio_load_state_device_buffer_load_start(const char *name, uint32_t idx) " (%s) idx %"PRIu32
+vfio_load_state_device_buffer_load_end(const char *name, uint32_t idx) " (%s) idx %"PRIu32
+vfio_load_state_device_buffer_end(const char *name) " (%s)"
 vfio_migration_realize(const char *name) " (%s)"
 vfio_migration_set_device_state(const char *name, const char *state) " (%s) state %s"
 vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 32d58e3e025b..ba5b9464e79a 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -76,6 +76,22 @@ typedef struct VFIOMigration {
 
     bool save_iterate_run;
     bool save_iterate_empty_hit;
+
+    QemuThread load_bufs_thread;
+    Error *load_bufs_thread_errp;
+    bool load_bufs_thread_started;
+    bool load_bufs_thread_finished;
+    bool load_bufs_thread_want_exit;
+
+    GArray *load_bufs;
+    bool load_bufs_device_ready;
+    QemuCond load_bufs_device_ready_cond;
+    QemuCond load_bufs_buffer_ready_cond;
+    QemuMutex load_bufs_mutex;
+    uint32_t load_buf_idx;
+    uint32_t load_buf_idx_last;
+    uint32_t load_buf_queued_pending_buffers;
+    bool config_state_loaded_to_dev;
 } VFIOMigration;
 
 struct VFIOGroup;
@@ -134,6 +150,7 @@ typedef struct VFIODevice {
     bool ram_block_discard_allowed;
     OnOffAuto enable_migration;
     bool migration_events;
+    uint64_t migration_max_queued_buffers;
     VFIODeviceOps *ops;
     unsigned int num_irqs;
     unsigned int num_regions;

