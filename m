Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8A4E7C706
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 07:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpLrw-0000sE-3j; Mon, 09 Feb 2026 02:39:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vpLrh-0000nC-03
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:39:27 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vpLrb-0004fr-CF
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:39:23 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 8EFFE8075C;
 Mon, 09 Feb 2026 10:39:16 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:129::1:13])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id BdLXu72As8c0-JVa7ECh8; Mon, 09 Feb 2026 10:39:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770622756;
 bh=JlAJLkQC4B4lhoBsNiiPpRV8n1pj6jtvYJYARvM3Cks=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=aHekf/N6aM015VX2VRQTQkIz0epmU5lJAH3NMbMG8+QQeNdTtst5Gp+QKmxCiD4Z2
 hNCNTIpLXxsgvpre8Pwq3fth+Et/MDPKcM2Z+aUg5OP0C7KFLV9DoB/eHIxLd0MU/X
 W1qdQDSKKE20YiANPlgz8Vl8lLN6oq+grReS4Nbg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH 05/10] vhost: simplify vhost_memory_map() and
 vhost_memory_unmap()
Date: Mon,  9 Feb 2026 10:39:02 +0300
Message-ID: <20260209073908.2125178-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260209073908.2125178-1-vsementsov@yandex-team.ru>
References: <20260209073908.2125178-1-vsementsov@yandex-team.ru>
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
Precedence: list
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

Make these functions simple wrappers around address_space_map() and
address_space_unmap(). Move IOMMU handling logic one layer up to the
callers.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 587f301832..b43525da87 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -456,21 +456,17 @@ static inline void vhost_dev_log_resize(struct vhost_dev *dev, uint64_t size)
 static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
                               hwaddr len, bool is_write)
 {
-    if (!vhost_dev_has_iommu(dev)) {
-        hwaddr mapped_len = len;
-        void *res = address_space_map(dev->vdev->dma_as, addr, &mapped_len,
-                                      is_write, MEMTXATTRS_UNSPECIFIED);
-        if (!res) {
-            return NULL;
-        }
-        if (len != mapped_len) {
-            address_space_unmap(dev->vdev->dma_as, res, mapped_len, 0, 0);
-            return NULL;
-        }
-        return res;
-    } else {
-        return (void *)(uintptr_t)addr;
+    hwaddr mapped_len = len;
+    void *res = address_space_map(dev->vdev->dma_as, addr, &mapped_len,
+                                  is_write, MEMTXATTRS_UNSPECIFIED);
+    if (!res) {
+        return NULL;
+    }
+    if (len != mapped_len) {
+        address_space_unmap(dev->vdev->dma_as, res, mapped_len, 0, 0);
+        return NULL;
     }
+    return res;
 }
 
 static void vhost_memory_unmap(struct vhost_dev *dev, void **buffer,
@@ -481,17 +477,18 @@ static void vhost_memory_unmap(struct vhost_dev *dev, void **buffer,
         return;
     }
 
-    if (!vhost_dev_has_iommu(dev)) {
-        address_space_unmap(dev->vdev->dma_as, *buffer, len, is_write,
-                            access_len);
-    }
-
+    address_space_unmap(dev->vdev->dma_as, *buffer, len, is_write,
+                        access_len);
     *buffer = NULL;
 }
 
 static void vhost_vrings_unmap(struct vhost_dev *dev,
                                struct vhost_virtqueue *vq, bool touched)
 {
+    if (vhost_dev_has_iommu(dev)) {
+        return;
+    }
+
     vhost_memory_unmap(dev, &vq->used, vq->used_size, touched,
                        touched ? vq->used_size : 0);
     vhost_memory_unmap(dev, &vq->avail, vq->avail_size, 0,
@@ -519,6 +516,14 @@ static int vhost_vrings_map(struct vhost_dev *dev,
         /* Queue might not be ready for start */
         return 0;
     }
+
+    if (vhost_dev_has_iommu(dev)) {
+        vq->desc = (void *)(uintptr_t)vq->desc_phys;
+        vq->avail = (void *)(uintptr_t)vq->avail_phys;
+        vq->used = (void *)(uintptr_t)vq->used_phys;
+        return 1;
+    }
+
     vq->desc = vhost_memory_map(dev, vq->desc_phys, vq->desc_size, false);
     if (!vq->desc) {
         goto fail;
-- 
2.52.0


