Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E190EC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 16:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg54S-0000Bz-0t; Thu, 06 Feb 2025 11:49:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <37c21fb972da373be101d20574309be0584dc2a3@kylie.crudebyte.com>)
 id 1tg54B-0008Rg-5V
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 11:49:33 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <37c21fb972da373be101d20574309be0584dc2a3@kylie.crudebyte.com>)
 id 1tg53z-0006Fs-68
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 11:49:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=zDzfIhpX7RUp42esNkfxQxrLx+/ehHksTquEVG3MY18=; b=NFCIK
 ZDNgugjfj3KeSkHdUMSo/4Cs23wAYtc6d2iDMOGWeQSL1HuLT4R8eEGLjO27soVC36fvY07ijBuzT
 rVkXffAMp3FBwovh7xmNQ0g8K9IWIteMghwUPjpUex0HpNFf9wQM5qzF1sSBfoCd3eyRUT1Iyk7wI
 eKzbrvrfW/BxKI0n7WRCpY3fcz+SMroIRHN66EeIhQqBvndv+lesgsqAUHvhdahuKe6l64eGnXjSz
 yvb6F5OEshcoJ9BlO5shm6k/YmDGF5u5Da7/2tV+wNYdilqq4g8n9qm7Q5ooLGR9pZ0PWPXi7GOGq
 mb7MLgMPMzDSPXoi+tvuuy9LDwL+snbPJz9nbtH2pCYVl/Uor+P8+sJY0L+irR2LiKn9SV+SZ3UcT
 287lEEalpp5apD0qUiiIOBCvkhCyfAXTXMhEsr1c8kiT6G2k1nG5Q1wMpGdmYLNqJRLS2qTnTiMZK
 11vCihRBkQucmcSxqckoRS0QG2jEgtZUqqE5xY3e1Ov76dyK0CNjimPYv1YeEo+3n2u/DT/CTCtVs
 o3Lfrk6dcKb5MVr10TRQVDEbBZUVNg0ltTm/jIBYJeuhlYTrp5V6nCFEsTyB9U0h+qjGZf+/enmA6
 E46AMMuBiDF1Pp7Xq342d/9s/4YHCPqnzux++xD8aIWybFWtpWjgmk26CgaIWs=;
Message-Id: <37c21fb972da373be101d20574309be0584dc2a3.1738860115.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1738860115.git.qemu_oss@crudebyte.com>
References: <cover.1738860115.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 06 Feb 2025 17:41:56 +0100
Subject: [PULL 5/7] tests/9p: add use_dir_after_unlink test
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>,
    Stefan Hajnoczi <stefanha@redhat.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=37c21fb972da373be101d20574309be0584dc2a3@kylie.crudebyte.com;
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

After removing a directory from the filesystem, it should still be
possible to operate on the directory if the directory has been opened
before.

As a first step this new test will verify whether Tgetattr request
works on the unlinked directory.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-Id: <0a9b3419356731e34b1be4a8577d6b416379d085.1736427878.git.qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 39 ++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 07459c5289..35c42cd0d7 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -737,6 +737,43 @@ static void fs_use_file_after_unlink(void *obj, void *data,
     g_assert_cmpint(count, ==, write_count);
 }
 
+static void fs_use_dir_after_unlink(void *obj, void *data,
+                                    QGuestAllocator *t_alloc)
+{
+    QVirtio9P *v9p = obj;
+    v9fs_set_allocator(t_alloc);
+    g_autofree char *real_dir = virtio_9p_test_path("10/doa_dir");
+    struct stat st_dir;
+    struct v9fs_attr attr;
+    uint32_t fid_dir;
+
+    tattach({ .client = v9p });
+
+    /* create a dir "10/doa_dir" and make sure it exists */
+    tmkdir({ .client = v9p, .atPath = "/", .name = "10" });
+    tmkdir({ .client = v9p, .atPath = "10", .name = "doa_dir" });
+    g_assert(stat(real_dir, &st_dir) == 0);
+    g_assert((st_dir.st_mode & S_IFMT) == S_IFDIR);
+
+    /* request a FID for that directory that we can work with next */
+    fid_dir = twalk({
+        .client = v9p, .fid = 0, .path = "10/doa_dir"
+    }).newfid;
+    g_assert(fid_dir != 0);
+
+    /* now first open the dir before ... */
+    tlopen({ .client = v9p, .fid = fid_dir, .flags = O_RDONLY });
+    /* ... removing the dir from file system */
+    tunlinkat({ .client = v9p, .atPath = "10", .name = "doa_dir",
+                .flags = AT_REMOVEDIR });
+
+    /* dir is removed, but we still have it open, so this should succeed */
+    tgetattr({
+        .client = v9p, .fid = fid_dir, .request_mask = P9_GETATTR_BASIC,
+        .rgetattr.attr = &attr
+    });
+}
+
 static void cleanup_9p_local_driver(void *data)
 {
     /* remove previously created test dir when test is completed */
@@ -804,6 +841,8 @@ static void register_virtio_9p_test(void)
                  &opts);
     qos_add_test("local/use_file_after_unlink", "virtio-9p",
                  fs_use_file_after_unlink, &opts);
+    qos_add_test("local/use_dir_after_unlink", "virtio-9p",
+                 fs_use_dir_after_unlink, &opts);
 }
 
 libqos_init(register_virtio_9p_test);
-- 
2.30.2


