Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA63E7BD9E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwe8-0001ia-4T; Mon, 16 Feb 2026 06:20:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwb6-0005PC-8S
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwax-0007Uw-As
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:16:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C74K2tWVcweB70dhChjxmvQkDVI4wpnqhJGfVEIQrd8=;
 b=C8PdUXr1mLkfYRjz4MyMThTx0Hqo9ZGjGsXJFJHgpfLAvvMuTYWTGgvNy4PM9lSRLKfrXa
 P5aFOaoac4kLPutm/RueGn3FlYlUJqGTRHEkEurmHPaDP61GINLPyDC/FuAR2vGxJJmaFZ
 AlDwHXYICVA052xZRs4NAhT7Fp2utiA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-fsMAzxRkPpSluGQ62iCFzQ-1; Mon,
 16 Feb 2026 06:16:47 -0500
X-MC-Unique: fsMAzxRkPpSluGQ62iCFzQ-1
X-Mimecast-MFC-AGG-ID: fsMAzxRkPpSluGQ62iCFzQ_1771240605
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CBCC1956067; Mon, 16 Feb 2026 11:16:45 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A515A19560A2; Mon, 16 Feb 2026 11:16:44 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:13 +0100
Subject: [PATCH 24/85] audio: add QOM module-objects for each backend
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-24-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=19909;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=smnEjBnrvBGsC98f664QS0l7ipklBxQwt/RhXOMoiw8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxPgmoGCDHhKwkRMtrN3YVWkVdtmJKNibU/O
 y/Z7rSkvSKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8TwAKCRDa6OEJdZac
 5RL7EAC5cGq37SiM8tzzNb41iV3vydFXGj/zWzih5e0dgKaKJ3Wv2+HVTlLq/ZqblY5QiR5WJOF
 IsW0QfOk5JVBEuDAI13TzN3sdmBR6qMfWjqHMJFe5GY414+QbJvrGeXlVclH+8wXWXyyloWvOwj
 nR2nZzpCxP5NJOhr/ZKPIsHWF4+ppMyWOITA06w1x/9vV0w9SVcuDzE50PGVwoZd38AfSMxDycu
 ujaNifwFHlsh1ZlfPOCuNgdtIIXuW6BsNs8IwmsKFNqpRcal8Ys0jTHTfTOfXbRHUGYWINxRtFW
 2nczp7kPynGDRUTy4deIo/wcRcaLz5ltEkUglavZZePD6RWD8N1p5dXgCAo8Mjdi2DUILX94IY5
 Azo9S6sMAdj/1kihumV8ba167YRIVpzc55WNX7lMnxvwYwBhjpApFM5x8XfT+FL41Jxyoscs25V
 7kl0KIC3iQew1QiwGJfjcLVs/HG8c55WE+/Vq+eBYNKhS0RhWQwdbkH/M3iD5HYU0IDDbEQCAKS
 iP6Zz8j178c57x8iZ+4x/ElohdcIBB29L7fYa/XO2tXy/Y2A4y1AKyXCznmU5Ijcq8HnT6vD96S
 AXBoBmNGY1xKF6MovdplBE9y/QpO6gMg0TSP/77XIIxg8lqwJ8XLzKgjvTYVS94u3WH68doXCfd
 IBd82zmdNt1tFmw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This will allow to use QOM and the dynamic object module loading.

The changes are done systematically, introducing an empty instance
structure that will later be filled by state with further refactoring.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/audio_int.h   |  2 ++
 audio/alsaaudio.c   | 27 +++++++++++++++++++++++++++
 audio/dbusaudio.c   | 26 ++++++++++++++++++++++++++
 audio/dsoundaudio.c | 26 ++++++++++++++++++++++++++
 audio/jackaudio.c   | 26 ++++++++++++++++++++++++++
 audio/noaudio.c     | 26 ++++++++++++++++++++++++++
 audio/ossaudio.c    | 26 ++++++++++++++++++++++++++
 audio/paaudio.c     | 26 ++++++++++++++++++++++++++
 audio/pwaudio.c     | 26 ++++++++++++++++++++++++++
 audio/sdlaudio.c    | 26 ++++++++++++++++++++++++++
 audio/sndioaudio.c  | 26 ++++++++++++++++++++++++++
 audio/spiceaudio.c  | 26 ++++++++++++++++++++++++++
 audio/wavaudio.c    | 26 ++++++++++++++++++++++++++
 audio/coreaudio.m   | 26 ++++++++++++++++++++++++++
 14 files changed, 341 insertions(+)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 06f5160e8df..29f5864be69 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -241,6 +241,8 @@ struct SWVoiceCap {
 
 struct AudioMixengBackendClass {
     AudioBackendClass parent_class;
+
+    audio_driver *driver;
 };
 
 struct AudioMixengBackend {
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 814820e2864..ecc22d7c8f9 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -27,6 +27,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/audio.h"
+#include "qom/object.h"
 #include "trace.h"
 
 #pragma GCC diagnostic ignored "-Waddress"
@@ -36,6 +37,22 @@
 
 #define DEBUG_ALSA 0
 
+#define TYPE_AUDIO_ALSA "audio-alsa"
+OBJECT_DECLARE_SIMPLE_TYPE(AudioALSA, AUDIO_ALSA)
+
+struct AudioALSA {
+    AudioMixengBackend parent_obj;
+};
+
+static struct audio_driver alsa_audio_driver;
+
+static void audio_alsa_class_init(ObjectClass *klass, const void *data)
+{
+    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
+
+    k->driver = &alsa_audio_driver;
+}
+
 struct pollhlp {
     snd_pcm_t *handle;
     struct pollfd *pfds;
@@ -945,8 +962,18 @@ static struct audio_driver alsa_audio_driver = {
     .voice_size_in  = sizeof (ALSAVoiceIn)
 };
 
+static const TypeInfo audio_alsa_info = {
+    .name = TYPE_AUDIO_ALSA,
+    .parent = TYPE_AUDIO_MIXENG_BACKEND,
+    .instance_size = sizeof(AudioALSA),
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
index 96d4fa3f471..4d62de6d72c 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -26,6 +26,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/dbus.h"
+#include "qom/object.h"
 
 #ifdef G_OS_UNIX
 #include <gio/gunixfdlist.h>
@@ -44,6 +45,22 @@
 
 #define DBUS_DEFAULT_AUDIO_NSAMPLES 480
 
+#define TYPE_AUDIO_DBUS "audio-dbus"
+OBJECT_DECLARE_SIMPLE_TYPE(AudioDbus, AUDIO_DBUS)
+
+struct AudioDbus {
+    AudioMixengBackend parent_obj;
+};
+
+static struct audio_driver dbus_audio_driver;
+
+static void audio_dbus_class_init(ObjectClass *klass, const void *data)
+{
+    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
+
+    k->driver = &dbus_audio_driver;
+}
+
 typedef struct DBusAudio {
     Audiodev *dev;
     GDBusObjectManagerServer *server;
@@ -711,10 +728,19 @@ static struct audio_driver dbus_audio_driver = {
     .voice_size_in   = sizeof(DBusVoiceIn)
 };
 
+static const TypeInfo audio_dbus_info = {
+    .name = TYPE_AUDIO_DBUS,
+    .parent = TYPE_AUDIO_MIXENG_BACKEND,
+    .instance_size = sizeof(AudioDbus),
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
index 7a03d1dad86..91c83dec742 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -33,6 +33,7 @@
 #include "audio_int.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
+#include "qom/object.h"
 
 #include <windows.h>
 #include <mmsystem.h>
@@ -41,6 +42,22 @@
 
 #include "audio_win_int.h"
 
+#define TYPE_AUDIO_DSOUND "audio-dsound"
+OBJECT_DECLARE_SIMPLE_TYPE(AudioDsound, AUDIO_DSOUND)
+
+struct AudioDsound {
+    AudioMixengBackend parent_obj;
+};
+
+static struct audio_driver dsound_audio_driver;
+
+static void audio_dsound_class_init(ObjectClass *klass, const void *data)
+{
+    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
+
+    k->driver = &dsound_audio_driver;
+}
+
 /* #define DEBUG_DSOUND */
 
 typedef struct {
@@ -694,8 +711,17 @@ static struct audio_driver dsound_audio_driver = {
     .voice_size_in  = sizeof (DSoundVoiceIn)
 };
 
+static const TypeInfo audio_dsound_info = {
+    .name = TYPE_AUDIO_DSOUND,
+    .parent = TYPE_AUDIO_MIXENG_BACKEND,
+    .instance_size = sizeof(AudioDsound),
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
index 7a3fcaedbae..7ed2e91fcc8 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -27,6 +27,7 @@
 #include "qemu/atomic.h"
 #include "qemu/main-loop.h"
 #include "qemu/audio.h"
+#include "qom/object.h"
 
 #define AUDIO_CAP "jack"
 #include "audio_int.h"
@@ -34,6 +35,22 @@
 #include <jack/jack.h>
 #include <jack/thread.h>
 
+#define TYPE_AUDIO_JACK "audio-jack"
+OBJECT_DECLARE_SIMPLE_TYPE(AudioJack, AUDIO_JACK)
+
+struct AudioJack {
+    AudioMixengBackend parent_obj;
+};
+
+static struct audio_driver jack_driver;
+
+static void audio_jack_class_init(ObjectClass *klass, const void *data)
+{
+    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
+
+    k->driver = &jack_driver;
+}
+
 struct QJack;
 
 typedef enum QJackState {
@@ -691,10 +708,18 @@ static void qjack_info(const char *msg)
     dolog("I: %s\n", msg);
 }
 
+static const TypeInfo audio_jack_info = {
+    .name = TYPE_AUDIO_JACK,
+    .parent = TYPE_AUDIO_MIXENG_BACKEND,
+    .instance_size = sizeof(AudioJack),
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
@@ -702,3 +727,4 @@ static void register_audio_jack(void)
     jack_set_info_function(qjack_info);
 }
 type_init(register_audio_jack);
+module_obj(TYPE_AUDIO_JACK);
diff --git a/audio/noaudio.c b/audio/noaudio.c
index 4ed9d2156c5..b3305480013 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -25,10 +25,27 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qemu/audio.h"
+#include "qom/object.h"
 
 #define AUDIO_CAP "noaudio"
 #include "audio_int.h"
 
+#define TYPE_AUDIO_NONE "audio-none"
+OBJECT_DECLARE_SIMPLE_TYPE(AudioNone, AUDIO_NONE)
+
+struct AudioNone {
+    AudioMixengBackend parent_obj;
+};
+
+static struct audio_driver no_audio_driver;
+
+static void audio_none_class_init(ObjectClass *klass, const void *data)
+{
+    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
+
+    k->driver = &no_audio_driver;
+}
+
 typedef struct NoVoiceOut {
     HWVoiceOut hw;
     RateCtl rate;
@@ -138,8 +155,17 @@ static struct audio_driver no_audio_driver = {
     .voice_size_in  = sizeof (NoVoiceIn)
 };
 
+static const TypeInfo audio_none_info = {
+    .name = TYPE_AUDIO_NONE,
+    .parent = TYPE_AUDIO_MIXENG_BACKEND,
+    .instance_size = sizeof(AudioNone),
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
index 6ad20ab1876..9697f4a0beb 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -30,11 +30,28 @@
 #include "qemu/host-utils.h"
 #include "qapi/error.h"
 #include "qemu/audio.h"
+#include "qom/object.h"
 #include "trace.h"
 
 #define AUDIO_CAP "oss"
 #include "audio_int.h"
 
+#define TYPE_AUDIO_OSS "audio-oss"
+OBJECT_DECLARE_SIMPLE_TYPE(AudioOss, AUDIO_OSS)
+
+struct AudioOss {
+    AudioMixengBackend parent_obj;
+};
+
+static struct audio_driver oss_audio_driver;
+
+static void audio_oss_class_init(ObjectClass *klass, const void *data)
+{
+    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
+
+    k->driver = &oss_audio_driver;
+}
+
 #if defined OSS_GETVERSION && defined SNDCTL_DSP_POLICY
 #define USE_DSP_POLICY
 #endif
@@ -772,8 +789,17 @@ static struct audio_driver oss_audio_driver = {
     .voice_size_in  = sizeof (OSSVoiceIn)
 };
 
+static const TypeInfo audio_oss_info = {
+    .name = TYPE_AUDIO_OSS,
+    .parent = TYPE_AUDIO_MIXENG_BACKEND,
+    .instance_size = sizeof(AudioOss),
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
index 0c06a397195..707a6d2fb23 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -4,12 +4,29 @@
 #include "qemu/module.h"
 #include "qemu/audio.h"
 #include "qapi/error.h"
+#include "qom/object.h"
 
 #include <pulse/pulseaudio.h>
 
 #define AUDIO_CAP "pulseaudio"
 #include "audio_int.h"
 
+#define TYPE_AUDIO_PA "audio-pa"
+OBJECT_DECLARE_SIMPLE_TYPE(AudioPa, AUDIO_PA)
+
+struct AudioPa {
+    AudioMixengBackend parent_obj;
+};
+
+static struct audio_driver pa_audio_driver;
+
+static void audio_pa_class_init(ObjectClass *klass, const void *data)
+{
+    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
+
+    k->driver = &pa_audio_driver;
+}
+
 typedef struct PAConnection {
     char *server;
     int refcount;
@@ -931,8 +948,17 @@ static struct audio_driver pa_audio_driver = {
     .voice_size_in  = sizeof (PAVoiceIn),
 };
 
+static const TypeInfo audio_pa_info = {
+    .name = TYPE_AUDIO_PA,
+    .parent = TYPE_AUDIO_MIXENG_BACKEND,
+    .instance_size = sizeof(AudioPa),
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
index 30f717ccacf..31f8899d1ed 100644
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
@@ -27,6 +28,22 @@
 
 #include "audio_int.h"
 
+#define TYPE_AUDIO_PW "audio-pipewire"
+OBJECT_DECLARE_SIMPLE_TYPE(AudioPw, AUDIO_PW)
+
+struct AudioPw {
+    AudioMixengBackend parent_obj;
+};
+
+static struct audio_driver pw_audio_driver;
+
+static void audio_pw_class_init(ObjectClass *klass, const void *data)
+{
+    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
+
+    k->driver = &pw_audio_driver;
+}
+
 typedef struct pwvolume {
     uint32_t channels;
     float values[SPA_AUDIO_MAX_CHANNELS];
@@ -847,10 +864,19 @@ static struct audio_driver pw_audio_driver = {
     .voice_size_in = sizeof(PWVoiceIn),
 };
 
+static const TypeInfo audio_pw_info = {
+    .name = TYPE_AUDIO_PW,
+    .parent = TYPE_AUDIO_MIXENG_BACKEND,
+    .instance_size = sizeof(AudioPw),
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
index 707110973ac..5841e131cc0 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -28,6 +28,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "qemu/audio.h"
+#include "qom/object.h"
 
 #ifndef _WIN32
 #ifdef __sun__
@@ -40,6 +41,22 @@
 #define AUDIO_CAP "sdl"
 #include "audio_int.h"
 
+#define TYPE_AUDIO_SDL "audio-sdl"
+OBJECT_DECLARE_SIMPLE_TYPE(AudioSdl, AUDIO_SDL)
+
+struct AudioSdl {
+    AudioMixengBackend parent_obj;
+};
+
+static struct audio_driver sdl_audio_driver;
+
+static void audio_sdl_class_init(ObjectClass *klass, const void *data)
+{
+    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
+
+    k->driver = &sdl_audio_driver;
+}
+
 typedef struct SDLVoiceOut {
     HWVoiceOut hw;
     int exit;
@@ -491,8 +508,17 @@ static struct audio_driver sdl_audio_driver = {
     .voice_size_in  = sizeof(SDLVoiceIn),
 };
 
+static const TypeInfo audio_sdl_info = {
+    .name = TYPE_AUDIO_SDL,
+    .parent = TYPE_AUDIO_MIXENG_BACKEND,
+    .instance_size = sizeof(AudioSdl),
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
index 8197b8b0b47..7f388b498f6 100644
--- a/audio/sndioaudio.c
+++ b/audio/sndioaudio.c
@@ -20,10 +20,27 @@
 #include "qemu/main-loop.h"
 #include "qemu/audio.h"
 #include "trace.h"
+#include "qom/object.h"
 
 #define AUDIO_CAP "sndio"
 #include "audio_int.h"
 
+#define TYPE_AUDIO_SNDIO "audio-sndio"
+OBJECT_DECLARE_SIMPLE_TYPE(AudioSndio, AUDIO_SNDIO)
+
+struct AudioSndio {
+    AudioMixengBackend parent_obj;
+};
+
+static struct audio_driver sndio_audio_driver;
+
+static void audio_sndio_class_init(ObjectClass *klass, const void *data)
+{
+    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
+
+    k->driver = &sndio_audio_driver;
+}
+
 /* default latency in microseconds if no option is set */
 #define SNDIO_LATENCY_US   50000
 
@@ -555,9 +572,18 @@ static struct audio_driver sndio_audio_driver = {
     .voice_size_in  = sizeof(SndioVoice)
 };
 
+static const TypeInfo audio_sndio_info = {
+    .name = TYPE_AUDIO_SNDIO,
+    .parent = TYPE_AUDIO_MIXENG_BACKEND,
+    .instance_size = sizeof(AudioSndio),
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
index 7db2d1f0dfd..d0bcc0836ad 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -24,11 +24,28 @@
 #include "qemu/timer.h"
 #include "qapi/error.h"
 #include "ui/qemu-spice.h"
+#include "qom/object.h"
 
 #define AUDIO_CAP "spice"
 #include "qemu/audio.h"
 #include "audio_int.h"
 
+#define TYPE_AUDIO_SPICE "audio-spice"
+OBJECT_DECLARE_SIMPLE_TYPE(AudioSpice, AUDIO_SPICE)
+
+struct AudioSpice {
+    AudioMixengBackend parent_obj;
+};
+
+static struct audio_driver spice_audio_driver;
+
+static void audio_spice_class_init(ObjectClass *klass, const void *data)
+{
+    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
+
+    k->driver = &spice_audio_driver;
+}
+
 #if SPICE_INTERFACE_PLAYBACK_MAJOR > 1 || SPICE_INTERFACE_PLAYBACK_MINOR >= 3
 #define LINE_OUT_SAMPLES (480 * 4)
 #else
@@ -325,10 +342,19 @@ static struct audio_driver spice_audio_driver = {
     .voice_size_in  = sizeof (SpiceVoiceIn),
 };
 
+static const TypeInfo audio_spice_info = {
+    .name = TYPE_AUDIO_SPICE,
+    .parent = TYPE_AUDIO_MIXENG_BACKEND,
+    .instance_size = sizeof(AudioSpice),
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
index 46460a5d573..00cf110ecd7 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -25,10 +25,27 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qemu/audio.h"
+#include "qom/object.h"
 
 #define AUDIO_CAP "wav"
 #include "audio_int.h"
 
+#define TYPE_AUDIO_WAV "audio-wav"
+OBJECT_DECLARE_SIMPLE_TYPE(AudioWav, AUDIO_WAV)
+
+struct AudioWav {
+    AudioMixengBackend parent_obj;
+};
+
+static struct audio_driver wav_audio_driver;
+
+static void audio_wav_class_init(ObjectClass *klass, const void *data)
+{
+    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
+
+    k->driver = &wav_audio_driver;
+}
+
 typedef struct WAVVoiceOut {
     HWVoiceOut hw;
     FILE *f;
@@ -214,8 +231,17 @@ static struct audio_driver wav_audio_driver = {
     .voice_size_in  = 0
 };
 
+static const TypeInfo audio_wav_info = {
+    .name = TYPE_AUDIO_WAV,
+    .parent = TYPE_AUDIO_MIXENG_BACKEND,
+    .instance_size = sizeof(AudioWav),
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
index 997017a1e96..61333e9f2f9 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -29,10 +29,27 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/audio.h"
+#include "qom/object.h"
 
 #define AUDIO_CAP "coreaudio"
 #include "audio_int.h"
 
+#define TYPE_AUDIO_COREAUDIO "audio-coreaudio"
+OBJECT_DECLARE_SIMPLE_TYPE(AudioCoreaudio, AUDIO_COREAUDIO)
+
+struct AudioCoreaudio {
+    AudioMixengBackend parent_obj;
+};
+
+static struct audio_driver coreaudio_audio_driver;
+
+static void audio_coreaudio_class_init(ObjectClass *klass, const void *data)
+{
+    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
+
+    k->driver = &coreaudio_audio_driver;
+}
+
 typedef struct coreaudioVoiceOut {
     HWVoiceOut hw;
     pthread_mutex_t buf_mutex;
@@ -673,8 +690,17 @@ static void coreaudio_audio_fini (void *opaque)
     .voice_size_in  = 0
 };
 
+static const TypeInfo audio_coreaudio_info = {
+    .name = TYPE_AUDIO_COREAUDIO,
+    .parent = TYPE_AUDIO_MIXENG_BACKEND,
+    .instance_size = sizeof(AudioCoreaudio),
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
2.53.0


