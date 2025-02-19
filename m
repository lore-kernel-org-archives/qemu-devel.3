Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CC9C021B1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 20:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkqpE-00025f-Jf; Wed, 19 Feb 2025 15:37:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tkqpC-000200-AQ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 15:37:42 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tkqp9-0004vS-Or
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 15:37:41 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tkqou-00000007VXF-2xTY; Wed, 19 Feb 2025 21:37:24 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v5 35/36] vfio/migration: Add
 x-migration-load-config-after-iter VFIO property
Date: Wed, 19 Feb 2025 21:34:17 +0100
Message-ID: <ac49874d02a104262995a282e12e9516856a0723.1739994627.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739994627.git.maciej.szmigiero@oracle.com>
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
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
 hw/vfio/migration-multifd.c   | 92 +++++++++++++++++++++++++++++++++++
 hw/vfio/migration-multifd.h   |  3 ++
 hw/vfio/migration.c           | 10 +++-
 hw/vfio/pci.c                 |  3 ++
 include/hw/vfio/vfio-common.h |  2 +
 5 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index 04aa3f4a6596..ebb19f746f27 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -31,6 +31,31 @@ typedef struct VFIODeviceStatePacket {
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
+#if defined(TARGET_ARM)
+    return true;
+#else
+    return false;
+#endif
+}
+
 /* type safety */
 typedef struct VFIOStateBuffers {
     GArray *array;
@@ -47,6 +72,9 @@ typedef struct VFIOMultifd {
     bool load_bufs_thread_running;
     bool load_bufs_thread_want_exit;
 
+    bool load_bufs_iter_done;
+    QemuCond load_bufs_iter_done_cond;
+
     VFIOStateBuffers load_bufs;
     QemuCond load_bufs_buffer_ready_cond;
     QemuCond load_bufs_thread_finished_cond;
@@ -394,6 +422,23 @@ static bool vfio_load_bufs_thread(void *opaque, bool *should_quit, Error **errp)
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
+                ret = false;
+                goto ret_signal;
+            }
+        }
+    }
+
     config_ret = vfio_load_bufs_thread_load_config(vbasedev);
     if (config_ret) {
         error_setg(errp, "load config state failed: %d", config_ret);
@@ -411,6 +456,48 @@ ret_signal:
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
 VFIOMultifd *vfio_multifd_new(void)
 {
     VFIOMultifd *multifd = g_new(VFIOMultifd, 1);
@@ -424,6 +511,9 @@ VFIOMultifd *vfio_multifd_new(void)
     multifd->load_buf_queued_pending_buffers = 0;
     qemu_cond_init(&multifd->load_bufs_buffer_ready_cond);
 
+    multifd->load_bufs_iter_done = false;
+    qemu_cond_init(&multifd->load_bufs_iter_done_cond);
+
     multifd->load_bufs_thread_running = false;
     multifd->load_bufs_thread_want_exit = false;
     qemu_cond_init(&multifd->load_bufs_thread_finished_cond);
@@ -447,6 +537,7 @@ static void vfio_load_cleanup_load_bufs_thread(VFIOMultifd *multifd)
             multifd->load_bufs_thread_want_exit = true;
 
             qemu_cond_signal(&multifd->load_bufs_buffer_ready_cond);
+            qemu_cond_signal(&multifd->load_bufs_iter_done_cond);
             qemu_cond_wait(&multifd->load_bufs_thread_finished_cond,
                            &multifd->load_bufs_mutex);
         }
@@ -459,6 +550,7 @@ void vfio_multifd_free(VFIOMultifd *multifd)
     vfio_load_cleanup_load_bufs_thread(multifd);
 
     qemu_cond_destroy(&multifd->load_bufs_thread_finished_cond);
+    qemu_cond_destroy(&multifd->load_bufs_iter_done_cond);
     vfio_state_buffers_destroy(&multifd->load_bufs);
     qemu_cond_destroy(&multifd->load_bufs_buffer_ready_cond);
     qemu_mutex_destroy(&multifd->load_bufs_mutex);
diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
index 79780d7b5392..414f2bc2ece9 100644
--- a/hw/vfio/migration-multifd.h
+++ b/hw/vfio/migration-multifd.h
@@ -22,9 +22,12 @@ bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev);
 
 bool vfio_multifd_transfer_setup(VFIODevice *vbasedev, Error **errp);
 
+bool vfio_load_config_after_iter(VFIODevice *vbasedev);
 bool vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
                             Error **errp);
 
+int vfio_load_state_config_load_ready(VFIODevice *vbasedev);
+
 void vfio_multifd_emit_dummy_eos(VFIODevice *vbasedev, QEMUFile *f);
 
 bool vfio_save_complete_precopy_thread(SaveLiveCompletePrecopyThreadData *d,
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 69dcf2dac2fa..c6f04f9756aa 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -671,7 +671,11 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
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
 
@@ -791,6 +795,10 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
 
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
index 247418f0fce2..9ca33b49421c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3383,6 +3383,9 @@ static const Property vfio_pci_dev_properties[] = {
                 vbasedev.migration_multifd_transfer,
                 qdev_prop_on_off_auto_mutable, OnOffAuto,
                 .set_default = true, .defval.i = ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("x-migration-load-config-after-iter", VFIOPCIDevice,
+                            vbasedev.migration_load_config_after_iter,
+                            ON_OFF_AUTO_AUTO),
     DEFINE_PROP_UINT64("x-migration-max-queued-buffers", VFIOPCIDevice,
                        vbasedev.migration_max_queued_buffers, UINT64_MAX),
     DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 30a5bb9af61b..bd3b0a29ecf2 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -52,6 +52,7 @@
 #define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
 #define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
 #define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
+#define VFIO_MIG_FLAG_DEV_CONFIG_LOAD_READY (0xffffffffef100006ULL)
 
 enum {
     VFIO_DEVICE_TYPE_PCI = 0,
@@ -155,6 +156,7 @@ typedef struct VFIODevice {
     bool ram_block_discard_allowed;
     OnOffAuto enable_migration;
     OnOffAuto migration_multifd_transfer;
+    OnOffAuto migration_load_config_after_iter;
     uint64_t migration_max_queued_buffers;
     bool migration_events;
     VFIODeviceOps *ops;

