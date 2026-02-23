Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE651EA4FBA
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 14:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuWNm-0004Jx-IG; Mon, 23 Feb 2026 08:53:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWLR-0006ZI-PC
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:51:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWLL-0007mt-Ay
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771854682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KcMrLyAIgOYdFY64yVHRXdrwUnIJyXUy4fcgyWcJqb8=;
 b=Jua5wFV5zHlvHjVokGKbKeheiMGdYgdAIgVPQJrdWck6hDRenCEOGN9prpi3JbT98uu/Mq
 wEYm8D4zGbyuLjBV7ptqaCQREfVMWwUmGrgFFk0p9TXCtozsvTUJBqsXAYjkXpuT2+ZCK2
 16WdkbUm0DvbiJ5po8Lddh7ry0mehmI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-l1dLM2K_OKGaHubViHD_2A-1; Mon,
 23 Feb 2026 08:51:19 -0500
X-MC-Unique: l1dLM2K_OKGaHubViHD_2A-1
X-Mimecast-MFC-AGG-ID: l1dLM2K_OKGaHubViHD_2A_1771854677
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66F391955F68; Mon, 23 Feb 2026 13:51:17 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AFF2E1800670; Mon, 23 Feb 2026 13:51:16 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v3 81/85] audio: rework audio_bug()
Date: Mon, 23 Feb 2026 14:47:22 +0100
Message-ID: <20260223134731.2377432-82-marcandre.lureau@redhat.com>
In-Reply-To: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
References: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
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

audio_bug() is a bit unconventional, it is meant to be used as a
condition expression, passing the actual condition as second argument
(and __func__ as first argument).

If the condition is true, it uses AUD_log() to print to stderr, and has
some dubious recommendations printed only once.

This change:
- clears the control flow, and make the condition directly visible in
  the 'if' statement.
- uses standard QEMU error_report()
- audio_bug() now captures __func__
- remove the "Save all your work and restart..." once hint

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_int.h       |  2 --
 audio/audio_template.h  | 38 +++++++++++------------
 audio/audio-mixeng-be.c | 69 ++++++++++++++++-------------------------
 3 files changed, 46 insertions(+), 63 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index e0ed6af67ed..20ec7883aab 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -244,8 +244,6 @@ extern const char *audio_prio_list[];
 void audio_pcm_init_info (struct audio_pcm_info *info, const struct audsettings *as);
 void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len);
 
-int audio_bug (const char *funcname, int cond);
-
 void audio_run(AudioMixengBackend *s, const char *msg);
 
 typedef struct RateCtl {
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 5711f4a26e1..9dde36738bc 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -64,15 +64,15 @@ static void glue(audio_init_nb_voices_, TYPE)(AudioMixengBackend *s,
                min_voices);
     }
 
-    if (audio_bug(__func__, !voice_size && max_voices)) {
-        dolog("drv=`%s' voice_size=0 max_voices=%d\n",
-               k->name, max_voices);
+    if (!voice_size && max_voices) {
+        audio_bug("drv=`%s' voice_size=0 max_voices=%d",
+                  k->name, max_voices);
         glue(s->nb_hw_voices_, TYPE) = 0;
     }
 
-    if (audio_bug(__func__, voice_size && !max_voices)) {
-        dolog("drv=`%s' voice_size=%zu max_voices=0\n",
-              k->name, voice_size);
+    if (voice_size && !max_voices) {
+        audio_bug("drv=`%s' voice_size=%zu max_voices=0",
+                  k->name, voice_size);
     }
 }
 
@@ -88,8 +88,8 @@ static void glue(audio_pcm_hw_alloc_resources_, TYPE)(HW *hw)
 {
     if (glue(audio_get_pdo_, TYPE)(hw->s->dev)->mixing_engine) {
         size_t samples = hw->samples;
-        if (audio_bug(__func__, samples == 0)) {
-            dolog("Attempted to allocate empty buffer\n");
+        if (samples == 0) {
+            audio_bug("Attempted to allocate empty buffer");
         }
 
         HWBUF.buffer = g_new0(st_sample, samples);
@@ -275,8 +275,8 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioMixengBackend *s,
         return NULL;
     }
 
-    if (audio_bug(__func__, !glue(k->init_, TYPE))) {
-        dolog("No host audio driver or missing init_%s\n", NAME);
+    if (!glue(k->init_, TYPE)) {
+        audio_bug("No host audio driver or missing init_%s", NAME);
         return NULL;
     }
 
@@ -295,8 +295,8 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioMixengBackend *s,
         goto err0;
     }
 
-    if (audio_bug(__func__, hw->samples <= 0)) {
-        dolog("hw->samples=%zd\n", hw->samples);
+    if (hw->samples <= 0) {
+        audio_bug("hw->samples=%zd", hw->samples);
         goto err1;
     }
 
@@ -477,8 +477,8 @@ static void glue (audio_close_, TYPE) (SW *sw)
 static void glue(audio_mixeng_backend_close_, TYPE)(AudioBackend *be, SW *sw)
 {
     if (sw) {
-        if (audio_bug(__func__, !be)) {
-            dolog("backend=%p\n", be);
+        if (!be) {
+            audio_bug("backend=%p", be);
             return;
         }
 
@@ -498,9 +498,9 @@ static SW *glue(audio_mixeng_backend_open_, TYPE) (
     AudioMixengBackendClass *k;
     AudiodevPerDirectionOptions *pdo;
 
-    if (audio_bug(__func__, !be || !name || !callback_fn || !as)) {
-        dolog("backend=%p name=%p callback_fn=%p as=%p\n",
-              be, name, callback_fn, as);
+    if (!be || !name || !callback_fn || !as) {
+        audio_bug("backend=%p name=%p callback_fn=%p as=%p",
+                  be, name, callback_fn, as);
         goto fail;
     }
 
@@ -519,8 +519,8 @@ static SW *glue(audio_mixeng_backend_open_, TYPE) (
         goto fail;
     }
 
-    if (audio_bug(__func__, !glue(k->init_, TYPE))) {
-        dolog("Can not open `%s' (no host audio driver)\n", name);
+    if (!glue(k->init_, TYPE)) {
+        error_report("audio: Can not open `%s' (no host audio driver)", name);
         goto fail;
     }
 
diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
index bb8c0b56f78..45bcfb74338 100644
--- a/audio/audio-mixeng-be.c
+++ b/audio/audio-mixeng-be.c
@@ -31,6 +31,8 @@
 
 #define SW_NAME(sw) (sw)->name ? (sw)->name : "unknown"
 
+#define audio_bug(fmt, ...) error_report("%s: " fmt, __func__, ##__VA_ARGS__)
+
 const struct mixeng_volume nominal_volume = {
     .mute = 0,
 #ifdef FLOAT_MIXENG
@@ -42,23 +44,6 @@ const struct mixeng_volume nominal_volume = {
 #endif
 };
 
-int audio_bug (const char *funcname, int cond)
-{
-    if (cond) {
-        static int shown;
-
-        AUD_log (NULL, "A bug was just triggered in %s\n", funcname);
-        if (!shown) {
-            shown = 1;
-            AUD_log (NULL, "Save all your work and restart without audio\n");
-            AUD_log (NULL, "I am sorry\n");
-        }
-        AUD_log (NULL, "Context:\n");
-    }
-
-    return cond;
-}
-
 /*
  * Convert audio format to mixeng_clip index. Used by audio_pcm_sw_init_ and
  * audio_mixeng_backend_add_capture()
@@ -332,8 +317,8 @@ static size_t audio_pcm_hw_find_min_in (HWVoiceIn *hw)
 static size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw)
 {
     size_t live = hw->total_samples_captured - audio_pcm_hw_find_min_in (hw);
-    if (audio_bug(__func__, live > hw->conv_buf.size)) {
-        dolog("live=%zu hw->conv_buf.size=%zu\n", live, hw->conv_buf.size);
+    if (live > hw->conv_buf.size) {
+        audio_bug("live=%zu hw->conv_buf.size=%zu", live, hw->conv_buf.size);
         return 0;
     }
     return live;
@@ -402,8 +387,8 @@ static size_t audio_pcm_sw_read(SWVoiceIn *sw, void *buf, size_t buf_len)
     if (!live) {
         return 0;
     }
-    if (audio_bug(__func__, live > hw->conv_buf.size)) {
-        dolog("live_in=%zu hw->conv_buf.size=%zu\n", live, hw->conv_buf.size);
+    if (live > hw->conv_buf.size) {
+        audio_bug("live=%zu hw->conv_buf.size=%zu", live, hw->conv_buf.size);
         return 0;
     }
 
@@ -454,8 +439,8 @@ static size_t audio_pcm_hw_get_live_out (HWVoiceOut *hw, int *nb_live)
     if (nb_live1) {
         size_t live = smin;
 
-        if (audio_bug(__func__, live > hw->mix_buf.size)) {
-            dolog("live=%zu hw->mix_buf.size=%zu\n", live, hw->mix_buf.size);
+        if (live > hw->mix_buf.size) {
+            audio_bug("live=%zu hw->mix_buf.size=%zu", live, hw->mix_buf.size);
             return 0;
         }
         return live;
@@ -533,8 +518,8 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t buf_len)
     size_t frames_in_max, frames_out_max, total_in, total_out;
 
     live = sw->total_hw_samples_mixed;
-    if (audio_bug(__func__, live > hw->mix_buf.size)) {
-        dolog("live=%zu hw->mix_buf.size=%zu\n", live, hw->mix_buf.size);
+    if (live > hw->mix_buf.size) {
+        audio_bug("live=%zu hw->mix_buf.size=%zu", live, hw->mix_buf.size);
         return 0;
     }
 
@@ -824,9 +809,9 @@ static size_t audio_get_avail(SWVoiceIn *sw)
     }
 
     live = sw->hw->total_samples_captured - sw->total_hw_samples_acquired;
-    if (audio_bug(__func__, live > sw->hw->conv_buf.size)) {
-        dolog("live=%zu sw->hw->conv_buf.size=%zu\n", live,
-              sw->hw->conv_buf.size);
+    if (live > sw->hw->conv_buf.size) {
+        audio_bug("live=%zu sw->hw->conv_buf.size=%zu", live,
+                  sw->hw->conv_buf.size);
         return 0;
     }
 
@@ -845,9 +830,9 @@ static size_t audio_get_free(SWVoiceOut *sw)
 
     live = sw->total_hw_samples_mixed;
 
-    if (audio_bug(__func__, live > sw->hw->mix_buf.size)) {
-        dolog("live=%zu sw->hw->mix_buf.size=%zu\n", live,
-              sw->hw->mix_buf.size);
+    if (live > sw->hw->mix_buf.size) {
+        audio_bug("live=%zu sw->hw->mix_buf.size=%zu", live,
+                  sw->hw->mix_buf.size);
         return 0;
     }
 
@@ -1002,8 +987,8 @@ static void audio_run_out(AudioMixengBackend *s)
             live = 0;
         }
 
-        if (audio_bug(__func__, live > hw->mix_buf.size)) {
-            dolog("live=%zu hw->mix_buf.size=%zu\n", live, hw->mix_buf.size);
+        if (live > hw->mix_buf.size) {
+            audio_bug("live=%zu hw->mix_buf.size=%zu", live, hw->mix_buf.size);
             continue;
         }
 
@@ -1033,9 +1018,9 @@ static void audio_run_out(AudioMixengBackend *s)
         prev_rpos = hw->mix_buf.pos;
         played = audio_pcm_hw_run_out(hw, live);
         replay_audio_out(&played);
-        if (audio_bug(__func__, hw->mix_buf.pos >= hw->mix_buf.size)) {
-            dolog("hw->mix_buf.pos=%zu hw->mix_buf.size=%zu played=%zu\n",
-                  hw->mix_buf.pos, hw->mix_buf.size, played);
+        if (hw->mix_buf.pos >= hw->mix_buf.size) {
+            audio_bug("hw->mix_buf.pos=%zu hw->mix_buf.size=%zu played=%zu",
+                      hw->mix_buf.pos, hw->mix_buf.size, played);
             hw->mix_buf.pos = 0;
         }
 
@@ -1050,9 +1035,9 @@ static void audio_run_out(AudioMixengBackend *s)
                 continue;
             }
 
-            if (audio_bug(__func__, played > sw->total_hw_samples_mixed)) {
-                dolog("played=%zu sw->total_hw_samples_mixed=%zu\n",
-                      played, sw->total_hw_samples_mixed);
+            if (played > sw->total_hw_samples_mixed) {
+                audio_bug("played=%zu sw->total_hw_samples_mixed=%zu",
+                          played, sw->total_hw_samples_mixed);
                 played = sw->total_hw_samples_mixed;
             }
 
@@ -1195,9 +1180,9 @@ static void audio_run_capture(AudioMixengBackend *s)
                 continue;
             }
 
-            if (audio_bug(__func__, captured > sw->total_hw_samples_mixed)) {
-                dolog("captured=%zu sw->total_hw_samples_mixed=%zu\n",
-                      captured, sw->total_hw_samples_mixed);
+            if (captured > sw->total_hw_samples_mixed) {
+                audio_bug("captured=%zu sw->total_hw_samples_mixed=%zu",
+                          captured, sw->total_hw_samples_mixed);
                 captured = sw->total_hw_samples_mixed;
             }
 
-- 
2.53.0


