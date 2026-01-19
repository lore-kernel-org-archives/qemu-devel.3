Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECD7CCF2DE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 18:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhuNL-0006is-CA; Mon, 19 Jan 2026 13:53:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhuN1-0006KM-KD
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 13:53:01 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhuMy-0005tE-Qq
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 13:52:59 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:5c05:0:640:ff67:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 8E4D6804AA;
 Mon, 19 Jan 2026 21:52:55 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:934::1:38])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id dqetGa1BQGk0-6NWd5nzR; Mon, 19 Jan 2026 21:52:55 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768848775;
 bh=yy92i/R/x+g2ibDhvt5IEKEUExQYMCC8wTFRtov/6oU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=yxXpTq2UgLHi17n7ZKvHgsZZbnnJomaNoEANHj1HL7nfm3Z1PrE3+xK9tXVQ8KW0o
 gCGQQ5ZyEzx9sTmfU0BmSZfDPhLA0+dF+tlw2xYT1DH+Fq3WaWVLiyhYUtn1kQKZOC
 WhilpBg0DRRFMwt0QZvqd5YJc+flsIMve8SCwQi0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: [PATCH v4 14/23] vhost: move vrings mapping to the top of
 vhost_virtqueue_start()
Date: Mon, 19 Jan 2026 21:52:18 +0300
Message-ID: <20260119185228.203296-15-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119185228.203296-1-vsementsov@yandex-team.ru>
References: <20260119185228.203296-1-vsementsov@yandex-team.ru>
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
index 84937c8a67..06b0b34cd3 100644
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
@@ -1347,6 +1324,29 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
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


