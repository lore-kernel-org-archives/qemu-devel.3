Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63566C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riW0t-0006Ta-Nk; Fri, 08 Mar 2024 03:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1riW0l-0006S7-Ih
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:55:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1riW0i-000824-VU
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:55:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709888124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K2EhFWmwQXg0VDff/9iN3Z1BFKxdUb+ZoUVtMHOFqB4=;
 b=PKV61O40K1YgBOxL1S1c+/7TO84UsgXVM0Enp7fFPW75P+PbzqlV/95GI7vMMhiP1cS2oS
 3BnYRsF5+Lv7zqnPdcn5MiP6tMYNIhxto3Erp0Ew1xox8BUidFEjzvwxuWMmbs7FWGvEbC
 6U2InDFVHBAe60eFAjGTHeRgGVx6ZbU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-Bg94elm2NMuId8cLaHDscA-1; Fri, 08 Mar 2024 03:55:22 -0500
X-MC-Unique: Bg94elm2NMuId8cLaHDscA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B5B3186E240
 for <qemu-devel@nongnu.org>; Fri,  8 Mar 2024 08:55:22 +0000 (UTC)
Received: from localhost (unknown [10.39.208.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 11ADE200E1B4;
 Fri,  8 Mar 2024 08:55:20 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 1/2] ui/dbus: factor out sending a scanout
Date: Fri,  8 Mar 2024 12:55:13 +0400
Message-ID: <20240308085515.2445091-2-marcandre.lureau@redhat.com>
In-Reply-To: <20240308085515.2445091-1-marcandre.lureau@redhat.com>
References: <20240308085515.2445091-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 18f556aa73..3f4529dbbd 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -630,11 +630,26 @@ static void dbus_gfx_update_sub(DBusDisplayListener *ddl,
         DBUS_DEFAULT_TIMEOUT, NULL, NULL, NULL);
 }
 
+static void ddl_scanout(DBusDisplayListener *ddl)
+{
+    GVariant *v_data;
+
+    v_data = g_variant_new_from_data(
+        G_VARIANT_TYPE("ay"), surface_data(ddl->ds),
+        surface_stride(ddl->ds) * surface_height(ddl->ds), TRUE,
+        (GDestroyNotify)pixman_image_unref, pixman_image_ref(ddl->ds->image));
+
+    qemu_dbus_display1_listener_call_scanout(
+        ddl->proxy, surface_width(ddl->ds), surface_height(ddl->ds),
+        surface_stride(ddl->ds), surface_format(ddl->ds), v_data,
+        G_DBUS_CALL_FLAGS_NONE, DBUS_DEFAULT_TIMEOUT, NULL, NULL,
+        g_object_ref(ddl));
+}
+
 static void dbus_gfx_update(DisplayChangeListener *dcl,
                             int x, int y, int w, int h)
 {
     DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
-    GVariant *v_data;
 
     assert(ddl->ds);
 
@@ -652,23 +667,7 @@ static void dbus_gfx_update(DisplayChangeListener *dcl,
 #endif
 
     if (x == 0 && y == 0 && w == surface_width(ddl->ds) && h == surface_height(ddl->ds)) {
-        v_data = g_variant_new_from_data(
-            G_VARIANT_TYPE("ay"),
-            surface_data(ddl->ds),
-            surface_stride(ddl->ds) * surface_height(ddl->ds),
-            TRUE,
-            (GDestroyNotify)pixman_image_unref,
-            pixman_image_ref(ddl->ds->image));
-        qemu_dbus_display1_listener_call_scanout(
-            ddl->proxy,
-            surface_width(ddl->ds),
-            surface_height(ddl->ds),
-            surface_stride(ddl->ds),
-            surface_format(ddl->ds),
-            v_data,
-            G_DBUS_CALL_FLAGS_NONE,
-            DBUS_DEFAULT_TIMEOUT, NULL, NULL, NULL);
-        return;
+        return ddl_scanout(ddl);
     }
 
     dbus_gfx_update_sub(ddl, x, y, w, h);
-- 
2.44.0


