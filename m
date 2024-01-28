Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88749C47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 17:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rU9KI-0007Ap-Tp; Sun, 28 Jan 2024 12:52:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rU9JV-0004Dy-DF; Sun, 28 Jan 2024 12:51:26 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rU9JP-0000px-A0; Sun, 28 Jan 2024 12:51:24 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CCFCF4810C;
 Sun, 28 Jan 2024 20:51:32 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4EFC86D528;
 Sun, 28 Jan 2024 20:50:41 +0300 (MSK)
Received: (nullmailer pid 812428 invoked by uid 1000);
 Sun, 28 Jan 2024 17:50:35 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Xiao Lei <leixiao.nop@zju.edu.cn>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 63/71] virtio-net: correctly copy vnet header when
 flushing TX
Date: Sun, 28 Jan 2024 20:50:26 +0300
Message-Id: <20240128175035.812352-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240128204849@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240128204849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Jason Wang <jasowang@redhat.com>

When HASH_REPORT is negotiated, the guest_hdr_len might be larger than
the size of the mergeable rx buffer header. Using
virtio_net_hdr_mrg_rxbuf during the header swap might lead a stack
overflow in this case. Fixing this by using virtio_net_hdr_v1_hash
instead.

Reported-by: Xiao Lei <leixiao.nop@zju.edu.cn>
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-stable@nongnu.org
Cc: Mauro Matteo Cascella <mcascell@redhat.com>
Fixes: CVE-2023-6693
Fixes: e22f0603fb2f ("virtio-net: reference implementation of hash report")
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 2220e8189fb94068dbad333228659fbac819abb0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 80c56f0cfc..73024babd4 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -674,6 +674,11 @@ static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
 
     n->mergeable_rx_bufs = mergeable_rx_bufs;
 
+    /*
+     * Note: when extending the vnet header, please make sure to
+     * change the vnet header copying logic in virtio_net_flush_tx()
+     * as well.
+     */
     if (version_1) {
         n->guest_hdr_len = hash_report ?
             sizeof(struct virtio_net_hdr_v1_hash) :
@@ -2693,7 +2698,7 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
         ssize_t ret;
         unsigned int out_num;
         struct iovec sg[VIRTQUEUE_MAX_SIZE], sg2[VIRTQUEUE_MAX_SIZE + 1], *out_sg;
-        struct virtio_net_hdr_mrg_rxbuf mhdr;
+        struct virtio_net_hdr_v1_hash vhdr;
 
         elem = virtqueue_pop(q->tx_vq, sizeof(VirtQueueElement));
         if (!elem) {
@@ -2710,7 +2715,7 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
         }
 
         if (n->has_vnet_hdr) {
-            if (iov_to_buf(out_sg, out_num, 0, &mhdr, n->guest_hdr_len) <
+            if (iov_to_buf(out_sg, out_num, 0, &vhdr, n->guest_hdr_len) <
                 n->guest_hdr_len) {
                 virtio_error(vdev, "virtio-net header incorrect");
                 virtqueue_detach_element(q->tx_vq, elem, 0);
@@ -2718,8 +2723,8 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
                 return -EINVAL;
             }
             if (n->needs_vnet_hdr_swap) {
-                virtio_net_hdr_swap(vdev, (void *) &mhdr);
-                sg2[0].iov_base = &mhdr;
+                virtio_net_hdr_swap(vdev, (void *) &vhdr);
+                sg2[0].iov_base = &vhdr;
                 sg2[0].iov_len = n->guest_hdr_len;
                 out_num = iov_copy(&sg2[1], ARRAY_SIZE(sg2) - 1,
                                    out_sg, out_num,
-- 
2.39.2


