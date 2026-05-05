Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A2CCD343B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 16:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKIMr-0000jE-PO; Tue, 05 May 2026 12:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKIMU-0000Ip-Pr
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:11:10 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKIMQ-00011s-Bv
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:11:05 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2FCCD6B769;
 Tue,  5 May 2026 16:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777997386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oyZZ68G2Wgyo9Jg2YrN5+k9bAyveWB5OkHRK5G9arB8=;
 b=kdJ1x7p/Y4A7jlgNMZ4Liyhu6eH/CHIHw17OG6XXAKzioycerxm9+I5hWTysdXyFhQDw8F
 0vNN4LReHYxpofaL5AmxaQjnTWGpyQNYNM/cZVPVuP8wkDWzAjH1qqNiN1pcfHgedu1g2d
 uiUSZZ+SS3tIFjrWsWL1siqLmYaLJxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777997386;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oyZZ68G2Wgyo9Jg2YrN5+k9bAyveWB5OkHRK5G9arB8=;
 b=zcT2hlNoQkVNCeZpIBCJCxaktR5DGj15Cj5LSwz+HjYYJa72BKAHOAYwDA1rjyQ7wXLXyq
 vcue/NWyq1GCQzDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777997386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oyZZ68G2Wgyo9Jg2YrN5+k9bAyveWB5OkHRK5G9arB8=;
 b=kdJ1x7p/Y4A7jlgNMZ4Liyhu6eH/CHIHw17OG6XXAKzioycerxm9+I5hWTysdXyFhQDw8F
 0vNN4LReHYxpofaL5AmxaQjnTWGpyQNYNM/cZVPVuP8wkDWzAjH1qqNiN1pcfHgedu1g2d
 uiUSZZ+SS3tIFjrWsWL1siqLmYaLJxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777997386;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oyZZ68G2Wgyo9Jg2YrN5+k9bAyveWB5OkHRK5G9arB8=;
 b=zcT2hlNoQkVNCeZpIBCJCxaktR5DGj15Cj5LSwz+HjYYJa72BKAHOAYwDA1rjyQ7wXLXyq
 vcue/NWyq1GCQzDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76056593A3;
 Tue,  5 May 2026 16:09:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CAShEUgW+mmNcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 May 2026 16:09:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>
Subject: [PATCH v1 14/15] tests/qtest/migration: Stop passing URI into
 migrate_start
Date: Tue,  5 May 2026 13:09:13 -0300
Message-ID: <20260505160915.25558-15-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505160915.25558-1-farosas@suse.de>
References: <20260505160915.25558-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[redhat.com,web.de,oracle.com,akamai.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[web.de]
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Don't allow changing the default -incoming URI via migrate_start. The
default is now -incoming defer. If a test really needs to alter this
(such as with CPR), the target_opts variable is still available to
change the command line.

(aside from the larger goal of using defer, this change is a step
towards allowing migrate_start() to be invoked only once for all
tests)

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/colo-tests.c    |  2 +-
 tests/qtest/migration/cpr-tests.c     |  6 +++---
 tests/qtest/migration/file-tests.c    |  3 +--
 tests/qtest/migration/framework.c     | 17 ++++++++---------
 tests/qtest/migration/framework.h     |  5 ++---
 tests/qtest/migration/misc-tests.c    | 10 +++++-----
 tests/qtest/migration/precopy-tests.c | 12 ++++++------
 7 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/tests/qtest/migration/colo-tests.c b/tests/qtest/migration/colo-tests.c
index 4add4a014b..a3d27e7bf6 100644
--- a/tests/qtest/migration/colo-tests.c
+++ b/tests/qtest/migration/colo-tests.c
@@ -45,7 +45,7 @@ static int test_colo_common(MigrateCommon *args,
     args->start.caps[MIGRATION_CAPABILITY_RETURN_PATH] = true;
     args->start.caps[MIGRATION_CAPABILITY_X_COLO] = true;
 
-    if (migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return -1;
     }
 
diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 9091a84213..fc09dad9c0 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -60,7 +60,7 @@ static int test_transfer(MigrateCommon *args, const char *cpr_channel,
     obj = migrate_str_to_channel(cpr_channel);
     qlist_append(channels_list, obj);
 
-    if (migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return -1;
     }
 
@@ -179,7 +179,7 @@ static void set_cpr_exec_args(QTestState *who, MigrateCommon *args)
      */
     g_assert(args->start.hide_stderr == false);
 
-    ret = migrate_args(&from_args, &to_args, args->listen_uri, &args->start);
+    ret = migrate_args(&from_args, &to_args, &args->start);
     g_assert(!ret);
     qtest_from_args = qtest_qemu_args(from_args);
 
@@ -230,7 +230,7 @@ static void test_cpr_exec(MigrateCommon *args)
     g_autofree char *filename = g_strdup_printf("%s/%s", tmpfs,
                                                 FILE_TEST_FILENAME);
 
-    if (migrate_start(&from, NULL, "defer", &args->start)) {
+    if (migrate_start(&from, NULL, &args->start)) {
         return;
     }
 
diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
index 4b6a2eeb7b..36109d30ba 100644
--- a/tests/qtest/migration/file-tests.c
+++ b/tests/qtest/migration/file-tests.c
@@ -47,8 +47,7 @@ static void test_file_connect_outgoing_fd_leak(char *name, MigrateCommon *args)
         return;
     }
 
-    args->listen_uri = "defer";
-    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return;
     }
 
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 9df33f8809..2acbe709b7 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -308,7 +308,7 @@ static char *migrate_mem_type_get_opts(MemType type, const char *memory_size)
     return opts;
 }
 
-int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
+int migrate_args(char **from, char **to, MigrateStart *args)
 {
     /* options for source and target */
     g_autofree gchar *arch_opts = NULL;
@@ -423,11 +423,11 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
                                  "-name target,debug-threads=on "
                                  "%s "
                                  "-serial file:%s/dest_serial "
-                                 "-incoming %s "
+                                 "-incoming defer "
                                  "%s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
                                  machine, machine_opts,
-                                 memory_backend, tmpfs, uri,
+                                 memory_backend, tmpfs,
                                  events,
                                  arch_opts ? arch_opts : "",
                                  args->opts_target ? args->opts_target : "",
@@ -474,8 +474,7 @@ static void migrate_mem_type_cleanup(MemType type)
     }
 }
 
-int migrate_start(QTestState **from, QTestState **to, const char *uri,
-                  MigrateStart *args)
+int migrate_start(QTestState **from, QTestState **to, MigrateStart *args)
 {
     g_autofree gchar *cmd_source = NULL;
     g_autofree gchar *cmd_target = NULL;
@@ -490,7 +489,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
     bootfile_create(qtest_get_arch(), tmpfs, args->suspend_me);
     src_state.suspend_me = args->suspend_me;
 
-    if (migrate_args(&cmd_source, &cmd_target, uri, args)) {
+    if (migrate_args(&cmd_source, &cmd_target, args)) {
         return -1;
     }
 
@@ -563,7 +562,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME] = true;
     args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true;
 
-    if (migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return -1;
     }
 
@@ -842,7 +841,7 @@ int test_precopy_common(MigrateCommon *args)
         args->listen_uri = "tcp:127.0.0.1:0";
     }
 
-    if (migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return -1;
     }
 
@@ -991,7 +990,7 @@ void test_file_common(MigrateCommon *args, bool stop_src)
     bool check_offset = false;
     g_autofree char *uri = NULL;
 
-    if (migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return;
     }
 
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 7635e9fac1..65d3912fda 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -230,9 +230,8 @@ void wait_for_serial(const char *side);
 void migrate_prepare_for_dirty_mem(QTestState *from);
 void migrate_wait_for_dirty_mem(QTestState *from, QTestState *to);
 
-int migrate_args(char **from, char **to, const char *uri, MigrateStart *args);
-int migrate_start(QTestState **from, QTestState **to, const char *uri,
-                  MigrateStart *args);
+int migrate_args(char **from, char **to, MigrateStart *args);
+int migrate_start(QTestState **from, QTestState **to, MigrateStart *args);
 void migrate_end(QTestState *from, QTestState *to, bool test_dest);
 
 void test_postcopy_common(MigrateCommon *args);
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 8216b5d79d..e5d5fc4959 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -28,7 +28,7 @@ static void test_baddest(char *name, MigrateCommon *args)
 
     args->start.hide_stderr = true;
 
-    if (migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return;
     }
 
@@ -54,7 +54,7 @@ static void test_analyze_script(char *name, MigrateCommon *args)
         return;
     }
 
-    if (migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return;
     }
 
@@ -115,7 +115,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
 
-    if (migrate_start(&from, &to, "defer", args)) {
+    if (migrate_start(&from, &to, args)) {
         return;
     }
 
@@ -180,7 +180,7 @@ static void do_test_validate_uri_channel(MigrateCommon *args)
     QTestState *from, *to;
     QObject *channels;
 
-    if (migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return;
     }
 
@@ -234,7 +234,7 @@ static void test_validate_caps_pair(char *test_path, MigrateCommon *args)
     args->start.hide_stderr = true;
     args->start.only_source = true;
 
-    if (migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return;
     }
 
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index b13e84e26d..a9381fa3bf 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -291,7 +291,7 @@ static void test_auto_converge(char *name, MigrateCommon *args)
     uint64_t prev_dirty_sync_cnt, dirty_sync_cnt;
     int max_try_count, hit = 0;
 
-    if (migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return;
     }
 
@@ -470,7 +470,7 @@ static void test_multifd_tcp_cancel(MigrateCommon *args, bool postcopy_ram)
 
     args->start.hide_stderr = true;
 
-    if (migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return;
     }
 
@@ -516,7 +516,7 @@ static void test_multifd_tcp_cancel(MigrateCommon *args, bool postcopy_ram)
 
     args->start.only_target = true;
 
-    if (migrate_start(&from, &to2, "defer", &args->start)) {
+    if (migrate_start(&from, &to2, &args->start)) {
         return;
     }
 
@@ -690,7 +690,7 @@ static void test_cancel_src_after_status(char *test_path, MigrateCommon *args)
 
     args->start.hide_stderr = true;
 
-    if (migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return;
     }
 
@@ -1029,7 +1029,7 @@ static void test_dirty_limit(char *name, MigrateCommon *args)
     args->connect_uri = uri;
 
     /* Start src, dst vm */
-    if (migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return;
     }
 
@@ -1077,7 +1077,7 @@ static void test_dirty_limit(char *name, MigrateCommon *args)
     args->start.use_dirty_ring = true;
 
     /* Restart dst vm, src vm already show up so we needn't wait anymore */
-    if (migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return;
     }
 
-- 
2.51.0


