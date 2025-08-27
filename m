Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0C9CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHi2-0004cR-3b; Wed, 27 Aug 2025 11:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHhj-00040R-AU; Wed, 27 Aug 2025 11:04:53 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHhg-0004wj-TG; Wed, 27 Aug 2025 11:04:50 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A35FC14C53B;
 Wed, 27 Aug 2025 18:02:57 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8D63F269843;
 Wed, 27 Aug 2025 18:03:24 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jonah Palmer <jonah.palmer@oracle.com>,
 terrynini <terrynini38514@gmail.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 19/59] virtio: fix off-by-one and invalid access in
 virtqueue_ordered_fill
Date: Wed, 27 Aug 2025 18:02:24 +0300
Message-ID: <20250827150323.2694101-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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

From: Jonah Palmer <jonah.palmer@oracle.com>

Commit b44135daa372 introduced virtqueue_ordered_fill for
VIRTIO_F_IN_ORDER support but had a few issues:

* Conditional while loop used 'steps <= max_steps' but should've been
  'steps < max_steps' since reaching steps == max_steps would indicate
  that we didn't find an element, which is an error. Without this
  change, the code would attempt to read invalid data at an index
  outside of our search range.

* Incremented 'steps' using the next chain's ndescs instead of the
  current one.

This patch corrects the loop bounds and synchronizes 'steps' and index
increments.

We also add a defensive sanity check against malicious or invalid
descriptor counts to avoid a potential infinite loop and DoS.

Fixes: b44135daa372 ("virtio: virtqueue_ordered_fill - VIRTIO_F_IN_ORDER support")
Reported-by: terrynini <terrynini38514@gmail.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Message-Id: <20250721150208.2409779-1-jonah.palmer@oracle.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 6fcf5ebafad65adc19a616260ca7dc90005785d1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index ec54573feb..b756f49867 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -929,18 +929,18 @@ static void virtqueue_packed_fill(VirtQueue *vq, const VirtQueueElement *elem,
 static void virtqueue_ordered_fill(VirtQueue *vq, const VirtQueueElement *elem,
                                    unsigned int len)
 {
-    unsigned int i, steps, max_steps;
+    unsigned int i, steps, max_steps, ndescs;
 
     i = vq->used_idx % vq->vring.num;
     steps = 0;
     /*
-     * We shouldn't need to increase 'i' by more than the distance
-     * between used_idx and last_avail_idx.
+     * We shouldn't need to increase 'i' by more than or equal to
+     * the distance between used_idx and last_avail_idx (max_steps).
      */
     max_steps = (vq->last_avail_idx - vq->used_idx) % vq->vring.num;
 
     /* Search for element in vq->used_elems */
-    while (steps <= max_steps) {
+    while (steps < max_steps) {
         /* Found element, set length and mark as filled */
         if (vq->used_elems[i].index == elem->index) {
             vq->used_elems[i].len = len;
@@ -948,8 +948,18 @@ static void virtqueue_ordered_fill(VirtQueue *vq, const VirtQueueElement *elem,
             break;
         }
 
-        i += vq->used_elems[i].ndescs;
-        steps += vq->used_elems[i].ndescs;
+        ndescs = vq->used_elems[i].ndescs;
+
+        /* Defensive sanity check */
+        if (unlikely(ndescs == 0 || ndescs > vq->vring.num)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: %s invalid ndescs %u at position %u\n",
+                          __func__, vq->vdev->name, ndescs, i);
+            return;
+        }
+
+        i += ndescs;
+        steps += ndescs;
 
         if (i >= vq->vring.num) {
             i -= vq->vring.num;
-- 
2.47.2


