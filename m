Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D12C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoTc-0006ke-JK; Wed, 21 Feb 2024 10:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <140110d514572af87a86ab169323528b3ca9c94d@lizzy.crudebyte.com>)
 id 1rcoMq-0003Rf-OZ
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:18:41 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <140110d514572af87a86ab169323528b3ca9c94d@lizzy.crudebyte.com>)
 id 1rco8C-0000Be-UU
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Message-Id:Cc:To:Subject:Date:From:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=y3KE/x9cBngz6SsDzZE4IUFJApU3YzKsgNydsU8Xl+c=; b=NCG+J
 vuSaCgzHZ0CzGAg2U9bOfyE8LfpdQvBoF0y02qRx63nFUn80FWz6xhS9k0X8QjzgCYSm39i5Ixyfj
 i9q4rpzTNXdCE8OUTGokwhMvR/klRa/IQF+44g++OZFkJBZyVcTvQ3fplTsPGi8Z+AvgsyCBh6f+m
 OoXNqdTzraVcMsG74eSM2X/CbeJHiLDu5FDd41JvDH6BBqGZy3almmMuW+MWKVGsYVV3hY33EZK3O
 oWaOIeh5GBri78sAOd1dUzhxC+Mw4xy56bOhg6LmSgOkVhE/J9nUWM4+/fxVBSa0UtxvDaxBGyRo4
 DQcrwfJVB1uRbwsdiKnGsqZOwvhsw==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 21 Feb 2024 15:13:13 +0100
Subject: [PATCH 1/1] tests/9p: add 'use-after-unlink' test
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Message-Id: <E1rcnYJ-0004KK-LV@lizzy.crudebyte.com>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=140110d514572af87a86ab169323528b3ca9c94d@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
do I/O on the file if we already had it open before removal.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---

 OK, this was a bit surprising to me. I was expecting this test to fail,
 but it works!

 tests/qtest/virtio-9p-test.c | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 65e69491e5..7638c0a183 100644
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
 static void *assign_9p_local_driver(GString *cmd_line, void *arg)
 {
     virtio_9p_assign_local_driver(cmd_line, "security_model=mapped-xattr");
@@ -756,6 +795,8 @@ static void register_virtio_9p_test(void)
     qos_add_test("local/hardlink_file", "virtio-9p", fs_hardlink_file, &opts);
     qos_add_test("local/unlinkat_hardlink", "virtio-9p", fs_unlinkat_hardlink,
                  &opts);
+    qos_add_test("local/use_after_unlink", "virtio-9p", fs_use_after_unlink,
+                 &opts);
 }
 
 libqos_init(register_virtio_9p_test);
-- 
2.30.2


