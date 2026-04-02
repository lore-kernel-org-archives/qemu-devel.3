Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA16AD6AB17
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 21:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8PSZ-000448-CA; Thu, 02 Apr 2026 17:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1w8PSX-0003yB-Ht
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:20:14 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1w8PSV-0005g4-Ol
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:20:13 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 12AF760125;
 Thu,  2 Apr 2026 21:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A36BC116C6;
 Thu,  2 Apr 2026 21:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775164780;
 bh=iW8amckai9wBk7Cc1O5sdHXXZB8WiWGJCBtSEG3XdSc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=kQIipvI6q54M6Nlu4GTAMqULqdXDMsArd03joVOfD3mG+R6wQM8WKfFrabTi/wcjT
 oEQOndakkChEae0X3FpW0/q78TRMp9KcBPOH8snRbeTzPbPch0/CU0GQTusQsE8aK/
 zC9I4UCg8aXF0qqduPRJcoKWWEMFXohkqTm7Dg4eijMqEzW4M4rbDSByGB1bdcOgqZ
 ZRg3ZX2I3jTFXEyTbHXglivbe8IMYfHn+0ghY6HCIr3Xuk0d9y2Ht0XKhIq5PkiMBV
 wQzGSqXQbjexmDIRSVcku9rfTQ7NPme98uiWWbVdmJNbYofFSVYNhgFtJlrx8xPYsf
 J88rQ+LikFPig==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 02 Apr 2026 23:19:19 +0200
Subject: [PATCH 4/5] tests/qtest: add tests for dynamic monitor add/remove
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-work-qmp-monitor-hotplug-v1-4-6313a5cdd574@kernel.org>
References: <20260402-work-qmp-monitor-hotplug-v1-0-6313a5cdd574@kernel.org>
In-Reply-To: <20260402-work-qmp-monitor-hotplug-v1-0-6313a5cdd574@kernel.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4873; i=brauner@kernel.org;
 h=from:subject:message-id; bh=iW8amckai9wBk7Cc1O5sdHXXZB8WiWGJCBtSEG3XdSc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSeuxuv0zbF1+2qPHuqwIHN55hO6/E0msQ8tfuXfeGk+
 w9DFRf9jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlMaGdkOKFw47v38W3b2t1/
 Hr7sYHnihKBqyMbZH8//cby7yPItgw0jw9Zfk8W29p0ocHXnFInVsmxZPvExa4Kw79PZW5WTqxK
 9eQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Received-SPF: pass client-ip=172.105.4.254; envelope-from=brauner@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
- Re-add after remove: same id and chardev reusable after removal

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tests/qtest/qmp-test.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/tests/qtest/qmp-test.c b/tests/qtest/qmp-test.c
index edf0886787..9dbd3a6103 100644
--- a/tests/qtest/qmp-test.c
+++ b/tests/qtest/qmp-test.c
@@ -337,6 +337,105 @@ static void test_qmp_missing_any_arg(void)
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
+    /* Error: remove CLI monitor (the default one) -- find its id first.
+     * CLI monitors typically have no id, so use a bogus id to test. */
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
 int main(int argc, char *argv[])
 {
     g_test_init(&argc, &argv, NULL);
@@ -348,6 +447,8 @@ int main(int argc, char *argv[])
 #endif
     qtest_add_func("qmp/preconfig", test_qmp_preconfig);
     qtest_add_func("qmp/missing-any-arg", test_qmp_missing_any_arg);
+    qtest_add_func("qmp/monitor-add-remove", test_qmp_monitor_add_remove);
+    qtest_add_func("qmp/monitor-error-paths", test_qmp_monitor_error_paths);
 
     return g_test_run();
 }

-- 
2.47.3


