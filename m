Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EEFD3B7DD
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 06:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFSHU-0007ha-Pw; Mon, 25 Nov 2024 01:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tFSHF-0007Mg-Aq
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 01:08:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tFSHD-0000RV-OA
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 01:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732514930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JjuPX7KuxWJ4rN1d0cS8/HEkn9VRAOFHKCN1S8O+Uto=;
 b=R3dWFU2kwzh+aNibKapSMVgzq6bhOEeHgNUKv/SNXV/FP2RQVUuiRWQ4oNUFWIo+HstRqV
 BiFoFetWer5jE577U+PXX3nMMmTJPSYlv90qDwg7puaeXH/fzzV70jGlxerp7M71c07aWU
 zHhRrqtVEZAS/ViOWwS37dCd2Y6VSXY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-CYPTpLI4OVKSMMDwPjzarA-1; Mon,
 25 Nov 2024 01:08:46 -0500
X-MC-Unique: CYPTpLI4OVKSMMDwPjzarA-1
X-Mimecast-MFC-AGG-ID: CYPTpLI4OVKSMMDwPjzarA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2B5E1956048; Mon, 25 Nov 2024 06:08:45 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.241])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 026BF30001A2; Mon, 25 Nov 2024 06:08:42 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 6/6] virtio-net: Copy received header to buffer
Date: Mon, 25 Nov 2024 14:08:09 +0800
Message-ID: <20241125060809.15543-7-jasowang@redhat.com>
In-Reply-To: <20241125060809.15543-1-jasowang@redhat.com>
References: <20241125060809.15543-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

receive_header() used to cast the const qualifier of the pointer to the
received packet away to modify the header. Avoid this by copying the
received header to buffer.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c | 85 ++++++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 39 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 44ea72b50e..bc0f31b666 100644
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
2.42.0


