Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AACD10F29
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 19:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCkrb-0006Zr-Hg; Sun, 17 Nov 2024 14:23:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkrW-0006HB-6x
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:23:11 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkrT-0005zR-DW
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:23:09 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkrN-00000002GWk-3yMY; Sun, 17 Nov 2024 20:23:01 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 22/24] vfio/migration: Multifd device state transfer
 support - receive side
Date: Sun, 17 Nov 2024 20:20:17 +0100
Message-ID: <0567baf58cd68716d06cbe4db360149322e0cfcc.1731773021.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731773021.git.maciej.szmigiero@oracle.com>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Therefore, each VFIO device state packet carries a header indicating its
position in the stream.

The last such VFIO device state packet should have
VFIO_DEVICE_STATE_CONFIG_STATE flag set and carry the device config state.

Since it's important to finish loading device state transferred via the
main migration channel (via save_live_iterate SaveVMHandler) before
starting loading the data asynchronously transferred via multifd the thread
doing the actual loading of the multifd transferred data is only started
from switchover_start SaveVMHandler.

switchover_start handler is called when MIG_CMD_SWITCHOVER_START
sub-command of QEMU_VM_COMMAND is received via the main migration channel.

This sub-command is only sent after all save_live_iterate data have already
been posted so it is safe to commence loading of the multifd-transferred
device state upon receiving it - loading of save_live_iterate data happens
synchronously in the main migration thread (much like the processing of
MIG_CMD_SWITCHOVER_START) so by the time MIG_CMD_SWITCHOVER_START is
processed all the proceeding data must have already been loaded.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/vfio/migration.c           | 402 ++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c                 |   2 +
 hw/vfio/trace-events          |   6 +
 include/hw/vfio/vfio-common.h |  19 ++
 4 files changed, 429 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 683f2ae98d5e..b54879fe6209 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -15,6 +15,7 @@
 #include <linux/vfio.h>
 #include <sys/ioctl.h>
 
+#include "io/channel-buffer.h"
 #include "sysemu/runstate.h"
 #include "hw/vfio/vfio-common.h"
 #include "migration/misc.h"
@@ -55,6 +56,15 @@
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
@@ -254,6 +264,292 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
     return ret;
 }
 
+typedef struct VFIOStateBuffer {
+    bool is_present;
+    char *data;
+    size_t len;
+} VFIOStateBuffer;
+
+static void vfio_state_buffer_clear(gpointer data)
+{
+    VFIOStateBuffer *lb = data;
+
+    if (!lb->is_present) {
+        return;
+    }
+
+    g_clear_pointer(&lb->data, g_free);
+    lb->is_present = false;
+}
+
+static void vfio_state_buffers_init(VFIOStateBuffers *bufs)
+{
+    bufs->array = g_array_new(FALSE, TRUE, sizeof(VFIOStateBuffer));
+    g_array_set_clear_func(bufs->array, vfio_state_buffer_clear);
+}
+
+static void vfio_state_buffers_destroy(VFIOStateBuffers *bufs)
+{
+    g_clear_pointer(&bufs->array, g_array_unref);
+}
+
+static void vfio_state_buffers_assert_init(VFIOStateBuffers *bufs)
+{
+    assert(bufs->array);
+}
+
+static guint vfio_state_buffers_size_get(VFIOStateBuffers *bufs)
+{
+    return bufs->array->len;
+}
+
+static void vfio_state_buffers_size_set(VFIOStateBuffers *bufs, guint size)
+{
+    g_array_set_size(bufs->array, size);
+}
+
+static VFIOStateBuffer *vfio_state_buffers_at(VFIOStateBuffers *bufs, guint idx)
+{
+    return &g_array_index(bufs->array, VFIOStateBuffer, idx);
+}
+
+static int vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
+                                  Error **errp)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    VFIODeviceStatePacket *packet = (VFIODeviceStatePacket *)data;
+    VFIOStateBuffer *lb;
+
+    /*
+     * Holding BQL here would violate the lock order and can cause
+     * a deadlock once we attempt to lock load_bufs_mutex below.
+     */
+    assert(!bql_locked());
+
+    if (!migration->multifd_transfer) {
+        error_setg(errp,
+                   "got device state packet but not doing multifd transfer");
+        return -1;
+    }
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
+    QEMU_LOCK_GUARD(&migration->load_bufs_mutex);
+
+    /* config state packet should be the last one in the stream */
+    if (packet->flags & VFIO_DEVICE_STATE_CONFIG_STATE) {
+        migration->load_buf_idx_last = packet->idx;
+    }
+
+    vfio_state_buffers_assert_init(&migration->load_bufs);
+    if (packet->idx >= vfio_state_buffers_size_get(&migration->load_bufs)) {
+        vfio_state_buffers_size_set(&migration->load_bufs, packet->idx + 1);
+    }
+
+    lb = vfio_state_buffers_at(&migration->load_bufs, packet->idx);
+    if (lb->is_present) {
+        error_setg(errp, "state buffer %" PRIu32 " already filled",
+                   packet->idx);
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
+    qemu_cond_signal(&migration->load_bufs_buffer_ready_cond);
+
+    return 0;
+}
+
+static int vfio_load_device_config_state(QEMUFile *f, void *opaque);
+
+static int vfio_load_bufs_thread_load_config(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    VFIOStateBuffer *lb;
+    g_autoptr(QIOChannelBuffer) bioc = NULL;
+    QEMUFile *f_out = NULL, *f_in = NULL;
+    uint64_t mig_header;
+    int ret;
+
+    assert(migration->load_buf_idx == migration->load_buf_idx_last);
+    lb = vfio_state_buffers_at(&migration->load_bufs, migration->load_buf_idx);
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
+        g_clear_pointer(&f_out, qemu_fclose);
+        return ret;
+    }
+
+    qio_channel_io_seek(QIO_CHANNEL(bioc), 0, 0, NULL);
+    f_in = qemu_file_new_input(QIO_CHANNEL(bioc));
+
+    mig_header = qemu_get_be64(f_in);
+    if (mig_header != VFIO_MIG_FLAG_DEV_CONFIG_STATE) {
+        g_clear_pointer(&f_out, qemu_fclose);
+        g_clear_pointer(&f_in, qemu_fclose);
+        return -EINVAL;
+    }
+
+    bql_lock();
+    ret = vfio_load_device_config_state(f_in, vbasedev);
+    bql_unlock();
+
+    g_clear_pointer(&f_out, qemu_fclose);
+    g_clear_pointer(&f_in, qemu_fclose);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return 0;
+}
+
+static bool vfio_load_bufs_thread_want_abort(VFIODevice *vbasedev,
+                                             bool *abort_flag)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    return migration->load_bufs_thread_want_exit || qatomic_read(abort_flag);
+}
+
+static int vfio_load_bufs_thread(bool *abort_flag, void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    QEMU_LOCK_GUARD(&migration->load_bufs_mutex);
+    int ret;
+
+    assert(migration->load_bufs_thread_running);
+
+    while (!vfio_load_bufs_thread_want_abort(vbasedev, abort_flag)) {
+        VFIOStateBuffer *lb;
+        guint bufs_len;
+        bool starved;
+
+        assert(migration->load_buf_idx <= migration->load_buf_idx_last);
+
+        bufs_len = vfio_state_buffers_size_get(&migration->load_bufs);
+        if (migration->load_buf_idx >= bufs_len) {
+            assert(migration->load_buf_idx == bufs_len);
+            starved = true;
+        } else {
+            lb = vfio_state_buffers_at(&migration->load_bufs,
+                                       migration->load_buf_idx);
+            starved = !lb->is_present;
+        }
+
+        if (starved) {
+            trace_vfio_load_state_device_buffer_starved(vbasedev->name,
+                                                        migration->load_buf_idx);
+            qemu_cond_wait(&migration->load_bufs_buffer_ready_cond,
+                           &migration->load_bufs_mutex);
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
+            ssize_t wr_ret;
+            int errno_save;
+
+            trace_vfio_load_state_device_buffer_load_start(vbasedev->name,
+                                                           migration->load_buf_idx);
+
+            /* lb might become re-allocated when we drop the lock */
+            buf = g_steal_pointer(&lb->data);
+            buf_len = lb->len;
+
+            /*
+             * Loading data to the device takes a while,
+             * drop the lock during this process.
+             */
+            qemu_mutex_unlock(&migration->load_bufs_mutex);
+            wr_ret = write(migration->data_fd, buf, buf_len);
+            errno_save = errno;
+            qemu_mutex_lock(&migration->load_bufs_mutex);
+
+            if (wr_ret < 0) {
+                ret = -errno_save;
+                goto ret_signal;
+            } else if (wr_ret < buf_len) {
+                ret = -EINVAL;
+                goto ret_signal;
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
+    if (vfio_load_bufs_thread_want_abort(vbasedev, abort_flag)) {
+        ret = -ECANCELED;
+        goto ret_signal;
+    }
+
+    ret = vfio_load_bufs_thread_load_config(vbasedev);
+
+ret_signal:
+    migration->load_bufs_thread_running = false;
+    qemu_cond_signal(&migration->load_bufs_thread_finished_cond);
+
+    return ret;
+}
+
 static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
                                          Error **errp)
 {
@@ -430,6 +726,12 @@ static bool vfio_precopy_supported(VFIODevice *vbasedev)
     return migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
 }
 
+static bool vfio_multifd_transfer_supported(void)
+{
+    return migration_has_device_state_support() &&
+        migrate_send_switchover_start();
+}
+
 /* ---------------------------------------------------------------------- */
 
 static int vfio_save_prepare(void *opaque, Error **errp)
@@ -695,17 +997,73 @@ static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
 
     assert(!migration->load_setup);
 
+    /*
+     * Make a copy of this setting at the start in case it is changed
+     * mid-migration.
+     */
+    if (vbasedev->migration_multifd_transfer == ON_OFF_AUTO_AUTO) {
+        migration->multifd_transfer = vfio_multifd_transfer_supported();
+    } else {
+        migration->multifd_transfer =
+            vbasedev->migration_multifd_transfer == ON_OFF_AUTO_ON;
+    }
+
+    if (migration->multifd_transfer && !vfio_multifd_transfer_supported()) {
+        error_setg(errp,
+                   "%s: Multifd device transfer requested but unsupported in the current config",
+                   vbasedev->name);
+        return -EINVAL;
+    }
+
     ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
                                    migration->device_state, errp);
     if (ret) {
         return ret;
     }
 
+    if (migration->multifd_transfer) {
+        assert(!migration->load_bufs.array);
+        vfio_state_buffers_init(&migration->load_bufs);
+
+        qemu_mutex_init(&migration->load_bufs_mutex);
+
+        migration->load_buf_idx = 0;
+        migration->load_buf_idx_last = UINT32_MAX;
+        migration->load_buf_queued_pending_buffers = 0;
+        qemu_cond_init(&migration->load_bufs_buffer_ready_cond);
+
+        migration->load_bufs_thread_running = false;
+        migration->load_bufs_thread_want_exit = false;
+        qemu_cond_init(&migration->load_bufs_thread_finished_cond);
+    }
+
     migration->load_setup = true;
 
     return 0;
 }
 
+static void vfio_load_cleanup_load_bufs_thread(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
+    bql_unlock();
+    WITH_QEMU_LOCK_GUARD(&migration->load_bufs_mutex) {
+        if (!migration->load_bufs_thread_running) {
+            break;
+        }
+
+        migration->load_bufs_thread_want_exit = true;
+
+        qemu_cond_signal(&migration->load_bufs_buffer_ready_cond);
+        qemu_cond_wait(&migration->load_bufs_thread_finished_cond,
+                       &migration->load_bufs_mutex);
+
+        assert(!migration->load_bufs_thread_running);
+    }
+    bql_lock();
+}
+
 static int vfio_load_cleanup(void *opaque)
 {
     VFIODevice *vbasedev = opaque;
@@ -715,7 +1073,19 @@ static int vfio_load_cleanup(void *opaque)
         return 0;
     }
 
+    if (migration->multifd_transfer) {
+        vfio_load_cleanup_load_bufs_thread(vbasedev);
+    }
+
     vfio_migration_cleanup(vbasedev);
+
+    if (migration->multifd_transfer) {
+        qemu_cond_destroy(&migration->load_bufs_thread_finished_cond);
+        vfio_state_buffers_destroy(&migration->load_bufs);
+        qemu_cond_destroy(&migration->load_bufs_buffer_ready_cond);
+        qemu_mutex_destroy(&migration->load_bufs_mutex);
+    }
+
     migration->load_setup = false;
     trace_vfio_load_cleanup(vbasedev->name);
 
@@ -725,6 +1095,7 @@ static int vfio_load_cleanup(void *opaque)
 static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
 {
     VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
     int ret = 0;
     uint64_t data;
 
@@ -736,6 +1107,12 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
         switch (data) {
         case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
         {
+            if (migration->multifd_transfer) {
+                error_report("%s: got DEV_CONFIG_STATE but doing multifd transfer",
+                             vbasedev->name);
+                return -EINVAL;
+            }
+
             return vfio_load_device_config_state(f, opaque);
         }
         case VFIO_MIG_FLAG_DEV_SETUP_STATE:
@@ -801,6 +1178,29 @@ static bool vfio_switchover_ack_needed(void *opaque)
     return vfio_precopy_supported(vbasedev);
 }
 
+static int vfio_switchover_start(void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+
+    if (!migration->multifd_transfer) {
+        /* Load thread is only used for multifd transfer */
+        return 0;
+    }
+
+    /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
+    bql_unlock();
+    WITH_QEMU_LOCK_GUARD(&migration->load_bufs_mutex) {
+        assert(!migration->load_bufs_thread_running);
+        migration->load_bufs_thread_running = true;
+    }
+    bql_lock();
+
+    qemu_loadvm_start_load_thread(vfio_load_bufs_thread, vbasedev);
+
+    return 0;
+}
+
 static const SaveVMHandlers savevm_vfio_handlers = {
     .save_prepare = vfio_save_prepare,
     .save_setup = vfio_save_setup,
@@ -814,7 +1214,9 @@ static const SaveVMHandlers savevm_vfio_handlers = {
     .load_setup = vfio_load_setup,
     .load_cleanup = vfio_load_cleanup,
     .load_state = vfio_load_state,
+    .load_state_buffer = vfio_load_state_buffer,
     .switchover_ack_needed = vfio_switchover_ack_needed,
+    .switchover_start = vfio_switchover_start,
 };
 
 /* ---------------------------------------------------------------------- */
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9d547cb5cdff..72d62ada8a39 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3384,6 +3384,8 @@ static Property vfio_pci_dev_properties[] = {
                 vbasedev.migration_multifd_transfer,
                 qdev_prop_on_off_auto_mutable, OnOffAuto,
                 .set_default = true, .defval.i = ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_UINT64("x-migration-max-queued-buffers", VFIOPCIDevice,
+                       vbasedev.migration_max_queued_buffers, UINT64_MAX),
     DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
                      vbasedev.migration_events, false),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 1bebe9877d88..418b378ebd29 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -153,6 +153,12 @@ vfio_load_device_config_state_start(const char *name) " (%s)"
 vfio_load_device_config_state_end(const char *name) " (%s)"
 vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
 vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size %"PRIu64" ret %d"
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
index b1c03a82eec8..0954d6981a22 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -61,6 +61,11 @@ typedef struct VFIORegion {
     uint8_t nr; /* cache the region number for debug */
 } VFIORegion;
 
+/* type safety */
+typedef struct VFIOStateBuffers {
+    GArray *array;
+} VFIOStateBuffers;
+
 typedef struct VFIOMigration {
     struct VFIODevice *vbasedev;
     VMChangeStateEntry *vm_state;
@@ -73,10 +78,23 @@ typedef struct VFIOMigration {
     uint64_t mig_flags;
     uint64_t precopy_init_size;
     uint64_t precopy_dirty_size;
+    bool multifd_transfer;
     bool initial_data_sent;
 
     bool event_save_iterate_started;
     bool event_precopy_empty_hit;
+
+    QemuThread load_bufs_thread;
+    bool load_bufs_thread_running;
+    bool load_bufs_thread_want_exit;
+
+    VFIOStateBuffers load_bufs;
+    QemuCond load_bufs_buffer_ready_cond;
+    QemuCond load_bufs_thread_finished_cond;
+    QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
+    uint32_t load_buf_idx;
+    uint32_t load_buf_idx_last;
+    uint32_t load_buf_queued_pending_buffers;
 } VFIOMigration;
 
 struct VFIOGroup;
@@ -136,6 +154,7 @@ typedef struct VFIODevice {
     OnOffAuto enable_migration;
     OnOffAuto migration_multifd_transfer;
     bool migration_events;
+    uint64_t migration_max_queued_buffers;
     VFIODeviceOps *ops;
     unsigned int num_irqs;
     unsigned int num_regions;

