Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B71DCDE00E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrVi-0001vR-IE; Thu, 25 Jun 2026 17:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrVe-0001Z5-Gq
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:21:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrVZ-0003kU-DJ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fRPtQELqolxkJtRA6vnIe5NUc3hcSq+toynCIGwIkSk=;
 b=RuJtYYHy9BMLYqUJLG8Wxfi2KdjPJfmTyQ3kqVRVEvwrz1rtnXDLi1MaRwZAOtzRDDXcv1
 XiY+NrhORtYTN9dLLM3Al9EOJrE/1Pl+2r8qEeubPrTETPxn4bFtNyDPt5kL4kkb3sK4qe
 Uf36vwSAZcVYZ6TED6/hDAOQy4ttols=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-F6roRQggPsGVXePBSYu3qw-1; Thu,
 25 Jun 2026 17:21:10 -0400
X-MC-Unique: F6roRQggPsGVXePBSYu3qw-1
X-Mimecast-MFC-AGG-ID: F6roRQggPsGVXePBSYu3qw_1782422469
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F8781955DE1; Thu, 25 Jun 2026 21:21:09 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6A9FD1956047; Thu, 25 Jun 2026 21:21:08 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:19 +0400
Subject: [PATCH v2 18/39] tests/qtest/device-introspect-test: fix test
 without HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-qemu-no-hmp-v2-18-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7498;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=/JxQv6h3FUqjsdGwFy0SeHfp3oZCxzfgsDm04W8itkE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZtdaOeovuOD8iPMcvz+fZ3y1LXJpBbN9nUBL
 5kIMMFuNq6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXQAKCRDa6OEJdZac
 5bQiEACsg0UV4OkjxJxmnI4GzUbh79+q2mvMw2VaMoyRzHANC2f3y2hBj0RfuasZkxri2eVje/U
 2be1N1IYQeoweLzG8NPlO1nI3OaHq1SI6Dwc2yOXshaFlGCiZly877E0AaHhgKmVnFRkk9Pwnn0
 /or59UN2+vMGKfgUyxJA17c2vlwXG9gM6LacQYWyK0Fh15vsUxQtzEkBZa1sl/E/2/EoTtmhbFw
 7u/+7bYT/ZgKaG0CXJi05fPZ5cPsK+oBmUTXP4RfyMuqjq/PSmXjkVDeEBiKT1HFoBAAridbPOO
 LDjP5HnYhrlhgr4GlAAjkp2gA0q6ZXUqI8PeAMTH3UwxBwZE+usQsXkE2C8C8foMMxNDRlIfJzn
 oVgrAZ40ymX8ze9htZ3CY6in7p33vpcJq3ctO4kgenSXiLGxWNkwWMzza3cobY/octXRRnhlat/
 jur/neLVHYdtkB77JbZSqpoYwU+O/rUBvVuyjc8TYGi7ZikbZc7fGHVPG92u6f0h/u16Qy5t6xM
 Kn76wJbxJ4SnXDrwDkkOwz2UatAJq5o77IOjdQHvTfyT/NGEQ9Vvw0zqA9WQMKIvmMEuDjFSR3+
 AFqJE5aJbm9d+wOgf/27+/iaSyuPFsxpq8KBan5K+xHAjzM4myAT5YgFTtCmbdGJXd2+qo34uD7
 hrgMH0TBAYAX6Kg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Replace "info qom-tree" with recursive qom-list walk.
Disable HMP-only code paths, info qtree, kinda duplicating the test.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/device-introspect-test.c | 111 +++++++++++++++++++++++++++--------
 1 file changed, 88 insertions(+), 23 deletions(-)

diff --git a/tests/qtest/device-introspect-test.c b/tests/qtest/device-introspect-test.c
index f84cec51dc2..f6eca2c8eb7 100644
--- a/tests/qtest/device-introspect-test.c
+++ b/tests/qtest/device-introspect-test.c
@@ -11,10 +11,10 @@
  */
 
 /*
- * Covers QMP device-list-properties and HMP device_add help.  We
- * currently don't check that their output makes sense, only that QEMU
- * survives.  Useful since we've had an astounding number of crash
- * bugs around here.
+ * Covers QMP device-list-properties and HMP device_add help (if
+ * CONFIG_HMP).  We currently don't check that the output makes sense,
+ * only that QEMU survives.  Useful since we've had an astounding
+ * number of crash bugs around here.
  */
 
 #include "qemu/osdep.h"
@@ -100,11 +100,60 @@ static QList *device_type_list(QTestState *qts, bool abstract)
     return qom_list_types(qts, "device", abstract);
 }
 
+/*
+ * Recursively walk the QOM composition tree via qom-list and build a
+ * string representation.  This serves two purposes: detecting dangling
+ * pointers (qom-list would crash QEMU) and detecting leaked objects
+ * (by comparing the output before and after device introspection).
+ */
+static void qom_tree_walk(QTestState *qts, const char *path, GString *result)
+{
+    QDict *resp;
+    QList *list;
+    QListEntry *e;
+    GList *children = NULL;
+
+    resp = qtest_qmp(qts, "{'execute': 'qom-list',"
+                     " 'arguments': {'path': %s}}", path);
+    g_assert(qdict_haskey(resp, "return"));
+    list = qdict_get_qlist(resp, "return");
+
+    QLIST_FOREACH_ENTRY(list, e) {
+        QDict *prop = qobject_to(QDict, qlist_entry_obj(e));
+        const char *type = qdict_get_str(prop, "type");
+        if (g_str_has_prefix(type, "child<")) {
+            const char *name = qdict_get_str(prop, "name");
+            children = g_list_prepend(children, g_strdup(name));
+        }
+    }
+
+    children = g_list_sort_with_data(children, (GCompareDataFunc)g_strcmp0,
+                                     NULL);
+
+    for (GList *l = children; l; l = l->next) {
+        const char *name = l->data;
+        g_autofree char *child_path = (!strcmp(path, "/"))
+            ? g_strdup_printf("/%s", name)
+            : g_strdup_printf("%s/%s", path, name);
+
+        g_string_append_printf(result, "%s\n", child_path);
+        qom_tree_walk(qts, child_path, result);
+    }
+
+    g_list_free_full(children, g_free);
+    qobject_unref(resp);
+}
+
+static char *qom_tree_str(QTestState *qts)
+{
+    GString *result = g_string_new("");
+    qom_tree_walk(qts, "/", result);
+    return g_string_free(result, FALSE);
+}
+
 static void test_one_device(QTestState *qts, const char *type)
 {
     QDict *resp;
-    char *help, *escaped;
-    GRegex *comma;
 
     g_test_message("Testing device '%s'", type);
 
@@ -113,19 +162,21 @@ static void test_one_device(QTestState *qts, const char *type)
                type);
     qobject_unref(resp);
 
-    comma = g_regex_new(",", 0, 0, NULL);
-    escaped = g_regex_replace_literal(comma, type, -1, 0, ",,", 0, NULL);
-    g_regex_unref(comma);
+#ifdef CONFIG_HMP
+    {
+        g_autofree char *escaped = NULL;
+        g_autoptr(GRegex) comma = NULL;
 
-    help = qtest_hmp(qts, "device_add \"%s,help\"", escaped);
-    g_free(help);
-    g_free(escaped);
+        comma = g_regex_new(",", 0, 0, NULL);
+        escaped = g_regex_replace_literal(comma, type, -1, 0, ",,", 0, NULL);
+        g_free(qtest_hmp(qts, "device_add \"%s,help\"", escaped));
+    }
+#endif
 }
 
 static void test_device_intro_list(void)
 {
     QList *types;
-    char *help;
     QTestState *qts;
 
     qts = qtest_init(common_args);
@@ -133,8 +184,11 @@ static void test_device_intro_list(void)
     types = device_type_list(qts, true);
     qobject_unref(types);
 
-    help = qtest_hmp(qts, "device_add help");
-    g_free(help);
+#ifdef CONFIG_HMP
+    {
+        g_free(qtest_hmp(qts, "device_add help"));
+    }
+#endif
 
     qtest_quit(qts);
 }
@@ -198,18 +252,22 @@ static void test_qom_list_fields(void)
 static void test_device_intro_none(void)
 {
     QTestState *qts = qtest_init(common_args);
-    g_autofree char *qom_tree_start = qtest_hmp(qts, "info qom-tree");
+    g_autofree char *qom_tree_start = qom_tree_str(qts);
     g_autofree char *qom_tree_end = NULL;
+#ifdef CONFIG_HMP
     g_autofree char *qtree_start = qtest_hmp(qts, "info qtree");
     g_autofree char *qtree_end = NULL;
+#endif
 
     test_one_device(qts, "nonexistent");
 
     /* Make sure that really nothing changed in the trees */
-    qom_tree_end = qtest_hmp(qts, "info qom-tree");
+    qom_tree_end = qom_tree_str(qts);
     g_assert_cmpstr(qom_tree_start, ==, qom_tree_end);
+#ifdef CONFIG_HMP
     qtree_end = qtest_hmp(qts, "info qtree");
     g_assert_cmpstr(qtree_start, ==, qtree_end);
+#endif
 
     qtest_quit(qts);
 }
@@ -217,18 +275,22 @@ static void test_device_intro_none(void)
 static void test_device_intro_abstract(void)
 {
     QTestState *qts = qtest_init(common_args);
-    g_autofree char *qom_tree_start = qtest_hmp(qts, "info qom-tree");
+    g_autofree char *qom_tree_start = qom_tree_str(qts);
     g_autofree char *qom_tree_end = NULL;
+#ifdef CONFIG_HMP
     g_autofree char *qtree_start = qtest_hmp(qts, "info qtree");
     g_autofree char *qtree_end = NULL;
+#endif
 
     test_one_device(qts, "device");
 
     /* Make sure that really nothing changed in the trees */
-    qom_tree_end = qtest_hmp(qts, "info qom-tree");
+    qom_tree_end = qom_tree_str(qts);
     g_assert_cmpstr(qom_tree_start, ==, qom_tree_end);
+#ifdef CONFIG_HMP
     qtree_end = qtest_hmp(qts, "info qtree");
     g_assert_cmpstr(qtree_start, ==, qtree_end);
+#endif
 
     qtest_quit(qts);
 }
@@ -239,10 +301,12 @@ static void test_device_intro_concrete(const void *args)
     QListEntry *entry;
     const char *type;
     QTestState *qts = qtest_init(args);
-    g_autofree char *qom_tree_start = qtest_hmp(qts, "info qom-tree");
+    g_autofree char *qom_tree_start = qom_tree_str(qts);
     g_autofree char *qom_tree_end = NULL;
+#ifdef CONFIG_HMP
     g_autofree char *qtree_start = qtest_hmp(qts, "info qtree");
     g_autofree char *qtree_end = NULL;
+#endif
 
     types = device_type_list(qts, false);
 
@@ -255,14 +319,15 @@ static void test_device_intro_concrete(const void *args)
 
     /*
      * Some devices leave dangling pointers in QOM behind.
-     * "info qom-tree" or "info qtree" have a good chance at crashing then.
+     * Walking the QOM tree via qom-list has a good chance at crashing then.
      * Also make sure that the tree did not change.
      */
-    qom_tree_end = qtest_hmp(qts, "info qom-tree");
+    qom_tree_end = qom_tree_str(qts);
     g_assert_cmpstr(qom_tree_start, ==, qom_tree_end);
-
+#ifdef CONFIG_HMP
     qtree_end = qtest_hmp(qts, "info qtree");
     g_assert_cmpstr(qtree_start, ==, qtree_end);
+#endif
 
     qobject_unref(types);
     qtest_quit(qts);

-- 
2.54.0


