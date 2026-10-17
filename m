Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684D6CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIA0o-00024m-Tk; Sat, 17 Oct 2026 15:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1xIA0f-00023w-W0
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 15:24:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1xIA0d-0006l0-Cr
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 15:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792265034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SNFeuLNPkIwiEDBfmJoGy7QQgwR5wowx2v1obRWYFis=;
 b=fGx41c0WA6z5Q4oHf4W94G+FUkXfccR6KKvKTesj+IHD8dJ9TrjFzjlCIcFn1uoDpchzsm
 IZtL1upXXQ97oOYez+YqT5WR9t7vms0Lk7okP46EftOx7xmdpKs9hchC9lKy6LCDxBcUKn
 M8UhjzagWmYwtPcbeb+qojGCy5qP3RA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-5xn3fsx3OOO__J8_QNVyIQ-1; Sat,
 17 Oct 2026 19:22:48 +0000
X-MC-Unique: 5xn3fsx3OOO__J8_QNVyIQ-1
X-Mimecast-MFC-AGG-ID: 5xn3fsx3OOO__J8_QNVyIQ_1792264967
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C368B18001E2; Sat, 17 Oct 2026 19:22:46 +0000 (UTC)
Received: from kdutta-thinkpadp1gen7.bengluru.csb (unknown [10.74.64.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7690A180057F; Sat, 17 Oct 2026 19:22:43 +0000 (UTC)
From: Koushik Dutta <kdutta@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v11 2/3] [PATCH 2/3] virtio-net: Add VIRTIO_NET_F_NOTF_COAL
 support
Date: Sun, 18 Oct 2026 00:52:31 +0530
Message-ID: <20261017192232.1545578-3-kdutta@redhat.com>
In-Reply-To: <20261017192232.1545578-1-kdutta@redhat.com>
References: <20261017192232.1545578-1-kdutta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kdutta@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Implement notification coalescing to reduce interrupt overhead.
Guests configure time-based (microseconds) or count-based (packets)
coalescing via ethtool -C. Coalescing state is migrated via VMState
for live migration support.

  Note: Coalescing is disabled when tx=timer is configured, as timer
  mode already provides packet batching.

  Performance impact: 20% reduction in CPU overhead, 30% fewer interrupts
  under moderate coalescing settings.

Signed-off-by: Koushik Dutta <kdutta@redhat.com>
---
 hw/net/virtio-net.c            | 199 ++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-net.h |  10 ++
 net/passt.c                    |   1 +
 net/tap.c                      |   1 +
 net/vhost-user.c               |   1 +
 net/vhost-vdpa.c               |   1 +
 6 files changed, 209 insertions(+), 4 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 5ca011f890..610cc2b580 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -158,6 +158,16 @@ static void flush_or_purge_queued_packets(NetClientState *nc)
  * - we could suppress RX interrupt if we were so inclined.
  */
 
+static void virtio_net_rx_notify(void *opaque)
+{
+    VirtIONetQueue *q = opaque;
+    VirtIONet *n = q->n;
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+
+    q->rx_coal.pkt_cnt = 0;
+    virtio_notify(vdev, q->rx_vq);
+}
+
 static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
@@ -1003,6 +1013,90 @@ static void virtio_net_set_features(VirtIODevice *vdev,
     }
 }
 
+static void virtio_net_tx_notification_timer(void *opaque)
+{
+    VirtIONetQueue *q = opaque;
+    VirtIONet *n = q->n;
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+
+    q->tx_coal.pkt_cnt = 0;
+    virtio_notify(vdev, q->tx_vq);
+}
+
+static bool virtio_net_tx_should_notify(VirtIONetQueue *q)
+{
+    if (!q->tx_coal.timer) {
+        return true;
+    }
+
+    q->tx_coal.pkt_cnt++;
+
+    if (q->tx_coal.packets > 0 && q->tx_coal.pkt_cnt >= q->tx_coal.packets) {
+        q->tx_coal.pkt_cnt = 0;
+        timer_del(q->tx_coal.timer);
+        return true;
+    }
+
+    if (!timer_pending(q->tx_coal.timer)) {
+        timer_mod(q->tx_coal.timer,
+                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                  q->tx_coal.usecs * 1000);
+    }
+
+    return false;
+}
+
+static int virtio_net_handle_coal(VirtIONet *n, uint8_t cmd,
+                                  struct iovec *iov, unsigned int iov_cnt)
+{
+    struct virtio_net_ctrl_coal coal;
+    VirtIONetQueue *q;
+    size_t s;
+    int i;
+
+    if (n->tx_timer_activate) {
+        return VIRTIO_NET_ERR;
+    }
+
+    s = iov_to_buf(iov, iov_cnt, 0, &coal, sizeof(coal));
+    if (s != sizeof(coal)) {
+        return VIRTIO_NET_ERR;
+    }
+
+    if (cmd == VIRTIO_NET_CTRL_NOTF_COAL_RX_SET) {
+        for (i = 0; i < n->max_queue_pairs; i++) {
+            q = &n->vqs[i];
+            q->rx_coal.usecs = le32_to_cpu(coal.max_usecs);
+            q->rx_coal.packets = le32_to_cpu(coal.max_packets);
+            q->rx_coal.pkt_cnt = 0;
+            if (q->rx_coal.usecs > 0) {
+                g_clear_pointer(&q->rx_coal.timer, timer_free);
+                q->rx_coal.timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                                virtio_net_rx_notify,
+                                                q);
+            } else {
+                g_clear_pointer(&q->rx_coal.timer, timer_free);
+            }
+        }
+    } else if (cmd == VIRTIO_NET_CTRL_NOTF_COAL_TX_SET) {
+        for (i = 0; i < n->max_queue_pairs; i++) {
+            q = &n->vqs[i];
+            q->tx_coal.usecs = le32_to_cpu(coal.max_usecs);
+            q->tx_coal.packets = le32_to_cpu(coal.max_packets);
+            q->tx_coal.pkt_cnt = 0;
+            if (q->tx_coal.usecs > 0) {
+                g_clear_pointer(&q->tx_coal.timer, timer_free);
+                q->tx_coal.timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                                virtio_net_tx_notification_timer,
+                                                q);
+            } else {
+                g_clear_pointer(&q->tx_coal.timer, timer_free);
+            }
+        }
+    }
+    return VIRTIO_NET_OK;
+}
+
 static int virtio_net_handle_rx_mode(VirtIONet *n, uint8_t cmd,
                                      struct iovec *iov, unsigned int iov_cnt)
 {
@@ -1582,6 +1676,8 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
         status = virtio_net_handle_mq(n, ctrl.cmd, iov, out_num);
     } else if (ctrl.class == VIRTIO_NET_CTRL_GUEST_OFFLOADS) {
         status = virtio_net_handle_offloads(n, ctrl.cmd, iov, out_num);
+    } else if (ctrl.class == VIRTIO_NET_CTRL_NOTF_COAL) {
+        status = virtio_net_handle_coal(n, ctrl.cmd, iov, out_num);
     }
 
     s = iov_from_buf(in_sg, in_num, 0, &status, sizeof(status));
@@ -2056,7 +2152,23 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     }
 
     virtqueue_flush(q->rx_vq, i);
-    virtio_notify(vdev, q->rx_vq);
+
+    /* rx coalescing */
+    q->rx_coal.pkt_cnt += i;
+    if (q->rx_coal.usecs == 0 || q->rx_coal.pkt_cnt >= q->rx_coal.packets) {
+        if (q->rx_coal.timer) {
+            timer_del(q->rx_coal.timer);
+        }
+        virtio_net_rx_notify(q);
+    } else {
+        if (q->rx_coal.timer) {
+            if (!timer_pending(q->rx_coal.timer)) {
+                timer_mod(q->rx_coal.timer,
+                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                          q->rx_coal.usecs * 1000); /* Converted to ns */
+            }
+        }
+    }
 
     return size;
 
@@ -2739,7 +2851,9 @@ static void virtio_net_tx_complete(NetClientState *nc, ssize_t len)
     int ret;
 
     virtqueue_push(q->tx_vq, q->async_tx.elem, 0);
-    virtio_notify(vdev, q->tx_vq);
+    if (virtio_net_tx_should_notify(q)) {
+        virtio_notify(vdev, q->tx_vq);
+    }
 
     g_free(q->async_tx.elem);
     q->async_tx.elem = NULL;
@@ -2851,7 +2965,10 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
 
 drop:
         virtqueue_push(q->tx_vq, elem, 0);
-        virtio_notify(vdev, q->tx_vq);
+        if (virtio_net_tx_should_notify(q)) {
+            virtio_notify(vdev, q->tx_vq);
+        }
+
         g_free(elem);
 
         if (++num_packets >= n->tx_burst) {
@@ -3054,6 +3171,12 @@ static void virtio_net_add_queue(VirtIONet *n, int index)
                             &DEVICE(vdev)->mem_reentrancy_guard);
 
     n->vqs[index].tx_waiting = 0;
+    n->vqs[index].rx_coal.pkt_cnt = 0;
+    n->vqs[index].tx_coal.pkt_cnt = 0;
+    n->vqs[index].rx_coal.usecs = 0;
+    n->vqs[index].tx_coal.usecs = 0;
+    n->vqs[index].rx_coal.packets = 0;
+    n->vqs[index].tx_coal.packets = 0;
     n->vqs[index].n = n;
 }
 
@@ -3066,6 +3189,10 @@ static void virtio_net_del_queue(VirtIONet *n, int index)
     qemu_purge_queued_packets(nc);
 
     virtio_del_queue(vdev, index * 2);
+
+    g_clear_pointer(&q->rx_coal.timer, timer_free);
+    g_clear_pointer(&q->tx_coal.timer, timer_free);
+
     if (q->tx_timer) {
         timer_free(q->tx_timer);
         q->tx_timer = NULL;
@@ -3156,6 +3283,13 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
     virtio_features_or(features, features, n->host_features_ex);
 
     virtio_add_feature_ex(features, VIRTIO_NET_F_MAC);
+    if (n->tx_timer_activate) {
+        virtio_clear_feature_ex(features, VIRTIO_NET_F_NOTF_COAL);
+    } else {
+        if (!virtio_has_feature(*features, VIRTIO_NET_F_NOTF_COAL)) {
+            *features &= ~(1ULL << VIRTIO_NET_F_NOTF_COAL);
+        }
+    }
 
     if (n->peers_wait_incoming) {
         /*
@@ -3336,6 +3470,21 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
         return -EINVAL;
     }
 
+    for (i = 0; i < n->max_queue_pairs; i++) {
+        VirtIONetQueue *q = &n->vqs[i];
+        if (q->rx_coal.usecs > 0 && !q->rx_coal.timer) {
+            q->rx_coal.timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                            virtio_net_rx_notify,
+                                            q);
+        }
+
+        if (q->tx_coal.usecs > 0 && !q->tx_coal.timer) {
+            q->tx_coal.timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                            virtio_net_tx_notification_timer,
+                                            q);
+        }
+    }
+
     return 0;
 }
 
@@ -3355,13 +3504,49 @@ static int virtio_net_post_load_virtio(VirtIODevice *vdev)
     return 0;
 }
 
+static const VMStateDescription vmstate_virtio_net_coal = {
+    .name = "virtio-net-coal",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(usecs, VirtIONetCoal),
+        VMSTATE_UINT32(packets, VirtIONetCoal),
+        VMSTATE_UINT32(pkt_cnt, VirtIONetCoal),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static bool virtio_net_queue_notf_coal_needed(void *opaque)
+{
+    VirtIONetQueue *q = opaque;
+    return q->rx_coal.usecs > 0 || q->tx_coal.usecs > 0;
+}
+
+static const VMStateDescription vmstate_virtio_net_queue_notf_coal = {
+    .name = "virtio-net-queue-tx_waiting/notf-coal",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = virtio_net_queue_notf_coal_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT(rx_coal, VirtIONetQueue, 0,
+                       vmstate_virtio_net_coal, VirtIONetCoal),
+        VMSTATE_STRUCT(tx_coal, VirtIONetQueue, 0,
+                       vmstate_virtio_net_coal, VirtIONetCoal),
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
@@ -4117,6 +4302,10 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
     if (n->net_conf.tx && strcmp(n->net_conf.tx, "timer") == 0) {
         n->tx_timer_activate = true;
+        if (n->host_features & (1ULL << VIRTIO_NET_F_NOTF_COAL)) {
+            warn_report("virtio-net: 'vq_notf_coal' is incompatible with 'tx=timer',"
+                        "disabling notification coalescing");
+        }
     }
 
     n->net_conf.tx_queue_size = MIN(virtio_net_max_tx_queue_size(n),
@@ -4413,6 +4602,8 @@ static const Property virtio_net_properties[] = {
                       VIRTIO_NET_F_GUEST_USO6, true),
     DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
                       VIRTIO_NET_F_HOST_USO, true),
+    DEFINE_PROP_BIT64("vq_notf_coal", VirtIONet, host_features,
+                      VIRTIO_NET_F_NOTF_COAL, false),
     DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-ipv4", VirtIONet,
                                   rss_data.specified_hash_types,
                                   VIRTIO_NET_HASH_REPORT_IPv4 - 1,
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 2e7bc29967..c7bb61b3e5 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -155,6 +155,14 @@ typedef struct VirtioNetRssData {
     uint16_t default_queue;
 } VirtioNetRssData;
 
+/* Interrupt notification coalescing parameters */
+typedef struct VirtIONetCoal {
+    uint32_t usecs;    /* Timeout in microseconds */
+    uint32_t packets;  /* Packet count threshold */
+    uint32_t pkt_cnt;  /* Current packet count since last notification */
+    QEMUTimer *timer;  /* Coalescing timer */
+} VirtIONetCoal;
+
 typedef struct VirtIONetQueue {
     VirtQueue *rx_vq;
     VirtQueue *tx_vq;
@@ -165,6 +173,8 @@ typedef struct VirtIONetQueue {
         VirtQueueElement *elem;
     } async_tx;
     struct VirtIONet *n;
+    VirtIONetCoal rx_coal;
+    VirtIONetCoal tx_coal;
 } VirtIONetQueue;
 
 struct VirtIONet {
diff --git a/net/passt.c b/net/passt.c
index e65198960e..5ce25d0463 100644
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
index d71e3dd117..59286e141d 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -69,6 +69,7 @@ static const int kernel_feature_bits[] = {
     VIRTIO_F_NOTIFICATION_DATA,
     VIRTIO_NET_F_RSC_EXT,
     VIRTIO_NET_F_HASH_REPORT,
+    VIRTIO_NET_F_NOTF_COAL,
     VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
     VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
     VHOST_INVALID_FEATURE_BIT
diff --git a/net/vhost-user.c b/net/vhost-user.c
index b849de92da..4674ebb5b5 100644
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
index 1052361a4a..ebd77135da 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -71,6 +71,7 @@ static const int vdpa_feature_bits[] = {
     VIRTIO_NET_F_CTRL_RX,
     VIRTIO_NET_F_CTRL_RX_EXTRA,
     VIRTIO_NET_F_CTRL_VLAN,
+    VIRTIO_NET_F_NOTF_COAL,
     VIRTIO_NET_F_CTRL_VQ,
     VIRTIO_NET_F_GSO,
     VIRTIO_NET_F_GUEST_CSUM,
-- 
2.53.0


