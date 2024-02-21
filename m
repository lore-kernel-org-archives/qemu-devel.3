Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC2CD68BFD
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2024 17:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFG5O-0003k0-65; Sun, 24 Nov 2024 12:07:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <3d6449d4df25bcdd3e807eff169f46f1385e5257@kylie.crudebyte.com>)
 id 1tFG5M-0003jE-64; Sun, 24 Nov 2024 12:07:48 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <3d6449d4df25bcdd3e807eff169f46f1385e5257@kylie.crudebyte.com>)
 id 1tFG5K-0005H3-OB; Sun, 24 Nov 2024 12:07:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=8eE59iENcUdzeUBXiMcAkpaESk28ON3bMfkwrIcP5vg=; b=ibziH
 B5pI2v95HYySR5Ol7PT/Wrt2Cs4aFtmfrYql1AoEINSg6XqmjV0tiZpWyVFk+1K65WmC1lmkRsL7L
 xUyss+pRblyGJ5nK8nwqYfzbN9NnA8Ysaw/TznbZAySfPFd67rsBQxZAD5xZlnE1G6ettXp2UBgEX
 rDkzSB4045qb2kQ8k76WuDaYRM0Ot3lTTj/eWTDZMgnkh7Z2U7uFZWJ9sQBYmShiNCp4YX+bVy5Qx
 9LlGbXJektbYYF6K645YMREHeog2ImkeFSf01gB6uU28QOao4LSEUI2bAke6USEzWoMeME+aYftUZ
 wcKU+7f+ACVCZ+COgY/NN7vilbP8ZQrVpkNHo1IX0+WTFKr+qFqY5NCADKO+ElPjFuVHIEZFDlNZ0
 2ndOWenkY/JmBlyduRKiYaTfQpPfwY6vhthad4BqtCP360x/+wNfIbDoH+59K2memUJRSrRRxHQ9J
 lK7WWTh6Ex6sCfCx0Pka3r9Gyei1/oLjoAdUDcAV3C4DmcGECmwuOwvErDzhfJgoHlY0jj9OvztKy
 EUntgjyAXw4Ve3WOsH4pQ58FwjFJvhu+PMSbdqYNFPD0kjY6XgGymv3FXDuhU8+8hbEb1dhOoFCBF
 5ACtA/Pn0GJ1v66T6bqRmWA8aHvEQisOvjzni5ZFHbpbngqgrNmEs1Jr+3ZVlc=;
Message-Id: <3d6449d4df25bcdd3e807eff169f46f1385e5257.1732465720.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1732465720.git.qemu_oss@crudebyte.com>
References: <cover.1732465720.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 21 Feb 2024 15:13:13 +0100
Subject: [PATCH 1/6] tests/9p: add 'use-after-unlink' test
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
    Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=3d6449d4df25bcdd3e807eff169f46f1385e5257@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
2.39.5


