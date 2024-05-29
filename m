Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22F7C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 04:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCAgz-0005Yp-2e; Wed, 29 May 2024 00:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sCAgx-0005YZ-R1
 for qemu-devel@nongnu.org; Wed, 29 May 2024 00:13:35 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sCAgv-0004uE-T7
 for qemu-devel@nongnu.org; Wed, 29 May 2024 00:13:35 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-24cbb884377so766757fac.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 21:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716956011; x=1717560811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y78cQbaG49gfAp5lAUthC7sJF/QkcqO5aFiUYCrDG3E=;
 b=Pim/9etZlWAKiP/ybnjALx0Qcj3z899lzOTK/7YLvgM6TQ4Vd5O1UNVRJXkhQCGChZ
 VHOgYV/QB359S/PAlmgch8IF1xJwMCi84eAP+VSMVU8nOMSekJxeGtLH6Mc1q3khFzs9
 XmaUKnGgD67oR9nGk8H+bHIbsgT8X/4UfPErXydZ25KS0otb6BFUUMyMw3gap3vCt/R2
 lNxV3OX80JZ5f++56euHoxJ89mhqfaC9LApWusjDZFVz6U6TLX12+pjSafKGpHGmy5Vc
 /qxMgV/HqrpG14xDQ/Ad6Tv9yGGWQfpbpAoohbduMM8H7v8uNxG/IawtT8jj6M4n5STr
 CO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716956011; x=1717560811;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y78cQbaG49gfAp5lAUthC7sJF/QkcqO5aFiUYCrDG3E=;
 b=g7WngzNBXlDskECB83RoU/+EdUIP4tFDHiG4iAZGJ6UjlmhxUm7T1eIhV0Kj21FWiY
 BtWfvd8FliWATU2xFm/Qb4ZSBO1q+RtxSV+R/CPgtBeIhNFaKW1N+FfRe7TMr7REEO7x
 hmw2mWQkGguh3hhlEe09bx5+TZJ6LALKhL3Vz+cqkaTdYSv9fzv7OaEnEZPSmTwgYhPr
 jv/DnkPpRtP6WRuBF1ZQI33YHpB580yeTU0XKhhPRpXNPJPK4y39FgKRp84N5WsP8SCS
 vAZb56vdFcVG9+6KLZ2YEutB3ZGDeoCrgccb3eARWnSjNFJnR0Uzg28aSPLe2z9FlOqs
 yuIg==
X-Gm-Message-State: AOJu0Yw3sk76CwQlHCv7neiqWSEnWLMcaz+wtJWuvRnB4TKUfRX0lqji
 KE8GrhsYoeIP6jnzALXzqW9Xl+Zr+XoZDTb1I7zMaL7oSqpPewFL26dZ4g==
X-Google-Smtp-Source: AGHT+IH1rJE9lXS9o6fY4HKSVI0TX51RjW+KAlpBuMGgcvzUuwDAM9IF9GyQDNCKwxKl4ba0eLC3mQ==
X-Received: by 2002:a05:6870:35d4:b0:23e:7764:7795 with SMTP id
 586e51a60fabf-24ca12e174bmr14907257fac.28.1716956010900; 
 Tue, 28 May 2024 21:13:30 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fcbeac22sm7202743b3a.113.2024.05.28.21.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 21:13:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] tests/qtest/migrate-test: Add a postcopy memfile test
Date: Wed, 29 May 2024 14:13:21 +1000
Message-ID: <20240529041322.701525-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x2a.google.com
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

How about this? This goes on top of the reset of the patches
(I'll re-send them all as a series if we can get to some agreement).

This adds back the /dev/shm option with preallocation and adds a test
case that requires tmpfs.

Thanks,
Nick

 tests/qtest/migration-test.c | 63 +++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 86eace354e..7fd9bbdc18 100644
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
+    bool use_uffd_memfile;
     /* only launch the target process */
     bool only_target;
     /* Use dirty ring if true; dirty logging otherwise */
@@ -739,7 +741,48 @@ static int test_migrate_start(QTestState **from, QTestState **to,
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
+    if (args->use_uffd_memfile) {
+#if defined(__NR_userfaultfd) && defined(__linux__)
+        int fd;
+        uint64_t size;
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
@@ -751,12 +794,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
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
 
@@ -807,7 +844,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
      * Remove shmem file immediately to avoid memory leak in test failed case.
      * It's valid because QEMU has already opened this file
      */
-    if (args->use_memfile) {
+    if (args->use_memfile || args->use_uffd_memfile) {
         unlink(memfile_path);
     }
 
@@ -1275,6 +1312,15 @@ static void test_postcopy(void)
     test_postcopy_common(&args);
 }
 
+static void test_postcopy_memfile(void)
+{
+    MigrateCommon args = {
+        .start.use_uffd_memfile = true,
+    };
+
+    test_postcopy_common(&args);
+}
+
 static void test_postcopy_suspend(void)
 {
     MigrateCommon args = {
@@ -3441,6 +3487,7 @@ int main(int argc, char **argv)
 
     if (has_uffd) {
         migration_test_add("/migration/postcopy/plain", test_postcopy);
+        migration_test_add("/migration/postcopy/memfile", test_postcopy_memfile);
         migration_test_add("/migration/postcopy/recovery/plain",
                            test_postcopy_recovery);
         migration_test_add("/migration/postcopy/preempt/plain",
-- 
2.43.0


