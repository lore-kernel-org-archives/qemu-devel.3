Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28258C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 15:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0j5b-0001X9-0q; Fri, 04 Apr 2025 11:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1u0ip9-0003U2-Fp
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 11:19:15 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <adamhet@scaleway.com>)
 id 1u0ip4-0003ae-EI
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 11:19:13 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so22347715e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 08:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=scaleway.com; s=google; t=1743779948; x=1744384748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=U9U2VVHp0BFby2wlksJ1oGOvuEuBCYLQ3tORhtPVRdo=;
 b=WI6APQuiM+1N3n6IDmn1IzcwjsxiO+TI87MPvCDKz2DONC1atVItBBNhzS7PtLs9K+
 DGZy2ITV3DofDVL93C22O0y/8CkmgkuDE3xws4H4EvRf+bCXYwnSo+cLQVzwYatwdQis
 4EI0CUMyW08nK2aRpkvkpBhqRz58uT0Ougy3pJQiNuOaVSMd088fSv00zBG20ygWuvbf
 EuK8CMznRxwCboy9s/xoDxTq45ZbQBcoA6XpiZNE86wVSUoQSHhDm/NTc3AZ7/w+aakQ
 3S1lU0z4j5LcPmtI58dCz17q38u/0kbHTJXZZjTucOF7GKXNrey9KKdWKj5IR+kVAIES
 UnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743779948; x=1744384748;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U9U2VVHp0BFby2wlksJ1oGOvuEuBCYLQ3tORhtPVRdo=;
 b=EdepGBxu7N4E7d7U3+O6USXqHlLWSLenc8hjQqb5bKXEt0EOk6whlHlPMMAs5Ws1yq
 lwjG1AxH00q6iCn7QqA9NbfGj2o/1mjaWebvN2SvuJCafcFvIg3xAMUr5WapdKduMDVl
 oFPD6OInQRXueTpR2Kf/O90Vkwe3uaDr4hikauIiYduRFfpixBMHHqRLdWghoVaKMiPM
 SDk3mFR/edWjL1fDVFVeL6CUfL6+r2MqmMibbP9BKjjoIA4Mzk4uTmVoOKJ5MBHxls8j
 zFpykbxH+Dh4lrs3TO+vRJdlxJLnAiM9ZV76ddYuQdUqVJlzs73cDCz+YDFjxpugRKvu
 Xr0g==
X-Gm-Message-State: AOJu0YxZyE4ayPBoUWMqofzpb4MJXTThgc+lUL0S4GQCcnEesnv2fJ7l
 /vzAF6jCdBRLrGAXOCiMdoYuFEA5a6pYkH2qbDVgnKbJ4pLJBt8jD0vCGLs9++BBZIq2mzKO2pj
 jDe0=
X-Gm-Gg: ASbGncuBBUzg0I9Noq6Rd9Abx2yZy+iPFntXgyBRVQigGTDgww4+ztE8dTZmn60kYOD
 uXC/XNA0f/90FgPrBDthVxy24Iw3qgMd+AQm4omOcGguFjnwtQHjXuvllxjricfy4+16qXELOKa
 qLqMpw6Ah9Dja7mWcQGj6UizykklaGGlCfjdUULkDgyY0uGiCbzeQCyeBEBjvgwJUrbu9v0po04
 nvWu5oOCmgDtHLetDGqz6bNedZqDJsAa/ODInI1db9uBzvzMTnh50ati8wmKxtlIh3NNsqYfbv3
 5LBPZBIBMwbYXZs9IQf3OXtJHrprSe7wGRqbMS/5Eoi2/27abQWt/4iRBmWViu483TUK7Q==
X-Google-Smtp-Source: AGHT+IF+dWN7cx5Kk0qj6JdKkgOWe0tPZDlwsDC0w+lXmRSwndGwa//BKd/wsA2112NQYMelsHjYEA==
X-Received: by 2002:a05:600c:384e:b0:43d:b51:46fb with SMTP id
 5b1f17b1804b1-43ed0b483damr32895575e9.2.1743779948073; 
 Fri, 04 Apr 2025 08:19:08 -0700 (PDT)
Received: from localhost (710304585.box.freepro.com. [130.180.219.188])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301b69fdsm4539706f8f.48.2025.04.04.08.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 08:19:07 -0700 (PDT)
From: Antoine Damhet <adamhet@scaleway.com>
To: qemu-devel@nongnu.org
Cc: Antoine Damhet <adamhet@scaleway.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PATCH] Revert "virtio-net: Copy received header to buffer"
Date: Fri,  4 Apr 2025 17:18:21 +0200
Message-ID: <20250404151835.328368-1-adamhet@scaleway.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=adamhet@scaleway.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 04 Apr 2025 11:36:11 -0400
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
 hw/net/virtio-net.c | 85 +++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 46 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index de87cfadffe1..028e7e873c42 100644
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
@@ -1996,18 +1986,21 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
             if (n->mergeable_rx_bufs) {
                 mhdr_cnt = iov_copy(mhdr_sg, ARRAY_SIZE(mhdr_sg),
                                     sg, elem->in_num,
-                                    offsetof(typeof(hdr),
-                                             virtio_net.hdr.num_buffers),
-                                    sizeof(hdr.virtio_net.hdr.num_buffers));
+                                    offsetof(typeof(extra_hdr), hdr.num_buffers),
+                                    sizeof(extra_hdr.hdr.num_buffers));
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
@@ -2033,11 +2026,11 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
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


