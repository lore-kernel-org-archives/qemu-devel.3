Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C8FCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 22:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v44qe-0005TC-Nr; Wed, 01 Oct 2025 17:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v44qW-0005Lu-8c
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:58:48 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v44qL-0006oJ-Ur
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:58:47 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9C09F1F81C;
 Wed,  1 Oct 2025 21:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759355600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nOB6A5yrjzAnyGop8HOyGHZJaj6qujyLWFS8SjlOA08=;
 b=CBCy0sYcDoeZKVgIoSkiPzMg9HoKY4DagqJwINF2hpm8zfNUK1IKFdhet8wRkiJKXDqn0h
 2WA14MCoAxs8MNYYawNzs3UlmNdN+n3xlHniJKSzGLiiiDdbZo3+hQg395LcOMa7k4Zssk
 F+mtBhvyhHoXqezsMDzr13HD7VnuE8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759355600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nOB6A5yrjzAnyGop8HOyGHZJaj6qujyLWFS8SjlOA08=;
 b=JjSbdXApmRmskt5xwLqIBOpZaJypxrx9zVTETU1XeAJVXE40PeqR2cFj6UPQZg07PwxSzo
 f0nUCOl2YvSq6sDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759355599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nOB6A5yrjzAnyGop8HOyGHZJaj6qujyLWFS8SjlOA08=;
 b=hJu4rD0UHc0hhq78HBdfpbtKgFKDuEa42ldrWONDI0xseP+2iA6D0qhC6t9x3n5AW/BBoe
 DzIMX7BiBw/YRVkSehzNKWsj+cpHhs17nA5UFypwPUXrhaf/rbne/54zmN2zKKuKlmHD2k
 h1ms9DDtTwaKeUdb2J9hpt/7PqO3YNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759355599;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nOB6A5yrjzAnyGop8HOyGHZJaj6qujyLWFS8SjlOA08=;
 b=/DPtQu7cZzYZyFZVvjJroZLqgqV6JnwgsC/2FlnG/El28gLQvv8ar4RufOektbDXymE+UK
 NqPKm3Dy6ITJ5FBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 594FD13A3F;
 Wed,  1 Oct 2025 21:53:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eCjMBs6i3WhrJgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 01 Oct 2025 21:53:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 12/13] migration-test: migrate_args
Date: Wed,  1 Oct 2025 18:52:53 -0300
Message-Id: <20251001215254.2863-13-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20251001215254.2863-1-farosas@suse.de>
References: <20251001215254.2863-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,oracle.com:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[]
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

From: Steve Sistare <steven.sistare@oracle.com>

Define the subroutine migrate_args to return the arguments that are
used to exec the source or target qemu process.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/qemu-devel/1759332851-370353-18-git-send-email-steven.sistare@oracle.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/framework.c | 65 +++++++++++++++++++------------
 tests/qtest/migration/framework.h |  2 +
 2 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 89c85cd314..a9be9c2dbf 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -260,13 +260,12 @@ static char *test_shmem_path(void)
     return g_strdup_printf("/dev/shm/qemu-%d", getpid());
 }
 
-int migrate_start(QTestState **from, QTestState **to, const char *uri,
-                  MigrateStart *args)
+int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
 {
     /* options for source and target */
     g_autofree gchar *arch_opts = NULL;
-    g_autofree gchar *cmd_source = NULL;
-    g_autofree gchar *cmd_target = NULL;
+    gchar *cmd_source = NULL;
+    gchar *cmd_target = NULL;
     const gchar *ignore_stderr;
     g_autofree char *shmem_opts = NULL;
     g_autofree char *shmem_path = NULL;
@@ -275,23 +274,10 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
     const char *memory_size;
     const char *machine_alias, *machine_opts = "";
     g_autofree char *machine = NULL;
-    const char *bootpath;
-    g_autoptr(QList) capabilities = migrate_start_get_qmp_capabilities(args);
+    const char *bootpath = bootfile_get();
     g_autofree char *memory_backend = NULL;
     const char *events;
 
-    if (args->use_shmem) {
-        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
-            g_test_skip("/dev/shm is not supported");
-            return -1;
-        }
-    }
-
-    dst_state = (QTestMigrationState) { };
-    src_state = (QTestMigrationState) { };
-    bootpath = bootfile_create(arch, tmpfs, args->suspend_me);
-    src_state.suspend_me = args->suspend_me;
-
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         memory_size = "150M";
 
@@ -388,12 +374,6 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
                                  shmem_opts ? shmem_opts : "",
                                  args->opts_source ? args->opts_source : "",
                                  ignore_stderr);
-    if (!args->only_target) {
-        *from = qtest_init_ext(QEMU_ENV_SRC, cmd_source, capabilities, true);
-        qtest_qmp_set_event_callback(*from,
-                                     migrate_watch_for_events,
-                                     &src_state);
-    }
 
     /*
      * If the monitor connection is deferred, enable events on the command line
@@ -417,6 +397,42 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
                                  shmem_opts ? shmem_opts : "",
                                  args->opts_target ? args->opts_target : "",
                                  ignore_stderr);
+
+    *from = cmd_source;
+    *to = cmd_target;
+    return 0;
+}
+
+int migrate_start(QTestState **from, QTestState **to, const char *uri,
+                  MigrateStart *args)
+{
+    g_autofree gchar *cmd_source = NULL;
+    g_autofree gchar *cmd_target = NULL;
+    g_autoptr(QList) capabilities = migrate_start_get_qmp_capabilities(args);
+
+    if (args->use_shmem) {
+        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
+            g_test_skip("/dev/shm is not supported");
+            return -1;
+        }
+    }
+
+    dst_state = (QTestMigrationState) { };
+    src_state = (QTestMigrationState) { };
+    bootfile_create(qtest_get_arch(), tmpfs, args->suspend_me);
+    src_state.suspend_me = args->suspend_me;
+
+    if (migrate_args(&cmd_source, &cmd_target, uri, args)) {
+        return -1;
+    }
+
+    if (!args->only_target) {
+        *from = qtest_init_ext(QEMU_ENV_SRC, cmd_source, capabilities, true);
+        qtest_qmp_set_event_callback(*from,
+                                     migrate_watch_for_events,
+                                     &src_state);
+    }
+
     if (!args->only_source) {
         *to = qtest_init_ext(QEMU_ENV_DST, cmd_target, capabilities,
                              !args->defer_target_connect);
@@ -430,6 +446,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
      * It's valid because QEMU has already opened this file
      */
     if (args->use_shmem) {
+        g_autofree char *shmem_path = test_shmem_path();
         unlink(shmem_path);
     }
 
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index cc0d09b6da..9bb584a6bb 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -223,6 +223,8 @@ typedef struct {
 void wait_for_serial(const char *side);
 void migrate_prepare_for_dirty_mem(QTestState *from);
 void migrate_wait_for_dirty_mem(QTestState *from, QTestState *to);
+
+int migrate_args(char **from, char **to, const char *uri, MigrateStart *args);
 int migrate_start(QTestState **from, QTestState **to, const char *uri,
                   MigrateStart *args);
 void migrate_end(QTestState *from, QTestState *to, bool test_dest);
-- 
2.35.3


