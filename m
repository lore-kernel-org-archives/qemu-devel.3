Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B264FC27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 12:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHjwf-0002Ee-OY; Thu, 13 Jun 2024 08:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1sHjwd-0002E4-2p
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 08:52:47 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1sHjwZ-000371-83
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 08:52:46 -0400
From: Dmitry Frolov <frolov@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1718283156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8tTpUENc49CM1lufBLPAZR/DzFN+igFpfemtx3UR+Lg=;
 b=tYO33kYDz6rbevUsn251rBOFIzWYnyRPU1YgI1Hy1gHGBGMf4TmZM2TM4L8m75gjvAB8Nr
 KD6m9i3BjXGVBOA5dp8UlmSW9Y5nqxiuSZSy/vQp7JPf9xJomkrGcaf9zDQiRUpvoJ/i7l
 A6/ea9A8TsIQAoSEcx+IB6r8SNhN9iU=
To: mst@redhat.com
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org,
 Dmitry Frolov <frolov@swemel.ru>
Subject: [PATCH v2] hw/net/virtio-net.c: fix crash in iov_copy()
Date: Thu, 13 Jun 2024 15:45:50 +0300
Message-ID: <20240613124549.406607-2-frolov@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

A crash found while fuzzing device virtio-net-socket-check-used.
Assertion "offset == 0" in iov_copy() fails if less than guest_hdr_len bytes
were transmited.

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
---
v1: https://patchew.org/QEMU/20240527133140.218300-2-frolov@swemel.ru/
v2: replaced repeating code with goto
---
 hw/net/virtio-net.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 24e5e7d347..424bada8cf 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2749,18 +2749,14 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
         out_sg = elem->out_sg;
         if (out_num < 1) {
             virtio_error(vdev, "virtio-net header not in first element");
-            virtqueue_detach_element(q->tx_vq, elem, 0);
-            g_free(elem);
-            return -EINVAL;
+            goto error;
         }
 
         if (n->has_vnet_hdr) {
             if (iov_to_buf(out_sg, out_num, 0, &vhdr, n->guest_hdr_len) <
                 n->guest_hdr_len) {
                 virtio_error(vdev, "virtio-net header incorrect");
-                virtqueue_detach_element(q->tx_vq, elem, 0);
-                g_free(elem);
-                return -EINVAL;
+                goto error;
             }
             if (n->needs_vnet_hdr_swap) {
                 virtio_net_hdr_swap(vdev, (void *) &vhdr);
@@ -2783,6 +2779,10 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
          */
         assert(n->host_hdr_len <= n->guest_hdr_len);
         if (n->host_hdr_len != n->guest_hdr_len) {
+            if (iov_size(out_sg, out_num) < n->guest_hdr_len) {
+                virtio_error(vdev, "virtio-net header is invalid");
+                goto error;
+            }
             unsigned sg_num = iov_copy(sg, ARRAY_SIZE(sg),
                                        out_sg, out_num,
                                        0, n->host_hdr_len);
@@ -2811,6 +2811,11 @@ drop:
         }
     }
     return num_packets;
+
+error:
+    virtqueue_detach_element(q->tx_vq, elem, 0);
+    g_free(elem);
+    return -EINVAL;
 }
 
 static void virtio_net_tx_timer(void *opaque);
-- 
2.43.0


