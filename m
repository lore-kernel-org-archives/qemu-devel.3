Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7D7D72347
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 07:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjBzN-0007X9-Qo; Fri, 23 Jan 2026 02:53:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vjByg-0006g3-4X
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 02:53:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vjByc-0002IN-DO
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 02:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769154785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zuYc0ECWBTy1czKo5i10dqgTqs2nMyrjdJ8OMdChWBA=;
 b=AYpRa1VW8THA2s3vottPfAqgrx+v0Ps59mtVG7n3CvR8YT5tHRuOdvceAsN9hOlqrENrTB
 qC93Graywj9belA9/P4gMOBs95tNGFTY4zCoLl7dA2clfmDZyOdum33/T43d7WT4DIMgrW
 lpfgBUzZbKZWLerN5U/e7msoBbUUjDI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-mYpTtM7XOBSLj8Cs9QCZBg-1; Fri,
 23 Jan 2026 02:53:02 -0500
X-MC-Unique: mYpTtM7XOBSLj8Cs9QCZBg-1
X-Mimecast-MFC-AGG-ID: mYpTtM7XOBSLj8Cs9QCZBg_1769154781
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55F6E1956094; Fri, 23 Jan 2026 07:53:01 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A2BC330002D1; Fri, 23 Jan 2026 07:52:59 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 31/37] audio: make AudioBackend truly abstract
Date: Fri, 23 Jan 2026 11:49:34 +0400
Message-ID: <20260123074945.2563196-32-marcandre.lureau@redhat.com>
In-Reply-To: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add virtual methods to be implemented by concrete classes, like
AudioMixengBackendClass.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_template.h       |   9 +-
 include/qemu/audio-capture.h |  13 ---
 include/qemu/audio.h         |  58 +++++++++--
 audio/audio.c                | 187 ++++++++++++++++++++++++++++++++---
 4 files changed, 227 insertions(+), 40 deletions(-)

diff --git a/audio/audio_template.h b/audio/audio_template.h
index 33f2ff432eb..a7733f9e1d9 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -478,7 +478,7 @@ static void glue (audio_close_, TYPE) (SW *sw)
     g_free (sw);
 }
 
-void glue(AUD_close_, TYPE)(AudioBackend *be, SW *sw)
+static void glue(audio_mixeng_backend_close_, TYPE)(AudioBackend *be, SW *sw)
 {
     if (sw) {
         if (audio_bug(__func__, !be)) {
@@ -490,14 +490,13 @@ void glue(AUD_close_, TYPE)(AudioBackend *be, SW *sw)
     }
 }
 
-SW *glue (AUD_open_, TYPE) (
+static SW *glue(audio_mixeng_backend_open_, TYPE) (
     AudioBackend *be,
     SW *sw,
     const char *name,
     void *callback_opaque ,
     audio_callback_fn callback_fn,
-    const struct audsettings *as
-    )
+    const struct audsettings *as)
 {
     AudioMixengBackend *s = AUDIO_MIXENG_BACKEND(be);
     AudiodevPerDirectionOptions *pdo;
@@ -569,7 +568,7 @@ SW *glue (AUD_open_, TYPE) (
     return NULL;
 }
 
-bool glue(AUD_is_active_, TYPE)(AudioBackend *be, SW *sw)
+static bool glue(audio_mixeng_backend_is_active_, TYPE)(AudioBackend *be, SW *sw)
 {
     return sw ? sw->active : 0;
 }
diff --git a/include/qemu/audio-capture.h b/include/qemu/audio-capture.h
index f500b0a7f8c..5bfbdd02985 100644
--- a/include/qemu/audio-capture.h
+++ b/include/qemu/audio-capture.h
@@ -8,19 +8,6 @@
 
 #include "audio.h"
 
-typedef struct CaptureVoiceOut CaptureVoiceOut;
-
-typedef enum {
-    AUD_CNOTIFY_ENABLE,
-    AUD_CNOTIFY_DISABLE
-} audcnotification_e;
-
-struct audio_capture_ops {
-    void (*notify) (void *opaque, audcnotification_e cmd);
-    void (*capture) (void *opaque, const void *buf, int size);
-    void (*destroy) (void *opaque);
-};
-
 struct capture_ops {
     void (*info) (void *opaque);
     void (*destroy) (void *opaque);
diff --git a/include/qemu/audio.h b/include/qemu/audio.h
index e87708e3d1e..4fae48886ba 100644
--- a/include/qemu/audio.h
+++ b/include/qemu/audio.h
@@ -43,6 +43,25 @@ typedef struct audsettings {
 
 typedef struct SWVoiceOut SWVoiceOut;
 typedef struct SWVoiceIn SWVoiceIn;
+typedef struct CaptureVoiceOut CaptureVoiceOut;
+
+typedef enum {
+    AUD_CNOTIFY_ENABLE,
+    AUD_CNOTIFY_DISABLE
+} audcnotification_e;
+
+struct audio_capture_ops {
+    void (*notify) (void *opaque, audcnotification_e cmd);
+    void (*capture) (void *opaque, const void *buf, int size);
+    void (*destroy) (void *opaque);
+};
+
+#define AUDIO_MAX_CHANNELS 16
+typedef struct Volume {
+    bool mute;
+    int channels;
+    uint8_t vol[AUDIO_MAX_CHANNELS];
+} Volume;
 
 typedef struct AudioBackend {
     Object parent_obj;
@@ -53,6 +72,35 @@ typedef struct AudioBackendClass {
 
     bool (*realize)(AudioBackend *be, Audiodev *dev, Error **errp);
     const char *(*get_id)(AudioBackend *be);
+    SWVoiceOut *(*open_out)(AudioBackend *be,
+                            SWVoiceOut *sw,
+                            const char *name,
+                            void *callback_opaque,
+                            audio_callback_fn callback_fn,
+                            const struct audsettings *as);
+    SWVoiceIn *(*open_in)(AudioBackend *be,
+                          SWVoiceIn *sw,
+                          const char *name,
+                          void *callback_opaque,
+                          audio_callback_fn callback_fn,
+                          const struct audsettings *as);
+    void (*close_out)(AudioBackend *be, SWVoiceOut *sw);
+    void (*close_in)(AudioBackend *be, SWVoiceIn *sw);
+    bool (*is_active_out)(AudioBackend *be, SWVoiceOut *sw);
+    bool (*is_active_in)(AudioBackend *be, SWVoiceIn *sw);
+    void (*set_active_out)(AudioBackend *be, SWVoiceOut *sw, bool on);
+    void (*set_active_in)(AudioBackend *be, SWVoiceIn *sw, bool on);
+    void (*set_volume_out)(AudioBackend *be, SWVoiceOut *sw, Volume *vol);
+    void (*set_volume_in)(AudioBackend *be, SWVoiceIn *sw, Volume *vol);
+    size_t (*write)(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t size);
+    size_t (*read)(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size);
+    int (*get_buffer_size_out)(AudioBackend *be, SWVoiceOut *sw);
+    CaptureVoiceOut *(*add_capture)(AudioBackend *be,
+                                    struct audsettings *as,
+                                    struct audio_capture_ops *ops,
+                                    void *cb_opaque);
+    void (*del_capture)(AudioBackend *be, CaptureVoiceOut *cap, void *cb_opaque);
+
 #ifdef CONFIG_GIO
     bool (*set_dbus_server)(AudioBackend *be,
                             GDBusObjectManagerServer *manager,
@@ -69,8 +117,7 @@ SWVoiceOut *AUD_open_out(
     const char *name,
     void *callback_opaque,
     audio_callback_fn callback_fn,
-    const struct audsettings *settings
-    );
+    const struct audsettings *settings);
 
 void AUD_close_out(AudioBackend *be, SWVoiceOut *sw);
 size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *pcm_buf, size_t size);
@@ -78,13 +125,6 @@ int  AUD_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw);
 void AUD_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on);
 bool AUD_is_active_out(AudioBackend *be, SWVoiceOut *sw);
 
-#define AUDIO_MAX_CHANNELS 16
-typedef struct Volume {
-    bool mute;
-    int channels;
-    uint8_t vol[AUDIO_MAX_CHANNELS];
-} Volume;
-
 void AUD_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol);
 void AUD_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol);
 
diff --git a/audio/audio.c b/audio/audio.c
index 6bfec5e1d75..3f09452e300 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -846,7 +846,8 @@ static void audio_timer (void *opaque)
 /*
  * Public API
  */
-size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t size)
+static size_t audio_mixeng_backend_write(AudioBackend *be, SWVoiceOut *sw,
+                                         void *buf, size_t size)
 {
     HWVoiceOut *hw;
 
@@ -857,7 +858,7 @@ size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t size)
     hw = sw->hw;
 
     if (!hw->enabled) {
-        dolog ("Writing to disabled voice %s\n", SW_NAME (sw));
+        dolog("Writing to disabled voice %s\n", SW_NAME(sw));
         return 0;
     }
 
@@ -868,7 +869,15 @@ size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t size)
     }
 }
 
-size_t AUD_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size)
+size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t size)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->write(be, sw, buf, size);
+}
+
+static size_t audio_mixeng_backend_read(AudioBackend *be, SWVoiceIn *sw,
+                                        void *buf, size_t size)
 {
     HWVoiceIn *hw;
 
@@ -879,7 +888,7 @@ size_t AUD_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size)
     hw = sw->hw;
 
     if (!hw->enabled) {
-        dolog ("Reading from disabled voice %s\n", SW_NAME (sw));
+        dolog("Reading from disabled voice %s\n", SW_NAME(sw));
         return 0;
     }
 
@@ -888,9 +897,17 @@ size_t AUD_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size)
     } else {
         return hw->pcm_ops->read(hw, buf, size);
     }
+
 }
 
-int AUD_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
+size_t AUD_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->read(be, sw, buf, size);
+}
+
+static int audio_mixeng_backend_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
 {
     if (!sw) {
         return 0;
@@ -903,7 +920,15 @@ int AUD_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
     return sw->hw->samples * sw->hw->info.bytes_per_frame;
 }
 
-void AUD_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on)
+int AUD_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->get_buffer_size_out(be, sw);
+}
+
+static void audio_mixeng_backend_set_active_out(AudioBackend *be, SWVoiceOut *sw,
+                                                bool on)
 {
     HWVoiceOut *hw;
 
@@ -949,9 +974,17 @@ void AUD_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on)
         }
         sw->active = on;
     }
+
 }
 
-void AUD_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
+void AUD_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->set_active_out(be, sw, on);
+}
+
+static void audio_mixeng_backend_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
 {
     HWVoiceIn *hw;
 
@@ -996,6 +1029,13 @@ void AUD_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
     }
 }
 
+void AUD_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->set_active_in(be, sw, on);
+}
+
 static size_t audio_get_avail(SWVoiceIn *sw)
 {
     size_t live;
@@ -1657,12 +1697,97 @@ static const char *audio_mixeng_backend_get_id(AudioBackend *be)
     return AUDIO_MIXENG_BACKEND(be)->dev->id;
 }
 
+static CaptureVoiceOut *audio_mixeng_backend_add_capture(
+    AudioBackend *be,
+    struct audsettings *as,
+    struct audio_capture_ops *ops,
+    void *cb_opaque);
+
+static void audio_mixeng_backend_del_capture(
+    AudioBackend *be,
+    CaptureVoiceOut *cap,
+    void *cb_opaque);
+
+static void audio_mixeng_backend_set_volume_out(AudioBackend *be, SWVoiceOut *sw,
+                                                Volume *vol);
+static void audio_mixeng_backend_set_volume_in(AudioBackend *be, SWVoiceIn *sw,
+                                               Volume *vol);
+
+SWVoiceOut *AUD_open_out(
+    AudioBackend *be,
+    SWVoiceOut *sw,
+    const char *name,
+    void *callback_opaque,
+    audio_callback_fn callback_fn,
+    const struct audsettings *as)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->open_out(be, sw, name, callback_opaque, callback_fn, as);
+}
+
+SWVoiceIn *AUD_open_in(
+    AudioBackend *be,
+    SWVoiceIn *sw,
+    const char *name,
+    void *callback_opaque,
+    audio_callback_fn callback_fn,
+    const struct audsettings *as)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->open_in(be, sw, name, callback_opaque, callback_fn, as);
+}
+
+void AUD_close_out(AudioBackend *be, SWVoiceOut *sw)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->close_out(be, sw);
+}
+
+void AUD_close_in(AudioBackend *be, SWVoiceIn *sw)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->close_in(be, sw);
+}
+
+bool AUD_is_active_out(AudioBackend *be, SWVoiceOut *sw)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->is_active_out(be, sw);
+}
+
+bool AUD_is_active_in(AudioBackend *be, SWVoiceIn *sw)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->is_active_in(be, sw);
+}
+
 static void audio_mixeng_backend_class_init(ObjectClass *klass, const void *data)
 {
     AudioBackendClass *be = AUDIO_BACKEND_CLASS(klass);
 
     be->realize = audio_mixeng_backend_realize;
     be->get_id = audio_mixeng_backend_get_id;
+    be->open_in = audio_mixeng_backend_open_in;
+    be->open_out = audio_mixeng_backend_open_out;
+    be->close_in = audio_mixeng_backend_close_in;
+    be->close_out = audio_mixeng_backend_close_out;
+    be->is_active_out = audio_mixeng_backend_is_active_out;
+    be->is_active_in = audio_mixeng_backend_is_active_in;
+    be->set_active_out = audio_mixeng_backend_set_active_out;
+    be->set_active_in = audio_mixeng_backend_set_active_in;
+    be->set_volume_out = audio_mixeng_backend_set_volume_out;
+    be->set_volume_in = audio_mixeng_backend_set_volume_in;
+    be->read = audio_mixeng_backend_read;
+    be->write = audio_mixeng_backend_write;
+    be->get_buffer_size_out = audio_mixeng_backend_get_buffer_size_out;
+    be->add_capture = audio_mixeng_backend_add_capture;
+    be->del_capture = audio_mixeng_backend_del_capture;
 }
 
 static void audio_mixeng_backend_init(Object *obj)
@@ -1862,12 +1987,11 @@ bool AUD_backend_check(AudioBackend **be, Error **errp)
 
 static struct audio_pcm_ops capture_pcm_ops;
 
-CaptureVoiceOut *AUD_add_capture(
+static CaptureVoiceOut *audio_mixeng_backend_add_capture(
     AudioBackend *be,
     struct audsettings *as,
     struct audio_capture_ops *ops,
-    void *cb_opaque
-    )
+    void *cb_opaque)
 {
     AudioMixengBackend *s = AUDIO_MIXENG_BACKEND(be);
     CaptureVoiceOut *cap;
@@ -1937,7 +2061,21 @@ CaptureVoiceOut *AUD_add_capture(
     return cap;
 }
 
-void AUD_del_capture(AudioBackend *be, CaptureVoiceOut *cap, void *cb_opaque)
+CaptureVoiceOut *AUD_add_capture(
+    AudioBackend *be,
+    struct audsettings *as,
+    struct audio_capture_ops *ops,
+    void *cb_opaque)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->add_capture(be, as, ops, cb_opaque);
+}
+
+static void audio_mixeng_backend_del_capture(
+    AudioBackend *be,
+    CaptureVoiceOut *cap,
+    void *cb_opaque)
 {
     struct capture_callback *cb;
 
@@ -1976,7 +2114,15 @@ void AUD_del_capture(AudioBackend *be, CaptureVoiceOut *cap, void *cb_opaque)
     }
 }
 
-void AUD_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol)
+void AUD_del_capture(AudioBackend *be, CaptureVoiceOut *cap, void *cb_opaque)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    klass->del_capture(be, cap, cb_opaque);
+}
+
+static void audio_mixeng_backend_set_volume_out(AudioBackend *be, SWVoiceOut *sw,
+                                                Volume *vol)
 {
     if (sw) {
         HWVoiceOut *hw = sw->hw;
@@ -1992,7 +2138,15 @@ void AUD_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol)
     }
 }
 
-void AUD_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol)
+void AUD_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    klass->set_volume_out(be, sw, vol);
+}
+
+static void audio_mixeng_backend_set_volume_in(AudioBackend *be, SWVoiceIn *sw,
+                                               Volume *vol)
 {
     if (sw) {
         HWVoiceIn *hw = sw->hw;
@@ -2008,6 +2162,13 @@ void AUD_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol)
     }
 }
 
+void AUD_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    klass->set_volume_in(be, sw, vol);
+}
+
 static void audio_create_pdos(Audiodev *dev)
 {
     switch (dev->driver) {
-- 
2.52.0


