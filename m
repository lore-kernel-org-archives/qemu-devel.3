Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EB5CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 15:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v92xw-0007o3-18; Wed, 15 Oct 2025 10:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v92xo-0007nM-JL
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:58:54 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v92xd-0000eT-5D
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:58:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id D3B71C04DA;
 Wed, 15 Oct 2025 17:58:26 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id AwRFIp2FFSw0-UgIqORcV; Wed, 15 Oct 2025 17:58:26 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760540306;
 bh=1/S7iH6/rmUz2u1Y049C9XSMrpfPhGe2Jbh+LATmEaU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=TVBSZu2R4L5TRp29eCeOZ3M9cDD1TkIsbbCn+LikYo2XfTM0g8y8K7SKbAD6+l990
 jD3f7DBHw2WaZjzVb3p5eM3Fsj8znkU66cgX2zDaMeNwCeb5L2biF8ke8hOabBs0cP
 UQP0J6n14QzSCgkbDiU6IZXHHJkQ/pNP/yGOHd5o=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: [PATCH v3 18/23] vhost: introduce check_memslots() helper
Date: Wed, 15 Oct 2025 17:58:02 +0300
Message-ID: <20251015145808.1112843-19-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
References: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 hw/virtio/vhost.c | 71 ++++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 31 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 34846edf36..56a812b06b 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1572,12 +1572,50 @@ static int vhost_dev_get_features(struct vhost_dev *hdev,
     return r;
 }
 
+static bool check_memslots(struct vhost_dev *hdev, Error **errp)
+{
+    unsigned int used, reserved, limit;
+
+    limit = hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
+    if (limit < MEMORY_DEVICES_SAFE_MAX_MEMSLOTS &&
+        memory_devices_memslot_auto_decision_active()) {
+        error_setg(errp, "some memory device (like virtio-mem)"
+            " decided how many memory slots to use based on the overall"
+            " number of memory slots; this vhost backend would further"
+            " restricts the overall number of memory slots");
+        error_append_hint(errp, "Try plugging this vhost backend before"
+            " plugging such memory devices.\n");
+        return false;
+    }
+
+    /*
+     * The listener we registered properly setup the number of required
+     * memslots in vhost_commit().
+     */
+    used = hdev->mem->nregions;
+
+    /*
+     * We assume that all reserved memslots actually require a real memslot
+     * in our vhost backend. This might not be true, for example, if the
+     * memslot would be ROM. If ever relevant, we can optimize for that --
+     * but we'll need additional information about the reservations.
+     */
+    reserved = memory_devices_get_reserved_memslots();
+    if (used + reserved > limit) {
+        error_setg(errp, "vhost backend memory slots limit (%d) is less"
+                   " than current number of used (%d) and reserved (%d)"
+                   " memory slots for memory devices.", limit, used, reserved);
+        return false;
+    }
+
+    return true;
+}
+
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    Error **errp)
 {
     uint64_t features[VIRTIO_FEATURES_NU64S];
-    unsigned int used, reserved, limit;
     int i, r, n_initialized_vqs = 0;
 
     hdev->vdev = NULL;
@@ -1603,19 +1641,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    limit = hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
-    if (limit < MEMORY_DEVICES_SAFE_MAX_MEMSLOTS &&
-        memory_devices_memslot_auto_decision_active()) {
-        error_setg(errp, "some memory device (like virtio-mem)"
-            " decided how many memory slots to use based on the overall"
-            " number of memory slots; this vhost backend would further"
-            " restricts the overall number of memory slots");
-        error_append_hint(errp, "Try plugging this vhost backend before"
-            " plugging such memory devices.\n");
-        r = -EINVAL;
-        goto fail;
-    }
-
     for (i = 0; i < hdev->nvqs; ++i, ++n_initialized_vqs) {
         r = vhost_virtqueue_init(hdev, hdev->vqs + i, hdev->vq_index + i,
                                  busyloop_timeout);
@@ -1674,23 +1699,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     memory_listener_register(&hdev->memory_listener, &address_space_memory);
     QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
 
-    /*
-     * The listener we registered properly setup the number of required
-     * memslots in vhost_commit().
-     */
-    used = hdev->mem->nregions;
-
-    /*
-     * We assume that all reserved memslots actually require a real memslot
-     * in our vhost backend. This might not be true, for example, if the
-     * memslot would be ROM. If ever relevant, we can optimize for that --
-     * but we'll need additional information about the reservations.
-     */
-    reserved = memory_devices_get_reserved_memslots();
-    if (used + reserved > limit) {
-        error_setg(errp, "vhost backend memory slots limit (%d) is less"
-                   " than current number of used (%d) and reserved (%d)"
-                   " memory slots for memory devices.", limit, used, reserved);
+    if (!check_memslots(hdev, errp)) {
         r = -EINVAL;
         goto fail;
     }
-- 
2.48.1


