Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A34CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWxPB-0002i6-EK; Tue, 09 Jun 2026 10:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <cf4466391ba7822cef445f4bdb62498230c73d07@kylie.crudebyte.com>)
 id 1wWxP9-0002gX-Bj; Tue, 09 Jun 2026 10:26:11 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <cf4466391ba7822cef445f4bdb62498230c73d07@kylie.crudebyte.com>)
 id 1wWxP7-0001OA-Na; Tue, 09 Jun 2026 10:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=IV4PgttiUqlqURT7+C9EUr8y4+9zRUQRPXoakWSXJ4s=; b=OiaKB
 Mxv3i/Mq6zmVQfQtVhDj4FlnCVJfOlDzJLwbdE+3ztkw2KV2MzWXmAIhhgXKxBTaTrj/GjJY2TM2Z
 NKcjKdMC8/zxRNsNTsyAkeCMnz2u3gb4iCYlOGske9mJS6RmYj5QVpftRblKvuj+xLdRZTi5FKBhV
 xXqM6NvgRSXkHslck7eOtnIVFDV3nDCsxsItCkgqvCkyUH5L7DMjM3Tm1Isgzx6NwNdjSVDfWKkJq
 57Pjf4VnosIpAbrgMd7qR5eA64dZSJOooJb81d/DnmNw/b8v4OVPIsuyeYTcuSSJM/EYrUqvvL1TH
 ic4s4XFV19iqesqtBhOjDwOnfNPlACqkTzoFy9kMu+ypRRQcNArjQ//wRpYDdBQaUA2YzEu+BM26F
 gqNNCHQAuscCYlif3H7Um9BznOw5+BwLDIZgqH/fUrOIKm85CONXOc3pGiuUQptuw+0PB0W08T6em
 wlCPajiH3MwXhfNbTtk5ioZF+DhHxWWCERY7e1Va23Mby4QjYbH/KAxn3vIz6aEDgIUqqG8dZP1PK
 sov2P+ICUvfneKd0wihqTynY1z+LDEa9xy3A9EErvSz5iYOHJn2hxYvD4vELvBa1yJnLHC5Sdla12
 rPMcQFhq7WqhUT2oHOgyelQPlHeEM2+yCvtmf0z6ygUqjzqilbfuuKhucH0DWU=;
Message-ID: <cf4466391ba7822cef445f4bdb62498230c73d07.1781012549.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1781012549.git.qemu_oss@crudebyte.com>
References: <cover.1781012549.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 09 Jun 2026 15:47:06 +0200
Subject: [PATCH v2 12/12] tests/9p: add 3 xattr FID limit test cases (local fs
 driver)
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=cf4466391ba7822cef445f4bdb62498230c73d07@kylie.crudebyte.com;
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

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 69 ++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 2e88429dfa..d559f0f8a0 100644
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
@@ -1008,20 +1042,41 @@ static void cleanup_9p_local_driver(void *data)
     virtio_9p_remove_local_test_dir();
 }
 
-static void *assign_9p_local_driver(GString *cmd_line, void *arg)
+static void assign_9p_local_driver_with_args(GString *cmd_line,
+                                             const char *extra_opts)
 {
     /* make sure test dir for the 'local' tests exists */
     virtio_9p_create_local_test_dir();
 
-    virtio_9p_assign_local_driver(cmd_line, "security_model=mapped-xattr");
+    g_autofree char *opts = g_strdup("security_model=mapped-xattr");
+    if (extra_opts) {
+        opts = g_strdup_printf("%s,%s", opts, extra_opts);
+    }
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
 
@@ -1078,6 +1133,14 @@ static void register_virtio_9p_test(void)
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


