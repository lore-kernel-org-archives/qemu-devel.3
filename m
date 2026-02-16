Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD677E7BDA3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfh-0000fr-S8; Mon, 16 Feb 2026 06:21:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwdQ-0008Kj-3t
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:19:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwdO-0008UU-J5
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:19:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BB6jQvGRqbXD7hENVx2pNstNIc4pFnH7f/Xe+/sKYwo=;
 b=KDk73N0wRcuB5rHKrW+C2Im2WGKmYztpEaRaHhYvnDlEBdqo/kZYw/Zz4v/9WO7zs8QFT8
 7hVJSzsCfm26zw3vYRoXngMCaDJWg6N23a+oqM0vpq7eXYHpXvLc8dyHQut6uK8v+sTwW2
 rPIKdkCFN95o461EV66oqGNQWYDgG3U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-vPQv5zfANgG7zZ6iODK0HQ-1; Mon,
 16 Feb 2026 06:19:17 -0500
X-MC-Unique: vPQv5zfANgG7zZ6iODK0HQ-1
X-Mimecast-MFC-AGG-ID: vPQv5zfANgG7zZ6iODK0HQ_1771240755
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 911A2180047F; Mon, 16 Feb 2026 11:19:15 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE2E61800464; Mon, 16 Feb 2026 11:19:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:16:06 +0100
Subject: [PATCH 77/85] audio: replace DEBUG_OUT with traces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-77-e676662e4514@redhat.com>
References: <20260216-audio-v1-0-e676662e4514@redhat.com>
In-Reply-To: <20260216-audio-v1-0-e676662e4514@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3777;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=b1klW4axY6twkEGfrheCi2WZdrVTpoIdzbMvZtSetFQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxSD1tB2iPbiDer/gUC7JJQHK122dd/DQiHS
 gGvw/JMRp2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UgAKCRDa6OEJdZac
 5Qi4D/4kXQIy8DYZMN/lWGjcNjP2yxGx6bYOyUBlC6LUHkP6lmCwgKBMMJxvfkK52LPURJ76oAl
 doYlcUY3INlg0+gqnyafels7Du27ZnzlqbykSep+qMKAd5IT0A4vZzoyKogG8MWTmn+F0UUqlql
 RivjAWeT8DjNwFbNjUb+XU1Qr3KV092DKgjabnrW/B759kiskAA/e/HEz4B2i8/6i1+7tsBmaCX
 i7p2Dvu02Zin6B2O7pGq2TapCXQBdoaMV6NkqTTd4XpoUjlu6dAbgVw5u2KvkfT2xauUSl0y6TW
 HaTvsOB0ZCwc71ObqHWNYH+R8IBwyFenQf28NGrT/uhT5WACKHBywrYRLZH80iEvgKpw6JKMnuS
 EHilMeHUsB0Dh17FWNb3L1d2ddku3pCwB5a3D34EfnuG958UeKs4qNKgCXV2XdXrQexnqru8/oC
 fcRKLJ1cbNfeC8nqOefyAp1lbW38vQaaSveXukk6Z+ZIZMgQmWlI+MvbQbUxSiQLEikQVwOqDlR
 Nn6F+ehNer0rhvkCfIfwPwI7owWnHUpbx8pwYaMu19TInF3w75m0LJJHWz2OONGj4DO02aoFame
 gxl6N3oCnKaFHRIkIs2nlyeyMorEzPgmmtCi2AnaPemuNUzMJWNR9H23Fv5NKvu8ksrnlJmOuwn
 z189WHXkqsIdQ/g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/audio-mixeng-be.c | 32 ++++++++------------------------
 audio/trace-events      |  5 +++++
 2 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
index 1963f3e5c79..3dd9d17dd25 100644
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
2.53.0


