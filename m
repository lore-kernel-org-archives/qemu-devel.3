Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C1BC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiflR-0005R2-4Y; Sat, 11 Jul 2026 18:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wiflO-0005KI-Ve; Sat, 11 Jul 2026 18:01:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wiflM-0008HW-UV; Sat, 11 Jul 2026 18:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807180; bh=QONICYvc3aooVcn8WP9NviLmeUnqTcw8CveB6thepP8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oqrJU71ytJBS+mXzsNqpqa3oH9CMyeKi/sGDBYrzTgWkOGYbKNudl/ErYxcaAoEDN
 emPI42cP6m+YsbeHCTIHtPlcRp6qI9CAZBoY+yTL6PGjmpsLcLr5S7nhOXYxMleF3+
 JxLQ6nAvUc/r4J9rK83yoC658BlFPEbjom6Z43gqDF5CDWYnmbEBqvJKKw2LENr2ql
 Hr2n+AzL2p+B9TCH26x9VAWB8rOfwg2s8ZWNvlaLeRdE/YWRUnL8n5s44M17NOYrO9
 T73QPo5d58qAQ3Yb+B3LIl67sy8rXVe+2bTfp9Wy6zK5px7BS53PPs/z4Lw5HcdlLs
 gg7ogeUXt1b2A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9676A1C0AA2;
 Sun, 12 Jul 2026 00:59:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4DFEA3EAF2D;
 Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6BA5313311; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 23/81] tests/9p: add 3 xattr FID limit test cases
 (local fs driver)
Date: Sun, 12 Jul 2026 00:58:01 +0300
Message-ID: <20260711215904.3757-23-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

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
(cherry picked from commit 04a62cdfe873d07a5f264d03372bfc34bbcdddf0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 2e88429dfa1..cfd3c02da45 100644
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
     return arg;
 }
 
-static void register_virtio_9p_test(void)
+static void *local_max_xattr_custom_opt(GString *cmd_line, void *arg)
 {
+    assign_9p_local_driver_with_args(cmd_line, "max_xattr=100");
+    return arg;
+}
 
+static void *local_max_xattr_unlimited_opt(GString *cmd_line, void *arg)
+{
+    assign_9p_local_driver_with_args(cmd_line, "max_xattr=0");
+    return arg;
+}
+
+static void register_virtio_9p_test(void)
+{
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


