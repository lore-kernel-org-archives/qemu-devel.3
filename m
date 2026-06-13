Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D815CD98C5
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 15:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYQJY-00081r-Gs; Sat, 13 Jun 2026 11:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <540c51faa074d9dd736bbf2170084a12288e23ef@kylie.crudebyte.com>)
 id 1wYQJP-0007yy-KK; Sat, 13 Jun 2026 11:30:19 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <540c51faa074d9dd736bbf2170084a12288e23ef@kylie.crudebyte.com>)
 id 1wYQJM-0005KK-U7; Sat, 13 Jun 2026 11:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=f5dQ2tNqI9ayHMeWdYoVc8SEf+8Gv+EqgITBot4K7RI=; b=a58pd
 Y/0g0OlmoS/0s/vfliXcL1XCIqbKK3tGS3gimYrwpyei1md89pNZ0pUsoiem+0V013w2xolBGhCQZ
 5XUmq4dp4AZBG5awZZlHRF0Hs9TiPnnqAYQxpTOsHBS0I5O4T/zwFXKTJAdJneXfzrG7Y4nFwe3cW
 t6vrHE0d5FX/uJb+jwq+dHnVRIs1fSMKdKfSU8YmA4zh6x/ciacNbyB9n1P70Z1vRYKfHhcqY1mPM
 AnmvxHJ2XezkYRAsmnQdhX739NPfGBjp8uugxBTC+4qf+d3bN766fVIpWl0y7zNq62tv7ViWGjBKp
 +euONlXPMiKNpfUY/8QovFgNdDYPUW0SMQlGF+2ijC56LGlj7wCdYyTkANFKNPlftZ1D54NSpd1AL
 dz2wWgOYoZQKe/A2euIK5EtbgvXOKnDcDJI4Ftu3v0F8XKKK+8V7XdA6k01HYkZBgNL60rWtrRYj0
 AYT0MtVndQhCTJdIRer5tUw+Q5D/YulLYCIlU2dyQoLz0qgh/zOtYaFCVoFV3/WK4tPgpPOuFqUYa
 ZuWHokFXfrPA9Zxxy1KcNfIlwcTzCU8rut1fz3SDCDkXf33LJBkGCZ92FSBtTO7XKH2VzXLIHU6sK
 Cvjiv5CmYPSD1kQdpbs1hi/oW4iugNDXblMLUkIDiINLvF4yA68/UK13WNNxWI=;
Message-ID: <540c51faa074d9dd736bbf2170084a12288e23ef.1781361555.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1781361555.git.qemu_oss@crudebyte.com>
References: <cover.1781361555.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sat, 13 Jun 2026 16:55:49 +0200
Subject: [PATCH v3 11/12] tests/9p: add 3 xattr FID limit test cases (synth fs
 driver)
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=540c51faa074d9dd736bbf2170084a12288e23ef@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add 3 test cases to verify correct xattr FID limit enforcement of
9pfs server.

 - 1. test with default max_xattr=1024
 - 2. test with custom max_xattr=100
 - 3. test with unlimited max_xattr=0

These are tests using the synth driver. Advantage: by using the
synth driver the tests cannot only check when the xattr FID limit
kicks in (server would return an Rlerror response with ENOSPC),
but can also validate the current 9p server internal xattr FID
counter at any moment.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 189 ++++++++++++++++++++++++++++++++++-
 1 file changed, 188 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 99a897b158..2e88429dfa 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -35,6 +35,15 @@
 #define tclunk(...) v9fs_tclunk((TClunkOpt) __VA_ARGS__)
 #define txattrcreate(...) v9fs_txattrcreate((TXattrCreateOpt) __VA_ARGS__)
 
+/*
+ * xattr size to be used for xattr tests
+ *
+ * 64k is the max. xattr size supported by the Linux kernel, However btrfs
+ * for instance supports only 16219 bytes. So let's be conservative and
+ * just use 8k for the xattr tests.
+ */
+#define TEST_XATTR_SIZE (8 * 1024)
+
 static void pci_config(void *obj, void *data, QGuestAllocator *t_alloc)
 {
     QVirtio9P *v9p = obj;
@@ -107,6 +116,42 @@ static bool fs_dirents_contain_name(struct V9fsDirent *e, const char* name)
     return false;
 }
 
+/*
+ * Returns the current internal xattr FID count (works with synth driver only).
+ */
+static size_t get_xattr_count(QVirtio9P *v9p)
+{
+    uint16_t nwqid;
+    v9fs_qid *wqid;
+    const char *xattr_count_path[] = { "stat", "xattr_count" };
+    size_t xattr_count;
+    uint32_t bytes_read;
+
+    /* walk to /stat/xattr_count file */
+    uint32_t fid = twalk({
+        .client = v9p, .fid = 0,
+        .nwname = 2, .wnames = (char **)xattr_count_path,
+        .rwalk = { .nwqid = &nwqid, .wqid = &wqid }
+    }).newfid;
+
+    /* open for read */
+    tlopen({
+        .client = v9p, .fid = fid, .flags = O_RDONLY,
+        .rlopen = { .qid = NULL, .iounit = NULL }
+    });
+
+    /* read the internal xattr FID count */
+    tread({
+        .client = v9p, .fid = fid, .offset = 0, .count = sizeof(xattr_count),
+        .rread = { .count = &bytes_read, .data = &xattr_count }
+    });
+
+    /* cleanup */
+    tclunk({ .client = v9p, .fid = fid });
+
+    return xattr_count;
+}
+
 /* basic readdir test where reply fits into a single response message */
 static void fs_readdir(void *obj, void *data, QGuestAllocator *t_alloc)
 {
@@ -248,6 +293,108 @@ static void do_readdir_split(QVirtio9P *v9p, uint32_t count)
     g_free(wnames[0]);
 }
 
+/*
+ * Test 9p server's xattr FID count limit enforcement.
+ *
+ * Shared test code for both 'synth' and 'local' driver to verify correct
+ * behaviour of 9p server enforcing preconfigured xattr FID count limit
+ * correctly.
+ *
+ * @v9p: 9pfs client
+ *
+ * @max_xattr: max. allowed xattr FIDs, or -1 for infinite
+ *
+ * @check_counter: whether to verify 9p server internal xattr FID counter
+ *                 (only works with 'synth' fs driver)
+ */
+static void do_xattr_limit(QVirtio9P *v9p, int max_xattr, bool check_counter)
+{
+    size_t count;
+    int i;
+    int limit = (max_xattr != -1) ? max_xattr : V9FS_MAX_XATTR_DEFAULT + 100;
+    g_autofree uint32_t *fids = g_new0(uint32_t, limit);
+    uint32_t err_fid = 0;
+    const char *file_path[] = { QTEST_V9FS_SYNTH_WRITE_FILE };
+    g_autofree uint8_t *xattr_data = g_malloc(TEST_XATTR_SIZE);
+
+    if (!g_test_slow()) {
+        g_test_skip("This is a slow test, run with -m slow");
+        return;
+    }
+
+    /* prepare xattr data with 'X' characters */
+    memset(xattr_data, 'X', TEST_XATTR_SIZE);
+
+    tattach({ .client = v9p });
+
+    /* create max. amount of permitted xattrs */
+    for (i = 0; i < limit; i++) {
+        /* walk to create a new fid */
+        fids[i] = twalk({
+            .client = v9p, .fid = 0,
+            .nwname = 1, .wnames = (char **) file_path
+        }).newfid;
+
+        /* create new xattr fid */
+        txattrcreate({
+            .client = v9p, .fid = fids[i], .name = "user.test",
+            .size = TEST_XATTR_SIZE, .flags = 0
+        });
+
+        /* transfer the xattr data */
+        twrite({
+            .client = v9p, .fid = fids[i], .offset = 0,
+            .count = TEST_XATTR_SIZE, .data = xattr_data
+        });
+
+        /* verify server internal xattr counter */
+        if (check_counter) {
+            count = get_xattr_count(v9p);
+            g_assert_cmpuint(count, ==, (i + 1));
+        }
+
+        /* avoid virtio descriptor exhaustion */
+        qvirtqueue_reset_pool(v9p->vq);
+    }
+
+    /* if xattrs are limited, the next xattr should fail */
+    if (max_xattr != -1) {
+        /* walk to create another fid */
+        err_fid = twalk({
+            .client = v9p, .fid = 0,
+            .nwname = 1, .wnames = (char **) file_path
+        }).newfid;
+
+        /* try to create one more xattr fid - should fail */
+        txattrcreate({
+            .client = v9p, .fid = err_fid, .name = "user.test_exceed",
+            .size = TEST_XATTR_SIZE, .flags = 0,
+            .expectErr = ENOSPC
+        });
+
+        /* verify internal xattr counter hasn't changed */
+        if (check_counter) {
+            count = get_xattr_count(v9p);
+            g_assert_cmpuint(count, ==, limit);
+        }
+    }
+
+    /* clunk all fids (should decrement xattr counter) */
+    for (i = 0; i < limit; i++) {
+        tclunk({ .client = v9p, .fid = fids[i] });
+        qvirtqueue_reset_pool(v9p->vq);
+    }
+    if (err_fid) {
+        tclunk({ .client = v9p, .fid = err_fid });
+    }
+
+    /* verify internal xattr counter is zero */
+    if (check_counter) {
+        count = get_xattr_count(v9p);
+        g_assert_cmpuint(count, ==, 0);
+    }
+}
+
 static void fs_walk_no_slash(void *obj, void *data, QGuestAllocator *t_alloc)
 {
     QVirtio9P *v9p = obj;
@@ -508,6 +655,27 @@ static void fs_readdir_split_512(void *obj, void *data,
     do_readdir_split(obj, 512);
 }
 
+static void fs_synth_xattr_limit_default(void *obj, void *data,
+                                         QGuestAllocator *t_alloc)
+{
+    v9fs_set_allocator(t_alloc);
+    do_xattr_limit(obj, V9FS_MAX_XATTR_DEFAULT, true);
+}
+
+static void fs_synth_xattr_limit_custom(void *obj, void *data,
+                                        QGuestAllocator *t_alloc)
+{
+    v9fs_set_allocator(t_alloc);
+    do_xattr_limit(obj, 100, true);
+}
+
+static void fs_synth_xattr_limit_unlimited(void *obj, void *data,
+                                           QGuestAllocator *t_alloc)
+{
+    v9fs_set_allocator(t_alloc);
+    do_xattr_limit(obj, -1, true);
+}
+
 
 /* tests using the 9pfs 'local' fs driver */
 
@@ -822,6 +990,18 @@ static void fs_deep_absolute_path(void *obj, void *data,
     g_string_free(path, TRUE);
 }
 
+static void *synth_max_xattr_custom_opt(GString *cmd_line, void *arg)
+{
+    virtio_9p_add_synth_driver_args(cmd_line, "max_xattr=100");
+    return arg;
+}
+
+static void *synth_max_xattr_unlimited_opt(GString *cmd_line, void *arg)
+{
+    virtio_9p_add_synth_driver_args(cmd_line, "max_xattr=0");
+    return arg;
+}
+
 static void cleanup_9p_local_driver(void *data)
 {
     /* remove previously created test dir when test is completed */
@@ -872,7 +1052,14 @@ static void register_virtio_9p_test(void)
                  fs_readdir_split_256,  &opts);
     qos_add_test("synth/readdir/split_128", "virtio-9p",
                  fs_readdir_split_128,  &opts);
-
+    qos_add_test("synth/xattr_limit/default", "virtio-9p",
+                 fs_synth_xattr_limit_default, &opts);
+    opts.before = synth_max_xattr_custom_opt;
+    qos_add_test("synth/xattr_limit/custom", "virtio-9p",
+                 fs_synth_xattr_limit_custom, &opts);
+    opts.before = synth_max_xattr_unlimited_opt;
+    qos_add_test("synth/xattr_limit/unlimited", "virtio-9p",
+                 fs_synth_xattr_limit_unlimited, &opts);
 
     /* 9pfs test cases using the 'local' filesystem driver */
     opts.before = assign_9p_local_driver;
-- 
2.47.3


