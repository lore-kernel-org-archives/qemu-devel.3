Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC87EC02195
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 10:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdRWi-0008Uc-3U; Thu, 30 Jan 2025 05:12:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRWZ-00086p-4P
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:11:53 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRWX-0007Q1-03
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:11:50 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRWJ-00000006U1W-0Z9E; Thu, 30 Jan 2025 11:11:35 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 28/33] vfio/migration: Multifd device state transfer
 support - load thread
Date: Thu, 30 Jan 2025 11:08:49 +0100
Message-ID: <3e1708a19ab743441a4771a8868043887ea4543c.1738171076.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738171076.git.maciej.szmigiero@oracle.com>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.037, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 hw/vfio/migration.c  | 229 +++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/trace-events |   5 +
 2 files changed, 234 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 0c0caec1bd64..ab5b097f59c9 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -301,8 +301,16 @@ typedef struct VFIOStateBuffer {
 } VFIOStateBuffer;
 
 typedef struct VFIOMultifd {
+    QemuThread load_bufs_thread;
+    bool load_bufs_thread_running;
+    bool load_bufs_thread_want_exit;
+
+    bool load_bufs_iter_done;
+    QemuCond load_bufs_iter_done_cond;
+
     VFIOStateBuffers load_bufs;
     QemuCond load_bufs_buffer_ready_cond;
+    QemuCond load_bufs_thread_finished_cond;
     QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
     uint32_t load_buf_idx;
     uint32_t load_buf_idx_last;
@@ -449,6 +457,171 @@ static bool vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
     return true;
 }
 
+static VFIOStateBuffer *vfio_load_state_buffer_get(VFIOMultifd *multifd)
+{
+    VFIOStateBuffer *lb;
+    guint bufs_len;
+
+    bufs_len = vfio_state_buffers_size_get(&multifd->load_bufs);
+    if (multifd->load_buf_idx >= bufs_len) {
+        assert(multifd->load_buf_idx == bufs_len);
+        return NULL;
+    }
+
+    lb = vfio_state_buffers_at(&multifd->load_bufs,
+                               multifd->load_buf_idx);
+    if (!lb->is_present) {
+        return NULL;
+    }
+
+    return lb;
+}
+
+static int vfio_load_bufs_thread_load_config(VFIODevice *vbasedev)
+{
+    return -EINVAL;
+}
+
+static bool vfio_load_state_buffer_write(VFIODevice *vbasedev,
+                                         VFIOStateBuffer *lb,
+                                         Error **errp)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    VFIOMultifd *multifd = migration->multifd;
+    g_autofree char *buf = NULL;
+    char *buf_cur;
+    size_t buf_len;
+
+    if (!lb->len) {
+        return true;
+    }
+
+    trace_vfio_load_state_device_buffer_load_start(vbasedev->name,
+                                                   multifd->load_buf_idx);
+
+    /* lb might become re-allocated when we drop the lock */
+    buf = g_steal_pointer(&lb->data);
+    buf_cur = buf;
+    buf_len = lb->len;
+    while (buf_len > 0) {
+        ssize_t wr_ret;
+        int errno_save;
+
+        /*
+         * Loading data to the device takes a while,
+         * drop the lock during this process.
+         */
+        qemu_mutex_unlock(&multifd->load_bufs_mutex);
+        wr_ret = write(migration->data_fd, buf_cur, buf_len);
+        errno_save = errno;
+        qemu_mutex_lock(&multifd->load_bufs_mutex);
+
+        if (wr_ret < 0) {
+            error_setg(errp,
+                       "writing state buffer %" PRIu32 " failed: %d",
+                       multifd->load_buf_idx, errno_save);
+            return false;
+        }
+
+        assert(wr_ret <= buf_len);
+        buf_len -= wr_ret;
+        buf_cur += wr_ret;
+    }
+
+    trace_vfio_load_state_device_buffer_load_end(vbasedev->name,
+                                                 multifd->load_buf_idx);
+
+    return true;
+}
+
+static bool vfio_load_bufs_thread_want_abort(VFIOMultifd *multifd,
+                                             bool *should_quit)
+{
+    return multifd->load_bufs_thread_want_exit || qatomic_read(should_quit);
+}
+
+static bool vfio_load_bufs_thread(void *opaque, bool *should_quit, Error **errp)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    VFIOMultifd *multifd = migration->multifd;
+    bool ret = true;
+    int config_ret;
+
+    assert(multifd);
+    QEMU_LOCK_GUARD(&multifd->load_bufs_mutex);
+
+    assert(multifd->load_bufs_thread_running);
+
+    while (!vfio_load_bufs_thread_want_abort(multifd, should_quit)) {
+        VFIOStateBuffer *lb;
+
+        assert(multifd->load_buf_idx <= multifd->load_buf_idx_last);
+
+        lb = vfio_load_state_buffer_get(multifd);
+        if (!lb) {
+            trace_vfio_load_state_device_buffer_starved(vbasedev->name,
+                                                        multifd->load_buf_idx);
+            qemu_cond_wait(&multifd->load_bufs_buffer_ready_cond,
+                           &multifd->load_bufs_mutex);
+            continue;
+        }
+
+        if (multifd->load_buf_idx == multifd->load_buf_idx_last) {
+            break;
+        }
+
+        if (multifd->load_buf_idx == 0) {
+            trace_vfio_load_state_device_buffer_start(vbasedev->name);
+        }
+
+        if (!vfio_load_state_buffer_write(vbasedev, lb, errp)) {
+            ret = false;
+            goto ret_signal;
+        }
+
+        assert(multifd->load_buf_queued_pending_buffers > 0);
+        multifd->load_buf_queued_pending_buffers--;
+
+        if (multifd->load_buf_idx == multifd->load_buf_idx_last - 1) {
+            trace_vfio_load_state_device_buffer_end(vbasedev->name);
+        }
+
+        multifd->load_buf_idx++;
+    }
+
+    if (vfio_load_bufs_thread_want_abort(multifd, should_quit)) {
+        error_setg(errp, "operation cancelled");
+        ret = false;
+        goto ret_signal;
+    }
+
+    if (vfio_load_config_after_iter(vbasedev)) {
+        while (!multifd->load_bufs_iter_done) {
+            qemu_cond_wait(&multifd->load_bufs_iter_done_cond,
+                           &multifd->load_bufs_mutex);
+
+            if (vfio_load_bufs_thread_want_abort(multifd, should_quit)) {
+                error_setg(errp, "operation cancelled");
+                ret = false;
+                goto ret_signal;
+            }
+        }
+    }
+
+    config_ret = vfio_load_bufs_thread_load_config(vbasedev);
+    if (config_ret) {
+        error_setg(errp, "load config state failed: %d", config_ret);
+        ret = false;
+    }
+
+ret_signal:
+    multifd->load_bufs_thread_running = false;
+    qemu_cond_signal(&multifd->load_bufs_thread_finished_cond);
+
+    return ret;
+}
+
 static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
                                          Error **errp)
 {
@@ -517,11 +690,40 @@ static VFIOMultifd *vfio_multifd_new(void)
     multifd->load_buf_queued_pending_buffers = 0;
     qemu_cond_init(&multifd->load_bufs_buffer_ready_cond);
 
+    multifd->load_bufs_iter_done = false;
+    qemu_cond_init(&multifd->load_bufs_iter_done_cond);
+
+    multifd->load_bufs_thread_running = false;
+    multifd->load_bufs_thread_want_exit = false;
+    qemu_cond_init(&multifd->load_bufs_thread_finished_cond);
+
     return multifd;
 }
 
+static void vfio_load_cleanup_load_bufs_thread(VFIOMultifd *multifd)
+{
+    /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
+    bql_unlock();
+    WITH_QEMU_LOCK_GUARD(&multifd->load_bufs_mutex) {
+        while (multifd->load_bufs_thread_running) {
+            multifd->load_bufs_thread_want_exit = true;
+
+            qemu_cond_signal(&multifd->load_bufs_buffer_ready_cond);
+            qemu_cond_signal(&multifd->load_bufs_iter_done_cond);
+            qemu_cond_wait(&multifd->load_bufs_thread_finished_cond,
+                           &multifd->load_bufs_mutex);
+        }
+    }
+    bql_lock();
+}
+
 static void vfio_multifd_free(VFIOMultifd *multifd)
 {
+    vfio_load_cleanup_load_bufs_thread(multifd);
+
+    qemu_cond_destroy(&multifd->load_bufs_thread_finished_cond);
+    qemu_cond_destroy(&multifd->load_bufs_iter_done_cond);
+    vfio_state_buffers_destroy(&multifd->load_bufs);
     qemu_cond_destroy(&multifd->load_bufs_buffer_ready_cond);
     qemu_mutex_destroy(&multifd->load_bufs_mutex);
 
@@ -1042,6 +1244,32 @@ static bool vfio_switchover_ack_needed(void *opaque)
     return vfio_precopy_supported(vbasedev);
 }
 
+static int vfio_switchover_start(void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    VFIOMultifd *multifd = migration->multifd;
+
+    if (!migration->multifd_transfer) {
+        /* Load thread is only used for multifd transfer */
+        return 0;
+    }
+
+    assert(multifd);
+
+    /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
+    bql_unlock();
+    WITH_QEMU_LOCK_GUARD(&multifd->load_bufs_mutex) {
+        assert(!multifd->load_bufs_thread_running);
+        multifd->load_bufs_thread_running = true;
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
@@ -1057,6 +1285,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
     .load_state = vfio_load_state,
     .load_state_buffer = vfio_load_state_buffer,
     .switchover_ack_needed = vfio_switchover_ack_needed,
+    .switchover_start = vfio_switchover_start,
 };
 
 /* ---------------------------------------------------------------------- */
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 042a3dc54a33..418b378ebd29 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -154,6 +154,11 @@ vfio_load_device_config_state_end(const char *name) " (%s)"
 vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
 vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size %"PRIu64" ret %d"
 vfio_load_state_device_buffer_incoming(const char *name, uint32_t idx) " (%s) idx %"PRIu32
+vfio_load_state_device_buffer_start(const char *name) " (%s)"
+vfio_load_state_device_buffer_starved(const char *name, uint32_t idx) " (%s) idx %"PRIu32
+vfio_load_state_device_buffer_load_start(const char *name, uint32_t idx) " (%s) idx %"PRIu32
+vfio_load_state_device_buffer_load_end(const char *name, uint32_t idx) " (%s) idx %"PRIu32
+vfio_load_state_device_buffer_end(const char *name) " (%s)"
 vfio_migration_realize(const char *name) " (%s)"
 vfio_migration_set_device_state(const char *name, const char *state) " (%s) state %s"
 vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"

