Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C927CD5BAC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoZC-00024M-TT; Wed, 20 May 2026 17:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoZA-0001xl-Jq
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:35:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoZ7-0007MW-PG
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F4Y0YhlKsEiszYujT2R1TdtLVmmENx/5453jVasI138=;
 b=OKXRkV+Q/7t4V9xh0anGLx7C7jUqZ8b8vyuTFBhu9m8MCWpM463Thgcl6y2xR5X7nJvQ5u
 6n9sN+z+nnpA17ZrW51e0xESOLwEfijicP8PT6pWLOG7tfxUUo7hQN/I9GetyWCcJvq0aI
 sQVQiZork1lFjq6frKztt+IyfNLVxso=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-7ohsX0x6NJWLBHsxZFZ3Mg-1; Wed, 20 May 2026 17:34:55 -0400
X-MC-Unique: 7ohsX0x6NJWLBHsxZFZ3Mg-1
X-Mimecast-MFC-AGG-ID: 7ohsX0x6NJWLBHsxZFZ3Mg_1779312895
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8aca14d1faaso195805956d6.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312895; x=1779917695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F4Y0YhlKsEiszYujT2R1TdtLVmmENx/5453jVasI138=;
 b=XR/gIjqLn/n/aeriEk4aKVxLK+Aep5JXe1Oph04X2osL5jwIMRm8eOnQaX+3GhQ1UX
 OVyLQB78yNZfLQ3QARPKknY1Tmft+twXuLqyIPB2ToHYtixTVsG0qzYerdKxS8bvK3An
 OeVOrLSZIT29xDdP8lo9c8WitHUlHVeuAfCXJzfVobixfdFRKISAskv4E2s2ZuZvgPA1
 53Wm+UNEByvcl63QSToC9VUSqVfcIcJGqHzKfmxEqc+T4S7o3hJkH/3gMFSSGwSnULhF
 Bnxryu3C9iSOjsatOS5WO/SOh3ON9wQeUNwwzMpzWvoG/uNUK6TkttB+ZwnKPTKKa2gf
 CAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312895; x=1779917695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F4Y0YhlKsEiszYujT2R1TdtLVmmENx/5453jVasI138=;
 b=skV1mQqa4FzJv1gZQZoA1I1a06ns7WbEZPrTomO2sKayeBcRLw5bhtQS9nQeQKquDr
 SyP6GmAPeAxtKh2BdOJF2bjxV9/tGlhom6o+jTHTrnGpR1kQjTut0kmbhk1/RVfChX2y
 64XrY/lICNj89iB5v3n3mgG8jj0nDTHvpZQXshhM9PMljF8H+1Dw8mcbuERopQeu4iMZ
 H7uhTgpHZIEWuvwWsazcAjMwp2cGBk0oc1pUte592Z4PT2xdtpshjOffICxt8hxs2vkr
 8l2/vOIUFXMmSldXAI9XrP2A8vs9pCzGorDyAYaaOHiw/yWNc2SIINu3T7fO+Q0I55Tf
 QGNg==
X-Gm-Message-State: AOJu0YyNwcrbmAu5NtDRxLluRM9qHXNprMIuijK/TqH7UGKMvDq8JG82
 +3k7M6b1ORd5p6u/90ljT179UcUF2sbMclIhEIEvRJI/DndCULXkxpollcdlrqo3AAKXh/oCM5e
 O6fc9hAn44yhWbp8JSvXjx2jjeJHhQy91KJEO5xlDA59TWiLLGyaIH0mnxTw6EVLk0DvH0ah8nt
 p344nyK0klPkiRcaP2hrgiUF0lGRp/k2uvjhXx4A==
X-Gm-Gg: Acq92OElx9NeRIaCw9DRSgdIE2xI7sq9Fb3P+pCQkmNSxVFu54S1NAKJk1VeS7yTfcw
 xTyvogzuWluCHpQusvgtsfBtvLobE4qc3D2HCqXdts6A3hp3gDsSnDCgNubz6YPDuCjsgmzNC/v
 tvRTYTj1XaQG21p6Mb4oJTv7/3GKaq3qIW4jtXnbAp1U5D4mX3moIbOWl+ZKvATqIsNmr4B/kXV
 DCVi1i7LIDXqoT35u2LzIlyJuGoGMV06+P8UUVhDZCQp/k+rTz4F68+E/qNJ+hmnHmQXnI633S4
 HXCjl4XbFN14seCUMHlsMxZJvH1LBWxYLXhFuZF+Kq62JgS7wWtecTZXtdBwsrVyJXnd8TxQlUO
 Ox9bNKq7cFEVcKzin30QgUmpOmrX7c7+C0lz/SjrODKoq
X-Received: by 2002:a05:6214:5c46:b0:89c:8a0f:55a0 with SMTP id
 6a1803df08f44-8cc6e3377e4mr4353486d6.16.1779312894674; 
 Wed, 20 May 2026 14:34:54 -0700 (PDT)
X-Received: by 2002:a05:6214:5c46:b0:89c:8a0f:55a0 with SMTP id
 6a1803df08f44-8cc6e3377e4mr4352886d6.16.1779312894010; 
 Wed, 20 May 2026 14:34:54 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:34:51 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 21/29] tests/qtest/migration: Unify URIs
Date: Wed, 20 May 2026 17:33:49 -0400
Message-ID: <20260520213357.40646-22-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520213357.40646-1-peterx@redhat.com>
References: <20260520213357.40646-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

The migration tests have always used localhost migration and therefore
the same URI for both sides of migration. Change the listen_uri and
connect_uri into a single uri variable.

For migrations using sockets, there's the possibility of detecting the
socket address the destination side is using. For those, keep using
different variables for migrate_qmp and migrate_incoming_qmp.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20260505160915.25558-16-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/framework.h     | 14 ++++++-------
 tests/qtest/migration/colo-tests.c    |  8 ++++----
 tests/qtest/migration/cpr-tests.c     |  6 +++---
 tests/qtest/migration/file-tests.c    | 10 ++++-----
 tests/qtest/migration/framework.c     | 29 ++++++++++-----------------
 tests/qtest/migration/misc-tests.c    |  4 ++--
 tests/qtest/migration/precopy-tests.c | 17 ++++++++--------
 tests/qtest/migration/tls-tests.c     |  2 +-
 8 files changed, 40 insertions(+), 50 deletions(-)

diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index d7e5db2cfe..941cbd7102 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -163,16 +163,14 @@ typedef struct {
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
index b92e6b7df1..a9b58d03aa 100644
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
index 3161e5f247..a23d51126b 100644
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
 
@@ -970,7 +970,7 @@ static void test_dirty_limit(char *name, MigrateCommon *args)
     args->start.hide_stderr = true;
     args->start.use_dirty_ring = true;
 
-    args->connect_uri = uri;
+    args->uri = uri;
 
     /* Start src, dst vm */
     if (migrate_start(&from, &to, &args->start)) {
@@ -981,8 +981,8 @@ static void test_dirty_limit(char *name, MigrateCommon *args)
     migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
 
     /* Start migrate */
-    migrate_incoming_qmp(to, args->connect_uri, NULL, "{}");
-    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
+    migrate_incoming_qmp(to, args->uri, NULL, "{}");
+    migrate_qmp(from, to, args->uri, NULL, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
@@ -1014,8 +1014,7 @@ static void test_dirty_limit(char *name, MigrateCommon *args)
     /* Assert dirty limit is not in service */
     g_assert_cmpint(throttle_us_per_full, ==, 0);
 
-    args->listen_uri = uri;
-    args->connect_uri = uri;
+    args->uri = uri;
 
     args->start.only_target = true;
     args->start.use_dirty_ring = true;
@@ -1026,8 +1025,8 @@ static void test_dirty_limit(char *name, MigrateCommon *args)
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
2.53.0


