Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D54EC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we6eU-0004jT-4z; Mon, 29 Jun 2026 03:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1we6eR-0004ii-D5
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 03:43:31 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1we6eO-00080g-Fi
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 03:43:31 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47122683cf3so614630f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 00:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782719006; x=1783323806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=09n42/5++1WYtDmqeZ+XA1dPTpGq4jqUREo3jpaCLx4=;
 b=o3uPviWcbjJM+qyVeAeCap1p7P4VQDj+WRutaBGOC+sTs9uqiWMOvjEDZsgSQRh8rw
 w71lOGNl/YGgXojIdI0gwZaa3PVa9i8NiXrBlpUrv4Sm1P2EToatXwW5RhSk5D+5gmXU
 EDW5S2B/aEl0OHj2/Qve/wNPiMPh5JXiWprbaJH5bCGvFnOJjrO+bs6kAqUKh7OADaoD
 Yg9VQr0DXUIqpW1fz63cDOmU+wtcSDOcmp+z3xUB1dBe7Iwj31x358MbPOsxOhaVY6R2
 Goc3tndwutyqgQjeciXzEMJkRCzauRhqYYdb0BztWLOD+U7Kn6WB0lqKId590dkEkTHh
 WfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782719006; x=1783323806;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=09n42/5++1WYtDmqeZ+XA1dPTpGq4jqUREo3jpaCLx4=;
 b=bNHGj5eJH+ACfJKz2gQlRxu7LGNX6yLvtwO75NbVK8XT4B2GRzsQGkxgagZvxTJV9H
 2ivtyWhuvc79WVDxRCq2u67U9B6UV4yh70Hcmk3JJ3GTv6cKy70zT2+TS/A0WSDd/H4d
 pk97qYvKyvwV5ZgFLJZJlXswtvmOGc9ChLt1wE3pxjE2Q+BEHU/ARVn+Kea+OncV8eyP
 ywW9RILiNIy4spsptVbUrycOvN2Dj5xmteQNqMzip951NdTxvYRHw31E33Lq0SoxhLXs
 gl+UBcHCFmIwf39KLpJ9HsQMqsuqDV3wxoOxZ4cK+92vJYzjYKS0f6SlfjgXmzKAgZxR
 ijbA==
X-Forwarded-Encrypted: i=1;
 AHgh+RolL3MdfmEn0vRrrGx4eP3Wqoy/l1K+EzYpd/hXkURTrtAKb7qKHSTpSW6eWjaRiuaaxNuLD2sR7cU3@nongnu.org
X-Gm-Message-State: AOJu0Yygo5Dg0IQNsydwZf53LkVW/ecFVjkRSKcWPS1v3Swu0rlt4viR
 iJFBF+SlSjlrhFAti1eHBL/27wUq5uM0oZCCvHncl9rqLvj7hgrT0NHluK5gBH8DOD0=
X-Gm-Gg: AfdE7cmjeCZ4bVVeIwn/ldQHrj5uaQbIqbHbG+qmYrA6ThABHjZmw9CTpUQptN04A8I
 5x6wTi064HRvjpoqqru/8Li33PwTKIzOVEyw0PInsM8LTHLe7FWdBhPmxMI8jViv8pkTqO8HQIG
 Wq0M0j476A76RJ+UwueyLRj0sVey5z5miNUEZkyGISGNZwd3bN6J7B7Iq6+14+6qvSeJQSNBBCa
 L88BDDWFxgTDQFSQhaQ1Fffd8CKj6dNaDeVwlw604djT9iyea4EFAzv1tZHlIMPR8aUp4oInyq9
 PktxPulEzdyo0d3UFvKFl0dtZpAoJ409qyO72iYXA/6dSApfKn8h2pMNNXx2DX//TISK819gpld
 4S+3QsYtSovdlHStpm+RrKIZKJPfVpFEwE2ePDk6yS3KXb82CqWubsDDBni4IBVHuBpp5tXLNQt
 rMMJ8uvLCIGxx++wm3Yxx+vOHhqsxq6QW1GymXK50DmiupD9OqrYXE1wC9fNu63dlFAyzBKVQM4
 hwkgS8Y5s8sFjFidO0H4twEWWHlxJyLdLQR25B7Eow7Y8cQBEbRIYLQS0V7GnoLlTlC/SP7GF9z
 hrWPJPRILC0OmrTil3TaXew=
X-Received: by 2002:a05:6000:2f83:b0:460:3233:beee with SMTP id
 ffacd0b85a97d-46fb9453004mr16250215f8f.42.1782719006165; 
 Mon, 29 Jun 2026 00:43:26 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-131-154.home.otenet.gr. [2.86.131.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4721c88bfcasm18486003f8f.10.2026.06.29.00.43.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jun 2026 00:43:25 -0700 (PDT)
Date: Mon, 29 Jun 2026 10:43:11 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>, qemu-devel@nongnu.org
Cc: Volker R=?UTF-8?B?w7xtZWxpbg==?= <vr_qemu@t-online.de>,
 Marc-Andr=?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 St=?UTF-8?B?w6lwaGFuZQ==?= Graber <stgraber@stgraber.org>,
 "Daniel P . Berrang=?UTF-8?B?w6k=?=" <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v3 1/9] hw/audio/virtio-sound: remove command and stream
 mutexes
User-Agent: meli/0.8.13
References: <20260626123531.132078-1-alexander@mihalicyn.com>
 <20260626123531.132078-2-alexander@mihalicyn.com>
In-Reply-To: <20260626123531.132078-2-alexander@mihalicyn.com>
Message-ID: <thdusc.3eqrjfwzutb70@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42d.google.com
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

On Fri, 26 Jun 2026 15:35, Alexander Mikhalitsyn <alexander@mihalicyn.com> wrote:
>From: Volker Rümelin <vr_qemu@t-online.de>
>
>All code in virtio-snd.c runs with the BQL held. Remove the
>command queue mutex and the stream queue mutexes. The qatomic
>functions are also not needed.
>
>Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
>[AM: there were too many conflicts, I did `git checkout --ours -- <.>`
>     and then reimplemented the patch idea
>/AM]
>Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> hw/audio/virtio-snd.c         | 248 +++++++++++++++-------------------
> include/hw/audio/virtio-snd.h |   3 -
> 2 files changed, 110 insertions(+), 141 deletions(-)
>
>diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
>index fb5cff38660..6eb31e2838e 100644
>--- a/hw/audio/virtio-snd.c
>+++ b/hw/audio/virtio-snd.c
>@@ -19,7 +19,6 @@
> #include "qemu/iov.h"
> #include "qemu/log.h"
> #include "qemu/error-report.h"
>-#include "qemu/lockable.h"
> #include "system/runstate.h"
> #include "trace.h"
> #include "qapi/error.h"
>@@ -442,7 +441,6 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
>         stream->id = stream_id;
>         stream->s = s;
>         stream->latency_bytes = 0;
>-        qemu_mutex_init(&stream->queue_mutex);
>         QSIMPLEQ_INIT(&stream->queue);
> 
>         /*
>@@ -568,9 +566,7 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
> 
>     stream = virtio_snd_pcm_get_stream(s, stream_id);
>     if (stream) {
>-        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
>-            stream->active = start;
>-        }
>+        stream->active = start;
>         if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
>             audio_be_set_active_out(s->audio_be, stream->voice.out, start);
>         } else {
>@@ -594,10 +590,8 @@ static size_t virtio_snd_pcm_get_io_msgs_count(VirtIOSoundPCMStream *stream)
>     VirtIOSoundPCMBuffer *buffer, *next;
>     size_t count = 0;
> 
>-    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
>-        QSIMPLEQ_FOREACH_SAFE(buffer, &stream->queue, entry, next) {
>-            count += 1;
>-        }
>+    QSIMPLEQ_FOREACH_SAFE(buffer, &stream->queue, entry, next) {
>+        count += 1;
>     }
>     return count;
> }
>@@ -739,23 +733,15 @@ static void virtio_snd_process_cmdq(VirtIOSound *s)
> {
>     virtio_snd_ctrl_command *cmd;
> 
>-    if (unlikely(qatomic_read(&s->processing_cmdq))) {
>-        return;
>-    }
>-
>-    WITH_QEMU_LOCK_GUARD(&s->cmdq_mutex) {
>-        qatomic_set(&s->processing_cmdq, true);
>-        while (!QTAILQ_EMPTY(&s->cmdq)) {
>-            cmd = QTAILQ_FIRST(&s->cmdq);
>+    while (!QTAILQ_EMPTY(&s->cmdq)) {
>+        cmd = QTAILQ_FIRST(&s->cmdq);
> 
>-            /* process command */
>-            process_cmd(s, cmd);
>+        /* process command */
>+        process_cmd(s, cmd);
> 
>-            QTAILQ_REMOVE(&s->cmdq, cmd, next);
>+        QTAILQ_REMOVE(&s->cmdq, cmd, next);
> 
>-            virtio_snd_ctrl_cmd_free(cmd);
>-        }
>-        qatomic_set(&s->processing_cmdq, false);
>+        virtio_snd_ctrl_cmd_free(cmd);
>     }
> }
> 
>@@ -892,19 +878,17 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
>             goto tx_err;
>         }
> 
>-        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
>-            size = iov_size(elem->out_sg, elem->out_num) - msg_sz;
>+        size = iov_size(elem->out_sg, elem->out_num) - msg_sz;
> 
>-            buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
>-            buffer->elem = elem;
>-            buffer->populated = false;
>-            buffer->vq = vq;
>-            buffer->size = size;
>-            buffer->offset = 0;
>-            stream->latency_bytes += size;
>+        buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
>+        buffer->elem = elem;
>+        buffer->populated = false;
>+        buffer->vq = vq;
>+        buffer->size = size;
>+        buffer->offset = 0;
>+        stream->latency_bytes += size;
> 
>-            QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
>-        }
>+        QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
>         continue;
> 
> tx_err:
>@@ -973,16 +957,15 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
>         if (stream == NULL || stream->info.direction != VIRTIO_SND_D_INPUT) {
>             goto rx_err;
>         }
>-        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
>-            size = iov_size(elem->in_sg, elem->in_num) -
>-                sizeof(virtio_snd_pcm_status);
>-            buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
>-            buffer->elem = elem;
>-            buffer->vq = vq;
>-            buffer->size = 0;
>-            buffer->offset = 0;
>-            QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
>-        }
>+
>+        size = iov_size(elem->in_sg, elem->in_num) -
>+            sizeof(virtio_snd_pcm_status);
>+        buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
>+        buffer->elem = elem;
>+        buffer->vq = vq;
>+        buffer->size = 0;
>+        buffer->offset = 0;
>+        QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
>         continue;
> 
> rx_err:
>@@ -1086,7 +1069,6 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
>         virtio_add_queue(vdev, 64, virtio_snd_handle_tx_xfer);
>     vsnd->queues[VIRTIO_SND_VQ_RX] =
>         virtio_add_queue(vdev, 64, virtio_snd_handle_rx_xfer);
>-    qemu_mutex_init(&vsnd->cmdq_mutex);
>     QTAILQ_INIT(&vsnd->cmdq);
>     QSIMPLEQ_INIT(&vsnd->invalid);
> 
>@@ -1154,52 +1136,50 @@ static void virtio_snd_pcm_out_cb(void *data, int available)
>     VirtIOSoundPCMBuffer *buffer;
>     size_t size;
> 
>-    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
>-        while (!QSIMPLEQ_EMPTY(&stream->queue)) {
>-            buffer = QSIMPLEQ_FIRST(&stream->queue);
>-            if (!virtio_queue_ready(buffer->vq)) {
>-                return;
>+    while (!QSIMPLEQ_EMPTY(&stream->queue)) {
>+        buffer = QSIMPLEQ_FIRST(&stream->queue);
>+        if (!virtio_queue_ready(buffer->vq)) {
>+            return;
>+        }
>+        if (!stream->active) {
>+            /* Stream has stopped, so do not perform audio_be_write. */
>+            return_tx_buffer(stream, buffer);
>+            continue;
>+        }
>+        if (!buffer->populated) {
>+            iov_to_buf(buffer->elem->out_sg,
>+                        buffer->elem->out_num,
>+                        sizeof(virtio_snd_pcm_xfer),
>+                        buffer->data,
>+                        buffer->size);
>+            buffer->populated = true;
>+        }
>+        for (;;) {
>+            size = audio_be_write(stream->s->audio_be,
>+                                stream->voice.out,
>+                                buffer->data + buffer->offset,
>+                                MIN(buffer->size, available));
>+            assert(size <= MIN(buffer->size, available));
>+            if (size == 0) {
>+                /* break out of both loops */
>+                available = 0;
>+                break;
>             }
>-            if (!stream->active) {
>-                /* Stream has stopped, so do not perform audio_be_write. */
>+            buffer->size -= size;
>+            buffer->offset += size;
>+            available -= size;
>+            update_latency(stream, size);
>+            if (buffer->size < 1) {
>                 return_tx_buffer(stream, buffer);
>-                continue;
>-            }
>-            if (!buffer->populated) {
>-                iov_to_buf(buffer->elem->out_sg,
>-                           buffer->elem->out_num,
>-                           sizeof(virtio_snd_pcm_xfer),
>-                           buffer->data,
>-                           buffer->size);
>-                buffer->populated = true;
>-            }
>-            for (;;) {
>-                size = audio_be_write(stream->s->audio_be,
>-                                 stream->voice.out,
>-                                 buffer->data + buffer->offset,
>-                                 MIN(buffer->size, available));
>-                assert(size <= MIN(buffer->size, available));
>-                if (size == 0) {
>-                    /* break out of both loops */
>-                    available = 0;
>-                    break;
>-                }
>-                buffer->size -= size;
>-                buffer->offset += size;
>-                available -= size;
>-                update_latency(stream, size);
>-                if (buffer->size < 1) {
>-                    return_tx_buffer(stream, buffer);
>-                    break;
>-                }
>-                if (!available) {
>-                    break;
>-                }
>+                break;
>             }
>             if (!available) {
>                 break;
>             }
>         }
>+        if (!available) {
>+            break;
>+        }
>     }
> }
> 
>@@ -1250,55 +1230,53 @@ static void virtio_snd_pcm_in_cb(void *data, int available)
>     VirtIOSoundPCMBuffer *buffer;
>     size_t size, max_size, to_read;
> 
>-    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
>-        while (!QSIMPLEQ_EMPTY(&stream->queue)) {
>-            buffer = QSIMPLEQ_FIRST(&stream->queue);
>-            if (!virtio_queue_ready(buffer->vq)) {
>-                return;
>-            }
>-            if (!stream->active) {
>-                /* Stream has stopped, so do not perform audio_be_read. */
>-                return_rx_buffer(stream, buffer);
>-                continue;
>-            }
>+    while (!QSIMPLEQ_EMPTY(&stream->queue)) {
>+        buffer = QSIMPLEQ_FIRST(&stream->queue);
>+        if (!virtio_queue_ready(buffer->vq)) {
>+            return;
>+        }
>+        if (!stream->active) {
>+            /* Stream has stopped, so do not perform audio_be_read. */
>+            return_rx_buffer(stream, buffer);
>+            continue;
>+        }
>+
>+        max_size = iov_size(buffer->elem->in_sg, buffer->elem->in_num);
>+        if (max_size <= sizeof(virtio_snd_pcm_status)) {
>+            return_rx_buffer(stream, buffer);
>+            continue;
>+        }
>+        max_size -= sizeof(virtio_snd_pcm_status);
> 
>-            max_size = iov_size(buffer->elem->in_sg, buffer->elem->in_num);
>-            if (max_size <= sizeof(virtio_snd_pcm_status)) {
>+        for (;;) {
>+            if (buffer->size >= max_size) {
>                 return_rx_buffer(stream, buffer);
>-                continue;
>+                break;
>             }
>-            max_size -= sizeof(virtio_snd_pcm_status);
>-
>-            for (;;) {
>-                if (buffer->size >= max_size) {
>-                    return_rx_buffer(stream, buffer);
>-                    break;
>-                }
>-                to_read = stream->params.period_bytes - buffer->size;
>-                to_read = MIN(to_read, available);
>-                to_read = MIN(to_read, max_size - buffer->size);
>-                size = audio_be_read(stream->s->audio_be,
>-                                     stream->voice.in,
>-                                     buffer->data + buffer->size,
>-                                     to_read);
>-                if (!size) {
>-                    available = 0;
>-                    break;
>-                }
>-                buffer->size += size;
>-                available -= size;
>-                if (buffer->size >= stream->params.period_bytes) {
>-                    return_rx_buffer(stream, buffer);
>-                    break;
>-                }
>-                if (!available) {
>-                    break;
>-                }
>+            to_read = stream->params.period_bytes - buffer->size;
>+            to_read = MIN(to_read, available);
>+            to_read = MIN(to_read, max_size - buffer->size);
>+            size = audio_be_read(stream->s->audio_be,
>+                                    stream->voice.in,
>+                                    buffer->data + buffer->size,
>+                                    to_read);
>+            if (!size) {
>+                available = 0;
>+                break;
>+            }
>+            buffer->size += size;
>+            available -= size;
>+            if (buffer->size >= stream->params.period_bytes) {
>+                return_rx_buffer(stream, buffer);
>+                break;
>             }
>             if (!available) {
>                 break;
>             }
>         }
>+        if (!available) {
>+            break;
>+        }
>     }
> }
> 
>@@ -1315,11 +1293,9 @@ static inline void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream)
>         (stream->info.direction == VIRTIO_SND_D_OUTPUT) ? return_tx_buffer :
>         return_rx_buffer;
> 
>-    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
>-        while (!QSIMPLEQ_EMPTY(&stream->queue)) {
>-            buffer = QSIMPLEQ_FIRST(&stream->queue);
>-            cb(stream, buffer);
>-        }
>+    while (!QSIMPLEQ_EMPTY(&stream->queue)) {
>+        buffer = QSIMPLEQ_FIRST(&stream->queue);
>+        cb(stream, buffer);
>     }
> }
> 
>@@ -1338,14 +1314,12 @@ static void virtio_snd_unrealize(DeviceState *dev)
>             if (stream) {
>                 virtio_snd_process_cmdq(stream->s);
>                 virtio_snd_pcm_close(stream);
>-                qemu_mutex_destroy(&stream->queue_mutex);
>                 g_free(stream);
>             }
>         }
>         g_free(vsnd->pcm.streams);
>     }
>     g_free(vsnd->pcm.pcm_params);
>-    qemu_mutex_destroy(&vsnd->cmdq_mutex);
>     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
>     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_EVENT]);
>     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_TX]);
>@@ -1366,12 +1340,10 @@ static void virtio_snd_reset(VirtIODevice *vdev)
>      */
>     g_assert(QSIMPLEQ_EMPTY(&vsnd->invalid));
> 
>-    WITH_QEMU_LOCK_GUARD(&vsnd->cmdq_mutex) {
>-        while (!QTAILQ_EMPTY(&vsnd->cmdq)) {
>-            cmd = QTAILQ_FIRST(&vsnd->cmdq);
>-            QTAILQ_REMOVE(&vsnd->cmdq, cmd, next);
>-            virtio_snd_ctrl_cmd_free(cmd);
>-        }
>+    while (!QTAILQ_EMPTY(&vsnd->cmdq)) {
>+        cmd = QTAILQ_FIRST(&vsnd->cmdq);
>+        QTAILQ_REMOVE(&vsnd->cmdq, cmd, next);
>+        virtio_snd_ctrl_cmd_free(cmd);
>     }
> }
> 
>diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
>index e28f1be5db9..fce7d1feea2 100644
>--- a/include/hw/audio/virtio-snd.h
>+++ b/include/hw/audio/virtio-snd.h
>@@ -146,7 +146,6 @@ struct VirtIOSoundPCMStream {
>         SWVoiceIn *in;
>         SWVoiceOut *out;
>     } voice;
>-    QemuMutex queue_mutex;
>     bool active;
>     uint32_t latency_bytes;
>     QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
>@@ -218,9 +217,7 @@ struct VirtIOSound {
>     AudioBackend *audio_be;
>     VMChangeStateEntry *vmstate;
>     virtio_snd_config snd_conf;
>-    QemuMutex cmdq_mutex;
>     QTAILQ_HEAD(, virtio_snd_ctrl_command) cmdq;
>-    bool processing_cmdq;
>     /*
>      * Convenience queue to keep track of invalid tx/rx queue messages inside
>      * the tx/rx callbacks.
>-- 
>2.47.3
>

