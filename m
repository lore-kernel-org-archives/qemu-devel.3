Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC665C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC4B-0003zL-M1; Thu, 06 Mar 2025 09:19:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC1e-0000sG-Mh
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:16:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC1X-00027m-Nd
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:16:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fL2jDoLkbNFzfcsI8GHD0gwVFThbZF+dj4p0Hq4j3rw=;
 b=X+MeZnpc5ZzGsHJPPGu6V6y7RxVIbCwra0NOh/0UhDyGu9aBFaf52zTlqedcITJ7uFQAIW
 u4MYS2PwpTcXrh/BKN7lk7KYvqR2QHX4VO3AKIl6Syp3ltTh3zZF8CVaoEo307ZB2z6Xhl
 KkjsGpRbd7IQA7yzSPpUFiQG5y+I3/w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-dNUYE8_EMP6zXm3kRnVMeQ-1; Thu,
 06 Mar 2025 09:16:09 -0500
X-MC-Unique: dNUYE8_EMP6zXm3kRnVMeQ-1
X-Mimecast-MFC-AGG-ID: dNUYE8_EMP6zXm3kRnVMeQ_1741270568
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BDCE1955E9C; Thu,  6 Mar 2025 14:16:08 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A99CD18009BC; Thu,  6 Mar 2025 14:16:06 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 35/42] vfio/migration: Multifd device state transfer support -
 received buffers queuing
Date: Thu,  6 Mar 2025 15:14:11 +0100
Message-ID: <20250306141419.2015340-36-clg@redhat.com>
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

The multifd received data needs to be reassembled since device state
packets sent via different multifd channels can arrive out-of-order.

Therefore, each VFIO device state packet carries a header indicating its
position in the stream.
The raw device state data is saved into a VFIOStateBuffer for later
in-order loading into the device.

The last such VFIO device state packet should have
VFIO_DEVICE_STATE_CONFIG_STATE flag set and carry the device config state.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/e3bff515a8d61c582b94b409eb12a45b1a143a69.1741124640.git.maciej.szmigiero@oracle.com
[ clg: - Reordered savevm_vfio_handlers
       - Added load_state_buffer documentation ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/devel/migration/vfio.rst |   7 ++
 hw/vfio/migration-multifd.h   |   3 +
 hw/vfio/migration-multifd.c   | 163 ++++++++++++++++++++++++++++++++++
 hw/vfio/migration.c           |   4 +
 hw/vfio/trace-events          |   1 +
 5 files changed, 178 insertions(+)

diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
index c49482eab66d8e831ea1c2c791fc895b51893e4d..8b1f28890a0ba708cc1e49d87b16e17a5d8f7c88 100644
--- a/docs/devel/migration/vfio.rst
+++ b/docs/devel/migration/vfio.rst
@@ -76,6 +76,10 @@ VFIO implements the device hooks for the iterative approach as follows:
 * A ``load_state`` function that loads the config section and the data
   sections that are generated by the save functions above.
 
+* A ``load_state_buffer`` function that loads the device state and the device
+  config that arrived via multifd channels.
+  It's used only in the multifd mode.
+
 * ``cleanup`` functions for both save and load that perform any migration
   related cleanup.
 
@@ -194,6 +198,9 @@ Live migration resume path
                           (RESTORE_VM, _ACTIVE, _STOP)
                                       |
      For each device, .load_state() is called for that device section data
+                 transmitted via the main migration channel.
+     For data transmitted via multifd channels .load_state_buffer() is called
+                                   instead.
                         (RESTORE_VM, _ACTIVE, _RESUMING)
                                       |
   At the end, .load_cleanup() is called for each device and vCPUs are started
diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
index 2a7a76164f291d182172775524a5b11c0a560c58..8c6320fcb484ca9f779e14d4f9d814081d2f760e 100644
--- a/hw/vfio/migration-multifd.h
+++ b/hw/vfio/migration-multifd.h
@@ -20,4 +20,7 @@ void vfio_multifd_cleanup(VFIODevice *vbasedev);
 bool vfio_multifd_transfer_supported(void);
 bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev);
 
+bool vfio_multifd_load_state_buffer(void *opaque, char *data, size_t data_size,
+                                    Error **errp);
+
 #endif
diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index 091dc43210ad1459d5114da18336e73f6cb0baf9..79df11b7baa991763039b395c34931e796e711b0 100644
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
 
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 3c8286ae62300122582ae5ced26f5cbf5742818a..2cdb92356e0a2afb64109c10536c857b19f7e7c5 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -802,6 +802,10 @@ static const SaveVMHandlers savevm_vfio_handlers = {
     .load_cleanup = vfio_load_cleanup,
     .load_state = vfio_load_state,
     .switchover_ack_needed = vfio_switchover_ack_needed,
+    /*
+     * Multifd support
+     */
+    .load_state_buffer = vfio_multifd_load_state_buffer,
 };
 
 /* ---------------------------------------------------------------------- */
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index a02c668f28a43f73ed2db9f15827f26fed0994c3..404ea079b25c49fe25f4c9b05f0cde4f0536fdd7 100644
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
-- 
2.48.1


