Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1882D637AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 19:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBJKc-0006W6-Hg; Wed, 13 Nov 2024 14:47:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBJKa-0006Vd-Iu
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 14:47:12 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBJKY-0003B9-L1
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 14:47:12 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6BBCB21109;
 Wed, 13 Nov 2024 19:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731527229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/6KiiPqfScx0wNZ9C8CRBzOrbDspXRpFvRZvJsyXx1M=;
 b=zYiIImn6B5MtW/laLD0fnqMBAeFo6zZ8SPwZYP7Qo9SV0nJHDrk9ShoXxX9pkfW7DjDxNh
 u7rpwuAHffuaYLqYzgYAPCXJEH0Zvi66xInUvxvYkcPeNRK34hedAdpIpG2Cbrr6WlWC+t
 Mtn3cW3RTH7g4bHL9mUlKHfV1nHzrNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731527229;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/6KiiPqfScx0wNZ9C8CRBzOrbDspXRpFvRZvJsyXx1M=;
 b=Cl8JZmi2EwPKNzAPtpvgt4q9kWj3bUK36JcjR2NdfvZBMiIan6N8GBzQBbr8NA9BTxRLDS
 HhYDKXO7L7UzVBBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zYiIImn6;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Cl8JZmi2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731527229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/6KiiPqfScx0wNZ9C8CRBzOrbDspXRpFvRZvJsyXx1M=;
 b=zYiIImn6B5MtW/laLD0fnqMBAeFo6zZ8SPwZYP7Qo9SV0nJHDrk9ShoXxX9pkfW7DjDxNh
 u7rpwuAHffuaYLqYzgYAPCXJEH0Zvi66xInUvxvYkcPeNRK34hedAdpIpG2Cbrr6WlWC+t
 Mtn3cW3RTH7g4bHL9mUlKHfV1nHzrNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731527229;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/6KiiPqfScx0wNZ9C8CRBzOrbDspXRpFvRZvJsyXx1M=;
 b=Cl8JZmi2EwPKNzAPtpvgt4q9kWj3bUK36JcjR2NdfvZBMiIan6N8GBzQBbr8NA9BTxRLDS
 HhYDKXO7L7UzVBBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 514D313301;
 Wed, 13 Nov 2024 19:47:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SM4LBjsCNWfLcQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 13 Nov 2024 19:47:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 14/22] tests/qtest/migration: Split postcopy tests
Date: Wed, 13 Nov 2024 16:46:22 -0300
Message-Id: <20241113194630.3385-15-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241113194630.3385-1-farosas@suse.de>
References: <20241113194630.3385-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6BBCB21109
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 R_RATELIMIT(0.00)[to_ip_from(RL6tyf6sue6knz55rs3us8rsc3)];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/meson.build                |   1 +
 tests/qtest/migration-test.c           |  78 +-----------------
 tests/qtest/migration/postcopy-tests.c | 106 +++++++++++++++++++++++++
 tests/qtest/migration/test-framework.h |   1 +
 4 files changed, 109 insertions(+), 77 deletions(-)
 create mode 100644 tests/qtest/migration/postcopy-tests.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 5e77eb09f2..23b600e6ec 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -336,6 +336,7 @@ migration_files = [files(
   'migration/migration-qmp.c',
   'migration/migration-util.c',
   'migration/compression-tests.c',
+  'migration/postcopy-tests.c',
 )]
 
 migration_tls_files = []
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 4a468079e8..d1d67fc42f 100644
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
@@ -1553,6 +1494,7 @@ int main(int argc, char **argv)
 
     migration_test_add_tls(env);
     migration_test_add_compression(env);
+    migration_test_add_postcopy(env);
 
     migration_test_add("/migration/bad_dest", test_baddest);
 #ifndef _WIN32
@@ -1566,24 +1508,6 @@ int main(int argc, char **argv)
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
diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
new file mode 100644
index 0000000000..9e2032bbf3
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
+#include "migration/test-framework.h"
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
diff --git a/tests/qtest/migration/test-framework.h b/tests/qtest/migration/test-framework.h
index 0f16f37426..d5197e8da1 100644
--- a/tests/qtest/migration/test-framework.h
+++ b/tests/qtest/migration/test-framework.h
@@ -219,5 +219,6 @@ void migration_test_add_tls(MigrationTestEnv *env);
 static inline void migration_test_add_tls(MigrationTestEnv *env) {};
 #endif
 void migration_test_add_compression(MigrationTestEnv *env);
+void migration_test_add_postcopy(MigrationTestEnv *env);
 
 #endif /* TEST_FRAMEWORK_H */
-- 
2.35.3


