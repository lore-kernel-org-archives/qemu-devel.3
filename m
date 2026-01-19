Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40479CCF2EE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 18:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhuNG-0006eO-7q; Mon, 19 Jan 2026 13:53:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhuN0-0006IN-7H
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 13:52:59 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhuMx-0005sZ-D9
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 13:52:57 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:5c05:0:640:ff67:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 651A280763;
 Mon, 19 Jan 2026 21:52:53 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:934::1:38])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id dqetGa1BQGk0-L9wrIHxr; Mon, 19 Jan 2026 21:52:52 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768848772;
 bh=+/XFljqJqxyCr23SXmMT7TFLKh2cfe03+ACmDCJee98=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Z4L2ykwxfnWwV7PLR/CFVrM6cgn7u4Fs38XImv8NqzlNaQtZ+op2174AX+N6yfqMk
 ihs9H+U6ybpRzlChLzs92itrqXF3CKRiVNEMbHbQ+P1juT3vLr6yfK9nBYHNbwQoxv
 xBM74v7+75FmBk/yjPgJEJa0wDs+y6OPv9mQz3Fg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH v4 11/23] vhost: vhost_virtqueue_start(): fix failure path
Date: Mon, 19 Jan 2026 21:52:15 +0300
Message-ID: <20260119185228.203296-12-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119185228.203296-1-vsementsov@yandex-team.ru>
References: <20260119185228.203296-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

We miss call to unmap in cases when vhost_memory_map() returns
lenght less than requested (still we consider such cases as an
error). Let's fix it in vhost_memory_map().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 40440c6d68..1ef9b3ed6c 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -454,11 +454,20 @@ static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint64_t size)
 }
 
 static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
-                              hwaddr *plen, bool is_write)
+                              hwaddr len, bool is_write)
 {
     if (!vhost_dev_has_iommu(dev)) {
-        return address_space_map(dev->vdev->dma_as, addr, plen, is_write,
-                                 MEMTXATTRS_UNSPECIFIED);
+        hwaddr mapped_len = len;
+        void *res = address_space_map(dev->vdev->dma_as, addr, &mapped_len,
+                                      is_write, MEMTXATTRS_UNSPECIFIED);
+        if (!res) {
+            return NULL;
+        }
+        if (len != mapped_len) {
+            address_space_unmap(dev->vdev->dma_as, res, mapped_len, 0, 0);
+            return NULL;
+        }
+        return res;
     } else {
         return (void *)(uintptr_t)addr;
     }
@@ -1312,22 +1321,22 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
     }
 
     l = vq->desc_size;
-    vq->desc = vhost_memory_map(dev, vq->desc_phys, &l, false);
-    if (!vq->desc || l != vq->desc_size) {
+    vq->desc = vhost_memory_map(dev, vq->desc_phys, l, false);
+    if (!vq->desc) {
         r = -ENOMEM;
         goto fail_alloc_desc;
     }
 
     l = vq->avail_size;
-    vq->avail = vhost_memory_map(dev, vq->avail_phys, &l, false);
-    if (!vq->avail || l != vq->avail_size) {
+    vq->avail = vhost_memory_map(dev, vq->avail_phys, l, false);
+    if (!vq->avail) {
         r = -ENOMEM;
         goto fail_alloc_avail;
     }
 
     l = vq->used_size;
-    vq->used = vhost_memory_map(dev, vq->used_phys, &l, true);
-    if (!vq->used || l != vq->used_size) {
+    vq->used = vhost_memory_map(dev, vq->used_phys, l, true);
+    if (!vq->used) {
         r = -ENOMEM;
         goto fail_alloc_used;
     }
-- 
2.52.0


