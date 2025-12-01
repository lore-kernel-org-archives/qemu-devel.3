Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990DED116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 11:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ211-0000RO-EC; Mon, 01 Dec 2025 06:24:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ20s-0000AO-7T
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:24:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ20h-0006We-K9
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:24:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764588231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u22Z74ggQFnSD0lEFLOdNYJgF5urxADWPdEIvOhtE34=;
 b=M6st/Nlqrx6ljF/VLghu1QC5COJAdP1ArfMUNqitjbc1wDIDx48jhDtDeGBrZsXvnqWETW
 URdhbw16LVGuxEKvImuz6ckx6HYV9h8tOAxxw4RhVbc/ogP7T3gjh8LkgCd0n3wAgL7r9V
 O9FgvYwj/vKGGlvBaPeuJs4IEgEbkrI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-X-YKr5zDN4CXgqdunIHC_g-1; Mon,
 01 Dec 2025 06:23:50 -0500
X-MC-Unique: X-YKr5zDN4CXgqdunIHC_g-1
X-Mimecast-MFC-AGG-ID: X-YKr5zDN4CXgqdunIHC_g_1764588228
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9336D195608E; Mon,  1 Dec 2025 11:23:48 +0000 (UTC)
Received: from localhost (unknown [10.45.242.40])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 372471800451; Mon,  1 Dec 2025 11:23:45 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [RFC 05/24] audio: introduce AudioDriver
Date: Mon,  1 Dec 2025 15:22:46 +0400
Message-ID: <20251201112309.4163921-6-marcandre.lureau@redhat.com>
In-Reply-To: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Introduce a sub-class for current "audio_driver" based implementations.
Future AudioBackend implementations can do without it.

Next cleanup will actually remove "audio_driver" struct altogether and
make the subclass proper QOM objects.

Public APIs still rely on backend being an AudioDriver. They will
assert() if not. This will be addressed later to allow other backends.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_int.h      |  25 +++++---
 audio/audio_template.h |  18 +++---
 include/qemu/audio.h   |  17 +++++-
 audio/alsaaudio.c      |   2 +-
 audio/audio.c          | 126 +++++++++++++++++++++++++++++++----------
 audio/dbusaudio.c      |   8 +--
 audio/ossaudio.c       |   4 +-
 ui/dbus.c              |   3 +-
 8 files changed, 142 insertions(+), 61 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index b2b8002477..e1f962875f 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -61,7 +61,7 @@ struct audio_pcm_info {
     int swap_endianness;
 };
 
-typedef struct AudioBackend AudioBackend;
+typedef struct AudioDriver AudioDriver;
 typedef struct SWVoiceCap SWVoiceCap;
 
 typedef struct STSampleBuffer {
@@ -70,7 +70,7 @@ typedef struct STSampleBuffer {
 } STSampleBuffer;
 
 typedef struct HWVoiceOut {
-    AudioBackend *s;
+    AudioDriver *s;
     bool enabled;
     int poll_mode;
     bool pending_disable;
@@ -91,7 +91,7 @@ typedef struct HWVoiceOut {
 } HWVoiceOut;
 
 typedef struct HWVoiceIn {
-    AudioBackend *s;
+    AudioDriver *s;
     bool enabled;
     int poll_mode;
     struct audio_pcm_info info;
@@ -112,7 +112,7 @@ typedef struct HWVoiceIn {
 } HWVoiceIn;
 
 struct SWVoiceOut {
-    AudioBackend *s;
+    AudioDriver *s;
     struct audio_pcm_info info;
     t_sample *conv;
     STSampleBuffer resample_buf;
@@ -128,7 +128,7 @@ struct SWVoiceOut {
 };
 
 struct SWVoiceIn {
-    AudioBackend *s;
+    AudioDriver *s;
     bool active;
     struct audio_pcm_info info;
     void *rate;
@@ -241,8 +241,12 @@ struct SWVoiceCap {
     QLIST_ENTRY (SWVoiceCap) entries;
 };
 
-typedef struct AudioBackend {
-    Object parent;
+struct AudioDriverClass {
+    AudioBackendClass parent_class;
+};
+
+struct AudioDriver {
+    AudioBackend parent_obj;
 
     struct audio_driver *drv;
     Audiodev *dev;
@@ -260,7 +264,7 @@ typedef struct AudioBackend {
     bool timer_running;
     uint64_t timer_last;
     VMChangeStateEntry *vmse;
-} AudioBackend;
+};
 
 extern const struct mixeng_volume nominal_volume;
 
@@ -273,7 +277,7 @@ void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len);
 
 int audio_bug (const char *funcname, int cond);
 
-void audio_run(AudioBackend *s, const char *msg);
+void audio_run(AudioDriver *s, const char *msg);
 
 const char *audio_application_name(void);
 
@@ -326,4 +330,7 @@ void audio_create_pdos(Audiodev *dev);
 AudiodevPerDirectionOptions *audio_get_pdo_in(Audiodev *dev);
 AudiodevPerDirectionOptions *audio_get_pdo_out(Audiodev *dev);
 
+#define TYPE_AUDIO_DRIVER "audio-driver"
+OBJECT_DECLARE_TYPE(AudioDriver, AudioDriverClass, AUDIO_DRIVER)
+
 #endif /* QEMU_AUDIO_INT_H */
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 1ab3c47fd7..925a878f6d 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -36,7 +36,7 @@
 #define HWBUF hw->conv_buf
 #endif
 
-static void glue(audio_init_nb_voices_, TYPE)(AudioBackend *s,
+static void glue(audio_init_nb_voices_, TYPE)(AudioDriver *s,
                                               struct audio_driver *drv, int min_voices)
 {
     int max_voices = glue (drv->max_voices_, TYPE);
@@ -221,7 +221,7 @@ static void glue (audio_pcm_hw_del_sw_, TYPE) (SW *sw)
 static void glue (audio_pcm_hw_gc_, TYPE) (HW **hwp)
 {
     HW *hw = *hwp;
-    AudioBackend *s = hw->s;
+    AudioDriver *s = hw->s;
 
     if (!hw->sw_head.lh_first) {
 #ifdef DAC
@@ -236,12 +236,12 @@ static void glue (audio_pcm_hw_gc_, TYPE) (HW **hwp)
     }
 }
 
-static HW *glue(audio_pcm_hw_find_any_, TYPE)(AudioBackend *s, HW *hw)
+static HW *glue(audio_pcm_hw_find_any_, TYPE)(AudioDriver *s, HW *hw)
 {
     return hw ? hw->entries.le_next : glue (s->hw_head_, TYPE).lh_first;
 }
 
-static HW *glue(audio_pcm_hw_find_any_enabled_, TYPE)(AudioBackend *s, HW *hw)
+static HW *glue(audio_pcm_hw_find_any_enabled_, TYPE)(AudioDriver *s, HW *hw)
 {
     while ((hw = glue(audio_pcm_hw_find_any_, TYPE)(s, hw))) {
         if (hw->enabled) {
@@ -251,7 +251,7 @@ static HW *glue(audio_pcm_hw_find_any_enabled_, TYPE)(AudioBackend *s, HW *hw)
     return NULL;
 }
 
-static HW *glue(audio_pcm_hw_find_specific_, TYPE)(AudioBackend *s, HW *hw,
+static HW *glue(audio_pcm_hw_find_specific_, TYPE)(AudioDriver *s, HW *hw,
                                                    struct audsettings *as)
 {
     while ((hw = glue(audio_pcm_hw_find_any_, TYPE)(s, hw))) {
@@ -262,7 +262,7 @@ static HW *glue(audio_pcm_hw_find_specific_, TYPE)(AudioBackend *s, HW *hw,
     return NULL;
 }
 
-static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioBackend *s,
+static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioDriver *s,
                                              struct audsettings *as)
 {
     HW *hw;
@@ -398,7 +398,7 @@ AudiodevPerDirectionOptions *glue(audio_get_pdo_, TYPE)(Audiodev *dev)
     abort();
 }
 
-static HW *glue(audio_pcm_hw_add_, TYPE)(AudioBackend *s, struct audsettings *as)
+static HW *glue(audio_pcm_hw_add_, TYPE)(AudioDriver *s, struct audsettings *as)
 {
     HW *hw;
     AudiodevPerDirectionOptions *pdo = glue(audio_get_pdo_, TYPE)(s->dev);
@@ -424,7 +424,7 @@ static HW *glue(audio_pcm_hw_add_, TYPE)(AudioBackend *s, struct audsettings *as
 }
 
 static SW *glue(audio_pcm_create_voice_pair_, TYPE)(
-    AudioBackend *s,
+    AudioDriver *s,
     const char *sw_name,
     struct audsettings *as
     )
@@ -494,7 +494,7 @@ SW *glue (AUD_open_, TYPE) (
     struct audsettings *as
     )
 {
-    AudioBackend *s = be;
+    AudioDriver *s = AUDIO_DRIVER(be);
     AudiodevPerDirectionOptions *pdo;
 
     if (audio_bug(__func__, !be || !name || !callback_fn || !as)) {
diff --git a/include/qemu/audio.h b/include/qemu/audio.h
index 2562710bec..f83f8326ab 100644
--- a/include/qemu/audio.h
+++ b/include/qemu/audio.h
@@ -44,11 +44,21 @@ typedef struct audsettings {
 typedef struct SWVoiceOut SWVoiceOut;
 typedef struct SWVoiceIn SWVoiceIn;
 
-struct AudioBackendClass {
+typedef struct AudioBackend {
+    Object parent_obj;
+} AudioBackend;
+
+typedef struct AudioBackendClass {
     ObjectClass parent_class;
-};
 
-typedef struct AudioBackend AudioBackend;
+    const char *(*get_id)(AudioBackend *be);
+#ifdef CONFIG_GIO
+    bool (*set_dbus_server)(AudioBackend *be,
+                            GDBusObjectManagerServer *manager,
+                            bool p2p,
+                            Error **errp);
+#endif
+} AudioBackendClass;
 
 typedef struct QEMUAudioTimeStamp {
     uint64_t old_ts;
@@ -129,6 +139,7 @@ AudioBackend *audio_be_by_name(const char *name, Error **errp);
 AudioBackend *audio_get_default_audio_be(Error **errp);
 const char *audio_be_get_id(AudioBackend *be);
 #ifdef CONFIG_GIO
+bool audio_be_can_set_dbus_server(AudioBackend *be);
 bool audio_be_set_dbus_server(AudioBackend *be,
                               GDBusObjectManagerServer *server,
                               bool p2p,
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 7d7da576dc..278c74c5de 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -41,7 +41,7 @@ struct pollhlp {
     struct pollfd *pfds;
     int count;
     int mask;
-    AudioBackend *s;
+    AudioDriver *s;
 };
 
 typedef struct ALSAVoiceOut {
diff --git a/audio/audio.c b/audio/audio.c
index 0f992a775c..4a43761528 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -36,6 +36,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/help_option.h"
+#include "qom/object.h"
 #include "system/system.h"
 #include "system/replay.h"
 #include "system/runstate.h"
@@ -383,7 +384,7 @@ void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len)
 /*
  * Capture
  */
-static CaptureVoiceOut *audio_pcm_capture_find_specific(AudioBackend *s,
+static CaptureVoiceOut *audio_pcm_capture_find_specific(AudioDriver *s,
                                                         struct audsettings *as)
 {
     CaptureVoiceOut *cap;
@@ -463,7 +464,7 @@ static void audio_detach_capture (HWVoiceOut *hw)
 
 static int audio_attach_capture (HWVoiceOut *hw)
 {
-    AudioBackend *s = hw->s;
+    AudioDriver *s = hw->s;
     CaptureVoiceOut *cap;
 
     audio_detach_capture (hw);
@@ -801,7 +802,7 @@ static void audio_pcm_print_info (const char *cap, struct audio_pcm_info *info)
 /*
  * Timer
  */
-static int audio_is_timer_needed(AudioBackend *s)
+static int audio_is_timer_needed(AudioDriver *s)
 {
     HWVoiceIn *hwi = NULL;
     HWVoiceOut *hwo = NULL;
@@ -819,7 +820,7 @@ static int audio_is_timer_needed(AudioBackend *s)
     return 0;
 }
 
-static void audio_reset_timer(AudioBackend *s)
+static void audio_reset_timer(AudioDriver *s)
 {
     if (audio_is_timer_needed(s)) {
         timer_mod_anticipate_ns(s->ts,
@@ -841,7 +842,7 @@ static void audio_reset_timer(AudioBackend *s)
 static void audio_timer (void *opaque)
 {
     int64_t now, diff;
-    AudioBackend *s = opaque;
+    AudioDriver *s = opaque;
 
     now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     diff = now - s->timer_last;
@@ -924,7 +925,7 @@ void AUD_set_active_out(SWVoiceOut *sw, bool on)
 
     hw = sw->hw;
     if (sw->active != on) {
-        AudioBackend *s = sw->s;
+        AudioDriver *s = sw->s;
         SWVoiceOut *temp_sw;
         SWVoiceCap *sc;
 
@@ -972,7 +973,7 @@ void AUD_set_active_in(SWVoiceIn *sw, bool on)
 
     hw = sw->hw;
     if (sw->active != on) {
-        AudioBackend *s = sw->s;
+        AudioDriver *s = sw->s;
         SWVoiceIn *temp_sw;
 
         if (on) {
@@ -1140,7 +1141,7 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
     return clipped;
 }
 
-static void audio_run_out(AudioBackend *s)
+static void audio_run_out(AudioDriver *s)
 {
     HWVoiceOut *hw = NULL;
     SWVoiceOut *sw;
@@ -1294,7 +1295,7 @@ static size_t audio_pcm_hw_run_in(HWVoiceIn *hw, size_t samples)
     return conv;
 }
 
-static void audio_run_in(AudioBackend *s)
+static void audio_run_in(AudioDriver *s)
 {
     HWVoiceIn *hw = NULL;
 
@@ -1342,7 +1343,7 @@ static void audio_run_in(AudioBackend *s)
     }
 }
 
-static void audio_run_capture(AudioBackend *s)
+static void audio_run_capture(AudioDriver *s)
 {
     CaptureVoiceOut *cap;
 
@@ -1389,7 +1390,7 @@ static void audio_run_capture(AudioBackend *s)
     }
 }
 
-void audio_run(AudioBackend *s, const char *msg)
+void audio_run(AudioDriver *s, const char *msg)
 {
     audio_run_out(s);
     audio_run_in(s);
@@ -1562,8 +1563,8 @@ size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
     return total;
 }
 
-static bool audio_driver_init(AudioBackend *s, struct audio_driver *drv,
-                              Audiodev *dev, Error **errp)
+static bool audio_driver_do_init(AudioDriver *s, struct audio_driver *drv,
+                                 Audiodev *dev, Error **errp)
 {
     s->drv_opaque = drv->init(dev, errp);
     if (!s->drv_opaque) {
@@ -1595,7 +1596,7 @@ static bool audio_driver_init(AudioBackend *s, struct audio_driver *drv,
 static void audio_vm_change_state_handler (void *opaque, bool running,
                                            RunState state)
 {
-    AudioBackend *s = opaque;
+    AudioDriver *s = opaque;
     HWVoiceOut *hwo = NULL;
     HWVoiceIn *hwi = NULL;
 
@@ -1618,7 +1619,47 @@ static const VMStateDescription vmstate_audio;
 
 static void audio_be_init(Object *obj)
 {
-    AudioBackend *s = AUDIO_BACKEND(obj);
+}
+
+static void audio_be_finalize(Object *obj)
+{
+}
+
+static const char *audio_driver_get_id(AudioBackend *be)
+{
+    return AUDIO_DRIVER(be)->dev->id;
+}
+
+#ifdef CONFIG_GIO
+static bool audio_driver_set_dbus_server(AudioBackend *be,
+                                            GDBusObjectManagerServer *manager,
+                                            bool p2p,
+                                            Error **errp)
+{
+    AudioDriver *d = AUDIO_DRIVER(be);
+
+    if (!d->drv->set_dbus_server) {
+        return false;
+    }
+
+    return d->drv->set_dbus_server(be, manager, p2p, errp);
+}
+
+#endif
+
+static void audio_driver_class_init(ObjectClass *klass, const void *data)
+{
+    AudioBackendClass *be = AUDIO_BACKEND_CLASS(klass);
+
+    be->get_id = audio_driver_get_id;
+#ifdef CONFIG_GIO
+    be->set_dbus_server = audio_driver_set_dbus_server;
+#endif
+}
+
+static void audio_driver_init(Object *obj)
+{
+    AudioDriver *s = AUDIO_DRIVER(obj);
 
     QLIST_INIT(&s->hw_head_out);
     QLIST_INIT(&s->hw_head_in);
@@ -1631,9 +1672,9 @@ static void audio_be_init(Object *obj)
     vmstate_register_any(NULL, &vmstate_audio, s);
 }
 
-static void audio_be_finalize(Object *obj)
+static void audio_driver_finalize(Object *obj)
 {
-    AudioBackend *s = AUDIO_BACKEND(obj);
+    AudioDriver *s = AUDIO_DRIVER(obj);
     HWVoiceOut *hwo, *hwon;
     HWVoiceIn *hwi, *hwin;
 
@@ -1749,10 +1790,10 @@ static AudioBackend *audio_init(Audiodev *dev, Error **errp)
 {
     int done = 0;
     const char *drvname;
-    AudioBackend *s;
+    AudioDriver *s;
     struct audio_driver *driver;
 
-    s = AUDIO_BACKEND(object_new(TYPE_AUDIO_BACKEND));
+    s = AUDIO_DRIVER(object_new(TYPE_AUDIO_DRIVER));
 
     if (dev) {
         /* -audiodev option */
@@ -1760,7 +1801,7 @@ static AudioBackend *audio_init(Audiodev *dev, Error **errp)
         drvname = AudiodevDriver_str(dev->driver);
         driver = audio_driver_lookup(drvname);
         if (driver) {
-            done = audio_driver_init(s, driver, dev, errp);
+            done = audio_driver_do_init(s, driver, dev, errp);
         } else {
             error_setg(errp, "Unknown audio driver `%s'", drvname);
         }
@@ -1780,7 +1821,7 @@ static AudioBackend *audio_init(Audiodev *dev, Error **errp)
             g_free(e);
             drvname = AudiodevDriver_str(dev->driver);
             driver = audio_driver_lookup(drvname);
-            if (audio_driver_init(s, driver, dev, NULL)) {
+            if (audio_driver_do_init(s, driver, dev, NULL)) {
                 break;
             }
             qapi_free_Audiodev(dev);
@@ -1792,7 +1833,7 @@ static AudioBackend *audio_init(Audiodev *dev, Error **errp)
         goto out;
     }
     object_unref(s);
-    return s;
+    return AUDIO_BACKEND(s);
 
 out:
     object_unref(s);
@@ -1831,17 +1872,19 @@ bool AUD_backend_check(AudioBackend **be, Error **errp)
 static struct audio_pcm_ops capture_pcm_ops;
 
 CaptureVoiceOut *AUD_add_capture(
-    AudioBackend *s,
+    AudioBackend *be,
     struct audsettings *as,
     struct audio_capture_ops *ops,
     void *cb_opaque
     )
 {
+    AudioDriver *s = AUDIO_DRIVER(be);
     CaptureVoiceOut *cap;
     struct capture_callback *cb;
 
     if (!s) {
-        error_report("Capturing without setting an audiodev is not supported");
+        /* TODO: implement an interface instead (or drop capture support) */
+        error_report("Capturing without setting an audiodev driver is not supported");
         abort();
     }
 
@@ -2227,27 +2270,36 @@ AudioBackend *audio_be_by_name(const char *name, Error **errp)
 }
 
 #ifdef CONFIG_GIO
+bool audio_be_can_set_dbus_server(AudioBackend *be)
+{
+    /*
+     * AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+     * return klass->set_dbus_server != NULL;
+     */
+     return AUDIO_DRIVER(be)->drv->set_dbus_server != NULL;
+}
+
 bool audio_be_set_dbus_server(AudioBackend *be,
                               GDBusObjectManagerServer *server,
                               bool p2p,
                               Error **errp)
 {
-    assert(be != NULL);
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
 
-    if (!be->drv->set_dbus_server) {
-        error_setg(errp, "Audiodev '%s' is not compatible with DBus", be->dev->id);
+    if (!audio_be_can_set_dbus_server(be)) {
+        error_setg(errp, "Audiodev '%s' is not compatible with DBus",
+                   audio_be_get_id(be));
         return false;
     }
 
-    return be->drv->set_dbus_server(be, server, p2p, errp);
+    return klass->set_dbus_server(be, server, p2p, errp);
 }
 #endif
 
 const char *audio_be_get_id(AudioBackend *be)
 {
     if (be) {
-        assert(be->dev);
-        return be->dev->id;
+        return AUDIO_BACKEND_GET_CLASS(be)->get_id(be);
     } else {
         return "";
     }
@@ -2322,13 +2374,25 @@ static const TypeInfo audio_be_info = {
     .instance_size = sizeof(AudioBackend),
     .instance_init = audio_be_init,
     .instance_finalize = audio_be_finalize,
-    .abstract = false, /* TODO: subclass drivers and make it abstract */
+    .abstract = true,
     .class_size = sizeof(AudioBackendClass),
 };
 
+static const TypeInfo audio_driver_info = {
+    .name = TYPE_AUDIO_DRIVER,
+    .parent = TYPE_AUDIO_BACKEND,
+    .instance_size = sizeof(AudioDriver),
+    .instance_init = audio_driver_init,
+    .instance_finalize = audio_driver_finalize,
+    .abstract = false,
+    .class_size = sizeof(AudioDriverClass),
+    .class_init = audio_driver_class_init,
+};
+
 static void register_types(void)
 {
     type_register_static(&audio_be_info);
+    type_register_static(&audio_driver_info);
 }
 
 type_init(register_types);
diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index 1fe7c4ed64..71b2a6c2cf 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -464,7 +464,7 @@ listener_in_vanished_cb(GDBusConnection *connection,
 }
 
 static gboolean
-dbus_audio_register_listener(AudioBackend *s,
+dbus_audio_register_listener(AudioDriver *s,
                              GDBusMethodInvocation *invocation,
 #ifdef G_OS_UNIX
                              GUnixFDList *fd_list,
@@ -621,7 +621,7 @@ dbus_audio_register_listener(AudioBackend *s,
 }
 
 static gboolean
-dbus_audio_register_out_listener(AudioBackend *s,
+dbus_audio_register_out_listener(AudioDriver *s,
                                  GDBusMethodInvocation *invocation,
 #ifdef G_OS_UNIX
                                  GUnixFDList *fd_list,
@@ -637,7 +637,7 @@ dbus_audio_register_out_listener(AudioBackend *s,
 }
 
 static gboolean
-dbus_audio_register_in_listener(AudioBackend *s,
+dbus_audio_register_in_listener(AudioDriver *s,
                                 GDBusMethodInvocation *invocation,
 #ifdef G_OS_UNIX
                                 GUnixFDList *fd_list,
@@ -657,7 +657,7 @@ dbus_audio_set_server(AudioBackend *s,
                       bool p2p,
                       Error **errp)
 {
-    DBusAudio *da = s->drv_opaque;
+    DBusAudio *da = AUDIO_DRIVER(s)->drv_opaque;
 
     g_assert(da);
     g_assert(!da->server);
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index c6cad47a01..9576cdba51 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -107,13 +107,13 @@ static void oss_anal_close (int *fdp)
 
 static void oss_helper_poll_out (void *opaque)
 {
-    AudioBackend *s = opaque;
+    AudioDriver *s = opaque;
     audio_run(s, "oss_poll_out");
 }
 
 static void oss_helper_poll_in (void *opaque)
 {
-    AudioBackend *s = opaque;
+    AudioDriver *s = opaque;
     audio_run(s, "oss_poll_in");
 }
 
diff --git a/ui/dbus.c b/ui/dbus.c
index 45fb3c1aa3..b0caa9b154 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -220,7 +220,7 @@ dbus_display_complete(UserCreatable *uc, Error **errp)
     }
 
     AudioBackend *audio_be = audio_get_default_audio_be(NULL);
-    if (audio_be && !g_str_equal(audio_be->drv->name, "dbus")) {
+    if (audio_be && !audio_be_can_set_dbus_server(audio_be)) {
         audio_be = NULL;
     }
     if (dd->audiodev && *dd->audiodev) {
@@ -233,7 +233,6 @@ dbus_display_complete(UserCreatable *uc, Error **errp)
         return;
     }
 
-
     consoles = g_array_new(FALSE, FALSE, sizeof(guint32));
     for (idx = 0;; idx++) {
         if (!qemu_console_lookup_by_index(idx)) {
-- 
2.51.1


