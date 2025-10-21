Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0148CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8K8-0005re-AJ; Tue, 21 Oct 2025 05:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8K5-0005jN-9i
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:06:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8K2-0004Jk-Ht
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761037585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5MPTE8Akx8DrDppQ1jTwOSmdu3PRNzUQfGjGiHQQmoQ=;
 b=D1A7c+7xYgCauZ7JjFgyXoSZ0sqEeuHG9WEwGx1s3oWTaL8x34np8BtYjWkHNpIHT5P3m6
 ODsfnrlP4BbgVWLbzGJU7pBATQP5z7GOo04yF6DSkhypTVkL0eLX5mjwznzlglL+x2yag1
 6/t2WEd7OZd+5NFgTkb3PHb0fqQkI7s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-Ub9OROPtOQ2e4ATRYFGpow-1; Tue,
 21 Oct 2025 05:06:23 -0400
X-MC-Unique: Ub9OROPtOQ2e4ATRYFGpow-1
X-Mimecast-MFC-AGG-ID: Ub9OROPtOQ2e4ATRYFGpow_1761037582
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9FC319560B7; Tue, 21 Oct 2025 09:06:22 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8674630001BE; Tue, 21 Oct 2025 09:06:21 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 33/43] audio: move internal APIs to audio_int.h
Date: Tue, 21 Oct 2025 13:03:04 +0400
Message-ID: <20251021090317.425409-34-marcandre.lureau@redhat.com>
In-Reply-To: <20251021090317.425409-1-marcandre.lureau@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio.h          | 21 ---------------------
 audio/audio_int.h      | 22 ++++++++++++++++++++++
 audio/audio-hmp-cmds.c |  2 +-
 audio/wavcapture.c     |  2 +-
 4 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index 91e8a4f23d..1858b930ca 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -38,15 +38,6 @@ typedef struct audsettings {
     int endianness;
 } audsettings;
 
-audsettings audiodev_to_audsettings(AudiodevPerDirectionOptions *pdo);
-int audioformat_bytes_per_sample(AudioFormat fmt);
-int audio_buffer_frames(AudiodevPerDirectionOptions *pdo,
-                        audsettings *as, int def_usecs);
-int audio_buffer_samples(AudiodevPerDirectionOptions *pdo,
-                         audsettings *as, int def_usecs);
-int audio_buffer_bytes(AudiodevPerDirectionOptions *pdo,
-                       audsettings *as, int def_usecs);
-
 typedef enum {
     AUD_CNOTIFY_ENABLE,
     AUD_CNOTIFY_DISABLE
@@ -89,9 +80,6 @@ typedef struct QEMUAudioTimeStamp {
     uint64_t old_ts;
 } QEMUAudioTimeStamp;
 
-void AUD_vlog (const char *cap, const char *fmt, va_list ap) G_GNUC_PRINTF(2, 0);
-void AUD_log (const char *cap, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
-
 bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp);
 void AUD_remove_card (QEMUSoundCard *card);
 CaptureVoiceOut *AUD_add_capture(
@@ -150,15 +138,6 @@ int  AUD_is_active_in (SWVoiceIn *sw);
 void     AUD_init_time_stamp_in (SWVoiceIn *sw, QEMUAudioTimeStamp *ts);
 uint64_t AUD_get_elapsed_usec_in (SWVoiceIn *sw, QEMUAudioTimeStamp *ts);
 
-static inline void *advance (void *p, int incr)
-{
-    uint8_t *d = p;
-    return (d + incr);
-}
-
-int wav_start_capture(AudioState *state, CaptureState *s, const char *path,
-                      int freq, int bits, int nchannels);
-
 void audio_cleanup(void);
 
 typedef struct st_sample st_sample;
diff --git a/audio/audio_int.h b/audio/audio_int.h
index 4a4d69f2bf..cc7a6fe087 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -29,12 +29,16 @@
 #define FLOAT_MIXENG
 /* #define RECIPROCAL */
 #endif
+#include "audio.h"
 #include "mixeng.h"
 
 #ifdef CONFIG_GIO
 #include <gio/gio.h>
 #endif
 
+void AUD_vlog (const char *cap, const char *fmt, va_list ap) G_GNUC_PRINTF(2, 0);
+void AUD_log (const char *cap, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
+
 struct audio_pcm_ops;
 
 struct audio_callback {
@@ -187,6 +191,24 @@ struct audio_pcm_ops {
     void   (*volume_in)(HWVoiceIn *hw, Volume *vol);
 };
 
+audsettings audiodev_to_audsettings(AudiodevPerDirectionOptions *pdo);
+int audioformat_bytes_per_sample(AudioFormat fmt);
+int audio_buffer_frames(AudiodevPerDirectionOptions *pdo,
+                        audsettings *as, int def_usecs);
+int audio_buffer_samples(AudiodevPerDirectionOptions *pdo,
+                         audsettings *as, int def_usecs);
+int audio_buffer_bytes(AudiodevPerDirectionOptions *pdo,
+                       audsettings *as, int def_usecs);
+
+static inline void *advance (void *p, int incr)
+{
+    uint8_t *d = p;
+    return (d + incr);
+}
+
+int wav_start_capture(AudioState *state, CaptureState *s, const char *path,
+                      int freq, int bits, int nchannels);
+
 void audio_generic_run_buffer_in(HWVoiceIn *hw);
 void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size);
 void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size);
diff --git a/audio/audio-hmp-cmds.c b/audio/audio-hmp-cmds.c
index 8774c09f18..819f8fa9d8 100644
--- a/audio/audio-hmp-cmds.c
+++ b/audio/audio-hmp-cmds.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "audio/audio.h"
+#include "audio_int.h"
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
diff --git a/audio/wavcapture.c b/audio/wavcapture.c
index b990844d48..0fbc695d23 100644
--- a/audio/wavcapture.c
+++ b/audio/wavcapture.c
@@ -1,7 +1,7 @@
 #include "qemu/osdep.h"
 #include "qemu/qemu-print.h"
 #include "qemu/error-report.h"
-#include "audio.h"
+#include "audio_int.h"
 
 typedef struct {
     FILE *f;
-- 
2.51.0


