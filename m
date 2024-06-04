Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52316C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEOlA-0001xX-5t; Tue, 04 Jun 2024 03:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sEOl7-0001jc-R8
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:39:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sEOl5-0006Pb-QZ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717486743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wNP3v399FEuLCNKjKz1Hgq6Vv7Mh17NVRy0U2xtE/8s=;
 b=WKeNd70ZGdVW4wNL0x1HyA+IWjy7LFHwhdtYB496Uzt5Uh8VpUiJ18fNXHY9DtvAgRD3Id
 hlGqk/t+v28b1TyC0LYE3fQDBjVvTmhjZ6NTQGKLaIlouECHH6RUuyNY7WW/9ZYR1Gmet2
 IHaII/dFlNabQL0KLLr65hdjQixyenQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-wf9Nkx07NQS0rE2w2BTJpA-1; Tue,
 04 Jun 2024 03:38:58 -0400
X-MC-Unique: wf9Nkx07NQS0rE2w2BTJpA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9FEA33C0262C;
 Tue,  4 Jun 2024 07:38:57 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 146FC492BD4;
 Tue,  4 Jun 2024 07:38:54 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Cc: Alexey Dobriyan <adobriyan@yandex-team.ru>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 19/20] virtio-net: drop too short packets early
Date: Tue,  4 Jun 2024 15:37:54 +0800
Message-ID: <20240604073755.1859-20-jasowang@redhat.com>
In-Reply-To: <20240604073755.1859-1-jasowang@redhat.com>
References: <20240604073755.1859-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Alexey Dobriyan <adobriyan@yandex-team.ru>

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
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 666a4e2a03..9c7e85caea 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2708,18 +2708,14 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
         out_sg = elem->out_sg;
         if (out_num < 1) {
             virtio_error(vdev, "virtio-net header not in first element");
-            virtqueue_detach_element(q->tx_vq, elem, 0);
-            g_free(elem);
-            return -EINVAL;
+            goto detach;
         }
 
         if (n->needs_vnet_hdr_swap) {
             if (iov_to_buf(out_sg, out_num, 0, &vhdr, sizeof(vhdr)) <
                 sizeof(vhdr)) {
                 virtio_error(vdev, "virtio-net header incorrect");
-                virtqueue_detach_element(q->tx_vq, elem, 0);
-                g_free(elem);
-                return -EINVAL;
+                goto detach;
             }
             virtio_net_hdr_swap(vdev, &vhdr);
             sg2[0].iov_base = &vhdr;
@@ -2747,6 +2743,11 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
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
@@ -2767,6 +2768,11 @@ drop:
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
2.42.0


