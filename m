Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D631E7BD9F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfe-0000Gy-79; Mon, 16 Feb 2026 06:21:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwcz-0007OJ-9n
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:19:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwcx-0008PL-HP
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:18:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VFkfaoxr/ut97cWdnq1cYjjnuVQk6XLSkYyC2tDUZnU=;
 b=VIM2LYGjete46DWD0VlizwdSBHMQOXQyS4oDxMVfJXw/76yN2lNJ7r7sC6TsLP/RCGqLfb
 afpC0zDITQoZyQEY+uVrlLIq8bpwFZGG/xexsZ3vfoZzYsj2g0xgRXputKErqumEBC8RTd
 j+js0dA3kXHoyGYSQziPwxISMP/hVhY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-R09qfEgPMLCnKkap6eOMzQ-1; Mon,
 16 Feb 2026 06:18:51 -0500
X-MC-Unique: R09qfEgPMLCnKkap6eOMzQ-1
X-Mimecast-MFC-AGG-ID: R09qfEgPMLCnKkap6eOMzQ_1771240729
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F4281800259; Mon, 16 Feb 2026 11:18:49 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5BEA618003F5; Mon, 16 Feb 2026 11:18:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:57 +0100
Subject: [PATCH 68/85] audio/sdl: replace custom logging with error_report
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-68-e676662e4514@redhat.com>
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
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Thomas Huth <thuth@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4310;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Gn3WILxoPJAdsQuhXzBqAuStlGu4nqLwJFp2NZ4IZow=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxRETj/q3txCvED93aDLMvSuZ8Ocd/u4aov9
 GG9p9nZp3+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UQAKCRDa6OEJdZac
 5eqUD/97hpvOdcFFIZH/83/e20nye1/j7tZQsFEEejX/jrJ8WNJ7GYy02PJp0miTn2LJ1hI1W6P
 x9di2RYPVlurujFPSsOKQgAQ6+ExFhXP+Q2uVZfg2CTb/bfOuTIAb182dzNuibzcrT+7JiLbwmo
 /W+r8ZsVBf5FVtM6aSV6ceXn35mhMRVRbn/DlsY70UMBmjC4sLgT4R2ETni5ZTJyq7oujoz7kuc
 djhBVnTiFpbz/KYDR5JJKqM6bf7XH2zByQRr+qmRMngRUjyG5SBQJFqmqwCH/dao2DDFiMtjy8B
 +16380/SysbKAyTR8WUr+zj5LTeE9jRmtCzcMSWSykbobvf0114iKJrYFKV0vPb2gUZ/pYlCjvh
 hIXWX3K5tMQhGFw/vDyK64T3JI5RNgPEPYKhNHVEV4VDVVEYOTvBALcCbDK+4KtSUark9Fep+YU
 yKn2w1pzHios0T5b0h3LRBl/FtzlppHXeHo38X8mZVQ38U24i8xjQdRH9D4jvg9BpNMJ+wkQTR4
 Rx6tSPG8PjH+Lw+OmijFvbz2qhJgaX2zE9ngbmCthaEHdXgfWBA4CY+lwd+ecgmc3kDs5FSuTHW
 82vxX1CD4wgFjznXWWV625L+dAvXGR5vrcfRFcD2btn1UsJkp4Lhojrvm0koatBtnCo/sUZ4zsM
 wobr+H3DV3J8afg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Replace the custom audio logging infrastructure (dolog macro and
AUD_log/AUD_vlog) with standard QEMU error reporting (error_report,
error_printf, error_vprintf).

Note that we also dropped the abort() call in DEBUG_AUDIO, as it is not
usually compiled with, doesn't help much, and can easily be added back
when doing development as needed.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 audio/sdlaudio.c | 36 +++++++++---------------------------
 1 file changed, 9 insertions(+), 27 deletions(-)

diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index d974d7eac46..5f332678209 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -26,6 +26,7 @@
 #include <SDL.h>
 #include <SDL_thread.h>
 #include "qemu/module.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu/audio.h"
 #include "qom/object.h"
@@ -38,7 +39,6 @@
 #endif
 #endif
 
-#define AUDIO_CAP "sdl"
 #include "audio_int.h"
 
 #define TYPE_AUDIO_SDL "audio-sdl"
@@ -67,17 +67,6 @@ typedef struct SDLVoiceIn {
     SDL_AudioDeviceID devid;
 } SDLVoiceIn;
 
-static void G_GNUC_PRINTF (1, 2) sdl_logerr (const char *fmt, ...)
-{
-    va_list ap;
-
-    va_start (ap, fmt);
-    AUD_vlog (AUDIO_CAP, fmt, ap);
-    va_end (ap);
-
-    AUD_log (AUDIO_CAP, "Reason: %s\n", SDL_GetError ());
-}
-
 static int aud_to_sdlfmt (AudioFormat fmt)
 {
     switch (fmt) {
@@ -102,10 +91,7 @@ static int aud_to_sdlfmt (AudioFormat fmt)
         return AUDIO_F32LSB;
 
     default:
-        dolog ("Internal logic error: Bad audio format %d\n", fmt);
-#ifdef DEBUG_AUDIO
-        abort ();
-#endif
+        error_report("sdl: internal logic error: bad audio format %d", fmt);
         return AUDIO_U8;
     }
 }
@@ -164,7 +150,7 @@ static int sdl_to_audfmt(int sdlfmt, AudioFormat *fmt, int *endianness)
         break;
 
     default:
-        dolog ("Unrecognized SDL audio format %d\n", sdlfmt);
+        error_report("sdl: unrecognized audio format %d", sdlfmt);
         return -1;
     }
 
@@ -182,27 +168,27 @@ static SDL_AudioDeviceID sdl_open(SDL_AudioSpec *req, SDL_AudioSpec *obt,
     /* Make sure potential threads created by SDL don't hog signals.  */
     err = sigfillset (&new);
     if (err) {
-        dolog ("sdl_open: sigfillset failed: %s\n", strerror (errno));
+        error_report("sdl: sigfillset failed: %s", strerror (errno));
         return 0;
     }
     err = pthread_sigmask (SIG_BLOCK, &new, &old);
     if (err) {
-        dolog ("sdl_open: pthread_sigmask failed: %s\n", strerror (err));
+        error_report("sdl: pthread_sigmask failed: %s", strerror (err));
         return 0;
     }
 #endif
 
     devid = SDL_OpenAudioDevice(NULL, rec, req, obt, 0);
     if (!devid) {
-        sdl_logerr("SDL_OpenAudioDevice for %s failed\n",
-                   rec ? "recording" : "playback");
+        error_report("SDL_OpenAudioDevice for %s failed: %s",
+                   rec ? "recording" : "playback", SDL_GetError());
     }
 
 #ifndef _WIN32
     err = pthread_sigmask (SIG_SETMASK, &old, NULL);
     if (err) {
-        dolog ("sdl_open: pthread_sigmask (restore) failed: %s\n",
-               strerror (errno));
+        error_report("sdl: pthread_sigmask (restore) failed: %s",
+                     strerror (errno));
         /* We have failed to restore original signal mask, all bets are off,
            so exit the process */
         exit (EXIT_FAILURE);
@@ -233,8 +219,6 @@ static void sdl_callback_out(void *opaque, Uint8 *buf, int len)
 
     if (!sdl->exit) {
 
-        /* dolog("callback_out: len=%d avail=%zu\n", len, hw->pending_emul); */
-
         while (hw->pending_emul && len) {
             size_t write_len, start;
 
@@ -283,8 +267,6 @@ static void sdl_callback_in(void *opaque, Uint8 *buf, int len)
         return;
     }
 
-    /* dolog("callback_in: len=%d pending=%zu\n", len, hw->pending_emul); */
-
     while (hw->pending_emul < hw->size_emul && len) {
         size_t read_len = MIN(len, MIN(hw->size_emul - hw->pos_emul,
                                        hw->size_emul - hw->pending_emul));

-- 
2.53.0


