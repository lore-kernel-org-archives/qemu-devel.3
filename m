Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F697D12D7A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 06:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAO6s-0006nu-V1; Mon, 11 Nov 2024 01:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tAO6k-0006mH-Vy
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 01:41:07 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tAO6i-0000fv-Dh
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 01:41:05 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e2ed2230d8so3336434a91.0
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 22:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1731307263; x=1731912063;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UntqNh0SSDcPg0A4KG+9ffl5JXbQpD+82Atqct3kXec=;
 b=aPAZHvzpBHf6Xn7AEx/wA3owP/SCzGNSN9Ac/IfK8lM9fQ9GowXRvTc8ZxlFiYCQLB
 v3HBTBT9l0W+MJ27/SBVs68buQsJVkebmuFmqUeHzf6AZcSjXdIusdXTXdONUI4lq6sc
 uF7KUmM6fR3+TL13dopHt4E7lciqLJ1qf7+v9xKZOcvCjUlNcIKgRJXnwhNc7iPqrjqV
 +gTAmXNYJnM6vxtHDH2mMaVtdgGxNiFxUsjOnAB9FuK7BhbrsQ669XejqeSbASTjUC0X
 lv3q2AEIkD/SGgJ6ZV0+xwK6SRmekROBuCwbLm2wuUhBFTp4+3aeaEEPzxK+P9dGVidJ
 +dwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731307263; x=1731912063;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UntqNh0SSDcPg0A4KG+9ffl5JXbQpD+82Atqct3kXec=;
 b=DqGVYzgSoWyS1oBctoJh4PnqPnVutIHiqW7mX6ows7Y2QJG+0WWYTYU23kKTOVvIlk
 CMdbjqLEYnc1qqyvq7yhQGsxRXApAIYKw0Hai4OVmbORIhSnopv/j3jNWBAMGX2JNE8O
 JijbkmQUBhqaehBBd3U6+b0++hNCC5bk+xSmezkwh4pCUDF3rz1KfXtVgH0OdfVJ2iU+
 Vha70Rnn7bpc8PpAh8fQOmVueTbnY0CNOEj3AMpCpa7y4bKWmfVBgYm89qSShMyBoRRK
 oJmaTg9Qv8+UHsYuFpqEQqRA15xTNjnRSDlrom4+Ly4s+gyKt+1RiIBe5vqzK7pu0GMp
 c4hw==
X-Gm-Message-State: AOJu0Yxuj+RSNcyToy2Um51hLhh5lOB7Z9cYDCp5dUJDN8i+hItQmEPR
 ddEDfJacpSt2sHiGYOHX0L2w721HYCNBoWfN1FqAdnPaivROmG8ena527Badijw=
X-Google-Smtp-Source: AGHT+IEbUGTu2wZSnZqwvRKYgEq17cts1XTgibILmFWBQif5pVnKSDDx43A32MDjDu1eDosWCCaXHg==
X-Received: by 2002:a17:90b:2749:b0:2e2:d7db:41fa with SMTP id
 98e67ed59e1d1-2e9b1781541mr16638061a91.33.1731307263025; 
 Sun, 10 Nov 2024 22:41:03 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2e9a5f5e5bcsm7870354a91.15.2024.11.10.22.41.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Nov 2024 22:41:02 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 11 Nov 2024 15:40:23 +0900
Subject: [PATCH v2 6/6] virtio-net: Copy received header to buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-queue-v2-6-2f7883a1004f@daynix.com>
References: <20241111-queue-v2-0-2f7883a1004f@daynix.com>
In-Reply-To: <20241111-queue-v2-0-2f7883a1004f@daynix.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

receive_header() used to cast the const qualifier of the pointer to the
received packet away to modify the header. Avoid this by copying the
received header to buffer.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 85 +++++++++++++++++++++++++++++------------------------
 1 file changed, 46 insertions(+), 39 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index e75a8bb1f27a..10fc43064e13 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1690,41 +1690,44 @@ static void virtio_net_hdr_swap(VirtIODevice *vdev, struct virtio_net_hdr *hdr)
  * cache.
  */
 static void work_around_broken_dhclient(struct virtio_net_hdr *hdr,
-                                        uint8_t *buf, size_t size)
+                                        size_t *hdr_len, const uint8_t *buf,
+                                        size_t buf_size, size_t *buf_offset)
 {
     size_t csum_size = ETH_HLEN + sizeof(struct ip_header) +
                        sizeof(struct udp_header);
 
+    buf += *buf_offset;
+    buf_size -= *buf_offset;
+
     if ((hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && /* missing csum */
-        (size >= csum_size && size < 1500) && /* normal sized MTU */
+        (buf_size >= csum_size && buf_size < 1500) && /* normal sized MTU */
         (buf[12] == 0x08 && buf[13] == 0x00) && /* ethertype == IPv4 */
         (buf[23] == 17) && /* ip.protocol == UDP */
         (buf[34] == 0 && buf[35] == 67)) { /* udp.srcport == bootps */
-        net_checksum_calculate(buf, size, CSUM_UDP);
+        memcpy((uint8_t *)hdr + *hdr_len, buf, csum_size);
+        net_checksum_calculate((uint8_t *)hdr + *hdr_len, csum_size, CSUM_UDP);
         hdr->flags &= ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
+        *hdr_len += csum_size;
+        *buf_offset += csum_size;
     }
 }
 
-static void receive_header(VirtIONet *n, const struct iovec *iov, int iov_cnt,
-                           const void *buf, size_t size)
+static size_t receive_header(VirtIONet *n, struct virtio_net_hdr *hdr,
+                             const void *buf, size_t buf_size,
+                             size_t *buf_offset)
 {
-    if (n->has_vnet_hdr) {
-        /* FIXME this cast is evil */
-        void *wbuf = (void *)buf;
-        work_around_broken_dhclient(wbuf, wbuf + n->host_hdr_len,
-                                    size - n->host_hdr_len);
+    size_t hdr_len = n->guest_hdr_len;
 
-        if (n->needs_vnet_hdr_swap) {
-            virtio_net_hdr_swap(VIRTIO_DEVICE(n), wbuf);
-        }
-        iov_from_buf(iov, iov_cnt, 0, buf, sizeof(struct virtio_net_hdr));
-    } else {
-        struct virtio_net_hdr hdr = {
-            .flags = 0,
-            .gso_type = VIRTIO_NET_HDR_GSO_NONE
-        };
-        iov_from_buf(iov, iov_cnt, 0, &hdr, sizeof hdr);
+    memcpy(hdr, buf, sizeof(struct virtio_net_hdr));
+
+    *buf_offset = n->host_hdr_len;
+    work_around_broken_dhclient(hdr, &hdr_len, buf, buf_size, buf_offset);
+
+    if (n->needs_vnet_hdr_swap) {
+        virtio_net_hdr_swap(VIRTIO_DEVICE(n), hdr);
     }
+
+    return hdr_len;
 }
 
 static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
@@ -1892,6 +1895,13 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
     return (index == new_index) ? -1 : new_index;
 }
 
+typedef struct Header {
+    struct virtio_net_hdr_v1_hash virtio_net;
+    struct eth_header eth;
+    struct ip_header ip;
+    struct udp_header udp;
+} Header;
+
 static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
                                       size_t size)
 {
@@ -1901,15 +1911,15 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     VirtQueueElement *elems[VIRTQUEUE_MAX_SIZE];
     size_t lens[VIRTQUEUE_MAX_SIZE];
     struct iovec mhdr_sg[VIRTQUEUE_MAX_SIZE];
-    struct virtio_net_hdr_v1_hash extra_hdr;
+    Header hdr;
     unsigned mhdr_cnt = 0;
     size_t offset, i, guest_offset, j;
     ssize_t err;
 
-    memset(&extra_hdr, 0, sizeof(extra_hdr));
+    memset(&hdr.virtio_net, 0, sizeof(hdr.virtio_net));
 
     if (n->rss_data.enabled && n->rss_data.enabled_software_rss) {
-        int index = virtio_net_process_rss(nc, buf, size, &extra_hdr);
+        int index = virtio_net_process_rss(nc, buf, size, &hdr.virtio_net);
         if (index >= 0) {
             nc = qemu_get_subqueue(n->nic, index % n->curr_queue_pairs);
         }
@@ -1974,21 +1984,18 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
             if (n->mergeable_rx_bufs) {
                 mhdr_cnt = iov_copy(mhdr_sg, ARRAY_SIZE(mhdr_sg),
                                     sg, elem->in_num,
-                                    offsetof(typeof(extra_hdr), hdr.num_buffers),
-                                    sizeof(extra_hdr.hdr.num_buffers));
+                                    offsetof(typeof(hdr),
+                                             virtio_net.hdr.num_buffers),
+                                    sizeof(hdr.virtio_net.hdr.num_buffers));
             }
 
-            receive_header(n, sg, elem->in_num, buf, size);
-            if (n->rss_data.populate_hash) {
-                offset = offsetof(typeof(extra_hdr), hash_value);
-                iov_from_buf(sg, elem->in_num, offset,
-                             (char *)&extra_hdr + offset,
-                             sizeof(extra_hdr.hash_value) +
-                             sizeof(extra_hdr.hash_report));
-            }
-            offset = n->host_hdr_len;
-            total += n->guest_hdr_len;
-            guest_offset = n->guest_hdr_len;
+            guest_offset = n->has_vnet_hdr ?
+                           receive_header(n, (struct virtio_net_hdr *)&hdr,
+                                          buf, size, &offset) :
+                           n->guest_hdr_len;
+
+            iov_from_buf(sg, elem->in_num, 0, &hdr, guest_offset);
+            total += guest_offset;
         } else {
             guest_offset = 0;
         }
@@ -2014,11 +2021,11 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     }
 
     if (mhdr_cnt) {
-        virtio_stw_p(vdev, &extra_hdr.hdr.num_buffers, i);
+        virtio_stw_p(vdev, &hdr.virtio_net.hdr.num_buffers, i);
         iov_from_buf(mhdr_sg, mhdr_cnt,
                      0,
-                     &extra_hdr.hdr.num_buffers,
-                     sizeof extra_hdr.hdr.num_buffers);
+                     &hdr.virtio_net.hdr.num_buffers,
+                     sizeof hdr.virtio_net.hdr.num_buffers);
     }
 
     for (j = 0; j < i; j++) {

-- 
2.47.0


