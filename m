Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A739FE7BD92
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfb-0008Ue-Ok; Mon, 16 Feb 2026 06:21:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwc8-0006RL-0I
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:18:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwc6-0008An-5g
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:18:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Rp8fyVkH2hZh+mPHtPSd3g8yoblH6WdY9/V5EDNhAE=;
 b=WfV4v4v8Niw6d3blMMx0HcMqYe4o5d1b/OnIQ9KfhjsDO5rDvEdbjogCq5ogeYwbdlNn/w
 EMok9dP48pzXM/vlkovneo+1lVA66UemkaUEU11H70AYBZemtu3/dOtWtDpm7PHhu4MSv7
 niJNQ/LHBdw4Bz5K2brF3aWOozsW/gk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-P-tWzq9TPfiVszLycTCsUA-1; Mon,
 16 Feb 2026 06:17:57 -0500
X-MC-Unique: P-tWzq9TPfiVszLycTCsUA-1
X-Mimecast-MFC-AGG-ID: P-tWzq9TPfiVszLycTCsUA_1771240675
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E8791800259; Mon, 16 Feb 2026 11:17:55 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9FDFB30001A5; Mon, 16 Feb 2026 11:17:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:38 +0100
Subject: [PATCH 49/85] audio/sdl: convert to QOM lifecycle methods
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-49-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4088;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Bi9IEy+nlgFFCt8QlBx2RYdWyux3lXAtO/gg3ozTayY=;
 b=owEBbAKT/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxQtE3m5hY51mQAQrSKdZIBcmYjmT5YyP8cp
 vUMuz6qBp6JAjIEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UAAKCRDa6OEJdZac
 5ROQD/dzAu4kQRBZiOoqG5a4TEY5nm127pGZega2hSBFiRQ5Ep3ZEB96xPTxG+kJoi6VHCY/T9I
 P0JxTrt2PellSi0S5ZPNSE6w+hy2YdSgVTsq1dRLcoNBT4wix6puI7qRp/8xs5ksDvYeGB+77NP
 hJ49mk3KxmBClm1/nJzrdZoG1gff3cVoPMapiEo4CxA6BpNyiz0FXrU83O240Ww1Iu9yliK908P
 W4z70Y+vG+c65ZlyXgEKJKqJZBmYZ4HN8K2c8yrBzxSe3Qh+1UBtz8usuKC9VwAthWT0iB/qtWI
 tVNitn6TMUkr7+d7grRKcJCxiyfNmLmU7i81ctLXoAtKmqgoY5Js0ajXZxl75IHyP0PG4A4uesd
 eLUECuz2FuOFkA4rii9YbVLUtB9QBCkw5AxtS1imhNm8/B0sFxUxCkAHAmZUEdoEMsl/uDQ/tgX
 bZRn5UkR4QwjOiwME9j+IywHiLJKMWrN/Z5leTLj3tXHUYD4voY0hmlgsQjxqRN5AOJIxuR1ybg
 cZVtsini+XZklQPGJW+Ei1SjOdsNBmlnK/nCyPDEw+N9lNgFlBPo4eUv1TROTnbTxe5GlTgp94q
 e5cL85CnhCLssitegN/Bsl28ADaGJqfKGOkam+a6V6xHQHvcgfBC+IYN0yzteFim5DUe9GnewOB
 TfaORBqIzmdtT
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Migrate the SDL audio backend from the legacy driver init/fini
callbacks to proper QOM realize and finalize methods.

The sdl_audio_init() function is replaced with audio_sdl_realize(),
which initializes the SDL audio subsystem before delegating to the
parent class realize method. The sdl_audio_fini() is replaced with
audio_sdl_finalize() to properly clean up the SDL audio subsystem.

Access to the Audiodev is now through hw->s->dev instead of the
drv_opaque pointer.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
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


