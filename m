Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A92C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPdn-0006At-9S; Wed, 27 Mar 2024 05:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpPda-00067c-SV
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:32:08 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpPdW-0007fU-Fu
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:32:02 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ea838bf357so3735532b3a.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1711531916; x=1712136716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1rCi//3DuQeWhizcKM3Yysq2ZSYZlpAxINwDElJYRZA=;
 b=QZJpRW1ONv9TFvtE4RSXIyYMR9iRjrjWuuIGEBZnB71KvZc2jG8II8u5AN9hhVOGxI
 xDcxsXKRxzANQayosZj2syRxt7WTj2U2ULC0Wf++7kFMl0S0uTonzJlX97Iu0f0X5k4l
 4qMRTSD1RuHyeoriEYtRL3+gZmziM5WhJClcWePzsx9634HJfvhiC9SVX3nyS7Khc03Z
 nh8YE30zBck4vBmq7Cw9y2Vq5Vcv03pgd1CAl+7ywlJjrR8P5RSCvm3qd0tOawy/T1GA
 sp2TuFSXqLyyIenITBlp8fEQ2MW9N3J30skB7QDbgyeqoA7FEu3tmnqkBlswfYhFy+Sd
 2+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711531916; x=1712136716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1rCi//3DuQeWhizcKM3Yysq2ZSYZlpAxINwDElJYRZA=;
 b=A1KrV/1bNK94Y/n4jAP1XHiIQ/LdMq04oZtN8r4zSn4K8c4IBQ6PMwdR13TlerQUQH
 E7ENwRqONhYh3o3LJS8Ly6TGqUexGS+Jtp5dgi7oaqIQaLlz3hiROMjZoEeclMZn4Uuj
 YrCYFkwE7lOwNaOTKRLi/wFyuGdP5jZ3I0416MztIxQiA/VDwyWsiWqXCS3LDpN1igCt
 J3gEQVim9pjZHRXNOQkXwx1iHVTwXZTl/4tztm7BbCn1pXwmOJHDkLXclX9L1CrBzutS
 n7GCVpjoHLUFBY1uzCXb+wdZWYlxmYfdjFaBwCT01a9w3i9WlahC9U4o8zPiDLEZDllz
 aU7A==
X-Gm-Message-State: AOJu0YzbSPN7I/w1/+zzKXR7BDZ3m+1/wJd6jDPfXWrf3pu/s6N3W30P
 QPwbpKMRtysO0KpyxcoiFyFNlM+1wMMHw+8sfdLhqxZ8FN7OYcZnVXlwgdnX982uBzVdzQT+9g2
 w
X-Google-Smtp-Source: AGHT+IGphlMuBTEXdnzWJ5LvppfwIgjWinWInp9O3bKarX2iCsBtCXOzczHFUHIKHpybBIrmWSv6BA==
X-Received: by 2002:a05:6a20:2446:b0:1a3:e2ed:62af with SMTP id
 t6-20020a056a20244600b001a3e2ed62afmr1709034pzc.34.1711531916505; 
 Wed, 27 Mar 2024 02:31:56 -0700 (PDT)
Received: from grind.. ([177.45.186.241]) by smtp.gmail.com with ESMTPSA id
 fm23-20020a056a002f9700b006e6b41511fdsm7628760pfb.94.2024.03.27.02.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 02:31:56 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, alistair.francis@wdc.com, groug@kaod.org,
 peter.maydell@linaro.org, qemu_oss@crudebyte.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v2 2/7] qtest/virtio-9p-test.c: parametrize 'dir' name
 in local tests
Date: Wed, 27 Mar 2024 06:31:39 -0300
Message-ID: <20240327093144.781701-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327093144.781701-1-dbarboza@ventanamicro.com>
References: <20240327093144.781701-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

All local 9p tests creates a different dir inside tempdir, where '01' is
the dir for the first test, '02' the dir fot the second test and so on.

We want to make tests autoclean themselves while also consolidating
them in fewer tests, but this will incur a lot of dir changes that will
be unpleasant to deal with at it is today - the dir name is hard coded
in every 9p API call.

Add a 'new_dir' var in each test that will hold the created dir name. If
the test also creates new files/symlinks, parametrize them as well since
they also use the dir name.

After these changes, changing the val of "new_dir" will change all dir
references the test uses.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 tests/qtest/virtio-9p-test.c | 108 +++++++++++++++++++++++------------
 1 file changed, 72 insertions(+), 36 deletions(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 23edca05c5..be031abc17 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -511,13 +511,14 @@ static void fs_create_dir(void *obj, void *data, QGuestAllocator *t_alloc)
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st;
+    const char *new_dir = "01";
     g_autofree char *root_path = virtio_9p_test_path("");
-    g_autofree char *new_dir_path = virtio_9p_test_path("01");
+    g_autofree char *new_dir_path = virtio_9p_test_path(new_dir);
 
     g_assert(root_path != NULL);
 
     tattach({ .client = v9p });
-    tmkdir({ .client = v9p, .atPath = "/", .name = "01" });
+    tmkdir({ .client = v9p, .atPath = "/", .name = new_dir });
 
     /* check if created directory really exists now ... */
     g_assert(stat(new_dir_path, &st) == 0);
@@ -530,13 +531,14 @@ static void fs_unlinkat_dir(void *obj, void *data, QGuestAllocator *t_alloc)
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st;
+    const char *new_dir = "02";
     g_autofree char *root_path = virtio_9p_test_path("");
-    g_autofree char *new_dir_path = virtio_9p_test_path("02");
+    g_autofree char *new_dir_path = virtio_9p_test_path(new_dir);
 
     g_assert(root_path != NULL);
 
     tattach({ .client = v9p });
-    tmkdir({ .client = v9p, .atPath = "/", .name = "02" });
+    tmkdir({ .client = v9p, .atPath = "/", .name = new_dir });
 
     /* check if created directory really exists now ... */
     g_assert(stat(new_dir_path, &st) == 0);
@@ -544,7 +546,7 @@ static void fs_unlinkat_dir(void *obj, void *data, QGuestAllocator *t_alloc)
     g_assert((st.st_mode & S_IFMT) == S_IFDIR);
 
     tunlinkat({
-        .client = v9p, .atPath = "/", .name = "02",
+        .client = v9p, .atPath = "/", .name = new_dir,
         .flags = P9_DOTL_AT_REMOVEDIR
     });
     /* directory should be gone now */
@@ -556,11 +558,13 @@ static void fs_create_file(void *obj, void *data, QGuestAllocator *t_alloc)
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st;
-    g_autofree char *new_file_path = virtio_9p_test_path("03/1st_file");
+    const char *new_dir = "03";
+    g_autofree char *new_file = g_strdup_printf("%s/%s", new_dir, "1st_file");
+    g_autofree char *new_file_path = virtio_9p_test_path(new_file);
 
     tattach({ .client = v9p });
-    tmkdir({ .client = v9p, .atPath = "/", .name = "03" });
-    tlcreate({ .client = v9p, .atPath = "03", .name = "1st_file" });
+    tmkdir({ .client = v9p, .atPath = "/", .name = new_dir });
+    tlcreate({ .client = v9p, .atPath = new_dir, .name = "1st_file" });
 
     /* check if created file exists now ... */
     g_assert(stat(new_file_path, &st) == 0);
@@ -573,18 +577,20 @@ static void fs_unlinkat_file(void *obj, void *data, QGuestAllocator *t_alloc)
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st;
-    g_autofree char *new_file_path = virtio_9p_test_path("04/doa_file");
+    const char *new_dir = "04";
+    g_autofree char *new_file = g_strdup_printf("%s/%s", new_dir, "doa_file");
+    g_autofree char *new_file_path = virtio_9p_test_path(new_file);
 
     tattach({ .client = v9p });
-    tmkdir({ .client = v9p, .atPath = "/", .name = "04" });
-    tlcreate({ .client = v9p, .atPath = "04", .name = "doa_file" });
+    tmkdir({ .client = v9p, .atPath = "/", .name = new_dir });
+    tlcreate({ .client = v9p, .atPath = new_dir, .name = "doa_file" });
 
     /* check if created file exists now ... */
     g_assert(stat(new_file_path, &st) == 0);
     /* ... and is a regular file */
     g_assert((st.st_mode & S_IFMT) == S_IFREG);
 
-    tunlinkat({ .client = v9p, .atPath = "04", .name = "doa_file" });
+    tunlinkat({ .client = v9p, .atPath = new_dir, .name = "doa_file" });
     /* file should be gone now */
     g_assert(stat(new_file_path, &st) != 0);
 }
@@ -594,17 +600,26 @@ static void fs_symlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st;
-    g_autofree char *real_file_path = virtio_9p_test_path("05/real_file");
-    g_autofree char *symlink_file_path = virtio_9p_test_path("05/symlink_file");
+    const char *new_dir = "05";
+    g_autofree char *real_file = NULL;
+    g_autofree char *real_file_path = NULL;
+    g_autofree char *symlink_file = NULL;
+    g_autofree char *symlink_file_path = NULL;
+
+    real_file = g_strdup_printf("%s/%s", new_dir, "real_file");
+    real_file_path = virtio_9p_test_path(real_file);
+
+    symlink_file = g_strdup_printf("%s/%s", new_dir, "symlink_file");
+    symlink_file_path = virtio_9p_test_path(symlink_file);
 
     tattach({ .client = v9p });
-    tmkdir({ .client = v9p, .atPath = "/", .name = "05" });
-    tlcreate({ .client = v9p, .atPath = "05", .name = "real_file" });
+    tmkdir({ .client = v9p, .atPath = "/", .name = new_dir });
+    tlcreate({ .client = v9p, .atPath = new_dir, .name = "real_file" });
     g_assert(stat(real_file_path, &st) == 0);
     g_assert((st.st_mode & S_IFMT) == S_IFREG);
 
     tsymlink({
-        .client = v9p, .atPath = "05", .name = "symlink_file",
+        .client = v9p, .atPath = new_dir, .name = "symlink_file",
         .symtgt = "real_file"
     });
 
@@ -618,22 +633,31 @@ static void fs_unlinkat_symlink(void *obj, void *data,
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st;
-    g_autofree char *real_file_path = virtio_9p_test_path("06/real_file");
-    g_autofree char *symlink_file_path = virtio_9p_test_path("06/symlink_file");
+    const char *new_dir = "06";
+    g_autofree char *real_file = NULL;
+    g_autofree char *real_file_path = NULL;
+    g_autofree char *symlink_file = NULL;
+    g_autofree char *symlink_file_path = NULL;
+
+    real_file = g_strdup_printf("%s/%s", new_dir, "real_file");
+    real_file_path = virtio_9p_test_path(real_file);
+
+    symlink_file = g_strdup_printf("%s/%s", new_dir, "symlink_file");
+    symlink_file_path = virtio_9p_test_path(symlink_file);
 
     tattach({ .client = v9p });
-    tmkdir({ .client = v9p, .atPath = "/", .name = "06" });
-    tlcreate({ .client = v9p, .atPath = "06", .name = "real_file" });
+    tmkdir({ .client = v9p, .atPath = "/", .name = new_dir });
+    tlcreate({ .client = v9p, .atPath = new_dir, .name = "real_file" });
     g_assert(stat(real_file_path, &st) == 0);
     g_assert((st.st_mode & S_IFMT) == S_IFREG);
 
     tsymlink({
-        .client = v9p, .atPath = "06", .name = "symlink_file",
+        .client = v9p, .atPath = new_dir, .name = "symlink_file",
         .symtgt = "real_file"
     });
     g_assert(stat(symlink_file_path, &st) == 0);
 
-    tunlinkat({ .client = v9p, .atPath = "06", .name = "symlink_file" });
+    tunlinkat({ .client = v9p, .atPath = new_dir, .name = "symlink_file" });
     /* symlink should be gone now */
     g_assert(stat(symlink_file_path, &st) != 0);
 }
@@ -643,21 +667,27 @@ static void fs_hardlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st_real, st_link;
+    const char *new_dir = "07";
+    g_autofree char *real_file = NULL;
     g_autofree char *real_file_path = NULL;
+    g_autofree char *hardlink_file = NULL;
     g_autofree char *hardlink_file_path = NULL;
 
-    real_file_path = virtio_9p_test_path("07/real_file");
-    hardlink_file_path = virtio_9p_test_path("07/hardlink_file");
+    real_file = g_strdup_printf("%s/%s", new_dir, "real_file");
+    real_file_path = virtio_9p_test_path(real_file);
+
+    hardlink_file = g_strdup_printf("%s/%s", new_dir, "hardlink_file");
+    hardlink_file_path = virtio_9p_test_path(hardlink_file);
 
     tattach({ .client = v9p });
-    tmkdir({ .client = v9p, .atPath = "/", .name = "07" });
-    tlcreate({ .client = v9p, .atPath = "07", .name = "real_file" });
+    tmkdir({ .client = v9p, .atPath = "/", .name = new_dir });
+    tlcreate({ .client = v9p, .atPath = new_dir, .name = "real_file" });
     g_assert(stat(real_file_path, &st_real) == 0);
     g_assert((st_real.st_mode & S_IFMT) == S_IFREG);
 
     tlink({
-        .client = v9p, .atPath = "07", .name = "hardlink_file",
-        .toPath = "07/real_file"
+        .client = v9p, .atPath = new_dir, .name = "hardlink_file",
+        .toPath = real_file
     });
 
     /* check if link exists now ... */
@@ -674,25 +704,31 @@ static void fs_unlinkat_hardlink(void *obj, void *data,
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st_real, st_link;
+    const char *new_dir = "08";
+    g_autofree char *real_file = NULL;
     g_autofree char *real_file_path = NULL;
+    g_autofree char *hardlink_file = NULL;
     g_autofree char *hardlink_file_path = NULL;
 
-    real_file_path = virtio_9p_test_path("08/real_file");
-    hardlink_file_path = virtio_9p_test_path("08/hardlink_file");
+    real_file = g_strdup_printf("%s/%s", new_dir, "real_file");
+    real_file_path = virtio_9p_test_path(real_file);
+
+    hardlink_file = g_strdup_printf("%s/%s", new_dir, "hardlink_file");
+    hardlink_file_path = virtio_9p_test_path(hardlink_file);
 
     tattach({ .client = v9p });
-    tmkdir({ .client = v9p, .atPath = "/", .name = "08" });
-    tlcreate({ .client = v9p, .atPath = "08", .name = "real_file" });
+    tmkdir({ .client = v9p, .atPath = "/", .name = new_dir });
+    tlcreate({ .client = v9p, .atPath = new_dir, .name = "real_file" });
     g_assert(stat(real_file_path, &st_real) == 0);
     g_assert((st_real.st_mode & S_IFMT) == S_IFREG);
 
     tlink({
-        .client = v9p, .atPath = "08", .name = "hardlink_file",
-        .toPath = "08/real_file"
+        .client = v9p, .atPath = new_dir, .name = "hardlink_file",
+        .toPath = real_file
     });
     g_assert(stat(hardlink_file_path, &st_link) == 0);
 
-    tunlinkat({ .client = v9p, .atPath = "08", .name = "hardlink_file" });
+    tunlinkat({ .client = v9p, .atPath = new_dir, .name = "hardlink_file" });
     /* symlink should be gone now */
     g_assert(stat(hardlink_file_path, &st_link) != 0);
     /* and old file should still exist */
-- 
2.44.0


