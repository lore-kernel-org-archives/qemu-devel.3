Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE027C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHID-0001ic-ER; Thu, 02 Jul 2026 09:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1wfHI5-0001h4-9t
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:17:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1wfHI2-0008Q8-VB
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782998234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k8AXq2mYNb1GDo+DjVREdz3EV6SUym7jqkW4S2swevw=;
 b=cURJPcmvthx1lixyXYrVLClo3ByDv/0JQS62OcYKXYjgYPvGYy5b4XtDayP8aP4kglrJqU
 5VjvggbQowUvQ8wr9Es9gNblSf4lR/xdKxG+1cbPucKA4lJj0MTEpC2MA30ohaE1VriOLU
 tyw5pV2ayTN1BmomQ2k31ZAbL6xww8Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-sJFNVHRrMj2O-w5qok4l6Q-1; Thu,
 02 Jul 2026 09:17:10 -0400
X-MC-Unique: sJFNVHRrMj2O-w5qok4l6Q-1
X-Mimecast-MFC-AGG-ID: sJFNVHRrMj2O-w5qok4l6Q_1782998229
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B70FD18C0719; Thu,  2 Jul 2026 13:16:46 +0000 (UTC)
Received: from kdutta-thinkpadp1gen7.bengluru.csb (unknown [10.74.81.96])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 916F218007FD; Thu,  2 Jul 2026 13:16:43 +0000 (UTC)
From: Koushik Dutta <kdutta@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v9 2/2] [PATCH 2/2] Implement VirtIO Network Notification
 Coalescing (VIRTIO_NET_F_NOTF_COAL). This allows guests to reduce interrupt
 overhead by configuring coalescing parameters via ethtool -C for both RX and
 TX paths.
Date: Thu,  2 Jul 2026 18:46:32 +0530
Message-ID: <20260702131632.1180309-3-kdutta@redhat.com>
In-Reply-To: <20260702131632.1180309-1-kdutta@redhat.com>
References: <20260702131632.1180309-1-kdutta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kdutta@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The feature supports two coalescing modes:
- Time-based: delay notifications up to N microseconds
- Count-based: delay until N packets are processed

Implementation details:
- Added VIRTIO_NET_CTRL_NOTF_COAL class handling in control virtqueue
- RX path: batches notifications based on packet count or timeout
- TX path: leverages the unified dispatcher to dynamically enable
  timer-based coalescing when guest configures it via ethtool
- Coalescing parameters persist across live migration

Note: When tx=timer is configured at VM launch, the coalescing feature
is automatically disabled because tx=timer already introduces a fixed
150µs delay for packet batching, making notification coalescing redundant.

Signed-off-by: Koushik Dutta <kdutta@redhat.com>
---
 hw/core/machine.c              |   1 +
 hw/net/virtio-net.c            | 176 +++++++++++++++++++++++++++++++--
 include/hw/virtio/virtio-net.h |   7 ++
 net/passt.c                    |   1 +
 net/tap.c                      |   1 +
 net/vhost-user.c               |   1 +
 net/vhost-vdpa.c               |   1 +
 7 files changed, 182 insertions(+), 6 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 4d8b15d99e..55ee886f41 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -43,6 +43,7 @@ GlobalProperty hw_compat_11_0[] = {
     { "chardev-vc", "encoding", "cp437" },
     { "tpm-crb", "cap-chunk", "off" },
     { "tpm-crb", "x-allow-chunk-migration", "off" },
+    { TYPE_VIRTIO_NET, "vq_notf_coal", "off" },
 };
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 319842cf28..4de6aa3b23 100644
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
+    q->rx_pkt_cnt = 0;
+    virtio_notify(vdev, q->rx_vq);
+}
+
 static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
@@ -1004,6 +1014,56 @@ static void virtio_net_set_features(VirtIODevice *vdev,
 
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
+        for (i = 0; i < n->max_queue_pairs; i++) {
+            q = &n->vqs[i];
+            q->rx_coal_usecs = le32_to_cpu(coal.max_usecs);
+            q->rx_coal_packets = le32_to_cpu(coal.max_packets);
+            if (q->rx_coal_usecs > 0) {
+                if (!q->rx_timer) {
+                    q->rx_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                               virtio_net_rx_notify,
+                                               q);
+                }
+            } else {
+                g_clear_pointer(&q->rx_timer, timer_free);
+            }
+        }
+    } else if (cmd == VIRTIO_NET_CTRL_NOTF_COAL_TX_SET) {
+        for (i = 0; i < n->max_queue_pairs; i++) {
+            q = &n->vqs[i];
+            q->tx_coal_usecs = le32_to_cpu(coal.max_usecs);
+            q->tx_coal_packets = le32_to_cpu(coal.max_packets);
+            /* Converted us to ns */
+            n->tx_timeout = q->tx_coal_usecs * 1000;
+            if (q->tx_coal_usecs > 0) {
+                if (!q->tx_timer) {
+                    q->tx_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                               virtio_net_tx_timer,
+                                               q);
+                }
+            } else {
+                g_clear_pointer(&q->tx_timer, timer_free);
+            }
+        }
+    }
+
+    return VIRTIO_NET_OK;
+}
+
 static int virtio_net_handle_rx_mode(VirtIONet *n, uint8_t cmd,
                                      struct iovec *iov, unsigned int iov_cnt)
 {
@@ -1583,6 +1643,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
         status = virtio_net_handle_mq(n, ctrl.cmd, iov, out_num);
     } else if (ctrl.class == VIRTIO_NET_CTRL_GUEST_OFFLOADS) {
         status = virtio_net_handle_offloads(n, ctrl.cmd, iov, out_num);
+    } else if (ctrl.class == VIRTIO_NET_CTRL_NOTF_COAL) {
+        status = virtio_net_handle_coal(n, ctrl.cmd, iov, out_num);
     }
 
     s = iov_from_buf(in_sg, in_num, 0, &status, sizeof(status));
@@ -2042,7 +2104,23 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     }
 
     virtqueue_flush(q->rx_vq, i);
-    virtio_notify(vdev, q->rx_vq);
+
+    /* rx coalescing */
+    q->rx_pkt_cnt += i;
+    if (q->rx_coal_usecs == 0 || q->rx_pkt_cnt >= q->rx_coal_packets) {
+        if (q->rx_timer) {
+            timer_del(q->rx_timer);
+        }
+        virtio_net_rx_notify(q);
+    } else {
+        if (q->rx_timer) {
+            if (!timer_pending(q->rx_timer)) {
+                timer_mod(q->rx_timer,
+                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                          q->rx_coal_usecs * 1000);
+            }
+        }
+    }
 
     return size;
 
@@ -2900,6 +2978,12 @@ static void virtio_net_tx_timer(void *opaque)
     if (ret == -EBUSY || ret == -EINVAL) {
         return;
     }
+    if (q->tx_pkt_cnt < ret) {
+        q->tx_pkt_cnt = 0;
+    } else {
+        q->tx_pkt_cnt -= ret;
+    }
+
     /*
      * If we flush a full burst of packets, assume there are
      * more coming and immediately rearm
@@ -2919,6 +3003,7 @@ static void virtio_net_tx_timer(void *opaque)
     ret = virtio_net_flush_tx(q);
     if (ret > 0) {
         virtio_queue_set_notification(q->tx_vq, 0);
+        q->tx_pkt_cnt -= ret;
         q->tx_waiting = 1;
         timer_mod(q->tx_timer,
                   qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout);
@@ -2985,6 +3070,15 @@ static void virtio_net_handle_tx_dispatch(VirtIODevice *vdev, VirtQueue *vq)
                                        virtio_net_tx_timer, q);
         }
         virtio_net_handle_tx_timer(vdev, vq);
+    } else if (q->tx_coal_usecs > 0 && q->tx_timer) {
+        q->tx_pkt_cnt++;
+        if (q->tx_pkt_cnt < q->tx_coal_packets) {
+            virtio_net_handle_tx_timer(vdev, vq);
+        } else {
+            q->tx_pkt_cnt = 0;
+            timer_del(q->tx_timer);
+            virtio_net_handle_tx_bh(vdev, vq);
+        }
     } else {
         virtio_net_handle_tx_bh(vdev, vq);
     }
@@ -3006,6 +3100,12 @@ static void virtio_net_add_queue(VirtIONet *n, int index)
                             &DEVICE(vdev)->mem_reentrancy_guard);
 
     n->vqs[index].tx_waiting = 0;
+    n->vqs[index].rx_pkt_cnt = 0;
+    n->vqs[index].tx_pkt_cnt = 0;
+    n->vqs[index].rx_coal_usecs = 0;
+    n->vqs[index].tx_coal_usecs = 0;
+    n->vqs[index].rx_coal_packets = 0;
+    n->vqs[index].tx_coal_packets = 0;
     n->vqs[index].n = n;
 }
 
@@ -3018,10 +3118,12 @@ static void virtio_net_del_queue(VirtIONet *n, int index)
     qemu_purge_queued_packets(nc);
 
     virtio_del_queue(vdev, index * 2);
-    if (q->tx_timer) {
-        timer_free(q->tx_timer);
-        q->tx_timer = NULL;
-    } else {
+
+    /* Cleanup coalescing timers */
+    g_clear_pointer(&q->rx_timer, timer_free);
+    g_clear_pointer(&q->tx_timer, timer_free);
+
+    if (q->tx_bh) {
         qemu_bh_delete(q->tx_bh);
         q->tx_bh = NULL;
     }
@@ -3098,6 +3200,13 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
     virtio_features_or(features, features, n->host_features_ex);
 
     virtio_add_feature_ex(features, VIRTIO_NET_F_MAC);
+    if (n->tx_timer_activate) {
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_NOTF_COAL);
+    } else {
+        if (!virtio_has_feature(*features, VIRTIO_NET_F_NOTF_COAL)) {
+            *features &= ~(1ULL << VIRTIO_NET_F_NOTF_COAL);
+        }
+    }
 
     if (!peer_has_vnet_hdr(n)) {
         virtio_clear_feature_ex(features, VIRTIO_NET_F_CSUM);
@@ -3252,6 +3361,27 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
     }
 
     virtio_net_commit_rss_config(n);
+
+    for (i = 0; i < n->max_queue_pairs; i++) {
+        VirtIONetQueue *q = &n->vqs[i];
+        if (q->rx_coal_usecs > 0) {
+            if (!q->rx_timer) {
+                q->rx_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                           virtio_net_rx_notify,
+                                           q);
+            }
+        }
+
+        if (q->tx_coal_usecs > 0) {
+            n->tx_timeout = q->tx_coal_usecs * 1000;
+            if (!q->tx_timer) {
+                q->tx_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                           virtio_net_tx_timer,
+                                           q);
+            }
+        }
+    }
+
     return 0;
 }
 
@@ -3271,13 +3401,41 @@ static int virtio_net_post_load_virtio(VirtIODevice *vdev)
     return 0;
 }
 
+static bool virtio_net_queue_notf_coal_needed(void *opaque)
+{
+    VirtIONetQueue *q = opaque;
+    VirtIONet *n = q->n;
+
+    return virtio_vdev_has_feature(VIRTIO_DEVICE(n), VIRTIO_NET_F_NOTF_COAL);
+}
+
+static const VMStateDescription vmstate_virtio_net_queue_notf_coal = {
+    .name = "virtio-net-queue-tx_waiting/notf-coal",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = virtio_net_queue_notf_coal_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(rx_coal_usecs, VirtIONetQueue),
+        VMSTATE_UINT32(tx_coal_usecs, VirtIONetQueue),
+        VMSTATE_UINT32(rx_coal_packets, VirtIONetQueue),
+        VMSTATE_UINT32(tx_coal_packets, VirtIONetQueue),
+        VMSTATE_UINT32(rx_pkt_cnt, VirtIONetQueue),
+        VMSTATE_UINT32(tx_pkt_cnt, VirtIONetQueue),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 /* tx_waiting field of a VirtIONetQueue */
 static const VMStateDescription vmstate_virtio_net_queue_tx_waiting = {
     .name = "virtio-net-queue-tx_waiting",
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(tx_waiting, VirtIONetQueue),
         VMSTATE_END_OF_LIST()
-   },
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_virtio_net_queue_notf_coal,
+        NULL
+    }
 };
 
 static bool max_queue_pairs_gt_1(void *opaque, int version_id)
@@ -3982,6 +4140,10 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
     if (n->net_conf.tx && strcmp(n->net_conf.tx, "timer") == 0) {
         n->tx_timer_activate = true;
+        if (n->host_features & (1ULL << VIRTIO_NET_F_NOTF_COAL)) {
+            warn_report("virtio-net: 'vq_notf_coal' is incompatible with 'tx=timer',"
+                        "disabling notification coalescing");
+        }
     }
 
     n->net_conf.tx_queue_size = MIN(virtio_net_max_tx_queue_size(n),
@@ -4272,6 +4434,8 @@ static const Property virtio_net_properties[] = {
                       VIRTIO_NET_F_GUEST_USO6, true),
     DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
                       VIRTIO_NET_F_HOST_USO, true),
+    DEFINE_PROP_BIT64("vq_notf_coal", VirtIONet, host_features,
+                      VIRTIO_NET_F_NOTF_COAL, false),
     DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-ipv4", VirtIONet,
                                   rss_data.specified_hash_types,
                                   VIRTIO_NET_HASH_REPORT_IPv4 - 1,
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index a4eb3f407e..550aaea2be 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -159,12 +159,19 @@ typedef struct VirtIONetQueue {
     VirtQueue *rx_vq;
     VirtQueue *tx_vq;
     QEMUTimer *tx_timer;
+    QEMUTimer *rx_timer;
     QEMUBH *tx_bh;
     uint32_t tx_waiting;
     struct {
         VirtQueueElement *elem;
     } async_tx;
     struct VirtIONet *n;
+    uint32_t rx_coal_usecs;   /* RX interrupt coalescing timeout (microseconds) */
+    uint32_t rx_coal_packets; /* RX packet count threshold for coalescing */
+    uint32_t rx_pkt_cnt;      /* Current RX packet count since last notification */
+    uint32_t tx_coal_usecs;   /* TX interrupt coalescing timeout (microseconds) */
+    uint32_t tx_coal_packets; /* TX packet count threshold for coalescing */
+    uint32_t tx_pkt_cnt;      /* Current TX packet count since last notification */
 } VirtIONetQueue;
 
 struct VirtIONet {
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


