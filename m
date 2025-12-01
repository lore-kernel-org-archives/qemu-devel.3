Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D01D116FC
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 11:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ22L-0004sE-UR; Mon, 01 Dec 2025 06:25:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ22C-0004MK-Rc
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:25:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ227-00070d-Om
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764588326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WeVZF3ijdiVf7ReEzERlNJDV4DDQf1oUAP+81yN3YQE=;
 b=WRP/a5SbTQLizTglIPv2lU32o40w0Gqelkh6UaC7/oc16Q75nmt3TctZLaTFcl3hTZQ4Kx
 zDEYD/bqsowlDwOP/tnWaFdWUHz0qiHYTXPIvj/rewDQ8wL1fNzzjfY9YcUURuetCjW19F
 Gg/8kfaVDBQ+hz2zQn1ZNmy/Gp4+FO0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-oQhTXVkrPIy818hj7Rrjcg-1; Mon,
 01 Dec 2025 06:25:23 -0500
X-MC-Unique: oQhTXVkrPIy818hj7Rrjcg-1
X-Mimecast-MFC-AGG-ID: oQhTXVkrPIy818hj7Rrjcg_1764588321
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F2611956094; Mon,  1 Dec 2025 11:25:21 +0000 (UTC)
Received: from localhost (unknown [10.45.242.40])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8DF9618002AC; Mon,  1 Dec 2025 11:25:19 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [RFC 19/24] audio: split AudioBackend
Date: Mon,  1 Dec 2025 15:23:00 +0400
Message-ID: <20251201112309.4163921-20-marcandre.lureau@redhat.com>
In-Reply-To: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

Code clean-up, to allow building bare abstract class separately.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/audio.h |   2 +
 audio/audio-be.c     | 210 +++++++++++++++++++++++++++++++++++++++++++
 audio/audio.c        | 188 --------------------------------------
 audio/meson.build    |   1 +
 4 files changed, 213 insertions(+), 188 deletions(-)
 create mode 100644 audio/audio-be.c

diff --git a/include/qemu/audio.h b/include/qemu/audio.h
index 672f9befe5..649fb89de2 100644
--- a/include/qemu/audio.h
+++ b/include/qemu/audio.h
@@ -118,6 +118,8 @@ typedef struct QEMUAudioTimeStamp {
 
 bool AUD_backend_check(AudioBackend **be, Error **errp);
 
+AudioBackend *audio_be_new(Audiodev *dev, Error **errp);
+
 SWVoiceOut *AUD_open_out(
     AudioBackend *be,
     SWVoiceOut *sw,
diff --git a/audio/audio-be.c b/audio/audio-be.c
new file mode 100644
index 0000000000..565b7a4cc5
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
+    void *callback_opaque ,
+    audio_callback_fn callback_fn,
+    struct audsettings *as)
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
+    void *callback_opaque ,
+    audio_callback_fn callback_fn,
+    struct audsettings *as)
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
index d9c338ea91..3d1c650cc0 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -868,13 +868,6 @@ static void audio_timer (void *opaque)
      }
  }
 
-size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t size)
-{
-    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
-
-    return klass->write(be, sw, buf, size);
-}
-
 static size_t audio_driver_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size)
 {
     HWVoiceIn *hw;
@@ -898,13 +891,6 @@ static size_t audio_driver_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size
 
 }
 
-size_t AUD_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size)
-{
-    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
-
-    return klass->read(be, sw, buf, size);
-}
-
 static int audio_driver_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
 {
     if (!sw) {
@@ -918,13 +904,6 @@ static int audio_driver_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
     return sw->hw->samples * sw->hw->info.bytes_per_frame;
 }
 
-int AUD_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
-{
-    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
-
-    return klass->get_buffer_size_out(be, sw);
-}
-
 static void audio_driver_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on)
 {
     HWVoiceOut *hw;
@@ -974,13 +953,6 @@ static void audio_driver_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool o
 
 }
 
-void AUD_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on)
-{
-    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
-
-    return klass->set_active_out(be, sw, on);
-}
-
 static void audio_driver_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
 {
     HWVoiceIn *hw;
@@ -1026,13 +998,6 @@ static void audio_driver_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
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
@@ -1683,14 +1648,6 @@ static void audio_vm_change_state_handler (void *opaque, bool running,
 
 static const VMStateDescription vmstate_audio;
 
-static void audio_be_init(Object *obj)
-{
-}
-
-static void audio_be_finalize(Object *obj)
-{
-}
-
 static const char *audio_driver_get_id(AudioBackend *be)
 {
     return AUDIO_DRIVER(be)->dev->id;
@@ -1710,60 +1667,6 @@ static void audio_driver_del_capture(
 static void audio_driver_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol);
 static void audio_driver_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol);
 
-SWVoiceOut *AUD_open_out(
-    AudioBackend *be,
-    SWVoiceOut *sw,
-    const char *name,
-    void *callback_opaque ,
-    audio_callback_fn callback_fn,
-    struct audsettings *as)
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
-    void *callback_opaque ,
-    audio_callback_fn callback_fn,
-    struct audsettings *as)
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
 static void audio_driver_class_init(ObjectClass *klass, const void *data)
 {
     AudioBackendClass *be = AUDIO_BACKEND_CLASS(klass);
@@ -1966,20 +1869,6 @@ AudioBackend *audio_get_default_audio_be(Error **errp)
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
 
 static CaptureVoiceOut *audio_driver_add_capture(
@@ -2057,17 +1946,6 @@ static CaptureVoiceOut *audio_driver_add_capture(
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
 static void audio_driver_del_capture(
     AudioBackend *be,
     CaptureVoiceOut *cap,
@@ -2110,13 +1988,6 @@ static void audio_driver_del_capture(
     }
 }
 
-void AUD_del_capture(AudioBackend *be, CaptureVoiceOut *cap, void *cb_opaque)
-{
-    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
-
-    klass->del_capture(be, cap, cb_opaque);
-}
-
 static void audio_driver_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol)
 {
     if (sw) {
@@ -2133,13 +2004,6 @@ static void audio_driver_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume
     }
 }
 
-void AUD_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol)
-{
-    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
-
-    klass->set_volume_out(be, sw, vol);
-}
-
 static void audio_driver_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol)
 {
     if (sw) {
@@ -2156,13 +2020,6 @@ static void audio_driver_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *
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
@@ -2416,40 +2273,6 @@ AudioBackend *audio_be_by_name(const char *name, Error **errp)
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
@@ -2513,16 +2336,6 @@ AudiodevList *qmp_query_audiodevs(Error **errp)
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
 static const TypeInfo audio_driver_info = {
     .name = TYPE_AUDIO_DRIVER,
     .parent = TYPE_AUDIO_BACKEND,
@@ -2536,7 +2349,6 @@ static const TypeInfo audio_driver_info = {
 
 static void register_types(void)
 {
-    type_register_static(&audio_be_info);
     type_register_static(&audio_driver_info);
 }
 
diff --git a/audio/meson.build b/audio/meson.build
index b2dca2c640..2450098eb8 100644
--- a/audio/meson.build
+++ b/audio/meson.build
@@ -1,5 +1,6 @@
 system_ss.add(files(
   'audio.c',
+  'audio-be.c',
   'mixeng.c',
   'noaudio.c',
   'wavaudio.c',
-- 
2.51.1


