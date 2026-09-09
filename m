Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E416C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4G61-0002qv-OX; Wed, 09 Sep 2026 07:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G60-0002qf-Qq
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:04:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G5y-0005Fu-VO
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788951842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0aCO0uNFxJDrfHiJBs8AT6lTkMw8C7vlFldvNwsdGSk=;
 b=Bkr7X9Q558k+wa/OE4wFGZ5Fqjg7rp+J66lx6h5JMvg7sH86AoutZAMOlOPWSmrnX84EW9
 tMz+VyxKajwiUaG2hwOAFKx24T2n4aWUmWZTWl6m5N4W6ugxaV8tiVOmAxHAXkQ/V7Q/pO
 BXmfSKN0sexVkrF9YD+x7crPaLuDAKU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-062Vkz8FMyqs5zujA9YSVA-1; Wed,
 09 Sep 2026 07:03:57 -0400
X-MC-Unique: 062Vkz8FMyqs5zujA9YSVA-1
X-Mimecast-MFC-AGG-ID: 062Vkz8FMyqs5zujA9YSVA_1788951836
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49823180076B; Wed,  9 Sep 2026 11:03:56 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7A4B630001BB; Wed,  9 Sep 2026 11:03:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 09 Sep 2026 15:03:13 +0400
Subject: [PATCH v3 08/24] ui/dbus: disable scanout iff dmabuf is current
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260909-virtio-gpu-cleanup-v3-8-99266590e79d@redhat.com>
References: <20260909-virtio-gpu-cleanup-v3-0-99266590e79d@redhat.com>
In-Reply-To: <20260909-virtio-gpu-cleanup-v3-0-99266590e79d@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6106;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=gSMT+0AOJarhtVwNErFLIpySAW7A6q8MDifZCjlShj0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoTzyFHzPB9+6/9iiaAFCBOeGG/fxn7eMeYXbV
 FmE/ABWZEyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqE88gAKCRDa6OEJdZac
 5fXoD/sEqBLqQVbjgBC3PdRuXQ7Zi13UOgaCaXqpjhJHmOkpg0wLmGTNEuEbu3OB1xWgjYkPK5n
 3zNiV79rmgAMoDwz4LCHA3Sy51Fla1OOB3yso/3KiwJ50o/Wqdb4ze2jjyZg2GjZbbCsNBCVFD0
 7lpi+CdrhHQR9sgVTy3EqO8S0+/PMzKB5P+1oxfgDcKL23l9UwTqzf5ZVa03un3MGSF8kYAOlxy
 DNp9ZGIUyjnNT97jRDE8FzxgO21aLQWejHoulD5fdjDcfrCVjQLroeh+MOlwzVLtvFw1/NbiRA+
 PemoJZAjUP12XgyXhwXX42IGCf9SNmrX/ZsokHUyJvYceUBH0wPNILSEBVA5rstVtha6gJvUJE/
 K2BBTkxgqsmrUaVN3NabOhrWewA25wImJ/FyJXSK7AmYx0QXkHeNQEQZZWTxyafQm1urHR8qbhB
 3CaRP8s9U9rmhzvBkpcJy41hksOywaScJOuyJB5vyV/0gpxp223xz0Tk86a+xVV9e+coTho6mYZ
 ii15/Mcg8ZRVNQAcZAy2/1SRX0JoQxNPVsCJROTgfV1sXCknGAUpa49s/4RiT4ktvh79QHopAq2
 8pspDISN8aBiGdu70gPwadurJDrykJ10p+Pu6U67xTxKl7XvsEw5xcFFJVREQ0wNoMgK4J9jA1a
 lYnL3z5HQ4w6ZNg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fixes: 142ca628a733 ("ui: add a D-Bus display backend")
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
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


