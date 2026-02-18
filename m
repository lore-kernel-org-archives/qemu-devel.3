Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA37AE9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsdXN-0002qD-Dc; Wed, 18 Feb 2026 04:08:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdX6-0001IM-PN
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:07:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdX3-0002VS-CO
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771405660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LGq+VCEW90rvm6mfQdjwX9Xt4WycZSlTKQAB6s+z0Ro=;
 b=UHgkR5LMr5BFmbxBXIM78GS9uzy1OhTISvfkRsm66jwIYssTFJW+CMR59QhS7p8dgAAKME
 8wTXVZXquLXS7K+ydifUaQM1LgNOc1rEPyFYGbFbqDKavH6KvH5jYpeO3UKf+kDCJGtEOD
 ntbaofisPcNfJdHSQB6ESlgnrNpFvdw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-T8Dl6c_hNDSGSw6EU1n4rA-1; Wed,
 18 Feb 2026 04:07:39 -0500
X-MC-Unique: T8Dl6c_hNDSGSw6EU1n4rA-1
X-Mimecast-MFC-AGG-ID: T8Dl6c_hNDSGSw6EU1n4rA_1771405658
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D4F01800464; Wed, 18 Feb 2026 09:07:38 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B43C91800351; Wed, 18 Feb 2026 09:07:37 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 82/85] audio: replace remaining dolog() and AUD_log
Date: Wed, 18 Feb 2026 10:03:22 +0100
Message-ID: <20260218090330.1476169-83-marcandre.lureau@redhat.com>
In-Reply-To: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
References: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use warn_report/error_report and trace instead.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_template.h  | 19 ++++++++-----------
 audio/audio-mixeng-be.c | 14 ++++++--------
 audio/trace-events      |  1 +
 3 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/audio/audio_template.h b/audio/audio_template.h
index 9dde36738bc..760aaf5f31f 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -47,21 +47,19 @@ static void glue(audio_init_nb_voices_, TYPE)(AudioMixengBackend *s,
     if (glue(s->nb_hw_voices_, TYPE) > max_voices) {
         if (!max_voices) {
 #ifdef DAC
-            dolog("Driver `%s' does not support " NAME "\n", k->name);
+            warn_report("audio: Driver '%s' does not support " NAME, k->name);
 #endif
         } else {
-            dolog("Driver `%s' does not support %d " NAME " voices, max %d\n",
-                   k->name,
-                   glue(s->nb_hw_voices_, TYPE),
-                   max_voices);
+            warn_report("audio: Driver '%s' does not support %d " NAME " voices, max %d",
+                        k->name, glue(s->nb_hw_voices_, TYPE), max_voices);
         }
         glue(s->nb_hw_voices_, TYPE) = max_voices;
     }
 
     if (glue(s->nb_hw_voices_, TYPE) < min_voices) {
-        dolog("Bogus number of " NAME " voices %d, setting to %d\n",
-               glue(s->nb_hw_voices_, TYPE),
-               min_voices);
+        warn_report("audio: Bogus number of " NAME " voices %d, setting to %d",
+                    glue(s->nb_hw_voices_, TYPE),
+                    min_voices);
     }
 
     if (!voice_size && max_voices) {
@@ -443,7 +441,7 @@ static SW *glue(audio_pcm_create_voice_pair_, TYPE)(
 
     hw = glue(audio_pcm_hw_add_, TYPE)(s, &hw_as);
     if (!hw) {
-        dolog("Could not create a backend for voice `%s'\n", sw_name);
+        error_report("audio: Could not create a backend for voice '%s'", sw_name);
         goto err1;
     }
 
@@ -537,8 +535,7 @@ static SW *glue(audio_mixeng_backend_open_, TYPE) (
         HW *hw = sw->hw;
 
         if (!hw) {
-            dolog("Internal logic error: voice `%s' has no backend\n",
-                  SW_NAME(sw));
+            audio_bug("Internal logic error: voice '%s' has no backend", SW_NAME(sw));
             goto fail;
         }
 
diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
index 45bcfb74338..87e5a2fc3af 100644
--- a/audio/audio-mixeng-be.c
+++ b/audio/audio-mixeng-be.c
@@ -654,7 +654,7 @@ static size_t audio_mixeng_backend_write(AudioBackend *be, SWVoiceOut *sw,
     hw = sw->hw;
 
     if (!hw->enabled) {
-        dolog("Writing to disabled voice %s\n", SW_NAME(sw));
+        warn_report("audio: Writing to disabled voice %s", SW_NAME(sw));
         return 0;
     }
 
@@ -677,7 +677,7 @@ static size_t audio_mixeng_backend_read(AudioBackend *be,
     hw = sw->hw;
 
     if (!hw->enabled) {
-        dolog("Reading from disabled voice %s\n", SW_NAME(sw));
+        warn_report("audio: Reading from disabled voice %s", SW_NAME(sw));
         return 0;
     }
 
@@ -874,9 +874,8 @@ static void audio_capture_mix_and_clear(HWVoiceOut *hw, size_t rpos,
                 sw->empty = sw->total_hw_samples_mixed == 0;
 
                 if (to_read - frames_in) {
-                    dolog("Could not mix %zu frames into a capture "
-                          "buffer, mixed %zu\n",
-                          to_read, frames_in);
+                    audio_bug("Could not mix %zu frames into a capture "
+                              "buffer, mixed %zu", to_read, frames_in);
                     break;
                 }
                 n -= to_read;
@@ -1561,7 +1560,7 @@ static CaptureVoiceOut *audio_mixeng_backend_add_capture(
     }
 
     if (!audio_get_pdo_out(s->dev)->mixing_engine) {
-        dolog("Can't capture with mixeng disabled\n");
+        error_report("audio: Can't capture with mixeng disabled");
         return NULL;
     }
 
@@ -1754,8 +1753,7 @@ size_t audio_rate_peek_bytes(RateCtl *rate, struct audio_pcm_info *info)
 void audio_rate_add_bytes(RateCtl *rate, size_t bytes_used)
 {
     if (rate->peeked_frames < 0 || rate->peeked_frames > 65536) {
-        AUD_log(NULL, "Resetting rate control (%" PRId64 " frames)\n",
-                rate->peeked_frames);
+        trace_audio_rate_reset(rate->peeked_frames);
         audio_rate_start(rate);
     }
 
diff --git a/audio/trace-events b/audio/trace-events
index ed04792d508..222e73c7e88 100644
--- a/audio/trace-events
+++ b/audio/trace-events
@@ -70,6 +70,7 @@ audio_sw_write(const char *name, size_t size, size_t written, size_t total_mixed
 audio_get_free(const char *name, size_t live, size_t dead, uint32_t frontend_frames) "%s: get_free live %zu dead %zu frontend frames %u"
 audio_out_disable(void) "Disabling voice"
 audio_out_played(size_t played) "played=%zu"
+audio_rate_reset(int64_t frames) "Resetting rate control (%" PRId64 " frames)"
 
 # audio_template.h
 audio_open_out(const char *name, int freq, int nchannels, int fmt) "open %s, freq %d, nchannels %d, fmt %d"
-- 
2.53.0


