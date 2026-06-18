Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7E5CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 11:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waAUH-0000u6-Sq; Thu, 18 Jun 2026 07:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waAUB-0000Xx-Tq
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 07:00:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waAU5-00035x-Dw
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 07:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781780432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+AUDsS66Hb9/8n/10lpnhTOC4pHWJD/VtKQl6aJ5g68=;
 b=M6uDyshtTyPx5bCTnj10vkWS/QNEN3CNW4+APDhilCqLRSZYrC4NId0l+TNOTm2+2kpJQR
 cm76+A4lYuL9bMGEJu0NhSXjj5+eW6wahC3BUZhFAB9GRqXGG967psgb9mhfWHP3VolpLY
 UMU35j5TkvDmj2lWJKHv28h5d7+UY+s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-wZGxJBWEMA6mWz2aBPJKBA-1; Thu,
 18 Jun 2026 07:00:28 -0400
X-MC-Unique: wZGxJBWEMA6mWz2aBPJKBA-1
X-Mimecast-MFC-AGG-ID: wZGxJBWEMA6mWz2aBPJKBA_1781780427
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0ACFE18009E4; Thu, 18 Jun 2026 11:00:27 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.28])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F30D1956087; Thu, 18 Jun 2026 11:00:23 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 27/35] tests/qtest: add tests for dynamic monitor add/remove
Date: Thu, 18 Jun 2026 11:58:28 +0100
Message-ID: <20260618105836.991609-28-berrange@redhat.com>
In-Reply-To: <20260618105836.991609-1-berrange@redhat.com>
References: <20260618105836.991609-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Christian Brauner <brauner@kernel.org>

Test the object-add/object-del QMP commands with the monitor-qmp
object type.

- Basic lifecycle: chardev-add -> object-add -> object-del -> chardev-remove
- Error: object-add with nonexistent chardev
- Error: second monitor on same chardev (chardev already in use)
- Removal of CLI-created QMP monitor succeeds
- Error: object-remove on HMP monitor
- Re-add after remove: same id and chardev reusable after removal

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[DB: modified to use object-add/object-del, removing redundant
     scenarios already handled by object-add/del code]
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/qmp-test.c | 174 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 174 insertions(+)

diff --git a/tests/qtest/qmp-test.c b/tests/qtest/qmp-test.c
index edf0886787..3a325a04e0 100644
--- a/tests/qtest/qmp-test.c
+++ b/tests/qtest/qmp-test.c
@@ -337,6 +337,174 @@ static void test_qmp_missing_any_arg(void)
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
+                     "{'execute': 'object-add',"
+                     " 'arguments': {'qom-type': 'monitor-qmp',"
+                     "               'id': 'dyn-mon',"
+                     "               'chardev': 'monitor-chardev'}}");
+    g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
+
+    /* Remove the dynamic monitor */
+    resp = qtest_qmp(qts,
+                     "{'execute': 'object-del',"
+                     " 'arguments': {'id': 'dyn-mon'}}");
+    g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
+
+    /* Add again after remove -- same id and chardev should work */
+    resp = qtest_qmp(qts,
+                     "{'execute': 'object-add',"
+                     " 'arguments': {'qom-type': 'monitor-qmp',"
+                     "               'id': 'dyn-mon',"
+                     "               'chardev': 'monitor-chardev'}}");
+    g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
+
+    /* Clean up */
+    resp = qtest_qmp(qts,
+                     "{'execute': 'object-del',"
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
+                     "{'execute': 'object-add',"
+                     " 'arguments': {'qom-type': 'monitor-qmp',"
+                     "               'id': 'bad-mon',"
+                     "               'chardev': 'nonexistent'}}");
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
+                     "{'execute': 'object-add',"
+                     " 'arguments': {'qom-type': 'monitor-qmp',"
+                     "               'id': 'mon-1',"
+                     "               'chardev': 'shared-chr'}}");
+    g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
+
+    /* Error: second monitor on the same chardev */
+    resp = qtest_qmp(qts,
+                     "{'execute': 'object-add',"
+                     " 'arguments': {'qom-type': 'monitor-qmp',"
+                     "               'id': 'mon-2',"
+                     "               'chardev': 'shared-chr'}}");
+    qmp_expect_error_and_unref(resp, "GenericError");
+
+    /* Clean up */
+    resp = qtest_qmp(qts,
+                     "{'execute': 'object-del',"
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
+                      " -object monitor-qmp,id=cli-mon,chardev=cli-chr",
+                      common_args);
+
+    /* CLI-created QMP monitors can be removed */
+    resp = qtest_qmp(qts,
+                     "{'execute': 'object-del',"
+                     " 'arguments': {'id': 'cli-mon'}}");
+    g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
+
+    resp = qtest_qmp(qts,
+                     "{'execute': 'chardev-remove',"
+                     " 'arguments': {'id': 'cli-chr'}}");
+    g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
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
+                      " -object monitor-hmp,id=hmp-mon,chardev=hmp-chr",
+                      common_args);
+
+    /* Error: object_del must reject HMP monitors */
+    resp = qtest_qmp(qts,
+                     "{'execute': 'object-del',"
+                     " 'arguments': {'id': 'hmp-mon'}}");
+    qmp_expect_error_and_unref(resp, "GenericError");
+
+    qtest_quit(qts);
+}
+
 int main(int argc, char *argv[])
 {
     g_test_init(&argc, &argv, NULL);
@@ -348,6 +516,12 @@ int main(int argc, char *argv[])
 #endif
     qtest_add_func("qmp/preconfig", test_qmp_preconfig);
     qtest_add_func("qmp/missing-any-arg", test_qmp_missing_any_arg);
+    qtest_add_func("qmp/monitor-add-remove", test_qmp_monitor_add_remove);
+    qtest_add_func("qmp/monitor-error-paths", test_qmp_monitor_error_paths);
+    qtest_add_func("qmp/monitor-chardev-in-use",
+                    test_qmp_monitor_chardev_in_use);
+    qtest_add_func("qmp/monitor-remove-cli", test_qmp_monitor_remove_cli);
+    qtest_add_func("qmp/monitor-remove-hmp", test_qmp_monitor_remove_hmp);
 
     return g_test_run();
 }
-- 
2.54.0


