Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBAEC61CE2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyoIZ-0005xa-OI; Tue, 25 Aug 2026 06:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoIY-0005tI-8z
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:22:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoIW-0005gb-Mq
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787653348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KRInEMHq3qCYs27hdoMN+FKb7VskfV2CZFNqIBjNKpE=;
 b=EKi6ZFERznOfNeQQTIdqeCHnyTqVacThgV6cydxLjp1LKJ1TX2rZzHOX/pvJzehB8fu2lF
 JnGAHmJvb2JsPaTBHjB153flxFdm7KqzKa2WsXw1nEkByBqNuhpEeNpexf9AwwtByCQHOS
 H/JW+8d0qga81sCQcd+nl22QZRbtrKk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-u5dyWZAHNP6OArLb5Kx6fA-1; Tue,
 25 Aug 2026 06:22:24 -0400
X-MC-Unique: u5dyWZAHNP6OArLb5Kx6fA-1
X-Mimecast-MFC-AGG-ID: u5dyWZAHNP6OArLb5Kx6fA_1787653343
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95F51195422D; Tue, 25 Aug 2026 10:22:23 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D5CDB1800642; Tue, 25 Aug 2026 10:22:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 14:20:39 +0400
Subject: [PATCH 02/18] ui/dbus: disable scanout iff dmabuf is current
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-virtio-gpu-cleanup-v1-2-d3bb612b9975@redhat.com>
References: <20260825-virtio-gpu-cleanup-v1-0-d3bb612b9975@redhat.com>
In-Reply-To: <20260825-virtio-gpu-cleanup-v1-0-d3bb612b9975@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5990;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SewAVNZd0/0MR4x3m27bnrbQErWKCD9bWw9XzyE3Keg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjWyXXCrjm+Uoai3uc5vCvAoUlO+yxGUvdFiOL
 3/krmwu0LOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao1slwAKCRDa6OEJdZac
 5Td9EACSOpaRk0Cc/cGtc5/f/hbr0E9XUstmKEyJapQRFtJkwpEbu5oq4YV37jLmu+nVnYyGl9r
 n2iZ5HQ/ONlvcnEradHNPvj2grcv3RTRf6hS3VPsL4bM9B39osFqq+9fsZ/TfNnTS3SWIoO1m2p
 KZL4D8NSqhj8owZuSek2Ul/3Tw0E6sJQut20MLmeKvP2jI6p3C/nae2eX4j8notK9TawdjOPxmX
 ziwYpFh5ABRbz6Ujf3HE8bcKFYNvXdruOVDS7C9L+HNxM9RcuWicFmebVC6+Kfdn1W1MWOb1ghR
 kL/3jZ/Jl0F9mTTk3h7RQO00/WJ4rRb/BvoQFvRE9O6qy4vFib9WLPZqPhXM288SjEqlAcZe7yu
 TyMzT0lTtEgx5RoQnEje9esPTzPhGQGxCYTwju31g+M7YFpNuvaLz5O0mFvlPlbhNeTVGfsQTaV
 iz/CEzQdMmOi7O/JdlXUZCdhb+doYSfO0pYu2JatHPqSOQQSu0zTZI5aN26dw3Tz0Xq5pQfv3bP
 Ra6Hc0WQ+7kWy9BazEwCiIZe2+w0uieHp0fJ8JFZic7FL+9AJSsP6JrC3O8xnCNhaPAw9dMge4k
 hKjm1USwU066oUVht7r+oqdHvMbLA/LQlcUl0nVZ3hf8z6gVIAisq/BJd1MlMKDUZr/huinsPxa
 8LpUSfrCJ18mgOg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Narrows release_dmabuf to the active scanout, as the device & console
may interleave new scanouts before releasing old ones.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c | 68 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 20 deletions(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 2e2f6ba4183a..5a72c7eeae59 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -91,6 +91,8 @@ struct _DBusDisplayListener {
     guint dbus_filter;
     guint32 display_serial_to_discard;
     guint32 cursor_serial_to_discard;
+
+    QemuDmaBuf *scanout_dmabuf;
 };
 
 G_DEFINE_TYPE(DBusDisplayListener, dbus_display_listener, G_TYPE_OBJECT)
@@ -119,6 +121,7 @@ static void dbus_scanout_disable(DisplayChangeListener *dcl)
 {
     DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
 
+    ddl->scanout_dmabuf = NULL;
     ddl_discard_display_messages(ddl);
 
     qemu_dbus_display1_listener_call_disable(
@@ -298,9 +301,9 @@ static void dbus_call_update_gl(DisplayChangeListener *dcl,
 
 #ifdef CONFIG_GBM
 static void dbus_scanout_dmabuf_v1(DBusDisplayListener *ddl,
-                                   QemuDmaBuf *dmabuf)
+                                   QemuDmaBuf *dmabuf,
+                                   GError **err)
 {
-    g_autoptr(GError) err = NULL;
     g_autoptr(GUnixFDList) fd_list = NULL;
     int fd;
     uint32_t width, height, stride, fourcc;
@@ -309,8 +312,7 @@ static void dbus_scanout_dmabuf_v1(DBusDisplayListener *ddl,
 
     fd = qemu_dmabuf_get_fds(dmabuf, NULL)[0];
     fd_list = g_unix_fd_list_new();
-    if (g_unix_fd_list_append(fd_list, fd, &err) != 0) {
-        error_report("Failed to setup dmabuf fdlist: %s", err->message);
+    if (g_unix_fd_list_append(fd_list, fd, err) != 0) {
         return;
     }
 
@@ -332,9 +334,9 @@ static void dbus_scanout_dmabuf_v1(DBusDisplayListener *ddl,
 }
 
 static void dbus_scanout_dmabuf_v2(DBusDisplayListener *ddl,
-                                   QemuDmaBuf *dmabuf)
+                                   QemuDmaBuf *dmabuf,
+                                   GError **err)
 {
-    g_autoptr(GError) err = NULL;
     g_autoptr(GUnixFDList) fd_list = NULL;
     int i, fd_index[DMABUF_MAX_PLANES], num_fds;
     uint32_t x, y, width, height, fourcc, backing_width, backing_height;
@@ -360,9 +362,8 @@ static void dbus_scanout_dmabuf_v2(DBusDisplayListener *ddl,
             break;
         }
 
-        fd_index[num_fds] = g_unix_fd_list_append(fd_list, plane_fd, &err);
+        fd_index[num_fds] = g_unix_fd_list_append(fd_list, plane_fd, err);
         if (fd_index[num_fds] < 0) {
-            error_report("Failed to setup dmabuf fdlist: %s", err->message);
             return;
         }
     }
@@ -395,20 +396,36 @@ static void dbus_scanout_dmabuf_v2(DBusDisplayListener *ddl,
         G_DBUS_CALL_FLAGS_NONE, -1, fd_list, NULL, NULL, NULL);
 }
 
+static bool dbus_call_scanout_dmabuf(DBusDisplayListener *ddl,
+                                     QemuDmaBuf *dmabuf)
+{
+    g_autoptr(GError) err = NULL;
+
+    if (ddl->scanout_dmabuf_v2_proxy) {
+        dbus_scanout_dmabuf_v2(ddl, dmabuf, &err);
+    } else {
+        if (qemu_dmabuf_get_num_planes(dmabuf) > 1) {
+            error_report("Peer does not support multi plane dmabuf");
+            return false;
+        }
+        dbus_scanout_dmabuf_v1(ddl, dmabuf, &err);
+    }
+
+    if (err) {
+        error_report("Failed to scanout dmabuf: %s", err->message);
+        return false;
+    }
+
+    return true;
+}
+
 static void dbus_scanout_dmabuf(DisplayChangeListener *dcl,
                                 QemuDmaBuf *dmabuf)
 {
     DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
 
-    if (ddl->scanout_dmabuf_v2_proxy) {
-        dbus_scanout_dmabuf_v2(ddl, dmabuf);
-    } else {
-        if (qemu_dmabuf_get_num_planes(dmabuf) > 1) {
-            g_debug("org.qemu.Display1.Listener.ScanoutDMABUF "
-                    "does not support mutli plane");
-            return;
-        }
-        dbus_scanout_dmabuf_v1(ddl, dmabuf);
+    if (dbus_call_scanout_dmabuf(ddl, dmabuf)) {
+        ddl->scanout_dmabuf = dmabuf;
     }
 }
 #endif /* GBM */
@@ -589,6 +606,10 @@ static void dbus_scanout_texture(DisplayChangeListener *dcl,
                                  uint32_t w, uint32_t h,
                                  void *d3d_tex2d)
 {
+#if defined(CONFIG_GBM) || defined(WIN32)
+    DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
+#endif
+
     trace_dbus_scanout_texture(tex_id, backing_y_0_top,
                                backing_width, backing_height, x, y, w, h);
 #ifdef CONFIG_GBM
@@ -607,13 +628,13 @@ static void dbus_scanout_texture(DisplayChangeListener *dcl,
                              backing_height, fourcc, modifier, fd, num_planes,
                              false, backing_y_0_top);
 
-    dbus_scanout_dmabuf(dcl, dmabuf);
+    if (dbus_call_scanout_dmabuf(ddl, dmabuf)) {
+        ddl->scanout_dmabuf = NULL;
+    }
     qemu_dmabuf_close(dmabuf);
 #endif
 
 #ifdef WIN32
-    DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
-
     /* there must be a matching gfx_switch before */
     assert(surface_width(ddl->ds) == w);
     assert(surface_height(ddl->ds) == h);
@@ -686,7 +707,14 @@ static void dbus_cursor_dmabuf(DisplayChangeListener *dcl,
 static void dbus_release_dmabuf(DisplayChangeListener *dcl,
                                 QemuDmaBuf *dmabuf)
 {
+    DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
+
+    if (ddl->scanout_dmabuf != dmabuf) {
+        return;
+    }
+
     dbus_scanout_disable(dcl);
+    ddl->scanout_dmabuf = NULL;
 }
 #endif /* GBM */
 

-- 
2.55.0.543.g5ebe2ebe4ea8


