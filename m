Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842C8CD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXbNI-0006ux-8N; Thu, 11 Jun 2026 05:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbNG-0006l8-Nj
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:06:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbNE-0005Rl-Cl
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781168811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xbxN/mAMtJtduNKSGnc8CLMOmhvQhZe+7JMf8JBpoeE=;
 b=gMB++L5BXMa26agA+/IgIhByv7WscCZVUlHF+x04qZDEjmpfUDipuKPO/01T80vdOWp0Uf
 FlBGaRrphqVjfDUltkmd5A0wOFH22PiImrRTzd6dvEdpxq5JSk+u7xSQt/gWHLMK2u6J1B
 csBkprj3iuiURfU76qhqcRfqQybFSdY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-qJQVMabLMcKHmRY_jFsaZA-1; Thu,
 11 Jun 2026 05:06:50 -0400
X-MC-Unique: qJQVMabLMcKHmRY_jFsaZA-1
X-Mimecast-MFC-AGG-ID: qJQVMabLMcKHmRY_jFsaZA_1781168809
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 608ED1977000; Thu, 11 Jun 2026 09:06:49 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2C36D180029C; Thu, 11 Jun 2026 09:06:47 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 13:03:50 +0400
Subject: [PATCH v3 35/35] tests/qtest: add D-Bus display hotplug test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260611-b4-ui-v3-35-72bcbbea0fae@redhat.com>
References: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
In-Reply-To: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4986;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Qj9RcQ/RNJdYxcuio5b6l1xNzAqRshVBUlgn/gQCRCY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKnnikT97l5ywP8O8xqU6gZXikDy2DzgyrFnru
 uQF4EgyI42JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaip54gAKCRDa6OEJdZac
 5W93D/41fK0YK2qNSFioSwH3D05vQDvqsho+2t7+xgROkKtTNHZRuXFwDgrUnHWg5PO4z8Ob0HA
 GW+zCEb75dNm8TS0XEsAiehpTvHOmXyYLAgl5zJlvH15FQ2iDT5hV6REKTdmPzet7M/PsUhKybY
 voS0PIybbA8n50ZQb8k/ejrxPuZb93Ryp/7BUdB5WbhYKZ6uBe8ATIUVuvrHeirRiXwTHJ/i1uu
 Xex0G9qE4A0L0UyBCFax5eqje6cw7IvH2bCzojCJaWnRh60t5JoMPOj0iRfzfdczKzpAH36FEvF
 2yA7rvL2KntxeDvZxdPNNjImNuf73QZoH/xyqGBrIvKKrJh+7pFiA7m5HFwvzpGlYIXDdxe2w9R
 J9TOtUMxgOlZ8J7hb+zH441v2zxhimwasfsSc4ALFMXJiH56BJrUKBgSd48eG9u63f+AfjEBtrJ
 e7bkjLsHFXHrDkwBOjheb/SSZYmV4BXj6ahfys4r6EvvLwVJBvz0MqSf4uqIayWJM06w8PXnCYh
 VXtm6ZoMhe4MOFBUS8R0xq8KBDnvohvP5ifwLkTnqFDPCKfPeyQ+dbbhH37qOiYf9+1XCAzEoTa
 h5P7pozQOnKtrY4l4DqFh7CEFHxFqes+JJ1dMdw7nCB11B26z7P12i5v+pFFKMwdO3B1IfKu4X0
 fAT6mn6nVFIbGYw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a qtest that verifies display consoles are dynamically added and
removed over D-Bus when a bochs-display device is hotplugged and
unplugged on a q35 machine.

The test plugs device_add a bochs-display, waits for the DEVICE_ADDED
QMP event, and checks that the D-Bus VM interface reports a second
console. It then device_del it, forces a system reset
(q35 removal is ACPI-based and needs guest cooperation qtest cannot
provide), waits for DEVICE_DELETED, and checks the console count again.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/dbus-display-test.c | 101 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/dbus-display-test.c b/tests/qtest/dbus-display-test.c
index 5773776cad5..7838ce7323f 100644
--- a/tests/qtest/dbus-display-test.c
+++ b/tests/qtest/dbus-display-test.c
@@ -7,6 +7,8 @@
 #include <gio/gio.h>
 #include <gio/gunixfdlist.h>
 #include "libqtest.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "ui/dbus-display1.h"
 
 static GDBusConnection*
@@ -38,11 +40,11 @@ test_dbus_p2p_from_fd(int fd)
 }
 
 static void
-test_setup(QTestState **qts, GDBusConnection **conn)
+test_setup_args(QTestState **qts, GDBusConnection **conn, const char *args)
 {
     int pair[2];
 
-    *qts = qtest_init("-display dbus,p2p=yes -name dbus-test");
+    *qts = qtest_init(args);
 
     g_assert_cmpint(qemu_socketpair(AF_UNIX, SOCK_STREAM, 0, pair), ==, 0);
 
@@ -52,6 +54,12 @@ test_setup(QTestState **qts, GDBusConnection **conn)
     g_dbus_connection_start_message_processing(*conn);
 }
 
+static void
+test_setup(QTestState **qts, GDBusConnection **conn)
+{
+    test_setup_args(qts, conn, "-display dbus,p2p=yes -name dbus-test");
+}
+
 static void
 test_dbus_display_vm(void)
 {
@@ -360,6 +368,92 @@ test_dbus_display_keyboard(void)
     qtest_quit(qts);
 }
 
+static gsize
+get_console_ids_count(GDBusConnection *conn)
+{
+    g_autoptr(GError) err = NULL;
+    g_autoptr(QemuDBusDisplay1VMProxy) vm = NULL;
+    GVariant *console_ids;
+    gsize n_ids = 0;
+
+    vm = QEMU_DBUS_DISPLAY1_VM_PROXY(
+        qemu_dbus_display1_vm_proxy_new_sync(
+            conn,
+            G_DBUS_PROXY_FLAGS_NONE,
+            NULL,
+            DBUS_DISPLAY1_ROOT "/VM",
+            NULL,
+            &err));
+    g_assert_no_error(err);
+
+    console_ids = qemu_dbus_display1_vm_get_console_ids(
+        QEMU_DBUS_DISPLAY1_VM(vm));
+    if (console_ids) {
+        n_ids = g_variant_n_children(console_ids);
+    }
+    return n_ids;
+}
+
+static void
+wait_device_event(QTestState *qts, const char *event_name, const char *id)
+{
+    QDict *resp, *data;
+    QString *qstr;
+
+    for (;;) {
+        resp = qtest_qmp_eventwait_ref(qts, event_name);
+        data = qdict_get_qdict(resp, "data");
+        if (!data || !qdict_get(data, "device")) {
+            qobject_unref(resp);
+            continue;
+        }
+        qstr = qobject_to(QString, qdict_get(data, "device"));
+        if (!strcmp(qstring_get_str(qstr), id)) {
+            qobject_unref(resp);
+            break;
+        }
+        qobject_unref(resp);
+    }
+}
+
+static void
+test_dbus_display_hotplug(void)
+{
+    g_autoptr(GDBusConnection) conn = NULL;
+    QTestState *qts = NULL;
+    gsize n;
+
+    test_setup_args(&qts, &conn,
+        "-machine q35"
+        " -device pcie-root-port,id=rp0"
+        " -display dbus,p2p=yes"
+        " -name dbus-test");
+
+    n = get_console_ids_count(conn);
+    g_assert_cmpuint(n, ==, 1);
+
+    qtest_qmp_device_add(qts, "bochs-display", "bochs0",
+                         "{'bus': 'rp0'}");
+
+    n = get_console_ids_count(conn);
+    g_assert_cmpuint(n, ==, 2);
+
+    /*
+     * On q35, PCI device removal is ACPI-based and requires guest
+     * acknowledgement. Since qtest has no guest OS, issue the delete
+     * request and force removal via system reset.
+     */
+    qtest_qmp_device_del_send(qts, "bochs0");
+    qtest_system_reset_nowait(qts);
+    wait_device_event(qts, "DEVICE_DELETED", "bochs0");
+
+    n = get_console_ids_count(conn);
+    g_assert_cmpuint(n, ==, 1);
+
+    g_clear_object(&conn);
+    qtest_quit(qts);
+}
+
 int
 main(int argc, char **argv)
 {
@@ -369,6 +463,9 @@ main(int argc, char **argv)
     qtest_add_data_func("/dbus-display/console", GINT_TO_POINTER(false), test_dbus_display_console);
     qtest_add_data_func("/dbus-display/console/map", GINT_TO_POINTER(true), test_dbus_display_console);
     qtest_add_func("/dbus-display/keyboard", test_dbus_display_keyboard);
+    if (qtest_has_machine("q35") && qtest_has_device("bochs-display")) {
+        qtest_add_func("/dbus-display/hotplug", test_dbus_display_hotplug);
+    }
 
     return g_test_run();
 }

-- 
2.54.0


