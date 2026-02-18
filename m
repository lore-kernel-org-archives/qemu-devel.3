Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11671E9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsdWz-0000sN-HJ; Wed, 18 Feb 2026 04:07:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdW3-0000OS-JY
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:06:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdW0-0002OP-VA
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771405596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vk+tuv/N/RyMuDjUwsZcUAlFQUcm2Bq9JgF070ZHc08=;
 b=ZzYj30ikH8rHl0bPdMr/BINkk7RDQEgWv6eylapsoypztnYymLqzC/a2M+oPaXJ2Und7r5
 RSakubJbwm2Au+ddPsNxI9P26qgiuUN0XD6bscNMsk39U8nRhvnrLq3MZlkaPZFKKHwNnK
 EM7UDcReSzNd6nHXnw9Jg9tLCnoiWNI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-2f4deptLND2nDM9gK6Im-Q-1; Wed,
 18 Feb 2026 04:06:33 -0500
X-MC-Unique: 2f4deptLND2nDM9gK6Im-Q-1
X-Mimecast-MFC-AGG-ID: 2f4deptLND2nDM9gK6Im-Q_1771405592
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2ED62180034A; Wed, 18 Feb 2026 09:06:32 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 150291956095; Wed, 18 Feb 2026 09:06:30 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: [PULL 59/85] audio/alsa: replace custom logging with error_report and
 trace events
Date: Wed, 18 Feb 2026 10:02:59 +0100
Message-ID: <20260218090330.1476169-60-marcandre.lureau@redhat.com>
In-Reply-To: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
References: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
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

The ALSA audio backend uses its own logging infrastructure (AUD_log,
AUD_vlog, dolog, ldebug) and a custom alsa_dump_info() debug helper.
This approach is inconsistent with the rest of QEMU and makes the
output harder to filter and configure.

Replace the custom logging with standard QEMU error reporting:
- Use error_report() / error_printf() for errors
- Use warn_report() for non-fatal warnings (invalid formats,
  rejected parameters, unexpected states)
- Convert ldebug() calls and alsa_dump_info() to trace events

Remove DEBUG_ALSA and AUDIO_CAP macros which are no longer needed.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/alsaaudio.c  | 169 ++++++++++++++++++---------------------------
 audio/trace-events |   5 ++
 2 files changed, 72 insertions(+), 102 deletions(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 8f226b42612..889240ad0c7 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -26,17 +26,15 @@
 #include <alsa/asoundlib.h>
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
+#include "qemu/error-report.h"
 #include "qemu/audio.h"
 #include "qom/object.h"
 #include "trace.h"
 
 #pragma GCC diagnostic ignored "-Waddress"
 
-#define AUDIO_CAP "alsa"
 #include "audio_int.h"
 
-#define DEBUG_ALSA 0
-
 #define TYPE_AUDIO_ALSA "audio-alsa"
 OBJECT_DECLARE_SIMPLE_TYPE(AudioALSA, AUDIO_ALSA)
 
@@ -81,33 +79,29 @@ struct alsa_params_obt {
     snd_pcm_uframes_t samples;
 };
 
-static void G_GNUC_PRINTF (2, 3) alsa_logerr (int err, const char *fmt, ...)
+static void G_GNUC_PRINTF(2, 3) alsa_logerr(int err, const char *fmt, ...)
 {
     va_list ap;
 
-    va_start (ap, fmt);
-    AUD_vlog (AUDIO_CAP, fmt, ap);
-    va_end (ap);
-
-    AUD_log (AUDIO_CAP, "Reason: %s\n", snd_strerror (err));
+    error_printf("alsa: ");
+    va_start(ap, fmt);
+    error_vprintf(fmt, ap);
+    va_end(ap);
+    error_printf(" Reason: %s", snd_strerror(err));
+    error_printf("\n");
 }
 
-static void G_GNUC_PRINTF (3, 4) alsa_logerr2 (
-    int err,
-    const char *typ,
-    const char *fmt,
-    ...
-    )
+static void G_GNUC_PRINTF(3, 4) alsa_logerr2(int err, const char *typ,
+                                             const char *fmt, ...)
 {
     va_list ap;
 
-    AUD_log (AUDIO_CAP, "Could not initialize %s\n", typ);
-
-    va_start (ap, fmt);
-    AUD_vlog (AUDIO_CAP, fmt, ap);
-    va_end (ap);
-
-    AUD_log (AUDIO_CAP, "Reason: %s\n", snd_strerror (err));
+    error_printf("alsa: Could not initialize %s:", typ);
+    va_start(ap, fmt);
+    error_vprintf(fmt, ap);
+    va_end(ap);
+    error_printf(" Reason: %s", snd_strerror(err));
+    error_printf("\n");
 }
 
 static void alsa_fini_poll (struct pollhlp *hlp)
@@ -130,7 +124,7 @@ static void alsa_anal_close1 (snd_pcm_t **handlep)
 {
     int err = snd_pcm_close (*handlep);
     if (err) {
-        alsa_logerr (err, "Failed to close PCM handle %p\n", *handlep);
+        alsa_logerr(err, "Failed to close PCM handle %p", *handlep);
     }
     *handlep = NULL;
 }
@@ -145,7 +139,7 @@ static int alsa_recover (snd_pcm_t *handle)
 {
     int err = snd_pcm_prepare (handle);
     if (err < 0) {
-        alsa_logerr (err, "Failed to prepare handle %p\n", handle);
+        alsa_logerr(err, "Failed to prepare handle %p", handle);
         return -1;
     }
     return 0;
@@ -155,7 +149,7 @@ static int alsa_resume (snd_pcm_t *handle)
 {
     int err = snd_pcm_resume (handle);
     if (err < 0) {
-        alsa_logerr (err, "Failed to resume handle %p\n", handle);
+        alsa_logerr(err, "Failed to resume handle %p", handle);
         return -1;
     }
     return 0;
@@ -170,7 +164,7 @@ static void alsa_poll_handler (void *opaque)
 
     count = poll (hlp->pfds, hlp->count, 0);
     if (count < 0) {
-        dolog ("alsa_poll_handler: poll %s\n", strerror (errno));
+        warn_report("alsa_poll_handler: poll %s", strerror(errno));
         return;
     }
 
@@ -183,7 +177,7 @@ static void alsa_poll_handler (void *opaque)
     err = snd_pcm_poll_descriptors_revents (hlp->handle, hlp->pfds,
                                             hlp->count, &revents);
     if (err < 0) {
-        alsa_logerr (err, "snd_pcm_poll_descriptors_revents");
+        alsa_logerr(err, "snd_pcm_poll_descriptors_revents");
         return;
     }
 
@@ -215,7 +209,7 @@ static void alsa_poll_handler (void *opaque)
         break;
 
     default:
-        dolog ("Unexpected state %d\n", state);
+        warn_report("alsa: Unexpected state %d", state);
     }
 }
 
@@ -226,8 +220,8 @@ static int alsa_poll_helper (snd_pcm_t *handle, struct pollhlp *hlp, int mask)
 
     count = snd_pcm_poll_descriptors_count (handle);
     if (count <= 0) {
-        dolog ("Could not initialize poll mode\n"
-               "Invalid number of poll descriptors %d\n", count);
+        warn_report("alsa: Could not initialize poll mode: "
+                    "Invalid number of poll descriptors %d", count);
         return -1;
     }
 
@@ -235,8 +229,7 @@ static int alsa_poll_helper (snd_pcm_t *handle, struct pollhlp *hlp, int mask)
 
     err = snd_pcm_poll_descriptors (handle, pfds, count);
     if (err < 0) {
-        alsa_logerr (err, "Could not initialize poll mode\n"
-                     "Could not obtain poll descriptors\n");
+        alsa_logerr(err, "Could not initialize poll mode: Could not obtain poll descriptors");
         g_free (pfds);
         return -1;
     }
@@ -298,10 +291,7 @@ static snd_pcm_format_t aud_to_alsafmt(AudioFormat fmt, bool big_endian)
         return big_endian ? SND_PCM_FORMAT_FLOAT_BE : SND_PCM_FORMAT_FLOAT_LE;
 
     default:
-        dolog ("Internal logic error: Bad audio format %d\n", fmt);
-#ifdef DEBUG_AUDIO
-        abort ();
-#endif
+        warn_report("alsa: Internal logic error: Bad audio format %d", fmt);
         return SND_PCM_FORMAT_U8;
     }
 }
@@ -371,29 +361,13 @@ static int alsa_to_audfmt (snd_pcm_format_t alsafmt, AudioFormat *fmt,
         break;
 
     default:
-        dolog ("Unrecognized audio format %d\n", alsafmt);
+        warn_report("alsa: Unrecognized audio format %d", alsafmt);
         return -1;
     }
 
     return 0;
 }
 
-static void alsa_dump_info (struct alsa_params_req *req,
-                            struct alsa_params_obt *obt,
-                            snd_pcm_format_t obtfmt,
-                            AudiodevAlsaPerDirectionOptions *apdo)
-{
-    dolog("parameter | requested value | obtained value\n");
-    dolog("format    |      %10d |     %10d\n", req->fmt, obtfmt);
-    dolog("channels  |      %10d |     %10d\n",
-          req->nchannels, obt->nchannels);
-    dolog("frequency |      %10d |     %10d\n", req->freq, obt->freq);
-    dolog("============================================\n");
-    dolog("requested: buffer len %" PRId32 " period len %" PRId32 "\n",
-          apdo->buffer_length, apdo->period_length);
-    dolog("obtained: samples %ld\n", obt->samples);
-}
-
 static void alsa_set_threshold (snd_pcm_t *handle, snd_pcm_uframes_t threshold)
 {
     int err;
@@ -403,23 +377,22 @@ static void alsa_set_threshold (snd_pcm_t *handle, snd_pcm_uframes_t threshold)
 
     err = snd_pcm_sw_params_current (handle, sw_params);
     if (err < 0) {
-        dolog ("Could not fully initialize DAC\n");
-        alsa_logerr (err, "Failed to get current software parameters\n");
+        error_report("alsa: Could not fully initialize DAC");
+        alsa_logerr(err, "Failed to get current software parameters");
         return;
     }
 
     err = snd_pcm_sw_params_set_start_threshold (handle, sw_params, threshold);
     if (err < 0) {
-        dolog ("Could not fully initialize DAC\n");
-        alsa_logerr (err, "Failed to set software threshold to %ld\n",
-                     threshold);
+        error_report("alsa: Could not fully initialize DAC");
+        alsa_logerr(err, "Failed to set software threshold to %ld", threshold);
         return;
     }
 
     err = snd_pcm_sw_params (handle, sw_params);
     if (err < 0) {
-        dolog ("Could not fully initialize DAC\n");
-        alsa_logerr (err, "Failed to set software parameters\n");
+        error_report("alsa: Could not fully initialize DAC");
+        alsa_logerr(err, "Failed to set software parameters");
         return;
     }
 }
@@ -451,13 +424,13 @@ static int alsa_open(bool in, struct alsa_params_req *req,
         SND_PCM_NONBLOCK
         );
     if (err < 0) {
-        alsa_logerr2 (err, typ, "Failed to open `%s':\n", pcm_name);
+        alsa_logerr2(err, typ, "Failed to open `%s'", pcm_name);
         return -1;
     }
 
     err = snd_pcm_hw_params_any (handle, hw_params);
     if (err < 0) {
-        alsa_logerr2 (err, typ, "Failed to initialize hardware parameters\n");
+        alsa_logerr2(err, typ, "Failed to initialize hardware parameters");
         goto err;
     }
 
@@ -467,18 +440,18 @@ static int alsa_open(bool in, struct alsa_params_req *req,
         SND_PCM_ACCESS_RW_INTERLEAVED
         );
     if (err < 0) {
-        alsa_logerr2 (err, typ, "Failed to set access type\n");
+        alsa_logerr2(err, typ, "Failed to set access type");
         goto err;
     }
 
     err = snd_pcm_hw_params_set_format (handle, hw_params, req->fmt);
     if (err < 0) {
-        alsa_logerr2 (err, typ, "Failed to set format %d\n", req->fmt);
+        alsa_logerr2(err, typ, "Failed to set format %d", req->fmt);
     }
 
     err = snd_pcm_hw_params_set_rate_near (handle, hw_params, &freq, 0);
     if (err < 0) {
-        alsa_logerr2 (err, typ, "Failed to set frequency %d\n", req->freq);
+        alsa_logerr2(err, typ, "Failed to set frequency %d", req->freq);
         goto err;
     }
 
@@ -488,8 +461,7 @@ static int alsa_open(bool in, struct alsa_params_req *req,
         &nchannels
         );
     if (err < 0) {
-        alsa_logerr2 (err, typ, "Failed to set number of channels %d\n",
-                      req->nchannels);
+        alsa_logerr2(err, typ, "Failed to set number of channels %d", req->nchannels);
         goto err;
     }
 
@@ -501,14 +473,14 @@ static int alsa_open(bool in, struct alsa_params_req *req,
             handle, hw_params, &btime, &dir);
 
         if (err < 0) {
-            alsa_logerr2(err, typ, "Failed to set buffer time to %" PRId32 "\n",
+            alsa_logerr2(err, typ, "Failed to set buffer time to %" PRId32,
                          apdo->buffer_length);
             goto err;
         }
 
         if (apdo->has_buffer_length && btime != apdo->buffer_length) {
-            dolog("Requested buffer time %" PRId32
-                  " was rejected, using %u\n", apdo->buffer_length, btime);
+            warn_report("alsa: Requested buffer time %" PRId32 " was rejected, using %u",
+                        apdo->buffer_length, btime);
         }
     }
 
@@ -520,43 +492,43 @@ static int alsa_open(bool in, struct alsa_params_req *req,
                                                      &dir);
 
         if (err < 0) {
-            alsa_logerr2(err, typ, "Failed to set period time to %" PRId32 "\n",
+            alsa_logerr2(err, typ, "Failed to set period time to %" PRId32,
                          apdo->period_length);
             goto err;
         }
 
         if (apdo->has_period_length && ptime != apdo->period_length) {
-            dolog("Requested period time %" PRId32 " was rejected, using %d\n",
-                  apdo->period_length, ptime);
+            warn_report("alsa: Requested period time %" PRId32 " was rejected, using %d",
+                        apdo->period_length, ptime);
         }
     }
 
     err = snd_pcm_hw_params (handle, hw_params);
     if (err < 0) {
-        alsa_logerr2 (err, typ, "Failed to apply audio parameters\n");
+        alsa_logerr2(err, typ, "Failed to apply audio parameters");
         goto err;
     }
 
     err = snd_pcm_hw_params_get_buffer_size (hw_params, &obt_buffer_size);
     if (err < 0) {
-        alsa_logerr2 (err, typ, "Failed to get buffer size\n");
+        alsa_logerr2(err, typ, "Failed to get buffer size");
         goto err;
     }
 
     err = snd_pcm_hw_params_get_format (hw_params, &obtfmt);
     if (err < 0) {
-        alsa_logerr2 (err, typ, "Failed to get format\n");
+        alsa_logerr2(err, typ, "Failed to get format");
         goto err;
     }
 
     if (alsa_to_audfmt (obtfmt, &obt->fmt, &obt->endianness)) {
-        dolog ("Invalid format was returned %d\n", obtfmt);
+        error_report("alsa: Invalid format was returned %d", obtfmt);
         goto err;
     }
 
     err = snd_pcm_prepare (handle);
     if (err < 0) {
-        alsa_logerr2 (err, typ, "Could not prepare handle %p\n", handle);
+        alsa_logerr2(err, typ, "Could not prepare handle %p", handle);
         goto err;
     }
 
@@ -574,11 +546,9 @@ static int alsa_open(bool in, struct alsa_params_req *req,
 
     *handlep = handle;
 
-    if (DEBUG_ALSA || obtfmt != req->fmt ||
-        obt->nchannels != req->nchannels || obt->freq != req->freq) {
-        dolog ("Audio parameters for %s\n", typ);
-        alsa_dump_info(req, obt, obtfmt, apdo);
-    }
+    trace_alsa_info_params(req->fmt, obtfmt, req->nchannels, obt->nchannels,
+                           req->freq, obt->freq);
+    trace_alsa_info_samples(apdo->buffer_length, apdo->period_length, obt->samples);
 
     return 0;
 
@@ -601,8 +571,7 @@ static size_t alsa_buffer_get_free(HWVoiceOut *hw)
             }
         }
         if (avail < 0) {
-            alsa_logerr(avail,
-                        "Could not obtain number of available frames\n");
+            alsa_logerr(avail, "Could not obtain number of available frames");
             avail = 0;
         }
     }
@@ -643,8 +612,7 @@ static size_t alsa_write(HWVoiceOut *hw, void *buf, size_t len)
 
             case -EPIPE:
                 if (alsa_recover(alsa->handle)) {
-                    alsa_logerr(written, "Failed to write %zu frames\n",
-                                len_frames);
+                    alsa_logerr(written, "Failed to write %zu frames", len_frames);
                     return pos;
                 }
                 trace_alsa_xrun_out();
@@ -656,8 +624,7 @@ static size_t alsa_write(HWVoiceOut *hw, void *buf, size_t len)
                  * recovery
                  */
                 if (alsa_resume(alsa->handle)) {
-                    alsa_logerr(written, "Failed to write %zu frames\n",
-                                len_frames);
+                    alsa_logerr(written, "Failed to write %zu frames", len_frames);
                     return pos;
                 }
                 trace_alsa_resume_out();
@@ -667,8 +634,7 @@ static size_t alsa_write(HWVoiceOut *hw, void *buf, size_t len)
                 return pos;
 
             default:
-                alsa_logerr(written, "Failed to write %zu frames from %p\n",
-                            len, src);
+                alsa_logerr(written, "Failed to write %zu frames from %p", len_frames, src);
                 return pos;
             }
         }
@@ -687,7 +653,7 @@ static void alsa_fini_out (HWVoiceOut *hw)
 {
     ALSAVoiceOut *alsa = (ALSAVoiceOut *) hw;
 
-    ldebug ("alsa_fini\n");
+    trace_alsa_fini_out();
     alsa_anal_close (&alsa->handle, &alsa->pollhlp);
 }
 
@@ -732,19 +698,19 @@ static int alsa_voice_ctl (snd_pcm_t *handle, const char *typ, int ctl)
     if (ctl == VOICE_CTL_PAUSE) {
         err = snd_pcm_drop (handle);
         if (err < 0) {
-            alsa_logerr (err, "Could not stop %s\n", typ);
+            alsa_logerr(err, "Could not stop %s", typ);
             return -1;
         }
     } else {
         err = snd_pcm_prepare (handle);
         if (err < 0) {
-            alsa_logerr (err, "Could not prepare handle for %s\n", typ);
+            alsa_logerr(err, "Could not prepare handle for %s", typ);
             return -1;
         }
         if (ctl == VOICE_CTL_START) {
             err = snd_pcm_start(handle);
             if (err < 0) {
-                alsa_logerr (err, "Could not start handle for %s\n", typ);
+                alsa_logerr(err, "Could not start handle for %s", typ);
                 return -1;
             }
         }
@@ -758,17 +724,17 @@ static void alsa_enable_out(HWVoiceOut *hw, bool enable)
     ALSAVoiceOut *alsa = (ALSAVoiceOut *) hw;
     AudiodevAlsaPerDirectionOptions *apdo = hw->s->dev->u.alsa.out;
 
+    trace_alsa_enable_out(enable);
+
     if (enable) {
         bool poll_mode = apdo->try_poll;
 
-        ldebug("enabling voice\n");
         if (poll_mode && alsa_poll_out(hw)) {
             poll_mode = 0;
         }
         hw->poll_mode = poll_mode;
         alsa_voice_ctl(alsa->handle, "playback", VOICE_CTL_PREPARE);
     } else {
-        ldebug("disabling voice\n");
         if (hw->poll_mode) {
             hw->poll_mode = 0;
             alsa_fini_poll(&alsa->pollhlp);
@@ -834,7 +800,7 @@ static size_t alsa_read(HWVoiceIn *hw, void *buf, size_t len)
 
             case -EPIPE:
                 if (alsa_recover(alsa->handle)) {
-                    alsa_logerr(nread, "Failed to read %zu frames\n", len);
+                    alsa_logerr(nread, "Failed to read %zu frames", len);
                     return pos;
                 }
                 trace_alsa_xrun_in();
@@ -844,8 +810,7 @@ static size_t alsa_read(HWVoiceIn *hw, void *buf, size_t len)
                 return pos;
 
             default:
-                alsa_logerr(nread, "Failed to read %zu frames to %p\n",
-                            len, dst);
+                alsa_logerr(nread, "Failed to read %zu frames to %p", len, dst);
                 return pos;
             }
         }
@@ -862,10 +827,11 @@ static void alsa_enable_in(HWVoiceIn *hw, bool enable)
     ALSAVoiceIn *alsa = (ALSAVoiceIn *) hw;
     AudiodevAlsaPerDirectionOptions *apdo = hw->s->dev->u.alsa.in;
 
+    trace_alsa_enable_in(enable);
+
     if (enable) {
         bool poll_mode = apdo->try_poll;
 
-        ldebug("enabling voice\n");
         if (poll_mode && alsa_poll_in(hw)) {
             poll_mode = 0;
         }
@@ -873,7 +839,6 @@ static void alsa_enable_in(HWVoiceIn *hw, bool enable)
 
         alsa_voice_ctl(alsa->handle, "capture", VOICE_CTL_START);
     } else {
-        ldebug ("disabling voice\n");
         if (hw->poll_mode) {
             hw->poll_mode = 0;
             alsa_fini_poll(&alsa->pollhlp);
diff --git a/audio/trace-events b/audio/trace-events
index f7f639d9605..737e3e60694 100644
--- a/audio/trace-events
+++ b/audio/trace-events
@@ -9,6 +9,11 @@ alsa_read_zero(long len) "Failed to read %ld frames (read zero)"
 alsa_xrun_out(void) "Recovering from playback xrun"
 alsa_xrun_in(void) "Recovering from capture xrun"
 alsa_resume_out(void) "Resuming suspended output stream"
+alsa_info_params(int req_fmt, int obt_fmt, int req_channels, int obt_channels, int req_freq, int obt_freq) "format %d->%d, channels %d->%d, frequency %d->%d"
+alsa_info_samples(int buffer_length, int period_length, long samples) "requested: buffer len %d, period len %d; obtained: %ld samples"
+alsa_fini_out(void) ""
+alsa_enable_out(bool enable) "enable=%d"
+alsa_enable_in(bool enable) "enable=%d"
 
 # ossaudio.c
 oss_version(int version) "OSS version = 0x%x"
-- 
2.53.0


