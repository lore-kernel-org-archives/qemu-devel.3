Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119F3D16261
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 13:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0LIx-0000hl-EF; Mon, 14 Oct 2024 09:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1t0LIw-0000h2-Ma
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:40:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1t0LIv-0003qH-4K
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728913208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Sbeeh6Nt5K4NX0Ls8O7TyT/aeG41lol8tOrg2NOQdw=;
 b=Me2r2s8dB0uKNyn5PYCAMVGmu91w7A2YH3mLx5fgTWsEWF7aNxdSlB+xvWpbQSQT5Ekwp9
 Oi9hc3j8Wg/F1Va4wConltTS5HiLpLwbLaT1uwJxyuaUndmegKGn/rHq1W0YNr4C8Ieo1r
 vPiIW/VymePyqiIWX78H8dtCuGbCdFo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-dqC3AR8lO-2S0DsJZXlPCQ-1; Mon,
 14 Oct 2024 09:40:06 -0400
X-MC-Unique: dqC3AR8lO-2S0DsJZXlPCQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 552081955D95; Mon, 14 Oct 2024 13:40:05 +0000 (UTC)
Received: from localhost (unknown [10.39.208.12])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F2A119560AA; Mon, 14 Oct 2024 13:40:03 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 05/20] ui/dbus: fix filtering all update messages
Date: Mon, 14 Oct 2024 17:39:20 +0400
Message-ID: <20241014133935.470709-6-marcandre.lureau@redhat.com>
In-Reply-To: <20241014133935.470709-1-marcandre.lureau@redhat.com>
References: <20241014133935.470709-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.076,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <20241008125028.1177932-6-marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c | 45 +++++++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 434bd608f2..c69afc05a8 100644
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
@@ -992,17 +995,35 @@ dbus_filter(GDBusConnection *connection,
             gpointer         user_data)
 {
     DBusDisplayListener *ddl = DBUS_DISPLAY_LISTENER(user_data);
-    guint32 serial;
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
+        const char *member = g_dbus_message_get_member(message);
+        static const char *const display_messages[] = {
+            "Scanout",
+            "Update",
+#ifdef CONFIG_GBM
+            "ScanoutDMABUF",
+            "UpdateDMABUF",
+#endif
+            "ScanoutMap",
+            "UpdateMap",
+            "Disable",
+            NULL,
+        };
+
+        if (g_strv_contains(display_messages, member)) {
+            trace_dbus_filter(serial, discard_serial);
+            g_object_unref(message);
+            return NULL;
+        }
     }
 
     return message;
-- 
2.47.0


