Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C38CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 22:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL7sq-00055p-U5; Mon, 17 Nov 2025 17:39:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vL7si-00053v-MD
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 17:39:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vL7sd-0003Vf-V2
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 17:39:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763419157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7voPtnKUi0ssosbvJJ37tKl+NUOzokq6k4Tl/nbnS9k=;
 b=Nnb0Xi44LrAxel37LyN2cY9nDsCxOs052phSBlLL0fQpDqeMfWddnSvcOJ06+Jxu5PiVs/
 iZZuRuUwBk32t9acZ9FI9NICu15c13HKfnGETUaH0IYlmgb9VMcNLex1NIrGQPXT1rkWMF
 KyojOJz+yKkWKajahBbsuzsWav9txmA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-opkEgjuONrOH79Zf9wZJ4A-1; Mon, 17 Nov 2025 17:39:16 -0500
X-MC-Unique: opkEgjuONrOH79Zf9wZJ4A-1
X-Mimecast-MFC-AGG-ID: opkEgjuONrOH79Zf9wZJ4A_1763419156
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b2657cfcdaso612080185a.3
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 14:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763419155; x=1764023955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7voPtnKUi0ssosbvJJ37tKl+NUOzokq6k4Tl/nbnS9k=;
 b=ZlflN0mtrFDtaRS358iBCw8EKdyY45s+8VZbu79PsIZZjYWLoIxUm8r9S8vPkDfPU3
 YTrWw+1URWYi9HCbGPQb4cbuuIL/AbFBEtETwoxwZVjAcpGXXHDzbXlVrHjuGrXqCWKP
 kJZcJjwz7wNF/F2Y5XoooTInfwAlTZyZvOGUY78VbKTR+u9FMx/rn1pOfXwv0UOcwTGG
 d7KAfkzw1gK6zzxj43v9j5uthuou3riv3y22epfjRO/geUAh/rUwalyS5WpxoSrxH1id
 aDHP2Hah3FHWT2Tn7o5Xyeqfp8HBkBzbu2/WkPM7RswnI47Nik3iOx9j1ZQ46prDA4PH
 f7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763419155; x=1764023955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7voPtnKUi0ssosbvJJ37tKl+NUOzokq6k4Tl/nbnS9k=;
 b=Q9huU5FcsZJbNUSeE1Gnjb30CQaWrlTO4lXfv3y2s3twfWjS7930/VnFLhcAsJpmwy
 bY8crPsJTEBf3w2sh8NpmEWZXFLToPkXZLHbzXZMzkhko9k8XqI5f5S4v5YP3NdckXvc
 YBYfLOxGBB0mhwzZKGPucpUyELb8qXD7fud+vremGF0oGENKtq9dhuSMrR37O0saWXfV
 GmziC4byqowObi+hTlTo1S93xkagFIEfNhxkdtB9ps/vf7S4KZCtSitndT2KJnlDLjGp
 jvnECvZ9W9qE6rHexneP1HUIKDA92g6z0fQTdx4BUmh6hZqSHvP7b5Tyg0QYybZTdcQJ
 tcHA==
X-Gm-Message-State: AOJu0YxEDlEcwVT0edV6m7zmDzdMEM2RetESuWOUlKS7hOqVhEmJKvdy
 qSiKVEpuHtfWBeg4UO8nYqOFenNTSURPqe3x1KXxpk5bnAC5IarojNf3jywRfUI2wzOM0Pr+8Y+
 F6SODw2dXUt4mYMSa/ee6BFrZqxMIWRQliR1NwZY3OE5lxQt71C4i8basGILPOWK1naini1sOrR
 ChqwbqL9S9IAJx/BMUagYxIZQvSo/0yWy50e5zDg==
X-Gm-Gg: ASbGncuinAvM48AQ2a8qx+knxuEKJwSuWmFy+Nw/Ffxj7/m4PpCe8r9vbFciCClFNJp
 pgTY6uPx/cNrNXZv6kfdPCQ37VNOBTejJBuyPGvBqcvnY6J+TQzIdEqnhumB11O7s0Tn4sqjmHN
 G1IBoHogVzgDSbdLPXeQ0BSwLxUmF5wcaGelLuL5DOD8kLMqP1oIqGtybmgJlWkM4se98j+9nga
 c1sMdvpJG6Bbu623L+mMDXtygKoi0mZdr5jmG7lXlAg4Mu2bDy31TYtj9N39hLaH0x8tdEu/TYr
 itEGIQtYCrkqmbbqLSOtnp33Pbb8PDPRBfwh2nSlmBsrpdgMqZMqIHIk3j8Rl7cE+9asRi3KIU0
 =
X-Received: by 2002:a05:620a:46a4:b0:8b2:7777:f641 with SMTP id
 af79cd13be357-8b2c31b23d4mr1641328585a.64.1763419155348; 
 Mon, 17 Nov 2025 14:39:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELIEGENZv+43LY08+51k8Pj97+jG7Ns25Zvgmk/KryWSyUy0LhWbpZ7sO6Dv4ryMxPZVRAEA==
X-Received: by 2002:a05:620a:46a4:b0:8b2:7777:f641 with SMTP id
 af79cd13be357-8b2c31b23d4mr1641324385a.64.1763419154657; 
 Mon, 17 Nov 2025 14:39:14 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee1c21ea34sm37693521cf.30.2025.11.17.14.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 14:39:14 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 1/4] tests/migration-test: Introduce MemType
Date: Mon, 17 Nov 2025 17:39:05 -0500
Message-ID: <20251117223908.415965-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251117223908.415965-1-peterx@redhat.com>
References: <20251117223908.415965-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Some migration tests need to be run with shmem, the rest by default use
anonymous memory.

Introduce MemType and replace use_shmem with such a enumeration.  This
prepares for a 3rd type of memory to be tested for migration.

Careful readers may also already notice that MigrateStart has another field
called memory_backend, which makes the whole "memory type" definition
convoluted.  That'll be merged into MemType soon in a follow up patch.

When doing this, introduce some migrate_mem_type_*() helpers to do the
work for each memory type.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/framework.h  |  8 ++-
 tests/qtest/migration/cpr-tests.c  |  2 +-
 tests/qtest/migration/framework.c  | 81 ++++++++++++++++++++++--------
 tests/qtest/migration/misc-tests.c |  2 +-
 4 files changed, 68 insertions(+), 25 deletions(-)

diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 9bb584a6bb..70705725bc 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -18,6 +18,12 @@
 #define FILE_TEST_OFFSET 0x1000
 #define FILE_TEST_MARKER 'X'
 
+typedef enum {
+    MEM_TYPE_ANON,
+    MEM_TYPE_SHMEM,
+    MEM_TYPE_NUM,
+} MemType;
+
 typedef struct MigrationTestEnv {
     bool has_kvm;
     bool has_tcg;
@@ -102,7 +108,7 @@ typedef struct {
      * unconditionally, because it means the user would like to be verbose.
      */
     bool hide_stderr;
-    bool use_shmem;
+    MemType mem_type;
     /* only launch the source process */
     bool only_source;
     /* only launch the target process */
diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 9388ad64be..70f8e69633 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -32,7 +32,7 @@ static void test_mode_reboot(void)
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
     MigrateCommon args = {
-        .start.use_shmem = true,
+        .start.mem_type = MEM_TYPE_SHMEM,
         .connect_uri = uri,
         .listen_uri = "defer",
         .start_hook = migrate_hook_start_mode_reboot,
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index a9be9c2dbf..8fa39999a1 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -260,6 +260,25 @@ static char *test_shmem_path(void)
     return g_strdup_printf("/dev/shm/qemu-%d", getpid());
 }
 
+/* NOTE: caller is responsbile to free the string if returned */
+static char *migrate_mem_type_get_opts(MemType type, const char *memory_size)
+{
+    g_autofree char *shmem_path = NULL;
+    char *backend = NULL;
+
+    switch (type) {
+    case MEM_TYPE_SHMEM:
+        shmem_path = test_shmem_path();
+        backend = g_strdup_printf(
+            "-object memory-backend-file,id=mem0,size=%s"
+            ",mem-path=%s,share=on -numa node,memdev=mem0",
+            memory_size, shmem_path);
+        return backend;
+    default:
+        return NULL;
+    }
+}
+
 int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
 {
     /* options for source and target */
@@ -268,7 +287,6 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
     gchar *cmd_target = NULL;
     const gchar *ignore_stderr;
     g_autofree char *shmem_opts = NULL;
-    g_autofree char *shmem_path = NULL;
     const char *kvm_opts = NULL;
     const char *arch = qtest_get_arch();
     const char *memory_size;
@@ -332,13 +350,7 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
         ignore_stderr = "";
     }
 
-    if (args->use_shmem) {
-        shmem_path = test_shmem_path();
-        shmem_opts = g_strdup_printf(
-            "-object memory-backend-file,id=mem0,size=%s"
-            ",mem-path=%s,share=on -numa node,memdev=mem0",
-            memory_size, shmem_path);
-    }
+    shmem_opts = migrate_mem_type_get_opts(args->mem_type, memory_size);
 
     if (args->memory_backend) {
         memory_backend = g_strdup_printf(args->memory_backend, memory_size);
@@ -403,6 +415,42 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
     return 0;
 }
 
+static bool migrate_mem_type_prepare(MemType type)
+{
+    switch (type) {
+    case MEM_TYPE_SHMEM:
+        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
+            g_test_skip("/dev/shm is not supported");
+            return false;
+        }
+        break;
+    default:
+        break;
+    }
+
+    return true;
+}
+
+static void migrate_mem_type_cleanup(MemType type)
+{
+    g_autofree char *shmem_path = NULL;
+
+    switch (type) {
+    case MEM_TYPE_SHMEM:
+
+        /*
+         * Remove shmem file immediately to avoid memory leak in test
+         * failed case.  It's valid because QEMU has already opened this
+         * file
+         */
+        shmem_path = test_shmem_path();
+        unlink(shmem_path);
+        break;
+    default:
+        break;
+    }
+}
+
 int migrate_start(QTestState **from, QTestState **to, const char *uri,
                   MigrateStart *args)
 {
@@ -410,11 +458,8 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
     g_autofree gchar *cmd_target = NULL;
     g_autoptr(QList) capabilities = migrate_start_get_qmp_capabilities(args);
 
-    if (args->use_shmem) {
-        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
-            g_test_skip("/dev/shm is not supported");
-            return -1;
-        }
+    if (!migrate_mem_type_prepare(args->mem_type)) {
+        return -1;
     }
 
     dst_state = (QTestMigrationState) { };
@@ -441,15 +486,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
                                      &dst_state);
     }
 
-    /*
-     * Remove shmem file immediately to avoid memory leak in test failed case.
-     * It's valid because QEMU has already opened this file
-     */
-    if (args->use_shmem) {
-        g_autofree char *shmem_path = test_shmem_path();
-        unlink(shmem_path);
-    }
-
+    migrate_mem_type_cleanup(args->mem_type);
     migrate_start_set_capabilities(*from,
                                    args->only_source ? NULL : *to,
                                    args);
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 54995256d8..20edaa51f5 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -97,7 +97,7 @@ static void test_ignore_shared(void)
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
     MigrateStart args = {
-        .use_shmem = true,
+        .mem_type = MEM_TYPE_SHMEM,
         .caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true,
     };
 
-- 
2.50.1


