Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F6CCD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSQx-0005xw-9W; Wed, 10 Apr 2024 03:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSQb-0005Te-4V; Wed, 10 Apr 2024 03:31:33 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSQY-0005TO-Cs; Wed, 10 Apr 2024 03:31:28 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CDE795D6C7;
 Wed, 10 Apr 2024 10:25:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 71A45B0307;
 Wed, 10 Apr 2024 10:23:10 +0300 (MSK)
Received: (nullmailer pid 4191913 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 87/87] virtio-snd: rewrite invalid tx/rx message
 handling
Date: Wed, 10 Apr 2024 10:23:00 +0300
Message-Id: <20240410072303.4191455-87-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

The current handling of invalid virtqueue elements inside the TX/RX virt
queue handlers is wrong.

They are added in a per-stream invalid queue to be processed after the
handler is done examining each message, but the invalid message might
not be specifying any stream_id; which means it's invalid to add it to
any stream->invalid queue since stream could be NULL at this point.

This commit moves the invalid queue to the VirtIOSound struct which
guarantees there will always be a valid temporary place to store them
inside the tx/rx handlers. The queue will be emptied before the handler
returns, so the queue must be empty at any other point of the device's
lifetime.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <virtio-snd-rewrite-invalid-tx-rx-message-handling-v1.manos.pitsidianakis@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 731655f87f319fd06f27282c6cafbc2467ac8045)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 2d118d6423..256a132ece 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -456,7 +456,6 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
         stream->s = s;
         qemu_mutex_init(&stream->queue_mutex);
         QSIMPLEQ_INIT(&stream->queue);
-        QSIMPLEQ_INIT(&stream->invalid);
 
         /*
          * stream_id >= s->snd_conf.streams was checked before so this is
@@ -611,9 +610,6 @@ static size_t virtio_snd_pcm_get_io_msgs_count(VirtIOSoundPCMStream *stream)
         QSIMPLEQ_FOREACH_SAFE(buffer, &stream->queue, entry, next) {
             count += 1;
         }
-        QSIMPLEQ_FOREACH_SAFE(buffer, &stream->invalid, entry, next) {
-            count += 1;
-        }
     }
     return count;
 }
@@ -831,47 +827,36 @@ static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
     trace_virtio_snd_handle_event();
 }
 
+/*
+ * Must only be called if vsnd->invalid is not empty.
+ */
 static inline void empty_invalid_queue(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOSoundPCMBuffer *buffer = NULL;
-    VirtIOSoundPCMStream *stream = NULL;
     virtio_snd_pcm_status resp = { 0 };
     VirtIOSound *vsnd = VIRTIO_SND(vdev);
-    bool any = false;
 
-    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
-        stream = vsnd->pcm->streams[i];
-        if (stream) {
-            any = false;
-            WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-                while (!QSIMPLEQ_EMPTY(&stream->invalid)) {
-                    buffer = QSIMPLEQ_FIRST(&stream->invalid);
-                    if (buffer->vq != vq) {
-                        break;
-                    }
-                    any = true;
-                    resp.status = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
-                    iov_from_buf(buffer->elem->in_sg,
-                                 buffer->elem->in_num,
-                                 0,
-                                 &resp,
-                                 sizeof(virtio_snd_pcm_status));
-                    virtqueue_push(vq,
-                                   buffer->elem,
-                                   sizeof(virtio_snd_pcm_status));
-                    QSIMPLEQ_REMOVE_HEAD(&stream->invalid, entry);
-                    virtio_snd_pcm_buffer_free(buffer);
-                }
-                if (any) {
-                    /*
-                     * Notify vq about virtio_snd_pcm_status responses.
-                     * Buffer responses must be notified separately later.
-                     */
-                    virtio_notify(vdev, vq);
-                }
-            }
-        }
+    g_assert(!QSIMPLEQ_EMPTY(&vsnd->invalid));
+
+    while (!QSIMPLEQ_EMPTY(&vsnd->invalid)) {
+        buffer = QSIMPLEQ_FIRST(&vsnd->invalid);
+        /* If buffer->vq != vq, our logic is fundamentally wrong, so bail out */
+        g_assert(buffer->vq == vq);
+
+        resp.status = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+        iov_from_buf(buffer->elem->in_sg,
+                     buffer->elem->in_num,
+                     0,
+                     &resp,
+                     sizeof(virtio_snd_pcm_status));
+        virtqueue_push(vq,
+                       buffer->elem,
+                       sizeof(virtio_snd_pcm_status));
+        QSIMPLEQ_REMOVE_HEAD(&vsnd->invalid, entry);
+        virtio_snd_pcm_buffer_free(buffer);
     }
+    /* Notify vq about virtio_snd_pcm_status responses. */
+    virtio_notify(vdev, vq);
 }
 
 /*
@@ -883,15 +868,14 @@ static inline void empty_invalid_queue(VirtIODevice *vdev, VirtQueue *vq)
  */
 static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
 {
-    VirtIOSound *s = VIRTIO_SND(vdev);
-    VirtIOSoundPCMStream *stream = NULL;
+    VirtIOSound *vsnd = VIRTIO_SND(vdev);
     VirtIOSoundPCMBuffer *buffer;
     VirtQueueElement *elem;
     size_t msg_sz, size;
     virtio_snd_pcm_xfer hdr;
     uint32_t stream_id;
     /*
-     * If any of the I/O messages are invalid, put them in stream->invalid and
+     * If any of the I/O messages are invalid, put them in vsnd->invalid and
      * return them after the for loop.
      */
     bool must_empty_invalid_queue = false;
@@ -901,7 +885,7 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
     }
     trace_virtio_snd_handle_tx_xfer();
 
-    for (;;) {
+    for (VirtIOSoundPCMStream *stream = NULL;; stream = NULL) {
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
         if (!elem) {
             break;
@@ -913,16 +897,16 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
                             &hdr,
                             sizeof(virtio_snd_pcm_xfer));
         if (msg_sz != sizeof(virtio_snd_pcm_xfer)) {
-            continue;
+            goto tx_err;
         }
         stream_id = le32_to_cpu(hdr.stream_id);
 
-        if (stream_id >= s->snd_conf.streams
-            || s->pcm->streams[stream_id] == NULL) {
-            continue;
+        if (stream_id >= vsnd->snd_conf.streams
+            || vsnd->pcm->streams[stream_id] == NULL) {
+            goto tx_err;
         }
 
-        stream = s->pcm->streams[stream_id];
+        stream = vsnd->pcm->streams[stream_id];
         if (stream->info.direction != VIRTIO_SND_D_OUTPUT) {
             goto tx_err;
         }
@@ -942,13 +926,11 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
         continue;
 
 tx_err:
-        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-            must_empty_invalid_queue = true;
-            buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer));
-            buffer->elem = elem;
-            buffer->vq = vq;
-            QSIMPLEQ_INSERT_TAIL(&stream->invalid, buffer, entry);
-        }
+        must_empty_invalid_queue = true;
+        buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer));
+        buffer->elem = elem;
+        buffer->vq = vq;
+        QSIMPLEQ_INSERT_TAIL(&vsnd->invalid, buffer, entry);
     }
 
     if (must_empty_invalid_queue) {
@@ -965,15 +947,14 @@ tx_err:
  */
 static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
 {
-    VirtIOSound *s = VIRTIO_SND(vdev);
-    VirtIOSoundPCMStream *stream = NULL;
+    VirtIOSound *vsnd = VIRTIO_SND(vdev);
     VirtIOSoundPCMBuffer *buffer;
     VirtQueueElement *elem;
     size_t msg_sz, size;
     virtio_snd_pcm_xfer hdr;
     uint32_t stream_id;
     /*
-     * if any of the I/O messages are invalid, put them in stream->invalid and
+     * if any of the I/O messages are invalid, put them in vsnd->invalid and
      * return them after the for loop.
      */
     bool must_empty_invalid_queue = false;
@@ -983,7 +964,7 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
     }
     trace_virtio_snd_handle_rx_xfer();
 
-    for (;;) {
+    for (VirtIOSoundPCMStream *stream = NULL;; stream = NULL) {
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
         if (!elem) {
             break;
@@ -995,16 +976,16 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
                             &hdr,
                             sizeof(virtio_snd_pcm_xfer));
         if (msg_sz != sizeof(virtio_snd_pcm_xfer)) {
-            continue;
+            goto rx_err;
         }
         stream_id = le32_to_cpu(hdr.stream_id);
 
-        if (stream_id >= s->snd_conf.streams
-            || !s->pcm->streams[stream_id]) {
-            continue;
+        if (stream_id >= vsnd->snd_conf.streams
+            || !vsnd->pcm->streams[stream_id]) {
+            goto rx_err;
         }
 
-        stream = s->pcm->streams[stream_id];
+        stream = vsnd->pcm->streams[stream_id];
         if (stream == NULL || stream->info.direction != VIRTIO_SND_D_INPUT) {
             goto rx_err;
         }
@@ -1021,13 +1002,11 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
         continue;
 
 rx_err:
-        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-            must_empty_invalid_queue = true;
-            buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer));
-            buffer->elem = elem;
-            buffer->vq = vq;
-            QSIMPLEQ_INSERT_TAIL(&stream->invalid, buffer, entry);
-        }
+        must_empty_invalid_queue = true;
+        buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer));
+        buffer->elem = elem;
+        buffer->vq = vq;
+        QSIMPLEQ_INSERT_TAIL(&vsnd->invalid, buffer, entry);
     }
 
     if (must_empty_invalid_queue) {
@@ -1127,6 +1106,7 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
         virtio_add_queue(vdev, 64, virtio_snd_handle_rx_xfer);
     qemu_mutex_init(&vsnd->cmdq_mutex);
     QTAILQ_INIT(&vsnd->cmdq);
+    QSIMPLEQ_INIT(&vsnd->invalid);
 
     for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
         status = virtio_snd_set_pcm_params(vsnd, i, &default_params);
@@ -1376,13 +1356,20 @@ static void virtio_snd_unrealize(DeviceState *dev)
 
 static void virtio_snd_reset(VirtIODevice *vdev)
 {
-    VirtIOSound *s = VIRTIO_SND(vdev);
+    VirtIOSound *vsnd = VIRTIO_SND(vdev);
     virtio_snd_ctrl_command *cmd;
 
-    WITH_QEMU_LOCK_GUARD(&s->cmdq_mutex) {
-        while (!QTAILQ_EMPTY(&s->cmdq)) {
-            cmd = QTAILQ_FIRST(&s->cmdq);
-            QTAILQ_REMOVE(&s->cmdq, cmd, next);
+    /*
+     * Sanity check that the invalid buffer message queue is emptied at the end
+     * of every virtio_snd_handle_tx_xfer/virtio_snd_handle_rx_xfer call, and
+     * must be empty otherwise.
+     */
+    g_assert(QSIMPLEQ_EMPTY(&vsnd->invalid));
+
+    WITH_QEMU_LOCK_GUARD(&vsnd->cmdq_mutex) {
+        while (!QTAILQ_EMPTY(&vsnd->cmdq)) {
+            cmd = QTAILQ_FIRST(&vsnd->cmdq);
+            QTAILQ_REMOVE(&vsnd->cmdq, cmd, next);
             virtio_snd_ctrl_cmd_free(cmd);
         }
     }
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index 3d79181364..8dafedb276 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -151,7 +151,6 @@ struct VirtIOSoundPCMStream {
     QemuMutex queue_mutex;
     bool active;
     QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
-    QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) invalid;
 };
 
 /*
@@ -223,6 +222,21 @@ struct VirtIOSound {
     QemuMutex cmdq_mutex;
     QTAILQ_HEAD(, virtio_snd_ctrl_command) cmdq;
     bool processing_cmdq;
+    /*
+     * Convenience queue to keep track of invalid tx/rx queue messages inside
+     * the tx/rx callbacks.
+     *
+     * In the callbacks as a first step we are emptying the virtqueue to handle
+     * each message and we cannot add an invalid message back to the queue: we
+     * would re-process it in subsequent loop iterations.
+     *
+     * Instead, we add them to this queue and after finishing examining every
+     * virtqueue element, we inform the guest for each invalid message.
+     *
+     * This queue must be empty at all times except for inside the tx/rx
+     * callbacks.
+     */
+    QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) invalid;
 };
 
 struct virtio_snd_ctrl_command {
-- 
2.39.2


