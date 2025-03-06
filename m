Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FDDC282EC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC4L-0004p7-5q; Thu, 06 Mar 2025 09:19:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC1d-0000s7-Vr
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:16:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC1X-00027c-NT
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3HZy1XPT45Um+BbusYDbqxnkO9sHgbG8uYLs/KQVWSs=;
 b=FZzkNDDkWchX27o/C5DAdYp03qI2N9A/3SnwoJUtWm2dhEU87O0c/1/WKX2o+g6yXW8CjH
 8YmW+56iIYBiacnTZE4g4Bkw15yCis/Gr7JO4KJewN7TI2zvsyWnoU8t41xiRIlhVsZTFQ
 CuJzs797gq2QhcFSS5z2QV1nRsJktWc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-AiZFGSlgNB2d1z1Hav11uw-1; Thu,
 06 Mar 2025 09:16:20 -0500
X-MC-Unique: AiZFGSlgNB2d1z1Hav11uw-1
X-Mimecast-MFC-AGG-ID: AiZFGSlgNB2d1z1Hav11uw_1741270579
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F95F1828A9C; Thu,  6 Mar 2025 14:16:19 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1E5311801748; Thu,  6 Mar 2025 14:16:16 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 39/42] vfio/migration: Multifd device state transfer support -
 send side
Date: Thu,  6 Mar 2025 15:14:15 +0100
Message-ID: <20250306141419.2015340-40-clg@redhat.com>
In-Reply-To: <20250306141419.2015340-1-clg@redhat.com>
References: <20250306141419.2015340-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Implement the multifd device state transfer via additional per-device
thread inside save_live_complete_precopy_thread handler.

Switch between doing the data transfer in the new handler and doing it
in the old save_state handler depending if VFIO multifd transfer is enabled
or not.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/4d727e2e0435e0022d50004e474077632830e08d.1741124640.git.maciej.szmigiero@oracle.com
[ clg: - Reordered savevm_vfio_handlers
       - Updated save_live_complete_precopy* documentation ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/devel/migration/vfio.rst |  19 ++++-
 hw/vfio/migration-multifd.h   |   6 ++
 include/hw/vfio/vfio-common.h |   6 ++
 hw/vfio/migration-multifd.c   | 142 ++++++++++++++++++++++++++++++++++
 hw/vfio/migration.c           |  22 ++++--
 hw/vfio/trace-events          |   2 +
 6 files changed, 189 insertions(+), 8 deletions(-)

diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
index d6cf60890c43f2ebf085940a233f8b85a900b6b3..a803a09bc15619cfc46384908d50860ca135d26e 100644
--- a/docs/devel/migration/vfio.rst
+++ b/docs/devel/migration/vfio.rst
@@ -71,11 +71,23 @@ VFIO implements the device hooks for the iterative approach as follows:
   reassembles the multifd received data and loads it in-order into the device.
   In the non-multifd mode this function is a NOP.
 
-* A ``save_state`` function to save the device config space if it is present.
+* A ``save_state`` function to save the device config space if it is present
+  in the non-multifd mode.
+  In the multifd mode it just emits either a dummy EOS marker.
 
 * A ``save_live_complete_precopy`` function that sets the VFIO device in
   _STOP_COPY state and iteratively copies the data for the VFIO device until
   the vendor driver indicates that no data remains.
+  In the multifd mode it just emits a dummy EOS marker.
+
+* A ``save_live_complete_precopy_thread`` function that in the multifd mode
+  provides thread handler performing multifd device state transfer.
+  It sets the VFIO device to _STOP_COPY state, iteratively reads the data
+  from the VFIO device and queues it for multifd transmission until the vendor
+  driver indicates that no data remains.
+  After that, it saves the device config space and queues it for multifd
+  transfer too.
+  In the non-multifd mode this thread is a NOP.
 
 * A ``load_state`` function that loads the config section and the data
   sections that are generated by the save functions above.
@@ -184,8 +196,11 @@ Live migration save path
                 Then the VFIO device is put in _STOP_COPY state
                      (FINISH_MIGRATE, _ACTIVE, _STOP_COPY)
          .save_live_complete_precopy() is called for each active device
-      For the VFIO device, iterate in .save_live_complete_precopy() until
+              For the VFIO device: in the non-multifd mode iterate in
+                        .save_live_complete_precopy() until
                                pending data is 0
+	          In the multifd mode this iteration is done in
+	          .save_live_complete_precopy_thread() instead.
                                       |
                      (POSTMIGRATE, _COMPLETED, _STOP_COPY)
             Migraton thread schedules cleanup bottom half and exits
diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
index f0d28fcef2ea737fc550a34ff266a34848bca67c..a664051eb8ae03bc41cb7f9362ace840f41066ff 100644
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
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 9d72ac1eae8a50e06f32d1c46332c9fd3adddce2..961931d9f457e170f26afabc484a1e7c39675533 100644
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
diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index 1d81233c755fec825d94c040ff6cf87eb6551f01..bfb9a72fa4503e2ea00731a2ba528a54d09ed4c5 100644
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
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 2ca3fa08d48667e1c338d3e148023afed7251ac4..416643ddd69ab64c252eadd07702a9d5dad0db47 100644
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
@@ -825,6 +834,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
      */
     .load_state_buffer = vfio_multifd_load_state_buffer,
     .switchover_start = vfio_switchover_start,
+    .save_live_complete_precopy_thread = vfio_multifd_save_complete_precopy_thread,
 };
 
 /* ---------------------------------------------------------------------- */
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index d6b7e34faa392890aad34173b34fd8c8c9df5e84..9347e3a5f6607ec6907f9b426da9ab90553292cf 100644
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
-- 
2.48.1


