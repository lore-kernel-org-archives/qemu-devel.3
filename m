Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311B2CD8CA4
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2026 17:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWHmF-0000Ko-Pk; Sun, 07 Jun 2026 13:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <7840fbdba06d0f4c45cac96a0a9aa35681ef177f@kylie.crudebyte.com>)
 id 1wWHmE-0000Ju-27; Sun, 07 Jun 2026 13:59:14 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <7840fbdba06d0f4c45cac96a0a9aa35681ef177f@kylie.crudebyte.com>)
 id 1wWHmC-0004KR-Fm; Sun, 07 Jun 2026 13:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=j+IJKoaTTT2cxXkfp0g/5zvDk/18rKDB/i3pyHZ0ieY=; b=ck0v4
 Ag917os6/3AG8KJIwcWoVk9MDsUm0Gz+/IBPB6a0OEFH9G+eF27hb1OMPb9CbwOrivu/jB1jvychT
 qgOi14PaxumE2gX+tG3d/vopr6wb0UXP7ZJN6sMBvza2bUtmfguLAwWMWVCu4qnkt9nVCxefuW5NJ
 1hTE1Q20LUX5x8ieA9CEFxiSzecpGcc4ydXLBxVCSUy+DM6UZdxdlI/KOC9mAfiDLczPH/ZC3bGD0
 Bp11DelvOe5G6KRu3W/e+EraU3ZzBglGpRodAb6K9PHLPbCvAyKQ6q2kT9wFk+4x0PAPdMmdV6vWy
 EhRBL1cgNigWXC70PMGlEQbds0tcQn5gYBKkMeTAbSFh4osPm1Y5cero/08SzFKmliknQi6trXaZH
 pBbgMPIk/BXwuY2OJN70glVK+vMRtl2+CCEV8q3hxNVcpYcngYfACZm1ce5siWfRqBoWA6a81a974
 Q5VAeBdYm7S4cWfEIjRbMj9pxjHNuvfXL4qs7DHx75HVcSEo0EKinx5aNA0xz6f+eeX0F3wCm3dAS
 Mrerm0ODuwnhT05IAvasquTkAPKlZjCxr7E6tdVbicB7hpTSIcF1NytzAOdURgcdrHCgYaM41FmzN
 HiIYRqI7UldwQ7oB5a7j9hnFN2bIAXMu26Il8REEShSCI++pwvAYdaRSu+ZMJQ=;
Message-ID: <7840fbdba06d0f4c45cac96a0a9aa35681ef177f.1780851947.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1780851947.git.qemu_oss@crudebyte.com>
References: <cover.1780851947.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 07 Jun 2026 19:22:19 +0200
Subject: [PATCH 12/12] tests/9p: add 3 xattr FID limit test cases (local fs
 driver)
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=7840fbdba06d0f4c45cac96a0a9aa35681ef177f@kylie.crudebyte.com;
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

These are "slow" tests, i.e. they are not running by default.
Use -m slow for running theses tests.

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


