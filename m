Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2061ACF857A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 11:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swJwO-00023y-LS; Thu, 03 Oct 2024 07:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1swJwN-0001wS-7x
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 07:24:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1swJwL-00055K-7J
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 07:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727954652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5uOUIJE6Tf6T0aD9xPzd8dJGIdaMu61Q5TD/Q81KBUk=;
 b=GmDE4517GPhtmWs1lGfBi+TxzAl5KTZtNJcxND66O87t9jOeTetGka6EzqCSHHxN+HHqkQ
 UT4wK1UdNCBqJ1HSh/0TxR2xYlECVGWftc2jG0yclvxIo+3J6VMW234bJrsoV4HKsgE08+
 DCAoz4vJIgLZPrrS5Iy2IECpVBMy/uM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-vSLmgh9tO-WtylfNU7Exbw-1; Thu,
 03 Oct 2024 07:24:09 -0400
X-MC-Unique: vSLmgh9tO-WtylfNU7Exbw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F58E195609E; Thu,  3 Oct 2024 11:24:08 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B3E5419560A3; Thu,  3 Oct 2024 11:24:06 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 belmouss@redhat.com, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 16/16] tests: add basic -display dbus Map.Unix test
Date: Thu,  3 Oct 2024 15:22:43 +0400
Message-ID: <20241003112244.3340697-17-marcandre.lureau@redhat.com>
In-Reply-To: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
References: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Only check we eventually get a shared memory scanout.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/dbus-display-test.c | 64 ++++++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/dbus-display-test.c b/tests/qtest/dbus-display-test.c
index 0390bdcb41..ac92cb00d4 100644
--- a/tests/qtest/dbus-display-test.c
+++ b/tests/qtest/dbus-display-test.c
@@ -2,9 +2,12 @@
 #include "qemu/sockets.h"
 #include "qemu/dbus.h"
 #include "qemu/sockets.h"
+#include "glib.h"
+#include "glibconfig.h"
 #include <gio/gio.h>
 #include <gio/gunixfdlist.h>
 #include "libqtest.h"
+#include <sys/mman.h>
 #include "ui/dbus-display1.h"
 
 static GDBusConnection*
@@ -82,6 +85,7 @@ typedef struct TestDBusConsoleRegister {
     GThread *thread;
     GDBusConnection *listener_conn;
     GDBusObjectManagerServer *server;
+    bool with_map;
 } TestDBusConsoleRegister;
 
 static gboolean listener_handle_scanout(
@@ -94,13 +98,48 @@ static gboolean listener_handle_scanout(
     GVariant *arg_data,
     TestDBusConsoleRegister *test)
 {
+    if (!test->with_map) {
+        g_main_loop_quit(test->loop);
+    }
+
+    return DBUS_METHOD_INVOCATION_HANDLED;
+}
+
+static gboolean listener_handle_scanout_map(
+    QemuDBusDisplay1ListenerUnixMap *object,
+    GDBusMethodInvocation *invocation,
+    GUnixFDList *fd_list,
+    GVariant *arg_handle,
+    guint arg_offset,
+    guint arg_width,
+    guint arg_height,
+    guint arg_stride,
+    guint arg_pixman_format,
+    TestDBusConsoleRegister *test)
+{
+    int fd = -1;
+    gint32 handle = g_variant_get_handle(arg_handle);
+    g_autoptr(GError) error = NULL;
+    void *addr = NULL;
+    size_t len = arg_height * arg_stride;
+
+    g_assert_cmpuint(g_unix_fd_list_get_length(fd_list), ==, 1);
+    fd = g_unix_fd_list_get(fd_list, handle, &error);
+    g_assert_no_error(error);
+
+    addr = mmap(NULL, len, PROT_READ, MAP_PRIVATE, fd, arg_offset);
+    g_assert_no_errno(GPOINTER_TO_INT(addr));
+    g_assert_nonnull(addr);
+    g_assert_no_errno(munmap(addr, len));
+
     g_main_loop_quit(test->loop);
 
+    close(fd);
     return DBUS_METHOD_INVOCATION_HANDLED;
 }
 
 static void
-test_dbus_console_setup_listener(TestDBusConsoleRegister *test)
+test_dbus_console_setup_listener(TestDBusConsoleRegister *test, bool with_map)
 {
     g_autoptr(GDBusObjectSkeleton) listener = NULL;
     g_autoptr(QemuDBusDisplay1ListenerSkeleton) iface = NULL;
@@ -114,6 +153,20 @@ test_dbus_console_setup_listener(TestDBusConsoleRegister *test)
                      NULL);
     g_dbus_object_skeleton_add_interface(listener,
                                          G_DBUS_INTERFACE_SKELETON(iface));
+    if (with_map) {
+        g_autoptr(QemuDBusDisplay1ListenerUnixMapSkeleton) iface_map =
+            QEMU_DBUS_DISPLAY1_LISTENER_UNIX_MAP_SKELETON(
+                qemu_dbus_display1_listener_unix_map_skeleton_new());
+
+        g_object_connect(iface_map,
+                         "signal::handle-scanout-map", listener_handle_scanout_map, test,
+                         NULL);
+        g_dbus_object_skeleton_add_interface(listener,
+                                             G_DBUS_INTERFACE_SKELETON(iface_map));
+        g_object_set(iface, "interfaces",
+            (const gchar *[]) { "org.qemu.Display1.Listener.Unix.Map", NULL },
+            NULL);
+    }
     g_dbus_object_manager_server_export(test->server, listener);
     g_dbus_object_manager_server_set_connection(test->server,
                                                 test->listener_conn);
@@ -145,7 +198,7 @@ test_dbus_console_registered(GObject *source_object,
     g_assert_no_error(err);
 
     test->listener_conn = g_thread_join(test->thread);
-    test_dbus_console_setup_listener(test);
+    test_dbus_console_setup_listener(test, test->with_map);
 }
 
 static gpointer
@@ -155,7 +208,7 @@ test_dbus_p2p_server_setup_thread(gpointer data)
 }
 
 static void
-test_dbus_display_console(void)
+test_dbus_display_console(const void* data)
 {
     g_autoptr(GError) err = NULL;
     g_autoptr(GDBusConnection) conn = NULL;
@@ -163,7 +216,7 @@ test_dbus_display_console(void)
     g_autoptr(GMainLoop) loop = NULL;
     QTestState *qts = NULL;
     int pair[2];
-    TestDBusConsoleRegister test = { 0, };
+    TestDBusConsoleRegister test = { 0, .with_map = GPOINTER_TO_INT(data) };
 #ifdef WIN32
     WSAPROTOCOL_INFOW info;
     g_autoptr(GVariant) listener = NULL;
@@ -299,7 +352,8 @@ main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("/dbus-display/vm", test_dbus_display_vm);
-    qtest_add_func("/dbus-display/console", test_dbus_display_console);
+    qtest_add_data_func("/dbus-display/console", GINT_TO_POINTER(false), test_dbus_display_console);
+    qtest_add_data_func("/dbus-display/console/map", GINT_TO_POINTER(true), test_dbus_display_console);
     qtest_add_func("/dbus-display/keyboard", test_dbus_display_keyboard);
 
     return g_test_run();
-- 
2.45.2.827.g557ae147e6


