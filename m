Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CC6D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 11:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ22T-0005Qo-3c; Mon, 01 Dec 2025 06:25:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ22C-0004M9-Rm
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:25:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ227-0006zx-Pf
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764588323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AMQeH2cjF88ml33Pu3oNyA0OPW5m9DbkCmqc6SBMCVs=;
 b=KhbwEW0P4NZsJKY8xq+7KNt3s9VAYl4wA9vT4N2vhjb0XnfsFc34fO2Mgxe2zZ3gwpd1aW
 UINTmrncs+fYMEqR9ixxBxaFO/8Jo7Gfw/KajXJ0ltsUm6IKrLXgw+8kgv7l8069sXEf+B
 ihmVct753Xb0Ot6r5sR7ffY1jXVdDCM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-uildAgrJOoae2HbSz5M-Gw-1; Mon,
 01 Dec 2025 06:25:18 -0500
X-MC-Unique: uildAgrJOoae2HbSz5M-Gw-1
X-Mimecast-MFC-AGG-ID: uildAgrJOoae2HbSz5M-Gw_1764588316
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F266D1800579; Mon,  1 Dec 2025 11:25:14 +0000 (UTC)
Received: from localhost (unknown [10.45.242.40])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 851401956095; Mon,  1 Dec 2025 11:25:12 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [RFC 18/24] audio: make AudioBackend truely abstract
Date: Mon,  1 Dec 2025 15:22:59 +0400
Message-ID: <20251201112309.4163921-19-marcandre.lureau@redhat.com>
In-Reply-To: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Add virtual methods to be implemented by concrete classes, like
AudioDriverClass.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_template.h       |   9 +-
 include/qemu/audio-capture.h |  13 ---
 include/qemu/audio.h         |  61 ++++++++--
 audio/audio.c                | 208 ++++++++++++++++++++++++++++++-----
 4 files changed, 237 insertions(+), 54 deletions(-)

diff --git a/audio/audio_template.h b/audio/audio_template.h
index 8d66f9cd40..9dee8575f3 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -478,7 +478,7 @@ static void glue (audio_close_, TYPE) (SW *sw)
     g_free (sw);
 }
 
-void glue(AUD_close_, TYPE)(AudioBackend *be, SW *sw)
+static void glue(audio_driver_close_, TYPE)(AudioBackend *be, SW *sw)
 {
     if (sw) {
         if (audio_bug(__func__, !be)) {
@@ -490,14 +490,13 @@ void glue(AUD_close_, TYPE)(AudioBackend *be, SW *sw)
     }
 }
 
-SW *glue (AUD_open_, TYPE) (
+static SW *glue(audio_driver_open_, TYPE) (
     AudioBackend *be,
     SW *sw,
     const char *name,
     void *callback_opaque ,
     audio_callback_fn callback_fn,
-    struct audsettings *as
-    )
+    struct audsettings *as)
 {
     AudioDriver *s = AUDIO_DRIVER(be);
     AudiodevPerDirectionOptions *pdo;
@@ -569,7 +568,7 @@ SW *glue (AUD_open_, TYPE) (
     return NULL;
 }
 
-bool glue(AUD_is_active_, TYPE)(AudioBackend *be, SW *sw)
+static bool glue(audio_driver_is_active_, TYPE)(AudioBackend *be, SW *sw)
 {
     return sw ? sw->active : 0;
 }
diff --git a/include/qemu/audio-capture.h b/include/qemu/audio-capture.h
index f500b0a7f8..5bfbdd0298 100644
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
index 745ee881b8..672f9befe5 100644
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
@@ -53,6 +72,38 @@ typedef struct AudioBackendClass {
 
     bool (*realize)(AudioBackend *be, Audiodev *dev, Error **errp);
     const char *(*get_id)(AudioBackend *be);
+    SWVoiceOut *(*open_out)(
+        AudioBackend *be,
+        SWVoiceOut *sw,
+        const char *name,
+        void *callback_opaque ,
+        audio_callback_fn callback_fn,
+        struct audsettings *as);
+    SWVoiceIn *(*open_in)(
+        AudioBackend *be,
+        SWVoiceIn *sw,
+        const char *name,
+        void *callback_opaque ,
+        audio_callback_fn callback_fn,
+        struct audsettings *as);
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
+    CaptureVoiceOut *(*add_capture)(
+        AudioBackend *be,
+        struct audsettings *as,
+        struct audio_capture_ops *ops,
+        void *cb_opaque);
+    void (*del_capture)(AudioBackend *be, CaptureVoiceOut *cap, void *cb_opaque);
+
 #ifdef CONFIG_GIO
     bool (*set_dbus_server)(AudioBackend *be,
                             GDBusObjectManagerServer *manager,
@@ -73,8 +124,7 @@ SWVoiceOut *AUD_open_out(
     const char *name,
     void *callback_opaque,
     audio_callback_fn callback_fn,
-    struct audsettings *settings
-    );
+    struct audsettings *settings);
 
 void AUD_close_out(AudioBackend *be, SWVoiceOut *sw);
 size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *pcm_buf, size_t size);
@@ -82,13 +132,6 @@ int  AUD_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw);
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
index cc65153dfa..d9c338ea91 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -846,29 +846,36 @@ static void audio_timer (void *opaque)
 /*
  * Public API
  */
+ static size_t audio_driver_write(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t size)
+ {
+     HWVoiceOut *hw;
+
+     if (!sw) {
+         /* XXX: Consider options */
+         return size;
+     }
+     hw = sw->hw;
+
+     if (!hw->enabled) {
+         dolog ("Writing to disabled voice %s\n", SW_NAME (sw));
+         return 0;
+     }
+
+     if (audio_get_pdo_out(hw->s->dev)->mixing_engine) {
+         return audio_pcm_sw_write(sw, buf, size);
+     } else {
+         return hw->pcm_ops->write(hw, buf, size);
+     }
+ }
+
 size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t size)
 {
-    HWVoiceOut *hw;
-
-    if (!sw) {
-        /* XXX: Consider options */
-        return size;
-    }
-    hw = sw->hw;
-
-    if (!hw->enabled) {
-        dolog ("Writing to disabled voice %s\n", SW_NAME (sw));
-        return 0;
-    }
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
-    if (audio_get_pdo_out(hw->s->dev)->mixing_engine) {
-        return audio_pcm_sw_write(sw, buf, size);
-    } else {
-        return hw->pcm_ops->write(hw, buf, size);
-    }
+    return klass->write(be, sw, buf, size);
 }
 
-size_t AUD_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size)
+static size_t audio_driver_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size)
 {
     HWVoiceIn *hw;
 
@@ -888,9 +895,17 @@ size_t AUD_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size)
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
+static int audio_driver_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
 {
     if (!sw) {
         return 0;
@@ -903,7 +918,14 @@ int AUD_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
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
+static void audio_driver_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on)
 {
     HWVoiceOut *hw;
 
@@ -949,9 +971,17 @@ void AUD_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on)
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
+static void audio_driver_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
 {
     HWVoiceIn *hw;
 
@@ -996,6 +1026,13 @@ void AUD_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
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
@@ -1659,12 +1696,95 @@ static const char *audio_driver_get_id(AudioBackend *be)
     return AUDIO_DRIVER(be)->dev->id;
 }
 
+static CaptureVoiceOut *audio_driver_add_capture(
+    AudioBackend *be,
+    struct audsettings *as,
+    struct audio_capture_ops *ops,
+    void *cb_opaque);
+
+static void audio_driver_del_capture(
+    AudioBackend *be,
+    CaptureVoiceOut *cap,
+    void *cb_opaque);
+
+static void audio_driver_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol);
+static void audio_driver_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol);
+
+SWVoiceOut *AUD_open_out(
+    AudioBackend *be,
+    SWVoiceOut *sw,
+    const char *name,
+    void *callback_opaque ,
+    audio_callback_fn callback_fn,
+    struct audsettings *as)
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
+    void *callback_opaque ,
+    audio_callback_fn callback_fn,
+    struct audsettings *as)
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
 static void audio_driver_class_init(ObjectClass *klass, const void *data)
 {
     AudioBackendClass *be = AUDIO_BACKEND_CLASS(klass);
 
     be->realize = audio_be_driver_realize;
     be->get_id = audio_driver_get_id;
+    be->open_in = audio_driver_open_in;
+    be->open_out = audio_driver_open_out;
+    be->close_in = audio_driver_close_in;
+    be->close_out = audio_driver_close_out;
+    be->is_active_out = audio_driver_is_active_out;
+    be->is_active_in = audio_driver_is_active_in;
+    be->set_active_out = audio_driver_set_active_out;
+    be->set_active_in = audio_driver_set_active_in;
+    be->set_volume_out = audio_driver_set_volume_out;
+    be->set_volume_in = audio_driver_set_volume_in;
+    be->read = audio_driver_read;
+    be->write = audio_driver_write;
+    be->get_buffer_size_out = audio_driver_get_buffer_size_out;
+    be->add_capture = audio_driver_add_capture;
+    be->del_capture = audio_driver_del_capture;
 }
 
 static void audio_driver_init(Object *obj)
@@ -1862,12 +1982,11 @@ bool AUD_backend_check(AudioBackend **be, Error **errp)
 
 static struct audio_pcm_ops capture_pcm_ops;
 
-CaptureVoiceOut *AUD_add_capture(
+static CaptureVoiceOut *audio_driver_add_capture(
     AudioBackend *be,
     struct audsettings *as,
     struct audio_capture_ops *ops,
-    void *cb_opaque
-    )
+    void *cb_opaque)
 {
     AudioDriver *s = AUDIO_DRIVER(be);
     CaptureVoiceOut *cap;
@@ -1938,7 +2057,21 @@ CaptureVoiceOut *AUD_add_capture(
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
+static void audio_driver_del_capture(
+    AudioBackend *be,
+    CaptureVoiceOut *cap,
+    void *cb_opaque)
 {
     struct capture_callback *cb;
 
@@ -1977,7 +2110,14 @@ void AUD_del_capture(AudioBackend *be, CaptureVoiceOut *cap, void *cb_opaque)
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
+static void audio_driver_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol)
 {
     if (sw) {
         HWVoiceOut *hw = sw->hw;
@@ -1993,7 +2133,14 @@ void AUD_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol)
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
+static void audio_driver_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol)
 {
     if (sw) {
         HWVoiceIn *hw = sw->hw;
@@ -2009,6 +2156,13 @@ void AUD_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol)
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
2.51.1


