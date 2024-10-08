Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923BFCEF166
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 12:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy9gd-0007fz-7s; Tue, 08 Oct 2024 08:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sy9gS-0007TT-21
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 08:51:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sy9gP-0002SB-US
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 08:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728391881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U4/qPOLitEUb23FhfD/jWHvtH9zG498ujY4CKZBW8Zc=;
 b=OybxF7h9h9DzQkrzkxo0BDQkBmgODE0Z9xAKvDha9I1sT/yvu9MyP6kXIP8jWIjWK8j8Kr
 23FVS2dzQg6UsC+/mtLY4uM+J5+det6SbJa98Eo8xm7oggZV9aqnITV99JBhkVijtcWfAh
 blJ58TRUf3xvT5wRfw8+TYOk5mm+l2A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-VvEsbkNSOKWjTKXqFxFmPg-1; Tue,
 08 Oct 2024 08:51:18 -0400
X-MC-Unique: VvEsbkNSOKWjTKXqFxFmPg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 647F41977400; Tue,  8 Oct 2024 12:51:10 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9EE4319560A2; Tue,  8 Oct 2024 12:51:08 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, belmouss@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 07/19] ui/dbus: discard pending CursorDefine on new one
Date: Tue,  8 Oct 2024 16:50:16 +0400
Message-ID: <20241008125028.1177932-8-marcandre.lureau@redhat.com>
In-Reply-To: <20241008125028.1177932-1-marcandre.lureau@redhat.com>
References: <20241008125028.1177932-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

Similar to scanout updates, let's discard pending cursor changes.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 19cb74e92b..eca6890ce6 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -87,6 +87,7 @@ struct _DBusDisplayListener {
 
     guint dbus_filter;
     guint32 display_serial_to_discard;
+    guint32 cursor_serial_to_discard;
 };
 
 G_DEFINE_TYPE(DBusDisplayListener, dbus_display_listener, G_TYPE_OBJECT)
@@ -102,6 +103,14 @@ static void ddl_discard_display_messages(DBusDisplayListener *ddl)
     g_atomic_int_set(&ddl->display_serial_to_discard, serial);
 }
 
+static void ddl_discard_cursor_messages(DBusDisplayListener *ddl)
+{
+    guint32 serial = g_dbus_connection_get_last_serial(
+        g_dbus_proxy_get_connection(G_DBUS_PROXY(ddl->proxy)));
+
+    g_atomic_int_set(&ddl->cursor_serial_to_discard, serial);
+}
+
 #ifdef CONFIG_OPENGL
 static void dbus_scanout_disable(DisplayChangeListener *dcl)
 {
@@ -502,6 +511,8 @@ static void dbus_cursor_dmabuf(DisplayChangeListener *dcl,
         return;
     }
 
+    ddl_discard_cursor_messages(ddl);
+
     egl_dmabuf_import_texture(dmabuf);
     texture = qemu_dmabuf_get_texture(dmabuf);
     if (!texture) {
@@ -745,6 +756,8 @@ static void dbus_cursor_define(DisplayChangeListener *dcl,
     DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
     GVariant *v_data = NULL;
 
+    ddl_discard_cursor_messages(ddl);
+
     v_data = g_variant_new_from_data(
         G_VARIANT_TYPE("ay"),
         c->data,
@@ -1028,6 +1041,21 @@ dbus_filter(GDBusConnection *connection,
         }
     }
 
+    discard_serial = g_atomic_int_get(&ddl->cursor_serial_to_discard);
+    if (serial <= discard_serial) {
+        const gchar *member = g_dbus_message_get_member(message);
+        static const char *const cursor_messages[] = {
+            "CursorDefine",
+            NULL
+        };
+
+        if (g_strv_contains(cursor_messages, member)) {
+            trace_dbus_filter(serial, discard_serial);
+            g_object_unref(message);
+            return NULL;
+        }
+    }
+
     return message;
 }
 
-- 
2.47.0


