Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC6DE7BD95
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfU-0007SH-8i; Mon, 16 Feb 2026 06:21:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwdL-00080I-Hd
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:19:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwdJ-0008TW-TO
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vPnMn5GvDJ7OVIuZ6lCYOvbjpyhZ011xLX1+qzHSAZE=;
 b=blVUIEUZSk2uHJwlFP086PBT+nvs8YI6TH4B6f6wcrCcOWRBnSQZrhhV/Ulf5Mn/S2g3WJ
 IZTta872fN8lordDmBMb0nYGvNIx1vy8rJxO0YC0pKs3QvBbbj3V6xDGYSjpvUfKPSFKIo
 R8wlBRI1A29TbzmiOtyp7Qx2wkMrVGg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-eQmQSJsUOAOApDI_wTsxNg-1; Mon,
 16 Feb 2026 06:19:14 -0500
X-MC-Unique: eQmQSJsUOAOApDI_wTsxNg-1
X-Mimecast-MFC-AGG-ID: eQmQSJsUOAOApDI_wTsxNg_1771240752
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DA3B1955D89; Mon, 16 Feb 2026 11:19:12 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5AE441800465; Mon, 16 Feb 2026 11:19:11 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:16:05 +0100
Subject: [PATCH 76/85] audio: replace DEBUG_CAPTURE with traces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-76-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3272;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=UIeZrRXkt2pxBSVmhpp0ZuhXisqo8XrlL/ZfBoMA7Kc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxSqeKbpRQDATwUVaUtAewI8YCn+CHkcAFwq
 uCcGV09uEWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UgAKCRDa6OEJdZac
 5TUYEACCbS0H+9dz94pjnMmO2xlvs4V12fgz0J7fur4MSTA/XPA1q1YsGH0mWiV1cnmPGeVtLRR
 +WhDf/9jAI+OO8FxHvWArz8gP3j/74DMPgZCZ4yXtek1thU7aG+9k/rJe6DObjk+IDGGtYmKYWU
 KbQ415cyNdY4Bxnf89wAwlXpG0TmFWp2+LdxhC6DHlTbQIgX2z89IfStYp/PLT0JDAJ9pYVsvpx
 dnD7mVOCGCaKBwuqzf10w6YBZey7ZxABiRYGH04jFyhoYI5BrvnAoHyYao88r3ioOw1LC61OBb7
 LaSWv0I1dvWYt7lGfEOnLOHdCYNlD7OjAMGWwHTOa9JF2GE7hfs/JA8s4mGtScgZzqKnMVdYw7V
 oDKaaVo3Q71kcRUEF0LUSUuWyUvhxCj+4Ur7V63ZMztHKOW6uiXnBWwRKueoxuDwFCa610B985t
 eSCqa4ZUpz/3gRjHzHgMRZDUX+qUgjmK6OrrBsgkT7Y/s4GDz57XFm3TD6SK+qNIx/XsAnaBKvU
 49hoHtw0vFVhZmeFGDHw1SwGhFIfqgw6WJVOppAfm4nOMJv1XO9YCG6ESFQG8nRlufbhltH9+AT
 XOKZbFx73GPx4VsmnCOHyHdEuWYY7/RxbjU8w0TLmvzrlfNZZ7WNEAnL4H9ndPe/nVgCtedhJWF
 HNJGsBKFUSRvi5Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/audio-mixeng-be.c | 20 +++++++-------------
 audio/trace-events      |  3 +++
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
index 2aeb05ba37e..1963f3e5c79 100644
--- a/audio/audio-mixeng-be.c
+++ b/audio/audio-mixeng-be.c
@@ -30,7 +30,6 @@
 #include "audio_int.h"
 
 /* #define DEBUG_OUT */
-/* #define DEBUG_CAPTURE */
 
 #define SW_NAME(sw) (sw)->name ? (sw)->name : "unknown"
 
@@ -249,9 +248,8 @@ static void audio_notify_capture (CaptureVoiceOut *cap, audcnotification_e cmd)
 {
     struct capture_callback *cb;
 
-#ifdef DEBUG_CAPTURE
-    dolog ("notification %d sent\n", cmd);
-#endif
+    trace_audio_notify_capture(cmd);
+
     for (cb = cap->cb_head.lh_first; cb; cb = cb->entries.le_next) {
         cb->ops.notify (cb->opaque, cmd);
     }
@@ -333,12 +331,10 @@ static int audio_attach_capture (HWVoiceOut *hw)
         sw->rate = st_rate_start (sw->info.freq, hw_cap->info.freq);
         QLIST_INSERT_HEAD (&hw_cap->sw_head, sw, entries);
         QLIST_INSERT_HEAD (&hw->cap_head, sc, entries);
-#ifdef DEBUG_CAPTURE
-        sw->name = g_strdup_printf ("for %p %d,%d,%d",
-                                    hw, sw->info.freq, sw->info.bits,
-                                    sw->info.nchannels);
-        dolog ("Added %s active = %d\n", sw->name, sw->active);
-#endif
+        sw->name = g_strdup_printf("for %p %d,%s,%d",
+                                   hw, sw->info.freq, AudioFormat_str(sw->info.af),
+                                   sw->info.nchannels);
+        trace_audio_capture_attach(sw->name, sw->active);
         if (sw->active) {
             audio_capture_maybe_changed (cap, 1);
         }
@@ -1707,10 +1703,8 @@ static void audio_mixeng_backend_del_capture(
 
                 while (sw) {
                     SWVoiceCap *sc = (SWVoiceCap *) sw;
-#ifdef DEBUG_CAPTURE
-                    dolog ("freeing %s\n", sw->name);
-#endif
 
+                    trace_audio_capture_free_sw(sw->name);
                     sw1 = sw->entries.le_next;
                     if (sw->rate) {
                         st_rate_stop (sw->rate);
diff --git a/audio/trace-events b/audio/trace-events
index d66a712e871..3f8ebf9c6cb 100644
--- a/audio/trace-events
+++ b/audio/trace-events
@@ -58,10 +58,13 @@ audio_be_set_active_out(void *sw, bool on) "sw=%p, on=%d"
 audio_timer_start(int interval) "interval %d ms"
 audio_timer_stop(void) ""
 audio_timer_delayed(int interval) "interval %d ms"
+audio_notify_capture(int cmd) "notification %d sent"
+audio_capture_attach(const char *name, bool active) "capture %s active=%d"
 
 # audio-mixeng-be.c
 audio_get_avail(const char *name, size_t live, uint32_t frontend_frames) "%s: get_avail live %zu frontend frames %u"
 audio_run_poll(const char *msg, int64_t elapsed_us) "Elapsed since last %s: %" PRId64 " us"
+audio_capture_free_sw(const char *name) "freeing %s"
 
 # audio_template.h
 audio_open_out(const char *name, int freq, int nchannels, int fmt) "open %s, freq %d, nchannels %d, fmt %d"

-- 
2.53.0


