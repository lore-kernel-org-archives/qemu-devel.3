Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D453C5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 17:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj0RP-0003YW-RE; Tue, 27 Aug 2024 13:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0Qj-00006n-0W
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:56:33 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0Qg-0001eo-PZ
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:56:32 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0QY-0002Qh-Ai; Tue, 27 Aug 2024 19:56:22 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 17/17] vfio/migration: Multifd device state transfer
 support - send side
Date: Tue, 27 Aug 2024 19:54:36 +0200
Message-ID: <1429fc59079d99ca035b31303892d807868dc6c0.1724701542.git.maciej.szmigiero@oracle.com>
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

Implement the multifd device state transfer via additional per-device
thread inside save_live_complete_precopy_thread handler.

Switch between doing the data transfer in the new handler and doing it
in the old save_state handler depending on the
x-migration-multifd-transfer device property value.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/vfio/migration.c           | 169 ++++++++++++++++++++++++++++++++++
 hw/vfio/trace-events          |   2 +
 include/hw/vfio/vfio-common.h |   1 +
 3 files changed, 172 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 57c1542528dc..67996aa2df8b 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -655,6 +655,16 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
     uint64_t stop_copy_size = VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE;
     int ret;
 
+    /* Make a copy of this setting at the start in case it is changed mid-migration */
+    migration->multifd_transfer = vbasedev->migration_multifd_transfer;
+
+    if (migration->multifd_transfer && !migration_has_device_state_support()) {
+        error_setg(errp,
+                   "%s: Multifd device transfer requested but unsupported in the current config",
+                   vbasedev->name);
+        return -EINVAL;
+    }
+
     qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
 
     vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
@@ -835,10 +845,20 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
 static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
 {
     VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
     ssize_t data_size;
     int ret;
     Error *local_err = NULL;
 
+    if (migration->multifd_transfer) {
+        /*
+         * Emit dummy NOP data, vfio_save_complete_precopy_thread()
+         * does the actual transfer.
+         */
+        qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
+        return 0;
+    }
+
     trace_vfio_save_complete_precopy_started(vbasedev->name);
 
     /* We reach here with device state STOP or STOP_COPY only */
@@ -864,12 +884,159 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
     return ret;
 }
 
+static int vfio_save_complete_precopy_async_thread_config_state(VFIODevice *vbasedev,
+                                                                char *idstr,
+                                                                uint32_t instance_id,
+                                                                uint32_t idx)
+{
+    g_autoptr(QIOChannelBuffer) bioc = NULL;
+    QEMUFile *f = NULL;
+    int ret;
+    g_autofree VFIODeviceStatePacket *packet = NULL;
+    size_t packet_len;
+
+    bioc = qio_channel_buffer_new(0);
+    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-save");
+
+    f = qemu_file_new_output(QIO_CHANNEL(bioc));
+
+    ret = vfio_save_device_config_state(f, vbasedev, NULL);
+    if (ret) {
+        return ret;
+    }
+
+    ret = qemu_fflush(f);
+    if (ret) {
+        goto ret_close_file;
+    }
+
+    packet_len = sizeof(*packet) + bioc->usage;
+    packet = g_malloc0(packet_len);
+    packet->idx = idx;
+    packet->flags = VFIO_DEVICE_STATE_CONFIG_STATE;
+    memcpy(&packet->data, bioc->data, bioc->usage);
+
+    if (!multifd_queue_device_state(idstr, instance_id,
+                                    (char *)packet, packet_len)) {
+        ret = -1;
+    }
+
+    bytes_transferred += packet_len;
+
+ret_close_file:
+    g_clear_pointer(&f, qemu_fclose);
+    return ret;
+}
+
+static int vfio_save_complete_precopy_thread(char *idstr,
+                                             uint32_t instance_id,
+                                             bool *abort_flag,
+                                             void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    int ret;
+    g_autofree VFIODeviceStatePacket *packet = NULL;
+    uint32_t idx;
+
+    if (!migration->multifd_transfer) {
+        /* Nothing to do, vfio_save_complete_precopy() does the transfer. */
+        return 0;
+    }
+
+    trace_vfio_save_complete_precopy_thread_started(vbasedev->name,
+                                                    idstr, instance_id);
+
+    /* We reach here with device state STOP or STOP_COPY only */
+    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
+                                   VFIO_DEVICE_STATE_STOP, NULL);
+    if (ret) {
+        goto ret_finish;
+    }
+
+    packet = g_malloc0(sizeof(*packet) + migration->data_buffer_size);
+
+    for (idx = 0; ; idx++) {
+        ssize_t data_size;
+        size_t packet_size;
+
+        if (qatomic_read(abort_flag)) {
+            ret = -ECANCELED;
+            goto ret_finish;
+        }
+
+        data_size = read(migration->data_fd, &packet->data,
+                         migration->data_buffer_size);
+        if (data_size < 0) {
+            if (errno != ENOMSG) {
+                ret = -errno;
+                goto ret_finish;
+            }
+
+            /*
+             * Pre-copy emptied all the device state for now. For more information,
+             * please refer to the Linux kernel VFIO uAPI.
+             */
+            data_size = 0;
+        }
+
+        if (data_size == 0)
+            break;
+
+        packet->idx = idx;
+        packet_size = sizeof(*packet) + data_size;
+
+        if (!multifd_queue_device_state(idstr, instance_id,
+                                        (char *)packet, packet_size)) {
+            ret = -1;
+            goto ret_finish;
+        }
+
+        bytes_transferred += packet_size;
+    }
+
+    ret = vfio_save_complete_precopy_async_thread_config_state(vbasedev, idstr,
+                                                               instance_id,
+                                                               idx);
+
+ret_finish:
+    trace_vfio_save_complete_precopy_thread_finished(vbasedev->name, ret);
+
+    return ret;
+}
+
+static int vfio_save_complete_precopy_begin(QEMUFile *f,
+                                            char *idstr, uint32_t instance_id,
+                                            void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+
+    if (!migration->multifd_transfer) {
+        /* Emit dummy NOP data */
+        qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
+        return 0;
+    }
+
+    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE_COMPLETE);
+    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
+
+    return qemu_fflush(f);
+}
+
 static void vfio_save_state(QEMUFile *f, void *opaque)
 {
     VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
     Error *local_err = NULL;
     int ret;
 
+    if (migration->multifd_transfer) {
+        /* Emit dummy NOP data */
+        qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
+        return;
+    }
+
     ret = vfio_save_device_config_state(f, opaque, &local_err);
     if (ret) {
         error_prepend(&local_err,
@@ -1119,7 +1286,9 @@ static const SaveVMHandlers savevm_vfio_handlers = {
     .state_pending_exact = vfio_state_pending_exact,
     .is_active_iterate = vfio_is_active_iterate,
     .save_live_iterate = vfio_save_iterate,
+    .save_live_complete_precopy_begin = vfio_save_complete_precopy_begin,
     .save_live_complete_precopy = vfio_save_complete_precopy,
+    .save_live_complete_precopy_thread = vfio_save_complete_precopy_thread,
     .save_state = vfio_save_state,
     .load_setup = vfio_load_setup,
     .load_cleanup = vfio_load_cleanup,
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 9d2519a28a7e..b1d9c9d5f2e1 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -167,6 +167,8 @@ vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
 vfio_save_cleanup(const char *name) " (%s)"
 vfio_save_complete_precopy(const char *name, int ret) " (%s) ret %d"
 vfio_save_complete_precopy_started(const char *name) " (%s)"
+vfio_save_complete_precopy_thread_started(const char *name, const char *idstr, uint32_t instance_id) " (%s) idstr %s instance %"PRIu32
+vfio_save_complete_precopy_thread_finished(const char *name, int ret) " (%s) ret %d"
 vfio_save_device_config_state(const char *name) " (%s)"
 vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
 vfio_save_iterate_started(const char *name) " (%s)"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index fe05acb9a5d1..4578a0ca6a5c 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -72,6 +72,7 @@ typedef struct VFIOMigration {
     uint64_t mig_flags;
     uint64_t precopy_init_size;
     uint64_t precopy_dirty_size;
+    bool multifd_transfer;
     bool initial_data_sent;
 
     bool save_iterate_run;

