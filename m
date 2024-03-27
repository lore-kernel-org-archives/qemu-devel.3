Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B168ECD11DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPdo-0006Bh-TQ; Wed, 27 Mar 2024 05:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpPdc-00067v-L0
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:32:08 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rpPda-0007gK-7Z
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:32:04 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-22a353217c3so1560549fac.1
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1711531919; x=1712136719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WyRw4RpAUjMROWRxa8n83txCjmXC/d2qLnvcFPrpXT0=;
 b=IoKPvo7KI7JQQ6FO9i70YZOdabMQB80CL+Gc6EIfd1//uMbsrlhGgLHTlqfo8klCeQ
 uiqY6Pln2dZq3RJndFqvVvdZtMYYF276x5sE5V2vSogQ5wJUdE/qeX9jszHI6mVBA+4r
 o+kVvQF7umJPDYuy2n/83F0Y45s2Z/SZRRSqwBCd6UUguIdsiKywP5dxWEsg+4YDqIAg
 xMUvvCivxvZNhGCZBJPxo5kWreBWXBCBlojprv57s6xu7kFqQFfHFzbt/S0T5vvEKVd5
 Hq24ciE4lTn18UDmE0T9RmKMG0zxsm7kxkFFJYBDFz7KWS7JDV7jsWyi5hnYJwkySXU/
 MYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711531919; x=1712136719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WyRw4RpAUjMROWRxa8n83txCjmXC/d2qLnvcFPrpXT0=;
 b=pRab/aYFNaJGiSspz+L8851GdNWHY35X9KHtYJlHBd4+ldYey2/TFUo+0D+5eSnTkT
 dMph7iwOraXnt2Ok56lKIt73IetTmvqJATD0rluMlapFrODdse2VmohFZTy5QekZ3Fef
 pgzfdVYT8l+NBoSbII338kvEdKb8T6HoOgE0m5AuweTSOzd6h1oSVSDh18qQLqvYRryg
 nhoKn5kcVc453187NFVrSSla/aiJ8VLbWsvdmGRdZ/O83QdIzLmogenjjzzXy2nQI8vz
 vKrpyWBKpGr9wXbYP6UCf6hlncI0e35nYhPlK/zsNZRltgvPdvKMuyB++Oi8YocS76MQ
 wIEw==
X-Gm-Message-State: AOJu0YzDzF32IjRYPp6szAARr0EsxJwUIYpunTwGCytSmyZkxIWJ/Xm+
 H3QSbTz1goEiw2ZgSc2gK6Yec1rDNFq7dGiyU23LCTCuO57PUkFapH+QcTnc3LlW1Ou82KJGrpR
 P
X-Google-Smtp-Source: AGHT+IG8YgU7L/GJNGMP5fw6uZ/FLqPFN9SAVIFv53bDx8dyHLlotZwzEZoscFQuzpf6Ri9TYGcBzg==
X-Received: by 2002:a05:6870:b14c:b0:229:fe3c:b096 with SMTP id
 a12-20020a056870b14c00b00229fe3cb096mr2271071oal.32.1711531919139; 
 Wed, 27 Mar 2024 02:31:59 -0700 (PDT)
Received: from grind.. ([177.45.186.241]) by smtp.gmail.com with ESMTPSA id
 fm23-20020a056a002f9700b006e6b41511fdsm7628760pfb.94.2024.03.27.02.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 02:31:58 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, alistair.francis@wdc.com, groug@kaod.org,
 peter.maydell@linaro.org, qemu_oss@crudebyte.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v2 3/7] qtest/virtio-9p-test.c: consolidate create dir
 tests
Date: Wed, 27 Mar 2024 06:31:40 -0300
Message-ID: <20240327093144.781701-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327093144.781701-1-dbarboza@ventanamicro.com>
References: <20240327093144.781701-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x35.google.com
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

The local 9p driver in virtio-9p-test.c its temporary dir right at the
start of qos-test (via virtio_9p_create_local_test_dir()) and only
deletes it after qos-test is finished (via
virtio_9p_remove_local_test_dir()).

This means that any qos-test machine that ends up running virtio-9p-test
local tests more than once will end up re-using the same temp dir. This
is what's happening in [1] after we introduced the riscv machine nodes:
if we enable slow tests with the '-m slow' flag using
qemu-system-riscv64, this is what happens:

- a temp dir is created;

- virtio-9p-device tests will run virtio-9p-test successfully;

- virtio-9p-pci tests will run virtio-9p-test, and fail right at the
  first slow test at fs_create_dir() because the "01" file was already
  created by fs_create_dir() test when running with the virtio-9p-device.

We can fix it by making every test clean up their changes in the
filesystem after they're done. But we don't need every test either: what
fs_create_file() does is already exercised in fs_unlinkat_dir(), i.e. a
dir is created, verified to be created, and then removed.  Fixing
fs_create_file() would turn it into fs_unlinkat_dir(), so we don't need
both.

The same idea applies to every test in virtio-9p-test.c, where the
'unlinkat' variant does the same thing the 'create' does but with some
cleaning in the end. But we'll start with fs_create_dir() and
fs_unlinkat_dir() only:

- fs_create_dir() is removed. s_unlinkat_dir() is renamed to
  fs_create_unlinkat_dir();

- update the dir names for every other test since we have 1 less test.

[1] https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg05807.html

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 tests/qtest/virtio-9p-test.c | 39 +++++++++---------------------------
 1 file changed, 10 insertions(+), 29 deletions(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index be031abc17..2cea1b4189 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -506,7 +506,8 @@ static void fs_readdir_split_512(void *obj, void *data,
 
 /* tests using the 9pfs 'local' fs driver */
 
-static void fs_create_dir(void *obj, void *data, QGuestAllocator *t_alloc)
+static void fs_create_unlinkat_dir(void *obj, void *data,
+                                   QGuestAllocator *t_alloc)
 {
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
@@ -524,26 +525,6 @@ static void fs_create_dir(void *obj, void *data, QGuestAllocator *t_alloc)
     g_assert(stat(new_dir_path, &st) == 0);
     /* ... and is actually a directory */
     g_assert((st.st_mode & S_IFMT) == S_IFDIR);
-}
-
-static void fs_unlinkat_dir(void *obj, void *data, QGuestAllocator *t_alloc)
-{
-    QVirtio9P *v9p = obj;
-    v9fs_set_allocator(t_alloc);
-    struct stat st;
-    const char *new_dir = "02";
-    g_autofree char *root_path = virtio_9p_test_path("");
-    g_autofree char *new_dir_path = virtio_9p_test_path(new_dir);
-
-    g_assert(root_path != NULL);
-
-    tattach({ .client = v9p });
-    tmkdir({ .client = v9p, .atPath = "/", .name = new_dir });
-
-    /* check if created directory really exists now ... */
-    g_assert(stat(new_dir_path, &st) == 0);
-    /* ... and is actually a directory */
-    g_assert((st.st_mode & S_IFMT) == S_IFDIR);
 
     tunlinkat({
         .client = v9p, .atPath = "/", .name = new_dir,
@@ -558,7 +539,7 @@ static void fs_create_file(void *obj, void *data, QGuestAllocator *t_alloc)
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st;
-    const char *new_dir = "03";
+    const char *new_dir = "02";
     g_autofree char *new_file = g_strdup_printf("%s/%s", new_dir, "1st_file");
     g_autofree char *new_file_path = virtio_9p_test_path(new_file);
 
@@ -577,7 +558,7 @@ static void fs_unlinkat_file(void *obj, void *data, QGuestAllocator *t_alloc)
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st;
-    const char *new_dir = "04";
+    const char *new_dir = "03";
     g_autofree char *new_file = g_strdup_printf("%s/%s", new_dir, "doa_file");
     g_autofree char *new_file_path = virtio_9p_test_path(new_file);
 
@@ -600,7 +581,7 @@ static void fs_symlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st;
-    const char *new_dir = "05";
+    const char *new_dir = "04";
     g_autofree char *real_file = NULL;
     g_autofree char *real_file_path = NULL;
     g_autofree char *symlink_file = NULL;
@@ -633,7 +614,7 @@ static void fs_unlinkat_symlink(void *obj, void *data,
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st;
-    const char *new_dir = "06";
+    const char *new_dir = "05";
     g_autofree char *real_file = NULL;
     g_autofree char *real_file_path = NULL;
     g_autofree char *symlink_file = NULL;
@@ -667,7 +648,7 @@ static void fs_hardlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st_real, st_link;
-    const char *new_dir = "07";
+    const char *new_dir = "06";
     g_autofree char *real_file = NULL;
     g_autofree char *real_file_path = NULL;
     g_autofree char *hardlink_file = NULL;
@@ -704,7 +685,7 @@ static void fs_unlinkat_hardlink(void *obj, void *data,
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st_real, st_link;
-    const char *new_dir = "08";
+    const char *new_dir = "07";
     g_autofree char *real_file = NULL;
     g_autofree char *real_file_path = NULL;
     g_autofree char *hardlink_file = NULL;
@@ -788,8 +769,8 @@ static void register_virtio_9p_test(void)
 
     opts.before = assign_9p_local_driver;
     qos_add_test("local/config", "virtio-9p", pci_config,  &opts);
-    qos_add_test("local/create_dir", "virtio-9p", fs_create_dir, &opts);
-    qos_add_test("local/unlinkat_dir", "virtio-9p", fs_unlinkat_dir, &opts);
+    qos_add_test("local/create_unlinkat_dir", "virtio-9p",
+                 fs_create_unlinkat_dir, &opts);
     qos_add_test("local/create_file", "virtio-9p", fs_create_file, &opts);
     qos_add_test("local/unlinkat_file", "virtio-9p", fs_unlinkat_file, &opts);
     qos_add_test("local/symlink_file", "virtio-9p", fs_symlink_file, &opts);
-- 
2.44.0


