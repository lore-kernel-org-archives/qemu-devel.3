Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA09C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 10:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1l7h-0002he-64; Tue, 30 Apr 2024 06:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adobriyan@yandex-team.ru>)
 id 1s1l7e-0002h0-4V
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 06:54:06 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adobriyan@yandex-team.ru>)
 id 1s1l7a-00011t-Bu
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 06:54:05 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c16:1680:0:640:d42f:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id E1A0960BEB;
 Tue, 30 Apr 2024 13:53:54 +0300 (MSK)
Received: from adobriyan-nix.yandex.net (unknown
 [2a02:6b8:82:e04:e5b2:61da:4dba:91a5])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id brOMh32Rpa60-Tum9qEaI; Tue, 30 Apr 2024 13:53:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714474434;
 bh=inOxdMhfrUMcS5L0UmHhsn9Yffjnx2Gukkbqn83LBEs=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=gITvv0D8YDifGG5yaM8NlrLVBKsIYktawkm0H9GqgcLRDZUON3211FvTQIEmHNYN8
 o1OG+uO+ftCHab44ALq09/yqaFQYsM45iMER8wnyHeiRKYGbSsH5jOfY/S4m+SFPTX
 ago2ToMNfywX7MERoHtASygtygTSRlfwd9+B4muc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexey Dobriyan <adobriyan@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: adobriyan@gmail.com, adobriyan@yandex-team.ru, mst@redhat.com,
 jasowang@redhat.com, vsementsov@yandex-team.ru
Subject: [PATCH RESEND] virtio-net: fix bug 1451 aka
 "assert(!virtio_net_get_subqueue(nc)->async_tx.elem); "
Date: Tue, 30 Apr 2024 13:53:33 +0300
Message-Id: <20240430105333.23377-1-adobriyan@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=adobriyan@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reproducer from https://gitlab.com/qemu-project/qemu/-/issues/1451
creates small packet (1 segment, len = 10 == n->guest_hdr_len),
then destroys queue.

"if (n->host_hdr_len != n->guest_hdr_len)" is triggered, if body creates
zero length/zero segment packet as there is nothing after guest header.

qemu_sendv_packet_async() tries to send it.

slirp discards it because it is smaller than Ethernet header,
but returns 0 because tx hooks are supposed to return total length of data.

0 is propagated upwards and is interpreted as "packet has been sent"
which is terrible because queue is being destroyed, nobody is waiting for TX
to complete and assert it triggered.

Fix is discard such empty packets instead of sending them.

Length 1 packets will go via different codepath:

	virtqueue_push(q->tx_vq, elem, 0);
	virtio_notify(vdev, q->tx_vq);
	g_free(elem);

and aren't problematic.

Signed-off-by: Alexey Dobriyan <adobriyan@yandex-team.ru>
---

	hopefully better changelog.
	use "if (out_num < 1)" so that discard doesn't calculate iov length

 hw/net/virtio-net.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 24e5e7d347..3644bfd91b 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2749,18 +2749,14 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
         out_sg = elem->out_sg;
         if (out_num < 1) {
             virtio_error(vdev, "virtio-net header not in first element");
-            virtqueue_detach_element(q->tx_vq, elem, 0);
-            g_free(elem);
-            return -EINVAL;
+            goto detach;
         }
 
         if (n->has_vnet_hdr) {
             if (iov_to_buf(out_sg, out_num, 0, &vhdr, n->guest_hdr_len) <
                 n->guest_hdr_len) {
                 virtio_error(vdev, "virtio-net header incorrect");
-                virtqueue_detach_element(q->tx_vq, elem, 0);
-                g_free(elem);
-                return -EINVAL;
+                goto detach;
             }
             if (n->needs_vnet_hdr_swap) {
                 virtio_net_hdr_swap(vdev, (void *) &vhdr);
@@ -2791,6 +2787,11 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
                              n->guest_hdr_len, -1);
             out_num = sg_num;
             out_sg = sg;
+
+            if (out_num < 1) {
+                virtio_error(vdev, "virtio-net nothing to send");
+                goto detach;
+            }
         }
 
         ret = qemu_sendv_packet_async(qemu_get_subqueue(n->nic, queue_index),
@@ -2811,6 +2812,11 @@ drop:
         }
     }
     return num_packets;
+
+detach:
+    virtqueue_detach_element(q->tx_vq, elem, 0);
+    g_free(elem);
+    return -EINVAL;
 }
 
 static void virtio_net_tx_timer(void *opaque);
-- 
2.34.1


