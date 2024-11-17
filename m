Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15742D10F26
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 19:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCkrq-0007ap-WB; Sun, 17 Nov 2024 14:23:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkrn-0007Mw-9P
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:23:27 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkrl-000609-Bv
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:23:26 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkrY-00000002GX6-11Vn; Sun, 17 Nov 2024 20:23:12 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 24/24] vfio/migration: Multifd device state transfer
 support - send side
Date: Sun, 17 Nov 2024 20:20:19 +0100
Message-ID: <4f5c33b97be09fcb4e1885073e31c5e930a39ad0.1731773021.git.maciej.szmigiero@oracle.com>
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

Implement the multifd device state transfer via additional per-device
thread inside save_live_complete_precopy_thread handler.

Switch between doing the data transfer in the new handler and doing it
in the old save_state handler depending on the
x-migration-multifd-transfer device property value.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/vfio/migration.c  | 155 +++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/trace-events |   2 +
 2 files changed, 157 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index b54879fe6209..8709672ada48 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -771,6 +771,24 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
     uint64_t stop_copy_size = VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE;
     int ret;
 
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
     qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
 
     vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
@@ -942,13 +960,32 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
     return !migration->precopy_init_size && !migration->precopy_dirty_size;
 }
 
+static void vfio_save_multifd_emit_dummy_eos(VFIODevice *vbasedev, QEMUFile *f)
+{
+    VFIOMigration *migration = vbasedev->migration;
+
+    assert(migration->multifd_transfer);
+
+    /*
+     * Emit dummy NOP data on the main migration channel since the actual
+     * device state transfer is done via multifd channels.
+     */
+    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
+}
+
 static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
 {
     VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
     ssize_t data_size;
     int ret;
     Error *local_err = NULL;
 
+    if (migration->multifd_transfer) {
+        vfio_save_multifd_emit_dummy_eos(vbasedev, f);
+        return 0;
+    }
+
     trace_vfio_save_complete_precopy_start(vbasedev->name);
 
     /* We reach here with device state STOP or STOP_COPY only */
@@ -974,12 +1011,129 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
     return ret;
 }
 
+static int
+vfio_save_complete_precopy_async_thread_config_state(VFIODevice *vbasedev,
+                                                     char *idstr,
+                                                     uint32_t instance_id,
+                                                     uint32_t idx)
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
+    ret = vfio_save_device_config_state(f, vbasedev, NULL);
+    if (ret) {
+        return ret;
+    }
+
+    ret = qemu_fflush(f);
+    if (ret) {
+        return ret;
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
+        return -1;
+    }
+
+    qatomic_add(&bytes_transferred, packet_len);
+
+    return 0;
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
+    trace_vfio_save_complete_precopy_thread_start(vbasedev->name,
+                                                  idstr, instance_id);
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
+            ret = -errno;
+            goto ret_finish;
+        } else if (data_size == 0) {
+            break;
+        }
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
+        qatomic_add(&bytes_transferred, packet_size);
+    }
+
+    ret = vfio_save_complete_precopy_async_thread_config_state(vbasedev, idstr,
+                                                               instance_id,
+                                                               idx);
+
+ret_finish:
+    trace_vfio_save_complete_precopy_thread_end(vbasedev->name, ret);
+
+    return ret;
+}
+
 static void vfio_save_state(QEMUFile *f, void *opaque)
 {
     VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
     Error *local_err = NULL;
     int ret;
 
+    if (migration->multifd_transfer) {
+        vfio_save_multifd_emit_dummy_eos(vbasedev, f);
+        return;
+    }
+
     ret = vfio_save_device_config_state(f, opaque, &local_err);
     if (ret) {
         error_prepend(&local_err,
@@ -1210,6 +1364,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
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

