Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2A6CDB47F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 08:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcf9P-0001pg-MC; Thu, 25 Jun 2026 04:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcf9J-0001hL-Q6
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 04:09:26 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcf9H-0007we-QG
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 04:09:25 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-46cbe01d4b6so947879f8f.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 01:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782374962; x=1782979762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8iiOZwR3wwRuU12hGn3F6sKroOsfSannvUWI+vGr7PE=;
 b=EXPQyaoQQBEh1+WSzWMLaOiWpb78dn72fHeanbApx6Eji9+8oHxbvzN9fyJ66YztcI
 0mxdobqzaIeLN4r19qMpLHjQPHbZ1n01G6UN1+ETcZyYzgb83ukA2VbsTVX9WaxA6YfN
 6PX3svVwlORYcWLWhOBsDqM285eZ66TxgOVyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782374962; x=1782979762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8iiOZwR3wwRuU12hGn3F6sKroOsfSannvUWI+vGr7PE=;
 b=Chr1Vvhsw84WEprl4PHd2Tje3aff/6JQisQbt48ee6FkMaPJgKGOurY2Z6BrjTCG17
 fDjYLCumAT6NuvOK+u8JmRDptzbQMkh7DXZGc1kB/dCn4Wkas+VaN4H9hd82qTeVOwS6
 Z8AmK7KX7scMZrYs7PuXCF5Eb/c6KREF3Cv8vqTskebngh5+CrS4dW6TV+DGldVCsX5I
 7m82UhWfqZw5sOKJqcRw720l27HXrtYl1pUHC0INNeUabcoHUcXoj9rhQAUMXLuno4EF
 TDHOjUbZVBRm0tQaPmo/yGHpyyAVdy4w7SZtc0Pfm70+aJD8mqkACLlTCa6Ckn9p9ciu
 K7AQ==
X-Gm-Message-State: AOJu0Yy0AHQ3owm4pvi2X40XFbXycTC1Wj+vg/m5QiltD461CVnnR9NT
 bRGVMmUobkLeBfeIf/JLpKTlVEQ1xtVhHQ07b2GWo3I7VxFtYjknefakiaTX8RCdUsUFKnS5iMq
 qj6MJAieRbg==
X-Gm-Gg: AfdE7cn22vNFKpCP3AitRmY6TuTsdMYWNYW1PUunhRPYU9VT3mdkCj98bvV9KShW0ZT
 /zcgbxqyQ5u39qC1OcR4u4G3amBQBh5tDIqP3WNn19F1d1uIgiBti8m/wTYVD5aew6PuTB2tgoh
 5KK+p/X2KN+VbXAEQTFxk8Ms7Ib9CBDDHU/nnLGMfck+F1lTKPmVsb2lH42qTUDnRNnIeNz9yrT
 217dpasMrv5SzncmMUtzAWLxL2VRBMKyF5wqU9i9edw1IMyQs0JHigbYtCoEofX+7/JZAtttHtk
 AJtJ0w+quPP0z1cBCGh7a1f4T002P3BiCo9WaAAmyOYq1nqP1Nt2oS9ttv13YtXmKJAq401RWvc
 BGWmCoSHNK32jCsODUeZTs5yjsx76XPdkld77MmpJjzVNb8ig9NNfqJA/iXrKoFYb5fbIVn3VaV
 FJT7zxfRIFxSJVaI2kc5d7AYQFS+MqkFs702T+WGNfCaKkouFe9JNQbg7uag7L09X5jsTE1NXTZ
 KNwLo2Yjq6N
X-Received: by 2002:a05:6000:4022:b0:460:66c0:311 with SMTP id
 ffacd0b85a97d-46dc27326bemr1994578f8f.33.1782374962219; 
 Thu, 25 Jun 2026 01:09:22 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a720090e98b0d86cf6583.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:90e9:8b0d:86cf:6583])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46dcbac0c9dsm3086950f8f.19.2026.06.25.01.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 01:09:21 -0700 (PDT)
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
Subject: [PATCH 8/9] hw/audio/virtio-sound: add missing vmstate fields
Date: Thu, 25 Jun 2026 10:09:09 +0200
Message-ID: <20260625080910.30569-9-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625080910.30569-1-alexander@mihalicyn.com>
References: <20260625080910.30569-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x430.google.com
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


