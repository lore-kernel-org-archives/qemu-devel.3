Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C65ACDE002
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd5mq-0004WS-NS; Fri, 26 Jun 2026 08:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wd5mW-0004Tk-T0
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:35:43 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wd5mS-0002w8-Uz
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:35:38 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4624a44e152so757737f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 05:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782477335; x=1783082135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AW7r2QY0nXmTKyAJnyZvsgmcfNO+aR6jABn9atnw44s=;
 b=dI9+AleVj/EqMYzXIHX1MJpIzxVRo+SEGd+JeXriBLzhu8RnxGMOj0ctARzk9rqdGI
 sRN9Xdt3Rov6AxF6i9KQcVz88wO23ZjLiw0xMcXCiNvBtKGHFXPOiN6eNJ/FtJM+XHp4
 RUj9q0wjDvW8swfqlV9WnrSeroEWQ4vQtgsA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782477335; x=1783082135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AW7r2QY0nXmTKyAJnyZvsgmcfNO+aR6jABn9atnw44s=;
 b=P+74nPZiWtTJcrenAwWBdMUQP8PVcZw/6pHdKYUH0ELOCql47givF98bqpnz9vNV1E
 FOWeNqetrTjFSf0y8lPdycx50b7YBRjNOKAJmMJjCxrifSNuBPv09KEwXvX2sL6Pg7C8
 MaZJomWGW0T+i0EaukXPMAUFIuo3Uc4fmTPWTkVaDI5gRgX9f7/PONdwtXoy6Zm2+vNQ
 4Jt3ys4fD2e2Rxf7KFFPRg8mYZheO+oyX0LYIUPh+wKT56/Lsa7GabcVu6BEEEJfhSqz
 7k5HFF2g6erWB0u0kPy6udX55qjfGgKfkzPbpZ6VolDdwCpPqwVnv//g8PdytAufg1nA
 KyxA==
X-Gm-Message-State: AOJu0YxI521dsWOPcKLOCFk+HbUZgMSdFpDH61BI2fXF9Z9thkDSzEGj
 7lmjt2zEhA/cbENznI8OfBTcyeBHWLPCRl2Q6mPbH88I58z+6/+1JsZL3IA3m/NYk9cBsdGaJSg
 BMP3AGls=
X-Gm-Gg: AfdE7clraPMRJgi1fsKStgjQssezRct/RKTvkuW+71Vz6D2h/sQ5ImO5B+39P6Edygu
 sz36jh6HYIXWtqSJ/e05sXBo8LJq//Pl9W/Q6YOe2XhFN83rCMWVgypt3y37oAapxPrxpZaPhnn
 7PD/khPY8VqV2EVO2tavztArdqUpUhC4/axJWEnU1C7QsM6P2TxQbGIZCcAkvQXpqpEseJZDoo+
 AgEr7iBltrPHd3GZ57b74D7L3Li4Ras04a1PJOL7HUjPI5V7owC6Wyczfa72XdAvnKi2vEYDj/0
 OVDKGOpfy1WjUsjCd1IJ8SfBRaZyNYD4WwQR8LyFLSc5e0WnxlThU8tqWVay3+9af/zQnfq5dC0
 jnuwJq5UC9lifIpk559EKUg6L+ke4V/++01hPn2c1mk83QIPEDpxrUL+t5OPQrOO18jXRPD707n
 JyExqE9NaXkNlYR8Gw326lDm6LX/REhSKS+SXhZ9pas3MeKBk3PeQC0zwFJYlh84DNqMFbxn3aH
 +JJZVRS8Vd4
X-Received: by 2002:a05:6000:706:b0:46f:558:a43f with SMTP id
 ffacd0b85a97d-46f0558a904mr3813141f8f.4.1782477335101; 
 Fri, 26 Jun 2026 05:35:35 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a7200aa896c1ac04cb1b2.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:aa89:6c1a:c04c:b1b2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46efd7ee1c7sm7373757f8f.14.2026.06.26.05.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 05:35:34 -0700 (PDT)
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
Subject: [PATCH v3 2/9] hw/audio/virtio-sound: allocate an array of streams
Date: Fri, 26 Jun 2026 14:35:24 +0200
Message-ID: <20260626123531.132078-3-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626123531.132078-1-alexander@mihalicyn.com>
References: <20260626123531.132078-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x433.google.com
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
[AM: there were too many conflicts, I did `git checkout --ours -- <.>`
     and then reimplemented the patch idea
/AM]
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
v3:
	As suggested by Marc-André Lureau:
	- drop VirtIOSoundPCMStream's id field
---
 hw/audio/virtio-snd.c         | 34 +++++++++++++++++++++-------------
 include/hw/audio/virtio-snd.h |  2 +-
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 6eb31e2838e..859c2770195 100644
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
@@ -1046,6 +1035,24 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     vsnd->vmstate =
         qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsnd);
 
+    vsnd->streams = g_new0(VirtIOSoundPCMStream, vsnd->snd_conf.streams);
+
+    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
+        VirtIOSoundPCMStream *stream = &vsnd->streams[i];
+
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
@@ -1314,12 +1321,13 @@ static void virtio_snd_unrealize(DeviceState *dev)
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
index fce7d1feea2..41c63b3f23b 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -136,7 +136,6 @@ struct VirtIOSoundPCM {
 struct VirtIOSoundPCMStream {
     virtio_snd_pcm_info info;
     virtio_snd_pcm_set_params params;
-    uint32_t id;
     /* channel position values (VIRTIO_SND_CHMAP_XXX) */
     uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
     VirtIOSound *s;
@@ -214,6 +213,7 @@ struct VirtIOSound {
     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
     uint64_t features;
     VirtIOSoundPCM pcm;
+    VirtIOSoundPCMStream *streams;
     AudioBackend *audio_be;
     VMChangeStateEntry *vmstate;
     virtio_snd_config snd_conf;
-- 
2.47.3


