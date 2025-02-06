Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28C5C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 16:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg54U-0000Kw-Oo; Thu, 06 Feb 2025 11:49:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <6eadd8767ab9422942c3c5e8d70c923e5ee3aa3f@kylie.crudebyte.com>)
 id 1tg54K-0008U4-KQ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 11:49:38 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <6eadd8767ab9422942c3c5e8d70c923e5ee3aa3f@kylie.crudebyte.com>)
 id 1tg54G-0006GI-Lg
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 11:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=PqKdHe7ois7thoZS8jd2yyOq9qy3lzC6R+YWRsAjpF4=; b=JV8Sg
 4MYSZpWS9j+wb7T8HQRcEuRWU8/DZhngvisgykswBgj/0xy4fM1FHV0HiSCifPEt5qcbgf7aChEph
 CrkFdBUR+6vovHEOZa+ZbyHddDtV/JKk0oW9DVz+CmkMREBWwfBvqrs5UFKEaYoemkgS9P1NYFFTk
 u8y1H0gf6thsQ4eSmw3GscWeh9LILnHBfjUjynuPnIgqGK262qptOE9js1ddbHlg3jfHDCRzyHWga
 qcYjfcEqmQFt+di61KLtJ5kfRM6vBLcmy1aUGi6eZ5OtE1qXDTO3J8B6FY4acne1t7y1zYuUyygaC
 nbbKs0E2B/mNFZl1OV9GvzMqeCqjHyvEoK5gDKYmPcZpp/V16d+5VwFo/bx31+sbAISSOvXXydTpM
 JE2gxeFYEcJkSYO6R5vVuDou9CSc80Lb80WC3glTPE7puVf2mBfX1TIyJlCWYe1rME2Pnk1Ol8iBo
 y6c27ZFTxv+37JNKxJwZVf3Rq5upRA5YFQVeE5d+1tzAUSp0iQpDEFLcEBvKXOt5H/UGKlZG9cEx1
 nzCIr2s0puPGGNGpTZDCQLhWyYQ7L224m4eiJk77NEqtrdYccYj2unfONf5Oomwod3YdjgFA/uHQy
 v9ZMQxDrENGwAmxxLYkJ7WoEA8NUznVgqJW373LWIYq+Oz6KsdhcX9UapCY06c=;
Message-Id: <6eadd8767ab9422942c3c5e8d70c923e5ee3aa3f.1738860115.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1738860115.git.qemu_oss@crudebyte.com>
References: <cover.1738860115.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 06 Feb 2025 17:41:56 +0100
Subject: [PULL 6/7] tests/9p: extend use_dir_after_unlink test with Treaddir
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>,
    Stefan Hajnoczi <stefanha@redhat.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=6eadd8767ab9422942c3c5e8d70c923e5ee3aa3f@kylie.crudebyte.com;
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

Sending a Treaddir request on an unlinked directory should also succeed
if the directory was alread opened before unlink. We just check that no
error occurs and that we get some kind of Treaddir result, but completely
ignore the actual Treaddir result content. In fact, there should be no
system as of to date that would allow a removed directory to have any
content (files, links, devices, subdirectories) and POSIX specifies that
a directory must be empty when trying to remove it from the file system.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-Id: <f1b91e3a33a6502be816d88dfb6b719101b69d41.1736427878.git.qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 35c42cd0d7..10243247ab 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -772,6 +772,9 @@ static void fs_use_dir_after_unlink(void *obj, void *data,
         .client = v9p, .fid = fid_dir, .request_mask = P9_GETATTR_BASIC,
         .rgetattr.attr = &attr
     });
+    treaddir({
+        .client = v9p, .fid = fid_dir, .offset = 0, .count = P9_MAX_SIZE - 11
+    });
 }
 
 static void cleanup_9p_local_driver(void *data)
-- 
2.30.2


