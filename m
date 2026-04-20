Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAD5F5A8B6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 20:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEur2-0001lu-Ke; Mon, 20 Apr 2026 16:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wEuqo-0001Mi-0I
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:04:11 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wEuqj-0001oZ-VD
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:04:08 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 3E5CE80795;
 Mon, 20 Apr 2026 23:04:04 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:54b::1:34])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id f3YMX10K1Sw0-IJFHQbSb; Mon, 20 Apr 2026 23:04:03 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1776715443;
 bh=34scPHp2ZdybOm2yZ0WL9aJaMm2nao2xuPbVsUANPc0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=RgFUKMAwfAaoFaTDJl/pPEutgmAh4vjAg26XhDyCrc3eT+sX8p4hQfMEUaiRH+/6H
 3L/oFWlAxcBB35saNHuI8+EsAMm1LZJ+490lT4cyE5wKaYpCf28AAL1OIoqOJhG90k
 7SSXuo1Q0aan3PNX1rYdSnyrrjX0ppMA0luaJ7kE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: [PATCH v6 10/22] vhost: vhost_virtqueue_start(): fix failure path
Date: Mon, 20 Apr 2026 23:03:25 +0300
Message-ID: <20260420200339.708640-11-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260420200339.708640-1-vsementsov@yandex-team.ru>
References: <20260420200339.708640-1-vsementsov@yandex-team.ru>
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
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
---
 hw/virtio/vhost.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index e39e0676e00..131a2fbf870 100644
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


