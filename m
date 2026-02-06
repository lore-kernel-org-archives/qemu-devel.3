Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1079FEB28FE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 09:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voIXE-0001wa-BY; Fri, 06 Feb 2026 04:53:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1voIWl-0001mX-1u
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 04:53:30 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1voIWj-0000J8-DK
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 04:53:26 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1593:0:640:6beb:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 30FCD807A4;
 Fri, 06 Feb 2026 12:53:24 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:52d::1:1f])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2rKPQc0AN0U0-nT7yIeoy; Fri, 06 Feb 2026 12:53:23 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770371603;
 bh=McaUj7C7juJONfX1pthkIVKcqzza7THk4u91y7xBCpQ=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=CVQP8spUEniGLL3LuJfG2MWUOhYEYA0HLD1opxlLvaa2nPFEQIw+bX1XGSEpxwEdU
 5qXX4jk9crITqwVhNWY+ZzACoJQauBQO2gooIHGcY4SmSSEmGey2YrvLMj7A5mTUhM
 m8xaD47uNYziyux323/89j1maJOpA5TPjIfGsp8A=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: [PATCH v5 14/23] vhost: move vrings mapping to the top of
 vhost_virtqueue_start()
Date: Fri,  6 Feb 2026 12:52:48 +0300
Message-ID: <20260206095258.894504-15-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206095258.894504-1-vsementsov@yandex-team.ru>
References: <20260206095258.894504-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 hw/virtio/vhost.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 52453b36e3..e4cffd50d5 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1305,29 +1305,6 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
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
-                                                    virtio_is_big_endian(vdev),
-                                                    vhost_vq_index);
-        if (r) {
-            return r;
-        }
-    }
-
     l = vq->desc_size;
     vq->desc = vhost_memory_map(dev, vq->desc_phys, l, false);
     if (!vq->desc) {
@@ -1349,6 +1326,29 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
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
+        r = vhost_virtqueue_set_vring_endian_legacy(dev,
+                                                    virtio_is_big_endian(vdev),
+                                                    vhost_vq_index);
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


