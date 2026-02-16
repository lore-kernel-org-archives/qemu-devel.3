Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676C3E7BD9B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfl-00013m-AY; Mon, 16 Feb 2026 06:21:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwcu-0007LB-66
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:18:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwcr-0008OL-Gf
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XVi8lBbZ0x6d3H1xMhZZ9DSsdXtKNj+ngko1jxe7z6A=;
 b=QzA3BNd1PQwOqe8LicCQnAz+j4PquGT/BRLddV4LWYmqhzy3srDe/nZxf9MVTIn66zBcD3
 vFxaHh9SyyneLh1DnkDovBnYrwWrz7Q9SFHkSutGenO4M0QIV1IalS0NCt6lkIkKkugBWC
 sEyv/SjVZJXmkzUUmwy2l2dm/f6ncLA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-zJtL5P6jP1Csz4OKR2yq9Q-1; Mon,
 16 Feb 2026 06:18:45 -0500
X-MC-Unique: zJtL5P6jP1Csz4OKR2yq9Q-1
X-Mimecast-MFC-AGG-ID: zJtL5P6jP1Csz4OKR2yq9Q_1771240724
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F396918005B7; Mon, 16 Feb 2026 11:18:43 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E21530001B9; Mon, 16 Feb 2026 11:18:43 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:55 +0100
Subject: [PATCH 66/85] audio/pa: replace custom logging with report & trace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-66-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12351;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=JVY/WEAWBXacb1I5A+f54VMSEuURH3uia0ld/lulY3A=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxRy2drI2ApEGZky9utC6vxFX2Qq7hWFM0w1
 gQGbw0SCvSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UQAKCRDa6OEJdZac
 5UDQD/48AuiOLZKP52JlrfEGLAKncJplORzeyFMSjsEljNCsEY7pGmUB2Bcxuv/54n0wFjdJK0J
 eWKKFtEyMKMUJGdcMKAzrpL1mCayluCXO6n58vJxFMN+VWhR6yz33Gtn9gKdDQ6rdcuzdIrpsrW
 lTUkjSRw74/Jx3bIIRwzSzv/fm69unL482SUJp0xuK1ug51cy7rJV9SynQsYo1m1WmlzdqzgxYB
 zCwRAzYkSyuNVk7QJZf9RstGDJK3DO/Q0IfKUD727aFukJgvfqkhSVfgk+cRL37wrvt5DC9My1f
 K6dBQrs9KdtW3R8OFxOD8WrDk7LuiRVWen552brdjOkixBiRwQM3vccTirhm6LoLtW0qwoKHlHA
 SiN2QjGnUkfgbEXJgdJrPCIY+bzWeY6UYxsxpVd772gevm1SnDNrG/gqJfPqMNDKQUHv+UsipXm
 09a/6iWWrY8aKmo/iq+mjuiwt4T7M8+PD7gscF9Cwr0lOh2ph09fxhmGABXn9+WjIL2iPSl2Deq
 Duh7hrc8lutuORf/wc3E306CEJcUxNJkyVBV8wMs03x34fTjH1aH257eAup//OJNh7mTjlFqIar
 ZxxJPLxs+VAP2VzZu2NedpZYmuP57JHHP4kG5Boxo+epjdfqJkKecMhTvOMM1vwbgfPdRtS5mze
 RYpJOv2Ynod6oNQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Replace the custom audio logging infrastructure with standard QEMU
error reporting and tracing.

qpa_conn_init() is called during audio_pa_realize() and already reports
an error through Error *.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/paaudio.c | 77 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 38 insertions(+), 39 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index b7826402e12..1501b26386a 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -3,14 +3,13 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qemu/audio.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qom/object.h"
+#include "audio_int.h"
 
 #include <pulse/pulseaudio.h>
 
-#define AUDIO_CAP "pulseaudio"
-#include "audio_int.h"
-
 #define TYPE_AUDIO_PA "audio-pa"
 OBJECT_DECLARE_SIMPLE_TYPE(AudioPa, AUDIO_PA)
 
@@ -51,15 +50,16 @@ typedef struct {
 
 static void qpa_conn_fini(PAConnection *c);
 
-static void G_GNUC_PRINTF (2, 3) qpa_logerr (int err, const char *fmt, ...)
+static void G_GNUC_PRINTF(2, 3) qpa_logerr(int err, const char *fmt, ...)
 {
     va_list ap;
 
-    va_start (ap, fmt);
-    AUD_vlog (AUDIO_CAP, fmt, ap);
-    va_end (ap);
+    error_printf("pulseaudio: ");
+    va_start(ap, fmt);
+    error_vprintf(fmt, ap);
+    va_end(ap);
 
-    AUD_log (AUDIO_CAP, "Reason: %s\n", pa_strerror (err));
+    error_printf(" Reason: %s\n", pa_strerror(err));
 }
 
 #ifndef PA_CONTEXT_IS_GOOD
@@ -113,12 +113,12 @@ static void *qpa_get_buffer_in(HWVoiceIn *hw, size_t *size)
     pa_threaded_mainloop_lock(c->mainloop);
 
     CHECK_DEAD_GOTO(c, p->stream, unlock_and_fail,
-                    "pa_threaded_mainloop_lock failed\n");
+                    "pa_threaded_mainloop_lock failed");
 
     if (!p->read_length) {
         r = pa_stream_peek(p->stream, &p->read_data, &p->read_length);
         CHECK_SUCCESS_GOTO(c, r == 0, unlock_and_fail,
-                           "pa_stream_peek failed\n");
+                           "pa_stream_peek failed");
     }
 
     *size = MIN(p->read_length, *size);
@@ -141,7 +141,7 @@ static void qpa_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size)
     pa_threaded_mainloop_lock(c->mainloop);
 
     CHECK_DEAD_GOTO(c, p->stream, unlock,
-                    "pa_threaded_mainloop_lock failed\n");
+                    "pa_threaded_mainloop_lock failed");
 
     assert(buf == p->read_data && size <= p->read_length);
 
@@ -150,7 +150,7 @@ static void qpa_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size)
 
     if (size && !p->read_length) {
         r = pa_stream_drop(p->stream);
-        CHECK_SUCCESS_GOTO(c, r == 0, unlock, "pa_stream_drop failed\n");
+        CHECK_SUCCESS_GOTO(c, r == 0, unlock, "pa_stream_drop failed");
     }
 
 unlock:
@@ -166,7 +166,7 @@ static size_t qpa_read(HWVoiceIn *hw, void *data, size_t length)
     pa_threaded_mainloop_lock(c->mainloop);
 
     CHECK_DEAD_GOTO(c, p->stream, unlock_and_fail,
-                    "pa_threaded_mainloop_lock failed\n");
+                    "pa_threaded_mainloop_lock failed");
     if (pa_stream_get_state(p->stream) != PA_STREAM_READY) {
         /* wait for stream to become ready */
         goto unlock;
@@ -179,7 +179,7 @@ static size_t qpa_read(HWVoiceIn *hw, void *data, size_t length)
         if (!p->read_length) {
             r = pa_stream_peek(p->stream, &p->read_data, &p->read_length);
             CHECK_SUCCESS_GOTO(c, r == 0, unlock_and_fail,
-                               "pa_stream_peek failed\n");
+                               "pa_stream_peek failed");
             if (!p->read_length) {
                 /* buffer is empty */
                 break;
@@ -196,7 +196,7 @@ static size_t qpa_read(HWVoiceIn *hw, void *data, size_t length)
         if (!p->read_length) {
             r = pa_stream_drop(p->stream);
             CHECK_SUCCESS_GOTO(c, r == 0, unlock_and_fail,
-                               "pa_stream_drop failed\n");
+                               "pa_stream_drop failed");
         }
     }
 
@@ -218,7 +218,7 @@ static size_t qpa_buffer_get_free(HWVoiceOut *hw)
     pa_threaded_mainloop_lock(c->mainloop);
 
     CHECK_DEAD_GOTO(c, p->stream, unlock_and_fail,
-                    "pa_threaded_mainloop_lock failed\n");
+                    "pa_threaded_mainloop_lock failed");
     if (pa_stream_get_state(p->stream) != PA_STREAM_READY) {
         /* wait for stream to become ready */
         l = 0;
@@ -227,7 +227,7 @@ static size_t qpa_buffer_get_free(HWVoiceOut *hw)
 
     l = pa_stream_writable_size(p->stream);
     CHECK_SUCCESS_GOTO(c, l != (size_t) -1, unlock_and_fail,
-                       "pa_stream_writable_size failed\n");
+                       "pa_stream_writable_size failed");
 
 unlock:
     pa_threaded_mainloop_unlock(c->mainloop);
@@ -248,12 +248,12 @@ static void *qpa_get_buffer_out(HWVoiceOut *hw, size_t *size)
     pa_threaded_mainloop_lock(c->mainloop);
 
     CHECK_DEAD_GOTO(c, p->stream, unlock_and_fail,
-                    "pa_threaded_mainloop_lock failed\n");
+                    "pa_threaded_mainloop_lock failed");
 
     *size = -1;
     r = pa_stream_begin_write(p->stream, &ret, size);
     CHECK_SUCCESS_GOTO(c, r >= 0, unlock_and_fail,
-                       "pa_stream_begin_write failed\n");
+                       "pa_stream_begin_write failed");
 
     pa_threaded_mainloop_unlock(c->mainloop);
     return ret;
@@ -273,10 +273,10 @@ static size_t qpa_put_buffer_out(HWVoiceOut *hw, void *data, size_t length)
     pa_threaded_mainloop_lock(c->mainloop);
 
     CHECK_DEAD_GOTO(c, p->stream, unlock_and_fail,
-                    "pa_threaded_mainloop_lock failed\n");
+                    "pa_threaded_mainloop_lock failed");
 
     r = pa_stream_write(p->stream, data, length, NULL, 0LL, PA_SEEK_RELATIVE);
-    CHECK_SUCCESS_GOTO(c, r >= 0, unlock_and_fail, "pa_stream_write failed\n");
+    CHECK_SUCCESS_GOTO(c, r >= 0, unlock_and_fail, "pa_stream_write failed");
 
     pa_threaded_mainloop_unlock(c->mainloop);
     return length;
@@ -296,7 +296,7 @@ static size_t qpa_write(HWVoiceOut *hw, void *data, size_t length)
     pa_threaded_mainloop_lock(c->mainloop);
 
     CHECK_DEAD_GOTO(c, p->stream, unlock_and_fail,
-                    "pa_threaded_mainloop_lock failed\n");
+                    "pa_threaded_mainloop_lock failed");
     if (pa_stream_get_state(p->stream) != PA_STREAM_READY) {
         /* wait for stream to become ready */
         l = 0;
@@ -306,14 +306,14 @@ static size_t qpa_write(HWVoiceOut *hw, void *data, size_t length)
     l = pa_stream_writable_size(p->stream);
 
     CHECK_SUCCESS_GOTO(c, l != (size_t) -1, unlock_and_fail,
-                       "pa_stream_writable_size failed\n");
+                       "pa_stream_writable_size failed");
 
     if (l > length) {
         l = length;
     }
 
     r = pa_stream_write(p->stream, data, l, NULL, 0LL, PA_SEEK_RELATIVE);
-    CHECK_SUCCESS_GOTO(c, r >= 0, unlock_and_fail, "pa_stream_write failed\n");
+    CHECK_SUCCESS_GOTO(c, r >= 0, unlock_and_fail, "pa_stream_write failed");
 
 unlock:
     pa_threaded_mainloop_unlock(c->mainloop);
@@ -345,7 +345,7 @@ static pa_sample_format_t audfmt_to_pa(AudioFormat afmt, bool big_endian)
         format = big_endian ? PA_SAMPLE_FLOAT32BE : PA_SAMPLE_FLOAT32LE;
         break;
     default:
-        dolog ("Internal logic error: Bad audio format %d\n", afmt);
+        error_report("pulseaudio: Internal logic error: Bad audio format %d", afmt);
         format = PA_SAMPLE_U8;
         break;
     }
@@ -376,12 +376,12 @@ static AudioFormat pa_to_audfmt (pa_sample_format_t fmt, int *endianness)
         *endianness = 0;
         return AUDIO_FORMAT_F32;
     default:
-        dolog ("Internal logic error: Bad pa_sample_format %d\n", fmt);
+        error_report("pulseaudio: Internal logic error: Bad pa_sample_format %d", fmt);
         return AUDIO_FORMAT_U8;
     }
 }
 
-static void context_state_cb (pa_context *c, void *userdata)
+static void context_state_cb(pa_context *c, void *userdata)
 {
     PAConnection *conn = userdata;
 
@@ -473,7 +473,7 @@ static pa_stream *qpa_simple_new (
         break;
 
     default:
-        dolog("Internal error: unsupported channel count %d\n", ss->channels);
+        error_report("pulseaudio: unsupported channel count %d", ss->channels);
         goto fail;
     }
 
@@ -553,7 +553,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as)
         &error
         );
     if (!pa->stream) {
-        qpa_logerr (error, "pa_simple_new for playback failed\n");
+        qpa_logerr(error, "pa_simple_new for playback failed");
         goto fail1;
     }
 
@@ -604,7 +604,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as)
         &error
         );
     if (!pa->stream) {
-        qpa_logerr (error, "pa_simple_new for capture failed\n");
+        qpa_logerr(error, "pa_simple_new for capture failed");
         goto fail1;
     }
 
@@ -633,7 +633,7 @@ static void qpa_simple_disconnect(PAConnection *c, pa_stream *stream)
 
     err = pa_stream_disconnect(stream);
     if (err != 0) {
-        dolog("Failed to disconnect! err=%d\n", err);
+        error_report("pulseaudio: Failed to disconnect! err=%d", err);
     }
     pa_stream_unref(stream);
 }
@@ -664,7 +664,7 @@ static void qpa_fini_in (HWVoiceIn *hw)
             int r = pa_stream_drop(pa->stream);
             if (r) {
                 qpa_logerr(pa_context_errno(c->context),
-                           "pa_stream_drop failed\n");
+                           "pa_stream_drop failed");
             }
             pa->read_length = 0;
         }
@@ -698,7 +698,7 @@ static void qpa_volume_out(HWVoiceOut *hw, Volume *vol)
                                           &v, NULL, NULL);
     if (!op) {
         qpa_logerr(pa_context_errno(c->context),
-                   "set_sink_input_volume() failed\n");
+                   "set_sink_input_volume() failed");
     } else {
         pa_operation_unref(op);
     }
@@ -708,7 +708,7 @@ static void qpa_volume_out(HWVoiceOut *hw, Volume *vol)
                                         vol->mute, NULL, NULL);
     if (!op) {
         qpa_logerr(pa_context_errno(c->context),
-                   "set_sink_input_mute() failed\n");
+                   "set_sink_input_mute() failed");
     } else {
         pa_operation_unref(op);
     }
@@ -740,7 +740,7 @@ static void qpa_volume_in(HWVoiceIn *hw, Volume *vol)
         &v, NULL, NULL);
     if (!op) {
         qpa_logerr(pa_context_errno(c->context),
-                   "set_source_output_volume() failed\n");
+                   "set_source_output_volume() failed");
     } else {
         pa_operation_unref(op);
     }
@@ -750,7 +750,7 @@ static void qpa_volume_in(HWVoiceIn *hw, Volume *vol)
         vol->mute, NULL, NULL);
     if (!op) {
         qpa_logerr(pa_context_errno(c->context),
-                   "set_source_output_mute() failed\n");
+                   "set_source_output_mute() failed");
     } else {
         pa_operation_unref(op);
     }
@@ -788,7 +788,7 @@ static void *qpa_conn_init(const char *server)
 
     if (pa_context_connect(c->context, server, 0, NULL) < 0) {
         qpa_logerr(pa_context_errno(c->context),
-                   "pa_context_connect() failed\n");
+                   "pa_context_connect() failed");
         goto fail;
     }
 
@@ -809,7 +809,7 @@ static void *qpa_conn_init(const char *server)
 
         if (!PA_CONTEXT_IS_GOOD(state)) {
             qpa_logerr(pa_context_errno(c->context),
-                       "Wrong context state\n");
+                       "Wrong context state");
             goto unlock_and_fail;
         }
 
@@ -823,7 +823,6 @@ static void *qpa_conn_init(const char *server)
 unlock_and_fail:
     pa_threaded_mainloop_unlock(c->mainloop);
 fail:
-    AUD_log (AUDIO_CAP, "Failed to initialize PA context");
     qpa_conn_fini(c);
     return NULL;
 }

-- 
2.53.0


