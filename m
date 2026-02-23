Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7D5EA4FC3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 13:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuWMP-00083t-M4; Mon, 23 Feb 2026 08:52:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWKA-00041i-DS
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:50:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWK8-0007SE-Cc
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771854607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Clmca6brEgEy0EO9JVnBRHVqAcmHfxH1ZAQ7KK97pq4=;
 b=e4b6KuQODN8jJ5rzjzoi5k62vPwRnG7KqULkPEt71BMUvhqpM7TrubW1+HEOQpm3UI1655
 maf/Wig7JPXrQ3piTXI0r8h2JkrJiExnCHn/EgjGNySioeTIK1TAfw6XTtlD9c9xPXyncB
 N4KqGH68wPHbnLwsXk/9mQu3HhEjmMI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-I9rVkf2YPEu7UquJMy4Lxw-1; Mon,
 23 Feb 2026 08:50:03 -0500
X-MC-Unique: I9rVkf2YPEu7UquJMy4Lxw-1
X-Mimecast-MFC-AGG-ID: I9rVkf2YPEu7UquJMy4Lxw_1771854603
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E00A81955DC3; Mon, 23 Feb 2026 13:50:02 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE87C1955D85; Mon, 23 Feb 2026 13:50:01 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v3 54/85] audio/dsound: convert to QOM lifecycle methods
Date: Mon, 23 Feb 2026 14:46:55 +0100
Message-ID: <20260223134731.2377432-55-marcandre.lureau@redhat.com>
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

Migrate the DirectSound audio backend from the legacy driver init/fini
callbacks to proper QOM realize and finalize methods.

The dsound struct fields are now embedded directly in the AudioDsound
QOM object instead of being allocated separately as drv_opaque. This
allows accessing the backend state through proper QOM type casting
with AUDIO_DSOUND() rather than casting drv_opaque pointers.

The DirectSound and DirectSoundCapture COM objects are now managed
through the QOM lifecycle, with initialization in realize and cleanup
in finalize.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/dsound_template.h |  9 ++---
 audio/dsoundaudio.c     | 87 +++++++++++++++++++----------------------
 2 files changed, 45 insertions(+), 51 deletions(-)

diff --git a/audio/dsound_template.h b/audio/dsound_template.h
index 0678f2de38b..7979773eb86 100644
--- a/audio/dsound_template.h
+++ b/audio/dsound_template.h
@@ -72,7 +72,7 @@ static int glue (dsound_lock_, TYPE) (
     DWORD *blen1p,
     DWORD *blen2p,
     int entire,
-    dsound *s
+    AudioDsound *s
     )
 {
     HRESULT hr;
@@ -166,7 +166,7 @@ static int dsound_init_out(HWVoiceOut *hw, struct audsettings *as,
 {
     int err;
     HRESULT hr;
-    dsound *s = drv_opaque;
+    AudioDsound *s = AUDIO_DSOUND(hw->s);
     WAVEFORMATEX wfx;
     struct audsettings obt_as;
 #ifdef DSBTYPE_IN
@@ -174,13 +174,13 @@ static int dsound_init_out(HWVoiceOut *hw, struct audsettings *as,
     DSoundVoiceIn *ds = (DSoundVoiceIn *) hw;
     DSCBUFFERDESC bd;
     DSCBCAPS bc;
-    AudiodevPerDirectionOptions *pdo = s->dev->u.dsound.in;
+    AudiodevPerDirectionOptions *pdo = hw->s->dev->u.dsound.in;
 #else
     const char *typ = "DAC";
     DSoundVoiceOut *ds = (DSoundVoiceOut *) hw;
     DSBUFFERDESC bd;
     DSBCAPS bc;
-    AudiodevPerDirectionOptions *pdo = s->dev->u.dsound.out;
+    AudiodevPerDirectionOptions *pdo = hw->s->dev->u.dsound.out;
 #endif
 
     if (!s->FIELD2) {
@@ -256,7 +256,6 @@ static int dsound_init_out(HWVoiceOut *hw, struct audsettings *as,
     }
     hw->size_emul = bc.dwBufferBytes;
     hw->samples = bc.dwBufferBytes / hw->info.bytes_per_frame;
-    ds->s = s;
 
 #ifdef DEBUG_DSOUND
     dolog ("caps %ld, desc %ld\n",
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 462d09e02af..a90c348230b 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -45,40 +45,30 @@
 #define TYPE_AUDIO_DSOUND "audio-dsound"
 OBJECT_DECLARE_SIMPLE_TYPE(AudioDsound, AUDIO_DSOUND)
 
+static AudioBackendClass *audio_dsound_parent_class;
+
 struct AudioDsound {
     AudioMixengBackend parent_obj;
+
+    LPDIRECTSOUND dsound;
+    LPDIRECTSOUNDCAPTURE dsound_capture;
+    struct audsettings settings;
 };
 
 static struct audio_driver dsound_audio_driver;
 
-static void audio_dsound_class_init(ObjectClass *klass, const void *data)
-{
-    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
-
-    k->driver = &dsound_audio_driver;
-}
-
 /* #define DEBUG_DSOUND */
 
-typedef struct {
-    LPDIRECTSOUND dsound;
-    LPDIRECTSOUNDCAPTURE dsound_capture;
-    struct audsettings settings;
-    Audiodev *dev;
-} dsound;
-
 typedef struct {
     HWVoiceOut hw;
     LPDIRECTSOUNDBUFFER dsound_buffer;
     bool first_time;
-    dsound *s;
 } DSoundVoiceOut;
 
 typedef struct {
     HWVoiceIn hw;
     LPDIRECTSOUNDCAPTUREBUFFER dsound_capture_buffer;
     bool first_time;
-    dsound *s;
 } DSoundVoiceIn;
 
 static const char *dserror(HRESULT hr)
@@ -276,7 +266,7 @@ static void print_wave_format (WAVEFORMATEX *wfx)
 }
 #endif
 
-static int dsound_restore_out (LPDIRECTSOUNDBUFFER dsb, dsound *s)
+static int dsound_restore_out (LPDIRECTSOUNDBUFFER dsb, AudioDsound *s)
 {
     HRESULT hr;
 
@@ -295,7 +285,7 @@ static int dsound_restore_out (LPDIRECTSOUNDBUFFER dsb, dsound *s)
 #undef DSBTYPE_IN
 
 static int dsound_get_status_out (LPDIRECTSOUNDBUFFER dsb, DWORD *statusp,
-                                  dsound *s)
+                                  AudioDsound *s)
 {
     HRESULT hr;
 
@@ -328,7 +318,7 @@ static int dsound_get_status_in (LPDIRECTSOUNDCAPTUREBUFFER dscb,
 }
 
 static void dsound_clear_sample (HWVoiceOut *hw, LPDIRECTSOUNDBUFFER dsb,
-                                 dsound *s)
+                                 AudioDsound *s)
 {
     int err;
     LPVOID p1, p2;
@@ -372,9 +362,9 @@ static void dsound_enable_out(HWVoiceOut *hw, bool enable)
 {
     HRESULT hr;
     DWORD status;
+    AudioDsound *s = AUDIO_DSOUND(hw->s);
     DSoundVoiceOut *ds = (DSoundVoiceOut *) hw;
     LPDIRECTSOUNDBUFFER dsb = ds->dsound_buffer;
-    dsound *s = ds->s;
 
     if (!dsb) {
         dolog ("Attempt to control voice without a buffer\n");
@@ -450,7 +440,7 @@ static void *dsound_get_buffer_out(HWVoiceOut *hw, size_t *size)
     assert(req_size > 0);
 
     err = dsound_lock_out(dsb, &hw->info, hw->pos_emul, req_size, &ret, NULL,
-                          &act_size, NULL, false, ds->s);
+                          &act_size, NULL, false, AUDIO_DSOUND(hw->s));
     if (err) {
         dolog("Failed to lock buffer\n");
         *size = 0;
@@ -553,7 +543,7 @@ static void *dsound_get_buffer_in(HWVoiceIn *hw, size_t *size)
     }
 
     err = dsound_lock_in(dscb, &hw->info, hw->pos_emul, req_size, &ret, NULL,
-                         &act_size, NULL, false, ds->s);
+                         &act_size, NULL, false, AUDIO_DSOUND(hw->s));
     if (err) {
         dolog("Failed to lock buffer\n");
         *size = 0;
@@ -577,13 +567,12 @@ static void dsound_put_buffer_in(HWVoiceIn *hw, void *buf, size_t len)
     hw->pos_emul = (hw->pos_emul + len) % hw->size_emul;
 }
 
-static void dsound_audio_fini (void *opaque)
+static void audio_dsound_finalize(Object *obj)
 {
+    AudioDsound *s = AUDIO_DSOUND(obj);
     HRESULT hr;
-    dsound *s = opaque;
 
     if (!s->dsound) {
-        g_free(s);
         return;
     }
 
@@ -594,7 +583,6 @@ static void dsound_audio_fini (void *opaque)
     s->dsound = NULL;
 
     if (!s->dsound_capture) {
-        g_free(s);
         return;
     }
 
@@ -603,18 +591,21 @@ static void dsound_audio_fini (void *opaque)
         dsound_logerr (hr, "Could not release DirectSoundCapture\n");
     }
     s->dsound_capture = NULL;
-
-    g_free(s);
 }
 
-static void *dsound_audio_init(Audiodev *dev, Error **errp)
+static bool
+audio_dsound_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
 {
+    AudioDsound *s = AUDIO_DSOUND(abe);
     HRESULT hr;
-    dsound *s = g_new0(dsound, 1);
     AudiodevDsoundOptions *dso;
 
     assert(dev->driver == AUDIODEV_DRIVER_DSOUND);
-    s->dev = dev;
+
+    if (!audio_dsound_parent_class->realize(abe, dev, errp)) {
+        return false;
+    }
+
     dso = &dev->u.dsound;
 
     if (!dso->has_latency) {
@@ -625,8 +616,7 @@ static void *dsound_audio_init(Audiodev *dev, Error **errp)
     hr = CoInitialize (NULL);
     if (FAILED (hr)) {
         dserror_set(errp, hr, "Could not initialize COM");
-        dsound_audio_fini(s);
-        return NULL;
+        return false;
     }
 
     hr = CoCreateInstance (
@@ -638,15 +628,13 @@ static void *dsound_audio_init(Audiodev *dev, Error **errp)
         );
     if (FAILED (hr)) {
         dserror_set(errp, hr, "Could not create DirectSound instance");
-        dsound_audio_fini(s);
-        return NULL;
+        return false;
     }
 
     hr = IDirectSound_Initialize (s->dsound, NULL);
     if (FAILED (hr)) {
         dserror_set(errp, hr, "Could not initialize DirectSound");
-        dsound_audio_fini(s);
-        return NULL;
+        return false;
     }
 
     hr = CoCreateInstance (
@@ -658,15 +646,13 @@ static void *dsound_audio_init(Audiodev *dev, Error **errp)
         );
     if (FAILED (hr)) {
         dserror_set(errp, hr, "Could not create DirectSoundCapture instance");
-        dsound_audio_fini(s);
-        return NULL;
+        return false;
     }
 
     hr = IDirectSoundCapture_Initialize (s->dsound_capture, NULL);
     if (FAILED(hr)) {
         dserror_set(errp, hr, "Could not initialize DirectSoundCapture");
-        dsound_audio_fini(s);
-        return NULL;
+        return false;
     }
 
     hr = IDirectSound_SetCooperativeLevel (
@@ -676,11 +662,10 @@ static void *dsound_audio_init(Audiodev *dev, Error **errp)
     );
     if (FAILED(hr)) {
         dserror_set(errp, hr, "Could not set cooperative level");
-        dsound_audio_fini(s);
-        return NULL;
+        return false;
     }
 
-    return s;
+    return true;
 }
 
 static struct audio_pcm_ops dsound_pcm_ops = {
@@ -702,8 +687,6 @@ static struct audio_pcm_ops dsound_pcm_ops = {
 
 static struct audio_driver dsound_audio_driver = {
     .name           = "dsound",
-    .init           = dsound_audio_init,
-    .fini           = dsound_audio_fini,
     .pcm_ops        = &dsound_pcm_ops,
     .max_voices_out = INT_MAX,
     .max_voices_in  = 1,
@@ -711,12 +694,24 @@ static struct audio_driver dsound_audio_driver = {
     .voice_size_in  = sizeof (DSoundVoiceIn)
 };
 
+static void audio_dsound_class_init(ObjectClass *klass, const void *data)
+{
+    AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
+    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
+
+    audio_dsound_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
+
+    b->realize = audio_dsound_realize;
+    k->driver = &dsound_audio_driver;
+}
+
 static const TypeInfo audio_types[] = {
     {
         .name = TYPE_AUDIO_DSOUND,
         .parent = TYPE_AUDIO_MIXENG_BACKEND,
         .instance_size = sizeof(AudioDsound),
         .class_init = audio_dsound_class_init,
+        .instance_finalize = audio_dsound_finalize,
     },
 };
 
-- 
2.53.0


