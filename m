Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F93BCA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 16:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umEg5-00038p-0y; Wed, 13 Aug 2025 12:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfw-00030Y-OM; Wed, 13 Aug 2025 12:50:08 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfk-0007tu-Hi; Wed, 13 Aug 2025 12:50:07 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id BD302813EE;
 Wed, 13 Aug 2025 19:49:27 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:167::1:21])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id wmOQI00FoSw0-tyTiIsXB; Wed, 13 Aug 2025 19:49:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755103767;
 bh=ySTklhZeyl9879IHDj6pOytJKMMT2EjW0woilwTiBYw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=VUWTwCtS6WZ5e6lVny+K3mw/0Dr11WoxdBM0KS3vtRM80sB1mSpcT5Vqacgkbnb8H
 Dt/vscMqWcgJKsEjnUxvnP+l/FskCQYTcKKND2VrWfSOyM/X0EPp2R6vuI+XUpjlbt
 fRNwXnbNHPJWRuvtKJIapP6p5+Yd2eTOwWDfoUKs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net
Cc: sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru, vsementsov@yandex-team.ru
Subject: [PATCH 31/33] vhost-user-blk: support vhost backend migration
Date: Wed, 13 Aug 2025 19:48:52 +0300
Message-ID: <20250813164856.950363-32-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813164856.950363-1-vsementsov@yandex-team.ru>
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Opt-out backend initialization code, and instead get the state
from migration channel (including inflight region).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/block/vhost-user-blk.c          | 185 +++++++++++++++++++++++------
 include/hw/virtio/vhost-user-blk.h |   2 +
 migration/options.c                |   7 ++
 migration/options.h                |   1 +
 qapi/migration.json                |  15 ++-
 5 files changed, 169 insertions(+), 41 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index c8bc2c78e6..2e6ef6477e 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -17,6 +17,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi-types-run-state.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
@@ -32,6 +33,11 @@
 #include "system/system.h"
 #include "system/runstate.h"
 #include "trace.h"
+#include "migration/qemu-file.h"
+#include "migration/migration.h"
+#include "migration/options.h"
+#include "qemu/event_notifier.h"
+#include <sys/mman.h>
 
 static const int user_feature_bits[] = {
     VIRTIO_BLK_F_SIZE_MAX,
@@ -159,32 +165,35 @@ static int vhost_user_blk_start(VirtIODevice *vdev, Error **errp)
 
     s->dev.acked_features = vdev->guest_features;
 
-    ret = vhost_dev_prepare_inflight(&s->dev, vdev);
-    if (ret < 0) {
-        error_setg_errno(errp, -ret, "Error setting inflight format");
-        goto err_guest_notifiers;
-    }
-
-    if (!s->inflight->addr) {
-        ret = vhost_dev_get_inflight(&s->dev, s->queue_size, s->inflight);
+    if (!s->dev.migrating_backend) {
+        ret = vhost_dev_prepare_inflight(&s->dev, vdev);
         if (ret < 0) {
-            error_setg_errno(errp, -ret, "Error getting inflight");
+            error_setg_errno(errp, -ret, "Error setting inflight format");
             goto err_guest_notifiers;
         }
-    }
 
-    ret = vhost_dev_set_inflight(&s->dev, s->inflight);
-    if (ret < 0) {
-        error_setg_errno(errp, -ret, "Error setting inflight");
-        goto err_guest_notifiers;
-    }
+        if (!s->inflight->addr) {
+            ret = vhost_dev_get_inflight(&s->dev, s->queue_size, s->inflight);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "Error getting inflight");
+                goto err_guest_notifiers;
+            }
+        }
 
-    /* guest_notifier_mask/pending not used yet, so just unmask
-     * everything here. virtio-pci will do the right thing by
-     * enabling/disabling irqfd.
-     */
-    for (i = 0; i < s->dev.nvqs; i++) {
-        vhost_virtqueue_mask(&s->dev, vdev, i, false);
+        ret = vhost_dev_set_inflight(&s->dev, s->inflight);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Error setting inflight");
+            goto err_guest_notifiers;
+        }
+
+        /*
+         * guest_notifier_mask/pending not used yet, so just unmask
+         * everything here. virtio-pci will do the right thing by
+         * enabling/disabling irqfd.
+         */
+        for (i = 0; i < s->dev.nvqs; i++) {
+            vhost_virtqueue_mask(&s->dev, vdev, i, false);
+        }
     }
 
     s->dev.vq_index_end = s->dev.nvqs;
@@ -231,6 +240,10 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
     force_stop = s->skip_get_vring_base_on_force_shutdown &&
                  qemu_force_shutdown_requested();
 
+    s->dev.migrating_backend = s->dev.migrating_backend ||
+        (runstate_check(RUN_STATE_FINISH_MIGRATE) &&
+         migrate_local_vhost_user_blk());
+
     ret = force_stop ? vhost_dev_force_stop(&s->dev, vdev, true) :
                        vhost_dev_stop(&s->dev, vdev, true);
 
@@ -343,7 +356,9 @@ static void vhost_user_blk_reset(VirtIODevice *vdev)
     vhost_dev_free_inflight(s->inflight);
 }
 
-static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
+static int vhost_user_blk_connect(DeviceState *dev,
+                                  bool migrating_backend,
+                                  Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
@@ -359,6 +374,7 @@ static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
     s->dev.nvqs = s->num_queues;
     s->dev.vqs = s->vhost_vqs;
     s->dev.vq_index = 0;
+    s->dev.migrating_backend = migrating_backend;
 
     vhost_dev_set_config_notifier(&s->dev, &blk_ops);
 
@@ -409,7 +425,7 @@ static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
 
     switch (event) {
     case CHR_EVENT_OPENED:
-        if (vhost_user_blk_connect(dev, &local_err) < 0) {
+        if (vhost_user_blk_connect(dev, false, &local_err) < 0) {
             error_report_err(local_err);
             qemu_chr_fe_disconnect(&s->chardev);
             return;
@@ -428,31 +444,37 @@ static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
     }
 }
 
-static int vhost_user_blk_realize_connect(VHostUserBlk *s, Error **errp)
+static int vhost_user_blk_realize_connect(VHostUserBlk *s,
+                                          bool migrating_backend,
+                                          Error **errp)
 {
     DeviceState *dev = DEVICE(s);
     int ret;
 
     s->connected = false;
 
-    ret = qemu_chr_fe_wait_connected(&s->chardev, errp);
-    if (ret < 0) {
-        return ret;
+    if (!migrating_backend) {
+        ret = qemu_chr_fe_wait_connected(&s->chardev, errp);
+        if (ret < 0) {
+            return ret;
+        }
     }
 
-    ret = vhost_user_blk_connect(dev, errp);
+    ret = vhost_user_blk_connect(dev, migrating_backend, errp);
     if (ret < 0) {
         qemu_chr_fe_disconnect(&s->chardev);
         return ret;
     }
     assert(s->connected);
 
-    ret = vhost_dev_get_config(&s->dev, (uint8_t *)&s->blkcfg,
-                               VIRTIO_DEVICE(s)->config_len, errp);
-    if (ret < 0) {
-        qemu_chr_fe_disconnect(&s->chardev);
-        vhost_dev_cleanup(&s->dev);
-        return ret;
+    if (!migrating_backend) {
+        ret = vhost_dev_get_config(&s->dev, (uint8_t *)&s->blkcfg,
+                                   VIRTIO_DEVICE(s)->config_len, errp);
+        if (ret < 0) {
+            qemu_chr_fe_disconnect(&s->chardev);
+            vhost_dev_cleanup(&s->dev);
+            return ret;
+        }
     }
 
     return 0;
@@ -469,6 +491,11 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
 
     trace_vhost_user_blk_device_realize();
 
+    if (s->incoming_backend && !runstate_check(RUN_STATE_INMIGRATE)) {
+        error_setg(errp, "__yc_local-incoming can be used "
+                   "only for incoming migration");
+    }
+
     if (!s->chardev.chr) {
         error_setg(errp, "chardev is mandatory");
         return;
@@ -517,7 +544,7 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
             error_report_err(*errp);
             *errp = NULL;
         }
-        ret = vhost_user_blk_realize_connect(s, errp);
+        ret = vhost_user_blk_realize_connect(s, s->incoming_backend, errp);
     } while (ret < 0 && retries--);
 
     if (ret < 0) {
@@ -525,9 +552,12 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
     }
 
     /* we're fully initialized, now we can operate, so add the handler */
-    qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL,
-                             vhost_user_blk_event, NULL, (void *)dev,
-                             NULL, true);
+    if (!s->incoming_backend) {
+        qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL,
+                                 vhost_user_blk_event, NULL, (void *)dev,
+                                 NULL, true);
+    }
+
     trace_vhost_user_blk_device_realize_finish();
     return;
 
@@ -592,6 +622,79 @@ static const VMStateDescription vmstate_vhost_user_blk = {
     },
 };
 
+static void vhost_user_blk_save(VirtIODevice *vdev, QEMUFile *f)
+{
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+    struct vhost_dev *hdev = vhost_user_blk_get_vhost(vdev);
+
+    if (!hdev->migrating_backend) {
+        return;
+    }
+
+    qemu_file_put_fd(f, s->inflight->fd);
+    qemu_put_be64(f, s->inflight->size);
+    qemu_put_be64(f, s->inflight->offset);
+    qemu_put_be16(f, s->inflight->queue_size);
+
+    vhost_save_backend(hdev, f);
+}
+
+static int vhost_user_blk_load(VirtIODevice *vdev, QEMUFile *f,
+                                      int version_id)
+{
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+    struct vhost_dev *hdev = vhost_user_blk_get_vhost(vdev);
+
+    if (!hdev->migrating_backend) {
+        return 0;
+    }
+
+    s->inflight->fd = qemu_file_get_fd(f);
+    qemu_get_be64s(f, &s->inflight->size);
+    qemu_get_be64s(f, &s->inflight->offset);
+    qemu_get_be16s(f, &s->inflight->queue_size);
+
+    s->inflight->addr = mmap(0, s->inflight->size, PROT_READ | PROT_WRITE,
+                             MAP_SHARED, s->inflight->fd, s->inflight->offset);
+    if (s->inflight->addr == MAP_FAILED) {
+        return -EINVAL;
+    }
+
+    vhost_load_backend(hdev, f);
+
+    return 0;
+}
+
+static int vhost_user_blk_post_load(VirtIODevice *vdev)
+{
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+    struct vhost_dev *hdev = vhost_user_blk_get_vhost(vdev);
+    DeviceState *dev = &s->parent_obj.parent_obj;
+
+    if (!hdev->migrating_backend) {
+        return 0;
+    }
+
+    memcpy(&s->blkcfg, vdev->config, vdev->config_len);
+
+    /* we're fully initialized, now we can operate, so add the handler */
+    qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL,
+                             vhost_user_blk_event, NULL, (void *)dev,
+                             NULL, true);
+
+    return 0;
+}
+
+static bool vhost_user_blk_skip_migration_log(VirtIODevice *vdev)
+{
+    /*
+     * Note that hdev->migrating_backend is false at this moment,
+     * as logging is being setup during outging migration setup stage,
+     * which is far before vm stop.
+     */
+    return migrate_local_vhost_user_blk();
+}
+
 static const Property vhost_user_blk_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
     DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues,
@@ -605,6 +708,8 @@ static const Property vhost_user_blk_properties[] = {
                       VIRTIO_BLK_F_WRITE_ZEROES, true),
     DEFINE_PROP_BOOL("skip-get-vring-base-on-force-shutdown", VHostUserBlk,
                      skip_get_vring_base_on_force_shutdown, false),
+    DEFINE_PROP_BOOL("local-incoming", VHostUserBlk,
+                     incoming_backend, false),
 };
 
 static void vhost_user_blk_class_init(ObjectClass *klass, const void *data)
@@ -624,6 +729,10 @@ static void vhost_user_blk_class_init(ObjectClass *klass, const void *data)
     vdc->set_status = vhost_user_blk_set_status;
     vdc->reset = vhost_user_blk_reset;
     vdc->get_vhost = vhost_user_blk_get_vhost;
+    vdc->save = vhost_user_blk_save;
+    vdc->load = vhost_user_blk_load;
+    vdc->post_load = vhost_user_blk_post_load,
+    vdc->skip_vhost_migration_log = vhost_user_blk_skip_migration_log;
 }
 
 static const TypeInfo vhost_user_blk_info = {
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
index a10f785672..b06f55fd6f 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -52,6 +52,8 @@ struct VHostUserBlk {
     bool started_vu;
 
     bool skip_get_vring_base_on_force_shutdown;
+
+    bool incoming_backend;
 };
 
 #endif
diff --git a/migration/options.c b/migration/options.c
index dffb6910f4..11b719c81b 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -269,6 +269,13 @@ bool migrate_local_char_socket(void)
     return s->capabilities[MIGRATION_CAPABILITY_LOCAL_CHAR_SOCKET];
 }
 
+bool migrate_local_vhost_user_blk(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->capabilities[MIGRATION_CAPABILITY_LOCAL_VHOST_USER_BLK];
+}
+
 bool migrate_ignore_shared(void)
 {
     MigrationState *s = migrate_get_current();
diff --git a/migration/options.h b/migration/options.h
index 40971f0aa0..5a40ac073d 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -31,6 +31,7 @@ bool migrate_dirty_bitmaps(void);
 bool migrate_events(void);
 bool migrate_mapped_ram(void);
 bool migrate_local_char_socket(void);
+bool migrate_local_vhost_user_blk(void);
 bool migrate_ignore_shared(void);
 bool migrate_late_block_activate(void);
 bool migrate_multifd(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index 4f282d168e..ead7f4d17c 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -520,11 +520,19 @@
 # @local-char-socket: Migrate socket chardevs open file descriptors.
 #     Only may be used when migration channel is unix socket. Only
 #     involves socket chardevs with "support-local-migration" option
-#     enabled.  (since 10.2)
+#     enabled. For target device also @local-incoming option must
+#     be specified (since 10.2)
+#
+# @local-vhost-user-blk: Migrate vhost-user-blk locally, keeping
+#     backend alive. Open file descriptors and backend-related state are
+#     migrated. Only may be used when migration channel is unix socket.
+#     For target device also @local-incoming option must be specified
+#     (since 10.2)
 #
 # Features:
 #
-# @unstable: Members @x-colo and @x-ignore-shared are experimental.
+# @unstable: Members @x-colo, @x-ignore-shared, @local-char-socket,
+#     @local-vhost-user-blk are experimental.
 # @deprecated: Member @zero-blocks is deprecated as being part of
 #     block migration which was already removed.
 #
@@ -542,7 +550,8 @@
            'validate-uuid', 'background-snapshot',
            'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
            'dirty-limit', 'mapped-ram',
-           { 'name': 'local-char-socket', 'features': [ 'unstable' ] } ] }
+           { 'name': 'local-char-socket', 'features': [ 'unstable' ] },
+           { 'name': 'local-vhost-user-blk', 'features': [ 'unstable' ] } ] }
 
 ##
 # @MigrationCapabilityStatus:
-- 
2.48.1


