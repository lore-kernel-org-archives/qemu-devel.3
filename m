Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03394C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCEn-0008Cb-0a; Mon, 29 Jun 2026 09:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <04a62cdfe873d07a5f264d03372bfc34bbcdddf0@kylie.crudebyte.com>)
 id 1weCEP-0007v8-VJ; Mon, 29 Jun 2026 09:41:03 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <04a62cdfe873d07a5f264d03372bfc34bbcdddf0@kylie.crudebyte.com>)
 id 1weCEN-0005I5-QU; Mon, 29 Jun 2026 09:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=7AFGGj9Ou8CnL4bL5HPzO5qkBolyqEML9C9hyGbWiu4=; b=faDdB
 WzRfKKwOzknjcw3ocwzIC0OHFnS9KEx3HHZvN8gfzabbB1ozDXVRQ3zSV7wqtVFMcOKqkWONltm36
 D8WMMgRdHMKj1eMdpHu6ZPjE84xvLX06LMUNRrYMDoKSNHzMxM3u0X/FXREFt493Z1gc3meLQq8Ro
 PcBqOy4rFQSVUsxvYW7jOZurJR3bWlsfAb9mEIZXpWsEJQzkuWPBM6EhoOOl/Y+sMyzDMgV6HW3BC
 GRhAfFAdUgu3yasYKG6gxoYLJSjSKMEyVLD9h+mM3Bf5Geba9lakSwDqKRWOvYH59SWF2YbksO66q
 HPj+R0Hp4TraQRfhal7/dpMea1uPyHkZgonSWZ5wWvzpHsyKWuYoh7ri5wr7XuiqVbWmz8WoWK3g4
 H2ufVd7JuMZDCxWbMXEmJLXgZZtnHuDCP6zOJtpaZG07s2BalhjdzldwNGUFldaRvjBHXy6LNkgay
 +jtgvr3g36MOqpLoWfrROU5LGBKngFl6w8ZblMbqAeLlIMPO2Q5pg1HhMzm3+62pkpy1u9Yo1nLXh
 ZAFYKyfSgZoK9qpOGKkhJAPI7FVfoxUumlhcq12Dk7bxvn1L5f1U0U5O1FcHEByd+2/AUCYlP9qAf
 iy6GvlSTXExQ3lNAMGMHVCc9hRVkjbqLPiNIBaL7aCGU24lCiBA7iZuo6tJLGc=;
Message-ID: <04a62cdfe873d07a5f264d03372bfc34bbcdddf0.1782739719.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1782739719.git.qemu_oss@crudebyte.com>
References: <cover.1782739719.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 29 Jun 2026 15:28:39 +0200
Subject: [PULL 20/23] tests/9p: add 3 xattr FID limit test cases (local fs
 driver)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=04a62cdfe873d07a5f264d03372bfc34bbcdddf0@kylie.crudebyte.com;
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

Analogue to the previously added 3 synth tests, add (similar) 3 test
cases using the "local" fs driver to verify correct xattr FID limit
enforcement of 9pfs server with a real filesystem.

These 3 new local tests use the shared test code of the previously
added 3 synth tests. The only difference is that the local fs driver
does not expose the current internal xattr FID counter, so we can't
verify this with the local tests.

This is a slow test (may take several seconds) and therefore
registered as "slow" test and not running by default.

Use -m slow to run this test.

Link: https://lore.kernel.org/qemu-devel/d23fa874df4f474ee7cbe738a35c1483426057f0.1781361555.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 70 ++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 2e88429dfa..cfd3c02da4 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -395,6 +395,19 @@ static void do_xattr_limit(QVirtio9P *v9p, int max_xattr, bool check_counter)
     }
 }
 
+static void do_local_xattr_limit(QVirtio9P *v9p, int max_xattr)
+{
+    g_autofree char *test_file = virtio_9p_test_path("WRITE");
+
+    /*
+     * this file must be created for the test to work with the 'local' fs driver
+     */
+    g_file_set_contents(test_file, "", 0, NULL);
+
+    /* the actual test code shared with the 'synth' fs driver tests */
+    do_xattr_limit(v9p, max_xattr, false);
+}
+
 static void fs_walk_no_slash(void *obj, void *data, QGuestAllocator *t_alloc)
 {
     QVirtio9P *v9p = obj;
@@ -990,6 +1003,27 @@ static void fs_deep_absolute_path(void *obj, void *data,
     g_string_free(path, TRUE);
 }
 
+static void fs_local_xattr_limit_default(void *obj, void *data,
+                                         QGuestAllocator *t_alloc)
+{
+    v9fs_set_allocator(t_alloc);
+    do_local_xattr_limit(obj, V9FS_MAX_XATTR_DEFAULT);
+}
+
+static void fs_local_xattr_limit_custom(void *obj, void *data,
+                                        QGuestAllocator *t_alloc)
+{
+    v9fs_set_allocator(t_alloc);
+    do_local_xattr_limit(obj, 100);
+}
+
+static void fs_local_xattr_limit_unlimited(void *obj, void *data,
+                                           QGuestAllocator *t_alloc)
+{
+    v9fs_set_allocator(t_alloc);
+    do_local_xattr_limit(obj, -1);
+}
+
 static void *synth_max_xattr_custom_opt(GString *cmd_line, void *arg)
 {
     virtio_9p_add_synth_driver_args(cmd_line, "max_xattr=100");
@@ -1008,20 +1042,42 @@ static void cleanup_9p_local_driver(void *data)
     virtio_9p_remove_local_test_dir();
 }
 
-static void *assign_9p_local_driver(GString *cmd_line, void *arg)
+static void assign_9p_local_driver_with_args(GString *cmd_line,
+                                             const char *extra_opts)
 {
     /* make sure test dir for the 'local' tests exists */
     virtio_9p_create_local_test_dir();
 
-    virtio_9p_assign_local_driver(cmd_line, "security_model=mapped-xattr");
+    g_autofree char *opts =
+        (extra_opts) ?
+            g_strdup_printf("security_model=mapped-xattr,%s", extra_opts) :
+            g_strdup("security_model=mapped-xattr");
+
+    virtio_9p_assign_local_driver(cmd_line, opts);
 
     g_test_queue_destroy(cleanup_9p_local_driver, NULL);
+}
+
+static void *assign_9p_local_driver(GString *cmd_line, void *arg)
+{
+    assign_9p_local_driver_with_args(cmd_line, NULL);
+    return arg;
+}
+
+static void *local_max_xattr_custom_opt(GString *cmd_line, void *arg)
+{
+    assign_9p_local_driver_with_args(cmd_line, "max_xattr=100");
+    return arg;
+}
+
+static void *local_max_xattr_unlimited_opt(GString *cmd_line, void *arg)
+{
+    assign_9p_local_driver_with_args(cmd_line, "max_xattr=0");
     return arg;
 }
 
 static void register_virtio_9p_test(void)
 {
-
     QOSGraphTestOptions opts = {
     };
 
@@ -1078,6 +1134,14 @@ static void register_virtio_9p_test(void)
                  &opts);
     qos_add_test("local/deep_absolute_path", "virtio-9p",
                  fs_deep_absolute_path, &opts);
+    qos_add_test("local/xattr_limit/default", "virtio-9p",
+                 fs_local_xattr_limit_default, &opts);
+    opts.before = local_max_xattr_custom_opt;
+    qos_add_test("local/xattr_limit/custom", "virtio-9p",
+                 fs_local_xattr_limit_custom, &opts);
+    opts.before = local_max_xattr_unlimited_opt;
+    qos_add_test("local/xattr_limit/unlimited", "virtio-9p",
+                 fs_local_xattr_limit_unlimited, &opts);
 }
 
 libqos_init(register_virtio_9p_test);
-- 
2.47.3


