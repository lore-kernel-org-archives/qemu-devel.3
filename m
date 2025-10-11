Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565FECCD184
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 23:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7iwr-0006Dm-4b; Sat, 11 Oct 2025 19:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7iwn-0006Br-UK
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 19:24:22 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7iwm-0000t8-3Y
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 19:24:21 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id C4ABBC01DC;
 Sun, 12 Oct 2025 02:24:18 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 6OWMXt1FjqM0-AOZ2PORW; Sun, 12 Oct 2025 02:24:18 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760225058;
 bh=lnmrNOdH9PiRJ6qfAMMgLMUKPbunmPfqaClpCsSkPRM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=rBrkvocJrduEtCy2znmVy7Mkr7KS6qt04/5JeJoj+cx7CV1gHyuD25o1sMry2YWSX
 ZrCBDfPki6SdU/TRWc5X34CrX9wp930tTFTYD5y/Xpln9K1gfihbMcqXJ8oDIbpR4n
 zkOmegFyHP9QZrrxA7cSpwMz2MUxoohz1hOBYL/w=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 raphael.s.norwitz@gmail.com, vsementsov@yandex-team.ru,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: [PATCH v2 11/23] vhost: make vhost_memory_unmap() null-safe
Date: Sun, 12 Oct 2025 02:23:50 +0300
Message-ID: <20251011232404.561024-12-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011232404.561024-1-vsementsov@yandex-team.ru>
References: <20251011232404.561024-1-vsementsov@yandex-team.ru>
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

This helps to simplify failure paths of vhost_virtqueue_start()
a lot. We also need to zero-out pointers on unmap, to not try
to unmap invalid pointers.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 8031c74e7b..6fec193d5f 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -472,14 +472,20 @@ static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
     }
 }
 
-static void vhost_memory_unmap(struct vhost_dev *dev, void *buffer,
+static void vhost_memory_unmap(struct vhost_dev *dev, void **buffer,
                                hwaddr len, int is_write,
                                hwaddr access_len)
 {
+    if (!*buffer) {
+        return;
+    }
+
     if (!vhost_dev_has_iommu(dev)) {
-        address_space_unmap(dev->vdev->dma_as, buffer, len, is_write,
+        address_space_unmap(dev->vdev->dma_as, *buffer, len, is_write,
                             access_len);
     }
+
+    *buffer = NULL;
 }
 
 static int vhost_verify_ring_part_mapping(void *ring_hva,
@@ -1315,33 +1321,33 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
     vq->desc = vhost_memory_map(dev, a, l, false);
     if (!vq->desc) {
         r = -ENOMEM;
-        goto fail_alloc_desc;
+        goto fail;
     }
     vq->avail_size = l = virtio_queue_get_avail_size(vdev, idx);
     vq->avail_phys = a = virtio_queue_get_avail_addr(vdev, idx);
     vq->avail = vhost_memory_map(dev, a, l, false);
     if (!vq->avail) {
         r = -ENOMEM;
-        goto fail_alloc_avail;
+        goto fail;
     }
     vq->used_size = l = virtio_queue_get_used_size(vdev, idx);
     vq->used_phys = a = virtio_queue_get_used_addr(vdev, idx);
     vq->used = vhost_memory_map(dev, a, l, true);
     if (!vq->used) {
         r = -ENOMEM;
-        goto fail_alloc_used;
+        goto fail;
     }
 
     r = vhost_virtqueue_set_addr(dev, vq, vhost_vq_index, dev->log_enabled);
     if (r < 0) {
-        goto fail_alloc;
+        goto fail;
     }
 
     file.fd = event_notifier_get_fd(virtio_queue_get_host_notifier(vvq));
     r = dev->vhost_ops->vhost_set_vring_kick(dev, &file);
     if (r) {
         VHOST_OPS_DEBUG(r, "vhost_set_vring_kick failed");
-        goto fail_kick;
+        goto fail;
     }
 
     /* Clear and discard previous events if any. */
@@ -1361,24 +1367,19 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
         file.fd = -1;
         r = dev->vhost_ops->vhost_set_vring_call(dev, &file);
         if (r) {
-            goto fail_vector;
+            goto fail;
         }
     }
 
     return 0;
 
-fail_vector:
-fail_kick:
-fail_alloc:
-    vhost_memory_unmap(dev, vq->used, virtio_queue_get_used_size(vdev, idx),
+fail:
+    vhost_memory_unmap(dev, &vq->used, virtio_queue_get_used_size(vdev, idx),
                        0, 0);
-fail_alloc_used:
-    vhost_memory_unmap(dev, vq->avail, virtio_queue_get_avail_size(vdev, idx),
+    vhost_memory_unmap(dev, &vq->avail, virtio_queue_get_avail_size(vdev, idx),
                        0, 0);
-fail_alloc_avail:
-    vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, idx),
+    vhost_memory_unmap(dev, &vq->desc, virtio_queue_get_desc_size(vdev, idx),
                        0, 0);
-fail_alloc_desc:
     return r;
 }
 
@@ -1425,11 +1426,11 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
                                                 vhost_vq_index);
     }
 
-    vhost_memory_unmap(dev, vq->used, virtio_queue_get_used_size(vdev, idx),
+    vhost_memory_unmap(dev, &vq->used, virtio_queue_get_used_size(vdev, idx),
                        1, virtio_queue_get_used_size(vdev, idx));
-    vhost_memory_unmap(dev, vq->avail, virtio_queue_get_avail_size(vdev, idx),
+    vhost_memory_unmap(dev, &vq->avail, virtio_queue_get_avail_size(vdev, idx),
                        0, virtio_queue_get_avail_size(vdev, idx));
-    vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, idx),
+    vhost_memory_unmap(dev, &vq->desc, virtio_queue_get_desc_size(vdev, idx),
                        0, virtio_queue_get_desc_size(vdev, idx));
     return r;
 }
-- 
2.48.1


