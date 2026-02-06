Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD866EB28FE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 09:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voIX9-0001sn-TF; Fri, 06 Feb 2026 04:53:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1voIWq-0001nH-8J
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 04:53:35 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1voIWl-0000K8-GV
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 04:53:30 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1593:0:640:6beb:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 4311680624;
 Fri, 06 Feb 2026 12:53:26 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:52d::1:1f])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2rKPQc0AN0U0-xHFpXS4E; Fri, 06 Feb 2026 12:53:25 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770371605;
 bh=vxz4qbxwQdPNmMfpno3R2GZ7Q0h7sCO3fSfHUlsFmBE=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=vJ7//H/gQLts1EN4wBYovztaHaAeTFJB6yoaEVK3i5a4SuAEBf195y8z739yy7MNr
 3mdHzBSLBs5IThdyXwnQ1TpR0tT5ttDmaVyb9WzH3ZTZCyLQX1kK9MAdD83mRKlmnS
 QeRCyyo8fpAPHouG8XVW+kkyxpKaWCVNXu1pr0I8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: [PATCH v5 16/23] vhost: final refactoring of vhost vrings map/unmap
Date: Fri,  6 Feb 2026 12:52:50 +0300
Message-ID: <20260206095258.894504-17-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206095258.894504-1-vsementsov@yandex-team.ru>
References: <20260206095258.894504-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

Introduce helper functions vhost_vrings_map() and
vhost_vrings_unmap() and use them.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
---
 hw/virtio/vhost.c | 89 +++++++++++++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 34 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 7eb3e105a1..403ebc257c 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -489,6 +489,56 @@ static void vhost_memory_unmap(struct vhost_dev *dev, void **buffer,
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
+    vq->desc_size = virtio_queue_get_desc_size(vdev, idx);
+    vq->desc_phys = virtio_queue_get_desc_addr(vdev, idx);
+    vq->desc = NULL;
+    vq->avail_size = virtio_queue_get_avail_size(vdev, idx);
+    vq->avail_phys = virtio_queue_get_avail_addr(vdev, idx);
+    vq->avail = NULL;
+    vq->used_size = virtio_queue_get_used_size(vdev, idx);
+    vq->used_phys = virtio_queue_get_used_addr(vdev, idx);
+    vq->used = NULL;
+
+    if (vq->desc_phys == 0) {
+        /* Queue might not be ready for start */
+        return 0;
+    }
+    vq->desc = vhost_memory_map(dev, vq->desc_phys, vq->desc_size, false);
+    if (!vq->desc) {
+        goto fail;
+    }
+    vq->avail = vhost_memory_map(dev, vq->avail_phys, vq->avail_size, false);
+    if (!vq->avail) {
+        goto fail;
+    }
+    vq->used = vhost_memory_map(dev, vq->used_phys, vq->used_size, true);
+    if (!vq->used) {
+        goto fail;
+    }
+
+    return 1;
+
+fail:
+    vhost_vrings_unmap(dev, vq, false);
+    return -ENOMEM;
+}
+
 static int vhost_verify_ring_part_mapping(void *ring_hva,
                                           uint64_t ring_gpa,
                                           uint64_t ring_size,
@@ -1289,34 +1339,9 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
     };
     struct VirtQueue *vvq = virtio_get_queue(vdev, idx);
 
-    vq->desc_size = virtio_queue_get_desc_size(vdev, idx);
-    vq->desc_phys = virtio_queue_get_desc_addr(vdev, idx);
-    vq->desc = NULL;
-    vq->avail_size = virtio_queue_get_avail_size(vdev, idx);
-    vq->avail_phys = virtio_queue_get_avail_addr(vdev, idx);
-    vq->avail = NULL;
-    vq->used_size = virtio_queue_get_used_size(vdev, idx);
-    vq->used_phys = virtio_queue_get_used_addr(vdev, idx);
-    vq->used = NULL;
-
-    if (vq->desc_phys == 0) {
-        /* Queue might not be ready for start */
-        return 0;
-    }
-    vq->desc = vhost_memory_map(dev, vq->desc_phys, vq->desc_size, false);
-    if (!vq->desc) {
-        r = -ENOMEM;
-        goto fail;
-    }
-    vq->avail = vhost_memory_map(dev, vq->avail_phys, vq->avail_size, false);
-    if (!vq->avail) {
-        r = -ENOMEM;
-        goto fail;
-    }
-    vq->used = vhost_memory_map(dev, vq->used_phys, vq->used_size, true);
-    if (!vq->used) {
-        r = -ENOMEM;
-        goto fail;
+    r = vhost_vrings_map(dev, vdev, vq, idx);
+    if (r <= 0) {
+        return r;
     }
 
     vq->num = state.num = virtio_queue_get_num(vdev, idx);
@@ -1378,9 +1403,7 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
     return 0;
 
 fail:
-    vhost_memory_unmap(dev, &vq->used, vq->used_size, 0, 0);
-    vhost_memory_unmap(dev, &vq->avail, vq->avail_size, 0, 0);
-    vhost_memory_unmap(dev, &vq->desc, vq->desc_size, 0, 0);
+    vhost_vrings_unmap(dev, vq, false);
     return r;
 }
 
@@ -1427,9 +1450,7 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
                                                 vhost_vq_index);
     }
 
-    vhost_memory_unmap(dev, &vq->used, vq->used_size, 1, vq->used_size);
-    vhost_memory_unmap(dev, &vq->avail, vq->avail_size, 0, vq->avail_size);
-    vhost_memory_unmap(dev, &vq->desc, vq->desc_size, 0, vq->desc_size);
+    vhost_vrings_unmap(dev, vq, true);
     return r;
 }
 
-- 
2.52.0


