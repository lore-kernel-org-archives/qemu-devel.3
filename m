Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3624D3177E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 18:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Nzn-00053L-E7; Tue, 05 Nov 2024 13:09:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8Nzl-00050b-Og
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:09:37 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8Nzi-0004xE-8K
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:09:36 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1ED771F813;
 Tue,  5 Nov 2024 18:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730830173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2yFMWs3r215nc/lz7lV8nMLbQszUz7P7neQ2wje3q0=;
 b=Hp81aVPcMkE4eJePXBZrIUpWXZFoxifg/jEf+8WOBtp4zVPziili14y7BhPEteVpqtxz4E
 8TfCM8yl0zYLusUfaofqKbCQHbL9WpE5Q+luFfSgQUbY/RtC/id32+k1Q8Cms2CTP3bxn4
 jGsq1gOuTsim+apD8pOef0zMZQmgAvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730830173;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2yFMWs3r215nc/lz7lV8nMLbQszUz7P7neQ2wje3q0=;
 b=ITY7LGnHnf2WXYPk+LM+WEO6jy/tez+tclpg9+wIxcq1kbbIBQdmVplVxbk+YPvSpPj3dF
 Gx6thQS3fXrXRtDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730830173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2yFMWs3r215nc/lz7lV8nMLbQszUz7P7neQ2wje3q0=;
 b=Hp81aVPcMkE4eJePXBZrIUpWXZFoxifg/jEf+8WOBtp4zVPziili14y7BhPEteVpqtxz4E
 8TfCM8yl0zYLusUfaofqKbCQHbL9WpE5Q+luFfSgQUbY/RtC/id32+k1Q8Cms2CTP3bxn4
 jGsq1gOuTsim+apD8pOef0zMZQmgAvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730830173;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2yFMWs3r215nc/lz7lV8nMLbQszUz7P7neQ2wje3q0=;
 b=ITY7LGnHnf2WXYPk+LM+WEO6jy/tez+tclpg9+wIxcq1kbbIBQdmVplVxbk+YPvSpPj3dF
 Gx6thQS3fXrXRtDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09AD31394A;
 Tue,  5 Nov 2024 18:09:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mLdXMFpfKmeCZwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 Nov 2024 18:09:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 17/22] tests/qtest/migration: Split CPR tests
Date: Tue,  5 Nov 2024 15:08:32 -0300
Message-Id: <20241105180837.5990-18-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241105180837.5990-1-farosas@suse.de>
References: <20241105180837.5990-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Move the mode/reboot test into a separate file to hold all the CPR
tests. Currently there's just one test, but we're adding more CPR
modes and the feature is different enough from live migration that
it's worth it to have a separate file for it.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/meson.build                  |  1 +
 tests/qtest/migration-test.c             | 34 +-------------
 tests/qtest/migration/cpr-tests.c        | 57 ++++++++++++++++++++++++
 tests/qtest/migration/migration-common.h |  1 +
 4 files changed, 60 insertions(+), 33 deletions(-)
 create mode 100644 tests/qtest/migration/cpr-tests.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index e4dc85208c..e3a7549fae 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -334,6 +334,7 @@ migration_files = [files(
   'migration/migration-qmp.c',
   'migration/migration-util.c',
   'migration/compression-tests.c',
+  'migration/cpr-tests.c',
   'migration/file-tests.c',
   'migration/precopy-tests.c',
   'migration/postcopy-tests.c',
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 4abbb5b19d..8a8752ca83 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -144,31 +144,6 @@ static void test_ignore_shared(void)
 }
 #endif
 
-static void *test_mode_reboot_start(QTestState *from, QTestState *to)
-{
-    migrate_set_parameter_str(from, "mode", "cpr-reboot");
-    migrate_set_parameter_str(to, "mode", "cpr-reboot");
-
-    migrate_set_capability(from, "x-ignore-shared", true);
-    migrate_set_capability(to, "x-ignore-shared", true);
-
-    return NULL;
-}
-
-static void test_mode_reboot(void)
-{
-    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
-                                           FILE_TEST_FILENAME);
-    MigrateCommon args = {
-        .start.use_shmem = true,
-        .connect_uri = uri,
-        .listen_uri = "defer",
-        .start_hook = test_mode_reboot_start
-    };
-
-    test_file_common(&args, true);
-}
-
 static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
@@ -307,20 +282,13 @@ int main(int argc, char **argv)
     migration_test_add_postcopy(env);
     migration_test_add_file(env);
     migration_test_add_precopy(env);
+    migration_test_add_cpr(env);
 
     migration_test_add("/migration/bad_dest", test_baddest);
 #ifndef _WIN32
     migration_test_add("/migration/analyze-script", test_analyze_script);
 #endif
 
-    /*
-     * Our CI system has problems with shared memory.
-     * Don't run this test until we find a workaround.
-     */
-    if (getenv("QEMU_TEST_FLAKY_TESTS")) {
-        migration_test_add("/migration/mode/reboot", test_mode_reboot);
-    }
-
     /* migration_test_add("/migration/ignore_shared", test_ignore_shared); */
 
     migration_test_add("/migration/validate_uuid", test_validate_uuid);
diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
new file mode 100644
index 0000000000..a3b4e6dac1
--- /dev/null
+++ b/tests/qtest/migration/cpr-tests.c
@@ -0,0 +1,57 @@
+/*
+ * QTest testcases for CPR
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
+#include "migration/migration-common.h"
+#include "migration/migration-util.h"
+
+
+static char *tmpfs;
+
+static void *test_mode_reboot_start(QTestState *from, QTestState *to)
+{
+    migrate_set_parameter_str(from, "mode", "cpr-reboot");
+    migrate_set_parameter_str(to, "mode", "cpr-reboot");
+
+    migrate_set_capability(from, "x-ignore-shared", true);
+    migrate_set_capability(to, "x-ignore-shared", true);
+
+    return NULL;
+}
+
+static void test_mode_reboot(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
+                                           FILE_TEST_FILENAME);
+    MigrateCommon args = {
+        .start.use_shmem = true,
+        .connect_uri = uri,
+        .listen_uri = "defer",
+        .start_hook = test_mode_reboot_start
+    };
+
+    test_file_common(&args, true);
+}
+
+void migration_test_add_cpr(MigrationTestEnv *env)
+{
+    tmpfs = env->tmpfs;
+
+    /*
+     * Our CI system has problems with shared memory.
+     * Don't run this test until we find a workaround.
+     */
+    if (getenv("QEMU_TEST_FLAKY_TESTS")) {
+        migration_test_add("/migration/mode/reboot", test_mode_reboot);
+    }
+}
diff --git a/tests/qtest/migration/migration-common.h b/tests/qtest/migration/migration-common.h
index 9632ac1b9e..8f6828beba 100644
--- a/tests/qtest/migration/migration-common.h
+++ b/tests/qtest/migration/migration-common.h
@@ -220,5 +220,6 @@ void migration_test_add_compression(MigrationTestEnv *env);
 void migration_test_add_postcopy(MigrationTestEnv *env);
 void migration_test_add_file(MigrationTestEnv *env);
 void migration_test_add_precopy(MigrationTestEnv *env);
+void migration_test_add_cpr(MigrationTestEnv *env);
 
 #endif /* MIGRATION_COMMON_H */
-- 
2.35.3


