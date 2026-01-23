Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF121D72347
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 07:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjC0J-0008Ip-4f; Fri, 23 Jan 2026 02:54:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vjByj-0006jy-Su
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 02:53:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vjByg-0002Ia-QN
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 02:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769154790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mCXf/Xy7UKL5acy6xc4fy3GCbSoRWYbjh5sPyv0ccS8=;
 b=aXXx+H07kYft3gTi6A9FPq/FtoizgncaICiUnQm3JE9q6kYKUH/ZqDp/lNsntOybXKIXVF
 RfuIkX/7D0HsDRaEhxk7aVLJgOUjpH5Nqy8vyrc/rRgXvQY14v1fBGoL1EztRRAzHC6kyw
 NM4oeuLUumdCbPKkyQjNpbf2HS0905Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-hqy8umx2Oy22FLydjmJPmQ-1; Fri,
 23 Jan 2026 02:53:08 -0500
X-MC-Unique: hqy8umx2Oy22FLydjmJPmQ-1
X-Mimecast-MFC-AGG-ID: hqy8umx2Oy22FLydjmJPmQ_1769154788
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E846D18003FC; Fri, 23 Jan 2026 07:53:07 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D61E1958DC1; Fri, 23 Jan 2026 07:53:05 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 32/37] audio: split AudioBackend
Date: Fri, 23 Jan 2026 11:49:35 +0400
Message-ID: <20260123074945.2563196-33-marcandre.lureau@redhat.com>
In-Reply-To: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Code clean-up, to allow building bare abstract class separately.

The original file is MIT-licensed.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/audio.h |   2 +
 audio/audio-be.c     | 210 ++++++++++++++++++++++++++++++++++++++++++
 audio/audio.c        | 211 +------------------------------------------
 audio/meson.build    |   1 +
 4 files changed, 215 insertions(+), 209 deletions(-)
 create mode 100644 audio/audio-be.c

diff --git a/include/qemu/audio.h b/include/qemu/audio.h
index 4fae48886ba..9f85c6316a8 100644
--- a/include/qemu/audio.h
+++ b/include/qemu/audio.h
@@ -111,6 +111,8 @@ typedef struct AudioBackendClass {
 
 bool AUD_backend_check(AudioBackend **be, Error **errp);
 
+AudioBackend *audio_be_new(Audiodev *dev, Error **errp);
+
 SWVoiceOut *AUD_open_out(
     AudioBackend *be,
     SWVoiceOut *sw,
diff --git a/audio/audio-be.c b/audio/audio-be.c
new file mode 100644
index 00000000000..8154727dbfb
--- /dev/null
+++ b/audio/audio-be.c
@@ -0,0 +1,210 @@
+/* SPDX-License-Identifier: MIT */
+
+#include "qemu/osdep.h"
+#include "qemu/audio.h"
+#include "qemu/audio-capture.h"
+#include "qapi/error.h"
+
+bool AUD_backend_check(AudioBackend **be, Error **errp)
+{
+    assert(be != NULL);
+
+    if (!*be) {
+        *be = audio_get_default_audio_be(errp);
+        if (!*be) {
+            return false;
+        }
+    }
+
+    return true;
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
+size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t size)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->write(be, sw, buf, size);
+}
+
+size_t AUD_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->read(be, sw, buf, size);
+}
+
+int AUD_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->get_buffer_size_out(be, sw);
+}
+
+void AUD_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->set_active_out(be, sw, on);
+}
+
+void AUD_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->set_active_in(be, sw, on);
+}
+
+void AUD_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    klass->set_volume_out(be, sw, vol);
+}
+
+void AUD_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    klass->set_volume_in(be, sw, vol);
+}
+
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
+void AUD_del_capture(AudioBackend *be, CaptureVoiceOut *cap, void *cb_opaque)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    klass->del_capture(be, cap, cb_opaque);
+}
+
+#ifdef CONFIG_GIO
+bool audio_be_can_set_dbus_server(AudioBackend *be)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->set_dbus_server != NULL;
+}
+
+bool audio_be_set_dbus_server(AudioBackend *be,
+                              GDBusObjectManagerServer *server,
+                              bool p2p,
+                              Error **errp)
+{
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    if (!audio_be_can_set_dbus_server(be)) {
+        error_setg(errp, "Audiodev '%s' is not compatible with DBus",
+                   audio_be_get_id(be));
+        return false;
+    }
+
+    return klass->set_dbus_server(be, server, p2p, errp);
+}
+#endif
+
+const char *audio_be_get_id(AudioBackend *be)
+{
+    if (be) {
+        return AUDIO_BACKEND_GET_CLASS(be)->get_id(be);
+    } else {
+        return "";
+    }
+}
+
+AudioBackend *audio_be_new(Audiodev *dev, Error **errp)
+{
+    const char *drvname = AudiodevDriver_str(dev->driver);
+    g_autofree char *type = g_strconcat("audio-", drvname, NULL);
+    AudioBackend *be = AUDIO_BACKEND(object_new(type));
+
+    if (!be) {
+        error_setg(errp, "Unknown audio driver `%s'", drvname);
+        return NULL;
+    }
+
+    if (!AUDIO_BACKEND_GET_CLASS(be)->realize(be, dev, errp)) {
+        object_unref(OBJECT(be));
+        return NULL;
+    }
+
+    return be;
+}
+
+
+static const TypeInfo audio_be_info = {
+    .name = TYPE_AUDIO_BACKEND,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(AudioBackend),
+    .abstract = true,
+    .class_size = sizeof(AudioBackendClass),
+};
+
+static void register_types(void)
+{
+    type_register_static(&audio_be_info);
+}
+
+type_init(register_types);
diff --git a/audio/audio.c b/audio/audio.c
index 3f09452e300..1d948084e80 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -869,15 +869,8 @@ static size_t audio_mixeng_backend_write(AudioBackend *be, SWVoiceOut *sw,
     }
 }
 
-size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t size)
-{
-    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
-
-    return klass->write(be, sw, buf, size);
-}
-
-static size_t audio_mixeng_backend_read(AudioBackend *be, SWVoiceIn *sw,
-                                        void *buf, size_t size)
+static size_t audio_mixeng_backend_read(AudioBackend *be,
+                                        SWVoiceIn *sw, void *buf, size_t size)
 {
     HWVoiceIn *hw;
 
@@ -900,13 +893,6 @@ static size_t audio_mixeng_backend_read(AudioBackend *be, SWVoiceIn *sw,
 
 }
 
-size_t AUD_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size)
-{
-    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
-
-    return klass->read(be, sw, buf, size);
-}
-
 static int audio_mixeng_backend_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
 {
     if (!sw) {
@@ -920,13 +906,6 @@ static int audio_mixeng_backend_get_buffer_size_out(AudioBackend *be, SWVoiceOut
     return sw->hw->samples * sw->hw->info.bytes_per_frame;
 }
 
-int AUD_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
-{
-    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
-
-    return klass->get_buffer_size_out(be, sw);
-}
-
 static void audio_mixeng_backend_set_active_out(AudioBackend *be, SWVoiceOut *sw,
                                                 bool on)
 {
@@ -977,13 +956,6 @@ static void audio_mixeng_backend_set_active_out(AudioBackend *be, SWVoiceOut *sw
 
 }
 
-void AUD_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on)
-{
-    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
-
-    return klass->set_active_out(be, sw, on);
-}
-
 static void audio_mixeng_backend_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
 {
     HWVoiceIn *hw;
@@ -1029,13 +1001,6 @@ static void audio_mixeng_backend_set_active_in(AudioBackend *be, SWVoiceIn *sw,
     }
 }
 
-void AUD_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
-{
-    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
-
-    return klass->set_active_in(be, sw, on);
-}
-
 static size_t audio_get_avail(SWVoiceIn *sw)
 {
     size_t live;
@@ -1642,25 +1607,6 @@ static bool audio_mixeng_backend_realize(AudioBackend *abe,
     return true;
 }
 
-static AudioBackend *audio_be_new(Audiodev *dev, Error **errp)
-{
-    const char *drvname = AudiodevDriver_str(dev->driver);
-    g_autofree char *type = g_strconcat("audio-", drvname, NULL);
-    AudioBackend *be = AUDIO_BACKEND(object_new(type));
-
-    if (!be) {
-        error_setg(errp, "Unknown audio driver `%s'", drvname);
-        return NULL;
-    }
-
-    if (!AUDIO_BACKEND_GET_CLASS(be)->realize(be, dev, errp)) {
-        object_unref(OBJECT(be));
-        return NULL;
-    }
-
-    return be;
-}
-
 static void audio_vm_change_state_handler (void *opaque, bool running,
                                            RunState state)
 {
@@ -1684,14 +1630,6 @@ static void audio_vm_change_state_handler (void *opaque, bool running,
 
 static const VMStateDescription vmstate_audio;
 
-static void audio_be_init(Object *obj)
-{
-}
-
-static void audio_be_finalize(Object *obj)
-{
-}
-
 static const char *audio_mixeng_backend_get_id(AudioBackend *be)
 {
     return AUDIO_MIXENG_BACKEND(be)->dev->id;
@@ -1713,60 +1651,6 @@ static void audio_mixeng_backend_set_volume_out(AudioBackend *be, SWVoiceOut *sw
 static void audio_mixeng_backend_set_volume_in(AudioBackend *be, SWVoiceIn *sw,
                                                Volume *vol);
 
-SWVoiceOut *AUD_open_out(
-    AudioBackend *be,
-    SWVoiceOut *sw,
-    const char *name,
-    void *callback_opaque,
-    audio_callback_fn callback_fn,
-    const struct audsettings *as)
-{
-    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
-
-    return klass->open_out(be, sw, name, callback_opaque, callback_fn, as);
-}
-
-SWVoiceIn *AUD_open_in(
-    AudioBackend *be,
-    SWVoiceIn *sw,
-    const char *name,
-    void *callback_opaque,
-    audio_callback_fn callback_fn,
-    const struct audsettings *as)
-{
-    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
-
-    return klass->open_in(be, sw, name, callback_opaque, callback_fn, as);
-}
-
-void AUD_close_out(AudioBackend *be, SWVoiceOut *sw)
-{
-    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
-
-    return klass->close_out(be, sw);
-}
-
-void AUD_close_in(AudioBackend *be, SWVoiceIn *sw)
-{
-    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
-
-    return klass->close_in(be, sw);
-}
-
-bool AUD_is_active_out(AudioBackend *be, SWVoiceOut *sw)
-{
-    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
-
-    return klass->is_active_out(be, sw);
-}
-
-bool AUD_is_active_in(AudioBackend *be, SWVoiceIn *sw)
-{
-    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
-
-    return klass->is_active_in(be, sw);
-}
-
 static void audio_mixeng_backend_class_init(ObjectClass *klass, const void *data)
 {
     AudioBackendClass *be = AUDIO_BACKEND_CLASS(klass);
@@ -1971,20 +1855,6 @@ AudioBackend *audio_get_default_audio_be(Error **errp)
     return default_audio_be;
 }
 
-bool AUD_backend_check(AudioBackend **be, Error **errp)
-{
-    assert(be != NULL);
-
-    if (!*be) {
-        *be = audio_get_default_audio_be(errp);
-        if (!*be) {
-            return false;
-        }
-    }
-
-    return true;
-}
-
 static struct audio_pcm_ops capture_pcm_ops;
 
 static CaptureVoiceOut *audio_mixeng_backend_add_capture(
@@ -2061,17 +1931,6 @@ static CaptureVoiceOut *audio_mixeng_backend_add_capture(
     return cap;
 }
 
-CaptureVoiceOut *AUD_add_capture(
-    AudioBackend *be,
-    struct audsettings *as,
-    struct audio_capture_ops *ops,
-    void *cb_opaque)
-{
-    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
-
-    return klass->add_capture(be, as, ops, cb_opaque);
-}
-
 static void audio_mixeng_backend_del_capture(
     AudioBackend *be,
     CaptureVoiceOut *cap,
@@ -2114,13 +1973,6 @@ static void audio_mixeng_backend_del_capture(
     }
 }
 
-void AUD_del_capture(AudioBackend *be, CaptureVoiceOut *cap, void *cb_opaque)
-{
-    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
-
-    klass->del_capture(be, cap, cb_opaque);
-}
-
 static void audio_mixeng_backend_set_volume_out(AudioBackend *be, SWVoiceOut *sw,
                                                 Volume *vol)
 {
@@ -2138,13 +1990,6 @@ static void audio_mixeng_backend_set_volume_out(AudioBackend *be, SWVoiceOut *sw
     }
 }
 
-void AUD_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol)
-{
-    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
-
-    klass->set_volume_out(be, sw, vol);
-}
-
 static void audio_mixeng_backend_set_volume_in(AudioBackend *be, SWVoiceIn *sw,
                                                Volume *vol)
 {
@@ -2162,13 +2007,6 @@ static void audio_mixeng_backend_set_volume_in(AudioBackend *be, SWVoiceIn *sw,
     }
 }
 
-void AUD_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol)
-{
-    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
-
-    klass->set_volume_in(be, sw, vol);
-}
-
 static void audio_create_pdos(Audiodev *dev)
 {
     switch (dev->driver) {
@@ -2422,40 +2260,6 @@ AudioBackend *audio_be_by_name(const char *name, Error **errp)
     }
 }
 
-#ifdef CONFIG_GIO
-bool audio_be_can_set_dbus_server(AudioBackend *be)
-{
-    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
-
-    return klass->set_dbus_server != NULL;
-}
-
-bool audio_be_set_dbus_server(AudioBackend *be,
-                              GDBusObjectManagerServer *server,
-                              bool p2p,
-                              Error **errp)
-{
-    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
-
-    if (!audio_be_can_set_dbus_server(be)) {
-        error_setg(errp, "Audiodev '%s' is not compatible with DBus",
-                   audio_be_get_id(be));
-        return false;
-    }
-
-    return klass->set_dbus_server(be, server, p2p, errp);
-}
-#endif
-
-const char *audio_be_get_id(AudioBackend *be)
-{
-    if (be) {
-        return AUDIO_BACKEND_GET_CLASS(be)->get_id(be);
-    } else {
-        return "";
-    }
-}
-
 const char *audio_application_name(void)
 {
     const char *vm_name;
@@ -2519,16 +2323,6 @@ AudiodevList *qmp_query_audiodevs(Error **errp)
     return ret;
 }
 
-static const TypeInfo audio_be_info = {
-    .name = TYPE_AUDIO_BACKEND,
-    .parent = TYPE_OBJECT,
-    .instance_size = sizeof(AudioBackend),
-    .instance_init = audio_be_init,
-    .instance_finalize = audio_be_finalize,
-    .abstract = true,
-    .class_size = sizeof(AudioBackendClass),
-};
-
 static const TypeInfo audio_mixeng_backend_info = {
     .name = TYPE_AUDIO_MIXENG_BACKEND,
     .parent = TYPE_AUDIO_BACKEND,
@@ -2542,7 +2336,6 @@ static const TypeInfo audio_mixeng_backend_info = {
 
 static void register_types(void)
 {
-    type_register_static(&audio_be_info);
     type_register_static(&audio_mixeng_backend_info);
 }
 
diff --git a/audio/meson.build b/audio/meson.build
index a5fec14fb3a..417670bd4c7 100644
--- a/audio/meson.build
+++ b/audio/meson.build
@@ -1,6 +1,7 @@
 audio_ss = ss.source_set()
 audio_ss.add(files(
   'audio.c',
+  'audio-be.c',
   'mixeng.c',
   'noaudio.c',
   'wavaudio.c',
-- 
2.52.0


