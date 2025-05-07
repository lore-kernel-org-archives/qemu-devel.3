Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2378C369DC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 05:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCXaY-0003Zv-U2; Wed, 07 May 2025 01:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uCXaV-0003Wl-OC
 for qemu-devel@nongnu.org; Wed, 07 May 2025 01:44:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uCXaT-0004Jq-Ku
 for qemu-devel@nongnu.org; Wed, 07 May 2025 01:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746596696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ovJe1IC+ycKR7ryCoFGIAypKjcLa9zhLl0efnslCQcQ=;
 b=TAfY1L3IpHgfHDZVDrgtSRCddOux3rNWhTbzFUMFQt7nlLElNo4HT+SA2PEPrfqQPmZrXU
 x9Fvz7eXm1tfHC11YyTk3RsEW5NYUtxlB5Vo2EKXyYcNXNvst4goYQIJIxU3c+pL9tBCEi
 En8GIw4TSI0ZB1cx7QY8iVJaB4RWG4U=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-o-wK8WIbOymtoQZy0glFHQ-1; Wed,
 07 May 2025 01:44:53 -0400
X-MC-Unique: o-wK8WIbOymtoQZy0glFHQ-1
X-Mimecast-MFC-AGG-ID: o-wK8WIbOymtoQZy0glFHQ_1746596692
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D0421955D79; Wed,  7 May 2025 05:44:52 +0000 (UTC)
Received: from localhost (unknown [10.45.242.19])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 13A3B30001A1; Wed,  7 May 2025 05:44:49 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Qiang Yu <yuq825@gmail.com>
Subject: [PULL 5/6] ui/dbus: change dbus ScanoutDMABUF interface
Date: Wed,  7 May 2025 09:44:13 +0400
Message-ID: <20250507054414.2284129-6-marcandre.lureau@redhat.com>
In-Reply-To: <20250507054414.2284129-1-marcandre.lureau@redhat.com>
References: <20250507054414.2284129-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Qiang Yu <yuq825@gmail.com>

To handle multi plane.

v3:
  * rename interface
  * add x/y/backing_width/backing_height arg

v2:
  * use new dmabuf API and check length

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Qiang Yu <yuq825@gmail.com>
Message-ID: <20250327025848.46962-6-yuq825@gmail.com>
[ Fix style ]
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c   | 114 ++++++++++++++++++++++++++++++++++++++++---
 ui/dbus-display1.xml |  45 +++++++++++++++++
 2 files changed, 152 insertions(+), 7 deletions(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 90147972cd..42875b8eed 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -85,6 +85,7 @@ struct _DBusDisplayListener {
 #endif
 #else /* !WIN32 */
     QemuDBusDisplay1ListenerUnixMap *map_proxy;
+    QemuDBusDisplay1ListenerUnixScanoutDMABUF2 *scanout_dmabuf_v2_proxy;
 #endif
 
     guint dbus_filter;
@@ -288,10 +289,9 @@ static void dbus_call_update_gl(DisplayChangeListener *dcl,
 }
 
 #ifdef CONFIG_GBM
-static void dbus_scanout_dmabuf(DisplayChangeListener *dcl,
-                                QemuDmaBuf *dmabuf)
+static void dbus_scanout_dmabuf_v1(DBusDisplayListener *ddl,
+                                   QemuDmaBuf *dmabuf)
 {
-    DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
     g_autoptr(GError) err = NULL;
     g_autoptr(GUnixFDList) fd_list = NULL;
     int fd;
@@ -322,6 +322,87 @@ static void dbus_scanout_dmabuf(DisplayChangeListener *dcl,
         y0_top, G_DBUS_CALL_FLAGS_NONE,
         -1, fd_list, NULL, NULL, NULL);
 }
+
+static void dbus_scanout_dmabuf_v2(DBusDisplayListener *ddl,
+                                   QemuDmaBuf *dmabuf)
+{
+    g_autoptr(GError) err = NULL;
+    g_autoptr(GUnixFDList) fd_list = NULL;
+    int i, fd_index[DMABUF_MAX_PLANES], num_fds;
+    uint32_t x, y, width, height, fourcc, backing_width, backing_height;
+    GVariant *fd, *offset, *stride, *fd_handles[DMABUF_MAX_PLANES];
+    uint64_t modifier;
+    bool y0_top;
+    int nfds, noffsets, nstrides;
+    const int *fds = qemu_dmabuf_get_fds(dmabuf, &nfds);
+    const uint32_t *offsets = qemu_dmabuf_get_offsets(dmabuf, &noffsets);
+    const uint32_t *strides = qemu_dmabuf_get_strides(dmabuf, &nstrides);
+    uint32_t num_planes = qemu_dmabuf_get_num_planes(dmabuf);
+
+    assert(nfds >= num_planes);
+    assert(noffsets >= num_planes);
+    assert(nstrides >= num_planes);
+
+    fd_list = g_unix_fd_list_new();
+
+    for (num_fds = 0; num_fds < num_planes; num_fds++) {
+        int plane_fd = fds[num_fds];
+
+        if (plane_fd < 0) {
+            break;
+        }
+
+        fd_index[num_fds] = g_unix_fd_list_append(fd_list, plane_fd, &err);
+        if (fd_index[num_fds] < 0) {
+            error_report("Failed to setup dmabuf fdlist: %s", err->message);
+            return;
+        }
+    }
+
+    ddl_discard_display_messages(ddl);
+
+    x = qemu_dmabuf_get_x(dmabuf);
+    y = qemu_dmabuf_get_y(dmabuf);
+    width = qemu_dmabuf_get_width(dmabuf);
+    height = qemu_dmabuf_get_height(dmabuf);
+    fourcc = qemu_dmabuf_get_fourcc(dmabuf);
+    backing_width = qemu_dmabuf_get_backing_width(dmabuf);
+    backing_height = qemu_dmabuf_get_backing_height(dmabuf);
+    modifier = qemu_dmabuf_get_modifier(dmabuf);
+    y0_top = qemu_dmabuf_get_y0_top(dmabuf);
+
+    offset = g_variant_new_fixed_array(G_VARIANT_TYPE_UINT32,
+                                       offsets, num_planes, sizeof(uint32_t));
+    stride = g_variant_new_fixed_array(G_VARIANT_TYPE_UINT32,
+                                       strides, num_planes, sizeof(uint32_t));
+
+    for (i = 0; i < num_fds; i++) {
+        fd_handles[i] = g_variant_new_handle(fd_index[i]);
+    }
+    fd = g_variant_new_array(G_VARIANT_TYPE_HANDLE, fd_handles, num_fds);
+
+    qemu_dbus_display1_listener_unix_scanout_dmabuf2_call_scanout_dmabuf2(
+        ddl->scanout_dmabuf_v2_proxy, fd, x, y, width, height, offset, stride,
+        num_planes, fourcc, backing_width, backing_height, modifier, y0_top,
+        G_DBUS_CALL_FLAGS_NONE, -1, fd_list, NULL, NULL, NULL);
+}
+
+static void dbus_scanout_dmabuf(DisplayChangeListener *dcl,
+                                QemuDmaBuf *dmabuf)
+{
+    DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
+
+    if (ddl->scanout_dmabuf_v2_proxy) {
+        dbus_scanout_dmabuf_v2(ddl, dmabuf);
+    } else {
+        if (qemu_dmabuf_get_num_planes(dmabuf) > 1) {
+            g_debug("org.qemu.Display1.Listener.ScanoutDMABUF "
+                    "does not support mutli plane");
+            return;
+        }
+        dbus_scanout_dmabuf_v1(ddl, dmabuf);
+    }
+}
 #endif /* GBM */
 #endif /* OPENGL */
 
@@ -514,10 +595,6 @@ static void dbus_scanout_texture(DisplayChangeListener *dcl,
         error_report("%s: failed to export dmabuf for texture", __func__);
         return;
     }
-    if (num_planes > 1) {
-        error_report("%s: does not support multi-plane dmabuf", __func__);
-        return;
-    }
     dmabuf = qemu_dmabuf_new(w, h, offset, stride, x, y, backing_width,
                              backing_height, fourcc, modifier, fd, num_planes,
                              false, backing_y_0_top);
@@ -886,6 +963,8 @@ dbus_display_listener_dispose(GObject *object)
 #ifdef CONFIG_OPENGL
     egl_fb_destroy(&ddl->fb);
 #endif
+#else /* !WIN32 */
+    g_clear_object(&ddl->scanout_dmabuf_v2_proxy);
 #endif
 
     G_OBJECT_CLASS(dbus_display_listener_parent_class)->dispose(object);
@@ -1074,6 +1153,26 @@ dbus_display_listener_setup_shared_map(DBusDisplayListener *ddl)
 #endif
 }
 
+static void dbus_display_listener_setup_scanout_dmabuf_v2(DBusDisplayListener *ddl)
+{
+#ifndef WIN32
+    g_autoptr(GError) err = NULL;
+
+    if (!dbus_display_listener_implements(
+            ddl, "org.qemu.Display1.Listener.Unix.ScanoutDMABUF2")) {
+        return;
+    }
+    ddl->scanout_dmabuf_v2_proxy =
+        qemu_dbus_display1_listener_unix_scanout_dmabuf2_proxy_new_sync(
+            ddl->conn, G_DBUS_PROXY_FLAGS_DO_NOT_AUTO_START, NULL,
+            "/org/qemu/Display1/Listener", NULL, &err);
+    if (!ddl->scanout_dmabuf_v2_proxy) {
+        g_debug("Failed to setup Unix scanout dmabuf v2 proxy: %s", err->message);
+        return;
+    }
+#endif
+}
+
 static GDBusMessage *
 dbus_filter(GDBusConnection *connection,
             GDBusMessage    *message,
@@ -1162,6 +1261,7 @@ dbus_display_listener_new(const char *bus_name,
     dbus_display_listener_setup_shared_map(ddl);
     trace_dbus_can_share_map(ddl->can_share_map);
     dbus_display_listener_setup_d3d11(ddl);
+    dbus_display_listener_setup_scanout_dmabuf_v2(ddl);
 
     con = qemu_console_lookup_by_index(dbus_display_console_get_index(console));
     assert(con);
diff --git a/ui/dbus-display1.xml b/ui/dbus-display1.xml
index 72deefa455..4a41a7e0f3 100644
--- a/ui/dbus-display1.xml
+++ b/ui/dbus-display1.xml
@@ -614,6 +614,51 @@
     </method>
   </interface>
 
+  <!--
+      org.qemu.Display1.Listener.Unix.ScanoutDMABUF2:
+
+      This optional client-side interface can complement
+      org.qemu.Display1.Listener on ``/org/qemu/Display1/Listener`` for
+      Unix-specific DMABUF scanout setup which support multi plane.
+  -->
+  <?if $(env.HOST_OS) != windows?>
+  <interface name="org.qemu.Display1.Listener.Unix.ScanoutDMABUF2">
+    <!--
+        ScanoutDMABUF2:
+        @dmabuf: DMABUF file descriptor of each plane.
+        @x: display x offset, in pixels
+        @y: display y offset, in pixels
+        @width: display width, in pixels.
+        @height: display height, in pixels.
+        @offset: offset of each plane, in bytes.
+        @stride: stride of each plane, in bytes.
+        @num_planes: plane number.
+        @fourcc: DMABUF fourcc.
+        @backing_width: backing framebuffer width, in pixels
+        @backing_height: backing framebuffer height, in pixels
+        @modifier: DMABUF modifier.
+        @y0_top: whether Y position 0 is the top or not.
+
+        Resize and update the display content with DMABUF.
+    -->
+    <method name="ScanoutDMABUF2">
+      <arg type="ah" name="dmabuf" direction="in"/>
+      <arg type="u" name="x" direction="in"/>
+      <arg type="u" name="y" direction="in"/>
+      <arg type="u" name="width" direction="in"/>
+      <arg type="u" name="height" direction="in"/>
+      <arg type="au" name="offset" direction="in"/>
+      <arg type="au" name="stride" direction="in"/>
+      <arg type="u" name="num_planes" direction="in"/>
+      <arg type="u" name="fourcc" direction="in"/>
+      <arg type="u" name="backing_width" direction="in"/>
+      <arg type="u" name="backing_height" direction="in"/>
+      <arg type="t" name="modifier" direction="in"/>
+      <arg type="b" name="y0_top" direction="in"/>
+    </method>
+  </interface>
+  <?endif?>
+
   <!--
       org.qemu.Display1.Clipboard:
 
-- 
2.49.0


