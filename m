Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30C5EA4FBA
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 14:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuWKA-00041U-FH; Mon, 23 Feb 2026 08:50:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWJK-00021q-TI
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:49:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWJH-00079N-O1
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771854555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mb5pHzNfJSpKQ6uJQFjOza9G7rq7AO5807bWCHM3ZPc=;
 b=EJ7BIDYc+dNR1dXqJ2cL12VavhcCuPEm678DveTsDzRSq0EpgRRwIlct+wFoo0jJAZvxxk
 C47E2kRzTdJg1DlSC4dWJTDujgzQ4XjT40yRSLqshPLq7NCHbUnPg5gR0swxZ5w/2i6K/1
 Dyd2J5ZQlaULZalvR+Pg3YRx+EyCiJE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-x2DH4Fy_MdaUwf2CTh_U5Q-1; Mon,
 23 Feb 2026 08:49:13 -0500
X-MC-Unique: x2DH4Fy_MdaUwf2CTh_U5Q-1
X-Mimecast-MFC-AGG-ID: x2DH4Fy_MdaUwf2CTh_U5Q_1771854552
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC7A81955F0E; Mon, 23 Feb 2026 13:49:12 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4A63E1800668; Mon, 23 Feb 2026 13:49:12 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v3 36/85] audio: split AudioBackend
Date: Mon, 23 Feb 2026 14:46:37 +0100
Message-ID: <20260223134731.2377432-37-marcandre.lureau@redhat.com>
In-Reply-To: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
References: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Code clean-up, to allow building bare abstract class separately.

The original file is MIT-licensed.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/audio.h |   2 +
 audio/audio-be.c     | 206 ++++++++++++++++++++++++++++++++++++++++++
 audio/audio.c        | 209 +------------------------------------------
 audio/meson.build    |   1 +
 4 files changed, 211 insertions(+), 207 deletions(-)
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
index 00000000000..51fb124026a
--- /dev/null
+++ b/audio/audio-be.c
@@ -0,0 +1,206 @@
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
+static const TypeInfo audio_types[] = {
+    {
+        .name = TYPE_AUDIO_BACKEND,
+        .parent = TYPE_OBJECT,
+        .instance_size = sizeof(AudioBackend),
+        .abstract = true,
+        .class_size = sizeof(AudioBackendClass),
+    },
+};
+
+DEFINE_TYPES(audio_types)
diff --git a/audio/audio.c b/audio/audio.c
index 32b2b882f80..22e55ac9758 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -870,15 +870,8 @@ static size_t audio_mixeng_backend_write(AudioBackend *be, SWVoiceOut *sw,
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
 
@@ -901,13 +894,6 @@ static size_t audio_mixeng_backend_read(AudioBackend *be, SWVoiceIn *sw,
 
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
@@ -921,13 +907,6 @@ static int audio_mixeng_backend_get_buffer_size_out(AudioBackend *be, SWVoiceOut
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
@@ -978,13 +957,6 @@ static void audio_mixeng_backend_set_active_out(AudioBackend *be, SWVoiceOut *sw
 
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
@@ -1030,13 +1002,6 @@ static void audio_mixeng_backend_set_active_in(AudioBackend *be, SWVoiceIn *sw,
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
@@ -1643,25 +1608,6 @@ static bool audio_mixeng_backend_realize(AudioBackend *abe,
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
@@ -1685,14 +1631,6 @@ static void audio_vm_change_state_handler (void *opaque, bool running,
 
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
@@ -1714,60 +1652,6 @@ static void audio_mixeng_backend_set_volume_out(AudioBackend *be, SWVoiceOut *sw
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
@@ -1972,20 +1856,6 @@ AudioBackend *audio_get_default_audio_be(Error **errp)
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
@@ -2062,17 +1932,6 @@ static CaptureVoiceOut *audio_mixeng_backend_add_capture(
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
@@ -2115,13 +1974,6 @@ static void audio_mixeng_backend_del_capture(
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
@@ -2139,13 +1991,6 @@ static void audio_mixeng_backend_set_volume_out(AudioBackend *be, SWVoiceOut *sw
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
@@ -2163,13 +2008,6 @@ static void audio_mixeng_backend_set_volume_in(AudioBackend *be, SWVoiceIn *sw,
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
@@ -2423,40 +2261,6 @@ AudioBackend *audio_be_by_name(const char *name, Error **errp)
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
@@ -2521,15 +2325,6 @@ AudiodevList *qmp_query_audiodevs(Error **errp)
 }
 
 static const TypeInfo audio_types[] = {
-    {
-        .name = TYPE_AUDIO_BACKEND,
-        .parent = TYPE_OBJECT,
-        .instance_size = sizeof(AudioBackend),
-        .instance_init = audio_be_init,
-        .instance_finalize = audio_be_finalize,
-        .abstract = true,
-        .class_size = sizeof(AudioBackendClass),
-    },
     {
         .name = TYPE_AUDIO_MIXENG_BACKEND,
         .parent = TYPE_AUDIO_BACKEND,
diff --git a/audio/meson.build b/audio/meson.build
index 55ee0bfc865..17f58369c20 100644
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
2.53.0


