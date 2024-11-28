Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865ABD70DEB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 19:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGkL0-0005yQ-Qg; Thu, 28 Nov 2024 14:38:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <462db8fb1d405391b83a0d3099fdb9bfb85c2d92@kylie.crudebyte.com>)
 id 1tGkKy-0005qT-1R; Thu, 28 Nov 2024 14:38:04 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <462db8fb1d405391b83a0d3099fdb9bfb85c2d92@kylie.crudebyte.com>)
 id 1tGkKw-0001ft-Il; Thu, 28 Nov 2024 14:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=pI02vUEzLaL6hvgao20/kKv0iB3ubx0RrXQPy8qFfY4=; b=VCkWL
 qsn/H3aD2SJJeGxqDzkuzCq6n/CZRPvFPAQ+FEG5z6gIrEw2yJwG9mpVxRRNOOeFUmqOzx1A8vNtZ
 D5VoUvt8emUDFh2AZW3CcUukImk9ukl9Lypth2TyN1qzo/zaRx355yiaI317ht6wTE2xI93qNqy9m
 iN148WX6QnUbgEtMyaTjitbuC02UFju+nUgghOSvnYZj81mo4fFKbUJspxi8umI0L+mc/mQjdGaG9
 unXaU4VavSDo1e/p0fXBrHHMJ/o3uHifU0yiV7RHOqfzTM+4FGWN5vuqMAbXJKBlCEzVCdlNT5H5n
 InsODab0xp6i0IoL9bSzACYG3XFL6d40KBaN0AV9ouGnNza2EC9CDwXVBmlgVQ5IrHwy8WJBJ/GfX
 xOXrNt5aVuXyXVreUChgi5v2gwS7j4hAklqEofLc9KfafaIUbJvT9g+yqt9wg0IKmi6C5Hc5VqdGe
 CfLVPoN0sGPTml6+l3JTuiwn2QRXCI+lWlV2UrxUjXWg4Sk8YsThqTVAj5oV9f6lZPrNfgfDcOHb2
 1XixKVXI+Ba2jaWB2RhD5jSx14txVnILyEhCqZG1mgVgYipRanCFtCNN0jWhSvbGYlaPA4Cb1ECtW
 wiDUChkCtgjkoJk/g25HrPRHVErRVMXjxTd1V2n/uSx5SQGn5l6sz+yOGQuJfY=;
Message-Id: <462db8fb1d405391b83a0d3099fdb9bfb85c2d92.1732820037.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1732820037.git.qemu_oss@crudebyte.com>
References: <cover.1732820037.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 28 Nov 2024 19:53:58 +0100
Subject: [PULL for-9.2 2/7] tests/9p: add 'use-after-unlink' test
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org,
    Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=462db8fb1d405391b83a0d3099fdb9bfb85c2d92@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

After removing a file from the file system, we should still be able to
work with the file if we already had it open before removal.

As a first step we verify that it is possible to write to an unlinked
file, as this is what already works. This test is extended later on
after having fixed other use cases after unlink that are not working
yet.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <3d6449d4df25bcdd3e807eff169f46f1385e5257.1732465720.git.qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 3c8cd235cf..f6d7400a87 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -693,6 +693,45 @@ static void fs_unlinkat_hardlink(void *obj, void *data,
     g_assert(stat(real_file, &st_real) == 0);
 }
 
+static void fs_use_after_unlink(void *obj, void *data,
+                                QGuestAllocator *t_alloc)
+{
+    QVirtio9P *v9p = obj;
+    v9fs_set_allocator(t_alloc);
+    static const uint32_t write_count = P9_MAX_SIZE / 2;
+    g_autofree char *real_file = virtio_9p_test_path("09/doa_file");
+    g_autofree char *buf = g_malloc0(write_count);
+    struct stat st_file;
+    uint32_t fid_file;
+    uint32_t count;
+
+    tattach({ .client = v9p });
+
+    /* create a file "09/doa_file" and make sure it exists and is regular */
+    tmkdir({ .client = v9p, .atPath = "/", .name = "09" });
+    tlcreate({ .client = v9p, .atPath = "09", .name = "doa_file" });
+    g_assert(stat(real_file, &st_file) == 0);
+    g_assert((st_file.st_mode & S_IFMT) == S_IFREG);
+
+    /* request a FID for that regular file that we can work with next */
+    fid_file = twalk({
+        .client = v9p, .fid = 0, .path = "09/doa_file"
+    }).newfid;
+    g_assert(fid_file != 0);
+
+    /* now first open the file in write mode before ... */
+    tlopen({ .client = v9p, .fid = fid_file, .flags = O_WRONLY });
+    /* ... removing the file from file system */
+    tunlinkat({ .client = v9p, .atPath = "09", .name = "doa_file" });
+
+    /* file is removed, but we still have it open, so this should succeed */
+    count = twrite({
+        .client = v9p, .fid = fid_file, .offset = 0, .count = write_count,
+        .data = buf
+    }).count;
+    g_assert_cmpint(count, ==, write_count);
+}
+
 static void cleanup_9p_local_driver(void *data)
 {
     /* remove previously created test dir when test is completed */
@@ -758,6 +797,8 @@ static void register_virtio_9p_test(void)
     qos_add_test("local/hardlink_file", "virtio-9p", fs_hardlink_file, &opts);
     qos_add_test("local/unlinkat_hardlink", "virtio-9p", fs_unlinkat_hardlink,
                  &opts);
+    qos_add_test("local/use_after_unlink", "virtio-9p", fs_use_after_unlink,
+                 &opts);
 }
 
 libqos_init(register_virtio_9p_test);
-- 
2.30.2


