Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B27E98E13
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 09:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuSZb-0001TH-3R; Mon, 23 Feb 2026 04:49:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSZE-00008w-Dh
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:49:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSZC-00074l-LZ
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:49:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771840166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N7lpB4YO8784dZ+RNH6GgnM/80tJeOGdjPt/WifQCsU=;
 b=Y8+iBuhz1CAwn+ot+zE6qNrXK3mh5p9u+YC6UAVEVE4nhxjsbHpp3CQbqSA80sYjD0BkhM
 D1ZYeiufSsGE20GoniasivmZEALU+Mto/SBY2m2X7FvmbD5yapb4WG1qW9RGiJ7ib6vrCD
 XZYI2JFz5aDRlsqJF5brMEngDlerNRs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-WS3WfwIlMpO966c6kEUj4g-1; Mon,
 23 Feb 2026 04:49:22 -0500
X-MC-Unique: WS3WfwIlMpO966c6kEUj4g-1
X-Mimecast-MFC-AGG-ID: WS3WfwIlMpO966c6kEUj4g_1771840161
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D0EB1956070; Mon, 23 Feb 2026 09:49:21 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3EC8A30001BE; Mon, 23 Feb 2026 09:49:20 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>
Subject: [PULL v2 49/85] audio/sdl: convert to QOM lifecycle methods
Date: Mon, 23 Feb 2026 10:46:07 +0100
Message-ID: <20260223094649.2005118-50-marcandre.lureau@redhat.com>
In-Reply-To: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
References: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Migrate the SDL audio backend from the legacy driver init/fini
callbacks to proper QOM realize and finalize methods.

The sdl_audio_init() function is replaced with audio_sdl_realize(),
which initializes the SDL audio subsystem before delegating to the
parent class realize method. The sdl_audio_fini() is replaced with
audio_sdl_finalize() to properly clean up the SDL audio subsystem.

Access to the Audiodev is now through hw->s->dev instead of the
drv_opaque pointer.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/sdlaudio.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index a60b1629da0..0dfa3100828 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -44,19 +44,14 @@
 #define TYPE_AUDIO_SDL "audio-sdl"
 OBJECT_DECLARE_SIMPLE_TYPE(AudioSdl, AUDIO_SDL)
 
+static AudioBackendClass *audio_sdl_parent_class;
+
 struct AudioSdl {
     AudioMixengBackend parent_obj;
 };
 
 static struct audio_driver sdl_audio_driver;
 
-static void audio_sdl_class_init(ObjectClass *klass, const void *data)
-{
-    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
-
-    k->driver = &sdl_audio_driver;
-}
-
 typedef struct SDLVoiceOut {
     HWVoiceOut hw;
     int exit;
@@ -356,7 +351,7 @@ static int sdl_init_out(HWVoiceOut *hw, struct audsettings *as,
     SDLVoiceOut *sdl = (SDLVoiceOut *)hw;
     SDL_AudioSpec req, obt;
     int err;
-    Audiodev *dev = drv_opaque;
+    Audiodev *dev = hw->s->dev;
     AudiodevSdlPerDirectionOptions *spdo = dev->u.sdl.out;
     struct audsettings obt_as;
 
@@ -412,7 +407,7 @@ static int sdl_init_in(HWVoiceIn *hw, audsettings *as, void *drv_opaque)
     SDLVoiceIn *sdl = (SDLVoiceIn *)hw;
     SDL_AudioSpec req, obt;
     int err;
-    Audiodev *dev = drv_opaque;
+    Audiodev *dev = hw->s->dev;
     AudiodevSdlPerDirectionOptions *spdo = dev->u.sdl.in;
     struct audsettings obt_as;
 
@@ -459,19 +454,20 @@ static void sdl_enable_in(HWVoiceIn *hw, bool enable)
     SDL_PauseAudioDevice(sdl->devid, !enable);
 }
 
-static void *sdl_audio_init(Audiodev *dev, Error **errp)
+static bool audio_sdl_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
 {
-    if (SDL_InitSubSystem (SDL_INIT_AUDIO)) {
+    if (SDL_InitSubSystem(SDL_INIT_AUDIO)) {
         error_setg(errp, "SDL failed to initialize audio subsystem");
-        return NULL;
+        qapi_free_Audiodev(dev);
+        return false;
     }
 
-    return dev;
+    return audio_sdl_parent_class->realize(abe, dev, errp);
 }
 
-static void sdl_audio_fini (void *opaque)
+static void audio_sdl_finalize(Object *obj)
 {
-    SDL_QuitSubSystem (SDL_INIT_AUDIO);
+    SDL_QuitSubSystem(SDL_INIT_AUDIO);
 }
 
 static struct audio_pcm_ops sdl_pcm_ops = {
@@ -499,8 +495,6 @@ static struct audio_pcm_ops sdl_pcm_ops = {
 
 static struct audio_driver sdl_audio_driver = {
     .name           = "sdl",
-    .init           = sdl_audio_init,
-    .fini           = sdl_audio_fini,
     .pcm_ops        = &sdl_pcm_ops,
     .max_voices_out = INT_MAX,
     .max_voices_in  = INT_MAX,
@@ -508,12 +502,24 @@ static struct audio_driver sdl_audio_driver = {
     .voice_size_in  = sizeof(SDLVoiceIn),
 };
 
+static void audio_sdl_class_init(ObjectClass *klass, const void *data)
+{
+    AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
+    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
+
+    audio_sdl_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
+
+    b->realize = audio_sdl_realize;
+    k->driver = &sdl_audio_driver;
+}
+
 static const TypeInfo audio_types[] = {
     {
         .name = TYPE_AUDIO_SDL,
         .parent = TYPE_AUDIO_MIXENG_BACKEND,
         .instance_size = sizeof(AudioSdl),
         .class_init = audio_sdl_class_init,
+        .instance_finalize = audio_sdl_finalize,
     },
 };
 
-- 
2.53.0


