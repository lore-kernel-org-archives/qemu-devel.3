Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809B7C0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 08:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgYF-0005uc-JR; Tue, 28 Jan 2025 03:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgY1-0004dR-2g; Tue, 28 Jan 2025 03:02:13 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgXz-00023y-CJ; Tue, 28 Jan 2025 03:02:12 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B8941E1B56;
 Tue, 28 Jan 2025 10:57:08 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 345A01A6309;
 Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 01AA1520A3; Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.3 15/58] tests/9p: add 'use-after-unlink' test
Date: Mon, 27 Jan 2025 23:25:01 +0300
Message-Id: <20250127202547.3723716-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
References: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
(cherry picked from commit 462db8fb1d405391b83a0d3099fdb9bfb85c2d92)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: pick it to stable so the next commit in this place applies too)

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
2.39.5


