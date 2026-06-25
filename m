Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1B5CDB466
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 08:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcf9I-0001ed-Mu; Thu, 25 Jun 2026 04:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcf9D-0001e3-1n
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 04:09:19 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcf9A-0007sw-LV
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 04:09:18 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so19146695e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 01:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782374954; x=1782979754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DLpHpa8OOkxWsW+hSrZ1Wzi0IhXXcT3liS5njp6hzZ8=;
 b=UKQ6DhnFVfXk4V8g259opg6TBAS8Y+5CgXuQ2cRB/uqGEo+4tbQVQ9wiLP8d+m+80/
 wvtmXQxpwDpf769JXnlSbOUhti9gaEgyBJYAltRjEIrMkElXxrR0ErKpFFHxmNludfNL
 kioSq/6g4currBoxq3AoRgzRHEZWN76q95uGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782374954; x=1782979754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DLpHpa8OOkxWsW+hSrZ1Wzi0IhXXcT3liS5njp6hzZ8=;
 b=k8+MGkuHWbM5y5feEMVNAvhmXGbM1NrQR+okhekzSRXnUmnCfgkhWrFORJNxzJXz8q
 hRytVHGz80STs+sRbprZjsiZt8fBnrP6ZRiJngTx963By7yF1WtlpgccPsCqfpp3IgHz
 tpD4sqFmuFeTn7PiDXe6vrwbAg8jhLbSYJVT0j+QcjVUCL3kVhnU4pPVzzBsAgO8ynVJ
 48C5mecQ9FKsPuZx7hpthWWo8NwYSkvf2On2wRwwPh9k6zFUFODPdkb8cZtWilXIegxS
 phQ3MD4pqno06VMCCECgYFg24Ra6iRmVlYaFOgJ0LZMikF0jOltudtm1VsLdyW4+aWx4
 BrsQ==
X-Gm-Message-State: AOJu0YxcQPQg7TYiEH8Rif4ZEsqZrhzIFlckeSTUkqIMrEt0ZzgqRfsV
 PZ6NpgxPupSVvclHILM8uQGqCTfPLSPu+Vs0kagVBVvnM7I9wGWbKimYO2nnN4aYBtw+zSfih5G
 v+RIs5a3kzg==
X-Gm-Gg: AfdE7cmlGaOCtyL7zxLmDLC+ie8k8/e3FD62KqCF9TMnq02S4WAAS9jKLw2zQXEn1iy
 28DVJ/y19X0qdzYYY1XzUSdIxHBJC5w7TVc925OB5awm2GkDnAnEjz+4zTfzWJL2VW6/nRUw2/+
 OBrIGS4eHuejmU8HAK0O4aPROjik1UdFXQDctkGgRXyiNdXTunlfnnOmdxcg+e+ajRy+Ff1ANz0
 HOxBGHXFtU4HFS9xisN7fieS0Tiypu/YeqdnC9e+SGvGtUQNp19POc5nqFldPIUm5ZOSPq4klSX
 Kl6q1S9A2pOMvTH/umlS1UO0e5+I4HcYwVXXVwzvJ6EVDLZEjeep/eJh/7OxBoet8fgdxLo4QfB
 2yzf4k2jZW6DSqz3PCZKi8t6KNXedWpJekPz2vUpW0ew7CRpV/MPzPNg2wDcE1No+7YptnG9Kx2
 0L1gcB2q2AdmSY0BS/RpDlUaDBklfAnCaFBZyTiNe243BdWbg2/JQLaXhnMPgxTeY2YFTGGUZpK
 BjqQSA8eoy3
X-Received: by 2002:a05:600c:8b53:b0:490:9d1b:f086 with SMTP id
 5b1f17b1804b1-49266864977mr18344415e9.14.1782374953271; 
 Thu, 25 Jun 2026 01:09:13 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a720090e98b0d86cf6583.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:90e9:8b0d:86cf:6583])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46dcbac0c9dsm3086950f8f.19.2026.06.25.01.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 01:09:12 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH 1/9] hw/audio/virtio-sound: remove command and stream mutexes
Date: Thu, 25 Jun 2026 10:09:02 +0200
Message-ID: <20260625080910.30569-2-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625080910.30569-1-alexander@mihalicyn.com>
References: <20260625080910.30569-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Volker Rümelin <vr_qemu@t-online.de>

All code in virtio-snd.c runs with the BQL held. Remove the
command queue mutex and the stream queue mutexes. The qatomic
functions are also not needed.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/audio/virtio-snd.c         | 248 +++++++++++++++-------------------
 include/hw/audio/virtio-snd.h |   3 -
 2 files changed, 110 insertions(+), 141 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index fb5cff38660..6eb31e2838e 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -19,7 +19,6 @@
 #include "qemu/iov.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
-#include "qemu/lockable.h"
 #include "system/runstate.h"
 #include "trace.h"
 #include "qapi/error.h"
@@ -442,7 +441,6 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
         stream->id = stream_id;
         stream->s = s;
         stream->latency_bytes = 0;
-        qemu_mutex_init(&stream->queue_mutex);
         QSIMPLEQ_INIT(&stream->queue);
 
         /*
@@ -568,9 +566,7 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
 
     stream = virtio_snd_pcm_get_stream(s, stream_id);
     if (stream) {
-        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-            stream->active = start;
-        }
+        stream->active = start;
         if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
             audio_be_set_active_out(s->audio_be, stream->voice.out, start);
         } else {
@@ -594,10 +590,8 @@ static size_t virtio_snd_pcm_get_io_msgs_count(VirtIOSoundPCMStream *stream)
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
@@ -739,23 +733,15 @@ static void virtio_snd_process_cmdq(VirtIOSound *s)
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
 
@@ -892,19 +878,17 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
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
-            stream->latency_bytes += size;
+        buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
+        buffer->elem = elem;
+        buffer->populated = false;
+        buffer->vq = vq;
+        buffer->size = size;
+        buffer->offset = 0;
+        stream->latency_bytes += size;
 
-            QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
-        }
+        QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
         continue;
 
 tx_err:
@@ -973,16 +957,15 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
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
+
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
@@ -1086,7 +1069,6 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
         virtio_add_queue(vdev, 64, virtio_snd_handle_tx_xfer);
     vsnd->queues[VIRTIO_SND_VQ_RX] =
         virtio_add_queue(vdev, 64, virtio_snd_handle_rx_xfer);
-    qemu_mutex_init(&vsnd->cmdq_mutex);
     QTAILQ_INIT(&vsnd->cmdq);
     QSIMPLEQ_INIT(&vsnd->invalid);
 
@@ -1154,52 +1136,50 @@ static void virtio_snd_pcm_out_cb(void *data, int available)
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
+            /* Stream has stopped, so do not perform audio_be_write. */
+            return_tx_buffer(stream, buffer);
+            continue;
+        }
+        if (!buffer->populated) {
+            iov_to_buf(buffer->elem->out_sg,
+                        buffer->elem->out_num,
+                        sizeof(virtio_snd_pcm_xfer),
+                        buffer->data,
+                        buffer->size);
+            buffer->populated = true;
+        }
+        for (;;) {
+            size = audio_be_write(stream->s->audio_be,
+                                stream->voice.out,
+                                buffer->data + buffer->offset,
+                                MIN(buffer->size, available));
+            assert(size <= MIN(buffer->size, available));
+            if (size == 0) {
+                /* break out of both loops */
+                available = 0;
+                break;
             }
-            if (!stream->active) {
-                /* Stream has stopped, so do not perform audio_be_write. */
+            buffer->size -= size;
+            buffer->offset += size;
+            available -= size;
+            update_latency(stream, size);
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
-                size = audio_be_write(stream->s->audio_be,
-                                 stream->voice.out,
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
-                update_latency(stream, size);
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
 
@@ -1250,55 +1230,53 @@ static void virtio_snd_pcm_in_cb(void *data, int available)
     VirtIOSoundPCMBuffer *buffer;
     size_t size, max_size, to_read;
 
-    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-        while (!QSIMPLEQ_EMPTY(&stream->queue)) {
-            buffer = QSIMPLEQ_FIRST(&stream->queue);
-            if (!virtio_queue_ready(buffer->vq)) {
-                return;
-            }
-            if (!stream->active) {
-                /* Stream has stopped, so do not perform audio_be_read. */
-                return_rx_buffer(stream, buffer);
-                continue;
-            }
+    while (!QSIMPLEQ_EMPTY(&stream->queue)) {
+        buffer = QSIMPLEQ_FIRST(&stream->queue);
+        if (!virtio_queue_ready(buffer->vq)) {
+            return;
+        }
+        if (!stream->active) {
+            /* Stream has stopped, so do not perform audio_be_read. */
+            return_rx_buffer(stream, buffer);
+            continue;
+        }
+
+        max_size = iov_size(buffer->elem->in_sg, buffer->elem->in_num);
+        if (max_size <= sizeof(virtio_snd_pcm_status)) {
+            return_rx_buffer(stream, buffer);
+            continue;
+        }
+        max_size -= sizeof(virtio_snd_pcm_status);
 
-            max_size = iov_size(buffer->elem->in_sg, buffer->elem->in_num);
-            if (max_size <= sizeof(virtio_snd_pcm_status)) {
+        for (;;) {
+            if (buffer->size >= max_size) {
                 return_rx_buffer(stream, buffer);
-                continue;
+                break;
             }
-            max_size -= sizeof(virtio_snd_pcm_status);
-
-            for (;;) {
-                if (buffer->size >= max_size) {
-                    return_rx_buffer(stream, buffer);
-                    break;
-                }
-                to_read = stream->params.period_bytes - buffer->size;
-                to_read = MIN(to_read, available);
-                to_read = MIN(to_read, max_size - buffer->size);
-                size = audio_be_read(stream->s->audio_be,
-                                     stream->voice.in,
-                                     buffer->data + buffer->size,
-                                     to_read);
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
+            to_read = stream->params.period_bytes - buffer->size;
+            to_read = MIN(to_read, available);
+            to_read = MIN(to_read, max_size - buffer->size);
+            size = audio_be_read(stream->s->audio_be,
+                                    stream->voice.in,
+                                    buffer->data + buffer->size,
+                                    to_read);
+            if (!size) {
+                available = 0;
+                break;
+            }
+            buffer->size += size;
+            available -= size;
+            if (buffer->size >= stream->params.period_bytes) {
+                return_rx_buffer(stream, buffer);
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
 
@@ -1315,11 +1293,9 @@ static inline void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream)
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
 
@@ -1338,14 +1314,12 @@ static void virtio_snd_unrealize(DeviceState *dev)
             if (stream) {
                 virtio_snd_process_cmdq(stream->s);
                 virtio_snd_pcm_close(stream);
-                qemu_mutex_destroy(&stream->queue_mutex);
                 g_free(stream);
             }
         }
         g_free(vsnd->pcm.streams);
     }
     g_free(vsnd->pcm.pcm_params);
-    qemu_mutex_destroy(&vsnd->cmdq_mutex);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_EVENT]);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_TX]);
@@ -1366,12 +1340,10 @@ static void virtio_snd_reset(VirtIODevice *vdev)
      */
     g_assert(QSIMPLEQ_EMPTY(&vsnd->invalid));
 
-    WITH_QEMU_LOCK_GUARD(&vsnd->cmdq_mutex) {
-        while (!QTAILQ_EMPTY(&vsnd->cmdq)) {
-            cmd = QTAILQ_FIRST(&vsnd->cmdq);
-            QTAILQ_REMOVE(&vsnd->cmdq, cmd, next);
-            virtio_snd_ctrl_cmd_free(cmd);
-        }
+    while (!QTAILQ_EMPTY(&vsnd->cmdq)) {
+        cmd = QTAILQ_FIRST(&vsnd->cmdq);
+        QTAILQ_REMOVE(&vsnd->cmdq, cmd, next);
+        virtio_snd_ctrl_cmd_free(cmd);
     }
 }
 
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index e28f1be5db9..fce7d1feea2 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -146,7 +146,6 @@ struct VirtIOSoundPCMStream {
         SWVoiceIn *in;
         SWVoiceOut *out;
     } voice;
-    QemuMutex queue_mutex;
     bool active;
     uint32_t latency_bytes;
     QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
@@ -218,9 +217,7 @@ struct VirtIOSound {
     AudioBackend *audio_be;
     VMChangeStateEntry *vmstate;
     virtio_snd_config snd_conf;
-    QemuMutex cmdq_mutex;
     QTAILQ_HEAD(, virtio_snd_ctrl_command) cmdq;
-    bool processing_cmdq;
     /*
      * Convenience queue to keep track of invalid tx/rx queue messages inside
      * the tx/rx callbacks.
-- 
2.47.3


