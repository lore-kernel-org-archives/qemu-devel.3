Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACB0C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKqC-0005TP-Gx; Mon, 14 Jul 2025 11:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUu-0000TC-Pc
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUd-0003eb-DK
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752500716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I7HHDjdxFdMzPaAdUoWmAmkFEVUaW8PBBDWsg7Z3n6M=;
 b=PzwFVzCPTH3HcQJ39aYWGZqft9qfT0Imjcf3MDCQCEcsbtVgAI0KwpsH2XUnnJcCDCzqBA
 ztgoZIBcKwn70KEtudFjkdXnNgqpAnY8ui3lxQGX91YbcIplXQwdcDly8v2VpD4W1ePKWg
 yquTKSaT1LulnEs0NGXHxZs2egGEtSw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-jFQ9ZYBqMO-t96nP7_6YIA-1; Mon,
 14 Jul 2025 09:45:11 -0400
X-MC-Unique: jFQ9ZYBqMO-t96nP7_6YIA-1
X-Mimecast-MFC-AGG-ID: jFQ9ZYBqMO-t96nP7_6YIA_1752500709
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95D4E1955F08; Mon, 14 Jul 2025 13:45:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 053D01956094; Mon, 14 Jul 2025 13:45:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4045221E60FF; Mon, 14 Jul 2025 15:44:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 32/32] tests/qtest/qom-test: unit test for qom-list-get
Date: Mon, 14 Jul 2025 15:44:58 +0200
Message-ID: <20250714134458.2991097-33-armbru@redhat.com>
In-Reply-To: <20250714134458.2991097-1-armbru@redhat.com>
References: <20250714134458.2991097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Add a unit test for qom-list-get.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <1752248703-217318-4-git-send-email-steven.sistare@oracle.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qtest/qom-test.c | 116 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 115 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
index 27d70bc11c..4ade1c728c 100644
--- a/tests/qtest/qom-test.c
+++ b/tests/qtest/qom-test.c
@@ -11,11 +11,119 @@
 
 #include "qobject/qdict.h"
 #include "qobject/qlist.h"
+#include "qobject/qstring.h"
 #include "qemu/cutils.h"
 #include "libqtest.h"
 
+#define RAM_NAME "node0"
+#define RAM_SIZE 65536
+
 static int verbosity_level;
 
+/*
+ * Verify that the /object/RAM_NAME 'size' property is RAM_SIZE.
+ */
+static void test_list_get_value(QTestState *qts)
+{
+    QDict *args = qdict_new();
+    g_autoptr(QDict) response = NULL;
+    g_autoptr(QList) paths = qlist_new();
+    QListEntry *entry, *prop_entry;
+    const char *prop_name;
+    QList *properties, *return_list;
+    QDict *obj;
+
+    qlist_append_str(paths, "/objects/" RAM_NAME);
+    qdict_put_obj(args, "paths", QOBJECT(qlist_copy(paths)));
+    response = qtest_qmp(qts, "{ 'execute': 'qom-list-get',"
+                              "  'arguments': %p }", args);
+    g_assert(response);
+    g_assert(qdict_haskey(response, "return"));
+    return_list = qobject_to(QList, qdict_get(response, "return"));
+
+    entry = QTAILQ_FIRST(&return_list->head);
+    obj = qobject_to(QDict, qlist_entry_obj(entry));
+    g_assert(qdict_haskey(obj, "properties"));
+    properties = qobject_to(QList, qdict_get(obj, "properties"));
+
+    QLIST_FOREACH_ENTRY(properties, prop_entry) {
+        QDict *prop = qobject_to(QDict, qlist_entry_obj(prop_entry));
+
+        g_assert(qdict_haskey(prop, "name"));
+        g_assert(qdict_haskey(prop, "value"));
+
+        prop_name = qdict_get_str(prop, "name");
+        if (!strcmp(prop_name, "type")) {
+            g_assert_cmpstr(qdict_get_str(prop, "value"), ==,
+                            "memory-backend-ram");
+
+        } else if (!strcmp(prop_name, "size")) {
+            g_assert_cmpint(qdict_get_int(prop, "value"), ==, RAM_SIZE);
+        }
+    }
+}
+
+static void test_list_get(QTestState *qts, QList *paths)
+{
+    QListEntry *entry, *prop_entry, *path_entry;
+    g_autoptr(QDict) response = NULL;
+    QDict *args = qdict_new();
+    QDict *prop;
+    QList *return_list;
+
+    if (verbosity_level >= 2) {
+        g_test_message("Obtaining properties for paths:");
+        QLIST_FOREACH_ENTRY(paths, path_entry) {
+            QString *qstr = qobject_to(QString, qlist_entry_obj(path_entry));
+            g_test_message("  %s", qstring_get_str(qstr));
+        }
+    }
+
+    qdict_put_obj(args, "paths", QOBJECT(qlist_copy(paths)));
+    response = qtest_qmp(qts, "{ 'execute': 'qom-list-get',"
+                              "  'arguments': %p }", args);
+    g_assert(response);
+    g_assert(qdict_haskey(response, "return"));
+    return_list = qobject_to(QList, qdict_get(response, "return"));
+    g_assert(!qlist_empty(return_list));
+
+    path_entry = QTAILQ_FIRST(&paths->head);
+    QLIST_FOREACH_ENTRY(return_list, entry) {
+        QDict *obj = qobject_to(QDict, qlist_entry_obj(entry));
+        g_assert(qdict_haskey(obj, "properties"));
+        QList *properties = qobject_to(QList, qdict_get(obj, "properties"));
+        bool has_child = false;
+
+        QLIST_FOREACH_ENTRY(properties, prop_entry) {
+            prop = qobject_to(QDict, qlist_entry_obj(prop_entry));
+            g_assert(qdict_haskey(prop, "name"));
+            g_assert(qdict_haskey(prop, "type"));
+            has_child |= strstart(qdict_get_str(prop, "type"), "child<", NULL);
+        }
+
+        if (has_child) {
+            /* build a list of child paths */
+            QString *qstr = qobject_to(QString, qlist_entry_obj(path_entry));
+            const char *path = qstring_get_str(qstr);
+            g_autoptr(QList) child_paths = qlist_new();
+
+            QLIST_FOREACH_ENTRY(properties, prop_entry) {
+                prop = qobject_to(QDict, qlist_entry_obj(prop_entry));
+                if (strstart(qdict_get_str(prop, "type"), "child<", NULL)) {
+                    g_autofree char *child_path = g_strdup_printf(
+                        "%s/%s", path, qdict_get_str(prop, "name"));
+                    qlist_append_str(child_paths, child_path);
+                }
+            }
+
+            /* fetch props for all children with one qom-list-get call */
+            test_list_get(qts, child_paths);
+        }
+
+        path_entry = QTAILQ_NEXT(path_entry, next);
+    }
+}
+
 static void test_properties(QTestState *qts, const char *path, bool recurse)
 {
     char *child_path;
@@ -85,8 +193,10 @@ static void test_machine(gconstpointer data)
     const char *machine = data;
     QDict *response;
     QTestState *qts;
+    g_autoptr(QList) paths = qlist_new();
 
-    qts = qtest_initf("-machine %s", machine);
+    qts = qtest_initf("-machine %s -object memory-backend-ram,id=%s,size=%d",
+                      machine, RAM_NAME, RAM_SIZE);
 
     if (g_test_slow()) {
         /* Make sure we can get the machine class properties: */
@@ -101,6 +211,10 @@ static void test_machine(gconstpointer data)
 
     test_properties(qts, "/machine", true);
 
+    qlist_append_str(paths, "/machine");
+    test_list_get(qts, paths);
+    test_list_get_value(qts);
+
     response = qtest_qmp(qts, "{ 'execute': 'quit' }");
     g_assert(qdict_haskey(response, "return"));
     qobject_unref(response);
-- 
2.49.0


