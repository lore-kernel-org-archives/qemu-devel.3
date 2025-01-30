Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301FDC02195
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 10:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdRWg-0008Md-G1; Thu, 30 Jan 2025 05:11:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRWU-00080J-Jo
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:11:49 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRWS-0007Ph-CI
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:11:46 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRWD-00000006U1M-47i2; Thu, 30 Jan 2025 11:11:29 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 27/33] vfio/migration: Multifd device state transfer
 support - received buffers queuing
Date: Thu, 30 Jan 2025 11:08:48 +0100
Message-ID: <74c4bbaaccd81e883504ae478e84394ddd96bbae.1738171076.git.maciej.szmigiero@oracle.com>
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
 hw/vfio/migration.c           | 116 ++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c                 |   2 +
 hw/vfio/trace-events          |   1 +
 include/hw/vfio/vfio-common.h |   1 +
 4 files changed, 120 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index bcdf204d5cf4..0c0caec1bd64 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -301,6 +301,12 @@ typedef struct VFIOStateBuffer {
 } VFIOStateBuffer;
 
 typedef struct VFIOMultifd {
+    VFIOStateBuffers load_bufs;
+    QemuCond load_bufs_buffer_ready_cond;
+    QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
+    uint32_t load_buf_idx;
+    uint32_t load_buf_idx_last;
+    uint32_t load_buf_queued_pending_buffers;
 } VFIOMultifd;
 
 static void vfio_state_buffer_clear(gpointer data)
@@ -346,6 +352,103 @@ static VFIOStateBuffer *vfio_state_buffers_at(VFIOStateBuffers *bufs, guint idx)
     return &g_array_index(bufs->array, VFIOStateBuffer, idx);
 }
 
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
+        error_setg(errp, "state buffer %" PRIu32 " already filled",
+                   packet->idx);
+        return false;
+    }
+
+    assert(packet->idx >= multifd->load_buf_idx);
+
+    multifd->load_buf_queued_pending_buffers++;
+    if (multifd->load_buf_queued_pending_buffers >
+        vbasedev->migration_max_queued_buffers) {
+        error_setg(errp,
+                   "queuing state buffer %" PRIu32 " would exceed the max of %" PRIu64,
+                   packet->idx, vbasedev->migration_max_queued_buffers);
+        return false;
+    }
+
+    lb->data = g_memdup2(&packet->data, packet_total_size - sizeof(*packet));
+    lb->len = packet_total_size - sizeof(*packet);
+    lb->is_present = true;
+
+    return true;
+}
+
+static bool vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
+                                   Error **errp)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    VFIOMultifd *multifd = migration->multifd;
+    VFIODeviceStatePacket *packet = (VFIODeviceStatePacket *)data;
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
+        return false;
+    }
+
+    assert(multifd);
+
+    if (data_size < sizeof(*packet)) {
+        error_setg(errp, "packet too short at %zu (min is %zu)",
+                   data_size, sizeof(*packet));
+        return false;
+    }
+
+    if (packet->version != 0) {
+        error_setg(errp, "packet has unknown version %" PRIu32,
+                   packet->version);
+        return false;
+    }
+
+    if (packet->idx == UINT32_MAX) {
+        error_setg(errp, "packet has too high idx %" PRIu32,
+                   packet->idx);
+        return false;
+    }
+
+    trace_vfio_load_state_device_buffer_incoming(vbasedev->name, packet->idx);
+
+    QEMU_LOCK_GUARD(&multifd->load_bufs_mutex);
+
+    /* config state packet should be the last one in the stream */
+    if (packet->flags & VFIO_DEVICE_STATE_CONFIG_STATE) {
+        multifd->load_buf_idx_last = packet->idx;
+    }
+
+    if (!vfio_load_state_buffer_insert(vbasedev, packet, data_size, errp)) {
+        return false;
+    }
+
+    qemu_cond_signal(&multifd->load_bufs_buffer_ready_cond);
+
+    return true;
+}
+
 static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
                                          Error **errp)
 {
@@ -405,11 +508,23 @@ static VFIOMultifd *vfio_multifd_new(void)
 {
     VFIOMultifd *multifd = g_new(VFIOMultifd, 1);
 
+    vfio_state_buffers_init(&multifd->load_bufs);
+
+    qemu_mutex_init(&multifd->load_bufs_mutex);
+
+    multifd->load_buf_idx = 0;
+    multifd->load_buf_idx_last = UINT32_MAX;
+    multifd->load_buf_queued_pending_buffers = 0;
+    qemu_cond_init(&multifd->load_bufs_buffer_ready_cond);
+
     return multifd;
 }
 
 static void vfio_multifd_free(VFIOMultifd *multifd)
 {
+    qemu_cond_destroy(&multifd->load_bufs_buffer_ready_cond);
+    qemu_mutex_destroy(&multifd->load_bufs_mutex);
+
     g_free(multifd);
 }
 
@@ -940,6 +1055,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
     .load_setup = vfio_load_setup,
     .load_cleanup = vfio_load_cleanup,
     .load_state = vfio_load_state,
+    .load_state_buffer = vfio_load_state_buffer,
     .switchover_ack_needed = vfio_switchover_ack_needed,
 };
 
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 83090c544d95..2700b355ecf1 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3380,6 +3380,8 @@ static const Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("x-migration-load-config-after-iter", VFIOPCIDevice,
                             vbasedev.migration_load_config_after_iter,
                             ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_UINT64("x-migration-max-queued-buffers", VFIOPCIDevice,
+                       vbasedev.migration_max_queued_buffers, UINT64_MAX),
     DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
                      vbasedev.migration_events, false),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 1bebe9877d88..042a3dc54a33 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -153,6 +153,7 @@ vfio_load_device_config_state_start(const char *name) " (%s)"
 vfio_load_device_config_state_end(const char *name) " (%s)"
 vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
 vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size %"PRIu64" ret %d"
+vfio_load_state_device_buffer_incoming(const char *name, uint32_t idx) " (%s) idx %"PRIu32
 vfio_migration_realize(const char *name) " (%s)"
 vfio_migration_set_device_state(const char *name, const char *state) " (%s) state %s"
 vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index c0c9c0b1b263..0e8b0848882e 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -139,6 +139,7 @@ typedef struct VFIODevice {
     OnOffAuto enable_migration;
     OnOffAuto migration_multifd_transfer;
     OnOffAuto migration_load_config_after_iter;
+    uint64_t migration_max_queued_buffers;
     bool migration_events;
     VFIODeviceOps *ops;
     unsigned int num_irqs;

