Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249B2FED2D1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 07:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0aH1-00068h-I8; Thu, 12 Mar 2026 03:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w0aGv-00060N-OS
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 03:15:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w0aGt-0001di-9P
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 03:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773299750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zoqm4IOr0n5qGBJHI6uKZ5VJOLDmV3ZKkec2FGaY77A=;
 b=VzDjnj6Kr6cgj785WQ6UggAi3YBbXVaJ8LgFn7I06ubWrNceVDO67Xo6AUHykyxKniM57n
 dE5OSJSe3n5GhWMwqel3LHy7LLZKoLjJ4vPhm3D4x5pXvC991a/eOY8Mm9dGR/bx4f7yje
 BBGdJ3W+oatv3yLlf3m1Llh5wPS+zTw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-vRqcH31sPCKHzxgcGVGJ0A-1; Thu,
 12 Mar 2026 03:15:48 -0400
X-MC-Unique: vRqcH31sPCKHzxgcGVGJ0A-1
X-Mimecast-MFC-AGG-ID: vRqcH31sPCKHzxgcGVGJ0A_1773299747
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A5CA195609E; Thu, 12 Mar 2026 07:15:47 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.170])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E6F181800107; Thu, 12 Mar 2026 07:15:43 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jmarcin@redhat.com, qemu-devel@nongnu.org
Subject: [RFC v2 8/9] virtio-net: handle short vnet headers on replay RX
Date: Thu, 12 Mar 2026 15:09:36 +0800
Message-ID: <20260312071415.1836655-9-lulu@redhat.com>
In-Reply-To: <20260312071415.1836655-1-lulu@redhat.com>
References: <20260312071415.1836655-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

During switchover replay, packets injected through AF_PACKET can come
back from the bridge with a 10-byte virtio_net_hdr even though QEMU
expects a 12-byte merged-rxbuf header. The missing two bytes shift the
Ethernet frame and corrupt the packet seen by the guest.

Detect this case by comparing the EtherType at the expected position
with the value two bytes earlier. When only the shifted position
contains a recognized protocol, reduce the effective host header length
by two for this packet.

Only apply the heuristic while vhost is running, and carry the adjusted
header length through the normal receive path without copying the
buffer.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/net/virtio-net.c | 54 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 616590fb82..29dbe3d8d5 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -144,6 +144,36 @@ static int vq2q(int queue_index)
     return queue_index / 2;
 }
 
+static bool virtio_net_rx_known_ethertype(uint16_t proto)
+{
+    if (proto <= 1500) {
+        /* IEEE 802.3 length field */
+        return true;
+    }
+
+    switch (proto) {
+    case ETH_P_IP:
+    case ETH_P_IPV6:
+    case ETH_P_ARP:
+    case ETH_P_VLAN:
+    case ETH_P_DVLAN:
+    case 0x0842: /* Wake-on-LAN */
+    case 0x22f0: /* IEEE 802.1Qbe / TSN */
+    case 0x8809: /* Slow protocols / LACP */
+    case 0x8863: /* PPPoE discovery */
+    case 0x8864: /* PPPoE session */
+    case 0x8906: /* FCoE */
+    case 0x8914: /* FCoE Init */
+    case 0x88cc: /* LLDP */
+    case 0x88e1: /* HomePlug AV */
+    case 0x88f7: /* PTP */
+    case 0x8915: /* RoCE */
+        return true;
+    default:
+        return false;
+    }
+}
+
 static void flush_or_purge_queued_packets(NetClientState *nc)
 {
     if (!nc->peer) {
@@ -1780,7 +1810,8 @@ static void receive_header(VirtIONet *n, const struct iovec *iov, int iov_cnt,
     }
 }
 
-static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
+static int receive_filter(VirtIONet *n, const uint8_t *buf, int size,
+                          size_t host_hdr_len)
 {
     static const uint8_t bcast[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
     static const uint8_t vlan[] = {0x81, 0x00};
@@ -1790,7 +1821,7 @@ static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
     if (n->promisc)
         return 1;
 
-    ptr += n->host_hdr_len;
+    ptr += host_hdr_len;
 
     if (!memcmp(&ptr[12], vlan, sizeof(vlan))) {
         int vid = lduw_be_p(ptr + 14) & 0xfff;
@@ -1955,12 +1986,25 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     QEMU_UNINITIALIZED size_t lens[VIRTQUEUE_MAX_SIZE];
     QEMU_UNINITIALIZED struct iovec mhdr_sg[VIRTQUEUE_MAX_SIZE];
     struct virtio_net_hdr_v1_hash extra_hdr;
+    size_t host_hdr_len = n->host_hdr_len;
     unsigned mhdr_cnt = 0;
     size_t offset, i, guest_offset, j;
     ssize_t err;
 
     memset(&extra_hdr, 0, sizeof(extra_hdr));
 
+    if (n->vhost_started &&
+        host_hdr_len >= 12 &&
+        size >= host_hdr_len + ETH_HLEN) {
+        uint16_t et_at_host = lduw_be_p(buf + host_hdr_len + 12);
+        uint16_t et_at_m2  = lduw_be_p(buf + host_hdr_len + 10);
+
+        if (!virtio_net_rx_known_ethertype(et_at_host) &&
+            virtio_net_rx_known_ethertype(et_at_m2)) {
+            host_hdr_len -= 2;
+        }
+    }
+
     if (n->rss_data.enabled && n->rss_data.enabled_software_rss) {
         int index = virtio_net_process_rss(nc, buf, size, &extra_hdr);
         if (index >= 0) {
@@ -1975,11 +2019,11 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     q = virtio_net_get_subqueue(nc);
 
     /* hdr_len refers to the header we supply to the guest */
-    if (!virtio_net_has_buffers(q, size + n->guest_hdr_len - n->host_hdr_len)) {
+    if (!virtio_net_has_buffers(q, size + n->guest_hdr_len - host_hdr_len)) {
         return 0;
     }
 
-    if (!receive_filter(n, buf, size))
+    if (!receive_filter(n, buf, size, host_hdr_len))
         return size;
 
     offset = i = 0;
@@ -2041,7 +2085,7 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
                              sizeof(extra_hdr.hash_value) +
                              sizeof(extra_hdr.hash_report));
             }
-            offset = n->host_hdr_len;
+            offset = host_hdr_len;
             total += n->guest_hdr_len;
             guest_offset = n->guest_hdr_len;
         } else {
-- 
2.52.0


