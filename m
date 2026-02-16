Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FEAE7BD9B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfa-0008Mu-ID; Mon, 16 Feb 2026 06:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwdL-0007yI-4e
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:19:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwdJ-0008TO-2x
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N7c59NEfg4hmqcbZ3MZ180N2UP3aJ4ktCpkln/Wb2qE=;
 b=JqOcgD0JtQkNLMFqZ40t0jkzI+1vxDCkRnqErCEwp/D8kdoa3bm+CVZnHWwdq0WJaMx0Sr
 hZGj+UlYaPAP5CvxPka8Q3saMEzAass3eT5BTIAix57fvOPX1mz31A0XNIJDnuNGQjoIFs
 kZsuLuiWb/KZxd/fxksFvzm9+3YSqpY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-4BQWyRFXM5OZuEZ7gBJIeg-1; Mon,
 16 Feb 2026 06:19:11 -0500
X-MC-Unique: 4BQWyRFXM5OZuEZ7gBJIeg-1
X-Mimecast-MFC-AGG-ID: 4BQWyRFXM5OZuEZ7gBJIeg_1771240749
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C51D18002C1; Mon, 16 Feb 2026 11:19:09 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0BD8A1955F43; Mon, 16 Feb 2026 11:19:08 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:16:04 +0100
Subject: [PATCH 75/85] audio: rework DEBUG_POLL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-75-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3820;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=VuHJE/OMoLF5FV66Xec/LvzCGIsN/NmdER0U65ZSEv0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxSC3oidMw+TYQw+bed/aGyUDri9z1ES2mfP
 mNcR+kss6KJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UgAKCRDa6OEJdZac
 5c4uD/sEd++T8QohRaQ95Za6IPQRCm1KE+xDf5nA1SOKwPzmuQDDiQrozdPuMv5Vcy1FSDc0oPq
 hMyYijL0C49wC06yiwaPAjtwios2ncI6XYim21cjvauUwO/wfvXwu0MB94+nmkjhMYrXkIJq+MI
 xs7veXvlVf+ThVbDHMxp9LjWFNxRnlYrbYzfKcgOLSYqNusDtMnHmJRdlm6C+A/Er/LPMCAl0Vr
 +GSVoh5Gz81ZwuZo0hyXkkF6l8BZIvU6ECtv8YpOIQLgrnxRX9sKNRzHG5sRhu+QcjEmUbNy7H/
 ppfOeH/VQd4wnJhY9VVvvsdOi8tFnW0tcmc0ONrzKxnO4nMaKbQB1QoD6JdlPe8TOTDncUdQonJ
 MxBn0lCJMKJ9CIBR0dj49JKuelJUP6gLrphdeiyq68CSuXhXcylMFXmwwwpv43NS2RbpKzPRgPf
 Ak/YJest1iyVRLsB1w2ixFHwRXqRWIrfz1h04eRahIvgr3feZJPKOhFMIcXUoEBMysWPkXT3vGY
 We+JscZXwHlOTYrJh9JOxhR+OmoHYO27+PI0xWwCIedoP3ZCe5SmKubNKk1XoxUpSV6Ag7v/QvJ
 vlAgGhrJnAB6N2j85w8oN3e+SbsyenoPP+47zACsMUTS6W6ZyiQAiWvgRSPBJcSkYuRFFvmXAYI
 XLrX7JpFBi9H96w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Use more correct GTimer, specific for each backend, with a trace event.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/audio_int.h       |  1 +
 include/qemu/timer.h    |  1 +
 audio/audio-mixeng-be.c | 25 +++++++++----------------
 audio/trace-events      |  1 +
 4 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index dd5f2220d75..e0ed6af67ed 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -224,6 +224,7 @@ struct AudioMixengBackend {
     Audiodev *dev;
 
     QEMUTimer *ts;
+    GTimer *run_timer;
     QLIST_HEAD (hw_in_listhead, HWVoiceIn) hw_head_in;
     QLIST_HEAD (hw_out_listhead, HWVoiceOut) hw_head_out;
     QLIST_HEAD (cap_listhead, CaptureVoiceOut) cap_head;
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 7c18da16525..b931181f53d 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -6,6 +6,7 @@
 #include "qemu/host-utils.h"
 
 #define NANOSECONDS_PER_SECOND 1000000000LL
+#define MICROSECONDS_PER_SECOND 1000000LL
 
 /* timers */
 
diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
index 84e4d136de3..2aeb05ba37e 100644
--- a/audio/audio-mixeng-be.c
+++ b/audio/audio-mixeng-be.c
@@ -24,13 +24,13 @@
 #include "system/replay.h"
 #include "system/runstate.h"
 #include "trace.h"
+#include "trace/control.h"
 
 #define AUDIO_CAP "audio"
 #include "audio_int.h"
 
 /* #define DEBUG_OUT */
 /* #define DEBUG_CAPTURE */
-/* #define DEBUG_POLL */
 
 #define SW_NAME(sw) (sw)->name ? (sw)->name : "unknown"
 
@@ -1269,22 +1269,12 @@ void audio_run(AudioMixengBackend *s, const char *msg)
     audio_run_in(s);
     audio_run_capture(s);
 
-#ifdef DEBUG_POLL
-    {
-        static double prevtime;
-        double currtime;
-        struct timeval tv;
-
-        if (gettimeofday (&tv, NULL)) {
-            perror ("audio_run: gettimeofday");
-            return;
-        }
-
-        currtime = tv.tv_sec + tv.tv_usec * 1e-6;
-        dolog ("Elapsed since last %s: %f\n", msg, currtime - prevtime);
-        prevtime = currtime;
+    if (trace_event_get_state(TRACE_AUDIO_RUN_POLL)) {
+        /* Convert seconds to microseconds for trace event */
+        int64_t elapsed_us = g_timer_elapsed(s->run_timer, NULL) * MICROSECONDS_PER_SECOND;
+        trace_audio_run_poll(msg, elapsed_us);
+        g_timer_start(s->run_timer);
     }
-#endif
 }
 
 void audio_generic_run_buffer_in(HWVoiceIn *hw)
@@ -1545,6 +1535,7 @@ static void audio_mixeng_backend_init(Object *obj)
     QLIST_INIT(&s->hw_head_in);
     QLIST_INIT(&s->cap_head);
     s->ts = timer_new_ns(QEMU_CLOCK_VIRTUAL, audio_timer, s);
+    s->run_timer = g_timer_new();
 
     s->vmse = qemu_add_vm_change_state_handler(audio_vm_change_state_handler, s);
     assert(s->vmse != NULL);
@@ -1596,6 +1587,8 @@ static void audio_mixeng_backend_finalize(Object *obj)
         s->ts = NULL;
     }
 
+    g_clear_pointer(&s->run_timer, g_timer_destroy);
+
     if (s->vmse) {
         qemu_del_vm_change_state_handler(s->vmse);
         s->vmse = NULL;
diff --git a/audio/trace-events b/audio/trace-events
index 4749c54fc04..d66a712e871 100644
--- a/audio/trace-events
+++ b/audio/trace-events
@@ -61,6 +61,7 @@ audio_timer_delayed(int interval) "interval %d ms"
 
 # audio-mixeng-be.c
 audio_get_avail(const char *name, size_t live, uint32_t frontend_frames) "%s: get_avail live %zu frontend frames %u"
+audio_run_poll(const char *msg, int64_t elapsed_us) "Elapsed since last %s: %" PRId64 " us"
 
 # audio_template.h
 audio_open_out(const char *name, int freq, int nchannels, int fmt) "open %s, freq %d, nchannels %d, fmt %d"

-- 
2.53.0


