Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165A5C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 13:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBaTT-0007Ad-LP; Mon, 27 May 2024 09:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1sBaTR-00079z-Ft
 for qemu-devel@nongnu.org; Mon, 27 May 2024 09:33:13 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1sBaTP-0007f1-JB
 for qemu-devel@nongnu.org; Mon, 27 May 2024 09:33:13 -0400
From: Dmitry Frolov <frolov@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1716816784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=f9Zh4ZS38waNOk1bEjf7gbo+W6LJjp+Ahtys9uXlUPQ=;
 b=uySJ00lTw17dVTcYi3QiJT+HmDIqPjfgjHmggzweFBCYm+SJPHig83cAiV8DqBsuibp8Zj
 imDgstjSUuSDzIJ7mz8df6tgQkWgr/c2MbXMETth5XOxwGY03hhFApf5D2ZCVQk/3TcDSl
 95P0HKTIqcq4wtnKaeAEqQbY1muZjbU=
To: mst@redhat.com
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org,
 Dmitry Frolov <frolov@swemel.ru>
Subject: [PATCH] hw/net/virtio-net.c: fix crash in iov_copy()
Date: Mon, 27 May 2024 16:31:41 +0300
Message-ID: <20240527133140.218300-2-frolov@swemel.ru>
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
 hw/net/virtio-net.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 24e5e7d347..603b80a50a 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2783,6 +2783,12 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
          */
         assert(n->host_hdr_len <= n->guest_hdr_len);
         if (n->host_hdr_len != n->guest_hdr_len) {
+            if (iov_size(out_sg, out_num) < n->guest_hdr_len) {
+                virtio_error(vdev, "virtio-net header is invalid");
+                virtqueue_detach_element(q->tx_vq, elem, 0);
+                g_free(elem);
+                return -EINVAL;
+            }
             unsigned sg_num = iov_copy(sg, ARRAY_SIZE(sg),
                                        out_sg, out_num,
                                        0, n->host_hdr_len);
-- 
2.43.0


