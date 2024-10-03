Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19063CF857A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 11:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swJwH-0001Ri-9E; Thu, 03 Oct 2024 07:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1swJwE-0001F6-36
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 07:24:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1swJwB-0004yP-2M
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 07:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727954623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LbA5VfDAr/RwkKCrilX42feGwXJTiuFwpzMtEmeaq7Y=;
 b=bGxmtQTiP/63wYQvWrcoRLgAW4l65cwETZssUw56tCXY2fyD5TKVAWzRnPDY7S1wfZwqbH
 x/BwLuFkAUSOpI+hukavK1+SgXZ3u2dk2rF7ypLpJFvljpGapkvn2SqqAZpPWAWjQ4qKpj
 m7Za2QuNxpUlTND26reuBo9R2plDQOs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-Hc2NFTKTMo6-korZlr0z-Q-1; Thu,
 03 Oct 2024 07:23:40 -0400
X-MC-Unique: Hc2NFTKTMo6-korZlr0z-Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B51B11955E84; Thu,  3 Oct 2024 11:23:38 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D2781956054; Thu,  3 Oct 2024 11:23:37 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 belmouss@redhat.com, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 10/16] ui/dbus: do not limit to one listener per connection /
 bus name
Date: Thu,  3 Oct 2024 15:22:37 +0400
Message-ID: <20241003112244.3340697-11-marcandre.lureau@redhat.com>
In-Reply-To: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
References: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124;
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

This is an arbitrary limitation that doesn't concern QEMU directly and
may make some use cases unnecessarily more complicated.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-console.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index 578b67f62b..5eb1d40d16 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -41,7 +41,7 @@ struct _DBusDisplayConsole {
     DisplayChangeListener dcl;
 
     DBusDisplay *display;
-    GHashTable *listeners;
+    GPtrArray *listeners;
     QemuDBusDisplay1Console *iface;
 
     QemuDBusDisplay1Keyboard *iface_kbd;
@@ -142,8 +142,7 @@ dbus_display_console_init(DBusDisplayConsole *object)
 {
     DBusDisplayConsole *ddc = DBUS_DISPLAY_CONSOLE(object);
 
-    ddc->listeners = g_hash_table_new_full(g_str_hash, g_str_equal,
-                                            NULL, g_object_unref);
+    ddc->listeners = g_ptr_array_new_with_free_func(g_object_unref);
     ddc->dcl.ops = &dbus_console_dcl_ops;
 }
 
@@ -157,7 +156,7 @@ dbus_display_console_dispose(GObject *object)
     g_clear_object(&ddc->iface_mouse);
     g_clear_object(&ddc->iface_kbd);
     g_clear_object(&ddc->iface);
-    g_clear_pointer(&ddc->listeners, g_hash_table_unref);
+    g_clear_pointer(&ddc->listeners, g_ptr_array_unref);
     g_clear_pointer(&ddc->kbd, qkbd_state_free);
 
     G_OBJECT_CLASS(dbus_display_console_parent_class)->dispose(object);
@@ -179,7 +178,7 @@ listener_vanished_cb(DBusDisplayListener *listener)
 
     trace_dbus_listener_vanished(name);
 
-    g_hash_table_remove(ddc->listeners, name);
+    g_ptr_array_remove_fast(ddc->listeners, listener);
     qkbd_state_lift_all_keys(ddc->kbd);
 }
 
@@ -267,16 +266,6 @@ dbus_console_register_listener(DBusDisplayConsole *ddc,
     DBusDisplayListener *listener;
     int fd;
 
-    if (sender && g_hash_table_contains(ddc->listeners, sender)) {
-        g_dbus_method_invocation_return_error(
-            invocation,
-            DBUS_DISPLAY_ERROR,
-            DBUS_DISPLAY_ERROR_INVALID,
-            "`%s` is already registered!",
-            sender);
-        return DBUS_METHOD_INVOCATION_HANDLED;
-    }
-
 #ifdef G_OS_WIN32
     if (!dbus_win32_import_socket(invocation, arg_listener, &fd)) {
         return DBUS_METHOD_INVOCATION_HANDLED;
@@ -331,9 +320,7 @@ dbus_console_register_listener(DBusDisplayConsole *ddc,
         return DBUS_METHOD_INVOCATION_HANDLED;
     }
 
-    g_hash_table_insert(ddc->listeners,
-                        (gpointer)dbus_display_listener_get_bus_name(listener),
-                        listener);
+    g_ptr_array_add(ddc->listeners, listener);
     g_object_connect(listener_conn,
                      "swapped-signal::closed", listener_vanished_cb, listener,
                      NULL);
-- 
2.45.2.827.g557ae147e6


