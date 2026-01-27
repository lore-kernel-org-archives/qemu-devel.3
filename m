Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C2ED2FED9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknqA-0007E7-CU; Tue, 27 Jan 2026 13:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vknoL-00021t-WA
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:29:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vknoC-0003Xf-BQ
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769538539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b36zKFl1eTvXCE4LVYy6WoOs1hux1pYpscdduj5xdoc=;
 b=bjlJ0IsjRMNOSlVMEtBcJLZdUEeDM5AAGN4i/AZGdeUGO6EtiidsXntRyf3uNHUTcRvJUE
 YcVtM0rv+Na+sWeShFqr9WVrDnwUiF5y/zbSEQraHngQdAFGAnCwDv8h2qzTl8+jxXjXov
 e3udeFnb69AHL2Pb5mJLa6eQHFwocSw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-jmOdHWxHN4mOww_Lm29A2w-1; Tue,
 27 Jan 2026 13:28:57 -0500
X-MC-Unique: jmOdHWxHN4mOww_Lm29A2w-1
X-Mimecast-MFC-AGG-ID: jmOdHWxHN4mOww_Lm29A2w_1769538536
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D247E19775AA; Tue, 27 Jan 2026 18:28:56 +0000 (UTC)
Received: from localhost (unknown [10.45.242.23])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8C3861955F66; Tue, 27 Jan 2026 18:28:55 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 36/43] audio: replace DEBUG_OUT with traces
Date: Tue, 27 Jan 2026 22:25:03 +0400
Message-ID: <20260127182516.289834-37-marcandre.lureau@redhat.com>
In-Reply-To: <20260127182516.289834-1-marcandre.lureau@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio-mixeng-be.c | 32 ++++++++------------------------
 audio/trace-events      |  5 +++++
 2 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
index c3234aafb1b..5303c08a285 100644
--- a/audio/audio-mixeng-be.c
+++ b/audio/audio-mixeng-be.c
@@ -29,8 +29,6 @@
 #define AUDIO_CAP "audio"
 #include "audio_int.h"
 
-/* #define DEBUG_OUT */
-
 #define SW_NAME(sw) (sw)->name ? (sw)->name : "unknown"
 
 const struct mixeng_volume nominal_volume = {
@@ -568,9 +566,7 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t buf_len)
     }
 
     if (live == hw->mix_buf.size) {
-#ifdef DEBUG_OUT
-        dolog ("%s is full %zu\n", sw->name, live);
-#endif
+        trace_audio_out_full(sw->name, live);
         return 0;
     }
 
@@ -618,15 +614,8 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t buf_len)
         sw->resample_buf.pos = 0;
     }
 
-#ifdef DEBUG_OUT
-    dolog (
-        "%s: write size %zu written %zu total mixed %zu\n",
-        SW_NAME(sw),
-        buf_len / sw->info.bytes_per_frame,
-        total_in,
-        sw->total_hw_samples_mixed
-        );
-#endif
+    trace_audio_sw_write(SW_NAME(sw), buf_len / sw->info.bytes_per_frame,
+                         total_in, sw->total_hw_samples_mixed);
 
     return total_in * sw->info.bytes_per_frame;
 }
@@ -900,10 +889,8 @@ static size_t audio_get_free(SWVoiceOut *sw)
 
     dead = sw->hw->mix_buf.size - live;
 
-#ifdef DEBUG_OUT
-    dolog("%s: get_free live %zu dead %zu frontend frames %u\n",
-          SW_NAME(sw), live, dead, st_rate_frames_in(sw->rate, dead));
-#endif
+    trace_audio_get_free(SW_NAME(sw), live, dead,
+                         st_rate_frames_in(sw->rate, dead));
 
     return dead;
 }
@@ -1058,9 +1045,8 @@ static void audio_run_out(AudioMixengBackend *s)
 
         if (hw->pending_disable && !nb_live) {
             SWVoiceCap *sc;
-#ifdef DEBUG_OUT
-            dolog ("Disabling voice\n");
-#endif
+
+            trace_audio_out_disable();
             hw->enabled = false;
             hw->pending_disable = false;
             if (k->enable_out) {
@@ -1089,9 +1075,7 @@ static void audio_run_out(AudioMixengBackend *s)
             hw->mix_buf.pos = 0;
         }
 
-#ifdef DEBUG_OUT
-        dolog("played=%zu\n", played);
-#endif
+        trace_audio_out_played(played);
 
         if (played) {
             audio_capture_mix_and_clear (hw, prev_rpos, played);
diff --git a/audio/trace-events b/audio/trace-events
index 3f8ebf9c6cb..7a73d6eb84f 100644
--- a/audio/trace-events
+++ b/audio/trace-events
@@ -65,6 +65,11 @@ audio_capture_attach(const char *name, bool active) "capture %s active=%d"
 audio_get_avail(const char *name, size_t live, uint32_t frontend_frames) "%s: get_avail live %zu frontend frames %u"
 audio_run_poll(const char *msg, int64_t elapsed_us) "Elapsed since last %s: %" PRId64 " us"
 audio_capture_free_sw(const char *name) "freeing %s"
+audio_out_full(const char *name, size_t live) "%s is full %zu"
+audio_sw_write(const char *name, size_t size, size_t written, size_t total_mixed) "%s: write size %zu written %zu total mixed %zu"
+audio_get_free(const char *name, size_t live, size_t dead, uint32_t frontend_frames) "%s: get_free live %zu dead %zu frontend frames %u"
+audio_out_disable(void) "Disabling voice"
+audio_out_played(size_t played) "played=%zu"
 
 # audio_template.h
 audio_open_out(const char *name, int freq, int nchannels, int fmt) "open %s, freq %d, nchannels %d, fmt %d"
-- 
2.52.0


