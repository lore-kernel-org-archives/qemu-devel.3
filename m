Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662F6C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03Pk-0006me-1u; Fri, 28 Aug 2026 16:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Pi-0006eS-V8
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:43:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Pg-0008JZ-PW
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q7aJVi5LXJ+NtA2gG+7uKXZdAeNwER+/p995kZn6wtA=;
 b=fNHbDa31wvr6VFaxipW/vEJ2/8L93WJn3uUghXB2fLDuthXNa78sq54/9cZxi6IyzKyYFC
 jO/Mylhdlo8DVySMOEDcLoR5ha4gHIQXO9KsjYRX2TWbRMrE9vSfJTEDht3EbqdKeXAhvk
 C2wA3Mq82wEakBF2dGhOfaJ/4IbVh6o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-4KCPBTQrMbuy_B8gyzTU0Q-1; Fri,
 28 Aug 2026 16:42:58 -0400
X-MC-Unique: 4KCPBTQrMbuy_B8gyzTU0Q-1
X-Mimecast-MFC-AGG-ID: 4KCPBTQrMbuy_B8gyzTU0Q_1787949777
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 469A018A3C0A; Fri, 28 Aug 2026 20:42:57 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 563971803A40; Fri, 28 Aug 2026 20:42:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:41:55 +0400
Subject: [GIT PULL 16/50] tests/qtest/device-introspect-test: replace 'info
 qom-tree'
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-16-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5554;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=FVCkBeD7AGwbOPHtW4E0zgvzeheUmYontGT5jAr9fls=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKUlNhE+aty2QZi2t05GX3f6tpXx+1lDbtG9
 5SlXwssheuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHylAAKCRDa6OEJdZac
 5azeD/0YVIAORAywdwiPLjxAbxJwrY/D/0c0vAhys71mkyjGqEsbNvyEU5qb5EGS6qI6u4SPWYH
 t0TFGBQPFvdNGoqmso3dIWnYbtt9k0gl+S+cOZ88mrRnwF1Bic6SrjRBBQaOubcWDOBXPrWzDdm
 Yq0cX9h+xvMO/6WRwiAecWcUAPIwJtWDcEPl0a7UzElO6KuKnhgndMiK0IjqSc+sPlwlEnAnmxn
 /ogJ1atQNWb0idslfCbDUs/DOPfV0mOPNy3BHJgQNnETAxq3ajBuZyVsPfUiE6qEGYUJLYHW/5g
 byrLLvgw2UR8TLuu9Qmh0s2VBu5ECQFAf+48T5h0yOv0F7HNoLEoIihdJGjPgfDkECUMdVzSIrw
 6bh6DBDZTAoQ5osbHFjFDJ0SHBipBlggfkLnMiWRk9mpJ1vUfrS7O9kh8Co7LHcM/nMFkTkoPTp
 67lS48hez7eAyco3ZitiJlW9lC1AoJ/lPp9DyQiB9GCgqZAEqd2nUxNmX8BkXYRVQTEpNW9ljlS
 QAnTycJ+A/q1pzRiHpOr0MPFOW1xwxmCbMVSFoHh72yRF0ZjLjH92XLtfLwHFcA4KA9ZNaQVnXv
 mEVwt/9DyiagjfnZE5Bfg2ubMhvqa355Fn5qwTJAKdKyNjzDkyiWLtxWytJrPd+7L5A3TGcXSzd
 eVNnuCxMhq1gVBA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Replace "info qom-tree" with recursive qom-list walk. This substitutes a
HMP-only command by a QOM command, allowing the test to run when
!CONFIG_HMP later in this series.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260828-qemu-no-hmp-v5-16-9227de146347@redhat.com>
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


