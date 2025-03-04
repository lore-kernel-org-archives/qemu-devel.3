Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D13C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpbES-0002uk-3Z; Tue, 04 Mar 2025 17:59:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpbEQ-0002u4-2g
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:59:22 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpbEN-00074U-GK
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:59:21 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaPp-00000000Lar-2q30; Tue, 04 Mar 2025 23:07:05 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v6 27/36] vfio/migration: Multifd device state transfer
 support - load thread
Date: Tue,  4 Mar 2025 23:03:54 +0100
Message-ID: <9abe612d775aaf42e31646796acd2363c723a57a.1741124640.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741124640.git.maciej.szmigiero@oracle.com>
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Add a thread which loads the VFIO device state buffers that were received
via multifd.

Each VFIO device that has multifd device state transfer enabled has one
such thread, which is created using migration core API
qemu_loadvm_start_load_thread().

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
 hw/vfio/migration-multifd.c | 226 ++++++++++++++++++++++++++++++++++++
 hw/vfio/migration-multifd.h |   2 +
 hw/vfio/migration.c         |  12 ++
 hw/vfio/trace-events        |   7 ++
 4 files changed, 247 insertions(+)

diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index 79df11b7baa9..2eef27604e4f 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -44,8 +44,12 @@ typedef struct VFIOStateBuffer {
 } VFIOStateBuffer;
 
 typedef struct VFIOMultifd {
+    bool load_bufs_thread_running;
+    bool load_bufs_thread_want_exit;
+
     VFIOStateBuffers load_bufs;
     QemuCond load_bufs_buffer_ready_cond;
+    QemuCond load_bufs_thread_finished_cond;
     QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
     uint32_t load_buf_idx;
     uint32_t load_buf_idx_last;
@@ -186,6 +190,178 @@ bool vfio_multifd_load_state_buffer(void *opaque, char *data, size_t data_size,
     return true;
 }
 
+static bool vfio_load_bufs_thread_load_config(VFIODevice *vbasedev,
+                                              Error **errp)
+{
+    error_setg(errp, "not yet there");
+    return false;
+}
+
+static VFIOStateBuffer *vfio_load_state_buffer_get(VFIOMultifd *multifd)
+{
+    VFIOStateBuffer *lb;
+    unsigned int bufs_len;
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
+                       "%s: writing state buffer %" PRIu32 " failed: %d",
+                       vbasedev->name, multifd->load_buf_idx, errno_save);
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
+static bool vfio_load_bufs_thread_want_exit(VFIOMultifd *multifd,
+                                            bool *should_quit)
+{
+    return multifd->load_bufs_thread_want_exit || qatomic_read(should_quit);
+}
+
+/*
+ * This thread is spawned by vfio_multifd_switchover_start() which gets
+ * called upon encountering the switchover point marker in main migration
+ * stream.
+ *
+ * It exits after either:
+ * * completing loading the remaining device state and device config, OR:
+ * * encountering some error while doing the above, OR:
+ * * being forcefully aborted by the migration core by it setting should_quit
+ *   or by vfio_load_cleanup_load_bufs_thread() setting
+ *   multifd->load_bufs_thread_want_exit.
+ */
+static bool vfio_load_bufs_thread(void *opaque, bool *should_quit, Error **errp)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    VFIOMultifd *multifd = migration->multifd;
+    bool ret = false;
+
+    trace_vfio_load_bufs_thread_start(vbasedev->name);
+
+    assert(multifd);
+    QEMU_LOCK_GUARD(&multifd->load_bufs_mutex);
+
+    assert(multifd->load_bufs_thread_running);
+
+    while (true) {
+        VFIOStateBuffer *lb;
+
+        /*
+         * Always check cancellation first after the buffer_ready wait below in
+         * case that cond was signalled by vfio_load_cleanup_load_bufs_thread().
+         */
+        if (vfio_load_bufs_thread_want_exit(multifd, should_quit)) {
+            error_setg(errp, "operation cancelled");
+            goto thread_exit;
+        }
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
+            goto thread_exit;
+        }
+
+        if (multifd->load_buf_idx == multifd->load_buf_idx_last - 1) {
+            trace_vfio_load_state_device_buffer_end(vbasedev->name);
+        }
+
+        multifd->load_buf_idx++;
+    }
+
+    if (!vfio_load_bufs_thread_load_config(vbasedev, errp)) {
+        goto thread_exit;
+    }
+
+    ret = true;
+
+thread_exit:
+    /*
+     * Notify possibly waiting vfio_load_cleanup_load_bufs_thread() that
+     * this thread is exiting.
+     */
+    multifd->load_bufs_thread_running = false;
+    qemu_cond_signal(&multifd->load_bufs_thread_finished_cond);
+
+    trace_vfio_load_bufs_thread_end(vbasedev->name);
+
+    return ret;
+}
+
 static VFIOMultifd *vfio_multifd_new(void)
 {
     VFIOMultifd *multifd = g_new(VFIOMultifd, 1);
@@ -198,11 +374,41 @@ static VFIOMultifd *vfio_multifd_new(void)
     multifd->load_buf_idx_last = UINT32_MAX;
     qemu_cond_init(&multifd->load_bufs_buffer_ready_cond);
 
+    multifd->load_bufs_thread_running = false;
+    multifd->load_bufs_thread_want_exit = false;
+    qemu_cond_init(&multifd->load_bufs_thread_finished_cond);
+
     return multifd;
 }
 
+/*
+ * Terminates vfio_load_bufs_thread by setting
+ * multifd->load_bufs_thread_want_exit and signalling all the conditions
+ * the thread could be blocked on.
+ *
+ * Waits for the thread to signal that it had finished.
+ */
+static void vfio_load_cleanup_load_bufs_thread(VFIOMultifd *multifd)
+{
+    /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
+    bql_unlock();
+    WITH_QEMU_LOCK_GUARD(&multifd->load_bufs_mutex) {
+        while (multifd->load_bufs_thread_running) {
+            multifd->load_bufs_thread_want_exit = true;
+
+            qemu_cond_signal(&multifd->load_bufs_buffer_ready_cond);
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
     vfio_state_buffers_destroy(&multifd->load_bufs);
     qemu_cond_destroy(&multifd->load_bufs_buffer_ready_cond);
     qemu_mutex_destroy(&multifd->load_bufs_mutex);
@@ -244,3 +450,23 @@ bool vfio_multifd_setup(VFIODevice *vbasedev, bool alloc_multifd, Error **errp)
 
     return true;
 }
+
+int vfio_multifd_switchover_start(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    VFIOMultifd *multifd = migration->multifd;
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
diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
index 8c6320fcb484..f0d28fcef2ea 100644
--- a/hw/vfio/migration-multifd.h
+++ b/hw/vfio/migration-multifd.h
@@ -23,4 +23,6 @@ bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev);
 bool vfio_multifd_load_state_buffer(void *opaque, char *data, size_t data_size,
                                     Error **errp);
 
+int vfio_multifd_switchover_start(VFIODevice *vbasedev);
+
 #endif
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index ecc4ee940567..0096344f74f9 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -788,6 +788,17 @@ static bool vfio_switchover_ack_needed(void *opaque)
     return vfio_precopy_supported(vbasedev);
 }
 
+static int vfio_switchover_start(void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+
+    if (vfio_multifd_transfer_enabled(vbasedev)) {
+        return vfio_multifd_switchover_start(vbasedev);
+    }
+
+    return 0;
+}
+
 static const SaveVMHandlers savevm_vfio_handlers = {
     .save_prepare = vfio_save_prepare,
     .save_setup = vfio_save_setup,
@@ -803,6 +814,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
     .load_state = vfio_load_state,
     .load_state_buffer = vfio_multifd_load_state_buffer,
     .switchover_ack_needed = vfio_switchover_ack_needed,
+    .switchover_start = vfio_switchover_start,
 };
 
 /* ---------------------------------------------------------------------- */
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 404ea079b25c..d6b7e34faa39 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -149,12 +149,19 @@ vfio_display_edid_update(uint32_t prefx, uint32_t prefy) "%ux%u"
 vfio_display_edid_write_error(void) ""
 
 # migration.c
+vfio_load_bufs_thread_start(const char *name) " (%s)"
+vfio_load_bufs_thread_end(const char *name) " (%s)"
 vfio_load_cleanup(const char *name) " (%s)"
 vfio_load_device_config_state_start(const char *name) " (%s)"
 vfio_load_device_config_state_end(const char *name) " (%s)"
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

