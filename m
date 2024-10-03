Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B027CF857A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 11:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swJvU-0000lt-Om; Thu, 03 Oct 2024 07:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1swJvS-0000jj-JY
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 07:23:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1swJvQ-0004sy-Vk
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 07:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727954596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z8wnl9Xm4zTLeRDOZvj5ql8gVTEheWi63WNCj5w4Mwo=;
 b=SFgG2AWHb4L0FUA/NRTOziJwjpuBuJyewN0BCqKoZUho/lzH+sC8p+0RLVrY8XKscUPnle
 VIcoK66QGlrE3+YRTwp+Bw0a1xyhCEsYHoTpcyWFB4BCVXvaFbpx/8TPPvRT55hMkoZh9l
 hgZiJ/F/Bb8w8/8oKa3RaXvxQJS118s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-HRQBx9dwPBS-iLTidsccPw-1; Thu,
 03 Oct 2024 07:23:15 -0400
X-MC-Unique: HRQBx9dwPBS-iLTidsccPw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEB1F19560AB; Thu,  3 Oct 2024 11:23:13 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D8A4E195605F; Thu,  3 Oct 2024 11:23:12 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 belmouss@redhat.com, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 05/16] ui/dbus: fix filtering all update messages
Date: Thu,  3 Oct 2024 15:22:32 +0400
Message-ID: <20241003112244.3340697-6-marcandre.lureau@redhat.com>
In-Reply-To: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
References: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Filtering pending messages when a new scanout is given shouldn't discard
pending cursor changes, for example.

Since filtering happens in a different thread, use atomic set/get.

Fixes: fa88b85dea ("ui/dbus: filter out pending messages when scanout")

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 434bd608f2..a70cad3a90 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -26,6 +26,7 @@
 #include "qapi/error.h"
 #include "sysemu/sysemu.h"
 #include "dbus.h"
+#include "glib.h"
 #ifdef G_OS_UNIX
 #include <gio/gunixfdlist.h>
 #endif
@@ -85,7 +86,7 @@ struct _DBusDisplayListener {
 #endif
 
     guint dbus_filter;
-    guint32 out_serial_to_discard;
+    guint32 display_serial_to_discard;
 };
 
 G_DEFINE_TYPE(DBusDisplayListener, dbus_display_listener, G_TYPE_OBJECT)
@@ -93,10 +94,12 @@ G_DEFINE_TYPE(DBusDisplayListener, dbus_display_listener, G_TYPE_OBJECT)
 static void dbus_gfx_update(DisplayChangeListener *dcl,
                             int x, int y, int w, int h);
 
-static void ddl_discard_pending_messages(DBusDisplayListener *ddl)
+static void ddl_discard_display_messages(DBusDisplayListener *ddl)
 {
-    ddl->out_serial_to_discard = g_dbus_connection_get_last_serial(
+    guint32 serial = g_dbus_connection_get_last_serial(
         g_dbus_proxy_get_connection(G_DBUS_PROXY(ddl->proxy)));
+
+    g_atomic_int_set(&ddl->display_serial_to_discard, serial);
 }
 
 #ifdef CONFIG_OPENGL
@@ -290,7 +293,7 @@ static void dbus_scanout_dmabuf(DisplayChangeListener *dcl,
         return;
     }
 
-    ddl_discard_pending_messages(ddl);
+    ddl_discard_display_messages(ddl);
 
     width = qemu_dmabuf_get_width(dmabuf);
     height = qemu_dmabuf_get_height(dmabuf);
@@ -338,7 +341,7 @@ static bool dbus_scanout_map(DBusDisplayListener *ddl)
         return false;
     }
 
-    ddl_discard_pending_messages(ddl);
+    ddl_discard_display_messages(ddl);
 
     if (!qemu_dbus_display1_listener_win32_map_call_scanout_map_sync(
             ddl->map_proxy,
@@ -401,7 +404,7 @@ dbus_scanout_share_d3d_texture(
         return false;
     }
 
-    ddl_discard_pending_messages(ddl);
+    ddl_discard_display_messages(ddl);
 
     qemu_dbus_display1_listener_win32_d3d11_call_scanout_texture2d(
         ddl->d3d11_proxy,
@@ -659,7 +662,7 @@ static void ddl_scanout(DBusDisplayListener *ddl)
         surface_stride(ddl->ds) * surface_height(ddl->ds), TRUE,
         (GDestroyNotify)pixman_image_unref, pixman_image_ref(ddl->ds->image));
 
-    ddl_discard_pending_messages(ddl);
+    ddl_discard_display_messages(ddl);
 
     qemu_dbus_display1_listener_call_scanout(
         ddl->proxy, surface_width(ddl->ds), surface_height(ddl->ds),
@@ -992,17 +995,34 @@ dbus_filter(GDBusConnection *connection,
             gpointer         user_data)
 {
     DBusDisplayListener *ddl = DBUS_DISPLAY_LISTENER(user_data);
-    guint32 serial;
+    const gchar *member = NULL;
+    guint32 serial, discard_serial;
 
     if (incoming) {
         return message;
     }
 
     serial = g_dbus_message_get_serial(message);
-    if (serial <= ddl->out_serial_to_discard) {
-        trace_dbus_filter(serial, ddl->out_serial_to_discard);
-        g_object_unref(message);
-        return NULL;
+
+    discard_serial = g_atomic_int_get(&ddl->display_serial_to_discard);
+    if (serial <= discard_serial) {
+        member = g_dbus_message_get_member(message);
+        if (g_strv_contains((const gchar *[]) {
+                "Scanout",
+                "Update",
+#ifdef CONFIG_GBM
+                "ScanoutDMABUF",
+                "UpdateDMABUF",
+#endif
+                "ScanoutMap",
+                "UpdateMap",
+                "Disable",
+                NULL,
+            }, member)) {
+            trace_dbus_filter(serial, discard_serial);
+            g_object_unref(message);
+            return NULL;
+        }
     }
 
     return message;
-- 
2.45.2.827.g557ae147e6


