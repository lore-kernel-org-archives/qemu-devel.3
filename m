Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CE4E65D26
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 05:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tELpU-00063F-7i; Fri, 22 Nov 2024 00:03:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tELpO-0005pt-Fx
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 00:03:35 -0500
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tELpL-0006X2-O6
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 00:03:34 -0500
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2958ddf99a7so1597748fac.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 21:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1732251810; x=1732856610;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lm07o6s5E1yl5hc4ZDjLUu2SLmHwkCbH+IFUtNg70Mo=;
 b=EUg0FomH8aAuNdRvWYi0d68jxU2lauo978HN6Wj8kh3buZypK2n7zdA2WmkCPbZOu5
 xuHcvA1Sn87uRYAjm++wZM/9VupVTk9AbtM7mSAakdABKVL+WDh2C/9YUCpWO722e3TT
 K+vvCAS2pgAcnlXNCPzsN+oHs0ZgfCKIsmKoa8gWURJ9onp1t22vZd68dTNaimmcbQW4
 fEF6ZziRQnA9/ocqSMlz2PJrhE27OvEbbywBHcuv3fXQhXUI55qkEpRixuasVL2ateu5
 txEUpQXheExVWIUPrgw7qKesAf/TrVdW9pHqw6acTGwsMoscWA3ekPjhFaEzIW93eoD2
 bmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732251810; x=1732856610;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lm07o6s5E1yl5hc4ZDjLUu2SLmHwkCbH+IFUtNg70Mo=;
 b=l0CzUsXOI2mOyxDeXc1n+aT7+9cEn2VFjUVZLahgme+3ftp+qh+CiS57yb+0rSi58z
 TgV5ItNOz4K4g67L+APRUK2KvLXY4mufeZvpvhftbyMvL2EBab3fWzxiDa3eWD6HSKxd
 aucBvMrU3zE327IPsBCI1PvArwx2HKXq0GQElIzbhOlx+N7dabGRH3WAEw/kTUTRNz+U
 vefnxQvgRAHU72BSYF4YSFVCmvU5qn+4+xTGQ1U6pbaxDGlY9wkjDGaymYId3/PCHX8V
 eN8eddc6gr4qoKLqefQzX8f304WXRMLB3X7VGeBU0mLzQWdS9K5p6C5YsKtpKCL9BfN7
 qk7g==
X-Gm-Message-State: AOJu0YyUseSGW8E1Qb388qZpx04C346P2hvV9A73rbI2ZGATuJJGY1OJ
 gtYV3RoWhz0qrb5fxaXRV9a+zCAFYL87pMI4c2fbqQ3xAjZbfmYf/c5tRLhm62EhUrEkh5aWEpF
 b+ng=
X-Gm-Gg: ASbGncuMHdHPLPPO1DX6VO/qyvy+jbXf5WgZbnWAB3dNTy+1PC7knaFKpR2PdjQf8dI
 TVUWQa4OjGZKQ5gPwUZrXryiHxLXowGx+AD6m2fIvFr4z60culj18vN6WlYpWzRSOT7NbUWoUEE
 Z8UfsG7ZPqT8n05zHrvb+g+/e0w4fjrd3dhoFIPIjGHp19w4bExzTUAkNLGoPISqnnbuPd7DenO
 7huFDlYdK9PKSgCqSC02nBFuQxUoz3oHHPkZw8iCAv1ANgWMshFpA==
X-Google-Smtp-Source: AGHT+IEki3PDwileZavRyApRUozdmVz2sm81vdfgl/UThyJ4Vw/td6BUwJcCAd6orGkvFV99vGGVSQ==
X-Received: by 2002:a05:6870:3b0a:b0:296:827c:9073 with SMTP id
 586e51a60fabf-29720d91504mr1837604fac.26.1732251810362; 
 Thu, 21 Nov 2024 21:03:30 -0800 (PST)
Received: from localhost ([157.82.207.167])
 by smtp.gmail.com with UTF8SMTPSA id
 586e51a60fabf-2971d56d992sm377978fac.9.2024.11.21.21.03.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 21:03:29 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 22 Nov 2024 14:03:12 +0900
Subject: [PATCH v3 6/6] virtio-net: Copy received header to buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-queue-v3-6-f2ff03b8dbfd@daynix.com>
References: <20241122-queue-v3-0-f2ff03b8dbfd@daynix.com>
In-Reply-To: <20241122-queue-v3-0-f2ff03b8dbfd@daynix.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x2e.google.com
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
index 44ea72b50e0e..bc0f31b6669b 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1695,41 +1695,44 @@ static void virtio_net_hdr_swap(VirtIODevice *vdev, struct virtio_net_hdr *hdr)
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
@@ -1897,6 +1900,13 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
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
@@ -1906,15 +1916,15 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
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
@@ -1979,21 +1989,18 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
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
@@ -2019,11 +2026,11 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
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


