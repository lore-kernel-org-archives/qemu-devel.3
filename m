Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55807C54FC6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 05:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smRMx-00033q-RP; Fri, 06 Sep 2024 01:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smRMl-0002Et-PH; Fri, 06 Sep 2024 01:18:40 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smRMj-0008Cg-KE; Fri, 06 Sep 2024 01:18:39 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AFEB18C12D;
 Fri,  6 Sep 2024 08:15:17 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5D872133372;
 Fri,  6 Sep 2024 08:16:35 +0300 (MSK)
Received: (nullmailer pid 10458 invoked by uid 1000);
 Fri, 06 Sep 2024 05:16:33 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, thomas <east.moutain.yang@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.14 24/40] virtio-net: Fix network stall at the host side
 waiting for kick
Date: Fri,  6 Sep 2024 08:16:12 +0300
Message-Id: <20240906051633.10288-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.14-20240906080824@cover.tls.msk.ru>
References: <qemu-stable-7.2.14-20240906080824@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: thomas <east.moutain.yang@gmail.com>

Patch 06b12970174 ("virtio-net: fix network stall under load")
added double-check to test whether the available buffer size
can satisfy the request or not, in case the guest has added
some buffers to the avail ring simultaneously after the first
check. It will be lucky if the available buffer size becomes
okay after the double-check, then the host can send the packet
to the guest. If the buffer size still can't satisfy the request,
even if the guest has added some buffers, viritio-net would
stall at the host side forever.

The patch enables notification and checks whether the guest has
added some buffers since last check of available buffers when
the available buffers are insufficient. If no buffer is added,
return false, else recheck the available buffers in the loop.
If the available buffers are sufficient, disable notification
and return true.

Changes:
1. Change the return type of virtqueue_get_avail_bytes() from void
   to int, it returns an opaque that represents the shadow_avail_idx
   of the virtqueue on success, else -1 on error.
2. Add a new API: virtio_queue_enable_notification_and_check(),
   it takes an opaque as input arg which is returned from
   virtqueue_get_avail_bytes(). It enables notification firstly,
   then checks whether the guest has added some buffers since
   last check of available buffers or not by virtio_queue_poll(),
   return ture if yes.

The patch also reverts patch "06b12970174".

The case below can reproduce the stall.

                                       Guest 0
                                     +--------+
                                     | iperf  |
                    ---------------> | server |
         Host       |                +--------+
       +--------+   |                    ...
       | iperf  |----
       | client |----                  Guest n
       +--------+   |                +--------+
                    |                | iperf  |
                    ---------------> | server |
                                     +--------+

Boot many guests from qemu with virtio network:
 qemu ... -netdev tap,id=net_x \
    -device virtio-net-pci-non-transitional,\
    iommu_platform=on,mac=xx:xx:xx:xx:xx:xx,netdev=net_x

Each guest acts as iperf server with commands below:
 iperf3 -s -D -i 10 -p 8001
 iperf3 -s -D -i 10 -p 8002

The host as iperf client:
 iperf3 -c guest_IP -p 8001 -i 30 -w 256k -P 20 -t 40000
 iperf3 -c guest_IP -p 8002 -i 30 -w 256k -P 20 -t 40000

After some time, the host loses connection to the guest,
the guest can send packet to the host, but can't receive
packet from the host.

It's more likely to happen if SWIOTLB is enabled in the guest,
allocating and freeing bounce buffer takes some CPU ticks,
copying from/to bounce buffer takes more CPU ticks, compared
with that there is no bounce buffer in the guest.
Once the rate of producing packets from the host approximates
the rate of receiveing packets in the guest, the guest would
loop in NAPI.

         receive packets    ---
               |             |
               v             |
           free buf      virtnet_poll
               |             |
               v             |
     add buf to avail ring  ---
               |
               |  need kick the host?
               |  NAPI continues
               v
         receive packets    ---
               |             |
               v             |
           free buf      virtnet_poll
               |             |
               v             |
     add buf to avail ring  ---
               |
               v
              ...           ...

On the other hand, the host fetches free buf from avail
ring, if the buf in the avail ring is not enough, the
host notifies the guest the event by writing the avail
idx read from avail ring to the event idx of used ring,
then the host goes to sleep, waiting for the kick signal
from the guest.

Once the guest finds the host is waiting for kick singal
(in virtqueue_kick_prepare_split()), it kicks the host.

The host may stall forever at the sequences below:

         Host                        Guest
     ------------                 -----------
 fetch buf, send packet           receive packet ---
         ...                          ...         |
 fetch buf, send packet             add buf       |
         ...                        add buf   virtnet_poll
    buf not enough      avail idx-> add buf       |
    read avail idx                  add buf       |
                                    add buf      ---
                                  receive packet ---
    write event idx                   ...         |
    wait for kick                   add buf   virtnet_poll
                                      ...         |
                                                 ---
                                 no more packet, exit NAPI

In the first loop of NAPI above, indicated in the range of
virtnet_poll above, the host is sending packets while the
guest is receiving packets and adding buffers.
 step 1: The buf is not enough, for example, a big packet
         needs 5 buf, but the available buf count is 3.
         The host read current avail idx.
 step 2: The guest adds some buf, then checks whether the
         host is waiting for kick signal, not at this time.
         The used ring is not empty, the guest continues
         the second loop of NAPI.
 step 3: The host writes the avail idx read from avail
         ring to used ring as event idx via
         virtio_queue_set_notification(q->rx_vq, 1).
 step 4: At the end of the second loop of NAPI, recheck
         whether kick is needed, as the event idx in the
         used ring written by the host is beyound the
         range of kick condition, the guest will not
         send kick signal to the host.

Fixes: 06b12970174 ("virtio-net: fix network stall under load")
Cc: qemu-stable@nongnu.org
Signed-off-by: Wencheng Yang <east.moutain.yang@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit f937309fbdbb48c354220a3e7110c202ae4aa7fa)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: context fixup in include/hw/virtio/virtio.h)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index ebee5db1bc..925a5c319e 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1597,24 +1597,28 @@ static bool virtio_net_can_receive(NetClientState *nc)
 
 static int virtio_net_has_buffers(VirtIONetQueue *q, int bufsize)
 {
+    int opaque;
+    unsigned int in_bytes;
     VirtIONet *n = q->n;
-    if (virtio_queue_empty(q->rx_vq) ||
-        (n->mergeable_rx_bufs &&
-         !virtqueue_avail_bytes(q->rx_vq, bufsize, 0))) {
-        virtio_queue_set_notification(q->rx_vq, 1);
-
-        /* To avoid a race condition where the guest has made some buffers
-         * available after the above check but before notification was
-         * enabled, check for available buffers again.
-         */
-        if (virtio_queue_empty(q->rx_vq) ||
-            (n->mergeable_rx_bufs &&
-             !virtqueue_avail_bytes(q->rx_vq, bufsize, 0))) {
+
+    while (virtio_queue_empty(q->rx_vq) || n->mergeable_rx_bufs) {
+        opaque = virtqueue_get_avail_bytes(q->rx_vq, &in_bytes, NULL,
+                                           bufsize, 0);
+        /* Buffer is enough, disable notifiaction */
+        if (bufsize <= in_bytes) {
+            break;
+        }
+
+        if (virtio_queue_enable_notification_and_check(q->rx_vq, opaque)) {
+            /* Guest has added some buffers, try again */
+            continue;
+        } else {
             return 0;
         }
     }
 
     virtio_queue_set_notification(q->rx_vq, 0);
+
     return 1;
 }
 
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 1227e3d692..d0d13f4766 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1153,6 +1153,60 @@ int virtio_queue_empty(VirtQueue *vq)
     }
 }
 
+static bool virtio_queue_split_poll(VirtQueue *vq, unsigned shadow_idx)
+{
+    if (unlikely(!vq->vring.avail)) {
+        return false;
+    }
+
+    return (uint16_t)shadow_idx != vring_avail_idx(vq);
+}
+
+static bool virtio_queue_packed_poll(VirtQueue *vq, unsigned shadow_idx)
+{
+    VRingPackedDesc desc;
+    VRingMemoryRegionCaches *caches;
+
+    if (unlikely(!vq->vring.desc)) {
+        return false;
+    }
+
+    caches = vring_get_region_caches(vq);
+    if (!caches) {
+        return false;
+    }
+
+    vring_packed_desc_read(vq->vdev, &desc, &caches->desc,
+                           shadow_idx, true);
+
+    return is_desc_avail(desc.flags, vq->shadow_avail_wrap_counter);
+}
+
+static bool virtio_queue_poll(VirtQueue *vq, unsigned shadow_idx)
+{
+    if (virtio_device_disabled(vq->vdev)) {
+        return false;
+    }
+
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        return virtio_queue_packed_poll(vq, shadow_idx);
+    } else {
+        return virtio_queue_split_poll(vq, shadow_idx);
+    }
+}
+
+bool virtio_queue_enable_notification_and_check(VirtQueue *vq,
+                                                int opaque)
+{
+    virtio_queue_set_notification(vq, 1);
+
+    if (opaque >= 0) {
+        return virtio_queue_poll(vq, (unsigned)opaque);
+    } else {
+        return false;
+    }
+}
+
 static void virtqueue_unmap_sg(VirtQueue *vq, const VirtQueueElement *elem,
                                unsigned int len)
 {
@@ -1727,9 +1781,9 @@ err:
     goto done;
 }
 
-void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
-                               unsigned int *out_bytes,
-                               unsigned max_in_bytes, unsigned max_out_bytes)
+int virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
+                              unsigned int *out_bytes, unsigned max_in_bytes,
+                              unsigned max_out_bytes)
 {
     uint16_t desc_size;
     VRingMemoryRegionCaches *caches;
@@ -1762,7 +1816,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
                                         caches);
     }
 
-    return;
+    return (int)vq->shadow_avail_idx;
 err:
     if (in_bytes) {
         *in_bytes = 0;
@@ -1770,6 +1824,8 @@ err:
     if (out_bytes) {
         *out_bytes = 0;
     }
+
+    return -1;
 }
 
 int virtqueue_avail_bytes(VirtQueue *vq, unsigned int in_bytes,
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index aa7f7d3dd6..ab3eb182f4 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -237,9 +237,13 @@ void qemu_put_virtqueue_element(VirtIODevice *vdev, QEMUFile *f,
                                 VirtQueueElement *elem);
 int virtqueue_avail_bytes(VirtQueue *vq, unsigned int in_bytes,
                           unsigned int out_bytes);
-void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
-                               unsigned int *out_bytes,
-                               unsigned max_in_bytes, unsigned max_out_bytes);
+/**
+ * Return <0 on error or an opaque >=0 to pass to
+ * virtio_queue_enable_notification_and_check on success.
+ */
+int virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
+                              unsigned int *out_bytes, unsigned max_in_bytes,
+                              unsigned max_out_bytes);
 
 void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq);
 void virtio_notify(VirtIODevice *vdev, VirtQueue *vq);
@@ -266,6 +270,15 @@ int virtio_queue_ready(VirtQueue *vq);
 
 int virtio_queue_empty(VirtQueue *vq);
 
+/**
+ * Enable notification and check whether guest has added some
+ * buffers since last call to virtqueue_get_avail_bytes.
+ *
+ * @opaque: value returned from virtqueue_get_avail_bytes
+ */
+bool virtio_queue_enable_notification_and_check(VirtQueue *vq,
+                                                int opaque);
+
 /* Host binding interface.  */
 
 uint32_t virtio_config_readb(VirtIODevice *vdev, uint32_t addr);
-- 
2.39.2


