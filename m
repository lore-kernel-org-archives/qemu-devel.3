Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549ECC44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjCG4-0004Vh-Ju; Mon, 13 Jul 2026 04:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wjCG2-0004UA-Nh
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:43:22 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wjCG0-0003Cn-PX
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:43:22 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-47f3e6cc44aso737593f8f.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 01:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1783932199; x=1784536999; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BpiGqXL48R6JF3fqQewK9hUyJ1JhTS7ckkKnhiB/cn8=;
 b=glGdYzYHkewzuRXYnYKPHnSPE9LVif8b58trhbSFpjqNckvGAMTSMLZ5CiWRUppJQM
 vj4YpXL4GiEX0VyxsSFY4fprFbTjIx7Pkt+wyj0DnQo0ppl5vBHGzDWcJmeKP53xJ7uB
 1979JuXgrU1uziG+0NS3niQWnrJN75GzP/zYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783932199; x=1784536999;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BpiGqXL48R6JF3fqQewK9hUyJ1JhTS7ckkKnhiB/cn8=;
 b=ZHzcWcY3IRq4lKjUVb5yj2BeTEVVEyyf0knp8eBxRK6PSlpTo+cfKCci79slAh6J78
 aFqEeaJuDNt5ghzh9a9FPULGHHtFnkRocJ0sj3PMK7iwALsqF1KdJFoANXgbmwj3C68X
 6RHeRHkM1Qx/KfXxogSQJidJp6M+GwvUfwAiAcM5u06Xs49aeZelleuJ6ljp61Otu0M0
 Uti7NcljtVr/XS+1X3JUrxGhUKgM9sd5pm+3JOW9taHU01JJuF8NSEmUN4BiQJsLjWe7
 ES/tG1wwAi8/NKUW41GahP1a286wy2yVjjKnmQWoJuJpygjpnxU4h7UEbDXAYmuaH3Ii
 bDJw==
X-Gm-Message-State: AOJu0YyhMHGi+6mjnY7wmauE3szHr3yOZutBc5NVuKDOXKy3uCPeNOuY
 u2XNn3p9pIrbq+1Khw6NotVNv5YjXHNtYRsaKYKwgsPywFHanFVxMSbPYuzAmB+cW1XH3TCAwwl
 zbY+E7FLQ7A==
X-Gm-Gg: AfdE7cl8GTCreea1h3viZ1ghAYbuEwMTtoAye50d2p4UiubjQ5MpTOZVNNabHqqlnp7
 gbaAaKOlIeCXpOgf6m0DUhYkjO4fGGIWNRXGEjiyjRRJIiwmBqTtrz/saeUdwugnWlTdRjCPrNS
 R/21SXeAEX3RgChzLWloAccBMz1nQSZW+E2mui2xVN6WNlFki1qe0JpdmFo4nzIkhlvaW4qWlVY
 ijp84EHvUsCxRpBukurHO5WHxojAdXxQ2WAwUs/TrnPwcG3WRpIANXbQib4lA0JZVgjFU9Qj5wA
 a1Glx0fPdWQuFdtervGqHqBTg+BLQy7r1BbH/9L10apXXheo0uJg4u3MA+kCY1fW3YkKGIS0mXC
 jwj1fdJeediehjDwm+YCWUDtrEo4E2j9FM6wi2aJ/Y13LbT4T3B2HYIIkc1qiZhOWHOwBqbGAjc
 JFHPmdpUTxFp7XKNlj3yokdvZrJ/7q7laOs5BpU7W+GSGCJoszgrWRpgZkw7OQIkc0H/UYIT4tb
 ChMPCvtTcur
X-Received: by 2002:a05:600c:154d:b0:493:e504:cbef with SMTP id
 5b1f17b1804b1-493f8782509mr88420205e9.0.1783932199202; 
 Mon, 13 Jul 2026 01:43:19 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a7200912ca59176a42017.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:912c:a591:76a4:2017])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d97527sm287254815e9.2.2026.07.13.01.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 01:43:18 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v4 10/10] hw/audio/virtio-sound: add missing vmstate fields
Date: Mon, 13 Jul 2026 10:43:07 +0200
Message-ID: <20260713084307.79593-11-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713084307.79593-1-alexander@mihalicyn.com>
References: <20260713084307.79593-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x42f.google.com
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

The virtio-sound device is currently not migratable. Add the
missing VMSTATE fields, enable migration and reconnect the audio
streams after migration.

The queue_inuse[] array variables mimic the inuse variable in
struct VirtQueue which is private. They are needed to restart
the virtio queues after migration.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
[AM: trivial rebase changes]
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
v4:
	- added assert(. > 0) before decremeting s->queue_inuse[.]
	  (suggested by Manos Pitsidianakis)
v3:
	- added latency_bytes field to VMStateDescription

	As suggested by Marc-André Lureau:
	- removed the "rc" variable from virtio_snd_post_load()
	- dropped info field from VMStateDescription, because
	  it can't be modified by guest and initialized only from realize
	- added minimum_version_id/version_id so we can extend VMStateDescription
	  without breaking compatibility in the future
---
 hw/audio/virtio-snd.c         | 83 +++++++++++++++++++++++++++++++----
 include/hw/audio/virtio-snd.h |  1 +
 2 files changed, 76 insertions(+), 8 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 5efedd6896a..23b2e5e502e 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -24,7 +24,6 @@
 #include "qapi/error.h"
 #include "hw/audio/virtio-snd.h"
 
-#define VIRTIO_SOUND_VM_VERSION 1
 #define VIRTIO_SOUND_JACK_DEFAULT 0
 #define VIRTIO_SOUND_STREAM_DEFAULT 2
 #define VIRTIO_SOUND_CHMAP_DEFAULT 0
@@ -73,17 +72,40 @@ static uint32_t supported_rates = BIT(VIRTIO_SND_PCM_RATE_5512)
                                 | BIT(VIRTIO_SND_PCM_RATE_192000)
                                 | BIT(VIRTIO_SND_PCM_RATE_384000);
 
+static const VMStateDescription vmstate_virtio_snd_stream = {
+    .name = "virtio-sound-stream",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(state, VirtIOSoundPCMStream),
+        VMSTATE_UINT32(params.buffer_bytes, VirtIOSoundPCMStream),
+        VMSTATE_UINT32(params.period_bytes, VirtIOSoundPCMStream),
+        VMSTATE_UINT32(params.features, VirtIOSoundPCMStream),
+        VMSTATE_UINT8(params.channels, VirtIOSoundPCMStream),
+        VMSTATE_UINT8(params.format, VirtIOSoundPCMStream),
+        VMSTATE_UINT8(params.rate, VirtIOSoundPCMStream),
+        VMSTATE_UINT32(latency_bytes, VirtIOSoundPCMStream),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_virtio_snd_device = {
-    .name = TYPE_VIRTIO_SND,
-    .version_id = VIRTIO_SOUND_VM_VERSION,
-    .minimum_version_id = VIRTIO_SOUND_VM_VERSION,
+    .name = "virtio-sound-device",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(queue_inuse, VirtIOSound, VIRTIO_SND_VQ_MAX),
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(streams, VirtIOSound,
+            snd_conf.streams,
+            vmstate_virtio_snd_stream, VirtIOSoundPCMStream),
+        VMSTATE_END_OF_LIST()
+    },
 };
 
 static const VMStateDescription vmstate_virtio_snd = {
-    .name = TYPE_VIRTIO_SND,
-    .unmigratable = 1,
-    .minimum_version_id = VIRTIO_SOUND_VM_VERSION,
-    .version_id = VIRTIO_SOUND_VM_VERSION,
+    .name = "virtio-sound",
+    .version_id = 1,
+    .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
@@ -812,6 +834,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
                  sizeof(virtio_snd_hdr));
     virtqueue_push(cmd->vq, cmd->elem,
                    sizeof(virtio_snd_hdr) + cmd->payload_size);
+    g_assert(s->queue_inuse[VIRTIO_SND_VQ_CONTROL] > 0);
+    s->queue_inuse[VIRTIO_SND_VQ_CONTROL] -= 1;
     virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
 }
 
@@ -858,6 +882,7 @@ static void virtio_snd_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
 
     elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
     while (elem) {
+        s->queue_inuse[VIRTIO_SND_VQ_CONTROL] += 1;
         cmd = g_new0(virtio_snd_ctrl_command, 1);
         cmd->elem = elem;
         cmd->vq = vq;
@@ -968,6 +993,7 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
             goto tx_err;
         }
 
+        vsnd->queue_inuse[VIRTIO_SND_VQ_TX] += 1;
         size = iov_size(elem->out_sg, elem->out_num) - msg_sz;
 
         buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
@@ -1047,6 +1073,7 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
             goto rx_err;
         }
 
+        vsnd->queue_inuse[VIRTIO_SND_VQ_RX] += 1;
         size = iov_size(elem->in_sg, elem->in_num) -
             sizeof(virtio_snd_pcm_status);
         buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
@@ -1188,6 +1215,8 @@ static inline void return_tx_buffer(VirtIOSoundPCMStream *stream,
     virtqueue_push(buffer->vq,
                    buffer->elem,
                    sizeof(virtio_snd_pcm_status));
+    g_assert(stream->s->queue_inuse[VIRTIO_SND_VQ_TX] > 0);
+    stream->s->queue_inuse[VIRTIO_SND_VQ_TX] -= 1;
     virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
     QSIMPLEQ_REMOVE(&stream->queue,
                     buffer,
@@ -1281,6 +1310,8 @@ static inline void return_rx_buffer(VirtIOSoundPCMStream *stream,
     virtqueue_push(buffer->vq,
                    buffer->elem,
                    sizeof(virtio_snd_pcm_status) + buffer->size);
+    g_assert(stream->s->queue_inuse[VIRTIO_SND_VQ_RX] > 0);
+    stream->s->queue_inuse[VIRTIO_SND_VQ_RX] -= 1;
     virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
     QSIMPLEQ_REMOVE(&stream->queue,
                     buffer,
@@ -1399,6 +1430,37 @@ static void virtio_snd_unrealize(DeviceState *dev)
     virtio_cleanup(vdev);
 }
 
+static int virtio_snd_post_load(VirtIODevice *vdev)
+{
+    VirtIOSound *s = VIRTIO_SND(vdev);
+    uint32_t i;
+
+    for (i = 0; i < s->snd_conf.streams; i++) {
+        struct VirtIOSoundPCMStream *stream;
+
+        stream = virtio_snd_pcm_get_stream(s, i);
+        if (virtio_snd_pcm_state_prepared(stream->state)) {
+            virtio_snd_pcm_open(stream);
+
+            if (stream->state == VIRTIO_SND_PCM_STATE_STARTED) {
+                virtio_snd_pcm_set_active(stream, true);
+            }
+        }
+    }
+
+    for (i = 0; i < VIRTIO_SND_VQ_MAX; i++) {
+        if (s->queue_inuse[i]) {
+            if (!virtqueue_rewind(s->queues[i], s->queue_inuse[i])) {
+                error_report(
+                    "virtio-snd: could not rewind %u elements in queue %u",
+                    s->queue_inuse[i], i);
+            }
+            s->queue_inuse[i] = 0;
+        }
+    }
+
+    return 0;
+}
 
 static void virtio_snd_reset(VirtIODevice *vdev)
 {
@@ -1430,6 +1492,10 @@ static void virtio_snd_reset(VirtIODevice *vdev)
             virtio_snd_pcm_buffer_free(buffer);
         }
     }
+
+    for (uint32_t i = 0; i < VIRTIO_SND_VQ_MAX; i++) {
+        vsnd->queue_inuse[i] = 0;
+    }
 }
 
 static void virtio_snd_class_init(ObjectClass *klass, const void *data)
@@ -1443,6 +1509,7 @@ static void virtio_snd_class_init(ObjectClass *klass, const void *data)
 
     dc->vmsd = &vmstate_virtio_snd;
     vdc->vmsd = &vmstate_virtio_snd_device;
+    vdc->post_load = virtio_snd_post_load;
     vdc->realize = virtio_snd_realize;
     vdc->unrealize = virtio_snd_unrealize;
     vdc->get_config = virtio_snd_get_config;
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index 85d5d7c8619..384d2868c19 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -194,6 +194,7 @@ struct VirtIOSound {
     VirtIODevice parent_obj;
 
     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
+    uint32_t queue_inuse[VIRTIO_SND_VQ_MAX];
     uint64_t features;
     VirtIOSoundPCMStream *streams;
     AudioBackend *audio_be;
-- 
2.47.3


