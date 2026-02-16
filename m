Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B082EE7BD92
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwda-0000oT-GG; Mon, 16 Feb 2026 06:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwb7-0005Pd-Qk
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwb4-0007Vn-5M
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MUsBjBksReZ1gaFRLPZuGSgyXvz6SSrNa1EyYK/h58o=;
 b=WHU0VmppVc2vxgYE76nQqeqAKMTl1zGBkIuTMv7WaK17Tc7PZxlpQFuBpzLXzlCHcx/5Rv
 +U4/gWW2LYTrlcqk2mpzShxwo4C1BpD25zohxNMQENY9z3ujb2jRAEqL1mUjroSOxfsLRZ
 RmAtccfBiIEK6IFy9PsyvGj0uRcxxHc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-Rsf5jSByM_aMDxAiFpTD6Q-1; Mon,
 16 Feb 2026 06:16:50 -0500
X-MC-Unique: Rsf5jSByM_aMDxAiFpTD6Q-1
X-Mimecast-MFC-AGG-ID: Rsf5jSByM_aMDxAiFpTD6Q_1771240608
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 460DD1956094; Mon, 16 Feb 2026 11:16:48 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 526E130001A5; Mon, 16 Feb 2026 11:16:47 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:14 +0100
Subject: [PATCH 25/85] audio: remove set_dbus_server from audio_driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-25-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4292;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=dbOONFCzI/swxM9VY+S6bbCkaSc4yZrxA86hh54hOys=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxPfP2bXM3hb4gPF8nqfgGOjVTVptgrC2Mqj
 KZK0TbdxwKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8TwAKCRDa6OEJdZac
 5d0RD/9hN+Gu4T9upe7I8RRO1rWs7WdRBo1JGUlaVLYfcEOaFzfAuyNqlxd9STApGJ4UTKy5I6g
 zl+1ytMpxE/nCZLTTgMi/xCZhwmnVwlRAEvR/5+sMXBYFbPkgoEQCKI+b6mCqQYCT70townLztb
 vKWqgBUhQ5b/0iyvVkQ67ni1//OyK5W90oZJABWGIiQbr+WHlVwK9JRhRFH9mw7fk/42JGS/aei
 w3TCpFhfU8D4SGsxLG818oQnqZWzuCq8/ZaTOH1xV+cckTgxc/2fGmNHKVW0LlvmRxXAnrL9owm
 T7VWbo6xnSrJ1RhToHjA5VPxmT3YBT+KrRcL5TulamHQ23laoAXdJZz4MEggmzeoTUOlFHT+Tm6
 5L1cmBRmPV2arkLZ7Od5qwLUwevbUcQHwU8pPo0R4Ox7hMp+YggIwiIZFlvXO3LHuB2MYKMWP3q
 yMUgG/jFpMcCNDPGouS7zzWsNabxtyPjQtrnVkPqQqJgLWnmnf8MjurtA9mtCnr7BUGcFikey8N
 vnHSBTKCzYD14lfP9yJc1hxnERWvSo31fNaUQpNmwLdI3aMziQgKHnPQYjjVGpNbMSN3hE44RNB
 rdyFBUDQYzf7Sf3gMYZ8x2wy6XitImVk9GnvwAN2jahXkyIEcnN6icj1plhWMueucHBT0H+So3F
 uYvxZ33u1O1NaTA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use the QOM class vtable only instead.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/audio_int.h | 10 ----------
 audio/audio.c     | 29 +++--------------------------
 audio/dbusaudio.c | 17 +++++++++--------
 3 files changed, 12 insertions(+), 44 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 29f5864be69..0b97c8edee3 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -33,10 +33,6 @@
 #include "qemu/audio-capture.h"
 #include "mixeng.h"
 
-#ifdef CONFIG_GIO
-#include <gio/gio.h>
-#endif
-
 void G_GNUC_PRINTF(2, 0)
 AUD_vlog(const char *cap, const char *fmt, va_list ap);
 
@@ -145,12 +141,6 @@ struct audio_driver {
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
index 3e1cd988852..5d0f5ad2145 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1640,31 +1640,11 @@ static const char *audio_mixeng_backend_get_id(AudioBackend *be)
     return AUDIO_MIXENG_BACKEND(be)->dev->id;
 }
 
-#ifdef CONFIG_GIO
-static bool audio_mixeng_backend_set_dbus_server(AudioBackend *be,
-                                                 GDBusObjectManagerServer *manager,
-                                                 bool p2p,
-                                                 Error **errp)
-{
-    AudioMixengBackend *d = AUDIO_MIXENG_BACKEND(be);
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
 static void audio_mixeng_backend_class_init(ObjectClass *klass, const void *data)
 {
     AudioBackendClass *be = AUDIO_BACKEND_CLASS(klass);
 
     be->get_id = audio_mixeng_backend_get_id;
-#ifdef CONFIG_GIO
-    be->set_dbus_server = audio_mixeng_backend_set_dbus_server;
-#endif
 }
 
 static void audio_mixeng_backend_init(Object *obj)
@@ -2264,12 +2244,9 @@ AudioBackend *audio_be_by_name(const char *name, Error **errp)
 #ifdef CONFIG_GIO
 bool audio_be_can_set_dbus_server(AudioBackend *be)
 {
-    /*
-     * TODO:
-     * AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
-     * return klass->set_dbus_server != NULL;
-     */
-    return AUDIO_MIXENG_BACKEND(be)->drv->set_dbus_server != NULL;
+    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
+
+    return klass->set_dbus_server != NULL;
 }
 
 bool audio_be_set_dbus_server(AudioBackend *be,
diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index 4d62de6d72c..5a5752b8f33 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -54,13 +54,6 @@ struct AudioDbus {
 
 static struct audio_driver dbus_audio_driver;
 
-static void audio_dbus_class_init(ObjectClass *klass, const void *data)
-{
-    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
-
-    k->driver = &dbus_audio_driver;
-}
-
 typedef struct DBusAudio {
     Audiodev *dev;
     GDBusObjectManagerServer *server;
@@ -720,7 +713,6 @@ static struct audio_driver dbus_audio_driver = {
     .name            = "dbus",
     .init            = dbus_audio_init,
     .fini            = dbus_audio_fini,
-    .set_dbus_server = dbus_audio_set_server,
     .pcm_ops         = &dbus_pcm_ops,
     .max_voices_out  = INT_MAX,
     .max_voices_in   = INT_MAX,
@@ -728,6 +720,15 @@ static struct audio_driver dbus_audio_driver = {
     .voice_size_in   = sizeof(DBusVoiceIn)
 };
 
+static void audio_dbus_class_init(ObjectClass *klass, const void *data)
+{
+    AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
+    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
+
+    b->set_dbus_server = dbus_audio_set_server;
+    k->driver = &dbus_audio_driver;
+}
+
 static const TypeInfo audio_dbus_info = {
     .name = TYPE_AUDIO_DBUS,
     .parent = TYPE_AUDIO_MIXENG_BACKEND,

-- 
2.53.0


