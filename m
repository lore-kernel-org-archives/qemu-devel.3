Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426A1CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 11:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MNf-0007WL-99; Thu, 16 Oct 2025 07:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MNO-0007JQ-Ew; Thu, 16 Oct 2025 07:42:37 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MNA-0003Wa-RW; Thu, 16 Oct 2025 07:42:32 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 0C04EC01C7;
 Thu, 16 Oct 2025 14:41:42 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a8c::1:19])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LfP2M73FEmI0-bUjaRCUF; Thu, 16 Oct 2025 14:41:41 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760614901;
 bh=FQa5UwKvUo2fp+LZPlQdGfhHVLkM6RfOrSZz/WATnZE=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=bKsCtGNDsy2GQ5rtZH+POpEx6fc2lSDcX+oeGoWhgLAKmilMVIyj59UOnpH7ezMfm
 u7J10LBBDQEYhdDIKsOLrArWqZ1+Gmh0Pnr2IkfTHebSVc0CYL8sX1Hljt5gdi+WXj
 fYIWtDqkC6JwqOKCMzbS8rpFGnSqBY+FjzB/gzsE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: raphael@enfabrica.net,
	pbonzini@redhat.com,
	farosas@suse.de
Cc: mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, jasowang@redhat.com
Subject: [PATCH v2 24/25] vhost-user-blk: support vhost backend migration
Date: Thu, 16 Oct 2025 14:41:01 +0300
Message-ID: <20251016114104.1384675-25-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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
 hw/block/vhost-user-blk.c          | 129 ++++++++++++++++++++++++-----
 include/hw/virtio/vhost-user-blk.h |   2 +
 include/hw/virtio/vhost.h          |   3 +-
 3 files changed, 111 insertions(+), 23 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index ffdd600526..a8fd90480a 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -17,6 +17,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi-types-run-state.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
@@ -31,7 +32,13 @@
 #include "hw/virtio/virtio-access.h"
 #include "system/system.h"
 #include "system/runstate.h"
+#include "chardev/char-backend-transfer.h"
 #include "trace.h"
+#include "migration/qemu-file.h"
+#include "migration/migration.h"
+#include "migration/options.h"
+#include "qemu/event_notifier.h"
+#include <sys/mman.h>
 
 static const int user_feature_bits[] = {
     VIRTIO_BLK_F_SIZE_MAX,
@@ -160,32 +167,35 @@ static int vhost_user_blk_start(VirtIODevice *vdev, Error **errp)
 
     s->dev.acked_features = vdev->guest_features;
 
-    ret = vhost_dev_prepare_inflight(&s->dev, vdev);
-    if (ret < 0) {
-        error_setg_errno(errp, -ret, "Error setting inflight format");
-        goto err_guest_notifiers;
-    }
-
-    if (!s->inflight->addr) {
-        ret = vhost_dev_get_inflight(&s->dev, s->queue_size, s->inflight);
+    if (!s->dev.backend_transfer) {
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
@@ -232,6 +242,10 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
     force_stop = s->skip_get_vring_base_on_force_shutdown &&
                  qemu_force_shutdown_requested();
 
+    s->dev.backend_transfer = s->dev.backend_transfer ||
+        (runstate_check(RUN_STATE_FINISH_MIGRATE) &&
+         migrate_local_vhost_user_blk());
+
     ret = force_stop ? vhost_dev_force_stop(&s->dev, vdev, true) :
                        vhost_dev_stop(&s->dev, vdev, true);
 
@@ -391,6 +405,7 @@ static int vhost_user_blk_connect(DeviceState *dev,
     trace_vhost_user_blk_connect_in(vdev);
 
     assert(!s->connected);
+    assert(!s->dev.backend_transfer);
 
     ret = vhost_dev_connect(&s->dev, errp);
     if (ret < 0) {
@@ -464,6 +479,9 @@ static int vhost_user_blk_realize_connect(VHostUserBlk *s, Error **errp)
     DeviceState *dev = DEVICE(s);
     int ret;
 
+    assert(!s->connected);
+    assert(!s->dev.backend_transfer);
+
     ret = qemu_chr_fe_wait_connected(&s->chardev, errp);
     if (ret < 0) {
         return ret;
@@ -642,7 +660,13 @@ static bool vhost_user_blk_pre_incoming(void *opaque, Error **errp)
 {
     VHostUserBlk *s = VHOST_USER_BLK(opaque);
 
-    return vhost_user_blk_realize_connect(s, errp) == 0;
+    s->dev.backend_transfer = migrate_local_vhost_user_blk();
+
+    if (!s->dev.backend_transfer) {
+        return vhost_user_blk_realize_connect_loop(s, errp) >= 0;
+    }
+
+    return true;
 }
 
 static const VMStateDescription vmstate_vhost_user_blk = {
@@ -656,6 +680,64 @@ static const VMStateDescription vmstate_vhost_user_blk = {
     },
 };
 
+static bool vhost_user_needed(void *opaque)
+{
+    return migrate_local_vhost_user_blk();
+}
+
+static const VMStateDescription vmstate_vhost_user_blk_device = {
+    .name = "vhost-user-blk-device",
+    .version_id = 1,
+    .needed = vhost_user_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BACKEND_TRANSFER_CHARDEV(chardev, VHostUserBlk),
+        VMSTATE_BACKEND_TRANSFER_VHOST_INFLIGHT(inflight, VHostUserBlk),
+        VMSTATE_BACKEND_TRANSFER_VHOST_USER(dev, VHostUserBlk),
+        VMSTATE_BACKEND_TRANSFER_VHOST(dev, VHostUserBlk),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static int vhost_user_blk_post_load(VirtIODevice *vdev)
+{
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+    struct vhost_dev *hdev = vhost_user_blk_get_vhost(vdev);
+    DeviceState *dev = &s->parent_obj.parent_obj;
+
+    if (!hdev->backend_transfer) {
+        return 0;
+    }
+
+    s->connected = true;
+
+    memcpy(&s->blkcfg, vdev->config, vdev->config_len);
+
+    if (virtio_device_started(vdev, vdev->status)) {
+        int ret;
+        ret = vhost_user_blk_start(vdev, NULL);
+        if (ret < 0) {
+            return ret;
+        }
+    }
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
     DEFINE_PROP_CHR_NO_CONNECT("chardev", VHostUserBlk, chardev),
     DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues,
@@ -688,6 +770,9 @@ static void vhost_user_blk_class_init(ObjectClass *klass, const void *data)
     vdc->set_status = vhost_user_blk_set_status;
     vdc->reset = vhost_user_blk_reset;
     vdc->get_vhost = vhost_user_blk_get_vhost;
+    vdc->vmsd = &vmstate_vhost_user_blk_device;
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
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 55ad822848..13ca2c319f 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -592,7 +592,8 @@ static inline int vhost_load_backend_state(struct vhost_dev *dev, QEMUFile *f,
 
 extern const VMStateDescription vmstate_backend_transfer_vhost_inflight;
 #define VMSTATE_BACKEND_TRANSFER_VHOST_INFLIGHT(_field, _state) \
-    VMSTATE_STRUCT_POINTER(_field, _state, vmstate_inflight, \
+    VMSTATE_STRUCT_POINTER(_field, _state, \
+                           vmstate_backend_transfer_vhost_inflight, \
                            struct vhost_inflight)
 
 extern const VMStateDescription vmstate_vhost_dev;
-- 
2.48.1


