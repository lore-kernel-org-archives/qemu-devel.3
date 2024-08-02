Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D61C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 14:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZtec-0007Qw-7l; Fri, 02 Aug 2024 10:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sZtea-0007QN-3l
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 10:53:12 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sZteX-0004M6-Ka
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 10:53:11 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0E06021A2F;
 Fri,  2 Aug 2024 14:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722610387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JWSU4zlp5AoEsL8vM5hc3GxnsfclPF7Jq6P0lVaztxE=;
 b=Fo2iJnm0DmYQaHZ8jb+ffxa1198u+oNJ7eBfK/yNwWS7uwSeyhJO2gCVz50tKetcqkgZr2
 m43SPUtOxX/QpSc69jUxsZjenOZMO+WRu9HImBbC3aFzRkWw3tme1NiGNShx2m2LxJXtuv
 gyYhXtZc3cKcv9sYZYj3X9Dpz0WL6DI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722610387;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JWSU4zlp5AoEsL8vM5hc3GxnsfclPF7Jq6P0lVaztxE=;
 b=yxprW/9nf4M8fMPKWbRcLEca2fQZP3nVs1R6TP7Wvg+Pz73LLGb8SxKhsTHScdl0K0TbjL
 cB5Xa23nIbHgB7CA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=d351Bt5G;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mJ0sJ8Xz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722610386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JWSU4zlp5AoEsL8vM5hc3GxnsfclPF7Jq6P0lVaztxE=;
 b=d351Bt5GVDwXHjctB0rSEYXlnQR2pgnyH+dIIjwAqTuNu3Mzn5vPgAfqwQ5Xx0qHzU1d4y
 qTxi8zHj4aozibg0kDSKYm72g9nPJUtMJ1spJBk7FTJhwTY/H9/VYrRD6ty8IJeoUx7f8I
 u/aACsE08EVx7+EPWH8bYOZwXQp/PoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722610386;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=JWSU4zlp5AoEsL8vM5hc3GxnsfclPF7Jq6P0lVaztxE=;
 b=mJ0sJ8Xzdz15BAAlEKCTti/8NWuSy2xntXFrjH7QpovSctilT9yzhVQMq2G5oEMBnYbBFE
 19BOrz/2tLpxIzDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D875913999;
 Fri,  2 Aug 2024 14:53:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id l0FEJ9DyrGbKCQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 02 Aug 2024 14:53:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH for-9.2] tests/qtest/migration: Remove vmstate-static-checker
 test
Date: Fri,  2 Aug 2024 11:53:01 -0300
Message-Id: <20240802145301.29629-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:email, suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0E06021A2F
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

I fumbled one of my last pull requests when fixing in-tree an issue
with commit 87d67fadb9 ("monitor: Stop removing non-duplicated
fds"). Basically mixed-up my `git add -p` and `git checkout -p` and
committed a piece of test infra that has not been reviewed yet.

This has not caused any bad symptoms because the test is not enabled
by default anywhere: make check doesn't use two qemu binaries and the
CI doesn't have PYTHON set for the compat tests. Besides, the test
works fine anyway, it would not break anything.

Remove this because it was never intended to be merged.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c       | 17 +++-----
 tests/qtest/libqtest.h       |  2 -
 tests/qtest/migration-test.c | 82 ------------------------------------
 3 files changed, 6 insertions(+), 95 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 1326e34291..9d07de1fbd 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -514,7 +514,12 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
         kill(s->qemu_pid, SIGSTOP);
     }
 #endif
-    return s;
+
+    /* ask endianness of the target */
+
+    s->big_endian = qtest_query_target_endianness(s);
+
+   return s;
 }
 
 QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
@@ -522,21 +527,11 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
     return qtest_init_internal(qtest_qemu_binary(NULL), extra_args);
 }
 
-QTestState *qtest_init_with_env_no_handshake(const char *var,
-                                             const char *extra_args)
-{
-    return qtest_init_internal(qtest_qemu_binary(var), extra_args);
-}
-
 QTestState *qtest_init_with_env(const char *var, const char *extra_args)
 {
     QTestState *s = qtest_init_internal(qtest_qemu_binary(var), extra_args);
     QDict *greeting;
 
-    /* ask endianness of the target */
-
-    s->big_endian = qtest_query_target_endianness(s);
-
     /* Read the QMP greeting and then do the handshake */
     greeting = qtest_qmp_receive(s);
     qobject_unref(greeting);
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index c261b7e0b3..beb96b18eb 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -68,8 +68,6 @@ QTestState *qtest_init(const char *extra_args);
  */
 QTestState *qtest_init_with_env(const char *var, const char *extra_args);
 
-QTestState *qtest_init_with_env_no_handshake(const char *var,
-                                             const char *extra_args);
 /**
  * qtest_init_without_qmp_handshake:
  * @extra_args: other arguments to pass to QEMU.  CAUTION: these
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 70b606b888..c3201c5b19 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -64,7 +64,6 @@ static QTestMigrationState dst_state;
 #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
 
 #define ANALYZE_SCRIPT "scripts/analyze-migration.py"
-#define VMSTATE_CHECKER_SCRIPT "scripts/vmstate-static-checker.py"
 
 #define QEMU_VM_FILE_MAGIC 0x5145564d
 #define FILE_TEST_FILENAME "migfile"
@@ -1688,85 +1687,6 @@ static void test_analyze_script(void)
     test_migrate_end(from, to, false);
     cleanup("migfile");
 }
-
-static void test_vmstate_checker_script(void)
-{
-    g_autofree gchar *cmd_src = NULL;
-    g_autofree gchar *cmd_dst = NULL;
-    g_autofree gchar *vmstate_src = NULL;
-    g_autofree gchar *vmstate_dst = NULL;
-    const char *machine_alias, *machine_opts = "";
-    g_autofree char *machine = NULL;
-    const char *arch = qtest_get_arch();
-    int pid, wstatus;
-    const char *python = g_getenv("PYTHON");
-
-    if (!getenv(QEMU_ENV_SRC) && !getenv(QEMU_ENV_DST)) {
-        g_test_skip("Test needs two different QEMU versions");
-        return;
-    }
-
-    if (!python) {
-        g_test_skip("PYTHON variable not set");
-        return;
-    }
-
-    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        if (g_str_equal(arch, "i386")) {
-            machine_alias = "pc";
-        } else {
-            machine_alias = "q35";
-        }
-    } else if (g_str_equal(arch, "s390x")) {
-        machine_alias = "s390-ccw-virtio";
-    } else if (strcmp(arch, "ppc64") == 0) {
-        machine_alias = "pseries";
-    } else if (strcmp(arch, "aarch64") == 0) {
-        machine_alias = "virt";
-    } else {
-        g_assert_not_reached();
-    }
-
-    if (!qtest_has_machine(machine_alias)) {
-        g_autofree char *msg = g_strdup_printf("machine %s not supported", machine_alias);
-        g_test_skip(msg);
-        return;
-    }
-
-    machine = resolve_machine_version(machine_alias, QEMU_ENV_SRC,
-                                      QEMU_ENV_DST);
-
-    vmstate_src = g_strdup_printf("%s/vmstate-src", tmpfs);
-    vmstate_dst = g_strdup_printf("%s/vmstate-dst", tmpfs);
-
-    cmd_dst = g_strdup_printf("-machine %s,%s -dump-vmstate %s",
-                              machine, machine_opts, vmstate_dst);
-    cmd_src = g_strdup_printf("-machine %s,%s -dump-vmstate %s",
-                              machine, machine_opts, vmstate_src);
-
-    qtest_init_with_env_no_handshake(QEMU_ENV_SRC, cmd_src);
-    qtest_init_with_env_no_handshake(QEMU_ENV_DST, cmd_dst);
-
-    pid = fork();
-    if (!pid) {
-        close(1);
-        open("/dev/null", O_WRONLY);
-        execl(python, python, VMSTATE_CHECKER_SCRIPT,
-              "-s", vmstate_src,
-              "-d", vmstate_dst,
-              NULL);
-        g_assert_not_reached();
-    }
-
-    g_assert(waitpid(pid, &wstatus, 0) == pid);
-    if (!WIFEXITED(wstatus) || WEXITSTATUS(wstatus) != 0) {
-        g_test_message("Failed to run vmstate-static-checker.py");
-        g_test_fail();
-    }
-
-    cleanup("vmstate-src");
-    cleanup("vmstate-dst");
-}
 #endif
 
 static void test_precopy_common(MigrateCommon *args)
@@ -3819,8 +3739,6 @@ int main(int argc, char **argv)
     migration_test_add("/migration/bad_dest", test_baddest);
 #ifndef _WIN32
     migration_test_add("/migration/analyze-script", test_analyze_script);
-    migration_test_add("/migration/vmstate-checker-script",
-                       test_vmstate_checker_script);
 #endif
 
     if (is_x86) {
-- 
2.35.3


