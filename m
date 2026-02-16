Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728BEE7BD92
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwe4-0001Me-5g; Mon, 16 Feb 2026 06:20:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwbO-0005c9-QE
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwbJ-0007hT-Uv
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0bHWW5dgK+/HJjVU+OAOt9u9O6Cx3FhrDkXc/laulI=;
 b=D9AUBAToeDykvv5IQOg+DEJ9Z4Qg1ldgfY1oR7AVGVTZ29v6ZADKxmTVBFs2oxT/uU3K93
 gF36TUPMVY5QQDgiYIuDoyW9TiYygMwzK6YnuoYZRZZYxlkrZTmB1RDBH7WMtiBx1kZdOs
 ZeVrRQvuOwPawbXDVGxCpujbXyz13Z0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-TVTG2A9MMSOzqy6JBVlDGQ-1; Mon,
 16 Feb 2026 06:17:01 -0500
X-MC-Unique: TVTG2A9MMSOzqy6JBVlDGQ-1
X-Mimecast-MFC-AGG-ID: TVTG2A9MMSOzqy6JBVlDGQ_1771240619
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57EA119560B2; Mon, 16 Feb 2026 11:16:59 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 13AB130001B9; Mon, 16 Feb 2026 11:16:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:18 +0100
Subject: [PATCH 29/85] audio: replace type_init() with DEFINE_TYPES
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-29-e676662e4514@redhat.com>
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
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=12925;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=/OclfmP5XewpxJNnSJDp4/Un0I4vQMcL2p0K7RiWt4g=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxPzq1tH1Qld4toiGW9FYMLYpn54fKwAT0rU
 t4x/7ROkeuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8TwAKCRDa6OEJdZac
 5XZ5D/92BWDs6BYjDg87G45/PgA62LTJsOjfYla3IWwsajkwczYlhI7uPJ5UromLxFIX8caU8hY
 0qcuok4XsErMv0/pP6E7mpiwpnwwdUPPIBZQjTtM6RKte3xpcVFbNqDZ81RE13vrC4sajh4r71+
 Pf7s0lvB5r59HOEW5qxQOlolKDyfHxofNWHdhYH08vwlAg/2fpRl8SCtgZqQ1urSEZgX1WjrQig
 ZytPyiyuc9NY1vgwMCZebFPcA8tCYRVW1LUaYeMswPG2i4VYwUOFhwjYbnKntDk8M4xBOCx1+5f
 w4wHmFYqFAxo0h0KwL9jB9aJpiOf0bQXw6OBZe7EO6y/pM5fwNS2oe1Vr0YVcQgS+aa0CPkVv5C
 w2Wkl2scangyq9W54eKBhu+y2FD96PYVUEBaFGUABj3pMhzADEOsRvzwTNBKgaHpbgC1xACt3FH
 EDpY1BstbEyMR/w97IzuzUdPPdtsd4oFLvkTe4sRVtXz1zxCml5qJbbff5fGbjZnIL5uWZZxn8i
 RmjH0upZzn9bWl+ud5hPXMyId3OJ+OyBIXaqZ8D1boiuVU3Jp2On0u/txT1Ad069DRr+3FOZfvs
 gEJxDqEJpzuLtDQC7dQGQ5VUTkf3Xd8BnLqg9z5E1M5Sx2Jai9jpO0OM/Dvj5lrEpi+q1TzTwqW
 FUG5mus6sXQUtGg==
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

Use the convenience macro to register types.

Note that jack backend was using the type registration to initialize
some globals. Use a ctor function instead.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/alsaaudio.c   | 19 ++++++++-----------
 audio/dbusaudio.c   | 18 ++++++++----------
 audio/dsoundaudio.c | 18 ++++++++----------
 audio/jackaudio.c   | 18 ++++++++++--------
 audio/noaudio.c     | 18 ++++++++----------
 audio/ossaudio.c    | 18 ++++++++----------
 audio/paaudio.c     | 18 ++++++++----------
 audio/pwaudio.c     | 20 ++++++++------------
 audio/sdlaudio.c    | 18 ++++++++----------
 audio/sndioaudio.c  | 19 ++++++++-----------
 audio/spiceaudio.c  | 18 ++++++++----------
 audio/wavaudio.c    | 18 ++++++++----------
 audio/coreaudio.m   | 18 ++++++++----------
 13 files changed, 106 insertions(+), 132 deletions(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 7200777ad82..ae1cec6a36e 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -962,17 +962,14 @@ static struct audio_driver alsa_audio_driver = {
     .voice_size_in  = sizeof (ALSAVoiceIn)
 };
 
-static const TypeInfo audio_alsa_info = {
-    .name = TYPE_AUDIO_ALSA,
-    .parent = TYPE_AUDIO_MIXENG_BACKEND,
-    .instance_size = sizeof(AudioALSA),
-    .class_init = audio_alsa_class_init,
+static const TypeInfo audio_types[] = {
+    {
+        .name = TYPE_AUDIO_ALSA,
+        .parent = TYPE_AUDIO_MIXENG_BACKEND,
+        .instance_size = sizeof(AudioALSA),
+        .class_init = audio_alsa_class_init,
+    },
 };
 
-
-static void register_audio_alsa(void)
-{
-    type_register_static(&audio_alsa_info);
-}
-type_init(register_audio_alsa);
+DEFINE_TYPES(audio_types)
 module_obj(TYPE_AUDIO_ALSA);
diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index 48c9078d80e..269db7877b6 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -729,18 +729,16 @@ static void audio_dbus_class_init(ObjectClass *klass, const void *data)
     k->driver = &dbus_audio_driver;
 }
 
-static const TypeInfo audio_dbus_info = {
-    .name = TYPE_AUDIO_DBUS,
-    .parent = TYPE_AUDIO_MIXENG_BACKEND,
-    .instance_size = sizeof(AudioDbus),
-    .class_init = audio_dbus_class_init,
+static const TypeInfo audio_types[] = {
+    {
+        .name = TYPE_AUDIO_DBUS,
+        .parent = TYPE_AUDIO_MIXENG_BACKEND,
+        .instance_size = sizeof(AudioDbus),
+        .class_init = audio_dbus_class_init,
+    },
 };
 
-static void register_audio_dbus(void)
-{
-    type_register_static(&audio_dbus_info);
-}
-type_init(register_audio_dbus);
+DEFINE_TYPES(audio_types)
 
 module_dep("ui-dbus")
 module_obj(TYPE_AUDIO_DBUS)
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 6d213899660..462d09e02af 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -711,16 +711,14 @@ static struct audio_driver dsound_audio_driver = {
     .voice_size_in  = sizeof (DSoundVoiceIn)
 };
 
-static const TypeInfo audio_dsound_info = {
-    .name = TYPE_AUDIO_DSOUND,
-    .parent = TYPE_AUDIO_MIXENG_BACKEND,
-    .instance_size = sizeof(AudioDsound),
-    .class_init = audio_dsound_class_init,
+static const TypeInfo audio_types[] = {
+    {
+        .name = TYPE_AUDIO_DSOUND,
+        .parent = TYPE_AUDIO_MIXENG_BACKEND,
+        .instance_size = sizeof(AudioDsound),
+        .class_init = audio_dsound_class_init,
+    },
 };
 
-static void register_audio_dsound(void)
-{
-    type_register_static(&audio_dsound_info);
-}
-type_init(register_audio_dsound);
+DEFINE_TYPES(audio_types)
 module_obj(TYPE_AUDIO_DSOUND);
diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index bfce4cb0b4c..972b158f023 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -708,22 +708,24 @@ static void qjack_info(const char *msg)
     dolog("I: %s\n", msg);
 }
 
-static const TypeInfo audio_jack_info = {
-    .name = TYPE_AUDIO_JACK,
-    .parent = TYPE_AUDIO_MIXENG_BACKEND,
-    .instance_size = sizeof(AudioJack),
-    .class_init = audio_jack_class_init,
+static const TypeInfo audio_types[] = {
+    {
+        .name = TYPE_AUDIO_JACK,
+        .parent = TYPE_AUDIO_MIXENG_BACKEND,
+        .instance_size = sizeof(AudioJack),
+        .class_init = audio_jack_class_init,
+    },
 };
 
-static void register_audio_jack(void)
+static void __attribute__((__constructor__)) audio_jack_init(void)
 {
     qemu_mutex_init(&qjack_shutdown_lock);
-    type_register_static(&audio_jack_info);
 #if !defined(WIN32) && defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
     jack_set_thread_creator(qjack_thread_creator);
 #endif
     jack_set_error_function(qjack_error);
     jack_set_info_function(qjack_info);
 }
-type_init(register_audio_jack);
+
+DEFINE_TYPES(audio_types)
 module_obj(TYPE_AUDIO_JACK);
diff --git a/audio/noaudio.c b/audio/noaudio.c
index 8b5ebd71bf6..65679b8b13d 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -155,16 +155,14 @@ static struct audio_driver no_audio_driver = {
     .voice_size_in  = sizeof (NoVoiceIn)
 };
 
-static const TypeInfo audio_none_info = {
-    .name = TYPE_AUDIO_NONE,
-    .parent = TYPE_AUDIO_MIXENG_BACKEND,
-    .instance_size = sizeof(AudioNone),
-    .class_init = audio_none_class_init,
+static const TypeInfo audio_types[] = {
+    {
+        .name = TYPE_AUDIO_NONE,
+        .parent = TYPE_AUDIO_MIXENG_BACKEND,
+        .instance_size = sizeof(AudioNone),
+        .class_init = audio_none_class_init,
+    },
 };
 
-static void register_audio_none(void)
-{
-    type_register_static(&audio_none_info);
-}
-type_init(register_audio_none);
+DEFINE_TYPES(audio_types)
 module_obj(TYPE_AUDIO_NONE);
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index b8e26b17ed7..f64c564e345 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -789,16 +789,14 @@ static struct audio_driver oss_audio_driver = {
     .voice_size_in  = sizeof (OSSVoiceIn)
 };
 
-static const TypeInfo audio_oss_info = {
-    .name = TYPE_AUDIO_OSS,
-    .parent = TYPE_AUDIO_MIXENG_BACKEND,
-    .instance_size = sizeof(AudioOss),
-    .class_init = audio_oss_class_init,
+static const TypeInfo audio_types[] = {
+    {
+        .name = TYPE_AUDIO_OSS,
+        .parent = TYPE_AUDIO_MIXENG_BACKEND,
+        .instance_size = sizeof(AudioOss),
+        .class_init = audio_oss_class_init,
+    },
 };
 
-static void register_audio_oss(void)
-{
-    type_register_static(&audio_oss_info);
-}
-type_init(register_audio_oss);
+DEFINE_TYPES(audio_types)
 module_obj(TYPE_AUDIO_OSS);
diff --git a/audio/paaudio.c b/audio/paaudio.c
index adaeb2af807..331da4f2ed6 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -948,16 +948,14 @@ static struct audio_driver pa_audio_driver = {
     .voice_size_in  = sizeof (PAVoiceIn),
 };
 
-static const TypeInfo audio_pa_info = {
-    .name = TYPE_AUDIO_PA,
-    .parent = TYPE_AUDIO_MIXENG_BACKEND,
-    .instance_size = sizeof(AudioPa),
-    .class_init = audio_pa_class_init,
+static const TypeInfo audio_types[] = {
+    {
+        .name = TYPE_AUDIO_PA,
+        .parent = TYPE_AUDIO_MIXENG_BACKEND,
+        .instance_size = sizeof(AudioPa),
+        .class_init = audio_pa_class_init,
+    },
 };
 
-static void register_audio_pa(void)
-{
-    type_register_static(&audio_pa_info);
-}
-type_init(register_audio_pa);
+DEFINE_TYPES(audio_types)
 module_obj(TYPE_AUDIO_PA);
diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index facd166052c..3b524dfea5a 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -864,18 +864,14 @@ static struct audio_driver pw_audio_driver = {
     .voice_size_in = sizeof(PWVoiceIn),
 };
 
-static const TypeInfo audio_pw_info = {
-    .name = TYPE_AUDIO_PW,
-    .parent = TYPE_AUDIO_MIXENG_BACKEND,
-    .instance_size = sizeof(AudioPw),
-    .class_init = audio_pw_class_init,
+static const TypeInfo audio_types[] = {
+    {
+        .name = TYPE_AUDIO_PW,
+        .parent = TYPE_AUDIO_MIXENG_BACKEND,
+        .instance_size = sizeof(AudioPw),
+        .class_init = audio_pw_class_init,
+    },
 };
 
-static void
-register_audio_pw(void)
-{
-    type_register_static(&audio_pw_info);
-}
-
-type_init(register_audio_pw);
+DEFINE_TYPES(audio_types)
 module_obj(TYPE_AUDIO_PW);
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index c00f1366d17..a60b1629da0 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -508,16 +508,14 @@ static struct audio_driver sdl_audio_driver = {
     .voice_size_in  = sizeof(SDLVoiceIn),
 };
 
-static const TypeInfo audio_sdl_info = {
-    .name = TYPE_AUDIO_SDL,
-    .parent = TYPE_AUDIO_MIXENG_BACKEND,
-    .instance_size = sizeof(AudioSdl),
-    .class_init = audio_sdl_class_init,
+static const TypeInfo audio_types[] = {
+    {
+        .name = TYPE_AUDIO_SDL,
+        .parent = TYPE_AUDIO_MIXENG_BACKEND,
+        .instance_size = sizeof(AudioSdl),
+        .class_init = audio_sdl_class_init,
+    },
 };
 
-static void register_audio_sdl(void)
-{
-    type_register_static(&audio_sdl_info);
-}
-type_init(register_audio_sdl);
+DEFINE_TYPES(audio_types)
 module_obj(TYPE_AUDIO_SDL);
diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
index c8310b1fa37..2a9ae42992b 100644
--- a/audio/sndioaudio.c
+++ b/audio/sndioaudio.c
@@ -572,17 +572,14 @@ static struct audio_driver sndio_audio_driver = {
     .voice_size_in  = sizeof(SndioVoice)
 };
 
-static const TypeInfo audio_sndio_info = {
-    .name = TYPE_AUDIO_SNDIO,
-    .parent = TYPE_AUDIO_MIXENG_BACKEND,
-    .instance_size = sizeof(AudioSndio),
-    .class_init = audio_sndio_class_init,
+static const TypeInfo audio_types[] = {
+    {
+        .name = TYPE_AUDIO_SNDIO,
+        .parent = TYPE_AUDIO_MIXENG_BACKEND,
+        .instance_size = sizeof(AudioSndio),
+        .class_init = audio_sndio_class_init,
+    },
 };
 
-static void register_audio_sndio(void)
-{
-    type_register_static(&audio_sndio_info);
-}
-
-type_init(register_audio_sndio);
+DEFINE_TYPES(audio_types)
 module_obj(TYPE_AUDIO_SNDIO);
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index d1bb318b6b7..ad7cb69673b 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -342,18 +342,16 @@ static struct audio_driver spice_audio_driver = {
     .voice_size_in  = sizeof (SpiceVoiceIn),
 };
 
-static const TypeInfo audio_spice_info = {
-    .name = TYPE_AUDIO_SPICE,
-    .parent = TYPE_AUDIO_MIXENG_BACKEND,
-    .instance_size = sizeof(AudioSpice),
-    .class_init = audio_spice_class_init,
+static const TypeInfo audio_types[] = {
+    {
+        .name = TYPE_AUDIO_SPICE,
+        .parent = TYPE_AUDIO_MIXENG_BACKEND,
+        .instance_size = sizeof(AudioSpice),
+        .class_init = audio_spice_class_init,
+    },
 };
 
-static void register_audio_spice(void)
-{
-    type_register_static(&audio_spice_info);
-}
-type_init(register_audio_spice);
+DEFINE_TYPES(audio_types)
 module_obj(TYPE_AUDIO_SPICE);
 
 module_dep("ui-spice-core");
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 12d4108ffad..cd2ceffd42b 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -231,16 +231,14 @@ static struct audio_driver wav_audio_driver = {
     .voice_size_in  = 0
 };
 
-static const TypeInfo audio_wav_info = {
-    .name = TYPE_AUDIO_WAV,
-    .parent = TYPE_AUDIO_MIXENG_BACKEND,
-    .instance_size = sizeof(AudioWav),
-    .class_init = audio_wav_class_init,
+static const TypeInfo audio_types[] = {
+    {
+        .name = TYPE_AUDIO_WAV,
+        .parent = TYPE_AUDIO_MIXENG_BACKEND,
+        .instance_size = sizeof(AudioWav),
+        .class_init = audio_wav_class_init,
+    }
 };
 
-static void register_audio_wav(void)
-{
-    type_register_static(&audio_wav_info);
-}
-type_init(register_audio_wav);
+DEFINE_TYPES(audio_types)
 module_obj(TYPE_AUDIO_WAV);
diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index 5efd16df7c4..862cb9dd9b0 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -690,16 +690,14 @@ static void coreaudio_audio_fini (void *opaque)
     .voice_size_in  = 0
 };
 
-static const TypeInfo audio_coreaudio_info = {
-    .name = TYPE_AUDIO_COREAUDIO,
-    .parent = TYPE_AUDIO_MIXENG_BACKEND,
-    .instance_size = sizeof(AudioCoreaudio),
-    .class_init = audio_coreaudio_class_init,
+static const TypeInfo audio_types[] = {
+    {
+        .name = TYPE_AUDIO_COREAUDIO,
+        .parent = TYPE_AUDIO_MIXENG_BACKEND,
+        .instance_size = sizeof(AudioCoreaudio),
+        .class_init = audio_coreaudio_class_init,
+    },
 };
 
-static void register_audio_coreaudio(void)
-{
-    type_register_static(&audio_coreaudio_info);
-}
-type_init(register_audio_coreaudio);
+DEFINE_TYPES(audio_types)
 module_obj(TYPE_AUDIO_COREAUDIO);

-- 
2.53.0


