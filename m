Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E303CD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUfG-0001QE-0w; Sat, 13 Jun 2026 16:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUfD-0001Ca-SV; Sat, 13 Jun 2026 16:09:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUfB-0002fx-QW; Sat, 13 Jun 2026 16:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781381070; bh=WBscJ52Kswc1ZMYXolaPaqnmlI8GCz9M9YD2ob2apxU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XOyR3K3ZD+LfMTeoc8e8BFOBR23DiXePF1OQkN4QeTcQtxY+GTYGdWDhS0WZdM/3y
 EMaW7bbz3dKDIx4p92dfKBtVUKddTWudXfK1JK0D8qFpOQcaXA+GJaZ9aeZoSSLQw7
 Wz4eGrpsfSQ5pyNp6YufRIuVoCoqBcDiyWBg7ORQxye5upcN9TuX0EpLuCH/7lbQCy
 l0JX1qQU+9wpGdD0KUxL44xuDyUhqjg9YAPP1Z7oPOgsqWuzqLTbV5ls1jMgbH9rx1
 a4j05nYYgjmtFegOQyes7T59tGW4q6Ee+lsYjiuCVfx7mvkMX1aujmhWxv153FB1nb
 E5NSd5eQA3nng==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2914A1B6E9F;
 Sat, 13 Jun 2026 23:04:30 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 832753CE8FA;
 Sat, 13 Jun 2026 23:04:48 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 48/61] tests/unit: add test-envlist covering
 setenv/unsetenv name matching
Date: Sat, 13 Jun 2026 23:03:31 +0300
Message-ID: <20260613200411.1808021-48-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Denis V. Lunev" <den@openvz.org>

util/envlist had no test coverage. Add tests/unit/test-envlist
exercising the public envlist API and pinning down the prefix-match
hazard fixed in the previous commit:

  - envlist_unsetenv("FOO") must not remove an entry named "FOOBAR";
  - envlist_setenv("FOO=...") must not replace an existing "FOOBAR=..."
    entry placed earlier in the list (envlist_setenv() inserts at the
    head, so the first prefix match wins under the old strncmp rule).

Also cover the rest of the contract: head-insertion order observed
through envlist_to_environ(), replacement of an existing variable,
the count argument of envlist_to_environ(), and the documented EINVAL
paths (NULL inputs, setenv without '=', unsetenv with '=').

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20260520212628.479772-3-den@openvz.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 05221c600a5f3ef657d71aeaea632c5f1bab3a2d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index bd58029060..24851335be 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -48,6 +48,7 @@ tests = {
   'test-qapi-util': [],
   'test-interval-tree': [],
   'test-fifo': [],
+  'test-envlist': [],
 }
 
 if have_system or have_tools
diff --git a/tests/unit/test-envlist.c b/tests/unit/test-envlist.c
new file mode 100644
index 0000000000..53813dd4de
--- /dev/null
+++ b/tests/unit/test-envlist.c
@@ -0,0 +1,196 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * envlist tests
+ *
+ * Copyright 2026 Virtuozzo International GmbH
+ *
+ * Authors:
+ *  Denis V. Lunev <den@openvz.org>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/envlist.h"
+
+static void free_environ(char **env)
+{
+    char **p;
+
+    for (p = env; *p != NULL; p++) {
+        g_free(*p);
+    }
+    g_free(env);
+}
+
+static const char *find_env(char **env, const char *name)
+{
+    size_t name_len = strlen(name);
+    char **p;
+
+    for (p = env; *p != NULL; p++) {
+        if (strncmp(*p, name, name_len) == 0 && (*p)[name_len] == '=') {
+            return *p + name_len + 1;
+        }
+    }
+    return NULL;
+}
+
+static void test_envlist_basic(void)
+{
+    envlist_t *el = envlist_create();
+    char **env;
+    size_t count;
+
+    /* empty list */
+    env = envlist_to_environ(el, &count);
+    g_assert_cmpuint(count, ==, 0);
+    g_assert_null(env[0]);
+    free_environ(env);
+
+    /* add */
+    g_assert_cmpint(envlist_setenv(el, "A=1"), ==, 0);
+    g_assert_cmpint(envlist_setenv(el, "B=2"), ==, 0);
+
+    env = envlist_to_environ(el, &count);
+    g_assert_cmpuint(count, ==, 2);
+    g_assert_cmpstr(find_env(env, "A"), ==, "1");
+    g_assert_cmpstr(find_env(env, "B"), ==, "2");
+    free_environ(env);
+
+    /* replace */
+    g_assert_cmpint(envlist_setenv(el, "A=42"), ==, 0);
+    env = envlist_to_environ(el, &count);
+    g_assert_cmpuint(count, ==, 2);
+    g_assert_cmpstr(find_env(env, "A"), ==, "42");
+    g_assert_cmpstr(find_env(env, "B"), ==, "2");
+    free_environ(env);
+
+    /* unset existing */
+    g_assert_cmpint(envlist_unsetenv(el, "A"), ==, 0);
+    env = envlist_to_environ(el, &count);
+    g_assert_cmpuint(count, ==, 1);
+    g_assert_null(find_env(env, "A"));
+    g_assert_cmpstr(find_env(env, "B"), ==, "2");
+    free_environ(env);
+
+    /* unset non-existing is a no-op success */
+    g_assert_cmpint(envlist_unsetenv(el, "NOPE"), ==, 0);
+    env = envlist_to_environ(el, &count);
+    g_assert_cmpuint(count, ==, 1);
+    free_environ(env);
+
+    envlist_free(el);
+}
+
+/*
+ * envlist_setenv() inserts at the head; envlist_to_environ() walks
+ * head-to-tail, so the last setenv comes out first.
+ */
+static void test_envlist_head_insertion_order(void)
+{
+    envlist_t *el = envlist_create();
+    char **env;
+    size_t count;
+
+    g_assert_cmpint(envlist_setenv(el, "A=1"), ==, 0);
+    g_assert_cmpint(envlist_setenv(el, "B=2"), ==, 0);
+    g_assert_cmpint(envlist_setenv(el, "C=3"), ==, 0);
+
+    env = envlist_to_environ(el, &count);
+    g_assert_cmpuint(count, ==, 3);
+    g_assert_cmpstr(env[0], ==, "C=3");
+    g_assert_cmpstr(env[1], ==, "B=2");
+    g_assert_cmpstr(env[2], ==, "A=1");
+    g_assert_null(env[3]);
+
+    free_environ(env);
+    envlist_free(el);
+}
+
+static void test_envlist_einval(void)
+{
+    envlist_t *el = envlist_create();
+
+    /* NULL list */
+    g_assert_cmpint(envlist_setenv(NULL, "A=1"), ==, EINVAL);
+    g_assert_cmpint(envlist_unsetenv(NULL, "A"), ==, EINVAL);
+
+    /* NULL string */
+    g_assert_cmpint(envlist_setenv(el, NULL), ==, EINVAL);
+    g_assert_cmpint(envlist_unsetenv(el, NULL), ==, EINVAL);
+
+    /* setenv: missing '=' */
+    g_assert_cmpint(envlist_setenv(el, "NOEQ"), ==, EINVAL);
+
+    /* unsetenv: name must not contain '=' */
+    g_assert_cmpint(envlist_unsetenv(el, "A=B"), ==, EINVAL);
+
+    envlist_free(el);
+}
+
+/*
+ * Regression: envlist_unsetenv("FOO") must not remove an entry named
+ * "FOOBAR" -- the previous strncmp(entry, name, strlen(name)) lookup
+ * prefix-matched. To trigger the bug, the longer-named entry has to
+ * be ahead of the target in the list: envlist_setenv() inserts at
+ * the head, so we add FOO first and FOOBAR last.
+ */
+static void test_envlist_unsetenv_no_prefix_match(void)
+{
+    envlist_t *el = envlist_create();
+    char **env;
+    size_t count;
+
+    g_assert_cmpint(envlist_setenv(el, "FOO=y"), ==, 0);
+    g_assert_cmpint(envlist_setenv(el, "FOOBAR=x"), ==, 0);
+
+    g_assert_cmpint(envlist_unsetenv(el, "FOO"), ==, 0);
+
+    env = envlist_to_environ(el, &count);
+    g_assert_cmpuint(count, ==, 1);
+    g_assert_cmpstr(find_env(env, "FOOBAR"), ==, "x");
+    g_assert_null(find_env(env, "FOO"));
+
+    free_environ(env);
+    envlist_free(el);
+}
+
+/*
+ * envlist_setenv() must not replace a prior FOOBAR=... entry when
+ * setting FOO=... The pre-fix code happened to be safe here only
+ * because it included the trailing '=' byte in its strncmp length;
+ * this test pins down the post-fix contract that the name boundary
+ * is a property of the entry, not of the encoded form.
+ */
+static void test_envlist_setenv_no_prefix_match(void)
+{
+    envlist_t *el = envlist_create();
+    char **env;
+    size_t count;
+
+    g_assert_cmpint(envlist_setenv(el, "FOOBAR=x"), ==, 0);
+    g_assert_cmpint(envlist_setenv(el, "FOO=y"), ==, 0);
+
+    env = envlist_to_environ(el, &count);
+    g_assert_cmpuint(count, ==, 2);
+    g_assert_cmpstr(find_env(env, "FOOBAR"), ==, "x");
+    g_assert_cmpstr(find_env(env, "FOO"), ==, "y");
+
+    free_environ(env);
+    envlist_free(el);
+}
+
+int main(int argc, char *argv[])
+{
+    g_test_init(&argc, &argv, NULL);
+
+    g_test_add_func("/envlist/basic", test_envlist_basic);
+    g_test_add_func("/envlist/head_insertion_order",
+                    test_envlist_head_insertion_order);
+    g_test_add_func("/envlist/einval", test_envlist_einval);
+    g_test_add_func("/envlist/unsetenv_no_prefix_match",
+                    test_envlist_unsetenv_no_prefix_match);
+    g_test_add_func("/envlist/setenv_no_prefix_match",
+                    test_envlist_setenv_no_prefix_match);
+
+    return g_test_run();
+}
-- 
2.47.3


