Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BEB7D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 11:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ217-0000nS-49; Mon, 01 Dec 2025 06:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ211-0000We-U8
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:24:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ20z-0006Zm-2b
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764588260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sJXOX2dGJoTMX57FacN+pymYbcqx6Y8biS2WWz387cE=;
 b=Y5ex0NCo4cdWhTnnqHi+mwpsfHqFlcsv7lJZWiuzvkaJNEtRtdXEk8ihjC27NaXC0k2iev
 M1dJVmGuVQCchtMVLKBZyITOWw/mY52DV/2hPffegDhEwFskINU+RIi9aw8IZ48qSC2Vli
 px5Ry8McVv7M6XUFZHCGy7SmksOhDbc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-k0f0MMcJOQqQ0T9XeZ_vvA-1; Mon,
 01 Dec 2025 06:24:15 -0500
X-MC-Unique: k0f0MMcJOQqQ0T9XeZ_vvA-1
X-Mimecast-MFC-AGG-ID: k0f0MMcJOQqQ0T9XeZ_vvA_1764588253
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E71C1955BCC; Mon,  1 Dec 2025 11:24:09 +0000 (UTC)
Received: from localhost (unknown [10.45.242.40])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0465B18008CC; Mon,  1 Dec 2025 11:24:06 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [RFC 08/24] audio: add QOM module-objects for each backend
Date: Mon,  1 Dec 2025 15:22:49 +0400
Message-ID: <20251201112309.4163921-9-marcandre.lureau@redhat.com>
In-Reply-To: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

This will allow to use QOM and the dynamic object module loading.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_int.h   |  2 ++
 audio/alsaaudio.c   | 39 +++++++++++++++++++++++++++++++++++++++
 audio/dbusaudio.c   | 36 ++++++++++++++++++++++++++++++++++++
 audio/dsoundaudio.c | 36 ++++++++++++++++++++++++++++++++++++
 audio/jackaudio.c   | 36 ++++++++++++++++++++++++++++++++++++
 audio/noaudio.c     | 36 ++++++++++++++++++++++++++++++++++++
 audio/ossaudio.c    | 36 ++++++++++++++++++++++++++++++++++++
 audio/paaudio.c     | 36 ++++++++++++++++++++++++++++++++++++
 audio/pwaudio.c     | 36 ++++++++++++++++++++++++++++++++++++
 audio/sdlaudio.c    | 36 ++++++++++++++++++++++++++++++++++++
 audio/sndioaudio.c  | 36 ++++++++++++++++++++++++++++++++++++
 audio/spiceaudio.c  | 36 ++++++++++++++++++++++++++++++++++++
 audio/wavaudio.c    | 36 ++++++++++++++++++++++++++++++++++++
 audio/coreaudio.m   | 36 ++++++++++++++++++++++++++++++++++++
 14 files changed, 473 insertions(+)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index e1f962875f..44e63318e8 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -243,6 +243,8 @@ struct SWVoiceCap {
 
 struct AudioDriverClass {
     AudioBackendClass parent_class;
+
+    audio_driver *driver;
 };
 
 struct AudioDriver {
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 278c74c5de..c28ee05b93 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -27,6 +27,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/audio.h"
+#include "qom/object.h"
 #include "trace.h"
 
 #pragma GCC diagnostic ignored "-Waddress"
@@ -36,6 +37,32 @@
 
 #define DEBUG_ALSA 0
 
+#define TYPE_AUDIO_ALSA "audio-alsa"
+OBJECT_DECLARE_TYPE(AudioALSA, AudioBEDriverClass, AUDIO_ALSA)
+
+struct AudioALSA {
+    AudioDriver parent;
+};
+
+static struct audio_driver alsa_audio_driver;
+
+static void audio_alsa_class_init(ObjectClass *klass, const void *data)
+{
+    AudioDriverClass *k = AUDIO_DRIVER_CLASS(klass);
+
+    k->driver = &alsa_audio_driver;
+}
+
+static void audio_alsa_init(Object *obj)
+{
+
+}
+
+static void audio_alsa_finalize(Object *obj)
+{
+
+}
+
 struct pollhlp {
     snd_pcm_t *handle;
     struct pollfd *pfds;
@@ -945,8 +972,20 @@ static struct audio_driver alsa_audio_driver = {
     .voice_size_in  = sizeof (ALSAVoiceIn)
 };
 
+static const TypeInfo audio_alsa_info = {
+    .name = TYPE_AUDIO_ALSA,
+    .parent = TYPE_AUDIO_DRIVER,
+    .instance_size = sizeof(AudioALSA),
+    .instance_init = audio_alsa_init,
+    .instance_finalize = audio_alsa_finalize,
+    .class_init = audio_alsa_class_init,
+};
+
+
 static void register_audio_alsa(void)
 {
     audio_driver_register(&alsa_audio_driver);
+    type_register_static(&audio_alsa_info);
 }
 type_init(register_audio_alsa);
+module_obj(TYPE_AUDIO_ALSA);
diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index 71b2a6c2cf..f0b17be6e8 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -26,6 +26,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/dbus.h"
+#include "qom/object.h"
 
 #ifdef G_OS_UNIX
 #include <gio/gunixfdlist.h>
@@ -44,6 +45,30 @@
 
 #define DBUS_DEFAULT_AUDIO_NSAMPLES 480
 
+#define TYPE_AUDIO_DBUS "audio-dbus"
+OBJECT_DECLARE_TYPE(AudioDbus, AudioDriverClass, AUDIO_DBUS)
+
+struct AudioDbus {
+    AudioDriver parent;
+};
+
+static struct audio_driver dbus_audio_driver;
+
+static void audio_dbus_class_init(ObjectClass *klass, const void *data)
+{
+    AudioDriverClass *k = AUDIO_DRIVER_CLASS(klass);
+
+    k->driver = &dbus_audio_driver;
+}
+
+static void audio_dbus_init(Object *obj)
+{
+}
+
+static void audio_dbus_finalize(Object *obj)
+{
+}
+
 typedef struct DBusAudio {
     Audiodev *dev;
     GDBusObjectManagerServer *server;
@@ -711,10 +736,21 @@ static struct audio_driver dbus_audio_driver = {
     .voice_size_in   = sizeof(DBusVoiceIn)
 };
 
+static const TypeInfo audio_dbus_info = {
+    .name = TYPE_AUDIO_DBUS,
+    .parent = TYPE_AUDIO_DRIVER,
+    .instance_size = sizeof(AudioDbus),
+    .instance_init = audio_dbus_init,
+    .instance_finalize = audio_dbus_finalize,
+    .class_init = audio_dbus_class_init,
+};
+
 static void register_audio_dbus(void)
 {
     audio_driver_register(&dbus_audio_driver);
+    type_register_static(&audio_dbus_info);
 }
 type_init(register_audio_dbus);
 
 module_dep("ui-dbus")
+module_obj(TYPE_AUDIO_DBUS)
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 7a03d1dad8..341df9e6d8 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -33,6 +33,7 @@
 #include "audio_int.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
+#include "qom/object.h"
 
 #include <windows.h>
 #include <mmsystem.h>
@@ -41,6 +42,30 @@
 
 #include "audio_win_int.h"
 
+#define TYPE_AUDIO_DSOUND "audio-dsound"
+OBJECT_DECLARE_TYPE(AudioDsound, AudioDriverClass, AUDIO_DSOUND)
+
+struct AudioDsound {
+    AudioDriver parent;
+};
+
+static struct audio_driver dsound_audio_driver;
+
+static void audio_dsound_class_init(ObjectClass *klass, const void *data)
+{
+    AudioDriverClass *k = AUDIO_DRIVER_CLASS(klass);
+
+    k->driver = &dsound_audio_driver;
+}
+
+static void audio_dsound_init(Object *obj)
+{
+}
+
+static void audio_dsound_finalize(Object *obj)
+{
+}
+
 /* #define DEBUG_DSOUND */
 
 typedef struct {
@@ -694,8 +719,19 @@ static struct audio_driver dsound_audio_driver = {
     .voice_size_in  = sizeof (DSoundVoiceIn)
 };
 
+static const TypeInfo audio_dsound_info = {
+    .name = TYPE_AUDIO_DSOUND,
+    .parent = TYPE_AUDIO_DRIVER,
+    .instance_size = sizeof(AudioDsound),
+    .instance_init = audio_dsound_init,
+    .instance_finalize = audio_dsound_finalize,
+    .class_init = audio_dsound_class_init,
+};
+
 static void register_audio_dsound(void)
 {
     audio_driver_register(&dsound_audio_driver);
+    type_register_static(&audio_dsound_info);
 }
 type_init(register_audio_dsound);
+module_obj(TYPE_AUDIO_DSOUND);
diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index 7a3fcaedba..7706fbcb6e 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -27,6 +27,7 @@
 #include "qemu/atomic.h"
 #include "qemu/main-loop.h"
 #include "qemu/audio.h"
+#include "qom/object.h"
 
 #define AUDIO_CAP "jack"
 #include "audio_int.h"
@@ -34,6 +35,30 @@
 #include <jack/jack.h>
 #include <jack/thread.h>
 
+#define TYPE_AUDIO_JACK "audio-jack"
+OBJECT_DECLARE_TYPE(AudioJack, AudioDriverClass, AUDIO_JACK)
+
+struct AudioJack {
+    AudioDriver parent;
+};
+
+static struct audio_driver jack_driver;
+
+static void audio_jack_class_init(ObjectClass *klass, const void *data)
+{
+    AudioDriverClass *k = AUDIO_DRIVER_CLASS(klass);
+
+    k->driver = &jack_driver;
+}
+
+static void audio_jack_init(Object *obj)
+{
+}
+
+static void audio_jack_finalize(Object *obj)
+{
+}
+
 struct QJack;
 
 typedef enum QJackState {
@@ -691,10 +716,20 @@ static void qjack_info(const char *msg)
     dolog("I: %s\n", msg);
 }
 
+static const TypeInfo audio_jack_info = {
+    .name = TYPE_AUDIO_JACK,
+    .parent = TYPE_AUDIO_DRIVER,
+    .instance_size = sizeof(AudioJack),
+    .instance_init = audio_jack_init,
+    .instance_finalize = audio_jack_finalize,
+    .class_init = audio_jack_class_init,
+};
+
 static void register_audio_jack(void)
 {
     qemu_mutex_init(&qjack_shutdown_lock);
     audio_driver_register(&jack_driver);
+    type_register_static(&audio_jack_info);
 #if !defined(WIN32) && defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
     jack_set_thread_creator(qjack_thread_creator);
 #endif
@@ -702,3 +737,4 @@ static void register_audio_jack(void)
     jack_set_info_function(qjack_info);
 }
 type_init(register_audio_jack);
+module_obj(TYPE_AUDIO_JACK);
diff --git a/audio/noaudio.c b/audio/noaudio.c
index 4ed9d2156c..6f5af23004 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -25,10 +25,35 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qemu/audio.h"
+#include "qom/object.h"
 
 #define AUDIO_CAP "noaudio"
 #include "audio_int.h"
 
+#define TYPE_AUDIO_NONE "audio-none"
+OBJECT_DECLARE_TYPE(AudioNone, AudioDriverClass, AUDIO_NONE)
+
+struct AudioNone {
+    AudioDriver parent;
+};
+
+static struct audio_driver no_audio_driver;
+
+static void audio_none_class_init(ObjectClass *klass, const void *data)
+{
+    AudioDriverClass *k = AUDIO_DRIVER_CLASS(klass);
+
+    k->driver = &no_audio_driver;
+}
+
+static void audio_none_init(Object *obj)
+{
+}
+
+static void audio_none_finalize(Object *obj)
+{
+}
+
 typedef struct NoVoiceOut {
     HWVoiceOut hw;
     RateCtl rate;
@@ -138,8 +163,19 @@ static struct audio_driver no_audio_driver = {
     .voice_size_in  = sizeof (NoVoiceIn)
 };
 
+static const TypeInfo audio_none_info = {
+    .name = TYPE_AUDIO_NONE,
+    .parent = TYPE_AUDIO_DRIVER,
+    .instance_size = sizeof(AudioNone),
+    .instance_init = audio_none_init,
+    .instance_finalize = audio_none_finalize,
+    .class_init = audio_none_class_init,
+};
+
 static void register_audio_none(void)
 {
     audio_driver_register(&no_audio_driver);
+    type_register_static(&audio_none_info);
 }
 type_init(register_audio_none);
+module_obj(TYPE_AUDIO_NONE);
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 9576cdba51..f5ce04928a 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -30,11 +30,36 @@
 #include "qemu/host-utils.h"
 #include "qapi/error.h"
 #include "qemu/audio.h"
+#include "qom/object.h"
 #include "trace.h"
 
 #define AUDIO_CAP "oss"
 #include "audio_int.h"
 
+#define TYPE_AUDIO_OSS "audio-oss"
+OBJECT_DECLARE_TYPE(AudioOss, AudioDriverClass, AUDIO_OSS)
+
+struct AudioOss {
+    AudioDriver parent;
+};
+
+static struct audio_driver oss_audio_driver;
+
+static void audio_oss_class_init(ObjectClass *klass, const void *data)
+{
+    AudioDriverClass *k = AUDIO_DRIVER_CLASS(klass);
+
+    k->driver = &oss_audio_driver;
+}
+
+static void audio_oss_init(Object *obj)
+{
+}
+
+static void audio_oss_finalize(Object *obj)
+{
+}
+
 #if defined OSS_GETVERSION && defined SNDCTL_DSP_POLICY
 #define USE_DSP_POLICY
 #endif
@@ -772,8 +797,19 @@ static struct audio_driver oss_audio_driver = {
     .voice_size_in  = sizeof (OSSVoiceIn)
 };
 
+static const TypeInfo audio_oss_info = {
+    .name = TYPE_AUDIO_OSS,
+    .parent = TYPE_AUDIO_DRIVER,
+    .instance_size = sizeof(AudioOss),
+    .instance_init = audio_oss_init,
+    .instance_finalize = audio_oss_finalize,
+    .class_init = audio_oss_class_init,
+};
+
 static void register_audio_oss(void)
 {
     audio_driver_register(&oss_audio_driver);
+    type_register_static(&audio_oss_info);
 }
 type_init(register_audio_oss);
+module_obj(TYPE_AUDIO_OSS);
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 0c06a39719..abeb2c2d81 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -4,12 +4,37 @@
 #include "qemu/module.h"
 #include "qemu/audio.h"
 #include "qapi/error.h"
+#include "qom/object.h"
 
 #include <pulse/pulseaudio.h>
 
 #define AUDIO_CAP "pulseaudio"
 #include "audio_int.h"
 
+#define TYPE_AUDIO_PA "audio-pa"
+OBJECT_DECLARE_TYPE(AudioPa, AudioDriverClass, AUDIO_PA)
+
+struct AudioPa {
+    AudioDriver parent;
+};
+
+static struct audio_driver pa_audio_driver;
+
+static void audio_pa_class_init(ObjectClass *klass, const void *data)
+{
+    AudioDriverClass *k = AUDIO_DRIVER_CLASS(klass);
+
+    k->driver = &pa_audio_driver;
+}
+
+static void audio_pa_init(Object *obj)
+{
+}
+
+static void audio_pa_finalize(Object *obj)
+{
+}
+
 typedef struct PAConnection {
     char *server;
     int refcount;
@@ -931,8 +956,19 @@ static struct audio_driver pa_audio_driver = {
     .voice_size_in  = sizeof (PAVoiceIn),
 };
 
+static const TypeInfo audio_pa_info = {
+    .name = TYPE_AUDIO_PA,
+    .parent = TYPE_AUDIO_DRIVER,
+    .instance_size = sizeof(AudioPa),
+    .instance_init = audio_pa_init,
+    .instance_finalize = audio_pa_finalize,
+    .class_init = audio_pa_class_init,
+};
+
 static void register_audio_pa(void)
 {
     audio_driver_register(&pa_audio_driver);
+    type_register_static(&audio_pa_info);
 }
 type_init(register_audio_pa);
+module_obj(TYPE_AUDIO_PA);
diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index 30f717ccac..5b51a933ae 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -13,6 +13,7 @@
 #include "qemu/audio.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qom/object.h"
 #include <spa/param/audio/format-utils.h>
 #include <spa/utils/ringbuffer.h>
 #include <spa/utils/result.h>
@@ -27,6 +28,30 @@
 
 #include "audio_int.h"
 
+#define TYPE_AUDIO_PW "audio-pipewire"
+OBJECT_DECLARE_TYPE(AudioPw, AudioDriverClass, AUDIO_PW)
+
+struct AudioPw {
+    AudioDriver parent;
+};
+
+static struct audio_driver pw_audio_driver;
+
+static void audio_pw_class_init(ObjectClass *klass, const void *data)
+{
+    AudioDriverClass *k = AUDIO_DRIVER_CLASS(klass);
+
+    k->driver = &pw_audio_driver;
+}
+
+static void audio_pw_init(Object *obj)
+{
+}
+
+static void audio_pw_finalize(Object *obj)
+{
+}
+
 typedef struct pwvolume {
     uint32_t channels;
     float values[SPA_AUDIO_MAX_CHANNELS];
@@ -847,10 +872,21 @@ static struct audio_driver pw_audio_driver = {
     .voice_size_in = sizeof(PWVoiceIn),
 };
 
+static const TypeInfo audio_pw_info = {
+    .name = TYPE_AUDIO_PW,
+    .parent = TYPE_AUDIO_DRIVER,
+    .instance_size = sizeof(AudioPw),
+    .instance_init = audio_pw_init,
+    .instance_finalize = audio_pw_finalize,
+    .class_init = audio_pw_class_init,
+};
+
 static void
 register_audio_pw(void)
 {
     audio_driver_register(&pw_audio_driver);
+    type_register_static(&audio_pw_info);
 }
 
 type_init(register_audio_pw);
+module_obj(TYPE_AUDIO_PW);
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index 707110973a..65fab1427e 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -28,6 +28,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "qemu/audio.h"
+#include "qom/object.h"
 
 #ifndef _WIN32
 #ifdef __sun__
@@ -40,6 +41,30 @@
 #define AUDIO_CAP "sdl"
 #include "audio_int.h"
 
+#define TYPE_AUDIO_SDL "audio-sdl"
+OBJECT_DECLARE_TYPE(AudioSdl, AudioDriverClass, AUDIO_SDL)
+
+struct AudioSdl {
+    AudioDriver parent;
+};
+
+static struct audio_driver sdl_audio_driver;
+
+static void audio_sdl_class_init(ObjectClass *klass, const void *data)
+{
+    AudioDriverClass *k = AUDIO_DRIVER_CLASS(klass);
+
+    k->driver = &sdl_audio_driver;
+}
+
+static void audio_sdl_init(Object *obj)
+{
+}
+
+static void audio_sdl_finalize(Object *obj)
+{
+}
+
 typedef struct SDLVoiceOut {
     HWVoiceOut hw;
     int exit;
@@ -491,8 +516,19 @@ static struct audio_driver sdl_audio_driver = {
     .voice_size_in  = sizeof(SDLVoiceIn),
 };
 
+static const TypeInfo audio_sdl_info = {
+    .name = TYPE_AUDIO_SDL,
+    .parent = TYPE_AUDIO_DRIVER,
+    .instance_size = sizeof(AudioSdl),
+    .instance_init = audio_sdl_init,
+    .instance_finalize = audio_sdl_finalize,
+    .class_init = audio_sdl_class_init,
+};
+
 static void register_audio_sdl(void)
 {
     audio_driver_register(&sdl_audio_driver);
+    type_register_static(&audio_sdl_info);
 }
 type_init(register_audio_sdl);
+module_obj(TYPE_AUDIO_SDL);
diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
index 8197b8b0b4..1a4912fb60 100644
--- a/audio/sndioaudio.c
+++ b/audio/sndioaudio.c
@@ -20,10 +20,35 @@
 #include "qemu/main-loop.h"
 #include "qemu/audio.h"
 #include "trace.h"
+#include "qom/object.h"
 
 #define AUDIO_CAP "sndio"
 #include "audio_int.h"
 
+#define TYPE_AUDIO_SNDIO "audio-sndio"
+OBJECT_DECLARE_TYPE(AudioSndio, AudioDriverClass, AUDIO_SNDIO)
+
+struct AudioSndio {
+    AudioDriver parent;
+};
+
+static struct audio_driver sndio_audio_driver;
+
+static void audio_sndio_class_init(ObjectClass *klass, const void *data)
+{
+    AudioDriverClass *k = AUDIO_DRIVER_CLASS(klass);
+
+    k->driver = &sndio_audio_driver;
+}
+
+static void audio_sndio_init(Object *obj)
+{
+}
+
+static void audio_sndio_finalize(Object *obj)
+{
+}
+
 /* default latency in microseconds if no option is set */
 #define SNDIO_LATENCY_US   50000
 
@@ -555,9 +580,20 @@ static struct audio_driver sndio_audio_driver = {
     .voice_size_in  = sizeof(SndioVoice)
 };
 
+static const TypeInfo audio_sndio_info = {
+    .name = TYPE_AUDIO_SNDIO,
+    .parent = TYPE_AUDIO_DRIVER,
+    .instance_size = sizeof(AudioSndio),
+    .instance_init = audio_sndio_init,
+    .instance_finalize = audio_sndio_finalize,
+    .class_init = audio_sndio_class_init,
+};
+
 static void register_audio_sndio(void)
 {
     audio_driver_register(&sndio_audio_driver);
+    type_register_static(&audio_sndio_info);
 }
 
 type_init(register_audio_sndio);
+module_obj(TYPE_AUDIO_SNDIO);
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 7db2d1f0df..d8451d5877 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -24,11 +24,36 @@
 #include "qemu/timer.h"
 #include "qapi/error.h"
 #include "ui/qemu-spice.h"
+#include "qom/object.h"
 
 #define AUDIO_CAP "spice"
 #include "qemu/audio.h"
 #include "audio_int.h"
 
+#define TYPE_AUDIO_SPICE "audio-spice"
+OBJECT_DECLARE_TYPE(AudioSpice, AudioDriverClass, AUDIO_SPICE)
+
+struct AudioSpice {
+    AudioDriver parent;
+};
+
+static struct audio_driver spice_audio_driver;
+
+static void audio_spice_class_init(ObjectClass *klass, const void *data)
+{
+    AudioDriverClass *k = AUDIO_DRIVER_CLASS(klass);
+
+    k->driver = &spice_audio_driver;
+}
+
+static void audio_spice_init(Object *obj)
+{
+}
+
+static void audio_spice_finalize(Object *obj)
+{
+}
+
 #if SPICE_INTERFACE_PLAYBACK_MAJOR > 1 || SPICE_INTERFACE_PLAYBACK_MINOR >= 3
 #define LINE_OUT_SAMPLES (480 * 4)
 #else
@@ -325,10 +350,21 @@ static struct audio_driver spice_audio_driver = {
     .voice_size_in  = sizeof (SpiceVoiceIn),
 };
 
+static const TypeInfo audio_spice_info = {
+    .name = TYPE_AUDIO_SPICE,
+    .parent = TYPE_AUDIO_DRIVER,
+    .instance_size = sizeof(AudioSpice),
+    .instance_init = audio_spice_init,
+    .instance_finalize = audio_spice_finalize,
+    .class_init = audio_spice_class_init,
+};
+
 static void register_audio_spice(void)
 {
     audio_driver_register(&spice_audio_driver);
+    type_register_static(&audio_spice_info);
 }
 type_init(register_audio_spice);
+module_obj(TYPE_AUDIO_SPICE);
 
 module_dep("ui-spice-core");
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 46460a5d57..3c1f352f11 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -25,10 +25,35 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qemu/audio.h"
+#include "qom/object.h"
 
 #define AUDIO_CAP "wav"
 #include "audio_int.h"
 
+#define TYPE_AUDIO_WAV "audio-wav"
+OBJECT_DECLARE_TYPE(AudioWav, AudioDriverClass, AUDIO_WAV)
+
+struct AudioWav {
+    AudioDriver parent;
+};
+
+static struct audio_driver wav_audio_driver;
+
+static void audio_wav_class_init(ObjectClass *klass, const void *data)
+{
+    AudioDriverClass *k = AUDIO_DRIVER_CLASS(klass);
+
+    k->driver = &wav_audio_driver;
+}
+
+static void audio_wav_init(Object *obj)
+{
+}
+
+static void audio_wav_finalize(Object *obj)
+{
+}
+
 typedef struct WAVVoiceOut {
     HWVoiceOut hw;
     FILE *f;
@@ -214,8 +239,19 @@ static struct audio_driver wav_audio_driver = {
     .voice_size_in  = 0
 };
 
+static const TypeInfo audio_wav_info = {
+    .name = TYPE_AUDIO_WAV,
+    .parent = TYPE_AUDIO_DRIVER,
+    .instance_size = sizeof(AudioWav),
+    .instance_init = audio_wav_init,
+    .instance_finalize = audio_wav_finalize,
+    .class_init = audio_wav_class_init,
+};
+
 static void register_audio_wav(void)
 {
     audio_driver_register(&wav_audio_driver);
+    type_register_static(&audio_wav_info);
 }
 type_init(register_audio_wav);
+module_obj(TYPE_AUDIO_WAV);
diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index 997017a1e9..d1a837f4bc 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -29,10 +29,35 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/audio.h"
+#include "qom/object.h"
 
 #define AUDIO_CAP "coreaudio"
 #include "audio_int.h"
 
+#define TYPE_AUDIO_COREAUDIO "audio-coreaudio"
+OBJECT_DECLARE_TYPE(AudioCoreaudio, AudioDriverClass, AUDIO_COREAUDIO)
+
+struct AudioCoreaudio {
+    AudioDriver parent;
+};
+
+static struct audio_driver coreaudio_audio_driver;
+
+static void audio_coreaudio_class_init(ObjectClass *klass, const void *data)
+{
+    AudioDriverClass *k = AUDIO_DRIVER_CLASS(klass);
+
+    k->driver = &coreaudio_audio_driver;
+}
+
+static void audio_coreaudio_init(Object *obj)
+{
+}
+
+static void audio_coreaudio_finalize(Object *obj)
+{
+}
+
 typedef struct coreaudioVoiceOut {
     HWVoiceOut hw;
     pthread_mutex_t buf_mutex;
@@ -673,8 +698,19 @@ static void coreaudio_audio_fini (void *opaque)
     .voice_size_in  = 0
 };
 
+static const TypeInfo audio_coreaudio_info = {
+    .name = TYPE_AUDIO_COREAUDIO,
+    .parent = TYPE_AUDIO_DRIVER,
+    .instance_size = sizeof(AudioCoreaudio),
+    .instance_init = audio_coreaudio_init,
+    .instance_finalize = audio_coreaudio_finalize,
+    .class_init = audio_coreaudio_class_init,
+};
+
 static void register_audio_coreaudio(void)
 {
     audio_driver_register(&coreaudio_audio_driver);
+    type_register_static(&audio_coreaudio_info);
 }
 type_init(register_audio_coreaudio);
+module_obj(TYPE_AUDIO_COREAUDIO);
-- 
2.51.1


