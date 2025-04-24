Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C0CC369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tDc-0006yL-M6; Thu, 24 Apr 2025 05:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u7tDZ-0006pt-EI
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:50:05 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u7tDW-0002gC-AU
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:50:05 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3012a0c8496so641256a91.2
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 02:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1745488200; x=1746093000;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rUPPROkU4RBV4RhAwljvTt8Qn8uFPYHRFG0fSZAQZpg=;
 b=geEd12Jou9fpSQnqkm2klrC6GPKuCyG7t7U+8tFD6FP+fWtwGOHc8e2mAFt9e8tnL2
 s7GpTBeYNFfyQ2wjuQyA1J8Z4bDQQ0t0Y5m7JA+LWkVJQBdzG97GTkdPmJeI1JNAqqIY
 38mH8jZjRbYGOscXI0Qis6TIZjVS1RP7yGM8htgT5kGEP3Gy4L4TTvveKy6j6FQRXlc4
 Uaee0ThGbBSp57wGrHIa+6jArXKjJzjuT2kKpBEjrrdaYQJ9yba9u64telVH7GuftomV
 rNP1Q1N5CQDuj1NOLCe2VKrTRy1/41aW+g2fNLthrpwWLGvA8kebjN3rMOaJMIPI+0W0
 6ZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745488200; x=1746093000;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rUPPROkU4RBV4RhAwljvTt8Qn8uFPYHRFG0fSZAQZpg=;
 b=e69RUoOSfRsEBrXutLl2jfOnAuxfjvNNQZE2SeGNq+dfn3h8P/oaTBShjK0mn+bCrc
 bBmjKq1dgAWIo7QveCb+g9OQIu2/LQIRQQaqohfVM90gZTPBO7Up/aPUhcB8ZcdX4mcI
 YxDPulGIrx8n2+N/zbXtbzRZgaIg8+o53SEUAwprF0yR+8A3EmNbbBJ5nERt2EOPoEzR
 EaEN3HWt9VAv3OlIwEKoDv8zBK3UzEjTqP0v+61oATwyBeXMeu/ZJ5vCYzcTdMirCQcT
 H9wJAcm9+SJ8v917ToNP3nwcbfnPFCFRUiK86cdWbc8jUrYWTRP/8OVeX8RCOGKm7VGX
 Qm6w==
X-Gm-Message-State: AOJu0YzToJxfmCKsXI5r5D706mdQJHBB7W+il3GyaWY4rNeRc8ibhnTU
 Bn1Zef/1mvmgBA/E4YFhu5sQg5EUAiBqmMM9WgHgaf1lOVLXk6QvSPGA8SX4VBg=
X-Gm-Gg: ASbGnctBhGiI8TGjB1LDfJQx4Y93TmPsyOShZRQkrM923jDqfX4Y9sJHyKUGDryhe0m
 3ImgRyse5Is19CkmMdc3ymQLqwGVqpUk1wn0VlPxtLqZ3oEl/oku3uiciCbrvAXfVIT09yoQjOr
 xnFFL35qu1obzaXIqbomWGslgYfw0vn++7Z3IXkt+SIo6MM+X3p5WgB0XORhQ6DLBu7lO74yeop
 8v/gGM2XPes2g/nEBicSh8IAYQ/fXAtotiEXTS1cJIZpsyTT12n6oJROLtiqZxspkWisI9on8YG
 +Lolry8WlJ332BjHNIVKDn6DcBG7edSJfLzbG+V+l7JX
X-Google-Smtp-Source: AGHT+IGxwpPnRamyVkoVWm0YukFQ9BHNdtz9HQKbcT5ZN72qiA7Dg5moz5fo8PKY+xV1eKo3+qYslg==
X-Received: by 2002:a17:90b:5445:b0:305:2d27:7cb0 with SMTP id
 98e67ed59e1d1-309ed29ce8bmr2898375a91.21.1745488200258; 
 Thu, 24 Apr 2025 02:50:00 -0700 (PDT)
Received: from localhost ([157.82.205.213])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-309ef0612b1sm897602a91.11.2025.04.24.02.49.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 02:49:59 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 24 Apr 2025 18:49:57 +0900
Subject: [PATCH v2] virtio-net: Copy received packet to buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-reapply-v2-1-d0ba763ac782@daynix.com>
X-B4-Tracking: v=1; b=H4sIAEQJCmgC/2XMSwrDIBSF4a2EO67FR6K0o+yjZBB8NBdaFS0SC
 e69NtMO/8PhOyDbhDbDfTgg2YIZg+/BLwPobfVPS9D0Bk75REcuSLJrjK9KpGBKTmw0Shro75i
 sw/2UHkvvDfMnpHrChf3Wf6Mwwoh0o9OCcnWjcjZr9bhfdXjD0lr7Apwe84qfAAAA
X-Change-ID: 20250423-reapply-63176514d76d
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Antoine Damhet <adamhet@scaleway.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1032.google.com
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

Commit e28fbd1c525d ("Revert "virtio-net: Copy received header to
buffer"") reverted commit 7987d2be5a8b, which attempted to remove the
need to patch the (const) input buffer.

Achieve the original goal by copying the header or the entire packet to
a writable buffer as necessary. Copy the virtio-net header when patching
it. Copy the entire packet when filling the UDP checksum as required by
net_checksum_calculate().

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Supersedes: <20250405-mtu-v1-1-08c5910fa6fd@daynix.com>
("[PATCH] virtio-net: Copy all for dhclient workaround")

This reapplies commit 7987d2be5a8b ("virtio-net: Copy all for dhclient
workaround"), which was reverted by commit e28fbd1c525d ("Revert
"virtio-net: Copy received header to buffer""), with a fix in the
superseded patch. It also renames identifiers according to the
discussion with Antoine Damhet.
---
Changes in v2:
- Rewrote the message avoiding archeology as suggested by
  Michael S. Tsirkin.
- Link to v1: https://lore.kernel.org/qemu-devel/20250423-reapply-v1-1-6f4fc3027906@daynix.com
---
 hw/net/virtio-net.c | 91 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 48 insertions(+), 43 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index bd37651dabb0..f1688e0b2536 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1687,6 +1687,11 @@ static void virtio_net_hdr_swap(VirtIODevice *vdev, struct virtio_net_hdr *hdr)
     virtio_tswap16s(vdev, &hdr->csum_offset);
 }
 
+typedef struct PacketPrefix {
+    struct virtio_net_hdr_v1_hash virtio_net;
+    uint8_t payload[1500];
+} PacketPrefix;
+
 /* dhclient uses AF_PACKET but doesn't pass auxdata to the kernel so
  * it never finds out that the packets don't have valid checksums.  This
  * causes dhclient to get upset.  Fedora's carried a patch for ages to
@@ -1701,42 +1706,46 @@ static void virtio_net_hdr_swap(VirtIODevice *vdev, struct virtio_net_hdr *hdr)
  * we should provide a mechanism to disable it to avoid polluting the host
  * cache.
  */
-static void work_around_broken_dhclient(struct virtio_net_hdr *hdr,
-                                        uint8_t *buf, size_t size)
+static void work_around_broken_dhclient(struct PacketPrefix *prefix,
+                                        size_t *prefix_len, const uint8_t *buf,
+                                        size_t buf_size, size_t *buf_offset)
 {
     size_t csum_size = ETH_HLEN + sizeof(struct ip_header) +
                        sizeof(struct udp_header);
+    uint8_t *payload = (uint8_t *)prefix + *prefix_len;
+
+    buf += *buf_offset;
+    buf_size -= *buf_offset;
 
-    if ((hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && /* missing csum */
-        (size >= csum_size && size < 1500) && /* normal sized MTU */
+    if ((prefix->virtio_net.hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && /* missing csum */
+        (buf_size >= csum_size && buf_size < sizeof(prefix->payload)) && /* normal sized MTU */
         (buf[12] == 0x08 && buf[13] == 0x00) && /* ethertype == IPv4 */
         (buf[23] == 17) && /* ip.protocol == UDP */
         (buf[34] == 0 && buf[35] == 67)) { /* udp.srcport == bootps */
-        net_checksum_calculate(buf, size, CSUM_UDP);
-        hdr->flags &= ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
+        memcpy(payload, buf, buf_size);
+        net_checksum_calculate(payload, buf_size, CSUM_UDP);
+        prefix->virtio_net.hdr.flags &= ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
+        *prefix_len += buf_size;
+        *buf_offset += buf_size;
     }
 }
 
-static void receive_header(VirtIONet *n, const struct iovec *iov, int iov_cnt,
-                           const void *buf, size_t size)
+static size_t receive_prefix(VirtIONet *n, PacketPrefix *prefix,
+                             const void *buf, size_t buf_size,
+                             size_t *buf_offset)
 {
-    if (n->has_vnet_hdr) {
-        /* FIXME this cast is evil */
-        void *wbuf = (void *)buf;
-        work_around_broken_dhclient(wbuf, wbuf + n->host_hdr_len,
-                                    size - n->host_hdr_len);
+    size_t prefix_len = n->guest_hdr_len;
 
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
+    memcpy(prefix, buf, sizeof(struct virtio_net_hdr));
+
+    *buf_offset = n->host_hdr_len;
+    work_around_broken_dhclient(prefix, &prefix_len, buf, buf_size, buf_offset);
+
+    if (n->needs_vnet_hdr_swap) {
+        virtio_net_hdr_swap(VIRTIO_DEVICE(n), (struct virtio_net_hdr *)prefix);
     }
+
+    return prefix_len;
 }
 
 static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
@@ -1913,15 +1922,15 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     VirtQueueElement *elems[VIRTQUEUE_MAX_SIZE];
     size_t lens[VIRTQUEUE_MAX_SIZE];
     struct iovec mhdr_sg[VIRTQUEUE_MAX_SIZE];
-    struct virtio_net_hdr_v1_hash extra_hdr;
+    PacketPrefix prefix;
     unsigned mhdr_cnt = 0;
     size_t offset, i, guest_offset, j;
     ssize_t err;
 
-    memset(&extra_hdr, 0, sizeof(extra_hdr));
+    memset(&prefix.virtio_net, 0, sizeof(prefix.virtio_net));
 
     if (n->rss_data.enabled && n->rss_data.enabled_software_rss) {
-        int index = virtio_net_process_rss(nc, buf, size, &extra_hdr);
+        int index = virtio_net_process_rss(nc, buf, size, &prefix.virtio_net);
         if (index >= 0) {
             nc = qemu_get_subqueue(n->nic, index % n->curr_queue_pairs);
         }
@@ -1986,23 +1995,19 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
             if (n->mergeable_rx_bufs) {
                 mhdr_cnt = iov_copy(mhdr_sg, ARRAY_SIZE(mhdr_sg),
                                     sg, elem->in_num,
-                                    offsetof(typeof(extra_hdr), hdr.num_buffers),
-                                    sizeof(extra_hdr.hdr.num_buffers));
+                                    offsetof(typeof(prefix),
+                                             virtio_net.hdr.num_buffers),
+                                    sizeof(prefix.virtio_net.hdr.num_buffers));
             } else {
-                extra_hdr.hdr.num_buffers = cpu_to_le16(1);
+                prefix.virtio_net.hdr.num_buffers = cpu_to_le16(1);
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
+                           receive_prefix(n, &prefix, buf, size, &offset) :
+                           n->guest_hdr_len;
+
+            iov_from_buf(sg, elem->in_num, 0, &prefix, guest_offset);
+            total += guest_offset;
         } else {
             guest_offset = 0;
         }
@@ -2028,11 +2033,11 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     }
 
     if (mhdr_cnt) {
-        virtio_stw_p(vdev, &extra_hdr.hdr.num_buffers, i);
+        virtio_stw_p(vdev, &prefix.virtio_net.hdr.num_buffers, i);
         iov_from_buf(mhdr_sg, mhdr_cnt,
                      0,
-                     &extra_hdr.hdr.num_buffers,
-                     sizeof extra_hdr.hdr.num_buffers);
+                     &prefix.virtio_net.hdr.num_buffers,
+                     sizeof prefix.virtio_net.hdr.num_buffers);
     }
 
     for (j = 0; j < i; j++) {

---
base-commit: 1da8f3a3c53b604edfe0d55e475102640490549e
change-id: 20250423-reapply-63176514d76d

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


