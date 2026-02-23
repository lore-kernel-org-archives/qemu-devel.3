Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31383E98E13
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 09:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuSaO-0002Z9-Cx; Mon, 23 Feb 2026 04:50:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSZF-0000Ih-8n
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:49:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSZD-00074t-9c
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771840166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J4SucUVkl0WRnnZuCp5t+N6kiYAKNSlru5EZCcCUPGM=;
 b=YWEuoln2P/EvQwYPGKZwSMne9zYuBbzpy9FhoxV5Pq+njPcj1gVFzVvQKn7M/kkkxq+XL7
 cISC8EvYv0h/hn9iS6vHhOFhEnNyAz3uetV2y0FeAfYOjhWLFTEXirWNv5YE9kv3YtG8yk
 w7fSUNforrYv65BDXGTWhyt7574mg6Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-Q39U-WxJP4-f_A_XHsmpcA-1; Mon,
 23 Feb 2026 04:49:24 -0500
X-MC-Unique: Q39U-WxJP4-f_A_XHsmpcA-1
X-Mimecast-MFC-AGG-ID: Q39U-WxJP4-f_A_XHsmpcA_1771840163
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66A221956094; Mon, 23 Feb 2026 09:49:23 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B28511955D85; Mon, 23 Feb 2026 09:49:22 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v2 50/85] audio/pw: convert to QOM lifecycle methods
Date: Mon, 23 Feb 2026 10:46:08 +0100
Message-ID: <20260223094649.2005118-51-marcandre.lureau@redhat.com>
In-Reply-To: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
References: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
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

Migrate the PipeWire audio backend from the legacy driver init/fini
callbacks to proper QOM realize and finalize methods.

The pwaudio struct fields are now embedded directly in the AudioPw
QOM object instead of being allocated separately as drv_opaque. This
allows accessing the backend state through proper QOM type casting
with AUDIO_PW() rather than casting drv_opaque pointers.

The PipeWire thread loop and context are now managed through the QOM
lifecycle, with initialization in realize and cleanup in finalize.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/pwaudio.c | 119 +++++++++++++++++++++++-------------------------
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


