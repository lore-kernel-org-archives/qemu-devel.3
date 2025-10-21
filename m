Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64917CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8Kr-00071o-S5; Tue, 21 Oct 2025 05:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8KV-0006oB-4A
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:06:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8KS-0004Ow-Q7
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761037611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dFt3SyQn/4VSg6MIGWMIRzoazNm5yv+QD/kuyUHOcI=;
 b=HCTjstycEmTZl3weF5hAHzfbdpXdl6r4ePLgZ72c4sRBfOG3Hdl31MV2nvghnbR3Dz6N5h
 NMI44Z77BMMxrbtHhvL2tohYSrW4+95GLENunGL+RIGWn2HobFBP2056cwFQWnkhEr3Qm/
 F/mZOIMbLfAdb/Ov7cqsxP0b56oStSU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-PDF8AoglMmyx1vvBnza2wQ-1; Tue,
 21 Oct 2025 05:06:48 -0400
X-MC-Unique: PDF8AoglMmyx1vvBnza2wQ-1
X-Mimecast-MFC-AGG-ID: PDF8AoglMmyx1vvBnza2wQ_1761037607
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E95D719560B7; Tue, 21 Oct 2025 09:06:46 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A5FC619560A2; Tue, 21 Oct 2025 09:06:45 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 37/43] audio/dbus: use a helper function to set the backend
 dbus server
Date: Tue, 21 Oct 2025 13:03:08 +0400
Message-ID: <20251021090317.425409-38-marcandre.lureau@redhat.com>
In-Reply-To: <20251021090317.425409-1-marcandre.lureau@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio.h     |  6 ++++++
 audio/audio_int.h |  2 +-
 audio/audio.c     | 14 ++++++++++++++
 audio/dbusaudio.c |  6 ++++--
 ui/dbus.c         |  8 +-------
 5 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index 85e588a885..1f37cc3164 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -28,6 +28,9 @@
 #include "qemu/queue.h"
 #include "qapi/qapi-types-audio.h"
 #include "hw/qdev-properties-system.h"
+#ifdef CONFIG_GIO
+#include "gio/gio.h"
+#endif
 
 typedef void (*audio_callback_fn) (void *opaque, int avail);
 
@@ -157,6 +160,9 @@ void audio_help(void);
 AudioBE *audio_be_by_name(const char *name, Error **errp);
 AudioBE *audio_get_default_audio_be(Error **errp);
 const char *audio_fe_get_be_id(AudioFE *fe);
+#ifdef CONFIG_GIO
+bool audio_be_set_dbus_server(AudioBE *be, GDBusObjectManagerServer *server, bool p2p, Error **errp);
+#endif
 
 #define DEFINE_AUDIO_PROPERTIES(_s, _f)         \
     DEFINE_PROP_AUDIODEV("audiodev", _s, _f)
diff --git a/audio/audio_int.h b/audio/audio_int.h
index 5943dc3b2a..8c2dae21ab 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -147,7 +147,7 @@ struct audio_driver {
     void *(*init) (Audiodev *, Error **);
     void (*fini) (void *);
 #ifdef CONFIG_GIO
-    void (*set_dbus_server) (AudioBE *s, GDBusObjectManagerServer *manager, bool p2p);
+    bool (*set_dbus_server) (AudioBE *s, GDBusObjectManagerServer *manager, bool p2p, Error **errp);
 #endif
     struct audio_pcm_ops *pcm_ops;
     int max_voices_out;
diff --git a/audio/audio.c b/audio/audio.c
index 35753ebb97..2207cad5d7 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -2232,6 +2232,20 @@ AudioBE *audio_be_by_name(const char *name, Error **errp)
     }
 }
 
+#ifdef CONFIG_GIO
+bool audio_be_set_dbus_server(AudioBE *be, GDBusObjectManagerServer *server, bool p2p, Error **errp)
+{
+    assert(be != NULL);
+
+    if (!be->drv->set_dbus_server) {
+        error_setg(errp, "Audiodev '%s' is not compatible with DBus", be->dev->id);
+        return false;
+    }
+
+    return be->drv->set_dbus_server(be, server, p2p, errp);
+}
+#endif
+
 const char *audio_fe_get_be_id(AudioFE *card)
 {
     if (card->be) {
diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index 873f76a89e..3344cbb030 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -645,8 +645,8 @@ dbus_audio_register_in_listener(AudioBE *s,
                                         arg_listener, false);
 }
 
-static void
-dbus_audio_set_server(AudioBE *s, GDBusObjectManagerServer *server, bool p2p)
+static bool
+dbus_audio_set_server(AudioBE *s, GDBusObjectManagerServer *server, bool p2p, Error **errp)
 {
     DBusAudio *da = s->drv_opaque;
 
@@ -669,6 +669,8 @@ dbus_audio_set_server(AudioBE *s, GDBusObjectManagerServer *server, bool p2p)
     g_dbus_object_skeleton_add_interface(G_DBUS_OBJECT_SKELETON(da->audio),
                                          G_DBUS_INTERFACE_SKELETON(da->iface));
     g_dbus_object_manager_server_export(da->server, da->audio);
+
+    return true;
 }
 
 static struct audio_pcm_ops dbus_pcm_ops = {
diff --git a/ui/dbus.c b/ui/dbus.c
index 962b4a8c1e..7d44287673 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -221,15 +221,9 @@ dbus_display_complete(UserCreatable *uc, Error **errp)
 
     if (dd->audiodev && *dd->audiodev) {
         AudioBE *audio_be = audio_be_by_name(dd->audiodev, errp);
-        if (!audio_be) {
+        if (!audio_be || !audio_be_set_dbus_server(audio_be, dd->server, dd->p2p, errp)) {
             return;
         }
-        if (!g_str_equal(audio_be->drv->name, "dbus")) {
-            error_setg(errp, "Audiodev '%s' is not compatible with DBus",
-                       dd->audiodev);
-            return;
-        }
-        audio_be->drv->set_dbus_server(audio_be, dd->server, dd->p2p);
     }
 
     consoles = g_array_new(FALSE, FALSE, sizeof(guint32));
-- 
2.51.0


