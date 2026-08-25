Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DBFC61DC6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyr5-0005rb-J6; Tue, 25 Aug 2026 17:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyr4-0005qq-1F
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:50 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyr1-00054L-JM
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:49 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id C9717C0962;
 Wed, 26 Aug 2026 00:38:45 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:630::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QckKa93ZVmI0-vckao7wX; Wed, 26 Aug 2026 00:38:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787693924;
 bh=WaO6mGJnd0uh3kBRMN24TFmwKauhWEuTiFj3VFLgfHQ=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=o6eqIWzIwMYmhhtA/GsKaDrIHZ+fMvTZ8V2/5o9Veggcg6Gyb6LLwqfHP1mAunEn9
 +aUaqlfO8TdFzHoY5uEduyX9XKeT6EYWGKlPkNOCICFkd0u8LHWJumIFa75eatx09o
 UqOx/yvEImvUDa1Kr5AXEmQZ6KYMe2GS59X6Xd5I=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>
Subject: [PATCH 15/30] hw/net/virtio-net.c: use new migration APIs
Date: Wed, 26 Aug 2026 00:37:55 +0300
Message-ID: <20260825213811.3725682-16-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
References: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/net/virtio-net.c | 133 ++++++++++++++++++++++----------------------
 1 file changed, 66 insertions(+), 67 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 814b99a43d2..a48c87e2453 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3198,7 +3198,8 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
     }
 }
 
-static int virtio_net_post_load_device(void *opaque, int version_id)
+static bool virtio_net_post_load_device(void *opaque, int version_id,
+                                        Error **errp)
 {
     VirtIONet *n = opaque;
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
@@ -3261,7 +3262,7 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
     }
 
     virtio_net_commit_rss_config(n);
-    return 0;
+    return true;
 }
 
 static int virtio_net_post_load_virtio(VirtIODevice *vdev)
@@ -3327,7 +3328,7 @@ struct VirtIONetMigTmp {
  * pointer and count and also validate the count.
  */
 
-static int virtio_net_tx_waiting_pre_save(void *opaque)
+static bool virtio_net_tx_waiting_pre_save(void *opaque, Error **errp)
 {
     struct VirtIONetMigTmp *tmp = opaque;
 
@@ -3337,30 +3338,31 @@ static int virtio_net_tx_waiting_pre_save(void *opaque)
         tmp->curr_queue_pairs_1 = 0;
     }
 
-    return 0;
+    return true;
 }
 
-static int virtio_net_tx_waiting_pre_load(void *opaque)
+static bool virtio_net_tx_waiting_pre_load(void *opaque, Error **errp)
 {
     struct VirtIONetMigTmp *tmp = opaque;
 
     /* Reuse the pointer setup from save */
-    virtio_net_tx_waiting_pre_save(opaque);
+    /* TODO: handle the error in a follow-up patch */
+    virtio_net_tx_waiting_pre_save(opaque, NULL);
 
     if (tmp->parent->curr_queue_pairs > tmp->parent->max_queue_pairs) {
-        error_report("virtio-net: curr_queue_pairs %x > max_queue_pairs %x",
+        error_setg(errp, "virtio-net: curr_queue_pairs %x > max_queue_pairs %x",
             tmp->parent->curr_queue_pairs, tmp->parent->max_queue_pairs);
 
-        return -EINVAL;
+        return false;
     }
 
-    return 0; /* all good */
+    return true;
 }
 
 static const VMStateDescription vmstate_virtio_net_tx_waiting = {
     .name      = "virtio-net-tx_waiting",
-    .pre_load  = virtio_net_tx_waiting_pre_load,
-    .pre_save  = virtio_net_tx_waiting_pre_save,
+    .pre_load_errp = virtio_net_tx_waiting_pre_load,
+    .pre_save_errp = virtio_net_tx_waiting_pre_save,
     .fields    = (const VMStateField[]) {
         VMSTATE_STRUCT_VARRAY_POINTER_UINT16(vqs_1, struct VirtIONetMigTmp,
                                      curr_queue_pairs_1,
@@ -3373,31 +3375,31 @@ static const VMStateDescription vmstate_virtio_net_tx_waiting = {
 /* the 'has_ufo' flag is just tested; if the incoming stream has the
  * flag set we need to check that we have it
  */
-static int virtio_net_ufo_post_load(void *opaque, int version_id)
+static bool virtio_net_ufo_post_load(void *opaque, int version_id, Error **errp)
 {
     struct VirtIONetMigTmp *tmp = opaque;
 
     if (tmp->has_ufo && !peer_has_ufo(tmp->parent)) {
-        error_report("virtio-net: saved image requires TUN_F_UFO support");
-        return -EINVAL;
+        error_setg(errp, "virtio-net: saved image requires TUN_F_UFO support");
+        return false;
     }
 
-    return 0;
+    return true;
 }
 
-static int virtio_net_ufo_pre_save(void *opaque)
+static bool virtio_net_ufo_pre_save(void *opaque, Error **errp)
 {
     struct VirtIONetMigTmp *tmp = opaque;
 
     tmp->has_ufo = tmp->parent->has_ufo;
 
-    return 0;
+    return true;
 }
 
 static const VMStateDescription vmstate_virtio_net_has_ufo = {
     .name      = "virtio-net-ufo",
-    .post_load = virtio_net_ufo_post_load,
-    .pre_save  = virtio_net_ufo_pre_save,
+    .post_load_errp = virtio_net_ufo_post_load,
+    .pre_save_errp = virtio_net_ufo_pre_save,
     .fields    = (const VMStateField[]) {
         VMSTATE_UINT8(has_ufo, struct VirtIONetMigTmp),
         VMSTATE_END_OF_LIST()
@@ -3407,38 +3409,39 @@ static const VMStateDescription vmstate_virtio_net_has_ufo = {
 /* the 'has_vnet_hdr' flag is just tested; if the incoming stream has the
  * flag set we need to check that we have it
  */
-static int virtio_net_vnet_post_load(void *opaque, int version_id)
+static bool virtio_net_vnet_post_load(void *opaque, int version_id,
+                                      Error **errp)
 {
     struct VirtIONetMigTmp *tmp = opaque;
 
     if (tmp->has_vnet_hdr && !peer_has_vnet_hdr(tmp->parent)) {
-        error_report("virtio-net: saved image requires vnet_hdr=on");
-        return -EINVAL;
+        error_setg(errp, "virtio-net: saved image requires vnet_hdr=on");
+        return false;
     }
 
-    return 0;
+    return true;
 }
 
-static int virtio_net_vnet_pre_save(void *opaque)
+static bool virtio_net_vnet_pre_save(void *opaque, Error **errp)
 {
     struct VirtIONetMigTmp *tmp = opaque;
 
     tmp->has_vnet_hdr = tmp->parent->has_vnet_hdr;
 
-    return 0;
+    return true;
 }
 
 static const VMStateDescription vmstate_virtio_net_has_vnet = {
     .name      = "virtio-net-vnet",
-    .post_load = virtio_net_vnet_post_load,
-    .pre_save  = virtio_net_vnet_pre_save,
+    .post_load_errp = virtio_net_vnet_post_load,
+    .pre_save_errp = virtio_net_vnet_pre_save,
     .fields    = (const VMStateField[]) {
         VMSTATE_UINT32(has_vnet_hdr, struct VirtIONetMigTmp),
         VMSTATE_END_OF_LIST()
     },
 };
 
-static int virtio_net_rss_post_load(void *opaque, int version_id)
+static bool virtio_net_rss_post_load(void *opaque, int version_id, Error **errp)
 {
     VirtIONet *n = VIRTIO_NET(opaque);
 
@@ -3447,13 +3450,13 @@ static int virtio_net_rss_post_load(void *opaque, int version_id)
     }
 
     if (!virtio_net_rss_indirections_len_valid(n->rss_data.indirections_len)) {
-        error_report("virtio-net: saved image has invalid RSS "
-                     "indirections_len: %u",
-                     n->rss_data.indirections_len);
-        return -EINVAL;
+        error_setg(errp, "virtio-net: saved image has invalid RSS "
+                   "indirections_len: %u",
+                   n->rss_data.indirections_len);
+        return false;
     }
 
-    return 0;
+    return true;
 }
 
 static bool virtio_net_rss_needed(void *opaque)
@@ -3465,7 +3468,7 @@ static const VMStateDescription vmstate_virtio_net_rss = {
     .name      = "virtio-net-device/rss",
     .version_id = 2,
     .minimum_version_id = 1,
-    .post_load = virtio_net_rss_post_load,
+    .post_load_errp = virtio_net_rss_post_load,
     .needed = virtio_net_rss_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_BOOL(rss_data.enabled, VirtIONet),
@@ -3507,61 +3510,57 @@ static struct vhost_dev *virtio_net_get_vhost(VirtIODevice *vdev)
     return &net->dev;
 }
 
-static int vhost_user_net_save_state(QEMUFile *f, void *pv, size_t size,
-                                     const VMStateField *field,
-                                     JSONWriter *vmdesc)
+static bool vhost_user_net_save_state(QEMUFile *f, void *pv, size_t size,
+                                      const VMStateField *field,
+                                      JSONWriter *vmdesc, Error **errp)
 {
+    ERRP_GUARD();
     VirtIONet *n = pv;
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     struct vhost_dev *vhdev;
-    Error *local_error = NULL;
     int ret;
 
     vhdev = virtio_net_get_vhost(vdev);
     if (vhdev == NULL) {
-        error_reportf_err(local_error,
-                          "Error getting vhost back-end of %s device %s: ",
-                          vdev->name, vdev->parent_obj.canonical_path);
-        return -1;
+        error_setg(errp, "Error getting vhost back-end of %s device %s",
+                   vdev->name, vdev->parent_obj.canonical_path);
+        return false;
     }
 
-    ret = vhost_save_backend_state(vhdev, f, &local_error);
+    ret = vhost_save_backend_state(vhdev, f, errp);
     if (ret < 0) {
-        error_reportf_err(local_error,
-                          "Error saving back-end state of %s device %s: ",
-                          vdev->name, vdev->parent_obj.canonical_path);
-        return ret;
+        error_prepend(errp, "Error saving back-end state of %s device %s: ",
+                      vdev->name, vdev->parent_obj.canonical_path);
+        return false;
     }
 
-    return 0;
+    return true;
 }
 
-static int vhost_user_net_load_state(QEMUFile *f, void *pv, size_t size,
-                                     const VMStateField *field)
+static bool vhost_user_net_load_state(QEMUFile *f, void *pv, size_t size,
+                                      const VMStateField *field, Error **errp)
 {
+    ERRP_GUARD();
     VirtIONet *n = pv;
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     struct vhost_dev *vhdev;
-    Error *local_error = NULL;
     int ret;
 
     vhdev = virtio_net_get_vhost(vdev);
     if (vhdev == NULL) {
-        error_reportf_err(local_error,
-                          "Error getting vhost back-end of %s device %s: ",
-                          vdev->name, vdev->parent_obj.canonical_path);
-        return -1;
+        error_setg(errp, "Error getting vhost back-end of %s device %s",
+                   vdev->name, vdev->parent_obj.canonical_path);
+        return false;
     }
 
-    ret = vhost_load_backend_state(vhdev, f, &local_error);
+    ret = vhost_load_backend_state(vhdev, f, errp);
     if (ret < 0) {
-        error_reportf_err(local_error,
-                          "Error loading  back-end state of %s device %s: ",
-                          vdev->name, vdev->parent_obj.canonical_path);
-        return ret;
+        error_prepend(errp, "Error loading back-end state of %s device %s: ",
+                      vdev->name, vdev->parent_obj.canonical_path);
+        return false;
     }
 
-    return 0;
+    return true;
 }
 
 static bool vhost_user_net_is_internal_migration(void *opaque)
@@ -3587,8 +3586,8 @@ static const VMStateDescription vhost_user_net_backend_state = {
             .name = "backend",
             .info = &(const VMStateInfo) {
                 .name = "virtio-net vhost-user backend state",
-                .get = vhost_user_net_load_state,
-                .put = vhost_user_net_save_state,
+                .load = vhost_user_net_load_state,
+                .save = vhost_user_net_save_state,
             },
          },
          VMSTATE_END_OF_LIST()
@@ -3599,7 +3598,7 @@ static const VMStateDescription vmstate_virtio_net_device = {
     .name = "virtio-net-device",
     .version_id = VIRTIO_NET_VM_VERSION,
     .minimum_version_id = VIRTIO_NET_VM_VERSION,
-    .post_load = virtio_net_post_load_device,
+    .post_load_errp = virtio_net_post_load_device,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(mac, VirtIONet, ETH_ALEN),
         VMSTATE_STRUCT_POINTER(vqs, VirtIONet,
@@ -4169,7 +4168,7 @@ static void virtio_net_instance_init(Object *obj)
     ebpf_rss_init(&n->ebpf_rss);
 }
 
-static int virtio_net_pre_save(void *opaque)
+static bool virtio_net_pre_save(void *opaque, Error **errp)
 {
     VirtIONet *n = opaque;
 
@@ -4177,7 +4176,7 @@ static int virtio_net_pre_save(void *opaque)
      * it might keep writing to memory. */
     assert(!n->vhost_started);
 
-    return 0;
+    return true;
 }
 
 static bool primary_unplug_pending(void *opaque)
@@ -4210,7 +4209,7 @@ static const VMStateDescription vmstate_virtio_net = {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
-    .pre_save = virtio_net_pre_save,
+    .pre_save_errp = virtio_net_pre_save,
     .dev_unplug_pending = dev_unplug_pending,
 };
 
-- 
2.43.0


