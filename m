Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96FDD1039D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 12:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOENz-0007sF-0V; Wed, 26 Nov 2025 07:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pzmarzly0@gmail.com>)
 id 1vOENx-0007r1-Rm
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:12:37 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pzmarzly0@gmail.com>)
 id 1vOENw-0002Aw-AN
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:12:37 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so62952455e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 04:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764159155; x=1764763955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NjGlMxqmi4jFAS3XRyH9VgyPblT7jZzO2mgmFvDZU7Y=;
 b=AfGNNNIHomhMw8l8hen0cHFkGT2xmyexPKSu0lsg40GtJCaHPM+eTxtUy4OEVjMcYR
 YVL7A/d3WnSjFszyvdZ0yjpo67b++CaAka5+J0AIZl59GCmE2moUIxlydRabgoCYY0dJ
 xj64F4qf6CIzDM+UgQpcJAc/3LrGB0xcBrVGijJTO86ocupnn8FQJHQShtwSPBb1SiRb
 JoELJO0AdurtdrKrIZx5ybRFadJ3uDgU+Ihz+iG8jj1NXIsW3GxZpdMfXE3PlKfPgf6d
 AHrfPk7oSlWzHhPK3IZcGbRht3g/BH9ADdI6QgG4p1GrZ++D8bgryUWdquPDMy19jAsg
 zOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764159155; x=1764763955;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NjGlMxqmi4jFAS3XRyH9VgyPblT7jZzO2mgmFvDZU7Y=;
 b=BC0HbNkbIcuAwhf1E6VxGISqAchamKFR/3Cc7I7uKfNeyF12pcv7ub25svt82sZRVX
 XJq41FUK1mn4R0Uoyc3gM0vI2x/mOxRBjC0uV32JP0V6Z7y1xbglKyQ4YMJyWhUS+v5j
 gZsKKqgN7bQOctW+8o+99Yk4Q/uwtNfXSnZaAF+n7ANadYcnVEueucvELxktFKetuTIY
 GSD7pZCHtIFX7PA53kq3tlcgavD263cVI1tsCu7dr58RqFkJ0vwZ9zbxSIS47ABeidmS
 mGCkdeT5hMcIgy3pb9sAT5ljt/n+vMdynR6q9pmkWuOUAbm7MZqfodX661ByH5RZd8ac
 7TuA==
X-Gm-Message-State: AOJu0Yy2kPfnwKIgvaLQu4xJQUJcXSzXVvyDcEM7we30c2eokh2kkmZ5
 lQ1AeZhQvmdg3njc5ACEm80n/PIX4dywqa1Bk+m+ovaoybh/dLqAfbQllBXknTYzjmOprQ==
X-Gm-Gg: ASbGncuTSIzZvyB1Ltaeux1XSodRhedbBcTVPynDBXe3k34+Jrh8CB3Q7spCTqFaOib
 c7AtVjKM0QasRIZdlgb4EFAld/sun2NIV6wfhQiJwErclFgcAiZ2XeHRGPN/1CmLbL/s72R+diC
 98gKytx8sPeG0pNK2M2PEXRyR5/FDz45yzZOa93SGA5tFI9U7XFxuyK0I28XJIr2DpqKCHPpRV8
 gNP1A9XqSEjSU9OmZoIcKVuUn/5AcecDHg+uSW0Zo1aTsD5Inv3O98zzckIwi+Cq9kZMFzxKBZx
 0UfCJ2A8saD7DFr4dZ2Y03STdBt5iqbxGeP8nG9GltYv1SkEl/0GhD1kI7quE1gQ4c2v4i2fF8K
 FlKpNPupM0TY+xymjZt9JTxfyQd7NSeE8lwNrSXPjSBjb3YORhP0Jsd5DfeipRIR3grpliGINUO
 MtcTV7ouE=
X-Google-Smtp-Source: AGHT+IESUI2vKM5vrFZpyegg9JqJzXIzC/4VtUcGAxnprIsf7pQscfSO9xyqdunNj5/tlhYm/6dFfg==
X-Received: by 2002:a05:600c:19cd:b0:477:c37:2ea7 with SMTP id
 5b1f17b1804b1-477c1115febmr143812655e9.21.1764159154409; 
 Wed, 26 Nov 2025 04:12:34 -0800 (PST)
Received: from localhost ([109.76.183.78]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e5a3sm39923344f8f.6.2025.11.26.04.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 04:12:33 -0800 (PST)
From: Pawel Zmarzly <pzmarzly0@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de
Subject: [PATCH v2] migration: fix parsing snapshots with x-ignore-shared flag
Date: Wed, 26 Nov 2025 12:12:33 +0000
Message-ID: <20251126121233.542473-1-pzmarzly0@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=pzmarzly0@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Snapshots made with mapped-ram and x-ignore-shared flags are
not parsed properly.

Co-authored-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Pawel Zmarzly <pzmarzly0@gmail.com>
---
 migration/ram.c                    | 21 +++++++++++----------
 tests/qtest/migration/file-tests.c | 18 ++++++++++++++++++
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 29f016cb25..7d024b88b5 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4205,6 +4205,17 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
 
     assert(block);
 
+    if (migrate_ignore_shared()) {
+        hwaddr addr = qemu_get_be64(f);
+        if (migrate_ram_is_ignored(block) &&
+            block->mr->addr != addr) {
+            error_report("Mismatched GPAs for block %s "
+                         "%" PRId64 "!= %" PRId64, block->idstr,
+                         (uint64_t)addr, (uint64_t)block->mr->addr);
+            return -EINVAL;
+        }
+    }
+
     if (migrate_mapped_ram()) {
         parse_ramblock_mapped_ram(f, block, length, &local_err);
         if (local_err) {
@@ -4244,16 +4255,6 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
             return -EINVAL;
         }
     }
-    if (migrate_ignore_shared()) {
-        hwaddr addr = qemu_get_be64(f);
-        if (migrate_ram_is_ignored(block) &&
-            block->mr->addr != addr) {
-            error_report("Mismatched GPAs for block %s "
-                         "%" PRId64 "!= %" PRId64, block->idstr,
-                         (uint64_t)addr, (uint64_t)block->mr->addr);
-            return -EINVAL;
-        }
-    }
     ret = rdma_block_notification_handle(f, block->idstr);
     if (ret < 0) {
         qemu_file_set_error(f, ret);
diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
index 4d78ce0855..c196a703ff 100644
--- a/tests/qtest/migration/file-tests.c
+++ b/tests/qtest/migration/file-tests.c
@@ -303,6 +303,22 @@ static void migration_test_add_file_smoke(MigrationTestEnv *env)
                        test_multifd_file_mapped_ram_dio);
 }
 
+static void test_precopy_file_mapped_ram_ignore_shared(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
+                                           FILE_TEST_FILENAME);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = "defer",
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true,
+            .caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true,
+        },
+    };
+
+    test_file_common(&args, true);
+}
+
 void migration_test_add_file(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
@@ -329,6 +345,8 @@ void migration_test_add_file(MigrationTestEnv *env)
 
     migration_test_add("/migration/multifd/file/mapped-ram",
                        test_multifd_file_mapped_ram);
+    migration_test_add("/migration/multifd/file/mapped-ram/ignore-shared",
+                       test_precopy_file_mapped_ram_ignore_shared);
     migration_test_add("/migration/multifd/file/mapped-ram/live",
                        test_multifd_file_mapped_ram_live);
 
-- 
2.52.0

