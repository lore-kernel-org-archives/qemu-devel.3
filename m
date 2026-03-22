Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C24FD58CA1
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2026 19:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4Ouc-0004RR-ON; Sun, 22 Mar 2026 15:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1w4Oub-0004R5-ES
 for qemu-devel@nongnu.org; Sun, 22 Mar 2026 15:56:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1w4OuZ-0001IM-1X
 for qemu-devel@nongnu.org; Sun, 22 Mar 2026 15:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774209392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8pc3zJLnuIfEaMDtqTOL+WylvUTII++AtHTg616zIbw=;
 b=Oz2PdvDhqSo9WTIYPvhzMG1UTB8f9MVKjuzGGPOW45cSuO4Q0c7vwPrkenbkdseo9Gk13y
 Ubc05sU8AkpB5nQJJHbwDCidrDIxHrWsDFhoCc3rs0e6G0thcT9WGCJLA3apnFTJjk9tLQ
 9Dtu9QVhlGwlFg0vDMLDhiOSWTohgSs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-eN1Tyxk5MUyRydSte-YNaA-1; Sun,
 22 Mar 2026 15:56:30 -0400
X-MC-Unique: eN1Tyxk5MUyRydSte-YNaA-1
X-Mimecast-MFC-AGG-ID: eN1Tyxk5MUyRydSte-YNaA_1774209389
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAA3C1956089
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2026 19:56:29 +0000 (UTC)
Received: from kdutta-thinkpadp1gen7.bengluru.csb (unknown [10.74.64.11])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A98E81800107; Sun, 22 Mar 2026 19:56:26 +0000 (UTC)
From: Koushik Dutta <kdutta@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3] hw/net/virtio-net: add support for notification coalescing
Date: Mon, 23 Mar 2026 01:26:24 +0530
Message-ID: <20260322195624.381837-1-kdutta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kdutta@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Implement VirtIO Network Notification Coalescing (Bit 53).
This allows the guest to manage interrupt frequency using ethtool
-C for both RX and TX paths.

- Added VIRTIO_NET_F_NOTF_COAL to host features.
- Implemented VIRTIO_NET_CTRL_NOTF_COAL class handling in
  virtio_net_handle_ctrl_iov.
- Added logic to store and apply rx/tx usecs and max_packets.
- Added packet counters and threshold logic for both RX and TX data paths.
- Dynamic Dispatcher: Implemented a dispatcher mechanism that
  dynamically switches/activates the notification callback logic
  only after the guest enables TX coalescing via ethtool.

vhost-vdpa: add support for SVQ interrupt coalescing.

This reduces interrupt overhead by batching notifications based on
either a packet count or a time-based threshold.

Signed-off-by: Koushik Dutta <kdutta@redhat.com>
---
 hw/net/virtio-net.c                | 133 +++++++++++++++++++++++++----
 hw/virtio/vhost-shadow-virtqueue.c |   1 +
 hw/virtio/vhost-vdpa.c             |   3 +
 include/hw/virtio/virtio-net.h     |   8 ++
 net/vhost-vdpa.c                   |   7 ++
 5 files changed, 135 insertions(+), 17 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index eccb48ad42..5fb61944f1 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -157,6 +157,15 @@ static void flush_or_purge_queued_packets(NetClientState *nc)
  * - we could suppress RX interrupt if we were so inclined.
  */
 
+static void virtio_net_rx_notify(void *opaque)
+{
+    VirtIONet *n = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+
+    n->rx_pkt_cnt = 0;
+    virtio_notify(vdev, n->vqs[0].rx_vq);
+}
+
 static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
@@ -1081,6 +1090,33 @@ static int virtio_net_handle_offloads(VirtIONet *n, uint8_t cmd,
     }
 }
 
+static int virtio_net_handle_coal(VirtIONet *n, uint8_t cmd,
+                                  struct iovec *iov, unsigned int iov_cnt)
+{
+    struct virtio_net_ctrl_coal coal;
+    size_t s;
+
+    s = iov_to_buf(iov, iov_cnt, 0, &coal, sizeof(coal));
+    if (s != sizeof(coal)) {
+        return VIRTIO_NET_ERR;
+    }
+
+    if (cmd == VIRTIO_NET_CTRL_NOTF_COAL_RX_SET) {
+        n->rx_coal_usecs = le32_to_cpu(coal.max_usecs);
+        n->rx_coal_packets = le32_to_cpu(coal.max_packets);
+        if (!n->rx_index_timer) {
+            n->rx_index_timer = timer_new_us(QEMU_CLOCK_VIRTUAL,
+                                             virtio_net_rx_notify, n);
+        }
+    } else if (cmd == VIRTIO_NET_CTRL_NOTF_COAL_TX_SET) {
+        n->tx_coal_usecs = le32_to_cpu(coal.max_usecs);
+        n->tx_coal_packets = le32_to_cpu(coal.max_packets);
+        n->tx_timeout = n->tx_coal_usecs * 1000;
+    }
+
+    return VIRTIO_NET_OK;
+}
+
 static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
                                  struct iovec *iov, unsigned int iov_cnt)
 {
@@ -1582,6 +1618,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
         status = virtio_net_handle_mq(n, ctrl.cmd, iov, out_num);
     } else if (ctrl.class == VIRTIO_NET_CTRL_GUEST_OFFLOADS) {
         status = virtio_net_handle_offloads(n, ctrl.cmd, iov, out_num);
+    } else if (ctrl.class == VIRTIO_NET_CTRL_NOTF_COAL) {
+        status = virtio_net_handle_coal(n, ctrl.cmd, iov, out_num);
     }
 
     s = iov_from_buf(in_sg, in_num, 0, &status, sizeof(status));
@@ -2041,7 +2079,24 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     }
 
     virtqueue_flush(q->rx_vq, i);
-    virtio_notify(vdev, q->rx_vq);
+
+    /* rx coalescing */
+    n->rx_pkt_cnt += i;
+    if (n->rx_coal_usecs == 0 || n->rx_pkt_cnt >= n->rx_coal_packets) {
+        if (n->rx_index_timer) {
+            timer_del(n->rx_index_timer);
+        }
+        virtio_net_rx_notify(n);
+    } else {
+        if (!n->rx_index_timer) {
+            n->rx_index_timer = timer_new_us(QEMU_CLOCK_VIRTUAL,
+                                             virtio_net_rx_notify, n);
+        }
+        if (!timer_pending(n->rx_index_timer)) {
+            timer_mod(n->rx_index_timer,
+                      qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n->rx_coal_usecs);
+        }
+    }
 
     return size;
 
@@ -2900,6 +2955,12 @@ static void virtio_net_tx_timer(void *opaque)
     if (ret == -EBUSY || ret == -EINVAL) {
         return;
     }
+    if (n->tx_pkt_cnt < ret) {
+        n->tx_pkt_cnt = 0;
+    } else {
+        n->tx_pkt_cnt -= ret;
+    }
+
     /*
      * If we flush a full burst of packets, assume there are
      * more coming and immediately rearm
@@ -2919,6 +2980,7 @@ static void virtio_net_tx_timer(void *opaque)
     ret = virtio_net_flush_tx(q);
     if (ret > 0) {
         virtio_queue_set_notification(q->tx_vq, 0);
+        n->tx_pkt_cnt -= ret;
         q->tx_waiting = 1;
         timer_mod(q->tx_timer,
                   qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout);
@@ -2974,27 +3036,50 @@ static void virtio_net_tx_bh(void *opaque)
     }
 }
 
+static void virtio_net_handle_tx_dispatch(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIONet *n = VIRTIO_NET(vdev);
+    VirtIONetQueue *q = &n->vqs[vq2q(virtio_get_queue_index(vq))];
+    bool use_timer = n->tx_timer_activate || n->tx_coal_usecs > 0 ||
+                     n->tx_coal_packets > 0;
+    bool pkt_limit = (n->tx_coal_packets > 0);
+
+    n->tx_pkt_cnt++;
+    if (use_timer) {
+        if (!pkt_limit || n->tx_pkt_cnt < n->tx_coal_packets) {
+            if (!q->tx_timer) {
+                q->tx_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                           virtio_net_tx_timer,
+                                           q);
+            }
+            virtio_net_handle_tx_timer(vdev, vq);
+        } else {
+            n->tx_pkt_cnt = 0;
+            virtio_net_handle_tx_bh(vdev, vq);
+        }
+    } else {
+        virtio_net_handle_tx_bh(vdev, vq);
+    }
+}
+
 static void virtio_net_add_queue(VirtIONet *n, int index)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
 
-    n->vqs[index].rx_vq = virtio_add_queue(vdev, n->net_conf.rx_queue_size,
-                                           virtio_net_handle_rx);
+    n->vqs[index].rx_vq =
+        virtio_add_queue(vdev,
+                         n->net_conf.rx_queue_size,
+                         virtio_net_handle_rx);
 
-    if (n->net_conf.tx && !strcmp(n->net_conf.tx, "timer")) {
-        n->vqs[index].tx_vq =
-            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
-                             virtio_net_handle_tx_timer);
-        n->vqs[index].tx_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                              virtio_net_tx_timer,
-                                              &n->vqs[index]);
-    } else {
-        n->vqs[index].tx_vq =
-            virtio_add_queue(vdev, n->net_conf.tx_queue_size,
-                             virtio_net_handle_tx_bh);
-        n->vqs[index].tx_bh = qemu_bh_new_guarded(virtio_net_tx_bh, &n->vqs[index],
-                                                  &DEVICE(vdev)->mem_reentrancy_guard);
-    }
+    n->vqs[index].tx_vq =
+        virtio_add_queue(vdev,
+                         n->net_conf.tx_queue_size,
+                         virtio_net_handle_tx_dispatch);
+
+    n->vqs[index].tx_bh =
+        qemu_bh_new_guarded(virtio_net_tx_bh,
+                            &n->vqs[index],
+                            &DEVICE(vdev)->mem_reentrancy_guard);
 
     n->vqs[index].tx_waiting = 0;
     n->vqs[index].n = n;
@@ -3089,6 +3174,7 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
     virtio_features_or(features, features, n->host_features_ex);
 
     virtio_add_feature_ex(features, VIRTIO_NET_F_MAC);
+    virtio_add_feature_ex(features, VIRTIO_NET_F_NOTF_COAL);
 
     if (!peer_has_vnet_hdr(n)) {
         virtio_clear_feature_ex(features, VIRTIO_NET_F_CSUM);
@@ -3972,6 +4058,10 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         error_printf("Defaulting to \"bh\"");
     }
 
+    if (n->net_conf.tx && strcmp(n->net_conf.tx, "timer")) {
+        n->tx_timer_activate = true;
+    }
+
     n->net_conf.tx_queue_size = MIN(virtio_net_max_tx_queue_size(n),
                                     n->net_conf.tx_queue_size);
 
@@ -4048,6 +4138,13 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
             n->rss_data.specified_hash_types.on_bits |
             n->rss_data.specified_hash_types.auto_bits;
     }
+    n->rx_pkt_cnt = 0;
+    n->tx_pkt_cnt = 0;
+    n->rx_coal_usecs = 0;
+    n->tx_coal_usecs = 0;
+    n->rx_coal_packets = 0;
+    n->tx_coal_packets = 0;
+    n->rx_index_timer = NULL;
 }
 
 static void virtio_net_device_unrealize(DeviceState *dev)
@@ -4262,6 +4359,8 @@ static const Property virtio_net_properties[] = {
                       VIRTIO_NET_F_GUEST_USO6, true),
     DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
                       VIRTIO_NET_F_HOST_USO, true),
+    DEFINE_PROP_BIT64("vq_notf_coal", VirtIONet, host_features,
+                      VIRTIO_NET_F_NOTF_COAL, true),
     DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-ipv4", VirtIONet,
                                   rss_data.specified_hash_types,
                                   VIRTIO_NET_HASH_REPORT_IPv4 - 1,
diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 6242aeb69c..104ed0ce8f 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -37,6 +37,7 @@ bool vhost_svq_valid_features(uint64_t features, Error **errp)
         case VIRTIO_RING_F_INDIRECT_DESC:
             continue;
 
+        case VIRTIO_F_RING_RESET:
         case VIRTIO_F_ACCESS_PLATFORM:
             /* SVQ trust in the host's IOMMU to translate addresses */
         case VIRTIO_F_VERSION_1:
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 2f8f11df86..8eb9bdb961 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1541,6 +1541,9 @@ static int vhost_vdpa_get_features(struct vhost_dev *dev,
     if (ret == 0) {
         /* Add SVQ logging capabilities */
         *features |= BIT_ULL(VHOST_F_LOG_ALL);
+
+        /* Add notification coalescing features */
+        *features |= BIT_ULL(VIRTIO_NET_F_NOTF_COAL);
     }
 
     return ret;
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 5b8ab7bda7..024501ed37 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -231,6 +231,14 @@ struct VirtIONet {
     struct EBPFRSSContext ebpf_rss;
     uint32_t nr_ebpf_rss_fds;
     char **ebpf_rss_fds;
+    QEMUTimer *rx_index_timer;
+    uint32_t rx_coal_usecs;
+    uint32_t rx_coal_packets;
+    uint32_t rx_pkt_cnt;
+    uint32_t tx_coal_usecs;
+    uint32_t tx_coal_packets;
+    uint32_t tx_pkt_cnt;
+    bool tx_timer_activate;
 };
 
 size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 3df6091274..3fef894d8d 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -70,6 +70,7 @@ static const int vdpa_feature_bits[] = {
     VIRTIO_NET_F_CTRL_RX,
     VIRTIO_NET_F_CTRL_RX_EXTRA,
     VIRTIO_NET_F_CTRL_VLAN,
+    VIRTIO_NET_F_NOTF_COAL,
     VIRTIO_NET_F_CTRL_VQ,
     VIRTIO_NET_F_GSO,
     VIRTIO_NET_F_GUEST_CSUM,
@@ -115,6 +116,12 @@ static const uint64_t vdpa_svq_device_features =
     BIT_ULL(VIRTIO_NET_F_HOST_UFO) |
     BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |
     BIT_ULL(VIRTIO_NET_F_STATUS) |
+    BIT_ULL(VIRTIO_F_RING_RESET) |
+    BIT_ULL(VIRTIO_NET_F_GUEST_USO4) |
+    BIT_ULL(VIRTIO_NET_F_GUEST_USO6) |
+    BIT_ULL(VIRTIO_NET_F_HOST_USO) |
+    BIT_ULL(VIRTIO_NET_F_GUEST_ANNOUNCE) |
+    BIT_ULL(VIRTIO_NET_F_NOTF_COAL) |
     BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |
     BIT_ULL(VIRTIO_NET_F_GSO) |
     BIT_ULL(VIRTIO_NET_F_CTRL_RX) |
-- 
2.53.0


