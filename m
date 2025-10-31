Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCBF9CCF9EB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 06:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEixD-00026i-9y; Fri, 31 Oct 2025 02:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vEixA-00022k-U9
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 02:49:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vEix6-00043J-G2
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 02:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761893370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tVfcrKntbees8E8JS94mROvCUbutFz5W+MwtI4yRgHI=;
 b=H4UFO9cnehJyeSWVEUJIakpkirHfJoGyyCNnTus+IvLeIaAKZ/vivVPDHFR1DJky0SK2Ak
 XJne4CgIyyAudWW2Zq4KgR/M8Gkl9nFMNU9NHqbssZWwSibyvea7Btn1/5vKYJX+SGtQkW
 N4IjMtrlWzt5QqfIDqPVgZDcGPiMP3c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-drn4l-TiNuK7uSiPVRccUQ-1; Fri,
 31 Oct 2025 02:49:26 -0400
X-MC-Unique: drn4l-TiNuK7uSiPVRccUQ-1
X-Mimecast-MFC-AGG-ID: drn4l-TiNuK7uSiPVRccUQ_1761893365
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09B02195DB9A; Fri, 31 Oct 2025 06:49:25 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3124F30001A1; Fri, 31 Oct 2025 06:49:22 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 26/36] audio: rename AudioState -> AudioBackend
Date: Fri, 31 Oct 2025 10:46:19 +0400
Message-ID: <20251031064631.134651-27-marcandre.lureau@redhat.com>
In-Reply-To: <20251031064631.134651-1-marcandre.lureau@redhat.com>
References: <20251031064631.134651-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Naming is hard. But in general in QEMU, a host "backend" is the term
used to fullfill the request made by the device or frontend.

AudioBackend will become an abstract base class in a follow-up series.

Currently the frontend is QEMUSoundCard, we are going to drop that next.

Note that "audiodev" is the corresponding QAPI type name (or configuration).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 audio/audio.h                    | 16 +++---
 audio/audio_int.h                | 20 +++----
 audio/audio_template.h           | 20 +++----
 ui/vnc.h                         |  2 +-
 audio/alsaaudio.c                |  2 +-
 audio/audio-hmp-cmds.c           |  2 +-
 audio/audio.c                    | 90 ++++++++++++++++----------------
 audio/dbusaudio.c                |  8 +--
 audio/ossaudio.c                 |  4 +-
 audio/wavcapture.c               |  2 +-
 hw/audio/pcspk.c                 |  2 +-
 hw/core/machine.c                |  2 +-
 hw/core/qdev-properties-system.c |  6 +--
 ui/dbus.c                        |  8 +--
 ui/vnc.c                         | 10 ++--
 15 files changed, 97 insertions(+), 97 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index c0cad7d976..1d56f111ea 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -64,14 +64,14 @@ typedef struct SWVoiceOut SWVoiceOut;
 typedef struct CaptureVoiceOut CaptureVoiceOut;
 typedef struct SWVoiceIn SWVoiceIn;
 
-struct AudioStateClass {
+struct AudioBackendClass {
     ObjectClass parent_class;
 };
 
-typedef struct AudioState AudioState;
+typedef struct AudioBackend AudioBackend;
 typedef struct QEMUSoundCard {
     char *name;
-    AudioState *state;
+    AudioBackend *be;
     QLIST_ENTRY (QEMUSoundCard) entries;
 } QEMUSoundCard;
 
@@ -82,7 +82,7 @@ typedef struct QEMUAudioTimeStamp {
 bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp);
 void AUD_remove_card (QEMUSoundCard *card);
 CaptureVoiceOut *AUD_add_capture(
-    AudioState *s,
+    AudioBackend *s,
     struct audsettings *as,
     struct audio_capture_ops *ops,
     void *opaque
@@ -164,14 +164,14 @@ void audio_create_default_audiodevs(void);
 void audio_init_audiodevs(void);
 void audio_help(void);
 
-AudioState *audio_state_by_name(const char *name, Error **errp);
-AudioState *audio_get_default_audio_state(Error **errp);
+AudioBackend *audio_be_by_name(const char *name, Error **errp);
+AudioBackend *audio_get_default_audio_be(Error **errp);
 const char *audio_get_id(QEMUSoundCard *card);
 
 #define DEFINE_AUDIO_PROPERTIES(_s, _f)         \
     DEFINE_PROP_AUDIODEV("audiodev", _s, _f)
 
-#define TYPE_AUDIO_STATE "audio-state"
-OBJECT_DECLARE_TYPE(AudioState, AudioStateClass, AUDIO_STATE)
+#define TYPE_AUDIO_BACKEND "audio-backend"
+OBJECT_DECLARE_TYPE(AudioBackend, AudioBackendClass, AUDIO_BACKEND)
 
 #endif /* QEMU_AUDIO_H */
diff --git a/audio/audio_int.h b/audio/audio_int.h
index d1badbf235..338af38fd1 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -60,7 +60,7 @@ struct audio_pcm_info {
     int swap_endianness;
 };
 
-typedef struct AudioState AudioState;
+typedef struct AudioBackend AudioBackend;
 typedef struct SWVoiceCap SWVoiceCap;
 
 typedef struct STSampleBuffer {
@@ -69,7 +69,7 @@ typedef struct STSampleBuffer {
 } STSampleBuffer;
 
 typedef struct HWVoiceOut {
-    AudioState *s;
+    AudioBackend *s;
     int enabled;
     int poll_mode;
     int pending_disable;
@@ -90,7 +90,7 @@ typedef struct HWVoiceOut {
 } HWVoiceOut;
 
 typedef struct HWVoiceIn {
-    AudioState *s;
+    AudioBackend *s;
     int enabled;
     int poll_mode;
     struct audio_pcm_info info;
@@ -112,7 +112,7 @@ typedef struct HWVoiceIn {
 
 struct SWVoiceOut {
     QEMUSoundCard *card;
-    AudioState *s;
+    AudioBackend *s;
     struct audio_pcm_info info;
     t_sample *conv;
     STSampleBuffer resample_buf;
@@ -129,7 +129,7 @@ struct SWVoiceOut {
 
 struct SWVoiceIn {
     QEMUSoundCard *card;
-    AudioState *s;
+    AudioBackend *s;
     int active;
     struct audio_pcm_info info;
     void *rate;
@@ -150,7 +150,7 @@ struct audio_driver {
     void *(*init) (Audiodev *, Error **);
     void (*fini) (void *);
 #ifdef CONFIG_GIO
-    void (*set_dbus_server) (AudioState *s, GDBusObjectManagerServer *manager, bool p2p);
+    void (*set_dbus_server)(AudioBackend *s, GDBusObjectManagerServer *manager, bool p2p);
 #endif
     struct audio_pcm_ops *pcm_ops;
     int max_voices_out;
@@ -208,7 +208,7 @@ static inline void *advance(void *p, size_t incr)
     return (uint8_t *)p + incr;
 }
 
-int wav_start_capture(AudioState *state, CaptureState *s, const char *path,
+int wav_start_capture(AudioBackend *state, CaptureState *s, const char *path,
                       int freq, int bits, int nchannels);
 
 void audio_generic_run_buffer_in(HWVoiceIn *hw);
@@ -240,7 +240,7 @@ struct SWVoiceCap {
     QLIST_ENTRY (SWVoiceCap) entries;
 };
 
-typedef struct AudioState {
+typedef struct AudioBackend {
     Object parent;
 
     struct audio_driver *drv;
@@ -260,7 +260,7 @@ typedef struct AudioState {
     bool timer_running;
     uint64_t timer_last;
     VMChangeStateEntry *vmse;
-} AudioState;
+} AudioBackend;
 
 extern const struct mixeng_volume nominal_volume;
 
@@ -273,7 +273,7 @@ void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len);
 
 int audio_bug (const char *funcname, int cond);
 
-void audio_run(AudioState *s, const char *msg);
+void audio_run(AudioBackend *s, const char *msg);
 
 const char *audio_application_name(void);
 
diff --git a/audio/audio_template.h b/audio/audio_template.h
index c29d79c443..b3c10a0709 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -36,7 +36,7 @@
 #define HWBUF hw->conv_buf
 #endif
 
-static void glue(audio_init_nb_voices_, TYPE)(AudioState *s,
+static void glue(audio_init_nb_voices_, TYPE)(AudioBackend *s,
                                               struct audio_driver *drv, int min_voices)
 {
     int max_voices = glue (drv->max_voices_, TYPE);
@@ -221,7 +221,7 @@ static void glue (audio_pcm_hw_del_sw_, TYPE) (SW *sw)
 static void glue (audio_pcm_hw_gc_, TYPE) (HW **hwp)
 {
     HW *hw = *hwp;
-    AudioState *s = hw->s;
+    AudioBackend *s = hw->s;
 
     if (!hw->sw_head.lh_first) {
 #ifdef DAC
@@ -236,12 +236,12 @@ static void glue (audio_pcm_hw_gc_, TYPE) (HW **hwp)
     }
 }
 
-static HW *glue(audio_pcm_hw_find_any_, TYPE)(AudioState *s, HW *hw)
+static HW *glue(audio_pcm_hw_find_any_, TYPE)(AudioBackend *s, HW *hw)
 {
     return hw ? hw->entries.le_next : glue (s->hw_head_, TYPE).lh_first;
 }
 
-static HW *glue(audio_pcm_hw_find_any_enabled_, TYPE)(AudioState *s, HW *hw)
+static HW *glue(audio_pcm_hw_find_any_enabled_, TYPE)(AudioBackend *s, HW *hw)
 {
     while ((hw = glue(audio_pcm_hw_find_any_, TYPE)(s, hw))) {
         if (hw->enabled) {
@@ -251,7 +251,7 @@ static HW *glue(audio_pcm_hw_find_any_enabled_, TYPE)(AudioState *s, HW *hw)
     return NULL;
 }
 
-static HW *glue(audio_pcm_hw_find_specific_, TYPE)(AudioState *s, HW *hw,
+static HW *glue(audio_pcm_hw_find_specific_, TYPE)(AudioBackend *s, HW *hw,
                                                    struct audsettings *as)
 {
     while ((hw = glue(audio_pcm_hw_find_any_, TYPE)(s, hw))) {
@@ -262,7 +262,7 @@ static HW *glue(audio_pcm_hw_find_specific_, TYPE)(AudioState *s, HW *hw,
     return NULL;
 }
 
-static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioState *s,
+static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioBackend *s,
                                              struct audsettings *as)
 {
     HW *hw;
@@ -398,7 +398,7 @@ AudiodevPerDirectionOptions *glue(audio_get_pdo_, TYPE)(Audiodev *dev)
     abort();
 }
 
-static HW *glue(audio_pcm_hw_add_, TYPE)(AudioState *s, struct audsettings *as)
+static HW *glue(audio_pcm_hw_add_, TYPE)(AudioBackend *s, struct audsettings *as)
 {
     HW *hw;
     AudiodevPerDirectionOptions *pdo = glue(audio_get_pdo_, TYPE)(s->dev);
@@ -424,7 +424,7 @@ static HW *glue(audio_pcm_hw_add_, TYPE)(AudioState *s, struct audsettings *as)
 }
 
 static SW *glue(audio_pcm_create_voice_pair_, TYPE)(
-    AudioState *s,
+    AudioBackend *s,
     const char *sw_name,
     struct audsettings *as
     )
@@ -494,7 +494,7 @@ SW *glue (AUD_open_, TYPE) (
     struct audsettings *as
     )
 {
-    AudioState *s;
+    AudioBackend *s;
     AudiodevPerDirectionOptions *pdo;
 
     if (audio_bug(__func__, !card || !name || !callback_fn || !as)) {
@@ -503,7 +503,7 @@ SW *glue (AUD_open_, TYPE) (
         goto fail;
     }
 
-    s = card->state;
+    s = card->be;
     pdo = glue(audio_get_pdo_, TYPE)(s->dev);
 
     ldebug ("open %s, freq %d, nchannels %d, fmt %d\n",
diff --git a/ui/vnc.h b/ui/vnc.h
index f2dab2f4d9..e2137c5ed1 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -184,7 +184,7 @@ struct VncDisplay
     VncDisplaySASL sasl;
 #endif
 
-    AudioState *audio_state;
+    AudioBackend *audio_be;
 
     VMChangeStateEntry *vmstate_handler_entry;
 };
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 9b6c01c0ef..797cb478e6 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -41,7 +41,7 @@ struct pollhlp {
     struct pollfd *pfds;
     int count;
     int mask;
-    AudioState *s;
+    AudioBackend *s;
 };
 
 typedef struct ALSAVoiceOut {
diff --git a/audio/audio-hmp-cmds.c b/audio/audio-hmp-cmds.c
index 819f8fa9d8..1e56af21ab 100644
--- a/audio/audio-hmp-cmds.c
+++ b/audio/audio-hmp-cmds.c
@@ -67,7 +67,7 @@ void hmp_wavcapture(Monitor *mon, const QDict *qdict)
     const char *audiodev = qdict_get_str(qdict, "audiodev");
     CaptureState *s;
     Error *local_err = NULL;
-    AudioState *as = audio_state_by_name(audiodev, &local_err);
+    AudioBackend *as = audio_be_by_name(audiodev, &local_err);
 
     if (!as) {
         error_report_err(local_err);
diff --git a/audio/audio.c b/audio/audio.c
index 8723f4e66e..8044d55c5c 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -99,7 +99,7 @@ static audio_driver *audio_driver_lookup(const char *name)
     return NULL;
 }
 
-static AudioState *default_audio_state;
+static AudioBackend *default_audio_be;
 
 const struct mixeng_volume nominal_volume = {
     .mute = 0,
@@ -380,7 +380,7 @@ void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len)
 /*
  * Capture
  */
-static CaptureVoiceOut *audio_pcm_capture_find_specific(AudioState *s,
+static CaptureVoiceOut *audio_pcm_capture_find_specific(AudioBackend *s,
                                                         struct audsettings *as)
 {
     CaptureVoiceOut *cap;
@@ -460,7 +460,7 @@ static void audio_detach_capture (HWVoiceOut *hw)
 
 static int audio_attach_capture (HWVoiceOut *hw)
 {
-    AudioState *s = hw->s;
+    AudioBackend *s = hw->s;
     CaptureVoiceOut *cap;
 
     audio_detach_capture (hw);
@@ -798,7 +798,7 @@ static void audio_pcm_print_info (const char *cap, struct audio_pcm_info *info)
 /*
  * Timer
  */
-static int audio_is_timer_needed(AudioState *s)
+static int audio_is_timer_needed(AudioBackend *s)
 {
     HWVoiceIn *hwi = NULL;
     HWVoiceOut *hwo = NULL;
@@ -816,7 +816,7 @@ static int audio_is_timer_needed(AudioState *s)
     return 0;
 }
 
-static void audio_reset_timer (AudioState *s)
+static void audio_reset_timer(AudioBackend *s)
 {
     if (audio_is_timer_needed(s)) {
         timer_mod_anticipate_ns(s->ts,
@@ -838,7 +838,7 @@ static void audio_reset_timer (AudioState *s)
 static void audio_timer (void *opaque)
 {
     int64_t now, diff;
-    AudioState *s = opaque;
+    AudioBackend *s = opaque;
 
     now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     diff = now - s->timer_last;
@@ -921,7 +921,7 @@ void AUD_set_active_out (SWVoiceOut *sw, int on)
 
     hw = sw->hw;
     if (sw->active != on) {
-        AudioState *s = sw->s;
+        AudioBackend *s = sw->s;
         SWVoiceOut *temp_sw;
         SWVoiceCap *sc;
 
@@ -969,7 +969,7 @@ void AUD_set_active_in (SWVoiceIn *sw, int on)
 
     hw = sw->hw;
     if (sw->active != on) {
-        AudioState *s = sw->s;
+        AudioBackend *s = sw->s;
         SWVoiceIn *temp_sw;
 
         if (on) {
@@ -1137,7 +1137,7 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
     return clipped;
 }
 
-static void audio_run_out (AudioState *s)
+static void audio_run_out(AudioBackend *s)
 {
     HWVoiceOut *hw = NULL;
     SWVoiceOut *sw;
@@ -1291,7 +1291,7 @@ static size_t audio_pcm_hw_run_in(HWVoiceIn *hw, size_t samples)
     return conv;
 }
 
-static void audio_run_in (AudioState *s)
+static void audio_run_in(AudioBackend *s)
 {
     HWVoiceIn *hw = NULL;
 
@@ -1339,7 +1339,7 @@ static void audio_run_in (AudioState *s)
     }
 }
 
-static void audio_run_capture (AudioState *s)
+static void audio_run_capture(AudioBackend *s)
 {
     CaptureVoiceOut *cap;
 
@@ -1386,7 +1386,7 @@ static void audio_run_capture (AudioState *s)
     }
 }
 
-void audio_run(AudioState *s, const char *msg)
+void audio_run(AudioBackend *s, const char *msg)
 {
     audio_run_out(s);
     audio_run_in(s);
@@ -1559,7 +1559,7 @@ size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
     return total;
 }
 
-static bool audio_driver_init(AudioState *s, struct audio_driver *drv,
+static bool audio_driver_init(AudioBackend *s, struct audio_driver *drv,
                               Audiodev *dev, Error **errp)
 {
     s->drv_opaque = drv->init(dev, errp);
@@ -1592,7 +1592,7 @@ static bool audio_driver_init(AudioState *s, struct audio_driver *drv,
 static void audio_vm_change_state_handler (void *opaque, bool running,
                                            RunState state)
 {
-    AudioState *s = opaque;
+    AudioBackend *s = opaque;
     HWVoiceOut *hwo = NULL;
     HWVoiceIn *hwi = NULL;
 
@@ -1613,9 +1613,9 @@ static void audio_vm_change_state_handler (void *opaque, bool running,
 
 static const VMStateDescription vmstate_audio;
 
-static void audio_state_init(Object *obj)
+static void audio_be_init(Object *obj)
 {
-    AudioState *s = AUDIO_STATE(obj);
+    AudioBackend *s = AUDIO_BACKEND(obj);
 
     QLIST_INIT(&s->hw_head_out);
     QLIST_INIT(&s->hw_head_in);
@@ -1629,9 +1629,9 @@ static void audio_state_init(Object *obj)
     vmstate_register_any(NULL, &vmstate_audio, s);
 }
 
-static void audio_state_finalize(Object *obj)
+static void audio_be_finalize(Object *obj)
 {
-    AudioState *s = AUDIO_STATE(obj);
+    AudioBackend *s = AUDIO_BACKEND(obj);
     HWVoiceOut *hwo, *hwon;
     HWVoiceIn *hwi, *hwin;
 
@@ -1692,7 +1692,7 @@ static Object *get_audiodevs_root(void)
 
 void audio_cleanup(void)
 {
-    default_audio_state = NULL;
+    default_audio_be = NULL;
 
     object_unparent(get_audiodevs_root());
 }
@@ -1743,14 +1743,14 @@ void audio_create_default_audiodevs(void)
  * if dev == NULL => legacy implicit initialization, return the already created
  *   state or create a new one
  */
-static AudioState *audio_init(Audiodev *dev, Error **errp)
+static AudioBackend *audio_init(Audiodev *dev, Error **errp)
 {
     int done = 0;
     const char *drvname;
-    AudioState *s;
+    AudioBackend *s;
     struct audio_driver *driver;
 
-    s = AUDIO_STATE(object_new(TYPE_AUDIO_STATE));
+    s = AUDIO_BACKEND(object_new(TYPE_AUDIO_BACKEND));
 
     if (dev) {
         /* -audiodev option */
@@ -1766,7 +1766,7 @@ static AudioState *audio_init(Audiodev *dev, Error **errp)
             goto out;
         }
     } else {
-        assert(!default_audio_state);
+        assert(!default_audio_be);
         for (;;) {
             AudiodevListEntry *e = QSIMPLEQ_FIRST(&default_audiodevs);
             if (!e) {
@@ -1797,11 +1797,11 @@ out:
     return NULL;
 }
 
-AudioState *audio_get_default_audio_state(Error **errp)
+AudioBackend *audio_get_default_audio_be(Error **errp)
 {
-    if (!default_audio_state) {
-        default_audio_state = audio_init(NULL, errp);
-        if (!default_audio_state) {
+    if (!default_audio_be) {
+        default_audio_be = audio_init(NULL, errp);
+        if (!default_audio_be) {
             if (!QSIMPLEQ_EMPTY(&audiodevs)) {
                 error_append_hint(errp, "Perhaps you wanted to use -audio or set audiodev=%s?\n",
                                   QSIMPLEQ_FIRST(&audiodevs)->dev->id);
@@ -1809,21 +1809,21 @@ AudioState *audio_get_default_audio_state(Error **errp)
         }
     }
 
-    return default_audio_state;
+    return default_audio_be;
 }
 
 bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp)
 {
-    if (!card->state) {
-        card->state = audio_get_default_audio_state(errp);
-        if (!card->state) {
+    if (!card->be) {
+        card->be = audio_get_default_audio_be(errp);
+        if (!card->be) {
             return false;
         }
     }
 
     card->name = g_strdup (name);
     memset (&card->entries, 0, sizeof (card->entries));
-    QLIST_INSERT_HEAD(&card->state->card_head, card, entries);
+    QLIST_INSERT_HEAD(&card->be->card_head, card, entries);
 
     return true;
 }
@@ -1837,7 +1837,7 @@ void AUD_remove_card (QEMUSoundCard *card)
 static struct audio_pcm_ops capture_pcm_ops;
 
 CaptureVoiceOut *AUD_add_capture(
-    AudioState *s,
+    AudioBackend *s,
     struct audsettings *as,
     struct audio_capture_ops *ops,
     void *cb_opaque
@@ -2220,7 +2220,7 @@ int audio_buffer_bytes(AudiodevPerDirectionOptions *pdo,
         audioformat_bytes_per_sample(as->fmt);
 }
 
-AudioState *audio_state_by_name(const char *name, Error **errp)
+AudioBackend *audio_be_by_name(const char *name, Error **errp)
 {
     Object *obj = object_resolve_path_component(get_audiodevs_root(), name);
 
@@ -2228,15 +2228,15 @@ AudioState *audio_state_by_name(const char *name, Error **errp)
         error_setg(errp, "audiodev '%s' not found", name);
         return NULL;
     } else {
-        return AUDIO_STATE(obj);
+        return AUDIO_BACKEND(obj);
     }
 }
 
 const char *audio_get_id(QEMUSoundCard *card)
 {
-    if (card->state) {
-        assert(card->state->dev);
-        return card->state->dev->id;
+    if (card->be) {
+        assert(card->be->dev);
+        return card->be->dev->id;
     } else {
         return "";
     }
@@ -2305,19 +2305,19 @@ AudiodevList *qmp_query_audiodevs(Error **errp)
     return ret;
 }
 
-static const TypeInfo audio_state_info = {
-    .name = TYPE_AUDIO_STATE,
+static const TypeInfo audio_be_info = {
+    .name = TYPE_AUDIO_BACKEND,
     .parent = TYPE_OBJECT,
-    .instance_size = sizeof(AudioState),
-    .instance_init = audio_state_init,
-    .instance_finalize = audio_state_finalize,
+    .instance_size = sizeof(AudioBackend),
+    .instance_init = audio_be_init,
+    .instance_finalize = audio_be_finalize,
     .abstract = false, /* TODO: subclass drivers and make it abstract */
-    .class_size = sizeof(AudioStateClass),
+    .class_size = sizeof(AudioBackendClass),
 };
 
 static void register_types(void)
 {
-    type_register_static(&audio_state_info);
+    type_register_static(&audio_be_info);
 }
 
 type_init(register_types);
diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index 908214a170..49cef38e3e 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -458,7 +458,7 @@ listener_in_vanished_cb(GDBusConnection *connection,
 }
 
 static gboolean
-dbus_audio_register_listener(AudioState *s,
+dbus_audio_register_listener(AudioBackend *s,
                              GDBusMethodInvocation *invocation,
 #ifdef G_OS_UNIX
                              GUnixFDList *fd_list,
@@ -615,7 +615,7 @@ dbus_audio_register_listener(AudioState *s,
 }
 
 static gboolean
-dbus_audio_register_out_listener(AudioState *s,
+dbus_audio_register_out_listener(AudioBackend *s,
                                  GDBusMethodInvocation *invocation,
 #ifdef G_OS_UNIX
                                  GUnixFDList *fd_list,
@@ -631,7 +631,7 @@ dbus_audio_register_out_listener(AudioState *s,
 }
 
 static gboolean
-dbus_audio_register_in_listener(AudioState *s,
+dbus_audio_register_in_listener(AudioBackend *s,
                                 GDBusMethodInvocation *invocation,
 #ifdef G_OS_UNIX
                                 GUnixFDList *fd_list,
@@ -646,7 +646,7 @@ dbus_audio_register_in_listener(AudioState *s,
 }
 
 static void
-dbus_audio_set_server(AudioState *s, GDBusObjectManagerServer *server, bool p2p)
+dbus_audio_set_server(AudioBackend *s, GDBusObjectManagerServer *server, bool p2p)
 {
     DBusAudio *da = s->drv_opaque;
 
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index c5858284a1..4a549b26a2 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -107,13 +107,13 @@ static void oss_anal_close (int *fdp)
 
 static void oss_helper_poll_out (void *opaque)
 {
-    AudioState *s = opaque;
+    AudioBackend *s = opaque;
     audio_run(s, "oss_poll_out");
 }
 
 static void oss_helper_poll_in (void *opaque)
 {
-    AudioState *s = opaque;
+    AudioBackend *s = opaque;
     audio_run(s, "oss_poll_in");
 }
 
diff --git a/audio/wavcapture.c b/audio/wavcapture.c
index 0fbc695d23..b33a38ff45 100644
--- a/audio/wavcapture.c
+++ b/audio/wavcapture.c
@@ -103,7 +103,7 @@ static struct capture_ops wav_capture_ops = {
     .info = wav_capture_info
 };
 
-int wav_start_capture(AudioState *state, CaptureState *s, const char *path,
+int wav_start_capture(AudioBackend *state, CaptureState *s, const char *path,
                       int freq, int bits, int nchannels)
 {
     WAVState *wav;
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 48ef830292..e0b0949918 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -196,7 +196,7 @@ static void pcspk_realizefn(DeviceState *dev, Error **errp)
 
     isa_register_ioport(isadev, &s->ioport, s->iobase);
 
-    if (s->card.state && AUD_register_card(s_spk, &s->card, errp)) {
+    if (s->card.be && AUD_register_card(s_spk, &s->card, errp)) {
         pcspk_audio_init(s);
     }
 }
diff --git a/hw/core/machine.c b/hw/core/machine.c
index cd63803000..28d2833c5d 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -760,7 +760,7 @@ static void machine_set_audiodev(Object *obj, const char *value,
 {
     MachineState *ms = MACHINE(obj);
 
-    if (!audio_state_by_name(value, errp)) {
+    if (!audio_be_by_name(value, errp)) {
         return;
     }
 
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 13cc91680b..4d815684d1 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -499,16 +499,16 @@ static void set_audiodev(Object *obj, Visitor *v, const char* name,
 {
     const Property *prop = opaque;
     QEMUSoundCard *card = object_field_prop_ptr(obj, prop);
-    AudioState *state;
+    AudioBackend *state;
     g_autofree char *str = NULL;
 
     if (!visit_type_str(v, name, &str, errp)) {
         return;
     }
 
-    state = audio_state_by_name(str, errp);
+    state = audio_be_by_name(str, errp);
     if (state) {
-        card->state = state;
+        card->be = state;
     }
 }
 
diff --git a/ui/dbus.c b/ui/dbus.c
index dd0336702d..84cff47ec7 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -220,16 +220,16 @@ dbus_display_complete(UserCreatable *uc, Error **errp)
     }
 
     if (dd->audiodev && *dd->audiodev) {
-        AudioState *audio_state = audio_state_by_name(dd->audiodev, errp);
-        if (!audio_state) {
+        AudioBackend *audio_be = audio_be_by_name(dd->audiodev, errp);
+        if (!audio_be) {
             return;
         }
-        if (!g_str_equal(audio_state->drv->name, "dbus")) {
+        if (!g_str_equal(audio_be->drv->name, "dbus")) {
             error_setg(errp, "Audiodev '%s' is not compatible with DBus",
                        dd->audiodev);
             return;
         }
-        audio_state->drv->set_dbus_server(audio_state, dd->server, dd->p2p);
+        audio_be->drv->set_dbus_server(audio_be, dd->server, dd->p2p);
     }
 
     consoles = g_array_new(FALSE, FALSE, sizeof(guint32));
diff --git a/ui/vnc.c b/ui/vnc.c
index 77c823bf2e..0094ec680c 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1276,7 +1276,7 @@ static void audio_add(VncState *vs)
     ops.destroy = audio_capture_destroy;
     ops.capture = audio_capture;
 
-    vs->audio_cap = AUD_add_capture(vs->vd->audio_state, &vs->as, &ops, vs);
+    vs->audio_cap = AUD_add_capture(vs->vd->audio_be, &vs->as, &ops, vs);
     if (!vs->audio_cap) {
         error_report("Failed to add audio capture");
     }
@@ -2193,7 +2193,7 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
             send_ext_key_event_ack(vs);
             break;
         case VNC_ENCODING_AUDIO:
-            if (vs->vd->audio_state) {
+            if (vs->vd->audio_be) {
                 vnc_set_feature(vs, VNC_FEATURE_AUDIO);
                 send_ext_audio_ack(vs);
             }
@@ -4236,12 +4236,12 @@ void vnc_display_open(const char *id, Error **errp)
 
     audiodev = qemu_opt_get(opts, "audiodev");
     if (audiodev) {
-        vd->audio_state = audio_state_by_name(audiodev, errp);
-        if (!vd->audio_state) {
+        vd->audio_be = audio_be_by_name(audiodev, errp);
+        if (!vd->audio_be) {
             goto fail;
         }
     } else {
-        vd->audio_state = audio_get_default_audio_state(NULL);
+        vd->audio_be = audio_get_default_audio_be(NULL);
     }
 
     device_id = qemu_opt_get(opts, "display");
-- 
2.51.1


