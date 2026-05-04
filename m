Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83201FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 09:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJpSF-0000hr-38; Mon, 04 May 2026 05:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1wJpSD-0000hN-56
 for qemu-devel@nongnu.org; Mon, 04 May 2026 05:19:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1wJpS7-0003ky-M4
 for qemu-devel@nongnu.org; Mon, 04 May 2026 05:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777886336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Uyg5JZ/tqHqDmB8VMcOiYiUOsudKQ3Lu4OKxsajY7ck=;
 b=dT385xpgmlnDxuCAcPw6mCs8puUuzE2rHQ3ze+UdlSfJnXFvcgbadfoUE2DGNG3FmoRs1A
 6LYVXyFnHrerUh8/b/Nety0UNOJJS5J+ZwTOlCNRCS5eprk+ReS5aIomegz8HOR3pVlQgt
 9AZgHpQScvZ/XbWkcXWoQLyUR3bL6m8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-kSSEDHJXNXiTqjCA_ouxqg-1; Mon,
 04 May 2026 05:18:55 -0400
X-MC-Unique: kSSEDHJXNXiTqjCA_ouxqg-1
X-Mimecast-MFC-AGG-ID: kSSEDHJXNXiTqjCA_ouxqg_1777886335
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C282A1800366
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 09:18:54 +0000 (UTC)
Received: from kdutta-thinkpadp1gen7.bengluru.csb (unknown [10.74.64.118])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1624930001BE; Mon,  4 May 2026 09:18:44 +0000 (UTC)
From: Koushik Dutta <kdutta@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v6] hw/net/virtio-net: add support for notification coalescing
Date: Mon,  4 May 2026 14:48:42 +0530
Message-ID: <20260504091842.1406602-1-kdutta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kdutta@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
- After VM LM coalescing parameters persist in the destination VM.

This reduces interrupt overhead by batching notifications based on
either a packet count or a time-based threshold.

Signed-off-by: Koushik Dutta <kdutta@redhat.com>
---
 hw/net/virtio-net.c            | 193 +++++++++++++++++++++++++++++----
 include/hw/virtio/virtio-net.h |  10 +-
 net/passt.c                    |   1 +
 net/tap.c                      |   1 +
 net/vhost-user.c               |   1 +
 net/vhost-vdpa.c               |   1 +
 6 files changed, 184 insertions(+), 23 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 2a5d642a64..aabba6a4be 100644
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
@@ -435,7 +445,7 @@ static int virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
         if (queue_started) {
             if (q->tx_timer) {
                 timer_mod(q->tx_timer,
-                               qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout);
+                               qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_coal_usecs);
             } else {
                 replay_bh_schedule_event(q->tx_bh);
             }
@@ -1080,6 +1090,52 @@ static int virtio_net_handle_offloads(VirtIONet *n, uint8_t cmd,
     }
 }
 
+static void virtio_net_tx_timer(void *opaque);
+
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
+        if (n->rx_coal_usecs > 0) {
+            for (i = 0; i < n->max_queue_pairs; i++) {
+                q = &n->vqs[i];
+                if (!q->rx_timer) {
+                    q->rx_timer = timer_new_us(QEMU_CLOCK_VIRTUAL,
+                                               virtio_net_rx_notify,
+                                               q);
+                }
+            }
+        }
+    } else if (cmd == VIRTIO_NET_CTRL_NOTF_COAL_TX_SET) {
+        n->tx_coal_usecs = le32_to_cpu(coal.max_usecs) * 1000;
+        n->tx_coal_packets = le32_to_cpu(coal.max_packets);
+        if (n->tx_coal_usecs > 0) {
+            for (i = 0; i < n->max_queue_pairs; i++) {
+                q = &n->vqs[i];
+                if (!q->tx_timer && n->tx_coal_usecs > 0) {
+                    q->tx_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                               virtio_net_tx_timer,
+                                               q);
+                }
+            }
+        }
+    }
+
+    return VIRTIO_NET_OK;
+}
+
 static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
                                  struct iovec *iov, unsigned int iov_cnt)
 {
@@ -1581,6 +1637,10 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
         status = virtio_net_handle_mq(n, ctrl.cmd, iov, out_num);
     } else if (ctrl.class == VIRTIO_NET_CTRL_GUEST_OFFLOADS) {
         status = virtio_net_handle_offloads(n, ctrl.cmd, iov, out_num);
+    } else if (ctrl.class == VIRTIO_NET_CTRL_NOTF_COAL) {
+        if (!n->tx_timer_activate) {
+            status = virtio_net_handle_coal(n, ctrl.cmd, iov, out_num);
+        }
     }
 
     s = iov_from_buf(in_sg, in_num, 0, &status, sizeof(status));
@@ -2040,7 +2100,22 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
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
+                          qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n->rx_coal_usecs);
+            }
+        }
+    }
 
     return size;
 
@@ -2708,7 +2783,7 @@ static void virtio_net_tx_complete(NetClientState *nc, ssize_t len)
             replay_bh_schedule_event(q->tx_bh);
         } else {
             timer_mod(q->tx_timer,
-                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout);
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_coal_usecs);
         }
         q->tx_waiting = 1;
     }
@@ -2817,7 +2892,6 @@ detach:
     return -EINVAL;
 }
 
-static void virtio_net_tx_timer(void *opaque);
 
 static void virtio_net_handle_tx_timer(VirtIODevice *vdev, VirtQueue *vq)
 {
@@ -2842,7 +2916,7 @@ static void virtio_net_handle_tx_timer(VirtIODevice *vdev, VirtQueue *vq)
     } else {
         /* re-arm timer to flush it (and more) on next tick */
         timer_mod(q->tx_timer,
-                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout);
+                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_coal_usecs);
         q->tx_waiting = 1;
         virtio_queue_set_notification(vq, 0);
     }
@@ -2899,6 +2973,12 @@ static void virtio_net_tx_timer(void *opaque)
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
@@ -2906,7 +2986,7 @@ static void virtio_net_tx_timer(void *opaque)
     if (ret >= n->tx_burst) {
         q->tx_waiting = 1;
         timer_mod(q->tx_timer,
-                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout);
+                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_coal_usecs);
         return;
     }
     /*
@@ -2918,9 +2998,10 @@ static void virtio_net_tx_timer(void *opaque)
     ret = virtio_net_flush_tx(q);
     if (ret > 0) {
         virtio_queue_set_notification(q->tx_vq, 0);
+        n->tx_pkt_cnt -= ret;
         q->tx_waiting = 1;
         timer_mod(q->tx_timer,
-                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_timeout);
+                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_coal_usecs);
     }
 }
 
@@ -2973,6 +3054,32 @@ static void virtio_net_tx_bh(void *opaque)
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
+    if (use_timer) {
+        n->tx_pkt_cnt++;
+        if (!pkt_limit || n->tx_pkt_cnt < n->tx_coal_packets) {
+            if (q->tx_timer) {
+                virtio_net_handle_tx_timer(vdev, vq);
+                return;
+            }
+        }
+        n->tx_pkt_cnt = 0;
+        if (q->tx_timer) {
+            timer_del(q->tx_timer);
+        }
+        virtio_net_handle_tx_bh(vdev, vq);
+    } else {
+        virtio_net_handle_tx_bh(vdev, vq);
+    }
+}
+
 static void virtio_net_add_queue(VirtIONet *n, int index)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
@@ -2980,20 +3087,15 @@ static void virtio_net_add_queue(VirtIONet *n, int index)
     n->vqs[index].rx_vq = virtio_add_queue(vdev, n->net_conf.rx_queue_size,
                                            virtio_net_handle_rx);
 
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
@@ -3242,6 +3344,35 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
     }
 
     virtio_net_commit_rss_config(n);
+    if (n->tx_coal_usecs > 0 || n->rx_coal_usecs > 0) {
+
+        for (i = 0; i < n->max_queue_pairs; i++) {
+            VirtIONetQueue *q = &n->vqs[i];
+            if (!q->rx_timer && n->rx_coal_usecs > 0) {
+                q->rx_timer = timer_new_us(QEMU_CLOCK_VIRTUAL,
+                                           virtio_net_rx_notify,
+                                           q);
+            }
+
+            if (!q->tx_timer && n->tx_coal_usecs > 0) {
+                q->tx_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                           virtio_net_tx_timer,
+                                           q);
+            }
+
+            if (n->tx_coal_usecs > 0 && q->tx_timer) {
+                n->tx_pkt_cnt = 0;
+                timer_mod(q->tx_timer,
+                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + n->tx_coal_usecs);
+            }
+
+            if (n->rx_coal_usecs > 0 && q->rx_timer) {
+                timer_mod(q->rx_timer,
+                          qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + n->rx_coal_usecs);
+            }
+        }
+    }
+
     return 0;
 }
 
@@ -3617,6 +3748,10 @@ static const VMStateDescription vmstate_virtio_net_device = {
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
@@ -3960,7 +4095,6 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     }
     n->vqs = g_new0(VirtIONetQueue, n->max_queue_pairs);
     n->curr_queue_pairs = 1;
-    n->tx_timeout = n->net_conf.txtimer;
 
     if (n->net_conf.tx && strcmp(n->net_conf.tx, "timer")
                        && strcmp(n->net_conf.tx, "bh")) {
@@ -3970,6 +4104,13 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         error_printf("Defaulting to \"bh\"");
     }
 
+    if (n->net_conf.tx && strcmp(n->net_conf.tx, "timer") == 0) {
+        n->tx_coal_usecs = n->net_conf.txtimer;
+        n->tx_timer_activate = true;
+    } else {
+        n->tx_coal_usecs = 0;
+    }
+
     n->net_conf.tx_queue_size = MIN(virtio_net_max_tx_queue_size(n),
                                     n->net_conf.tx_queue_size);
 
@@ -4046,6 +4187,12 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
             n->rss_data.specified_hash_types.on_bits |
             n->rss_data.specified_hash_types.auto_bits;
     }
+    n->rx_pkt_cnt = 0;
+    n->tx_pkt_cnt = 0;
+    n->rx_coal_usecs = 0;
+    n->rx_coal_packets = 0;
+    n->tx_coal_packets = 0;
+    n->rx_index_timer = NULL;
 }
 
 static void virtio_net_device_unrealize(DeviceState *dev)
@@ -4258,6 +4405,8 @@ static const Property virtio_net_properties[] = {
                       VIRTIO_NET_F_GUEST_USO6, true),
     DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
                       VIRTIO_NET_F_HOST_USO, true),
+    DEFINE_PROP_BIT64("vq_notf_coal", VirtIONet, host_features,
+                      VIRTIO_NET_F_NOTF_COAL, true),
     DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-ipv4", VirtIONet,
                                   rss_data.specified_hash_types,
                                   VIRTIO_NET_HASH_REPORT_IPv4 - 1,
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 371e376428..a76d271096 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -158,6 +158,7 @@ typedef struct VirtioNetRssData {
 typedef struct VirtIONetQueue {
     VirtQueue *rx_vq;
     VirtQueue *tx_vq;
+    QEMUTimer *rx_timer;
     QEMUTimer *tx_timer;
     QEMUBH *tx_bh;
     uint32_t tx_waiting;
@@ -177,7 +178,6 @@ struct VirtIONet {
     /* RSC Chains - temporary storage of coalesced data,
        all these data are lost in case of migration */
     QTAILQ_HEAD(, VirtioNetRscChain) rsc_chains;
-    uint32_t tx_timeout;
     int32_t tx_burst;
     uint32_t has_vnet_hdr;
     size_t host_hdr_len;
@@ -230,6 +230,14 @@ struct VirtIONet {
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
diff --git a/net/passt.c b/net/passt.c
index 4ff94ee509..0b0d9e222a 100644
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
index 8d7ab6ba6f..ea5987a3dc 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -62,6 +62,7 @@ static const int kernel_feature_bits[] = {
     VIRTIO_F_NOTIFICATION_DATA,
     VIRTIO_NET_F_RSC_EXT,
     VIRTIO_NET_F_HASH_REPORT,
+    VIRTIO_NET_F_NOTF_COAL,
     VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
     VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
     VHOST_INVALID_FEATURE_BIT
diff --git a/net/vhost-user.c b/net/vhost-user.c
index a4bb49bbcf..f0b3752d7c 100644
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
index 3df6091274..4ab8f26ceb 100644
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


