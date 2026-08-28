Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4857AC61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvLK-00084C-Va; Fri, 28 Aug 2026 08:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvLH-0007mW-IP
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:05:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvLF-0002nc-C6
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CuP3EnaGyDXRAg52Vqg6Hm1fS8XB6K3i6dENe06nehg=;
 b=dl/DWlhQuIbAuTpGIVUmFpzbKtBMRmkXmx5DjEe744JNDt42KLu4aNug4+z6R4bMj38lPo
 Zbkwic7obGjWgWrP0t+OYlviznkcsbGjBKWXiK8mBXPyuMF8nJw7mVRD5WQiSmGmAJTOTW
 VM2h6++N/58Sa9P4R0vVXzDXWvnCgMw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-G2RdJK9nNEmUK9ZYqPSZrg-1; Fri,
 28 Aug 2026 08:05:47 -0400
X-MC-Unique: G2RdJK9nNEmUK9ZYqPSZrg-1
X-Mimecast-MFC-AGG-ID: G2RdJK9nNEmUK9ZYqPSZrg_1787918746
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 367BA193E8B8; Fri, 28 Aug 2026 12:05:46 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E1D31956049; Fri, 28 Aug 2026 12:05:41 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:04:13 +0400
Subject: [PATCH v5 16/50] tests/qtest/device-introspect-test: replace 'info
 qom-tree'
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-qemu-no-hmp-v5-16-9227de146347@redhat.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5488;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=yLTM0alVvwLmc7461bXP1LamXvh/171bHSXVhVcekoQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk4OG+RQILANSTUDIfTWYQVQPfu7pexbaBCq
 Vi0wdEbtzKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5OAAKCRDa6OEJdZac
 5XMED/oCVJQ4hIxz6fq1PkwJaBtYfgQG/wdyVjwZvNnaIC+aTNbNMa8p/fBEozVnOADyCtqDqTZ
 lqfMdFPwafkTJdofVPlDuz9zX7vlN+vBHytu/EcFjFDEXyqHKAqdTirQtBfhi4ZLtRjOfZOPslw
 K/bz5ogdH0KAH2NPmVG9ZV+wf1nRJEdIOs7zmU1DL1o72It5DW8EMAC4wvpvhkeH5h390kk7P+s
 IelSPchllHtEj4YARCutJSa3VEdYoJLph+UiHha/TJOy3QKfPhdyjQESJ3ZEq4CTcf73jOjeBNc
 VLraOvliXqihDSf3HrMV+XtEGZSEvTs7sB0CKX52ZdlcHN6GtWoSQkhLpyQhYIZw1QMAaZft2Bl
 AB577eUZr0fKz6Fwfq/qumgbifjZyJtC/yHwLQr3rJupjMR4xi2S8IJ6L5NLJ105Af7whkiavqc
 Hmn0pQ11YxsX/pHqX/O3OTjwlj7dynIH/0ONrIxD/CxngjYNXUP5QkoLog1N4VtQIYXbnvV6Yes
 KDwTm8GqpOEaTfiq9bySu1ibev9s17uhze11b7FpHTYCw21hU2qJv1JntH6tjVF9lHKYm4PyBNX
 CIrC5qozE8iNXUmN/epPMPTL449oNEugdgbF9bdtYmScVusjGfAigACLW7WwUmQPHLqGgMsQanh
 R4lJoF6HiMyHB4g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Replace "info qom-tree" with recursive qom-list walk. This substitutes a
HMP-only command by a QOM command, allowing the test to run when
!CONFIG_HMP later in this series.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/device-introspect-test.c | 65 ++++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/device-introspect-test.c b/tests/qtest/device-introspect-test.c
index f84cec51dc2e..1ee441e19a0a 100644
--- a/tests/qtest/device-introspect-test.c
+++ b/tests/qtest/device-introspect-test.c
@@ -100,6 +100,57 @@ static QList *device_type_list(QTestState *qts, bool abstract)
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
@@ -198,7 +249,7 @@ static void test_qom_list_fields(void)
 static void test_device_intro_none(void)
 {
     QTestState *qts = qtest_init(common_args);
-    g_autofree char *qom_tree_start = qtest_hmp(qts, "info qom-tree");
+    g_autofree char *qom_tree_start = qom_tree_str(qts);
     g_autofree char *qom_tree_end = NULL;
     g_autofree char *qtree_start = qtest_hmp(qts, "info qtree");
     g_autofree char *qtree_end = NULL;
@@ -206,7 +257,7 @@ static void test_device_intro_none(void)
     test_one_device(qts, "nonexistent");
 
     /* Make sure that really nothing changed in the trees */
-    qom_tree_end = qtest_hmp(qts, "info qom-tree");
+    qom_tree_end = qom_tree_str(qts);
     g_assert_cmpstr(qom_tree_start, ==, qom_tree_end);
     qtree_end = qtest_hmp(qts, "info qtree");
     g_assert_cmpstr(qtree_start, ==, qtree_end);
@@ -217,7 +268,7 @@ static void test_device_intro_none(void)
 static void test_device_intro_abstract(void)
 {
     QTestState *qts = qtest_init(common_args);
-    g_autofree char *qom_tree_start = qtest_hmp(qts, "info qom-tree");
+    g_autofree char *qom_tree_start = qom_tree_str(qts);
     g_autofree char *qom_tree_end = NULL;
     g_autofree char *qtree_start = qtest_hmp(qts, "info qtree");
     g_autofree char *qtree_end = NULL;
@@ -225,7 +276,7 @@ static void test_device_intro_abstract(void)
     test_one_device(qts, "device");
 
     /* Make sure that really nothing changed in the trees */
-    qom_tree_end = qtest_hmp(qts, "info qom-tree");
+    qom_tree_end = qom_tree_str(qts);
     g_assert_cmpstr(qom_tree_start, ==, qom_tree_end);
     qtree_end = qtest_hmp(qts, "info qtree");
     g_assert_cmpstr(qtree_start, ==, qtree_end);
@@ -239,7 +290,7 @@ static void test_device_intro_concrete(const void *args)
     QListEntry *entry;
     const char *type;
     QTestState *qts = qtest_init(args);
-    g_autofree char *qom_tree_start = qtest_hmp(qts, "info qom-tree");
+    g_autofree char *qom_tree_start = qom_tree_str(qts);
     g_autofree char *qom_tree_end = NULL;
     g_autofree char *qtree_start = qtest_hmp(qts, "info qtree");
     g_autofree char *qtree_end = NULL;
@@ -255,10 +306,10 @@ static void test_device_intro_concrete(const void *args)
 
     /*
      * Some devices leave dangling pointers in QOM behind.
-     * "info qom-tree" or "info qtree" have a good chance at crashing then.
+     * Walking the QOM tree via qom-list has a good chance at crashing then.
      * Also make sure that the tree did not change.
      */
-    qom_tree_end = qtest_hmp(qts, "info qom-tree");
+    qom_tree_end = qom_tree_str(qts);
     g_assert_cmpstr(qom_tree_start, ==, qom_tree_end);
 
     qtree_end = qtest_hmp(qts, "info qtree");

-- 
2.55.0.543.g5ebe2ebe4ea8


