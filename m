Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FE6C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 16:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubiwO-0003C9-Tw; Tue, 15 Jul 2025 12:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubieu-000775-F7
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:37:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubier-0003kp-ED
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752597452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z/O43qI/WrPJzUDNsGyhzAW+Zwhq/ftDmevNFEjgpgA=;
 b=h3tpwhb3fBTtJnWwxp7y7D2G7AEdYkOe5i4OHMwOoNcdQLdL/0e6ANnFGg0coVSiXuf6QJ
 ul0Vkva5CCyYCpd1MgoXNRxJlkY2l+YYoGPuyqbcWzZ9Ul30E1eq/ao+zkSskvosWSrtyc
 PuQZrMTBSumfWyb/8IjNSbc1VloXwOE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-JjRcw591PF2294leeUHIvg-1; Tue,
 15 Jul 2025 12:37:29 -0400
X-MC-Unique: JjRcw591PF2294leeUHIvg-1
X-Mimecast-MFC-AGG-ID: JjRcw591PF2294leeUHIvg_1752597448
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2880D19560BC; Tue, 15 Jul 2025 16:37:28 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.160])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 050F53000198; Tue, 15 Jul 2025 16:37:25 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 6/7] vfio/migration: Add x-migration-load-config-after-iter
 VFIO property
Date: Tue, 15 Jul 2025 18:37:02 +0200
Message-ID: <20250715163703.243975-7-clg@redhat.com>
In-Reply-To: <20250715163703.243975-1-clg@redhat.com>
References: <20250715163703.243975-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
after all iterables were loaded, during non-iterables loading phase.
Such interlocking is required for ARM64 due to this platform VFIO
dependency on interrupt controller being loaded first.

The property defaults to AUTO, which means ON for ARM, OFF for other
platforms.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Link: https://lore.kernel.org/qemu-devel/0e03c60dbc91f9a9ba2516929574df605b7dfcb4.1752589295.git.maciej.szmigiero@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/devel/migration/vfio.rst     |  6 +++
 hw/vfio/migration-multifd.h       |  3 ++
 hw/vfio/vfio-helpers.h            |  2 +
 hw/vfio/vfio-migration-internal.h |  1 +
 include/hw/vfio/vfio-device.h     |  1 +
 hw/core/machine.c                 |  1 +
 hw/vfio/helpers.c                 | 17 +++++++
 hw/vfio/migration-multifd.c       | 79 +++++++++++++++++++++++++++++++
 hw/vfio/migration.c               | 10 +++-
 hw/vfio/pci.c                     | 10 ++++
 10 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
index 2d8e5ca9dd0e16ac8a393ca7a664b81b9c4e5f21..dae3a988307fedf00f83926b96fd3d2b9a1c56f7 100644
--- a/docs/devel/migration/vfio.rst
+++ b/docs/devel/migration/vfio.rst
@@ -247,3 +247,9 @@ The multifd VFIO device state transfer is controlled by
 "x-migration-multifd-transfer" VFIO device property. This property defaults to
 AUTO, which means that VFIO device state transfer via multifd channels is
 attempted in configurations that otherwise support it.
+
+Some host platforms (like ARM64) require that VFIO device config is loaded only
+after all iterables were loaded, during non-iterables loading phase.
+Such interlocking is controlled by "x-migration-load-config-after-iter" VFIO
+device property, which in its default setting (AUTO) does so only on platforms
+that actually require it.
diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
index ebf22a7997ac54c69cb347a7edbb867f88490ad8..82d2d3a1fd3eed61ce1f2a2addf62f0f5c8e09b5 100644
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
diff --git a/hw/vfio/vfio-helpers.h b/hw/vfio/vfio-helpers.h
index 54a327ffbc04a2df364fdd78bd97fe7e2065b38c..ce317580800ac0c96696e8d3769a98c21d2716d0 100644
--- a/hw/vfio/vfio-helpers.h
+++ b/hw/vfio/vfio-helpers.h
@@ -32,4 +32,6 @@ struct vfio_device_info *vfio_get_device_info(int fd);
 int vfio_kvm_device_add_fd(int fd, Error **errp);
 int vfio_kvm_device_del_fd(int fd, Error **errp);
 
+bool vfio_arch_wants_loading_config_after_iter(void);
+
 #endif /* HW_VFIO_VFIO_HELPERS_H */
diff --git a/hw/vfio/vfio-migration-internal.h b/hw/vfio/vfio-migration-internal.h
index a8b456b239df8a54ab96daf56b5f778b3ffbfa5e..54141e27e6b2f86178b684759342fde2f270bf23 100644
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
index 1901a35aa90214c36369f8ac0b0cfef36acbbaa8..dac3fdce1539b19937870c0e38027e0a6b6ed1a9 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -67,6 +67,7 @@ typedef struct VFIODevice {
     bool ram_block_discard_allowed;
     OnOffAuto enable_migration;
     OnOffAuto migration_multifd_transfer;
+    OnOffAuto migration_load_config_after_iter;
     bool migration_events;
     bool use_region_fds;
     VFIODeviceOps *ops;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index e869821b224632fd56babc76c962c612d00e9eef..16640b700f2e16fbcf7acd5b151ecd93f289694c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -39,6 +39,7 @@
 
 GlobalProperty hw_compat_10_0[] = {
     { "scsi-hd", "dpofua", "off" },
+    { "vfio-pci", "x-migration-load-config-after-iter", "off" },
 };
 const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
 
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 9a5f62154554e1df36545b8c315b9ae25534d0fb..23d13e5db5f2cb10d6914c81497494a98775a78b 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -209,3 +209,20 @@ retry:
 
     return info;
 }
+
+bool vfio_arch_wants_loading_config_after_iter(void)
+{
+    /*
+     * Starting the config load only after all iterables were loaded (during
+     * non-iterables loading phase) is required for ARM64 due to this platform
+     * VFIO dependency on interrupt controller being loaded first.
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
diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index 55635486c8f185ec2e417c9403ea5dad82d10c18..e539befaa925ac739e3bc87ddb2abbb3d50f7cf5 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -23,6 +23,7 @@
 #include "migration-multifd.h"
 #include "vfio-migration-internal.h"
 #include "trace.h"
+#include "vfio-helpers.h"
 
 #define VFIO_DEVICE_STATE_CONFIG_STATE (1)
 
@@ -35,6 +36,18 @@ typedef struct VFIODeviceStatePacket {
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
+    return vfio_arch_wants_loading_config_after_iter();
+}
+
 /* type safety */
 typedef struct VFIOStateBuffers {
     GArray *array;
@@ -50,6 +63,9 @@ typedef struct VFIOMultifd {
     bool load_bufs_thread_running;
     bool load_bufs_thread_want_exit;
 
+    bool load_bufs_iter_done;
+    QemuCond load_bufs_iter_done_cond;
+
     VFIOStateBuffers load_bufs;
     QemuCond load_bufs_buffer_ready_cond;
     QemuCond load_bufs_thread_finished_cond;
@@ -394,6 +410,22 @@ static bool vfio_load_bufs_thread(void *opaque, bool *should_quit, Error **errp)
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
@@ -413,6 +445,48 @@ thread_exit:
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
@@ -425,6 +499,9 @@ static VFIOMultifd *vfio_multifd_new(void)
     multifd->load_buf_idx_last = UINT32_MAX;
     qemu_cond_init(&multifd->load_bufs_buffer_ready_cond);
 
+    multifd->load_bufs_iter_done = false;
+    qemu_cond_init(&multifd->load_bufs_iter_done_cond);
+
     multifd->load_bufs_thread_running = false;
     multifd->load_bufs_thread_want_exit = false;
     qemu_cond_init(&multifd->load_bufs_thread_finished_cond);
@@ -448,6 +525,7 @@ static void vfio_load_cleanup_load_bufs_thread(VFIOMultifd *multifd)
             multifd->load_bufs_thread_want_exit = true;
 
             qemu_cond_signal(&multifd->load_bufs_buffer_ready_cond);
+            qemu_cond_signal(&multifd->load_bufs_iter_done_cond);
             qemu_cond_wait(&multifd->load_bufs_thread_finished_cond,
                            &multifd->load_bufs_mutex);
         }
@@ -460,6 +538,7 @@ static void vfio_multifd_free(VFIOMultifd *multifd)
     vfio_load_cleanup_load_bufs_thread(multifd);
 
     qemu_cond_destroy(&multifd->load_bufs_thread_finished_cond);
+    qemu_cond_destroy(&multifd->load_bufs_iter_done_cond);
     vfio_state_buffers_destroy(&multifd->load_bufs);
     qemu_cond_destroy(&multifd->load_bufs_buffer_ready_cond);
     qemu_mutex_destroy(&multifd->load_bufs_mutex);
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index c329578eec31be00e754c15dbc7fc6e2932b1009..4c06e3db936a827acce4f51e3e9d344d0611378e 100644
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
index 910042c6c2049fc5ee1e635cc74989769b965b76..09acad002a47fd333d426cee2dcc9cacbbcb2e2f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3642,6 +3642,9 @@ static const Property vfio_pci_dev_properties[] = {
                 vbasedev.migration_multifd_transfer,
                 vfio_pci_migration_multifd_transfer_prop, OnOffAuto,
                 .set_default = true, .defval.i = ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("x-migration-load-config-after-iter", VFIOPCIDevice,
+                            vbasedev.migration_load_config_after_iter,
+                            ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
                      vbasedev.migration_events, false),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
@@ -3818,6 +3821,13 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
                                           "x-migration-multifd-transfer",
                                           "Transfer this device state via "
                                           "multifd channels when live migrating it");
+    object_class_property_set_description(klass, /* 10.1 */
+                                          "x-migration-load-config-after-iter",
+                                          "Start the config load only after "
+                                          "all iterables were loaded (during "
+                                          "non-iterables loading phase) when "
+                                          "doing live migration of device state "
+                                          "via multifd channels");
 }
 
 static const TypeInfo vfio_pci_dev_info = {
-- 
2.50.1


