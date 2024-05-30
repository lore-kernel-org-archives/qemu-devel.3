Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020DCC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 09:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCcUN-00070l-Tn; Thu, 30 May 2024 05:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sCcUL-000704-Rl
 for qemu-devel@nongnu.org; Thu, 30 May 2024 05:54:25 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sCcUJ-00026Q-IV
 for qemu-devel@nongnu.org; Thu, 30 May 2024 05:54:25 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-6c104f64ff6so218161a12.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 02:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717062862; x=1717667662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7OY+Yb66xH2ve4EOh/kSWfFWLssdw6ThCr38/yoK6pI=;
 b=TuIgLXAg2iAcwZrMI/B7S0WRFDOwAyghYDMyJd0dlzkF8l8RtM+C752X4Aw3J8So5y
 SCf0vJtLqFb9DFWvdInWnH0+D/eqaB6abKTU/AluqSTuljF2xEwO4jKOf4i4UfIVUtt+
 AIvh4Tv9lsKsV4fJk5PTpVmbt0T47IYjKzg/KPTRD4J3xd1iW4Ap+lcn0mRp+RyZj+tn
 s0ba6ZZjVV4QHCuDL1Ur2uV5zuLyUZho0F3ZgUruEobDQ/l4At+7RE040xxci95k9xYn
 M+9N8jtXmQFaUJQ828drRlT3LGOtPLQxhS4ZSFkKJ/4bzBruRXF9Z//SGqZI61Gvu3PD
 Pqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717062862; x=1717667662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7OY+Yb66xH2ve4EOh/kSWfFWLssdw6ThCr38/yoK6pI=;
 b=wlA2n3b9zGdYCuHjdC7K14n4WfSfDXf0a+2A8zAE5fJlmNY2gAetY6w5+ZUX8eNC5v
 HxsRrSbHsGnt3WpXWNva6rZ/6dwtiIwcS1uGsHX99bLjD113UBXz+1lCprhm8HPYbV4+
 T7/+haOYd+f/EeHu1uXzrZdIKa8LbzUhPdZWVHKWRtZ3RxfbmoU6fh2OX/U3lsJf2II3
 cBtqb706jm1enmtUD0q8kHqb5JMxLTNXQQEtng317/Dep12tpRXtiUZ0UVwkVFMyDXS3
 dK0Loq/9tWcSEfdXjHzIXVdaClxTyNmN736T05j6p5Bp2td5Xk+/jhXlIPhjyi0ts/sR
 2fDQ==
X-Gm-Message-State: AOJu0Yyv6pLZj3KEbPI/VgXcTjyOuhJP9YMoJMdXI8REXezVY1r6Ku+J
 JlxmfOTdtWhBHS8AB6kEkMuizacrFBXZHdLWpbX/WwivFtmsK7mHzekcN9Uu
X-Google-Smtp-Source: AGHT+IFb8Oi6i9H0gmUifZb4BGlKK57TqfSUWvOHImiNUBpsrMEcHrrNoGVfA2rMPwUztr8Z9rNzoA==
X-Received: by 2002:a17:90b:60e:b0:2bd:dce4:8f90 with SMTP id
 98e67ed59e1d1-2c1abc064f1mr1627738a91.6.1717062861513; 
 Thu, 30 May 2024 02:54:21 -0700 (PDT)
Received: from wheely.local0.net ([1.146.0.82])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775d28asm1183626a91.8.2024.05.30.02.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 02:54:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 1/4] tests/qtest/migration-test: Use regular file file for
 shared-memory tests
Date: Thu, 30 May 2024 19:54:04 +1000
Message-ID: <20240530095408.31608-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240530095408.31608-1-npiggin@gmail.com>
References: <20240530095408.31608-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

There is no need to use /dev/shm for file-backed memory devices, and
on Gitlab CI the tmpfs mount is too small to be usable for migration
tests. Switch to using a regular file in /tmp/ which will usually have
more space available.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/migration-test.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index d6f5ceed80..8bbf45313d 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -552,7 +552,7 @@ typedef struct {
      * unconditionally, because it means the user would like to be verbose.
      */
     bool hide_stderr;
-    bool use_shmem;
+    bool use_memfile;
     /* only launch the target process */
     bool only_target;
     /* Use dirty ring if true; dirty logging otherwise */
@@ -672,21 +672,14 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     g_autofree gchar *cmd_source = NULL;
     g_autofree gchar *cmd_target = NULL;
     const gchar *ignore_stderr;
-    g_autofree char *shmem_opts = NULL;
-    g_autofree char *shmem_path = NULL;
+    g_autofree char *memfile_opts = NULL;
+    g_autofree char *memfile_path = NULL;
     const char *kvm_opts = NULL;
     const char *arch = qtest_get_arch();
     const char *memory_size;
     const char *machine_alias, *machine_opts = "";
     g_autofree char *machine = NULL;
 
-    if (args->use_shmem) {
-        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
-            g_test_skip("/dev/shm is not supported");
-            return -1;
-        }
-    }
-
     dst_state = (QTestMigrationState) { };
     src_state = (QTestMigrationState) { };
     bootfile_create(tmpfs, args->suspend_me);
@@ -746,12 +739,12 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         ignore_stderr = "";
     }
 
-    if (args->use_shmem) {
-        shmem_path = g_strdup_printf("/dev/shm/qemu-%d", getpid());
-        shmem_opts = g_strdup_printf(
+    if (args->use_memfile) {
+        memfile_path = g_strdup_printf("/%s/qemu-%d", tmpfs, getpid());
+        memfile_opts = g_strdup_printf(
             "-object memory-backend-file,id=mem0,size=%s"
             ",mem-path=%s,share=on -numa node,memdev=mem0",
-            memory_size, shmem_path);
+            memory_size, memfile_path);
     }
 
     if (args->use_dirty_ring) {
@@ -780,7 +773,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  memory_size, tmpfs,
                                  arch_opts ? arch_opts : "",
                                  arch_source ? arch_source : "",
-                                 shmem_opts ? shmem_opts : "",
+                                 memfile_opts ? memfile_opts : "",
                                  args->opts_source ? args->opts_source : "",
                                  ignore_stderr);
     if (!args->only_target) {
@@ -802,7 +795,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  memory_size, tmpfs, uri,
                                  arch_opts ? arch_opts : "",
                                  arch_target ? arch_target : "",
-                                 shmem_opts ? shmem_opts : "",
+                                 memfile_opts ? memfile_opts : "",
                                  args->opts_target ? args->opts_target : "",
                                  ignore_stderr);
     *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target);
@@ -814,8 +807,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
      * Remove shmem file immediately to avoid memory leak in test failed case.
      * It's valid because QEMU has already opened this file
      */
-    if (args->use_shmem) {
-        unlink(shmem_path);
+    if (args->use_memfile) {
+        unlink(memfile_path);
     }
 
     return 0;
@@ -1868,6 +1861,9 @@ static void test_ignore_shared(void)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
+    MigrateStart args = {
+        .use_memfile = true,
+    };
 
     if (test_migrate_start(&from, &to, uri, false, true, NULL, NULL)) {
         return;
@@ -2024,7 +2020,7 @@ static void test_mode_reboot(void)
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
     MigrateCommon args = {
-        .start.use_shmem = true,
+        .start.use_memfile = true,
         .connect_uri = uri,
         .listen_uri = "defer",
         .start_hook = test_mode_reboot_start
-- 
2.43.0


