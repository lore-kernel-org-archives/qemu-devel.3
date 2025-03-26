Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D782C3600C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 09:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txNA0-000103-3s; Wed, 26 Mar 2025 05:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1txN9u-0000zF-0T
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:34:54 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1txN9r-0003XL-Tp
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:34:49 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-224171d6826so64725175ad.3
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 02:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742981686; x=1743586486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zXugeWpc+Q4q1zkES6fx7VpgJwCLDDyqvNSu0wIXzFo=;
 b=kUwa1BRSUrHhAtHIkRcM1Gs39Lo+GETIkUb0WDpUIJFpyAceRHWjHflezlB/q2kicp
 BxKNLRKbfNniyYpiI3x2PchxkqbjTbkQ5tYJbMQH601uM4EC+QuMpLLi6ghxoJJHKxzV
 /Wz3akJMyIIdgkV6VN+pFKVQaV0KHWjaG1wU/oKYDYswGORqb/dRCYqRbNfSkFDiKb4E
 YXCwlK1hilm3UQRK2gS3sKAXVrrvWuwryQc6ks3wuK9YF0/rcYLld03veQ8Bxn6iMnBz
 KHglh0ds0gpe3XAWFzlzkC9JiTRIFM9tmZvLjYl18y4ZEfttFKuFkBI92iNhkasn00PE
 9T4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742981686; x=1743586486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zXugeWpc+Q4q1zkES6fx7VpgJwCLDDyqvNSu0wIXzFo=;
 b=vyg7Hxdyxbvspu9C5ZNoITz8Swx2UkYdjchHUHIUE93//nVy0VAhVJb4BCr8RaD3Hz
 PpMS5wO3azUzF3gj05HKYuVaijf1KqItRyJj7/y/dI4kffc6T310Gluw5nJoXd0O7yHb
 Wrcc9jQ91RvSdhAyuQMiHa+TTQbzKsgKUQ6bZDzQX7+pGUc9HE2G7pLfwdjRWH4aobsZ
 ZNO2CfyXM+Fg//vcXIRhvPrMr0nayktbNTsedgQhY6+OVGw8c8jSfyQzAyyEPfkNITPn
 ++rU5UN/6U8j0tWCAV2ham3W+g+tkLl7nW13MhLdskiOKjqzDu4mzIKu2Z36Hpo/yvy4
 MPBQ==
X-Gm-Message-State: AOJu0YxXu6ocb1xjAWNrAdnga6EgoBu2VOEjepYlGc4zfBv/p+fcEOt7
 nmfmlCaa3SHmHWDKc2+Cm5MLW1QfEhAfGpq5JKZjVVyBNuaFVpxeoVEBS5s6
X-Gm-Gg: ASbGncsgN98ahl8AJ4YDNbvbFUooLmyttYM5u17rYQ5H0gkfJDzI2qIiou2Zd2oYlL5
 c49NbpcA7iwc4cF6T4Zjm6WASISFDvuKZPpDOX5XCJIFcIFl6SdoGyl0uy4VNyiWCzJcdjcWtoM
 AuGfWZmrRnZEaqaud5rl3FV9Qh9eHP279H6Zbr4DYFSce1XopPDL6ynCD36c80/gQD59zEj10EL
 /x+zmUBPS1Y955x0HzCA5L6LnwpZgNBOJqA0Tqmb28YOzo0Us9rv5Rle2F/JWVIycV+WpsUZHAB
 mdD0C7T4LYTkIzP29JfoyMajU6lapGAFIFhkd+UfBfXfW6uIiSpkmyDD00jnVdutZQY3eVldZf8
 UWwP9/a9kxgO7DGHptZj8
X-Google-Smtp-Source: AGHT+IEG2RwX8EXpbq0HPAroIcGiT/iQF9F3ZQAXoE2eR2TmdslMsqNkWZouVCCmONmVcXFznQUywg==
X-Received: by 2002:a05:6a00:1409:b0:737:e73:f64b with SMTP id
 d2e1a72fcca58-7390593b7ffmr29348091b3a.1.1742981686106; 
 Wed, 26 Mar 2025 02:34:46 -0700 (PDT)
Received: from localhost.localdomain (awork062150.netvigator.com.
 [203.198.28.150]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73905fd57f7sm11729684b3a.44.2025.03.26.02.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 02:34:45 -0700 (PDT)
From: yuq825@gmail.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Qiang Yu <yuq825@gmail.com>
Subject: [PATCH v2 5/6] ui/dbus: change dbus ScanoutDMABUF interface
Date: Wed, 26 Mar 2025 17:34:17 +0800
Message-ID: <20250326093418.397269-6-yuq825@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326093418.397269-1-yuq825@gmail.com>
References: <20250326093418.397269-1-yuq825@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=yuq825@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

v2:
  * use new dmabuf API and check length

Signed-off-by: Qiang Yu <yuq825@gmail.com>
---
 ui/dbus-display1.xml |  37 +++++++++++++++
 ui/dbus-listener.c   | 108 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 138 insertions(+), 7 deletions(-)

diff --git a/ui/dbus-display1.xml b/ui/dbus-display1.xml
index 72deefa455..c1d1a402b7 100644
--- a/ui/dbus-display1.xml
+++ b/ui/dbus-display1.xml
@@ -614,6 +614,43 @@
     </method>
   </interface>
 
+  <!--
+      org.qemu.Display1.Listener.Unix.MultiPlane:
+
+      This optional client-side interface can complement
+      org.qemu.Display1.Listener on ``/org/qemu/Display1/Listener`` for
+      Unix-specific multi plane DMABUF scanout setup.
+  -->
+  <?if $(env.HOST_OS) != windows?>
+  <interface name="org.qemu.Display1.Listener.Unix.MultiPlane">
+    <!--
+        ScanoutDMABUF2:
+        @dmabuf: DMABUF file descriptor of each plane.
+        @width: display width, in pixels.
+        @height: display height, in pixels.
+        @offset: offset of each plane, in bytes.
+        @stride: stride of each plane, in bytes.
+        @num_planes: plane number.
+        @fourcc: DMABUF fourcc.
+        @modifier: DMABUF modifier.
+        @y0_top: whether Y position 0 is the top or not.
+
+        Resize and update the display content with DMABUF.
+    -->
+    <method name="ScanoutDMABUF2">
+      <arg type="ah" name="dmabuf" direction="in"/>
+      <arg type="u" name="width" direction="in"/>
+      <arg type="u" name="height" direction="in"/>
+      <arg type="au" name="offset" direction="in"/>
+      <arg type="au" name="stride" direction="in"/>
+      <arg type="u" name="num_planes" direction="in"/>
+      <arg type="u" name="fourcc" direction="in"/>
+      <arg type="t" name="modifier" direction="in"/>
+      <arg type="b" name="y0_top" direction="in"/>
+    </method>
+  </interface>
+  <?endif?>
+
   <!--
       org.qemu.Display1.Clipboard:
 
diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 90147972cd..a225890084 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -85,6 +85,7 @@ struct _DBusDisplayListener {
 #endif
 #else /* !WIN32 */
     QemuDBusDisplay1ListenerUnixMap *map_proxy;
+    QemuDBusDisplay1ListenerUnixMultiPlane *multi_plane_proxy;
 #endif
 
     guint dbus_filter;
@@ -288,10 +289,9 @@ static void dbus_call_update_gl(DisplayChangeListener *dcl,
 }
 
 #ifdef CONFIG_GBM
-static void dbus_scanout_dmabuf(DisplayChangeListener *dcl,
-                                QemuDmaBuf *dmabuf)
+static void dbus_scanout_dmabuf_single_plane(DBusDisplayListener *ddl,
+                                             QemuDmaBuf *dmabuf)
 {
-    DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
     g_autoptr(GError) err = NULL;
     g_autoptr(GUnixFDList) fd_list = NULL;
     int fd;
@@ -322,6 +322,81 @@ static void dbus_scanout_dmabuf(DisplayChangeListener *dcl,
         y0_top, G_DBUS_CALL_FLAGS_NONE,
         -1, fd_list, NULL, NULL, NULL);
 }
+
+static void dbus_scanout_dmabuf_multi_plane(DBusDisplayListener *ddl,
+                                            QemuDmaBuf *dmabuf)
+{
+    g_autoptr(GError) err = NULL;
+    g_autoptr(GUnixFDList) fd_list = NULL;
+    int i, fd_index[DMABUF_MAX_PLANES], num_fds;
+    uint32_t width, height, fourcc;
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
+        if (plane_fd < 0)
+            break;
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
+    width = qemu_dmabuf_get_width(dmabuf);
+    height = qemu_dmabuf_get_height(dmabuf);
+    fourcc = qemu_dmabuf_get_fourcc(dmabuf);
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
+    qemu_dbus_display1_listener_unix_multi_plane_call_scanout_dmabuf2(
+        ddl->multi_plane_proxy, fd, width, height, offset, stride, num_planes,
+        fourcc, modifier, y0_top, G_DBUS_CALL_FLAGS_NONE,
+        -1, fd_list, NULL, NULL, NULL);
+}
+
+static void dbus_scanout_dmabuf(DisplayChangeListener *dcl,
+                                QemuDmaBuf *dmabuf)
+{
+    DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
+
+    if (ddl->multi_plane_proxy) {
+        dbus_scanout_dmabuf_multi_plane(ddl, dmabuf);
+    } else {
+        if (qemu_dmabuf_get_num_planes(dmabuf) > 1) {
+            g_debug("org.qemu.Display1.Listener.ScanoutDMABUF does not support mutli plane");
+            return;
+        }
+        dbus_scanout_dmabuf_single_plane(ddl, dmabuf);
+    }
+}
 #endif /* GBM */
 #endif /* OPENGL */
 
@@ -514,10 +589,6 @@ static void dbus_scanout_texture(DisplayChangeListener *dcl,
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
@@ -886,6 +957,8 @@ dbus_display_listener_dispose(GObject *object)
 #ifdef CONFIG_OPENGL
     egl_fb_destroy(&ddl->fb);
 #endif
+#else /* !WIN32 */
+    g_clear_object(&ddl->multi_plane_proxy);
 #endif
 
     G_OBJECT_CLASS(dbus_display_listener_parent_class)->dispose(object);
@@ -1074,6 +1147,26 @@ dbus_display_listener_setup_shared_map(DBusDisplayListener *ddl)
 #endif
 }
 
+static void dbus_display_listener_setup_multi_plane(DBusDisplayListener *ddl)
+{
+#ifndef WIN32
+    g_autoptr(GError) err = NULL;
+
+    if (!dbus_display_listener_implements(
+            ddl, "org.qemu.Display1.Listener.Unix.MultiPlane")) {
+        return;
+    }
+    ddl->multi_plane_proxy =
+        qemu_dbus_display1_listener_unix_multi_plane_proxy_new_sync(
+            ddl->conn, G_DBUS_PROXY_FLAGS_DO_NOT_AUTO_START, NULL,
+            "/org/qemu/Display1/Listener", NULL, &err);
+    if (!ddl->multi_plane_proxy) {
+        g_debug("Failed to setup Unix multi plane proxy: %s", err->message);
+        return;
+    }
+#endif
+}
+
 static GDBusMessage *
 dbus_filter(GDBusConnection *connection,
             GDBusMessage    *message,
@@ -1162,6 +1255,7 @@ dbus_display_listener_new(const char *bus_name,
     dbus_display_listener_setup_shared_map(ddl);
     trace_dbus_can_share_map(ddl->can_share_map);
     dbus_display_listener_setup_d3d11(ddl);
+    dbus_display_listener_setup_multi_plane(ddl);
 
     con = qemu_console_lookup_by_index(dbus_display_console_get_index(console));
     assert(con);
-- 
2.43.0


