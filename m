Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12356D5B86F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGeC-0004dO-13; Mon, 15 Dec 2025 17:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGe2-0004HV-8K
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:02:19 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGdz-0002qV-As
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:02:18 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1C2CD33748;
 Mon, 15 Dec 2025 22:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QrAiykv9iUBDfBang+33s6+6HocOLLmKaPnqDkF+SbE=;
 b=qjIsDogzxKaY1z8f0Yu3LqagLh5Hk+zEI+lbb5Lky5fst9de47igZG844NlK81+SU03b2C
 J9CRjcFwZmMuNrDetPgF5FB8abnqGewchVN7mJS9FAOzWIIac7C7Erh0d5z0vkRQI1xAhZ
 cCPw7W7pxnPvslD+cf/sNEUCdpqwtEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836117;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QrAiykv9iUBDfBang+33s6+6HocOLLmKaPnqDkF+SbE=;
 b=WSB0nBA3ZwuutewEgIRSoypEt6Ix89j0Slnxq8TB/U8BlJ5Q9+GvG4dQ5HPM13msjoNlOr
 /N/CYIcHZVpq+hAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QrAiykv9iUBDfBang+33s6+6HocOLLmKaPnqDkF+SbE=;
 b=qjIsDogzxKaY1z8f0Yu3LqagLh5Hk+zEI+lbb5Lky5fst9de47igZG844NlK81+SU03b2C
 J9CRjcFwZmMuNrDetPgF5FB8abnqGewchVN7mJS9FAOzWIIac7C7Erh0d5z0vkRQI1xAhZ
 cCPw7W7pxnPvslD+cf/sNEUCdpqwtEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836117;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QrAiykv9iUBDfBang+33s6+6HocOLLmKaPnqDkF+SbE=;
 b=WSB0nBA3ZwuutewEgIRSoypEt6Ix89j0Slnxq8TB/U8BlJ5Q9+GvG4dQ5HPM13msjoNlOr
 /N/CYIcHZVpq+hAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17E053EA63;
 Mon, 15 Dec 2025 22:01:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6C3BMlKFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:01:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 27/51] tests/qtest/migration: Fix misuse of listen_uri
Date: Mon, 15 Dec 2025 19:00:13 -0300
Message-ID: <20251215220041.12657-28-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.991];
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

The listen_uri parameter is supposed to be used for the incoming
migration while connect_uri for the outgoing migration. This is well
documented in the header file.

However, due to -incoming "defer", some tests set listen-uri =
"defer", which is fine. But then, being without another parameter to
define the uri to be use in migrate_incoming, some tests have been
misusing connect_uri.

Add a separate flag to denote "defer" and spare the tests from passing
the string. Change the usage of listen_uri to it's original purpose.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/compression-tests.c | 12 +++----
 tests/qtest/migration/cpr-tests.c         | 17 +++++++---
 tests/qtest/migration/file-tests.c        | 38 ++++++++++++++++-------
 tests/qtest/migration/framework.c         | 12 +++----
 tests/qtest/migration/framework.h         |  7 +++++
 tests/qtest/migration/misc-tests.c        |  4 +--
 tests/qtest/migration/precopy-tests.c     | 26 ++++++++++------
 tests/qtest/migration/tls-tests.c         | 16 +++++-----
 8 files changed, 85 insertions(+), 47 deletions(-)

diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
index 845e622cd5..eb0b7d6b4b 100644
--- a/tests/qtest/migration/compression-tests.c
+++ b/tests/qtest/migration/compression-tests.c
@@ -33,9 +33,9 @@ migrate_hook_start_precopy_tcp_multifd_zstd(QTestState *from,
 
 static void test_multifd_tcp_zstd(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_zstd;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     test_precopy_common(args);
@@ -43,9 +43,9 @@ static void test_multifd_tcp_zstd(char *name, MigrateCommon *args)
 
 static void test_multifd_postcopy_tcp_zstd(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
     args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true;
 
@@ -66,9 +66,9 @@ migrate_hook_start_precopy_tcp_multifd_qatzip(QTestState *from,
 
 static void test_multifd_tcp_qatzip(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_qatzip;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     test_precopy_common(args);
@@ -85,9 +85,9 @@ migrate_hook_start_precopy_tcp_multifd_qpl(QTestState *from,
 
 static void test_multifd_tcp_qpl(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_qpl;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     test_precopy_common(args);
@@ -104,9 +104,9 @@ migrate_hook_start_precopy_tcp_multifd_uadk(QTestState *from,
 
 static void test_multifd_tcp_uadk(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_uadk;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     test_precopy_common(args);
@@ -156,9 +156,9 @@ migrate_hook_start_precopy_tcp_multifd_zlib(QTestState *from,
 
 static void test_multifd_tcp_zlib(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_zlib;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     test_precopy_common(args);
diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 0d97b5b89f..7456337370 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -32,10 +32,11 @@ static void test_mode_reboot(char *name, MigrateCommon *args)
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
 
+    args->listen_uri = uri;
     args->connect_uri = uri;
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_mode_reboot;
 
+    args->start.incoming_defer = true;
     args->start.mem_type = MEM_TYPE_SHMEM;
     args->start.caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true;
 
@@ -53,7 +54,7 @@ static void *test_mode_transfer_start(QTestState *from, QTestState *to)
  * migration, and cannot connect synchronously to the monitor, so defer
  * the target connection.
  */
-static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer)
+static void test_mode_transfer_common(MigrateCommon *args)
 {
     g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock", tmpfs);
     g_autofree char *mig_path = g_strdup_printf("%s/migsocket", tmpfs);
@@ -84,7 +85,11 @@ static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer)
                                   "addr.type=fd,addr.str=%d %s",
                                   cpr_sockfd, opts);
 
-    args->listen_uri = incoming_defer ? "defer" : uri;
+    /*
+     * The URI is used only for the deferred target connection when
+     * !incoming_defer.
+     */
+    args->listen_uri = uri;
     args->connect_channels = connect_channels;
     args->cpr_channel = cpr_channel;
     args->start_hook = test_mode_transfer_start;
@@ -102,12 +107,14 @@ static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer)
 
 static void test_mode_transfer(char *name, MigrateCommon *args)
 {
-    test_mode_transfer_common(args, false);
+    args->start.incoming_defer = false;
+    test_mode_transfer_common(args);
 }
 
 static void test_mode_transfer_defer(char *name, MigrateCommon *args)
 {
-    test_mode_transfer_common(args, true);
+    args->start.incoming_defer = true;
+    test_mode_transfer_common(args);
 }
 
 static void set_cpr_exec_args(QTestState *who, MigrateCommon *args)
diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
index 5f1159076c..57117b2496 100644
--- a/tests/qtest/migration/file-tests.c
+++ b/tests/qtest/migration/file-tests.c
@@ -25,7 +25,9 @@ static void test_precopy_file(char *name, MigrateCommon *args)
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
     args->connect_uri = uri;
-    args->listen_uri = "defer";
+    args->listen_uri = uri;
+
+    args->start.incoming_defer = true;
 
     test_file_common(args, true);
 }
@@ -69,9 +71,11 @@ static void test_precopy_file_offset_fdset(char *name, MigrateCommon *args)
     g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=%d",
                                            FILE_TEST_OFFSET);
     args->connect_uri = uri;
-    args->listen_uri = "defer";
+    args->listen_uri = uri;
     args->start_hook = migrate_hook_start_file_offset_fdset;
 
+    args->start.incoming_defer = true;
+
     test_file_common(args, false);
 }
 #endif
@@ -83,7 +87,9 @@ static void test_precopy_file_offset(char *name, MigrateCommon *args)
                                            FILE_TEST_OFFSET);
 
     args->connect_uri = uri;
-    args->listen_uri = "defer";
+    args->listen_uri = uri;
+
+    args->start.incoming_defer = true;
 
     test_file_common(args, false);
 }
@@ -95,9 +101,11 @@ static void test_precopy_file_offset_bad(char *name, MigrateCommon *args)
                                            tmpfs, FILE_TEST_FILENAME);
 
     args->connect_uri = uri;
-    args->listen_uri = "defer";
+    args->listen_uri = uri;
     args->result = MIG_TEST_QMP_ERROR;
 
+    args->start.incoming_defer = true;
+
     test_file_common(args, false);
 }
 
@@ -107,8 +115,9 @@ static void test_precopy_file_mapped_ram_live(char *name, MigrateCommon *args)
                                            FILE_TEST_FILENAME);
 
     args->connect_uri = uri;
-    args->listen_uri = "defer";
+    args->listen_uri = uri;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
 
     test_file_common(args, false);
@@ -120,8 +129,9 @@ static void test_precopy_file_mapped_ram(char *name, MigrateCommon *args)
                                            FILE_TEST_FILENAME);
 
     args->connect_uri = uri;
-    args->listen_uri = "defer";
+    args->listen_uri = uri;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
 
     test_file_common(args, true);
@@ -132,8 +142,9 @@ static void test_multifd_file_mapped_ram_live(char *name, MigrateCommon *args)
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
     args->connect_uri = uri;
-    args->listen_uri = "defer";
+    args->listen_uri = uri;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
 
@@ -146,8 +157,9 @@ static void test_multifd_file_mapped_ram(char *name, MigrateCommon *args)
                                            FILE_TEST_FILENAME);
 
     args->connect_uri = uri;
-    args->listen_uri = "defer";
+    args->listen_uri = uri;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
 
@@ -168,9 +180,10 @@ static void test_multifd_file_mapped_ram_dio(char *name, MigrateCommon *args)
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
     args->connect_uri = uri;
-    args->listen_uri = "defer";
+    args->listen_uri = uri;
     args->start_hook = migrate_hook_start_multifd_mapped_ram_dio;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
@@ -240,10 +253,11 @@ static void test_multifd_file_mapped_ram_fdset(char *name, MigrateCommon *args)
                                            FILE_TEST_OFFSET);
 
     args->connect_uri = uri;
-    args->listen_uri = "defer";
+    args->listen_uri = uri;
     args->start_hook = migrate_hook_start_multifd_mapped_ram_fdset;
     args->end_hook = migrate_hook_end_multifd_mapped_ram_fdset;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
@@ -255,11 +269,13 @@ static void test_multifd_file_mapped_ram_fdset_dio(char *name,
 {
     g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=%d",
                                            FILE_TEST_OFFSET);
+
     args->connect_uri = uri;
-    args->listen_uri = "defer";
+    args->listen_uri = uri;
     args->start_hook = migrate_hook_start_multifd_mapped_ram_fdset_dio;
     args->end_hook = migrate_hook_end_multifd_mapped_ram_fdset;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index e35839c95f..e811945122 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -414,7 +414,8 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
                                  "%s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
                                  machine, machine_opts,
-                                 memory_backend, tmpfs, uri,
+                                 memory_backend, tmpfs,
+                                 args->incoming_defer ? "defer" : uri,
                                  events,
                                  arch_opts ? arch_opts : "",
                                  args->opts_target ? args->opts_target : "",
@@ -856,8 +857,7 @@ int test_precopy_common(MigrateCommon *args)
      * migrate-incoming channels.
      */
     if (args->connect_channels) {
-        if (args->start.defer_target_connect &&
-            !strcmp(args->listen_uri, "defer")) {
+        if (args->start.defer_target_connect && args->start.incoming_defer) {
             in_channels = qobject_from_json(args->connect_channels,
                                             &error_abort);
         }
@@ -881,8 +881,8 @@ int test_precopy_common(MigrateCommon *args)
     if (args->start.defer_target_connect) {
         qtest_connect(to);
         qtest_qmp_handshake(to, NULL);
-        if (!strcmp(args->listen_uri, "defer")) {
-            migrate_incoming_qmp(to, args->connect_uri, in_channels, "{}");
+        if (args->start.incoming_defer) {
+            migrate_incoming_qmp(to, NULL, in_channels, "{}");
         }
     }
 
@@ -1031,7 +1031,7 @@ void test_file_common(MigrateCommon *args, bool stop_src)
      * We need to wait for the source to finish before starting the
      * destination.
      */
-    migrate_incoming_qmp(to, args->connect_uri, NULL, "{}");
+    migrate_incoming_qmp(to, args->listen_uri, NULL, "{}");
     wait_for_migration_complete(to);
 
     if (stop_src) {
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index ed85ed502d..bf3492a59e 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -144,6 +144,13 @@ typedef struct {
      * migration_set_capabilities().
      */
     bool caps[MIGRATION_CAPABILITY__MAX];
+
+    /*
+     * Whether to use "defer" as the uri for the -incoming command
+     * line option. If set to true, MigrateCommon.listen_uri will be
+     * used for the deferred migrate_incoming call.
+     */
+    bool incoming_defer;
 } MigrateStart;
 
 typedef enum PostcopyRecoveryFailStage {
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 810e9e6549..61bdfda857 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -217,7 +217,6 @@ static void do_test_validate_uri_channel(MigrateCommon *args)
 
 static void test_validate_uri_channels_both_set(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer",
     args->connect_uri = "tcp:127.0.0.1:0",
     args->connect_channels = ("[ { ""'channel-type': 'main',"
                               "    'addr': { 'transport': 'socket',"
@@ -225,6 +224,7 @@ static void test_validate_uri_channels_both_set(char *name, MigrateCommon *args)
                               "              'host': '127.0.0.1',"
                               "              'port': '0' } } ]"),
 
+    args->start.incoming_defer = true;
     args->start.hide_stderr = true;
 
     do_test_validate_uri_channel(args);
@@ -232,8 +232,8 @@ static void test_validate_uri_channels_both_set(char *name, MigrateCommon *args)
 
 static void test_validate_uri_channels_none_set(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start.hide_stderr = true;
+    args->start.incoming_defer = true;
 
     do_test_validate_uri_channel(args);
 }
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index aca7ed51ef..d9c463dd0f 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -282,11 +282,12 @@ static void migrate_hook_end_fd(QTestState *from,
 
 static void test_precopy_fd_socket(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->connect_uri = "fd:fd-mig";
     args->start_hook = migrate_hook_start_fd;
     args->end_hook = migrate_hook_end_fd;
 
+    args->start.incoming_defer = true;
+
     test_precopy_common(args);
 }
 
@@ -321,11 +322,13 @@ static void *migrate_hook_start_precopy_fd_file(QTestState *from,
 
 static void test_precopy_fd_file(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
+    args->listen_uri = "fd:fd-mig";
     args->connect_uri = "fd:fd-mig";
     args->start_hook = migrate_hook_start_precopy_fd_file;
     args->end_hook = migrate_hook_end_fd;
 
+    args->start.incoming_defer = true;
+
     test_file_common(args, true);
 }
 #endif /* _WIN32 */
@@ -474,7 +477,6 @@ migrate_hook_start_precopy_tcp_multifd_no_zero_page(QTestState *from,
 
 static void test_multifd_tcp_uri_none(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd;
     /*
      * Multifd is more complicated than most of the features, it
@@ -483,6 +485,7 @@ static void test_multifd_tcp_uri_none(char *name, MigrateCommon *args)
      */
     args->live = true;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     test_precopy_common(args);
@@ -490,7 +493,6 @@ static void test_multifd_tcp_uri_none(char *name, MigrateCommon *args)
 
 static void test_multifd_tcp_zero_page_legacy(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_zero_page_legacy;
     /*
      * Multifd is more complicated than most of the features, it
@@ -499,6 +501,7 @@ static void test_multifd_tcp_zero_page_legacy(char *name, MigrateCommon *args)
      */
     args->live = true;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     test_precopy_common(args);
@@ -506,7 +509,6 @@ static void test_multifd_tcp_zero_page_legacy(char *name, MigrateCommon *args)
 
 static void test_multifd_tcp_no_zero_page(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_no_zero_page;
     /*
      * Multifd is more complicated than most of the features, it
@@ -515,6 +517,7 @@ static void test_multifd_tcp_no_zero_page(char *name, MigrateCommon *args)
      */
     args->live = true;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     test_precopy_common(args);
@@ -522,15 +525,15 @@ static void test_multifd_tcp_no_zero_page(char *name, MigrateCommon *args)
 
 static void test_multifd_tcp_channels_none(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd;
     args->live = true;
     args->connect_channels = ("[ { 'channel-type': 'main',"
-                             "    'addr': { 'transport': 'socket',"
-                             "              'type': 'inet',"
-                             "              'host': '127.0.0.1',"
+                              "    'addr': { 'transport': 'socket',"
+                              "              'type': 'inet',"
+                              "              'host': '127.0.0.1',"
                               "              'port': '0' } } ]");
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     test_precopy_common(args);
@@ -552,6 +555,7 @@ static void test_multifd_tcp_cancel(MigrateCommon *args, bool postcopy_ram)
     QTestState *from, *to, *to2;
 
     args->start.hide_stderr = true;
+    args->start.incoming_defer = true;
 
     if (migrate_start(&from, &to, "defer", &args->start)) {
         return;
@@ -599,6 +603,9 @@ static void test_multifd_tcp_cancel(MigrateCommon *args, bool postcopy_ram)
     wait_for_migration_status(from, "cancelled", NULL);
 
     args->start.only_target = true;
+    args->start.incoming_defer = true;
+
+    /* reusing the same config for to2 */
 
     if (migrate_start(&from, &to2, "defer", &args->start)) {
         return;
@@ -773,6 +780,7 @@ static void test_cancel_src_after_status(char *test_path, MigrateCommon *args)
     QTestState *from, *to;
 
     args->start.hide_stderr = true;
+    args->start.incoming_defer = true;
 
     if (migrate_start(&from, &to, "defer", &args->start)) {
         return;
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 6a20c65104..166f27f478 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -675,10 +675,10 @@ migrate_hook_start_multifd_tls_x509_reject_anon_client(QTestState *from,
 
 static void test_multifd_tcp_tls_psk_match(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     test_precopy_common(args);
@@ -686,12 +686,12 @@ static void test_multifd_tcp_tls_psk_match(char *name, MigrateCommon *args)
 
 static void test_multifd_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_mismatch;
     args->end_hook = migrate_hook_end_tls_psk;
     args->result = MIG_TEST_FAIL;
 
     args->start.hide_stderr = true;
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     test_precopy_common(args);
@@ -700,10 +700,10 @@ static void test_multifd_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
 static void test_multifd_postcopy_tcp_tls_psk_match(char *name,
                                                     MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
     args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true;
 
@@ -714,10 +714,10 @@ static void test_multifd_postcopy_tcp_tls_psk_match(char *name,
 static void test_multifd_tcp_tls_x509_default_host(char *name,
                                                    MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tls_x509_default_host;
     args->end_hook = migrate_hook_end_tls_x509;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     test_precopy_common(args);
@@ -726,10 +726,10 @@ static void test_multifd_tcp_tls_x509_default_host(char *name,
 static void test_multifd_tcp_tls_x509_override_host(char *name,
                                                     MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tls_x509_override_host;
     args->end_hook = migrate_hook_end_tls_x509;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     test_precopy_common(args);
@@ -751,11 +751,11 @@ static void test_multifd_tcp_tls_x509_mismatch_host(char *name,
      * to load migration state, and thus just aborts the migration
      * without exiting.
      */
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tls_x509_mismatch_host;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
 
+    args->start.incoming_defer = true;
     args->start.hide_stderr = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
@@ -765,10 +765,10 @@ static void test_multifd_tcp_tls_x509_mismatch_host(char *name,
 static void test_multifd_tcp_tls_x509_allow_anon_client(char *name,
                                                         MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tls_x509_allow_anon_client;
     args->end_hook = migrate_hook_end_tls_x509;
 
+    args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     test_precopy_common(args);
@@ -777,11 +777,11 @@ static void test_multifd_tcp_tls_x509_allow_anon_client(char *name,
 static void test_multifd_tcp_tls_x509_reject_anon_client(char *name,
                                                          MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tls_x509_reject_anon_client;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
 
+    args->start.incoming_defer = true;
     args->start.hide_stderr = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
-- 
2.51.0


