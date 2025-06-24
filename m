Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF2EC7EE2A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 17:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU7qA-0002wB-CX; Tue, 24 Jun 2025 13:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1uU7pr-0002tL-N4; Tue, 24 Jun 2025 13:53:32 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1uU7pp-0002j6-Nd; Tue, 24 Jun 2025 13:53:31 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1uU7pg-00000005WmV-272w; Tue, 24 Jun 2025 19:53:20 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Avihai Horon <avihaih@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 2/3] vfio/migration: Add x-migration-load-config-after-iter
 VFIO property
Date: Tue, 24 Jun 2025 19:51:57 +0200
Message-ID: <22e94f25448f9ff42b84c84df3960c4ecc94cbdc.1750787338.git.maciej.szmigiero@oracle.com>
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

This property allows configuring whether to start the config load only
after all iterables were loaded.
Such interlocking is required for ARM64 due to this platform VFIO
dependency on interrupt controller being loaded first.

The property defaults to AUTO, which means ON for ARM, OFF for other
platforms.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 docs/devel/migration/vfio.rst     |  6 +++
 hw/core/machine.c                 |  1 +
 hw/vfio/migration-multifd.c       | 88 +++++++++++++++++++++++++++++++
 hw/vfio/migration-multifd.h       |  3 ++
 hw/vfio/migration.c               | 10 +++-
 hw/vfio/pci.c                     |  9 ++++
 hw/vfio/vfio-migration-internal.h |  1 +
 include/hw/vfio/vfio-device.h     |  1 +
 8 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
index f4a6bfa4619b..7c9cb7bdbf87 100644
--- a/docs/devel/migration/vfio.rst
+++ b/docs/devel/migration/vfio.rst
@@ -260,3 +260,9 @@ Because a malicious QEMU source causing OOM on the target is not expected to be
 a realistic threat in most of VFIO live migration use cases and the right value
 depends on the particular setup by default this queued buffers limit is
 disabled by setting it to UINT64_MAX.
+
+Some host platforms (like ARM64) require that VFIO device config is loaded only
+after all iterables were loaded.
+Such interlocking is controlled by "x-migration-load-config-after-iter" VFIO
+device property, which in its default setting (AUTO) does so only on platforms
+that actually require it.
diff --git a/hw/core/machine.c b/hw/core/machine.c
index e869821b2246..16640b700f2e 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -39,6 +39,7 @@
 
 GlobalProperty hw_compat_10_0[] = {
     { "scsi-hd", "dpofua", "off" },
+    { "vfio-pci", "x-migration-load-config-after-iter", "off" },
 };
 const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
 
diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index f26c112090b4..a12ec1ead74a 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -17,6 +17,7 @@
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
 #include "qemu/main-loop.h"
+#include "qemu/target-info.h"
 #include "qemu/thread.h"
 #include "io/channel-buffer.h"
 #include "migration/qemu-file.h"
@@ -35,6 +36,27 @@ typedef struct VFIODeviceStatePacket {
     uint8_t data[0];
 } QEMU_PACKED VFIODeviceStatePacket;
 
+bool vfio_load_config_after_iter(VFIODevice *vbasedev)
+{
+    if (vbasedev->migration_load_config_after_iter == ON_OFF_AUTO_ON) {
+        return true;
+    } else if (vbasedev->migration_load_config_after_iter == ON_OFF_AUTO_OFF) {
+        return false;
+    }
+
+    assert(vbasedev->migration_load_config_after_iter == ON_OFF_AUTO_AUTO);
+
+    /*
+     * Starting the config load only after all iterables were loaded is required
+     * for ARM64 due to this platform VFIO dependency on interrupt controller
+     * being loaded first.
+     *
+     * See commit d329f5032e17 ("vfio: Move the saving of the config space to
+     * the right place in VFIO migration").
+     */
+    return strcmp(target_name(), "aarch64") == 0;
+}
+
 /* type safety */
 typedef struct VFIOStateBuffers {
     GArray *array;
@@ -50,6 +72,9 @@ typedef struct VFIOMultifd {
     bool load_bufs_thread_running;
     bool load_bufs_thread_want_exit;
 
+    bool load_bufs_iter_done;
+    QemuCond load_bufs_iter_done_cond;
+
     VFIOStateBuffers load_bufs;
     QemuCond load_bufs_buffer_ready_cond;
     QemuCond load_bufs_thread_finished_cond;
@@ -409,6 +434,22 @@ static bool vfio_load_bufs_thread(void *opaque, bool *should_quit, Error **errp)
         multifd->load_buf_idx++;
     }
 
+    if (vfio_load_config_after_iter(vbasedev)) {
+        while (!multifd->load_bufs_iter_done) {
+            qemu_cond_wait(&multifd->load_bufs_iter_done_cond,
+                           &multifd->load_bufs_mutex);
+
+            /*
+             * Need to re-check cancellation immediately after wait in case
+             * cond was signalled by vfio_load_cleanup_load_bufs_thread().
+             */
+            if (vfio_load_bufs_thread_want_exit(multifd, should_quit)) {
+                error_setg(errp, "operation cancelled");
+                goto thread_exit;
+            }
+        }
+    }
+
     if (!vfio_load_bufs_thread_load_config(vbasedev, errp)) {
         goto thread_exit;
     }
@@ -428,6 +469,48 @@ thread_exit:
     return ret;
 }
 
+int vfio_load_state_config_load_ready(VFIODevice *vbasedev)
+{
+    VFIOMigration *migration = vbasedev->migration;
+    VFIOMultifd *multifd = migration->multifd;
+    int ret = 0;
+
+    if (!vfio_multifd_transfer_enabled(vbasedev)) {
+        error_report("%s: got DEV_CONFIG_LOAD_READY outside multifd transfer",
+                     vbasedev->name);
+        return -EINVAL;
+    }
+
+    if (!vfio_load_config_after_iter(vbasedev)) {
+        error_report("%s: got DEV_CONFIG_LOAD_READY but was disabled",
+                     vbasedev->name);
+        return -EINVAL;
+    }
+
+    assert(multifd);
+
+    /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first */
+    bql_unlock();
+    WITH_QEMU_LOCK_GUARD(&multifd->load_bufs_mutex) {
+        if (multifd->load_bufs_iter_done) {
+            /* Can't print error here as we're outside BQL */
+            ret = -EINVAL;
+            break;
+        }
+
+        multifd->load_bufs_iter_done = true;
+        qemu_cond_signal(&multifd->load_bufs_iter_done_cond);
+    }
+    bql_lock();
+
+    if (ret) {
+        error_report("%s: duplicate DEV_CONFIG_LOAD_READY",
+                     vbasedev->name);
+    }
+
+    return ret;
+}
+
 static VFIOMultifd *vfio_multifd_new(void)
 {
     VFIOMultifd *multifd = g_new(VFIOMultifd, 1);
@@ -441,6 +524,9 @@ static VFIOMultifd *vfio_multifd_new(void)
     multifd->load_buf_queued_pending_buffers = 0;
     qemu_cond_init(&multifd->load_bufs_buffer_ready_cond);
 
+    multifd->load_bufs_iter_done = false;
+    qemu_cond_init(&multifd->load_bufs_iter_done_cond);
+
     multifd->load_bufs_thread_running = false;
     multifd->load_bufs_thread_want_exit = false;
     qemu_cond_init(&multifd->load_bufs_thread_finished_cond);
@@ -464,6 +550,7 @@ static void vfio_load_cleanup_load_bufs_thread(VFIOMultifd *multifd)
             multifd->load_bufs_thread_want_exit = true;
 
             qemu_cond_signal(&multifd->load_bufs_buffer_ready_cond);
+            qemu_cond_signal(&multifd->load_bufs_iter_done_cond);
             qemu_cond_wait(&multifd->load_bufs_thread_finished_cond,
                            &multifd->load_bufs_mutex);
         }
@@ -476,6 +563,7 @@ static void vfio_multifd_free(VFIOMultifd *multifd)
     vfio_load_cleanup_load_bufs_thread(multifd);
 
     qemu_cond_destroy(&multifd->load_bufs_thread_finished_cond);
+    qemu_cond_destroy(&multifd->load_bufs_iter_done_cond);
     vfio_state_buffers_destroy(&multifd->load_bufs);
     qemu_cond_destroy(&multifd->load_bufs_buffer_ready_cond);
     qemu_mutex_destroy(&multifd->load_bufs_mutex);
diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
index 0bab63211d30..487f457282df 100644
--- a/hw/vfio/migration-multifd.h
+++ b/hw/vfio/migration-multifd.h
@@ -20,9 +20,12 @@ void vfio_multifd_cleanup(VFIODevice *vbasedev);
 bool vfio_multifd_transfer_supported(void);
 bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev);
 
+bool vfio_load_config_after_iter(VFIODevice *vbasedev);
 bool vfio_multifd_load_state_buffer(void *opaque, char *data, size_t data_size,
                                     Error **errp);
 
+int vfio_load_state_config_load_ready(VFIODevice *vbasedev);
+
 void vfio_multifd_emit_dummy_eos(VFIODevice *vbasedev, QEMUFile *f);
 
 bool
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index b76697bd1a23..7c6436d4c344 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -675,7 +675,11 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
     int ret;
 
     if (vfio_multifd_transfer_enabled(vbasedev)) {
-        vfio_multifd_emit_dummy_eos(vbasedev, f);
+        if (vfio_load_config_after_iter(vbasedev)) {
+            qemu_put_be64(f, VFIO_MIG_FLAG_DEV_CONFIG_LOAD_READY);
+        } else {
+            vfio_multifd_emit_dummy_eos(vbasedev, f);
+        }
         return;
     }
 
@@ -784,6 +788,10 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
 
             return ret;
         }
+        case VFIO_MIG_FLAG_DEV_CONFIG_LOAD_READY:
+        {
+            return vfio_load_state_config_load_ready(vbasedev);
+        }
         default:
             error_report("%s: Unknown tag 0x%"PRIx64, vbasedev->name, data);
             return -EINVAL;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 2765a39f9df1..01e48e39de75 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3524,6 +3524,9 @@ static const Property vfio_pci_dev_properties[] = {
                 vbasedev.migration_multifd_transfer,
                 vfio_pci_migration_multifd_transfer_prop, OnOffAuto,
                 .set_default = true, .defval.i = ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("x-migration-load-config-after-iter", VFIOPCIDevice,
+                            vbasedev.migration_load_config_after_iter,
+                            ON_OFF_AUTO_AUTO),
     DEFINE_PROP_UINT64("x-migration-max-queued-buffers", VFIOPCIDevice,
                        vbasedev.migration_max_queued_buffers, UINT64_MAX),
     DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
@@ -3700,6 +3703,12 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
                                           "x-migration-multifd-transfer",
                                           "Transfer this device state via "
                                           "multifd channels when live migrating it");
+    object_class_property_set_description(klass, /* 10.1 */
+                                          "x-migration-load-config-after-iter",
+                                          "Start the config load only after "
+                                          "all iterables were loaded when doing "
+                                          "live migration of device state via "
+                                          "multifd channels");
     object_class_property_set_description(klass, /* 10.1 */
                                           "x-migration-max-queued-buffers",
                                           "Maximum count of in-flight VFIO "
diff --git a/hw/vfio/vfio-migration-internal.h b/hw/vfio/vfio-migration-internal.h
index a8b456b239df..54141e27e6b2 100644
--- a/hw/vfio/vfio-migration-internal.h
+++ b/hw/vfio/vfio-migration-internal.h
@@ -32,6 +32,7 @@
 #define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
 #define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
 #define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
+#define VFIO_MIG_FLAG_DEV_CONFIG_LOAD_READY (0xffffffffef100006ULL)
 
 typedef struct VFIODevice VFIODevice;
 typedef struct VFIOMultifd VFIOMultifd;
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 0ee34aaf668b..359d553b916a 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -66,6 +66,7 @@ typedef struct VFIODevice {
     bool ram_block_discard_allowed;
     OnOffAuto enable_migration;
     OnOffAuto migration_multifd_transfer;
+    OnOffAuto migration_load_config_after_iter;
     uint64_t migration_max_queued_buffers;
     bool migration_events;
     bool use_region_fds;

