Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC43CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 15:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDOva-0004Tw-Vh; Mon, 27 Oct 2025 11:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vDOuo-0003Ri-OA
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:13:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vDOuY-0003x3-9H
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761578004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hy4r03TiVsWUDCEtGQ377AJr9mo6eZ99I30huexBd+o=;
 b=ec3QuFgbU5AJmUfqnnzqqrwmay2OLeh7+nl4q3wj7x357UtMU1F6jC87yWwXLNfQVTah74
 bduEMUkoqOef2iLQSqLLMzQ1/hS58AjoruqM/kIB1cxnex+AkPr9GRiOdxMIIZ5zYDYHd9
 YYsiBn+zVJnWqxCYSSOXv7opP8gnwu0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-DsO2r2GTNOaUEM264E1qjQ-1; Mon,
 27 Oct 2025 11:13:19 -0400
X-MC-Unique: DsO2r2GTNOaUEM264E1qjQ-1
X-Mimecast-MFC-AGG-ID: DsO2r2GTNOaUEM264E1qjQ_1761577996
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 760801956096; Mon, 27 Oct 2025 15:13:16 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 76B1330001A2; Mon, 27 Oct 2025 15:13:14 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Alexandre Ratchov <alex@caoua.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jan Kiszka <jan.kiszka@web.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 22/35] audio: remove AUDIO_HOST_ENDIANNESS
Date: Mon, 27 Oct 2025 19:10:29 +0400
Message-ID: <20251027151045.2863176-23-marcandre.lureau@redhat.com>
In-Reply-To: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 audio/audio.h      | 6 ------
 audio/audio.c      | 6 +++---
 audio/spiceaudio.c | 4 ++--
 hw/audio/adlib.c   | 2 +-
 hw/audio/asc.c     | 2 +-
 hw/audio/cs4231a.c | 2 +-
 hw/audio/gus.c     | 2 +-
 7 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index 3be0c4f24f..0af911fd9a 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -31,12 +31,6 @@
 
 typedef void (*audio_callback_fn) (void *opaque, int avail);
 
-#if HOST_BIG_ENDIAN
-#define AUDIO_HOST_ENDIANNESS 1
-#else
-#define AUDIO_HOST_ENDIANNESS 0
-#endif
-
 typedef struct audsettings {
     int freq;
     int nchannels;
diff --git a/audio/audio.c b/audio/audio.c
index f334030d96..18bc9188db 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -274,7 +274,7 @@ static int audio_pcm_info_eq (struct audio_pcm_info *info, struct audsettings *a
         && info->is_signed == is_signed
         && info->is_float == is_float
         && info->bits == bits
-        && info->swap_endianness == (as->endianness != AUDIO_HOST_ENDIANNESS);
+        && info->swap_endianness == (as->endianness != HOST_BIG_ENDIAN);
 }
 
 void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as)
@@ -320,7 +320,7 @@ void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as)
     info->nchannels = as->nchannels;
     info->bytes_per_frame = as->nchannels * mul;
     info->bytes_per_second = info->freq * info->bytes_per_frame;
-    info->swap_endianness = (as->endianness != AUDIO_HOST_ENDIANNESS);
+    info->swap_endianness = (as->endianness != HOST_BIG_ENDIAN);
 }
 
 void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len)
@@ -2179,7 +2179,7 @@ audsettings audiodev_to_audsettings(AudiodevPerDirectionOptions *pdo)
         .freq = pdo->frequency,
         .nchannels = pdo->channels,
         .fmt = pdo->format,
-        .endianness = AUDIO_HOST_ENDIANNESS,
+        .endianness = HOST_BIG_ENDIAN,
     };
 }
 
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 7f02f7285c..7e737bff9a 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -102,7 +102,7 @@ static int line_out_init(HWVoiceOut *hw, struct audsettings *as,
 #endif
     settings.nchannels  = SPICE_INTERFACE_PLAYBACK_CHAN;
     settings.fmt        = AUDIO_FORMAT_S16;
-    settings.endianness = AUDIO_HOST_ENDIANNESS;
+    settings.endianness = HOST_BIG_ENDIAN;
 
     audio_pcm_init_info (&hw->info, &settings);
     hw->samples = LINE_OUT_SAMPLES;
@@ -218,7 +218,7 @@ static int line_in_init(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
 #endif
     settings.nchannels  = SPICE_INTERFACE_RECORD_CHAN;
     settings.fmt        = AUDIO_FORMAT_S16;
-    settings.endianness = AUDIO_HOST_ENDIANNESS;
+    settings.endianness = HOST_BIG_ENDIAN;
 
     audio_pcm_init_info (&hw->info, &settings);
     hw->samples = LINE_IN_SAMPLES;
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index 6aae365f47..45c0a458f2 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -272,7 +272,7 @@ static void adlib_realizefn (DeviceState *dev, Error **errp)
     as.freq = s->freq;
     as.nchannels = SHIFT;
     as.fmt = AUDIO_FORMAT_S16;
-    as.endianness = AUDIO_HOST_ENDIANNESS;
+    as.endianness = HOST_BIG_ENDIAN;
 
     s->voice = AUD_open_out (
         &s->card,
diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index edd42d6d91..41472dc2e3 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -650,7 +650,7 @@ static void asc_realize(DeviceState *dev, Error **errp)
     as.freq = ASC_FREQ;
     as.nchannels = 2;
     as.fmt = AUDIO_FORMAT_U8;
-    as.endianness = AUDIO_HOST_ENDIANNESS;
+    as.endianness = HOST_BIG_ENDIAN;
 
     s->voice = AUD_open_out(&s->card, s->voice, "asc.out", s, asc_out_cb,
                             &as);
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 3b80a61378..0a5d614f8b 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -305,7 +305,7 @@ static void cs_reset_voices (CSState *s, uint32_t val)
         s->tab = ALawDecompressTable;
     x_law:
         as.fmt = AUDIO_FORMAT_S16;
-        as.endianness = AUDIO_HOST_ENDIANNESS;
+        as.endianness = HOST_BIG_ENDIAN;
         s->shift = as.nchannels == 2;
         break;
 
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index 45ea04bf89..d13a95eb5a 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -255,7 +255,7 @@ static void gus_realizefn (DeviceState *dev, Error **errp)
     as.freq = s->freq;
     as.nchannels = 2;
     as.fmt = AUDIO_FORMAT_S16;
-    as.endianness = AUDIO_HOST_ENDIANNESS;
+    as.endianness = HOST_BIG_ENDIAN;
 
     s->voice = AUD_open_out (
         &s->card,
-- 
2.51.0


