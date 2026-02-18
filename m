Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB0CE9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsdW0-0000IL-30; Wed, 18 Feb 2026 04:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdVu-00009s-B4
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:06:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdVr-0002Mw-5J
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:06:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771405586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cz6AbaE7CL6KiT71myE0oBxOtXlm0BFJpijm8buyrXU=;
 b=Tk654wl+PvyQ4J6lUNI04kd1+Vrj0gf8H0DZMRjDrxbzc3xs/pbN6UUFW6hxXoq+DIRs0M
 1Skx+ArRaqwPlQG565Vnm3PI9GCe8Vq8qQUsc3a4jlC3D/F9LNEjxyrQV+7NL9Caq7n/8P
 6CpnffzfgXZdpTz41fxJvp0oz7ygVk0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-WN3C0sQkPt-IblpH4dxejQ-1; Wed,
 18 Feb 2026 04:06:25 -0500
X-MC-Unique: WN3C0sQkPt-IblpH4dxejQ-1
X-Mimecast-MFC-AGG-ID: WN3C0sQkPt-IblpH4dxejQ_1771405584
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8321E1956060; Wed, 18 Feb 2026 09:06:23 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8C0691800348; Wed, 18 Feb 2026 09:06:22 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>
Subject: [PULL 56/85] audio: remove audio_driver
Date: Wed, 18 Feb 2026 10:02:56 +0100
Message-ID: <20260218090330.1476169-57-marcandre.lureau@redhat.com>
In-Reply-To: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
References: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move all fields from audio_driver directly into AudioMixengBackendClass,
eliminating an unnecessary extra struct. Drivers now set class
fields directly in class_init instead of creating a static audio_driver
instance.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 audio/audio_int.h       | 18 +++++--------
 audio/audio_template.h  | 58 +++++++++++++++++++----------------------
 audio/alsaaudio.c       | 17 +++++-------
 audio/audio-mixeng-be.c | 20 +++++++-------
 audio/dbusaudio.c       | 17 +++++-------
 audio/dsoundaudio.c     | 17 +++++-------
 audio/jackaudio.c       | 17 +++++-------
 audio/noaudio.c         | 28 ++++++++------------
 audio/ossaudio.c        | 17 +++++-------
 audio/paaudio.c         | 17 +++++-------
 audio/pwaudio.c         | 17 +++++-------
 audio/sdlaudio.c        | 17 +++++-------
 audio/sndioaudio.c      | 27 ++++++++-----------
 audio/spiceaudio.c      | 36 +++++++++++--------------
 audio/wavaudio.c        | 28 ++++++++------------
 audio/coreaudio.m       | 28 ++++++++------------
 16 files changed, 149 insertions(+), 230 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index fb5a9dd871e..bd9c7a29e41 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -136,16 +136,6 @@ struct SWVoiceIn {
     QLIST_ENTRY (SWVoiceIn) entries;
 };
 
-typedef struct audio_driver audio_driver;
-struct audio_driver {
-    const char *name;
-    struct audio_pcm_ops *pcm_ops;
-    int max_voices_out;
-    int max_voices_in;
-    size_t voice_size_out;
-    size_t voice_size_in;
-};
-
 struct audio_pcm_ops {
     int    (*init_out)(HWVoiceOut *hw, audsettings *as);
     void   (*fini_out)(HWVoiceOut *hw);
@@ -229,13 +219,17 @@ struct SWVoiceCap {
 struct AudioMixengBackendClass {
     AudioBackendClass parent_class;
 
-    audio_driver *driver;
+    const char *name;
+    struct audio_pcm_ops *pcm_ops;
+    int max_voices_out;
+    int max_voices_in;
+    size_t voice_size_out;
+    size_t voice_size_in;
 };
 
 struct AudioMixengBackend {
     AudioBackend parent_obj;
 
-    struct audio_driver *drv;
     Audiodev *dev;
 
     QEMUTimer *ts;
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 6c2d2ad5dca..7187571c668 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -37,41 +37,42 @@
 #endif
 
 static void glue(audio_init_nb_voices_, TYPE)(AudioMixengBackend *s,
-                                              struct audio_driver *drv, int min_voices)
+                                              AudioMixengBackendClass *k,
+                                              int min_voices)
 {
-    int max_voices = glue (drv->max_voices_, TYPE);
-    size_t voice_size = glue(drv->voice_size_, TYPE);
+    int max_voices = glue(k->max_voices_, TYPE);
+    size_t voice_size = glue(k->voice_size_, TYPE);
 
-    glue (s->nb_hw_voices_, TYPE) = glue(audio_get_pdo_, TYPE)(s->dev)->voices;
-    if (glue (s->nb_hw_voices_, TYPE) > max_voices) {
+    glue(s->nb_hw_voices_, TYPE) = glue(audio_get_pdo_, TYPE)(s->dev)->voices;
+    if (glue(s->nb_hw_voices_, TYPE) > max_voices) {
         if (!max_voices) {
 #ifdef DAC
-            dolog ("Driver `%s' does not support " NAME "\n", drv->name);
+            dolog("Driver `%s' does not support " NAME "\n", k->name);
 #endif
         } else {
-            dolog ("Driver `%s' does not support %d " NAME " voices, max %d\n",
-                   drv->name,
-                   glue (s->nb_hw_voices_, TYPE),
+            dolog("Driver `%s' does not support %d " NAME " voices, max %d\n",
+                   k->name,
+                   glue(s->nb_hw_voices_, TYPE),
                    max_voices);
         }
-        glue (s->nb_hw_voices_, TYPE) = max_voices;
+        glue(s->nb_hw_voices_, TYPE) = max_voices;
     }
 
-    if (glue (s->nb_hw_voices_, TYPE) < min_voices) {
-        dolog ("Bogus number of " NAME " voices %d, setting to %d\n",
-               glue (s->nb_hw_voices_, TYPE),
+    if (glue(s->nb_hw_voices_, TYPE) < min_voices) {
+        dolog("Bogus number of " NAME " voices %d, setting to %d\n",
+               glue(s->nb_hw_voices_, TYPE),
                min_voices);
     }
 
     if (audio_bug(__func__, !voice_size && max_voices)) {
-        dolog ("drv=`%s' voice_size=0 max_voices=%d\n",
-               drv->name, max_voices);
-        glue (s->nb_hw_voices_, TYPE) = 0;
+        dolog("drv=`%s' voice_size=0 max_voices=%d\n",
+               k->name, max_voices);
+        glue(s->nb_hw_voices_, TYPE) = 0;
     }
 
     if (audio_bug(__func__, voice_size && !max_voices)) {
         dolog("drv=`%s' voice_size=%zu max_voices=0\n",
-              drv->name, voice_size);
+              k->name, voice_size);
     }
 }
 
@@ -267,29 +268,24 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioMixengBackend *s,
                                              struct audsettings *as)
 {
     HW *hw;
-    struct audio_driver *drv = s->drv;
+    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_GET_CLASS(s);
 
-    if (!glue (s->nb_hw_voices_, TYPE)) {
+    if (!glue(s->nb_hw_voices_, TYPE)) {
         return NULL;
     }
 
-    if (audio_bug(__func__, !drv)) {
-        dolog ("No host audio driver\n");
-        return NULL;
-    }
-
-    if (audio_bug(__func__, !drv->pcm_ops)) {
-        dolog ("Host audio driver without pcm_ops\n");
+    if (audio_bug(__func__, !k->pcm_ops)) {
+        dolog("No host audio driver or missing pcm_ops\n");
         return NULL;
     }
 
     /*
-     * Since glue(s->nb_hw_voices_, TYPE) is != 0, glue(drv->voice_size_, TYPE)
+     * Since glue(s->nb_hw_voices_, TYPE) is != 0, glue(k->voice_size_, TYPE)
      * is guaranteed to be != 0. See the audio_init_nb_voices_* functions.
      */
-    hw = g_malloc0(glue(drv->voice_size_, TYPE));
+    hw = g_malloc0(glue(k->voice_size_, TYPE));
     hw->s = AUDIO_MIXENG_BACKEND(object_ref(s));
-    hw->pcm_ops = drv->pcm_ops;
+    hw->pcm_ops = k->pcm_ops;
 
     QLIST_INIT (&hw->sw_head);
 #ifdef DAC
@@ -517,8 +513,8 @@ static SW *glue(audio_mixeng_backend_open_, TYPE) (
         goto fail;
     }
 
-    if (audio_bug(__func__, !s->drv)) {
-        dolog ("Can not open `%s' (no host audio driver)\n", name);
+    if (audio_bug(__func__, !AUDIO_MIXENG_BACKEND_GET_CLASS(s)->pcm_ops)) {
+        dolog("Can not open `%s' (no host audio driver)\n", name);
         goto fail;
     }
 
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 0c63d133496..d008ce7b627 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -46,7 +46,6 @@ struct AudioALSA {
     AudioMixengBackend parent_obj;
 };
 
-static struct audio_driver alsa_audio_driver;
 
 struct pollhlp {
     snd_pcm_t *handle;
@@ -938,15 +937,6 @@ static struct audio_pcm_ops alsa_pcm_ops = {
     .enable_in = alsa_enable_in,
 };
 
-static struct audio_driver alsa_audio_driver = {
-    .name           = "alsa",
-    .pcm_ops        = &alsa_pcm_ops,
-    .max_voices_out = INT_MAX,
-    .max_voices_in  = INT_MAX,
-    .voice_size_out = sizeof (ALSAVoiceOut),
-    .voice_size_in  = sizeof (ALSAVoiceIn)
-};
-
 static void audio_alsa_class_init(ObjectClass *klass, const void *data)
 {
     AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
@@ -955,7 +945,12 @@ static void audio_alsa_class_init(ObjectClass *klass, const void *data)
     audio_alsa_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
 
     b->realize = audio_alsa_realize;
-    k->driver = &alsa_audio_driver;
+    k->name = "alsa";
+    k->pcm_ops = &alsa_pcm_ops;
+    k->max_voices_out = INT_MAX;
+    k->max_voices_in = INT_MAX;
+    k->voice_size_out = sizeof(ALSAVoiceOut);
+    k->voice_size_in = sizeof(ALSAVoiceIn);
 }
 
 static const TypeInfo audio_types[] = {
diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
index ee593310180..3a0a537713e 100644
--- a/audio/audio-mixeng-be.c
+++ b/audio/audio-mixeng-be.c
@@ -1518,21 +1518,20 @@ static bool audio_mixeng_backend_realize(AudioBackend *abe,
                                          Audiodev *dev, Error **errp)
 {
     AudioMixengBackend *be = AUDIO_MIXENG_BACKEND(abe);
-    audio_driver *drv = AUDIO_MIXENG_BACKEND_GET_CLASS(be)->driver;
+    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_GET_CLASS(be);
 
     be->dev = dev;
-    if (!drv->pcm_ops->get_buffer_in) {
-        drv->pcm_ops->get_buffer_in = audio_generic_get_buffer_in;
-        drv->pcm_ops->put_buffer_in = audio_generic_put_buffer_in;
+    if (!k->pcm_ops->get_buffer_in) {
+        k->pcm_ops->get_buffer_in = audio_generic_get_buffer_in;
+        k->pcm_ops->put_buffer_in = audio_generic_put_buffer_in;
     }
-    if (!drv->pcm_ops->get_buffer_out) {
-        drv->pcm_ops->get_buffer_out = audio_generic_get_buffer_out;
-        drv->pcm_ops->put_buffer_out = audio_generic_put_buffer_out;
+    if (!k->pcm_ops->get_buffer_out) {
+        k->pcm_ops->get_buffer_out = audio_generic_get_buffer_out;
+        k->pcm_ops->put_buffer_out = audio_generic_put_buffer_out;
     }
 
-    audio_init_nb_voices_out(be, drv, 1);
-    audio_init_nb_voices_in(be, drv, 0);
-    be->drv = drv;
+    audio_init_nb_voices_out(be, k, 1);
+    audio_init_nb_voices_in(be, k, 0);
 
     if (be->dev->timer_period <= 0) {
         be->period_ticks = 1;
@@ -1658,7 +1657,6 @@ static void audio_mixeng_backend_finalize(Object *obj)
         QLIST_REMOVE(hwi, entries);
     }
 
-    s->drv = NULL;
     if (s->dev) {
         qapi_free_Audiodev(s->dev);
         s->dev = NULL;
diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index 9cc6e826b7e..82e76c41f9f 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -61,7 +61,6 @@ struct AudioDbus {
     GHashTable *in_listeners;
 };
 
-static struct audio_driver dbus_audio_driver;
 
 typedef struct DBusVoiceOut {
     HWVoiceOut hw;
@@ -709,15 +708,6 @@ static struct audio_pcm_ops dbus_pcm_ops = {
     .volume_in = dbus_volume_in,
 };
 
-static struct audio_driver dbus_audio_driver = {
-    .name            = "dbus",
-    .pcm_ops         = &dbus_pcm_ops,
-    .max_voices_out  = INT_MAX,
-    .max_voices_in   = INT_MAX,
-    .voice_size_out  = sizeof(DBusVoiceOut),
-    .voice_size_in   = sizeof(DBusVoiceIn)
-};
-
 static void audio_dbus_class_init(ObjectClass *klass, const void *data)
 {
     AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
@@ -727,7 +717,12 @@ static void audio_dbus_class_init(ObjectClass *klass, const void *data)
 
     b->realize = audio_dbus_realize;
     b->set_dbus_server = dbus_audio_set_server;
-    k->driver = &dbus_audio_driver;
+    k->name = "dbus";
+    k->pcm_ops = &dbus_pcm_ops;
+    k->max_voices_out = INT_MAX;
+    k->max_voices_in = INT_MAX;
+    k->voice_size_out = sizeof(DBusVoiceOut);
+    k->voice_size_in = sizeof(DBusVoiceIn);
 }
 
 static const TypeInfo audio_types[] = {
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index a90c348230b..e35b7fc233f 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -55,7 +55,6 @@ struct AudioDsound {
     struct audsettings settings;
 };
 
-static struct audio_driver dsound_audio_driver;
 
 /* #define DEBUG_DSOUND */
 
@@ -685,15 +684,6 @@ static struct audio_pcm_ops dsound_pcm_ops = {
     .enable_in = dsound_enable_in,
 };
 
-static struct audio_driver dsound_audio_driver = {
-    .name           = "dsound",
-    .pcm_ops        = &dsound_pcm_ops,
-    .max_voices_out = INT_MAX,
-    .max_voices_in  = 1,
-    .voice_size_out = sizeof (DSoundVoiceOut),
-    .voice_size_in  = sizeof (DSoundVoiceIn)
-};
-
 static void audio_dsound_class_init(ObjectClass *klass, const void *data)
 {
     AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
@@ -702,7 +692,12 @@ static void audio_dsound_class_init(ObjectClass *klass, const void *data)
     audio_dsound_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
 
     b->realize = audio_dsound_realize;
-    k->driver = &dsound_audio_driver;
+    k->name = "dsound";
+    k->pcm_ops = &dsound_pcm_ops;
+    k->max_voices_out = INT_MAX;
+    k->max_voices_in = 1;
+    k->voice_size_out = sizeof(DSoundVoiceOut);
+    k->voice_size_in = sizeof(DSoundVoiceIn);
 }
 
 static const TypeInfo audio_types[] = {
diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index d1bf80f8b68..7caa2ddf43f 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -42,7 +42,6 @@ struct AudioJack {
     AudioMixengBackend parent_obj;
 };
 
-static struct audio_driver jack_driver;
 
 struct QJack;
 
@@ -668,15 +667,6 @@ static struct audio_pcm_ops jack_pcm_ops = {
     .enable_in      = qjack_enable_in
 };
 
-static struct audio_driver jack_driver = {
-    .name           = "jack",
-    .pcm_ops        = &jack_pcm_ops,
-    .max_voices_out = INT_MAX,
-    .max_voices_in  = INT_MAX,
-    .voice_size_out = sizeof(QJackOut),
-    .voice_size_in  = sizeof(QJackIn)
-};
-
 static void qjack_error(const char *msg)
 {
     dolog("E: %s\n", msg);
@@ -691,7 +681,12 @@ static void audio_jack_class_init(ObjectClass *klass, const void *data)
 {
     AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
 
-    k->driver = &jack_driver;
+    k->name = "jack";
+    k->pcm_ops = &jack_pcm_ops;
+    k->max_voices_out = INT_MAX;
+    k->max_voices_in = INT_MAX;
+    k->voice_size_out = sizeof(QJackOut);
+    k->voice_size_in = sizeof(QJackIn);
 }
 
 static const TypeInfo audio_types[] = {
diff --git a/audio/noaudio.c b/audio/noaudio.c
index 6016f516d4a..be2e2e684ce 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -37,15 +37,6 @@ struct AudioNone {
     AudioMixengBackend parent_obj;
 };
 
-static struct audio_driver no_audio_driver;
-
-static void audio_none_class_init(ObjectClass *klass, const void *data)
-{
-    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
-
-    k->driver = &no_audio_driver;
-}
-
 typedef struct NoVoiceOut {
     HWVoiceOut hw;
     RateCtl rate;
@@ -134,14 +125,17 @@ static struct audio_pcm_ops no_pcm_ops = {
     .enable_in = no_enable_in
 };
 
-static struct audio_driver no_audio_driver = {
-    .name           = "none",
-    .pcm_ops        = &no_pcm_ops,
-    .max_voices_out = INT_MAX,
-    .max_voices_in  = INT_MAX,
-    .voice_size_out = sizeof (NoVoiceOut),
-    .voice_size_in  = sizeof (NoVoiceIn)
-};
+static void audio_none_class_init(ObjectClass *klass, const void *data)
+{
+    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
+
+    k->name = "none";
+    k->pcm_ops = &no_pcm_ops;
+    k->max_voices_out = INT_MAX;
+    k->max_voices_in = INT_MAX;
+    k->voice_size_out = sizeof(NoVoiceOut);
+    k->voice_size_in = sizeof(NoVoiceIn);
+}
 
 static const TypeInfo audio_types[] = {
     {
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index e6f8d6d41e5..0ad974e20cc 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -46,7 +46,6 @@ struct AudioOss {
     AudioMixengBackend parent_obj;
 };
 
-static struct audio_driver oss_audio_driver;
 
 #if defined OSS_GETVERSION && defined SNDCTL_DSP_POLICY
 #define USE_DSP_POLICY
@@ -773,15 +772,6 @@ static struct audio_pcm_ops oss_pcm_ops = {
     .enable_in = oss_enable_in
 };
 
-static struct audio_driver oss_audio_driver = {
-    .name           = "oss",
-    .pcm_ops        = &oss_pcm_ops,
-    .max_voices_out = INT_MAX,
-    .max_voices_in  = INT_MAX,
-    .voice_size_out = sizeof (OSSVoiceOut),
-    .voice_size_in  = sizeof (OSSVoiceIn)
-};
-
 static void audio_oss_class_init(ObjectClass *klass, const void *data)
 {
     AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
@@ -790,7 +780,12 @@ static void audio_oss_class_init(ObjectClass *klass, const void *data)
     audio_oss_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
 
     b->realize = audio_oss_realize;
-    k->driver = &oss_audio_driver;
+    k->name = "oss";
+    k->pcm_ops = &oss_pcm_ops;
+    k->max_voices_out = INT_MAX;
+    k->max_voices_in = INT_MAX;
+    k->voice_size_out = sizeof(OSSVoiceOut);
+    k->voice_size_in = sizeof(OSSVoiceIn);
 }
 
 static const TypeInfo audio_types[] = {
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 35818296282..5758050cb55 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -16,7 +16,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(AudioPa, AUDIO_PA)
 
 static AudioBackendClass *audio_pa_parent_class;
 
-static struct audio_driver pa_audio_driver;
 
 typedef struct PAConnection {
     char *server;
@@ -931,15 +930,6 @@ static struct audio_pcm_ops qpa_pcm_ops = {
     .volume_in = qpa_volume_in
 };
 
-static struct audio_driver pa_audio_driver = {
-    .name           = "pa",
-    .pcm_ops        = &qpa_pcm_ops,
-    .max_voices_out = INT_MAX,
-    .max_voices_in  = INT_MAX,
-    .voice_size_out = sizeof (PAVoiceOut),
-    .voice_size_in  = sizeof (PAVoiceIn),
-};
-
 static void audio_pa_class_init(ObjectClass *klass, const void *data)
 {
     AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
@@ -948,7 +938,12 @@ static void audio_pa_class_init(ObjectClass *klass, const void *data)
     audio_pa_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
 
     b->realize = audio_pa_realize;
-    k->driver = &pa_audio_driver;
+    k->name = "pa";
+    k->pcm_ops = &qpa_pcm_ops;
+    k->max_voices_out = INT_MAX;
+    k->max_voices_in = INT_MAX;
+    k->voice_size_out = sizeof(PAVoiceOut);
+    k->voice_size_in = sizeof(PAVoiceIn);
 }
 
 static const TypeInfo audio_types[] = {
diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index c668ef19a3e..f7f7dfbe0ad 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -44,7 +44,6 @@ struct AudioPw {
     int last_seq, pending_seq, error;
 };
 
-static struct audio_driver pw_audio_driver;
 
 typedef struct pwvolume {
     uint32_t channels;
@@ -840,15 +839,6 @@ static struct audio_pcm_ops qpw_pcm_ops = {
     .enable_in = qpw_enable_in
 };
 
-static struct audio_driver pw_audio_driver = {
-    .name = "pipewire",
-    .pcm_ops = &qpw_pcm_ops,
-    .max_voices_out = INT_MAX,
-    .max_voices_in = INT_MAX,
-    .voice_size_out = sizeof(PWVoiceOut),
-    .voice_size_in = sizeof(PWVoiceIn),
-};
-
 static void audio_pw_class_init(ObjectClass *klass, const void *data)
 {
     AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
@@ -857,7 +847,12 @@ static void audio_pw_class_init(ObjectClass *klass, const void *data)
     audio_pw_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
 
     b->realize = audio_pw_realize;
-    k->driver = &pw_audio_driver;
+    k->name = "pipewire";
+    k->pcm_ops = &qpw_pcm_ops;
+    k->max_voices_out = INT_MAX;
+    k->max_voices_in = INT_MAX;
+    k->voice_size_out = sizeof(PWVoiceOut);
+    k->voice_size_in = sizeof(PWVoiceIn);
 }
 
 static const TypeInfo audio_types[] = {
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index a1d453aa307..62f7ac8d76b 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -50,7 +50,6 @@ struct AudioSdl {
     AudioMixengBackend parent_obj;
 };
 
-static struct audio_driver sdl_audio_driver;
 
 typedef struct SDLVoiceOut {
     HWVoiceOut hw;
@@ -492,15 +491,6 @@ static struct audio_pcm_ops sdl_pcm_ops = {
     .enable_in = sdl_enable_in,
 };
 
-static struct audio_driver sdl_audio_driver = {
-    .name           = "sdl",
-    .pcm_ops        = &sdl_pcm_ops,
-    .max_voices_out = INT_MAX,
-    .max_voices_in  = INT_MAX,
-    .voice_size_out = sizeof(SDLVoiceOut),
-    .voice_size_in  = sizeof(SDLVoiceIn),
-};
-
 static void audio_sdl_class_init(ObjectClass *klass, const void *data)
 {
     AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
@@ -509,7 +499,12 @@ static void audio_sdl_class_init(ObjectClass *klass, const void *data)
     audio_sdl_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
 
     b->realize = audio_sdl_realize;
-    k->driver = &sdl_audio_driver;
+    k->name = "sdl";
+    k->pcm_ops = &sdl_pcm_ops;
+    k->max_voices_out = INT_MAX;
+    k->max_voices_in = INT_MAX;
+    k->voice_size_out = sizeof(SDLVoiceOut);
+    k->voice_size_in = sizeof(SDLVoiceIn);
 }
 
 static const TypeInfo audio_types[] = {
diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
index 77685e27cb1..5cd6250775b 100644
--- a/audio/sndioaudio.c
+++ b/audio/sndioaudio.c
@@ -32,14 +32,6 @@ struct AudioSndio {
     AudioMixengBackend parent_obj;
 };
 
-static struct audio_driver sndio_audio_driver;
-
-static void audio_sndio_class_init(ObjectClass *klass, const void *data)
-{
-    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
-
-    k->driver = &sndio_audio_driver;
-}
 
 /* default latency in microseconds if no option is set */
 #define SNDIO_LATENCY_US   50000
@@ -551,14 +543,17 @@ static struct audio_pcm_ops sndio_pcm_ops = {
     .put_buffer_in   = sndio_put_buffer_in,
 };
 
-static struct audio_driver sndio_audio_driver = {
-    .name           = "sndio",
-    .pcm_ops        = &sndio_pcm_ops,
-    .max_voices_out = INT_MAX,
-    .max_voices_in  = INT_MAX,
-    .voice_size_out = sizeof(SndioVoice),
-    .voice_size_in  = sizeof(SndioVoice)
-};
+static void audio_sndio_class_init(ObjectClass *klass, const void *data)
+{
+    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
+
+    k->name = "sndio";
+    k->pcm_ops = &sndio_pcm_ops;
+    k->max_voices_out = INT_MAX;
+    k->max_voices_in = INT_MAX;
+    k->voice_size_out = sizeof(SndioVoice);
+    k->voice_size_in = sizeof(SndioVoice);
+}
 
 static const TypeInfo audio_types[] = {
     {
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index cc6c5d7e287..995e0f6faa3 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -39,8 +39,6 @@ struct AudioSpice {
     AudioMixengBackend parent_obj;
 };
 
-static struct audio_driver spice_audio_driver;
-
 static bool spice_audio_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
 {
     if (!using_spice) {
@@ -52,17 +50,6 @@ static bool spice_audio_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
     return audio_spice_parent_class->realize(abe, dev, errp);
 }
 
-static void audio_spice_class_init(ObjectClass *klass, const void *data)
-{
-    AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
-    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
-
-    audio_spice_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
-
-    b->realize = spice_audio_realize;
-    k->driver = &spice_audio_driver;
-}
-
 #if SPICE_INTERFACE_PLAYBACK_MAJOR > 1 || SPICE_INTERFACE_PLAYBACK_MINOR >= 3
 #define LINE_OUT_SAMPLES (480 * 4)
 #else
@@ -332,14 +319,21 @@ static struct audio_pcm_ops audio_callbacks = {
 #endif
 };
 
-static struct audio_driver spice_audio_driver = {
-    .name           = "spice",
-    .pcm_ops        = &audio_callbacks,
-    .max_voices_out = 1,
-    .max_voices_in  = 1,
-    .voice_size_out = sizeof (SpiceVoiceOut),
-    .voice_size_in  = sizeof (SpiceVoiceIn),
-};
+static void audio_spice_class_init(ObjectClass *klass, const void *data)
+{
+    AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
+    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
+
+    audio_spice_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
+
+    b->realize = spice_audio_realize;
+    k->name = "spice";
+    k->pcm_ops = &audio_callbacks;
+    k->max_voices_out = 1;
+    k->max_voices_in = 1;
+    k->voice_size_out = sizeof(SpiceVoiceOut);
+    k->voice_size_in = sizeof(SpiceVoiceIn);
+}
 
 static const TypeInfo audio_types[] = {
     {
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index f9a0484488b..153e50fa0be 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -37,15 +37,6 @@ struct AudioWav {
     AudioMixengBackend parent_obj;
 };
 
-static struct audio_driver wav_audio_driver;
-
-static void audio_wav_class_init(ObjectClass *klass, const void *data)
-{
-    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
-
-    k->driver = &wav_audio_driver;
-}
-
 typedef struct WAVVoiceOut {
     HWVoiceOut hw;
     FILE *f;
@@ -208,14 +199,17 @@ static struct audio_pcm_ops wav_pcm_ops = {
     .enable_out = wav_enable_out,
 };
 
-static struct audio_driver wav_audio_driver = {
-    .name           = "wav",
-    .pcm_ops        = &wav_pcm_ops,
-    .max_voices_out = 1,
-    .max_voices_in  = 0,
-    .voice_size_out = sizeof (WAVVoiceOut),
-    .voice_size_in  = 0
-};
+static void audio_wav_class_init(ObjectClass *klass, const void *data)
+{
+    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
+
+    k->name = "wav";
+    k->pcm_ops = &wav_pcm_ops;
+    k->max_voices_out = 1;
+    k->max_voices_in = 0;
+    k->voice_size_out = sizeof(WAVVoiceOut);
+    k->voice_size_in = 0;
+}
 
 static const TypeInfo audio_types[] = {
     {
diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index a3a0b83eb9d..e9274976f94 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -41,15 +41,6 @@
     AudioMixengBackend parent_obj;
 };
 
-static struct audio_driver coreaudio_audio_driver;
-
-static void audio_coreaudio_class_init(ObjectClass *klass, const void *data)
-{
-    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
-
-    k->driver = &coreaudio_audio_driver;
-}
-
 typedef struct coreaudioVoiceOut {
     HWVoiceOut hw;
     pthread_mutex_t buf_mutex;
@@ -669,14 +660,17 @@ static void coreaudio_enable_out(HWVoiceOut *hw, bool enable)
     .enable_out = coreaudio_enable_out
 };
 
-static struct audio_driver coreaudio_audio_driver = {
-    .name           = "coreaudio",
-    .pcm_ops        = &coreaudio_pcm_ops,
-    .max_voices_out = 1,
-    .max_voices_in  = 0,
-    .voice_size_out = sizeof (coreaudioVoiceOut),
-    .voice_size_in  = 0
-};
+static void audio_coreaudio_class_init(ObjectClass *klass, const void *data)
+{
+    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
+
+    k->name = "coreaudio";
+    k->pcm_ops = &coreaudio_pcm_ops;
+    k->max_voices_out = 1;
+    k->max_voices_in = 0;
+    k->voice_size_out = sizeof(coreaudioVoiceOut);
+    k->voice_size_in = 0;
+}
 
 static const TypeInfo audio_types[] = {
     {
-- 
2.53.0


