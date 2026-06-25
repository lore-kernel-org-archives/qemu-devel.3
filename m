Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF222CDE007
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcglm-0005pr-Ty; Thu, 25 Jun 2026 05:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcgle-0005mj-PW
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 05:53:07 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcglc-0003l5-VI
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 05:53:06 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-490b3637b90so13479635e9.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 02:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782381183; x=1782985983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oOx2qm+R206+UVXi/f01/lgWrnrK6jGBH1GZz/aoU+w=;
 b=IwO2YSM201HHjun0k+Xxac3t/GcCckW1qsidUHgJbXcqSgdMbPtpNEzqpl2sEAtacq
 oyg7lAeX/QGk7nBTUbMhNIZ3r3YSB4l72/MF6lPsan1H/tuEbShOAC5KUsE1fiU37Vws
 7sTdW/HdzGjV95M0J4YGa0V5oKIvuxPoZhMDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782381183; x=1782985983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oOx2qm+R206+UVXi/f01/lgWrnrK6jGBH1GZz/aoU+w=;
 b=QnIN1OW/QeGDt+Ar4lHg+BBOfxLeM6JxN8CnOMnwa+Us6QfjXQmchgv3Jwyhz/c2nq
 +U6cTLm0V0gRQWy6KAgTDX53n4T1F5+IKk5C+R0hID4n64eHYVEW0cBlSDhzb5ZWQs1i
 tKTWDz/OA4dOwQY/eWi8+/kfBU6gjR0Vljp9jZtwlb6n/HcXjnMBUTzgquJTtpBHbEJs
 YUkFSrc9Zkn0u9xdzsJKrRjgkeooco5o28NKrYaCokMiJUH1ctMDepGeU42Dbh+c4Yqn
 6YveOPWyuYIBsQja/uLgpRggvQRonWv2yXB8ICxGn7eIDmSvcq3lKyT4Ff5Agr4m1+U0
 sXnQ==
X-Gm-Message-State: AOJu0Yz7dYCseLDmJIkROawqg23cUOFlF404/QQ/hYYC38roWzsX9r93
 4yjcRe69Ul4/KrHITUY3XFazAc76Qfn11oQrpt0kWGx/nI5nOY1qg4dJJb6FJsR1wcznkRL55mN
 WwkuEUV8wAQ==
X-Gm-Gg: AfdE7ckVN34DIyYRNsQwKgbFzlaVA8Ik5G3pTVDaKVm+vKR5S8Bwr3VCRROXpNq2O3y
 89qYe653DJhKljr7RFysJgwRIqVwGPAEs05qa9F7LpZc+YVWEKdAy0bXkJUmkOdnaM2JNUkn850
 HITwvQKrnT/T0Qz6d1KWNEwaR9DMgXVMzk3XAeBArBZWzdOqxTt29H42ft+EpBDvzFbxMGLwg7h
 f7dOUKs0rxb1GAwhVcwERKPMaFDEpdeyalzoKVZ7A6HZ4EpcpphDgYSSzUfImP2oAHH8VNejyYx
 j+yJru+2MU9plssQi0HMYAoyEH6WjYNY9um/6YeRfgSzeay4FC2qDRZxHC6EioLREOgvmiGM/0a
 BKL0hy1VNz39Yt33O9KIjdDfZ/E++r5XrK1hpSNrV367vmMqUNmo81d5RVX97mtd8SNBCCV6sqx
 vFyRrbXZX0AccqGDYxSn1loD+D7fwqGWxIWaxX4G5Ykqt9JYMo0ZWVXvYj6Qqv+H47+eL+LbHPG
 KXQFK2kEC1L
X-Received: by 2002:a05:600c:4353:b0:492:1eed:3e67 with SMTP id
 5b1f17b1804b1-49266893383mr14961165e9.26.1782381183509; 
 Thu, 25 Jun 2026 02:53:03 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a720090e98b0d86cf6583.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:90e9:8b0d:86cf:6583])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49266102bcfsm53562105e9.15.2026.06.25.02.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 02:53:02 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v2 8/9] hw/audio/virtio-sound: add missing vmstate fields
Date: Thu, 25 Jun 2026 11:52:48 +0200
Message-ID: <20260625095250.65073-9-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625095250.65073-1-alexander@mihalicyn.com>
References: <20260625095250.65073-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x32f.google.com
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
 hw/audio/virtio-snd.c         | 83 +++++++++++++++++++++++++++++++----
 include/hw/audio/virtio-snd.h |  1 +
 2 files changed, 76 insertions(+), 8 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 53f9066ab24..b3de8abcb61 100644
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
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(state, VirtIOSoundPCMStream),
+        VMSTATE_UINT32(info.hdr.hda_fn_nid, VirtIOSoundPCMStream),
+        VMSTATE_UINT32(info.features, VirtIOSoundPCMStream),
+        VMSTATE_UINT64(info.formats, VirtIOSoundPCMStream),
+        VMSTATE_UINT64(info.rates, VirtIOSoundPCMStream),
+        VMSTATE_UINT8(info.direction, VirtIOSoundPCMStream),
+        VMSTATE_UINT8(info.channels_min, VirtIOSoundPCMStream),
+        VMSTATE_UINT8(info.channels_max, VirtIOSoundPCMStream),
+        VMSTATE_UINT32(params.buffer_bytes, VirtIOSoundPCMStream),
+        VMSTATE_UINT32(params.period_bytes, VirtIOSoundPCMStream),
+        VMSTATE_UINT32(params.features, VirtIOSoundPCMStream),
+        VMSTATE_UINT8(params.channels, VirtIOSoundPCMStream),
+        VMSTATE_UINT8(params.format, VirtIOSoundPCMStream),
+        VMSTATE_UINT8(params.rate, VirtIOSoundPCMStream),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_virtio_snd_device = {
-    .name = TYPE_VIRTIO_SND,
-    .version_id = VIRTIO_SOUND_VM_VERSION,
-    .minimum_version_id = VIRTIO_SOUND_VM_VERSION,
+    .name = "virtio-sound-device",
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
     .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
@@ -800,6 +822,7 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
                  sizeof(virtio_snd_hdr));
     virtqueue_push(cmd->vq, cmd->elem,
                    sizeof(virtio_snd_hdr) + cmd->payload_size);
+    s->queue_inuse[VIRTIO_SND_VQ_CONTROL] -= 1;
     virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
 }
 
@@ -846,6 +869,7 @@ static void virtio_snd_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
 
     elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
     while (elem) {
+        s->queue_inuse[VIRTIO_SND_VQ_CONTROL] += 1;
         cmd = g_new0(virtio_snd_ctrl_command, 1);
         cmd->elem = elem;
         cmd->vq = vq;
@@ -956,6 +980,7 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
             goto tx_err;
         }
 
+        vsnd->queue_inuse[VIRTIO_SND_VQ_TX] += 1;
         size = iov_size(elem->out_sg, elem->out_num) - msg_sz;
 
         buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
@@ -1035,6 +1060,7 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
             goto rx_err;
         }
 
+        vsnd->queue_inuse[VIRTIO_SND_VQ_RX] += 1;
         size = iov_size(elem->in_sg, elem->in_num) -
             sizeof(virtio_snd_pcm_status);
         buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
@@ -1177,6 +1203,7 @@ static inline void return_tx_buffer(VirtIOSoundPCMStream *stream,
     virtqueue_push(buffer->vq,
                    buffer->elem,
                    sizeof(virtio_snd_pcm_status));
+    stream->s->queue_inuse[VIRTIO_SND_VQ_TX] -= 1;
     virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
     QSIMPLEQ_REMOVE(&stream->queue,
                     buffer,
@@ -1270,6 +1297,7 @@ static inline void return_rx_buffer(VirtIOSoundPCMStream *stream,
     virtqueue_push(buffer->vq,
                    buffer->elem,
                    sizeof(virtio_snd_pcm_status) + buffer->size);
+    stream->s->queue_inuse[VIRTIO_SND_VQ_RX] -= 1;
     virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
     QSIMPLEQ_REMOVE(&stream->queue,
                     buffer,
@@ -1387,6 +1415,40 @@ static void virtio_snd_unrealize(DeviceState *dev)
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
+            bool rc;
+
+            rc = virtqueue_rewind(s->queues[i], s->queue_inuse[i]);
+            if (!rc) {
+                error_report(
+                    "virtio-sound: could not rewind %u elements in queue %u",
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
@@ -1419,6 +1481,10 @@ static void virtio_snd_reset(VirtIODevice *vdev)
             virtio_snd_pcm_buffer_free(buffer);
         }
     }
+
+    for (i = 0; i < VIRTIO_SND_VQ_MAX; i++) {
+        vsnd->queue_inuse[i] = 0;
+    }
 }
 
 static void virtio_snd_class_init(ObjectClass *klass, const void *data)
@@ -1432,6 +1498,7 @@ static void virtio_snd_class_init(ObjectClass *klass, const void *data)
 
     dc->vmsd = &vmstate_virtio_snd;
     vdc->vmsd = &vmstate_virtio_snd_device;
+    vdc->post_load = virtio_snd_post_load;
     vdc->realize = virtio_snd_realize;
     vdc->unrealize = virtio_snd_unrealize;
     vdc->get_config = virtio_snd_get_config;
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index 28d0322b979..523c456436b 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -197,6 +197,7 @@ struct VirtIOSound {
     VirtIODevice parent_obj;
 
     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
+    uint32_t queue_inuse[VIRTIO_SND_VQ_MAX];
     uint64_t features;
     VirtIOSoundPCMStream *streams;
     AudioBackend *audio_be;
-- 
2.47.3


