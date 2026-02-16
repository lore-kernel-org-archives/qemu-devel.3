Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60712E7BDA1
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfO-0006Ze-90; Mon, 16 Feb 2026 06:21:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwcA-0006UA-RP
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:18:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwc8-0008BV-SN
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:18:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JxdTNnVEA5dLWdTaaPYS9EB7LtH7sy5sV7cgK+yuVqQ=;
 b=W2W/Y3vtlCdsK9xJu0mKnxCIInXIfgrnpPco15/eW7/XmQeXMyTzUMNWWT4syM/RyTUfNB
 KsZjp/zLrCZtoeG+5Z+6kWv9Ck4RNDZOT2HVMsrqQzHqdJAuW3SmGnrcrFZ8oG0mUvLcYk
 rphm96pzKabqL4htyMsMY2VUaEteig8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436--wvVxrslPou7Q_UZU69iHg-1; Mon,
 16 Feb 2026 06:18:00 -0500
X-MC-Unique: -wvVxrslPou7Q_UZU69iHg-1
X-Mimecast-MFC-AGG-ID: -wvVxrslPou7Q_UZU69iHg_1771240678
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CECF18004BB; Mon, 16 Feb 2026 11:17:58 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5A74E30001A5; Mon, 16 Feb 2026 11:17:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:39 +0100
Subject: [PATCH 50/85] audio/pw: convert to QOM lifecycle methods
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-50-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12053;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bH5+vNyDDwdZkNy3frawvDWH6mwupPcSpMoXcje0aDk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxQJ/hD0x7wGCiHDqWdVH3+569qWFB7r8MYE
 AFOV0C5zOiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UAAKCRDa6OEJdZac
 5dJ4D/0eBJ519OUSgb8YMQ6AUwynOBk6buTKswp2KglOQu3mliBl8Y/o8F2p6hRvLMWgWhTxrGx
 i6M8wAhBb91KQLmNlotztvgoRGQwoee38u4ROs6+5kYPB+e7zl2OElxDH5bNgR1132f8bmDHjzT
 61P3Dkrb7BsD121mEA4OSO4zitDuW7VRlbrcNnUcvU+6roRIB5aU9hYx/juk6gWI5SeEJbX5Zba
 RoxRRMLMy/DWRazbVuVnJnxYTXh6wM49pdvt+VaIJqW5krUm+YfQiGzOW/J7zJGtfvzCG2R47bp
 z9aGuz6aOSBkXRxRVLeAU1xj4I5kmKBsKWM7ZfROtj0670V5AY5BilxFPg36rlOFrFx0XqYxmrF
 7NWbABgXpAiMHI7rhI1A+b9M3xwYJ3b1MhEz2dsWf36OEiNkond1TYUbokkINqe2T2CpeS2FymV
 FU2D/WdjkMONAp/NKnxNPuIL68lyxu3mt9C2rRDJmLewrqftCftVFIPRkuz1RDo8LXAnpmm8fHG
 ZzMNIg9Y9b91aBogU3ML7CYPdl2YgOrNIfcx8FRi7AOQi5lValcnh0fSyA4kWHnMdUp6FlyGelU
 VJ2DgmurlxTTq1yyUgrIHPWrXUsY1VGIdjTg7BggemNZ3KSjj9zdPkAmwml6bV9BpVO3St4k6Tw
 O2HmGJy61t2JOZQ==
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Migrate the PipeWire audio backend from the legacy driver init/fini
callbacks to proper QOM realize and finalize methods.

The pwaudio struct fields are now embedded directly in the AudioPw
QOM object instead of being allocated separately as drv_opaque. This
allows accessing the backend state through proper QOM type casting
with AUDIO_PW() rather than casting drv_opaque pointers.

The PipeWire thread loop and context are now managed through the QOM
lifecycle, with initialization in realize and cleanup in finalize.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/pwaudio.c | 119 +++++++++++++++++++++++++++-----------------------------
 1 file changed, 58 insertions(+), 61 deletions(-)

diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index 3b524dfea5a..ca61a1b4ef5 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -31,36 +31,27 @@
 #define TYPE_AUDIO_PW "audio-pipewire"
 OBJECT_DECLARE_SIMPLE_TYPE(AudioPw, AUDIO_PW)
 
+static AudioBackendClass *audio_pw_parent_class;
+
 struct AudioPw {
     AudioMixengBackend parent_obj;
-};
 
-static struct audio_driver pw_audio_driver;
+    struct pw_thread_loop *thread_loop;
+    struct pw_context *context;
 
-static void audio_pw_class_init(ObjectClass *klass, const void *data)
-{
-    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
+    struct pw_core *core;
+    struct spa_hook core_listener;
+    int last_seq, pending_seq, error;
+};
 
-    k->driver = &pw_audio_driver;
-}
+static struct audio_driver pw_audio_driver;
 
 typedef struct pwvolume {
     uint32_t channels;
     float values[SPA_AUDIO_MAX_CHANNELS];
 } pwvolume;
 
-typedef struct pwaudio {
-    Audiodev *dev;
-    struct pw_thread_loop *thread_loop;
-    struct pw_context *context;
-
-    struct pw_core *core;
-    struct spa_hook core_listener;
-    int last_seq, pending_seq, error;
-} pwaudio;
-
 typedef struct PWVoice {
-    pwaudio *g;
     struct pw_stream *stream;
     struct spa_hook stream_listener;
     struct spa_audio_info_raw info;
@@ -236,9 +227,9 @@ static const struct pw_stream_events playback_stream_events = {
 static size_t
 qpw_read(HWVoiceIn *hw, void *data, size_t len)
 {
+    AudioPw *c = AUDIO_PW(hw->s);
     PWVoiceIn *pw = (PWVoiceIn *) hw;
     PWVoice *v = &pw->v;
-    pwaudio *c = v->g;
     const char *error = NULL;
     size_t l;
     int32_t avail;
@@ -273,9 +264,9 @@ done_unlock:
 
 static size_t qpw_buffer_get_free(HWVoiceOut *hw)
 {
+    AudioPw *c = AUDIO_PW(hw->s);
     PWVoiceOut *pw = (PWVoiceOut *)hw;
     PWVoice *v = &pw->v;
-    pwaudio *c = v->g;
     const char *error = NULL;
     int32_t filled, avail;
     uint32_t index;
@@ -298,9 +289,9 @@ done_unlock:
 static size_t
 qpw_write(HWVoiceOut *hw, void *data, size_t len)
 {
+    AudioPw *c = AUDIO_PW(hw->s);
     PWVoiceOut *pw = (PWVoiceOut *) hw;
     PWVoice *v = &pw->v;
-    pwaudio *c = v->g;
     const char *error = NULL;
     int32_t filled, avail;
     uint32_t index;
@@ -434,7 +425,7 @@ pw_to_audfmt(enum spa_audio_format fmt, int *endianness,
 }
 
 static int
-qpw_stream_new(pwaudio *c, PWVoice *v, const char *stream_name,
+qpw_stream_new(AudioPw *c, PWVoice *v, const char *stream_name,
                const char *name, enum spa_direction dir)
 {
     int res;
@@ -452,8 +443,8 @@ qpw_stream_new(pwaudio *c, PWVoice *v, const char *stream_name,
     }
 
     /* 75% of the timer period for faster updates */
-    buf_samples = (uint64_t)v->g->dev->timer_period * v->info.rate
-                    * 3 / 4 / 1000000;
+    buf_samples = (uint64_t)AUDIO_MIXENG_BACKEND(c)->dev->timer_period
+        * v->info.rate * 3 / 4 / 1000000;
     pw_properties_setf(props, PW_KEY_NODE_LATENCY, "%" PRIu64 "/%u",
                        buf_samples, v->info.rate);
 
@@ -535,11 +526,11 @@ qpw_set_position(uint32_t channels, uint32_t position[SPA_AUDIO_MAX_CHANNELS])
 static int
 qpw_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
 {
+    AudioPw *c = AUDIO_PW(hw->s);
     PWVoiceOut *pw = (PWVoiceOut *) hw;
     PWVoice *v = &pw->v;
     struct audsettings obt_as = *as;
-    pwaudio *c = v->g = drv_opaque;
-    AudiodevPipewireOptions *popts = &c->dev->u.pipewire;
+    AudiodevPipewireOptions *popts = &AUDIO_MIXENG_BACKEND(c)->dev->u.pipewire;
     AudiodevPipewirePerDirectionOptions *ppdo = popts->out;
     int r;
 
@@ -554,11 +545,11 @@ qpw_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
         pw_to_audfmt(v->info.format, &obt_as.endianness, &v->frame_size);
     v->frame_size *= as->nchannels;
 
-    v->req = (uint64_t)c->dev->timer_period * v->info.rate
+    v->req = (uint64_t)AUDIO_MIXENG_BACKEND(c)->dev->timer_period * v->info.rate
         * 1 / 2 / 1000000 * v->frame_size;
 
     /* call the function that creates a new stream for playback */
-    r = qpw_stream_new(c, v, ppdo->stream_name ? : c->dev->id,
+    r = qpw_stream_new(c, v, ppdo->stream_name ?: AUDIO_MIXENG_BACKEND(c)->dev->id,
                        ppdo->name, SPA_DIRECTION_OUTPUT);
     if (r < 0) {
         pw_thread_loop_unlock(c->thread_loop);
@@ -582,11 +573,11 @@ qpw_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
 static int
 qpw_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
 {
+    AudioPw *c = AUDIO_PW(hw->s);
     PWVoiceIn *pw = (PWVoiceIn *) hw;
     PWVoice *v = &pw->v;
     struct audsettings obt_as = *as;
-    pwaudio *c = v->g = drv_opaque;
-    AudiodevPipewireOptions *popts = &c->dev->u.pipewire;
+    AudiodevPipewireOptions *popts = &AUDIO_MIXENG_BACKEND(c)->dev->u.pipewire;
     AudiodevPipewirePerDirectionOptions *ppdo = popts->in;
     int r;
 
@@ -602,7 +593,7 @@ qpw_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     v->frame_size *= as->nchannels;
 
     /* call the function that creates a new stream for recording */
-    r = qpw_stream_new(c, v, ppdo->stream_name ? : c->dev->id,
+    r = qpw_stream_new(c, v, ppdo->stream_name ? : AUDIO_MIXENG_BACKEND(c)->dev->id,
                        ppdo->name, SPA_DIRECTION_INPUT);
     if (r < 0) {
         pw_thread_loop_unlock(c->thread_loop);
@@ -621,10 +612,8 @@ qpw_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
 }
 
 static void
-qpw_voice_fini(PWVoice *v)
+qpw_voice_fini(AudioPw *c, PWVoice *v)
 {
-    pwaudio *c = v->g;
-
     if (!v->stream) {
         return;
     }
@@ -637,19 +626,18 @@ qpw_voice_fini(PWVoice *v)
 static void
 qpw_fini_out(HWVoiceOut *hw)
 {
-    qpw_voice_fini(&PW_VOICE_OUT(hw)->v);
+    qpw_voice_fini(AUDIO_PW(hw->s), &PW_VOICE_OUT(hw)->v);
 }
 
 static void
 qpw_fini_in(HWVoiceIn *hw)
 {
-    qpw_voice_fini(&PW_VOICE_IN(hw)->v);
+    qpw_voice_fini(AUDIO_PW(hw->s), &PW_VOICE_IN(hw)->v);
 }
 
 static void
-qpw_voice_set_enabled(PWVoice *v, bool enable)
+qpw_voice_set_enabled(AudioPw *c, PWVoice *v, bool enable)
 {
-    pwaudio *c = v->g;
     pw_thread_loop_lock(c->thread_loop);
     pw_stream_set_active(v->stream, enable);
     pw_thread_loop_unlock(c->thread_loop);
@@ -658,19 +646,18 @@ qpw_voice_set_enabled(PWVoice *v, bool enable)
 static void
 qpw_enable_out(HWVoiceOut *hw, bool enable)
 {
-    qpw_voice_set_enabled(&PW_VOICE_OUT(hw)->v, enable);
+    qpw_voice_set_enabled(AUDIO_PW(hw->s), &PW_VOICE_OUT(hw)->v, enable);
 }
 
 static void
 qpw_enable_in(HWVoiceIn *hw, bool enable)
 {
-    qpw_voice_set_enabled(&PW_VOICE_IN(hw)->v, enable);
+    qpw_voice_set_enabled(AUDIO_PW(hw->s), &PW_VOICE_IN(hw)->v, enable);
 }
 
 static void
-qpw_voice_set_volume(PWVoice *v, Volume *vol)
+qpw_voice_set_volume(AudioPw *c, PWVoice *v, Volume *vol)
 {
-    pwaudio *c = v->g;
     int i, ret;
 
     pw_thread_loop_lock(c->thread_loop);
@@ -693,16 +680,16 @@ qpw_voice_set_volume(PWVoice *v, Volume *vol)
 static void
 qpw_volume_out(HWVoiceOut *hw, Volume *vol)
 {
-    qpw_voice_set_volume(&PW_VOICE_OUT(hw)->v, vol);
+    qpw_voice_set_volume(AUDIO_PW(hw->s), &PW_VOICE_OUT(hw)->v, vol);
 }
 
 static void
 qpw_volume_in(HWVoiceIn *hw, Volume *vol)
 {
-    qpw_voice_set_volume(&PW_VOICE_IN(hw)->v, vol);
+    qpw_voice_set_volume(AUDIO_PW(hw->s), &PW_VOICE_IN(hw)->v, vol);
 }
 
-static int wait_resync(pwaudio *pw)
+static int wait_resync(AudioPw *pw)
 {
     int res;
     pw->pending_seq = pw_core_sync(pw->core, PW_ID_CORE, pw->pending_seq);
@@ -725,7 +712,7 @@ static int wait_resync(pwaudio *pw)
 static void
 on_core_error(void *data, uint32_t id, int seq, int res, const char *message)
 {
-    pwaudio *pw = data;
+    AudioPw *pw = data;
 
     error_report("error id:%u seq:%d res:%d (%s): %s",
                 id, seq, res, spa_strerror(res), message);
@@ -737,7 +724,7 @@ on_core_error(void *data, uint32_t id, int seq, int res, const char *message)
 static void
 on_core_done(void *data, uint32_t id, int seq)
 {
-    pwaudio *pw = data;
+    AudioPw *pw = data;
     assert(id == PW_ID_CORE);
     pw->last_seq = seq;
     if (pw->pending_seq == seq) {
@@ -752,17 +739,20 @@ static const struct pw_core_events core_events = {
     .error = on_core_error,
 };
 
-static void *
-qpw_audio_init(Audiodev *dev, Error **errp)
+static bool
+audio_pw_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
 {
-    g_autofree pwaudio *pw = g_new0(pwaudio, 1);
+    AudioPw *pw = AUDIO_PW(abe);
 
     assert(dev->driver == AUDIODEV_DRIVER_PIPEWIRE);
     trace_pw_audio_init();
 
+    if (!audio_pw_parent_class->realize(abe, dev, errp)) {
+        return false;
+    }
+
     pw_init(NULL, NULL);
 
-    pw->dev = dev;
     pw->thread_loop = pw_thread_loop_new("PipeWire thread loop", NULL);
     if (pw->thread_loop == NULL) {
         error_setg_errno(errp, errno, "Could not create PipeWire loop");
@@ -801,8 +791,7 @@ qpw_audio_init(Audiodev *dev, Error **errp)
     }
 
     pw_thread_loop_unlock(pw->thread_loop);
-
-    return g_steal_pointer(&pw);
+    return true;
 
 fail:
     if (pw->thread_loop) {
@@ -810,13 +799,13 @@ fail:
     }
     g_clear_pointer(&pw->context, pw_context_destroy);
     g_clear_pointer(&pw->thread_loop, pw_thread_loop_destroy);
-    return NULL;
+    return false;
 }
 
 static void
-qpw_audio_fini(void *opaque)
+audio_pw_finalize(Object *obj)
 {
-    pwaudio *pw = opaque;
+    AudioPw *pw = AUDIO_PW(obj);
 
     if (pw->thread_loop) {
         pw_thread_loop_stop(pw->thread_loop);
@@ -831,9 +820,7 @@ qpw_audio_fini(void *opaque)
     if (pw->context) {
         pw_context_destroy(pw->context);
     }
-    pw_thread_loop_destroy(pw->thread_loop);
-
-    g_free(pw);
+    g_clear_pointer(&pw->thread_loop, pw_thread_loop_destroy);
 }
 
 static struct audio_pcm_ops qpw_pcm_ops = {
@@ -855,8 +842,6 @@ static struct audio_pcm_ops qpw_pcm_ops = {
 
 static struct audio_driver pw_audio_driver = {
     .name = "pipewire",
-    .init = qpw_audio_init,
-    .fini = qpw_audio_fini,
     .pcm_ops = &qpw_pcm_ops,
     .max_voices_out = INT_MAX,
     .max_voices_in = INT_MAX,
@@ -864,12 +849,24 @@ static struct audio_driver pw_audio_driver = {
     .voice_size_in = sizeof(PWVoiceIn),
 };
 
+static void audio_pw_class_init(ObjectClass *klass, const void *data)
+{
+    AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
+    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
+
+    audio_pw_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
+
+    b->realize = audio_pw_realize;
+    k->driver = &pw_audio_driver;
+}
+
 static const TypeInfo audio_types[] = {
     {
         .name = TYPE_AUDIO_PW,
         .parent = TYPE_AUDIO_MIXENG_BACKEND,
         .instance_size = sizeof(AudioPw),
         .class_init = audio_pw_class_init,
+        .instance_finalize = audio_pw_finalize,
     },
 };
 

-- 
2.53.0


