Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D85C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPdo-0006BA-5l; Wed, 27 Mar 2024 05:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpPdd-00067x-VX
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:32:08 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpPdb-0007hQ-Hp
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:32:05 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6da202aa138so3253778b3a.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1711531922; x=1712136722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZpweT3nmK6wwpDDzMjiVrCdC5R/qvdKZcUMpNV2zdM=;
 b=lP8PjhSzu4ha8Ey9xuvW8+1cl7DU9XkNyFgurO5OADsl27T0S+7P6BHNwnw0M4s3qq
 HE2nmQSGg/0Uvpwz61kqBItoqGcBoKVlNsLxT5pd7qxUhGJmXRF+4a0i9RyG5bx3kee/
 QYxhxjCLTeQYDL0JsWgQ7obTHZMnpIFONmmNWnD+OqU1Uq759jE6p0bD/rJ+5IcGUOlq
 QjT3Fw4zTB+wb4AkSBunU8n3hWV3NZlPl9uXywrJJG7Rs8MaKP662M6eq4XMn4iUrymh
 eKOUQz+fr52FS7C4fxAoCFotd3v7MO8BAO8rCBLpF0Al/UWXXy6TLAEpzlDK8Li0gmjL
 GOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711531922; x=1712136722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AZpweT3nmK6wwpDDzMjiVrCdC5R/qvdKZcUMpNV2zdM=;
 b=B/Q97jZHtW8YPuzPV1BZnDFqty8iAqZaefsj0kZQZ25P9980vc7w72CrjJDFrFhnVX
 IcIKwUutX1ImhqO++YttGadAi0q2esFG0VTnLW51HXbtT2gf2VksW8ZrkPMLRldrwxzQ
 ZnzZDnHnMkRFbc3oCH650GdICqbO2yORa7F70cOZv9xTNMA8VOX2efudCscvVe4cuBxf
 yH2k4hWpwbTHxgnwkhRLzR576vOP5nyDhAEni9eLttFFBP5E8HmMCn0QS4scOpjLelDy
 XUpz7CEyfhuKFgDcxA8+7utnTM1roSeMovNlkwZOzd9XsKMbL03AUR5Ub8N/NjQXlaQC
 wi9g==
X-Gm-Message-State: AOJu0YzOb5Ul+3N31tIk5A/IsaMuDEHIFeP26hJIpgcSrhKAqAw0RBWL
 2Qy9n/SJK7s+NnMSItdZVh6zhvYiW0ccJMGnp8IxnRDoiL4n+CJof8IPKvq1peLrhYL5EyZVHM2
 Q
X-Google-Smtp-Source: AGHT+IE8gNWMuqBsTHHCCGlyOS35JWmvZsCSfHIeFxVG+ylOzo4nXhyeTaO33yd/lbvNP01g+CLpnA==
X-Received: by 2002:a05:6a21:7896:b0:1a1:6803:69a3 with SMTP id
 bf22-20020a056a21789600b001a1680369a3mr2397973pzc.0.1711531921856; 
 Wed, 27 Mar 2024 02:32:01 -0700 (PDT)
Received: from grind.. ([177.45.186.241]) by smtp.gmail.com with ESMTPSA id
 fm23-20020a056a002f9700b006e6b41511fdsm7628760pfb.94.2024.03.27.02.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 02:32:01 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, alistair.francis@wdc.com, groug@kaod.org,
 peter.maydell@linaro.org, qemu_oss@crudebyte.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v2 4/7] qtest/virtio-9p-test.c: consolidate create
 file tests
Date: Wed, 27 Mar 2024 06:31:41 -0300
Message-ID: <20240327093144.781701-5-dbarboza@ventanamicro.com>
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

Similar to what was done with fs_create_dir() in the previous patch, and
for the same reasons, let's consolidate fs_create_file() and
fs_unlinkat_file() in a single test that has the same coverage:

- fs_create_file() is removed;

- rename fs_unlinkat_file() to fs_create_unlinkat_file();

- change fs_create_unlinkat_file() to also remove the created dir.

The remaining tests got their dir changed to reflect that we're now with
one less test.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 tests/qtest/virtio-9p-test.c | 42 ++++++++++++++----------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 2cea1b4189..75d4d1cf4b 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -534,31 +534,14 @@ static void fs_create_unlinkat_dir(void *obj, void *data,
     g_assert(stat(new_dir_path, &st) != 0);
 }
 
-static void fs_create_file(void *obj, void *data, QGuestAllocator *t_alloc)
+static void fs_create_unlinkat_file(void *obj, void *data,
+                                    QGuestAllocator *t_alloc)
 {
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st;
     const char *new_dir = "02";
-    g_autofree char *new_file = g_strdup_printf("%s/%s", new_dir, "1st_file");
-    g_autofree char *new_file_path = virtio_9p_test_path(new_file);
-
-    tattach({ .client = v9p });
-    tmkdir({ .client = v9p, .atPath = "/", .name = new_dir });
-    tlcreate({ .client = v9p, .atPath = new_dir, .name = "1st_file" });
-
-    /* check if created file exists now ... */
-    g_assert(stat(new_file_path, &st) == 0);
-    /* ... and is a regular file */
-    g_assert((st.st_mode & S_IFMT) == S_IFREG);
-}
-
-static void fs_unlinkat_file(void *obj, void *data, QGuestAllocator *t_alloc)
-{
-    QVirtio9P *v9p = obj;
-    v9fs_set_allocator(t_alloc);
-    struct stat st;
-    const char *new_dir = "03";
+    g_autofree char *new_dir_path = virtio_9p_test_path(new_dir);
     g_autofree char *new_file = g_strdup_printf("%s/%s", new_dir, "doa_file");
     g_autofree char *new_file_path = virtio_9p_test_path(new_file);
 
@@ -574,6 +557,13 @@ static void fs_unlinkat_file(void *obj, void *data, QGuestAllocator *t_alloc)
     tunlinkat({ .client = v9p, .atPath = new_dir, .name = "doa_file" });
     /* file should be gone now */
     g_assert(stat(new_file_path, &st) != 0);
+
+    /* cleanup: remove the created dir */
+    tunlinkat({
+        .client = v9p, .atPath = "/", .name = new_dir,
+        .flags = P9_DOTL_AT_REMOVEDIR
+    });
+    g_assert(stat(new_dir_path, &st) != 0);
 }
 
 static void fs_symlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
@@ -581,7 +571,7 @@ static void fs_symlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st;
-    const char *new_dir = "04";
+    const char *new_dir = "03";
     g_autofree char *real_file = NULL;
     g_autofree char *real_file_path = NULL;
     g_autofree char *symlink_file = NULL;
@@ -614,7 +604,7 @@ static void fs_unlinkat_symlink(void *obj, void *data,
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st;
-    const char *new_dir = "05";
+    const char *new_dir = "04";
     g_autofree char *real_file = NULL;
     g_autofree char *real_file_path = NULL;
     g_autofree char *symlink_file = NULL;
@@ -648,7 +638,7 @@ static void fs_hardlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st_real, st_link;
-    const char *new_dir = "06";
+    const char *new_dir = "05";
     g_autofree char *real_file = NULL;
     g_autofree char *real_file_path = NULL;
     g_autofree char *hardlink_file = NULL;
@@ -685,7 +675,7 @@ static void fs_unlinkat_hardlink(void *obj, void *data,
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st_real, st_link;
-    const char *new_dir = "07";
+    const char *new_dir = "06";
     g_autofree char *real_file = NULL;
     g_autofree char *real_file_path = NULL;
     g_autofree char *hardlink_file = NULL;
@@ -771,8 +761,8 @@ static void register_virtio_9p_test(void)
     qos_add_test("local/config", "virtio-9p", pci_config,  &opts);
     qos_add_test("local/create_unlinkat_dir", "virtio-9p",
                  fs_create_unlinkat_dir, &opts);
-    qos_add_test("local/create_file", "virtio-9p", fs_create_file, &opts);
-    qos_add_test("local/unlinkat_file", "virtio-9p", fs_unlinkat_file, &opts);
+    qos_add_test("local/create_unlinkat_file", "virtio-9p",
+                 fs_create_unlinkat_file, &opts);
     qos_add_test("local/symlink_file", "virtio-9p", fs_symlink_file, &opts);
     qos_add_test("local/unlinkat_symlink", "virtio-9p", fs_unlinkat_symlink,
                  &opts);
-- 
2.44.0


