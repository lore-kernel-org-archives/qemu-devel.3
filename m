Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D23AD5B86D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGdt-00044Q-6K; Mon, 15 Dec 2025 17:02:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGdq-0003ue-2E
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:02:06 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGdk-0002nS-AQ
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:02:05 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DC5E933742;
 Mon, 15 Dec 2025 22:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iLkti5HK8cPBvGiKTNRMV7ZzLL4wmNalm3Ux1Q8dj1c=;
 b=b5lJUskbPg8iNiRE9JUsxGe4G1OfO+PqgMHIb/+rgRHl/R/IdDCmJbMEGNGX65ID9din64
 WLgDm9jPgw/N/siZZXpZi0Ii+bIVKS1S2YLLxeHH582tIQ1PVt+4hNuINplmg5uoGomHpu
 9gwoaznnHODhP3HW0x8h2+Yy2pPdx0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836111;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iLkti5HK8cPBvGiKTNRMV7ZzLL4wmNalm3Ux1Q8dj1c=;
 b=YPMgwqkNLG0KAS743JGW1jluYPPGlWktn14hx8OooRcc7reY+t87EyvY1bkGVZGALUPURi
 uvn8kV4NZuUSIEBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iLkti5HK8cPBvGiKTNRMV7ZzLL4wmNalm3Ux1Q8dj1c=;
 b=b5lJUskbPg8iNiRE9JUsxGe4G1OfO+PqgMHIb/+rgRHl/R/IdDCmJbMEGNGX65ID9din64
 WLgDm9jPgw/N/siZZXpZi0Ii+bIVKS1S2YLLxeHH582tIQ1PVt+4hNuINplmg5uoGomHpu
 9gwoaznnHODhP3HW0x8h2+Yy2pPdx0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836111;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iLkti5HK8cPBvGiKTNRMV7ZzLL4wmNalm3Ux1Q8dj1c=;
 b=YPMgwqkNLG0KAS743JGW1jluYPPGlWktn14hx8OooRcc7reY+t87EyvY1bkGVZGALUPURi
 uvn8kV4NZuUSIEBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D07D73EA63;
 Mon, 15 Dec 2025 22:01:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UBGZI02FQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:01:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 25/51] tests/qtest/migration: Pass MigrateCommon into test
 functions
Date: Mon, 15 Dec 2025 19:00:11 -0300
Message-ID: <20251215220041.12657-26-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.989];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[]
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

With the upcoming addition of the config QDict, the tests will need a
better way of managing the memory of the test data than putting the
test arguments on the stack of the test functions. The config QDict
will need to be merged into the arguments of migrate_qmp* functions,
which causes a refcount increment, so the test functions would need to
allocate and deref the config QDict themselves.

A better approach is to already pass the arguments into the test
functions and do the memory management in the existing wrapper. There
is already migration_test_destroy(), which is called for every test.

Do the following:

- merge the two existing wrappers, migration_test_wrapper() and
  migration_test_wrapper_full(). The latter was pioneer in passing
  data into the tests, but now all tests will receive data, so we
  don't need it anymore.

  The usage of migration_test_wrapper_full() was in passing a slightly
  different test name string into the cancel tests, so still keep the
  migration_test_add_suffix() function.

- add (char *name, MigrateCommon *args) to the signature of all test
  functions.

- alter any code to stop allocating args on the stack and instead use
  the object that came as parameter.

- pass args around as needed.

- while here, order args (MigrateCommon) before args->start
  (MigrateStart) and put a blank like in between.

No functional change.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/compression-tests.c | 127 +++---
 tests/qtest/migration/cpr-tests.c         |  71 ++--
 tests/qtest/migration/file-tests.c        | 184 ++++----
 tests/qtest/migration/migration-util.c    |  26 +-
 tests/qtest/migration/migration-util.h    |   8 +-
 tests/qtest/migration/misc-tests.c        | 108 ++---
 tests/qtest/migration/postcopy-tests.c    |  80 ++--
 tests/qtest/migration/precopy-tests.c     | 354 +++++++---------
 tests/qtest/migration/tls-tests.c         | 485 ++++++++++------------
 9 files changed, 642 insertions(+), 801 deletions(-)

diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
index b827665b8e..845e622cd5 100644
--- a/tests/qtest/migration/compression-tests.c
+++ b/tests/qtest/migration/compression-tests.c
@@ -31,30 +31,25 @@ migrate_hook_start_precopy_tcp_multifd_zstd(QTestState *from,
     return migrate_hook_start_precopy_tcp_multifd_common(from, to, "zstd");
 }
 
-static void test_multifd_tcp_zstd(void)
+static void test_multifd_tcp_zstd(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-        },
-        .start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
-    };
-    test_precopy_common(&args);
+    args->listen_uri = "defer";
+    args->start_hook = migrate_hook_start_precopy_tcp_multifd_zstd;
+
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
+    test_precopy_common(args);
 }
 
-static void test_multifd_postcopy_tcp_zstd(void)
+static void test_multifd_postcopy_tcp_zstd(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-            .caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true,
-        },
-        .start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
-    };
+    args->listen_uri = "defer";
+    args->start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
 
-    test_precopy_common(&args);
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true;
+
+    test_precopy_common(args);
 }
 #endif /* CONFIG_ZSTD */
 
@@ -69,16 +64,14 @@ migrate_hook_start_precopy_tcp_multifd_qatzip(QTestState *from,
     return migrate_hook_start_precopy_tcp_multifd_common(from, to, "qatzip");
 }
 
-static void test_multifd_tcp_qatzip(void)
+static void test_multifd_tcp_qatzip(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-        },
-        .start_hook = migrate_hook_start_precopy_tcp_multifd_qatzip,
-    };
-    test_precopy_common(&args);
+    args->listen_uri = "defer";
+    args->start_hook = migrate_hook_start_precopy_tcp_multifd_qatzip;
+
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
+    test_precopy_common(args);
 }
 #endif
 
@@ -90,16 +83,14 @@ migrate_hook_start_precopy_tcp_multifd_qpl(QTestState *from,
     return migrate_hook_start_precopy_tcp_multifd_common(from, to, "qpl");
 }
 
-static void test_multifd_tcp_qpl(void)
+static void test_multifd_tcp_qpl(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-        },
-        .start_hook = migrate_hook_start_precopy_tcp_multifd_qpl,
-    };
-    test_precopy_common(&args);
+    args->listen_uri = "defer";
+    args->start_hook = migrate_hook_start_precopy_tcp_multifd_qpl;
+
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
+    test_precopy_common(args);
 }
 #endif /* CONFIG_QPL */
 
@@ -111,16 +102,14 @@ migrate_hook_start_precopy_tcp_multifd_uadk(QTestState *from,
     return migrate_hook_start_precopy_tcp_multifd_common(from, to, "uadk");
 }
 
-static void test_multifd_tcp_uadk(void)
+static void test_multifd_tcp_uadk(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-        },
-        .start_hook = migrate_hook_start_precopy_tcp_multifd_uadk,
-    };
-    test_precopy_common(&args);
+    args->listen_uri = "defer";
+    args->start_hook = migrate_hook_start_precopy_tcp_multifd_uadk;
+
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
+    test_precopy_common(args);
 }
 #endif /* CONFIG_UADK */
 
@@ -132,25 +121,23 @@ migrate_hook_start_xbzrle(QTestState *from,
     return NULL;
 }
 
-static void test_precopy_unix_xbzrle(void)
+static void test_precopy_unix_xbzrle(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = uri,
-        .start_hook = migrate_hook_start_xbzrle,
-        .iterations = 2,
-        .start = {
-            .caps[MIGRATION_CAPABILITY_XBZRLE] = true,
-        },
-        /*
-         * XBZRLE needs pages to be modified when doing the 2nd+ round
-         * iteration to have real data pushed to the stream.
-         */
-        .live = true,
-    };
 
-    test_precopy_common(&args);
+    args->connect_uri = uri;
+    args->listen_uri = uri;
+    args->start_hook = migrate_hook_start_xbzrle;
+    args->iterations = 2;
+    /*
+     * XBZRLE needs pages to be modified when doing the 2nd+ round
+     * iteration to have real data pushed to the stream.
+     */
+    args->live = true;
+
+    args->start.caps[MIGRATION_CAPABILITY_XBZRLE] = true;
+
+    test_precopy_common(args);
 }
 
 static void *
@@ -167,16 +154,14 @@ migrate_hook_start_precopy_tcp_multifd_zlib(QTestState *from,
     return migrate_hook_start_precopy_tcp_multifd_common(from, to, "zlib");
 }
 
-static void test_multifd_tcp_zlib(void)
+static void test_multifd_tcp_zlib(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-        },
-        .start_hook = migrate_hook_start_precopy_tcp_multifd_zlib,
-    };
-    test_precopy_common(&args);
+    args->listen_uri = "defer";
+    args->start_hook = migrate_hook_start_precopy_tcp_multifd_zlib;
+
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
+    test_precopy_common(args);
 }
 
 static void migration_test_add_compression_smoke(MigrationTestEnv *env)
diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 2a186c6f35..0d97b5b89f 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -27,21 +27,19 @@ static void *migrate_hook_start_mode_reboot(QTestState *from, QTestState *to)
     return NULL;
 }
 
-static void test_mode_reboot(void)
+static void test_mode_reboot(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
-    MigrateCommon args = {
-        .start.mem_type = MEM_TYPE_SHMEM,
-        .connect_uri = uri,
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_mode_reboot,
-        .start = {
-            .caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true,
-        },
-    };
 
-    test_file_common(&args, true);
+    args->connect_uri = uri;
+    args->listen_uri = "defer";
+    args->start_hook = migrate_hook_start_mode_reboot;
+
+    args->start.mem_type = MEM_TYPE_SHMEM;
+    args->start.caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true;
+
+    test_file_common(args, true);
 }
 
 static void *test_mode_transfer_start(QTestState *from, QTestState *to)
@@ -55,7 +53,7 @@ static void *test_mode_transfer_start(QTestState *from, QTestState *to)
  * migration, and cannot connect synchronously to the monitor, so defer
  * the target connection.
  */
-static void test_mode_transfer_common(bool incoming_defer)
+static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer)
 {
     g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock", tmpfs);
     g_autofree char *mig_path = g_strdup_printf("%s/migsocket", tmpfs);
@@ -85,31 +83,31 @@ static void test_mode_transfer_common(bool incoming_defer)
     opts_target = g_strdup_printf("-incoming cpr,addr.transport=socket,"
                                   "addr.type=fd,addr.str=%d %s",
                                   cpr_sockfd, opts);
-    MigrateCommon args = {
-        .start.opts_source = opts,
-        .start.opts_target = opts_target,
-        .start.defer_target_connect = true,
-        .start.mem_type = MEM_TYPE_MEMFD,
-        .listen_uri = incoming_defer ? "defer" : uri,
-        .connect_channels = connect_channels,
-        .cpr_channel = cpr_channel,
-        .start_hook = test_mode_transfer_start,
-    };
 
-    if (test_precopy_common(&args) < 0) {
+    args->listen_uri = incoming_defer ? "defer" : uri;
+    args->connect_channels = connect_channels;
+    args->cpr_channel = cpr_channel;
+    args->start_hook = test_mode_transfer_start;
+
+    args->start.opts_source = opts;
+    args->start.opts_target = opts_target;
+    args->start.defer_target_connect = true;
+    args->start.mem_type = MEM_TYPE_MEMFD;
+
+    if (test_precopy_common(args) < 0) {
         close(cpr_sockfd);
         unlink(cpr_path);
     }
 }
 
-static void test_mode_transfer(void)
+static void test_mode_transfer(char *name, MigrateCommon *args)
 {
-    test_mode_transfer_common(NULL);
+    test_mode_transfer_common(args, false);
 }
 
-static void test_mode_transfer_defer(void)
+static void test_mode_transfer_defer(char *name, MigrateCommon *args)
 {
-    test_mode_transfer_common(true);
+    test_mode_transfer_common(args, true);
 }
 
 static void set_cpr_exec_args(QTestState *who, MigrateCommon *args)
@@ -225,22 +223,21 @@ static void *test_mode_exec_start(QTestState *from, QTestState *to)
     return NULL;
 }
 
-static void test_mode_exec(void)
+static void test_mode_exec(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
     g_autofree char *listen_uri = g_strdup_printf("defer");
 
-    MigrateCommon args = {
-        .start.only_source = true,
-        .start.opts_source = "-machine aux-ram-share=on -nodefaults",
-        .start.mem_type = MEM_TYPE_MEMFD,
-        .connect_uri = uri,
-        .listen_uri = listen_uri,
-        .start_hook = test_mode_exec_start,
-    };
+    args->connect_uri = uri;
+    args->listen_uri = listen_uri;
+    args->start_hook = test_mode_exec_start;
 
-    test_cpr_exec(&args);
+    args->start.only_source = true;
+    args->start.opts_source = "-machine aux-ram-share=on -nodefaults";
+    args->start.mem_type = MEM_TYPE_MEMFD;
+
+    test_cpr_exec(args);
 }
 
 void migration_test_add_cpr(MigrationTestEnv *env)
diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
index 4d78ce0855..5f1159076c 100644
--- a/tests/qtest/migration/file-tests.c
+++ b/tests/qtest/migration/file-tests.c
@@ -20,16 +20,14 @@
 
 static char *tmpfs;
 
-static void test_precopy_file(void)
+static void test_precopy_file(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = "defer",
-    };
+    args->connect_uri = uri;
+    args->listen_uri = "defer";
 
-    test_file_common(&args, true);
+    test_file_common(args, true);
 }
 
 #ifndef _WIN32
@@ -66,107 +64,94 @@ static void *migrate_hook_start_file_offset_fdset(QTestState *from,
     return NULL;
 }
 
-static void test_precopy_file_offset_fdset(void)
+static void test_precopy_file_offset_fdset(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=%d",
                                            FILE_TEST_OFFSET);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_file_offset_fdset,
-    };
+    args->connect_uri = uri;
+    args->listen_uri = "defer";
+    args->start_hook = migrate_hook_start_file_offset_fdset;
 
-    test_file_common(&args, false);
+    test_file_common(args, false);
 }
 #endif
 
-static void test_precopy_file_offset(void)
+static void test_precopy_file_offset(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s,offset=%d", tmpfs,
                                            FILE_TEST_FILENAME,
                                            FILE_TEST_OFFSET);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = "defer",
-    };
 
-    test_file_common(&args, false);
+    args->connect_uri = uri;
+    args->listen_uri = "defer";
+
+    test_file_common(args, false);
 }
 
-static void test_precopy_file_offset_bad(void)
+static void test_precopy_file_offset_bad(char *name, MigrateCommon *args)
 {
     /* using a value not supported by qemu_strtosz() */
     g_autofree char *uri = g_strdup_printf("file:%s/%s,offset=0x20M",
                                            tmpfs, FILE_TEST_FILENAME);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = "defer",
-        .result = MIG_TEST_QMP_ERROR,
-    };
 
-    test_file_common(&args, false);
+    args->connect_uri = uri;
+    args->listen_uri = "defer";
+    args->result = MIG_TEST_QMP_ERROR;
+
+    test_file_common(args, false);
 }
 
-static void test_precopy_file_mapped_ram_live(void)
+static void test_precopy_file_mapped_ram_live(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = "defer",
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
-        },
-    };
-
-    test_file_common(&args, false);
+
+    args->connect_uri = uri;
+    args->listen_uri = "defer";
+
+    args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
+
+    test_file_common(args, false);
 }
 
-static void test_precopy_file_mapped_ram(void)
+static void test_precopy_file_mapped_ram(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = "defer",
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
-        },
-    };
-
-    test_file_common(&args, true);
+
+    args->connect_uri = uri;
+    args->listen_uri = "defer";
+
+    args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
+
+    test_file_common(args, true);
 }
 
-static void test_multifd_file_mapped_ram_live(void)
+static void test_multifd_file_mapped_ram_live(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = "defer",
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
-        },
-    };
-
-    test_file_common(&args, false);
+    args->connect_uri = uri;
+    args->listen_uri = "defer";
+
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+    args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
+
+    test_file_common(args, false);
 }
 
-static void test_multifd_file_mapped_ram(void)
+static void test_multifd_file_mapped_ram(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = "defer",
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
-        },
-    };
-
-    test_file_common(&args, true);
+
+    args->connect_uri = uri;
+    args->listen_uri = "defer";
+
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+    args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
+
+    test_file_common(args, true);
 }
 
 static void *migrate_hook_start_multifd_mapped_ram_dio(QTestState *from,
@@ -178,26 +163,23 @@ static void *migrate_hook_start_multifd_mapped_ram_dio(QTestState *from,
     return NULL;
 }
 
-static void test_multifd_file_mapped_ram_dio(void)
+static void test_multifd_file_mapped_ram_dio(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_multifd_mapped_ram_dio,
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-        },
-    };
+    args->connect_uri = uri;
+    args->listen_uri = "defer";
+    args->start_hook = migrate_hook_start_multifd_mapped_ram_dio;
+
+    args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     if (!probe_o_direct_support(tmpfs)) {
         g_test_skip("Filesystem does not support O_DIRECT");
         return;
     }
 
-    test_file_common(&args, true);
+    test_file_common(args, true);
 }
 
 #ifndef _WIN32
@@ -252,45 +234,41 @@ static void *migrate_hook_start_multifd_mapped_ram_fdset(QTestState *from,
     return NULL;
 }
 
-static void test_multifd_file_mapped_ram_fdset(void)
+static void test_multifd_file_mapped_ram_fdset(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=%d",
                                            FILE_TEST_OFFSET);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_multifd_mapped_ram_fdset,
-        .end_hook = migrate_hook_end_multifd_mapped_ram_fdset,
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-        },
-    };
 
-    test_file_common(&args, true);
+    args->connect_uri = uri;
+    args->listen_uri = "defer";
+    args->start_hook = migrate_hook_start_multifd_mapped_ram_fdset;
+    args->end_hook = migrate_hook_end_multifd_mapped_ram_fdset;
+
+    args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
+    test_file_common(args, true);
 }
 
-static void test_multifd_file_mapped_ram_fdset_dio(void)
+static void test_multifd_file_mapped_ram_fdset_dio(char *name,
+                                                   MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=%d",
                                            FILE_TEST_OFFSET);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_multifd_mapped_ram_fdset_dio,
-        .end_hook = migrate_hook_end_multifd_mapped_ram_fdset,
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-        },
-    };
+    args->connect_uri = uri;
+    args->listen_uri = "defer";
+    args->start_hook = migrate_hook_start_multifd_mapped_ram_fdset_dio;
+    args->end_hook = migrate_hook_end_multifd_mapped_ram_fdset;
+
+    args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     if (!probe_o_direct_support(tmpfs)) {
         g_test_skip("Filesystem does not support O_DIRECT");
         return;
     }
 
-    test_file_common(&args, true);
+    test_file_common(args, true);
 }
 #endif /* !_WIN32 */
 
diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
index 642cf50c8d..c2462306a1 100644
--- a/tests/qtest/migration/migration-util.c
+++ b/tests/qtest/migration/migration-util.c
@@ -235,14 +235,15 @@ char *resolve_machine_version(const char *alias, const char *var1,
 
 typedef struct {
     char *name;
-    void (*func)(void);
-    void (*func_full)(void *);
+    MigrateCommon *data;
+    void (*func)(char *name, MigrateCommon *args);
 } MigrationTest;
 
 static void migration_test_destroy(gpointer data)
 {
     MigrationTest *test = (MigrationTest *)data;
 
+    g_free(test->data);
     g_free(test->name);
     g_free(test);
 }
@@ -251,11 +252,14 @@ static void migration_test_wrapper(const void *data)
 {
     MigrationTest *test = (MigrationTest *)data;
 
+    test->data = g_new0(MigrateCommon, 1);
+
     g_test_message("Running /%s%s", qtest_get_arch(), test->name);
-    test->func();
+    test->func(test->name, test->data);
 }
 
-void migration_test_add(const char *path, void (*fn)(void))
+void migration_test_add(const char *path,
+                        void (*fn)(char *name, MigrateCommon *args))
 {
     MigrationTest *test = g_new0(MigrationTest, 1);
 
@@ -266,26 +270,18 @@ void migration_test_add(const char *path, void (*fn)(void))
                              migration_test_destroy);
 }
 
-static void migration_test_wrapper_full(const void *data)
-{
-    MigrationTest *test = (MigrationTest *)data;
-
-    g_test_message("Running /%s%s", qtest_get_arch(), test->name);
-    test->func_full(test->name);
-}
-
 void migration_test_add_suffix(const char *path, const char *suffix,
-                               void (*fn)(void *))
+                               void (*fn)(char *name, MigrateCommon *args))
 {
     MigrationTest *test = g_new0(MigrationTest, 1);
 
     g_assert(g_str_has_suffix(path, "/"));
     g_assert(!g_str_has_prefix(suffix, "/"));
 
-    test->func_full = fn;
+    test->func = fn;
     test->name = g_strconcat(path, suffix, NULL);
 
-    qtest_add_data_func_full(test->name, test, migration_test_wrapper_full,
+    qtest_add_data_func_full(test->name, test, migration_test_wrapper,
                              migration_test_destroy);
 }
 
diff --git a/tests/qtest/migration/migration-util.h b/tests/qtest/migration/migration-util.h
index 44815e9c42..e73d69bab0 100644
--- a/tests/qtest/migration/migration-util.h
+++ b/tests/qtest/migration/migration-util.h
@@ -15,6 +15,8 @@
 
 #include "libqtest.h"
 
+#include "migration/framework.h"
+
 typedef struct QTestMigrationState {
     bool stop_seen;
     bool resume_seen;
@@ -50,9 +52,11 @@ static inline bool probe_o_direct_support(const char *tmpfs)
 
 bool ufd_version_check(bool *uffd_feature_thread_id);
 bool kvm_dirty_ring_supported(void);
-void migration_test_add(const char *path, void (*fn)(void));
+
+void migration_test_add(const char *path,
+                        void (*fn)(char *name, MigrateCommon *args));
 void migration_test_add_suffix(const char *path, const char *suffix,
-                               void (*fn)(void *));
+                               void (*fn)(char *name, MigrateCommon *args));
 char *migrate_get_connect_uri(QTestState *who);
 void migrate_set_ports(QTestState *to, QList *channel_list);
 
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 20edaa51f5..810e9e6549 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -22,14 +22,13 @@
 
 static char *tmpfs;
 
-static void test_baddest(void)
+static void test_baddest(char *name, MigrateCommon *args)
 {
-    MigrateStart args = {
-        .hide_stderr = true
-    };
     QTestState *from, *to;
 
-    if (migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
+    args->start.hide_stderr = true;
+
+    if (migrate_start(&from, &to, "tcp:127.0.0.1:0", &args->start)) {
         return;
     }
     migrate_qmp(from, to, "tcp:127.0.0.1:0", NULL, "{}");
@@ -38,24 +37,23 @@ static void test_baddest(void)
 }
 
 #ifndef _WIN32
-static void test_analyze_script(void)
+static void test_analyze_script(char *name, MigrateCommon *args)
 {
-    MigrateStart args = {
-        .opts_source = "-uuid 11111111-1111-1111-1111-111111111111",
-    };
     QTestState *from, *to;
     g_autofree char *uri = NULL;
     g_autofree char *file = NULL;
     int pid, wstatus;
     const char *python = g_getenv("PYTHON");
 
+    args->start.opts_source = "-uuid 11111111-1111-1111-1111-111111111111";
+
     if (!python) {
         g_test_skip("PYTHON variable not set");
         return;
     }
 
     /* dummy url */
-    if (migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
+    if (migrate_start(&from, &to, "tcp:127.0.0.1:0", &args->start)) {
         return;
     }
 
@@ -92,16 +90,15 @@ static void test_analyze_script(void)
 }
 #endif
 
-static void test_ignore_shared(void)
+static void test_ignore_shared(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
-    MigrateStart args = {
-        .mem_type = MEM_TYPE_SHMEM,
-        .caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true,
-    };
 
-    if (migrate_start(&from, &to, uri, &args)) {
+    args->start.mem_type = MEM_TYPE_SHMEM;
+    args->start.caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true;
+
+    if (migrate_start(&from, &to, uri, &args->start)) {
         return;
     }
 
@@ -161,45 +158,37 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     migrate_end(from, to, false);
 }
 
-static void test_validate_uuid(void)
+static void test_validate_uuid(char *name, MigrateCommon *args)
 {
-    MigrateStart args = {
-        .opts_source = "-uuid 11111111-1111-1111-1111-111111111111",
-        .opts_target = "-uuid 11111111-1111-1111-1111-111111111111",
-    };
+    args->start.opts_source = "-uuid 11111111-1111-1111-1111-111111111111";
+    args->start.opts_target = "-uuid 11111111-1111-1111-1111-111111111111";
 
-    do_test_validate_uuid(&args, false);
+    do_test_validate_uuid(&args->start, false);
 }
 
-static void test_validate_uuid_error(void)
+static void test_validate_uuid_error(char *name, MigrateCommon *args)
 {
-    MigrateStart args = {
-        .opts_source = "-uuid 11111111-1111-1111-1111-111111111111",
-        .opts_target = "-uuid 22222222-2222-2222-2222-222222222222",
-        .hide_stderr = true,
-    };
+    args->start.opts_source = "-uuid 11111111-1111-1111-1111-111111111111";
+    args->start.opts_target = "-uuid 22222222-2222-2222-2222-222222222222";
+    args->start.hide_stderr = true;
 
-    do_test_validate_uuid(&args, true);
+    do_test_validate_uuid(&args->start, true);
 }
 
-static void test_validate_uuid_src_not_set(void)
+static void test_validate_uuid_src_not_set(char *name, MigrateCommon *args)
 {
-    MigrateStart args = {
-        .opts_target = "-uuid 22222222-2222-2222-2222-222222222222",
-        .hide_stderr = true,
-    };
+    args->start.opts_target = "-uuid 22222222-2222-2222-2222-222222222222";
+    args->start.hide_stderr = true;
 
-    do_test_validate_uuid(&args, false);
+    do_test_validate_uuid(&args->start, false);
 }
 
-static void test_validate_uuid_dst_not_set(void)
+static void test_validate_uuid_dst_not_set(char *name, MigrateCommon *args)
 {
-    MigrateStart args = {
-        .opts_source = "-uuid 11111111-1111-1111-1111-111111111111",
-        .hide_stderr = true,
-    };
+    args->start.opts_source = "-uuid 11111111-1111-1111-1111-111111111111";
+    args->start.hide_stderr = true;
 
-    do_test_validate_uuid(&args, false);
+    do_test_validate_uuid(&args->start, false);
 }
 
 static void do_test_validate_uri_channel(MigrateCommon *args)
@@ -226,34 +215,27 @@ static void do_test_validate_uri_channel(MigrateCommon *args)
     migrate_end(from, to, false);
 }
 
-static void test_validate_uri_channels_both_set(void)
+static void test_validate_uri_channels_both_set(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-        },
-        .listen_uri = "defer",
-        .connect_uri = "tcp:127.0.0.1:0",
-        .connect_channels = ("[ { ""'channel-type': 'main',"
-                             "    'addr': { 'transport': 'socket',"
-                             "              'type': 'inet',"
-                             "              'host': '127.0.0.1',"
-                             "              'port': '0' } } ]"),
-    };
+    args->listen_uri = "defer",
+    args->connect_uri = "tcp:127.0.0.1:0",
+    args->connect_channels = ("[ { ""'channel-type': 'main',"
+                              "    'addr': { 'transport': 'socket',"
+                              "              'type': 'inet',"
+                              "              'host': '127.0.0.1',"
+                              "              'port': '0' } } ]"),
 
-    do_test_validate_uri_channel(&args);
+    args->start.hide_stderr = true;
+
+    do_test_validate_uri_channel(args);
 }
 
-static void test_validate_uri_channels_none_set(void)
+static void test_validate_uri_channels_none_set(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-        },
-        .listen_uri = "defer",
-    };
+    args->listen_uri = "defer";
+    args->start.hide_stderr = true;
 
-    do_test_validate_uri_channel(&args);
+    do_test_validate_uri_channel(args);
 }
 
 static void migration_test_add_misc_smoke(MigrationTestEnv *env)
diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
index 3773525843..7ae4d765d7 100644
--- a/tests/qtest/migration/postcopy-tests.c
+++ b/tests/qtest/migration/postcopy-tests.c
@@ -20,67 +20,51 @@
 #include "qemu/range.h"
 #include "qemu/sockets.h"
 
-static void test_postcopy(void)
+static void test_postcopy(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = { };
-
-    test_postcopy_common(&args);
+    test_postcopy_common(args);
 }
 
-static void test_postcopy_suspend(void)
+static void test_postcopy_suspend(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .start.suspend_me = true,
-    };
+    args->start.suspend_me = true;
 
-    test_postcopy_common(&args);
+    test_postcopy_common(args);
 }
 
-static void test_postcopy_preempt(void)
+static void test_postcopy_preempt(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .start = {
-            .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
-        },
-    };
+    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
 
-    test_postcopy_common(&args);
+    test_postcopy_common(args);
 }
 
-static void test_postcopy_recovery(void)
+static void test_postcopy_recovery(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = { };
-
-    test_postcopy_recovery_common(&args);
+    test_postcopy_recovery_common(args);
 }
 
-static void test_postcopy_recovery_fail_handshake(void)
+static void test_postcopy_recovery_fail_handshake(char *name,
+                                                  MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .postcopy_recovery_fail_stage = POSTCOPY_FAIL_RECOVERY,
-    };
+    args->postcopy_recovery_fail_stage = POSTCOPY_FAIL_RECOVERY;
 
-    test_postcopy_recovery_common(&args);
+    test_postcopy_recovery_common(args);
 }
 
-static void test_postcopy_recovery_fail_reconnect(void)
+static void test_postcopy_recovery_fail_reconnect(char *name,
+                                                  MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .postcopy_recovery_fail_stage = POSTCOPY_FAIL_CHANNEL_ESTABLISH,
-    };
+    args->postcopy_recovery_fail_stage = POSTCOPY_FAIL_CHANNEL_ESTABLISH;
 
-    test_postcopy_recovery_common(&args);
+    test_postcopy_recovery_common(args);
 }
 
-static void test_postcopy_preempt_recovery(void)
+static void test_postcopy_preempt_recovery(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .start = {
-            .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
-        },
-    };
+    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
 
-    test_postcopy_recovery_common(&args);
+    test_postcopy_recovery_common(args);
 }
 
 static void migration_test_add_postcopy_smoke(MigrationTestEnv *env)
@@ -94,27 +78,19 @@ static void migration_test_add_postcopy_smoke(MigrationTestEnv *env)
     }
 }
 
-static void test_multifd_postcopy(void)
+static void test_multifd_postcopy(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-        },
-    };
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
-    test_postcopy_common(&args);
+    test_postcopy_common(args);
 }
 
-static void test_multifd_postcopy_preempt(void)
+static void test_multifd_postcopy_preempt(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-            .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
-        },
-    };
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
 
-    test_postcopy_common(&args);
+    test_postcopy_common(args);
 }
 
 void migration_test_add_postcopy(MigrationTestEnv *env)
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 57ca623de5..086d06a31c 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -35,68 +35,64 @@
 
 static char *tmpfs;
 
-static void test_precopy_unix_plain(void)
+static void test_precopy_unix_plain(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    MigrateCommon args = {
-        .listen_uri = uri,
-        .connect_uri = uri,
-        /*
-         * The simplest use case of precopy, covering smoke tests of
-         * get-dirty-log dirty tracking.
-         */
-        .live = true,
-    };
-
-    test_precopy_common(&args);
+
+    args->listen_uri = uri;
+    args->connect_uri = uri;
+    /*
+     * The simplest use case of precopy, covering smoke tests of
+     * get-dirty-log dirty tracking.
+     */
+    args->live = true;
+
+    test_precopy_common(args);
 }
 
-static void test_precopy_unix_suspend_live(void)
+static void test_precopy_unix_suspend_live(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    MigrateCommon args = {
-        .listen_uri = uri,
-        .connect_uri = uri,
-        /*
-         * despite being live, the test is fast because the src
-         * suspends immediately.
-         */
-        .live = true,
-        .start.suspend_me = true,
-    };
-
-    test_precopy_common(&args);
+
+    args->listen_uri = uri;
+    args->connect_uri = uri;
+    /*
+     * despite being live, the test is fast because the src
+     * suspends immediately.
+     */
+    args->live = true;
+
+    args->start.suspend_me = true;
+
+    test_precopy_common(args);
 }
 
-static void test_precopy_unix_suspend_notlive(void)
+static void test_precopy_unix_suspend_notlive(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    MigrateCommon args = {
-        .listen_uri = uri,
-        .connect_uri = uri,
-        .start.suspend_me = true,
-    };
 
-    test_precopy_common(&args);
+    args->listen_uri = uri;
+    args->connect_uri = uri;
+    args->start.suspend_me = true;
+
+    test_precopy_common(args);
 }
 
-static void test_precopy_unix_dirty_ring(void)
+static void test_precopy_unix_dirty_ring(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    MigrateCommon args = {
-        .start = {
-            .use_dirty_ring = true,
-        },
-        .listen_uri = uri,
-        .connect_uri = uri,
-        /*
-         * Besides the precopy/unix basic test, cover dirty ring interface
-         * rather than get-dirty-log.
-         */
-        .live = true,
-    };
-
-    test_precopy_common(&args);
+
+    args->listen_uri = uri;
+    args->connect_uri = uri;
+    /*
+     * Besides the precopy/unix basic test, cover dirty ring interface
+     * rather than get-dirty-log.
+     */
+    args->live = true;
+
+    args->start.use_dirty_ring = true;
+
+    test_precopy_common(args);
 }
 
 #ifdef CONFIG_RDMA
@@ -162,7 +158,7 @@ static int new_rdma_link(char *buffer, bool ipv6)
     return -1;
 }
 
-static void __test_precopy_rdma_plain(bool ipv6)
+static void __test_precopy_rdma_plain(MigrateCommon *args, bool ipv6)
 {
     char buffer[128] = {};
 
@@ -187,50 +183,43 @@ static void __test_precopy_rdma_plain(bool ipv6)
      **/
     g_autofree char *uri = g_strdup_printf("rdma:%s:29200", buffer);
 
-    MigrateCommon args = {
-        .listen_uri = uri,
-        .connect_uri = uri,
-    };
+    args->listen_uri = uri;
+    args->connect_uri = uri;
 
-    test_precopy_common(&args);
+    test_precopy_common(args);
 }
 
-static void test_precopy_rdma_plain(void)
+static void test_precopy_rdma_plain(char *name, MigrateCommon *args)
 {
-    __test_precopy_rdma_plain(false);
+    __test_precopy_rdma_plain(args, false);
 }
 
-static void test_precopy_rdma_plain_ipv6(void)
+static void test_precopy_rdma_plain_ipv6(char *name, MigrateCommon *args)
 {
-    __test_precopy_rdma_plain(true);
+    __test_precopy_rdma_plain(args, true);
 }
 #endif
 
-static void test_precopy_tcp_plain(void)
+static void test_precopy_tcp_plain(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .listen_uri = "tcp:127.0.0.1:0",
-    };
+    args->listen_uri = "tcp:127.0.0.1:0";
 
-    test_precopy_common(&args);
+    test_precopy_common(args);
 }
 
-static void test_precopy_tcp_switchover_ack(void)
+static void test_precopy_tcp_switchover_ack(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .listen_uri = "tcp:127.0.0.1:0",
-        .start = {
-            .caps[MIGRATION_CAPABILITY_RETURN_PATH] = true,
-            .caps[MIGRATION_CAPABILITY_SWITCHOVER_ACK] = true,
-        },
-        /*
-         * Source VM must be running in order to consider the switchover ACK
-         * when deciding to do switchover or not.
-         */
-        .live = true,
-    };
+    args->listen_uri = "tcp:127.0.0.1:0";
+    /*
+     * Source VM must be running in order to consider the switchover ACK
+     * when deciding to do switchover or not.
+     */
+    args->live = true;
 
-    test_precopy_common(&args);
+    args->start.caps[MIGRATION_CAPABILITY_RETURN_PATH] = true;
+    args->start.caps[MIGRATION_CAPABILITY_SWITCHOVER_ACK] = true;
+
+    test_precopy_common(args);
 }
 
 #ifndef _WIN32
@@ -291,15 +280,14 @@ static void migrate_hook_end_fd(QTestState *from,
     qobject_unref(rsp);
 }
 
-static void test_precopy_fd_socket(void)
+static void test_precopy_fd_socket(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .connect_uri = "fd:fd-mig",
-        .start_hook = migrate_hook_start_fd,
-        .end_hook = migrate_hook_end_fd,
-    };
-    test_precopy_common(&args);
+    args->listen_uri = "defer";
+    args->connect_uri = "fd:fd-mig";
+    args->start_hook = migrate_hook_start_fd;
+    args->end_hook = migrate_hook_end_fd;
+
+    test_precopy_common(args);
 }
 
 static void *migrate_hook_start_precopy_fd_file(QTestState *from,
@@ -331,15 +319,14 @@ static void *migrate_hook_start_precopy_fd_file(QTestState *from,
     return NULL;
 }
 
-static void test_precopy_fd_file(void)
+static void test_precopy_fd_file(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .connect_uri = "fd:fd-mig",
-        .start_hook = migrate_hook_start_precopy_fd_file,
-        .end_hook = migrate_hook_end_fd,
-    };
-    test_file_common(&args, true);
+    args->listen_uri = "defer";
+    args->connect_uri = "fd:fd-mig";
+    args->start_hook = migrate_hook_start_precopy_fd_file;
+    args->end_hook = migrate_hook_end_fd;
+
+    test_file_common(args, true);
 }
 #endif /* _WIN32 */
 
@@ -358,10 +345,9 @@ static void test_precopy_fd_file(void)
  * To make things even worse, we need to run the initial stage at
  * 3MB/s so we enter autoconverge even when host is (over)loaded.
  */
-static void test_auto_converge(void)
+static void test_auto_converge(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    MigrateStart args = {};
     QTestState *from, *to;
     int64_t percentage;
 
@@ -374,7 +360,7 @@ static void test_auto_converge(void)
     uint64_t prev_dirty_sync_cnt, dirty_sync_cnt;
     int max_try_count, hit = 0;
 
-    if (migrate_start(&from, &to, uri, &args)) {
+    if (migrate_start(&from, &to, uri, &args->start)) {
         return;
     }
 
@@ -486,76 +472,68 @@ migrate_hook_start_precopy_tcp_multifd_no_zero_page(QTestState *from,
     return NULL;
 }
 
-static void test_multifd_tcp_uri_none(void)
+static void test_multifd_tcp_uri_none(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_precopy_tcp_multifd,
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-        },
-        /*
-         * Multifd is more complicated than most of the features, it
-         * directly takes guest page buffers when sending, make sure
-         * everything will work alright even if guest page is changing.
-         */
-        .live = true,
-    };
-    test_precopy_common(&args);
+    args->listen_uri = "defer";
+    args->start_hook = migrate_hook_start_precopy_tcp_multifd;
+    /*
+     * Multifd is more complicated than most of the features, it
+     * directly takes guest page buffers when sending, make sure
+     * everything will work alright even if guest page is changing.
+     */
+    args->live = true;
+
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
+    test_precopy_common(args);
 }
 
-static void test_multifd_tcp_zero_page_legacy(void)
+static void test_multifd_tcp_zero_page_legacy(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_precopy_tcp_multifd_zero_page_legacy,
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-        },
-        /*
-         * Multifd is more complicated than most of the features, it
-         * directly takes guest page buffers when sending, make sure
-         * everything will work alright even if guest page is changing.
-         */
-        .live = true,
-    };
-    test_precopy_common(&args);
+    args->listen_uri = "defer";
+    args->start_hook = migrate_hook_start_precopy_tcp_multifd_zero_page_legacy;
+    /*
+     * Multifd is more complicated than most of the features, it
+     * directly takes guest page buffers when sending, make sure
+     * everything will work alright even if guest page is changing.
+     */
+    args->live = true;
+
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
+    test_precopy_common(args);
 }
 
-static void test_multifd_tcp_no_zero_page(void)
+static void test_multifd_tcp_no_zero_page(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_precopy_tcp_multifd_no_zero_page,
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-        },
-        /*
-         * Multifd is more complicated than most of the features, it
-         * directly takes guest page buffers when sending, make sure
-         * everything will work alright even if guest page is changing.
-         */
-        .live = true,
-    };
-    test_precopy_common(&args);
+    args->listen_uri = "defer";
+    args->start_hook = migrate_hook_start_precopy_tcp_multifd_no_zero_page;
+    /*
+     * Multifd is more complicated than most of the features, it
+     * directly takes guest page buffers when sending, make sure
+     * everything will work alright even if guest page is changing.
+     */
+    args->live = true;
+
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
+    test_precopy_common(args);
 }
 
-static void test_multifd_tcp_channels_none(void)
+static void test_multifd_tcp_channels_none(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_precopy_tcp_multifd,
-        .live = true,
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-        },
-        .connect_channels = ("[ { 'channel-type': 'main',"
+    args->listen_uri = "defer";
+    args->start_hook = migrate_hook_start_precopy_tcp_multifd;
+    args->live = true;
+    args->connect_channels = ("[ { 'channel-type': 'main',"
                              "    'addr': { 'transport': 'socket',"
                              "              'type': 'inet',"
                              "              'host': '127.0.0.1',"
-                             "              'port': '0' } } ]"),
-    };
-    test_precopy_common(&args);
+                              "              'port': '0' } } ]");
+
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
+    test_precopy_common(args);
 }
 
 /*
@@ -569,14 +547,13 @@ static void test_multifd_tcp_channels_none(void)
  *
  *  And see that it works
  */
-static void test_multifd_tcp_cancel(bool postcopy_ram)
+static void test_multifd_tcp_cancel(MigrateCommon *args, bool postcopy_ram)
 {
-    MigrateStart args = {
-        .hide_stderr = true,
-    };
     QTestState *from, *to, *to2;
 
-    if (migrate_start(&from, &to, "defer", &args)) {
+    args->start.hide_stderr = true;
+
+    if (migrate_start(&from, &to, "defer", &args->start)) {
         return;
     }
 
@@ -621,11 +598,9 @@ static void test_multifd_tcp_cancel(bool postcopy_ram)
      */
     wait_for_migration_status(from, "cancelled", NULL);
 
-    args = (MigrateStart){
-        .only_target = true,
-    };
+    args->start.only_target = true;
 
-    if (migrate_start(&from, &to2, "defer", &args)) {
+    if (migrate_start(&from, &to2, "defer", &args->start)) {
         return;
     }
 
@@ -656,14 +631,14 @@ static void test_multifd_tcp_cancel(bool postcopy_ram)
     migrate_end(from, to2, true);
 }
 
-static void test_multifd_precopy_tcp_cancel(void)
+static void test_multifd_precopy_tcp_cancel(char *name, MigrateCommon *args)
 {
-    test_multifd_tcp_cancel(false);
+    test_multifd_tcp_cancel(args, false);
 }
 
-static void test_multifd_postcopy_tcp_cancel(void)
+static void test_multifd_postcopy_tcp_cancel(char *name, MigrateCommon *args)
 {
-    test_multifd_tcp_cancel(true);
+    test_multifd_tcp_cancel(args, true);
 }
 
 static void test_cancel_src_after_failed(QTestState *from, QTestState *to,
@@ -786,17 +761,15 @@ static void test_cancel_src_pre_switchover(QTestState *from, QTestState *to,
                               (const char * []) { "completed", NULL });
 }
 
-static void test_cancel_src_after_status(void *opaque)
+static void test_cancel_src_after_status(char *test_path, MigrateCommon *args)
 {
-    const char *test_path = opaque;
     g_autofree char *phase = g_path_get_basename(test_path);
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
-    MigrateStart args = {
-        .hide_stderr = true,
-    };
 
-    if (migrate_start(&from, &to, "defer", &args)) {
+    args->start.hide_stderr = true;
+
+    if (migrate_start(&from, &to, "defer", &args->start)) {
         return;
     }
 
@@ -980,7 +953,7 @@ static void dirtylimit_stop_vm(QTestState *vm)
     unlink(path);
 }
 
-static void test_vcpu_dirty_limit(void)
+static void test_vcpu_dirty_limit(char *name, MigrateCommon *args)
 {
     QTestState *vm;
     int64_t origin_rate;
@@ -1107,7 +1080,7 @@ static void migrate_dirty_limit_wait_showup(QTestState *from,
  * And see if dirty limit migration works correctly.
  * This test case involves many passes, so it runs in slow mode only.
  */
-static void test_dirty_limit(void)
+static void test_dirty_limit(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
@@ -1128,17 +1101,15 @@ static void test_dirty_limit(void)
      */
     const int64_t expected_threshold = max_bandwidth * downtime_limit / 1000;
     int max_try_count = 10;
-    MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-            .use_dirty_ring = true,
-        },
-        .listen_uri = uri,
-        .connect_uri = uri,
-    };
+
+    args->start.hide_stderr = true;
+    args->start.use_dirty_ring = true;
+
+    args->listen_uri = uri;
+    args->connect_uri = uri;
 
     /* Start src, dst vm */
-    if (migrate_start(&from, &to, args.listen_uri, &args.start)) {
+    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
     }
 
@@ -1146,7 +1117,7 @@ static void test_dirty_limit(void)
     migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
 
     /* Start migrate */
-    migrate_qmp(from, to, args.connect_uri, NULL, "{}");
+    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
@@ -1179,22 +1150,19 @@ static void test_dirty_limit(void)
     /* Assert dirty limit is not in service */
     g_assert_cmpint(throttle_us_per_full, ==, 0);
 
-    args = (MigrateCommon) {
-        .start = {
-            .only_target = true,
-            .use_dirty_ring = true,
-        },
-        .listen_uri = uri,
-        .connect_uri = uri,
-    };
+    args->listen_uri = uri;
+    args->connect_uri = uri;
+
+    args->start.only_target = true;
+    args->start.use_dirty_ring = true;
 
     /* Restart dst vm, src vm already show up so we needn't wait anymore */
-    if (migrate_start(&from, &to, args.listen_uri, &args.start)) {
+    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
     }
 
     /* Start migrate */
-    migrate_qmp(from, to, args.connect_uri, NULL, "{}");
+    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index e0e8a7335c..6a20c65104 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -362,149 +362,128 @@ migrate_hook_end_tls_x509(QTestState *from,
 }
 #endif /* CONFIG_TASN1 */
 
-static void test_postcopy_tls_psk(void)
+static void test_postcopy_tls_psk(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .start_hook = migrate_hook_start_tls_psk_match,
-        .end_hook = migrate_hook_end_tls_psk,
-    };
+    args->start_hook = migrate_hook_start_tls_psk_match;
+    args->end_hook = migrate_hook_end_tls_psk;
 
-    test_postcopy_common(&args);
+    test_postcopy_common(args);
 }
 
-static void test_postcopy_preempt_tls_psk(void)
+static void test_postcopy_preempt_tls_psk(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .start_hook = migrate_hook_start_tls_psk_match,
-        .end_hook = migrate_hook_end_tls_psk,
-        .start = {
-            .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
-        },
-    };
-
-    test_postcopy_common(&args);
+    args->start_hook = migrate_hook_start_tls_psk_match;
+    args->end_hook = migrate_hook_end_tls_psk;
+
+    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
+
+    test_postcopy_common(args);
 }
 
-static void test_postcopy_recovery_tls_psk(void)
+static void test_postcopy_recovery_tls_psk(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .start_hook = migrate_hook_start_tls_psk_match,
-        .end_hook = migrate_hook_end_tls_psk,
-    };
+    args->start_hook = migrate_hook_start_tls_psk_match;
+    args->end_hook = migrate_hook_end_tls_psk;
 
-    test_postcopy_recovery_common(&args);
+    test_postcopy_recovery_common(args);
 }
 
-static void test_multifd_postcopy_recovery_tls_psk(void)
+static void test_multifd_postcopy_recovery_tls_psk(char *name,
+                                                   MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .start_hook = migrate_hook_start_tls_psk_match,
-        .end_hook = migrate_hook_end_tls_psk,
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-        },
-    };
-
-    test_postcopy_recovery_common(&args);
+    args->start_hook = migrate_hook_start_tls_psk_match;
+    args->end_hook = migrate_hook_end_tls_psk;
+
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
+    test_postcopy_recovery_common(args);
 }
 
 /* This contains preempt+recovery+tls test altogether */
-static void test_postcopy_preempt_all(void)
+static void test_postcopy_preempt_all(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .start_hook = migrate_hook_start_tls_psk_match,
-        .end_hook = migrate_hook_end_tls_psk,
-        .start = {
-            .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
-        },
-    };
+    args->start_hook = migrate_hook_start_tls_psk_match;
+    args->end_hook = migrate_hook_end_tls_psk;
 
-    test_postcopy_recovery_common(&args);
+    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
+
+    test_postcopy_recovery_common(args);
 }
 
-static void test_multifd_postcopy_preempt_recovery_tls_psk(void)
+static void test_multifd_postcopy_preempt_recovery_tls_psk(char *name,
+                                                           MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .start_hook = migrate_hook_start_tls_psk_match,
-        .end_hook = migrate_hook_end_tls_psk,
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-            .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
-        },
-    };
+    args->start_hook = migrate_hook_start_tls_psk_match;
+    args->end_hook = migrate_hook_end_tls_psk;
+
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
 
-    test_postcopy_recovery_common(&args);
+    test_postcopy_recovery_common(args);
 }
 
-static void test_precopy_unix_tls_psk(void)
+static void test_precopy_unix_tls_psk(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = uri,
-        .start_hook = migrate_hook_start_tls_psk_match,
-        .end_hook = migrate_hook_end_tls_psk,
-    };
 
-    test_precopy_common(&args);
+    args->connect_uri = uri;
+    args->listen_uri = uri;
+    args->start_hook = migrate_hook_start_tls_psk_match;
+    args->end_hook = migrate_hook_end_tls_psk;
+
+    test_precopy_common(args);
 }
 
 #ifdef CONFIG_TASN1
-static void test_precopy_unix_tls_x509_default_host(void)
+static void test_precopy_unix_tls_x509_default_host(char *name,
+                                                    MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-        },
-        .connect_uri = uri,
-        .listen_uri = uri,
-        .start_hook = migrate_hook_start_tls_x509_default_host,
-        .end_hook = migrate_hook_end_tls_x509,
-        .result = MIG_TEST_FAIL_DEST_QUIT_ERR,
-    };
 
-    test_precopy_common(&args);
+    args->connect_uri = uri;
+    args->listen_uri = uri;
+    args->start_hook = migrate_hook_start_tls_x509_default_host;
+    args->end_hook = migrate_hook_end_tls_x509;
+    args->result = MIG_TEST_FAIL_DEST_QUIT_ERR;
+
+    args->start.hide_stderr = true;
+
+    test_precopy_common(args);
 }
 
-static void test_precopy_unix_tls_x509_override_host(void)
+static void test_precopy_unix_tls_x509_override_host(char *name,
+                                                     MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = uri,
-        .start_hook = migrate_hook_start_tls_x509_override_host,
-        .end_hook = migrate_hook_end_tls_x509,
-    };
 
-    test_precopy_common(&args);
+    args->connect_uri = uri;
+    args->listen_uri = uri;
+    args->start_hook = migrate_hook_start_tls_x509_override_host;
+    args->end_hook = migrate_hook_end_tls_x509;
+
+    test_precopy_common(args);
 }
 #endif /* CONFIG_TASN1 */
 
-static void test_precopy_tcp_tls_psk_match(void)
+static void test_precopy_tcp_tls_psk_match(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = migrate_hook_start_tls_psk_match,
-        .end_hook = migrate_hook_end_tls_psk,
-    };
+    args->listen_uri = "tcp:127.0.0.1:0";
+    args->start_hook = migrate_hook_start_tls_psk_match;
+    args->end_hook = migrate_hook_end_tls_psk;
 
-    test_precopy_common(&args);
+    test_precopy_common(args);
 }
 
-static void test_precopy_tcp_tls_psk_mismatch(void)
+static void test_precopy_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-        },
-        .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = migrate_hook_start_tls_psk_mismatch,
-        .end_hook = migrate_hook_end_tls_psk,
-        .result = MIG_TEST_FAIL,
-    };
+    args->listen_uri = "tcp:127.0.0.1:0";
+    args->start_hook = migrate_hook_start_tls_psk_mismatch;
+    args->end_hook = migrate_hook_end_tls_psk;
+    args->result = MIG_TEST_FAIL;
 
-    test_precopy_common(&args);
+    args->start.hide_stderr = true;
+
+    test_precopy_common(args);
 }
 
 static void *migrate_hook_start_no_tls(QTestState *from, QTestState *to)
@@ -518,15 +497,13 @@ static void *migrate_hook_start_no_tls(QTestState *from, QTestState *to)
     return data;
 }
 
-static void test_precopy_tcp_no_tls(void)
+static void test_precopy_tcp_no_tls(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = migrate_hook_start_no_tls,
-        .end_hook = migrate_hook_end_tls_psk,
-    };
+    args->listen_uri = "tcp:127.0.0.1:0";
+    args->start_hook = migrate_hook_start_no_tls;
+    args->end_hook = migrate_hook_end_tls_psk;
 
-    test_precopy_common(&args);
+    test_precopy_common(args);
 }
 
 static void *
@@ -545,107 +522,96 @@ migrate_hook_start_tls_x509_no_host(QTestState *from, QTestState *to)
     return data;
 }
 
-static void test_precopy_tcp_tls_no_hostname(void)
+static void test_precopy_tcp_tls_no_hostname(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = migrate_hook_start_tls_x509_no_host,
-        .end_hook = migrate_hook_end_tls_x509,
-        .result = MIG_TEST_FAIL_DEST_QUIT_ERR,
-        .start.hide_stderr = true,
-    };
+    args->listen_uri = "tcp:127.0.0.1:0";
+    args->start_hook = migrate_hook_start_tls_x509_no_host;
+    args->end_hook = migrate_hook_end_tls_x509;
+    args->result = MIG_TEST_FAIL_DEST_QUIT_ERR;
 
-    test_precopy_common(&args);
+    args->start.hide_stderr = true;
+
+    test_precopy_common(args);
 }
 
 #ifdef CONFIG_TASN1
-static void test_precopy_tcp_tls_x509_default_host(void)
+static void test_precopy_tcp_tls_x509_default_host(char *name,
+                                                   MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = migrate_hook_start_tls_x509_default_host,
-        .end_hook = migrate_hook_end_tls_x509,
-    };
+    args->listen_uri = "tcp:127.0.0.1:0";
+    args->start_hook = migrate_hook_start_tls_x509_default_host;
+    args->end_hook = migrate_hook_end_tls_x509;
 
-    test_precopy_common(&args);
+    test_precopy_common(args);
 }
 
-static void test_precopy_tcp_tls_x509_override_host(void)
+static void test_precopy_tcp_tls_x509_override_host(char *name,
+                                                    MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = migrate_hook_start_tls_x509_override_host,
-        .end_hook = migrate_hook_end_tls_x509,
-    };
+    args->listen_uri = "tcp:127.0.0.1:0";
+    args->start_hook = migrate_hook_start_tls_x509_override_host;
+    args->end_hook = migrate_hook_end_tls_x509;
 
-    test_precopy_common(&args);
+    test_precopy_common(args);
 }
 
-static void test_precopy_tcp_tls_x509_mismatch_host(void)
+static void test_precopy_tcp_tls_x509_mismatch_host(char *name,
+                                                    MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-        },
-        .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = migrate_hook_start_tls_x509_mismatch_host,
-        .end_hook = migrate_hook_end_tls_x509,
-        .result = MIG_TEST_FAIL_DEST_QUIT_ERR,
-    };
-
-    test_precopy_common(&args);
+    args->listen_uri = "tcp:127.0.0.1:0";
+    args->start_hook = migrate_hook_start_tls_x509_mismatch_host;
+    args->end_hook = migrate_hook_end_tls_x509;
+    args->result = MIG_TEST_FAIL_DEST_QUIT_ERR;
+
+    args->start.hide_stderr = true;
+
+    test_precopy_common(args);
 }
 
-static void test_precopy_tcp_tls_x509_friendly_client(void)
+static void test_precopy_tcp_tls_x509_friendly_client(char *name,
+                                                      MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = migrate_hook_start_tls_x509_friendly_client,
-        .end_hook = migrate_hook_end_tls_x509,
-    };
+    args->listen_uri = "tcp:127.0.0.1:0";
+    args->start_hook = migrate_hook_start_tls_x509_friendly_client;
+    args->end_hook = migrate_hook_end_tls_x509;
 
-    test_precopy_common(&args);
+    test_precopy_common(args);
 }
 
-static void test_precopy_tcp_tls_x509_hostile_client(void)
+static void test_precopy_tcp_tls_x509_hostile_client(char *name,
+                                                     MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-        },
-        .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = migrate_hook_start_tls_x509_hostile_client,
-        .end_hook = migrate_hook_end_tls_x509,
-        .result = MIG_TEST_FAIL,
-    };
-
-    test_precopy_common(&args);
+    args->listen_uri = "tcp:127.0.0.1:0";
+    args->start_hook = migrate_hook_start_tls_x509_hostile_client;
+    args->end_hook = migrate_hook_end_tls_x509;
+    args->result = MIG_TEST_FAIL;
+
+    args->start.hide_stderr = true;
+
+    test_precopy_common(args);
 }
 
-static void test_precopy_tcp_tls_x509_allow_anon_client(void)
+static void test_precopy_tcp_tls_x509_allow_anon_client(char *name,
+                                                        MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = migrate_hook_start_tls_x509_allow_anon_client,
-        .end_hook = migrate_hook_end_tls_x509,
-    };
+    args->listen_uri = "tcp:127.0.0.1:0";
+    args->start_hook = migrate_hook_start_tls_x509_allow_anon_client;
+    args->end_hook = migrate_hook_end_tls_x509;
 
-    test_precopy_common(&args);
+    test_precopy_common(args);
 }
 
-static void test_precopy_tcp_tls_x509_reject_anon_client(void)
+static void test_precopy_tcp_tls_x509_reject_anon_client(char *name,
+                                                         MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-        },
-        .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = migrate_hook_start_tls_x509_reject_anon_client,
-        .end_hook = migrate_hook_end_tls_x509,
-        .result = MIG_TEST_FAIL,
-    };
-
-    test_precopy_common(&args);
+    args->listen_uri = "tcp:127.0.0.1:0";
+    args->start_hook = migrate_hook_start_tls_x509_reject_anon_client;
+    args->end_hook = migrate_hook_end_tls_x509;
+    args->result = MIG_TEST_FAIL;
+
+    args->start.hide_stderr = true;
+
+    test_precopy_common(args);
 }
 #endif /* CONFIG_TASN1 */
 
@@ -707,77 +673,70 @@ migrate_hook_start_multifd_tls_x509_reject_anon_client(QTestState *from,
 }
 #endif /* CONFIG_TASN1 */
 
-static void test_multifd_tcp_tls_psk_match(void)
+static void test_multifd_tcp_tls_psk_match(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_multifd_tcp_tls_psk_match,
-        .end_hook = migrate_hook_end_tls_psk,
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-        },
-    };
-    test_precopy_common(&args);
+    args->listen_uri = "defer";
+    args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
+    args->end_hook = migrate_hook_end_tls_psk;
+
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
+    test_precopy_common(args);
 }
 
-static void test_multifd_tcp_tls_psk_mismatch(void)
+static void test_multifd_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-        },
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_multifd_tcp_tls_psk_mismatch,
-        .end_hook = migrate_hook_end_tls_psk,
-        .result = MIG_TEST_FAIL,
-    };
-    test_precopy_common(&args);
+    args->listen_uri = "defer";
+    args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_mismatch;
+    args->end_hook = migrate_hook_end_tls_psk;
+    args->result = MIG_TEST_FAIL;
+
+    args->start.hide_stderr = true;
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
+    test_precopy_common(args);
 }
 
-static void test_multifd_postcopy_tcp_tls_psk_match(void)
+static void test_multifd_postcopy_tcp_tls_psk_match(char *name,
+                                                    MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-            .caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true,
-        },
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_multifd_tcp_tls_psk_match,
-        .end_hook = migrate_hook_end_tls_psk,
-    };
-
-    test_precopy_common(&args);
+    args->listen_uri = "defer";
+    args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
+    args->end_hook = migrate_hook_end_tls_psk;
+
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+    args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true;
+
+    test_precopy_common(args);
 }
 
 #ifdef CONFIG_TASN1
-static void test_multifd_tcp_tls_x509_default_host(void)
+static void test_multifd_tcp_tls_x509_default_host(char *name,
+                                                   MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_multifd_tls_x509_default_host,
-        .end_hook = migrate_hook_end_tls_x509,
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-        },
-    };
-    test_precopy_common(&args);
+    args->listen_uri = "defer";
+    args->start_hook = migrate_hook_start_multifd_tls_x509_default_host;
+    args->end_hook = migrate_hook_end_tls_x509;
+
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
+    test_precopy_common(args);
 }
 
-static void test_multifd_tcp_tls_x509_override_host(void)
+static void test_multifd_tcp_tls_x509_override_host(char *name,
+                                                    MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_multifd_tls_x509_override_host,
-        .end_hook = migrate_hook_end_tls_x509,
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-        },
-    };
-    test_precopy_common(&args);
+    args->listen_uri = "defer";
+    args->start_hook = migrate_hook_start_multifd_tls_x509_override_host;
+    args->end_hook = migrate_hook_end_tls_x509;
+
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
+    test_precopy_common(args);
 }
 
-static void test_multifd_tcp_tls_x509_mismatch_host(void)
+static void test_multifd_tcp_tls_x509_mismatch_host(char *name,
+                                                    MigrateCommon *args)
 {
     /*
      * This has different behaviour to the non-multifd case.
@@ -792,45 +751,41 @@ static void test_multifd_tcp_tls_x509_mismatch_host(void)
      * to load migration state, and thus just aborts the migration
      * without exiting.
      */
-    MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-        },
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_multifd_tls_x509_mismatch_host,
-        .end_hook = migrate_hook_end_tls_x509,
-        .result = MIG_TEST_FAIL,
-    };
-    test_precopy_common(&args);
+    args->listen_uri = "defer";
+    args->start_hook = migrate_hook_start_multifd_tls_x509_mismatch_host;
+    args->end_hook = migrate_hook_end_tls_x509;
+    args->result = MIG_TEST_FAIL;
+
+    args->start.hide_stderr = true;
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
+    test_precopy_common(args);
 }
 
-static void test_multifd_tcp_tls_x509_allow_anon_client(void)
+static void test_multifd_tcp_tls_x509_allow_anon_client(char *name,
+                                                        MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_multifd_tls_x509_allow_anon_client,
-        .end_hook = migrate_hook_end_tls_x509,
-        .start = {
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-        },
-    };
-    test_precopy_common(&args);
+    args->listen_uri = "defer";
+    args->start_hook = migrate_hook_start_multifd_tls_x509_allow_anon_client;
+    args->end_hook = migrate_hook_end_tls_x509;
+
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
+    test_precopy_common(args);
 }
 
-static void test_multifd_tcp_tls_x509_reject_anon_client(void)
+static void test_multifd_tcp_tls_x509_reject_anon_client(char *name,
+                                                         MigrateCommon *args)
 {
-    MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
-        },
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_multifd_tls_x509_reject_anon_client,
-        .end_hook = migrate_hook_end_tls_x509,
-        .result = MIG_TEST_FAIL,
-    };
-    test_precopy_common(&args);
+    args->listen_uri = "defer";
+    args->start_hook = migrate_hook_start_multifd_tls_x509_reject_anon_client;
+    args->end_hook = migrate_hook_end_tls_x509;
+    args->result = MIG_TEST_FAIL;
+
+    args->start.hide_stderr = true;
+    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
+    test_precopy_common(args);
 }
 #endif /* CONFIG_TASN1 */
 
-- 
2.51.0


