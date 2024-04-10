Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA908CD1297
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 05:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruQoo-0006F8-It; Wed, 10 Apr 2024 01:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQom-0006D3-UX; Wed, 10 Apr 2024 01:48:21 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQok-00027h-5l; Wed, 10 Apr 2024 01:48:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 655D85D501;
 Wed, 10 Apr 2024 08:46:17 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 2992DB0168;
 Wed, 10 Apr 2024 08:44:19 +0300 (MSK)
Received: (nullmailer pid 4182127 invoked by uid 1000);
 Wed, 10 Apr 2024 05:44:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Wafer <wafer@jaguarmicro.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.11 41/41] hw/virtio: Fix packed virtqueue flush used_idx
Date: Wed, 10 Apr 2024 08:44:02 +0300
Message-Id: <20240410054416.4181891-41-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.11-20240410084037@cover.tls.msk.ru>
References: <qemu-stable-7.2.11-20240410084037@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Wafer <wafer@jaguarmicro.com>

In the event of writing many chains of descriptors, the device must
write just the id of the last buffer in the descriptor chain, skip
forward the number of descriptors in the chain, and then repeat the
operations for the rest of chains.

Current QEMU code writes all the buffer ids consecutively, and then
skips all the buffers altogether. This is a bug, and can be reproduced
with a VirtIONet device with _F_MRG_RXBUB and without
_F_INDIRECT_DESC:

If a virtio-net device has the VIRTIO_NET_F_MRG_RXBUF feature
but not the VIRTIO_RING_F_INDIRECT_DESC feature,
'VirtIONetQueue->rx_vq' will use the merge feature
to store data in multiple 'elems'.
The 'num_buffers' in the virtio header indicates how many elements are merged.
If the value of 'num_buffers' is greater than 1,
all the merged elements will be filled into the descriptor ring.
The 'idx' of the elements should be the value of 'vq->used_idx' plus 'ndescs'.

Fixes: 86044b24e8 ("virtio: basic packed virtqueue support")
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Wafer <wafer@jaguarmicro.com>
Message-Id: <20240407015451.5228-2-wafer@jaguarmicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 2d9a31b3c27311eca1682cb2c076d7a300441960)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index b7da7f074d..e4f8ed1e63 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1367,12 +1367,20 @@ static void virtqueue_packed_flush(VirtQueue *vq, unsigned int count)
         return;
     }
 
+    /*
+     * For indirect element's 'ndescs' is 1.
+     * For all other elemment's 'ndescs' is the
+     * number of descriptors chained by NEXT (as set in virtqueue_packed_pop).
+     * So When the 'elem' be filled into the descriptor ring,
+     * The 'idx' of this 'elem' shall be
+     * the value of 'vq->used_idx' plus the 'ndescs'.
+     */
+    ndescs += vq->used_elems[0].ndescs;
     for (i = 1; i < count; i++) {
-        virtqueue_packed_fill_desc(vq, &vq->used_elems[i], i, false);
+        virtqueue_packed_fill_desc(vq, &vq->used_elems[i], ndescs, false);
         ndescs += vq->used_elems[i].ndescs;
     }
     virtqueue_packed_fill_desc(vq, &vq->used_elems[0], 0, true);
-    ndescs += vq->used_elems[0].ndescs;
 
     vq->inuse -= ndescs;
     vq->used_idx += ndescs;
-- 
2.39.2


