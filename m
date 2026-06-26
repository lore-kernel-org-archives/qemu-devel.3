Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC16CDE002
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd5mx-0004js-GM; Fri, 26 Jun 2026 08:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wd5mb-0004U2-59
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:35:50 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wd5mZ-00030N-0Q
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:35:44 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4626fdc829aso556387f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 05:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782477341; x=1783082141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pNVus+BalkmCoTPkNk7eFs2k8kuZ2QplCRnW+ImiFis=;
 b=EyFQOqqLDcM7UPwtqFIinTt9cbNiSDOMI0DmL9T5PlTlfZj9Vg2G/SKKM0LoEuPSKa
 d4IrrPKkiA3+PwPUhaQP+3MPdiTB5L07WBHfZzE0WTc5wpIiRmCidnqN3tFElyyVWN/O
 EcGhpRTSsPIXMdbUmFZEa+5oFEty59aIPdQn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782477341; x=1783082141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pNVus+BalkmCoTPkNk7eFs2k8kuZ2QplCRnW+ImiFis=;
 b=U8NrpY0vc0s0M/SSUSSmdCBHMFq30LatG53GCiHfKkvt0r1jjYqoQehgc0IFSbI8w8
 dvZ8RGX+bdKbl6DNQT3SGeGhn9Ge1XmyE0Nc/WOnMd/OjF2rXLl0+2D2BApRWAOXegvP
 MtbybUg2SzI3HiO75St0l8YSZpH8D3TZClFiz5aay7ja7W1/VzRJvSH5TyApKvGPV6lF
 DRAoyGKxxiYqJHBofh4NC+ZUvb1XyWQGVso9iCdX45X4nB0MTSm1BRBeK4kJx9lYc1lh
 eufor/mSr+BbNJnr5PY/bODEY89PijBgiOv7OLyoiEBZQ/3l1C5NI7B/dPNsXqVmB1X2
 /4dQ==
X-Gm-Message-State: AOJu0YzEYDKuR/5oozZOsKj3hNAYQOjqVzTwO1LkLcXII5WtPJaVLiJg
 ONkaKQAMgE4WZak97wlgHpR+dmsOLraGTqhPL4jckCWvkKPfoQLAJHTh/YuE5UEecN4m3lcGIBr
 qMyKW7r4=
X-Gm-Gg: AfdE7cnUZhpl2wr3BvFaw/iihZKKFOM6xYaO2LNy5yEi9dlTnmVh4Efv+NKw0gsSdnK
 QUJOhHX+OuhLhEsVe9xxWLhaSsOj84SS5tJWqGnT8uE4tY1EmLZBqWUMfXWStW8b+u1ITN99VeB
 8+Wh4RfiBQYo+MkybXWMgJ9GqUaA3xb8c/fbtqU4ka+LIebYKHTQ4ZNvv4QLfdH8oNUh/IveP/M
 6zrqqZraCrH7k1gqNr0yGsAR9x1Jv/FS9cRF26ekiJwoGwp30HYk8pL5HMFmDhuifCWEm+OysjD
 krRkdC7JXNkjwVvtLnJGp6gRm4BbYRZHVvogfjQhLE997GnWTODFVZ+WIleDO2mguI6Rm2UdvnQ
 9QbTgCn0hSyq4+IUZKkdEGsNC7+fBJa9fdLyoof+5oqksUvlbdjjoDY1N85sNcP+eki+aVo2O9o
 EvkGXJJ/hhE8/XzxemW8opQLHIVEeQ8KjHTgOk34pnDZefsqhhc3t9fIjBxsRJ+XCyOlfkWBbgM
 W9YryRMpUDR
X-Received: by 2002:a05:6000:29d2:b0:46d:d5da:f0aa with SMTP id
 ffacd0b85a97d-46dd5daf1ffmr8044719f8f.45.1782477341080; 
 Fri, 26 Jun 2026 05:35:41 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a7200aa896c1ac04cb1b2.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:aa89:6c1a:c04c:b1b2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46efd7ee1c7sm7373757f8f.14.2026.06.26.05.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 05:35:40 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v3 9/9] hw/audio/virtio-sound: add missing vmstate fields
Date: Fri, 26 Jun 2026 14:35:31 +0200
Message-ID: <20260626123531.132078-10-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626123531.132078-1-alexander@mihalicyn.com>
References: <20260626123531.132078-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x42b.google.com
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
---
v3:
	- added latency_bytes field to VMStateDescription

	As suggested by Marc-André Lureau:
	- removed the "rc" variable from virtio_snd_post_load()
	- dropped info field from VMStateDescription, because
	  it can't be modified by guest and initialized only from realize
	- added minimum_version_id/version_id so we can extend VMStateDescription
	  without breaking compatibility in the future
---
 hw/audio/virtio-snd.c         | 80 +++++++++++++++++++++++++++++++----
 include/hw/audio/virtio-snd.h |  1 +
 2 files changed, 73 insertions(+), 8 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 81ba1e1a277..7af0b63c03b 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -24,7 +24,6 @@
 #include "qapi/error.h"
 #include "hw/audio/virtio-snd.h"
 
-#define VIRTIO_SOUND_VM_VERSION 1
 #define VIRTIO_SOUND_JACK_DEFAULT 0
 #define VIRTIO_SOUND_STREAM_DEFAULT 2
 #define VIRTIO_SOUND_CHMAP_DEFAULT 0
@@ -78,17 +77,40 @@ static uint32_t supported_rates = BIT(VIRTIO_SND_PCM_RATE_5512)
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
@@ -799,6 +821,7 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
                  sizeof(virtio_snd_hdr));
     virtqueue_push(cmd->vq, cmd->elem,
                    sizeof(virtio_snd_hdr) + cmd->payload_size);
+    s->queue_inuse[VIRTIO_SND_VQ_CONTROL] -= 1;
     virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
 }
 
@@ -845,6 +868,7 @@ static void virtio_snd_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
 
     elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
     while (elem) {
+        s->queue_inuse[VIRTIO_SND_VQ_CONTROL] += 1;
         cmd = g_new0(virtio_snd_ctrl_command, 1);
         cmd->elem = elem;
         cmd->vq = vq;
@@ -955,6 +979,7 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
             goto tx_err;
         }
 
+        vsnd->queue_inuse[VIRTIO_SND_VQ_TX] += 1;
         size = iov_size(elem->out_sg, elem->out_num) - msg_sz;
 
         buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
@@ -1034,6 +1059,7 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
             goto rx_err;
         }
 
+        vsnd->queue_inuse[VIRTIO_SND_VQ_RX] += 1;
         size = iov_size(elem->in_sg, elem->in_num) -
             sizeof(virtio_snd_pcm_status);
         buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
@@ -1175,6 +1201,7 @@ static inline void return_tx_buffer(VirtIOSoundPCMStream *stream,
     virtqueue_push(buffer->vq,
                    buffer->elem,
                    sizeof(virtio_snd_pcm_status));
+    stream->s->queue_inuse[VIRTIO_SND_VQ_TX] -= 1;
     virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
     QSIMPLEQ_REMOVE(&stream->queue,
                     buffer,
@@ -1268,6 +1295,7 @@ static inline void return_rx_buffer(VirtIOSoundPCMStream *stream,
     virtqueue_push(buffer->vq,
                    buffer->elem,
                    sizeof(virtio_snd_pcm_status) + buffer->size);
+    stream->s->queue_inuse[VIRTIO_SND_VQ_RX] -= 1;
     virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
     QSIMPLEQ_REMOVE(&stream->queue,
                     buffer,
@@ -1386,6 +1414,37 @@ static void virtio_snd_unrealize(DeviceState *dev)
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
+        if (stream->state & VSND_PCMSTREAM_STATE_F_PREPARED) {
+            virtio_snd_pcm_open(stream);
+
+            if (stream->state & VSND_PCMSTREAM_STATE_F_ACTIVE) {
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
@@ -1418,6 +1477,10 @@ static void virtio_snd_reset(VirtIODevice *vdev)
             virtio_snd_pcm_buffer_free(buffer);
         }
     }
+
+    for (i = 0; i < VIRTIO_SND_VQ_MAX; i++) {
+        vsnd->queue_inuse[i] = 0;
+    }
 }
 
 static void virtio_snd_class_init(ObjectClass *klass, const void *data)
@@ -1431,6 +1494,7 @@ static void virtio_snd_class_init(ObjectClass *klass, const void *data)
 
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


