Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1D5C2D0CB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 05:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFRPm-00068a-0F; Thu, 15 May 2025 01:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1uFRPV-0005eP-95
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:45:37 -0400
Received: from mailout11.t-online.de ([194.25.134.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1uFRPT-00006n-47
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:45:36 -0400
Received: from fwd83.aul.t-online.de (fwd83.aul.t-online.de [10.223.144.109])
 by mailout11.t-online.de (Postfix) with SMTP id 91A89147A;
 Thu, 15 May 2025 07:44:46 +0200 (CEST)
Received: from linpower.localnet ([84.175.230.13]) by fwd83.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1uFROe-2G3OOf0; Thu, 15 May 2025 07:44:44 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id 78E6E2006D0; Thu, 15 May 2025 07:44:29 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 7/7] audio: add float sample endianness converters
Date: Thu, 15 May 2025 07:44:29 +0200
Message-ID: <20250515054429.7385-7-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0bb1a55e-70f1-410b-8b59-78eed7f4c8f7@t-online.de>
References: <0bb1a55e-70f1-410b-8b59-78eed7f4c8f7@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1747287884-7EA2A5E4-A66AE5F8/0/0 CLEAN NORMAL
X-TOI-MSGID: 3af5b955-3819-4479-82ad-dcb9ccf90b85
Received-SPF: pass client-ip=194.25.134.85;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout11.t-online.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit ed2a4a7941 ("audio: proper support for float samples in
mixeng") added support for float audio samples. As there were no
audio frontend devices with float support at that time, the code
was limited to native endian float samples.

When nobody was paying attention, an audio device that supports
floating point samples crept in with commit eb9ad377bb
("virtio-sound: handle control messages and streams").

Add code for the audio subsystem to convert float samples to the
correct endianness.

The type punning code was taken from the PipeWire project.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 audio/audio.c          |  3 +-
 audio/audio_template.h | 12 ++++---
 audio/mixeng.c         | 75 ++++++++++++++++++++++++++++++++++++++----
 audio/mixeng.h         |  6 ++--
 4 files changed, 82 insertions(+), 14 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 3f5baf0cc6..b58ad74433 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1892,7 +1892,8 @@ CaptureVoiceOut *AUD_add_capture(
         cap->buf = g_malloc0_n(hw->mix_buf.size, hw->info.bytes_per_frame);
 
         if (hw->info.is_float) {
-            hw->clip = mixeng_clip_float[hw->info.nchannels == 2];
+            hw->clip = mixeng_clip_float[hw->info.nchannels == 2]
+                [hw->info.swap_endianness];
         } else {
             hw->clip = mixeng_clip
                 [hw->info.nchannels == 2]
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 7ccfec0116..c29d79c443 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -174,9 +174,11 @@ static int glue (audio_pcm_sw_init_, TYPE) (
 
     if (sw->info.is_float) {
 #ifdef DAC
-        sw->conv = mixeng_conv_float[sw->info.nchannels == 2];
+        sw->conv = mixeng_conv_float[sw->info.nchannels == 2]
+            [sw->info.swap_endianness];
 #else
-        sw->clip = mixeng_clip_float[sw->info.nchannels == 2];
+        sw->clip = mixeng_clip_float[sw->info.nchannels == 2]
+            [sw->info.swap_endianness];
 #endif
     } else {
 #ifdef DAC
@@ -303,9 +305,11 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioState *s,
 
     if (hw->info.is_float) {
 #ifdef DAC
-        hw->clip = mixeng_clip_float[hw->info.nchannels == 2];
+        hw->clip = mixeng_clip_float[hw->info.nchannels == 2]
+            [hw->info.swap_endianness];
 #else
-        hw->conv = mixeng_conv_float[hw->info.nchannels == 2];
+        hw->conv = mixeng_conv_float[hw->info.nchannels == 2]
+            [hw->info.swap_endianness];
 #endif
     } else {
 #ifdef DAC
diff --git a/audio/mixeng.c b/audio/mixeng.c
index 13e1ff9b08..703ee5448f 100644
--- a/audio/mixeng.c
+++ b/audio/mixeng.c
@@ -283,6 +283,11 @@ static const float float_scale_reciprocal = 1.f / ((int64_t)INT32_MAX + 1);
 #endif
 #endif
 
+#define F32_TO_F32S(v) \
+    bswap32((union { uint32_t i; float f; }){ .f = (v) }.i)
+#define F32S_TO_F32(v) \
+    ((union { uint32_t i; float f; }){ .i = bswap32(v) }.f)
+
 static void conv_natural_float_to_mono(struct st_sample *dst, const void *src,
                                        int samples)
 {
@@ -294,6 +299,17 @@ static void conv_natural_float_to_mono(struct st_sample *dst, const void *src,
     }
 }
 
+static void conv_swap_float_to_mono(struct st_sample *dst, const void *src,
+                                    int samples)
+{
+    const uint32_t *in_f32s = src;
+
+    while (samples--) {
+        dst->r = dst->l = CONV_NATURAL_FLOAT(F32S_TO_F32(*in_f32s++));
+        dst++;
+    }
+}
+
 static void conv_natural_float_to_stereo(struct st_sample *dst, const void *src,
                                          int samples)
 {
@@ -306,9 +322,27 @@ static void conv_natural_float_to_stereo(struct st_sample *dst, const void *src,
     }
 }
 
-t_sample *mixeng_conv_float[2] = {
-    conv_natural_float_to_mono,
-    conv_natural_float_to_stereo,
+static void conv_swap_float_to_stereo(struct st_sample *dst, const void *src,
+                                      int samples)
+{
+    const uint32_t *in_f32s = src;
+
+    while (samples--) {
+        dst->l = CONV_NATURAL_FLOAT(F32S_TO_F32(*in_f32s++));
+        dst->r = CONV_NATURAL_FLOAT(F32S_TO_F32(*in_f32s++));
+        dst++;
+    }
+}
+
+t_sample *mixeng_conv_float[2][2] = {
+    {
+        conv_natural_float_to_mono,
+        conv_swap_float_to_mono,
+    },
+    {
+        conv_natural_float_to_stereo,
+        conv_swap_float_to_stereo,
+    }
 };
 
 static void clip_natural_float_from_mono(void *dst, const struct st_sample *src,
@@ -322,6 +356,17 @@ static void clip_natural_float_from_mono(void *dst, const struct st_sample *src,
     }
 }
 
+static void clip_swap_float_from_mono(void *dst, const struct st_sample *src,
+                                      int samples)
+{
+    uint32_t *out_f32s = dst;
+
+    while (samples--) {
+        *out_f32s++ = F32_TO_F32S(CLIP_NATURAL_FLOAT(src->l + src->r));
+        src++;
+    }
+}
+
 static void clip_natural_float_from_stereo(
     void *dst, const struct st_sample *src, int samples)
 {
@@ -334,9 +379,27 @@ static void clip_natural_float_from_stereo(
     }
 }
 
-f_sample *mixeng_clip_float[2] = {
-    clip_natural_float_from_mono,
-    clip_natural_float_from_stereo,
+static void clip_swap_float_from_stereo(
+    void *dst, const struct st_sample *src, int samples)
+{
+    uint32_t *out_f32s = dst;
+
+    while (samples--) {
+        *out_f32s++ = F32_TO_F32S(CLIP_NATURAL_FLOAT(src->l));
+        *out_f32s++ = F32_TO_F32S(CLIP_NATURAL_FLOAT(src->r));
+        src++;
+    }
+}
+
+f_sample *mixeng_clip_float[2][2] = {
+    {
+        clip_natural_float_from_mono,
+        clip_swap_float_from_mono,
+    },
+    {
+        clip_natural_float_from_stereo,
+        clip_swap_float_from_stereo,
+    }
 };
 
 void audio_sample_to_uint64(const void *samples, int pos,
diff --git a/audio/mixeng.h b/audio/mixeng.h
index a5f56d2c26..ead93ac2f7 100644
--- a/audio/mixeng.h
+++ b/audio/mixeng.h
@@ -42,9 +42,9 @@ typedef void (f_sample) (void *dst, const struct st_sample *src, int samples);
 extern t_sample *mixeng_conv[2][2][2][3];
 extern f_sample *mixeng_clip[2][2][2][3];
 
-/* indices: [stereo] */
-extern t_sample *mixeng_conv_float[2];
-extern f_sample *mixeng_clip_float[2];
+/* indices: [stereo][swap endianness] */
+extern t_sample *mixeng_conv_float[2][2];
+extern f_sample *mixeng_clip_float[2][2];
 
 void *st_rate_start (int inrate, int outrate);
 void st_rate_flow(void *opaque, st_sample *ibuf, st_sample *obuf,
-- 
2.43.0


