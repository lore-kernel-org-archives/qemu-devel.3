Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB86CCD194
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 15:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v92xe-0007lC-W2; Wed, 15 Oct 2025 10:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v92xd-0007kn-C8
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:58:41 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v92xR-0000dn-JV
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:58:40 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 9B298C069D;
 Wed, 15 Oct 2025 17:58:24 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id AwRFIp2FFSw0-iszgJGE7; Wed, 15 Oct 2025 17:58:24 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760540304;
 bh=7cF3P2LWCnkJ6+Z8tJLkgzbc+ihDE5lR0cnBIILM/Ew=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Za2JIVfc7o46G4PyeZv0vISMVxhfdKSISBp3oDcQVphZFV73BH2CxzqfNGuV8pQfP
 RprNEMhFtTjOVRmIw2Y4x246cCQmeAnEOnzZ+EvG8+qM8zDwPuwXgc/gniUnrDOiTL
 ZzW3FfK4kT8om4+qBaXHvcXh+ryugw7VPyKV8zS4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: [PATCH v3 15/23] vhost: final refactoring of vhost vrings map/unmap
Date: Wed, 15 Oct 2025 17:57:59 +0300
Message-ID: <20251015145808.1112843-16-vsementsov@yandex-team.ru>
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

Introduce helper functions vhost_vrings_map() and
vhost_vrings_unmap() and use them.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
---
 hw/virtio/vhost.c | 82 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 30 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 52a3236fff..8c5e434b89 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -488,6 +488,53 @@ static void vhost_memory_unmap(struct vhost_dev *dev, void **buffer,
     *buffer = NULL;
 }
 
+static void vhost_vrings_unmap(struct vhost_dev *dev,
+                               struct vhost_virtqueue *vq, bool touched)
+{
+    vhost_memory_unmap(dev, &vq->used, vq->used_size, touched,
+                       touched ? vq->used_size : 0);
+    vhost_memory_unmap(dev, &vq->avail, vq->avail_size, 0,
+                       touched ? vq->avail_size : 0);
+    vhost_memory_unmap(dev, &vq->desc, vq->desc_size, 0,
+                       touched ? vq->desc_size : 0);
+}
+
+static int vhost_vrings_map(struct vhost_dev *dev,
+                            struct VirtIODevice *vdev,
+                            struct vhost_virtqueue *vq,
+                            unsigned idx)
+{
+    vq->desc_phys = virtio_queue_get_desc_addr(vdev, idx);
+    if (vq->desc_phys == 0) {
+        /* Queue might not be ready for start */
+        return 0;
+    }
+    vq->desc_size = virtio_queue_get_desc_size(vdev, idx);
+    vq->desc = vhost_memory_map(dev, vq->desc_phys, vq->desc_size, false);
+    if (!vq->desc) {
+        return -ENOMEM;
+    }
+
+    vq->avail_size = virtio_queue_get_avail_size(vdev, idx);
+    vq->avail_phys = virtio_queue_get_avail_addr(vdev, idx);
+    vq->avail = vhost_memory_map(dev, vq->avail_phys, vq->avail_size, false);
+    if (!vq->avail) {
+        goto fail;
+    }
+
+    vq->used_size = virtio_queue_get_used_size(vdev, idx);
+    vq->used_phys = virtio_queue_get_used_addr(vdev, idx);
+    vq->used = vhost_memory_map(dev, vq->used_phys, vq->used_size, true);
+    if (!vq->used) {
+        goto fail;
+    }
+
+    return 1;
+fail:
+    vhost_vrings_unmap(dev, vq, false);
+    return -ENOMEM;
+}
+
 static int vhost_verify_ring_part_mapping(void *ring_hva,
                                           uint64_t ring_gpa,
                                           uint64_t ring_size,
@@ -1286,30 +1333,9 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
     };
     struct VirtQueue *vvq = virtio_get_queue(vdev, idx);
 
-    vq->desc_phys = virtio_queue_get_desc_addr(vdev, idx);
-    if (vq->desc_phys == 0) {
-        /* Queue might not be ready for start */
-        return 0;
-    }
-    vq->desc_size = virtio_queue_get_desc_size(vdev, idx);
-    vq->desc = vhost_memory_map(dev, vq->desc_phys, vq->desc_size, false);
-    if (!vq->desc) {
-        r = -ENOMEM;
-        goto fail;
-    }
-    vq->avail_size = virtio_queue_get_avail_size(vdev, idx);
-    vq->avail_phys = virtio_queue_get_avail_addr(vdev, idx);
-    vq->avail = vhost_memory_map(dev, vq->avail_phys, vq->avail_size, false);
-    if (!vq->avail) {
-        r = -ENOMEM;
-        goto fail;
-    }
-    vq->used_size = virtio_queue_get_used_size(vdev, idx);
-    vq->used_phys = virtio_queue_get_used_addr(vdev, idx);
-    vq->used = vhost_memory_map(dev, vq->used_phys, vq->used_size, true);
-    if (!vq->used) {
-        r = -ENOMEM;
-        goto fail;
+    r = vhost_vrings_map(dev, vdev, vq, idx);
+    if (r <= 0) {
+        return r;
     }
 
     vq->num = state.num = virtio_queue_get_num(vdev, idx);
@@ -1371,9 +1397,7 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
     return 0;
 
 fail:
-    vhost_memory_unmap(dev, &vq->used, vq->used_size, 0, 0);
-    vhost_memory_unmap(dev, &vq->avail, vq->avail_size, 0, 0);
-    vhost_memory_unmap(dev, &vq->desc, vq->desc_size, 0, 0);
+    vhost_vrings_unmap(dev, vq, false);
     return r;
 }
 
@@ -1420,9 +1444,7 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
                                                 vhost_vq_index);
     }
 
-    vhost_memory_unmap(dev, &vq->used, vq->used_size, 1, vq->used_size);
-    vhost_memory_unmap(dev, &vq->avail, vq->avail_size, 0, vq->avail_size);
-    vhost_memory_unmap(dev, &vq->desc, vq->desc_size, 0, vq->desc_size);
+    vhost_vrings_unmap(dev, vq, true);
     return r;
 }
 
-- 
2.48.1


