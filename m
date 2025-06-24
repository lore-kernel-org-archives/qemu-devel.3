Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A714C77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 17:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU7q0-0002vC-4y; Tue, 24 Jun 2025 13:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1uU7pp-0002sw-GI; Tue, 24 Jun 2025 13:53:29 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1uU7pn-0002jX-QE; Tue, 24 Jun 2025 13:53:29 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1uU7pl-00000005Wmh-2a5T; Tue, 24 Jun 2025 19:53:25 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Avihai Horon <avihaih@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 3/3] vfio/migration: Add also max in-flight VFIO device state
 buffers size limit
Date: Tue, 24 Jun 2025 19:51:58 +0200
Message-ID: <65a132db72807ec6341015e7079b10352d718b96.1750787338.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750787338.git.maciej.szmigiero@oracle.com>
References: <cover.1750787338.git.maciej.szmigiero@oracle.com>
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

There's already a max in-flight VFIO device state buffers *count* limit,
add also max queued buffers *size* limit.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 docs/devel/migration/vfio.rst |  8 +++++---
 hw/vfio/migration-multifd.c   | 21 +++++++++++++++++++--
 hw/vfio/pci.c                 |  9 +++++++++
 include/hw/vfio/vfio-device.h |  1 +
 4 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
index 7c9cb7bdbf87..127a1db35949 100644
--- a/docs/devel/migration/vfio.rst
+++ b/docs/devel/migration/vfio.rst
@@ -254,12 +254,14 @@ This means that a malicious QEMU source could theoretically cause the target
 QEMU to allocate unlimited amounts of memory for such buffers-in-flight.
 
 The "x-migration-max-queued-buffers" property allows capping the maximum count
-of these VFIO device state buffers queued at the destination.
+of these VFIO device state buffers queued at the destination while
+"x-migration-max-queued-buffers-size" property allows capping their total queued
+size.
 
 Because a malicious QEMU source causing OOM on the target is not expected to be
 a realistic threat in most of VFIO live migration use cases and the right value
-depends on the particular setup by default this queued buffers limit is
-disabled by setting it to UINT64_MAX.
+depends on the particular setup by default these queued buffers limits are
+disabled by setting them to UINT64_MAX.
 
 Some host platforms (like ARM64) require that VFIO device config is loaded only
 after all iterables were loaded.
diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index a12ec1ead74a..c76f1f2181f9 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -82,6 +82,7 @@ typedef struct VFIOMultifd {
     uint32_t load_buf_idx;
     uint32_t load_buf_idx_last;
     uint32_t load_buf_queued_pending_buffers;
+    size_t load_buf_queued_pending_buffers_size;
 } VFIOMultifd;
 
 static void vfio_state_buffer_clear(gpointer data)
@@ -138,6 +139,7 @@ static bool vfio_load_state_buffer_insert(VFIODevice *vbasedev,
     VFIOMigration *migration = vbasedev->migration;
     VFIOMultifd *multifd = migration->multifd;
     VFIOStateBuffer *lb;
+    size_t data_size = packet_total_size - sizeof(*packet);
 
     vfio_state_buffers_assert_init(&multifd->load_bufs);
     if (packet->idx >= vfio_state_buffers_size_get(&multifd->load_bufs)) {
@@ -164,8 +166,19 @@ static bool vfio_load_state_buffer_insert(VFIODevice *vbasedev,
         return false;
     }
 
-    lb->data = g_memdup2(&packet->data, packet_total_size - sizeof(*packet));
-    lb->len = packet_total_size - sizeof(*packet);
+    multifd->load_buf_queued_pending_buffers_size += data_size;
+    if (multifd->load_buf_queued_pending_buffers_size >
+        vbasedev->migration_max_queued_buffers_size) {
+        error_setg(errp,
+                   "%s: queuing state buffer %" PRIu32
+                   " would exceed the size max of %" PRIu64,
+                   vbasedev->name, packet->idx,
+                   vbasedev->migration_max_queued_buffers_size);
+        return false;
+    }
+
+    lb->data = g_memdup2(&packet->data, data_size);
+    lb->len = data_size;
     lb->is_present = true;
 
     return true;
@@ -349,6 +362,9 @@ static bool vfio_load_state_buffer_write(VFIODevice *vbasedev,
         assert(wr_ret <= buf_len);
         buf_len -= wr_ret;
         buf_cur += wr_ret;
+
+        assert(multifd->load_buf_queued_pending_buffers_size >= wr_ret);
+        multifd->load_buf_queued_pending_buffers_size -= wr_ret;
     }
 
     trace_vfio_load_state_device_buffer_load_end(vbasedev->name,
@@ -522,6 +538,7 @@ static VFIOMultifd *vfio_multifd_new(void)
     multifd->load_buf_idx = 0;
     multifd->load_buf_idx_last = UINT32_MAX;
     multifd->load_buf_queued_pending_buffers = 0;
+    multifd->load_buf_queued_pending_buffers_size = 0;
     qemu_cond_init(&multifd->load_bufs_buffer_ready_cond);
 
     multifd->load_bufs_iter_done = false;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 01e48e39de75..944813ee7bdb 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3529,6 +3529,8 @@ static const Property vfio_pci_dev_properties[] = {
                             ON_OFF_AUTO_AUTO),
     DEFINE_PROP_UINT64("x-migration-max-queued-buffers", VFIOPCIDevice,
                        vbasedev.migration_max_queued_buffers, UINT64_MAX),
+    DEFINE_PROP_SIZE("x-migration-max-queued-buffers-size", VFIOPCIDevice,
+                     vbasedev.migration_max_queued_buffers_size, UINT64_MAX),
     DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
                      vbasedev.migration_events, false),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
@@ -3716,6 +3718,13 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
                                           "destination when doing live "
                                           "migration of device state via "
                                           "multifd channels");
+    object_class_property_set_description(klass, /* 10.1 */
+                                          "x-migration-max-queued-buffers-size",
+                                          "Maximum size of in-flight VFIO "
+                                          "device state buffers queued at the "
+                                          "destination when doing live "
+                                          "migration of device state via "
+                                          "multifd channels");
 }
 
 static const TypeInfo vfio_pci_dev_info = {
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 359d553b916a..3e86d07347d6 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -68,6 +68,7 @@ typedef struct VFIODevice {
     OnOffAuto migration_multifd_transfer;
     OnOffAuto migration_load_config_after_iter;
     uint64_t migration_max_queued_buffers;
+    uint64_t migration_max_queued_buffers_size;
     bool migration_events;
     bool use_region_fds;
     VFIODeviceOps *ops;

