Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B31E7BD9D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfc-000090-Pj; Mon, 16 Feb 2026 06:21:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwcm-00075e-Hj
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:18:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwci-0008Hn-Jo
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:18:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hxleiIuMmSQxAplkZkRImBt1hhK43Xtyj3HdkAU9nk4=;
 b=Wx5mx7LoyIkXItaQHACsYHil6ZuX4qszfYnUrLxxCsqNZ3+x5UpraFBwKZ8FO6OFetUOlj
 fCZ6QFF9xRDycqI/MpP9UK8BrBQH07LD3XzWxk12ljn0oStnciA+1jTnBLNd/1hG0fXPvO
 5n91xhrxarYhIaVWAbqElaNmCJBSfnU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-Ov7S36wAPRCG5fbdAF4h1w-1; Mon,
 16 Feb 2026 06:18:35 -0500
X-MC-Unique: Ov7S36wAPRCG5fbdAF4h1w-1
X-Mimecast-MFC-AGG-ID: Ov7S36wAPRCG5fbdAF4h1w_1771240713
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B05DA1954B34; Mon, 16 Feb 2026 11:18:33 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EAD4819560AD; Mon, 16 Feb 2026 11:18:32 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:51 +0100
Subject: [PATCH 62/85] audio/dsound: replace custom logging with
 error_report & trace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-62-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=21303;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=5rlLKZYChnAU7rxWYkldvo1LS6BroTN0lrE9LwrT7vU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxReoWbj5FukBIihc8PV7DcL64s7eWJWS6OX
 9/KJbTEsPuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UQAKCRDa6OEJdZac
 5XmFD/9DPJEWxNt8e7oRJggBnpreYniCdEMzO0m2ScEPVXDg6QZHRa688RxBGJ/utR2W+sWYJeZ
 hJ/1cWNHbIjIYV4TO+lon4QAe2I5BOi6oVViaEcTAuZ7YYKFGevNn9psEWUNlFNFIBqWPNQfsvs
 1T6u33yji5I/o0lYRwb4bktc7WtLgVdYInRA+wrDtjjST2EOzkDFmM2FdZ7udk7E1SLxjHij6dK
 Cq7SLfbp/87MSHeFmzhBUokV2nkd7opCiGT137B8q2bC4XyScHHLl2wBL5Zq5gHPLb5LKNPwYbE
 yS8OIY0dFrYi1Io9Umx+kf1H8Ux87uhj3ixSSm+yOSuiqaGF0QnKmR9MnjPp4m58tR3DooTOsnh
 aH5hRk3WAGnctN3kPexhS6KrQxg+N+3pcMkNRUjQiJAksAiJONTAnW9WJww8j2qbfb8zGjJe5mP
 ST2fWrufRC0/zaUtOBwD/No5E09F7ao1IAfQVtfGCHiiDBuWhvgab86iqxKVLfZsv/hzIQmi9ui
 6dFnt3VjC743PZTvviOlMZLd8IggWp0Ado26IMDc2WJrNnx5gdLo1qHFKwbrSXM0Qq7jG6Sg5ud
 OL6z0y1LNCaLntBpt9lulox9RJ6Yd7NZIu6PH2/CqmCbY8/Kbni+pQm99XFwPWT8P+a2FWoOJfP
 /OvF6ssn+9d6htA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

The DirectSound audio backend uses its own logging infrastructure
(AUD_log, AUD_vlog, dolog) and the AUDIO_CAP macro. This approach is
inconsistent with the rest of QEMU and makes the output harder to
filter and configure.

Replace the custom logging with standard QEMU error reporting.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/dsound_template.h |  72 ++++++++++++--------------
 audio/audio_win_int.c   |  31 ++++++-----
 audio/dsoundaudio.c     | 134 +++++++++++++++++++-----------------------------
 audio/trace-events      |   5 ++
 4 files changed, 108 insertions(+), 134 deletions(-)

diff --git a/audio/dsound_template.h b/audio/dsound_template.h
index 022a7307c99..af4019bcb34 100644
--- a/audio/dsound_template.h
+++ b/audio/dsound_template.h
@@ -53,9 +53,9 @@ static int glue (dsound_unlock_, TYPE) (
 {
     HRESULT hr;
 
-    hr = glue (IFACE, _Unlock) (buf, p1, blen1, p2, blen2);
-    if (FAILED (hr)) {
-        dsound_logerr (hr, "Could not unlock " NAME "\n");
+    hr = glue(IFACE, _Unlock)(buf, p1, blen1, p2, blen2);
+    if (FAILED(hr)) {
+        dsound_logerr(hr, "Could not unlock " NAME);
         return -1;
     }
 
@@ -85,35 +85,35 @@ static int glue (dsound_lock_, TYPE) (
 #endif
     hr = glue(IFACE, _Lock)(buf, pos, len, p1p, blen1p, p2p, blen2p, flag);
 
-    if (FAILED (hr)) {
+    if (FAILED(hr)) {
 #ifndef DSBTYPE_IN
         if (hr == DSERR_BUFFERLOST) {
-            if (glue (dsound_restore_, TYPE) (buf, s)) {
-                dsound_logerr (hr, "Could not lock " NAME "\n");
+            if (glue(dsound_restore_, TYPE)(buf, s)) {
+                dsound_logerr(hr, "Could not lock " NAME);
             }
             goto fail;
         }
 #endif
-        dsound_logerr (hr, "Could not lock " NAME "\n");
+        dsound_logerr(hr, "Could not lock " NAME);
         goto fail;
     }
 
     if ((p1p && *p1p && (*blen1p % info->bytes_per_frame)) ||
         (p2p && *p2p && (*blen2p % info->bytes_per_frame))) {
-        dolog("DirectSound returned misaligned buffer %ld %ld\n",
-              *blen1p, *blen2p);
+        error_report("dsound: returned misaligned buffer %ld %ld",
+                     *blen1p, *blen2p);
         glue(dsound_unlock_, TYPE)(buf, *p1p, p2p ? *p2p : NULL, *blen1p,
                                    blen2p ? *blen2p : 0);
         goto fail;
     }
 
     if (p1p && !*p1p && *blen1p) {
-        dolog("warning: !p1 && blen1=%ld\n", *blen1p);
+        warn_report("dsound: !p1 && blen1=%ld", *blen1p);
         *blen1p = 0;
     }
 
     if (p2p && !*p2p && *blen2p) {
-        dolog("warning: !p2 && blen2=%ld\n", *blen2p);
+        warn_report("dsound: !p2 && blen2=%ld", *blen2p);
         *blen2p = 0;
     }
 
@@ -143,14 +143,14 @@ static void dsound_fini_out (HWVoiceOut *hw)
 #endif
 
     if (ds->FIELD) {
-        hr = glue (IFACE, _Stop) (ds->FIELD);
-        if (FAILED (hr)) {
-            dsound_logerr (hr, "Could not stop " NAME "\n");
+        hr = glue(IFACE, _Stop)(ds->FIELD);
+        if (FAILED(hr)) {
+            dsound_logerr(hr, "Could not stop " NAME);
         }
 
-        hr = glue (IFACE, _Release) (ds->FIELD);
-        if (FAILED (hr)) {
-            dsound_logerr (hr, "Could not release " NAME "\n");
+        hr = glue(IFACE, _Release)(ds->FIELD);
+        if (FAILED(hr)) {
+            dsound_logerr(hr, "Could not release " NAME);
         }
         ds->FIELD = NULL;
     }
@@ -182,7 +182,8 @@ static int dsound_init_out(HWVoiceOut *hw, struct audsettings *as)
 #endif
 
     if (!s->FIELD2) {
-        dolog ("Attempt to initialize voice without " NAME2 " object\n");
+        error_report("dsound: Attempt to initialize voice without "
+                     NAME2 " object");
         return -1;
     }
 
@@ -212,28 +213,28 @@ static int dsound_init_out(HWVoiceOut *hw, struct audsettings *as)
         );
 #endif
 
-    if (FAILED (hr)) {
-        dsound_logerr2 (hr, typ, "Could not create " NAME "\n");
+    if (FAILED(hr)) {
+        dsound_logerr2(hr, typ, "Could not create " NAME);
         return -1;
     }
 
-    hr = glue (IFACE, _GetFormat) (ds->FIELD, &wfx, sizeof (wfx), NULL);
-    if (FAILED (hr)) {
-        dsound_logerr2 (hr, typ, "Could not get " NAME " format\n");
+    hr = glue(IFACE, _GetFormat)(ds->FIELD, &wfx, sizeof(wfx), NULL);
+    if (FAILED(hr)) {
+        dsound_logerr2(hr, typ, "Could not get " NAME " format");
         goto fail0;
     }
 
-#ifdef DEBUG_DSOUND
-    dolog (NAME "\n");
-    print_wave_format (&wfx);
-#endif
+    trace_dsound_wave_format(
+        wfx.wFormatTag, wfx.nChannels,
+        wfx.nSamplesPerSec, wfx.nAvgBytesPerSec,
+        wfx.nBlockAlign, wfx.wBitsPerSample, wfx.cbSize);
 
     memset (&bc, 0, sizeof (bc));
     bc.dwSize = sizeof (bc);
 
-    hr = glue (IFACE, _GetCaps) (ds->FIELD, &bc);
-    if (FAILED (hr)) {
-        dsound_logerr2 (hr, typ, "Could not get " NAME " format\n");
+    hr = glue(IFACE, _GetCaps)(ds->FIELD, &bc);
+    if (FAILED(hr)) {
+        dsound_logerr2(hr, typ, "Could not get " NAME " caps");
         goto fail0;
     }
 
@@ -247,18 +248,13 @@ static int dsound_init_out(HWVoiceOut *hw, struct audsettings *as)
     audio_pcm_init_info (&hw->info, &obt_as);
 
     if (bc.dwBufferBytes % hw->info.bytes_per_frame) {
-        dolog (
-            "GetCaps returned misaligned buffer size %ld, alignment %d\n",
-            bc.dwBufferBytes, hw->info.bytes_per_frame
-            );
+        warn_report("dsound: GetCaps returned misaligned buffer size %ld, "
+                    "alignment %d", bc.dwBufferBytes, hw->info.bytes_per_frame);
     }
     hw->size_emul = bc.dwBufferBytes;
     hw->samples = bc.dwBufferBytes / hw->info.bytes_per_frame;
 
-#ifdef DEBUG_DSOUND
-    dolog ("caps %ld, desc %ld\n",
-           bc.dwBufferBytes, bd.dwBufferBytes);
-#endif
+    trace_dsound_buffer_bytes(bc.dwBufferBytes, bd.dwBufferBytes);
     return 0;
 
  fail0:
diff --git a/audio/audio_win_int.c b/audio/audio_win_int.c
index 44a8ff24a6f..ecd599c87de 100644
--- a/audio/audio_win_int.c
+++ b/audio/audio_win_int.c
@@ -2,12 +2,12 @@
 
 #include "qemu/osdep.h"
 
-#define AUDIO_CAP "win-int"
 #include <windows.h>
 #include <mmreg.h>
 #include <mmsystem.h>
 
 #include "qemu/audio.h"
+#include "qemu/error-report.h"
 #include "audio_int.h"
 #include "audio_win_int.h"
 
@@ -53,7 +53,7 @@ int waveformat_from_audio_settings (WAVEFORMATEX *wfx,
         break;
 
     default:
-        dolog("Internal logic error: Bad audio format %d\n", as->fmt);
+        error_report("dsound: Internal logic error: Bad audio format %d", as->fmt);
         return -1;
     }
 
@@ -64,7 +64,7 @@ int waveformat_to_audio_settings (WAVEFORMATEX *wfx,
                                   struct audsettings *as)
 {
     if (!wfx->nSamplesPerSec) {
-        dolog ("Invalid wave format, frequency is zero\n");
+        error_report("dsound: Invalid wave format, frequency is zero");
         return -1;
     }
     as->freq = wfx->nSamplesPerSec;
@@ -79,10 +79,9 @@ int waveformat_to_audio_settings (WAVEFORMATEX *wfx,
         break;
 
     default:
-        dolog (
-            "Invalid wave format, number of channels is not 1 or 2, but %d\n",
-            wfx->nChannels
-            );
+        error_report("dsound: Invalid wave format, "
+                     "number of channels is not 1 or 2, but %d",
+                     wfx->nChannels);
         return -1;
     }
 
@@ -101,9 +100,9 @@ int waveformat_to_audio_settings (WAVEFORMATEX *wfx,
             break;
 
         default:
-            dolog("Invalid PCM wave format, bits per sample is not "
-                  "8, 16 or 32, but %d\n",
-                  wfx->wBitsPerSample);
+            error_report("dsound: Invalid PCM wave format, bits per sample is not "
+                         "8, 16 or 32, but %d",
+                         wfx->wBitsPerSample);
             return -1;
         }
     } else if (wfx->wFormatTag == WAVE_FORMAT_IEEE_FLOAT) {
@@ -113,15 +112,15 @@ int waveformat_to_audio_settings (WAVEFORMATEX *wfx,
             break;
 
         default:
-            dolog("Invalid IEEE_FLOAT wave format, bits per sample is not "
-                  "32, but %d\n",
-                  wfx->wBitsPerSample);
+            error_report("dsound: Invalid IEEE_FLOAT wave format, "
+                         "bits per sample is not 32, but %d",
+                         wfx->wBitsPerSample);
             return -1;
         }
     } else {
-        dolog("Invalid wave format, tag is not PCM and not IEEE_FLOAT, "
-              "but %d\n",
-              wfx->wFormatTag);
+        error_report("dsound: Invalid wave format, "
+                     "tag is not PCM and not IEEE_FLOAT, but %d",
+                     wfx->wFormatTag);
         return -1;
     }
 
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 2c592c56663..704bc3da73b 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -28,8 +28,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/audio.h"
-
-#define AUDIO_CAP "dsound"
+#include "qemu/error-report.h"
 #include "audio_int.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
@@ -40,6 +39,7 @@
 #include <objbase.h>
 #include <dsound.h>
 
+#include "trace.h"
 #include "audio_win_int.h"
 
 #define TYPE_AUDIO_DSOUND "audio-dsound"
@@ -55,9 +55,6 @@ struct AudioDsound {
     struct audsettings settings;
 };
 
-
-/* #define DEBUG_DSOUND */
-
 typedef struct {
     HWVoiceOut hw;
     LPDIRECTSOUNDBUFFER dsound_buffer;
@@ -214,56 +211,37 @@ static void dsound_log_hresult(HRESULT hr)
     const char *str = dserror(hr);
 
     if (str) {
-        AUD_log (AUDIO_CAP, "Reason: %s\n", str);
+        error_printf(" Reason: %s", str);
     } else {
-        AUD_log (AUDIO_CAP, "Reason: Unknown (HRESULT: 0x%lx)\n", hr);
+        error_printf(" Reason: Unknown (HRESULT: 0x%lx)", hr);
     }
 }
 
-static void G_GNUC_PRINTF (2, 3) dsound_logerr (
-    HRESULT hr,
-    const char *fmt,
-    ...
-    )
+static void G_GNUC_PRINTF(2, 3) dsound_logerr(HRESULT hr, const char *fmt, ...)
 {
     va_list ap;
 
-    va_start (ap, fmt);
-    AUD_vlog (AUDIO_CAP, fmt, ap);
-    va_end (ap);
-
-    dsound_log_hresult (hr);
+    error_printf("dsound: ");
+    va_start(ap, fmt);
+    error_vprintf(fmt, ap);
+    va_end(ap);
+    dsound_log_hresult(hr);
+    error_printf("\n");
 }
 
-static void G_GNUC_PRINTF (3, 4) dsound_logerr2 (
-    HRESULT hr,
-    const char *typ,
-    const char *fmt,
-    ...
-    )
+static void G_GNUC_PRINTF(3, 4) dsound_logerr2(HRESULT hr, const char *typ,
+                                               const char *fmt, ...)
 {
     va_list ap;
 
-    AUD_log (AUDIO_CAP, "Could not initialize %s\n", typ);
-    va_start (ap, fmt);
-    AUD_vlog (AUDIO_CAP, fmt, ap);
-    va_end (ap);
-
-    dsound_log_hresult (hr);
+    error_printf("dsound: Could not initialize %s: ", typ);
+    va_start(ap, fmt);
+    error_vprintf(fmt, ap);
+    va_end(ap);
+    dsound_log_hresult(hr);
+    error_printf("\n");
 }
 
-#ifdef DEBUG_DSOUND
-static void print_wave_format (WAVEFORMATEX *wfx)
-{
-    dolog ("tag             = %d\n", wfx->wFormatTag);
-    dolog ("nChannels       = %d\n", wfx->nChannels);
-    dolog ("nSamplesPerSec  = %ld\n", wfx->nSamplesPerSec);
-    dolog ("nAvgBytesPerSec = %ld\n", wfx->nAvgBytesPerSec);
-    dolog ("nBlockAlign     = %d\n", wfx->nBlockAlign);
-    dolog ("wBitsPerSample  = %d\n", wfx->wBitsPerSample);
-    dolog ("cbSize          = %d\n", wfx->cbSize);
-}
-#endif
 
 static int dsound_restore_out (LPDIRECTSOUNDBUFFER dsb, AudioDsound *s)
 {
@@ -272,7 +250,7 @@ static int dsound_restore_out (LPDIRECTSOUNDBUFFER dsb, AudioDsound *s)
     hr = IDirectSoundBuffer_Restore (dsb);
 
     if (hr != DS_OK) {
-        dsound_logerr (hr, "Could not restore playback buffer\n");
+        dsound_logerr(hr, "Could not restore playback buffer");
         return -1;
     }
     return 0;
@@ -290,7 +268,7 @@ static int dsound_get_status_out (LPDIRECTSOUNDBUFFER dsb, DWORD *statusp,
 
     hr = IDirectSoundBuffer_GetStatus (dsb, statusp);
     if (FAILED (hr)) {
-        dsound_logerr (hr, "Could not get playback buffer status\n");
+        dsound_logerr(hr, "Could not get playback buffer status");
         return -1;
     }
 
@@ -309,7 +287,7 @@ static int dsound_get_status_in (LPDIRECTSOUNDCAPTUREBUFFER dscb,
 
     hr = IDirectSoundCaptureBuffer_GetStatus (dscb, statusp);
     if (FAILED (hr)) {
-        dsound_logerr (hr, "Could not get capture buffer status\n");
+        dsound_logerr(hr, "Could not get capture buffer status");
         return -1;
     }
 
@@ -340,11 +318,7 @@ static void dsound_clear_sample (HWVoiceOut *hw, LPDIRECTSOUNDBUFFER dsb,
     len1 = blen1 / hw->info.bytes_per_frame;
     len2 = blen2 / hw->info.bytes_per_frame;
 
-#ifdef DEBUG_DSOUND
-    dolog ("clear %p,%ld,%ld %p,%ld,%ld\n",
-           p1, blen1, len1,
-           p2, blen2, len2);
-#endif
+    trace_dsound_clear_sample(p1, blen1, len1, p2, blen2, len2);
 
     if (p1 && len1) {
         audio_pcm_info_clear_buf (&hw->info, p1, len1);
@@ -366,40 +340,40 @@ static void dsound_enable_out(HWVoiceOut *hw, bool enable)
     LPDIRECTSOUNDBUFFER dsb = ds->dsound_buffer;
 
     if (!dsb) {
-        dolog ("Attempt to control voice without a buffer\n");
+        error_report("dsound: Attempt to control voice without a buffer");
         return;
     }
 
     if (enable) {
-        if (dsound_get_status_out (dsb, &status, s)) {
+        if (dsound_get_status_out(dsb, &status, s)) {
             return;
         }
 
         if (status & DSBSTATUS_PLAYING) {
-            dolog ("warning: Voice is already playing\n");
+            warn_report("dsound: Voice is already playing");
             return;
         }
 
-        dsound_clear_sample (hw, dsb, s);
+        dsound_clear_sample(hw, dsb, s);
 
-        hr = IDirectSoundBuffer_Play (dsb, 0, 0, DSBPLAY_LOOPING);
-        if (FAILED (hr)) {
-            dsound_logerr (hr, "Could not start playing buffer\n");
+        hr = IDirectSoundBuffer_Play(dsb, 0, 0, DSBPLAY_LOOPING);
+        if (FAILED(hr)) {
+            dsound_logerr(hr, "Could not start playing buffer");
             return;
         }
     } else {
-        if (dsound_get_status_out (dsb, &status, s)) {
+        if (dsound_get_status_out(dsb, &status, s)) {
             return;
         }
 
         if (status & DSBSTATUS_PLAYING) {
-            hr = IDirectSoundBuffer_Stop (dsb);
-            if (FAILED (hr)) {
-                dsound_logerr (hr, "Could not stop playing buffer\n");
+            hr = IDirectSoundBuffer_Stop(dsb);
+            if (FAILED(hr)) {
+                dsound_logerr(hr, "Could not stop playing buffer");
                 return;
             }
         } else {
-            dolog ("warning: Voice is not playing\n");
+            warn_report("dsound: Voice is not playing");
         }
     }
 }
@@ -414,7 +388,7 @@ static size_t dsound_buffer_get_free(HWVoiceOut *hw)
     hr = IDirectSoundBuffer_GetCurrentPosition(
         dsb, &ppos, ds->first_time ? &wpos : NULL);
     if (FAILED(hr)) {
-        dsound_logerr(hr, "Could not get playback buffer position\n");
+        dsound_logerr(hr, "Could not get playback buffer position");
         return 0;
     }
 
@@ -441,7 +415,7 @@ static void *dsound_get_buffer_out(HWVoiceOut *hw, size_t *size)
     err = dsound_lock_out(dsb, &hw->info, hw->pos_emul, req_size, &ret, NULL,
                           &act_size, NULL, false, AUDIO_DSOUND(hw->s));
     if (err) {
-        dolog("Failed to lock buffer\n");
+        error_report("dsound: Failed to lock buffer");
         *size = 0;
         return NULL;
     }
@@ -457,7 +431,7 @@ static size_t dsound_put_buffer_out(HWVoiceOut *hw, void *buf, size_t len)
     int err = dsound_unlock_out(dsb, buf, NULL, len, 0);
 
     if (err) {
-        dolog("Failed to unlock buffer!!\n");
+        error_report("dsound: Failed to unlock buffer");
         return 0;
     }
     hw->pos_emul = (hw->pos_emul + len) % hw->size_emul;
@@ -473,40 +447,40 @@ static void dsound_enable_in(HWVoiceIn *hw, bool enable)
     LPDIRECTSOUNDCAPTUREBUFFER dscb = ds->dsound_capture_buffer;
 
     if (!dscb) {
-        dolog ("Attempt to control capture voice without a buffer\n");
+        error_report("dsound: Attempt to control capture voice without a buffer");
         return;
     }
 
     if (enable) {
-        if (dsound_get_status_in (dscb, &status)) {
+        if (dsound_get_status_in(dscb, &status)) {
             return;
         }
 
         if (status & DSCBSTATUS_CAPTURING) {
-            dolog ("warning: Voice is already capturing\n");
+            warn_report("dsound: Voice is already capturing");
             return;
         }
 
         /* clear ?? */
 
-        hr = IDirectSoundCaptureBuffer_Start (dscb, DSCBSTART_LOOPING);
-        if (FAILED (hr)) {
-            dsound_logerr (hr, "Could not start capturing\n");
+        hr = IDirectSoundCaptureBuffer_Start(dscb, DSCBSTART_LOOPING);
+        if (FAILED(hr)) {
+            dsound_logerr(hr, "Could not start capturing");
             return;
         }
     } else {
-        if (dsound_get_status_in (dscb, &status)) {
+        if (dsound_get_status_in(dscb, &status)) {
             return;
         }
 
         if (status & DSCBSTATUS_CAPTURING) {
-            hr = IDirectSoundCaptureBuffer_Stop (dscb);
-            if (FAILED (hr)) {
-                dsound_logerr (hr, "Could not stop capturing\n");
+            hr = IDirectSoundCaptureBuffer_Stop(dscb);
+            if (FAILED(hr)) {
+                dsound_logerr(hr, "Could not stop capturing");
                 return;
             }
         } else {
-            dolog ("warning: Voice is not capturing\n");
+            warn_report("dsound: Voice is not capturing");
         }
     }
 }
@@ -523,7 +497,7 @@ static void *dsound_get_buffer_in(HWVoiceIn *hw, size_t *size)
 
     hr = IDirectSoundCaptureBuffer_GetCurrentPosition(dscb, NULL, &rpos);
     if (FAILED(hr)) {
-        dsound_logerr(hr, "Could not get capture buffer position\n");
+        dsound_logerr(hr, "Could not get capture buffer position");
         *size = 0;
         return NULL;
     }
@@ -544,7 +518,7 @@ static void *dsound_get_buffer_in(HWVoiceIn *hw, size_t *size)
     err = dsound_lock_in(dscb, &hw->info, hw->pos_emul, req_size, &ret, NULL,
                          &act_size, NULL, false, AUDIO_DSOUND(hw->s));
     if (err) {
-        dolog("Failed to lock buffer\n");
+        error_report("dsound: Failed to lock buffer");
         *size = 0;
         return NULL;
     }
@@ -560,7 +534,7 @@ static void dsound_put_buffer_in(HWVoiceIn *hw, void *buf, size_t len)
     int err = dsound_unlock_in(dscb, buf, NULL, len, 0);
 
     if (err) {
-        dolog("Failed to unlock buffer!!\n");
+        error_report("dsound: Failed to unlock buffer");
         return;
     }
     hw->pos_emul = (hw->pos_emul + len) % hw->size_emul;
@@ -577,7 +551,7 @@ static void audio_dsound_finalize(Object *obj)
 
     hr = IDirectSound_Release (s->dsound);
     if (FAILED (hr)) {
-        dsound_logerr (hr, "Could not release DirectSound\n");
+        dsound_logerr(hr, "Could not release DirectSound");
     }
     s->dsound = NULL;
 
@@ -587,7 +561,7 @@ static void audio_dsound_finalize(Object *obj)
 
     hr = IDirectSoundCapture_Release (s->dsound_capture);
     if (FAILED (hr)) {
-        dsound_logerr (hr, "Could not release DirectSoundCapture\n");
+        dsound_logerr(hr, "Could not release DirectSoundCapture");
     }
     s->dsound_capture = NULL;
 }
diff --git a/audio/trace-events b/audio/trace-events
index 737e3e60694..b2f29666700 100644
--- a/audio/trace-events
+++ b/audio/trace-events
@@ -23,6 +23,11 @@ dbus_audio_register(const char *s, const char *dir) "sender = %s, dir = %s"
 dbus_audio_put_buffer_out(size_t pos, size_t size) "buf_pos = %zu, buf_size = %zu"
 dbus_audio_read(size_t len) "len = %zu"
 
+# dsoundaudio.c
+dsound_clear_sample(void *p1, uint32_t blen1, uint32_t len1, void *p2, uint32_t blen2, uint32_t len2) "p1=%p, blen1=%u, len1=%u, p2=%p, blen2=%u, len2=%u"
+dsound_wave_format(uint16_t wFormatTag, uint16_t nChannels, uint32_t nSamplesPerSec, uint32_t nAvgBytesPerSec, uint16_t nBlockAlign, uint16_t wBitsPerSample, uint16_t cbSize) "wFormatTag=%u, nChannels=%u, nSamplesPerSec=%u, nAvgBytesPerSec=%u, nBlockAlign=%u, wBitsPerSample=%u, cbSize=%u"
+dsound_buffer_bytes(uint32_t caps_bytes, uint32_t desc_bytes) "caps_bytes=%u, desc_bytes=%u"
+
 # pwaudio.c
 pw_state_changed(int nodeid, const char *s) "node id: %d stream state: %s"
 pw_read(int32_t avail, uint32_t index, size_t len) "avail=%d index=%u len=%zu"

-- 
2.53.0


