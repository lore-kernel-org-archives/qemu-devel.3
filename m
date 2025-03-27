Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8CCC36010
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 14:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txoOt-0006YG-1N; Thu, 27 Mar 2025 10:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1txoOm-0006WW-64
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:40:01 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1txoOj-0005aW-JC
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:39:59 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1FF2C2117A;
 Thu, 27 Mar 2025 14:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743086389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNsDhETiAJds2+ePucPEzklBK2SNjt8lSIOpJ0xkdX0=;
 b=Llve80IIwQ+fjsYaLaPEKjhx2CMvbc69eMxxK9nToAgw2QshjcNIS0sQvV7cjObeRSmy4h
 v7UmbCBFk+cbBQ9HbKKGlXvdjhjxTFPeQGO9tcXKNpilvs0FHP6/PKcJN+tzhN+FIvqyjh
 5fkI0qjZOiiDVZ48dHOqkbznqdDG2aQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743086389;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNsDhETiAJds2+ePucPEzklBK2SNjt8lSIOpJ0xkdX0=;
 b=J5CjFkw+VwCen6TgetW4ZKdhz9EBOCbAMrvpp+rFKjEgA+9718iaZ3TdWyaPZwoRIzfTc9
 9P9VlSPmbxryLRAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Llve80II;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=J5CjFkw+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743086389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNsDhETiAJds2+ePucPEzklBK2SNjt8lSIOpJ0xkdX0=;
 b=Llve80IIwQ+fjsYaLaPEKjhx2CMvbc69eMxxK9nToAgw2QshjcNIS0sQvV7cjObeRSmy4h
 v7UmbCBFk+cbBQ9HbKKGlXvdjhjxTFPeQGO9tcXKNpilvs0FHP6/PKcJN+tzhN+FIvqyjh
 5fkI0qjZOiiDVZ48dHOqkbznqdDG2aQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743086389;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNsDhETiAJds2+ePucPEzklBK2SNjt8lSIOpJ0xkdX0=;
 b=J5CjFkw+VwCen6TgetW4ZKdhz9EBOCbAMrvpp+rFKjEgA+9718iaZ3TdWyaPZwoRIzfTc9
 9P9VlSPmbxryLRAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1ED1913A41;
 Thu, 27 Mar 2025 14:39:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aNVlNDJj5WcVZgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 27 Mar 2025 14:39:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, berrange@redhat.com,
 Marco Cavenati <Marco.Cavenati@eurecom.fr>
Subject: [PATCH 4/4] tests/qtest/migration: Add savevm tests
Date: Thu, 27 Mar 2025 11:39:34 -0300
Message-Id: <20250327143934.7935-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250327143934.7935-1-farosas@suse.de>
References: <20250327143934.7935-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1FF2C2117A
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Add a test file for savevm tests so the snapshot functionality can be
better tested in the context of migration. There's currently issues
with migration capabilities causing crashes in QEMU when running
savevm.

Start with a couple of tests, one that simply saves and loads a
snapshot and another to check that migration capabilities don't cause
disruption of savevm.

The simple savevm/loadvm test will be redundant with some block layer
tests that are already present. The objective here is more to have an
infrastructure that can save and load snapshots from different QEMU
versions, which is convenient for tracking compatibility bugs.

I chose to not add a guest workload for this because we could in the
future run the test for all architectures without having to write
guest code (but also because the QEMU cmdline construction is way more
complex).

Both tests only run during the full set of tests.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/meson.build              |   1 +
 tests/qtest/migration-test.c         |   1 +
 tests/qtest/migration/framework.c    |   4 +-
 tests/qtest/migration/framework.h    |   5 +
 tests/qtest/migration/savevm-tests.c | 144 +++++++++++++++++++++++++++
 5 files changed, 152 insertions(+), 3 deletions(-)
 create mode 100644 tests/qtest/migration/savevm-tests.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 3136d15e0f..305b662620 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -347,6 +347,7 @@ migration_files = [files(
   'migration/misc-tests.c',
   'migration/precopy-tests.c',
   'migration/postcopy-tests.c',
+  'migration/savevm-tests.c',
 )]
 
 migration_tls_files = []
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 0893687174..b15f6d091b 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -55,6 +55,7 @@ int main(int argc, char **argv)
     migration_test_add_precopy(env);
     migration_test_add_cpr(env);
     migration_test_add_misc(env);
+    migration_test_add_savevm(env);
 
     ret = g_test_run();
 
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 2311100dd6..42bda03693 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -28,8 +28,6 @@
 
 
 #define QEMU_VM_FILE_MAGIC 0x5145564d
-#define QEMU_ENV_SRC "QTEST_QEMU_BINARY_SRC"
-#define QEMU_ENV_DST "QTEST_QEMU_BINARY_DST"
 
 unsigned start_address;
 unsigned end_address;
@@ -207,7 +205,7 @@ static QList *migrate_start_get_qmp_capabilities(const MigrateStart *args)
     return capabilities;
 }
 
-static char *migrate_resolve_alias(const char *arch)
+char *migrate_resolve_alias(const char *arch)
 {
     const char *machine_alias;
 
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index e4a11870f6..66823267af 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -17,6 +17,9 @@
 #define FILE_TEST_OFFSET 0x1000
 #define FILE_TEST_MARKER 'X'
 
+#define QEMU_ENV_SRC "QTEST_QEMU_BINARY_SRC"
+#define QEMU_ENV_DST "QTEST_QEMU_BINARY_DST"
+
 typedef struct MigrationTestEnv {
     bool has_kvm;
     bool has_tcg;
@@ -225,6 +228,7 @@ void test_file_common(MigrateCommon *args, bool stop_src);
 void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
                                                     QTestState *to,
                                                     const char *method);
+char *migrate_resolve_alias(const char *arch);
 
 typedef struct QTestMigrationState QTestMigrationState;
 QTestMigrationState *get_src(void);
@@ -240,5 +244,6 @@ void migration_test_add_file(MigrationTestEnv *env);
 void migration_test_add_precopy(MigrationTestEnv *env);
 void migration_test_add_cpr(MigrationTestEnv *env);
 void migration_test_add_misc(MigrationTestEnv *env);
+void migration_test_add_savevm(MigrationTestEnv *env);
 
 #endif /* TEST_FRAMEWORK_H */
diff --git a/tests/qtest/migration/savevm-tests.c b/tests/qtest/migration/savevm-tests.c
new file mode 100644
index 0000000000..5904c4b07e
--- /dev/null
+++ b/tests/qtest/migration/savevm-tests.c
@@ -0,0 +1,144 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "migration/framework.h"
+#include "migration/migration-qmp.h"
+#include "migration/migration-util.h"
+#include "qapi/qapi-types-migration.h"
+
+char *disk_path;
+
+static char *savevm_make_cmdline(void)
+{
+    MigrationTestEnv *env = migration_get_env();
+    g_autofree char *drive_opts = NULL;
+    g_autofree char *arch_opts = NULL;
+    g_autofree char *machine_opts = NULL;
+    g_autofree char *machine = NULL;
+
+    disk_path = g_strdup_printf("%s/qtest-savevm-%d.qcow2", g_get_tmp_dir(),
+                                getpid());
+    drive_opts = g_strdup_printf("-drive if=none,file=%s,format=qcow2,node-name=disk0 ",
+                                disk_path);
+
+    g_assert(mkimg(disk_path, "qcow2", 100));
+
+    machine = migrate_resolve_alias(env->arch);
+
+    if (machine) {
+        machine_opts = g_strdup_printf("-machine %s", machine);
+    }
+
+    return g_strdup_printf("%s %s %s",
+                           drive_opts,
+                           arch_opts ?: "",
+                           machine_opts ?: "");
+}
+
+static void teardown_savevm_test(void)
+{
+    unlink(disk_path);
+    g_free(disk_path);
+}
+
+/*
+ * Enabling capabilities before savevm/loadvm should either apply the
+ * appropriate feature or reject the command. Crashing or ignoring the
+ * capability is not acceptable. Most (all?) migration capabilities
+ * are incompatible with snapshots, but they've historically not been
+ * rejected. Since there are compatibility concerns with simply
+ * rejecting all caps, for now this test only validates that nothing
+ * crashes.
+ */
+static void test_savevm_caps(void)
+{
+    MigrationTestEnv *env = migration_get_env();
+    g_autofree char *cmdline = savevm_make_cmdline();
+    QTestState *vm;
+
+    /*
+     * Only one VM to avoid having to shutdown the machine several
+     * times to release the disks lock.
+     */
+    if (env->qemu_src || env->qemu_dst) {
+        g_test_skip("Only one QEMU binary is supported");
+        return;
+    }
+
+    vm = qtest_init(cmdline);
+
+    for (int i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
+        const char *cap = MigrationCapability_str(i);
+        g_autofree char *error_str = NULL;
+        bool ret;
+
+        switch (i) {
+        case MIGRATION_CAPABILITY_ZERO_BLOCKS:          /* deprecated */
+        case MIGRATION_CAPABILITY_ZERO_COPY_SEND:       /* requires multifd */
+        case MIGRATION_CAPABILITY_POSTCOPY_PREEMPT:     /* requires postcopy-ram */
+        case MIGRATION_CAPABILITY_SWITCHOVER_ACK:       /* requires return-path */
+        case MIGRATION_CAPABILITY_DIRTY_LIMIT:          /* requires dirty ring setup */
+        case MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT:  /* requires uffd setup */
+            continue;
+        default:
+            break;
+        }
+
+        if (getenv("QTEST_LOG")) {
+            g_test_message("%s", MigrationCapability_str(i));
+        }
+        migrate_set_capability(vm, MigrationCapability_str(i), true);
+
+        ret = snapshot_save_qmp_sync(vm, &error_str);
+
+        if (ret) {
+            g_assert(snapshot_load_qmp_sync(vm, NULL));
+            g_assert(snapshot_delete_qmp_sync(vm, NULL));
+        } else {
+            g_autofree char *msg = g_strdup_printf(
+                "Snapshots are not compatible with %s", cap);
+
+            g_assert(error_str);
+            g_assert(g_str_equal(msg, error_str));
+        }
+
+        migrate_set_capability(vm, MigrationCapability_str(i), false);
+    }
+
+    qtest_quit(vm);
+    teardown_savevm_test();
+}
+
+static void test_savevm_loadvm(void)
+{
+    g_autofree char *cmdline = savevm_make_cmdline();
+    QTestState *src, *dst;
+    bool ret;
+
+    src = qtest_init_with_env(QEMU_ENV_SRC, cmdline, true);
+
+    ret = snapshot_save_qmp_sync(src, NULL);
+    qtest_quit(src);
+
+    if (ret) {
+        dst = qtest_init_with_env(QEMU_ENV_DST, cmdline, true);
+
+        g_assert(snapshot_load_qmp_sync(dst, NULL));
+        g_assert(snapshot_delete_qmp_sync(dst, NULL));
+        qtest_quit(dst);
+    }
+
+    teardown_savevm_test();
+}
+
+void migration_test_add_savevm(MigrationTestEnv *env)
+{
+    if (!getenv("QTEST_QEMU_IMG")) {
+        g_test_message("savevm tests require QTEST_QEMU_IMG");
+        return;
+    }
+
+    migration_test_add("/migration/savevm/save-load", test_savevm_loadvm);
+    migration_test_add("/migration/savevm/capabilities", test_savevm_caps);
+}
-- 
2.35.3


