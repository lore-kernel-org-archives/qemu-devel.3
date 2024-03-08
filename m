Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFF7C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riW0x-0006UF-Fv; Fri, 08 Mar 2024 03:55:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1riW0t-0006TB-5D
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:55:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1riW0o-00083L-NO
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709888129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ObhuA3H8+Qw8iGJTgr6GIHo8x03k3oRryE1X3xAmIPA=;
 b=Wy9P/mmHvOA/ckS8ESsI2rLFCLvhSnbUmdiB3nmjHA4YCx0wempOkUpK7B3aYteIGH10rY
 9bUI5rHv5xfpklHivP9FAXoSR6/JpYKrBNTNAoxRnByo+t+SizgeeJpsw3avj8zXfk9u2+
 D+QZroidJE/0XcGIwpRtw5doPwS6eJE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-CQ22z39hPUS125UoA-V7qA-1; Fri, 08 Mar 2024 03:55:27 -0500
X-MC-Unique: CQ22z39hPUS125UoA-V7qA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0857C186E241
 for <qemu-devel@nongnu.org>; Fri,  8 Mar 2024 08:55:27 +0000 (UTC)
Received: from localhost (unknown [10.39.208.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 148AB37F6;
 Fri,  8 Mar 2024 08:55:24 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/2] ui/dbus: filter out pending messages when scanout
Date: Fri,  8 Mar 2024 12:55:14 +0400
Message-ID: <20240308085515.2445091-3-marcandre.lureau@redhat.com>
In-Reply-To: <20240308085515.2445091-1-marcandre.lureau@redhat.com>
References: <20240308085515.2445091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The "Listener" connection, being private and under the control of the
qemu display, allows for the optimization of discarding pending
intermediary messages when queuing a new scanout. This ensures that the
client receives only the latest scanout update, improving communication
efficiency.

While the current implementation does not provide a mechanism for
clients who may wish to receive all updates, making this behavior
optional could be considered in the future. For now, adopting this new
default behavior accelerates the communication process without a
guarantee of delivering all updates.

The filter is removed when the connection is dropped.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c | 40 ++++++++++++++++++++++++++++++++++++++++
 ui/trace-events    |  1 +
 2 files changed, 41 insertions(+)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 3f4529dbbd..4a0a5d78f9 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -83,6 +83,9 @@ struct _DBusDisplayListener {
     egl_fb fb;
 #endif
 #endif
+
+    guint dbus_filter;
+    guint32 out_serial_to_discard;
 };
 
 G_DEFINE_TYPE(DBusDisplayListener, dbus_display_listener, G_TYPE_OBJECT)
@@ -90,6 +93,12 @@ G_DEFINE_TYPE(DBusDisplayListener, dbus_display_listener, G_TYPE_OBJECT)
 static void dbus_gfx_update(DisplayChangeListener *dcl,
                             int x, int y, int w, int h);
 
+static void ddl_discard_pending_messages(DBusDisplayListener *ddl)
+{
+    ddl->out_serial_to_discard = g_dbus_connection_get_last_serial(
+        g_dbus_proxy_get_connection(G_DBUS_PROXY(ddl->proxy)));
+}
+
 #ifdef CONFIG_OPENGL
 static void dbus_scanout_disable(DisplayChangeListener *dcl)
 {
@@ -276,6 +285,8 @@ static void dbus_scanout_dmabuf(DisplayChangeListener *dcl,
         return;
     }
 
+    ddl_discard_pending_messages(ddl);
+
     /* FIXME: add missing x/y/w/h support */
     qemu_dbus_display1_listener_call_scanout_dmabuf(
         ddl->proxy,
@@ -323,6 +334,8 @@ static bool dbus_scanout_map(DBusDisplayListener *ddl)
         return false;
     }
 
+    ddl_discard_pending_messages(ddl);
+
     if (!qemu_dbus_display1_listener_win32_map_call_scanout_map_sync(
             ddl->map_proxy,
             GPOINTER_TO_UINT(target_handle),
@@ -384,6 +397,8 @@ dbus_scanout_share_d3d_texture(
         return false;
     }
 
+    ddl_discard_pending_messages(ddl);
+
     qemu_dbus_display1_listener_win32_d3d11_call_scanout_texture2d(
         ddl->d3d11_proxy,
         GPOINTER_TO_INT(target_handle),
@@ -639,6 +654,8 @@ static void ddl_scanout(DBusDisplayListener *ddl)
         surface_stride(ddl->ds) * surface_height(ddl->ds), TRUE,
         (GDestroyNotify)pixman_image_unref, pixman_image_ref(ddl->ds->image));
 
+    ddl_discard_pending_messages(ddl);
+
     qemu_dbus_display1_listener_call_scanout(
         ddl->proxy, surface_width(ddl->ds), surface_height(ddl->ds),
         surface_stride(ddl->ds), surface_format(ddl->ds), v_data,
@@ -963,6 +980,28 @@ dbus_display_listener_setup_shared_map(DBusDisplayListener *ddl)
 #endif
 }
 
+static GDBusMessage *
+dbus_filter(GDBusConnection *connection,
+            GDBusMessage    *message,
+            gboolean         incoming,
+            gpointer         user_data)
+{
+    DBusDisplayListener *ddl = DBUS_DISPLAY_LISTENER(user_data);
+    guint32 serial;
+
+    if (incoming) {
+        return message;
+    }
+
+    serial = g_dbus_message_get_serial(message);
+    if (serial <= ddl->out_serial_to_discard) {
+        trace_dbus_filter(serial, ddl->out_serial_to_discard);
+        return NULL;
+    }
+
+    return message;
+}
+
 DBusDisplayListener *
 dbus_display_listener_new(const char *bus_name,
                           GDBusConnection *conn,
@@ -987,6 +1026,7 @@ dbus_display_listener_new(const char *bus_name,
         return NULL;
     }
 
+    ddl->dbus_filter = g_dbus_connection_add_filter(conn, dbus_filter, g_object_ref(ddl), g_object_unref);
     ddl->bus_name = g_strdup(bus_name);
     ddl->conn = conn;
     ddl->console = console;
diff --git a/ui/trace-events b/ui/trace-events
index 16c35c9fd6..e6a2894303 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -161,6 +161,7 @@ dbus_clipboard_register(const char *bus_name) "peer %s"
 dbus_clipboard_unregister(const char *bus_name) "peer %s"
 dbus_scanout_texture(uint32_t tex_id, bool backing_y_0_top, uint32_t backing_width, uint32_t backing_height, uint32_t x, uint32_t y, uint32_t w, uint32_t h) "tex_id:%u y0top:%d back:%ux%u %u+%u-%ux%u"
 dbus_gl_gfx_switch(void *p) "surf: %p"
+dbus_filter(unsigned int serial, unsigned int filter) "serial=%u (<= %u)"
 
 # egl-helpers.c
 egl_init_d3d11_device(void *p) "d3d device: %p"
-- 
2.44.0


