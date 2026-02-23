Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395F1EA4FC1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 13:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuWK8-0003qg-0D; Mon, 23 Feb 2026 08:50:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWIy-00016Z-Br
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:48:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWIw-00076N-AG
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771854533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7HCB0tFd+ANmIO7FPb3+hIVZQ6tqCMrMKL5pZLTa81o=;
 b=ZT9XdHWW1/SFrarmZEhJyE9/eQHCn/Q/+np0j8pk45omUm1keTXwH3GjNAh9Co61nc/Lvt
 4zxkd8iAA9xhbLaQqX1J+6l9OdN+MzzFwgiJdMsEunzaHoDDURZnBbuZjtNTdoDQZZUWT9
 rrhw7ago2piYWHIfUgcvUpre1z7IiDU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-GiA1s5N3PqCr7PLW8q9gDw-1; Mon,
 23 Feb 2026 08:48:49 -0500
X-MC-Unique: GiA1s5N3PqCr7PLW8q9gDw-1
X-Mimecast-MFC-AGG-ID: GiA1s5N3PqCr7PLW8q9gDw_1771854528
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CBCB1956072; Mon, 23 Feb 2026 13:48:48 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0F56F30001BE; Mon, 23 Feb 2026 13:48:46 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>
Subject: [PULL v3 27/85] audio: drop audio driver registration
Date: Mon, 23 Feb 2026 14:46:28 +0100
Message-ID: <20260223134731.2377432-28-marcandre.lureau@redhat.com>
In-Reply-To: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
References: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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


