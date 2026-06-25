Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DC1CDE002
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 08:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcf9M-0001j7-Q1; Thu, 25 Jun 2026 04:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcf9D-0001eC-UV
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 04:09:20 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcf9A-0007t1-Tw
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 04:09:19 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4926046fbc5so7635285e9.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 01:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782374954; x=1782979754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bLJxlS0/VNCvUknk3SrcUo8jmkLA2OeYVti9LC75F2g=;
 b=O4tYK74UEaI/mlAB/dTFVVVzAvl7l9EgMZuSI/SK4jWFT9HMJQVy9HqSx0cO0VBaEd
 LJyHJAvQKxI13KC3NlfPz/xSLS0uBK6TL5MstjMkC0Xq3HSAIUIk52NkIpXG8RR5Imdo
 UGCZHUdIAQEOGVzRJF7th5eDzZLu0RyavtjYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782374954; x=1782979754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bLJxlS0/VNCvUknk3SrcUo8jmkLA2OeYVti9LC75F2g=;
 b=N7wcDMAprqDqnmndflEBb75wGf8aLFk6LnjbTo/U49FFtdZvMAlo3rW4Y0xcLqkuRU
 PuwSRVL6mvVWxAZQpmW8jPTip5GfflZLraL5J87YKBLQFscq2Rdg9mxEk/xaGxSfgY49
 UU9LsoQb2p5F/tZe50kFwMqaOoktE2ghkTXYdM20NYgF8xIaH9XXEJzbys8YUxMqEN81
 OFUY9xGXVMOIDBM9w2Tl+P59+HGWXWefCvJzLKfuzyG4mgFlz1G2HEX+IKG7abgW4NrK
 PK59savN05x7nvVMPZK/+P+0VE4ETqH2Q0hUMP8jZ4Ubg8q7wjvnP0nvEJsxDc15sPmm
 WCNw==
X-Gm-Message-State: AOJu0Yyogv/kDA7V+DRF8mLRzm904hEcC00YVuOJRsJOGmAY2B9MhJrv
 5dP32rIVbIUxPteuiFznyZqMv6wNUOqRZiLbhsZnc4+704ujluPh7CpVZWpgc3TjaU27uEeIFc6
 1BVNYQSoD9A==
X-Gm-Gg: AfdE7cmPb0LfDs3LZjYD/R+/RU4H6H+C0ojx5wBPnx/w9h1mPVmX76t7LvsrjzGXk6U
 NqjP7EHQLts5I4CJFHRKnid02r+8IfEiCQqKV+T3Kn0HX0Nb7iJX4RUq2tv82S78dkUzGAB3CW1
 Lz8EtWIZe8kE6L/h6AK0T41r4/e8MURKxr4D9ParQew/rmNnk0aP2an1rglQPfcHIrFL/xH+WEq
 7SyaWlQKwYKmU/3W2MsKKqbJN1V8W7KOs8UUD8nomANJ1YGLG6I/vPOuCNpyn5+rNN1/9KoD4zm
 yuIA30FyQENheWful08/in22kzcezawoneXAUU+RwdF5lSVok0fh8oI1/5MZOBJLKHoQj5MV3xn
 LcD6kq8lj2p6WA6lAGyDP/9wN/B1WnUzsktKJTFrB4MkeC+ZyagRG0GScdJwvuO6vnEL2Pfef6a
 2NxGapl/ar9ncniJFJXoXqSHNeh5dtdm9ww6lOKsr9qlY12rJQVNJWx8u7++jd6KQKikqb4QL4Z
 FR0t0xKbE2y
X-Received: by 2002:a05:600c:4fc2:b0:48a:53cb:8604 with SMTP id
 5b1f17b1804b1-49266423f79mr16515045e9.14.1782374954472; 
 Thu, 25 Jun 2026 01:09:14 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a720090e98b0d86cf6583.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:90e9:8b0d:86cf:6583])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46dcbac0c9dsm3086950f8f.19.2026.06.25.01.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 01:09:13 -0700 (PDT)
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
Subject: [PATCH 2/9] hw/audio/virtio-sound: allocate an array of streams
Date: Thu, 25 Jun 2026 10:09:03 +0200
Message-ID: <20260625080910.30569-3-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625080910.30569-1-alexander@mihalicyn.com>
References: <20260625080910.30569-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x333.google.com
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

It is much easier to migrate an array of structs than individual
structs that are accessed via a pointer to a pointer to an array
of pointers to struct.

For this reason, allocate an array of streams in
virtio_snd_realize() and initialise all stream variables that
are constant at runtime immediately after allocation.

This makes it easier to remove the virtio_snd_set_pcm_params()
and virtio_snd_pcm_prepare() calls in the realisation phase and
to migrate the audio streams of the virtio sound device after
the next few patches.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/audio/virtio-snd.c         | 35 ++++++++++++++++++++++-------------
 include/hw/audio/virtio-snd.h |  1 +
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 6eb31e2838e..ebf2ec4b3f6 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -436,12 +436,9 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
 
     stream = virtio_snd_pcm_get_stream(s, stream_id);
     if (stream == NULL) {
-        stream = g_new0(VirtIOSoundPCMStream, 1);
+        stream = &s->streams[stream_id];
         stream->active = false;
-        stream->id = stream_id;
-        stream->s = s;
         stream->latency_bytes = 0;
-        QSIMPLEQ_INIT(&stream->queue);
 
         /*
          * stream_id >= s->snd_conf.streams was checked before so this is
@@ -451,14 +448,6 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
     }
 
     virtio_snd_get_qemu_audsettings(&as, params);
-    stream->info.direction = stream_id < s->snd_conf.streams / 2 +
-        (s->snd_conf.streams & 1) ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;
-    stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
-    stream->info.features = 0;
-    stream->info.channels_min = 1;
-    stream->info.channels_max = as.nchannels;
-    stream->info.formats = supported_formats;
-    stream->info.rates = supported_rates;
     stream->params = *params;
 
     stream->positions[0] = VIRTIO_SND_CHMAP_FL;
@@ -1046,6 +1035,25 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     vsnd->vmstate =
         qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsnd);
 
+    vsnd->streams = g_new0(VirtIOSoundPCMStream, vsnd->snd_conf.streams);
+
+    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
+        VirtIOSoundPCMStream *stream = &vsnd->streams[i];
+
+        stream->id = i;
+        stream->s = vsnd;
+        QSIMPLEQ_INIT(&stream->queue);
+        stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
+        stream->info.features = 0;
+        stream->info.formats = supported_formats;
+        stream->info.rates = supported_rates;
+        stream->info.direction =
+            i < vsnd->snd_conf.streams / 2 + (vsnd->snd_conf.streams & 1)
+            ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;
+        stream->info.channels_min = 1;
+        stream->info.channels_max = 2;
+    }
+
     vsnd->pcm.streams =
         g_new0(VirtIOSoundPCMStream *, vsnd->snd_conf.streams);
     vsnd->pcm.pcm_params =
@@ -1314,12 +1322,13 @@ static void virtio_snd_unrealize(DeviceState *dev)
             if (stream) {
                 virtio_snd_process_cmdq(stream->s);
                 virtio_snd_pcm_close(stream);
-                g_free(stream);
             }
         }
         g_free(vsnd->pcm.streams);
     }
     g_free(vsnd->pcm.pcm_params);
+    g_free(vsnd->streams);
+    vsnd->streams = NULL;
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_EVENT]);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_TX]);
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index fce7d1feea2..d65e6ba85be 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -214,6 +214,7 @@ struct VirtIOSound {
     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
     uint64_t features;
     VirtIOSoundPCM pcm;
+    VirtIOSoundPCMStream *streams;
     AudioBackend *audio_be;
     VMChangeStateEntry *vmstate;
     virtio_snd_config snd_conf;
-- 
2.47.3


