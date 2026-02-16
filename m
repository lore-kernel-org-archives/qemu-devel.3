Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CB5E7BD92
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrweN-0003qH-An; Mon, 16 Feb 2026 06:20:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwbX-0005fs-RG
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwbT-0007tX-H6
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hkWryIjuSHmr0bwEziyOBTp5DFea2r/ueaDp4dOe6mM=;
 b=TknKFMh3eyfMaUna1501g40sELVLpreCCIJ13pUNlwGjgiBEQEaoCHo9pQu2GXoQ+eiRNW
 bpE3IugggMFHEU6CpRkCrH7I0S6noSY0h/5LuMEVGLn37UIINZvVKPUk4PoNWOKkN+4NKL
 8U89TVsedk1wrMC5yauoS4y9eXFRhfM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-UqaeIxcwOYuQUWTFGgcaKg-1; Mon,
 16 Feb 2026 06:17:18 -0500
X-MC-Unique: UqaeIxcwOYuQUWTFGgcaKg-1
X-Mimecast-MFC-AGG-ID: UqaeIxcwOYuQUWTFGgcaKg_1771240636
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 606E11800352; Mon, 16 Feb 2026 11:17:16 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2BB511800465; Mon, 16 Feb 2026 11:17:14 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:24 +0100
Subject: [PATCH 35/85] audio: make AudioBackend truly abstract
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-35-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15723;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=e9fl1yiCeU+X0vumgeQ8TB7z7p3VBLjNMWmpzAK3nek=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxPKcoUc2shWSYxqvj00cb6oQkqtTRvUBIDg
 8taVMCOsQuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8TwAKCRDa6OEJdZac
 5Rj0EACbutn6dNwbp1Is5/qPIpfuAigPYe9YEhIwjV8wfW4EIOy5DxkLmyOjBIxXSTOKlQn4eD6
 vyEPWdhOMJChFR/h+du05m2nyN98Sj9TRdZuniTmxb7P8CfEWY+H4jePXvGS1cxKPHO1nXEHtGv
 7dCIn5AoeERp3V60bTQBjUKZjDbyP7qvHGtgMgyBNk93/mskp/8gKPsTmxfgpWZw99rgzZwe+i8
 lhyEeYS4avvNiKtLteKVMgt1Lk2inCcmE0iP2i1ybrg4/m1RuPgkO4bONUigZiYwasDYLQ1ouTt
 U7n+TPKWWe4XntBk+/vvt3Ql4Y1KTCVL0yVjDqM4kWZaPCckRJ6TXPcfHEXSWMCZuZhwZ/YkOnH
 atThSW0zplyNwrDoy8TbHRMEOxj8tAi3DGAHI3BU24XqRWaOI87DXA0NtYGTiwU99fR1pov5D98
 4UHxHOgxxwqEeY9vjrlEdpgtSruy3/awzXHfFmaekbFIieWvxjPVEK/MFEWbByY6V7k8LV4uZzC
 Ck8NCxKVdOeDC0cGe0nW3pHm7leWNDgfqoTj1VdDw/+xT8bhKqbag/3pqfzf8PtSNqqhdOxneuM
 CgfAa+EYYm8bHwu3JTwqNhGZSbYSEfe86HORl9v5Rcf/TmhSX2s661IvGcRC8/wqiFeSWBz5mkW
 4cSRtupI6Jxilkg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Add virtual methods to be implemented by concrete classes, like
AudioMixengBackendClass.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/audio_template.h       |   9 +--
 include/qemu/audio-capture.h |  13 ---
 include/qemu/audio.h         |  58 +++++++++++---
 audio/audio.c                | 187 ++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 227 insertions(+), 40 deletions(-)

diff --git a/audio/audio_template.h b/audio/audio_template.h
index 33f2ff432eb..a7733f9e1d9 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -478,7 +478,7 @@ static void glue (audio_close_, TYPE) (SW *sw)
     g_free (sw);
 }
 
-void glue(AUD_close_, TYPE)(AudioBackend *be, SW *sw)
+static void glue(audio_mixeng_backend_close_, TYPE)(AudioBackend *be, SW *sw)
 {
     if (sw) {
         if (audio_bug(__func__, !be)) {
@@ -490,14 +490,13 @@ void glue(AUD_close_, TYPE)(AudioBackend *be, SW *sw)
     }
 }
 
-SW *glue (AUD_open_, TYPE) (
+static SW *glue(audio_mixeng_backend_open_, TYPE) (
     AudioBackend *be,
     SW *sw,
     const char *name,
     void *callback_opaque ,
     audio_callback_fn callback_fn,
-    const struct audsettings *as
-    )
+    const struct audsettings *as)
 {
     AudioMixengBackend *s = AUDIO_MIXENG_BACKEND(be);
     AudiodevPerDirectionOptions *pdo;
@@ -569,7 +568,7 @@ SW *glue (AUD_open_, TYPE) (
     return NULL;
 }
 
-bool glue(AUD_is_active_, TYPE)(AudioBackend *be, SW *sw)
+static bool glue(audio_mixeng_backend_is_active_, TYPE)(AudioBackend *be, SW *sw)
 {
     return sw ? sw->active : 0;
 }
diff --git a/include/qemu/audio-capture.h b/include/qemu/audio-capture.h
index f500b0a7f8c..5bfbdd02985 100644
--- a/include/qemu/audio-capture.h
+++ b/include/qemu/audio-capture.h
@@ -8,19 +8,6 @@
 
 #include "audio.h"
 
-typedef struct CaptureVoiceOut CaptureVoiceOut;
-
-typedef enum {
-    AUD_CNOTIFY_ENABLE,
-    AUD_CNOTIFY_DISABLE
-} audcnotification_e;
-
-struct audio_capture_ops {
-    void (*notify) (void *opaque, audcnotification_e cmd);
-    void (*capture) (void *opaque, const void *buf, int size);
-    void (*destroy) (void *opaque);
-};
-
 struct capture_ops {
     void (*info) (void *opaque);
     void (*destroy) (void *opaque);
diff --git a/include/qemu/audio.h b/include/qemu/audio.h
index e87708e3d1e..4fae48886ba 100644
--- a/include/qemu/audio.h
+++ b/include/qemu/audio.h
@@ -43,6 +43,25 @@ typedef struct audsettings {
 
 typedef struct SWVoiceOut SWVoiceOut;
 typedef struct SWVoiceIn SWVoiceIn;
+typedef struct CaptureVoiceOut CaptureVoiceOut;
+
+typedef enum {
+    AUD_CNOTIFY_ENABLE,
+    AUD_CNOTIFY_DISABLE
+} audcnotification_e;
+
+struct audio_capture_ops {
+    void (*notify) (void *opaque, audcnotification_e cmd);
+    void (*capture) (void *opaque, const void *buf, int size);
+    void (*destroy) (void *opaque);
+};
+
+#define AUDIO_MAX_CHANNELS 16
+typedef struct Volume {
+    bool mute;
+    int channels;
+    uint8_t vol[AUDIO_MAX_CHANNELS];
+} Volume;
 
 typedef struct AudioBackend {
     Object parent_obj;
@@ -53,6 +72,35 @@ typedef struct AudioBackendClass {
 
     bool (*realize)(AudioBackend *be, Audiodev *dev, Error **errp);
     const char *(*get_id)(AudioBackend *be);
+    SWVoiceOut *(*open_out)(AudioBackend *be,
+                            SWVoiceOut *sw,
+                            const char *name,
+                            void *callback_opaque,
+                            audio_callback_fn callback_fn,
+                            const struct audsettings *as);
+    SWVoiceIn *(*open_in)(AudioBackend *be,
+                          SWVoiceIn *sw,
+                          const char *name,
+                          void *callback_opaque,
+                          audio_callback_fn callback_fn,
+                          const struct audsettings *as);
+    void (*close_out)(AudioBackend *be, SWVoiceOut *sw);
+    void (*close_in)(AudioBackend *be, SWVoiceIn *sw);
+    bool (*is_active_out)(AudioBackend *be, SWVoiceOut *sw);
+    bool (*is_active_in)(AudioBackend *be, SWVoiceIn *sw);
+    void (*set_active_out)(AudioBackend *be, SWVoiceOut *sw, bool on);
+    void (*set_active_in)(AudioBackend *be, SWVoiceIn *sw, bool on);
+    void (*set_volume_out)(AudioBackend *be, SWVoiceOut *sw, Volume *vol);
+    void (*set_volume_in)(AudioBackend *be, SWVoiceIn *sw, Volume *vol);
+    size_t (*write)(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t size);
+    size_t (*read)(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size);
+    int (*get_buffer_size_out)(AudioBackend *be, SWVoiceOut *sw);
+    CaptureVoiceOut *(*add_capture)(AudioBackend *be,
+                                    struct audsettings *as,
+                                    struct audio_capture_ops *ops,
+                                    void *cb_opaque);
+    void (*del_capture)(AudioBackend *be, CaptureVoiceOut *cap, void *cb_opaque);
+
 #ifdef CONFIG_GIO
     bool (*set_dbus_server)(AudioBackend *be,
                             GDBusObjectManagerServer *manager,
@@ -69,8 +117,7 @@ SWVoiceOut *AUD_open_out(
     const char *name,
     void *callback_opaque,
     audio_callback_fn callback_fn,
-    const struct audsettings *settings
-    );
+    const struct audsettings *settings);
 
 void AUD_close_out(AudioBackend *be, SWVoiceOut *sw);
 size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *pcm_buf, size_t size);
@@ -78,13 +125,6 @@ int  AUD_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw);
 void AUD_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on);
 bool AUD_is_active_out(AudioBackend *be, SWVoiceOut *sw);
 
-#define AUDIO_MAX_CHANNELS 16
-typedef struct Volume {
-    bool mute;
-    int channels;
-    uint8_t vol[AUDIO_MAX_CHANNELS];
-} Volume;
-
 void AUD_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol);
 void AUD_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol);
 
diff --git a/audio/audio.c b/audio/audio.c
index 320035c0484..32b2b882f80 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -847,7 +847,8 @@ static void audio_timer (void *opaque)
 /*
  * Public API
  */
-size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t size)
+static size_t audio_mixeng_backend_write(AudioBackend *be, SWVoiceOut *sw,
+                                         void *buf, size_t size)
 {
     HWVoiceOut *hw;
 
@@ -858,7 +859,7 @@ size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t size)
     hw = sw->hw;
 
     if (!hw->enabled) {
-        dolog ("Writing to disabled voice %s\n", SW_NAME (sw));
+        dolog("Writing to disabled voice %s\n", SW_NAME(sw));
         return 0;
     }
 
@@ -869,7 +870,15 @@ size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t size)
     }
 }
 
-size_t AUD_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size)
+size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t size)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->write(be, sw, buf, size);
+}
+
+static size_t audio_mixeng_backend_read(AudioBackend *be, SWVoiceIn *sw,
+                                        void *buf, size_t size)
 {
     HWVoiceIn *hw;
 
@@ -880,7 +889,7 @@ size_t AUD_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size)
     hw = sw->hw;
 
     if (!hw->enabled) {
-        dolog ("Reading from disabled voice %s\n", SW_NAME (sw));
+        dolog("Reading from disabled voice %s\n", SW_NAME(sw));
         return 0;
     }
 
@@ -889,9 +898,17 @@ size_t AUD_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size)
     } else {
         return hw->pcm_ops->read(hw, buf, size);
     }
+
 }
 
-int AUD_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
+size_t AUD_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->read(be, sw, buf, size);
+}
+
+static int audio_mixeng_backend_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
 {
     if (!sw) {
         return 0;
@@ -904,7 +921,15 @@ int AUD_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
     return sw->hw->samples * sw->hw->info.bytes_per_frame;
 }
 
-void AUD_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on)
+int AUD_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->get_buffer_size_out(be, sw);
+}
+
+static void audio_mixeng_backend_set_active_out(AudioBackend *be, SWVoiceOut *sw,
+                                                bool on)
 {
     HWVoiceOut *hw;
 
@@ -950,9 +975,17 @@ void AUD_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on)
         }
         sw->active = on;
     }
+
 }
 
-void AUD_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
+void AUD_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->set_active_out(be, sw, on);
+}
+
+static void audio_mixeng_backend_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
 {
     HWVoiceIn *hw;
 
@@ -997,6 +1030,13 @@ void AUD_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
     }
 }
 
+void AUD_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->set_active_in(be, sw, on);
+}
+
 static size_t audio_get_avail(SWVoiceIn *sw)
 {
     size_t live;
@@ -1658,12 +1698,97 @@ static const char *audio_mixeng_backend_get_id(AudioBackend *be)
     return AUDIO_MIXENG_BACKEND(be)->dev->id;
 }
 
+static CaptureVoiceOut *audio_mixeng_backend_add_capture(
+    AudioBackend *be,
+    struct audsettings *as,
+    struct audio_capture_ops *ops,
+    void *cb_opaque);
+
+static void audio_mixeng_backend_del_capture(
+    AudioBackend *be,
+    CaptureVoiceOut *cap,
+    void *cb_opaque);
+
+static void audio_mixeng_backend_set_volume_out(AudioBackend *be, SWVoiceOut *sw,
+                                                Volume *vol);
+static void audio_mixeng_backend_set_volume_in(AudioBackend *be, SWVoiceIn *sw,
+                                               Volume *vol);
+
+SWVoiceOut *AUD_open_out(
+    AudioBackend *be,
+    SWVoiceOut *sw,
+    const char *name,
+    void *callback_opaque,
+    audio_callback_fn callback_fn,
+    const struct audsettings *as)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->open_out(be, sw, name, callback_opaque, callback_fn, as);
+}
+
+SWVoiceIn *AUD_open_in(
+    AudioBackend *be,
+    SWVoiceIn *sw,
+    const char *name,
+    void *callback_opaque,
+    audio_callback_fn callback_fn,
+    const struct audsettings *as)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->open_in(be, sw, name, callback_opaque, callback_fn, as);
+}
+
+void AUD_close_out(AudioBackend *be, SWVoiceOut *sw)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->close_out(be, sw);
+}
+
+void AUD_close_in(AudioBackend *be, SWVoiceIn *sw)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->close_in(be, sw);
+}
+
+bool AUD_is_active_out(AudioBackend *be, SWVoiceOut *sw)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->is_active_out(be, sw);
+}
+
+bool AUD_is_active_in(AudioBackend *be, SWVoiceIn *sw)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->is_active_in(be, sw);
+}
+
 static void audio_mixeng_backend_class_init(ObjectClass *klass, const void *data)
 {
     AudioBackendClass *be = AUDIO_BACKEND_CLASS(klass);
 
     be->realize = audio_mixeng_backend_realize;
     be->get_id = audio_mixeng_backend_get_id;
+    be->open_in = audio_mixeng_backend_open_in;
+    be->open_out = audio_mixeng_backend_open_out;
+    be->close_in = audio_mixeng_backend_close_in;
+    be->close_out = audio_mixeng_backend_close_out;
+    be->is_active_out = audio_mixeng_backend_is_active_out;
+    be->is_active_in = audio_mixeng_backend_is_active_in;
+    be->set_active_out = audio_mixeng_backend_set_active_out;
+    be->set_active_in = audio_mixeng_backend_set_active_in;
+    be->set_volume_out = audio_mixeng_backend_set_volume_out;
+    be->set_volume_in = audio_mixeng_backend_set_volume_in;
+    be->read = audio_mixeng_backend_read;
+    be->write = audio_mixeng_backend_write;
+    be->get_buffer_size_out = audio_mixeng_backend_get_buffer_size_out;
+    be->add_capture = audio_mixeng_backend_add_capture;
+    be->del_capture = audio_mixeng_backend_del_capture;
 }
 
 static void audio_mixeng_backend_init(Object *obj)
@@ -1863,12 +1988,11 @@ bool AUD_backend_check(AudioBackend **be, Error **errp)
 
 static struct audio_pcm_ops capture_pcm_ops;
 
-CaptureVoiceOut *AUD_add_capture(
+static CaptureVoiceOut *audio_mixeng_backend_add_capture(
     AudioBackend *be,
     struct audsettings *as,
     struct audio_capture_ops *ops,
-    void *cb_opaque
-    )
+    void *cb_opaque)
 {
     AudioMixengBackend *s = AUDIO_MIXENG_BACKEND(be);
     CaptureVoiceOut *cap;
@@ -1938,7 +2062,21 @@ CaptureVoiceOut *AUD_add_capture(
     return cap;
 }
 
-void AUD_del_capture(AudioBackend *be, CaptureVoiceOut *cap, void *cb_opaque)
+CaptureVoiceOut *AUD_add_capture(
+    AudioBackend *be,
+    struct audsettings *as,
+    struct audio_capture_ops *ops,
+    void *cb_opaque)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->add_capture(be, as, ops, cb_opaque);
+}
+
+static void audio_mixeng_backend_del_capture(
+    AudioBackend *be,
+    CaptureVoiceOut *cap,
+    void *cb_opaque)
 {
     struct capture_callback *cb;
 
@@ -1977,7 +2115,15 @@ void AUD_del_capture(AudioBackend *be, CaptureVoiceOut *cap, void *cb_opaque)
     }
 }
 
-void AUD_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol)
+void AUD_del_capture(AudioBackend *be, CaptureVoiceOut *cap, void *cb_opaque)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    klass->del_capture(be, cap, cb_opaque);
+}
+
+static void audio_mixeng_backend_set_volume_out(AudioBackend *be, SWVoiceOut *sw,
+                                                Volume *vol)
 {
     if (sw) {
         HWVoiceOut *hw = sw->hw;
@@ -1993,7 +2139,15 @@ void AUD_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol)
     }
 }
 
-void AUD_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol)
+void AUD_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    klass->set_volume_out(be, sw, vol);
+}
+
+static void audio_mixeng_backend_set_volume_in(AudioBackend *be, SWVoiceIn *sw,
+                                               Volume *vol)
 {
     if (sw) {
         HWVoiceIn *hw = sw->hw;
@@ -2009,6 +2163,13 @@ void AUD_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol)
     }
 }
 
+void AUD_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    klass->set_volume_in(be, sw, vol);
+}
+
 static void audio_create_pdos(Audiodev *dev)
 {
     switch (dev->driver) {

-- 
2.53.0


