Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B88CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 16:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKIMs-0000mA-MT; Tue, 05 May 2026 12:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKIMb-0000M0-2A
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:11:13 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKIMY-0001HV-LM
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:11:12 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 55B4E6B76A;
 Tue,  5 May 2026 16:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777997388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YKg8mJ+rvLFsh+SlfVpKhwypU3tAlhSOY0TiXz/7ey0=;
 b=MXHrq+attL5hcOtlIYz85n/hZSuG+5WLoGPTn8x48S7iOTAbJ/XA44nNBytI4SC6Xi2dme
 JChd4Uxjfmz/Z0DCEOfAEkaNpjJYjw6UtJwf10Wt1JyV8Q8AnCKtXv19KVFUC/Gz3WOjMA
 qoqrmLJWPjk4FwHAnYJMLLTYJ7+Q4e4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777997388;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YKg8mJ+rvLFsh+SlfVpKhwypU3tAlhSOY0TiXz/7ey0=;
 b=21+4hvD00TJUvi+JrH8e5ArDzslszqpdT4nFRs3wX0aaPu86IHrh1U5nP6r5if9yXayHJn
 W45YsomK/BKqEUAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777997388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YKg8mJ+rvLFsh+SlfVpKhwypU3tAlhSOY0TiXz/7ey0=;
 b=MXHrq+attL5hcOtlIYz85n/hZSuG+5WLoGPTn8x48S7iOTAbJ/XA44nNBytI4SC6Xi2dme
 JChd4Uxjfmz/Z0DCEOfAEkaNpjJYjw6UtJwf10Wt1JyV8Q8AnCKtXv19KVFUC/Gz3WOjMA
 qoqrmLJWPjk4FwHAnYJMLLTYJ7+Q4e4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777997388;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YKg8mJ+rvLFsh+SlfVpKhwypU3tAlhSOY0TiXz/7ey0=;
 b=21+4hvD00TJUvi+JrH8e5ArDzslszqpdT4nFRs3wX0aaPu86IHrh1U5nP6r5if9yXayHJn
 W45YsomK/BKqEUAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AA71593A3;
 Tue,  5 May 2026 16:09:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yMSZGkoW+mmNcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 May 2026 16:09:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>
Subject: [PATCH v1 15/15] tests/qtest/migration: Unify URIs
Date: Tue,  5 May 2026 13:09:14 -0300
Message-ID: <20260505160915.25558-16-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505160915.25558-1-farosas@suse.de>
References: <20260505160915.25558-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[redhat.com,web.de,oracle.com,akamai.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 FREEMAIL_ENVRCPT(0.00)[web.de]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

The migration tests have always used localhost migration and therefore
the same URI for both sides of migration. Change the listen_uri and
connect_uri into a single uri variable.

For migrations using sockets, there's the possibility of detecting the
socket address the destination side is using. For those, keep using
different variables for migrate_qmp and migrate_incoming_qmp.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/colo-tests.c    |  8 ++++----
 tests/qtest/migration/cpr-tests.c     |  6 +++---
 tests/qtest/migration/file-tests.c    | 10 ++++-----
 tests/qtest/migration/framework.c     | 29 ++++++++++-----------------
 tests/qtest/migration/framework.h     | 14 ++++++-------
 tests/qtest/migration/misc-tests.c    |  4 ++--
 tests/qtest/migration/precopy-tests.c | 17 ++++++++--------
 tests/qtest/migration/tls-tests.c     |  2 +-
 8 files changed, 40 insertions(+), 50 deletions(-)

diff --git a/tests/qtest/migration/colo-tests.c b/tests/qtest/migration/colo-tests.c
index a3d27e7bf6..f7f9ba491b 100644
--- a/tests/qtest/migration/colo-tests.c
+++ b/tests/qtest/migration/colo-tests.c
@@ -55,12 +55,12 @@ static int test_colo_common(MigrateCommon *args,
         data_hook = args->start_hook(from, to);
     }
 
-    migrate_incoming_qmp(to, args->listen_uri, NULL, "{}");
+    migrate_incoming_qmp(to, args->uri, NULL, "{}");
 
     migrate_ensure_converge(from);
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
+    migrate_qmp(from, to, NULL, NULL, "{}");
 
     wait_for_migration_status(from, "colo", NULL);
     wait_for_resume(to, get_dst());
@@ -105,7 +105,7 @@ static void test_colo_plain_common(MigrateCommon *args,
                                    bool failover_during_checkpoint,
                                    bool primary_failover)
 {
-    args->listen_uri = "tcp:127.0.0.1:0";
+    args->uri = "tcp:127.0.0.1:0";
     test_colo_common(args, failover_during_checkpoint, primary_failover);
 }
 
@@ -113,7 +113,7 @@ static void test_colo_multifd_common(MigrateCommon *args,
                                      bool failover_during_checkpoint,
                                      bool primary_failover)
 {
-    args->listen_uri = "tcp:127.0.0.1:0";
+    args->uri = "tcp:127.0.0.1:0";
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
     test_colo_common(args, failover_during_checkpoint, primary_failover);
 }
diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index fc09dad9c0..0bec753b4a 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -35,7 +35,7 @@ static void test_mode_reboot(char *name, MigrateCommon *args)
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
 
-    args->connect_uri = uri;
+    args->uri = uri;
     args->start_hook = migrate_hook_start_mode_reboot;
 
     args->start.mem_type = MEM_TYPE_SHMEM;
@@ -226,7 +226,7 @@ static void test_cpr_exec(MigrateCommon *args)
 {
     QTestState *from, *to;
     void *data_hook = NULL;
-    g_autofree char *connect_uri = g_strdup(args->connect_uri);
+    g_autofree char *connect_uri = g_strdup(args->uri);
     g_autofree char *filename = g_strdup_printf("%s/%s", tmpfs,
                                                 FILE_TEST_FILENAME);
 
@@ -280,7 +280,7 @@ static void test_mode_exec(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
-    args->connect_uri = uri;
+    args->uri = uri;
     args->start_hook = test_mode_exec_start;
 
     args->start.only_source = true;
diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
index 36109d30ba..5118d9dec9 100644
--- a/tests/qtest/migration/file-tests.c
+++ b/tests/qtest/migration/file-tests.c
@@ -107,7 +107,7 @@ static void test_precopy_file_offset_fdset(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=%d",
                                            FILE_TEST_OFFSET);
-    args->connect_uri = uri;
+    args->uri = uri;
     args->start_hook = migrate_hook_start_file_offset_fdset;
 
     test_file_common(args, false);
@@ -120,7 +120,7 @@ static void test_precopy_file_offset(char *name, MigrateCommon *args)
                                            FILE_TEST_FILENAME,
                                            FILE_TEST_OFFSET);
 
-    args->connect_uri = uri;
+    args->uri = uri;
     test_file_common(args, false);
 }
 
@@ -130,7 +130,7 @@ static void test_precopy_file_offset_bad(char *name, MigrateCommon *args)
     g_autofree char *uri = g_strdup_printf("file:%s/%s,offset=0x20M",
                                            tmpfs, FILE_TEST_FILENAME);
 
-    args->connect_uri = uri;
+    args->uri = uri;
     args->result = MIG_TEST_QMP_ERROR;
 
     test_file_common(args, false);
@@ -247,7 +247,7 @@ static void test_multifd_file_mapped_ram_fdset(char *name, MigrateCommon *args)
     g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=%d",
                                            FILE_TEST_OFFSET);
 
-    args->connect_uri = uri;
+    args->uri = uri;
     args->start_hook = migrate_hook_start_multifd_mapped_ram_fdset;
     args->end_hook = migrate_hook_end_multifd_mapped_ram_fdset;
 
@@ -262,7 +262,7 @@ static void test_multifd_file_mapped_ram_fdset_dio(char *name,
 {
     g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=%d",
                                            FILE_TEST_OFFSET);
-    args->connect_uri = uri;
+    args->uri = uri;
     args->start_hook = migrate_hook_start_multifd_mapped_ram_fdset_dio;
     args->end_hook = migrate_hook_end_multifd_mapped_ram_fdset;
 
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 2acbe709b7..17bcd28c66 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -832,14 +832,7 @@ int test_precopy_common(MigrateCommon *args)
     QTestState *from, *to;
     void *data_hook = NULL;
     QObject *channels = NULL;
-
-    assert(!args->connect_uri);
-
-    if (args->listen_uri) {
-        args->connect_uri = args->listen_uri;
-    } else {
-        args->listen_uri = "tcp:127.0.0.1:0";
-    }
+    const char *listen_uri = args->uri ?: "tcp:127.0.0.1:0";
 
     if (migrate_start(&from, &to, &args->start)) {
         return -1;
@@ -849,7 +842,7 @@ int test_precopy_common(MigrateCommon *args)
         data_hook = args->start_hook(from, to);
     }
 
-    migrate_incoming_qmp(to, args->listen_uri, NULL, "{}");
+    migrate_incoming_qmp(to, listen_uri, NULL, "{}");
 
     /* Wait for the first serial output from the source */
     if (args->result == MIG_TEST_SUCCEED) {
@@ -879,11 +872,11 @@ int test_precopy_common(MigrateCommon *args)
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, args->connect_uri, channels, "{}");
+        migrate_qmp_fail(from, args->uri, channels, "{}");
         goto finish;
     }
 
-    migrate_qmp(from, to, args->connect_uri, channels, "{}");
+    migrate_qmp(from, to, args->uri, channels, "{}");
 
     if (args->result != MIG_TEST_SUCCEED) {
         bool allow_active = args->result == MIG_TEST_FAIL;
@@ -947,7 +940,7 @@ void test_precopy_unix_common(MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
 
-    args->listen_uri = uri;
+    args->uri = uri;
     test_precopy_common(args);
 }
 
@@ -994,9 +987,9 @@ void test_file_common(MigrateCommon *args, bool stop_src)
         return;
     }
 
-    if (!args->connect_uri) {
+    if (!args->uri) {
         uri = g_strdup_printf("file:%s/%s", tmpfs, FILE_TEST_FILENAME);
-        args->connect_uri = uri;
+        args->uri = uri;
     }
 
     /*
@@ -1006,7 +999,7 @@ void test_file_common(MigrateCommon *args, bool stop_src)
      */
     g_assert_false(args->live);
 
-    if (g_strrstr(args->connect_uri, "offset=")) {
+    if (g_strrstr(args->uri, "offset=")) {
         check_offset = true;
         /*
          * This comes before the start_hook because it's equivalent to
@@ -1029,18 +1022,18 @@ void test_file_common(MigrateCommon *args, bool stop_src)
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, args->connect_uri, NULL, "{}");
+        migrate_qmp_fail(from, args->uri, NULL, "{}");
         goto finish;
     }
 
-    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
+    migrate_qmp(from, to, args->uri, NULL, "{}");
     wait_for_migration_complete(from);
 
     /*
      * We need to wait for the source to finish before starting the
      * destination.
      */
-    migrate_incoming_qmp(to, args->connect_uri, NULL, "{}");
+    migrate_incoming_qmp(to, args->uri, NULL, "{}");
     wait_for_migration_complete(to);
 
     if (stop_src) {
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 65d3912fda..eceb40abbf 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -162,16 +162,14 @@ typedef struct {
     /* Optional: fine tune start parameters */
     MigrateStart start;
 
-    /* Required: the URI for the dst QEMU to listen on */
-    const char *listen_uri;
-
     /*
-     * Optional: the URI for the src QEMU to connect to
-     * If NULL, then it will query the dst QEMU for its actual
-     * listening address and use that as the connect address.
-     * This allows for dynamically picking a free TCP port.
+     * Optional: the migration URI. If NULL, the common code should
+     * provide a default. For socket migration, the source QEMU may
+     * query the dst QEMU for the listening address and use that as
+     * the connection address. This allows for dynamically picking a
+     * free TCP port.
      */
-    const char *connect_uri;
+    const char *uri;
 
     /*
      * Optional: JSON-formatted list of src QEMU URIs. If a port is
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index e5d5fc4959..ec6d438cdc 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -196,7 +196,7 @@ static void do_test_validate_uri_channel(MigrateCommon *args)
     channels = args->connect_channels ?
                qobject_from_json(args->connect_channels, &error_abort) :
                NULL;
-    migrate_qmp_fail(from, args->connect_uri, channels, "{}");
+    migrate_qmp_fail(from, args->uri, channels, "{}");
 
     migrate_end(from, to, false);
 }
@@ -252,7 +252,7 @@ static void test_validate_caps_pair(char *test_path, MigrateCommon *args)
 
 static void test_validate_uri_channels_both_set(char *name, MigrateCommon *args)
 {
-    args->connect_uri = "tcp:127.0.0.1:0",
+    args->uri = "tcp:127.0.0.1:0",
     args->connect_channels = ("[ { ""'channel-type': 'main',"
                               "    'addr': { 'transport': 'socket',"
                               "              'type': 'inet',"
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index a9381fa3bf..55ad77ef0d 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -161,7 +161,7 @@ static void __test_precopy_rdma_plain(MigrateCommon *args, bool ipv6)
      **/
     g_autofree char *uri = g_strdup_printf("rdma:%s:29200", buffer);
 
-    args->listen_uri = uri;
+    args->uri = uri;
 
     test_precopy_common(args);
 }
@@ -253,7 +253,7 @@ static void migrate_hook_end_fd(QTestState *from,
 
 static void test_precopy_fd_socket(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "fd:fd-mig";
+    args->uri = "fd:fd-mig";
     args->start_hook = migrate_hook_start_fd;
     args->end_hook = migrate_hook_end_fd;
 
@@ -1026,7 +1026,7 @@ static void test_dirty_limit(char *name, MigrateCommon *args)
     args->start.hide_stderr = true;
     args->start.use_dirty_ring = true;
 
-    args->connect_uri = uri;
+    args->uri = uri;
 
     /* Start src, dst vm */
     if (migrate_start(&from, &to, &args->start)) {
@@ -1037,8 +1037,8 @@ static void test_dirty_limit(char *name, MigrateCommon *args)
     migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
 
     /* Start migrate */
-    migrate_incoming_qmp(to, args->connect_uri, NULL, "{}");
-    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
+    migrate_incoming_qmp(to, args->uri, NULL, "{}");
+    migrate_qmp(from, to, args->uri, NULL, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
@@ -1070,8 +1070,7 @@ static void test_dirty_limit(char *name, MigrateCommon *args)
     /* Assert dirty limit is not in service */
     g_assert_cmpint(throttle_us_per_full, ==, 0);
 
-    args->listen_uri = uri;
-    args->connect_uri = uri;
+    args->uri = uri;
 
     args->start.only_target = true;
     args->start.use_dirty_ring = true;
@@ -1082,8 +1081,8 @@ static void test_dirty_limit(char *name, MigrateCommon *args)
     }
 
     /* Start migrate */
-    migrate_incoming_qmp(to, args->listen_uri, NULL, "{}");
-    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
+    migrate_incoming_qmp(to, args->uri, NULL, "{}");
+    migrate_qmp(from, to, args->uri, NULL, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index f45f4c4b0c..827cc7bcf8 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -436,7 +436,7 @@ static void test_precopy_unix_tls_x509_default_host(char *name,
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
 
-    args->listen_uri = uri;
+    args->uri = uri;
     args->start_hook = migrate_hook_start_tls_x509_default_host;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
-- 
2.51.0


