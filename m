Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FBAE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkqK-0004ln-47; Thu, 12 Dec 2024 10:11:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpm-0004FQ-1n
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:10:34 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpi-0003G2-TY
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:10:33 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9E7B21F445;
 Thu, 12 Dec 2024 15:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDZpeC6rYI1YlIJo+CzM3cZy8J3VgDyf7eBmt5XCcAg=;
 b=rho1Op/3pLogfPQN5vrk1DBC5uOv1/M52B509hRpAQc8kOc7i9nL+7zK/0GUI4lUelXvhE
 yWnxtcnNbfvUh8xuad5Y18Ftc5VuyvXz6JGXowEWb6HtxEj18EroVd9dZmn9X1JWIJA6z+
 3INlYgj9t6tC+i96NOPz1GGyEqMPCk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016229;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDZpeC6rYI1YlIJo+CzM3cZy8J3VgDyf7eBmt5XCcAg=;
 b=xc33l/0+azTbZ/04CY62AAevSaqQyxeCflgR5+6kakNnJVL/UefQwA97VJNP1tHIvCb4xc
 2hgSNrbCOMfIdjCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDZpeC6rYI1YlIJo+CzM3cZy8J3VgDyf7eBmt5XCcAg=;
 b=rho1Op/3pLogfPQN5vrk1DBC5uOv1/M52B509hRpAQc8kOc7i9nL+7zK/0GUI4lUelXvhE
 yWnxtcnNbfvUh8xuad5Y18Ftc5VuyvXz6JGXowEWb6HtxEj18EroVd9dZmn9X1JWIJA6z+
 3INlYgj9t6tC+i96NOPz1GGyEqMPCk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016229;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDZpeC6rYI1YlIJo+CzM3cZy8J3VgDyf7eBmt5XCcAg=;
 b=xc33l/0+azTbZ/04CY62AAevSaqQyxeCflgR5+6kakNnJVL/UefQwA97VJNP1tHIvCb4xc
 2hgSNrbCOMfIdjCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7106113508;
 Thu, 12 Dec 2024 15:10:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EFTjDeT8WmcTfQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 12 Dec 2024 15:10:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 22/22] tests/qtest/migration: Split validation tests + misc
Date: Thu, 12 Dec 2024 12:09:49 -0300
Message-Id: <20241212150949.16806-23-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241212150949.16806-1-farosas@suse.de>
References: <20241212150949.16806-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Move the remaining tests into a misc-tests.c file. These tests are
mostly about validation of input and should be in the future replaced
by unit testing.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/meson.build            |   1 +
 tests/qtest/migration-test.c       | 285 +----------------------------
 tests/qtest/migration/framework.h  |   1 +
 tests/qtest/migration/misc-tests.c | 282 ++++++++++++++++++++++++++++
 4 files changed, 286 insertions(+), 283 deletions(-)
 create mode 100644 tests/qtest/migration/misc-tests.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index cda1a84122..c5a70021c5 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -340,6 +340,7 @@ migration_files = [files(
   'migration/compression-tests.c',
   'migration/cpr-tests.c',
   'migration/file-tests.c',
+  'migration/misc-tests.c',
   'migration/precopy-tests.c',
   'migration/postcopy-tests.c',
 )]
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 4b366a94a2..5cad5060b3 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -11,262 +11,8 @@
  */
 
 #include "qemu/osdep.h"
-
-#include "libqtest.h"
-#include "qapi/qmp/qlist.h"
-#include "qemu/module.h"
-#include "qemu/option.h"
-#include "qemu/range.h"
-#include "qemu/sockets.h"
-#include "chardev/char.h"
-#include "crypto/tlscredspsk.h"
-#include "ppc-util.h"
-
-#include "migration/bootfile.h"
 #include "migration/framework.h"
-#include "migration/migration-qmp.h"
-#include "migration/migration-util.h"
-
-#define ANALYZE_SCRIPT "scripts/analyze-migration.py"
-
-#if defined(__linux__)
-#include <sys/ioctl.h>
-#include <sys/syscall.h>
-#include <sys/vfs.h>
-#endif
-
-static char *tmpfs;
-
-static void test_baddest(void)
-{
-    MigrateStart args = {
-        .hide_stderr = true
-    };
-    QTestState *from, *to;
-
-    if (migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
-        return;
-    }
-    migrate_qmp(from, to, "tcp:127.0.0.1:0", NULL, "{}");
-    wait_for_migration_fail(from, false);
-    migrate_end(from, to, false);
-}
-
-#ifndef _WIN32
-static void test_analyze_script(void)
-{
-    MigrateStart args = {
-        .opts_source = "-uuid 11111111-1111-1111-1111-111111111111",
-    };
-    QTestState *from, *to;
-    g_autofree char *uri = NULL;
-    g_autofree char *file = NULL;
-    int pid, wstatus;
-    const char *python = g_getenv("PYTHON");
-
-    if (!python) {
-        g_test_skip("PYTHON variable not set");
-        return;
-    }
-
-    /* dummy url */
-    if (migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
-        return;
-    }
-
-    /*
-     * Setting these two capabilities causes the "configuration"
-     * vmstate to include subsections for them. The script needs to
-     * parse those subsections properly.
-     */
-    migrate_set_capability(from, "validate-uuid", true);
-    migrate_set_capability(from, "x-ignore-shared", true);
-
-    file = g_strdup_printf("%s/migfile", tmpfs);
-    uri = g_strdup_printf("exec:cat > %s", file);
-
-    migrate_ensure_converge(from);
-    migrate_qmp(from, to, uri, NULL, "{}");
-    wait_for_migration_complete(from);
-
-    pid = fork();
-    if (!pid) {
-        close(1);
-        open("/dev/null", O_WRONLY);
-        execl(python, python, ANALYZE_SCRIPT, "-f", file, NULL);
-        g_assert_not_reached();
-    }
-
-    g_assert(waitpid(pid, &wstatus, 0) == pid);
-    if (!WIFEXITED(wstatus) || WEXITSTATUS(wstatus) != 0) {
-        g_test_message("Failed to analyze the migration stream");
-        g_test_fail();
-    }
-    migrate_end(from, to, false);
-    unlink(file);
-}
-#endif
-
-static void test_ignore_shared(void)
-{
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    QTestState *from, *to;
-    MigrateStart args = {
-        .use_shmem = true,
-    };
-
-    if (migrate_start(&from, &to, uri, &args)) {
-        return;
-    }
-
-    migrate_ensure_non_converge(from);
-    migrate_prepare_for_dirty_mem(from);
-
-    migrate_set_capability(from, "x-ignore-shared", true);
-    migrate_set_capability(to, "x-ignore-shared", true);
-
-    /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
-
-    migrate_qmp(from, to, uri, NULL, "{}");
-
-    migrate_wait_for_dirty_mem(from, to);
-
-    wait_for_stop(from, get_src());
-
-    qtest_qmp_eventwait(to, "RESUME");
-
-    wait_for_serial("dest_serial");
-    wait_for_migration_complete(from);
-
-    /* Check whether shared RAM has been really skipped */
-    g_assert_cmpint(
-        read_ram_property_int(from, "transferred"), <, 4 * 1024 * 1024);
-
-    migrate_end(from, to, true);
-}
-
-static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
-{
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    QTestState *from, *to;
-
-    if (migrate_start(&from, &to, uri, args)) {
-        return;
-    }
-
-    /*
-     * UUID validation is at the begin of migration. So, the main process of
-     * migration is not interesting for us here. Thus, set huge downtime for
-     * very fast migration.
-     */
-    migrate_set_parameter_int(from, "downtime-limit", 1000000);
-    migrate_set_capability(from, "validate-uuid", true);
-
-    /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
-
-    migrate_qmp(from, to, uri, NULL, "{}");
-
-    if (should_fail) {
-        qtest_set_expected_status(to, EXIT_FAILURE);
-        wait_for_migration_fail(from, true);
-    } else {
-        wait_for_migration_complete(from);
-    }
-
-    migrate_end(from, to, false);
-}
-
-static void test_validate_uuid(void)
-{
-    MigrateStart args = {
-        .opts_source = "-uuid 11111111-1111-1111-1111-111111111111",
-        .opts_target = "-uuid 11111111-1111-1111-1111-111111111111",
-    };
-
-    do_test_validate_uuid(&args, false);
-}
-
-static void test_validate_uuid_error(void)
-{
-    MigrateStart args = {
-        .opts_source = "-uuid 11111111-1111-1111-1111-111111111111",
-        .opts_target = "-uuid 22222222-2222-2222-2222-222222222222",
-        .hide_stderr = true,
-    };
-
-    do_test_validate_uuid(&args, true);
-}
-
-static void test_validate_uuid_src_not_set(void)
-{
-    MigrateStart args = {
-        .opts_target = "-uuid 22222222-2222-2222-2222-222222222222",
-        .hide_stderr = true,
-    };
-
-    do_test_validate_uuid(&args, false);
-}
-
-static void test_validate_uuid_dst_not_set(void)
-{
-    MigrateStart args = {
-        .opts_source = "-uuid 11111111-1111-1111-1111-111111111111",
-        .hide_stderr = true,
-    };
-
-    do_test_validate_uuid(&args, false);
-}
-
-static void do_test_validate_uri_channel(MigrateCommon *args)
-{
-    QTestState *from, *to;
-
-    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
-        return;
-    }
-
-    /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
-
-    /*
-     * 'uri' and 'channels' validation is checked even before the migration
-     * starts.
-     */
-    migrate_qmp_fail(from, args->connect_uri, args->connect_channels, "{}");
-    migrate_end(from, to, false);
-}
-
-static void test_validate_uri_channels_both_set(void)
-{
-    MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-        },
-        .listen_uri = "defer",
-        .connect_uri = "tcp:127.0.0.1:0",
-        .connect_channels = ("[ { ""'channel-type': 'main',"
-                             "    'addr': { 'transport': 'socket',"
-                             "              'type': 'inet',"
-                             "              'host': '127.0.0.1',"
-                             "              'port': '0' } } ]"),
-    };
-
-    do_test_validate_uri_channel(&args);
-}
-
-static void test_validate_uri_channels_none_set(void)
-{
-    MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-        },
-        .listen_uri = "defer",
-    };
-
-    do_test_validate_uri_channel(&args);
-}
+#include "qemu/module.h"
 
 int main(int argc, char **argv)
 {
@@ -277,45 +23,18 @@ int main(int argc, char **argv)
     env = migration_get_env();
     module_call_init(MODULE_INIT_QOM);
 
-    tmpfs = env->tmpfs;
-
     migration_test_add_tls(env);
     migration_test_add_compression(env);
     migration_test_add_postcopy(env);
     migration_test_add_file(env);
     migration_test_add_precopy(env);
     migration_test_add_cpr(env);
-
-    migration_test_add("/migration/bad_dest", test_baddest);
-#ifndef _WIN32
-    migration_test_add("/migration/analyze-script", test_analyze_script);
-#endif
-
-    /*
-     * Our CI system has problems with shared memory.
-     * Don't run this test until we find a workaround.
-     */
-    if (getenv("QEMU_TEST_FLAKY_TESTS")) {
-        migration_test_add("/migration/ignore-shared", test_ignore_shared);
-    }
-
-    migration_test_add("/migration/validate_uuid", test_validate_uuid);
-    migration_test_add("/migration/validate_uuid_error",
-                       test_validate_uuid_error);
-    migration_test_add("/migration/validate_uuid_src_not_set",
-                       test_validate_uuid_src_not_set);
-    migration_test_add("/migration/validate_uuid_dst_not_set",
-                       test_validate_uuid_dst_not_set);
-    migration_test_add("/migration/validate_uri/channels/both_set",
-                       test_validate_uri_channels_both_set);
-    migration_test_add("/migration/validate_uri/channels/none_set",
-                       test_validate_uri_channels_none_set);
+    migration_test_add_misc(env);
 
     ret = g_test_run();
 
     g_assert_cmpint(ret, ==, 0);
 
-    tmpfs = NULL;
     ret = migration_env_clean(env);
 
     return ret;
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index b264be76eb..e9fc4ec363 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -225,5 +225,6 @@ void migration_test_add_postcopy(MigrationTestEnv *env);
 void migration_test_add_file(MigrationTestEnv *env);
 void migration_test_add_precopy(MigrationTestEnv *env);
 void migration_test_add_cpr(MigrationTestEnv *env);
+void migration_test_add_misc(MigrationTestEnv *env);
 
 #endif /* TEST_FRAMEWORK_H */
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
new file mode 100644
index 0000000000..6173430748
--- /dev/null
+++ b/tests/qtest/migration/misc-tests.c
@@ -0,0 +1,282 @@
+/*
+ * QTest testcases for migration
+ *
+ * Copyright (c) 2016-2018 Red Hat, Inc. and/or its affiliates
+ *   based on the vhost-user-test.c that is:
+ *      Copyright (c) 2014 Virtual Open Systems Sarl.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "migration/framework.h"
+#include "migration/migration-qmp.h"
+#include "migration/migration-util.h"
+
+#define ANALYZE_SCRIPT "scripts/analyze-migration.py"
+
+static char *tmpfs;
+
+static void test_baddest(void)
+{
+    MigrateStart args = {
+        .hide_stderr = true
+    };
+    QTestState *from, *to;
+
+    if (migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
+        return;
+    }
+    migrate_qmp(from, to, "tcp:127.0.0.1:0", NULL, "{}");
+    wait_for_migration_fail(from, false);
+    migrate_end(from, to, false);
+}
+
+#ifndef _WIN32
+static void test_analyze_script(void)
+{
+    MigrateStart args = {
+        .opts_source = "-uuid 11111111-1111-1111-1111-111111111111",
+    };
+    QTestState *from, *to;
+    g_autofree char *uri = NULL;
+    g_autofree char *file = NULL;
+    int pid, wstatus;
+    const char *python = g_getenv("PYTHON");
+
+    if (!python) {
+        g_test_skip("PYTHON variable not set");
+        return;
+    }
+
+    /* dummy url */
+    if (migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
+        return;
+    }
+
+    /*
+     * Setting these two capabilities causes the "configuration"
+     * vmstate to include subsections for them. The script needs to
+     * parse those subsections properly.
+     */
+    migrate_set_capability(from, "validate-uuid", true);
+    migrate_set_capability(from, "x-ignore-shared", true);
+
+    file = g_strdup_printf("%s/migfile", tmpfs);
+    uri = g_strdup_printf("exec:cat > %s", file);
+
+    migrate_ensure_converge(from);
+    migrate_qmp(from, to, uri, NULL, "{}");
+    wait_for_migration_complete(from);
+
+    pid = fork();
+    if (!pid) {
+        close(1);
+        open("/dev/null", O_WRONLY);
+        execl(python, python, ANALYZE_SCRIPT, "-f", file, NULL);
+        g_assert_not_reached();
+    }
+
+    g_assert(waitpid(pid, &wstatus, 0) == pid);
+    if (!WIFEXITED(wstatus) || WEXITSTATUS(wstatus) != 0) {
+        g_test_message("Failed to analyze the migration stream");
+        g_test_fail();
+    }
+    migrate_end(from, to, false);
+    unlink(file);
+}
+#endif
+
+static void test_ignore_shared(void)
+{
+    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    QTestState *from, *to;
+    MigrateStart args = {
+        .use_shmem = true,
+    };
+
+    if (migrate_start(&from, &to, uri, &args)) {
+        return;
+    }
+
+    migrate_ensure_non_converge(from);
+    migrate_prepare_for_dirty_mem(from);
+
+    migrate_set_capability(from, "x-ignore-shared", true);
+    migrate_set_capability(to, "x-ignore-shared", true);
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    migrate_qmp(from, to, uri, NULL, "{}");
+
+    migrate_wait_for_dirty_mem(from, to);
+
+    wait_for_stop(from, get_src());
+
+    qtest_qmp_eventwait(to, "RESUME");
+
+    wait_for_serial("dest_serial");
+    wait_for_migration_complete(from);
+
+    /* Check whether shared RAM has been really skipped */
+    g_assert_cmpint(
+        read_ram_property_int(from, "transferred"), <, 4 * 1024 * 1024);
+
+    migrate_end(from, to, true);
+}
+
+static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
+{
+    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    QTestState *from, *to;
+
+    if (migrate_start(&from, &to, uri, args)) {
+        return;
+    }
+
+    /*
+     * UUID validation is at the begin of migration. So, the main process of
+     * migration is not interesting for us here. Thus, set huge downtime for
+     * very fast migration.
+     */
+    migrate_set_parameter_int(from, "downtime-limit", 1000000);
+    migrate_set_capability(from, "validate-uuid", true);
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    migrate_qmp(from, to, uri, NULL, "{}");
+
+    if (should_fail) {
+        qtest_set_expected_status(to, EXIT_FAILURE);
+        wait_for_migration_fail(from, true);
+    } else {
+        wait_for_migration_complete(from);
+    }
+
+    migrate_end(from, to, false);
+}
+
+static void test_validate_uuid(void)
+{
+    MigrateStart args = {
+        .opts_source = "-uuid 11111111-1111-1111-1111-111111111111",
+        .opts_target = "-uuid 11111111-1111-1111-1111-111111111111",
+    };
+
+    do_test_validate_uuid(&args, false);
+}
+
+static void test_validate_uuid_error(void)
+{
+    MigrateStart args = {
+        .opts_source = "-uuid 11111111-1111-1111-1111-111111111111",
+        .opts_target = "-uuid 22222222-2222-2222-2222-222222222222",
+        .hide_stderr = true,
+    };
+
+    do_test_validate_uuid(&args, true);
+}
+
+static void test_validate_uuid_src_not_set(void)
+{
+    MigrateStart args = {
+        .opts_target = "-uuid 22222222-2222-2222-2222-222222222222",
+        .hide_stderr = true,
+    };
+
+    do_test_validate_uuid(&args, false);
+}
+
+static void test_validate_uuid_dst_not_set(void)
+{
+    MigrateStart args = {
+        .opts_source = "-uuid 11111111-1111-1111-1111-111111111111",
+        .hide_stderr = true,
+    };
+
+    do_test_validate_uuid(&args, false);
+}
+
+static void do_test_validate_uri_channel(MigrateCommon *args)
+{
+    QTestState *from, *to;
+
+    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
+        return;
+    }
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    /*
+     * 'uri' and 'channels' validation is checked even before the migration
+     * starts.
+     */
+    migrate_qmp_fail(from, args->connect_uri, args->connect_channels, "{}");
+    migrate_end(from, to, false);
+}
+
+static void test_validate_uri_channels_both_set(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .hide_stderr = true,
+        },
+        .listen_uri = "defer",
+        .connect_uri = "tcp:127.0.0.1:0",
+        .connect_channels = ("[ { ""'channel-type': 'main',"
+                             "    'addr': { 'transport': 'socket',"
+                             "              'type': 'inet',"
+                             "              'host': '127.0.0.1',"
+                             "              'port': '0' } } ]"),
+    };
+
+    do_test_validate_uri_channel(&args);
+}
+
+static void test_validate_uri_channels_none_set(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .hide_stderr = true,
+        },
+        .listen_uri = "defer",
+    };
+
+    do_test_validate_uri_channel(&args);
+}
+
+void migration_test_add_misc(MigrationTestEnv *env)
+{
+    tmpfs = env->tmpfs;
+
+    migration_test_add("/migration/bad_dest", test_baddest);
+#ifndef _WIN32
+    migration_test_add("/migration/analyze-script", test_analyze_script);
+#endif
+
+    /*
+     * Our CI system has problems with shared memory.
+     * Don't run this test until we find a workaround.
+     */
+    if (getenv("QEMU_TEST_FLAKY_TESTS")) {
+        migration_test_add("/migration/ignore-shared", test_ignore_shared);
+    }
+
+    migration_test_add("/migration/validate_uuid", test_validate_uuid);
+    migration_test_add("/migration/validate_uuid_error",
+                       test_validate_uuid_error);
+    migration_test_add("/migration/validate_uuid_src_not_set",
+                       test_validate_uuid_src_not_set);
+    migration_test_add("/migration/validate_uuid_dst_not_set",
+                       test_validate_uuid_dst_not_set);
+    migration_test_add("/migration/validate_uri/channels/both_set",
+                       test_validate_uri_channels_both_set);
+    migration_test_add("/migration/validate_uri/channels/none_set",
+                       test_validate_uri_channels_none_set);
+}
-- 
2.35.3


