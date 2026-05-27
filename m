Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71097CD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 06:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS7Zg-00048a-2m; Wed, 27 May 2026 02:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wS7ZM-0003wl-Ig
 for qemu-devel@nongnu.org; Wed, 27 May 2026 02:16:46 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wS7ZK-00041q-9D
 for qemu-devel@nongnu.org; Wed, 27 May 2026 02:16:43 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2925:0:640:1f39:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id E34EB80604;
 Wed, 27 May 2026 09:16:40 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:69::1:d])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QGSCNG0ZtGk0-OyVLrbmF; Wed, 27 May 2026 09:16:40 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779862600;
 bh=XocdcTcecnBxB/Sds6p3bzMTQMvxaXfbHbggfQ8XQGg=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=eaGKdDrsokQlEN6a9iKATpI2Ud3xmho6Yzwbt9+J8M0OHQLrJT7zrH1VGX65KBAYw
 MVPLyRXPI/owlv2oZRC1m2ub66wA+rMWYIqhDIE711KG0ipZ/GsMlloLUzM2nCNu5T
 5xgKRuj3Lxvum1Ueww0Qdlrg3nFjLvpPSi7EZB9M=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: [PATCH v7 13/22] vhost: move vrings mapping to the top of
 vhost_virtqueue_start()
Date: Wed, 27 May 2026 09:16:14 +0300
Message-ID: <20260527061625.11167-14-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260527061625.11167-1-vsementsov@yandex-team.ru>
References: <20260527061625.11167-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

This simplifies further refactoring and final introduction
of vhost backend live migration.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 hw/virtio/vhost.c | 45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index f43e563f0de..d5bafbcc4b3 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1303,29 +1303,6 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
         return 0;
     }
 
-    vq->num = state.num = virtio_queue_get_num(vdev, idx);
-    r = dev->vhost_ops->vhost_set_vring_num(dev, &state);
-    if (r) {
-        VHOST_OPS_DEBUG(r, "vhost_set_vring_num failed");
-        return r;
-    }
-
-    state.num = virtio_queue_get_last_avail_idx(vdev, idx);
-    r = dev->vhost_ops->vhost_set_vring_base(dev, &state);
-    if (r) {
-        VHOST_OPS_DEBUG(r, "vhost_set_vring_base failed");
-        return r;
-    }
-
-    if (vhost_needs_vring_endian(vdev)) {
-        r = vhost_virtqueue_set_vring_endian_legacy(dev,
-                                                    virtio_vdev_is_big_endian(vdev),
-                                                    vhost_vq_index);
-        if (r) {
-            return r;
-        }
-    }
-
     l = vq->desc_size;
     vq->desc = vhost_memory_map(dev, vq->desc_phys, l, false);
     if (!vq->desc) {
@@ -1347,6 +1324,28 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
         goto fail;
     }
 
+    vq->num = state.num = virtio_queue_get_num(vdev, idx);
+    r = dev->vhost_ops->vhost_set_vring_num(dev, &state);
+    if (r) {
+        VHOST_OPS_DEBUG(r, "vhost_set_vring_num failed");
+        goto fail;
+    }
+
+    state.num = virtio_queue_get_last_avail_idx(vdev, idx);
+    r = dev->vhost_ops->vhost_set_vring_base(dev, &state);
+    if (r) {
+        VHOST_OPS_DEBUG(r, "vhost_set_vring_base failed");
+        goto fail;
+    }
+
+    if (vhost_needs_vring_endian(vdev)) {
+        r = vhost_virtqueue_set_vring_endian_legacy(
+            dev, virtio_vdev_is_big_endian(vdev), vhost_vq_index);
+        if (r) {
+            goto fail;
+        }
+    }
+
     r = vhost_virtqueue_set_addr(dev, vq, vhost_vq_index, dev->log_enabled);
     if (r < 0) {
         goto fail;
-- 
2.52.0


