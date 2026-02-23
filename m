Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8523AEA4FC3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 13:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuWMv-0001MC-Q6; Mon, 23 Feb 2026 08:53:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWKg-0005ye-15
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:50:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWKd-0007Wu-Lv
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771854638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XPyKm0uIZ6EnWYaaOkmTTzkbOadyDmkb7sT93ZCTKz8=;
 b=VV7Rtc/1zFDDuNh6IRmyBzSr45lA0t5IXMWM4vaZYtV7pzUFumDRSWtgHBHGutx5yBpdyl
 bfFY2QT1Jq27xmtJLpTj7pHqNmgPYv1JQAMzZJMY7QodtoFgVBDWy5pkUWP1nHENzSn6Mr
 izdDxVIDbmxdHHvt6yszx8OpKCJ+geA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-2gkRyIPBOdqf2zyo3e7m_w-1; Mon,
 23 Feb 2026 08:50:35 -0500
X-MC-Unique: 2gkRyIPBOdqf2zyo3e7m_w-1
X-Mimecast-MFC-AGG-ID: 2gkRyIPBOdqf2zyo3e7m_w_1771854634
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C6641955F3B; Mon, 23 Feb 2026 13:50:34 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7542330001BE; Mon, 23 Feb 2026 13:50:33 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v3 65/85] audio/oss: replace custom logging with report & trace
Date: Mon, 23 Feb 2026 14:47:06 +0100
Message-ID: <20260223134731.2377432-66-marcandre.lureau@redhat.com>
In-Reply-To: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
References: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Replace the custom audio logging infrastructure with standard QEMU
error reporting and tracing.

Note the patch drops DEBUG_MISMATCH condition, and now always trace
actual audio parameters.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/ossaudio.c   | 176 ++++++++++++++++++++-------------------------
 audio/trace-events |   5 ++
 2 files changed, 81 insertions(+), 100 deletions(-)

diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index d12c65dd0d7..81f49f9a7e7 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -31,11 +31,10 @@
 #include "qemu/host-utils.h"
 #include "qapi/error.h"
 #include "qemu/audio.h"
+#include "qemu/error-report.h"
 #include "qom/object.h"
-#include "trace.h"
-
-#define AUDIO_CAP "oss"
 #include "audio_int.h"
+#include "trace.h"
 
 #define TYPE_AUDIO_OSS "audio-oss"
 OBJECT_DECLARE_SIMPLE_TYPE(AudioOss, AUDIO_OSS)
@@ -76,43 +75,40 @@ struct oss_params {
     int fragsize;
 };
 
-static void G_GNUC_PRINTF (2, 3) oss_logerr (int err, const char *fmt, ...)
+static void G_GNUC_PRINTF(2, 3) oss_logerr(int err, const char *fmt, ...)
 {
     va_list ap;
 
-    va_start (ap, fmt);
-    AUD_vlog (AUDIO_CAP, fmt, ap);
-    va_end (ap);
+    error_printf("oss: ");
+    va_start(ap, fmt);
+    error_vprintf(fmt, ap);
+    va_end(ap);
 
-    AUD_log (AUDIO_CAP, "Reason: %s\n", strerror (err));
+    error_printf(" Reason: %s\n", strerror(err));
 }
 
-static void G_GNUC_PRINTF (3, 4) oss_logerr2 (
-    int err,
-    const char *typ,
-    const char *fmt,
-    ...
-    )
+static void G_GNUC_PRINTF(3, 4) oss_logerr2(int err, const char *typ,
+                                            const char *fmt, ...)
 {
     va_list ap;
 
-    AUD_log (AUDIO_CAP, "Could not initialize %s\n", typ);
+    error_printf("oss: Could not initialize %s: ", typ);
 
-    va_start (ap, fmt);
-    AUD_vlog (AUDIO_CAP, fmt, ap);
-    va_end (ap);
+    va_start(ap, fmt);
+    error_vprintf(fmt, ap);
+    va_end(ap);
 
-    AUD_log (AUDIO_CAP, "Reason: %s\n", strerror (err));
+    error_printf(" Reason: %s\n", strerror(err));
 }
 
-static void oss_anal_close (int *fdp)
+static void oss_anal_close(int *fdp)
 {
     int err;
 
-    qemu_set_fd_handler (*fdp, NULL, NULL, NULL);
-    err = close (*fdp);
+    qemu_set_fd_handler(*fdp, NULL, NULL, NULL);
+    err = close(*fdp);
     if (err) {
-        oss_logerr (errno, "Failed to close file(fd=%d)\n", *fdp);
+        oss_logerr(errno, "Failed to close file(fd=%d)", *fdp);
     }
     *fdp = -1;
 }
@@ -159,10 +155,7 @@ static int aud_to_ossfmt(AudioFormat fmt, bool big_endian)
         return big_endian ? AFMT_U16_BE : AFMT_U16_LE;
 
     default:
-        dolog ("Internal logic error: Bad audio format %d\n", fmt);
-#ifdef DEBUG_AUDIO
-        abort ();
-#endif
+        error_report("oss: Internal logic error: Bad audio format %d", fmt);
         return AFMT_U8;
     }
 }
@@ -201,27 +194,13 @@ static int oss_to_audfmt (int ossfmt, AudioFormat *fmt, int *endianness)
         break;
 
     default:
-        dolog ("Unrecognized audio format %d\n", ossfmt);
+        error_report("oss: Unrecognized audio format %d", ossfmt);
         return -1;
     }
 
     return 0;
 }
 
-#if defined DEBUG_MISMATCHES || defined DEBUG
-static void oss_dump_info (struct oss_params *req, struct oss_params *obt)
-{
-    dolog ("parameter | requested value | obtained value\n");
-    dolog ("format    |      %10d |     %10d\n", req->fmt, obt->fmt);
-    dolog ("channels  |      %10d |     %10d\n",
-           req->nchannels, obt->nchannels);
-    dolog ("frequency |      %10d |     %10d\n", req->freq, obt->freq);
-    dolog ("nfrags    |      %10d |     %10d\n", req->nfrags, obt->nfrags);
-    dolog ("fragsize  |      %10d |     %10d\n",
-           req->fragsize, obt->fragsize);
-}
-#endif
-
 #ifdef USE_DSP_POLICY
 static int oss_get_version (int fd, int *version, const char *typ)
 {
@@ -240,7 +219,7 @@ static int oss_get_version (int fd, int *version, const char *typ)
             return 0;
         }
 #endif
-        oss_logerr2 (errno, typ, "Failed to get OSS version\n");
+        oss_logerr2(errno, typ, "Failed to get OSS version");
         return -1;
     }
     return 0;
@@ -269,7 +248,7 @@ static int oss_open(int in, struct oss_params *req, audsettings *as,
 
     fd = open (dspname, oflags | O_NONBLOCK);
     if (-1 == fd) {
-        oss_logerr2 (errno, typ, "Failed to open `%s'\n", dspname);
+        oss_logerr2(errno, typ, "Failed to open '%s'", dspname);
         return -1;
     }
 
@@ -281,23 +260,23 @@ static int oss_open(int in, struct oss_params *req, audsettings *as,
         qapi_AudiodevOssPerDirectionOptions_base(opdo), as, 23220);
 
     if (ioctl (fd, SNDCTL_DSP_SAMPLESIZE, &fmt)) {
-        oss_logerr2 (errno, typ, "Failed to set sample size %d\n", req->fmt);
+        oss_logerr2(errno, typ, "Failed to set sample size %d", req->fmt);
         goto err;
     }
 
     if (ioctl (fd, SNDCTL_DSP_CHANNELS, &nchannels)) {
-        oss_logerr2 (errno, typ, "Failed to set number of channels %d\n",
-                     req->nchannels);
+        oss_logerr2(errno, typ, "Failed to set number of channels %d",
+                    req->nchannels);
         goto err;
     }
 
     if (ioctl (fd, SNDCTL_DSP_SPEED, &freq)) {
-        oss_logerr2 (errno, typ, "Failed to set frequency %d\n", req->freq);
+        oss_logerr2(errno, typ, "Failed to set frequency %d", req->freq);
         goto err;
     }
 
     if (ioctl (fd, SNDCTL_DSP_NONBLOCK, NULL)) {
-        oss_logerr2 (errno, typ, "Failed to set non-blocking mode\n");
+        oss_logerr2(errno, typ, "Failed to set non-blocking mode");
         goto err;
     }
 
@@ -311,9 +290,9 @@ static int oss_open(int in, struct oss_params *req, audsettings *as,
             if (version >= 0x040000) {
                 int policy2 = policy;
                 if (ioctl(fd, SNDCTL_DSP_POLICY, &policy2)) {
-                    oss_logerr2 (errno, typ,
-                                 "Failed to set timing policy to %d\n",
-                                 policy);
+                    oss_logerr2(errno, typ,
+                                "Failed to set timing policy to %d",
+                                policy);
                     goto err;
                 }
                 setfragment = 0;
@@ -325,20 +304,20 @@ static int oss_open(int in, struct oss_params *req, audsettings *as,
     if (setfragment) {
         int mmmmssss = (req->nfrags << 16) | ctz32 (req->fragsize);
         if (ioctl (fd, SNDCTL_DSP_SETFRAGMENT, &mmmmssss)) {
-            oss_logerr2 (errno, typ, "Failed to set buffer length (%d, %d)\n",
-                         req->nfrags, req->fragsize);
+            oss_logerr2(errno, typ, "Failed to set buffer length (%d, %d)",
+                        req->nfrags, req->fragsize);
             goto err;
         }
     }
 
     if (ioctl (fd, in ? SNDCTL_DSP_GETISPACE : SNDCTL_DSP_GETOSPACE, &abinfo)) {
-        oss_logerr2 (errno, typ, "Failed to get buffer length\n");
+        oss_logerr2(errno, typ, "Failed to get buffer length");
         goto err;
     }
 
     if (!abinfo.fragstotal || !abinfo.fragsize) {
-        AUD_log (AUDIO_CAP, "Returned bogus buffer information(%d, %d) for %s\n",
-                 abinfo.fragstotal, abinfo.fragsize, typ);
+        error_report("oss: Returned bogus buffer information(%d, %d) for %s",
+                     abinfo.fragstotal, abinfo.fragsize, typ);
         goto err;
     }
 
@@ -349,20 +328,13 @@ static int oss_open(int in, struct oss_params *req, audsettings *as,
     obt->fragsize = abinfo.fragsize;
     *pfd = fd;
 
-#ifdef DEBUG_MISMATCHES
-    if ((req->fmt != obt->fmt) ||
-        (req->nchannels != obt->nchannels) ||
-        (req->freq != obt->freq) ||
-        (req->fragsize != obt->fragsize) ||
-        (req->nfrags != obt->nfrags)) {
-        dolog ("Audio parameters mismatch\n");
-        oss_dump_info (req, obt);
-    }
-#endif
+    trace_oss_out_params(
+        req->fmt, obt->fmt,
+        req->nchannels, obt->nchannels,
+        req->freq, obt->freq,
+        req->nfrags, obt->nfrags,
+        req->fragsize, obt->fragsize);
 
-#ifdef DEBUG
-    oss_dump_info (req, obt);
-#endif
     return 0;
 
  err:
@@ -378,7 +350,7 @@ static size_t oss_get_available_bytes(OSSVoiceOut *oss)
 
     err = ioctl(oss->fd, SNDCTL_DSP_GETOPTR, &cntinfo);
     if (err < 0) {
-        oss_logerr(errno, "SNDCTL_DSP_GETOPTR failed\n");
+        oss_logerr(errno, "SNDCTL_DSP_GETOPTR failed");
         return 0;
     }
 
@@ -459,8 +431,7 @@ static size_t oss_write(HWVoiceOut *hw, void *buf, size_t len)
         bytes_written = write(oss->fd, pcm, len);
         if (bytes_written < 0) {
             if (errno != EAGAIN) {
-                oss_logerr(errno, "failed to write %zu bytes\n",
-                           len);
+                oss_logerr(errno, "failed to write %zu bytes", len);
             }
             return pos;
         }
@@ -474,18 +445,18 @@ static size_t oss_write(HWVoiceOut *hw, void *buf, size_t len)
     return pos;
 }
 
-static void oss_fini_out (HWVoiceOut *hw)
+static void oss_fini_out(HWVoiceOut *hw)
 {
     int err;
-    OSSVoiceOut *oss = (OSSVoiceOut *) hw;
+    OSSVoiceOut *oss = (OSSVoiceOut *)hw;
 
-    ldebug ("oss_fini\n");
-    oss_anal_close (&oss->fd);
+    trace_oss_fini_out();
+    oss_anal_close(&oss->fd);
 
     if (oss->mmapped && hw->buf_emul) {
         err = munmap(hw->buf_emul, hw->size_emul);
         if (err) {
-            oss_logerr(errno, "Failed to unmap buffer %p, size %zu\n",
+            oss_logerr(errno, "Failed to unmap buffer %p, size %zu",
                        hw->buf_emul, hw->size_emul);
         }
         hw->buf_emul = NULL;
@@ -526,8 +497,8 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as)
     oss->fragsize = obt.fragsize;
 
     if (obt.nfrags * obt.fragsize % hw->info.bytes_per_frame) {
-        dolog ("warning: Misaligned DAC buffer, size %d, alignment %d\n",
-               obt.nfrags * obt.fragsize, hw->info.bytes_per_frame);
+        warn_report("oss: Misaligned DAC buffer, size %d, alignment %d",
+                    obt.nfrags * obt.fragsize, hw->info.bytes_per_frame);
     }
 
     hw->samples = (obt.nfrags * obt.fragsize) / hw->info.bytes_per_frame;
@@ -544,20 +515,16 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as)
             0
             );
         if (hw->buf_emul == MAP_FAILED) {
-            oss_logerr(errno, "Failed to map %zu bytes of DAC\n",
-                       hw->size_emul);
+            oss_logerr(errno, "Failed to map %zu bytes of DAC", hw->size_emul);
             hw->buf_emul = NULL;
         } else {
             int trig = 0;
             if (ioctl (fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
-                oss_logerr (errno, "SNDCTL_DSP_SETTRIGGER 0 failed\n");
+                oss_logerr(errno, "SNDCTL_DSP_SETTRIGGER 0 failed");
             } else {
                 trig = PCM_ENABLE_OUTPUT;
-                if (ioctl (fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
-                    oss_logerr (
-                        errno,
-                        "SNDCTL_DSP_SETTRIGGER PCM_ENABLE_OUTPUT failed\n"
-                        );
+                if (ioctl(fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
+                    oss_logerr(errno, "SNDCTL_DSP_SETTRIGGER PCM_ENABLE_OUTPUT failed");
                 } else {
                     oss->mmapped = 1;
                 }
@@ -566,7 +533,7 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as)
             if (!oss->mmapped) {
                 err = munmap(hw->buf_emul, hw->size_emul);
                 if (err) {
-                    oss_logerr(errno, "Failed to unmap buffer %p size %zu\n",
+                    oss_logerr(errno, "Failed to unmap buffer %p size %zu",
                                hw->buf_emul, hw->size_emul);
                 }
                 hw->buf_emul = NULL;
@@ -582,13 +549,14 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as)
 static void oss_enable_out(HWVoiceOut *hw, bool enable)
 {
     int trig;
-    OSSVoiceOut *oss = (OSSVoiceOut *) hw;
+    OSSVoiceOut *oss = (OSSVoiceOut *)hw;
     AudiodevOssPerDirectionOptions *opdo = oss->dev->u.oss.out;
 
+    trace_oss_enable_out(enable);
+
     if (enable) {
         hw->poll_mode = opdo->try_poll;
 
-        ldebug("enabling voice\n");
         if (hw->poll_mode) {
             oss_poll_out(hw);
         }
@@ -601,12 +569,12 @@ static void oss_enable_out(HWVoiceOut *hw, bool enable)
         trig = PCM_ENABLE_OUTPUT;
         if (ioctl(oss->fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
             oss_logerr(errno,
-                       "SNDCTL_DSP_SETTRIGGER PCM_ENABLE_OUTPUT failed\n");
+                       "SNDCTL_DSP_SETTRIGGER PCM_ENABLE_OUTPUT failed");
             return;
         }
     } else {
         if (hw->poll_mode) {
-            qemu_set_fd_handler (oss->fd, NULL, NULL, NULL);
+            qemu_set_fd_handler(oss->fd, NULL, NULL, NULL);
             hw->poll_mode = 0;
         }
 
@@ -614,10 +582,9 @@ static void oss_enable_out(HWVoiceOut *hw, bool enable)
             return;
         }
 
-        ldebug ("disabling voice\n");
         trig = 0;
-        if (ioctl (oss->fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
-            oss_logerr (errno, "SNDCTL_DSP_SETTRIGGER 0 failed\n");
+        if (ioctl(oss->fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
+            oss_logerr(errno, "SNDCTL_DSP_SETTRIGGER 0 failed");
             return;
         }
     }
@@ -654,9 +621,16 @@ static int oss_init_in(HWVoiceIn *hw, struct audsettings *as)
     oss->nfrags = obt.nfrags;
     oss->fragsize = obt.fragsize;
 
+    trace_oss_in_params(
+        req.fmt, obt.fmt,
+        req.nchannels, obt.nchannels,
+        req.freq, obt.freq,
+        req.nfrags, obt.nfrags,
+        req.fragsize, obt.fragsize);
+
     if (obt.nfrags * obt.fragsize % hw->info.bytes_per_frame) {
-        dolog ("warning: Misaligned ADC buffer, size %d, alignment %d\n",
-               obt.nfrags * obt.fragsize, hw->info.bytes_per_frame);
+        warn_report("oss: Misaligned ADC buffer, size %d, alignment %d",
+                    obt.nfrags * obt.fragsize, hw->info.bytes_per_frame);
     }
 
     hw->samples = (obt.nfrags * obt.fragsize) / hw->info.bytes_per_frame;
@@ -690,7 +664,7 @@ static size_t oss_read(HWVoiceIn *hw, void *buf, size_t len)
             case EAGAIN:
                 break;
             default:
-                oss_logerr(errno, "Failed to read %zu bytes of audio (to %p)\n",
+                oss_logerr(errno, "Failed to read %zu bytes of audio (to %p)",
                            len, dst);
                 break;
             }
@@ -706,9 +680,11 @@ static size_t oss_read(HWVoiceIn *hw, void *buf, size_t len)
 
 static void oss_enable_in(HWVoiceIn *hw, bool enable)
 {
-    OSSVoiceIn *oss = (OSSVoiceIn *) hw;
+    OSSVoiceIn *oss = (OSSVoiceIn *)hw;
     AudiodevOssPerDirectionOptions *opdo = oss->dev->u.oss.out;
 
+    trace_oss_enable_in(enable);
+
     if (enable) {
         hw->poll_mode = opdo->try_poll;
 
diff --git a/audio/trace-events b/audio/trace-events
index 79744456cec..f33be2dd8e3 100644
--- a/audio/trace-events
+++ b/audio/trace-events
@@ -17,6 +17,11 @@ alsa_enable_in(bool enable) "enable=%d"
 
 # ossaudio.c
 oss_version(int version) "OSS version = 0x%x"
+oss_out_params(int req_fmt, int obt_fmt, int req_channels, int obt_channels, int req_freq, int obt_freq, int req_nfrags, int obt_nfrags, int req_fragsize, int obt_fragsize) "fmt=%d->%d, channels %d->%d, freq=%d->%d, nfrags=%d->%d, fragsize=%d->%d"
+oss_in_params(int req_fmt, int obt_fmt, int req_channels, int obt_channels, int req_freq, int obt_freq, int req_nfrags, int obt_nfrags, int req_fragsize, int obt_fragsize) "fmt=%d->%d, channels %d->%d, freq=%d->%d, nfrags=%d->%d, fragsize=%d->%d"
+oss_fini_out(void) ""
+oss_enable_out(bool enable) "enable=%d"
+oss_enable_in(bool enable) "enable=%d"
 
 # dbusaudio.c
 dbus_audio_register(const char *s, const char *dir) "sender = %s, dir = %s"
-- 
2.53.0


