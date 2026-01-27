Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E07D2FED4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknt9-0003Hj-3d; Tue, 27 Jan 2026 13:34:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vknpA-0004R3-RQ
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:30:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vknp8-0003uw-MD
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:30:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769538598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f2Pjd0su5K0He3AzlPEAFNiJEDUHYmTEYEST1ewVR6w=;
 b=SuKuxj9z8jC8KMDk/oz97yyctWId0vZ2OnSh7yg4YAUCBPa3WVjf5MxpNdbhk15wxEabyr
 imk+dvJlK7zBvQv3R78CKcCFXHk2AyDu3LrC7U0lkGoUYfhwlFE7SJxfKFHdAr48fjQxqu
 rXKNXG6WW+V4aoCTSMUqGknbp2c+nFI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-kKYcGqQGOsqb3fxywZB0GQ-1; Tue,
 27 Jan 2026 13:29:54 -0500
X-MC-Unique: kKYcGqQGOsqb3fxywZB0GQ-1
X-Mimecast-MFC-AGG-ID: kKYcGqQGOsqb3fxywZB0GQ_1769538593
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A22C818941F3; Tue, 27 Jan 2026 18:29:34 +0000 (UTC)
Received: from localhost (unknown [10.45.242.23])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CBC82180097D; Tue, 27 Jan 2026 18:29:32 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 42/43] audio: remove AUD_log/ldebug
Date: Tue, 27 Jan 2026 22:25:09 +0400
Message-ID: <20260127182516.289834-43-marcandre.lureau@redhat.com>
In-Reply-To: <20260127182516.289834-1-marcandre.lureau@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
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

audio/ is now converted to use QEMU standard trace & error reporting.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_int.h       | 14 --------------
 audio/audio_template.h  |  2 +-
 audio/audio-mixeng-be.c | 19 -------------------
 audio/mixeng.c          |  1 -
 4 files changed, 1 insertion(+), 35 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 20ec7883aab..3fc4b516878 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -33,12 +33,6 @@
 #include "qemu/audio-capture.h"
 #include "mixeng.h"
 
-void G_GNUC_PRINTF(2, 0)
-AUD_vlog(const char *cap, const char *fmt, va_list ap);
-
-void G_GNUC_PRINTF(2, 3)
-AUD_log(const char *cap, const char *fmt, ...);
-
 struct audio_callback {
     void *opaque;
     audio_callback_fn fn;
@@ -276,14 +270,6 @@ static inline size_t audio_ring_posb(size_t pos, size_t dist, size_t len)
     return pos >= dist ? pos - dist : len - dist + pos;
 }
 
-#define dolog(fmt, ...) AUD_log(AUDIO_CAP, fmt, ## __VA_ARGS__)
-
-#ifdef DEBUG
-#define ldebug(fmt, ...) AUD_log(AUDIO_CAP, fmt, ## __VA_ARGS__)
-#else
-#define ldebug(fmt, ...) (void)0
-#endif
-
 AudiodevPerDirectionOptions *audio_get_pdo_in(Audiodev *dev);
 AudiodevPerDirectionOptions *audio_get_pdo_out(Audiodev *dev);
 
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 760aaf5f31f..85a128e2f47 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -128,7 +128,7 @@ static int glue (audio_pcm_sw_alloc_resources_, TYPE) (SW *sw)
         /* f_fe_min = ceil(1 [frames] * f_be [Hz] / size_be [frames]) */
         f_fe_min = (f_be + HWBUF.size - 1) / HWBUF.size;
         qemu_log_mask(LOG_UNIMP,
-                      AUDIO_CAP ": The guest selected a " NAME " sample rate"
+                      "audio: The guest selected a " NAME " sample rate"
                       " of %d Hz for %s. Only sample rates >= %" PRIu64 " Hz"
                       " are supported.\n",
                       sw->info.freq, sw->name, f_fe_min);
diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
index 6799b7664b8..2ee05a18055 100644
--- a/audio/audio-mixeng-be.c
+++ b/audio/audio-mixeng-be.c
@@ -26,7 +26,6 @@
 #include "trace.h"
 #include "trace/control.h"
 
-#define AUDIO_CAP "audio"
 #include "audio_int.h"
 
 #define SW_NAME(sw) (sw)->name ? (sw)->name : "unknown"
@@ -68,24 +67,6 @@ static int audio_format_to_index(AudioFormat af)
     g_assert_not_reached();
 }
 
-void AUD_vlog (const char *cap, const char *fmt, va_list ap)
-{
-    if (cap) {
-        fprintf(stderr, "%s: ", cap);
-    }
-
-    vfprintf(stderr, fmt, ap);
-}
-
-void AUD_log (const char *cap, const char *fmt, ...)
-{
-    va_list ap;
-
-    va_start (ap, fmt);
-    AUD_vlog (cap, fmt, ap);
-    va_end (ap);
-}
-
 static char *audsettings_to_string(const struct audsettings *as)
 {
     return g_strdup_printf("frequency=%d nchannels=%d fmt=%s endian=%s",
diff --git a/audio/mixeng.c b/audio/mixeng.c
index e63c76e021d..a209737a913 100644
--- a/audio/mixeng.c
+++ b/audio/mixeng.c
@@ -26,7 +26,6 @@
 #include "qemu/bswap.h"
 #include "qemu/audio.h"
 
-#define AUDIO_CAP "mixeng"
 #include "audio_int.h"
 #ifdef FLOAT_MIXENG
 #include "qemu/error-report.h"
-- 
2.52.0


