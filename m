Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F18C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 23:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpbEX-0002yL-IL; Tue, 04 Mar 2025 17:59:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpbES-0002vY-O3
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:59:25 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpbEQ-00074U-Im
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:59:24 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaQ5-00000000LbM-0DR0; Tue, 04 Mar 2025 23:07:21 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v6 30/36] vfio/migration: Multifd device state transfer
 support - send side
Date: Tue,  4 Mar 2025 23:03:57 +0100
Message-ID: <4d727e2e0435e0022d50004e474077632830e08d.1741124640.git.maciej.szmigiero@oracle.com>
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

Implement the multifd device state transfer via additional per-device
thread inside save_live_complete_precopy_thread handler.

Switch between doing the data transfer in the new handler and doing it
in the old save_state handler depending if VFIO multifd transfer is enabled
or not.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/vfio/migration-multifd.c   | 142 ++++++++++++++++++++++++++++++++++
 hw/vfio/migration-multifd.h   |   6 ++
 hw/vfio/migration.c           |  22 ++++--
 hw/vfio/trace-events          |   2 +
 include/hw/vfio/vfio-common.h |   6 ++
 5 files changed, 172 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index 1d81233c755f..bfb9a72fa450 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -496,6 +496,148 @@ bool vfio_multifd_setup(VFIODevice *vbasedev, bool alloc_multifd, Error **errp)
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
+        error_setg(errp, "%s: save config state flush failed: %d",
+                   vbasedev->name, ret);
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
+        error_setg(errp, "%s: multifd config data queuing failed",
+                   vbasedev->name);
+        return false;
+    }
+
+    vfio_mig_add_bytes_transferred(packet_len);
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
+bool
+vfio_multifd_save_complete_precopy_thread(SaveLiveCompletePrecopyThreadData *d,
+                                          Error **errp)
+{
+    VFIODevice *vbasedev = d->handler_opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    bool ret = false;
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
+        goto thread_exit;
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
+            goto thread_exit;
+        }
+
+        data_size = read(migration->data_fd, &packet->data,
+                         migration->data_buffer_size);
+        if (data_size < 0) {
+            error_setg(errp, "%s: reading state buffer %" PRIu32 " failed: %d",
+                       vbasedev->name, idx, errno);
+            goto thread_exit;
+        } else if (data_size == 0) {
+            break;
+        }
+
+        packet->idx = idx;
+        packet_size = sizeof(*packet) + data_size;
+
+        if (!multifd_queue_device_state(d->idstr, d->instance_id,
+                                        (char *)packet, packet_size)) {
+            error_setg(errp, "%s: multifd data queuing failed", vbasedev->name);
+            goto thread_exit;
+        }
+
+        vfio_mig_add_bytes_transferred(packet_size);
+    }
+
+    if (!vfio_save_complete_precopy_thread_config_state(vbasedev,
+                                                        d->idstr,
+                                                        d->instance_id,
+                                                        idx, errp)) {
+        goto thread_exit;
+   }
+
+    ret = true;
+
+thread_exit:
+    trace_vfio_save_complete_precopy_thread_end(vbasedev->name, ret);
+
+    return ret;
+}
+
 int vfio_multifd_switchover_start(VFIODevice *vbasedev)
 {
     VFIOMigration *migration = vbasedev->migration;
diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
index f0d28fcef2ea..a664051eb8ae 100644
--- a/hw/vfio/migration-multifd.h
+++ b/hw/vfio/migration-multifd.h
@@ -23,6 +23,12 @@ bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev);
 bool vfio_multifd_load_state_buffer(void *opaque, char *data, size_t data_size,
                                     Error **errp);
 
+void vfio_multifd_emit_dummy_eos(VFIODevice *vbasedev, QEMUFile *f);
+
+bool
+vfio_multifd_save_complete_precopy_thread(SaveLiveCompletePrecopyThreadData *d,
+                                          Error **errp);
+
 int vfio_multifd_switchover_start(VFIODevice *vbasedev);
 
 #endif
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index f325a619c3ed..24bdc9e24c71 100644
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
@@ -638,6 +637,11 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
     int ret;
     Error *local_err = NULL;
 
+    if (vfio_multifd_transfer_enabled(vbasedev)) {
+        vfio_multifd_emit_dummy_eos(vbasedev, f);
+        return 0;
+    }
+
     trace_vfio_save_complete_precopy_start(vbasedev->name);
 
     /* We reach here with device state STOP or STOP_COPY only */
@@ -669,6 +673,11 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
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
@@ -815,6 +824,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
     .is_active_iterate = vfio_is_active_iterate,
     .save_live_iterate = vfio_save_iterate,
     .save_live_complete_precopy = vfio_save_complete_precopy,
+    .save_live_complete_precopy_thread = vfio_multifd_save_complete_precopy_thread,
     .save_state = vfio_save_state,
     .load_setup = vfio_load_setup,
     .load_cleanup = vfio_load_cleanup,
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index d6b7e34faa39..9347e3a5f660 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -171,6 +171,8 @@ vfio_save_block_precopy_empty_hit(const char *name) " (%s)"
 vfio_save_cleanup(const char *name) " (%s)"
 vfio_save_complete_precopy(const char *name, int ret) " (%s) ret %d"
 vfio_save_complete_precopy_start(const char *name) " (%s)"
+vfio_save_complete_precopy_thread_start(const char *name, const char *idstr, uint32_t instance_id) " (%s) idstr %s instance %"PRIu32
+vfio_save_complete_precopy_thread_end(const char *name, int ret) " (%s) ret %d"
 vfio_save_device_config_state(const char *name) " (%s)"
 vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size %"PRIu64" precopy dirty size %"PRIu64
 vfio_save_iterate_start(const char *name) " (%s)"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 9d72ac1eae8a..961931d9f457 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -298,6 +298,7 @@ void vfio_mig_add_bytes_transferred(unsigned long val);
 bool vfio_device_state_is_running(VFIODevice *vbasedev);
 bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
 
+int vfio_save_device_config_state(QEMUFile *f, void *opaque, Error **errp);
 int vfio_load_device_config_state(QEMUFile *f, void *opaque);
 
 #ifdef CONFIG_LINUX
@@ -314,6 +315,11 @@ struct vfio_info_cap_header *
 vfio_get_device_info_cap(struct vfio_device_info *info, uint16_t id);
 struct vfio_info_cap_header *
 vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id);
+
+int vfio_migration_set_state(VFIODevice *vbasedev,
+                             enum vfio_device_mig_state new_state,
+                             enum vfio_device_mig_state recover_state,
+                             Error **errp);
 #endif
 
 bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);

