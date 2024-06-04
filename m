Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E84C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEOkn-0000En-Ud; Tue, 04 Jun 2024 03:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sEOke-0000BM-6a
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:38:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sEOkc-0006LE-Kk
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717486713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0355VJVyNQ+og3MeEaoZS3COabkY3dh5g5p6DrOXJCo=;
 b=RosEzdoCA6eTmpT4h32VjIEQXb64QQN4GP0tb3J2gn9GU7+rf054CmAItE4Re/Yum6nx+R
 4lyvQdhaUTUDr+ds2txvsJ9wHTSoNPIAd5zFfyWSYJxezlbptPunlxF0L8DiFHsYX3htug
 b6G35JPB4l5eSf48nORzqecEQAthn+o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-mM4xLXfBOTibr93PCx0CAg-1; Tue, 04 Jun 2024 03:38:30 -0400
X-MC-Unique: mM4xLXfBOTibr93PCx0CAg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2496D80027F;
 Tue,  4 Jun 2024 07:38:30 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 407A7492BD4;
 Tue,  4 Jun 2024 07:38:27 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 10/20] virtio-net: Shrink header byte swapping buffer
Date: Tue,  4 Jun 2024 15:37:45 +0800
Message-ID: <20240604073755.1859-11-jasowang@redhat.com>
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Byte swapping is only performed for the part of header shared with the
legacy standard and the buffer only needs to cover it.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 13a17a1e5a..dabfa6e7d7 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -676,11 +676,6 @@ static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
 
     n->mergeable_rx_bufs = mergeable_rx_bufs;
 
-    /*
-     * Note: when extending the vnet header, please make sure to
-     * change the vnet header copying logic in virtio_net_flush_tx()
-     * as well.
-     */
     if (version_1) {
         n->guest_hdr_len = hash_report ?
             sizeof(struct virtio_net_hdr_v1_hash) :
@@ -2736,7 +2731,7 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
         ssize_t ret;
         unsigned int out_num;
         struct iovec sg[VIRTQUEUE_MAX_SIZE], sg2[VIRTQUEUE_MAX_SIZE + 1], *out_sg;
-        struct virtio_net_hdr_v1_hash vhdr;
+        struct virtio_net_hdr vhdr;
 
         elem = virtqueue_pop(q->tx_vq, sizeof(VirtQueueElement));
         if (!elem) {
@@ -2753,18 +2748,18 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
         }
 
         if (n->needs_vnet_hdr_swap) {
-            if (iov_to_buf(out_sg, out_num, 0, &vhdr, n->guest_hdr_len) <
-                n->guest_hdr_len) {
+            if (iov_to_buf(out_sg, out_num, 0, &vhdr, sizeof(vhdr)) <
+                sizeof(vhdr)) {
                 virtio_error(vdev, "virtio-net header incorrect");
                 virtqueue_detach_element(q->tx_vq, elem, 0);
                 g_free(elem);
                 return -EINVAL;
             }
-            virtio_net_hdr_swap(vdev, (void *) &vhdr);
+            virtio_net_hdr_swap(vdev, &vhdr);
             sg2[0].iov_base = &vhdr;
-            sg2[0].iov_len = n->guest_hdr_len;
+            sg2[0].iov_len = sizeof(vhdr);
             out_num = iov_copy(&sg2[1], ARRAY_SIZE(sg2) - 1, out_sg, out_num,
-                               n->guest_hdr_len, -1);
+                               sizeof(vhdr), -1);
             if (out_num == VIRTQUEUE_MAX_SIZE) {
                 goto drop;
             }
-- 
2.42.0


