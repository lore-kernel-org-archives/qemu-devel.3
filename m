Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5843FEA4FC2
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 13:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuWNl-00048Y-Ms; Mon, 23 Feb 2026 08:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWKW-0005pD-HE
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:50:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWKO-0007Uj-PV
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:50:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771854623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Z5jcvVXOzhqc4lUNGAawG594MBKHCLsZuQLgSkTre0=;
 b=XqepJbsfbX2jXGjxkfN+P2u7pnc6iNjuzqjmDQSazznXnfz7xXWPQYzzxfBK7PNzeolrDd
 FPp3wA2O5ONKhesSJoGks8FWpDFSwmnfjeV0iUGpksz1YWUz0VQexKGjE48hj12bDSqIN3
 PJI3jWa4adLR6DROwHd+TRRzkntOgXc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-NPIP436uOk6e4cdbveF5_Q-1; Mon,
 23 Feb 2026 08:50:22 -0500
X-MC-Unique: NPIP436uOk6e4cdbveF5_Q-1
X-Mimecast-MFC-AGG-ID: NPIP436uOk6e4cdbveF5_Q_1771854621
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5021D1800341; Mon, 23 Feb 2026 13:50:21 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 843A71955F29; Mon, 23 Feb 2026 13:50:20 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL v3 60/85] audio/coreaudio: replace custom logging with
 error_report
Date: Mon, 23 Feb 2026 14:47:01 +0100
Message-ID: <20260223134731.2377432-61-marcandre.lureau@redhat.com>
In-Reply-To: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
References: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The CoreAudio backend uses its own logging infrastructure (AUD_log,
AUD_vlog, dolog) and the AUDIO_CAP macro. This approach is inconsistent
with the rest of QEMU and makes the output harder to filter and
configure.

Replace the custom logging with standard QEMU error reporting:
- Use error_report() / error_printf() for errors
- Use warn_report() for non-fatal warnings (buffer frame size
  adjustments)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 audio/coreaudio.m | 124 ++++++++++++++++++++++------------------------
 1 file changed, 60 insertions(+), 64 deletions(-)

diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index 561c08f47c1..0c0e8583c89 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -28,10 +28,9 @@
 
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
+#include "qemu/error-report.h"
 #include "qemu/audio.h"
 #include "qom/object.h"
-
-#define AUDIO_CAP "coreaudio"
 #include "audio_int.h"
 
 #define TYPE_AUDIO_COREAUDIO "audio-coreaudio"
@@ -157,7 +156,7 @@ static OSStatus coreaudio_get_isrunning(AudioDeviceID id, UInt32 *result)
                                       result);
 }
 
-static void coreaudio_logstatus (OSStatus status)
+static void coreaudio_logstatus(OSStatus status)
 {
     const char *str = "BUG";
 
@@ -207,70 +206,64 @@ static void coreaudio_logstatus (OSStatus status)
         break;
 
     default:
-        AUD_log (AUDIO_CAP, "Reason: status code %" PRId32 "\n", (int32_t)status);
+        error_printf(" Reason: status code %" PRId32, (int32_t)status);
         return;
     }
 
-    AUD_log (AUDIO_CAP, "Reason: %s\n", str);
+    error_printf(" Reason: %s", str);
 }
 
-static void G_GNUC_PRINTF (2, 3) coreaudio_logerr (
-    OSStatus status,
-    const char *fmt,
-    ...
-    )
+static void G_GNUC_PRINTF(2, 3) coreaudio_logerr(OSStatus status,
+                                                const char *fmt, ...)
 {
     va_list ap;
 
-    va_start (ap, fmt);
-    AUD_log (AUDIO_CAP, fmt, ap);
-    va_end (ap);
-
-    coreaudio_logstatus (status);
+    error_printf("coreaudio: ");
+    va_start(ap, fmt);
+    error_vprintf(fmt, ap);
+    va_end(ap);
+    coreaudio_logstatus(status);
+    error_printf("\n");
 }
 
-static void G_GNUC_PRINTF (3, 4) coreaudio_logerr2 (
-    OSStatus status,
-    const char *typ,
-    const char *fmt,
-    ...
-    )
+static void G_GNUC_PRINTF(3, 4) coreaudio_logerr2(OSStatus status,
+                                                  const char *typ,
+                                                  const char *fmt, ...)
 {
     va_list ap;
 
-    AUD_log (AUDIO_CAP, "Could not initialize %s\n", typ);
-
-    va_start (ap, fmt);
-    AUD_vlog (AUDIO_CAP, fmt, ap);
-    va_end (ap);
-
-    coreaudio_logstatus (status);
+    error_printf("coreaudio: Could not initialize %s: ", typ);
+    va_start(ap, fmt);
+    error_vprintf(fmt, ap);
+    va_end(ap);
+    coreaudio_logstatus(status);
+    error_printf("\n");
 }
 
 #define coreaudio_playback_logerr(status, ...) \
     coreaudio_logerr2(status, "playback", __VA_ARGS__)
 
-static int coreaudio_buf_lock (coreaudioVoiceOut *core, const char *fn_name)
+static int coreaudio_buf_lock(coreaudioVoiceOut *core, const char *fn_name)
 {
     int err;
 
-    err = pthread_mutex_lock (&core->buf_mutex);
+    err = pthread_mutex_lock(&core->buf_mutex);
     if (err) {
-        dolog ("Could not lock voice for %s\nReason: %s\n",
-               fn_name, strerror (err));
+        error_report("coreaudio: Could not lock voice for %s: %s",
+                     fn_name, strerror(err));
         return -1;
     }
     return 0;
 }
 
-static int coreaudio_buf_unlock (coreaudioVoiceOut *core, const char *fn_name)
+static int coreaudio_buf_unlock(coreaudioVoiceOut *core, const char *fn_name)
 {
     int err;
 
-    err = pthread_mutex_unlock (&core->buf_mutex);
+    err = pthread_mutex_unlock(&core->buf_mutex);
     if (err) {
-        dolog ("Could not unlock voice for %s\nReason: %s\n",
-               fn_name, strerror (err));
+        error_report("coreaudio: Could not unlock voice for %s: %s",
+                     fn_name, strerror(err));
         return -1;
     }
     return 0;
@@ -378,12 +371,13 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
 
     status = coreaudio_get_voice(&core->outputDeviceID);
     if (status != kAudioHardwareNoError) {
-        coreaudio_playback_logerr (status,
-                                   "Could not get default output Device\n");
+        coreaudio_playback_logerr(status,
+                                  "Could not get default output device");
         return status;
     }
     if (core->outputDeviceID == kAudioDeviceUnknown) {
-        dolog ("Could not initialize playback - Unknown Audiodevice\n");
+        error_report("coreaudio: Could not initialize playback: "
+                     "Unknown audio device");
         return status;
     }
 
@@ -394,17 +388,19 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
         return 0;
     }
     if (status != kAudioHardwareNoError) {
-        coreaudio_playback_logerr (status,
-                                    "Could not get device buffer frame range\n");
+        coreaudio_playback_logerr(status,
+                                  "Could not get device buffer frame range");
         return status;
     }
 
     if (frameRange.mMinimum > core->frameSizeSetting) {
         core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMinimum;
-        dolog ("warning: Upsizing Buffer Frames to %f\n", frameRange.mMinimum);
+        warn_report("coreaudio: Upsizing buffer frames to %f",
+                    frameRange.mMinimum);
     } else if (frameRange.mMaximum < core->frameSizeSetting) {
         core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMaximum;
-        dolog ("warning: Downsizing Buffer Frames to %f\n", frameRange.mMaximum);
+        warn_report("coreaudio: Downsizing buffer frames to %f",
+                    frameRange.mMaximum);
     } else {
         core->audioDevicePropertyBufferFrameSize = core->frameSizeSetting;
     }
@@ -416,9 +412,9 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
         return 0;
     }
     if (status != kAudioHardwareNoError) {
-        coreaudio_playback_logerr (status,
-                                    "Could not set device buffer frame size %" PRIu32 "\n",
-                                    (uint32_t)core->audioDevicePropertyBufferFrameSize);
+        coreaudio_playback_logerr(status,
+                                  "Could not set device buffer frame size %" PRIu32,
+                                  (uint32_t)core->audioDevicePropertyBufferFrameSize);
         return status;
     }
 
@@ -429,8 +425,8 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
         return 0;
     }
     if (status != kAudioHardwareNoError) {
-        coreaudio_playback_logerr (status,
-                                    "Could not get device buffer frame size\n");
+        coreaudio_playback_logerr(status,
+                                  "Could not get device buffer frame size");
         return status;
     }
     core->hw.samples = core->bufferCount * core->audioDevicePropertyBufferFrameSize;
@@ -442,9 +438,9 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
         return 0;
     }
     if (status != kAudioHardwareNoError) {
-        coreaudio_playback_logerr (status,
-                                   "Could not set samplerate %lf\n",
-                                   streamBasicDescription.mSampleRate);
+        coreaudio_playback_logerr(status,
+                                  "Could not set samplerate %lf",
+                                  streamBasicDescription.mSampleRate);
         core->outputDeviceID = kAudioDeviceUnknown;
         return status;
     }
@@ -468,7 +464,7 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
         return 0;
     }
     if (status != kAudioHardwareNoError || core->ioprocid == NULL) {
-        coreaudio_playback_logerr (status, "Could not set IOProc\n");
+        coreaudio_playback_logerr(status, "Could not set IOProc");
         core->outputDeviceID = kAudioDeviceUnknown;
         return status;
     }
@@ -486,13 +482,13 @@ static void fini_out_device(coreaudioVoiceOut *core)
     if (status != kAudioHardwareBadObjectError) {
         if (status != kAudioHardwareNoError) {
             coreaudio_logerr(status,
-                             "Could not determine whether Device is playing\n");
+                             "Could not determine whether device is playing");
         }
 
         if (isrunning) {
             status = AudioDeviceStop(core->outputDeviceID, core->ioprocid);
             if (status != kAudioHardwareBadDeviceError && status != kAudioHardwareNoError) {
-                coreaudio_logerr(status, "Could not stop playback\n");
+                coreaudio_logerr(status, "Could not stop playback");
             }
         }
     }
@@ -501,7 +497,7 @@ static void fini_out_device(coreaudioVoiceOut *core)
     status = AudioDeviceDestroyIOProcID(core->outputDeviceID,
                                         core->ioprocid);
     if (status != kAudioHardwareBadDeviceError && status != kAudioHardwareNoError) {
-        coreaudio_logerr(status, "Could not remove IOProc\n");
+        coreaudio_logerr(status, "Could not remove IOProc");
     }
     core->outputDeviceID = kAudioDeviceUnknown;
 }
@@ -515,7 +511,7 @@ static void update_device_playback_state(coreaudioVoiceOut *core)
     if (status != kAudioHardwareNoError) {
         if (status != kAudioHardwareBadObjectError) {
             coreaudio_logerr(status,
-                             "Could not determine whether Device is playing\n");
+                             "Could not determine whether device is playing");
         }
 
         return;
@@ -526,7 +522,7 @@ static void update_device_playback_state(coreaudioVoiceOut *core)
         if (!isrunning) {
             status = AudioDeviceStart(core->outputDeviceID, core->ioprocid);
             if (status != kAudioHardwareBadDeviceError && status != kAudioHardwareNoError) {
-                coreaudio_logerr (status, "Could not resume playback\n");
+                coreaudio_logerr(status, "Could not resume playback");
             }
         }
     } else {
@@ -535,7 +531,7 @@ static void update_device_playback_state(coreaudioVoiceOut *core)
             status = AudioDeviceStop(core->outputDeviceID,
                                      core->ioprocid);
             if (status != kAudioHardwareBadDeviceError && status != kAudioHardwareNoError) {
-                coreaudio_logerr(status, "Could not pause playback\n");
+                coreaudio_logerr(status, "Could not pause playback");
             }
         }
     }
@@ -576,7 +572,7 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as)
     /* create mutex */
     err = pthread_mutex_init(&core->buf_mutex, NULL);
     if (err) {
-        dolog("Could not create mutex\nReason: %s\n", strerror (err));
+        error_report("coreaudio: Could not create mutex: %s", strerror(err));
         return -1;
     }
 
@@ -594,8 +590,8 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as)
                                             &voice_addr, handle_voice_change,
                                             core);
     if (status != kAudioHardwareNoError) {
-        coreaudio_playback_logerr (status,
-                                   "Could not listen to voice property change\n");
+        coreaudio_playback_logerr(status,
+                                  "Could not listen to voice property change");
         return -1;
     }
 
@@ -606,7 +602,7 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as)
                                                    core);
         if (status != kAudioHardwareNoError) {
             coreaudio_playback_logerr(status,
-                                      "Could not remove voice property change listener\n");
+                                      "Could not remove voice property change listener");
         }
 
         return -1;
@@ -626,7 +622,7 @@ static void coreaudio_fini_out (HWVoiceOut *hw)
                                                handle_voice_change,
                                                core);
     if (status != kAudioHardwareNoError) {
-        coreaudio_logerr(status, "Could not remove voice property change listener\n");
+        coreaudio_logerr(status, "Could not remove voice property change listener");
     }
 
     fini_out_device(core);
@@ -634,7 +630,7 @@ static void coreaudio_fini_out (HWVoiceOut *hw)
     /* destroy mutex */
     err = pthread_mutex_destroy(&core->buf_mutex);
     if (err) {
-        dolog("Could not destroy mutex\nReason: %s\n", strerror (err));
+        error_report("coreaudio: Could not destroy mutex: %s", strerror(err));
     }
 }
 
-- 
2.53.0


