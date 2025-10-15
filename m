Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B24DCCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 15:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v92xf-0007lD-0R; Wed, 15 Oct 2025 10:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v92xd-0007kV-2F
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:58:41 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v92xP-0000dD-Sl
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:58:40 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id E4328C0692;
 Wed, 15 Oct 2025 17:58:21 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id AwRFIp2FFSw0-4Z1Orgpw; Wed, 15 Oct 2025 17:58:21 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760540301;
 bh=ZXMrzcbIowlzXAQ2kQUJmxrXvoog9SldUHDJaCCwYU4=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=nYyHZRQrgHwcj+UojtqdSQ1P5ij0OozYhCkdmObBXM9ArfI6mXF03vpUC6t+6UD6D
 ukygVurLbcYsaLyhbRvh+D7tBEcOydZWDYUlLAcw/9WFWaLJHK6AZ7hXb/I64NWKqv
 NBOdRxT5k3s3jaLivsJXEAguoyd3lKEstvIhkvWU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: [PATCH v3 11/23] vhost: make vhost_memory_unmap() null-safe
Date: Wed, 15 Oct 2025 17:57:55 +0300
Message-ID: <20251015145808.1112843-12-vsementsov@yandex-team.ru>
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
index be2245cc7e..db6ea42f9b 100644
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


