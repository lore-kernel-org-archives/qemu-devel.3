Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C49CCF9EB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 06:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEixK-0002QJ-Bf; Fri, 31 Oct 2025 02:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vEixJ-0002PZ-LJ
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 02:49:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vEixD-00044K-8H
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 02:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761893382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3vcN7c2q7ApEIuezAycDq9xRQa4lV6TBvMpmZRZ04JE=;
 b=CACT38tYHCKEBOfmK79AHs86kQziizb5B5GvdGgC1Jy+1Ef8kyhV0vfz7QtFM7uq72GOTN
 dVisaVO/inIET6LKavfV/npzLXVmOaM4+LDEfTT6Jwjt/9WOaQCApGfASsIKa/6zUlBYDo
 Ei1kq5fya8L0N/WbRsT1/AkVILKnlLA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-VOH_7-ToMoW4PieoOAdPAg-1; Fri,
 31 Oct 2025 02:49:39 -0400
X-MC-Unique: VOH_7-ToMoW4PieoOAdPAg-1
X-Mimecast-MFC-AGG-ID: VOH_7-ToMoW4PieoOAdPAg_1761893378
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EB881955DB5; Fri, 31 Oct 2025 06:49:38 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2BC60180035A; Fri, 31 Oct 2025 06:49:36 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 28/36] audio/dbus: use a helper function to set the backend
 dbus server
Date: Fri, 31 Oct 2025 10:46:21 +0400
Message-ID: <20251031064631.134651-29-marcandre.lureau@redhat.com>
In-Reply-To: <20251031064631.134651-1-marcandre.lureau@redhat.com>
References: <20251031064631.134651-1-marcandre.lureau@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 audio/audio.h     |  9 +++++++++
 audio/audio_int.h |  5 ++++-
 audio/audio.c     | 17 +++++++++++++++++
 audio/dbusaudio.c |  9 +++++++--
 ui/dbus.c         |  8 +-------
 5 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index 0a016bdabc..08753f621a 100644
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
 
@@ -162,6 +165,12 @@ void audio_help(void);
 AudioBackend *audio_be_by_name(const char *name, Error **errp);
 AudioBackend *audio_get_default_audio_be(Error **errp);
 const char *audio_be_get_id(AudioBackend *be);
+#ifdef CONFIG_GIO
+bool audio_be_set_dbus_server(AudioBackend *be,
+                              GDBusObjectManagerServer *server,
+                              bool p2p,
+                              Error **errp);
+#endif
 
 #define DEFINE_AUDIO_PROPERTIES(_s, _f)         \
     DEFINE_PROP_AUDIODEV("audiodev", _s, _f)
diff --git a/audio/audio_int.h b/audio/audio_int.h
index c4453b3a29..d66f7aac32 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -148,7 +148,10 @@ struct audio_driver {
     void *(*init) (Audiodev *, Error **);
     void (*fini) (void *);
 #ifdef CONFIG_GIO
-    void (*set_dbus_server)(AudioBackend *s, GDBusObjectManagerServer *manager, bool p2p);
+    bool (*set_dbus_server)(AudioBackend *be,
+                            GDBusObjectManagerServer *manager,
+                            bool p2p,
+                            Error **errp);
 #endif
     struct audio_pcm_ops *pcm_ops;
     int max_voices_out;
diff --git a/audio/audio.c b/audio/audio.c
index d9a5695eb8..3229829bef 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -2223,6 +2223,23 @@ AudioBackend *audio_be_by_name(const char *name, Error **errp)
     }
 }
 
+#ifdef CONFIG_GIO
+bool audio_be_set_dbus_server(AudioBackend *be,
+                              GDBusObjectManagerServer *server,
+                              bool p2p,
+                              Error **errp)
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
 const char *audio_be_get_id(AudioBackend *be)
 {
     if (be) {
diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index 49cef38e3e..c97c34b486 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -645,8 +645,11 @@ dbus_audio_register_in_listener(AudioBackend *s,
                                         arg_listener, false);
 }
 
-static void
-dbus_audio_set_server(AudioBackend *s, GDBusObjectManagerServer *server, bool p2p)
+static bool
+dbus_audio_set_server(AudioBackend *s,
+                      GDBusObjectManagerServer *server,
+                      bool p2p,
+                      Error **errp)
 {
     DBusAudio *da = s->drv_opaque;
 
@@ -669,6 +672,8 @@ dbus_audio_set_server(AudioBackend *s, GDBusObjectManagerServer *server, bool p2
     g_dbus_object_skeleton_add_interface(G_DBUS_OBJECT_SKELETON(da->audio),
                                          G_DBUS_INTERFACE_SKELETON(da->iface));
     g_dbus_object_manager_server_export(da->server, da->audio);
+
+    return true;
 }
 
 static struct audio_pcm_ops dbus_pcm_ops = {
diff --git a/ui/dbus.c b/ui/dbus.c
index 84cff47ec7..fbe108af1e 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -221,15 +221,9 @@ dbus_display_complete(UserCreatable *uc, Error **errp)
 
     if (dd->audiodev && *dd->audiodev) {
         AudioBackend *audio_be = audio_be_by_name(dd->audiodev, errp);
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
2.51.1


