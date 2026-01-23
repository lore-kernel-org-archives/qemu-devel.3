Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3234FD72343
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 07:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjBxj-0004UL-OG; Fri, 23 Jan 2026 02:52:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vjBxM-0003wF-2O
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 02:51:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vjBxJ-0002B3-HK
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 02:51:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769154703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0p5kRZ5ii9vo84k0TwCIHefeYS6A+v9X6dWjhK7jTHQ=;
 b=STVWgmw1yxDF4oXQmRwg+I0SKP/c22KRHdrwBTJiFB8GVbzKTEquIRRx/4CEpQfsoMQwcK
 2OFwLaZTmxHv3lJ+qFkB7o7NL7x3evfIeWqWmOki4huJPYm7vpR2RQhh0Tr3yJoFhyi488
 hWWvI6yCqxAN87fTsckKpfbVRviEaGQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-nhBy6m7uNTWqA517phP7MA-1; Fri,
 23 Jan 2026 02:51:41 -0500
X-MC-Unique: nhBy6m7uNTWqA517phP7MA-1
X-Mimecast-MFC-AGG-ID: nhBy6m7uNTWqA517phP7MA_1769154700
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB0A71955D80; Fri, 23 Jan 2026 07:51:40 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 97F9A1800993; Fri, 23 Jan 2026 07:51:38 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: [PATCH 18/37] audio: introduce AudioMixengBackend
Date: Fri, 23 Jan 2026 11:49:21 +0400
Message-ID: <20260123074945.2563196-19-marcandre.lureau@redhat.com>
In-Reply-To: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Introduce a sub-class for current "audio_driver" based implementations.
Future AudioBackend implementations can do without it.

Next cleanup will actually remove "audio_driver" struct altogether and
make the subclass proper QOM objects.

Public APIs still rely on backend being an AudioMixeng. They will
assert() if not. This will be addressed later to allow other backends.

Note that the initial naming proposed for this object was AudioDriver,
however the semantics for "driver" is already overloaded and leads to
confusion, in particular with the QAPI AudiodevDriver. The defining
characteristic is of using QEMU's software mixing engine, so
AudioMixengBackend.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_int.h        |  25 +++++---
 audio/audio_template.h   |  18 +++---
 include/qemu/audio.h     |  17 +++++-
 audio/alsaaudio.c        |   2 +-
 audio/audio.c            | 124 +++++++++++++++++++++++++++++----------
 audio/dbusaudio.c        |   8 +--
 audio/ossaudio.c         |   4 +-
 tests/audio/test-audio.c |   4 +-
 ui/dbus.c                |   6 +-
 9 files changed, 144 insertions(+), 64 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index a6276375887..06f5160e8df 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -61,7 +61,7 @@ struct audio_pcm_info {
     int swap_endianness;
 };
 
-typedef struct AudioBackend AudioBackend;
+typedef struct AudioMixengBackend AudioMixengBackend;
 typedef struct SWVoiceCap SWVoiceCap;
 
 typedef struct STSampleBuffer {
@@ -70,7 +70,7 @@ typedef struct STSampleBuffer {
 } STSampleBuffer;
 
 typedef struct HWVoiceOut {
-    AudioBackend *s;
+    AudioMixengBackend *s;
     bool enabled;
     int poll_mode;
     bool pending_disable;
@@ -90,7 +90,7 @@ typedef struct HWVoiceOut {
 } HWVoiceOut;
 
 typedef struct HWVoiceIn {
-    AudioBackend *s;
+    AudioMixengBackend *s;
     bool enabled;
     int poll_mode;
     struct audio_pcm_info info;
@@ -110,7 +110,7 @@ typedef struct HWVoiceIn {
 } HWVoiceIn;
 
 struct SWVoiceOut {
-    AudioBackend *s;
+    AudioMixengBackend *s;
     struct audio_pcm_info info;
     t_sample *conv;
     STSampleBuffer resample_buf;
@@ -126,7 +126,7 @@ struct SWVoiceOut {
 };
 
 struct SWVoiceIn {
-    AudioBackend *s;
+    AudioMixengBackend *s;
     bool active;
     struct audio_pcm_info info;
     void *rate;
@@ -239,8 +239,12 @@ struct SWVoiceCap {
     QLIST_ENTRY (SWVoiceCap) entries;
 };
 
-typedef struct AudioBackend {
-    Object parent;
+struct AudioMixengBackendClass {
+    AudioBackendClass parent_class;
+};
+
+struct AudioMixengBackend {
+    AudioBackend parent_obj;
 
     struct audio_driver *drv;
     Audiodev *dev;
@@ -257,7 +261,7 @@ typedef struct AudioBackend {
     bool timer_running;
     uint64_t timer_last;
     VMChangeStateEntry *vmse;
-} AudioBackend;
+};
 
 extern const struct mixeng_volume nominal_volume;
 
@@ -270,7 +274,7 @@ void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len);
 
 int audio_bug (const char *funcname, int cond);
 
-void audio_run(AudioBackend *s, const char *msg);
+void audio_run(AudioMixengBackend *s, const char *msg);
 
 const char *audio_application_name(void);
 
@@ -323,4 +327,7 @@ void audio_create_pdos(Audiodev *dev);
 AudiodevPerDirectionOptions *audio_get_pdo_in(Audiodev *dev);
 AudiodevPerDirectionOptions *audio_get_pdo_out(Audiodev *dev);
 
+#define TYPE_AUDIO_MIXENG_BACKEND "audio-mixeng-backend"
+OBJECT_DECLARE_TYPE(AudioMixengBackend, AudioMixengBackendClass, AUDIO_MIXENG_BACKEND)
+
 #endif /* QEMU_AUDIO_INT_H */
diff --git a/audio/audio_template.h b/audio/audio_template.h
index e69e6e74570..a1f78d8748b 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -36,7 +36,7 @@
 #define HWBUF hw->conv_buf
 #endif
 
-static void glue(audio_init_nb_voices_, TYPE)(AudioBackend *s,
+static void glue(audio_init_nb_voices_, TYPE)(AudioMixengBackend *s,
                                               struct audio_driver *drv, int min_voices)
 {
     int max_voices = glue (drv->max_voices_, TYPE);
@@ -221,7 +221,7 @@ static void glue (audio_pcm_hw_del_sw_, TYPE) (SW *sw)
 static void glue (audio_pcm_hw_gc_, TYPE) (HW **hwp)
 {
     HW *hw = *hwp;
-    AudioBackend *s = hw->s;
+    AudioMixengBackend *s = hw->s;
 
     if (!hw->sw_head.lh_first) {
 #ifdef DAC
@@ -236,12 +236,12 @@ static void glue (audio_pcm_hw_gc_, TYPE) (HW **hwp)
     }
 }
 
-static HW *glue(audio_pcm_hw_find_any_, TYPE)(AudioBackend *s, HW *hw)
+static HW *glue(audio_pcm_hw_find_any_, TYPE)(AudioMixengBackend *s, HW *hw)
 {
     return hw ? hw->entries.le_next : glue (s->hw_head_, TYPE).lh_first;
 }
 
-static HW *glue(audio_pcm_hw_find_any_enabled_, TYPE)(AudioBackend *s, HW *hw)
+static HW *glue(audio_pcm_hw_find_any_enabled_, TYPE)(AudioMixengBackend *s, HW *hw)
 {
     while ((hw = glue(audio_pcm_hw_find_any_, TYPE)(s, hw))) {
         if (hw->enabled) {
@@ -251,7 +251,7 @@ static HW *glue(audio_pcm_hw_find_any_enabled_, TYPE)(AudioBackend *s, HW *hw)
     return NULL;
 }
 
-static HW *glue(audio_pcm_hw_find_specific_, TYPE)(AudioBackend *s, HW *hw,
+static HW *glue(audio_pcm_hw_find_specific_, TYPE)(AudioMixengBackend *s, HW *hw,
                                                    struct audsettings *as)
 {
     while ((hw = glue(audio_pcm_hw_find_any_, TYPE)(s, hw))) {
@@ -262,7 +262,7 @@ static HW *glue(audio_pcm_hw_find_specific_, TYPE)(AudioBackend *s, HW *hw,
     return NULL;
 }
 
-static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioBackend *s,
+static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioMixengBackend *s,
                                              struct audsettings *as)
 {
     HW *hw;
@@ -398,7 +398,7 @@ AudiodevPerDirectionOptions *glue(audio_get_pdo_, TYPE)(Audiodev *dev)
     abort();
 }
 
-static HW *glue(audio_pcm_hw_add_, TYPE)(AudioBackend *s, struct audsettings *as)
+static HW *glue(audio_pcm_hw_add_, TYPE)(AudioMixengBackend *s, struct audsettings *as)
 {
     HW *hw;
     AudiodevPerDirectionOptions *pdo = glue(audio_get_pdo_, TYPE)(s->dev);
@@ -424,7 +424,7 @@ static HW *glue(audio_pcm_hw_add_, TYPE)(AudioBackend *s, struct audsettings *as
 }
 
 static SW *glue(audio_pcm_create_voice_pair_, TYPE)(
-    AudioBackend *s,
+    AudioMixengBackend *s,
     const char *sw_name,
     const struct audsettings *as
     )
@@ -494,7 +494,7 @@ SW *glue (AUD_open_, TYPE) (
     const struct audsettings *as
     )
 {
-    AudioBackend *s = be;
+    AudioMixengBackend *s = AUDIO_MIXENG_BACKEND(be);
     AudiodevPerDirectionOptions *pdo;
 
     if (audio_bug(__func__, !be || !name || !callback_fn || !as)) {
diff --git a/include/qemu/audio.h b/include/qemu/audio.h
index 370e993f080..474d761f0be 100644
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
 
 bool AUD_backend_check(AudioBackend **be, Error **errp);
 
@@ -125,6 +135,7 @@ AudioBackend *audio_be_by_name(const char *name, Error **errp);
 AudioBackend *audio_get_default_audio_be(Error **errp);
 const char *audio_be_get_id(AudioBackend *be);
 #ifdef CONFIG_GIO
+bool audio_be_can_set_dbus_server(AudioBackend *be);
 bool audio_be_set_dbus_server(AudioBackend *be,
                               GDBusObjectManagerServer *server,
                               bool p2p,
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 7d7da576dc9..814820e2864 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -41,7 +41,7 @@ struct pollhlp {
     struct pollfd *pfds;
     int count;
     int mask;
-    AudioBackend *s;
+    AudioMixengBackend *s;
 };
 
 typedef struct ALSAVoiceOut {
diff --git a/audio/audio.c b/audio/audio.c
index 6eb921f0cca..1c83dd4ce6d 100644
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
+static CaptureVoiceOut *audio_pcm_capture_find_specific(AudioMixengBackend *s,
                                                         struct audsettings *as)
 {
     CaptureVoiceOut *cap;
@@ -463,7 +464,7 @@ static void audio_detach_capture (HWVoiceOut *hw)
 
 static int audio_attach_capture (HWVoiceOut *hw)
 {
-    AudioBackend *s = hw->s;
+    AudioMixengBackend *s = hw->s;
     CaptureVoiceOut *cap;
 
     audio_detach_capture (hw);
@@ -801,7 +802,7 @@ static void audio_pcm_print_info (const char *cap, struct audio_pcm_info *info)
 /*
  * Timer
  */
-static int audio_is_timer_needed(AudioBackend *s)
+static int audio_is_timer_needed(AudioMixengBackend *s)
 {
     HWVoiceIn *hwi = NULL;
     HWVoiceOut *hwo = NULL;
@@ -819,7 +820,7 @@ static int audio_is_timer_needed(AudioBackend *s)
     return 0;
 }
 
-static void audio_reset_timer(AudioBackend *s)
+static void audio_reset_timer(AudioMixengBackend *s)
 {
     if (audio_is_timer_needed(s)) {
         timer_mod_anticipate_ns(s->ts,
@@ -841,7 +842,7 @@ static void audio_reset_timer(AudioBackend *s)
 static void audio_timer (void *opaque)
 {
     int64_t now, diff;
-    AudioBackend *s = opaque;
+    AudioMixengBackend *s = opaque;
 
     now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     diff = now - s->timer_last;
@@ -924,7 +925,7 @@ void AUD_set_active_out(SWVoiceOut *sw, bool on)
 
     hw = sw->hw;
     if (sw->active != on) {
-        AudioBackend *s = sw->s;
+        AudioMixengBackend *s = sw->s;
         SWVoiceOut *temp_sw;
         SWVoiceCap *sc;
 
@@ -972,7 +973,7 @@ void AUD_set_active_in(SWVoiceIn *sw, bool on)
 
     hw = sw->hw;
     if (sw->active != on) {
-        AudioBackend *s = sw->s;
+        AudioMixengBackend *s = sw->s;
         SWVoiceIn *temp_sw;
 
         if (on) {
@@ -1140,7 +1141,7 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
     return clipped;
 }
 
-static void audio_run_out(AudioBackend *s)
+static void audio_run_out(AudioMixengBackend *s)
 {
     HWVoiceOut *hw = NULL;
     SWVoiceOut *sw;
@@ -1293,7 +1294,7 @@ static size_t audio_pcm_hw_run_in(HWVoiceIn *hw, size_t samples)
     return conv;
 }
 
-static void audio_run_in(AudioBackend *s)
+static void audio_run_in(AudioMixengBackend *s)
 {
     HWVoiceIn *hw = NULL;
 
@@ -1340,7 +1341,7 @@ static void audio_run_in(AudioBackend *s)
     }
 }
 
-static void audio_run_capture(AudioBackend *s)
+static void audio_run_capture(AudioMixengBackend *s)
 {
     CaptureVoiceOut *cap;
 
@@ -1387,7 +1388,7 @@ static void audio_run_capture(AudioBackend *s)
     }
 }
 
-void audio_run(AudioBackend *s, const char *msg)
+void audio_run(AudioMixengBackend *s, const char *msg)
 {
     audio_run_out(s);
     audio_run_in(s);
@@ -1560,8 +1561,8 @@ size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
     return total;
 }
 
-static bool audio_driver_init(AudioBackend *s, struct audio_driver *drv,
-                              Audiodev *dev, Error **errp)
+static bool audio_driver_do_init(AudioMixengBackend *s, struct audio_driver *drv,
+                                 Audiodev *dev, Error **errp)
 {
     s->drv_opaque = drv->init(dev, errp);
     if (!s->drv_opaque) {
@@ -1593,7 +1594,7 @@ static bool audio_driver_init(AudioBackend *s, struct audio_driver *drv,
 static void audio_vm_change_state_handler (void *opaque, bool running,
                                            RunState state)
 {
-    AudioBackend *s = opaque;
+    AudioMixengBackend *s = opaque;
     HWVoiceOut *hwo = NULL;
     HWVoiceIn *hwi = NULL;
 
@@ -1615,7 +1616,47 @@ static const VMStateDescription vmstate_audio;
 
 static void audio_be_init(Object *obj)
 {
-    AudioBackend *s = AUDIO_BACKEND(obj);
+}
+
+static void audio_be_finalize(Object *obj)
+{
+}
+
+static const char *audio_mixeng_backend_get_id(AudioBackend *be)
+{
+    return AUDIO_MIXENG_BACKEND(be)->dev->id;
+}
+
+#ifdef CONFIG_GIO
+static bool audio_mixeng_backend_set_dbus_server(AudioBackend *be,
+                                                 GDBusObjectManagerServer *manager,
+                                                 bool p2p,
+                                                 Error **errp)
+{
+    AudioMixengBackend *d = AUDIO_MIXENG_BACKEND(be);
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
+static void audio_mixeng_backend_class_init(ObjectClass *klass, const void *data)
+{
+    AudioBackendClass *be = AUDIO_BACKEND_CLASS(klass);
+
+    be->get_id = audio_mixeng_backend_get_id;
+#ifdef CONFIG_GIO
+    be->set_dbus_server = audio_mixeng_backend_set_dbus_server;
+#endif
+}
+
+static void audio_mixeng_backend_init(Object *obj)
+{
+    AudioMixengBackend *s = AUDIO_MIXENG_BACKEND(obj);
 
     QLIST_INIT(&s->hw_head_out);
     QLIST_INIT(&s->hw_head_in);
@@ -1628,9 +1669,9 @@ static void audio_be_init(Object *obj)
     vmstate_register_any(NULL, &vmstate_audio, s);
 }
 
-static void audio_be_finalize(Object *obj)
+static void audio_mixeng_backend_finalize(Object *obj)
 {
-    AudioBackend *s = AUDIO_BACKEND(obj);
+    AudioMixengBackend *s = AUDIO_MIXENG_BACKEND(obj);
     HWVoiceOut *hwo, *hwon;
     HWVoiceIn *hwi, *hwin;
 
@@ -1746,10 +1787,10 @@ static AudioBackend *audio_init(Audiodev *dev, Error **errp)
 {
     int done = 0;
     const char *drvname;
-    AudioBackend *s;
+    AudioMixengBackend *s;
     struct audio_driver *driver;
 
-    s = AUDIO_BACKEND(object_new(TYPE_AUDIO_BACKEND));
+    s = AUDIO_MIXENG_BACKEND(object_new(TYPE_AUDIO_MIXENG_BACKEND));
 
     if (dev) {
         /* -audiodev option */
@@ -1757,7 +1798,7 @@ static AudioBackend *audio_init(Audiodev *dev, Error **errp)
         drvname = AudiodevDriver_str(dev->driver);
         driver = audio_driver_lookup(drvname);
         if (driver) {
-            done = audio_driver_init(s, driver, dev, errp);
+            done = audio_driver_do_init(s, driver, dev, errp);
         } else {
             error_setg(errp, "Unknown audio driver `%s'", drvname);
         }
@@ -1777,7 +1818,7 @@ static AudioBackend *audio_init(Audiodev *dev, Error **errp)
             g_free(e);
             drvname = AudiodevDriver_str(dev->driver);
             driver = audio_driver_lookup(drvname);
-            if (audio_driver_init(s, driver, dev, NULL)) {
+            if (audio_driver_do_init(s, driver, dev, NULL)) {
                 break;
             }
             qapi_free_Audiodev(dev);
@@ -1789,7 +1830,7 @@ static AudioBackend *audio_init(Audiodev *dev, Error **errp)
         goto out;
     }
     object_unref(s);
-    return s;
+    return AUDIO_BACKEND(s);
 
 out:
     object_unref(s);
@@ -1828,12 +1869,13 @@ bool AUD_backend_check(AudioBackend **be, Error **errp)
 static struct audio_pcm_ops capture_pcm_ops;
 
 CaptureVoiceOut *AUD_add_capture(
-    AudioBackend *s,
+    AudioBackend *be,
     struct audsettings *as,
     struct audio_capture_ops *ops,
     void *cb_opaque
     )
 {
+    AudioMixengBackend *s = AUDIO_MIXENG_BACKEND(be);
     CaptureVoiceOut *cap;
     struct capture_callback *cb;
 
@@ -2224,27 +2266,37 @@ AudioBackend *audio_be_by_name(const char *name, Error **errp)
 }
 
 #ifdef CONFIG_GIO
+bool audio_be_can_set_dbus_server(AudioBackend *be)
+{
+    /*
+     * TODO:
+     * AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+     * return klass->set_dbus_server != NULL;
+     */
+    return AUDIO_MIXENG_BACKEND(be)->drv->set_dbus_server != NULL;
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
@@ -2319,13 +2371,25 @@ static const TypeInfo audio_be_info = {
     .instance_size = sizeof(AudioBackend),
     .instance_init = audio_be_init,
     .instance_finalize = audio_be_finalize,
-    .abstract = false, /* TODO: subclass drivers and make it abstract */
+    .abstract = true,
     .class_size = sizeof(AudioBackendClass),
 };
 
+static const TypeInfo audio_mixeng_backend_info = {
+    .name = TYPE_AUDIO_MIXENG_BACKEND,
+    .parent = TYPE_AUDIO_BACKEND,
+    .instance_size = sizeof(AudioMixengBackend),
+    .instance_init = audio_mixeng_backend_init,
+    .instance_finalize = audio_mixeng_backend_finalize,
+    .abstract = false,
+    .class_size = sizeof(AudioMixengBackendClass),
+    .class_init = audio_mixeng_backend_class_init,
+};
+
 static void register_types(void)
 {
     type_register_static(&audio_be_info);
+    type_register_static(&audio_mixeng_backend_info);
 }
 
 type_init(register_types);
diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index 1fe7c4ed647..96d4fa3f471 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -464,7 +464,7 @@ listener_in_vanished_cb(GDBusConnection *connection,
 }
 
 static gboolean
-dbus_audio_register_listener(AudioBackend *s,
+dbus_audio_register_listener(AudioMixengBackend *s,
                              GDBusMethodInvocation *invocation,
 #ifdef G_OS_UNIX
                              GUnixFDList *fd_list,
@@ -621,7 +621,7 @@ dbus_audio_register_listener(AudioBackend *s,
 }
 
 static gboolean
-dbus_audio_register_out_listener(AudioBackend *s,
+dbus_audio_register_out_listener(AudioMixengBackend *s,
                                  GDBusMethodInvocation *invocation,
 #ifdef G_OS_UNIX
                                  GUnixFDList *fd_list,
@@ -637,7 +637,7 @@ dbus_audio_register_out_listener(AudioBackend *s,
 }
 
 static gboolean
-dbus_audio_register_in_listener(AudioBackend *s,
+dbus_audio_register_in_listener(AudioMixengBackend *s,
                                 GDBusMethodInvocation *invocation,
 #ifdef G_OS_UNIX
                                 GUnixFDList *fd_list,
@@ -657,7 +657,7 @@ dbus_audio_set_server(AudioBackend *s,
                       bool p2p,
                       Error **errp)
 {
-    DBusAudio *da = s->drv_opaque;
+    DBusAudio *da = AUDIO_MIXENG_BACKEND(s)->drv_opaque;
 
     g_assert(da);
     g_assert(!da->server);
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index c6cad47a015..6ad20ab1876 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -107,13 +107,13 @@ static void oss_anal_close (int *fdp)
 
 static void oss_helper_poll_out (void *opaque)
 {
-    AudioBackend *s = opaque;
+    AudioMixengBackend *s = opaque;
     audio_run(s, "oss_poll_out");
 }
 
 static void oss_helper_poll_in (void *opaque)
 {
-    AudioBackend *s = opaque;
+    AudioMixengBackend *s = opaque;
     audio_run(s, "oss_poll_in");
 }
 
diff --git a/tests/audio/test-audio.c b/tests/audio/test-audio.c
index 38e30f47f89..e1e518df2a7 100644
--- a/tests/audio/test-audio.c
+++ b/tests/audio/test-audio.c
@@ -165,7 +165,7 @@ static void test_audio_out_sine_wave(void)
      */
     start_time = g_get_monotonic_time();
     while (state.frames_written < state.total_frames) {
-        audio_run(state.be, "test");
+        audio_run(AUDIO_MIXENG_BACKEND(state.be), "test");
         main_loop_wait(true);
 
         elapsed_ms = (g_get_monotonic_time() - start_time) / 1000;
@@ -419,7 +419,7 @@ static void test_audio_capture(void)
     start_time = g_get_monotonic_time();
     while (sine_state.frames_written < sine_state.total_frames ||
            state.captured_bytes < CAPTURE_BUFFER_SIZE) {
-        audio_run(be, "test-capture");
+        audio_run(AUDIO_MIXENG_BACKEND(be), "test-capture");
         main_loop_wait(true);
 
         elapsed_ms = (g_get_monotonic_time() - start_time) / 1000;
diff --git a/ui/dbus.c b/ui/dbus.c
index e44e2ff9877..0cac1ba8471 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -221,8 +221,7 @@ dbus_display_complete(UserCreatable *uc, Error **errp)
 
     {
         AudioBackend *audio_be = audio_get_default_audio_be(NULL);
-
-        if (audio_be && !g_str_equal(audio_be->drv->name, "dbus")) {
+        if (audio_be && !audio_be_can_set_dbus_server(audio_be)) {
             audio_be = NULL;
         }
         if (dd->audiodev && *dd->audiodev) {
@@ -231,8 +230,7 @@ dbus_display_complete(UserCreatable *uc, Error **errp)
                 return;
             }
         }
-        if (audio_be &&
-            !audio_be_set_dbus_server(audio_be, dd->server, dd->p2p, errp)) {
+        if (audio_be && !audio_be_set_dbus_server(audio_be, dd->server, dd->p2p, errp)) {
             return;
         }
     }
-- 
2.52.0


