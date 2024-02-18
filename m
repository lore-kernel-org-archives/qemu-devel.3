Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848C7C4829E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 08:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbcci-00037b-LB; Sun, 18 Feb 2024 03:34:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rbccf-00036y-1H
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 03:34:05 -0500
Received: from mailout01.t-online.de ([194.25.134.80])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rbccc-0006K2-R5
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 03:34:04 -0500
Received: from fwd85.aul.t-online.de (fwd85.aul.t-online.de [10.223.144.111])
 by mailout01.t-online.de (Postfix) with SMTP id B4614659E;
 Sun, 18 Feb 2024 09:34:00 +0100 (CET)
Received: from linpower.localnet ([79.208.24.6]) by fwd85.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1rbccW-0XOtJx0; Sun, 18 Feb 2024 09:33:56 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 66C2C200378; Sun, 18 Feb 2024 09:33:51 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 03/11] hw/audio/virtio-sound: remove command and stream
 mutexes
Date: Sun, 18 Feb 2024 09:33:43 +0100
Message-Id: <20240218083351.8524-3-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <a289a081-9a61-4bcb-b693-bf6cd7768c0e@t-online.de>
References: <a289a081-9a61-4bcb-b693-bf6cd7768c0e@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1708245236-8CB04383-EFE88149/0/0 CLEAN NORMAL
X-TOI-MSGID: bde513c9-f605-49a3-a391-8863c1e11567
Received-SPF: pass client-ip=194.25.134.80;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout01.t-online.de
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

All code in virtio-snd.c runs with the BQL held. Remove the
command queue mutex and the stream queue mutexes. The qatomic
functions are also not needed.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/virtio-snd.c         | 215 +++++++++++++++-------------------
 include/hw/audio/virtio-snd.h |   3 -
 2 files changed, 93 insertions(+), 125 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index b87653daf4..7ed5f3de3e 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -19,7 +19,6 @@
 #include "qemu/iov.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
-#include "include/qemu/lockable.h"
 #include "sysemu/runstate.h"
 #include "trace.h"
 #include "qapi/error.h"
@@ -454,7 +453,6 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
         stream->id = stream_id;
         stream->pcm = s->pcm;
         stream->s = s;
-        qemu_mutex_init(&stream->queue_mutex);
         QSIMPLEQ_INIT(&stream->queue);
 
         /*
@@ -580,9 +578,7 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
 
     stream = virtio_snd_pcm_get_stream(s, stream_id);
     if (stream) {
-        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-            stream->active = start;
-        }
+        stream->active = start;
         if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
             AUD_set_active_out(stream->voice.out, start);
         } else {
@@ -606,10 +602,8 @@ static size_t virtio_snd_pcm_get_io_msgs_count(VirtIOSoundPCMStream *stream)
     VirtIOSoundPCMBuffer *buffer, *next;
     size_t count = 0;
 
-    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-        QSIMPLEQ_FOREACH_SAFE(buffer, &stream->queue, entry, next) {
-            count += 1;
-        }
+    QSIMPLEQ_FOREACH_SAFE(buffer, &stream->queue, entry, next) {
+        count += 1;
     }
     return count;
 }
@@ -760,23 +754,15 @@ static void virtio_snd_process_cmdq(VirtIOSound *s)
 {
     virtio_snd_ctrl_command *cmd;
 
-    if (unlikely(qatomic_read(&s->processing_cmdq))) {
-        return;
-    }
-
-    WITH_QEMU_LOCK_GUARD(&s->cmdq_mutex) {
-        qatomic_set(&s->processing_cmdq, true);
-        while (!QTAILQ_EMPTY(&s->cmdq)) {
-            cmd = QTAILQ_FIRST(&s->cmdq);
+    while (!QTAILQ_EMPTY(&s->cmdq)) {
+        cmd = QTAILQ_FIRST(&s->cmdq);
 
-            /* process command */
-            process_cmd(s, cmd);
+        /* process command */
+        process_cmd(s, cmd);
 
-            QTAILQ_REMOVE(&s->cmdq, cmd, next);
+        QTAILQ_REMOVE(&s->cmdq, cmd, next);
 
-            virtio_snd_ctrl_cmd_free(cmd);
-        }
-        qatomic_set(&s->processing_cmdq, false);
+        virtio_snd_ctrl_cmd_free(cmd);
     }
 }
 
@@ -891,18 +877,16 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
             goto tx_err;
         }
 
-        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-            size = iov_size(elem->out_sg, elem->out_num) - msg_sz;
+        size = iov_size(elem->out_sg, elem->out_num) - msg_sz;
 
-            buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
-            buffer->elem = elem;
-            buffer->populated = false;
-            buffer->vq = vq;
-            buffer->size = size;
-            buffer->offset = 0;
+        buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
+        buffer->elem = elem;
+        buffer->populated = false;
+        buffer->vq = vq;
+        buffer->size = size;
+        buffer->offset = 0;
 
-            QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
-        }
+        QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
         continue;
 
 tx_err:
@@ -967,16 +951,14 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
         if (stream == NULL || stream->info.direction != VIRTIO_SND_D_INPUT) {
             goto rx_err;
         }
-        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-            size = iov_size(elem->in_sg, elem->in_num) -
-                sizeof(virtio_snd_pcm_status);
-            buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
-            buffer->elem = elem;
-            buffer->vq = vq;
-            buffer->size = 0;
-            buffer->offset = 0;
-            QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
-        }
+        size = iov_size(elem->in_sg, elem->in_num) -
+            sizeof(virtio_snd_pcm_status);
+        buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
+        buffer->elem = elem;
+        buffer->vq = vq;
+        buffer->size = 0;
+        buffer->offset = 0;
+        QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
         continue;
 
 rx_err:
@@ -1083,7 +1065,6 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
         virtio_add_queue(vdev, 64, virtio_snd_handle_tx_xfer);
     vsnd->queues[VIRTIO_SND_VQ_RX] =
         virtio_add_queue(vdev, 64, virtio_snd_handle_rx_xfer);
-    qemu_mutex_init(&vsnd->cmdq_mutex);
     QTAILQ_INIT(&vsnd->cmdq);
 
     for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
@@ -1143,50 +1124,48 @@ static void virtio_snd_pcm_out_cb(void *data, int available)
     VirtIOSoundPCMBuffer *buffer;
     size_t size;
 
-    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-        while (!QSIMPLEQ_EMPTY(&stream->queue)) {
-            buffer = QSIMPLEQ_FIRST(&stream->queue);
-            if (!virtio_queue_ready(buffer->vq)) {
-                return;
+    while (!QSIMPLEQ_EMPTY(&stream->queue)) {
+        buffer = QSIMPLEQ_FIRST(&stream->queue);
+        if (!virtio_queue_ready(buffer->vq)) {
+            return;
+        }
+        if (!stream->active) {
+            /* Stream has stopped, so do not perform AUD_write. */
+            return_tx_buffer(stream, buffer);
+            continue;
+        }
+        if (!buffer->populated) {
+            iov_to_buf(buffer->elem->out_sg,
+                       buffer->elem->out_num,
+                       sizeof(virtio_snd_pcm_xfer),
+                       buffer->data,
+                       buffer->size);
+            buffer->populated = true;
+        }
+        for (;;) {
+            size = AUD_write(stream->voice.out,
+                             buffer->data + buffer->offset,
+                             MIN(buffer->size, available));
+            assert(size <= MIN(buffer->size, available));
+            if (size == 0) {
+                /* break out of both loops */
+                available = 0;
+                break;
             }
-            if (!stream->active) {
-                /* Stream has stopped, so do not perform AUD_write. */
+            buffer->size -= size;
+            buffer->offset += size;
+            available -= size;
+            if (buffer->size < 1) {
                 return_tx_buffer(stream, buffer);
-                continue;
-            }
-            if (!buffer->populated) {
-                iov_to_buf(buffer->elem->out_sg,
-                           buffer->elem->out_num,
-                           sizeof(virtio_snd_pcm_xfer),
-                           buffer->data,
-                           buffer->size);
-                buffer->populated = true;
-            }
-            for (;;) {
-                size = AUD_write(stream->voice.out,
-                                 buffer->data + buffer->offset,
-                                 MIN(buffer->size, available));
-                assert(size <= MIN(buffer->size, available));
-                if (size == 0) {
-                    /* break out of both loops */
-                    available = 0;
-                    break;
-                }
-                buffer->size -= size;
-                buffer->offset += size;
-                available -= size;
-                if (buffer->size < 1) {
-                    return_tx_buffer(stream, buffer);
-                    break;
-                }
-                if (!available) {
-                    break;
-                }
+                break;
             }
             if (!available) {
                 break;
             }
         }
+        if (!available) {
+            break;
+        }
     }
 }
 
@@ -1237,41 +1216,39 @@ static void virtio_snd_pcm_in_cb(void *data, int available)
     VirtIOSoundPCMBuffer *buffer;
     size_t size;
 
-    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-        while (!QSIMPLEQ_EMPTY(&stream->queue)) {
-            buffer = QSIMPLEQ_FIRST(&stream->queue);
-            if (!virtio_queue_ready(buffer->vq)) {
-                return;
+    while (!QSIMPLEQ_EMPTY(&stream->queue)) {
+        buffer = QSIMPLEQ_FIRST(&stream->queue);
+        if (!virtio_queue_ready(buffer->vq)) {
+            return;
+        }
+        if (!stream->active) {
+            /* Stream has stopped, so do not perform AUD_read. */
+            return_rx_buffer(stream, buffer);
+            continue;
+        }
+
+        for (;;) {
+            size = AUD_read(stream->voice.in,
+                            buffer->data + buffer->size,
+                            MIN(available, (stream->params.period_bytes -
+                                            buffer->size)));
+            if (!size) {
+                available = 0;
+                break;
             }
-            if (!stream->active) {
-                /* Stream has stopped, so do not perform AUD_read. */
+            buffer->size += size;
+            available -= size;
+            if (buffer->size >= stream->params.period_bytes) {
                 return_rx_buffer(stream, buffer);
-                continue;
-            }
-
-            for (;;) {
-                size = AUD_read(stream->voice.in,
-                        buffer->data + buffer->size,
-                        MIN(available, (stream->params.period_bytes -
-                                        buffer->size)));
-                if (!size) {
-                    available = 0;
-                    break;
-                }
-                buffer->size += size;
-                available -= size;
-                if (buffer->size >= stream->params.period_bytes) {
-                    return_rx_buffer(stream, buffer);
-                    break;
-                }
-                if (!available) {
-                    break;
-                }
+                break;
             }
             if (!available) {
                 break;
             }
         }
+        if (!available) {
+            break;
+        }
     }
 }
 
@@ -1288,11 +1265,9 @@ static inline void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream)
         (stream->info.direction == VIRTIO_SND_D_OUTPUT) ? return_tx_buffer :
         return_rx_buffer;
 
-    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-        while (!QSIMPLEQ_EMPTY(&stream->queue)) {
-            buffer = QSIMPLEQ_FIRST(&stream->queue);
-            cb(stream, buffer);
-        }
+    while (!QSIMPLEQ_EMPTY(&stream->queue)) {
+        buffer = QSIMPLEQ_FIRST(&stream->queue);
+        cb(stream, buffer);
     }
 }
 
@@ -1312,7 +1287,6 @@ static void virtio_snd_unrealize(DeviceState *dev)
                 if (stream) {
                     virtio_snd_process_cmdq(stream->s);
                     virtio_snd_pcm_close(stream);
-                    qemu_mutex_destroy(&stream->queue_mutex);
                     g_free(stream);
                 }
             }
@@ -1323,7 +1297,6 @@ static void virtio_snd_unrealize(DeviceState *dev)
         vsnd->pcm = NULL;
     }
     AUD_remove_card(&vsnd->card);
-    qemu_mutex_destroy(&vsnd->cmdq_mutex);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_EVENT]);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_TX]);
@@ -1337,12 +1310,10 @@ static void virtio_snd_reset(VirtIODevice *vdev)
     VirtIOSound *s = VIRTIO_SND(vdev);
     virtio_snd_ctrl_command *cmd;
 
-    WITH_QEMU_LOCK_GUARD(&s->cmdq_mutex) {
-        while (!QTAILQ_EMPTY(&s->cmdq)) {
-            cmd = QTAILQ_FIRST(&s->cmdq);
-            QTAILQ_REMOVE(&s->cmdq, cmd, next);
-            virtio_snd_ctrl_cmd_free(cmd);
-        }
+    while (!QTAILQ_EMPTY(&s->cmdq)) {
+        cmd = QTAILQ_FIRST(&s->cmdq);
+        QTAILQ_REMOVE(&s->cmdq, cmd, next);
+        virtio_snd_ctrl_cmd_free(cmd);
     }
 }
 
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index 1209b122b9..a2868067fb 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -148,7 +148,6 @@ struct VirtIOSoundPCMStream {
         SWVoiceIn *in;
         SWVoiceOut *out;
     } voice;
-    QemuMutex queue_mutex;
     bool active;
     QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
 };
@@ -219,9 +218,7 @@ struct VirtIOSound {
     QEMUSoundCard card;
     VMChangeStateEntry *vmstate;
     virtio_snd_config snd_conf;
-    QemuMutex cmdq_mutex;
     QTAILQ_HEAD(, virtio_snd_ctrl_command) cmdq;
-    bool processing_cmdq;
 };
 
 struct virtio_snd_ctrl_command {
-- 
2.35.3


