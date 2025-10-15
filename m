Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75EECCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 15:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v92xc-0007k4-VW; Wed, 15 Oct 2025 10:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v92xZ-0007j2-J8
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:58:37 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v92xR-0000dc-Dx
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:58:37 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 3C3A4C0696;
 Wed, 15 Oct 2025 17:58:23 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id AwRFIp2FFSw0-P4BuoXCB; Wed, 15 Oct 2025 17:58:22 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760540302;
 bh=Zn2ruQ+ylWQSJvvrnKTYr451ZPn/rZw3F/HGccRpHf0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ByVQemZrc9VIGtkYiATwbbGC2rH3ilD5KnvusmNU7BnlY4ZFclOsGHt0mPim3f/T6
 Bomxk/Y+KzsOplS924k+3W88RY8zZCrnvDNYnm2rT6A5NcjbyeeLgRwcO1UOPab+lx
 7A0M2iHz2ZZ+TPLmDnQ3f7c6w/CtilQQtWhHzUsA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: [PATCH v3 13/23] vhost: move vrings mapping to the top of
 vhost_virtqueue_start()
Date: Wed, 15 Oct 2025 17:57:57 +0300
Message-ID: <20251015145808.1112843-14-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
References: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
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

This simplifies further refactoring and final introduction
of vhost backend live migration.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 hw/virtio/vhost.c | 47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index c8ec6b4911..db93b93fb1 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1292,30 +1292,6 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
         /* Queue might not be ready for start */
         return 0;
     }
-
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
     vq->desc_size = l = virtio_queue_get_desc_size(vdev, idx);
     vq->desc_phys = a;
     vq->desc = vhost_memory_map(dev, a, l, false);
@@ -1338,6 +1314,29 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
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
2.48.1


