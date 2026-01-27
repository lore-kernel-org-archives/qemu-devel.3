Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDF8D2FED8
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknmP-0006M7-Kl; Tue, 27 Jan 2026 13:27:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vknm7-0005Wl-Gm
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:26:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vknm5-0003DO-4A
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769538407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kyKmc102v21b6I9WW7W8KwGGxvCbroklvaSgfGJz8t8=;
 b=B3g2nZhuez83KFlpSbN26KjuZJUGrTrwjtMQrOzxsmC+saD/40W0ohHosA8UwVOD6Atg3z
 /rmgc86wScUdUOgFZgxc63qpwyjRu6HndaRkTkUHCDDF5yKgiXfFanBI9v2wgkCuc/Akzz
 g6P2W/mqvj7DzsVywdAHcGk36xvFoc0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-9iMponq2MImPFLQ5xPk74g-1; Tue,
 27 Jan 2026 13:26:46 -0500
X-MC-Unique: 9iMponq2MImPFLQ5xPk74g-1
X-Mimecast-MFC-AGG-ID: 9iMponq2MImPFLQ5xPk74g_1769538404
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA5251944F2F; Tue, 27 Jan 2026 18:26:44 +0000 (UTC)
Received: from localhost (unknown [10.45.242.23])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DDA9219560B4; Tue, 27 Jan 2026 18:26:42 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>
Subject: [PATCH 14/43] audio: remove audio_driver init/fini/next
Date: Tue, 27 Jan 2026 22:24:41 +0400
Message-ID: <20260127182516.289834-15-marcandre.lureau@redhat.com>
In-Reply-To: <20260127182516.289834-1-marcandre.lureau@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

They are no longer used after conversion to QOM.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_int.h       |  8 ++------
 audio/audio_template.h  |  2 +-
 audio/dsound_template.h |  6 ++----
 audio/alsaaudio.c       |  5 ++---
 audio/audio-mixeng-be.c | 15 +--------------
 audio/dbusaudio.c       |  4 ++--
 audio/jackaudio.c       |  6 ++----
 audio/noaudio.c         |  4 ++--
 audio/ossaudio.c        |  5 ++---
 audio/paaudio.c         |  5 ++---
 audio/pwaudio.c         |  4 ++--
 audio/sdlaudio.c        |  5 ++---
 audio/sndioaudio.c      |  4 ++--
 audio/spiceaudio.c      |  5 ++---
 audio/wavaudio.c        |  3 +--
 audio/coreaudio.m       |  3 +--
 16 files changed, 28 insertions(+), 56 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 6ecd75c4fbf..fb5a9dd871e 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -139,18 +139,15 @@ struct SWVoiceIn {
 typedef struct audio_driver audio_driver;
 struct audio_driver {
     const char *name;
-    void *(*init) (Audiodev *, Error **);
-    void (*fini) (void *);
     struct audio_pcm_ops *pcm_ops;
     int max_voices_out;
     int max_voices_in;
     size_t voice_size_out;
     size_t voice_size_in;
-    QLIST_ENTRY(audio_driver) next;
 };
 
 struct audio_pcm_ops {
-    int    (*init_out)(HWVoiceOut *hw, audsettings *as, void *drv_opaque);
+    int    (*init_out)(HWVoiceOut *hw, audsettings *as);
     void   (*fini_out)(HWVoiceOut *hw);
     size_t (*write)   (HWVoiceOut *hw, void *buf, size_t size);
     void   (*run_buffer_out)(HWVoiceOut *hw);
@@ -173,7 +170,7 @@ struct audio_pcm_ops {
     void   (*enable_out)(HWVoiceOut *hw, bool enable);
     void   (*volume_out)(HWVoiceOut *hw, Volume *vol);
 
-    int    (*init_in) (HWVoiceIn *hw, audsettings *as, void *drv_opaque);
+    int    (*init_in) (HWVoiceIn *hw, audsettings *as);
     void   (*fini_in) (HWVoiceIn *hw);
     size_t (*read)    (HWVoiceIn *hw, void *buf, size_t size);
     void   (*run_buffer_in)(HWVoiceIn *hw);
@@ -240,7 +237,6 @@ struct AudioMixengBackend {
 
     struct audio_driver *drv;
     Audiodev *dev;
-    void *drv_opaque;
 
     QEMUTimer *ts;
     QLIST_HEAD (hw_in_listhead, HWVoiceIn) hw_head_in;
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 77a70d6e56a..6c2d2ad5dca 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -295,7 +295,7 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioMixengBackend *s,
 #ifdef DAC
     QLIST_INIT (&hw->cap_head);
 #endif
-    if (glue (hw->pcm_ops->init_, TYPE) (hw, as, s->drv_opaque)) {
+    if (glue (hw->pcm_ops->init_, TYPE) (hw, as)) {
         goto err0;
     }
 
diff --git a/audio/dsound_template.h b/audio/dsound_template.h
index 7979773eb86..022a7307c99 100644
--- a/audio/dsound_template.h
+++ b/audio/dsound_template.h
@@ -157,11 +157,9 @@ static void dsound_fini_out (HWVoiceOut *hw)
 }
 
 #ifdef DSBTYPE_IN
-static int dsound_init_in(HWVoiceIn *hw, struct audsettings *as,
-                          void *drv_opaque)
+static int dsound_init_in(HWVoiceIn *hw, struct audsettings *as)
 #else
-static int dsound_init_out(HWVoiceOut *hw, struct audsettings *as,
-                           void *drv_opaque)
+static int dsound_init_out(HWVoiceOut *hw, struct audsettings *as)
 #endif
 {
     int err;
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 42bfea2515d..0bb2ab5c462 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -692,8 +692,7 @@ static void alsa_fini_out (HWVoiceOut *hw)
     alsa_anal_close (&alsa->handle, &alsa->pollhlp);
 }
 
-static int alsa_init_out(HWVoiceOut *hw, struct audsettings *as,
-                         void *drv_opaque)
+static int alsa_init_out(HWVoiceOut *hw, struct audsettings *as)
 {
     ALSAVoiceOut *alsa = (ALSAVoiceOut *) hw;
     struct alsa_params_req req;
@@ -779,7 +778,7 @@ static void alsa_enable_out(HWVoiceOut *hw, bool enable)
     }
 }
 
-static int alsa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
+static int alsa_init_in(HWVoiceIn *hw, struct audsettings *as)
 {
     ALSAVoiceIn *alsa = (ALSAVoiceIn *) hw;
     struct alsa_params_req req;
diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
index c814a178f94..8024ca6bf9f 100644
--- a/audio/audio-mixeng-be.c
+++ b/audio/audio-mixeng-be.c
@@ -1521,13 +1521,6 @@ static bool audio_mixeng_backend_realize(AudioBackend *abe,
     audio_driver *drv = AUDIO_MIXENG_BACKEND_GET_CLASS(be)->driver;
 
     be->dev = dev;
-    if (drv->init != NULL) {
-        be->drv_opaque = drv->init(be->dev, errp);
-        if (!be->drv_opaque) {
-            return false;
-        }
-    }
-
     if (!drv->pcm_ops->get_buffer_in) {
         drv->pcm_ops->get_buffer_in = audio_generic_get_buffer_in;
         drv->pcm_ops->put_buffer_in = audio_generic_put_buffer_in;
@@ -1665,13 +1658,7 @@ static void audio_mixeng_backend_finalize(Object *obj)
         QLIST_REMOVE(hwi, entries);
     }
 
-    if (s->drv) {
-        if (s->drv->fini) {
-            s->drv->fini (s->drv_opaque);
-        }
-        s->drv = NULL;
-    }
-
+    s->drv = NULL;
     if (s->dev) {
         qapi_free_Audiodev(s->dev);
         s->dev = NULL;
diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index b31bfd88d81..a69baad4aec 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -173,7 +173,7 @@ dbus_audio_get_nsamples(AudioDbus *da)
 }
 
 static int
-dbus_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
+dbus_init_out(HWVoiceOut *hw, struct audsettings *as)
 {
     AudioDbus *da = AUDIO_DBUS(hw->s);
     DBusVoiceOut *vo = container_of(hw, DBusVoiceOut, hw);
@@ -287,7 +287,7 @@ dbus_init_in_listener(QemuDBusDisplay1AudioInListener *listener, HWVoiceIn *hw)
 }
 
 static int
-dbus_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
+dbus_init_in(HWVoiceIn *hw, struct audsettings *as)
 {
     AudioDbus *da = AUDIO_DBUS(hw->s);
     DBusVoiceIn *vo = container_of(hw, DBusVoiceIn, hw);
diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index 7fbc37ef4f2..650ec230846 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -507,8 +507,7 @@ static int qjack_client_init(QJackClient *c)
     return 0;
 }
 
-static int qjack_init_out(HWVoiceOut *hw, struct audsettings *as,
-    void *drv_opaque)
+static int qjack_init_out(HWVoiceOut *hw, struct audsettings *as)
 {
     QJackOut *jo  = (QJackOut *)hw;
     Audiodev *dev = hw->s->dev;
@@ -544,8 +543,7 @@ static int qjack_init_out(HWVoiceOut *hw, struct audsettings *as,
     return 0;
 }
 
-static int qjack_init_in(HWVoiceIn *hw, struct audsettings *as,
-    void *drv_opaque)
+static int qjack_init_in(HWVoiceIn *hw, struct audsettings *as)
 {
     QJackIn  *ji  = (QJackIn *)hw;
     Audiodev *dev = hw->s->dev;
diff --git a/audio/noaudio.c b/audio/noaudio.c
index fd032ee6e09..5c721ed69d0 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -62,7 +62,7 @@ static size_t no_write(HWVoiceOut *hw, void *buf, size_t len)
     return audio_rate_get_bytes(&no->rate, &hw->info, len);
 }
 
-static int no_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
+static int no_init_out(HWVoiceOut *hw, struct audsettings *as)
 {
     NoVoiceOut *no = (NoVoiceOut *) hw;
 
@@ -86,7 +86,7 @@ static void no_enable_out(HWVoiceOut *hw, bool enable)
     }
 }
 
-static int no_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
+static int no_init_in(HWVoiceIn *hw, struct audsettings *as)
 {
     NoVoiceIn *no = (NoVoiceIn *) hw;
 
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index e745149ca39..a4ee6ee3327 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -493,8 +493,7 @@ static void oss_fini_out (HWVoiceOut *hw)
     }
 }
 
-static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
-                        void *drv_opaque)
+static int oss_init_out(HWVoiceOut *hw, struct audsettings *as)
 {
     OSSVoiceOut *oss = (OSSVoiceOut *) hw;
     struct oss_params req, obt;
@@ -625,7 +624,7 @@ static void oss_enable_out(HWVoiceOut *hw, bool enable)
     }
 }
 
-static int oss_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
+static int oss_init_in(HWVoiceIn *hw, struct audsettings *as)
 {
     OSSVoiceIn *oss = (OSSVoiceIn *) hw;
     struct oss_params req, obt;
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 8191b54468e..4d77f341b5f 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -518,8 +518,7 @@ fail:
     return NULL;
 }
 
-static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
-                        void *drv_opaque)
+static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as)
 {
     AudioMixengBackend *amb = hw->s;
     AudioPa *apa = AUDIO_PA(amb);
@@ -570,7 +569,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
     return -1;
 }
 
-static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
+static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as)
 {
     AudioMixengBackend *amb = hw->s;
     AudioPa *apa = AUDIO_PA(amb);
diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index ddf5f2c70f7..c1cc945e659 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -524,7 +524,7 @@ qpw_set_position(uint32_t channels, uint32_t position[SPA_AUDIO_MAX_CHANNELS])
 }
 
 static int
-qpw_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
+qpw_init_out(HWVoiceOut *hw, struct audsettings *as)
 {
     AudioPw *c = AUDIO_PW(hw->s);
     PWVoiceOut *pw = (PWVoiceOut *) hw;
@@ -571,7 +571,7 @@ qpw_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
 }
 
 static int
-qpw_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
+qpw_init_in(HWVoiceIn *hw, struct audsettings *as)
 {
     AudioPw *c = AUDIO_PW(hw->s);
     PWVoiceIn *pw = (PWVoiceIn *) hw;
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index aa3c0922199..2e9bc255a41 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -345,8 +345,7 @@ static void sdl_fini_out(HWVoiceOut *hw)
     sdl_close_out(sdl);
 }
 
-static int sdl_init_out(HWVoiceOut *hw, struct audsettings *as,
-                        void *drv_opaque)
+static int sdl_init_out(HWVoiceOut *hw, struct audsettings *as)
 {
     SDLVoiceOut *sdl = (SDLVoiceOut *)hw;
     SDL_AudioSpec req, obt;
@@ -402,7 +401,7 @@ static void sdl_fini_in(HWVoiceIn *hw)
     sdl_close_in(sdl);
 }
 
-static int sdl_init_in(HWVoiceIn *hw, audsettings *as, void *drv_opaque)
+static int sdl_init_in(HWVoiceIn *hw, audsettings *as)
 {
     SDLVoiceIn *sdl = (SDLVoiceIn *)hw;
     SDL_AudioSpec req, obt;
diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
index 4c2acbcbb4b..de2ee44fa0d 100644
--- a/audio/sndioaudio.c
+++ b/audio/sndioaudio.c
@@ -495,7 +495,7 @@ static void sndio_enable_in(HWVoiceIn *hw, bool enable)
     sndio_enable(self, enable);
 }
 
-static int sndio_init_out(HWVoiceOut *hw, struct audsettings *as, void *opaque)
+static int sndio_init_out(HWVoiceOut *hw, struct audsettings *as)
 {
     SndioVoice *self = (SndioVoice *) hw;
 
@@ -508,7 +508,7 @@ static int sndio_init_out(HWVoiceOut *hw, struct audsettings *as, void *opaque)
     return 0;
 }
 
-static int sndio_init_in(HWVoiceIn *hw, struct audsettings *as, void *opaque)
+static int sndio_init_in(HWVoiceIn *hw, struct audsettings *as)
 {
     SndioVoice *self = (SndioVoice *) hw;
 
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index b72424055c0..248249cef61 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -108,8 +108,7 @@ static const SpiceRecordInterface record_sif = {
 
 /* playback */
 
-static int line_out_init(HWVoiceOut *hw, struct audsettings *as,
-                         void *drv_opaque)
+static int line_out_init(HWVoiceOut *hw, struct audsettings *as)
 {
     SpiceVoiceOut *out = container_of (hw, SpiceVoiceOut, hw);
     struct audsettings settings;
@@ -225,7 +224,7 @@ static void line_out_volume(HWVoiceOut *hw, Volume *vol)
 
 /* record */
 
-static int line_in_init(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
+static int line_in_init(HWVoiceIn *hw, struct audsettings *as)
 {
     SpiceVoiceIn *in = container_of (hw, SpiceVoiceIn, hw);
     struct audsettings settings;
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 2a7703831f3..56b3122938f 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -78,8 +78,7 @@ static void le_store (uint8_t *buf, uint32_t val, int len)
     }
 }
 
-static int wav_init_out(HWVoiceOut *hw, struct audsettings *as,
-                        void *drv_opaque)
+static int wav_init_out(HWVoiceOut *hw, struct audsettings *as)
 {
     WAVVoiceOut *wav = (WAVVoiceOut *) hw;
     int bits16 = 0, stereo = 0;
diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index 4ab2abfc6f7..925c68e8da4 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -573,8 +573,7 @@ static OSStatus handle_voice_change(
     return 0;
 }
 
-static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
-                              void *drv_opaque)
+static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as)
 {
     OSStatus status;
     coreaudioVoiceOut *core = (coreaudioVoiceOut *) hw;
-- 
2.52.0


