Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9E6C5DF66
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgJ6-0000O2-4u; Sun, 16 Aug 2026 15:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgIz-0000Cl-1p
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:14:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgIw-0007W2-Tz
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786907638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UZRz3EkbKUI26MlQnyuxQXcUyNkJElc5W8Guw6Tk6gI=;
 b=VgskfFo9tMkdfLqp49wh/OdlTcH4yAilPFjiRUnKL46IcY4eoia73J/jd5dfm4ImHaYVO/
 zxjMGKNeqckCxdeH9392p07AY17sN4oYi2BFKm/ubs6HpWtM91OHs5D0mFCS9EVDJaiZjD
 2uBmjFvzxk1/3UDn/spucN1J42Gh0NQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-OOEjt81mPLqDF6_m7TskMw-1; Sun,
 16 Aug 2026 15:13:56 -0400
X-MC-Unique: OOEjt81mPLqDF6_m7TskMw-1
X-Mimecast-MFC-AGG-ID: OOEjt81mPLqDF6_m7TskMw_1786907635
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 867B8180049D; Sun, 16 Aug 2026 19:13:55 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D2B71800347; Sun, 16 Aug 2026 19:13:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:12:43 +0400
Subject: [PATCH v3 16/49] tests/qtest/device-introspect-test: fix test
 without HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-qemu-no-hmp-v3-16-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7518;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=9Kj/FtbaZbFHg5LizU23usl5iX+58YVJ4JW3Ey5xlPk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqgguxNeTVUYD655MqOz1Kg8mK9s7pm7TUKZ70p
 m0heNaCtVGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoILsQAKCRDa6OEJdZac
 5YYaEACZINcvIXIgTSGEe2HPVGA6lPkxDjfXZ9dDLnQPTrQvcEy3X24UimiM4DYqgTzwnphTgY9
 YKRAZuwg0LpW+sI+UbDTDGSPNRc/lA/7+yikliBrUg/opfye6jpOlvUFIoIIW+pNjjBM9GsR72Z
 3Mlkq1toHGUmTTI0ZwFG/8Y20lnBchP8bthL6TYH+PD74aXVVajZrKHL5w0Yf29LsnAifWVOnRp
 GNKV1HzOYkfHVjmJS3jpyCJ/AEHobG6rbl2/dxE0g3En01a7+rdbL+letaz7ylJXBovjBSy026N
 eWTH0Be9HbMjUVCMId5KfLfQQHVYns/+u+cCt2+AeQ7xZvhLcnZE/qaAbVPn+ajzFn3SaWZhvbn
 Gg/q1XJ0KUlRCd+BPWLqxMs/YCnU+rlI5ZguaZTuSywVwrdDCDqsAxOIzBKqWI8ddi/FmHq+7EG
 +yfrW7eH/ZFFLMTbuC2yG0nOYrDMArppkiEvn7ZXq7BYfbMfM+eItWmEzxETtBF6oj5lkxN47WX
 KgBaZFbl+QCjJXgMk2uTOe9WK1SPKfHPOcpHipAuwjClErKhMKXFdVhF8iiecj9pyzCHrT4N4/I
 9xUUBBjOwcsDNfg2vBu9sd9tZZ+i3t1TVMDHtSbhB4oA/BHck0i1eDIAynJTOq0+2QqTqcKOMzP
 fyeZ6NaAU3w6cAg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index f84cec51dc2e..f6eca2c8eb7e 100644
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
2.55.0.543.g5ebe2ebe4ea8


