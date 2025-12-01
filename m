Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C208D111A8
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 11:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ21J-0001Vu-RD; Mon, 01 Dec 2025 06:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ21I-0001PU-Lb
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:24:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ21G-0006bo-O0
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764588278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gbV3yRehhUnpngzS2Eefm+9zcrjOE+PZ5+HQpxGNrRU=;
 b=cHAHYCOPi0qwVItfxMspsFWPKlP1FLJ7ion+Uop3Lwsk1t7r4hQUJnOVuh6Bd7D+fL4MTB
 z9jUojxFrLlb6bbOD8Abip8T3KyeVjcAGrMuGEbcGkAY0vtbzwfFzLbfLAPvAWvAwm8E3B
 13Dr5eWVKFvOCTL1WljqG8OMzbrIuA8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-Cnzrsj14MuS7wDTqffaE7g-1; Mon,
 01 Dec 2025 06:24:34 -0500
X-MC-Unique: Cnzrsj14MuS7wDTqffaE7g-1
X-Mimecast-MFC-AGG-ID: Cnzrsj14MuS7wDTqffaE7g_1764588272
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4298518002D6; Mon,  1 Dec 2025 11:24:29 +0000 (UTC)
Received: from localhost (unknown [10.45.242.40])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C3643002D0C; Mon,  1 Dec 2025 11:24:26 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [RFC 11/24] audio: switch to module-object,
 drop audio driver registration
Date: Mon,  1 Dec 2025 15:22:52 +0400
Message-ID: <20251201112309.4163921-12-marcandre.lureau@redhat.com>
In-Reply-To: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

module_object_class_by_name() handles loading the module providing the
requested object.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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
index e289ef5f66..eaf7838bfe 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -266,8 +266,6 @@ extern const struct mixeng_volume nominal_volume;
 
 extern const char *audio_prio_list[];
 
-void audio_driver_register(audio_driver *drv);
-
 void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as);
 void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len);
 
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index c28ee05b93..1056bdd63d 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -984,7 +984,6 @@ static const TypeInfo audio_alsa_info = {
 
 static void register_audio_alsa(void)
 {
-    audio_driver_register(&alsa_audio_driver);
     type_register_static(&audio_alsa_info);
 }
 type_init(register_audio_alsa);
diff --git a/audio/audio.c b/audio/audio.c
index 31459f9707..8523f14daa 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -67,40 +67,21 @@ const char *audio_prio_list[] = {
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
@@ -1765,7 +1746,7 @@ static const VMStateDescription vmstate_audio = {
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
index edd551a80f..187da7fa65 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -749,7 +749,6 @@ static const TypeInfo audio_dbus_info = {
 
 static void register_audio_dbus(void)
 {
-    audio_driver_register(&dbus_audio_driver);
     type_register_static(&audio_dbus_info);
 }
 type_init(register_audio_dbus);
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 341df9e6d8..9c6ff93022 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -730,7 +730,6 @@ static const TypeInfo audio_dsound_info = {
 
 static void register_audio_dsound(void)
 {
-    audio_driver_register(&dsound_audio_driver);
     type_register_static(&audio_dsound_info);
 }
 type_init(register_audio_dsound);
diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index 7706fbcb6e..d472f4e5c6 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -728,7 +728,6 @@ static const TypeInfo audio_jack_info = {
 static void register_audio_jack(void)
 {
     qemu_mutex_init(&qjack_shutdown_lock);
-    audio_driver_register(&jack_driver);
     type_register_static(&audio_jack_info);
 #if !defined(WIN32) && defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
     jack_set_thread_creator(qjack_thread_creator);
diff --git a/audio/noaudio.c b/audio/noaudio.c
index 6f5af23004..b788bc5f8e 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -174,7 +174,6 @@ static const TypeInfo audio_none_info = {
 
 static void register_audio_none(void)
 {
-    audio_driver_register(&no_audio_driver);
     type_register_static(&audio_none_info);
 }
 type_init(register_audio_none);
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index f5ce04928a..60aff632a6 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -808,7 +808,6 @@ static const TypeInfo audio_oss_info = {
 
 static void register_audio_oss(void)
 {
-    audio_driver_register(&oss_audio_driver);
     type_register_static(&audio_oss_info);
 }
 type_init(register_audio_oss);
diff --git a/audio/paaudio.c b/audio/paaudio.c
index abeb2c2d81..02fb29cb2f 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -967,7 +967,6 @@ static const TypeInfo audio_pa_info = {
 
 static void register_audio_pa(void)
 {
-    audio_driver_register(&pa_audio_driver);
     type_register_static(&audio_pa_info);
 }
 type_init(register_audio_pa);
diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index 5b51a933ae..c42f81b820 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -884,7 +884,6 @@ static const TypeInfo audio_pw_info = {
 static void
 register_audio_pw(void)
 {
-    audio_driver_register(&pw_audio_driver);
     type_register_static(&audio_pw_info);
 }
 
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index 65fab1427e..e52616bec8 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -527,7 +527,6 @@ static const TypeInfo audio_sdl_info = {
 
 static void register_audio_sdl(void)
 {
-    audio_driver_register(&sdl_audio_driver);
     type_register_static(&audio_sdl_info);
 }
 type_init(register_audio_sdl);
diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
index 1a4912fb60..c1468ef2b9 100644
--- a/audio/sndioaudio.c
+++ b/audio/sndioaudio.c
@@ -591,7 +591,6 @@ static const TypeInfo audio_sndio_info = {
 
 static void register_audio_sndio(void)
 {
-    audio_driver_register(&sndio_audio_driver);
     type_register_static(&audio_sndio_info);
 }
 
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index d8451d5877..1165f88400 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -361,7 +361,6 @@ static const TypeInfo audio_spice_info = {
 
 static void register_audio_spice(void)
 {
-    audio_driver_register(&spice_audio_driver);
     type_register_static(&audio_spice_info);
 }
 type_init(register_audio_spice);
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 3c1f352f11..dbf0e8e00c 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -250,7 +250,6 @@ static const TypeInfo audio_wav_info = {
 
 static void register_audio_wav(void)
 {
-    audio_driver_register(&wav_audio_driver);
     type_register_static(&audio_wav_info);
 }
 type_init(register_audio_wav);
diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index d1a837f4bc..9e4266ee97 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -709,7 +709,6 @@ static void coreaudio_audio_fini (void *opaque)
 
 static void register_audio_coreaudio(void)
 {
-    audio_driver_register(&coreaudio_audio_driver);
     type_register_static(&audio_coreaudio_info);
 }
 type_init(register_audio_coreaudio);
-- 
2.51.1


