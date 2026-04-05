Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A920F3D5E1
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 13:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9NGr-0006in-W9; Sun, 05 Apr 2026 09:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1w9NGV-0006WN-1n
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 09:11:47 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1w9NGT-0006eH-3g
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 09:11:46 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3FBE94410D;
 Sun,  5 Apr 2026 13:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23E1C116C6;
 Sun,  5 Apr 2026 13:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775394704;
 bh=cP8XbmJh0GXQB9MuBcgRv0ncdejCpajjhdMyKSshUIc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=YO/9Aj3DJ1JjNoVW6JEuye2rD+QiJ+tpF6E34Y7RpQmJVNB4Ssq1XVcn0GzRZwuPv
 9lQn/Y1cygEWdRSTYgGsMmZUN3cuBzhmAMaQJ8HU8KOoepJs3yxP7+7jWCiLMWCLWF
 lr62FIUVkdcxNMIXUwk5VmDlXFKPUemLURYzfwikEfBOrsr7CPSj0m6CVhgP8kuB/3
 DLESmKsU2ZA2H45fGzPiy3oNmJd05J9mLwxiV66fW4cIIVPMw7orgMYVlqG32uLuG6
 Jod4yV5q+cYBpftHH0/miHHxE78KWKjm5klQkurXwUAHa9PChHs0vvZOyHvY6ddwt/
 wzShQYKFrDkHw==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 05 Apr 2026 15:11:20 +0200
Subject: [PATCH v2 4/5] tests/qtest: add tests for dynamic monitor add/remove
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-work-qmp-monitor-hotplug-v2-4-ad5bedd2917a@kernel.org>
References: <20260405-work-qmp-monitor-hotplug-v2-0-ad5bedd2917a@kernel.org>
In-Reply-To: <20260405-work-qmp-monitor-hotplug-v2-0-ad5bedd2917a@kernel.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7943; i=brauner@kernel.org;
 h=from:subject:message-id; bh=cP8XbmJh0GXQB9MuBcgRv0ncdejCpajjhdMyKSshUIc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWReim9at7b/kZ3QTuV7aSVpAWpnNabFyZ1ek6n7Nj3XM
 2HenNPlHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZ3sPIMLmyZ0+efnRxd1zc
 XL5fNwseLeydJKzM13L11+b2z9KPXzP8D9i566fqnYarOt/sWbY7FCw9cjz2M0dB5YmS/9XpPup
 PeQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=brauner@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Test the monitor-add, monitor-remove, and query-monitors QMP commands:

- Basic lifecycle: chardev-add -> monitor-add -> query-monitors ->
  monitor-remove -> chardev-remove
- Error: duplicate monitor id
- Error: monitor-remove on nonexistent id
- Error: monitor-add with nonexistent chardev
- Error: second monitor on same chardev (chardev already in use)
- Error: monitor-remove on CLI-created monitor
- Error: monitor-remove on HMP monitor
- Re-add after remove: same id and chardev reusable after removal

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tests/qtest/qmp-test.c | 185 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 185 insertions(+)

diff --git a/tests/qtest/qmp-test.c b/tests/qtest/qmp-test.c
index edf0886787..a493a812a9 100644
--- a/tests/qtest/qmp-test.c
+++ b/tests/qtest/qmp-test.c
@@ -337,6 +337,186 @@ static void test_qmp_missing_any_arg(void)
     qtest_quit(qts);
 }
 
+static void test_qmp_monitor_add_remove(void)
+{
+    QTestState *qts;
+    QDict *resp;
+
+    qts = qtest_init(common_args);
+
+    /* Create a null chardev for the dynamic monitor */
+    resp = qtest_qmp(qts,
+                     "{'execute': 'chardev-add',"
+                     " 'arguments': {'id': 'monitor-chardev',"
+                     "               'backend': {'type': 'null',"
+                     "                           'data': {}}}}");
+    g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
+
+    /* Add a dynamic monitor */
+    resp = qtest_qmp(qts,
+                     "{'execute': 'monitor-add',"
+                     " 'arguments': {'id': 'dyn-mon',"
+                     "               'chardev': 'monitor-chardev'}}");
+    g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
+
+    /* Verify it shows up in query-monitors */
+    resp = qtest_qmp(qts, "{'execute': 'query-monitors'}");
+    g_assert(!qdict_haskey(resp, "error"));
+    qobject_unref(resp);
+
+    /* Error: duplicate id */
+    resp = qtest_qmp(qts,
+                     "{'execute': 'monitor-add',"
+                     " 'arguments': {'id': 'dyn-mon',"
+                     "               'chardev': 'monitor-chardev'}}");
+    qmp_expect_error_and_unref(resp, "GenericError");
+
+    /* Remove the dynamic monitor */
+    resp = qtest_qmp(qts,
+                     "{'execute': 'monitor-remove',"
+                     " 'arguments': {'id': 'dyn-mon'}}");
+    g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
+
+    /* Error: remove nonexistent */
+    resp = qtest_qmp(qts,
+                     "{'execute': 'monitor-remove',"
+                     " 'arguments': {'id': 'dyn-mon'}}");
+    qmp_expect_error_and_unref(resp, "GenericError");
+
+    /* Add again after remove -- same id and chardev should work */
+    resp = qtest_qmp(qts,
+                     "{'execute': 'monitor-add',"
+                     " 'arguments': {'id': 'dyn-mon',"
+                     "               'chardev': 'monitor-chardev'}}");
+    g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
+
+    /* Clean up */
+    resp = qtest_qmp(qts,
+                     "{'execute': 'monitor-remove',"
+                     " 'arguments': {'id': 'dyn-mon'}}");
+    g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
+
+    resp = qtest_qmp(qts,
+                     "{'execute': 'chardev-remove',"
+                     " 'arguments': {'id': 'monitor-chardev'}}");
+    g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
+
+    qtest_quit(qts);
+}
+
+static void test_qmp_monitor_error_paths(void)
+{
+    QTestState *qts;
+    QDict *resp;
+
+    qts = qtest_init(common_args);
+
+    /* Error: chardev does not exist */
+    resp = qtest_qmp(qts,
+                     "{'execute': 'monitor-add',"
+                     " 'arguments': {'id': 'bad-mon',"
+                     "               'chardev': 'nonexistent'}}");
+    qmp_expect_error_and_unref(resp, "GenericError");
+
+    /* Error: remove nonexistent monitor */
+    resp = qtest_qmp(qts,
+                     "{'execute': 'monitor-remove',"
+                     " 'arguments': {'id': 'bogus'}}");
+    qmp_expect_error_and_unref(resp, "GenericError");
+
+    qtest_quit(qts);
+}
+
+static void test_qmp_monitor_chardev_in_use(void)
+{
+    QTestState *qts;
+    QDict *resp;
+
+    qts = qtest_init(common_args);
+
+    /* Create a null chardev */
+    resp = qtest_qmp(qts,
+                     "{'execute': 'chardev-add',"
+                     " 'arguments': {'id': 'shared-chr',"
+                     "               'backend': {'type': 'null',"
+                     "                           'data': {}}}}");
+    g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
+
+    /* Attach first monitor */
+    resp = qtest_qmp(qts,
+                     "{'execute': 'monitor-add',"
+                     " 'arguments': {'id': 'mon-1',"
+                     "               'chardev': 'shared-chr'}}");
+    g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
+
+    /* Error: second monitor on the same chardev */
+    resp = qtest_qmp(qts,
+                     "{'execute': 'monitor-add',"
+                     " 'arguments': {'id': 'mon-2',"
+                     "               'chardev': 'shared-chr'}}");
+    qmp_expect_error_and_unref(resp, "GenericError");
+
+    /* Clean up */
+    resp = qtest_qmp(qts,
+                     "{'execute': 'monitor-remove',"
+                     " 'arguments': {'id': 'mon-1'}}");
+    g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
+
+    resp = qtest_qmp(qts,
+                     "{'execute': 'chardev-remove',"
+                     " 'arguments': {'id': 'shared-chr'}}");
+    g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
+
+    qtest_quit(qts);
+}
+
+static void test_qmp_monitor_remove_cli(void)
+{
+    QTestState *qts;
+    QDict *resp;
+
+    /* Launch with a named CLI monitor on a null chardev */
+    qts = qtest_initf("%s -chardev null,id=cli-chr"
+                      " -mon id=cli-mon,chardev=cli-chr,mode=control",
+                      common_args);
+
+    /* Error: monitor-remove must reject CLI-created monitors */
+    resp = qtest_qmp(qts,
+                     "{'execute': 'monitor-remove',"
+                     " 'arguments': {'id': 'cli-mon'}}");
+    qmp_expect_error_and_unref(resp, "GenericError");
+
+    qtest_quit(qts);
+}
+
+static void test_qmp_monitor_remove_hmp(void)
+{
+    QTestState *qts;
+    QDict *resp;
+
+    qts = qtest_initf("%s -chardev null,id=hmp-chr"
+                      " -mon id=hmp-mon,chardev=hmp-chr,mode=readline",
+                      common_args);
+
+    /* Error: monitor-remove must reject HMP monitors */
+    resp = qtest_qmp(qts,
+                     "{'execute': 'monitor-remove',"
+                     " 'arguments': {'id': 'hmp-mon'}}");
+    qmp_expect_error_and_unref(resp, "GenericError");
+
+    qtest_quit(qts);
+}
+
 int main(int argc, char *argv[])
 {
     g_test_init(&argc, &argv, NULL);
@@ -348,6 +528,11 @@ int main(int argc, char *argv[])
 #endif
     qtest_add_func("qmp/preconfig", test_qmp_preconfig);
     qtest_add_func("qmp/missing-any-arg", test_qmp_missing_any_arg);
+    qtest_add_func("qmp/monitor-add-remove", test_qmp_monitor_add_remove);
+    qtest_add_func("qmp/monitor-error-paths", test_qmp_monitor_error_paths);
+    qtest_add_func("qmp/monitor-chardev-in-use", test_qmp_monitor_chardev_in_use);
+    qtest_add_func("qmp/monitor-remove-cli", test_qmp_monitor_remove_cli);
+    qtest_add_func("qmp/monitor-remove-hmp", test_qmp_monitor_remove_hmp);
 
     return g_test_run();
 }

-- 
2.47.3


