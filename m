Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B881C606A32A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=Auw4lhb1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3Dr-0004FN-K3; Mon, 16 Nov 2026 15:22:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3DX-0003p9-S9; Mon, 16 Nov 2026 15:22:20 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3DW-0003Tv-2q; Mon, 16 Nov 2026 15:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860372; bh=BrlqNyyC3bVRKL2A0ZQcX24nY/1rt8PSOZ8XZh5juxU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Auw4lhb1KrCkL9oxvIrUpqTdE3Nc/5MklS3Nij0f9kUPERj/7W8A2QVKkwzGFxFI7
 QAadUS34hK4oZWkEpOPNuHDG1B+NocDqLZg/8WTSE9z8uYgBBTMHzFuF1j1JfaYNAk
 R1sRw5uRHYM8vLzkUtltcDr0ex+yRBEavo5FeOrH6OMjxIfdBdmttFe6lR1QUoSmUj
 fIrNgeEssaD41RBDMaPx50zBWCd/ZNBW2KsHsntKNGpWP1YO782ZgXjnI5XDBw7dUg
 T5pq4Z2m2n9UGz8PfoRXIfqq525Fnt9Dn2nS03y/rZ8pDsLi63MAs6smYKKv/QlI0w
 G6iDd/4hX/t0w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 924531E7157;
 Mon, 16 Nov 2026 23:19:32 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8D6B945FB90;
 Mon, 16 Nov 2026 23:19:32 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 5ADEAB8E10; Mon, 16 Nov 2026 23:19:32 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>,
 Michael S. Tsirkin <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 33/59] vhost: final refactoring of vhost vrings
 map/unmap
Date: Mon, 16 Nov 2026 23:18:37 +0300
Message-ID: <20261116201922.534306-33-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Introduce helper functions vhost_vrings_map() and
vhost_vrings_unmap() and use them.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420200339.708640-16-vsementsov@yandex-team.ru>
(cherry picked from commit 4e61c89262aa7fad36df39daf5d7ab759079bd9a)
(Mjt: adjust context for before do_vhost_virtqueue_stop() split/return)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index cda28118c8a..3532255aa15 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -488,6 +488,56 @@ static void vhost_memory_unmap(struct vhost_dev *dev, void **buffer,
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
@@ -1274,34 +1324,9 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
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
@@ -1363,9 +1388,7 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
     return 0;
 
 fail:
-    vhost_memory_unmap(dev, &vq->used, vq->used_size, 0, 0);
-    vhost_memory_unmap(dev, &vq->avail, vq->avail_size, 0, 0);
-    vhost_memory_unmap(dev, &vq->desc, vq->desc_size, 0, 0);
+    vhost_vrings_unmap(dev, vq, false);
     return r;
 }
 
@@ -1407,9 +1430,7 @@ void vhost_virtqueue_stop(struct vhost_dev *dev,
                                                 vhost_vq_index);
     }
 
-    vhost_memory_unmap(dev, &vq->used, vq->used_size, 1, vq->used_size);
-    vhost_memory_unmap(dev, &vq->avail, vq->avail_size, 0, vq->avail_size);
-    vhost_memory_unmap(dev, &vq->desc, vq->desc_size, 0, vq->desc_size);
+    vhost_vrings_unmap(dev, vq, true);
 }
 
 static int vhost_virtqueue_set_busyloop_timeout(struct vhost_dev *dev,
-- 
2.47.3


