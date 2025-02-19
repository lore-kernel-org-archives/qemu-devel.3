Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818D4C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 20:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkqov-0000ns-Qz; Wed, 19 Feb 2025 15:37:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tkqok-0000YC-Oc
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 15:37:20 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tkqoi-0004sW-KY
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 15:37:14 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tkqoU-00000007VWJ-416n; Wed, 19 Feb 2025 21:36:58 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v5 30/36] vfio/migration: Multifd device state transfer
 support - send side
Date: Wed, 19 Feb 2025 21:34:12 +0100
Message-ID: <608c869621ffe1688e08af98a373c33376487d53.1739994627.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739994627.git.maciej.szmigiero@oracle.com>
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
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

Implement the multifd device state transfer via additional per-device
thread inside save_live_complete_precopy_thread handler.

Switch between doing the data transfer in the new handler and doing it
in the old save_state handler depending on the
x-migration-multifd-transfer device property value.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/vfio/migration-multifd.c   | 139 ++++++++++++++++++++++++++++++++++
 hw/vfio/migration-multifd.h   |   5 ++
 hw/vfio/migration.c           |  26 +++++--
 hw/vfio/trace-events          |   2 +
 include/hw/vfio/vfio-common.h |   8 ++
 5 files changed, 174 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index 7200f6f1c2a2..0cfa9d31732a 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -476,6 +476,145 @@ bool vfio_multifd_transfer_setup(VFIODevice *vbasedev, Error **errp)
     return true;
 }
 
+void vfio_multifd_emit_dummy_eos(VFIODevice *vbasedev, QEMUFile *f)
+{
+    assert(vfio_multifd_transfer_enabled(vbasedev));
+
+    /*
+     * Emit dummy NOP data on the main migration channel since the actual
+     * device state transfer is done via multifd channels.
+     */
+    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
+}
+
+static bool
+vfio_save_complete_precopy_thread_config_state(VFIODevice *vbasedev,
+                                               char *idstr,
+                                               uint32_t instance_id,
+                                               uint32_t idx,
+                                               Error **errp)
+{
+    g_autoptr(QIOChannelBuffer) bioc = NULL;
+    g_autoptr(QEMUFile) f = NULL;
+    int ret;
+    g_autofree VFIODeviceStatePacket *packet = NULL;
+    size_t packet_len;
+
+    bioc = qio_channel_buffer_new(0);
+    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-save");
+
+    f = qemu_file_new_output(QIO_CHANNEL(bioc));
+
+    if (vfio_save_device_config_state(f, vbasedev, errp)) {
+        return false;
+    }
+
+    ret = qemu_fflush(f);
+    if (ret) {
+        error_setg(errp, "save config state flush failed: %d", ret);
+        return false;
+    }
+
+    packet_len = sizeof(*packet) + bioc->usage;
+    packet = g_malloc0(packet_len);
+    packet->version = VFIO_DEVICE_STATE_PACKET_VER_CURRENT;
+    packet->idx = idx;
+    packet->flags = VFIO_DEVICE_STATE_CONFIG_STATE;
+    memcpy(&packet->data, bioc->data, bioc->usage);
+
+    if (!multifd_queue_device_state(idstr, instance_id,
+                                    (char *)packet, packet_len)) {
+        error_setg(errp, "multifd config data queuing failed");
+        return false;
+    }
+
+    vfio_add_bytes_transferred(packet_len);
+
+    return true;
+}
+
+/*
+ * This thread is spawned by the migration core directly via
+ * .save_live_complete_precopy_thread SaveVMHandler.
+ *
+ * It exits after either:
+ * * completing saving the remaining device state and device config, OR:
+ * * encountering some error while doing the above, OR:
+ * * being forcefully aborted by the migration core by
+ *   multifd_device_state_save_thread_should_exit() returning true.
+ */
+bool vfio_save_complete_precopy_thread(SaveLiveCompletePrecopyThreadData *d,
+                                       Error **errp)
+{
+    VFIODevice *vbasedev = d->handler_opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    bool ret;
+    g_autofree VFIODeviceStatePacket *packet = NULL;
+    uint32_t idx;
+
+    if (!vfio_multifd_transfer_enabled(vbasedev)) {
+        /* Nothing to do, vfio_save_complete_precopy() does the transfer. */
+        return true;
+    }
+
+    trace_vfio_save_complete_precopy_thread_start(vbasedev->name,
+                                                  d->idstr, d->instance_id);
+
+    /* We reach here with device state STOP or STOP_COPY only */
+    if (vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
+                                 VFIO_DEVICE_STATE_STOP, errp)) {
+        ret = false;
+        goto ret_finish;
+    }
+
+    packet = g_malloc0(sizeof(*packet) + migration->data_buffer_size);
+    packet->version = VFIO_DEVICE_STATE_PACKET_VER_CURRENT;
+
+    for (idx = 0; ; idx++) {
+        ssize_t data_size;
+        size_t packet_size;
+
+        if (multifd_device_state_save_thread_should_exit()) {
+            error_setg(errp, "operation cancelled");
+            ret = false;
+            goto ret_finish;
+        }
+
+        data_size = read(migration->data_fd, &packet->data,
+                         migration->data_buffer_size);
+        if (data_size < 0) {
+            error_setg(errp, "reading state buffer %" PRIu32 " failed: %d",
+                       idx, errno);
+            ret = false;
+            goto ret_finish;
+        } else if (data_size == 0) {
+            break;
+        }
+
+        packet->idx = idx;
+        packet_size = sizeof(*packet) + data_size;
+
+        if (!multifd_queue_device_state(d->idstr, d->instance_id,
+                                        (char *)packet, packet_size)) {
+            error_setg(errp, "multifd data queuing failed");
+            ret = false;
+            goto ret_finish;
+        }
+
+        vfio_add_bytes_transferred(packet_size);
+    }
+
+    ret = vfio_save_complete_precopy_thread_config_state(vbasedev,
+                                                         d->idstr,
+                                                         d->instance_id,
+                                                         idx, errp);
+
+ret_finish:
+    trace_vfio_save_complete_precopy_thread_end(vbasedev->name, ret);
+
+    return ret;
+}
+
 int vfio_multifd_switchover_start(VFIODevice *vbasedev)
 {
     VFIOMigration *migration = vbasedev->migration;
diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
index 09cbb437d9d1..79780d7b5392 100644
--- a/hw/vfio/migration-multifd.h
+++ b/hw/vfio/migration-multifd.h
@@ -25,6 +25,11 @@ bool vfio_multifd_transfer_setup(VFIODevice *vbasedev, Error **errp);
 bool vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
                             Error **errp);
 
+void vfio_multifd_emit_dummy_eos(VFIODevice *vbasedev, QEMUFile *f);
+
+bool vfio_save_complete_precopy_thread(SaveLiveCompletePrecopyThreadData *d,
+                                       Error **errp);
+
 int vfio_multifd_switchover_start(VFIODevice *vbasedev);
 
 #endif
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index b962309f7c27..69dcf2dac2fa 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -120,10 +120,10 @@ static void vfio_migration_set_device_state(VFIODevice *vbasedev,
     vfio_migration_send_event(vbasedev);
 }
 
-static int vfio_migration_set_state(VFIODevice *vbasedev,
-                                    enum vfio_device_mig_state new_state,
-                                    enum vfio_device_mig_state recover_state,
-                                    Error **errp)
+int vfio_migration_set_state(VFIODevice *vbasedev,
+                             enum vfio_device_mig_state new_state,
+                             enum vfio_device_mig_state recover_state,
+                             Error **errp)
 {
     VFIOMigration *migration = vbasedev->migration;
     uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
@@ -238,8 +238,7 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
     return ret;
 }
 
-static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
-                                         Error **errp)
+int vfio_save_device_config_state(QEMUFile *f, void *opaque, Error **errp)
 {
     VFIODevice *vbasedev = opaque;
     int ret;
@@ -453,6 +452,10 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
     uint64_t stop_copy_size = VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE;
     int ret;
 
+    if (!vfio_multifd_transfer_setup(vbasedev, errp)) {
+        return -EINVAL;
+    }
+
     qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
 
     vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
@@ -631,6 +634,11 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
     int ret;
     Error *local_err = NULL;
 
+    if (vfio_multifd_transfer_enabled(vbasedev)) {
+        vfio_multifd_emit_dummy_eos(vbasedev, f);
+        return 0;
+    }
+
     trace_vfio_save_complete_precopy_start(vbasedev->name);
 
     /* We reach here with device state STOP or STOP_COPY only */
@@ -662,6 +670,11 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
     Error *local_err = NULL;
     int ret;
 
+    if (vfio_multifd_transfer_enabled(vbasedev)) {
+        vfio_multifd_emit_dummy_eos(vbasedev, f);
+        return;
+    }
+
     ret = vfio_save_device_config_state(f, opaque, &local_err);
     if (ret) {
         error_prepend(&local_err,
@@ -819,6 +832,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
     .is_active_iterate = vfio_is_active_iterate,
     .save_live_iterate = vfio_save_iterate,
     .save_live_complete_precopy = vfio_save_complete_precopy,
+    .save_live_complete_precopy_thread = vfio_save_complete_precopy_thread,
     .save_state = vfio_save_state,
     .load_setup = vfio_load_setup,
     .load_cleanup = vfio_load_cleanup,
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 418b378ebd29..039979bdd98f 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -168,6 +168,8 @@ vfio_save_block_precopy_empty_hit(const char *name) " (%s)"
 vfio_save_cleanup(const char *name) " (%s)"
 vfio_save_complete_precopy(const char *name, int ret) " (%s) ret %d"
 vfio_save_complete_precopy_start(const char *name) " (%s)"
+vfio_save_complete_precopy_thread_start(const char *name, const char *idstr, uint32_t instance_id) " (%s) idstr %s instance %"PRIu32
+vfio_save_complete_precopy_thread_end(const char *name, int ret) " (%s) ret %d"
 vfio_save_device_config_state(const char *name) " (%s)"
 vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size %"PRIu64" precopy dirty size %"PRIu64
 vfio_save_iterate_start(const char *name) " (%s)"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index ce2bdea8a2c2..ba851917f9fc 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -298,6 +298,14 @@ void vfio_add_bytes_transferred(unsigned long val);
 bool vfio_device_state_is_running(VFIODevice *vbasedev);
 bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
 
+#ifdef CONFIG_LINUX
+int vfio_migration_set_state(VFIODevice *vbasedev,
+                             enum vfio_device_mig_state new_state,
+                             enum vfio_device_mig_state recover_state,
+                             Error **errp);
+#endif
+
+int vfio_save_device_config_state(QEMUFile *f, void *opaque, Error **errp);
 int vfio_load_device_config_state(QEMUFile *f, void *opaque);
 
 #ifdef CONFIG_LINUX

