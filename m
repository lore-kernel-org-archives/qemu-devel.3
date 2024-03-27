Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94055C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPdo-0006BH-Ha; Wed, 27 Mar 2024 05:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpPdi-00069v-6L
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:32:11 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpPdf-0007l6-5t
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:32:08 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6ea8ee55812so4011362b3a.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1711531924; x=1712136724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZk8Q5ZMP3H348YFajK/KsGoIsIEqBXjitss5B3q9oM=;
 b=C84grWLNiYnarXvKavRUZHV8AY051ILUYxszZyhWQ6z/wOT9TNq9PLpriv8QhlEz36
 DUGSbTQnh1ZD7+8nltZLkg1DWvm8qgv00UpPCHmQZ4etzJxRjguC51MDwfMKABCmQpu7
 pVvmSjcSzKzV76X1rvmAW+E0aFRR/Ii+ju7IKHG8ipwEoeEuJmp77KHoHllQ6/T9FpKO
 5DO/+BC6rChzOyw6lYANkT8zB95TFFeLz6EzLHsR38Ii9hSkv0w5uxWuB9NnavEswrXi
 9V9HIKFcQ1p+OdSaexeYt48hWRc6scOcUy/+8EU8XanHVbFDA3NhaonjoCU3tEVvjhCa
 ZiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711531924; x=1712136724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HZk8Q5ZMP3H348YFajK/KsGoIsIEqBXjitss5B3q9oM=;
 b=iNCqS3fDqCtpvDRO8zxmJLc9mCzSpWEIKqbYg3z4XETNvNd3TCfhgd+j1EHPk76vvs
 STd0ZHeMCK8Ut+8e0HTAkujvoEJJveecijw8xEk9s7LNchCmkhPQfAsM4XtjoD5eovUv
 WOqPiTsT7ae6OoJc5CXFjZO3bAf596GXV6CR1BAHE5tQos+oRp6Osq+f6u0fghlzfP+4
 0j2aIBMxAmzrVhjGpqAUC4XdeZZ5aUA67OsLl2mScXbGrbyjzgj1iSfHi4TE33NDGLiN
 hC5j9C4aG/pLYpgRNlyLJFL8BxNxkk2YKteh0wqboOrUkeT8ngOfTv0zgn1VMWwNf+tw
 HaXw==
X-Gm-Message-State: AOJu0YxQMLEZJhRPvSfg5qr0jEvM1ce00RAwwu40sjyap3mMvpdLs2+C
 UkEKyMvy50mv3WJLGjTCtr/7OTWWehWVFFik2+565Us9nkF74AcV8ikKF4Z+iGFXVMPg/XG4atu
 A
X-Google-Smtp-Source: AGHT+IHcghAAR0NtsQDisW+TA9jKAiNbhCPGw4C+73Ao3z82iqPe93IXUluamfuqBLCxGtkzvudaFg==
X-Received: by 2002:a05:6a00:22c4:b0:6ea:92de:3603 with SMTP id
 f4-20020a056a0022c400b006ea92de3603mr865523pfj.16.1711531924412; 
 Wed, 27 Mar 2024 02:32:04 -0700 (PDT)
Received: from grind.. ([177.45.186.241]) by smtp.gmail.com with ESMTPSA id
 fm23-20020a056a002f9700b006e6b41511fdsm7628760pfb.94.2024.03.27.02.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 02:32:04 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, alistair.francis@wdc.com, groug@kaod.org,
 peter.maydell@linaro.org, qemu_oss@crudebyte.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v2 5/7] qtest/virtio-9p-test.c: consolidate create
 symlink tests
Date: Wed, 27 Mar 2024 06:31:42 -0300
Message-ID: <20240327093144.781701-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327093144.781701-1-dbarboza@ventanamicro.com>
References: <20240327093144.781701-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x430.google.com
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

fs_unlinkat_symlink() does the same thing as fs_symlink_file() while
also removing the created symlink. We also want every test to not leave
stuff behind after each run to avoid subsequential runs to fail.

We can achieve all that by:

- remove fs_unlinkat_symlink(). fs_unlinkat_symlink() is now named
  fs_create_unlinkat_symlink();

- remove 'real_file' and the created dir at the end of
  fs_create_unlinkat_symlink().

The hardlink tests dir names were updated because now we have one less
test.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 tests/qtest/virtio-9p-test.c | 54 ++++++++++++------------------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 75d4d1cf4b..222d11037d 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -566,12 +566,14 @@ static void fs_create_unlinkat_file(void *obj, void *data,
     g_assert(stat(new_dir_path, &st) != 0);
 }
 
-static void fs_symlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
+static void fs_create_unlinkat_symlink(void *obj, void *data,
+                                       QGuestAllocator *t_alloc)
 {
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st;
     const char *new_dir = "03";
+    g_autofree char *new_dir_path = virtio_9p_test_path(new_dir);
     g_autofree char *real_file = NULL;
     g_autofree char *real_file_path = NULL;
     g_autofree char *symlink_file = NULL;
@@ -596,41 +598,20 @@ static void fs_symlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
 
     /* check if created link exists now */
     g_assert(stat(symlink_file_path, &st) == 0);
-}
-
-static void fs_unlinkat_symlink(void *obj, void *data,
-                                QGuestAllocator *t_alloc)
-{
-    QVirtio9P *v9p = obj;
-    v9fs_set_allocator(t_alloc);
-    struct stat st;
-    const char *new_dir = "04";
-    g_autofree char *real_file = NULL;
-    g_autofree char *real_file_path = NULL;
-    g_autofree char *symlink_file = NULL;
-    g_autofree char *symlink_file_path = NULL;
-
-    real_file = g_strdup_printf("%s/%s", new_dir, "real_file");
-    real_file_path = virtio_9p_test_path(real_file);
-
-    symlink_file = g_strdup_printf("%s/%s", new_dir, "symlink_file");
-    symlink_file_path = virtio_9p_test_path(symlink_file);
-
-    tattach({ .client = v9p });
-    tmkdir({ .client = v9p, .atPath = "/", .name = new_dir });
-    tlcreate({ .client = v9p, .atPath = new_dir, .name = "real_file" });
-    g_assert(stat(real_file_path, &st) == 0);
-    g_assert((st.st_mode & S_IFMT) == S_IFREG);
-
-    tsymlink({
-        .client = v9p, .atPath = new_dir, .name = "symlink_file",
-        .symtgt = "real_file"
-    });
-    g_assert(stat(symlink_file_path, &st) == 0);
 
     tunlinkat({ .client = v9p, .atPath = new_dir, .name = "symlink_file" });
     /* symlink should be gone now */
     g_assert(stat(symlink_file_path, &st) != 0);
+
+    /* cleanup: remove created file and dir */
+    tunlinkat({ .client = v9p, .atPath = new_dir, .name = "real_file" });
+    g_assert(stat(real_file_path, &st) != 0);
+
+    tunlinkat({
+        .client = v9p, .atPath = "/", .name = new_dir,
+        .flags = P9_DOTL_AT_REMOVEDIR
+    });
+    g_assert(stat(new_dir_path, &st) != 0);
 }
 
 static void fs_hardlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
@@ -638,7 +619,7 @@ static void fs_hardlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st_real, st_link;
-    const char *new_dir = "05";
+    const char *new_dir = "04";
     g_autofree char *real_file = NULL;
     g_autofree char *real_file_path = NULL;
     g_autofree char *hardlink_file = NULL;
@@ -675,7 +656,7 @@ static void fs_unlinkat_hardlink(void *obj, void *data,
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st_real, st_link;
-    const char *new_dir = "06";
+    const char *new_dir = "05";
     g_autofree char *real_file = NULL;
     g_autofree char *real_file_path = NULL;
     g_autofree char *hardlink_file = NULL;
@@ -763,9 +744,8 @@ static void register_virtio_9p_test(void)
                  fs_create_unlinkat_dir, &opts);
     qos_add_test("local/create_unlinkat_file", "virtio-9p",
                  fs_create_unlinkat_file, &opts);
-    qos_add_test("local/symlink_file", "virtio-9p", fs_symlink_file, &opts);
-    qos_add_test("local/unlinkat_symlink", "virtio-9p", fs_unlinkat_symlink,
-                 &opts);
+    qos_add_test("local/create_unlinkat_symlink", "virtio-9p",
+                 fs_create_unlinkat_symlink, &opts);
     qos_add_test("local/hardlink_file", "virtio-9p", fs_hardlink_file, &opts);
     qos_add_test("local/unlinkat_hardlink", "virtio-9p", fs_unlinkat_hardlink,
                  &opts);
-- 
2.44.0


