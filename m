Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AC1CDB466
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcglj-0005n0-VD; Thu, 25 Jun 2026 05:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcgla-0005mG-Us
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 05:53:03 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcglY-0003kI-DO
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 05:53:02 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso22051955e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 02:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782381179; x=1782985979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lri0bRdBhkCLGxACsdkqhrYXwIEgpqDLyxURVvr3nz8=;
 b=aCVreMjXKNjVyBaXMKGwlDn9HLkr2V6eLofhQGqvRvdBgX93Nd/puTGCXyeyrG2VqE
 dyx/U14o0XL1OzlbQ9fm1nfTHN1fbiUeEjbgP3g4VAy/eBC7OLK28k+7IVkpZlbh89VJ
 QrV2XsQlbYltOnpgvMz7Jq4ekwZy11W+FEN8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782381179; x=1782985979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lri0bRdBhkCLGxACsdkqhrYXwIEgpqDLyxURVvr3nz8=;
 b=SScAggmK+z7Hpp36Xfox7huMofyU/cRpvNI38NJXsBY6+KXHqp8VVG8CWfqijZ67Wz
 l/4aKISxC0DgNHVc6XltODOmGyQbiGDbvsdr1x6MBM5xranZ1EZ0byFXXJ7y/90pMRPq
 Tc2aDlfSi9gw428+78LThn/u5gefgo0OwXWjrVW6Uo8jdb8iviFDKQ03ebsux+4N3dYE
 BqUotbd9KQhL/66nOi2mppFMF70LpWOr+UIy5ap+R41P9lvlD6ea4dmXdJPAVmU8YRDa
 mlYVBL2DSJa3ZH246X8L0MHdN5P3kIPjEj0pXKRjVqRzu9saU561w24HBCuYK1uYNSVT
 e8aQ==
X-Gm-Message-State: AOJu0YzCFWYvaIFFF2P4boNlBJuQ5GcuAubhTeFUKUagW7cnvETgPrvR
 nSByZCNzDkgoXzXsXvyb5m+mGxTU/GBfbMqXr1hK+PfS7vlMhnkEVq+QjsEcgXZ+68AVEKmJhXx
 XlE6z7ykSfw==
X-Gm-Gg: AfdE7cnwkBCAk6nX7BbD/II1olmbcbudiV9gru/bUIE2T8eBYMtntYOw+3KL1xl/c7R
 hv0FigWq8mTvqcTLUPNiDAU5bHQORtxzZ7hIwLRKZ8Q8jVHSgZ9RgNZQYfm2w+TfBZ156hU68Se
 zNkH63w64peXlxYo362hXScAiGLTeo9t9pZyXJRkiDjE6Iurv60dlECukaqIWOHSwGAHFaTpOPd
 jCxbNa5YLZr8oZ1cIO1Mt0cUpWD0SfosHPovTViJ464UdOzfv3Ip+CketjyIU9KQz2yL1qJOJTk
 DgKOylz9G+Z6rtlJvoCyvxNxEnOuik2T6L6w4jWc+3F3fE1vVXT8kt+jCq3IgmI2SUeZss00zAD
 jcFZT5eQVGDIky5FsRDIjJuvQs1mEZu3i3keIp0L1IpVtDvmzEypaAqhUQ9fbRU9GrqVZuBBUDt
 6OO12YZBcWMueyxo1esX9KMK2zXAQYV5fEPhYvWLAsVf+BUvY3UVAPHeAoT0Y9LcnSSTGCIL8/t
 RrMz4KRdLUm
X-Received: by 2002:a05:600c:34c2:b0:490:d946:47cf with SMTP id
 5b1f17b1804b1-49266832378mr23614735e9.4.1782381178782; 
 Thu, 25 Jun 2026 02:52:58 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a720090e98b0d86cf6583.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:90e9:8b0d:86cf:6583])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49266102bcfsm53562105e9.15.2026.06.25.02.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 02:52:58 -0700 (PDT)
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
Subject: [PATCH v2 5/9] hw/audio/virtio-sound: add stream state variable
Date: Thu, 25 Jun 2026 11:52:45 +0200
Message-ID: <20260625095250.65073-6-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625095250.65073-1-alexander@mihalicyn.com>
References: <20260625095250.65073-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x32c.google.com
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

So far, only rudimentary checks have been made to ensure that
the guest only performs state transitions permitted in
virtio-v1.2-csd01 5.14.6.6.1 PCM Command Lifecycle. Add a state
variable per audio stream and check all state transitions.

Because only permitted state transitions are possible, only one
copy of the audio stream parameters is required and these do not
need to be initialised with default values.

The state variable will also make it easier to restore the audio
stream after migration.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
[AM: there were too many conflicts, I did `git checkout --ours -- <.>`
     and then reimplemented the patch idea
/AM]
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/audio/virtio-snd.c         | 196 +++++++++++++++++++---------------
 include/hw/audio/virtio-snd.h |  18 +---
 2 files changed, 109 insertions(+), 105 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 80dc13318af..388a302255a 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -30,11 +30,30 @@
 #define VIRTIO_SOUND_CHMAP_DEFAULT 0
 #define VIRTIO_SOUND_HDA_FN_NID 0
 
+#define VSND_PCMSTREAM_STATE_F_PARAMS_SET  0x10000
+#define VSND_PCMSTREAM_STATE_F_PREPARED    0x20000
+#define VSND_PCMSTREAM_STATE_F_ACTIVE      0x40000
+
+#define VSND_PCMSTREAM_STATE_UNINITIALIZED 0
+#define VSND_PCMSTREAM_STATE_PARAMS_SET    (1 \
+                                           | VSND_PCMSTREAM_STATE_F_PARAMS_SET)
+#define VSND_PCMSTREAM_STATE_PREPARED      (2 \
+                                           | VSND_PCMSTREAM_STATE_F_PARAMS_SET \
+                                           | VSND_PCMSTREAM_STATE_F_PREPARED)
+#define VSND_PCMSTREAM_STATE_STARTED       (4 \
+                                           | VSND_PCMSTREAM_STATE_F_PARAMS_SET \
+                                           | VSND_PCMSTREAM_STATE_F_PREPARED \
+                                           | VSND_PCMSTREAM_STATE_F_ACTIVE)
+#define VSND_PCMSTREAM_STATE_STOPPED       (6 \
+                                           | VSND_PCMSTREAM_STATE_F_PARAMS_SET \
+                                           | VSND_PCMSTREAM_STATE_F_PREPARED)
+#define VSND_PCMSTREAM_STATE_RELEASED      (7 \
+                                           | VSND_PCMSTREAM_STATE_F_PARAMS_SET)
+
 static void virtio_snd_pcm_out_cb(void *data, int available);
 static void virtio_snd_process_cmdq(VirtIOSound *s);
 static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
 static void virtio_snd_pcm_in_cb(void *data, int available);
-static void virtio_snd_unrealize(DeviceState *dev);
 
 static uint32_t supported_formats = BIT(VIRTIO_SND_PCM_FMT_S8)
                                   | BIT(VIRTIO_SND_PCM_FMT_U8)
@@ -129,7 +148,7 @@ static VirtIOSoundPCMStream *virtio_snd_pcm_get_stream(VirtIOSound *s,
                                                        uint32_t stream_id)
 {
     return stream_id >= s->snd_conf.streams ? NULL :
-        s->pcm.streams[stream_id];
+        &s->streams[stream_id];
 }
 
 /*
@@ -141,8 +160,8 @@ static VirtIOSoundPCMStream *virtio_snd_pcm_get_stream(VirtIOSound *s,
 static virtio_snd_pcm_set_params *virtio_snd_pcm_get_params(VirtIOSound *s,
                                                             uint32_t stream_id)
 {
-    return stream_id >= s->snd_conf.streams ? NULL
-        : &s->pcm.pcm_params[stream_id];
+    return stream_id >= s->snd_conf.streams ? NULL :
+        &s->streams[stream_id].params;
 }
 
 /*
@@ -245,11 +264,10 @@ static void virtio_snd_handle_pcm_info(VirtIOSound *s,
 
 /*
  * Set the given stream params.
- * Called by both virtio_snd_handle_pcm_set_params and during device
- * initialization.
  * Returns the response status code. (VIRTIO_SND_S_*).
  *
  * @s: VirtIOSound device
+ * @stream_id: stream id
  * @params: The PCM params as defined in the virtio specification
  */
 static
@@ -257,14 +275,25 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
                                    uint32_t stream_id,
                                    virtio_snd_pcm_set_params *params)
 {
+    VirtIOSoundPCMStream *stream;
     virtio_snd_pcm_set_params *st_params;
 
-    if (stream_id >= s->snd_conf.streams || s->pcm.pcm_params == NULL) {
+    if (stream_id >= s->snd_conf.streams) {
         virtio_error(VIRTIO_DEVICE(s), "Streams have not been initialized.\n");
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 
-    st_params = virtio_snd_pcm_get_params(s, stream_id);
+    stream = virtio_snd_pcm_get_stream(s, stream_id);
+
+    switch (stream->state) {
+    case VSND_PCMSTREAM_STATE_UNINITIALIZED:
+    case VSND_PCMSTREAM_STATE_PARAMS_SET:
+    case VSND_PCMSTREAM_STATE_PREPARED:
+    case VSND_PCMSTREAM_STATE_RELEASED:
+        break;
+    default:
+        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+    }
 
     if (params->channels < 1 || params->channels > AUDIO_MAX_CHANNELS) {
         error_report("Number of channels is not supported.");
@@ -281,6 +310,8 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
         return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
     }
 
+    st_params = virtio_snd_pcm_get_params(s, stream_id);
+
     st_params->buffer_bytes = le32_to_cpu(params->buffer_bytes);
     st_params->period_bytes = le32_to_cpu(params->period_bytes);
     st_params->features = le32_to_cpu(params->features);
@@ -289,6 +320,13 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
     st_params->format = params->format;
     st_params->rate = params->rate;
 
+    if (stream->state & VSND_PCMSTREAM_STATE_F_PREPARED) {
+        /* implicit VIRTIO_SND_R_PCM_RELEASE */
+        virtio_snd_pcm_flush(stream);
+    }
+
+    stream->state = VSND_PCMSTREAM_STATE_PARAMS_SET;
+
     return cpu_to_le32(VIRTIO_SND_S_OK);
 }
 
@@ -398,15 +436,13 @@ static void virtio_snd_get_qemu_audsettings(audsettings *as,
  */
 static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
 {
-    if (stream) {
-        virtio_snd_pcm_flush(stream);
-        if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
-            audio_be_close_out(stream->s->audio_be, stream->voice.out);
-            stream->voice.out = NULL;
-        } else if (stream->info.direction == VIRTIO_SND_D_INPUT) {
-            audio_be_close_in(stream->s->audio_be, stream->voice.in);
-            stream->voice.in = NULL;
-        }
+    virtio_snd_pcm_flush(stream);
+    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
+        audio_be_close_out(stream->s->audio_be, stream->voice.out);
+        stream->voice.out = NULL;
+    } else if (stream->info.direction == VIRTIO_SND_D_INPUT) {
+        audio_be_close_in(stream->s->audio_be, stream->voice.in);
+        stream->voice.in = NULL;
     }
 }
 
@@ -423,32 +459,23 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
     virtio_snd_pcm_set_params *params;
     VirtIOSoundPCMStream *stream;
 
-    if (s->pcm.streams == NULL ||
-        s->pcm.pcm_params == NULL ||
-        stream_id >= s->snd_conf.streams) {
+    stream = virtio_snd_pcm_get_stream(s, stream_id);
+    if (!stream) {
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 
-    params = virtio_snd_pcm_get_params(s, stream_id);
-    if (params == NULL) {
+    switch (stream->state) {
+    case VSND_PCMSTREAM_STATE_PARAMS_SET:
+    case VSND_PCMSTREAM_STATE_PREPARED:
+    case VSND_PCMSTREAM_STATE_RELEASED:
+        break;
+    default:
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 
-    stream = virtio_snd_pcm_get_stream(s, stream_id);
-    if (stream == NULL) {
-        stream = &s->streams[stream_id];
-        stream->active = false;
-        stream->latency_bytes = 0;
-
-        /*
-         * stream_id >= s->snd_conf.streams was checked before so this is
-         * in-bounds
-         */
-        s->pcm.streams[stream_id] = stream;
-    }
+    params = virtio_snd_pcm_get_params(s, stream_id);
 
     virtio_snd_get_qemu_audsettings(&as, params);
-    stream->params = *params;
 
     stream->positions[0] = VIRTIO_SND_CHMAP_FL;
     stream->positions[1] = VIRTIO_SND_CHMAP_FR;
@@ -472,6 +499,8 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
         audio_be_set_volume_in_lr(s->audio_be, stream->voice.in, 0, 255, 255);
     }
 
+    stream->state = VSND_PCMSTREAM_STATE_PREPARED;
+
     return cpu_to_le32(VIRTIO_SND_S_OK);
 }
 
@@ -540,12 +569,28 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
     }
 
     if (start) {
+        switch (stream->state) {
+        case VSND_PCMSTREAM_STATE_PREPARED:
+        case VSND_PCMSTREAM_STATE_STOPPED:
+            break;
+        default:
+            return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+        }
+
         trace_virtio_snd_handle_pcm_start(stream_id);
+        stream->state = VSND_PCMSTREAM_STATE_STARTED;
     } else {
+        switch (stream->state) {
+        case VSND_PCMSTREAM_STATE_STARTED:
+            break;
+        default:
+            return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+        }
+
         trace_virtio_snd_handle_pcm_stop(stream_id);
+        stream->state = VSND_PCMSTREAM_STATE_STOPPED;
     }
 
-    stream->active = start;
     if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
         audio_be_set_active_out(s->audio_be, stream->voice.out, start);
     } else {
@@ -639,6 +684,15 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
         return;
     }
 
+    switch (stream->state) {
+    case VSND_PCMSTREAM_STATE_PREPARED:
+    case VSND_PCMSTREAM_STATE_STOPPED:
+        break;
+    default:
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+        return;
+    }
+
     if (virtio_snd_pcm_get_io_msgs_count(stream)) {
         /*
          * virtio-v1.2-csd01, 5.14.6.6.5.1,
@@ -653,6 +707,8 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
         virtio_snd_pcm_flush(stream);
     }
 
+    stream->state = VSND_PCMSTREAM_STATE_RELEASED;
+
     cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
 }
 
@@ -874,12 +930,11 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
         }
         stream_id = le32_to_cpu(hdr.stream_id);
 
-        if (stream_id >= vsnd->snd_conf.streams
-            || vsnd->pcm.streams[stream_id] == NULL) {
+        if (stream_id >= vsnd->snd_conf.streams) {
             goto tx_err;
         }
 
-        stream = vsnd->pcm.streams[stream_id];
+        stream = &vsnd->streams[stream_id];
         if (stream->info.direction != VIRTIO_SND_D_OUTPUT) {
             goto tx_err;
         }
@@ -954,13 +1009,12 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
         }
         stream_id = le32_to_cpu(hdr.stream_id);
 
-        if (stream_id >= vsnd->snd_conf.streams
-            || !vsnd->pcm.streams[stream_id]) {
+        if (stream_id >= vsnd->snd_conf.streams) {
             goto rx_err;
         }
 
-        stream = vsnd->pcm.streams[stream_id];
-        if (stream == NULL || stream->info.direction != VIRTIO_SND_D_INPUT) {
+        stream = &vsnd->streams[stream_id];
+        if (stream->info.direction != VIRTIO_SND_D_INPUT) {
             goto rx_err;
         }
 
@@ -1019,8 +1073,6 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     ERRP_GUARD();
     VirtIOSound *vsnd = VIRTIO_SND(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    virtio_snd_pcm_set_params default_params = { 0 };
-    uint32_t status;
 
     trace_virtio_snd_realize(vsnd);
 
@@ -1058,6 +1110,7 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
         VirtIOSoundPCMStream *stream = &vsnd->streams[i];
 
         stream->id = i;
+        stream->state = VSND_PCMSTREAM_STATE_UNINITIALIZED;
         stream->s = vsnd;
         QSIMPLEQ_INIT(&stream->queue);
         stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
@@ -1071,21 +1124,9 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
         stream->info.channels_max = 2;
     }
 
-    vsnd->pcm.streams =
-        g_new0(VirtIOSoundPCMStream *, vsnd->snd_conf.streams);
-    vsnd->pcm.pcm_params =
-        g_new0(virtio_snd_pcm_set_params, vsnd->snd_conf.streams);
-
     virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
     virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
 
-    /* set default params for all streams */
-    default_params.features = 0;
-    default_params.buffer_bytes = cpu_to_le32(8192);
-    default_params.period_bytes = cpu_to_le32(2048);
-    default_params.channels = 2;
-    default_params.format = VIRTIO_SND_PCM_FMT_S16;
-    default_params.rate = VIRTIO_SND_PCM_RATE_48000;
     vsnd->queues[VIRTIO_SND_VQ_CONTROL] =
         virtio_add_queue(vdev, 64, virtio_snd_handle_ctrl);
     vsnd->queues[VIRTIO_SND_VQ_EVENT] =
@@ -1096,28 +1137,6 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
         virtio_add_queue(vdev, 64, virtio_snd_handle_rx_xfer);
     QTAILQ_INIT(&vsnd->cmdq);
     QSIMPLEQ_INIT(&vsnd->invalid);
-
-    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
-        status = virtio_snd_set_pcm_params(vsnd, i, &default_params);
-        if (status != cpu_to_le32(VIRTIO_SND_S_OK)) {
-            error_setg(errp,
-                       "Can't initialize stream params, device responded with %s.",
-                       print_code(status));
-            goto error_cleanup;
-        }
-        status = virtio_snd_pcm_prepare(vsnd, i);
-        if (status != cpu_to_le32(VIRTIO_SND_S_OK)) {
-            error_setg(errp,
-                       "Can't prepare streams, device responded with %s.",
-                       print_code(status));
-            goto error_cleanup;
-        }
-    }
-
-    return;
-
-error_cleanup:
-    virtio_snd_unrealize(dev);
 }
 
 static inline void update_latency(VirtIOSoundPCMStream *s, size_t used)
@@ -1166,7 +1185,7 @@ static void virtio_snd_pcm_out_cb(void *data, int available)
         if (!virtio_queue_ready(buffer->vq)) {
             return;
         }
-        if (!stream->active) {
+        if (!(stream->state & VSND_PCMSTREAM_STATE_F_ACTIVE)) {
             /* Stream has stopped, so do not perform audio_be_write. */
             return_tx_buffer(stream, buffer);
             continue;
@@ -1260,7 +1279,7 @@ static void virtio_snd_pcm_in_cb(void *data, int available)
         if (!virtio_queue_ready(buffer->vq)) {
             return;
         }
-        if (!stream->active) {
+        if (!(stream->state & VSND_PCMSTREAM_STATE_F_ACTIVE)) {
             /* Stream has stopped, so do not perform audio_be_read. */
             return_rx_buffer(stream, buffer);
             continue;
@@ -1333,17 +1352,15 @@ static void virtio_snd_unrealize(DeviceState *dev)
     qemu_del_vm_change_state_handler(vsnd->vmstate);
     trace_virtio_snd_unrealize(vsnd);
 
-    if (vsnd->pcm.streams) {
+    if (vsnd->streams) {
+        virtio_snd_process_cmdq(vsnd);
         for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
-            stream = vsnd->pcm.streams[i];
-            if (stream) {
-                virtio_snd_process_cmdq(stream->s);
-                virtio_snd_pcm_close(stream);
+            stream = &vsnd->streams[i];
+            if (stream->state & VSND_PCMSTREAM_STATE_F_PREPARED) {
+                virtio_snd_pcm_flush(stream);
             }
         }
-        g_free(vsnd->pcm.streams);
     }
-    g_free(vsnd->pcm.pcm_params);
     g_free(vsnd->streams);
     vsnd->streams = NULL;
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
@@ -1377,6 +1394,9 @@ static void virtio_snd_reset(VirtIODevice *vdev)
         VirtIOSoundPCMStream *stream = &vsnd->streams[i];
         VirtIOSoundPCMBuffer *buffer;
 
+        virtio_snd_pcm_close(stream);
+        stream->state = VSND_PCMSTREAM_STATE_UNINITIALIZED;
+
         while ((buffer = QSIMPLEQ_FIRST(&stream->queue))) {
             QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
             virtio_snd_pcm_buffer_free(buffer);
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index d65e6ba85be..28d0322b979 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -75,8 +75,6 @@ typedef struct VirtIOSoundPCMStream VirtIOSoundPCMStream;
 
 typedef struct virtio_snd_ctrl_command virtio_snd_ctrl_command;
 
-typedef struct VirtIOSoundPCM VirtIOSoundPCM;
-
 typedef struct VirtIOSoundPCMBuffer VirtIOSoundPCMBuffer;
 
 /*
@@ -121,32 +119,19 @@ struct VirtIOSoundPCMBuffer {
     uint8_t data[];
 };
 
-struct VirtIOSoundPCM {
-    /*
-     * PCM parameters are a separate field instead of a VirtIOSoundPCMStream
-     * field, because the operation of PCM control requests is first
-     * VIRTIO_SND_R_PCM_SET_PARAMS and then VIRTIO_SND_R_PCM_PREPARE; this
-     * means that some times we get parameters without having an allocated
-     * stream yet.
-     */
-    virtio_snd_pcm_set_params *pcm_params;
-    VirtIOSoundPCMStream **streams;
-};
-
 struct VirtIOSoundPCMStream {
     virtio_snd_pcm_info info;
     virtio_snd_pcm_set_params params;
     uint32_t id;
+    uint32_t state;
     /* channel position values (VIRTIO_SND_CHMAP_XXX) */
     uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
     VirtIOSound *s;
-    bool flushing;
     audsettings as;
     union {
         SWVoiceIn *in;
         SWVoiceOut *out;
     } voice;
-    bool active;
     uint32_t latency_bytes;
     QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
 };
@@ -213,7 +198,6 @@ struct VirtIOSound {
 
     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
     uint64_t features;
-    VirtIOSoundPCM pcm;
     VirtIOSoundPCMStream *streams;
     AudioBackend *audio_be;
     VMChangeStateEntry *vmstate;
-- 
2.47.3


