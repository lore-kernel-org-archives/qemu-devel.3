Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF4CE98E11
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 09:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuSbq-0004bk-Nl; Mon, 23 Feb 2026 04:52:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSaM-0002bV-Ew
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:50:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSaJ-0007NN-Ge
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771840234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iJi7oR34DgBP+jpHqeJxc7l5EOkuU6U9i1W56NnMyQI=;
 b=UgzLUoQf7tpiLEhg7QNv+S5TD9MOsvCaHqxS+OuU+DocDEvrNW8C8kkaYuRIpCd1QnAr6Y
 S2BJru1VUzt/ZfwxivEYXdair+NSRuuJb99KResl3/9mOtGaFBhm9bYe+KJakoiWlRAD6B
 884s/tP4nC4Wcay8lWgDBqefFxc+7/g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-1fdd7K2QPK-Xm4Ce5Dixkw-1; Mon,
 23 Feb 2026 04:50:30 -0500
X-MC-Unique: 1fdd7K2QPK-Xm4Ce5Dixkw-1
X-Mimecast-MFC-AGG-ID: 1fdd7K2QPK-Xm4Ce5Dixkw_1771840228
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56EA11956088; Mon, 23 Feb 2026 09:50:28 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC8CD1955F22; Mon, 23 Feb 2026 09:50:26 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>,
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 qemu-arm@nongnu.org (open list:Xilinx ZynqMP and...)
Subject: [PULL v2 73/85] audio: replace int endianness with bool big_endian in
 audsettings
Date: Mon, 23 Feb 2026 10:46:31 +0100
Message-ID: <20260223094649.2005118-74-marcandre.lureau@redhat.com>
In-Reply-To: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
References: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The endianness field used an int to represent a boolean concept, with
0 meaning little-endian and 1 meaning big-endian. This required runtime
validation to reject invalid values and made the code less readable.

Replace with a bool big_endian field that is self-documenting and
type-safe. The compiler now enforces valid values, eliminating the
need for the validation check in audio_validate_settings().

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/dsound_template.h  |  2 +-
 include/qemu/audio.h     |  2 +-
 audio/alsaaudio.c        |  8 ++++----
 audio/audio-mixeng-be.c  | 21 ++++-----------------
 audio/jackaudio.c        |  4 ++--
 audio/ossaudio.c         | 22 +++++++++++-----------
 audio/paaudio.c          | 22 +++++++++++-----------
 audio/pwaudio.c          | 30 +++++++++++++++---------------
 audio/sdlaudio.c         | 26 +++++++++++++-------------
 audio/sndioaudio.c       |  2 +-
 audio/spiceaudio.c       |  4 ++--
 audio/wavaudio.c         |  2 +-
 audio/wavcapture.c       |  2 +-
 hw/audio/ac97.c          |  2 +-
 hw/audio/adlib.c         |  2 +-
 hw/audio/asc.c           |  2 +-
 hw/audio/cs4231a.c       |  6 +++---
 hw/audio/es1370.c        |  2 +-
 hw/audio/gus.c           |  2 +-
 hw/audio/lm4549.c        |  6 +++---
 hw/audio/sb16.c          |  8 ++++----
 hw/audio/via-ac97.c      |  2 +-
 hw/audio/virtio-snd.c    |  2 +-
 hw/audio/wm8750.c        |  4 ++--
 hw/display/xlnx_dp.c     |  2 +-
 hw/usb/dev-audio.c       |  2 +-
 tests/audio/test-audio.c |  2 +-
 ui/vnc.c                 |  2 +-
 28 files changed, 90 insertions(+), 103 deletions(-)

diff --git a/audio/dsound_template.h b/audio/dsound_template.h
index af4019bcb34..f9761120875 100644
--- a/audio/dsound_template.h
+++ b/audio/dsound_template.h
@@ -244,7 +244,7 @@ static int dsound_init_out(HWVoiceOut *hw, struct audsettings *as)
     }
 
     ds->first_time = true;
-    obt_as.endianness = 0;
+    obt_as.big_endian = false;
     audio_pcm_init_info (&hw->info, &obt_as);
 
     if (bc.dwBufferBytes % hw->info.bytes_per_frame) {
diff --git a/include/qemu/audio.h b/include/qemu/audio.h
index 9e4566d60aa..cff8a334f36 100644
--- a/include/qemu/audio.h
+++ b/include/qemu/audio.h
@@ -38,7 +38,7 @@ typedef struct audsettings {
     int freq;
     int nchannels;
     AudioFormat fmt;
-    int endianness;
+    bool big_endian;
 } audsettings;
 
 typedef struct SWVoiceOut SWVoiceOut;
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 889240ad0c7..e2290ea814a 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -666,7 +666,7 @@ static int alsa_init_out(HWVoiceOut *hw, struct audsettings *as)
     struct audsettings obt_as;
     Audiodev *dev = hw->s->dev;
 
-    req.fmt = aud_to_alsafmt (as->fmt, as->endianness);
+    req.fmt = aud_to_alsafmt (as->fmt, as->big_endian);
     req.freq = as->freq;
     req.nchannels = as->nchannels;
 
@@ -677,7 +677,7 @@ static int alsa_init_out(HWVoiceOut *hw, struct audsettings *as)
     obt_as.freq = obt.freq;
     obt_as.nchannels = obt.nchannels;
     obt_as.fmt = obt.fmt;
-    obt_as.endianness = obt.endianness;
+    obt_as.big_endian = obt.endianness;
 
     audio_pcm_init_info (&hw->info, &obt_as);
     hw->samples = obt.samples;
@@ -752,7 +752,7 @@ static int alsa_init_in(HWVoiceIn *hw, struct audsettings *as)
     struct audsettings obt_as;
     Audiodev *dev = hw->s->dev;
 
-    req.fmt = aud_to_alsafmt (as->fmt, as->endianness);
+    req.fmt = aud_to_alsafmt (as->fmt, as->big_endian);
     req.freq = as->freq;
     req.nchannels = as->nchannels;
 
@@ -763,7 +763,7 @@ static int alsa_init_in(HWVoiceIn *hw, struct audsettings *as)
     obt_as.freq = obt.freq;
     obt_as.nchannels = obt.nchannels;
     obt_as.fmt = obt.fmt;
-    obt_as.endianness = obt.endianness;
+    obt_as.big_endian = obt.endianness;
 
     audio_pcm_init_info (&hw->info, &obt_as);
     hw->samples = obt.samples;
diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
index 931d5b206f2..d05202aabae 100644
--- a/audio/audio-mixeng-be.c
+++ b/audio/audio-mixeng-be.c
@@ -135,19 +135,7 @@ static void audio_print_settings (const struct audsettings *as)
         break;
     }
 
-    AUD_log (NULL, " endianness=");
-    switch (as->endianness) {
-    case 0:
-        AUD_log (NULL, "little");
-        break;
-    case 1:
-        AUD_log (NULL, "big");
-        break;
-    default:
-        AUD_log (NULL, "invalid");
-        break;
-    }
-    AUD_log (NULL, "\n");
+    AUD_log (NULL, " endianness=%s\n", as->big_endian ? "big" : "little");
 }
 
 static int audio_validate_settings (const struct audsettings *as)
@@ -155,7 +143,6 @@ static int audio_validate_settings (const struct audsettings *as)
     int invalid;
 
     invalid = as->nchannels < 1;
-    invalid |= as->endianness != 0 && as->endianness != 1;
 
     switch (as->fmt) {
     case AUDIO_FORMAT_S8:
@@ -180,7 +167,7 @@ static int audio_pcm_info_eq (struct audio_pcm_info *info, const struct audsetti
     return info->af == as->fmt
         && info->freq == as->freq
         && info->nchannels == as->nchannels
-        && info->swap_endianness == (as->endianness != HOST_BIG_ENDIAN);
+        && info->swap_endianness == (as->big_endian != HOST_BIG_ENDIAN);
 }
 
 void audio_pcm_init_info (struct audio_pcm_info *info, const struct audsettings *as)
@@ -190,7 +177,7 @@ void audio_pcm_init_info (struct audio_pcm_info *info, const struct audsettings
     info->nchannels = as->nchannels;
     info->bytes_per_frame = as->nchannels * audio_format_bits(as->fmt) / 8;
     info->bytes_per_second = info->freq * info->bytes_per_frame;
-    info->swap_endianness = (as->endianness != HOST_BIG_ENDIAN);
+    info->swap_endianness = (as->big_endian != HOST_BIG_ENDIAN);
 }
 
 void audio_pcm_info_clear_buf(struct audio_pcm_info *info, void *buf, int len)
@@ -1797,7 +1784,7 @@ audsettings audiodev_to_audsettings(AudiodevPerDirectionOptions *pdo)
         .freq = pdo->frequency,
         .nchannels = pdo->channels,
         .fmt = pdo->format,
-        .endianness = HOST_BIG_ENDIAN,
+        .big_endian = HOST_BIG_ENDIAN,
     };
 }
 
diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index a2f725a3232..d9ae8edc0e0 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -531,7 +531,7 @@ static int qjack_init_out(HWVoiceOut *hw, struct audsettings *as)
         .freq       = jo->c.freq,
         .nchannels  = jo->c.nchannels,
         .fmt        = AUDIO_FORMAT_F32,
-        .endianness = 0
+        .big_endian = false
     };
     audio_pcm_init_info(&hw->info, &os);
 
@@ -566,7 +566,7 @@ static int qjack_init_in(HWVoiceIn *hw, struct audsettings *as)
         .freq       = ji->c.freq,
         .nchannels  = ji->c.nchannels,
         .fmt        = AUDIO_FORMAT_F32,
-        .endianness = 0
+        .big_endian = false
     };
     audio_pcm_init_info(&hw->info, &is);
 
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 81f49f9a7e7..157979e84b4 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -160,36 +160,36 @@ static int aud_to_ossfmt(AudioFormat fmt, bool big_endian)
     }
 }
 
-static int oss_to_audfmt (int ossfmt, AudioFormat *fmt, int *endianness)
+static int oss_to_audfmt (int ossfmt, AudioFormat *fmt, bool *big_endian)
 {
     switch (ossfmt) {
     case AFMT_S8:
-        *endianness = 0;
+        *big_endian = false;
         *fmt = AUDIO_FORMAT_S8;
         break;
 
     case AFMT_U8:
-        *endianness = 0;
+        *big_endian = false;
         *fmt = AUDIO_FORMAT_U8;
         break;
 
     case AFMT_S16_LE:
-        *endianness = 0;
+        *big_endian = false;
         *fmt = AUDIO_FORMAT_S16;
         break;
 
     case AFMT_U16_LE:
-        *endianness = 0;
+        *big_endian = false;
         *fmt = AUDIO_FORMAT_U16;
         break;
 
     case AFMT_S16_BE:
-        *endianness = 1;
+        *big_endian = true;
         *fmt = AUDIO_FORMAT_S16;
         break;
 
     case AFMT_U16_BE:
-        *endianness = 1;
+        *big_endian = true;
         *fmt = AUDIO_FORMAT_U16;
         break;
 
@@ -475,7 +475,7 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as)
 
     oss->fd = -1;
 
-    req.fmt = aud_to_ossfmt (as->fmt, as->endianness);
+    req.fmt = aud_to_ossfmt (as->fmt, as->big_endian);
     req.freq = as->freq;
     req.nchannels = as->nchannels;
 
@@ -483,7 +483,7 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as)
         return -1;
     }
 
-    err = oss_to_audfmt(obt.fmt, &obt_as.fmt, &obt_as.endianness);
+    err = oss_to_audfmt(obt.fmt, &obt_as.fmt, &obt_as.big_endian);
     if (err) {
         oss_anal_close (&fd);
         return -1;
@@ -601,14 +601,14 @@ static int oss_init_in(HWVoiceIn *hw, struct audsettings *as)
 
     oss->fd = -1;
 
-    req.fmt = aud_to_ossfmt (as->fmt, as->endianness);
+    req.fmt = aud_to_ossfmt (as->fmt, as->big_endian);
     req.freq = as->freq;
     req.nchannels = as->nchannels;
     if (oss_open(1, &req, as, &obt, &fd, dev)) {
         return -1;
     }
 
-    err = oss_to_audfmt(obt.fmt, &obt_as.fmt, &obt_as.endianness);
+    err = oss_to_audfmt(obt.fmt, &obt_as.fmt, &obt_as.big_endian);
     if (err) {
         oss_anal_close (&fd);
         return -1;
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 1501b26386a..c9957105543 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -352,28 +352,28 @@ static pa_sample_format_t audfmt_to_pa(AudioFormat afmt, bool big_endian)
     return format;
 }
 
-static AudioFormat pa_to_audfmt (pa_sample_format_t fmt, int *endianness)
+static AudioFormat pa_to_audfmt (pa_sample_format_t fmt, bool *big_endian)
 {
     switch (fmt) {
     case PA_SAMPLE_U8:
         return AUDIO_FORMAT_U8;
     case PA_SAMPLE_S16BE:
-        *endianness = 1;
+        *big_endian = true;
         return AUDIO_FORMAT_S16;
     case PA_SAMPLE_S16LE:
-        *endianness = 0;
+        *big_endian = false;
         return AUDIO_FORMAT_S16;
     case PA_SAMPLE_S32BE:
-        *endianness = 1;
+        *big_endian = true;
         return AUDIO_FORMAT_S32;
     case PA_SAMPLE_S32LE:
-        *endianness = 0;
+        *big_endian = false;
         return AUDIO_FORMAT_S32;
     case PA_SAMPLE_FLOAT32BE:
-        *endianness = 1;
+        *big_endian = true;
         return AUDIO_FORMAT_F32;
     case PA_SAMPLE_FLOAT32LE:
-        *endianness = 0;
+        *big_endian = false;
         return AUDIO_FORMAT_F32;
     default:
         error_report("pulseaudio: Internal logic error: Bad pa_sample_format %d", fmt);
@@ -531,7 +531,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as)
     PAConnection *c = apa->conn;
 
     pa->g = apa;
-    ss.format = audfmt_to_pa (as->fmt, as->endianness);
+    ss.format = audfmt_to_pa (as->fmt, as->big_endian);
     ss.channels = as->nchannels;
     ss.rate = as->freq;
 
@@ -541,7 +541,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as)
     ba.maxlength = -1;
     ba.prebuf = -1;
 
-    obt_as.fmt = pa_to_audfmt (ss.format, &obt_as.endianness);
+    obt_as.fmt = pa_to_audfmt (ss.format, &obt_as.big_endian);
 
     pa->stream = qpa_simple_new (
         c,
@@ -582,7 +582,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as)
     PAConnection *c = apa->conn;
 
     pa->g = apa;
-    ss.format = audfmt_to_pa (as->fmt, as->endianness);
+    ss.format = audfmt_to_pa (as->fmt, as->big_endian);
     ss.channels = as->nchannels;
     ss.rate = as->freq;
 
@@ -592,7 +592,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as)
     ba.minreq = -1;
     ba.prebuf = -1;
 
-    obt_as.fmt = pa_to_audfmt (ss.format, &obt_as.endianness);
+    obt_as.fmt = pa_to_audfmt (ss.format, &obt_as.big_endian);
 
     pa->stream = qpa_simple_new (
         c,
diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index 6a80e5a333e..b70bf0c1353 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -365,7 +365,7 @@ audfmt_to_pw(AudioFormat fmt, bool big_endian)
 }
 
 static AudioFormat
-pw_to_audfmt(enum spa_audio_format fmt, int *endianness,
+pw_to_audfmt(enum spa_audio_format fmt, bool *big_endian,
              uint32_t *sample_size)
 {
     switch (fmt) {
@@ -377,43 +377,43 @@ pw_to_audfmt(enum spa_audio_format fmt, int *endianness,
         return AUDIO_FORMAT_U8;
     case SPA_AUDIO_FORMAT_S16_BE:
         *sample_size = 2;
-        *endianness = 1;
+        *big_endian = true;
         return AUDIO_FORMAT_S16;
     case SPA_AUDIO_FORMAT_S16_LE:
         *sample_size = 2;
-        *endianness = 0;
+        *big_endian = false;
         return AUDIO_FORMAT_S16;
     case SPA_AUDIO_FORMAT_U16_BE:
         *sample_size = 2;
-        *endianness = 1;
+        *big_endian = true;
         return AUDIO_FORMAT_U16;
     case SPA_AUDIO_FORMAT_U16_LE:
         *sample_size = 2;
-        *endianness = 0;
+        *big_endian = false;
         return AUDIO_FORMAT_U16;
     case SPA_AUDIO_FORMAT_S32_BE:
         *sample_size = 4;
-        *endianness = 1;
+        *big_endian = true;
         return AUDIO_FORMAT_S32;
     case SPA_AUDIO_FORMAT_S32_LE:
         *sample_size = 4;
-        *endianness = 0;
+        *big_endian = false;
         return AUDIO_FORMAT_S32;
     case SPA_AUDIO_FORMAT_U32_BE:
         *sample_size = 4;
-        *endianness = 1;
+        *big_endian = true;
         return AUDIO_FORMAT_U32;
     case SPA_AUDIO_FORMAT_U32_LE:
         *sample_size = 4;
-        *endianness = 0;
+        *big_endian = false;
         return AUDIO_FORMAT_U32;
     case SPA_AUDIO_FORMAT_F32_BE:
         *sample_size = 4;
-        *endianness = 1;
+        *big_endian = true;
         return AUDIO_FORMAT_F32;
     case SPA_AUDIO_FORMAT_F32_LE:
         *sample_size = 4;
-        *endianness = 0;
+        *big_endian = false;
         return AUDIO_FORMAT_F32;
     default:
         *sample_size = 1;
@@ -534,13 +534,13 @@ qpw_init_out(HWVoiceOut *hw, struct audsettings *as)
 
     pw_thread_loop_lock(c->thread_loop);
 
-    v->info.format = audfmt_to_pw(as->fmt, as->endianness);
+    v->info.format = audfmt_to_pw(as->fmt, as->big_endian);
     v->info.channels = as->nchannels;
     qpw_set_position(as->nchannels, v->info.position);
     v->info.rate = as->freq;
 
     obt_as.fmt =
-        pw_to_audfmt(v->info.format, &obt_as.endianness, &v->frame_size);
+        pw_to_audfmt(v->info.format, &obt_as.big_endian, &v->frame_size);
     v->frame_size *= as->nchannels;
 
     v->req = (uint64_t)AUDIO_MIXENG_BACKEND(c)->dev->timer_period * v->info.rate
@@ -581,13 +581,13 @@ qpw_init_in(HWVoiceIn *hw, struct audsettings *as)
 
     pw_thread_loop_lock(c->thread_loop);
 
-    v->info.format = audfmt_to_pw(as->fmt, as->endianness);
+    v->info.format = audfmt_to_pw(as->fmt, as->big_endian);
     v->info.channels = as->nchannels;
     qpw_set_position(as->nchannels, v->info.position);
     v->info.rate = as->freq;
 
     obt_as.fmt =
-        pw_to_audfmt(v->info.format, &obt_as.endianness, &v->frame_size);
+        pw_to_audfmt(v->info.format, &obt_as.big_endian, &v->frame_size);
     v->frame_size *= as->nchannels;
 
     /* call the function that creates a new stream for recording */
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index 5f332678209..936a3ed076d 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -96,56 +96,56 @@ static int aud_to_sdlfmt (AudioFormat fmt)
     }
 }
 
-static int sdl_to_audfmt(int sdlfmt, AudioFormat *fmt, int *endianness)
+static int sdl_to_audfmt(int sdlfmt, AudioFormat *fmt, bool *big_endian)
 {
     switch (sdlfmt) {
     case AUDIO_S8:
-        *endianness = 0;
+        *big_endian = false;
         *fmt = AUDIO_FORMAT_S8;
         break;
 
     case AUDIO_U8:
-        *endianness = 0;
+        *big_endian = false;
         *fmt = AUDIO_FORMAT_U8;
         break;
 
     case AUDIO_S16LSB:
-        *endianness = 0;
+        *big_endian = false;
         *fmt = AUDIO_FORMAT_S16;
         break;
 
     case AUDIO_U16LSB:
-        *endianness = 0;
+        *big_endian = false;
         *fmt = AUDIO_FORMAT_U16;
         break;
 
     case AUDIO_S16MSB:
-        *endianness = 1;
+        *big_endian = true;
         *fmt = AUDIO_FORMAT_S16;
         break;
 
     case AUDIO_U16MSB:
-        *endianness = 1;
+        *big_endian = true;
         *fmt = AUDIO_FORMAT_U16;
         break;
 
     case AUDIO_S32LSB:
-        *endianness = 0;
+        *big_endian = false;
         *fmt = AUDIO_FORMAT_S32;
         break;
 
     case AUDIO_S32MSB:
-        *endianness = 1;
+        *big_endian = true;
         *fmt = AUDIO_FORMAT_S32;
         break;
 
     case AUDIO_F32LSB:
-        *endianness = 0;
+        *big_endian = false;
         *fmt = AUDIO_FORMAT_F32;
         break;
 
     case AUDIO_F32MSB:
-        *endianness = 1;
+        *big_endian = true;
         *fmt = AUDIO_FORMAT_F32;
         break;
 
@@ -350,7 +350,7 @@ static int sdl_init_out(HWVoiceOut *hw, struct audsettings *as)
         return -1;
     }
 
-    err = sdl_to_audfmt(obt.format, &obt_as.fmt, &obt_as.endianness);
+    err = sdl_to_audfmt(obt.format, &obt_as.fmt, &obt_as.big_endian);
     if (err) {
         sdl_close_out(sdl);
         return -1;
@@ -406,7 +406,7 @@ static int sdl_init_in(HWVoiceIn *hw, audsettings *as)
         return -1;
     }
 
-    err = sdl_to_audfmt(obt.format, &obt_as.fmt, &obt_as.endianness);
+    err = sdl_to_audfmt(obt.format, &obt_as.fmt, &obt_as.big_endian);
     if (err) {
         sdl_close_in(sdl);
         return -1;
diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
index 766eceeeefe..761f23f8273 100644
--- a/audio/sndioaudio.c
+++ b/audio/sndioaudio.c
@@ -387,7 +387,7 @@ static int sndio_init(SndioVoice *self,
     }
 
     if (req.bits > 8) {
-        req.le = as->endianness ? 0 : 1;
+        req.le = !as->big_endian;
     }
 
     req.rate = as->freq;
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 81b897e13e0..f903ef77e72 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -106,7 +106,7 @@ static int line_out_init(HWVoiceOut *hw, struct audsettings *as)
 #endif
     settings.nchannels  = SPICE_INTERFACE_PLAYBACK_CHAN;
     settings.fmt        = AUDIO_FORMAT_S16;
-    settings.endianness = HOST_BIG_ENDIAN;
+    settings.big_endian = HOST_BIG_ENDIAN;
 
     audio_pcm_init_info (&hw->info, &settings);
     hw->samples = LINE_OUT_SAMPLES;
@@ -222,7 +222,7 @@ static int line_in_init(HWVoiceIn *hw, struct audsettings *as)
 #endif
     settings.nchannels  = SPICE_INTERFACE_RECORD_CHAN;
     settings.fmt        = AUDIO_FORMAT_S16;
-    settings.endianness = HOST_BIG_ENDIAN;
+    settings.big_endian = HOST_BIG_ENDIAN;
 
     audio_pcm_init_info (&hw->info, &settings);
     hw->samples = LINE_IN_SAMPLES;
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index eed1e501af0..55d12d6cdfd 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -111,7 +111,7 @@ static int wav_init_out(HWVoiceOut *hw, struct audsettings *as)
 
     hdr[34] = bits16 ? 0x10 : 0x08;
 
-    wav_as.endianness = 0;
+    wav_as.big_endian = false;
     audio_pcm_init_info (&hw->info, &wav_as);
 
     hw->samples = 1024;
diff --git a/audio/wavcapture.c b/audio/wavcapture.c
index 69aa91e35f6..2dac9461710 100644
--- a/audio/wavcapture.c
+++ b/audio/wavcapture.c
@@ -137,7 +137,7 @@ int wav_start_capture(AudioBackend *state, CaptureState *s, const char *path,
     as.freq = freq;
     as.nchannels = 1 << stereo;
     as.fmt = bits16 ? AUDIO_FORMAT_S16 : AUDIO_FORMAT_U8;
-    as.endianness = 0;
+    as.big_endian = false;
 
     ops.notify = wav_notify;
     ops.capture = wav_capture;
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 5d442b7e067..fd74c249949 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -313,7 +313,7 @@ static void open_voice(AC97LinkState *s, int index, int freq)
     as.freq = freq;
     as.nchannels = 2;
     as.fmt = AUDIO_FORMAT_S16;
-    as.endianness = 0;
+    as.big_endian = false;
 
     if (freq > 0) {
         s->invalid_freq[index] = 0;
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index ce17e21d5fd..52ee5cb6256 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -254,7 +254,7 @@ static void adlib_realizefn (DeviceState *dev, Error **errp)
     as.freq = s->freq;
     as.nchannels = SHIFT;
     as.fmt = AUDIO_FORMAT_S16;
-    as.endianness = HOST_BIG_ENDIAN;
+    as.big_endian = HOST_BIG_ENDIAN;
 
     s->voice = audio_be_open_out(
         s->audio_be,
diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index 35c7b5750d6..ea59bdde7b8 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -648,7 +648,7 @@ static void asc_realize(DeviceState *dev, Error **errp)
     as.freq = ASC_FREQ;
     as.nchannels = 2;
     as.fmt = AUDIO_FORMAT_U8;
-    as.endianness = HOST_BIG_ENDIAN;
+    as.big_endian = HOST_BIG_ENDIAN;
 
     s->voice = audio_be_open_out(s->audio_be, s->voice, "asc.out", s, asc_out_cb,
                             &as);
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index e6cae9c988e..c589670e855 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -289,7 +289,7 @@ static void cs_reset_voices (CSState *s, uint32_t val)
     }
 
     as.nchannels = (val & (1 << 4)) ? 2 : 1;
-    as.endianness = 0;
+    as.big_endian = false;
     s->tab = NULL;
 
     switch ((val >> 5) & ((s->dregs[MODE_And_ID] & MODE2) ? 7 : 3)) {
@@ -305,12 +305,12 @@ static void cs_reset_voices (CSState *s, uint32_t val)
         s->tab = ALawDecompressTable;
     x_law:
         as.fmt = AUDIO_FORMAT_S16;
-        as.endianness = HOST_BIG_ENDIAN;
+        as.big_endian = HOST_BIG_ENDIAN;
         s->shift = as.nchannels == 2;
         break;
 
     case 6:
-        as.endianness = 1;
+        as.big_endian = true;
         /* fall through */
     case 2:
         as.fmt = AUDIO_FORMAT_S16;
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index e1658393c6a..ca7ad16df49 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -407,7 +407,7 @@ static void es1370_update_voices (ES1370State *s, uint32_t ctl, uint32_t sctl)
                 as.freq = new_freq;
                 as.nchannels = 1 << (new_fmt & 1);
                 as.fmt = (new_fmt & 2) ? AUDIO_FORMAT_S16 : AUDIO_FORMAT_U8;
-                as.endianness = 0;
+                as.big_endian = false;
 
                 if (i == ADC_CHANNEL) {
                     s->adc_voice =
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index 5c2a34c09d2..196c4f72205 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -256,7 +256,7 @@ static void gus_realizefn (DeviceState *dev, Error **errp)
     as.freq = s->freq;
     as.nchannels = 2;
     as.fmt = AUDIO_FORMAT_S16;
-    as.endianness = HOST_BIG_ENDIAN;
+    as.big_endian = HOST_BIG_ENDIAN;
 
     s->voice = audio_be_open_out(
         s->audio_be,
diff --git a/hw/audio/lm4549.c b/hw/audio/lm4549.c
index 14e15a844ba..a891e975106 100644
--- a/hw/audio/lm4549.c
+++ b/hw/audio/lm4549.c
@@ -202,7 +202,7 @@ void lm4549_write(lm4549_state *s,
         as.freq = value;
         as.nchannels = 2;
         as.fmt = AUDIO_FORMAT_S16;
-        as.endianness = 0;
+        as.big_endian = false;
 
         s->voice = audio_be_open_out(
             s->audio_be,
@@ -272,7 +272,7 @@ static int lm4549_post_load(void *opaque, int version_id)
     as.freq = freq;
     as.nchannels = 2;
     as.fmt = AUDIO_FORMAT_S16;
-    as.endianness = 0;
+    as.big_endian = false;
 
     s->voice = audio_be_open_out(
         s->audio_be,
@@ -312,7 +312,7 @@ void lm4549_init(lm4549_state *s, lm4549_callback data_req_cb, void* opaque,
     as.freq = 48000;
     as.nchannels = 2;
     as.fmt = AUDIO_FORMAT_S16;
-    as.endianness = 0;
+    as.big_endian = false;
 
     s->voice = audio_be_open_out(
         s->audio_be,
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index c8fc7df8b44..1b5e452a29b 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -213,7 +213,7 @@ static void continue_dma8 (SB16State *s)
         as.freq = s->freq;
         as.nchannels = 1 << s->fmt_stereo;
         as.fmt = s->fmt;
-        as.endianness = 0;
+        as.big_endian = false;
 
         s->voice = audio_be_open_out(
             s->audio_be,
@@ -376,7 +376,7 @@ static void dma_cmd (SB16State *s, uint8_t cmd, uint8_t d0, int dma_len)
         as.freq = s->freq;
         as.nchannels = 1 << s->fmt_stereo;
         as.fmt = s->fmt;
-        as.endianness = 0;
+        as.big_endian = false;
 
         s->voice = audio_be_open_out(
             s->audio_be,
@@ -877,7 +877,7 @@ static void legacy_reset (SB16State *s)
     as.freq = s->freq;
     as.nchannels = 1;
     as.fmt = AUDIO_FORMAT_U8;
-    as.endianness = 0;
+    as.big_endian = false;
 
     s->voice = audio_be_open_out(
         s->audio_be,
@@ -1300,7 +1300,7 @@ static int sb16_post_load (void *opaque, int version_id)
             as.freq = s->freq;
             as.nchannels = 1 << s->fmt_stereo;
             as.fmt = s->fmt;
-            as.endianness = 0;
+            as.big_endian = false;
 
             s->voice = audio_be_open_out(
                 s->audio_be,
diff --git a/hw/audio/via-ac97.c b/hw/audio/via-ac97.c
index 84d137b41a3..9d61283542a 100644
--- a/hw/audio/via-ac97.c
+++ b/hw/audio/via-ac97.c
@@ -237,7 +237,7 @@ static void open_voice_out(ViaAC97State *s)
         .freq = CODEC_REG(s, AC97_PCM_Front_DAC_Rate),
         .nchannels = s->aur.type & BIT(4) ? 2 : 1,
         .fmt = s->aur.type & BIT(5) ? AUDIO_FORMAT_S16 : AUDIO_FORMAT_S8,
-        .endianness = 0,
+        .big_endian = false,
     };
     s->vo = audio_be_open_out(s->audio_be, s->vo, "via-ac97.out", s, out_cb, &as);
 }
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 89e24c0a8e0..8b949146468 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -378,7 +378,7 @@ static void virtio_snd_get_qemu_audsettings(audsettings *as,
     as->nchannels = MIN(AUDIO_MAX_CHANNELS, params->channels);
     as->fmt = virtio_snd_get_qemu_format(params->format);
     as->freq = virtio_snd_get_qemu_freq(params->rate);
-    as->endianness = 0; /* Conforming to VIRTIO 1.0: always little endian. */
+    as->big_endian = false; /* Conforming to VIRTIO 1.0: always little endian. */
 }
 
 /*
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index 2a286515b14..e2507b0269a 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -202,7 +202,7 @@ static void wm8750_set_format(WM8750State *s)
         return;
 
     /* Setup input */
-    in_fmt.endianness = 0;
+    in_fmt.big_endian = false;
     in_fmt.nchannels = 2;
     in_fmt.freq = s->adc_hz;
     in_fmt.fmt = AUDIO_FORMAT_S16;
@@ -215,7 +215,7 @@ static void wm8750_set_format(WM8750State *s)
                     CODEC ".input3", s, wm8750_audio_in_cb, &in_fmt);
 
     /* Setup output */
-    out_fmt.endianness = 0;
+    out_fmt.big_endian = false;
     out_fmt.nchannels = 2;
     out_fmt.freq = s->dac_hz;
     out_fmt.fmt = AUDIO_FORMAT_S16;
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 9aa4709b411..7d037b46a35 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1393,7 +1393,7 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
     as.freq = 44100;
     as.nchannels = 2;
     as.fmt = AUDIO_FORMAT_S16;
-    as.endianness = 0;
+    as.big_endian = false;
 
     s->amixer_output_stream = audio_be_open_out(s->audio_be,
                                            s->amixer_output_stream,
diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index 7b758718c12..e18e0a1dfd6 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -975,7 +975,7 @@ static void usb_audio_reinit(USBDevice *dev, unsigned channels)
     s->out.as.freq       = USBAUDIO_SAMPLE_RATE;
     s->out.as.nchannels  = s->out.channels;
     s->out.as.fmt        = AUDIO_FORMAT_S16;
-    s->out.as.endianness = 0;
+    s->out.as.big_endian = false;
     streambuf_init(&s->out.buf, s->buffer, s->out.channels);
 
     s->out.voice = audio_be_open_out(s->audio_be, s->out.voice, TYPE_USB_AUDIO,
diff --git a/tests/audio/test-audio.c b/tests/audio/test-audio.c
index 90d96ae0575..b87a12eb55b 100644
--- a/tests/audio/test-audio.c
+++ b/tests/audio/test-audio.c
@@ -57,7 +57,7 @@ static const struct audsettings default_test_settings = {
     .freq = SAMPLE_RATE,
     .nchannels = CHANNELS,
     .fmt = AUDIO_FORMAT_S16,
-    .endianness = 0,
+    .big_endian = false,
 };
 
 static void dummy_audio_callback(void *opaque, int avail)
diff --git a/ui/vnc.c b/ui/vnc.c
index d56fe2c180e..daf5b01d342 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3372,7 +3372,7 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
     vs->as.freq = 44100;
     vs->as.nchannels = 2;
     vs->as.fmt = AUDIO_FORMAT_S16;
-    vs->as.endianness = 0;
+    vs->as.big_endian = false;
 
     qemu_mutex_init(&vs->output_mutex);
     vs->bh = qemu_bh_new(vnc_jobs_bh, vs);
-- 
2.53.0


