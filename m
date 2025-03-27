Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69929C36008
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 03:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txdT1-0006x0-U0; Wed, 26 Mar 2025 22:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1txdT0-0006vk-Mt
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 22:59:38 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1txdSy-0007fP-IG
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 22:59:38 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-301a4d5156aso757742a91.1
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 19:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743044375; x=1743649175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l+CnokoM4dJ/mv3foQ5OXlEgVAPO+ixDiCKrot48SCs=;
 b=RYLk+hM3aOh/BsmqRPobJcnFMJXvE3RuEpv4R4BGmC8EjxGgIprkKFjbA8sCrJxqQk
 UQkz+Cx6alsGvJmhYhC566g42/BLZpyJKjJ6RawykQZq8ujD3M3CZQ+juOag+M5VeDeU
 PK9AFxzMnhwbJjKI7RtqPuQkw4CeDORukBxWzHOGKFFXGP2ABle8exczyRmrTNo8eu+j
 erQDpDgpOdcPb7loFPNfrwAuYF0SrAgObRa5CTFXorIy5xKgEe1XugAjAurO9GCxyg0I
 qQRrMIaqt0rOhVnpRpZ7/h8yVxLP/oBTnpfkNBFNpM03zua9APQEJlrSvj0EZGl3kxhR
 sZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743044375; x=1743649175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l+CnokoM4dJ/mv3foQ5OXlEgVAPO+ixDiCKrot48SCs=;
 b=MA9uxRrDMGVJNbK1wNxbd8/I8RWfI9d4dfsoQDUmE4WqogbnpLCNNQT7yGeuFg3/Jg
 r+yErbLLuHRLQ7Cj4FeiGpYpwhRL46J/2ogeY6wo+skLLyCtNup38OtLS6xckJAVtRdE
 jTUZgtmvF7YZ0pjYZKIR2BsX2CUIl4WYGrPXCvNzIOQ3ek1pW1txwwd4ANWDY/Pa3g5Q
 dcEeByU2SweES4Gjr6f6IxKFx4qRqmvgc0lXC/jupMPc//DigVgUlkm4TKS105zVA3UG
 pJ8iLhP2zJCi2w4q6uIY2D3jLDW79ztOd20Fs92ehtgcudIJaQH1WBgvMHywP9XjErlI
 Vb1Q==
X-Gm-Message-State: AOJu0YyEnT+FAURqWi1fbY02E9hq2WWcN2w9XQDK9AKXuOesYrDvpu8B
 Wxo4sHCPjOQ/A4V75JxAqEHdQW3lslpJs6HoUT/9eN6RiGXoCH7rARMXjZjs
X-Gm-Gg: ASbGncvXkJ/IXgvzy8EYpOYFlU9O4YsXWjrKKopg4vjPBTHuc9z9iG0cO5OBt/mJZFl
 I2ORm82LTH0CK+NMwKj27XUT45QpkNpkweul2VpWqVLKHaWaKs0K6x4tHjWx0KQLB1QQA/+dMd/
 pjIMbNRO7SDNyCtKmS8tnBUIIyi0C2tVuseQQJCDPsBShziKQTuETI33H6nHrlkXwiY8r9hXjIH
 t6g6J3RmxGGuV9N0QhKTdRqWVfwalWBRwQqJpblMwXR1LPOzeK9OSkhQzABoDbw1wb+sjI4JD1a
 kvNSj3fvVI3fygIr6jJ4CIg56J18/tbh9YVSWc8IYqDOg7rY2K9AHradZ5MpmxZQrLEbbVKOwN/
 ONxwD8tZj6zbPc7qJR+Y2
X-Google-Smtp-Source: AGHT+IEdm1Zh6B733F1cF0QpSik1lJo+JzCbPl7b3nrQlBS6r+FU0oZJB4SlgGRcvotPZHJDmjcnNg==
X-Received: by 2002:a17:90b:4b07:b0:301:98fc:9b5a with SMTP id
 98e67ed59e1d1-303a7b5b051mr2767309a91.6.1743044374500; 
 Wed, 26 Mar 2025 19:59:34 -0700 (PDT)
Received: from localhost.localdomain (awork062150.netvigator.com.
 [203.198.28.150]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039dfd37e5sm1027698a91.2.2025.03.26.19.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 19:59:34 -0700 (PDT)
From: yuq825@gmail.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Qiang Yu <yuq825@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 5/6] ui/dbus: change dbus ScanoutDMABUF interface
Date: Thu, 27 Mar 2025 10:58:47 +0800
Message-ID: <20250327025848.46962-6-yuq825@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327025848.46962-1-yuq825@gmail.com>
References: <20250327025848.46962-1-yuq825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=yuq825@gmail.com; helo=mail-pj1-x1029.google.com
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

v3:
  * rename interface
  * add x/y/backing_width/backing_height arg

v2:
  * use new dmabuf API and check length

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Qiang Yu <yuq825@gmail.com>
---
 ui/dbus-display1.xml |  45 +++++++++++++++++
 ui/dbus-listener.c   | 112 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 150 insertions(+), 7 deletions(-)

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
 
diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 90147972cd..58a7002611 100644
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
@@ -322,6 +322,85 @@ static void dbus_scanout_dmabuf(DisplayChangeListener *dcl,
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
+            g_debug("org.qemu.Display1.Listener.ScanoutDMABUF does not support mutli plane");
+            return;
+        }
+        dbus_scanout_dmabuf_v1(ddl, dmabuf);
+    }
+}
 #endif /* GBM */
 #endif /* OPENGL */
 
@@ -514,10 +593,6 @@ static void dbus_scanout_texture(DisplayChangeListener *dcl,
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
@@ -886,6 +961,8 @@ dbus_display_listener_dispose(GObject *object)
 #ifdef CONFIG_OPENGL
     egl_fb_destroy(&ddl->fb);
 #endif
+#else /* !WIN32 */
+    g_clear_object(&ddl->scanout_dmabuf_v2_proxy);
 #endif
 
     G_OBJECT_CLASS(dbus_display_listener_parent_class)->dispose(object);
@@ -1074,6 +1151,26 @@ dbus_display_listener_setup_shared_map(DBusDisplayListener *ddl)
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
@@ -1162,6 +1259,7 @@ dbus_display_listener_new(const char *bus_name,
     dbus_display_listener_setup_shared_map(ddl);
     trace_dbus_can_share_map(ddl->can_share_map);
     dbus_display_listener_setup_d3d11(ddl);
+    dbus_display_listener_setup_scanout_dmabuf_v2(ddl);
 
     con = qemu_console_lookup_by_index(dbus_display_console_get_index(console));
     assert(con);
-- 
2.43.0


