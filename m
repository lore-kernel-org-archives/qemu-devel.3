Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2951DCCD1BE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 07:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBSpD-0000am-GK; Wed, 22 Oct 2025 02:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSpC-0000aK-BP
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:59:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBSpA-0008OD-37
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761116394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CH7P42O24akCrSS/HXFEvKJEwmzuKXQF/eDHOvR5Gsg=;
 b=Iavq6PA/2XcfY5O+8rm93rLwTfnfvXgL0NzK/2QKW5COrO6IfzjVmSRpu/s4QhKCrtF+mn
 aeW3dxi+VCsVLViRokyavq58kYtHxQ8NXnLzhjtYUw4qRAZB5ZY+/oa6Hp1YNH4d9BorKX
 EKm0PunQZDb4fNCxwXC2b4WRwuCesiA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-ru_qw45FOOSUYq9BITfQiA-1; Wed,
 22 Oct 2025 02:59:50 -0400
X-MC-Unique: ru_qw45FOOSUYq9BITfQiA-1
X-Mimecast-MFC-AGG-ID: ru_qw45FOOSUYq9BITfQiA_1761116389
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C778E195608A; Wed, 22 Oct 2025 06:59:49 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7EC7D1956056; Wed, 22 Oct 2025 06:59:48 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 33/42] audio: move internal APIs to audio_int.h
Date: Wed, 22 Oct 2025 10:56:28 +0400
Message-ID: <20251022065640.1172785-34-marcandre.lureau@redhat.com>
In-Reply-To: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
References: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
index 68509fed58..b8b9715896 100644
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
@@ -88,9 +79,6 @@ typedef struct QEMUAudioTimeStamp {
     uint64_t old_ts;
 } QEMUAudioTimeStamp;
 
-void AUD_vlog (const char *cap, const char *fmt, va_list ap) G_GNUC_PRINTF(2, 0);
-void AUD_log (const char *cap, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
-
 bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp);
 void AUD_remove_card (QEMUSoundCard *card);
 CaptureVoiceOut *AUD_add_capture(
@@ -149,15 +137,6 @@ int  AUD_is_active_in (SWVoiceIn *sw);
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


