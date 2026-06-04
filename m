Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904B9CD6E57
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 08:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV3tB-00041E-1n; Thu, 04 Jun 2026 04:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wV3st-0003zQ-Vs; Thu, 04 Jun 2026 04:57:05 -0400
Received: from [115.124.30.100] (helo=out30-100.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wV3si-0002d0-QS; Thu, 04 Jun 2026 04:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780563386; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=ome00y6NCajRZ9+WaJy0c0RVI8D3yqZmz0PyuC8oox8=;
 b=fYvngzZfdGYRH+fRgN0mZ4F+seXjA1sOFwih3nU5/vBjVQF5bray8ViiIZ8qknlDXKOk6YVw8upBtTbteEuym0oRjxm+jLPn+w0x7nQjb++lKimfJ6lhz3i2zc8g178juC+ndcqcteLK2pTpmEHu+X2+Y433a4jqAuMXkwUMm90=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0X49lhnY_1780563384; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X49lhnY_1780563384 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 04 Jun 2026 16:56:25 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, stefanha@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 pbonzini@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH] hw/virtio: reject malformed VirtQueueElement on migration load
Date: Thu,  4 Jun 2026 16:56:24 +0800
Message-ID: <20260604085624.53815-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.100 (deferred)
Received-SPF: pass client-ip=115.124.30.100;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-100.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

qemu_get_virtqueue_element() asserts on in_num/out_num read straight
from the migration stream, then feeds them to virtqueue_alloc_element()
as allocation sizes. A malformed stream from the source crashes the
destination; with NDEBUG the asserts vanish and the heap allocation is
driven by attacker-controlled values - the reason the in-tree TODO
forbade NDEBUG builds. The hole is reachable on every inbound migration
of a virtio-blk or virtio-scsi guest.

Reject in_num/out_num that overflow their arrays, and reject
in_num + out_num > VIRTQUEUE_MAX_SIZE (a single chain cannot exceed
one ring). The OR short-circuits so the sum is only evaluated once
both counts are individually bounded.

virtio_blk_load_device() returns -EINVAL through its existing int
return. virtio_scsi_load_request() has no error channel in its
SCSIBusInfo hook signature and mirrors the existing error_report() +
exit(1) used a few lines below for parse failures.

Document the new NULL return on the prototype in virtio.h.

Cc: qemu-stable@nongnu.org
Fixes: 8059feee0041 ("virtio: introduce virtio_map")
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 hw/block/virtio-blk.c      |  3 +++
 hw/scsi/virtio-scsi.c      |  5 +++++
 hw/virtio/virtio.c         | 19 +++++++++++++------
 include/hw/virtio/virtio.h |  4 ++++
 4 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 9cb9f1fb2b..97482c7981 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1378,6 +1378,9 @@ static int virtio_blk_load_device(VirtIODevice *vdev, QEMUFile *f,
         }
 
         req = qemu_get_virtqueue_element(vdev, f, sizeof(VirtIOBlockReq));
+        if (!req) {
+            return -EINVAL;
+        }
         virtio_blk_init_request(s, virtio_get_queue(vdev, vq_idx), req);
 
         WITH_QEMU_LOCK_GUARD(&s->rq_lock) {
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 6c73768011..bb2412e89c 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -274,6 +274,11 @@ static void *virtio_scsi_load_request(QEMUFile *f, SCSIRequest *sreq)
     assert(n < vs->conf.num_queues);
     req = qemu_get_virtqueue_element(vdev, f,
                                      sizeof(VirtIOSCSIReq) + vs->cdb_size);
+    if (!req) {
+        error_report("virtio-scsi: failed to load request from migration "
+                     "stream (queue=%u)", n);
+        exit(1);
+    }
     virtio_scsi_init_req(s, vs->cmd_vqs[n], req);
 
     if (virtio_scsi_parse_req(req, sizeof(VirtIOSCSICmdReq) + vs->cdb_size,
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 63e2faee99..24df1d0300 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2167,13 +2167,20 @@ void *qemu_get_virtqueue_element(VirtIODevice *vdev, QEMUFile *f, size_t sz)
 
     qemu_get_buffer(f, (uint8_t *)&data, sizeof(VirtQueueElementOld));
 
-    /* TODO: teach all callers that this can fail, and return failure instead
-     * of asserting here.
-     * This is just one thing (there are probably more) that must be
-     * fixed before we can allow NDEBUG compilation.
+    /*
+     * Bound the untrusted counts before they reach
+     * virtqueue_alloc_element() as allocation sizes. A single chain
+     * cannot exceed the ring size, so the sum is bounded too.
      */
-    assert(ARRAY_SIZE(data.in_addr) >= data.in_num);
-    assert(ARRAY_SIZE(data.out_addr) >= data.out_num);
+    if (data.in_num > ARRAY_SIZE(data.in_addr) ||
+        data.out_num > ARRAY_SIZE(data.out_addr) ||
+        data.in_num + data.out_num > VIRTQUEUE_MAX_SIZE) {
+        error_report("virtio: malformed VirtQueueElement on migration load: "
+                     "in_num=%u out_num=%u (max=%u)",
+                     data.in_num, data.out_num,
+                     (unsigned)VIRTQUEUE_MAX_SIZE);
+        return NULL;
+    }
 
     elem = virtqueue_alloc_element(sz, data.out_num, data.in_num);
     elem->index = data.index;
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 6344bd7b68..3034257505 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -281,6 +281,10 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
 void virtqueue_map(VirtIODevice *vdev, VirtQueueElement *elem);
 void *virtqueue_pop(VirtQueue *vq, size_t sz);
 unsigned int virtqueue_drop_all(VirtQueue *vq);
+/**
+ * Returns NULL if the migration stream encodes an out-of-range
+ * descriptor count; callers must check before dereferencing.
+ */
 void *qemu_get_virtqueue_element(VirtIODevice *vdev, QEMUFile *f, size_t sz);
 void qemu_put_virtqueue_element(VirtIODevice *vdev, QEMUFile *f,
                                 VirtQueueElement *elem);
-- 
2.50.1 (Apple Git-155)


