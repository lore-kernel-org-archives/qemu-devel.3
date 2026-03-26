Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69503109E558
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 06:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5eZ4-0000Ah-Ly; Thu, 26 Mar 2026 02:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1w5eZ2-0000AP-AZ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 02:51:32 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1w5eYy-0000Qv-Rm
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 02:51:31 -0400
X-UUID: 2f271de028e011f1a21c59e7364eecb8-20260326
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:1ea9415f-3aab-42ae-a742-a02b26f2c93a, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:25
X-CID-META: VersionHash:89c9d04, CLOUDID:57232f90b651bdf86ccb35070357935b,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:5
 ,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
 :0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2f271de028e011f1a21c59e7364eecb8-20260326
X-User: zhaoguohan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 295054896; Thu, 26 Mar 2026 14:51:15 +0800
From: GuoHan Zhao <zhaoguohan@kylinos.cn>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
	GuoHan Zhao <zhaoguohan@kylinos.cn>
Subject: [PATCH] ui/dbus: associate add_client completion with its request
Date: Thu, 26 Mar 2026 14:51:11 +0800
Message-ID: <20260326065111.626236-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=zhaoguohan@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
---
 ui/dbus.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/ui/dbus.c b/ui/dbus.c
index 4f24215555a4..7c54b6a502d2 100644
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
2.43.0


