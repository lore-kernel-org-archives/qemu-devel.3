Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F10CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoR2-0006ix-48; Wed, 20 May 2026 17:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wPoR0-0006iC-Hc
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:26:34 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wPoQx-0005YE-AQ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=pH2FUvyhi+mHii53FUt0c0qNEmmfH14JumiyrbnsBpg=; b=ELS855UPMeCn
 UBuRhLm6puBh2wmA79bRrg98JTn61zJGYGadVirHaAm7zC3hU1MHkWUsK1i2dgVmkdBvDghxbYP7Y
 KBQ5FGMwJ5CvqwRVgvstZ7IqqTuNoLrtDCWHSIa5hwERVDMjYPmMIoRbckRhOi++aVUlNemqhmw6K
 YcPvpF5oCyZpj1b3CDirWEn/AQffYIVl91lx0jh24i+RNVodiCTxVU4WU9GCb/nc2m6Vba3Gzs/Ki
 WpmQNvPxU3BgdEOAaqycWIUOsAfJBypxzyqI6dipRE8T+w8U312FgF9ku79OHuMmxEBDF1l8RedL+
 sXQ7JEFsvPmBo/zSzoJkMA==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8]
 helo=iris.astra-academy.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1wPoNa-003Cdo-1e;
 Wed, 20 May 2026 23:26:28 +0200
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/2] tests/unit: add test-envlist covering setenv/unsetenv
 name matching
Date: Wed, 20 May 2026 23:26:28 +0200
Message-ID: <20260520212628.479772-3-den@openvz.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260520212628.479772-1-den@openvz.org>
References: <20260520212628.479772-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=ham autolearn_force=no
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

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
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/unit/meson.build    |   1 +
 tests/unit/test-envlist.c | 196 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 197 insertions(+)
 create mode 100644 tests/unit/test-envlist.c

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index de64f9501f..01cc540a45 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -49,6 +49,7 @@ tests = {
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
2.51.0


