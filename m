Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041B6C369A2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 14:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2AL3-0000dS-6H; Tue, 08 Apr 2025 10:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1u2AL1-0000dG-Mu
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 10:54:07 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1u2AKz-0004za-Ah
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 10:54:07 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso53089555e9.1
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 07:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=scaleway.com; s=google; t=1744124043; x=1744728843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=34HMdzTUHPzXzyteSFb2jERXTVF7Lovgf1yiwhcHioo=;
 b=LNOLNaAeHYj5X7qMMOEH74m6lmC3PELWWAD7r1rCev08+2yTNGxqNKEm6QE2dLsNth
 qD1UYekNfdy0/nHulbH5fC/Nf8kCkfwqE3SiDaw87xOgLoSl/bGxgo/V4u0EpE2PGC57
 wdZ5GmHUmGboPc9u3dJlq2cS9idK99qEBZe9BN8OGZAxWt3YowACSFNwx0Bc37ffc/z9
 tbdf+g0UStV+sqlI6my5XecKifm7nOZJe/wvt0g6t6UqP4obRMmevGqq6OVcQhtwncPv
 UF2NFVQzY64OQ1mXLx+e4dJITuppqzz+WD0iWWusM0tXOgFvaZbYeSl6nVNnJhWlFfCk
 GH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744124043; x=1744728843;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=34HMdzTUHPzXzyteSFb2jERXTVF7Lovgf1yiwhcHioo=;
 b=ZvD0uwaMYMQTHr6rmrdJdZf/lq/Q3gAQuYPhniKc0S3tOxQvXg5CPBCDEZVlVEl9ji
 mU4M+ugkA2+05TkuZcfC2WKrmNVuz3bSUWvu5Y37iLFtCrt4+395v1NeTb1rp9dSstQr
 TdzNyG7FtpKNp0ZYdDzM8c8XrzxXCWBvvS+1BCM9UiuUX8wpBcDYe83GbmI0zcIIs+aX
 jlyrtfo7Y0MXbp8KBKWhF/Eibk4WwNfZ4FgB3w2n4e0dxCxMIdRoaTNOjvjGq/cYqgh+
 06RAblYC1tdzi0ddYLb8pMZwmMSK7IYGQWjT+0gXaBqOjtK4HrFlAESJCJ98SWFHGIRU
 Miyg==
X-Gm-Message-State: AOJu0Ywm+qJhl5xSdFS3JhyGKWcrBH8+RZrHtfeUvBaYrpkba56eBX5X
 vAbeTOciXoGhHwZo72eDZlto561S763vnUQbW1xJHXAq7sn7NZSgOC4QZCjHcLq1IEGL7VNR0Aq
 I
X-Gm-Gg: ASbGncvFUQsm9zZ+k5yU8+iM9tDkan14kZwJ619AAbd5ljIsu7+GK3KH/VetF83M4cG
 B5/1gG6NgUCMoW7eiuF3vMH0vGddzQmQixQ4tShuCFPPEAa4hDeKx5kwz4t7b0cnpQ+E7/sanuj
 3DUWc1JyLfqYHYbcHhwl0k/eU2C7MhzytE0aO85vOzGEZiFXpNQphQ1ufoqNL3gc5rJoVbj7CBs
 sNJx/SP0l4qFCyJ/TZcY5h7kf6W4a9A74bNTnGucpz1NV1/S+wkdpp3mNPULsoLEIPm8G91bYGr
 ZsTuuowYzUQcdv2g9kQUEjytau56o1bwKVuk5Go0ZaJ+YIc5rgakNJyscGexD8uvpP1NjQ==
X-Google-Smtp-Source: AGHT+IHqnQcIQPUzGHQ/CIq7XneTgFrJcck8tUclw/czOzqgPlWkKUg+4Bh4b17pzyjP8hodfOdCZA==
X-Received: by 2002:a05:600c:1e13:b0:43c:fc0c:7f33 with SMTP id
 5b1f17b1804b1-43ecf842aa5mr161347025e9.2.1744124042981; 
 Tue, 08 Apr 2025 07:54:02 -0700 (PDT)
Received: from localhost (710304585.box.freepro.com. [130.180.219.188])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30096964sm15230324f8f.15.2025.04.08.07.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 07:54:02 -0700 (PDT)
From: Antoine Damhet <adamhet@scaleway.com>
To: qemu-devel@nongnu.org
Cc: Antoine Damhet <adamhet@scaleway.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH v2] Revert "virtio-net: Copy received header to buffer"
Date: Tue,  8 Apr 2025 16:53:33 +0200
Message-ID: <20250408145345.142947-1-adamhet@scaleway.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=adamhet@scaleway.com; helo=mail-wm1-x32a.google.com
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

This reverts commit 7987d2be5a8bc3a502f89ba8cf3ac3e09f64d1ce.

The goal was to remove the need to patch the (const) input buffer
with a recomputed UDP checksum by copying headers to a RW region and
inject the checksum there. The patch computed the checksum only from the
header fields (missing the rest of the payload) producing an invalid one
and making guests fail to acquire a DHCP lease.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2727
Cc: qemu-stable@nongnu.org
Signed-off-by: Antoine Damhet <adamhet@scaleway.com>
---
v2: Rebased on master due to conflict with c17ad4b11bd2 (
"virtio-net: Fix num_buffers for version 1")

 hw/net/virtio-net.c | 87 +++++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 47 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 340c6b642224..bd37651dabb0 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1702,44 +1702,41 @@ static void virtio_net_hdr_swap(VirtIODevice *vdev, struct virtio_net_hdr *hdr)
  * cache.
  */
 static void work_around_broken_dhclient(struct virtio_net_hdr *hdr,
-                                        size_t *hdr_len, const uint8_t *buf,
-                                        size_t buf_size, size_t *buf_offset)
+                                        uint8_t *buf, size_t size)
 {
     size_t csum_size = ETH_HLEN + sizeof(struct ip_header) +
                        sizeof(struct udp_header);
 
-    buf += *buf_offset;
-    buf_size -= *buf_offset;
-
     if ((hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && /* missing csum */
-        (buf_size >= csum_size && buf_size < 1500) && /* normal sized MTU */
+        (size >= csum_size && size < 1500) && /* normal sized MTU */
         (buf[12] == 0x08 && buf[13] == 0x00) && /* ethertype == IPv4 */
         (buf[23] == 17) && /* ip.protocol == UDP */
         (buf[34] == 0 && buf[35] == 67)) { /* udp.srcport == bootps */
-        memcpy((uint8_t *)hdr + *hdr_len, buf, csum_size);
-        net_checksum_calculate((uint8_t *)hdr + *hdr_len, csum_size, CSUM_UDP);
+        net_checksum_calculate(buf, size, CSUM_UDP);
         hdr->flags &= ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
-        *hdr_len += csum_size;
-        *buf_offset += csum_size;
     }
 }
 
-static size_t receive_header(VirtIONet *n, struct virtio_net_hdr *hdr,
-                             const void *buf, size_t buf_size,
-                             size_t *buf_offset)
+static void receive_header(VirtIONet *n, const struct iovec *iov, int iov_cnt,
+                           const void *buf, size_t size)
 {
-    size_t hdr_len = n->guest_hdr_len;
-
-    memcpy(hdr, buf, sizeof(struct virtio_net_hdr));
-
-    *buf_offset = n->host_hdr_len;
-    work_around_broken_dhclient(hdr, &hdr_len, buf, buf_size, buf_offset);
+    if (n->has_vnet_hdr) {
+        /* FIXME this cast is evil */
+        void *wbuf = (void *)buf;
+        work_around_broken_dhclient(wbuf, wbuf + n->host_hdr_len,
+                                    size - n->host_hdr_len);
 
-    if (n->needs_vnet_hdr_swap) {
-        virtio_net_hdr_swap(VIRTIO_DEVICE(n), hdr);
+        if (n->needs_vnet_hdr_swap) {
+            virtio_net_hdr_swap(VIRTIO_DEVICE(n), wbuf);
+        }
+        iov_from_buf(iov, iov_cnt, 0, buf, sizeof(struct virtio_net_hdr));
+    } else {
+        struct virtio_net_hdr hdr = {
+            .flags = 0,
+            .gso_type = VIRTIO_NET_HDR_GSO_NONE
+        };
+        iov_from_buf(iov, iov_cnt, 0, &hdr, sizeof hdr);
     }
-
-    return hdr_len;
 }
 
 static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
@@ -1907,13 +1904,6 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
     return (index == new_index) ? -1 : new_index;
 }
 
-typedef struct Header {
-    struct virtio_net_hdr_v1_hash virtio_net;
-    struct eth_header eth;
-    struct ip_header ip;
-    struct udp_header udp;
-} Header;
-
 static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
                                       size_t size)
 {
@@ -1923,15 +1913,15 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     VirtQueueElement *elems[VIRTQUEUE_MAX_SIZE];
     size_t lens[VIRTQUEUE_MAX_SIZE];
     struct iovec mhdr_sg[VIRTQUEUE_MAX_SIZE];
-    Header hdr;
+    struct virtio_net_hdr_v1_hash extra_hdr;
     unsigned mhdr_cnt = 0;
     size_t offset, i, guest_offset, j;
     ssize_t err;
 
-    memset(&hdr.virtio_net, 0, sizeof(hdr.virtio_net));
+    memset(&extra_hdr, 0, sizeof(extra_hdr));
 
     if (n->rss_data.enabled && n->rss_data.enabled_software_rss) {
-        int index = virtio_net_process_rss(nc, buf, size, &hdr.virtio_net);
+        int index = virtio_net_process_rss(nc, buf, size, &extra_hdr);
         if (index >= 0) {
             nc = qemu_get_subqueue(n->nic, index % n->curr_queue_pairs);
         }
@@ -1996,20 +1986,23 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
             if (n->mergeable_rx_bufs) {
                 mhdr_cnt = iov_copy(mhdr_sg, ARRAY_SIZE(mhdr_sg),
                                     sg, elem->in_num,
-                                    offsetof(typeof(hdr),
-                                             virtio_net.hdr.num_buffers),
-                                    sizeof(hdr.virtio_net.hdr.num_buffers));
+                                    offsetof(typeof(extra_hdr), hdr.num_buffers),
+                                    sizeof(extra_hdr.hdr.num_buffers));
             } else {
-                hdr.virtio_net.hdr.num_buffers = cpu_to_le16(1);
+                extra_hdr.hdr.num_buffers = cpu_to_le16(1);
             }
 
-            guest_offset = n->has_vnet_hdr ?
-                           receive_header(n, (struct virtio_net_hdr *)&hdr,
-                                          buf, size, &offset) :
-                           n->guest_hdr_len;
-
-            iov_from_buf(sg, elem->in_num, 0, &hdr, guest_offset);
-            total += guest_offset;
+            receive_header(n, sg, elem->in_num, buf, size);
+            if (n->rss_data.populate_hash) {
+                offset = offsetof(typeof(extra_hdr), hash_value);
+                iov_from_buf(sg, elem->in_num, offset,
+                             (char *)&extra_hdr + offset,
+                             sizeof(extra_hdr.hash_value) +
+                             sizeof(extra_hdr.hash_report));
+            }
+            offset = n->host_hdr_len;
+            total += n->guest_hdr_len;
+            guest_offset = n->guest_hdr_len;
         } else {
             guest_offset = 0;
         }
@@ -2035,11 +2028,11 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     }
 
     if (mhdr_cnt) {
-        virtio_stw_p(vdev, &hdr.virtio_net.hdr.num_buffers, i);
+        virtio_stw_p(vdev, &extra_hdr.hdr.num_buffers, i);
         iov_from_buf(mhdr_sg, mhdr_cnt,
                      0,
-                     &hdr.virtio_net.hdr.num_buffers,
-                     sizeof hdr.virtio_net.hdr.num_buffers);
+                     &extra_hdr.hdr.num_buffers,
+                     sizeof extra_hdr.hdr.num_buffers);
     }
 
     for (j = 0; j < i; j++) {
-- 
2.49.0


