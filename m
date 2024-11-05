Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD1BD3177B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 18:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Nzh-0004yb-9o; Tue, 05 Nov 2024 13:09:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8Nzc-0004xH-Gw
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:09:28 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8Nza-0004wW-GZ
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:09:28 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5880A21D3A;
 Tue,  5 Nov 2024 18:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730830165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AIBKb0RV2s9yut17iYrTOAf1A8QLObMADWj9wZ1Ou+c=;
 b=IL2zcLUit4v9YLiV5GZq+bAmHGZfL1hdVNgislRSjMbKlORBMrjECTJPTKCkygEO4CDYfI
 5LDaex3yeYeWM2rPlVaJuy6dmRVYC4ypLJogCU9Foyav40ayz2DKyOLgmq5o2/Te2vTHw+
 rXti07hSF9xrASGY2Hin/G+31ZS06us=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730830165;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AIBKb0RV2s9yut17iYrTOAf1A8QLObMADWj9wZ1Ou+c=;
 b=xocxwmlu69VqrByCcfeqqS9UjRoo9sPtbpERhZJ9mwsZzlfY+RuFfmwqHMZIHT5Rf4Nz0p
 c/zd7G7Jl0HCkRAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IL2zcLUi;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xocxwmlu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730830165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AIBKb0RV2s9yut17iYrTOAf1A8QLObMADWj9wZ1Ou+c=;
 b=IL2zcLUit4v9YLiV5GZq+bAmHGZfL1hdVNgislRSjMbKlORBMrjECTJPTKCkygEO4CDYfI
 5LDaex3yeYeWM2rPlVaJuy6dmRVYC4ypLJogCU9Foyav40ayz2DKyOLgmq5o2/Te2vTHw+
 rXti07hSF9xrASGY2Hin/G+31ZS06us=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730830165;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AIBKb0RV2s9yut17iYrTOAf1A8QLObMADWj9wZ1Ou+c=;
 b=xocxwmlu69VqrByCcfeqqS9UjRoo9sPtbpERhZJ9mwsZzlfY+RuFfmwqHMZIHT5Rf4Nz0p
 c/zd7G7Jl0HCkRAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4510213A17;
 Tue,  5 Nov 2024 18:09:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EGh1A1NfKmeCZwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 Nov 2024 18:09:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 14/22] tests/qtest/migration: Split postcopy tests
Date: Tue,  5 Nov 2024 15:08:29 -0300
Message-Id: <20241105180837.5990-15-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241105180837.5990-1-farosas@suse.de>
References: <20241105180837.5990-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5880A21D3A
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RL6tyf6sue6knz55rs3us8rsc3)];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Split the next group of tests from migration-test.c, the postcopy
tests. This is another well-defined group of tests and postcopy is a
unique enough feature that it deserves it's own file.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/meson.build                  |   1 +
 tests/qtest/migration-test.c             |  78 +----------------
 tests/qtest/migration/migration-common.h |   1 +
 tests/qtest/migration/postcopy-tests.c   | 101 +++++++++++++++++++++++
 4 files changed, 104 insertions(+), 77 deletions(-)
 create mode 100644 tests/qtest/migration/postcopy-tests.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 4d29746708..bccfcc63ff 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -334,6 +334,7 @@ migration_files = [files(
   'migration/migration-qmp.c',
   'migration/migration-util.c',
   'migration/compression-tests.c',
+  'migration/postcopy-tests.c',
 )]
 
 migration_tls_files = []
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index a22ae06f88..ad7be589ef 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -42,65 +42,6 @@
 
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
@@ -1548,6 +1489,7 @@ int main(int argc, char **argv)
 
     migration_test_add_tls(env);
     migration_test_add_compression(env);
+    migration_test_add_postcopy(env);
 
     migration_test_add("/migration/bad_dest", test_baddest);
 #ifndef _WIN32
@@ -1561,24 +1503,6 @@ int main(int argc, char **argv)
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
diff --git a/tests/qtest/migration/migration-common.h b/tests/qtest/migration/migration-common.h
index 18e85baece..8ac6d2fa5d 100644
--- a/tests/qtest/migration/migration-common.h
+++ b/tests/qtest/migration/migration-common.h
@@ -217,5 +217,6 @@ void migration_test_add_tls(MigrationTestEnv *env);
 static inline void migration_test_add_tls(MigrationTestEnv *env) {};
 #endif
 void migration_test_add_compression(MigrationTestEnv *env);
+void migration_test_add_postcopy(MigrationTestEnv *env);
 
 #endif /* MIGRATION_COMMON_H */
diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
new file mode 100644
index 0000000000..30ce54339c
--- /dev/null
+++ b/tests/qtest/migration/postcopy-tests.c
@@ -0,0 +1,101 @@
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
+#include "migration/migration-common.h"
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
+        migration_test_add("/migration/postcopy/recovery/double-failures/handshake",
+                           test_postcopy_recovery_fail_handshake);
+        migration_test_add("/migration/postcopy/recovery/double-failures/reconnect",
+                           test_postcopy_recovery_fail_reconnect);
+        if (env->is_x86) {
+            migration_test_add("/migration/postcopy/suspend",
+                               test_postcopy_suspend);
+        }
+    }
+}
-- 
2.35.3


