Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3C8C4829E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 08:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbccd-00036F-57; Sun, 18 Feb 2024 03:34:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rbcca-00035R-Lv; Sun, 18 Feb 2024 03:34:00 -0500
Received: from mailout07.t-online.de ([194.25.134.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rbccY-0006Jb-2j; Sun, 18 Feb 2024 03:34:00 -0500
Received: from fwd76.aul.t-online.de (fwd76.aul.t-online.de [10.223.144.102])
 by mailout07.t-online.de (Postfix) with SMTP id B457A23889;
 Sun, 18 Feb 2024 09:33:55 +0100 (CET)
Received: from linpower.localnet ([79.208.24.6]) by fwd76.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1rbccU-39unNx0; Sun, 18 Feb 2024 09:33:54 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 642D8200364; Sun, 18 Feb 2024 09:33:51 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Subject: [PATCH v2 02/11] hw/audio/virtio-sound: fix segmentation fault in
 tx/rx xfer handler
Date: Sun, 18 Feb 2024 09:33:42 +0100
Message-Id: <20240218083351.8524-2-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <a289a081-9a61-4bcb-b693-bf6cd7768c0e@t-online.de>
References: <a289a081-9a61-4bcb-b693-bf6cd7768c0e@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1708245234-FAFFA94C-D533C803/0/0 CLEAN NORMAL
X-TOI-MSGID: 77aa13fe-39a7-4215-acfd-50955ce197b4
Received-SPF: pass client-ip=194.25.134.83;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout07.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

A malicious guest may trigger a segmentation fault in the tx/rx xfer
handlers. On handler entry the stream variable is initialized with
NULL. If the first element of the virtio queue has an invalid size
or an invalid stream id, the error handling code dereferences the
stream variable NULL pointer.

Don't try to handle the invalid virtio queue element with a stream
queue. Instead, push the invalid queue element back to the guest
immediately.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/virtio-snd.c         | 100 ++++++++++------------------------
 include/hw/audio/virtio-snd.h |   1 -
 2 files changed, 29 insertions(+), 72 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index e604d8f30c..b87653daf4 100644
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
@@ -831,47 +827,19 @@ static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
     trace_virtio_snd_handle_event();
 }
 
-static inline void empty_invalid_queue(VirtIODevice *vdev, VirtQueue *vq)
+static void push_bad_msg_resp(VirtQueue *vq, VirtQueueElement *elem)
 {
-    VirtIOSoundPCMBuffer *buffer = NULL;
-    VirtIOSoundPCMStream *stream = NULL;
     virtio_snd_pcm_status resp = { 0 };
-    VirtIOSound *vsnd = VIRTIO_SND(vdev);
-    bool any = false;
-
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
-    }
+    size_t msg_sz;
+
+    resp.status = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+    msg_sz = iov_from_buf(elem->in_sg,
+                          elem->in_num,
+                          0,
+                          &resp,
+                          sizeof(virtio_snd_pcm_status));
+    virtqueue_push(vq, elem, msg_sz);
+    g_free(elem);
 }
 
 /*
@@ -890,11 +858,7 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
     size_t msg_sz, size;
     virtio_snd_pcm_xfer hdr;
     uint32_t stream_id;
-    /*
-     * If any of the I/O messages are invalid, put them in stream->invalid and
-     * return them after the for loop.
-     */
-    bool must_empty_invalid_queue = false;
+    bool notify = false;
 
     if (!virtio_queue_ready(vq)) {
         return;
@@ -942,17 +906,16 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
         continue;
 
 tx_err:
-        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-            must_empty_invalid_queue = true;
-            buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer));
-            buffer->elem = elem;
-            buffer->vq = vq;
-            QSIMPLEQ_INSERT_TAIL(&stream->invalid, buffer, entry);
-        }
+        push_bad_msg_resp(vq, elem);
+        notify = true;
     }
 
-    if (must_empty_invalid_queue) {
-        empty_invalid_queue(vdev, vq);
+    if (notify) {
+        /*
+         * Notify vq about virtio_snd_pcm_status responses.
+         * Buffer responses must be notified separately later.
+         */
+         virtio_notify(vdev, vq);
     }
 }
 
@@ -972,11 +935,7 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
     size_t msg_sz, size;
     virtio_snd_pcm_xfer hdr;
     uint32_t stream_id;
-    /*
-     * if any of the I/O messages are invalid, put them in stream->invalid and
-     * return them after the for loop.
-     */
-    bool must_empty_invalid_queue = false;
+    bool notify = false;
 
     if (!virtio_queue_ready(vq)) {
         return;
@@ -1021,17 +980,16 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
         continue;
 
 rx_err:
-        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-            must_empty_invalid_queue = true;
-            buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer));
-            buffer->elem = elem;
-            buffer->vq = vq;
-            QSIMPLEQ_INSERT_TAIL(&stream->invalid, buffer, entry);
-        }
+        push_bad_msg_resp(vq, elem);
+        notify = true;
     }
 
-    if (must_empty_invalid_queue) {
-        empty_invalid_queue(vdev, vq);
+    if (notify) {
+        /*
+         * Notify vq about virtio_snd_pcm_status responses.
+         * Buffer responses must be notified separately later.
+         */
+         virtio_notify(vdev, vq);
     }
 }
 
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index 3d79181364..1209b122b9 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -151,7 +151,6 @@ struct VirtIOSoundPCMStream {
     QemuMutex queue_mutex;
     bool active;
     QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
-    QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) invalid;
 };
 
 /*
-- 
2.35.3


