Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278E4CF857E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 11:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swJwL-0001hj-4g; Thu, 03 Oct 2024 07:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1swJwF-0001NN-QI
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 07:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1swJwB-00050n-9e
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 07:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727954640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MDNNMWlYqHs9jX6D7VLKte0DMYvCkeRGp8P+fJM72K0=;
 b=H7naHxARtWQUG5PgAI5MQkxNi6x8/qEGyk/N+RdXcgBacLtBGGVRC3slyeZscuAH6kuBKT
 2EHhndKumz7gEQaWaU7KaEjI1KvKGp1Dd/DBwy9RvtkJfabQImoKu812FID7kCM4EhGQoC
 v3Zj/Qzzwjy3tzBqa4RxmgGv+yUsekE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-GPRBSvoGO9S8nncj94D-yQ-1; Thu,
 03 Oct 2024 07:23:59 -0400
X-MC-Unique: GPRBSvoGO9S8nncj94D-yQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3517195394E; Thu,  3 Oct 2024 11:23:57 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 68BBF19560A2; Thu,  3 Oct 2024 11:23:56 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 belmouss@redhat.com, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 14/16] ui/dbus: implement Unix.Map
Date: Thu,  3 Oct 2024 15:22:41 +0400
Message-ID: <20241003112244.3340697-15-marcandre.lureau@redhat.com>
In-Reply-To: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
References: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c | 83 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 5 deletions(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index f55e197768..cc665f2f11 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -75,6 +75,9 @@ struct _DBusDisplayListener {
     bool ds_mapped;
     bool can_share_map;
 
+#ifndef WIN32
+    QemuDBusDisplay1ListenerUnixMap *map_proxy;
+#endif
 #ifdef WIN32
     QemuDBusDisplay1ListenerWin32Map *map_proxy;
     QemuDBusDisplay1ListenerWin32D3d11 *d3d11_proxy;
@@ -323,6 +326,53 @@ static void dbus_scanout_dmabuf(DisplayChangeListener *dcl,
 #endif /* GBM */
 #endif /* OPENGL */
 
+#ifndef WIN32
+static bool dbus_scanout_map(DBusDisplayListener *ddl)
+{
+    g_autoptr(GError) err = NULL;
+    g_autoptr(GUnixFDList) fd_list = NULL;
+
+    if (ddl->ds_share == SHARE_KIND_MAPPED) {
+        return true;
+    }
+
+    if (!ddl->can_share_map || ddl->ds->shmfd == -1) {
+        return false;
+    }
+
+    ddl_discard_display_messages(ddl);
+    fd_list = g_unix_fd_list_new();
+    if (g_unix_fd_list_append(fd_list, ddl->ds->shmfd, &err) != 0) {
+        g_debug("Failed to setup scanout map fdlist: %s", err->message);
+        ddl->can_share_map = false;
+        return false;
+    }
+
+    if (!qemu_dbus_display1_listener_unix_map_call_scanout_map_sync(
+            ddl->map_proxy,
+            g_variant_new_handle(0),
+            ddl->ds->shmfd_offset,
+            surface_width(ddl->ds),
+            surface_height(ddl->ds),
+            surface_stride(ddl->ds),
+            surface_format(ddl->ds),
+            G_DBUS_CALL_FLAGS_NONE,
+            DBUS_DEFAULT_TIMEOUT,
+            fd_list,
+            NULL,
+            NULL,
+            &err)) {
+        g_debug("Failed to call ScanoutMap: %s", err->message);
+        ddl->can_share_map = false;
+        return false;
+    }
+
+    ddl->ds_share = SHARE_KIND_MAPPED;
+
+    return true;
+}
+#endif /* !WIN32 */
+
 #ifdef WIN32
 static bool dbus_scanout_map(DBusDisplayListener *ddl)
 {
@@ -693,16 +743,22 @@ static void dbus_gfx_update(DisplayChangeListener *dcl,
 
     trace_dbus_update(x, y, w, h);
 
-#ifdef WIN32
     if (dbus_scanout_map(ddl)) {
+#ifndef WIN32
+        qemu_dbus_display1_listener_unix_map_call_update_map(
+            ddl->map_proxy,
+            x, y, w, h,
+            G_DBUS_CALL_FLAGS_NONE,
+            DBUS_DEFAULT_TIMEOUT, NULL, NULL, NULL);
+#else
         qemu_dbus_display1_listener_win32_map_call_update_map(
             ddl->map_proxy,
             x, y, w, h,
             G_DBUS_CALL_FLAGS_NONE,
             DBUS_DEFAULT_TIMEOUT, NULL, NULL, NULL);
+#endif
         return;
     }
-#endif
 
     if (x == 0 && y == 0 && w == surface_width(ddl->ds) && h == surface_height(ddl->ds)) {
         return ddl_scanout(ddl);
@@ -879,7 +935,6 @@ dbus_display_listener_get_console(DBusDisplayListener *ddl)
     return ddl->console;
 }
 
-#ifdef WIN32
 static bool
 dbus_display_listener_implements(DBusDisplayListener *ddl, const char *iface)
 {
@@ -894,6 +949,7 @@ dbus_display_listener_implements(DBusDisplayListener *ddl, const char *iface)
     return implements;
 }
 
+#ifdef WIN32
 static bool
 dbus_display_listener_setup_peer_process(DBusDisplayListener *ddl)
 {
@@ -976,10 +1032,27 @@ dbus_display_listener_setup_d3d11(DBusDisplayListener *ddl)
 static void
 dbus_display_listener_setup_shared_map(DBusDisplayListener *ddl)
 {
-#ifdef WIN32
     g_autoptr(GError) err = NULL;
 
-    if (!dbus_display_listener_implements(ddl, "org.qemu.Display1.Listener.Win32.Map")) {
+#ifndef WIN32
+    if (!dbus_display_listener_implements(
+            ddl, "org.qemu.Display1.Listener.Unix.Map")) {
+        return;
+    }
+    ddl->map_proxy = qemu_dbus_display1_listener_unix_map_proxy_new_sync(
+        ddl->conn, G_DBUS_PROXY_FLAGS_DO_NOT_AUTO_START, NULL,
+        "/org/qemu/Display1/Listener", NULL, &err);
+    if (!ddl->map_proxy) {
+        g_debug("Failed to setup Unix map proxy: %s", err->message);
+        return;
+    }
+
+    ddl->can_share_map = true;
+#endif
+
+#ifdef WIN32
+    if (!dbus_display_listener_implements(
+            ddl, "org.qemu.Display1.Listener.Win32.Map")) {
         return;
     }
 
-- 
2.45.2.827.g557ae147e6


