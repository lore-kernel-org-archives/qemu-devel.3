Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE482CCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDstX-0002z9-F3; Tue, 28 Oct 2025 19:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstW-0002yj-JJ
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:26 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstK-00017d-Pe
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:25 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 04E4E8176E;
 Wed, 29 Oct 2025 02:14:02 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oDnXpg2bCW20-HHYfGBkN; Wed, 29 Oct 2025 02:14:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761693241;
 bh=W4FzO8lSWOUPXV+V8oEsi7uae9/GNQt9LV+s1RTTQo8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ugf1XKvz7j/KB31uVvLcl+9OerbmToJtgi1rx1FAVYhXFdhItHtHdrZ3tKdbtge8t
 woaW11Vx913JKmoem3TSLqkfFPp28ZH7Pi7zAv4B8MoLV+vn9wcbZ6yjPRvR1ZgU9v
 AVaEMx1Tk9CkqWlB+IJTduA+ItFB6KzHp6qSJNC8=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: armbru@redhat.com,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [RFC 14/22] hw/net/virtio-net.c: use new migration APIs
Date: Wed, 29 Oct 2025 02:13:38 +0300
Message-ID: <20251028231347.194844-15-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251028231347.194844-1-vsementsov@yandex-team.ru>
References: <20251028231347.194844-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/net/virtio-net.c | 118 +++++++++++++++++++++-----------------------
 1 file changed, 55 insertions(+), 63 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 33116712eb..23be0e3047 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3180,7 +3180,8 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
     }
 }
 
-static int virtio_net_post_load_device(void *opaque, int version_id)
+static bool virtio_net_post_load_device(void *opaque, int version_id,
+                                        Error **errp)
 {
     VirtIONet *n = opaque;
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
@@ -3243,7 +3244,7 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
     }
 
     virtio_net_commit_rss_config(n);
-    return 0;
+    return true;
 }
 
 static int virtio_net_post_load_virtio(VirtIODevice *vdev)
@@ -3309,7 +3310,7 @@ struct VirtIONetMigTmp {
  * pointer and count and also validate the count.
  */
 
-static int virtio_net_tx_waiting_pre_save(void *opaque)
+static bool virtio_net_tx_waiting_pre_save(void *opaque, Error **errp)
 {
     struct VirtIONetMigTmp *tmp = opaque;
 
@@ -3319,30 +3320,30 @@ static int virtio_net_tx_waiting_pre_save(void *opaque)
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
+    virtio_net_tx_waiting_pre_save(opaque, &error_abort);
 
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
@@ -3355,31 +3356,31 @@ static const VMStateDescription vmstate_virtio_net_tx_waiting = {
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
@@ -3389,38 +3390,39 @@ static const VMStateDescription vmstate_virtio_net_has_ufo = {
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
 
@@ -3428,7 +3430,7 @@ static int virtio_net_rss_post_load(void *opaque, int version_id)
         n->rss_data.supported_hash_types = VIRTIO_NET_RSS_SUPPORTED_HASHES;
     }
 
-    return 0;
+    return true;
 }
 
 static bool virtio_net_rss_needed(void *opaque)
@@ -3440,7 +3442,7 @@ static const VMStateDescription vmstate_virtio_net_rss = {
     .name      = "virtio-net-device/rss",
     .version_id = 2,
     .minimum_version_id = 1,
-    .post_load = virtio_net_rss_post_load,
+    .post_load_errp = virtio_net_rss_post_load,
     .needed = virtio_net_rss_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_BOOL(rss_data.enabled, VirtIONet),
@@ -3482,61 +3484,51 @@ static struct vhost_dev *virtio_net_get_vhost(VirtIODevice *vdev)
     return &net->dev;
 }
 
-static int vhost_user_net_save_state(QEMUFile *f, void *pv, size_t size,
-                                     const VMStateField *field,
-                                     JSONWriter *vmdesc)
+static bool vhost_user_net_save_state(QEMUFile *f, void *pv, size_t size,
+                                      const VMStateField *field,
+                                      JSONWriter *vmdesc, Error **errp)
 {
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
+        return false;
     }
 
-    return 0;
+    return true;
 }
 
 static bool vhost_user_net_is_internal_migration(void *opaque)
@@ -3562,8 +3554,8 @@ static const VMStateDescription vhost_user_net_backend_state = {
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
@@ -3574,7 +3566,7 @@ static const VMStateDescription vmstate_virtio_net_device = {
     .name = "virtio-net-device",
     .version_id = VIRTIO_NET_VM_VERSION,
     .minimum_version_id = VIRTIO_NET_VM_VERSION,
-    .post_load = virtio_net_post_load_device,
+    .post_load_errp = virtio_net_post_load_device,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(mac, VirtIONet, ETH_ALEN),
         VMSTATE_STRUCT_POINTER(vqs, VirtIONet,
@@ -4144,7 +4136,7 @@ static void virtio_net_instance_init(Object *obj)
     ebpf_rss_init(&n->ebpf_rss);
 }
 
-static int virtio_net_pre_save(void *opaque)
+static bool virtio_net_pre_save(void *opaque, Error **errp)
 {
     VirtIONet *n = opaque;
 
@@ -4152,7 +4144,7 @@ static int virtio_net_pre_save(void *opaque)
      * it might keep writing to memory. */
     assert(!n->vhost_started);
 
-    return 0;
+    return true;
 }
 
 static bool primary_unplug_pending(void *opaque)
@@ -4185,7 +4177,7 @@ static const VMStateDescription vmstate_virtio_net = {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
-    .pre_save = virtio_net_pre_save,
+    .pre_save_errp = virtio_net_pre_save,
     .dev_unplug_pending = dev_unplug_pending,
 };
 
-- 
2.48.1


