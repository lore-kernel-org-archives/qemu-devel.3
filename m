Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9339EC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 08:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twd38-0006iR-Ol; Mon, 24 Mar 2025 04:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1twd2I-0005y9-70
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 04:19:54 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1twd2G-0008VV-0m
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 04:19:53 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2240b4de12bso59687295ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 01:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742804390; x=1743409190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MOpnM5k0/7RKu+1euKv2KpHJgg77Uj6rRlq9oExCvSk=;
 b=ID2qSPLsTIJiqFrkpqZICKpglHu8p3z/ZTCq32xNudWjmDzINHQlRLAvm4lcalXzAD
 PB1mA2imc8XQP+vFG7qXMCFoGfzSpJRwrjtlAVuqLsF6gZS2xq9oftA2VJ3u/V8NNwC/
 1g4IEbNBpJRwm/hfz0y3nhJhnIJC9A2I4rxLfuCOBUT8BuTxbqlK7m78NwQrG/82H+t4
 Tpm0neVrPkND73EJRBgliExgn4nOMYM9i6NjEUpQCaf+ll0BX8qq5U41vCPN6JPyVE+J
 CniBwUrZyM4nW1xOm6MqxCeeiU2oZaJ6t9XVN9GCy8MGQwKs8GVDbM41hElDJy8BwTbH
 Bz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742804390; x=1743409190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MOpnM5k0/7RKu+1euKv2KpHJgg77Uj6rRlq9oExCvSk=;
 b=vEhG8lGhCctdebdsXYauZehTDTYw8JanvlcGBNLouLTFDAhxXTXrLyheXF71Dsus8p
 q75DqjHaWwgapbLmlq7cAWq6YBqPAZPB38qrn2TK99hD4WAlbpimjhf7lffzMBLMsMxT
 3qlYOgMkllf5F5ufIA+WWnyGP2l5gMoIFh6dO89obv9/cWZvKlAUBnKwz8Fb4wZ/BWyk
 frgg5VO8fd/JyJ2E2j9mHBtNUmWQdw9DhCpU5jIjvILiFCbGjMXFmUk0kdBnbPQQA8bV
 IjeLEPCcj/LXoQ1AL+wh7abMNPfnKpS5MumNdGcU1ylzvt8mTm51Xe/MbPKSsx9YTCVM
 9DdQ==
X-Gm-Message-State: AOJu0YwVq3HLwAaompgSMS+F6/sQKOsTXBCoFbhEJCSHl3Vt2eVWItd+
 u8L/rCE8/RRI9OYGCezKVZAt31kY8aixdAIs5aYu3n2gQFPT8d3Else91s8j
X-Gm-Gg: ASbGncuhwjw4bp7cw03Ggp/h41MiVje5mLAQxh9p8vPldDotBo3BKFXY5mh5zcPYBqj
 jvRD2idSjsQlyIH1/gnsOkpvGBYXHHKx2AYfFG6UZobN/5m125jU3CD/XrFPeI5Ea3MzZ8ajXiz
 IIBoaWou1e/PWsUiRFGSAq5256vs1EnJ3tn6SNCNQuYpmq7ITFDxgapjKn+SEGAHYIZKg89w0bc
 X8AicNIYvgYRMbSV3qwPSndxDAgyLedWNdT5wJIiFSD7SzZ+dUOG8AZS5bIlhb3wVfZpTi2VKJD
 pkSHrrfpj2WQhM0FgA2G5P6m9/2eLOJXj5DXw6wur8Inh3qMrFx9J+/9PreS6lE9EuNyn8E0T68
 7Ff5u7WCqks5U5MnLeLtI
X-Google-Smtp-Source: AGHT+IFAOYVKiRCSAoict2NQHbVLkuMtR247KxvPmXreRLR6Uw8hg3w8GuB1Ozsj9GtgYH3nlGgKhg==
X-Received: by 2002:a17:902:e54a:b0:21f:85ee:f2df with SMTP id
 d9443c01a7336-22780c79888mr177158315ad.15.1742804389683; 
 Mon, 24 Mar 2025 01:19:49 -0700 (PDT)
Received: from localhost.localdomain (awork062150.netvigator.com.
 [203.198.28.150]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2278120a5b6sm64717685ad.252.2025.03.24.01.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 01:19:48 -0700 (PDT)
From: yuq825@gmail.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Qiang Yu <yuq825@gmail.com>
Subject: [PATCH 5/6] ui/dbus: change dbus ScanoutDMABUF interface
Date: Mon, 24 Mar 2025 16:19:20 +0800
Message-ID: <20250324081922.359369-6-yuq825@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324081922.359369-1-yuq825@gmail.com>
References: <20250324081922.359369-1-yuq825@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=yuq825@gmail.com; helo=mail-pl1-x629.google.com
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

Signed-off-by: Qiang Yu <yuq825@gmail.com>
---
 ui/dbus-display1.xml |  37 ++++++++++++++++
 ui/dbus-listener.c   | 103 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 133 insertions(+), 7 deletions(-)

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
index 73b72ed57c..b7b455a595 100644
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
@@ -322,6 +322,76 @@ static void dbus_scanout_dmabuf(DisplayChangeListener *dcl,
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
+    uint32_t width, height, fourcc, num_planes;
+    GVariant *fd, *offset, *stride, *fd_handles[DMABUF_MAX_PLANES];
+    uint64_t modifier;
+    bool y0_top;
+
+    num_planes = qemu_dmabuf_get_num_planes(dmabuf);
+
+    fd_list = g_unix_fd_list_new();
+
+    for (num_fds = 0; num_fds < num_planes; num_fds++) {
+        int plane_fd = qemu_dmabuf_get_fd(dmabuf)[num_fds];
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
+                                       qemu_dmabuf_get_offset(dmabuf),
+                                       num_planes, sizeof(uint32_t));
+    stride = g_variant_new_fixed_array(G_VARIANT_TYPE_UINT32,
+                                       qemu_dmabuf_get_stride(dmabuf),
+                                       num_planes, sizeof(uint32_t));
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
 
@@ -514,10 +584,6 @@ static void dbus_scanout_texture(DisplayChangeListener *dcl,
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
@@ -886,6 +952,8 @@ dbus_display_listener_dispose(GObject *object)
 #ifdef CONFIG_OPENGL
     egl_fb_destroy(&ddl->fb);
 #endif
+#else /* !WIN32 */
+    g_clear_object(&ddl->multi_plane_proxy);
 #endif
 
     G_OBJECT_CLASS(dbus_display_listener_parent_class)->dispose(object);
@@ -1074,6 +1142,26 @@ dbus_display_listener_setup_shared_map(DBusDisplayListener *ddl)
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
@@ -1162,6 +1250,7 @@ dbus_display_listener_new(const char *bus_name,
     dbus_display_listener_setup_shared_map(ddl);
     trace_dbus_can_share_map(ddl->can_share_map);
     dbus_display_listener_setup_d3d11(ddl);
+    dbus_display_listener_setup_multi_plane(ddl);
 
     con = qemu_console_lookup_by_index(dbus_display_console_get_index(console));
     assert(con);
-- 
2.43.0


