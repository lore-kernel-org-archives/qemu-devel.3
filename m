Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C8ACC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJXr-0006IQ-M1; Thu, 15 Oct 2026 07:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJXc-0005qM-4s
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:22:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJXa-0004Cd-9B
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6vLizomyPwqHlqTEjyg8D92Xsk6Hhk4CiZI2lAtTgxY=;
 b=I7VB7wMhWF4/phsuc3D8xC/ehc2qqahaCR+QxU1sOaxQxuvc5QmVKjKxo8wQUj2ldUuP+3
 LLEQDtcxS+NwYY0O5yFUuQ6JVLzGbXH4ObJspNvrbsv9qXjIJQaGAS0znx1fia94DabR3+
 V7V/KQF93DDHEObBeQK1WoDNCHvt458=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-3q5SrAryO1usPkma5n3Uqw-1; Thu,
 15 Oct 2026 11:22:14 +0000
X-MC-Unique: 3q5SrAryO1usPkma5n3Uqw-1
X-Mimecast-MFC-AGG-ID: 3q5SrAryO1usPkma5n3Uqw_1792063333
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFA98180067A; Thu, 15 Oct 2026 11:22:12 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 88BBF1800677; Thu, 15 Oct 2026 11:22:09 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 21/21] tests/qtest: add test to validate data recorder on
 crashes
Date: Thu, 15 Oct 2026 12:20:44 +0100
Message-ID: <20261015112044.1999748-22-berrange@redhat.com>
In-Reply-To: <20261015112044.1999748-1-berrange@redhat.com>
References: <20261015112044.1999748-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

Use qtest to trigger a QEMU crash and validate that a data
recorder crash dump is written to disk.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/meson.build |   3 +
 tests/qtest/tldr-test.c | 124 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+)
 create mode 100644 tests/qtest/tldr-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 200abf6f36d..c7bba9ea828 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -27,6 +27,9 @@ qtests_generic = [
   'qmp-cmd-test',
   'qom-test',
 ]
+if host_os != 'windows'
+  qtests_generic += ['tldr-test']
+endif
 if have_hmp
   qtests_generic += [
     'test-hmp',
diff --git a/tests/qtest/tldr-test.c b/tests/qtest/tldr-test.c
new file mode 100644
index 00000000000..b20d44577af
--- /dev/null
+++ b/tests/qtest/tldr-test.c
@@ -0,0 +1,124 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * QTest testcase for the data recorder (tldr)
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "util/tldr-internal.h"
+
+
+static QTestState *qtldr_test_start(const char *crashfile)
+{
+    return qtest_initf("-object tldr-config,id=tldr,crash-target=%s", crashfile);
+}
+
+static void test_crash(QTestCrashType type, int signo)
+{
+    QTestState *qts = NULL;
+    g_autofree char *crashfile = NULL;
+    g_autofree char *crashreport = NULL;
+    size_t crashlen = 0;
+    int fd = g_file_open_tmp("tldr-test-XXXXXX",
+                             &crashfile, NULL);
+    assert(fd != -1);
+    qts = qtldr_test_start(crashfile);
+
+    qtest_crash(qts, type);
+
+    assert(g_file_get_contents(crashfile, &crashreport, &crashlen, NULL));
+    close(fd);
+    unlink(crashfile);
+    qtest_set_expected_signal(qts, signo);
+    qtest_quit(qts);
+
+    assert(crashlen != 0);
+    assert(strstr(crashreport, QTLDR_DUMP_LEADER));
+    assert(strstr(crashreport, QTLDR_DUMP_TRIGGER_PREFIX));
+    assert(strstr(crashreport, QTLDR_DUMP_MSG_BUCKET_PREFIX));
+    assert(strstr(crashreport, QTLDR_DUMP_TRAILER));
+}
+
+static void test_crash_null_pointer(void)
+{
+    test_crash(QTEST_CRASH_NULL_POINTER, SIGSEGV);
+}
+
+static void test_crash_invalid_addr(void)
+{
+    test_crash(QTEST_CRASH_INVALID_ADDR, SIGSEGV);
+}
+
+static void test_crash_mapping_not_backed(void)
+{
+    test_crash(QTEST_CRASH_MAPPING_NOT_BACKED, SIGBUS);
+}
+
+#if defined(__x86_64__) || defined(__aarch64__)
+static void test_crash_bad_alignment(void)
+{
+    test_crash(QTEST_CRASH_BAD_ALIGNMENT, SIGBUS);
+}
+#endif
+
+static void test_crash_fpe_div_zero(void)
+{
+    test_crash(QTEST_CRASH_FPE_DIV_ZERO, SIGFPE);
+}
+
+
+static void test_crash_assert(void)
+{
+    test_crash(QTEST_CRASH_ASSERT, SIGABRT);
+}
+
+static void test_crash_illegal_inst(void)
+{
+    test_crash(QTEST_CRASH_ILLEGAL_INST, SIGILL);
+}
+
+static void test_qmp(void)
+{
+    QTestState *qts = NULL;
+    g_autofree char *crashfile = NULL;
+    g_autofree char *crashreport = NULL;
+    size_t crashlen = 0;
+    int fd = g_file_open_tmp("tldr-test-XXXXXX",
+                             &crashfile, NULL);
+    assert(fd != -1);
+    qts = qtldr_test_start(crashfile);
+
+    qtest_qmp_assert_success(
+        qts, "{'execute':'tldr-dump','arguments':{'target': %s}}",
+        crashfile);
+
+    assert(g_file_get_contents(crashfile, &crashreport, &crashlen, NULL));
+    close(fd);
+    unlink(crashfile);
+    qtest_quit(qts);
+
+    assert(crashlen != 0);
+    assert(strstr(crashreport, QTLDR_DUMP_LEADER));
+    assert(strstr(crashreport, QTLDR_DUMP_TRIGGER_PREFIX));
+    assert(strstr(crashreport, QTLDR_DUMP_MSG_BUCKET_PREFIX));
+    assert(strstr(crashreport, QTLDR_DUMP_TRAILER));
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/tldr/null-pointer", test_crash_null_pointer);
+    qtest_add_func("/tldr/invalid-addr", test_crash_invalid_addr);
+    qtest_add_func("/tldr/mapping-not-backed", test_crash_mapping_not_backed);
+#if defined(__x86_64__) || defined(__aarch64__)
+    qtest_add_func("/tldr/bad-alignment", test_crash_bad_alignment);
+#endif
+    qtest_add_func("/tldr/fpe-div-zero", test_crash_fpe_div_zero);
+    qtest_add_func("/tldr/assert", test_crash_assert);
+    qtest_add_func("/tldr/illegal-inst", test_crash_illegal_inst);
+    qtest_add_func("/tldr/qmp", test_qmp);
+
+    return g_test_run();
+}
-- 
2.56.0


