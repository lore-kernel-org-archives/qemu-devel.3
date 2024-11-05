Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39195D31778
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 18:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Nzj-0004zt-KD; Tue, 05 Nov 2024 13:09:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8Nzc-0004xM-TK
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:09:28 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8Nza-0004wL-G5
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:09:28 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BE0BC1F7FB;
 Tue,  5 Nov 2024 18:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730830162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZvRlIrkdC8b6FRevSEggqlUNb8Qjbx4332kLRy0afU8=;
 b=tlw19/qPLEVWNr6c1g0OFuRwSjVUsq6KMTihfRRPlOgosFNyPr0wIs1Fmuy5RiE93HuvJq
 iJVcBpXUr8XhI1DW77cgwt1m+A8NmFHD97Sk1erWkkRPdPUgkTK1r+1Ixb11CtD3TCrgxh
 b5vwEEfLTyZw+h13kcLNsYXHsdz0Bj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730830162;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZvRlIrkdC8b6FRevSEggqlUNb8Qjbx4332kLRy0afU8=;
 b=WCCMW9l4VP42MUQXJcuqIvZCKp4vLvKT/6FQON8G2KL/9i42t7cy/w6MsRhl6KogQQe/lq
 2fKf/4IwmwnNWVBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="tlw19/qP";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WCCMW9l4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730830162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZvRlIrkdC8b6FRevSEggqlUNb8Qjbx4332kLRy0afU8=;
 b=tlw19/qPLEVWNr6c1g0OFuRwSjVUsq6KMTihfRRPlOgosFNyPr0wIs1Fmuy5RiE93HuvJq
 iJVcBpXUr8XhI1DW77cgwt1m+A8NmFHD97Sk1erWkkRPdPUgkTK1r+1Ixb11CtD3TCrgxh
 b5vwEEfLTyZw+h13kcLNsYXHsdz0Bj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730830162;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZvRlIrkdC8b6FRevSEggqlUNb8Qjbx4332kLRy0afU8=;
 b=WCCMW9l4VP42MUQXJcuqIvZCKp4vLvKT/6FQON8G2KL/9i42t7cy/w6MsRhl6KogQQe/lq
 2fKf/4IwmwnNWVBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB7481394A;
 Tue,  5 Nov 2024 18:09:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kE3ZG1BfKmeCZwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 Nov 2024 18:09:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 13/22] tests/qtest/migration: Split compression tests from
 migration-test.c
Date: Tue,  5 Nov 2024 15:08:28 -0300
Message-Id: <20241105180837.5990-14-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241105180837.5990-1-farosas@suse.de>
References: <20241105180837.5990-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BE0BC1F7FB
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RL6tyf6sue6knz55rs3us8rsc3)];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Continuing the split of groups of tests from migration-test.c, split
the compression tests into their own file.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/meson.build                   |   1 +
 tests/qtest/migration-test.c              | 162 +--------------
 tests/qtest/migration/compression-tests.c | 238 ++++++++++++++++++++++
 tests/qtest/migration/migration-common.h  |   1 +
 4 files changed, 241 insertions(+), 161 deletions(-)
 create mode 100644 tests/qtest/migration/compression-tests.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index d83f3db758..4d29746708 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -333,6 +333,7 @@ migration_files = [files(
   'migration/migration-common.c',
   'migration/migration-qmp.c',
   'migration/migration-util.c',
+  'migration/compression-tests.c',
 )]
 
 migration_tls_files = []
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 9d5f3be63c..a22ae06f88 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -273,36 +273,6 @@ static void test_ignore_shared(void)
 }
 #endif
 
-static void *
-migrate_xbzrle_start(QTestState *from,
-                     QTestState *to)
-{
-    migrate_set_parameter_int(from, "xbzrle-cache-size", 33554432);
-
-    migrate_set_capability(from, "xbzrle", true);
-    migrate_set_capability(to, "xbzrle", true);
-
-    return NULL;
-}
-
-static void test_precopy_unix_xbzrle(void)
-{
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = uri,
-        .start_hook = migrate_xbzrle_start,
-        .iterations = 2,
-        /*
-         * XBZRLE needs pages to be modified when doing the 2nd+ round
-         * iteration to have real data pushed to the stream.
-         */
-        .live = true,
-    };
-
-    test_precopy_common(&args);
-}
-
 static void test_precopy_file(void)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
@@ -1009,61 +979,6 @@ test_migration_precopy_tcp_multifd_no_zero_page_start(QTestState *from,
     return NULL;
 }
 
-static void *
-migrate_precopy_tcp_multifd_zlib_start(QTestState *from,
-                                       QTestState *to)
-{
-    /*
-     * Overloading this test to also check that set_parameter does not error.
-     * This is also done in the tests for the other compression methods.
-     */
-    migrate_set_parameter_int(from, "multifd-zlib-level", 2);
-    migrate_set_parameter_int(to, "multifd-zlib-level", 2);
-
-    return migrate_precopy_tcp_multifd_start_common(from, to, "zlib");
-}
-
-#ifdef CONFIG_ZSTD
-static void *
-migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
-                                       QTestState *to)
-{
-    migrate_set_parameter_int(from, "multifd-zstd-level", 2);
-    migrate_set_parameter_int(to, "multifd-zstd-level", 2);
-
-    return migrate_precopy_tcp_multifd_start_common(from, to, "zstd");
-}
-#endif /* CONFIG_ZSTD */
-
-#ifdef CONFIG_QATZIP
-static void *
-migrate_precopy_tcp_multifd_qatzip_start(QTestState *from,
-                                         QTestState *to)
-{
-    migrate_set_parameter_int(from, "multifd-qatzip-level", 2);
-    migrate_set_parameter_int(to, "multifd-qatzip-level", 2);
-
-    return migrate_precopy_tcp_multifd_start_common(from, to, "qatzip");
-}
-#endif
-
-#ifdef CONFIG_QPL
-static void *
-migrate_precopy_tcp_multifd_qpl_start(QTestState *from,
-                                      QTestState *to)
-{
-    return migrate_precopy_tcp_multifd_start_common(from, to, "qpl");
-}
-#endif /* CONFIG_QPL */
-#ifdef CONFIG_UADK
-static void *
-migrate_precopy_tcp_multifd_uadk_start(QTestState *from,
-                                       QTestState *to)
-{
-    return migrate_precopy_tcp_multifd_start_common(from, to, "uadk");
-}
-#endif /* CONFIG_UADK */
-
 static void test_multifd_tcp_uri_none(void)
 {
     MigrateCommon args = {
@@ -1124,59 +1039,6 @@ static void test_multifd_tcp_channels_none(void)
     test_precopy_common(&args);
 }
 
-static void test_multifd_tcp_zlib(void)
-{
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start_hook = migrate_precopy_tcp_multifd_zlib_start,
-    };
-    test_precopy_common(&args);
-}
-
-#ifdef CONFIG_ZSTD
-static void test_multifd_tcp_zstd(void)
-{
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start_hook = migrate_precopy_tcp_multifd_zstd_start,
-    };
-    test_precopy_common(&args);
-}
-#endif
-
-#ifdef CONFIG_QATZIP
-static void test_multifd_tcp_qatzip(void)
-{
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start_hook = migrate_precopy_tcp_multifd_qatzip_start,
-    };
-    test_precopy_common(&args);
-}
-#endif
-
-#ifdef CONFIG_QPL
-static void test_multifd_tcp_qpl(void)
-{
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start_hook = migrate_precopy_tcp_multifd_qpl_start,
-    };
-    test_precopy_common(&args);
-}
-#endif
-
-#ifdef CONFIG_UADK
-static void test_multifd_tcp_uadk(void)
-{
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start_hook = migrate_precopy_tcp_multifd_uadk_start,
-    };
-    test_precopy_common(&args);
-}
-#endif
-
 /*
  * This test does:
  *  source               target
@@ -1685,6 +1547,7 @@ int main(int argc, char **argv)
     tmpfs = env->tmpfs;
 
     migration_test_add_tls(env);
+    migration_test_add_compression(env);
 
     migration_test_add("/migration/bad_dest", test_baddest);
 #ifndef _WIN32
@@ -1718,10 +1581,6 @@ int main(int argc, char **argv)
 
     migration_test_add("/migration/precopy/unix/plain",
                        test_precopy_unix_plain);
-    if (g_test_slow()) {
-        migration_test_add("/migration/precopy/unix/xbzrle",
-                           test_precopy_unix_xbzrle);
-    }
     migration_test_add("/migration/precopy/file",
                        test_precopy_file);
     migration_test_add("/migration/precopy/file/offset",
@@ -1806,25 +1665,6 @@ int main(int argc, char **argv)
                        test_multifd_tcp_no_zero_page);
     migration_test_add("/migration/multifd/tcp/plain/cancel",
                        test_multifd_tcp_cancel);
-    migration_test_add("/migration/multifd/tcp/plain/zlib",
-                       test_multifd_tcp_zlib);
-#ifdef CONFIG_ZSTD
-    migration_test_add("/migration/multifd/tcp/plain/zstd",
-                       test_multifd_tcp_zstd);
-#endif
-#ifdef CONFIG_QATZIP
-    migration_test_add("/migration/multifd/tcp/plain/qatzip",
-                       test_multifd_tcp_qatzip);
-#endif
-#ifdef CONFIG_QPL
-    migration_test_add("/migration/multifd/tcp/plain/qpl",
-                       test_multifd_tcp_qpl);
-#endif
-#ifdef CONFIG_UADK
-    migration_test_add("/migration/multifd/tcp/plain/uadk",
-                       test_multifd_tcp_uadk);
-#endif
-
     if (g_str_equal(env->arch, "x86_64") && env->has_kvm && env->has_dirty_ring) {
         migration_test_add("/migration/dirty_ring",
                            test_precopy_unix_dirty_ring);
diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
new file mode 100644
index 0000000000..32f3d44586
--- /dev/null
+++ b/tests/qtest/migration/compression-tests.c
@@ -0,0 +1,238 @@
+/*
+ * QTest testcases for migration compression
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
+#include "qemu/module.h"
+
+
+static char *tmpfs;
+
+#ifdef CONFIG_ZSTD
+static void *
+migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
+                                       QTestState *to)
+{
+    migrate_set_parameter_int(from, "multifd-zstd-level", 2);
+    migrate_set_parameter_int(to, "multifd-zstd-level", 2);
+
+    return migrate_precopy_tcp_multifd_start_common(from, to, "zstd");
+}
+
+static void test_multifd_tcp_zstd(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = migrate_precopy_tcp_multifd_zstd_start,
+    };
+    test_precopy_common(&args);
+}
+#endif /* CONFIG_ZSTD */
+
+#ifdef CONFIG_QATZIP
+static void *
+migrate_precopy_tcp_multifd_qatzip_start(QTestState *from,
+                                         QTestState *to)
+{
+    migrate_set_parameter_int(from, "multifd-qatzip-level", 2);
+    migrate_set_parameter_int(to, "multifd-qatzip-level", 2);
+
+    return migrate_precopy_tcp_multifd_start_common(from, to, "qatzip");
+}
+
+static void test_multifd_tcp_qatzip(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = migrate_precopy_tcp_multifd_qatzip_start,
+    };
+    test_precopy_common(&args);
+}
+#endif
+
+#ifdef CONFIG_QPL
+static void *
+migrate_precopy_tcp_multifd_qpl_start(QTestState *from,
+                                      QTestState *to)
+{
+    return migrate_precopy_tcp_multifd_start_common(from, to, "qpl");
+}
+
+static void test_multifd_tcp_qpl(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = migrate_precopy_tcp_multifd_qpl_start,
+    };
+    test_precopy_common(&args);
+}
+#endif /* CONFIG_QPL */
+
+#ifdef CONFIG_UADK
+static void *
+migrate_precopy_tcp_multifd_uadk_start(QTestState *from,
+                                       QTestState *to)
+{
+    return migrate_precopy_tcp_multifd_start_common(from, to, "uadk");
+}
+
+static void *
+migrate_xbzrle_start(QTestState *from,
+                     QTestState *to)
+{
+    migrate_set_parameter_int(from, "xbzrle-cache-size", 33554432);
+
+    migrate_set_capability(from, "xbzrle", true);
+    migrate_set_capability(to, "xbzrle", true);
+
+    return NULL;
+}
+
+static void test_precopy_unix_xbzrle(void)
+{
+    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = uri,
+        .start_hook = migrate_xbzrle_start,
+        .iterations = 2,
+        /*
+         * XBZRLE needs pages to be modified when doing the 2nd+ round
+         * iteration to have real data pushed to the stream.
+         */
+        .live = true,
+    };
+
+    test_precopy_common(&args);
+}
+
+static void *
+migrate_precopy_tcp_multifd_zlib_start(QTestState *from,
+                                       QTestState *to)
+{
+    /*
+     * Overloading this test to also check that set_parameter does not error.
+     * This is also done in the tests for the other compression methods.
+     */
+    migrate_set_parameter_int(from, "multifd-zlib-level", 2);
+    migrate_set_parameter_int(to, "multifd-zlib-level", 2);
+
+    return migrate_precopy_tcp_multifd_start_common(from, to, "zlib");
+}
+
+static void test_multifd_tcp_zlib(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = migrate_precopy_tcp_multifd_zlib_start,
+    };
+    test_precopy_common(&args);
+}
+
+static void test_multifd_tcp_uadk(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = migrate_precopy_tcp_multifd_uadk_start,
+    };
+    test_precopy_common(&args);
+}
+#endif /* CONFIG_UADK */
+
+
+static void *
+migrate_xbzrle_start(QTestState *from,
+                     QTestState *to)
+{
+    migrate_set_parameter_int(from, "xbzrle-cache-size", 33554432);
+
+    migrate_set_capability(from, "xbzrle", true);
+    migrate_set_capability(to, "xbzrle", true);
+
+    return NULL;
+}
+
+static void test_precopy_unix_xbzrle(void)
+{
+    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = uri,
+        .start_hook = migrate_xbzrle_start,
+        .iterations = 2,
+        /*
+         * XBZRLE needs pages to be modified when doing the 2nd+ round
+         * iteration to have real data pushed to the stream.
+         */
+        .live = true,
+    };
+
+    test_precopy_common(&args);
+}
+
+static void *
+migrate_precopy_tcp_multifd_zlib_start(QTestState *from,
+                                       QTestState *to)
+{
+    /*
+     * Overloading this test to also check that set_parameter does not error.
+     * This is also done in the tests for the other compression methods.
+     */
+    migrate_set_parameter_int(from, "multifd-zlib-level", 2);
+    migrate_set_parameter_int(to, "multifd-zlib-level", 2);
+
+    return migrate_precopy_tcp_multifd_start_common(from, to, "zlib");
+}
+
+static void test_multifd_tcp_zlib(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = migrate_precopy_tcp_multifd_zlib_start,
+    };
+    test_precopy_common(&args);
+}
+
+void migration_test_add_compression(MigrationTestEnv *env)
+{
+    tmpfs = env->tmpfs;
+
+#ifdef CONFIG_ZSTD
+    migration_test_add("/migration/multifd/tcp/plain/zstd",
+                       test_multifd_tcp_zstd);
+#endif
+
+#ifdef CONFIG_QATZIP
+    migration_test_add("/migration/multifd/tcp/plain/qatzip",
+                       test_multifd_tcp_qatzip);
+#endif
+
+#ifdef CONFIG_QPL
+    migration_test_add("/migration/multifd/tcp/plain/qpl",
+                       test_multifd_tcp_qpl);
+#endif
+
+#ifdef CONFIG_UADK
+    migration_test_add("/migration/multifd/tcp/plain/uadk",
+                       test_multifd_tcp_uadk);
+#endif
+
+    if (g_test_slow()) {
+        migration_test_add("/migration/precopy/unix/xbzrle",
+                           test_precopy_unix_xbzrle);
+    }
+
+    migration_test_add("/migration/multifd/tcp/plain/zlib",
+                       test_multifd_tcp_zlib);
+}
diff --git a/tests/qtest/migration/migration-common.h b/tests/qtest/migration/migration-common.h
index c546e92259..18e85baece 100644
--- a/tests/qtest/migration/migration-common.h
+++ b/tests/qtest/migration/migration-common.h
@@ -216,5 +216,6 @@ void migration_test_add_tls(MigrationTestEnv *env);
 #else
 static inline void migration_test_add_tls(MigrationTestEnv *env) {};
 #endif
+void migration_test_add_compression(MigrationTestEnv *env);
 
 #endif /* MIGRATION_COMMON_H */
-- 
2.35.3


