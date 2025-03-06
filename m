Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDC3C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC3U-0002SM-NI; Thu, 06 Mar 2025 09:18:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC1J-0000gR-94
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:16:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC1G-00020d-JC
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZP4TLHbC3WazgKO8vlgr/7iKmqPs2/SyqnCf0Vx7TnA=;
 b=EyraR0I/GHnkdpBpe/ew0sgIj/kAzrcDbkB/xPFtNnJ4/qWbxgwY13gi1v9Wf41ri+XVk7
 l+dz6GZ4nmgBTdcDIpAJyTqXAcsAAkBLvX3BmnjNXh1VcOdFsuxFSI+eWtnWFEBTFoG/3R
 YD9SAX9M828JvxxW4pjBKbDwRkMrI/A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-uZh2R9XTNuyInRZ8rZS4zQ-1; Thu,
 06 Mar 2025 09:16:12 -0500
X-MC-Unique: uZh2R9XTNuyInRZ8rZS4zQ-1
X-Mimecast-MFC-AGG-ID: uZh2R9XTNuyInRZ8rZS4zQ_1741270571
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BD8F1954223; Thu,  6 Mar 2025 14:16:11 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 251CE18009BC; Thu,  6 Mar 2025 14:16:08 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 36/42] vfio/migration: Multifd device state transfer support -
 load thread
Date: Thu,  6 Mar 2025 15:14:12 +0100
Message-ID: <20250306141419.2015340-37-clg@redhat.com>
In-Reply-To: <20250306141419.2015340-1-clg@redhat.com>
References: <20250306141419.2015340-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/9abe612d775aaf42e31646796acd2363c723a57a.1741124640.git.maciej.szmigiero@oracle.com
[ clg: - Reordered savevm_vfio_handlers
       - Added switchover_start documentation ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/devel/migration/vfio.rst |   4 +
 hw/vfio/migration-multifd.h   |   2 +
 hw/vfio/migration-multifd.c   | 226 ++++++++++++++++++++++++++++++++++
 hw/vfio/migration.c           |  12 ++
 hw/vfio/trace-events          |   7 ++
 5 files changed, 251 insertions(+)

diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
index 8b1f28890a0ba708cc1e49d87b16e17a5d8f7c88..d6cf60890c43f2ebf085940a233f8b85a900b6b3 100644
--- a/docs/devel/migration/vfio.rst
+++ b/docs/devel/migration/vfio.rst
@@ -67,6 +67,10 @@ VFIO implements the device hooks for the iterative approach as follows:
 * A ``switchover_ack_needed`` function that checks if the VFIO device uses
   "switchover-ack" migration capability when this capability is enabled.
 
+* A ``switchover_start`` function that in the multifd mode starts a thread that
+  reassembles the multifd received data and loads it in-order into the device.
+  In the non-multifd mode this function is a NOP.
+
 * A ``save_state`` function to save the device config space if it is present.
 
 * A ``save_live_complete_precopy`` function that sets the VFIO device in
diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
index 8c6320fcb484ca9f779e14d4f9d814081d2f760e..f0d28fcef2ea737fc550a34ff266a34848bca67c 100644
--- a/hw/vfio/migration-multifd.h
+++ b/hw/vfio/migration-multifd.h
@@ -23,4 +23,6 @@ bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev);
 bool vfio_multifd_load_state_buffer(void *opaque, char *data, size_t data_size,
                                     Error **errp);
 
+int vfio_multifd_switchover_start(VFIODevice *vbasedev);
+
 #endif
diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index 79df11b7baa991763039b395c34931e796e711b0..2eef27604e4f8f1f4db74d132a4d4bf2906a4cc1 100644
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
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 2cdb92356e0a2afb64109c10536c857b19f7e7c5..815ad8fc93c7155d831838f9ccfcfd1955e588bc 100644
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
@@ -806,6 +817,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
      * Multifd support
      */
     .load_state_buffer = vfio_multifd_load_state_buffer,
+    .switchover_start = vfio_switchover_start,
 };
 
 /* ---------------------------------------------------------------------- */
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 404ea079b25c49fe25f4c9b05f0cde4f0536fdd7..d6b7e34faa392890aad34173b34fd8c8c9df5e84 100644
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
-- 
2.48.1


