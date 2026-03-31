Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7F0FF60FA
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 09:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Vmq-0000Vi-3C; Tue, 31 Mar 2026 05:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w7Vmp-0000VD-2x
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:53:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w7Vmn-00084z-Gy
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774950804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mHpBtpFggB69Aq4TcqZoU6H0mIeC/0Ty0iKbm2he4uw=;
 b=VbFp+9rvhYh1CmA2Is6MF+ussTaeJo3Ev/J68iShVO/JVN/eNyjYyEtA2zvEPPT2/ZWd3C
 Y34ocYj93UngjpW8Hau5sno2rt1T8hQkhwz8s6d78y0fW/YGlwVUbNSgeo4fii1N4ezkGc
 QV0ih1M6JK4iu43gffoqsnorQXhuADU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-5H_G1zdKOyeTX3MUod59SA-1; Tue,
 31 Mar 2026 05:53:21 -0400
X-MC-Unique: 5H_G1zdKOyeTX3MUod59SA-1
X-Mimecast-MFC-AGG-ID: 5H_G1zdKOyeTX3MUod59SA_1774950800
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 016CA195608E; Tue, 31 Mar 2026 09:53:20 +0000 (UTC)
Received: from localhost (unknown [10.44.22.22])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6E4B330002DA; Tue, 31 Mar 2026 09:53:17 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, GuoHan Zhao <zhaoguohan@kylinos.cn>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 2/6] ui/dbus: associate add_client completion with its request
Date: Tue, 31 Mar 2026 13:52:58 +0400
Message-ID: <20260331095302.644608-3-marcandre.lureau@redhat.com>
In-Reply-To: <20260331095302.644608-1-marcandre.lureau@redhat.com>
References: <20260331095302.644608-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

Commit 99997823bbbd ("ui/dbus: add p2p=on/off option")
introduced an asynchronous D-Bus client setup path, with the completion
handler reaching back into the global dbus_display state.

This makes the callback effectively operate on whatever request is
current when it runs, rather than the one that created it. A completion
from an older request can therefore clear a newer
add_client_cancellable or install its connection after a replacement
request has already been issued. It also relies on the DBusDisplay
instance remaining alive until completion.

Fix this by passing the DBusDisplay and GCancellable as callback data,
taking references while the async setup is in flight, and only acting
on completion if it still matches the current request. Also drop the
previous cancellable before creating a new request.

Fixes: 99997823bbbd ("ui/dbus: add p2p=on/off option")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260326065111.626236-1-zhaoguohan@kylinos.cn>
---
 ui/dbus.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/ui/dbus.c b/ui/dbus.c
index 4f24215555a..7c54b6a502d 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -263,22 +263,52 @@ dbus_display_complete(UserCreatable *uc, Error **errp)
     }
 }
 
+typedef struct DBusDisplayAddClientData {
+    DBusDisplay *display;
+    GCancellable *cancellable;
+} DBusDisplayAddClientData;
+
+static void dbus_display_add_client_data_free(DBusDisplayAddClientData *data)
+{
+    if (data->display) {
+        object_unref(OBJECT(data->display));
+        data->display = NULL;
+    }
+    g_clear_object(&data->cancellable);
+    g_free(data);
+}
+
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(DBusDisplayAddClientData,
+                              dbus_display_add_client_data_free)
+
 static void
 dbus_display_add_client_ready(GObject *source_object,
                               GAsyncResult *res,
                               gpointer user_data)
 {
+    g_autoptr(DBusDisplayAddClientData) data = user_data;
+    DBusDisplay *display = data->display;
+    bool current = display->add_client_cancellable == data->cancellable;
     g_autoptr(GError) err = NULL;
     g_autoptr(GDBusConnection) conn = NULL;
 
-    g_clear_object(&dbus_display->add_client_cancellable);
+    if (current) {
+        g_clear_object(&display->add_client_cancellable);
+    }
 
     conn = g_dbus_connection_new_finish(res, &err);
     if (!conn) {
-        error_printf("Failed to accept D-Bus client: %s", err->message);
+        if (!g_error_matches(err, G_IO_ERROR, G_IO_ERROR_CANCELLED)) {
+            error_printf("Failed to accept D-Bus client: %s", err->message);
+        }
+        return;
     }
 
-    g_dbus_object_manager_server_set_connection(dbus_display->server, conn);
+    if (!current) {
+        return;
+    }
+
+    g_dbus_object_manager_server_set_connection(display->server, conn);
     g_dbus_connection_start_message_processing(conn);
 }
 
@@ -290,6 +320,7 @@ dbus_display_add_client(int csock, Error **errp)
     g_autoptr(GSocket) socket = NULL;
     g_autoptr(GSocketConnection) conn = NULL;
     g_autofree char *guid = g_dbus_generate_guid();
+    DBusDisplayAddClientData *data;
 
     if (!dbus_display) {
         error_setg(errp, "p2p connections not accepted in bus mode");
@@ -298,6 +329,7 @@ dbus_display_add_client(int csock, Error **errp)
 
     if (dbus_display->add_client_cancellable) {
         g_cancellable_cancel(dbus_display->add_client_cancellable);
+        g_clear_object(&dbus_display->add_client_cancellable);
     }
 
 #ifdef WIN32
@@ -318,6 +350,10 @@ dbus_display_add_client(int csock, Error **errp)
     conn = g_socket_connection_factory_create_connection(socket);
 
     dbus_display->add_client_cancellable = g_cancellable_new();
+    data = g_new0(DBusDisplayAddClientData, 1);
+    data->display = DBUS_DISPLAY(object_ref(OBJECT(dbus_display)));
+    data->cancellable = g_object_ref(dbus_display->add_client_cancellable);
+
     GDBusConnectionFlags flags =
         G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_SERVER |
         G_DBUS_CONNECTION_FLAGS_DELAY_MESSAGE_PROCESSING;
@@ -332,7 +368,7 @@ dbus_display_add_client(int csock, Error **errp)
                           NULL,
                           dbus_display->add_client_cancellable,
                           dbus_display_add_client_ready,
-                          NULL);
+                          data);
 
     return true;
 }
-- 
2.53.0


