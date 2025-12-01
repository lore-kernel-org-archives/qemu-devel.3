Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D75D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 11:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ22M-0004sU-Bn; Mon, 01 Dec 2025 06:25:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ229-0004DL-CP
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:25:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ21r-0006yV-8H
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:25:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764588314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MnZ8xf1jNhx3OIPoccDARGdVwIWeeUhhnCgaTBsALM4=;
 b=S6b2xynSLq0ZLB+smgFUdljcV3BibWjTwKKHARMYb4mCTH9kpKhQKtWPG7HHvimlPWQQ5w
 XS0XvWU4DMdrQLrFtUBHJcUjiLlkud8Ss6iNyeD+kuOx2opT/dqcmYQdU+GvZR8gCwpzUH
 hzocqaCvVtKMepM8amFj0rqSfbtais8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-vEZKrdhcPA6RphpM6xpnsA-1; Mon,
 01 Dec 2025 06:25:10 -0500
X-MC-Unique: vEZKrdhcPA6RphpM6xpnsA-1
X-Mimecast-MFC-AGG-ID: vEZKrdhcPA6RphpM6xpnsA_1764588308
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2A6F195608F; Mon,  1 Dec 2025 11:25:07 +0000 (UTC)
Received: from localhost (unknown [10.45.242.40])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 29DDA180035F; Mon,  1 Dec 2025 11:25:04 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:Xilinx ZynqMP and...)
Subject: [RFC 17/24] audio: make all the backend-specific APIs take the be
Date: Mon,  1 Dec 2025 15:22:58 +0400
Message-ID: <20251201112309.4163921-18-marcandre.lureau@redhat.com>
In-Reply-To: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This will allow to dispatch to different implementations next.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_template.h       |  2 +-
 include/qemu/audio-capture.h |  9 ++++++---
 include/qemu/audio.h         | 30 +++++++++++++++---------------
 audio/audio.c                | 18 +++++++++---------
 audio/wavcapture.c           |  7 +++++--
 hw/audio/ac97.c              | 24 ++++++++++++------------
 hw/audio/adlib.c             |  9 +++++----
 hw/audio/asc.c               | 16 ++++++++--------
 hw/audio/cs4231a.c           | 16 ++++++++--------
 hw/audio/es1370.c            | 12 ++++++------
 hw/audio/gus.c               |  9 +++++----
 hw/audio/hda-codec.c         | 16 ++++++++--------
 hw/audio/lm4549.c            | 12 ++++++------
 hw/audio/pcspk.c             |  4 ++--
 hw/audio/sb16.c              | 14 +++++++-------
 hw/audio/via-ac97.c          | 14 +++++++-------
 hw/audio/virtio-snd.c        | 14 ++++++++------
 hw/audio/wm8750.c            | 24 ++++++++++++------------
 hw/display/xlnx_dp.c         | 10 +++++-----
 hw/usb/dev-audio.c           | 12 ++++++------
 ui/vnc.c                     |  2 +-
 21 files changed, 142 insertions(+), 132 deletions(-)

diff --git a/audio/audio_template.h b/audio/audio_template.h
index 7d204d25bc..8d66f9cd40 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -569,7 +569,7 @@ SW *glue (AUD_open_, TYPE) (
     return NULL;
 }
 
-bool glue(AUD_is_active_, TYPE)(SW *sw)
+bool glue(AUD_is_active_, TYPE)(AudioBackend *be, SW *sw)
 {
     return sw ? sw->active : 0;
 }
diff --git a/include/qemu/audio-capture.h b/include/qemu/audio-capture.h
index a07412db85..f500b0a7f8 100644
--- a/include/qemu/audio-capture.h
+++ b/include/qemu/audio-capture.h
@@ -36,8 +36,11 @@ CaptureVoiceOut *AUD_add_capture(
     AudioBackend *be,
     struct audsettings *as,
     struct audio_capture_ops *ops,
-    void *opaque
-    );
-void AUD_del_capture (CaptureVoiceOut *cap, void *cb_opaque);
+    void *opaque);
+
+void AUD_del_capture(
+    AudioBackend *be,
+    CaptureVoiceOut *cap,
+    void *cb_opaque);
 
 #endif /* QEMU_AUDIO_CAPTURE_H */
diff --git a/include/qemu/audio.h b/include/qemu/audio.h
index 07a2e23998..745ee881b8 100644
--- a/include/qemu/audio.h
+++ b/include/qemu/audio.h
@@ -67,7 +67,7 @@ typedef struct QEMUAudioTimeStamp {
 
 bool AUD_backend_check(AudioBackend **be, Error **errp);
 
-SWVoiceOut *AUD_open_out (
+SWVoiceOut *AUD_open_out(
     AudioBackend *be,
     SWVoiceOut *sw,
     const char *name,
@@ -76,11 +76,11 @@ SWVoiceOut *AUD_open_out (
     struct audsettings *settings
     );
 
-void AUD_close_out (AudioBackend *be, SWVoiceOut *sw);
-size_t AUD_write (SWVoiceOut *sw, void *pcm_buf, size_t size);
-int  AUD_get_buffer_size_out (SWVoiceOut *sw);
-void AUD_set_active_out(SWVoiceOut *sw, bool on);
-bool AUD_is_active_out(SWVoiceOut *sw);
+void AUD_close_out(AudioBackend *be, SWVoiceOut *sw);
+size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *pcm_buf, size_t size);
+int  AUD_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw);
+void AUD_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on);
+bool AUD_is_active_out(AudioBackend *be, SWVoiceOut *sw);
 
 #define AUDIO_MAX_CHANNELS 16
 typedef struct Volume {
@@ -89,19 +89,19 @@ typedef struct Volume {
     uint8_t vol[AUDIO_MAX_CHANNELS];
 } Volume;
 
-void AUD_set_volume_out(SWVoiceOut *sw, Volume *vol);
-void AUD_set_volume_in(SWVoiceIn *sw, Volume *vol);
+void AUD_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol);
+void AUD_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol);
 
 static inline void
-AUD_set_volume_out_lr(SWVoiceOut *sw, bool mut, uint8_t lvol, uint8_t rvol) {
-    AUD_set_volume_out(sw, &(Volume) {
+AUD_set_volume_out_lr(AudioBackend *be, SWVoiceOut *sw, bool mut, uint8_t lvol, uint8_t rvol) {
+    AUD_set_volume_out(be, sw, &(Volume) {
         .mute = mut, .channels = 2, .vol = { lvol, rvol }
     });
 }
 
 static inline void
-AUD_set_volume_in_lr(SWVoiceIn *sw, bool mut, uint8_t lvol, uint8_t rvol) {
-    AUD_set_volume_in(sw, &(Volume) {
+AUD_set_volume_in_lr(AudioBackend *be, SWVoiceIn *sw, bool mut, uint8_t lvol, uint8_t rvol) {
+    AUD_set_volume_in(be, sw, &(Volume) {
         .mute = mut, .channels = 2, .vol = { lvol, rvol }
     });
 }
@@ -116,9 +116,9 @@ SWVoiceIn *AUD_open_in(
     );
 
 void AUD_close_in(AudioBackend *be, SWVoiceIn *sw);
-size_t AUD_read (SWVoiceIn *sw, void *pcm_buf, size_t size);
-void AUD_set_active_in(SWVoiceIn *sw, bool on);
-bool AUD_is_active_in(SWVoiceIn *sw);
+size_t AUD_read(AudioBackend *be, SWVoiceIn *sw, void *pcm_buf, size_t size);
+void AUD_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on);
+bool AUD_is_active_in(AudioBackend *be, SWVoiceIn *sw);
 
 void audio_cleanup(void);
 
diff --git a/audio/audio.c b/audio/audio.c
index f0e31ce4a0..cc65153dfa 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -846,7 +846,7 @@ static void audio_timer (void *opaque)
 /*
  * Public API
  */
-size_t AUD_write(SWVoiceOut *sw, void *buf, size_t size)
+size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t size)
 {
     HWVoiceOut *hw;
 
@@ -868,7 +868,7 @@ size_t AUD_write(SWVoiceOut *sw, void *buf, size_t size)
     }
 }
 
-size_t AUD_read(SWVoiceIn *sw, void *buf, size_t size)
+size_t AUD_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size)
 {
     HWVoiceIn *hw;
 
@@ -890,7 +890,7 @@ size_t AUD_read(SWVoiceIn *sw, void *buf, size_t size)
     }
 }
 
-int AUD_get_buffer_size_out(SWVoiceOut *sw)
+int AUD_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
 {
     if (!sw) {
         return 0;
@@ -903,7 +903,7 @@ int AUD_get_buffer_size_out(SWVoiceOut *sw)
     return sw->hw->samples * sw->hw->info.bytes_per_frame;
 }
 
-void AUD_set_active_out(SWVoiceOut *sw, bool on)
+void AUD_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on)
 {
     HWVoiceOut *hw;
 
@@ -951,7 +951,7 @@ void AUD_set_active_out(SWVoiceOut *sw, bool on)
     }
 }
 
-void AUD_set_active_in(SWVoiceIn *sw, bool on)
+void AUD_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
 {
     HWVoiceIn *hw;
 
@@ -996,7 +996,7 @@ void AUD_set_active_in(SWVoiceIn *sw, bool on)
     }
 }
 
-static size_t audio_get_avail (SWVoiceIn *sw)
+static size_t audio_get_avail(SWVoiceIn *sw)
 {
     size_t live;
 
@@ -1938,7 +1938,7 @@ CaptureVoiceOut *AUD_add_capture(
     return cap;
 }
 
-void AUD_del_capture (CaptureVoiceOut *cap, void *cb_opaque)
+void AUD_del_capture(AudioBackend *be, CaptureVoiceOut *cap, void *cb_opaque)
 {
     struct capture_callback *cb;
 
@@ -1977,7 +1977,7 @@ void AUD_del_capture (CaptureVoiceOut *cap, void *cb_opaque)
     }
 }
 
-void AUD_set_volume_out(SWVoiceOut *sw, Volume *vol)
+void AUD_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol)
 {
     if (sw) {
         HWVoiceOut *hw = sw->hw;
@@ -1993,7 +1993,7 @@ void AUD_set_volume_out(SWVoiceOut *sw, Volume *vol)
     }
 }
 
-void AUD_set_volume_in(SWVoiceIn *sw, Volume *vol)
+void AUD_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol)
 {
     if (sw) {
         HWVoiceIn *hw = sw->hw;
diff --git a/audio/wavcapture.c b/audio/wavcapture.c
index b33a38ff45..2950ceaf24 100644
--- a/audio/wavcapture.c
+++ b/audio/wavcapture.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "qemu/audio.h"
 #include "qemu/qemu-print.h"
 #include "qemu/error-report.h"
 #include "audio_int.h"
@@ -10,6 +11,7 @@ typedef struct {
     int freq;
     int bits;
     int nchannels;
+    AudioBackend *audio_be;
     CaptureVoiceOut *cap;
 } WAVState;
 
@@ -84,7 +86,7 @@ static void wav_capture_destroy (void *opaque)
 {
     WAVState *wav = opaque;
 
-    AUD_del_capture (wav->cap, wav);
+    AUD_del_capture(wav->audio_be, wav->cap, wav);
     g_free (wav);
 }
 
@@ -159,6 +161,7 @@ int wav_start_capture(AudioBackend *state, CaptureState *s, const char *path,
         return -1;
     }
 
+    wav->audio_be = state;
     wav->path = g_strdup (path);
     wav->bits = bits;
     wav->nchannels = nchannels;
@@ -169,7 +172,7 @@ int wav_start_capture(AudioBackend *state, CaptureState *s, const char *path,
         goto error_free;
     }
 
-    cap = AUD_add_capture(state, &as, &ops, wav);
+    cap = AUD_add_capture(wav->audio_be, &as, &ops, wav);
     if (!cap) {
         error_report("Failed to add audio capture");
         goto error_free;
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 60daa62ea3..e9a1daf92a 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -246,15 +246,15 @@ static void voice_set_active(AC97LinkState *s, int bm_index, int on)
 {
     switch (bm_index) {
     case PI_INDEX:
-        AUD_set_active_in(s->voice_pi, on);
+        AUD_set_active_in(s->audio_be, s->voice_pi, on);
         break;
 
     case PO_INDEX:
-        AUD_set_active_out(s->voice_po, on);
+        AUD_set_active_out(s->audio_be, s->voice_po, on);
         break;
 
     case MC_INDEX:
-        AUD_set_active_in(s->voice_mc, on);
+        AUD_set_active_in(s->audio_be, s->voice_mc, on);
         break;
 
     default:
@@ -378,15 +378,15 @@ static void reset_voices(AC97LinkState *s, uint8_t active[LAST_INDEX])
 
     freq = mixer_load(s, AC97_PCM_LR_ADC_Rate);
     open_voice(s, PI_INDEX, freq);
-    AUD_set_active_in(s->voice_pi, active[PI_INDEX]);
+    AUD_set_active_in(s->audio_be, s->voice_pi, active[PI_INDEX]);
 
     freq = mixer_load(s, AC97_PCM_Front_DAC_Rate);
     open_voice(s, PO_INDEX, freq);
-    AUD_set_active_out(s->voice_po, active[PO_INDEX]);
+    AUD_set_active_out(s->audio_be, s->voice_po, active[PO_INDEX]);
 
     freq = mixer_load(s, AC97_MIC_ADC_Rate);
     open_voice(s, MC_INDEX, freq);
-    AUD_set_active_in(s->voice_mc, active[MC_INDEX]);
+    AUD_set_active_in(s->audio_be, s->voice_mc, active[MC_INDEX]);
 }
 
 static void get_volume(uint16_t vol, uint16_t mask, int inverse,
@@ -416,7 +416,7 @@ static void update_combined_volume_out(AC97LinkState *s)
     lvol = (lvol * plvol) / 255;
     rvol = (rvol * prvol) / 255;
 
-    AUD_set_volume_out_lr(s->voice_po, mute, lvol, rvol);
+    AUD_set_volume_out_lr(s->audio_be, s->voice_po, mute, lvol, rvol);
 }
 
 static void update_volume_in(AC97LinkState *s)
@@ -427,7 +427,7 @@ static void update_volume_in(AC97LinkState *s)
     get_volume(mixer_load(s, AC97_Record_Gain_Mute), 0x0f, 0,
                &mute, &lvol, &rvol);
 
-    AUD_set_volume_in_lr(s->voice_pi, mute, lvol, rvol);
+    AUD_set_volume_in_lr(s->audio_be, s->voice_pi, mute, lvol, rvol);
 }
 
 static void set_volume(AC97LinkState *s, int index, uint32_t val)
@@ -904,7 +904,7 @@ static int write_audio(AC97LinkState *s, AC97BusMasterRegs *r,
         int copied;
         to_copy = MIN(temp, sizeof(tmpbuf));
         pci_dma_read(&s->dev, addr, tmpbuf, to_copy);
-        copied = AUD_write(s->voice_po, tmpbuf, to_copy);
+        copied = AUD_write(s->audio_be, s->voice_po, tmpbuf, to_copy);
         dolog("write_audio max=%x to_copy=%x copied=%x",
               max, to_copy, copied);
         if (!copied) {
@@ -948,7 +948,7 @@ static void write_bup(AC97LinkState *s, int elapsed)
     while (elapsed) {
         int temp = MIN(elapsed, sizeof(s->silence));
         while (temp) {
-            int copied = AUD_write(s->voice_po, s->silence, temp);
+            int copied = AUD_write(s->audio_be, s->voice_po, s->silence, temp);
             if (!copied) {
                 return;
             }
@@ -978,7 +978,7 @@ static int read_audio(AC97LinkState *s, AC97BusMasterRegs *r,
     while (temp) {
         int acquired;
         to_copy = MIN(temp, sizeof(tmpbuf));
-        acquired = AUD_read(voice, tmpbuf, to_copy);
+        acquired = AUD_read(s->audio_be, voice, tmpbuf, to_copy);
         if (!acquired) {
             *stop = 1;
             break;
@@ -1275,7 +1275,7 @@ static void ac97_realize(PCIDevice *dev, Error **errp)
     AC97LinkState *s = AC97(dev);
     uint8_t *c = s->dev.config;
 
-    if (!AUD_backend_check (&s->audio_be, errp)) {
+    if (!AUD_backend_check(&s->audio_be, errp)) {
         return;
     }
 
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index 2a2fe7d04f..d3677c1d7f 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -96,7 +96,7 @@ static void adlib_write(void *opaque, uint32_t nport, uint32_t val)
     int a = nport & 3;
 
     s->active = 1;
-    AUD_set_active_out (s->voice, 1);
+    AUD_set_active_out(s->audio_be, s->voice, 1);
 
     adlib_kill_timers (s);
 
@@ -145,7 +145,8 @@ static int write_audio (AdlibState *s, int samples)
         int nbytes, wbytes, wsampl;
 
         nbytes = samples << SHIFT;
-        wbytes = AUD_write (
+        wbytes = AUD_write(
+            s->audio_be,
             s->voice,
             s->mixbuf + (pos << (SHIFT - 1)),
             nbytes
@@ -257,7 +258,7 @@ static void adlib_realizefn (DeviceState *dev, Error **errp)
     as.fmt = AUDIO_FORMAT_S16;
     as.endianness = HOST_BIG_ENDIAN;
 
-    s->voice = AUD_open_out (
+    s->voice = AUD_open_out(
         s->audio_be,
         s->voice,
         "adlib",
@@ -271,7 +272,7 @@ static void adlib_realizefn (DeviceState *dev, Error **errp)
         return;
     }
 
-    s->samples = AUD_get_buffer_size_out (s->voice) >> SHIFT;
+    s->samples = AUD_get_buffer_size_out(s->audio_be, s->voice) >> SHIFT;
     s->mixbuf = g_malloc0 (s->samples << SHIFT);
 
     adlib_portio_list[0].offset = s->port;
diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index 0abb106979..c7bb40df83 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -355,12 +355,12 @@ static void asc_out_cb(void *opaque, int free_b)
              * loop because the FIFO has run out of data, and the driver
              * reuses the stale content in its circular audio buffer.
              */
-            AUD_write(s->voice, s->silentbuf, samples << s->shift);
+            AUD_write(s->audio_be, s->voice, s->silentbuf, samples << s->shift);
         }
         return;
     }
 
-    AUD_write(s->voice, s->mixbuf, generated << s->shift);
+    AUD_write(s->audio_be, s->voice, s->mixbuf, generated << s->shift);
 }
 
 static uint64_t asc_fifo_read(void *opaque, hwaddr addr,
@@ -470,9 +470,9 @@ static void asc_write(void *opaque, hwaddr addr, uint64_t value,
             asc_fifo_reset(&s->fifos[1]);
             asc_lower_irq(s);
             if (value != 0) {
-                AUD_set_active_out(s->voice, 1);
+                AUD_set_active_out(s->audio_be, s->voice, 1);
             } else {
-                AUD_set_active_out(s->voice, 0);
+                AUD_set_active_out(s->audio_be, s->voice, 0);
             }
         }
         break;
@@ -489,7 +489,7 @@ static void asc_write(void *opaque, hwaddr addr, uint64_t value,
         {
             int vol = (value & 0xe0);
 
-            AUD_set_volume_out_lr(s->voice, 0, vol, vol);
+            AUD_set_volume_out_lr(s->audio_be, s->voice, 0, vol, vol);
             break;
         }
     }
@@ -545,7 +545,7 @@ static int asc_post_load(void *opaque, int version)
     ASCState *s = ASC(opaque);
 
     if (s->regs[ASC_MODE] != 0) {
-        AUD_set_active_out(s->voice, 1);
+        AUD_set_active_out(s->audio_be, s->voice, 1);
     }
 
     return 0;
@@ -614,7 +614,7 @@ static void asc_reset_hold(Object *obj, ResetType type)
 {
     ASCState *s = ASC(obj);
 
-    AUD_set_active_out(s->voice, 0);
+    AUD_set_active_out(s->audio_be, s->voice, 0);
 
     memset(s->regs, 0, sizeof(s->regs));
     asc_fifo_reset(&s->fifos[0]);
@@ -658,7 +658,7 @@ static void asc_realize(DeviceState *dev, Error **errp)
     }
 
     s->shift = 1;
-    s->samples = AUD_get_buffer_size_out(s->voice) >> s->shift;
+    s->samples = AUD_get_buffer_size_out(s->audio_be, s->voice) >> s->shift;
     s->mixbuf = g_malloc0(s->samples << s->shift);
 
     s->silentbuf = g_malloc(s->samples << s->shift);
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 98fdbc5b72..ff68a9ccd9 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -327,7 +327,7 @@ static void cs_reset_voices (CSState *s, uint32_t val)
         goto error;
     }
 
-    s->voice = AUD_open_out (
+    s->voice = AUD_open_out(
         s->audio_be,
         s->voice,
         "cs4231a",
@@ -339,7 +339,7 @@ static void cs_reset_voices (CSState *s, uint32_t val)
     if (s->dregs[Interface_Configuration] & PEN) {
         if (!s->dma_running) {
             k->hold_DREQ(s->isa_dma, s->dma);
-            AUD_set_active_out (s->voice, 1);
+            AUD_set_active_out(s->audio_be, s->voice, 1);
             s->transferred = 0;
         }
         s->dma_running = 1;
@@ -347,7 +347,7 @@ static void cs_reset_voices (CSState *s, uint32_t val)
     else {
         if (s->dma_running) {
             k->release_DREQ(s->isa_dma, s->dma);
-            AUD_set_active_out (s->voice, 0);
+            AUD_set_active_out(s->audio_be, s->voice, 0);
         }
         s->dma_running = 0;
     }
@@ -356,7 +356,7 @@ static void cs_reset_voices (CSState *s, uint32_t val)
  error:
     if (s->dma_running) {
         k->release_DREQ(s->isa_dma, s->dma);
-        AUD_set_active_out (s->voice, 0);
+        AUD_set_active_out(s->audio_be, s->voice, 0);
     }
 }
 
@@ -465,7 +465,7 @@ static void cs_write (void *opaque, hwaddr addr,
                 if (s->dma_running) {
                     IsaDmaClass *k = ISADMA_GET_CLASS(s->isa_dma);
                     k->release_DREQ(s->isa_dma, s->dma);
-                    AUD_set_active_out (s->voice, 0);
+                    AUD_set_active_out(s->audio_be, s->voice, 0);
                     s->dma_running = 0;
                 }
             }
@@ -551,11 +551,11 @@ static int cs_write_audio (CSState *s, int nchan, int dma_pos,
 
             for (i = 0; i < copied; ++i)
                 linbuf[i] = s->tab[tmpbuf[i]];
-            copied = AUD_write (s->voice, linbuf, copied << 1);
+            copied = AUD_write(s->audio_be, s->voice, linbuf, copied << 1);
             copied >>= 1;
         }
         else {
-            copied = AUD_write (s->voice, tmpbuf, copied);
+            copied = AUD_write(s->audio_be, s->voice, tmpbuf, copied);
         }
 
         temp -= copied;
@@ -614,7 +614,7 @@ static int cs4231a_pre_load (void *opaque)
     if (s->dma_running) {
         IsaDmaClass *k = ISADMA_GET_CLASS(s->isa_dma);
         k->release_DREQ(s->isa_dma, s->dma);
-        AUD_set_active_out (s->voice, 0);
+        AUD_set_active_out(s->audio_be, s->voice, 0);
     }
     s->dma_running = 0;
     return 0;
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 9873ffadab..0422cf9836 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -411,7 +411,7 @@ static void es1370_update_voices (ES1370State *s, uint32_t ctl, uint32_t sctl)
 
                 if (i == ADC_CHANNEL) {
                     s->adc_voice =
-                        AUD_open_in (
+                        AUD_open_in(
                             s->audio_be,
                             s->adc_voice,
                             "es1370.adc",
@@ -421,7 +421,7 @@ static void es1370_update_voices (ES1370State *s, uint32_t ctl, uint32_t sctl)
                             );
                 } else {
                     s->dac_voice[i] =
-                        AUD_open_out (
+                        AUD_open_out(
                             s->audio_be,
                             s->dac_voice[i],
                             i ? "es1370.dac2" : "es1370.dac1",
@@ -438,9 +438,9 @@ static void es1370_update_voices (ES1370State *s, uint32_t ctl, uint32_t sctl)
             int on = (ctl & b->ctl_en) && !(sctl & b->sctl_pause);
 
             if (i == ADC_CHANNEL) {
-                AUD_set_active_in (s->adc_voice, on);
+                AUD_set_active_in(s->audio_be, s->adc_voice, on);
             } else {
-                AUD_set_active_out (s->dac_voice[i], on);
+                AUD_set_active_out(s->audio_be, s->dac_voice[i], on);
             }
         }
     }
@@ -627,7 +627,7 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
             int acquired, to_copy;
 
             to_copy = MIN(to_transfer, sizeof(tmpbuf));
-            acquired = AUD_read (s->adc_voice, tmpbuf, to_copy);
+            acquired = AUD_read(s->audio_be, s->adc_voice, tmpbuf, to_copy);
             if (!acquired) {
                 break;
             }
@@ -646,7 +646,7 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
 
             to_copy = MIN(to_transfer, sizeof(tmpbuf));
             pci_dma_read (&s->dev, addr, tmpbuf, to_copy);
-            copied = AUD_write (voice, tmpbuf, to_copy);
+            copied = AUD_write(s->audio_be, voice, tmpbuf, to_copy);
             if (!copied) {
                 break;
             }
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index 68f89e994c..df069a19fc 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -87,7 +87,8 @@ static int write_audio (GUSState *s, int samples)
         int nbytes, wbytes, wsampl;
 
         nbytes = samples << s->shift;
-        wbytes = AUD_write (
+        wbytes = AUD_write(
+            s->audio_be,
             s->voice,
             s->mixbuf + (pos << (s->shift - 1)),
             nbytes
@@ -257,7 +258,7 @@ static void gus_realizefn (DeviceState *dev, Error **errp)
     as.fmt = AUDIO_FORMAT_S16;
     as.endianness = HOST_BIG_ENDIAN;
 
-    s->voice = AUD_open_out (
+    s->voice = AUD_open_out(
         s->audio_be,
         NULL,
         "gus",
@@ -272,7 +273,7 @@ static void gus_realizefn (DeviceState *dev, Error **errp)
     }
 
     s->shift = 2;
-    s->samples = AUD_get_buffer_size_out (s->voice) >> s->shift;
+    s->samples = AUD_get_buffer_size_out(s->audio_be, s->voice) >> s->shift;
     s->mixbuf = g_malloc0 (s->samples << s->shift);
 
     isa_register_portio_list(d, &s->portio_list1, s->port,
@@ -287,7 +288,7 @@ static void gus_realizefn (DeviceState *dev, Error **errp)
     s->emu.opaque = s;
     s->pic = isa_bus_get_irq(bus, s->emu.gusirq);
 
-    AUD_set_active_out (s->voice, 1);
+    AUD_set_active_out(s->audio_be, s->voice, 1);
 }
 
 static const Property gus_properties[] = {
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index e90c9de046..1daa2c25c5 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -275,7 +275,7 @@ static void hda_audio_input_cb(void *opaque, int avail)
     while (to_transfer) {
         uint32_t start = (uint32_t) (wpos & B_MASK);
         uint32_t chunk = (uint32_t) MIN(B_SIZE - start, to_transfer);
-        uint32_t read = AUD_read(st->voice.in, st->buf + start, chunk);
+        uint32_t read = AUD_read(st->state->audio_be, st->voice.in, st->buf + start, chunk);
         wpos += read;
         to_transfer -= read;
         st->wpos += read;
@@ -354,7 +354,7 @@ static void hda_audio_output_cb(void *opaque, int avail)
     while (to_transfer) {
         uint32_t start = (uint32_t) (rpos & B_MASK);
         uint32_t chunk = (uint32_t) MIN(B_SIZE - start, to_transfer);
-        uint32_t written = AUD_write(st->voice.out, st->buf + start, chunk);
+        uint32_t written = AUD_write(st->state->audio_be, st->voice.out, st->buf + start, chunk);
         rpos += written;
         to_transfer -= written;
         st->rpos += written;
@@ -375,7 +375,7 @@ static void hda_audio_compat_input_cb(void *opaque, int avail)
 
     while (avail - recv >= sizeof(st->compat_buf)) {
         if (st->compat_bpos != sizeof(st->compat_buf)) {
-            len = AUD_read(st->voice.in, st->compat_buf + st->compat_bpos,
+            len = AUD_read(st->state->audio_be, st->voice.in, st->compat_buf + st->compat_bpos,
                            sizeof(st->compat_buf) - st->compat_bpos);
             st->compat_bpos += len;
             recv += len;
@@ -408,7 +408,7 @@ static void hda_audio_compat_output_cb(void *opaque, int avail)
             }
             st->compat_bpos = 0;
         }
-        len = AUD_write(st->voice.out, st->compat_buf + st->compat_bpos,
+        len = AUD_write(st->state->audio_be, st->voice.out, st->compat_buf + st->compat_bpos,
                         sizeof(st->compat_buf) - st->compat_bpos);
         st->compat_bpos += len;
         sent += len;
@@ -440,9 +440,9 @@ static void hda_audio_set_running(HDAAudioStream *st, bool running)
         }
     }
     if (st->output) {
-        AUD_set_active_out(st->voice.out, st->running);
+        AUD_set_active_out(st->state->audio_be, st->voice.out, st->running);
     } else {
-        AUD_set_active_in(st->voice.in, st->running);
+        AUD_set_active_in(st->state->audio_be, st->voice.in, st->running);
     }
 }
 
@@ -466,9 +466,9 @@ static void hda_audio_set_amp(HDAAudioStream *st)
         return;
     }
     if (st->output) {
-        AUD_set_volume_out_lr(st->voice.out, muted, left, right);
+        AUD_set_volume_out_lr(st->state->audio_be, st->voice.out, muted, left, right);
     } else {
-        AUD_set_volume_in_lr(st->voice.in, muted, left, right);
+        AUD_set_volume_in_lr(st->state->audio_be, st->voice.in, muted, left, right);
     }
 }
 
diff --git a/hw/audio/lm4549.c b/hw/audio/lm4549.c
index bf711c49c0..4adf67f967 100644
--- a/hw/audio/lm4549.c
+++ b/hw/audio/lm4549.c
@@ -101,11 +101,11 @@ static void lm4549_audio_transfer(lm4549_state *s)
     uint32_t i;
 
     /* Activate the voice */
-    AUD_set_active_out(s->voice, 1);
+    AUD_set_active_out(s->audio_be, s->voice, 1);
     s->voice_is_active = 1;
 
     /* Try to write the buffer content */
-    written_bytes = AUD_write(s->voice, s->buffer,
+    written_bytes = AUD_write(s->audio_be, s->voice, s->buffer,
                               s->buffer_level * sizeof(uint16_t));
     written_samples = written_bytes >> 1;
 
@@ -129,14 +129,14 @@ static void lm4549_audio_out_callback(void *opaque, int free)
     static uint32_t prev_buffer_level;
 
 #ifdef LM4549_DEBUG
-    int size = AUD_get_buffer_size_out(s->voice);
+    int size = AUD_get_buffer_size_out(s->audio_be, s->voice);
     DPRINTF("audio_out_callback size = %i free = %i\n", size, free);
 #endif
 
     /* Detect that no data are consumed
        => disable the voice */
     if (s->buffer_level == prev_buffer_level) {
-        AUD_set_active_out(s->voice, 0);
+        AUD_set_active_out(s->audio_be, s->voice, 0);
         s->voice_is_active = 0;
     }
     prev_buffer_level = s->buffer_level;
@@ -285,7 +285,7 @@ static int lm4549_post_load(void *opaque, int version_id)
 
     /* Request data */
     if (s->voice_is_active == 1) {
-        lm4549_audio_out_callback(s, AUD_get_buffer_size_out(s->voice));
+        lm4549_audio_out_callback(s, AUD_get_buffer_size_out(s->audio_be, s->voice));
     }
 
     return 0;
@@ -323,7 +323,7 @@ void lm4549_init(lm4549_state *s, lm4549_callback data_req_cb, void* opaque,
         &as
     );
 
-    AUD_set_volume_out_lr(s->voice, 0, 255, 255);
+    AUD_set_volume_out_lr(s->audio_be, s->voice, 0, 255, 255);
 
     s->voice_is_active = 0;
 
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 916c56fa4c..a74a263b37 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -106,7 +106,7 @@ static void pcspk_callback(void *opaque, int free)
 
     while (free > 0) {
         n = MIN(s->samples - s->play_pos, (unsigned int)free);
-        n = AUD_write(s->voice, &s->sample_buf[s->play_pos], n);
+        n = AUD_write(s->audio_be, s->voice, &s->sample_buf[s->play_pos], n);
         if (!n)
             break;
         s->play_pos = (s->play_pos + n) % s->samples;
@@ -164,7 +164,7 @@ static void pcspk_io_write(void *opaque, hwaddr addr, uint64_t val,
     if (s->voice) {
         if (gate) /* restart */
             s->play_pos = 0;
-        AUD_set_active_out(s->voice, gate & s->data_on);
+        AUD_set_active_out(s->audio_be, s->voice, gate & s->data_on);
     }
 }
 
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 1e3c4caf5e..47b36dfc69 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -185,11 +185,11 @@ static void control (SB16State *s, int hold)
 
     if (hold) {
         k->hold_DREQ(isa_dma, dma);
-        AUD_set_active_out (s->voice, 1);
+        AUD_set_active_out(s->audio_be, s->voice, 1);
     }
     else {
         k->release_DREQ(isa_dma, dma);
-        AUD_set_active_out (s->voice, 0);
+        AUD_set_active_out(s->audio_be, s->voice, 0);
     }
 }
 
@@ -215,7 +215,7 @@ static void continue_dma8 (SB16State *s)
         as.fmt = s->fmt;
         as.endianness = 0;
 
-        s->voice = AUD_open_out (
+        s->voice = AUD_open_out(
             s->audio_be,
             s->voice,
             "sb16",
@@ -378,7 +378,7 @@ static void dma_cmd (SB16State *s, uint8_t cmd, uint8_t d0, int dma_len)
         as.fmt = s->fmt;
         as.endianness = 0;
 
-        s->voice = AUD_open_out (
+        s->voice = AUD_open_out(
             s->audio_be,
             s->voice,
             "sb16",
@@ -879,7 +879,7 @@ static void legacy_reset (SB16State *s)
     as.fmt = AUDIO_FORMAT_U8;
     as.endianness = 0;
 
-    s->voice = AUD_open_out (
+    s->voice = AUD_open_out(
         s->audio_be,
         s->voice,
         "sb16",
@@ -1196,7 +1196,7 @@ static int write_audio (SB16State *s, int nchan, int dma_pos,
         }
 
         copied = k->read_memory(isa_dma, nchan, tmpbuf, dma_pos, to_copy);
-        copied = AUD_write (s->voice, tmpbuf, copied);
+        copied = AUD_write(s->audio_be, s->voice, tmpbuf, copied);
 
         temp -= copied;
         dma_pos = (dma_pos + copied) % dma_len;
@@ -1302,7 +1302,7 @@ static int sb16_post_load (void *opaque, int version_id)
             as.fmt = s->fmt;
             as.endianness = 0;
 
-            s->voice = AUD_open_out (
+            s->voice = AUD_open_out(
                 s->audio_be,
                 s->voice,
                 "sb16",
diff --git a/hw/audio/via-ac97.c b/hw/audio/via-ac97.c
index 019d296853..5b344d7a0f 100644
--- a/hw/audio/via-ac97.c
+++ b/hw/audio/via-ac97.c
@@ -53,7 +53,7 @@ static void codec_volume_set_out(ViaAC97State *s)
     rvol /= 255;
     mute = CODEC_REG(s, AC97_Master_Volume_Mute) >> MUTE_SHIFT;
     mute |= CODEC_REG(s, AC97_PCM_Out_Volume_Mute) >> MUTE_SHIFT;
-    AUD_set_volume_out_lr(s->vo, mute, lvol, rvol);
+    AUD_set_volume_out_lr(s->audio_be, s->vo, mute, lvol, rvol);
 }
 
 static void codec_reset(ViaAC97State *s)
@@ -189,7 +189,7 @@ static void out_cb(void *opaque, int avail)
         while (temp) {
             to_copy = MIN(temp, sizeof(tmpbuf));
             pci_dma_read(&s->dev, c->addr, tmpbuf, to_copy);
-            copied = AUD_write(s->vo, tmpbuf, to_copy);
+            copied = AUD_write(s->audio_be, s->vo, tmpbuf, to_copy);
             if (!copied) {
                 stop = true;
                 break;
@@ -208,7 +208,7 @@ static void out_cb(void *opaque, int avail)
                     c->stat |= STAT_PAUSED;
                 } else {
                     c->stat &= ~STAT_ACTIVE;
-                    AUD_set_active_out(s->vo, 0);
+                    AUD_set_active_out(s->audio_be, s->vo, 0);
                 }
                 if (c->type & STAT_EOL) {
                     via_isa_set_irq(&s->dev, 0, 1);
@@ -317,20 +317,20 @@ static void sgd_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
         break;
     case 1:
         if (val & CNTL_START) {
-            AUD_set_active_out(s->vo, 1);
+            AUD_set_active_out(s->audio_be, s->vo, 1);
             s->aur.stat = STAT_ACTIVE;
         }
         if (val & CNTL_TERM) {
-            AUD_set_active_out(s->vo, 0);
+            AUD_set_active_out(s->audio_be, s->vo, 0);
             s->aur.stat &= ~(STAT_ACTIVE | STAT_PAUSED);
             s->aur.clen = 0;
         }
         if (val & CNTL_PAUSE) {
-            AUD_set_active_out(s->vo, 0);
+            AUD_set_active_out(s->audio_be, s->vo, 0);
             s->aur.stat &= ~STAT_ACTIVE;
             s->aur.stat |= STAT_PAUSED;
         } else if (!(val & CNTL_PAUSE) && (s->aur.stat & STAT_PAUSED)) {
-            AUD_set_active_out(s->vo, 1);
+            AUD_set_active_out(s->audio_be, s->vo, 1);
             s->aur.stat |= STAT_ACTIVE;
             s->aur.stat &= ~STAT_PAUSED;
         }
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 9101560f38..47fef61af8 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -463,7 +463,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
                                          stream,
                                          virtio_snd_pcm_out_cb,
                                          &as);
-        AUD_set_volume_out_lr(stream->voice.out, 0, 255, 255);
+        AUD_set_volume_out_lr(s->audio_be, stream->voice.out, 0, 255, 255);
     } else {
         stream->voice.in = AUD_open_in(s->audio_be,
                                         stream->voice.in,
@@ -471,7 +471,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
                                         stream,
                                         virtio_snd_pcm_in_cb,
                                         &as);
-        AUD_set_volume_in_lr(stream->voice.in, 0, 255, 255);
+        AUD_set_volume_in_lr(s->audio_be, stream->voice.in, 0, 255, 255);
     }
 
     return cpu_to_le32(VIRTIO_SND_S_OK);
@@ -561,9 +561,9 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
             stream->active = start;
         }
         if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
-            AUD_set_active_out(stream->voice.out, start);
+            AUD_set_active_out(s->audio_be, stream->voice.out, start);
         } else {
-            AUD_set_active_in(stream->voice.in, start);
+            AUD_set_active_in(s->audio_be, stream->voice.in, start);
         }
     } else {
         error_report("Invalid stream id: %"PRIu32, stream_id);
@@ -1166,7 +1166,8 @@ static void virtio_snd_pcm_out_cb(void *data, int available)
                 buffer->populated = true;
             }
             for (;;) {
-                size = AUD_write(stream->voice.out,
+                size = AUD_write(stream->s->audio_be,
+                                 stream->voice.out,
                                  buffer->data + buffer->offset,
                                  MIN(buffer->size, available));
                 assert(size <= MIN(buffer->size, available));
@@ -1258,7 +1259,8 @@ static void virtio_snd_pcm_in_cb(void *data, int available)
                     return_rx_buffer(stream, buffer);
                     break;
                 }
-                size = AUD_read(stream->voice.in,
+                size = AUD_read(stream->s->audio_be,
+                        stream->voice.in,
                         buffer->data + buffer->size,
                         MIN(available, (stream->params.period_bytes -
                                         buffer->size)));
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index 336fb6d20b..bc347fe537 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -72,7 +72,7 @@ static inline void wm8750_in_load(WM8750State *s)
     if (s->idx_in + s->req_in <= sizeof(s->data_in))
         return;
     s->idx_in = MAX(0, (int) sizeof(s->data_in) - s->req_in);
-    AUD_read(*s->in[0], s->data_in + s->idx_in,
+    AUD_read(s->audio_be, *s->in[0], s->data_in + s->idx_in,
              sizeof(s->data_in) - s->idx_in);
 }
 
@@ -80,7 +80,7 @@ static inline void wm8750_out_flush(WM8750State *s)
 {
     int sent = 0;
     while (sent < s->idx_out)
-        sent += AUD_write(*s->out[0], s->data_out + sent, s->idx_out - sent)
+        sent += AUD_write(s->audio_be, *s->out[0], s->data_out + sent, s->idx_out - sent)
                 ?: s->idx_out;
     s->idx_out = 0;
 }
@@ -145,30 +145,30 @@ static void wm8750_vol_update(WM8750State *s)
 {
     /* FIXME: multiply all volumes by s->invol[2], s->invol[3] */
 
-    AUD_set_volume_in_lr(s->adc_voice[0], s->mute,
+    AUD_set_volume_in_lr(s->audio_be, s->adc_voice[0], s->mute,
                     s->inmute[0] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[0]),
                     s->inmute[1] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[1]));
-    AUD_set_volume_in_lr(s->adc_voice[1], s->mute,
+    AUD_set_volume_in_lr(s->audio_be, s->adc_voice[1], s->mute,
                     s->inmute[0] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[0]),
                     s->inmute[1] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[1]));
-    AUD_set_volume_in_lr(s->adc_voice[2], s->mute,
+    AUD_set_volume_in_lr(s->audio_be, s->adc_voice[2], s->mute,
                     s->inmute[0] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[0]),
                     s->inmute[1] ? 0 : WM8750_INVOL_TRANSFORM(s->invol[1]));
 
     /* FIXME: multiply all volumes by s->outvol[0], s->outvol[1] */
 
     /* Speaker: LOUT2VOL ROUT2VOL */
-    AUD_set_volume_out_lr(s->dac_voice[0], s->mute,
+    AUD_set_volume_out_lr(s->audio_be, s->dac_voice[0], s->mute,
                     s->outmute[0] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[4]),
                     s->outmute[1] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[5]));
 
     /* Headphone: LOUT1VOL ROUT1VOL */
-    AUD_set_volume_out_lr(s->dac_voice[1], s->mute,
+    AUD_set_volume_out_lr(s->audio_be, s->dac_voice[1], s->mute,
                     s->outmute[0] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[2]),
                     s->outmute[1] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[3]));
 
     /* MONOOUT: MONOVOL MONOVOL */
-    AUD_set_volume_out_lr(s->dac_voice[2], s->mute,
+    AUD_set_volume_out_lr(s->audio_be, s->dac_voice[2], s->mute,
                     s->outmute[0] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[6]),
                     s->outmute[1] ? 0 : WM8750_OUTVOL_TRANSFORM(s->outvol[6]));
 }
@@ -182,9 +182,9 @@ static void wm8750_set_format(WM8750State *s)
     wm8750_out_flush(s);
 
     if (s->in[0] && *s->in[0])
-        AUD_set_active_in(*s->in[0], 0);
+        AUD_set_active_in(s->audio_be, *s->in[0], 0);
     if (s->out[0] && *s->out[0])
-        AUD_set_active_out(*s->out[0], 0);
+        AUD_set_active_out(s->audio_be, *s->out[0], 0);
 
     for (i = 0; i < IN_PORT_N; i ++)
         if (s->adc_voice[i]) {
@@ -235,9 +235,9 @@ static void wm8750_set_format(WM8750State *s)
      * for mixing or combining paths to different ports, so we
      * connect both channels to where the left channel is routed.  */
     if (s->in[0] && *s->in[0])
-        AUD_set_active_in(*s->in[0], 1);
+        AUD_set_active_in(s->audio_be, *s->in[0], 1);
     if (s->out[0] && *s->out[0])
-        AUD_set_active_out(*s->out[0], 1);
+        AUD_set_active_out(s->audio_be, *s->out[0], 1);
 }
 
 static void wm8750_clk_update(WM8750State *s, int ext)
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index a248b943a5..e89f1ffaf6 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -331,7 +331,7 @@ static inline void xlnx_dp_audio_activate(XlnxDPState *s)
 {
     bool activated = ((s->core_registers[DP_TX_AUDIO_CONTROL]
                    & DP_TX_AUD_CTRL) != 0);
-    AUD_set_active_out(s->amixer_output_stream, activated);
+    AUD_set_active_out(s->audio_be, s->amixer_output_stream, activated);
     xlnx_dpdma_set_host_data_location(s->dpdma, DP_AUDIO_DMA_CHANNEL(0),
                                       &s->audio_buffer_0);
     xlnx_dpdma_set_host_data_location(s->dpdma, DP_AUDIO_DMA_CHANNEL(1),
@@ -401,7 +401,7 @@ static void xlnx_dp_audio_callback(void *opaque, int avail)
     /* Send the buffer through the audio. */
     if (s->byte_left <= MAX_QEMU_BUFFER_SIZE) {
         if (s->byte_left != 0) {
-            written = AUD_write(s->amixer_output_stream,
+            written = AUD_write(s->audio_be, s->amixer_output_stream,
                                 &s->out_buffer[s->data_ptr], s->byte_left);
         } else {
              int len_to_copy;
@@ -413,12 +413,12 @@ static void xlnx_dp_audio_callback(void *opaque, int avail)
             while (avail) {
                 len_to_copy = MIN(AUD_CHBUF_MAX_DEPTH, avail);
                 memset(s->out_buffer, 0, len_to_copy);
-                avail -= AUD_write(s->amixer_output_stream, s->out_buffer,
+                avail -= AUD_write(s->audio_be, s->amixer_output_stream, s->out_buffer,
                                    len_to_copy);
             }
         }
     } else {
-        written = AUD_write(s->amixer_output_stream,
+        written = AUD_write(s->audio_be, s->amixer_output_stream,
                             &s->out_buffer[s->data_ptr], MAX_QEMU_BUFFER_SIZE);
     }
     s->byte_left -= written;
@@ -1401,7 +1401,7 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
                                            s,
                                            xlnx_dp_audio_callback,
                                            &as);
-    AUD_set_volume_out_lr(s->amixer_output_stream, 0, 255, 255);
+    AUD_set_volume_out_lr(s->audio_be, s->amixer_output_stream, 0, 255, 255);
     xlnx_dp_audio_activate(s);
     s->vblank = ptimer_init(vblank_hit, s, DP_VBLANK_PTIMER_POLICY);
     ptimer_transaction_begin(s->vblank);
diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index 8dd9d26599..189fd1df26 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -669,7 +669,7 @@ static void output_callback(void *opaque, int avail)
             return;
         }
 
-        written = AUD_write(s->out.voice, data, len);
+        written = AUD_write(s->audio_be, s->out.voice, data, len);
         avail -= written;
         s->out.buf.cons += written;
 
@@ -683,7 +683,7 @@ static int usb_audio_set_output_altset(USBAudioState *s, int altset)
 {
     switch (altset) {
     case ALTSET_OFF:
-        AUD_set_active_out(s->out.voice, false);
+        AUD_set_active_out(s->audio_be, s->out.voice, false);
         break;
     case ALTSET_STEREO:
     case ALTSET_51:
@@ -692,7 +692,7 @@ static int usb_audio_set_output_altset(USBAudioState *s, int altset)
             usb_audio_reinit(USB_DEVICE(s), altset_channels[altset]);
         }
         streambuf_init(&s->out.buf, s->buffer, s->out.channels);
-        AUD_set_active_out(s->out.voice, true);
+        AUD_set_active_out(s->audio_be, s->out.voice, true);
         break;
     default:
         return -1;
@@ -805,7 +805,7 @@ static int usb_audio_set_control(USBAudioState *s, uint8_t attrib,
             }
             fprintf(stderr, "\n");
         }
-        AUD_set_volume_out(s->out.voice, &s->out.vol);
+        AUD_set_volume_out(s->audio_be, s->out.voice, &s->out.vol);
     }
 
     return ret;
@@ -980,8 +980,8 @@ static void usb_audio_reinit(USBDevice *dev, unsigned channels)
 
     s->out.voice = AUD_open_out(s->audio_be, s->out.voice, TYPE_USB_AUDIO,
                                 s, output_callback, &s->out.as);
-    AUD_set_volume_out(s->out.voice, &s->out.vol);
-    AUD_set_active_out(s->out.voice, 0);
+    AUD_set_volume_out(s->audio_be, s->out.voice, &s->out.vol);
+    AUD_set_active_out(s->audio_be, s->out.voice, 0);
 }
 
 static const VMStateDescription vmstate_usb_audio = {
diff --git a/ui/vnc.c b/ui/vnc.c
index 0d499b208b..5c8af65202 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1286,7 +1286,7 @@ static void audio_add(VncState *vs)
 static void audio_del(VncState *vs)
 {
     if (vs->audio_cap) {
-        AUD_del_capture(vs->audio_cap, vs);
+        AUD_del_capture(vs->vd->audio_be, vs->audio_cap, vs);
         vs->audio_cap = NULL;
     }
 }
-- 
2.51.1


