Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED083CCF2DE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 18:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhuNG-0006eg-BY; Mon, 19 Jan 2026 13:53:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhuN0-0006IP-Es
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 13:52:59 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhuMx-0005sq-D6
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 13:52:58 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:5c05:0:640:ff67:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 240EDC04E0;
 Mon, 19 Jan 2026 21:52:54 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:934::1:38])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id dqetGa1BQGk0-dFIw8j8e; Mon, 19 Jan 2026 21:52:53 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768848773;
 bh=rCiioBnnWbMi4a0Cp3Ty2I/qaYF7GYfNwpKaJC9w4mE=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ORV1opxJ2HVyE7RqQl/tcM+GrABbfgfIbDU+cdOuFTMWcGr9IYY3EADIHeEhyuKw+
 QBS9xZ3koX+NQsGfOfaqVXWOfxolHHkcOF56L0SyQZoQ5g53N4RgeSDzB4gkrM+v+h
 kPvDxFOOm6hEdYBtezzgbUBH9dR/Sq7SL+1q5uag=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: [PATCH v4 12/23] vhost: make vhost_memory_unmap() null-safe
Date: Mon, 19 Jan 2026 21:52:16 +0300
Message-ID: <20260119185228.203296-13-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119185228.203296-1-vsementsov@yandex-team.ru>
References: <20260119185228.203296-1-vsementsov@yandex-team.ru>
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

This helps to simplify failure paths of vhost_virtqueue_start()
a lot. We also need to zero-out pointers on unmap, to not try
to unmap invalid pointers.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
---
 hw/virtio/vhost.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 1ef9b3ed6c..036c28dead 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -473,14 +473,20 @@ static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
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
@@ -1324,33 +1330,33 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
     vq->desc = vhost_memory_map(dev, vq->desc_phys, l, false);
     if (!vq->desc) {
         r = -ENOMEM;
-        goto fail_alloc_desc;
+        goto fail;
     }
 
     l = vq->avail_size;
     vq->avail = vhost_memory_map(dev, vq->avail_phys, l, false);
     if (!vq->avail) {
         r = -ENOMEM;
-        goto fail_alloc_avail;
+        goto fail;
     }
 
     l = vq->used_size;
     vq->used = vhost_memory_map(dev, vq->used_phys, l, true);
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
@@ -1370,24 +1376,19 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
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
 
@@ -1434,11 +1435,11 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
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
2.52.0


