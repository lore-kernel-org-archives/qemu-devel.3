Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3E8C25B7E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 09:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCcUa-00075Q-M3; Thu, 30 May 2024 05:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sCcUY-00074W-NV
 for qemu-devel@nongnu.org; Thu, 30 May 2024 05:54:38 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sCcUW-00027V-Ly
 for qemu-devel@nongnu.org; Thu, 30 May 2024 05:54:38 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-6bce380eb96so485470a12.0
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 02:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717062875; x=1717667675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tnIeYsOj4b7IsclyGOZghZMKCz5C3A6o8pslemkUzRU=;
 b=CGj0rUAWxxHjhVNwE/BSNm3WTyW9G2EDl9Uq297z1nhXeHpIDhJ/OazKJXAuemuKqO
 ib1NxwLyWFtkNeBXHdhuOQhFV6C6JHItteNHyVsnm5/OKBaAeiDnmqg+j/U4IBtXN31/
 CVx4GngKfHgvOTjkDOeJECYGKfUR3ifWYMMPIGcR5liWddak202tmpcubND1pyed2zTn
 YGg9I+4iVVehAIvq/M6mmbjl9Ligp5hlBKK/7pTkuHUW0qRVB6oeB5XONGMUeON7TyRr
 mlRnlNEMYyUZNfql3FIaTBLrd4xZA4HVReB7mKdHEcU87l+/gVPKiGLyLV78xeNsLU9u
 NSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717062875; x=1717667675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tnIeYsOj4b7IsclyGOZghZMKCz5C3A6o8pslemkUzRU=;
 b=JE8Ysu/rfuNZJkaaPFmhccM2NdarFS4mKeeQwoOpX6Mr5qMHjbCY7cTuN52Tq78dzB
 eA4+QxvC1EnApqODVavyw3RMzTdPdgNVQoAI/PmZ068hKkfGygBYzEzpUTftF8kSuwZl
 ZMBu5EYn4CwRCTyzCUp5E1qpDgH1MQAoVS/mWWGJRUVygOl7Go6iehLnnTNOfvSgr9j+
 pS5jQqa4/vk8/9LLZZb0F5DWIEvQtT8fK+i9FpbQD9r2Z8u1DLGUns6jPkiJezdmJwDj
 IugAni0U3OKUGqp6KkK1H/wobcjL/RhENV5q6tkx09gUCl+yNeoTGdAUOwgJodoYy3tJ
 NS+w==
X-Gm-Message-State: AOJu0YwXy+ptRAHm1U3VxutAsWL1jp8icvlKDznK81i9E6/L/y3wtdf7
 YGrtcx0wAdGN/NoCkhoL7jJoS0UCYinJVx3yqSVxSuEfhQ3kXTR8E6ksJZMa
X-Google-Smtp-Source: AGHT+IEyzVIeXlIpDHfsSpzH3gt+zx9FIqWtWgdLPpQeAL7EcufB9lX0C0UXEDAyV1vlZqjrKeIFoA==
X-Received: by 2002:a17:90a:d155:b0:2bf:cf50:593e with SMTP id
 98e67ed59e1d1-2c1ab9f6c7cmr1627549a91.11.1717062874986; 
 Thu, 30 May 2024 02:54:34 -0700 (PDT)
Received: from wheely.local0.net ([1.146.0.82])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775d28asm1183626a91.8.2024.05.30.02.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 02:54:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 4/4] tests/qtest/migration-test: Add a postcopy memfile test
Date: Thu, 30 May 2024 19:54:07 +1000
Message-ID: <20240530095408.31608-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240530095408.31608-1-npiggin@gmail.com>
References: <20240530095408.31608-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x530.google.com
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

Postcopy requires userfaultfd support, which requires tmpfs if a memory
file is used.

This adds back support for /dev/shm memory files, but adds preallocation
to skip environments where that mount is limited in size.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/migration-test.c | 77 ++++++++++++++++++++++++++++++++----
 1 file changed, 69 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 86eace354e..5078033ded 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 
 #include "libqtest.h"
 #include "qapi/qmp/qdict.h"
@@ -553,6 +554,7 @@ typedef struct {
      */
     bool hide_stderr;
     bool use_memfile;
+    bool use_shm_memfile;
     /* only launch the target process */
     bool only_target;
     /* Use dirty ring if true; dirty logging otherwise */
@@ -739,7 +741,62 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         ignore_stderr = "";
     }
 
-    if (args->use_memfile) {
+    if (!qtest_has_machine(machine_alias)) {
+        g_autofree char *msg = g_strdup_printf("machine %s not supported",
+                                               machine_alias);
+        g_test_skip(msg);
+        return -1;
+    }
+
+    if (args->use_shm_memfile) {
+#if defined(__NR_userfaultfd) && defined(__linux__)
+        int fd;
+        uint64_t size;
+
+        if (getenv("GITLAB_CI")) {
+            /*
+             * Gitlab runners are limited to 64MB shm size and despite
+             * pre-allocation there is concern that concurrent tests
+             * could result in nondeterministic failures. Until all shm
+             * usage in all CI tests is found to fail gracefully on
+             * ENOSPC, it is safer to avoid large allocations for now.
+             *
+             * https://lore.kernel.org/qemu-devel/875xuwg4mx.fsf@suse.de/
+             */
+            g_test_skip("shm tests are not supported in Gitlab CI environment");
+            return -1;
+        }
+
+        if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
+            g_test_skip("/dev/shm does not exist or is not a directory");
+            return -1;
+        }
+
+        /*
+         * Pre-create and allocate the file here, because /dev/shm/
+         * is known to be limited in size in some places (e.g., Gitlab CI).
+         */
+        memfile_path = g_strdup_printf("/dev/shm/qemu-%d", getpid());
+        fd = open(memfile_path, O_WRONLY | O_CREAT | O_EXCL, S_IRUSR | S_IWUSR);
+        if (fd == -1) {
+            g_test_skip("/dev/shm file could not be created");
+            return -1;
+        }
+
+        g_assert(qemu_strtosz(memory_size, NULL, &size) == 0);
+        size += 64*1024; /* QEMU may map a bit more memory for a guard page */
+
+        if (fallocate(fd, 0, 0, size) == -1) {
+            unlink(memfile_path);
+            perror("could not alloc"); exit(1);
+            g_test_skip("Could not allocate machine memory in /dev/shm");
+            return -1;
+        }
+        close(fd);
+#else
+        g_test_skip("userfaultfd is not supported");
+#endif
+    } else if (args->use_memfile) {
         memfile_path = g_strdup_printf("/%s/qemu-%d", tmpfs, getpid());
         memfile_opts = g_strdup_printf(
             "-object memory-backend-file,id=mem0,size=%s"
@@ -751,12 +808,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         kvm_opts = ",dirty-ring-size=4096";
     }
 
-    if (!qtest_has_machine(machine_alias)) {
-        g_autofree char *msg = g_strdup_printf("machine %s not supported", machine_alias);
-        g_test_skip(msg);
-        return -1;
-    }
-
     machine = resolve_machine_version(machine_alias, QEMU_ENV_SRC,
                                       QEMU_ENV_DST);
 
@@ -807,7 +858,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
      * Remove shmem file immediately to avoid memory leak in test failed case.
      * It's valid because QEMU has already opened this file
      */
-    if (args->use_memfile) {
+    if (args->use_memfile || args->use_shm_memfile) {
         unlink(memfile_path);
     }
 
@@ -1275,6 +1326,15 @@ static void test_postcopy(void)
     test_postcopy_common(&args);
 }
 
+static void test_postcopy_memfile(void)
+{
+    MigrateCommon args = {
+        .start.use_shm_memfile = true,
+    };
+
+    test_postcopy_common(&args);
+}
+
 static void test_postcopy_suspend(void)
 {
     MigrateCommon args = {
@@ -3441,6 +3501,7 @@ int main(int argc, char **argv)
 
     if (has_uffd) {
         migration_test_add("/migration/postcopy/plain", test_postcopy);
+        migration_test_add("/migration/postcopy/memfile", test_postcopy_memfile);
         migration_test_add("/migration/postcopy/recovery/plain",
                            test_postcopy_recovery);
         migration_test_add("/migration/postcopy/preempt/plain",
-- 
2.43.0


