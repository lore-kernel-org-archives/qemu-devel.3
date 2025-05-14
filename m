Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37210C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBlc-0001vp-N9; Wed, 14 May 2025 09:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBiT-0006kt-Kc; Wed, 14 May 2025 09:00:10 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFBiP-00080v-PG; Wed, 14 May 2025 09:00:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E600A121AF0;
 Wed, 14 May 2025 15:57:49 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 900BE20B85E;
 Wed, 14 May 2025 15:57:59 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Antoine Damhet <adamhet@scaleway.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.4 18/34] Revert "virtio-net: Copy received header to
 buffer"
Date: Wed, 14 May 2025 15:57:40 +0300
Message-Id: <20250514125758.92030-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
References: <qemu-stable-9.2.4-20250514155748@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Antoine Damhet <adamhet@scaleway.com>

This reverts commit 7987d2be5a8bc3a502f89ba8cf3ac3e09f64d1ce.

The goal was to remove the need to patch the (const) input buffer
with a recomputed UDP checksum by copying headers to a RW region and
inject the checksum there. The patch computed the checksum only from the
header fields (missing the rest of the payload) producing an invalid one
and making guests fail to acquire a DHCP lease.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2727
Cc: qemu-stable@nongnu.org
Signed-off-by: Antoine Damhet <adamhet@scaleway.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250408145345.142947-1-adamhet@scaleway.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit e28fbd1c525db21f0502b85517f49504c9f9dcd8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 78b7d88756..09ff80c995 100644
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
2.39.5


