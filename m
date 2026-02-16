Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF641E7BD98
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfa-0008Mo-H0; Mon, 16 Feb 2026 06:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwbK-0005Z5-5y
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwb6-0007Ys-8R
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3cfhdOzknAF9YO6j0QekhEL3lL807Fp77kyJj7wmWFs=;
 b=K1UBGNUMMJaQpsj8z61J6/KbzA5OtGmRtWXYOmezW33uA9tddcE7sAd1sSV8igu9Toh3he
 lGf8LLJPg1cJ6JQSI1REEbaQLZWJrsAO/nQy0T51C+btzNwGxpizOdM98YNj9C9R+Eayst
 yxsRrVmSkyrBWgHlHX5VarkY0hp0c5o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-dgIVvDxQONKLDdsJPAnelA-1; Mon,
 16 Feb 2026 06:16:55 -0500
X-MC-Unique: dgIVvDxQONKLDdsJPAnelA-1
X-Mimecast-MFC-AGG-ID: dgIVvDxQONKLDdsJPAnelA_1771240613
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6AFFD180057E; Mon, 16 Feb 2026 11:16:53 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8890718003F5; Mon, 16 Feb 2026 11:16:52 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:16 +0100
Subject: [PATCH 27/85] audio: drop audio driver registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-27-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8757;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=azrrD2hSQuvPvUHhEWUcKcpNNPTuuiUl6Tzb3Fh3kL4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxPrPWbFGVfXMLpQzg2rNHWeAk8rDnBWOLKJ
 MI7Pwx3sR+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8TwAKCRDa6OEJdZac
 5UzND/9jBaKwuuWl3L5VRzoK3j1iU17UCb6YvE4L4/UcsDkDtZ4/86Jw+3bAZIkLwXE0J3fJOob
 0dPXDwTECFZWh4kEVTenIYuRqBXUHaKahAcBxX6YE8h0As8qiC/gFrebUptUP96T7TzplBhexvJ
 3A4V1XymaIpzTzFCQudAgEO3wbjPK9FsvD+7k2svnkddvAm+pzHbF+JHKcCqIARZjTsxtYGna/M
 3C+s2x79E5rSYRWNy4L01KfzzOeyoyxnts1LHvrYtgMZTtCpA/zo7DTnJKyAjdxAU+uqJODFUbe
 mI6Ykhd8b5mJqqn17RKf713KekVxXiXxWDpyoumaqK3QGDR3iVXZsld94lXFwjDBwHXIs6hxc6H
 5jnOg9f/GbdVaCLuWQqnw7l/ZSyLoLt7zkY3HUeRBvGHlBYsQEA5A0kFoouB0FXCI8D0uneoIVG
 /HxerlCKAYbP4OU8yONP83PIQoKrRm6/raRgR62yBniJ7znOj1MEVKD5omK1YEChapSTybdLJ2l
 IhFANRG23ZIUIr3sCsRZMxz/3l1I1aIIRQkM12vt9UB/ANWzcBri7q6dmmqT5EvvNXWjWsPseKy
 ztnr0WY1Y+ooVmMG/BH87UobAPL5+6uLiQ7/1VQu5UUCYIYz4GjBHB4OfJffLLW8AST6zCSqNTo
 yyBypsdfZ0RTFxg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

module_object_class_by_name() handles loading the module providing the
requested object.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/audio_int.h   |  2 --
 audio/alsaaudio.c   |  1 -
 audio/audio.c       | 43 +++++++++++++------------------------------
 audio/dbusaudio.c   |  1 -
 audio/dsoundaudio.c |  1 -
 audio/jackaudio.c   |  1 -
 audio/noaudio.c     |  1 -
 audio/ossaudio.c    |  1 -
 audio/paaudio.c     |  1 -
 audio/pwaudio.c     |  1 -
 audio/sdlaudio.c    |  1 -
 audio/sndioaudio.c  |  1 -
 audio/spiceaudio.c  |  1 -
 audio/wavaudio.c    |  1 -
 audio/coreaudio.m   |  1 -
 15 files changed, 13 insertions(+), 45 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 0b97c8edee3..446ba1d52c6 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -259,8 +259,6 @@ extern const struct mixeng_volume nominal_volume;
 
 extern const char *audio_prio_list[];
 
-void audio_driver_register(audio_driver *drv);
-
 void audio_pcm_init_info (struct audio_pcm_info *info, const struct audsettings *as);
 void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len);
 
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index ecc22d7c8f9..7200777ad82 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -972,7 +972,6 @@ static const TypeInfo audio_alsa_info = {
 
 static void register_audio_alsa(void)
 {
-    audio_driver_register(&alsa_audio_driver);
     type_register_static(&audio_alsa_info);
 }
 type_init(register_audio_alsa);
diff --git a/audio/audio.c b/audio/audio.c
index 72949fe27f5..16edc57e5f0 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -68,40 +68,21 @@ const char *audio_prio_list[] = {
     NULL
 };
 
-static QLIST_HEAD(, audio_driver) audio_drivers;
 static AudiodevListHead audiodevs =
     QSIMPLEQ_HEAD_INITIALIZER(audiodevs);
 static AudiodevListHead default_audiodevs =
     QSIMPLEQ_HEAD_INITIALIZER(default_audiodevs);
 
-
-void audio_driver_register(audio_driver *drv)
-{
-    QLIST_INSERT_HEAD(&audio_drivers, drv, next);
-}
-
-static audio_driver *audio_driver_lookup(const char *name)
+static AudioBackendClass *audio_be_class_by_name(const char *name)
 {
-    struct audio_driver *d;
-    Error *local_err = NULL;
-    int rv;
+    g_autofree char *tname = g_strconcat("audio-", name, NULL);
+    ObjectClass *oc = module_object_class_by_name(tname);
 
-    QLIST_FOREACH(d, &audio_drivers, next) {
-        if (strcmp(name, d->name) == 0) {
-            return d;
-        }
-    }
-    rv = audio_module_load(name, &local_err);
-    if (rv > 0) {
-        QLIST_FOREACH(d, &audio_drivers, next) {
-            if (strcmp(name, d->name) == 0) {
-                return d;
-            }
-        }
-    } else if (rv < 0) {
-        error_report_err(local_err);
+    if (!oc || !object_class_dynamic_cast(oc, TYPE_AUDIO_BACKEND)) {
+        return NULL;
     }
-    return NULL;
+
+    return AUDIO_BACKEND_CLASS(oc);
 }
 
 static AudioBackend *default_audio_be;
@@ -1764,7 +1745,7 @@ static const VMStateDescription vmstate_audio = {
 void audio_create_default_audiodevs(void)
 {
     for (int i = 0; audio_prio_list[i]; i++) {
-        if (audio_driver_lookup(audio_prio_list[i])) {
+        if (audio_be_class_by_name(audio_prio_list[i]) != NULL) {
             QDict *dict = qdict_new();
             Audiodev *dev = NULL;
             Visitor *v;
@@ -2129,9 +2110,11 @@ void audio_help(void)
     printf("Available audio drivers:\n");
 
     for (i = 0; i < AUDIODEV_DRIVER__MAX; i++) {
-        audio_driver *driver = audio_driver_lookup(AudiodevDriver_str(i));
-        if (driver) {
-            printf("%s\n", driver->name);
+        const char *name = AudiodevDriver_str(i);
+        AudioBackendClass *be = audio_be_class_by_name(name);
+
+        if (be) {
+            printf("%s\n", name);
         }
     }
 }
diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index 5a5752b8f33..48c9078d80e 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -738,7 +738,6 @@ static const TypeInfo audio_dbus_info = {
 
 static void register_audio_dbus(void)
 {
-    audio_driver_register(&dbus_audio_driver);
     type_register_static(&audio_dbus_info);
 }
 type_init(register_audio_dbus);
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 91c83dec742..6d213899660 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -720,7 +720,6 @@ static const TypeInfo audio_dsound_info = {
 
 static void register_audio_dsound(void)
 {
-    audio_driver_register(&dsound_audio_driver);
     type_register_static(&audio_dsound_info);
 }
 type_init(register_audio_dsound);
diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index 7ed2e91fcc8..bfce4cb0b4c 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -718,7 +718,6 @@ static const TypeInfo audio_jack_info = {
 static void register_audio_jack(void)
 {
     qemu_mutex_init(&qjack_shutdown_lock);
-    audio_driver_register(&jack_driver);
     type_register_static(&audio_jack_info);
 #if !defined(WIN32) && defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
     jack_set_thread_creator(qjack_thread_creator);
diff --git a/audio/noaudio.c b/audio/noaudio.c
index b3305480013..8b5ebd71bf6 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -164,7 +164,6 @@ static const TypeInfo audio_none_info = {
 
 static void register_audio_none(void)
 {
-    audio_driver_register(&no_audio_driver);
     type_register_static(&audio_none_info);
 }
 type_init(register_audio_none);
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 9697f4a0beb..b8e26b17ed7 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -798,7 +798,6 @@ static const TypeInfo audio_oss_info = {
 
 static void register_audio_oss(void)
 {
-    audio_driver_register(&oss_audio_driver);
     type_register_static(&audio_oss_info);
 }
 type_init(register_audio_oss);
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 707a6d2fb23..adaeb2af807 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -957,7 +957,6 @@ static const TypeInfo audio_pa_info = {
 
 static void register_audio_pa(void)
 {
-    audio_driver_register(&pa_audio_driver);
     type_register_static(&audio_pa_info);
 }
 type_init(register_audio_pa);
diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index 31f8899d1ed..facd166052c 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -874,7 +874,6 @@ static const TypeInfo audio_pw_info = {
 static void
 register_audio_pw(void)
 {
-    audio_driver_register(&pw_audio_driver);
     type_register_static(&audio_pw_info);
 }
 
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index 5841e131cc0..c00f1366d17 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -517,7 +517,6 @@ static const TypeInfo audio_sdl_info = {
 
 static void register_audio_sdl(void)
 {
-    audio_driver_register(&sdl_audio_driver);
     type_register_static(&audio_sdl_info);
 }
 type_init(register_audio_sdl);
diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
index 7f388b498f6..c8310b1fa37 100644
--- a/audio/sndioaudio.c
+++ b/audio/sndioaudio.c
@@ -581,7 +581,6 @@ static const TypeInfo audio_sndio_info = {
 
 static void register_audio_sndio(void)
 {
-    audio_driver_register(&sndio_audio_driver);
     type_register_static(&audio_sndio_info);
 }
 
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index d0bcc0836ad..d1bb318b6b7 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -351,7 +351,6 @@ static const TypeInfo audio_spice_info = {
 
 static void register_audio_spice(void)
 {
-    audio_driver_register(&spice_audio_driver);
     type_register_static(&audio_spice_info);
 }
 type_init(register_audio_spice);
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 00cf110ecd7..12d4108ffad 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -240,7 +240,6 @@ static const TypeInfo audio_wav_info = {
 
 static void register_audio_wav(void)
 {
-    audio_driver_register(&wav_audio_driver);
     type_register_static(&audio_wav_info);
 }
 type_init(register_audio_wav);
diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index 61333e9f2f9..5efd16df7c4 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -699,7 +699,6 @@ static void coreaudio_audio_fini (void *opaque)
 
 static void register_audio_coreaudio(void)
 {
-    audio_driver_register(&coreaudio_audio_driver);
     type_register_static(&audio_coreaudio_info);
 }
 type_init(register_audio_coreaudio);

-- 
2.53.0


