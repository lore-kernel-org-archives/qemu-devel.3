Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F94BC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaa8-000635-MI; Tue, 04 Mar 2025 17:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaYL-00047l-Ok
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:15:54 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaXP-0001Tu-5R
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:15:53 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaQP-00000000Lc0-2HR1; Tue, 04 Mar 2025 23:07:41 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v6 34/36] vfio/migration: Max in-flight VFIO device state
 buffer count limit
Date: Tue,  4 Mar 2025 23:04:01 +0100
Message-ID: <09463235e0aa30e48e40bd6c89d07f56f4140a93.1741124640.git.maciej.szmigiero@oracle.com>
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

Allow capping the maximum count of in-flight VFIO device state buffers
queued at the destination, otherwise a malicious QEMU source could
theoretically cause the target QEMU to allocate unlimited amounts of memory
for buffers-in-flight.

Since this is not expected to be a realistic threat in most of VFIO live
migration use cases and the right value depends on the particular setup
disable the limit by default by setting it to UINT64_MAX.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/vfio/migration-multifd.c   | 16 ++++++++++++++++
 hw/vfio/pci.c                 |  9 +++++++++
 include/hw/vfio/vfio-common.h |  1 +
 3 files changed, 26 insertions(+)

diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index 233724710b37..d6dabaf869ca 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -54,6 +54,7 @@ typedef struct VFIOMultifd {
     QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
     uint32_t load_buf_idx;
     uint32_t load_buf_idx_last;
+    uint32_t load_buf_queued_pending_buffers;
 } VFIOMultifd;
 
 static void vfio_state_buffer_clear(gpointer data)
@@ -125,6 +126,17 @@ static bool vfio_load_state_buffer_insert(VFIODevice *vbasedev,
 
     assert(packet->idx >= multifd->load_buf_idx);
 
+    multifd->load_buf_queued_pending_buffers++;
+    if (multifd->load_buf_queued_pending_buffers >
+        vbasedev->migration_max_queued_buffers) {
+        error_setg(errp,
+                   "%s: queuing state buffer %" PRIu32
+                   " would exceed the max of %" PRIu64,
+                   vbasedev->name, packet->idx,
+                   vbasedev->migration_max_queued_buffers);
+        return false;
+    }
+
     lb->data = g_memdup2(&packet->data, packet_total_size - sizeof(*packet));
     lb->len = packet_total_size - sizeof(*packet);
     lb->is_present = true;
@@ -381,6 +393,9 @@ static bool vfio_load_bufs_thread(void *opaque, bool *should_quit, Error **errp)
             goto thread_exit;
         }
 
+        assert(multifd->load_buf_queued_pending_buffers > 0);
+        multifd->load_buf_queued_pending_buffers--;
+
         if (multifd->load_buf_idx == multifd->load_buf_idx_last - 1) {
             trace_vfio_load_state_device_buffer_end(vbasedev->name);
         }
@@ -417,6 +432,7 @@ static VFIOMultifd *vfio_multifd_new(void)
 
     multifd->load_buf_idx = 0;
     multifd->load_buf_idx_last = UINT32_MAX;
+    multifd->load_buf_queued_pending_buffers = 0;
     qemu_cond_init(&multifd->load_bufs_buffer_ready_cond);
 
     multifd->load_bufs_thread_running = false;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 21605bac2fb0..ce407f971000 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3383,6 +3383,8 @@ static const Property vfio_pci_dev_properties[] = {
                 vbasedev.migration_multifd_transfer,
                 vfio_pci_migration_multifd_transfer_prop, OnOffAuto,
                 .set_default = true, .defval.i = ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_UINT64("x-migration-max-queued-buffers", VFIOPCIDevice,
+                       vbasedev.migration_max_queued_buffers, UINT64_MAX),
     DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
                      vbasedev.migration_events, false),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
@@ -3444,6 +3446,13 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
                                           "x-migration-multifd-transfer",
                                           "Transfer this device state via "
                                           "multifd channels when live migrating it");
+    object_class_property_set_description(klass, /* 10.0 */
+                                          "x-migration-max-queued-buffers",
+                                          "Maximum count of in-flight VFIO "
+                                          "device state buffers queued at the "
+                                          "destination when doing live "
+                                          "migration of device state via "
+                                          "multifd channels");
 }
 
 static const TypeInfo vfio_pci_dev_info = {
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 04b123a6c929..c033c3c5134f 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -155,6 +155,7 @@ typedef struct VFIODevice {
     bool ram_block_discard_allowed;
     OnOffAuto enable_migration;
     OnOffAuto migration_multifd_transfer;
+    uint64_t migration_max_queued_buffers;
     bool migration_events;
     VFIODeviceOps *ops;
     unsigned int num_irqs;

