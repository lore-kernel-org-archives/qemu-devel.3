Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D30D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 11:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ21B-00019r-Df; Mon, 01 Dec 2025 06:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ219-000113-DQ
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:24:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ217-0006aT-I8
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764588268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TlG1sPXnGLhOhnk3rhuSP7v3hdO6MZAFD+uX2XjeOcs=;
 b=ZbSHK/ShbCgdpQ6dmzjq0JCOk4AGvfrcjWUDXsQ3bnDOzYtiAYUjzNnpH10cBX/KrEUFfC
 SJwZkY6+rTJkwWbIkj+adXcpUzbJR+zXGuopFKFg8hDi3Sy63Zs9XQKAjgqQGklMzMIXXb
 SMI12kqgwXz+yiC5YYIbzDWG0xnOGLo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-C6o0hx1FPyCKA6hrPzEl0w-1; Mon,
 01 Dec 2025 06:24:25 -0500
X-MC-Unique: C6o0hx1FPyCKA6hrPzEl0w-1
X-Mimecast-MFC-AGG-ID: C6o0hx1FPyCKA6hrPzEl0w_1764588264
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 459E1180134A; Mon,  1 Dec 2025 11:24:16 +0000 (UTC)
Received: from localhost (unknown [10.45.242.40])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CB465180087B; Mon,  1 Dec 2025 11:24:13 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [RFC 09/24] audio: remove set_dbus_server from audio_driver
Date: Mon,  1 Dec 2025 15:22:50 +0400
Message-ID: <20251201112309.4163921-10-marcandre.lureau@redhat.com>
In-Reply-To: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Use the QOM class vtable only instead.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_int.h |  6 ------
 audio/audio.c     | 28 +++-------------------------
 audio/dbusaudio.c | 34 ++++++++++++++++++----------------
 3 files changed, 21 insertions(+), 47 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 44e63318e8..e289ef5f66 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -147,12 +147,6 @@ struct audio_driver {
     const char *name;
     void *(*init) (Audiodev *, Error **);
     void (*fini) (void *);
-#ifdef CONFIG_GIO
-    bool (*set_dbus_server)(AudioBackend *be,
-                            GDBusObjectManagerServer *manager,
-                            bool p2p,
-                            Error **errp);
-#endif
     struct audio_pcm_ops *pcm_ops;
     int max_voices_out;
     int max_voices_in;
diff --git a/audio/audio.c b/audio/audio.c
index fab6024207..1693563c62 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1641,31 +1641,11 @@ static const char *audio_driver_get_id(AudioBackend *be)
     return AUDIO_DRIVER(be)->dev->id;
 }
 
-#ifdef CONFIG_GIO
-static bool audio_driver_set_dbus_server(AudioBackend *be,
-                                            GDBusObjectManagerServer *manager,
-                                            bool p2p,
-                                            Error **errp)
-{
-    AudioDriver *d = AUDIO_DRIVER(be);
-
-    if (!d->drv->set_dbus_server) {
-        return false;
-    }
-
-    return d->drv->set_dbus_server(be, manager, p2p, errp);
-}
-
-#endif
-
 static void audio_driver_class_init(ObjectClass *klass, const void *data)
 {
     AudioBackendClass *be = AUDIO_BACKEND_CLASS(klass);
 
     be->get_id = audio_driver_get_id;
-#ifdef CONFIG_GIO
-    be->set_dbus_server = audio_driver_set_dbus_server;
-#endif
 }
 
 static void audio_driver_init(Object *obj)
@@ -2264,11 +2244,9 @@ AudioBackend *audio_be_by_name(const char *name, Error **errp)
 #ifdef CONFIG_GIO
 bool audio_be_can_set_dbus_server(AudioBackend *be)
 {
-    /*
-     * AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
-     * return klass->set_dbus_server != NULL;
-     */
-     return AUDIO_DRIVER(be)->drv->set_dbus_server != NULL;
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->set_dbus_server != NULL;
 }
 
 bool audio_be_set_dbus_server(AudioBackend *be,
diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index f0b17be6e8..edd551a80f 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -54,21 +54,6 @@ struct AudioDbus {
 
 static struct audio_driver dbus_audio_driver;
 
-static void audio_dbus_class_init(ObjectClass *klass, const void *data)
-{
-    AudioDriverClass *k = AUDIO_DRIVER_CLASS(klass);
-
-    k->driver = &dbus_audio_driver;
-}
-
-static void audio_dbus_init(Object *obj)
-{
-}
-
-static void audio_dbus_finalize(Object *obj)
-{
-}
-
 typedef struct DBusAudio {
     Audiodev *dev;
     GDBusObjectManagerServer *server;
@@ -728,7 +713,6 @@ static struct audio_driver dbus_audio_driver = {
     .name            = "dbus",
     .init            = dbus_audio_init,
     .fini            = dbus_audio_fini,
-    .set_dbus_server = dbus_audio_set_server,
     .pcm_ops         = &dbus_pcm_ops,
     .max_voices_out  = INT_MAX,
     .max_voices_in   = INT_MAX,
@@ -736,6 +720,24 @@ static struct audio_driver dbus_audio_driver = {
     .voice_size_in   = sizeof(DBusVoiceIn)
 };
 
+static void audio_dbus_class_init(ObjectClass *klass, const void *data)
+{
+    AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
+    AudioDriverClass *k = AUDIO_DRIVER_CLASS(klass);
+
+    b->set_dbus_server = dbus_audio_set_server;
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
+
 static const TypeInfo audio_dbus_info = {
     .name = TYPE_AUDIO_DBUS,
     .parent = TYPE_AUDIO_DRIVER,
-- 
2.51.1


