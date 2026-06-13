Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50B2CD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYV9m-0002jZ-UK; Sat, 13 Jun 2026 16:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV9l-0002hb-NV; Sat, 13 Jun 2026 16:40:41 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV9j-0004nI-Qu; Sat, 13 Jun 2026 16:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382965; bh=sq3wfnIuv+1QgSiiJ3QDn+46DBYkyT99RJCkygeD7uc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jtW4MGuSUo9ncyHe78zxUmCtDcQNvUuQGsVtBzdVpRminDk3jQ897adi8EEKYt5PO
 u5THKG8tJ11DRRm6ZOSQnZdCh1scgIPiTvHlHDSWmDig/yBxSXkPfiwOARS7Ky7iqW
 5W74ZW9yOfovzCNA+ZfzumtnLOZ+8+CZRvZYhY+GUzRs6IEwaoHMd+vBKZutD80gW+
 Gr8xlqyP0NO8iuKfd0B1xqiu8NR0Df378DUB9kI2WPHL1woj5nxR+CpslNqSSLD1Dt
 oIyNn4v40Tkfj/rUghcmWO2LFEHgS2p5Mo27tm/4UarvRJH3K4okQF8kd1bbFH8Miz
 bw/+DTz25647Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6D2321B6F10;
 Sat, 13 Jun 2026 23:36:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D6EAF3CE95C;
 Sat, 13 Jun 2026 23:36:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 48/72] tests/9pfs: add deep absolute path test
Date: Sat, 13 Jun 2026 23:35:14 +0300
Message-ID: <20260613203542.1809153-48-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

Add fs_deep_absolute_path test that creates a deep directory
structure with an absolute path length exceeding 16-bit range
(i.e. >65536) to verify the previous buffer overflow fix.

This is a slow test (may take several seconds) and therefore
registered as "slow" test and not running by default.

Use -m slow to run this test.

Link: https://gitlab.com/qemu-project/qemu/-/issues/3358
Link: https://lore.kernel.org/qemu-devel/933552b2cfc2c442fac7f4e68c777dce20ee8d7e.1779126034.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit 198627807a6b94e2aab157cf345f98edb1ac1a7a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index ac38ccf595..1c69d41e33 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -14,6 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
+#include "libqos/virtio.h"
 #include "libqos/virtio-9p-client.h"
 
 #define twalk(...) v9fs_twalk((TWalkOpt) __VA_ARGS__)
@@ -752,6 +753,72 @@ static void fs_use_after_unlink(void *obj, void *data,
     g_assert_cmpint(attr.size, ==, 2001);
 }
 
+/* https://gitlab.com/qemu-project/qemu/-/issues/3358 */
+static void fs_deep_absolute_path(void *obj, void *data,
+                                  QGuestAllocator *t_alloc)
+{
+    QVirtio9P *v9p = obj;
+    v9fs_set_allocator(t_alloc);
+
+    if (!g_test_slow()) {
+        g_test_skip("This is a slow test, run with -m slow");
+        return;
+    }
+
+    GString *path = g_string_new("/");
+    char name[256];
+    uint32_t current_fid = 0;
+
+    tattach({ .client = v9p });
+
+    /* Create deep directory structure until absolute path length
+     * exceeds 16-bit range.
+     */
+    while (path->len <= 65536) {
+        /* use 255-byte name (NAME_MAX) to reduce iterations to ~257 */
+        memset(name, 'A', 255);
+        name[255] = '\0';
+
+        /* create the directory relative to current FID */
+        tmkdir({
+            .client = v9p,
+            .dfid = current_fid,
+            .name = name
+        });
+
+        /* just for locally tracking the current path length */
+        g_string_append(path, name);
+        g_string_append(path, "/");
+
+        /* acquire new FID for the newly created directory */
+        char *wnames[] = { name };
+        current_fid = twalk({
+            .client = v9p,
+            .fid = current_fid,
+            .nwname = 1,
+            .wnames = wnames
+        }).newfid;
+
+        /* Reset descriptor pool to avoid exhaustion. The simplified
+         * virtio test driver does never free descriptors back to the pool
+         * after use, so we must manually reset it for the required high
+         * amount of 9p requests here.
+         */
+        qvirtqueue_reset_pool(v9p->vq);
+    }
+
+    /* check if the deepest directory is accessible */
+    v9fs_attr attr = {};
+    tgetattr({
+        .client = v9p,
+        .fid = current_fid,
+        .request_mask = P9_GETATTR_BASIC,
+        .rgetattr.attr = &attr
+    });
+
+    g_string_free(path, TRUE);
+}
+
 static void cleanup_9p_local_driver(void *data)
 {
     /* remove previously created test dir when test is completed */
@@ -819,6 +886,8 @@ static void register_virtio_9p_test(void)
                  &opts);
     qos_add_test("local/use_after_unlink", "virtio-9p", fs_use_after_unlink,
                  &opts);
+    qos_add_test("local/deep_absolute_path", "virtio-9p",
+                 fs_deep_absolute_path, &opts);
 }
 
 libqos_init(register_virtio_9p_test);
-- 
2.47.3


