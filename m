Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35D5C282D0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 23:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpbEP-0002u1-TT; Tue, 04 Mar 2025 17:59:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpbEM-0002t9-TL
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:59:19 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpbEK-00074U-R7
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:59:18 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaPk-00000000Lah-2Jmd; Tue, 04 Mar 2025 23:07:00 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v6 26/36] vfio/migration: Multifd device state transfer
 support - received buffers queuing
Date: Tue,  4 Mar 2025 23:03:53 +0100
Message-ID: <e3bff515a8d61c582b94b409eb12a45b1a143a69.1741124640.git.maciej.szmigiero@oracle.com>
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

The multifd received data needs to be reassembled since device state
packets sent via different multifd channels can arrive out-of-order.

Therefore, each VFIO device state packet carries a header indicating its
position in the stream.
The raw device state data is saved into a VFIOStateBuffer for later
in-order loading into the device.

The last such VFIO device state packet should have
VFIO_DEVICE_STATE_CONFIG_STATE flag set and carry the device config state.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/vfio/migration-multifd.c | 163 ++++++++++++++++++++++++++++++++++++
 hw/vfio/migration-multifd.h |   3 +
 hw/vfio/migration.c         |   1 +
 hw/vfio/trace-events        |   1 +
 4 files changed, 168 insertions(+)

diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index 091dc43210ad..79df11b7baa9 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -32,18 +32,181 @@ typedef struct VFIODeviceStatePacket {
     uint8_t data[0];
 } QEMU_PACKED VFIODeviceStatePacket;
 
+/* type safety */
+typedef struct VFIOStateBuffers {
+    GArray *array;
+} VFIOStateBuffers;
+
+typedef struct VFIOStateBuffer {
+    bool is_present;
+    char *data;
+    size_t len;
+} VFIOStateBuffer;
+
 typedef struct VFIOMultifd {
+    VFIOStateBuffers load_bufs;
+    QemuCond load_bufs_buffer_ready_cond;
+    QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
+    uint32_t load_buf_idx;
+    uint32_t load_buf_idx_last;
 } VFIOMultifd;
 
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
+static unsigned int vfio_state_buffers_size_get(VFIOStateBuffers *bufs)
+{
+    return bufs->array->len;
+}
+
+static void vfio_state_buffers_size_set(VFIOStateBuffers *bufs,
+                                        unsigned int size)
+{
+    g_array_set_size(bufs->array, size);
+}
+
+static VFIOStateBuffer *vfio_state_buffers_at(VFIOStateBuffers *bufs,
+                                              unsigned int idx)
+{
+    return &g_array_index(bufs->array, VFIOStateBuffer, idx);
+}
+
+/* called with load_bufs_mutex locked */
+static bool vfio_load_state_buffer_insert(VFIODevice *vbasedev,
+                                          VFIODeviceStatePacket *packet,
+                                          size_t packet_total_size,
+                                          Error **errp)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    VFIOMultifd *multifd = migration->multifd;
+    VFIOStateBuffer *lb;
+
+    vfio_state_buffers_assert_init(&multifd->load_bufs);
+    if (packet->idx >= vfio_state_buffers_size_get(&multifd->load_bufs)) {
+        vfio_state_buffers_size_set(&multifd->load_bufs, packet->idx + 1);
+    }
+
+    lb = vfio_state_buffers_at(&multifd->load_bufs, packet->idx);
+    if (lb->is_present) {
+        error_setg(errp, "%s: state buffer %" PRIu32 " already filled",
+                   vbasedev->name, packet->idx);
+        return false;
+    }
+
+    assert(packet->idx >= multifd->load_buf_idx);
+
+    lb->data = g_memdup2(&packet->data, packet_total_size - sizeof(*packet));
+    lb->len = packet_total_size - sizeof(*packet);
+    lb->is_present = true;
+
+    return true;
+}
+
+bool vfio_multifd_load_state_buffer(void *opaque, char *data, size_t data_size,
+                                    Error **errp)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    VFIOMultifd *multifd = migration->multifd;
+    VFIODeviceStatePacket *packet = (VFIODeviceStatePacket *)data;
+
+    if (!vfio_multifd_transfer_enabled(vbasedev)) {
+        error_setg(errp,
+                   "%s: got device state packet but not doing multifd transfer",
+                   vbasedev->name);
+        return false;
+    }
+
+    assert(multifd);
+
+    if (data_size < sizeof(*packet)) {
+        error_setg(errp, "%s: packet too short at %zu (min is %zu)",
+                   vbasedev->name, data_size, sizeof(*packet));
+        return false;
+    }
+
+    if (packet->version != VFIO_DEVICE_STATE_PACKET_VER_CURRENT) {
+        error_setg(errp, "%s: packet has unknown version %" PRIu32,
+                   vbasedev->name, packet->version);
+        return false;
+    }
+
+    if (packet->idx == UINT32_MAX) {
+        error_setg(errp, "%s: packet index is invalid", vbasedev->name);
+        return false;
+    }
+
+    trace_vfio_load_state_device_buffer_incoming(vbasedev->name, packet->idx);
+
+    /*
+     * Holding BQL here would violate the lock order and can cause
+     * a deadlock once we attempt to lock load_bufs_mutex below.
+     */
+    assert(!bql_locked());
+
+    WITH_QEMU_LOCK_GUARD(&multifd->load_bufs_mutex) {
+        /* config state packet should be the last one in the stream */
+        if (packet->flags & VFIO_DEVICE_STATE_CONFIG_STATE) {
+            multifd->load_buf_idx_last = packet->idx;
+        }
+
+        if (!vfio_load_state_buffer_insert(vbasedev, packet, data_size,
+                                           errp)) {
+            return false;
+        }
+
+        qemu_cond_signal(&multifd->load_bufs_buffer_ready_cond);
+    }
+
+    return true;
+}
+
 static VFIOMultifd *vfio_multifd_new(void)
 {
     VFIOMultifd *multifd = g_new(VFIOMultifd, 1);
 
+    vfio_state_buffers_init(&multifd->load_bufs);
+
+    qemu_mutex_init(&multifd->load_bufs_mutex);
+
+    multifd->load_buf_idx = 0;
+    multifd->load_buf_idx_last = UINT32_MAX;
+    qemu_cond_init(&multifd->load_bufs_buffer_ready_cond);
+
     return multifd;
 }
 
 static void vfio_multifd_free(VFIOMultifd *multifd)
 {
+    vfio_state_buffers_destroy(&multifd->load_bufs);
+    qemu_cond_destroy(&multifd->load_bufs_buffer_ready_cond);
+    qemu_mutex_destroy(&multifd->load_bufs_mutex);
+
     g_free(multifd);
 }
 
diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
index 2a7a76164f29..8c6320fcb484 100644
--- a/hw/vfio/migration-multifd.h
+++ b/hw/vfio/migration-multifd.h
@@ -20,4 +20,7 @@ void vfio_multifd_cleanup(VFIODevice *vbasedev);
 bool vfio_multifd_transfer_supported(void);
 bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev);
 
+bool vfio_multifd_load_state_buffer(void *opaque, char *data, size_t data_size,
+                                    Error **errp);
+
 #endif
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 3c8286ae6230..ecc4ee940567 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -801,6 +801,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
     .load_setup = vfio_load_setup,
     .load_cleanup = vfio_load_cleanup,
     .load_state = vfio_load_state,
+    .load_state_buffer = vfio_multifd_load_state_buffer,
     .switchover_ack_needed = vfio_switchover_ack_needed,
 };
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index a02c668f28a4..404ea079b25c 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -154,6 +154,7 @@ vfio_load_device_config_state_start(const char *name) " (%s)"
 vfio_load_device_config_state_end(const char *name) " (%s)"
 vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
 vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size %"PRIu64" ret %d"
+vfio_load_state_device_buffer_incoming(const char *name, uint32_t idx) " (%s) idx %"PRIu32
 vfio_migration_realize(const char *name) " (%s)"
 vfio_migration_set_device_state(const char *name, const char *state) " (%s) state %s"
 vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"

