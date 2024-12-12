Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D70E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkpj-0004Be-Ku; Thu, 12 Dec 2024 10:10:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpb-00041R-W0
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:10:25 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpY-0003EI-Ha
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:10:23 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4C8D321137;
 Thu, 12 Dec 2024 15:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uTj8rEaE4WSd6LhpilRYb90vZI1kEw8/S13n0DwUBJ8=;
 b=pzukMLv3A7q7xegY8EZjdJCg61Lhlp7iOWXA9jL5mk0JN49noA6vBStJSuD3ZQ0+EDAKN0
 K2eDK0nSeC2k5eqK18hiKQqwJX6pkM0kZUnDzIzZS6nrTAwV7W8alDUtmk5UOkSh/z5ecd
 sgmRPHCfuNK8pvm4pr6fdWdW80Uch6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uTj8rEaE4WSd6LhpilRYb90vZI1kEw8/S13n0DwUBJ8=;
 b=oo+oxhxJy+jv95vjNZveEWUR4l1LnG6+Wc7lAv7VoNqRGPOUJOEfNpjPskjRXMii8okC5M
 FnWg3psT22tt5kCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pzukMLv3;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oo+oxhxJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uTj8rEaE4WSd6LhpilRYb90vZI1kEw8/S13n0DwUBJ8=;
 b=pzukMLv3A7q7xegY8EZjdJCg61Lhlp7iOWXA9jL5mk0JN49noA6vBStJSuD3ZQ0+EDAKN0
 K2eDK0nSeC2k5eqK18hiKQqwJX6pkM0kZUnDzIzZS6nrTAwV7W8alDUtmk5UOkSh/z5ecd
 sgmRPHCfuNK8pvm4pr6fdWdW80Uch6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uTj8rEaE4WSd6LhpilRYb90vZI1kEw8/S13n0DwUBJ8=;
 b=oo+oxhxJy+jv95vjNZveEWUR4l1LnG6+Wc7lAv7VoNqRGPOUJOEfNpjPskjRXMii8okC5M
 FnWg3psT22tt5kCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1786113508;
 Thu, 12 Dec 2024 15:10:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WFOPM9n8WmcTfQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 12 Dec 2024 15:10:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 16/22] tests/qtest/migration: Split compression tests from
 migration-test.c
Date: Thu, 12 Dec 2024 12:09:43 -0300
Message-Id: <20241212150949.16806-17-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241212150949.16806-1-farosas@suse.de>
References: <20241212150949.16806-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4C8D321137
X-Rspamd-Action: no action
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
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:mid, suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/meson.build                   |   1 +
 tests/qtest/migration-test.c              | 161 +--------------
 tests/qtest/migration/compression-tests.c | 239 ++++++++++++++++++++++
 tests/qtest/migration/framework.h         |   1 +
 4 files changed, 242 insertions(+), 160 deletions(-)
 create mode 100644 tests/qtest/migration/compression-tests.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 6dc4ba9d40..eeb8ecf695 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -337,6 +337,7 @@ migration_files = [files(
   'migration/framework.c',
   'migration/migration-qmp.c',
   'migration/migration-util.c',
+  'migration/compression-tests.c',
 )]
 
 migration_tls_files = []
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 7395403f50..3528676678 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -274,36 +274,6 @@ static void test_ignore_shared(void)
 }
 #endif
 
-static void *
-migrate_hook_start_xbzrle(QTestState *from,
-                          QTestState *to)
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
-        .start_hook = migrate_hook_start_xbzrle,
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
@@ -1016,61 +986,6 @@ migrate_hook_start_precopy_tcp_multifd_no_zero_page(QTestState *from,
     return NULL;
 }
 
-static void *
-migrate_hook_start_precopy_tcp_multifd_zlib(QTestState *from,
-                                            QTestState *to)
-{
-    /*
-     * Overloading this test to also check that set_parameter does not error.
-     * This is also done in the tests for the other compression methods.
-     */
-    migrate_set_parameter_int(from, "multifd-zlib-level", 2);
-    migrate_set_parameter_int(to, "multifd-zlib-level", 2);
-
-    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "zlib");
-}
-
-#ifdef CONFIG_ZSTD
-static void *
-migrate_hook_start_precopy_tcp_multifd_zstd(QTestState *from,
-                                            QTestState *to)
-{
-    migrate_set_parameter_int(from, "multifd-zstd-level", 2);
-    migrate_set_parameter_int(to, "multifd-zstd-level", 2);
-
-    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "zstd");
-}
-#endif /* CONFIG_ZSTD */
-
-#ifdef CONFIG_QATZIP
-static void *
-migrate_hook_start_precopy_tcp_multifd_qatzip(QTestState *from,
-                                              QTestState *to)
-{
-    migrate_set_parameter_int(from, "multifd-qatzip-level", 2);
-    migrate_set_parameter_int(to, "multifd-qatzip-level", 2);
-
-    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "qatzip");
-}
-#endif
-
-#ifdef CONFIG_QPL
-static void *
-migrate_hook_start_precopy_tcp_multifd_qpl(QTestState *from,
-                                           QTestState *to)
-{
-    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "qpl");
-}
-#endif /* CONFIG_QPL */
-#ifdef CONFIG_UADK
-static void *
-migrate_hook_start_precopy_tcp_multifd_uadk(QTestState *from,
-                                            QTestState *to)
-{
-    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "uadk");
-}
-#endif /* CONFIG_UADK */
-
 static void test_multifd_tcp_uri_none(void)
 {
     MigrateCommon args = {
@@ -1131,59 +1046,6 @@ static void test_multifd_tcp_channels_none(void)
     test_precopy_common(&args);
 }
 
-static void test_multifd_tcp_zlib(void)
-{
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_precopy_tcp_multifd_zlib,
-    };
-    test_precopy_common(&args);
-}
-
-#ifdef CONFIG_ZSTD
-static void test_multifd_tcp_zstd(void)
-{
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
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
-        .start_hook = migrate_hook_start_precopy_tcp_multifd_qatzip,
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
-        .start_hook = migrate_hook_start_precopy_tcp_multifd_qpl,
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
-        .start_hook = migrate_hook_start_precopy_tcp_multifd_uadk,
-    };
-    test_precopy_common(&args);
-}
-#endif
-
 /*
  * This test does:
  *  source               target
@@ -1695,6 +1557,7 @@ int main(int argc, char **argv)
     tmpfs = env->tmpfs;
 
     migration_test_add_tls(env);
+    migration_test_add_compression(env);
 
     migration_test_add("/migration/bad_dest", test_baddest);
 #ifndef _WIN32
@@ -1728,10 +1591,6 @@ int main(int argc, char **argv)
 
     migration_test_add("/migration/precopy/unix/plain",
                        test_precopy_unix_plain);
-    if (g_test_slow()) {
-        migration_test_add("/migration/precopy/unix/xbzrle",
-                           test_precopy_unix_xbzrle);
-    }
     migration_test_add("/migration/precopy/file",
                        test_precopy_file);
     migration_test_add("/migration/precopy/file/offset",
@@ -1816,24 +1675,6 @@ int main(int argc, char **argv)
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
 
     if (g_str_equal(env->arch, "x86_64") &&
         env->has_kvm && env->has_dirty_ring) {
diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
new file mode 100644
index 0000000000..6de87bc47d
--- /dev/null
+++ b/tests/qtest/migration/compression-tests.c
@@ -0,0 +1,239 @@
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
+#include "migration/framework.h"
+#include "migration/migration-qmp.h"
+#include "migration/migration-util.h"
+#include "qemu/module.h"
+
+
+static char *tmpfs;
+
+#ifdef CONFIG_ZSTD
+static void *
+migrate_hook_start_precopy_tcp_multifd_zstd(QTestState *from,
+                                            QTestState *to)
+{
+    migrate_set_parameter_int(from, "multifd-zstd-level", 2);
+    migrate_set_parameter_int(to, "multifd-zstd-level", 2);
+
+    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "zstd");
+}
+
+static void test_multifd_tcp_zstd(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
+    };
+    test_precopy_common(&args);
+}
+#endif /* CONFIG_ZSTD */
+
+#ifdef CONFIG_QATZIP
+static void *
+migrate_hook_start_precopy_tcp_multifd_qatzip(QTestState *from,
+                                              QTestState *to)
+{
+    migrate_set_parameter_int(from, "multifd-qatzip-level", 2);
+    migrate_set_parameter_int(to, "multifd-qatzip-level", 2);
+
+    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "qatzip");
+}
+
+static void test_multifd_tcp_qatzip(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = migrate_hook_start_precopy_tcp_multifd_qatzip,
+    };
+    test_precopy_common(&args);
+}
+#endif
+
+#ifdef CONFIG_QPL
+static void *
+migrate_hook_start_precopy_tcp_multifd_qpl(QTestState *from,
+                                           QTestState *to)
+{
+    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "qpl");
+}
+
+static void test_multifd_tcp_qpl(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = migrate_hook_start_precopy_tcp_multifd_qpl,
+    };
+    test_precopy_common(&args);
+}
+#endif /* CONFIG_QPL */
+
+#ifdef CONFIG_UADK
+static void *
+migrate_hook_start_precopy_tcp_multifd_uadk(QTestState *from,
+                                            QTestState *to)
+{
+    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "uadk");
+}
+
+static void *
+migrate_hook_start_xbzrle(QTestState *from,
+                          QTestState *to)
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
+        .start_hook = migrate_hook_start_xbzrle,
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
+migrate_hook_start_precopy_tcp_multifd_zlib(QTestState *from,
+                                            QTestState *to)
+{
+    /*
+     * Overloading this test to also check that set_parameter does not error.
+     * This is also done in the tests for the other compression methods.
+     */
+    migrate_set_parameter_int(from, "multifd-zlib-level", 2);
+    migrate_set_parameter_int(to, "multifd-zlib-level", 2);
+
+    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "zlib");
+}
+
+static void test_multifd_tcp_zlib(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = migrate_hook_start_precopy_tcp_multifd_zlib,
+    };
+    test_precopy_common(&args);
+}
+
+static void test_multifd_tcp_uadk(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = migrate_hook_start_precopy_tcp_multifd_uadk,
+    };
+    test_precopy_common(&args);
+}
+#endif /* CONFIG_UADK */
+
+
+static void *
+migrate_hook_start_xbzrle(QTestState *from,
+                          QTestState *to)
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
+        .start_hook = migrate_hook_start_xbzrle,
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
+migrate_hook_start_precopy_tcp_multifd_zlib(QTestState *from,
+                                            QTestState *to)
+{
+    /*
+     * Overloading this test to also check that set_parameter does not error.
+     * This is also done in the tests for the other compression methods.
+     */
+    migrate_set_parameter_int(from, "multifd-zlib-level", 2);
+    migrate_set_parameter_int(to, "multifd-zlib-level", 2);
+
+    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "zlib");
+}
+
+static void test_multifd_tcp_zlib(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = migrate_hook_start_precopy_tcp_multifd_zlib,
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
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 1aad4da0e0..bc978d4c1c 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -220,5 +220,6 @@ void migration_test_add_tls(MigrationTestEnv *env);
 #else
 static inline void migration_test_add_tls(MigrationTestEnv *env) {};
 #endif
+void migration_test_add_compression(MigrationTestEnv *env);
 
 #endif /* TEST_FRAMEWORK_H */
-- 
2.35.3


