Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE05CD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 13:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsjpT-0006fM-6T; Fri, 05 Apr 2024 09:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adobriyan@yandex-team.ru>)
 id 1rshcx-0006SU-Dw
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 07:20:59 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adobriyan@yandex-team.ru>)
 id 1rshct-0007Lk-0s
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 07:20:58 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c16:1785:0:640:67c7:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 4254860C9E;
 Fri,  5 Apr 2024 14:20:47 +0300 (MSK)
Received: from adobriyan-nix.yandex.net (unknown
 [2a02:6b8:0:419:54ea:2a62:4c98:52ef])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id GKTkIL0iDeA0-tZwaKVhJ; Fri, 05 Apr 2024 14:20:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1712316046;
 bh=TRGnG0ODI3T3VD2kj0JguynzzI8jF7mmkXmuXbR5fRM=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=sTIBxQ+fhTF1x86cq/mLiE60ZMJ8zkEyPgZdnV9swlcfMuELhTA2CTQ+pOSccT/Nq
 SsLaHGTgfNDDyT+Z8vqBGaHLeWM0Ulk39Tp2N8xAAUM8B2JzjyQN6qJDwsi2J19VfR
 C/qn6y4iDUR3UGvwud28VrCSID3/yhTP6nZ+rH/A=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexey Dobriyan <adobriyan@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: adobriyan@gmail.com, adobriyan@yandex-team.ru, mst@redhat.com,
 jasowang@redhat.com, vsementsov@yandex-team.ru
Subject: [PATCH 1/1] virtio-net: fix bug 1451 aka
 "assert(!virtio_net_get_subqueue(nc)->async_tx.elem); "
Date: Fri,  5 Apr 2024 14:20:15 +0300
Message-Id: <20240405112015.11919-1-adobriyan@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=adobriyan@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 05 Apr 2024 09:42:00 -0400
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

Don't send zero length packets in virtio_net_flush_tx().

Reproducer from https://gitlab.com/qemu-project/qemu/-/issues/1451
creates small packet (1 segment, len = 10 == n->guest_hdr_len),
destroys queue.

"if (n->host_hdr_len != n->guest_hdr_len)" is triggered, if body creates
zero length/zero segment packet, because there is nothing after guest
header.

qemu_sendv_packet_async() tries to send it.

slirp discards it because it is smaller than Ethernet header,
but returns 0.

0 length is propagated upwards and is interpreted as "packet has been sent"
which is terrible because queue is being destroyed, nothing has been sent,
nobody is waiting for TX to complete and assert it triggered.

Signed-off-by: Alexey Dobriyan <adobriyan@yandex-team.ru>
---
 hw/net/virtio-net.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 58014a92ad..258633f885 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2765,18 +2765,14 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
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
@@ -2807,6 +2803,11 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
                              n->guest_hdr_len, -1);
             out_num = sg_num;
             out_sg = sg;
+
+            if (iov_size(out_sg, out_num) == 0) {
+                virtio_error(vdev, "virtio-net nothing to send");
+                goto detach;
+            }
         }
 
         ret = qemu_sendv_packet_async(qemu_get_subqueue(n->nic, queue_index),
@@ -2827,6 +2828,11 @@ drop:
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


