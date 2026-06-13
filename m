Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DB9CD98DC
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 22:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYWwv-0003em-3n; Sat, 13 Jun 2026 18:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1wYWwt-0003eT-55
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 18:35:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1wYWwr-0001Gz-1q
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 18:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781390127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NmM/e6NxDJYnBg4ShPAow4xjufvwJ2X4jmv+rZNgCkU=;
 b=ZYII2KU7p9LHf+PNgdENX83/WJK3F62Fz1ZNHNNClORmZLAVxLzIHciCIRxGIIwIsRkXaJ
 y1FiBQYqapqk2YDH0Iy9987f98XDscX9vtrzS3ZDyUZAqOJyf9l8aYW6Ed8D4BJifWYecW
 N6u5DmSBXSR17JXUt2XPcNxolIg47WM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-CDyUF8PGMF6hFLSDT9zg3A-1; Sat,
 13 Jun 2026 18:35:26 -0400
X-MC-Unique: CDyUF8PGMF6hFLSDT9zg3A-1
X-Mimecast-MFC-AGG-ID: CDyUF8PGMF6hFLSDT9zg3A_1781390125
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A94F1956089
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2026 22:35:25 +0000 (UTC)
Received: from kdutta-thinkpadp1gen7.bengluru.csb (unknown [10.74.64.7])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C7B14414; Sat, 13 Jun 2026 22:35:22 +0000 (UTC)
From: Koushik Dutta <kdutta@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v8 2/2] [PATCH 2/2] Implement VirtIO Network Notification
 Coalescing (VIRTIO_NET_F_NOTF_COAL). This allows guests to reduce interrupt
 overhead by configuring coalescing parameters via ethtool -C for both RX and
 TX paths.
Date: Sun, 14 Jun 2026 04:05:13 +0530
Message-ID: <20260613223513.865744-3-kdutta@redhat.com>
In-Reply-To: <20260613223513.865744-1-kdutta@redhat.com>
References: <20260613223513.865744-1-kdutta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kdutta@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The feature supports two coalescing modes:
- Time-based: delay notifications up to N microseconds
- Count-based: delay until N packets are processed

Implementation details:
- Added VIRTIO_NET_CTRL_NOTF_COAL class handling in control virtqueue
- RX path: batches notifications based on packet count or timeout
- TX path: leverages the unified dispatcher to dynamically enable
  timer-based coalescing when guest configures it via ethtool
- Coalescing parameters persist across live migration

Note: During VM launch if we provide tx=timer, then coalescing feature
will not be active. As, user already introduce delay 150ms.

Signed-off-by: Koushik Dutta <kdutta@redhat.com>
---
 hw/net/virtio-net.c            | 144 ++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-net.h |   7 ++
 net/passt.c                    |   1 +
 net/tap.c                      |   1 +
 net/vhost-user.c               |   1 +
 net/vhost-vdpa.c               |   1 +
 6 files changed, 154 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 319842cf28..3dbd2f4c11 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -157,6 +157,16 @@ static void flush_or_purge_queued_packets(NetClientState *nc)
  * - we could suppress RX interrupt if we were so inclined.
  */
 
+static void virtio_net_rx_notify(void *opaque)
+{
+    VirtIONetQueue *q = opaque;
+    VirtIONet *n = q->n;
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+
+    n->rx_pkt_cnt = 0;
+    virtio_notify(vdev, q->rx_vq);
+}
+
 static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
@@ -1004,6 +1014,62 @@ static void virtio_net_set_features(VirtIODevice *vdev,
 
 static void virtio_net_tx_timer(void *opaque);
 
+static int virtio_net_handle_coal(VirtIONet *n, uint8_t cmd,
+                                  struct iovec *iov, unsigned int iov_cnt)
+{
+    struct virtio_net_ctrl_coal coal;
+    VirtIONetQueue *q;
+    size_t s;
+    int i;
+
+    s = iov_to_buf(iov, iov_cnt, 0, &coal, sizeof(coal));
+    if (s != sizeof(coal)) {
+        return VIRTIO_NET_ERR;
+    }
+
+    if (cmd == VIRTIO_NET_CTRL_NOTF_COAL_RX_SET) {
+        n->rx_coal_usecs = le32_to_cpu(coal.max_usecs);
+        n->rx_coal_packets = le32_to_cpu(coal.max_packets);
+        for (i = 0; i < n->max_queue_pairs; i++) {
+            q = &n->vqs[i];
+            if (n->rx_coal_usecs > 0) {
+                if (!q->rx_timer) {
+                    q->rx_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                               virtio_net_rx_notify,
+                                               q);
+                }
+            } else {
+                if (q->rx_timer) {
+                    timer_free(q->rx_timer);
+                    q->rx_timer = NULL;
+                }
+            }
+        }
+    } else if (cmd == VIRTIO_NET_CTRL_NOTF_COAL_TX_SET) {
+        n->tx_coal_usecs = le32_to_cpu(coal.max_usecs);
+        n->tx_coal_packets = le32_to_cpu(coal.max_packets);
+        /* Converted us to ns */
+        n->tx_timeout = n->tx_coal_usecs * 1000;
+        for (i = 0; i < n->max_queue_pairs; i++) {
+            q = &n->vqs[i];
+            if (n->tx_coal_usecs > 0) {
+                if (!q->tx_timer) {
+                    q->tx_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                               virtio_net_tx_timer,
+                                               q);
+                }
+            } else {
+                if (q->tx_timer) {
+                    timer_free(q->tx_timer);
+                    q->tx_timer = NULL;
+                }
+           }
+        }
+    }
+
+    return VIRTIO_NET_OK;
+}
+
 static int virtio_net_handle_rx_mode(VirtIONet *n, uint8_t cmd,
                                      struct iovec *iov, unsigned int iov_cnt)
 {
@@ -1583,6 +1649,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
         status = virtio_net_handle_mq(n, ctrl.cmd, iov, out_num);
     } else if (ctrl.class == VIRTIO_NET_CTRL_GUEST_OFFLOADS) {
         status = virtio_net_handle_offloads(n, ctrl.cmd, iov, out_num);
+    } else if (ctrl.class == VIRTIO_NET_CTRL_NOTF_COAL) {
+        status = virtio_net_handle_coal(n, ctrl.cmd, iov, out_num);
     }
 
     s = iov_from_buf(in_sg, in_num, 0, &status, sizeof(status));
@@ -2042,7 +2110,23 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     }
 
     virtqueue_flush(q->rx_vq, i);
-    virtio_notify(vdev, q->rx_vq);
+
+    /* rx coalescing */
+    n->rx_pkt_cnt += i;
+    if (n->rx_coal_usecs == 0 || n->rx_pkt_cnt >= n->rx_coal_packets) {
+        if (q->rx_timer) {
+            timer_del(q->rx_timer);
+        }
+        virtio_net_rx_notify(q);
+    } else {
+        if (q->rx_timer) {
+            if (!timer_pending(q->rx_timer)) {
+                timer_mod(q->rx_timer,
+                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                          n->rx_coal_usecs * 1000);
+            }
+        }
+    }
 
     return size;
 
@@ -2900,6 +2984,12 @@ static void virtio_net_tx_timer(void *opaque)
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
@@ -2919,6 +3009,7 @@ static void virtio_net_tx_timer(void *opaque)
     ret = virtio_net_flush_tx(q);
     if (ret > 0) {
         virtio_queue_set_notification(q->tx_vq, 0);
+        n->tx_pkt_cnt -= ret;
         q->tx_waiting = 1;
         timer_mod(q->tx_timer,
                   qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout);
@@ -2985,6 +3076,20 @@ static void virtio_net_handle_tx_dispatch(VirtIODevice *vdev, VirtQueue *vq)
                                        virtio_net_tx_timer, q);
         }
         virtio_net_handle_tx_timer(vdev, vq);
+    } else if (n->tx_coal_usecs > 0) {
+        n->tx_pkt_cnt++;
+        if (n->tx_pkt_cnt < n->tx_coal_packets) {
+            if (q->tx_timer) {
+                virtio_net_handle_tx_timer(vdev, vq);
+                return;
+            }
+        } else {
+            n->tx_pkt_cnt = 0;
+            if (q->tx_timer) {
+                timer_del(q->tx_timer);
+            }
+            virtio_net_handle_tx_bh(vdev, vq);
+        }
     } else {
         virtio_net_handle_tx_bh(vdev, vq);
     }
@@ -3098,6 +3203,9 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
     virtio_features_or(features, features, n->host_features_ex);
 
     virtio_add_feature_ex(features, VIRTIO_NET_F_MAC);
+    if (n->tx_timer_activate) {
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_NOTF_COAL);
+    }
 
     if (!peer_has_vnet_hdr(n)) {
         virtio_clear_feature_ex(features, VIRTIO_NET_F_CSUM);
@@ -3252,6 +3360,29 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
     }
 
     virtio_net_commit_rss_config(n);
+    if (n->tx_coal_usecs > 0 || n->rx_coal_usecs > 0) {
+
+        for (i = 0; i < n->max_queue_pairs; i++) {
+            VirtIONetQueue *q = &n->vqs[i];
+            if (n->rx_coal_usecs > 0) {
+                if (!q->rx_timer) {
+                    q->rx_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                               virtio_net_rx_notify,
+                                               q);
+                }
+            }
+
+            if (n->tx_coal_usecs > 0) {
+                n->tx_timeout = n->tx_coal_usecs * 1000;
+                if (!q->tx_timer) {
+                    q->tx_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                               virtio_net_tx_timer,
+                                               q);
+                }
+            }
+        }
+    }
+
     return 0;
 }
 
@@ -3627,6 +3758,10 @@ static const VMStateDescription vmstate_virtio_net_device = {
                          vmstate_virtio_net_tx_waiting),
         VMSTATE_UINT64_TEST(curr_guest_offloads, VirtIONet,
                             has_ctrl_guest_offloads),
+        VMSTATE_UINT32(rx_coal_usecs, VirtIONet),
+        VMSTATE_UINT32(tx_coal_usecs, VirtIONet),
+        VMSTATE_UINT32(rx_coal_packets, VirtIONet),
+        VMSTATE_UINT32(tx_coal_packets, VirtIONet),
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
@@ -4060,6 +4195,11 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
             n->rss_data.specified_hash_types.on_bits |
             n->rss_data.specified_hash_types.auto_bits;
     }
+    n->rx_pkt_cnt = 0;
+    n->tx_pkt_cnt = 0;
+    n->rx_coal_usecs = 0;
+    n->rx_coal_packets = 0;
+    n->tx_coal_packets = 0;
 }
 
 static void virtio_net_device_unrealize(DeviceState *dev)
@@ -4272,6 +4412,8 @@ static const Property virtio_net_properties[] = {
                       VIRTIO_NET_F_GUEST_USO6, true),
     DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
                       VIRTIO_NET_F_HOST_USO, true),
+    DEFINE_PROP_BIT64("vq_notf_coal", VirtIONet, host_features,
+                      VIRTIO_NET_F_NOTF_COAL, true),
     DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-ipv4", VirtIONet,
                                   rss_data.specified_hash_types,
                                   VIRTIO_NET_HASH_REPORT_IPv4 - 1,
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index a4eb3f407e..9612416622 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -159,6 +159,7 @@ typedef struct VirtIONetQueue {
     VirtQueue *rx_vq;
     VirtQueue *tx_vq;
     QEMUTimer *tx_timer;
+    QEMUTimer *rx_timer;
     QEMUBH *tx_bh;
     uint32_t tx_waiting;
     struct {
@@ -230,6 +231,12 @@ struct VirtIONet {
     struct EBPFRSSContext ebpf_rss;
     uint32_t nr_ebpf_rss_fds;
     char **ebpf_rss_fds;
+    uint32_t rx_coal_usecs; /* RX interrupt coalescing timeout (microseconds) */
+    uint32_t rx_coal_packets; /* RX packet count threshold for coalescing */
+    uint32_t rx_pkt_cnt; /* Current RX packet count since last notification */
+    uint32_t tx_coal_usecs; /* TX interrupt coalescing timeout (microseconds) */
+    uint32_t tx_coal_packets; /* TX packet count threshold for coalescing */
+    uint32_t tx_pkt_cnt; /* Current TX packet count since last notification */
     bool tx_timer_activate;
 };
 
diff --git a/net/passt.c b/net/passt.c
index 45440c399b..43b36ed8c5 100644
--- a/net/passt.c
+++ b/net/passt.c
@@ -52,6 +52,7 @@ static const int user_feature_bits[] = {
     VIRTIO_NET_F_GUEST_USO4,
     VIRTIO_NET_F_GUEST_USO6,
     VIRTIO_NET_F_HOST_USO,
+    VIRTIO_NET_F_NOTF_COAL,
 
     /* This bit implies RARP isn't sent by QEMU out of band */
     VIRTIO_NET_F_GUEST_ANNOUNCE,
diff --git a/net/tap.c b/net/tap.c
index 57ffb09885..e6ddbc1eb1 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -63,6 +63,7 @@ static const int kernel_feature_bits[] = {
     VIRTIO_F_NOTIFICATION_DATA,
     VIRTIO_NET_F_RSC_EXT,
     VIRTIO_NET_F_HASH_REPORT,
+    VIRTIO_NET_F_NOTF_COAL,
     VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
     VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
     VHOST_INVALID_FEATURE_BIT
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 2d0fc49b4d..f1e9b7a038 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -54,6 +54,7 @@ static const int user_feature_bits[] = {
     VIRTIO_NET_F_GUEST_USO4,
     VIRTIO_NET_F_GUEST_USO6,
     VIRTIO_NET_F_HOST_USO,
+    VIRTIO_NET_F_NOTF_COAL,
 
     /* This bit implies RARP isn't sent by QEMU out of band */
     VIRTIO_NET_F_GUEST_ANNOUNCE,
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index f1523697e2..0dcd6fb9f1 100644
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
-- 
2.53.0


