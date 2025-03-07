Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB042C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 10:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqVOr-0006R5-F5; Fri, 07 Mar 2025 05:57:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tqVOn-0006QI-Us
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 05:57:50 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tqVOk-0003D9-P5
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 05:57:49 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tqVOW-00000000RLw-08mS; Fri, 07 Mar 2025 11:57:32 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH 1/2] vfio/migration: Add also max in-flight VFIO device state
 buffers size limit
Date: Fri,  7 Mar 2025 11:57:24 +0100
Message-ID: <2b2469939198c2f31dba33b284576d2df22697b7.1741344976.git.maciej.szmigiero@oracle.com>
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

There's already a max in-flight VFIO device state buffers *count* limit,
add also max queued buffers *size* limit.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 docs/devel/migration/vfio.rst |  8 +++++---
 hw/vfio/migration-multifd.c   | 21 +++++++++++++++++++--
 hw/vfio/pci.c                 |  9 +++++++++
 include/hw/vfio/vfio-common.h |  1 +
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
index dccd763d7c39..a9d41b9f1cb1 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -83,6 +83,7 @@ typedef struct VFIOMultifd {
     uint32_t load_buf_idx;
     uint32_t load_buf_idx_last;
     uint32_t load_buf_queued_pending_buffers;
+    size_t load_buf_queued_pending_buffers_size;
 } VFIOMultifd;
 
 static void vfio_state_buffer_clear(gpointer data)
@@ -139,6 +140,7 @@ static bool vfio_load_state_buffer_insert(VFIODevice *vbasedev,
     VFIOMigration *migration = vbasedev->migration;
     VFIOMultifd *multifd = migration->multifd;
     VFIOStateBuffer *lb;
+    size_t data_size = packet_total_size - sizeof(*packet);
 
     vfio_state_buffers_assert_init(&multifd->load_bufs);
     if (packet->idx >= vfio_state_buffers_size_get(&multifd->load_bufs)) {
@@ -165,8 +167,19 @@ static bool vfio_load_state_buffer_insert(VFIODevice *vbasedev,
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
@@ -346,6 +359,9 @@ static bool vfio_load_state_buffer_write(VFIODevice *vbasedev,
         assert(wr_ret <= buf_len);
         buf_len -= wr_ret;
         buf_cur += wr_ret;
+
+        assert(multifd->load_buf_queued_pending_buffers_size >= wr_ret);
+        multifd->load_buf_queued_pending_buffers_size -= wr_ret;
     }
 
     trace_vfio_load_state_device_buffer_load_end(vbasedev->name,
@@ -519,6 +535,7 @@ static VFIOMultifd *vfio_multifd_new(void)
     multifd->load_buf_idx = 0;
     multifd->load_buf_idx_last = UINT32_MAX;
     multifd->load_buf_queued_pending_buffers = 0;
+    multifd->load_buf_queued_pending_buffers_size = 0;
     qemu_cond_init(&multifd->load_bufs_buffer_ready_cond);
 
     multifd->load_bufs_iter_done = false;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 02f784c1b2a3..8abf73f810ee 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3392,6 +3392,8 @@ static const Property vfio_pci_dev_properties[] = {
                             ON_OFF_AUTO_AUTO),
     DEFINE_PROP_UINT64("x-migration-max-queued-buffers", VFIOPCIDevice,
                        vbasedev.migration_max_queued_buffers, UINT64_MAX),
+    DEFINE_PROP_SIZE("x-migration-max-queued-buffers-size", VFIOPCIDevice,
+                     vbasedev.migration_max_queued_buffers_size, UINT64_MAX),
     DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
                      vbasedev.migration_events, false),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
@@ -3581,6 +3583,13 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
                                           "destination when doing live "
                                           "migration of device state via "
                                           "multifd channels");
+    object_class_property_set_description(klass, /* 10.0 */
+                                          "x-migration-max-queued-buffers-size",
+                                          "Maximum size of in-flight VFIO "
+                                          "device state buffers queued at the "
+                                          "destination when doing live "
+                                          "migration of device state via "
+                                          "multifd channels");
 }
 
 static const TypeInfo vfio_pci_dev_info = {
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index c8ff4252e24a..fff2f35754b2 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -158,6 +158,7 @@ typedef struct VFIODevice {
     OnOffAuto migration_multifd_transfer;
     OnOffAuto migration_load_config_after_iter;
     uint64_t migration_max_queued_buffers;
+    uint64_t migration_max_queued_buffers_size;
     bool migration_events;
     VFIODeviceOps *ops;
     unsigned int num_irqs;

