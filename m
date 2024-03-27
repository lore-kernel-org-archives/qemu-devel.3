Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FBCC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPdm-0006Aa-7n; Wed, 27 Mar 2024 05:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpPda-00067b-O3
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:32:08 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpPdU-0007dY-Kb
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:32:00 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e6f69e850bso5885522b3a.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1711531914; x=1712136714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cr2RMbcAw0+JQljknmBuPqVal2V2vcT8l1MqfVteyqg=;
 b=E+7NVQW2bC3huOxCR+7ursnoOzjJKlhpyFLB+dA25HFpePR6hj+J8z+JonlGAZ0C2/
 hN80c6P40Cq6bomuO7eClaM7+1wQyeVzlPj3jAk1jKJiV/fVP7+gPbZXT/aUpHWDq+9U
 ZolR7yx9z0IQNyPj4Kziar2O1zej1C58UVz9t2LorIO38RRm7gfDr+lWCCneDB9xd9os
 fRj5D5TslDYEIjBVlJ+3qWJYyzVm9QY4ygA5pbpKuZ5dxcyYQAQOu23FCkFWvHnblxe7
 M1KiAdf1+wB45rKhBW1F2iLVXqKarwxUq0W/jRlU0EBLmQ9mFLqSLirPxs5N4ycnvIfT
 kP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711531914; x=1712136714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cr2RMbcAw0+JQljknmBuPqVal2V2vcT8l1MqfVteyqg=;
 b=M6YKxfmevum3U7n3M/iPBHNI0gxAAht0f64+4rhHP4VHvZnV2JbargRoHojQOfU6As
 AXvQNmR3BlxWUop4tOs2bZAvArVhEsEs9hJnb78CTAH8Ha2XnbbxfIJjdNF/MFM7oWYe
 Ov706WJpVI1h4hTqqQSdkrZvudSvWUimCRB7ZZVHwy86YUg/wAtVuwJXpmi9xVI2kGtt
 p5Mnrm5dBoNfdPr49QVcfLmyp8JTUHOsXICAY6W7gDO46DQTI96mv7SvCznDCLfp69cm
 FXJkIf0BAAp1nRSb8waRRrPiV+rQtfgFabRRWZo/Y8mecvZDU+PhiTJwwKuo6AwUlpmo
 zxAQ==
X-Gm-Message-State: AOJu0Yy9f24FJiQaziy4/EqsEfOOjKXE633ICc15/4emie8oo5sE6efd
 4okaTNcq+tlm0xPKq10kt2QN0NmmdXtO+ch8huv4zHTfJqjS8oiEtptcKYb2/WwuUHsk2F8D7TS
 g
X-Google-Smtp-Source: AGHT+IEDwg25E0KBHXl7/65jGZC6Bjj0ZbX0uKR6UZEPXcK7VLqYs3mZBd0rfkXcrrxRDhGw5oQlhA==
X-Received: by 2002:a05:6a00:178e:b0:6ea:b1f5:1146 with SMTP id
 s14-20020a056a00178e00b006eab1f51146mr4458179pfg.21.1711531913729; 
 Wed, 27 Mar 2024 02:31:53 -0700 (PDT)
Received: from grind.. ([177.45.186.241]) by smtp.gmail.com with ESMTPSA id
 fm23-20020a056a002f9700b006e6b41511fdsm7628760pfb.94.2024.03.27.02.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 02:31:53 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, alistair.francis@wdc.com, groug@kaod.org,
 peter.maydell@linaro.org, qemu_oss@crudebyte.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v2 1/7] qtest/virtio-9p-test.c: add '_path' in path
 vars
Date: Wed, 27 Mar 2024 06:31:38 -0300
Message-ID: <20240327093144.781701-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327093144.781701-1-dbarboza@ventanamicro.com>
References: <20240327093144.781701-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
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

Add a '_path' call in all variables that are receiving a full path via
virtio_9p_test_path().

Aside from being more accurate with what the variable represents, this
will allow us to use 'new_dir' and 'real_path' and so on to parametrize
test values in the next patch.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 tests/qtest/virtio-9p-test.c | 64 ++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 65e69491e5..23edca05c5 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -512,7 +512,7 @@ static void fs_create_dir(void *obj, void *data, QGuestAllocator *t_alloc)
     v9fs_set_allocator(t_alloc);
     struct stat st;
     g_autofree char *root_path = virtio_9p_test_path("");
-    g_autofree char *new_dir = virtio_9p_test_path("01");
+    g_autofree char *new_dir_path = virtio_9p_test_path("01");
 
     g_assert(root_path != NULL);
 
@@ -520,7 +520,7 @@ static void fs_create_dir(void *obj, void *data, QGuestAllocator *t_alloc)
     tmkdir({ .client = v9p, .atPath = "/", .name = "01" });
 
     /* check if created directory really exists now ... */
-    g_assert(stat(new_dir, &st) == 0);
+    g_assert(stat(new_dir_path, &st) == 0);
     /* ... and is actually a directory */
     g_assert((st.st_mode & S_IFMT) == S_IFDIR);
 }
@@ -531,7 +531,7 @@ static void fs_unlinkat_dir(void *obj, void *data, QGuestAllocator *t_alloc)
     v9fs_set_allocator(t_alloc);
     struct stat st;
     g_autofree char *root_path = virtio_9p_test_path("");
-    g_autofree char *new_dir = virtio_9p_test_path("02");
+    g_autofree char *new_dir_path = virtio_9p_test_path("02");
 
     g_assert(root_path != NULL);
 
@@ -539,7 +539,7 @@ static void fs_unlinkat_dir(void *obj, void *data, QGuestAllocator *t_alloc)
     tmkdir({ .client = v9p, .atPath = "/", .name = "02" });
 
     /* check if created directory really exists now ... */
-    g_assert(stat(new_dir, &st) == 0);
+    g_assert(stat(new_dir_path, &st) == 0);
     /* ... and is actually a directory */
     g_assert((st.st_mode & S_IFMT) == S_IFDIR);
 
@@ -548,7 +548,7 @@ static void fs_unlinkat_dir(void *obj, void *data, QGuestAllocator *t_alloc)
         .flags = P9_DOTL_AT_REMOVEDIR
     });
     /* directory should be gone now */
-    g_assert(stat(new_dir, &st) != 0);
+    g_assert(stat(new_dir_path, &st) != 0);
 }
 
 static void fs_create_file(void *obj, void *data, QGuestAllocator *t_alloc)
@@ -556,14 +556,14 @@ static void fs_create_file(void *obj, void *data, QGuestAllocator *t_alloc)
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st;
-    g_autofree char *new_file = virtio_9p_test_path("03/1st_file");
+    g_autofree char *new_file_path = virtio_9p_test_path("03/1st_file");
 
     tattach({ .client = v9p });
     tmkdir({ .client = v9p, .atPath = "/", .name = "03" });
     tlcreate({ .client = v9p, .atPath = "03", .name = "1st_file" });
 
     /* check if created file exists now ... */
-    g_assert(stat(new_file, &st) == 0);
+    g_assert(stat(new_file_path, &st) == 0);
     /* ... and is a regular file */
     g_assert((st.st_mode & S_IFMT) == S_IFREG);
 }
@@ -573,20 +573,20 @@ static void fs_unlinkat_file(void *obj, void *data, QGuestAllocator *t_alloc)
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st;
-    g_autofree char *new_file = virtio_9p_test_path("04/doa_file");
+    g_autofree char *new_file_path = virtio_9p_test_path("04/doa_file");
 
     tattach({ .client = v9p });
     tmkdir({ .client = v9p, .atPath = "/", .name = "04" });
     tlcreate({ .client = v9p, .atPath = "04", .name = "doa_file" });
 
     /* check if created file exists now ... */
-    g_assert(stat(new_file, &st) == 0);
+    g_assert(stat(new_file_path, &st) == 0);
     /* ... and is a regular file */
     g_assert((st.st_mode & S_IFMT) == S_IFREG);
 
     tunlinkat({ .client = v9p, .atPath = "04", .name = "doa_file" });
     /* file should be gone now */
-    g_assert(stat(new_file, &st) != 0);
+    g_assert(stat(new_file_path, &st) != 0);
 }
 
 static void fs_symlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
@@ -594,13 +594,13 @@ static void fs_symlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st;
-    g_autofree char *real_file = virtio_9p_test_path("05/real_file");
-    g_autofree char *symlink_file = virtio_9p_test_path("05/symlink_file");
+    g_autofree char *real_file_path = virtio_9p_test_path("05/real_file");
+    g_autofree char *symlink_file_path = virtio_9p_test_path("05/symlink_file");
 
     tattach({ .client = v9p });
     tmkdir({ .client = v9p, .atPath = "/", .name = "05" });
     tlcreate({ .client = v9p, .atPath = "05", .name = "real_file" });
-    g_assert(stat(real_file, &st) == 0);
+    g_assert(stat(real_file_path, &st) == 0);
     g_assert((st.st_mode & S_IFMT) == S_IFREG);
 
     tsymlink({
@@ -609,7 +609,7 @@ static void fs_symlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
     });
 
     /* check if created link exists now */
-    g_assert(stat(symlink_file, &st) == 0);
+    g_assert(stat(symlink_file_path, &st) == 0);
 }
 
 static void fs_unlinkat_symlink(void *obj, void *data,
@@ -618,24 +618,24 @@ static void fs_unlinkat_symlink(void *obj, void *data,
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st;
-    g_autofree char *real_file = virtio_9p_test_path("06/real_file");
-    g_autofree char *symlink_file = virtio_9p_test_path("06/symlink_file");
+    g_autofree char *real_file_path = virtio_9p_test_path("06/real_file");
+    g_autofree char *symlink_file_path = virtio_9p_test_path("06/symlink_file");
 
     tattach({ .client = v9p });
     tmkdir({ .client = v9p, .atPath = "/", .name = "06" });
     tlcreate({ .client = v9p, .atPath = "06", .name = "real_file" });
-    g_assert(stat(real_file, &st) == 0);
+    g_assert(stat(real_file_path, &st) == 0);
     g_assert((st.st_mode & S_IFMT) == S_IFREG);
 
     tsymlink({
         .client = v9p, .atPath = "06", .name = "symlink_file",
         .symtgt = "real_file"
     });
-    g_assert(stat(symlink_file, &st) == 0);
+    g_assert(stat(symlink_file_path, &st) == 0);
 
     tunlinkat({ .client = v9p, .atPath = "06", .name = "symlink_file" });
     /* symlink should be gone now */
-    g_assert(stat(symlink_file, &st) != 0);
+    g_assert(stat(symlink_file_path, &st) != 0);
 }
 
 static void fs_hardlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
@@ -643,13 +643,16 @@ static void fs_hardlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st_real, st_link;
-    g_autofree char *real_file = virtio_9p_test_path("07/real_file");
-    g_autofree char *hardlink_file = virtio_9p_test_path("07/hardlink_file");
+    g_autofree char *real_file_path = NULL;
+    g_autofree char *hardlink_file_path = NULL;
+
+    real_file_path = virtio_9p_test_path("07/real_file");
+    hardlink_file_path = virtio_9p_test_path("07/hardlink_file");
 
     tattach({ .client = v9p });
     tmkdir({ .client = v9p, .atPath = "/", .name = "07" });
     tlcreate({ .client = v9p, .atPath = "07", .name = "real_file" });
-    g_assert(stat(real_file, &st_real) == 0);
+    g_assert(stat(real_file_path, &st_real) == 0);
     g_assert((st_real.st_mode & S_IFMT) == S_IFREG);
 
     tlink({
@@ -658,7 +661,7 @@ static void fs_hardlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
     });
 
     /* check if link exists now ... */
-    g_assert(stat(hardlink_file, &st_link) == 0);
+    g_assert(stat(hardlink_file_path, &st_link) == 0);
     /* ... and it's a hard link, right? */
     g_assert((st_link.st_mode & S_IFMT) == S_IFREG);
     g_assert(st_link.st_dev == st_real.st_dev);
@@ -671,26 +674,29 @@ static void fs_unlinkat_hardlink(void *obj, void *data,
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st_real, st_link;
-    g_autofree char *real_file = virtio_9p_test_path("08/real_file");
-    g_autofree char *hardlink_file = virtio_9p_test_path("08/hardlink_file");
+    g_autofree char *real_file_path = NULL;
+    g_autofree char *hardlink_file_path = NULL;
+
+    real_file_path = virtio_9p_test_path("08/real_file");
+    hardlink_file_path = virtio_9p_test_path("08/hardlink_file");
 
     tattach({ .client = v9p });
     tmkdir({ .client = v9p, .atPath = "/", .name = "08" });
     tlcreate({ .client = v9p, .atPath = "08", .name = "real_file" });
-    g_assert(stat(real_file, &st_real) == 0);
+    g_assert(stat(real_file_path, &st_real) == 0);
     g_assert((st_real.st_mode & S_IFMT) == S_IFREG);
 
     tlink({
         .client = v9p, .atPath = "08", .name = "hardlink_file",
         .toPath = "08/real_file"
     });
-    g_assert(stat(hardlink_file, &st_link) == 0);
+    g_assert(stat(hardlink_file_path, &st_link) == 0);
 
     tunlinkat({ .client = v9p, .atPath = "08", .name = "hardlink_file" });
     /* symlink should be gone now */
-    g_assert(stat(hardlink_file, &st_link) != 0);
+    g_assert(stat(hardlink_file_path, &st_link) != 0);
     /* and old file should still exist */
-    g_assert(stat(real_file, &st_real) == 0);
+    g_assert(stat(real_file_path, &st_real) == 0);
 }
 
 static void *assign_9p_local_driver(GString *cmd_line, void *arg)
-- 
2.44.0


