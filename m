Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4376C88E75
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7T80-0005gl-CM; Fri, 18 Sep 2026 03:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7T7x-0005g0-Uu
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 03:35:21 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x7T7v-0007E1-R9
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 03:35:21 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e69b9e16aso4584605e9.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 00:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789716918; x=1790321718; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ev1EtVgOCLRng9RIv1gIUfgjXM5TZkVOcIQwbt1kHH4=;
 b=oeNizE7nJ9ZYa/M1IQmyuVmuSJ91yt/F0QeoKWA0m3lYOgD3qv5UJKqCleR9VnILrk
 TuBAk8CcNVsrgVWU59iDleuMKGRg4uFsLfvv/LCo7Q/8UGYHDagiXux68qd5C6q5i9SR
 sjknGPxiYxaFv/igWg3c3xnEDpPqHr7lS+wZuBAWOUdXKJKFMj8jHxIHyugzHnttplcy
 qvsFU8cea9z374ESXOsP/XCJX7AfZEE4Bc9lwF8VDRhrSIxl0gSykz9bHj6L+5Mb8OBq
 Sy+9RpYwF1s42sjBAhklxzvjkMT9RLEWTrfISJBX58iABhNLKQJIP9QP9Xhfx3yvUWHM
 /11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789716918; x=1790321718;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ev1EtVgOCLRng9RIv1gIUfgjXM5TZkVOcIQwbt1kHH4=;
 b=zwGXCHQMmo+YKUpTKkYEXevfcv8eRFE6PSdlGQGHXf6CeBli20NvOAh4180H/DpaK8
 /+YG8DlKLc+YWcayUz8VjGhgABK6zrFXrNqr776Qbo5p6KBAHUnvXtcCi3vHJNXTPnn9
 FpJjVXbf/2bkndS8emxpbRDFv94/YR2/XdsEnkN/Z3Y5LFMvUIzHn1nTDdaTCEqx4wm1
 x/aBdXV90Adi5gHuXE3W48icEZjdQZiZFgmD/OXF/NVlWrxko4o9IxPV43GTAw9gKMWa
 qPI5LlQydZasod6PO9sfJDT3lqWt29y8cpJ7lvY8PuypVTZuHPNoZnWuJtGCUaq2GfqV
 3E4g==
X-Gm-Message-State: AFuF++nauF2AwSC3Y5tsVYgbMpwIDCBl07eW93Qnj35XpFD9BsQP6RbH
 P6ay9AE7UveyIE+qEVSUBxDXnvswrkh1WMC7KLoJ6F6W4C3aDSLNXz9Ks6ckoFNSRxBVTMgSx1F
 FW1bVD30=
X-Gm-Gg: AYBFou0wqPhmkwk4u8wh3R9lUMeEqcrI3JFBHbTgaVOBXhkkV16MZkaBBk0j05rJ4X/
 j9blvLLEAInv84U/yUaBjGmhzDUSOrfJy/f89sDmh/dW9tlKwuvNO4pnP4cfvJwKw16qALB4JDx
 yM8nhcQQZnS0Y2FXxkaWrKgY+3qDewW+0mL/ZWSukzT0CCbDMB2HKEutQbed40/XMj0Lf7dJqe/
 +JRKrVkvpZhRmdTZ7rDuqhmY33yucUF4zUf9+gzrJVlhCF8+KLdMhL0OLFdII3ld7DdchvhANgT
 W8CGts8oYXxNI1Gp+G3DAUEH2Eced83alNDCskxDcS1IHa5i0WDR96gwTpU7MSx7zX2yxbsXsPs
 7m6pODdVHqXavCnaq0ue170lnFl/DK8PJSYLHZtWM9t+WA+EFa9VKM8nbj5oJwP11az0hoqrHkM
 ixO3dcru1IvDxhXD86vfc3M+XTswOQSJmiAenvvVx6bKAEImf3QYxOd8GSf7rs/1eKIS8DOIxts
 1YDdoTmlHX2/d+tEz7xK5stHZrSDhFIF5Cer+ULj1yGm7qfW2ewwkgsnJ/XxU3lZXn73lI9S3+w
 nuKQ6U+5Lle+8nmzbxCe6aOww+eI8S0xinlqE8JDolCq3l9cTlg2Qcv/PS4UB9RTQCmCb1+Aj9c
 DCku9zK9PkcH661xn2cXL2fm38mxz3H+huMT4D436J2EC
X-Received: by 2002:a05:600c:4e16:b0:49e:8377:c880 with SMTP id
 5b1f17b1804b1-49fc574a641mr15734825e9.33.1789716917750; 
 Fri, 18 Sep 2026 00:35:17 -0700 (PDT)
Received: from localhost.localdomain (athedsl-116222.home.otenet.gr.
 [85.75.29.157]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc471b9a2sm23879825e9.0.2026.09.18.00.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 00:35:17 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 10/10] hw/audio/virtio-sound: add missing vmstate fields
Date: Fri, 18 Sep 2026 10:34:53 +0300
Message-ID: <20260918073502.3265143-11-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918073502.3265143-1-manos.pitsidianakis@linaro.org>
References: <20260918073502.3265143-1-manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20260803081159.91981-11-alexander@mihalicyn.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 include/hw/audio/virtio-snd.h |  1 +
 hw/audio/virtio-snd.c         | 83 +++++++++++++++++++++++++++++++----
 2 files changed, 76 insertions(+), 8 deletions(-)

diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index 85d5d7c861..384d2868c1 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -194,6 +194,7 @@ struct VirtIOSound {
     VirtIODevice parent_obj;
 
     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
+    uint32_t queue_inuse[VIRTIO_SND_VQ_MAX];
     uint64_t features;
     VirtIOSoundPCMStream *streams;
     AudioBackend *audio_be;
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 12473862d2..6df7ea0eb0 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -24,7 +24,6 @@
 #include "qapi/error.h"
 #include "hw/audio/virtio-snd.h"
 
-#define VIRTIO_SOUND_VM_VERSION 1
 #define VIRTIO_SOUND_JACK_DEFAULT 0
 #define VIRTIO_SOUND_STREAM_DEFAULT 2
 #define VIRTIO_SOUND_CHMAP_DEFAULT 0
@@ -74,17 +73,40 @@ static uint32_t supported_rates = BIT(VIRTIO_SND_PCM_RATE_5512)
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
@@ -813,6 +835,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
                  sizeof(virtio_snd_hdr));
     virtqueue_push(cmd->vq, cmd->elem,
                    sizeof(virtio_snd_hdr) + cmd->payload_size);
+    g_assert(s->queue_inuse[VIRTIO_SND_VQ_CONTROL] > 0);
+    s->queue_inuse[VIRTIO_SND_VQ_CONTROL] -= 1;
     virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
 }
 
@@ -859,6 +883,7 @@ static void virtio_snd_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
 
     elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
     while (elem) {
+        s->queue_inuse[VIRTIO_SND_VQ_CONTROL] += 1;
         cmd = g_new0(virtio_snd_ctrl_command, 1);
         cmd->elem = elem;
         cmd->vq = vq;
@@ -976,6 +1001,7 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
             goto tx_err;
         }
 
+        vsnd->queue_inuse[VIRTIO_SND_VQ_TX] += 1;
         buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
         buffer->elem = elem;
         buffer->populated = false;
@@ -1060,6 +1086,7 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
             goto rx_err;
         }
 
+        vsnd->queue_inuse[VIRTIO_SND_VQ_RX] += 1;
         buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
         buffer->elem = elem;
         buffer->vq = vq;
@@ -1200,6 +1227,8 @@ static inline void return_tx_buffer(VirtIOSoundPCMStream *stream,
     virtqueue_push(buffer->vq,
                    buffer->elem,
                    sizeof(virtio_snd_pcm_status));
+    g_assert(stream->s->queue_inuse[VIRTIO_SND_VQ_TX] > 0);
+    stream->s->queue_inuse[VIRTIO_SND_VQ_TX] -= 1;
     virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
     QSIMPLEQ_REMOVE(&stream->queue,
                     buffer,
@@ -1293,6 +1322,8 @@ static inline void return_rx_buffer(VirtIOSoundPCMStream *stream,
     virtqueue_push(buffer->vq,
                    buffer->elem,
                    sizeof(virtio_snd_pcm_status) + buffer->size);
+    g_assert(stream->s->queue_inuse[VIRTIO_SND_VQ_RX] > 0);
+    stream->s->queue_inuse[VIRTIO_SND_VQ_RX] -= 1;
     virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
     QSIMPLEQ_REMOVE(&stream->queue,
                     buffer,
@@ -1411,6 +1442,37 @@ static void virtio_snd_unrealize(DeviceState *dev)
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
@@ -1442,6 +1504,10 @@ static void virtio_snd_reset(VirtIODevice *vdev)
             virtio_snd_pcm_buffer_free(buffer);
         }
     }
+
+    for (uint32_t i = 0; i < VIRTIO_SND_VQ_MAX; i++) {
+        vsnd->queue_inuse[i] = 0;
+    }
 }
 
 static void virtio_snd_class_init(ObjectClass *klass, const void *data)
@@ -1455,6 +1521,7 @@ static void virtio_snd_class_init(ObjectClass *klass, const void *data)
 
     dc->vmsd = &vmstate_virtio_snd;
     vdc->vmsd = &vmstate_virtio_snd_device;
+    vdc->post_load = virtio_snd_post_load;
     vdc->realize = virtio_snd_realize;
     vdc->unrealize = virtio_snd_unrealize;
     vdc->get_config = virtio_snd_get_config;
-- 
γαῖα πυρί μιχθήτω


