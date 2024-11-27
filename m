Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E30D6ACFD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 18:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGMnB-0006c5-Ck; Wed, 27 Nov 2024 13:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tGMnA-0006bp-4N
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 13:29:36 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tGMn7-00021E-VN
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 13:29:35 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B99651F38D;
 Wed, 27 Nov 2024 18:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732732172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VVaJjlp9nySgSAZ8W4dYmquNmukCXvdeTf5KHADWYbU=;
 b=lHWXyIM/U3jkQetHHYCXqXzOYzKBlqzR0jyhPDg49nWJG6bHDu96zndyFSl6BkxmXXgHAw
 UD+pPf5acE/e5oweplWaoKRTujAlRp7Vf8CmP2WzYjnqa+5xNgN3JjtIHK2eUywMI9oK+r
 M9yKOzUJa/fM2Sr9TzmnJqY/OV3icHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732732172;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VVaJjlp9nySgSAZ8W4dYmquNmukCXvdeTf5KHADWYbU=;
 b=5hrNQHdmlYd+FNO1dzFbBcj7sflLyZfxYvei/viAXaJPSzZ+JOY074Zfl2T5H7BvTqYiUh
 jDTx91mwuKT6J1Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732732172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VVaJjlp9nySgSAZ8W4dYmquNmukCXvdeTf5KHADWYbU=;
 b=lHWXyIM/U3jkQetHHYCXqXzOYzKBlqzR0jyhPDg49nWJG6bHDu96zndyFSl6BkxmXXgHAw
 UD+pPf5acE/e5oweplWaoKRTujAlRp7Vf8CmP2WzYjnqa+5xNgN3JjtIHK2eUywMI9oK+r
 M9yKOzUJa/fM2Sr9TzmnJqY/OV3icHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732732172;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VVaJjlp9nySgSAZ8W4dYmquNmukCXvdeTf5KHADWYbU=;
 b=5hrNQHdmlYd+FNO1dzFbBcj7sflLyZfxYvei/viAXaJPSzZ+JOY074Zfl2T5H7BvTqYiUh
 jDTx91mwuKT6J1Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1395513941;
 Wed, 27 Nov 2024 18:29:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EDq2MQplR2faYQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 27 Nov 2024 18:29:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 13/17] tests/qtest/migration: Split postcopy tests
Date: Wed, 27 Nov 2024 15:28:57 -0300
Message-Id: <20241127182901.529-14-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241127182901.529-1-farosas@suse.de>
References: <20241127182901.529-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.19)[-0.948];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
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

Split the next group of tests from migration-test.c, the postcopy
tests. This is another well-defined group of tests and postcopy is a
unique enough feature that it deserves it's own file.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/meson.build                |   1 +
 tests/qtest/migration-test.c           |  78 +-----------------
 tests/qtest/migration/framework.h      |   1 +
 tests/qtest/migration/postcopy-tests.c | 106 +++++++++++++++++++++++++
 4 files changed, 109 insertions(+), 77 deletions(-)
 create mode 100644 tests/qtest/migration/postcopy-tests.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 3131f92406..cf29101974 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -337,6 +337,7 @@ migration_files = [files(
   'migration/migration-qmp.c',
   'migration/migration-util.c',
   'migration/compression-tests.c',
+  'migration/postcopy-tests.c',
 )]
 
 migration_tls_files = []
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 3528676678..fa759022d1 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -43,65 +43,6 @@
 
 static char *tmpfs;
 
-static void test_postcopy(void)
-{
-    MigrateCommon args = { };
-
-    test_postcopy_common(&args);
-}
-
-static void test_postcopy_suspend(void)
-{
-    MigrateCommon args = {
-        .start.suspend_me = true,
-    };
-
-    test_postcopy_common(&args);
-}
-
-static void test_postcopy_preempt(void)
-{
-    MigrateCommon args = {
-        .postcopy_preempt = true,
-    };
-
-    test_postcopy_common(&args);
-}
-
-static void test_postcopy_recovery(void)
-{
-    MigrateCommon args = { };
-
-    test_postcopy_recovery_common(&args);
-}
-
-static void test_postcopy_recovery_fail_handshake(void)
-{
-    MigrateCommon args = {
-        .postcopy_recovery_fail_stage = POSTCOPY_FAIL_RECOVERY,
-    };
-
-    test_postcopy_recovery_common(&args);
-}
-
-static void test_postcopy_recovery_fail_reconnect(void)
-{
-    MigrateCommon args = {
-        .postcopy_recovery_fail_stage = POSTCOPY_FAIL_CHANNEL_ESTABLISH,
-    };
-
-    test_postcopy_recovery_common(&args);
-}
-
-static void test_postcopy_preempt_recovery(void)
-{
-    MigrateCommon args = {
-        .postcopy_preempt = true,
-    };
-
-    test_postcopy_recovery_common(&args);
-}
-
 static void test_baddest(void)
 {
     MigrateStart args = {
@@ -1558,6 +1499,7 @@ int main(int argc, char **argv)
 
     migration_test_add_tls(env);
     migration_test_add_compression(env);
+    migration_test_add_postcopy(env);
 
     migration_test_add("/migration/bad_dest", test_baddest);
 #ifndef _WIN32
@@ -1571,24 +1513,6 @@ int main(int argc, char **argv)
                            test_precopy_unix_suspend_notlive);
     }
 
-    if (env->has_uffd) {
-        migration_test_add("/migration/postcopy/plain", test_postcopy);
-        migration_test_add("/migration/postcopy/recovery/plain",
-                           test_postcopy_recovery);
-        migration_test_add("/migration/postcopy/preempt/plain",
-                           test_postcopy_preempt);
-        migration_test_add("/migration/postcopy/preempt/recovery/plain",
-                           test_postcopy_preempt_recovery);
-        migration_test_add("/migration/postcopy/recovery/double-failures/handshake",
-                           test_postcopy_recovery_fail_handshake);
-        migration_test_add("/migration/postcopy/recovery/double-failures/reconnect",
-                           test_postcopy_recovery_fail_reconnect);
-        if (env->is_x86) {
-            migration_test_add("/migration/postcopy/suspend",
-                               test_postcopy_suspend);
-        }
-    }
-
     migration_test_add("/migration/precopy/unix/plain",
                        test_precopy_unix_plain);
     migration_test_add("/migration/precopy/file",
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index bc978d4c1c..1ac3aea4b2 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -221,5 +221,6 @@ void migration_test_add_tls(MigrationTestEnv *env);
 static inline void migration_test_add_tls(MigrationTestEnv *env) {};
 #endif
 void migration_test_add_compression(MigrationTestEnv *env);
+void migration_test_add_postcopy(MigrationTestEnv *env);
 
 #endif /* TEST_FRAMEWORK_H */
diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
new file mode 100644
index 0000000000..daf7449f2c
--- /dev/null
+++ b/tests/qtest/migration/postcopy-tests.c
@@ -0,0 +1,106 @@
+/*
+ * QTest testcases for postcopy migration
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
+#include "migration/migration-util.h"
+#include "qapi/qmp/qlist.h"
+#include "qemu/module.h"
+#include "qemu/option.h"
+#include "qemu/range.h"
+#include "qemu/sockets.h"
+
+static void test_postcopy(void)
+{
+    MigrateCommon args = { };
+
+    test_postcopy_common(&args);
+}
+
+static void test_postcopy_suspend(void)
+{
+    MigrateCommon args = {
+        .start.suspend_me = true,
+    };
+
+    test_postcopy_common(&args);
+}
+
+static void test_postcopy_preempt(void)
+{
+    MigrateCommon args = {
+        .postcopy_preempt = true,
+    };
+
+    test_postcopy_common(&args);
+}
+
+static void test_postcopy_recovery(void)
+{
+    MigrateCommon args = { };
+
+    test_postcopy_recovery_common(&args);
+}
+
+static void test_postcopy_recovery_fail_handshake(void)
+{
+    MigrateCommon args = {
+        .postcopy_recovery_fail_stage = POSTCOPY_FAIL_RECOVERY,
+    };
+
+    test_postcopy_recovery_common(&args);
+}
+
+static void test_postcopy_recovery_fail_reconnect(void)
+{
+    MigrateCommon args = {
+        .postcopy_recovery_fail_stage = POSTCOPY_FAIL_CHANNEL_ESTABLISH,
+    };
+
+    test_postcopy_recovery_common(&args);
+}
+
+static void test_postcopy_preempt_recovery(void)
+{
+    MigrateCommon args = {
+        .postcopy_preempt = true,
+    };
+
+    test_postcopy_recovery_common(&args);
+}
+
+void migration_test_add_postcopy(MigrationTestEnv *env)
+{
+    if (env->has_uffd) {
+        migration_test_add("/migration/postcopy/plain", test_postcopy);
+        migration_test_add("/migration/postcopy/recovery/plain",
+                           test_postcopy_recovery);
+        migration_test_add("/migration/postcopy/preempt/plain",
+                           test_postcopy_preempt);
+        migration_test_add("/migration/postcopy/preempt/recovery/plain",
+                           test_postcopy_preempt_recovery);
+
+        migration_test_add(
+            "/migration/postcopy/recovery/double-failures/handshake",
+            test_postcopy_recovery_fail_handshake);
+
+        migration_test_add(
+            "/migration/postcopy/recovery/double-failures/reconnect",
+            test_postcopy_recovery_fail_reconnect);
+
+        if (env->is_x86) {
+            migration_test_add("/migration/postcopy/suspend",
+                               test_postcopy_suspend);
+        }
+    }
+}
-- 
2.35.3


