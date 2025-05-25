Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAA5C54FB3
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 13:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJBOL-0007Z9-BW; Sun, 25 May 2025 09:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uJBOI-0007YJ-Co
 for qemu-devel@nongnu.org; Sun, 25 May 2025 09:27:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uJBOG-0003MB-6C
 for qemu-devel@nongnu.org; Sun, 25 May 2025 09:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748179667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FBIR8jEV7umWJBJj66t3fKCqalHrQZeavnN66Mv4MRY=;
 b=cUISZEMfb0hJk5tAuYh1SdiOvzfa78+r7mfnuIn7TWZpEBBMpTs3rTgcdVziwW2rNyAMXB
 Odf/Z8RomkdJstrRA39vA+q2OJsF3QjV5N5wjmsMTKGDLHWqAU/6ODO2Nskuw3Vc7OmcM+
 MFd1L7RqfUZHzbmxN4VUpkH/tE6Xs5U=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-P90y0w1rOeebLNo7yUszsA-1; Sun,
 25 May 2025 09:27:44 -0400
X-MC-Unique: P90y0w1rOeebLNo7yUszsA-1
X-Mimecast-MFC-AGG-ID: P90y0w1rOeebLNo7yUszsA_1748179663
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47545195608A; Sun, 25 May 2025 13:27:43 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 36BF3195608D; Sun, 25 May 2025 13:27:41 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 7/9] audio: add float sample endianness converters
Date: Sun, 25 May 2025 15:27:14 +0200
Message-ID: <20250525132717.527392-8-marcandre.lureau@redhat.com>
In-Reply-To: <20250525132717.527392-1-marcandre.lureau@redhat.com>
References: <20250525132717.527392-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Volker Rümelin <vr_qemu@t-online.de>

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
Message-Id: <20250515054429.7385-7-vr_qemu@t-online.de>
---
 audio/audio_template.h | 12 ++++---
 audio/mixeng.h         |  6 ++--
 audio/audio.c          |  3 +-
 audio/mixeng.c         | 75 ++++++++++++++++++++++++++++++++++++++----
 4 files changed, 82 insertions(+), 14 deletions(-)

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
-- 
2.49.0


