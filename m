Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D7CCFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcjp-0000eW-3s; Fri, 21 Nov 2025 20:48:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vMbTT-0006eP-PH
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:27:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vMbTJ-0003fM-Fc
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763771229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P1sVJQwbcNqFr0LfI7lXuG6bpSPUSfPuzbZGwxc62oc=;
 b=JzIOQcpuXugHwPbE6s4hJNee0J7I6OncCmVUPHeeCBm2BM5IW1Fjfa9KDY9RucxdQZhYHP
 L4zR+EpEInDCsZb1CZT//Pe6uvNMUCq/0i4Qd93F2naGUgRv4nm59NEYucipLSxmkJuFOl
 ILs0oG95gNX2tSS2lKGPKluULEn90y4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-TLLfEmZ-NEeEGFEs4H-GcQ-1; Fri, 21 Nov 2025 19:27:07 -0500
X-MC-Unique: TLLfEmZ-NEeEGFEs4H-GcQ-1
X-Mimecast-MFC-AGG-ID: TLLfEmZ-NEeEGFEs4H-GcQ_1763771227
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-882381f2092so101680986d6.1
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 16:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763771227; x=1764376027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P1sVJQwbcNqFr0LfI7lXuG6bpSPUSfPuzbZGwxc62oc=;
 b=jCw/qqoFSbhgaFElyJq6fuH+RBDr82AVdX3bYtlCmm+91HLMlArEECn8sPo8QhhSEZ
 3JH0wMuOvmCZ4X0+j/ZFue0o9L1XTldOqbetUDr75EYQXnrpvAPe3TtovBEet711aqzC
 LNx62Mfb17fcMZLn0x1MjnAoBD9f0/rMYf+9n1l6JLms4RExT5DUhPYYDRddZD49Wr7t
 klb11iah6oXWo5rljjVyML7nWUaZlnJNi3wnhEiy1Q8+IVzcdwdqFmhfOv/X08z6dAF1
 XxuDMW8ZKQRCqMBg/Ebs7iPtoT3+PxLcLkGGiB9MeMR8msrNRUW2sDLSGxsn7dDXTgsI
 YNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763771227; x=1764376027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P1sVJQwbcNqFr0LfI7lXuG6bpSPUSfPuzbZGwxc62oc=;
 b=wRFeg7hO6t0o/GeZfJYdnWfYUN9AgpplCG98JoJScnavJjC9/owbIxf5izNre/Hhbo
 atVNlIImJAyc0R6dwF4n/eLa+D1zsYdwk8vndQdBCrOhlcCwauX9wKXLp+XyS0st3bmj
 qFqROabPj4sP00O2Htey6jQsMrjj/DU8KXEegpdahYfmE6hl3Dz0SQDHax18PcaoEyn6
 WhsMXE349vRdZQfI2krKl7kqyJIX/lt0Oh3WkwrQNmvhRYRVxxLpSWt/a6ZO7uqwtAqe
 P05UHqGBApV5vA2oZwWk4ZMQFfzXlmAND3bSs9RDSVshYgXZwLHwDo6Z6l7fub0quAgh
 dqEA==
X-Gm-Message-State: AOJu0YwtjEYXEClBCKhFAtgVMrQFn+TvsXSz9KjpULkitX8SPLGHozvK
 prBjK90+owUb2wZ7HfG6AMjurJgY/JS7pDP0i/Cvr80gbC+YkCyqXjp6p8EogMc/IwgUW6pYqp0
 wdArwsQUyZmv1BKwfedjyBLma3/Coy/GFSMNr07X4J+AIeL/ru6MTm+OAF432E0eZazPtupD7xS
 NxIIBE9bYrTq6xSxE6M+IXxKzOgfwk0lC96/jSLQ==
X-Gm-Gg: ASbGnctWiEYIljO9ej4ickS761R1UBJvD3UtKGmAbNMJNjIwetiB5J9FYsE3sENiggH
 bnvcYfssuW1wKFwwaC68Wd5tQZcJSq0Ao3ADxPJyqLSX9Ln/GM8ZsRUxmqSCZmqwET6z+xiHcbv
 oVpMBsquepyof30IBMmAonxB7Uj+GgEBjF5TGb41ZP64sxgNoZtRmcel6F4YhHaaUIC47R+FQQ5
 4o5J80hjL3OKxI4PDtoqTZ+o4Gcquv9D0bH7V+26AiFLNT5lk9647ROpkGhQE1WUxBXBGDGi0WV
 4LHo+VcY71VrIp866eSvm8py3LHF8Sn09yu2LnMF9ZiSCssNWWZKtAn1NJzBa2twKPa9gyDv3VU
 5
X-Received: by 2002:a05:622a:1a20:b0:4ed:1948:a8af with SMTP id
 d75a77b69052e-4ee58a784e0mr53056701cf.36.1763771227090; 
 Fri, 21 Nov 2025 16:27:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5LYgqKjf1YfaOBt0DyDdbVf1JsO6Arl+DEvvcJN+01/xffZEH3hC74b1ysHLDbdErTseJYw==
X-Received: by 2002:a05:622a:1a20:b0:4ed:1948:a8af with SMTP id
 d75a77b69052e-4ee58a784e0mr53056391cf.36.1763771226586; 
 Fri, 21 Nov 2025 16:27:06 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee48e8df63sm43870291cf.30.2025.11.21.16.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 16:27:05 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 6/9] tests/migration-test: Introduce MemType
Date: Fri, 21 Nov 2025 19:26:52 -0500
Message-ID: <20251122002656.687350-7-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251122002656.687350-1-peterx@redhat.com>
References: <20251122002656.687350-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20251117223908.415965-2-peterx@redhat.com
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


