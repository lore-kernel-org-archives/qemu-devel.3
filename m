Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891AEEA4FBB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 13:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuWK4-0003NN-Ot; Mon, 23 Feb 2026 08:50:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWIh-0000f6-5E
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:48:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWIb-00073M-4o
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771854511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6E7LBXbuAd2mWDdhOQp5nZ1S4M2r4p8d4uqj9EQhV+0=;
 b=ctXF7160eL+PuY+kBtE5KKEwFwpfcToceXJzFb2x+I6Uk6eOXVXB7pfK5ktr6cVEE/Z/KC
 iuAUTUkToSV1rClrcNnU6wr/A5wvvSdCh2XupD9xmiGEVceHQ4x4d/xnYqqGAlhleuiX6y
 W7Dj7NEiu6CKUpwsGtt/lGrL+C67r3I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-55RuV58wPQ2d6ue56OxyPw-1; Mon,
 23 Feb 2026 08:48:28 -0500
X-MC-Unique: 55RuV58wPQ2d6ue56OxyPw-1
X-Mimecast-MFC-AGG-ID: 55RuV58wPQ2d6ue56OxyPw_1771854507
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04993195609D; Mon, 23 Feb 2026 13:48:27 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6E4371955D85; Mon, 23 Feb 2026 13:48:26 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: [PULL v3 20/85] audio: introduce AudioMixengBackend
Date: Mon, 23 Feb 2026 14:46:21 +0100
Message-ID: <20260223134731.2377432-21-marcandre.lureau@redhat.com>
In-Reply-To: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
References: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_int.h        |  25 +++++---
 audio/audio_template.h   |  18 +++---
 include/qemu/audio.h     |  17 +++++-
 audio/alsaaudio.c        |   2 +-
 audio/audio.c            | 123 +++++++++++++++++++++++++++++----------
 audio/dbusaudio.c        |   8 +--
 audio/ossaudio.c         |   4 +-
 tests/audio/test-audio.c |   4 +-
 ui/dbus.c                |   6 +-
 9 files changed, 143 insertions(+), 64 deletions(-)

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
index 5dccb9b0a36..75a7f694319 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -37,6 +37,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/help_option.h"
+#include "qom/object.h"
 #include "system/system.h"
 #include "system/replay.h"
 #include "system/runstate.h"
@@ -384,7 +385,7 @@ void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len)
 /*
  * Capture
  */
-static CaptureVoiceOut *audio_pcm_capture_find_specific(AudioBackend *s,
+static CaptureVoiceOut *audio_pcm_capture_find_specific(AudioMixengBackend *s,
                                                         struct audsettings *as)
 {
     CaptureVoiceOut *cap;
@@ -464,7 +465,7 @@ static void audio_detach_capture (HWVoiceOut *hw)
 
 static int audio_attach_capture (HWVoiceOut *hw)
 {
-    AudioBackend *s = hw->s;
+    AudioMixengBackend *s = hw->s;
     CaptureVoiceOut *cap;
 
     audio_detach_capture (hw);
@@ -802,7 +803,7 @@ static void audio_pcm_print_info (const char *cap, struct audio_pcm_info *info)
 /*
  * Timer
  */
-static int audio_is_timer_needed(AudioBackend *s)
+static int audio_is_timer_needed(AudioMixengBackend *s)
 {
     HWVoiceIn *hwi = NULL;
     HWVoiceOut *hwo = NULL;
@@ -820,7 +821,7 @@ static int audio_is_timer_needed(AudioBackend *s)
     return 0;
 }
 
-static void audio_reset_timer(AudioBackend *s)
+static void audio_reset_timer(AudioMixengBackend *s)
 {
     if (audio_is_timer_needed(s)) {
         timer_mod_anticipate_ns(s->ts,
@@ -842,7 +843,7 @@ static void audio_reset_timer(AudioBackend *s)
 static void audio_timer (void *opaque)
 {
     int64_t now, diff;
-    AudioBackend *s = opaque;
+    AudioMixengBackend *s = opaque;
 
     now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     diff = now - s->timer_last;
@@ -925,7 +926,7 @@ void AUD_set_active_out(SWVoiceOut *sw, bool on)
 
     hw = sw->hw;
     if (sw->active != on) {
-        AudioBackend *s = sw->s;
+        AudioMixengBackend *s = sw->s;
         SWVoiceOut *temp_sw;
         SWVoiceCap *sc;
 
@@ -973,7 +974,7 @@ void AUD_set_active_in(SWVoiceIn *sw, bool on)
 
     hw = sw->hw;
     if (sw->active != on) {
-        AudioBackend *s = sw->s;
+        AudioMixengBackend *s = sw->s;
         SWVoiceIn *temp_sw;
 
         if (on) {
@@ -1141,7 +1142,7 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
     return clipped;
 }
 
-static void audio_run_out(AudioBackend *s)
+static void audio_run_out(AudioMixengBackend *s)
 {
     HWVoiceOut *hw = NULL;
     SWVoiceOut *sw;
@@ -1294,7 +1295,7 @@ static size_t audio_pcm_hw_run_in(HWVoiceIn *hw, size_t samples)
     return conv;
 }
 
-static void audio_run_in(AudioBackend *s)
+static void audio_run_in(AudioMixengBackend *s)
 {
     HWVoiceIn *hw = NULL;
 
@@ -1341,7 +1342,7 @@ static void audio_run_in(AudioBackend *s)
     }
 }
 
-static void audio_run_capture(AudioBackend *s)
+static void audio_run_capture(AudioMixengBackend *s)
 {
     CaptureVoiceOut *cap;
 
@@ -1388,7 +1389,7 @@ static void audio_run_capture(AudioBackend *s)
     }
 }
 
-void audio_run(AudioBackend *s, const char *msg)
+void audio_run(AudioMixengBackend *s, const char *msg)
 {
     audio_run_out(s);
     audio_run_in(s);
@@ -1561,8 +1562,8 @@ size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
     return total;
 }
 
-static bool audio_driver_init(AudioBackend *s, struct audio_driver *drv,
-                              Audiodev *dev, Error **errp)
+static bool audio_driver_do_init(AudioMixengBackend *s, struct audio_driver *drv,
+                                 Audiodev *dev, Error **errp)
 {
     s->drv_opaque = drv->init(dev, errp);
     if (!s->drv_opaque) {
@@ -1594,7 +1595,7 @@ static bool audio_driver_init(AudioBackend *s, struct audio_driver *drv,
 static void audio_vm_change_state_handler (void *opaque, bool running,
                                            RunState state)
 {
-    AudioBackend *s = opaque;
+    AudioMixengBackend *s = opaque;
     HWVoiceOut *hwo = NULL;
     HWVoiceIn *hwi = NULL;
 
@@ -1616,7 +1617,47 @@ static const VMStateDescription vmstate_audio;
 
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
@@ -1629,9 +1670,9 @@ static void audio_be_init(Object *obj)
     vmstate_register_any(NULL, &vmstate_audio, s);
 }
 
-static void audio_be_finalize(Object *obj)
+static void audio_mixeng_backend_finalize(Object *obj)
 {
-    AudioBackend *s = AUDIO_BACKEND(obj);
+    AudioMixengBackend *s = AUDIO_MIXENG_BACKEND(obj);
     HWVoiceOut *hwo, *hwon;
     HWVoiceIn *hwi, *hwin;
 
@@ -1747,10 +1788,10 @@ static AudioBackend *audio_init(Audiodev *dev, Error **errp)
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
@@ -1758,7 +1799,7 @@ static AudioBackend *audio_init(Audiodev *dev, Error **errp)
         drvname = AudiodevDriver_str(dev->driver);
         driver = audio_driver_lookup(drvname);
         if (driver) {
-            done = audio_driver_init(s, driver, dev, errp);
+            done = audio_driver_do_init(s, driver, dev, errp);
         } else {
             error_setg(errp, "Unknown audio driver `%s'", drvname);
         }
@@ -1778,7 +1819,7 @@ static AudioBackend *audio_init(Audiodev *dev, Error **errp)
             g_free(e);
             drvname = AudiodevDriver_str(dev->driver);
             driver = audio_driver_lookup(drvname);
-            if (audio_driver_init(s, driver, dev, NULL)) {
+            if (audio_driver_do_init(s, driver, dev, NULL)) {
                 break;
             }
             qapi_free_Audiodev(dev);
@@ -1790,7 +1831,7 @@ static AudioBackend *audio_init(Audiodev *dev, Error **errp)
         goto out;
     }
     object_unref(s);
-    return s;
+    return AUDIO_BACKEND(s);
 
 out:
     object_unref(s);
@@ -1829,12 +1870,13 @@ bool AUD_backend_check(AudioBackend **be, Error **errp)
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
 
@@ -2225,27 +2267,37 @@ AudioBackend *audio_be_by_name(const char *name, Error **errp)
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
@@ -2320,13 +2372,24 @@ static const TypeInfo audio_be_info = {
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
index edb4971972c..66693f0fbfd 100644
--- a/tests/audio/test-audio.c
+++ b/tests/audio/test-audio.c
@@ -170,7 +170,7 @@ static void test_audio_out_sine_wave(void)
      */
     start_time = g_get_monotonic_time();
     while (state.frames_written < state.total_frames) {
-        audio_run(state.be, "test");
+        audio_run(AUDIO_MIXENG_BACKEND(state.be), "test");
         main_loop_wait(true);
 
         elapsed_ms = (g_get_monotonic_time() - start_time) / 1000;
@@ -432,7 +432,7 @@ static void test_audio_capture(void)
     start_time = g_get_monotonic_time();
     while (sine_state.frames_written < sine_state.total_frames ||
            state.captured_bytes < CAPTURE_BUFFER_SIZE) {
-        audio_run(be, "test-capture");
+        audio_run(AUDIO_MIXENG_BACKEND(be), "test-capture");
         main_loop_wait(true);
 
         elapsed_ms = (g_get_monotonic_time() - start_time) / 1000;
diff --git a/ui/dbus.c b/ui/dbus.c
index 0be1931d208..905ee6fea71 100644
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
2.53.0


