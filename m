Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3163D5E156
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 10:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9MNC-0002Qm-UX; Fri, 08 Nov 2024 05:37:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <042b4ebfd2298ae01553844124f27d651cdb1071@kylie.crudebyte.com>)
 id 1t9MNA-0002QE-Di; Fri, 08 Nov 2024 05:37:48 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <042b4ebfd2298ae01553844124f27d651cdb1071@kylie.crudebyte.com>)
 id 1t9MN7-0005bX-G5; Fri, 08 Nov 2024 05:37:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=3wiZXtK/ZFU3fzQgHyiPmVBJifvcCVuHJzV0dxB5Hl0=; b=Ibc1S
 /i4kL8zj/g1ZqY8NRkYJRR5DJjozk4qGWprEgele5oJsfo+3rw7Qaoj45BjmcXXMbQFQ76HEwf0ZM
 ltgXZYIAqN7PD9YIAUUdD2FCeyXj1Czt2YoH9dpsB+8p0Ddk956qGgrXvLnE1k6AZf+G1aBgYd5OZ
 4O2yw7MdPZQGPaFTKAbUyYTd3dwIwoy2r7RH4NaWNS6Kb+Z8Fp2WkO+ezKcTi2WbPeB55VBIy2BlQ
 UWSNrmeZFQSKMYUe4Hr7AFagMQwyO/JdW0mL0TwGqn4/xbc1dU5yUY1QB9c4g6NNHjvyuuRSbkYLq
 66EBb5iTgA9b7WtNhkaqNJWWOzvLO5b0RsudJKo9d6GXtzzylBfbVDu8kymfqvDOsx+VYIzwI4qjd
 FBQyva+1G8yWg0OUWr4FLwTIX2vNZxbTgbhuf19sAeaVBLWkiVOss/eVKrLn27KXEcIFY97H10pPh
 ZZwSV79z/56zSk+880iapb5jSLgvkzNFPQSRVvg42oOg7zZGBtUpJTmbUZowzK0rqZfaciZ8YX9Jg
 1ePPIhAFepKwLqL7VdmrjUhF5XvY9FHzZr7cFK8OoUGpJUllCA7N+WWJFylZpiOjn1jYBKMO8TZDi
 U7ekopyeRf+x6AhC+CGS5rRazDOjHVDx4McXtncZbPnFaCaQBkV/WshIx9cOt0=;
Message-Id: <042b4ebfd2298ae01553844124f27d651cdb1071.1731059803.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1731059803.git.qemu_oss@crudebyte.com>
References: <cover.1731059803.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 08 Nov 2024 10:56:43 +0100
Subject: [PULL for-9.2 1/1] 9pfs: fix crash on 'Treaddir' request
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Akihiro Suda <suda.kyoto@gmail.com>, jan.dubois@suse.com,
 anders.f.bjorklund@gmail.com, Balaji Vijayakumar <kuttibalaji.v6@gmail.com>
Received-SPF: none client-ip=5.189.157.229;
 envelope-from=042b4ebfd2298ae01553844124f27d651cdb1071@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

A bad (broken or malicious) 9p client (guest) could cause QEMU host to
crash by sending a 9p 'Treaddir' request with a numeric file ID (FID) that
was previously opened for a file instead of an expected directory:

  #0  0x0000762aff8f4919 in __GI___rewinddir (dirp=0xf) at
    ../sysdeps/unix/sysv/linux/rewinddir.c:29
  #1  0x0000557b7625fb40 in do_readdir_many (pdu=0x557bb67d2eb0,
    fidp=0x557bb67955b0, entries=0x762afe9fff58, offset=0, maxsize=131072,
    dostat=<optimized out>) at ../hw/9pfs/codir.c:101
  #2  v9fs_co_readdir_many (pdu=pdu@entry=0x557bb67d2eb0,
    fidp=fidp@entry=0x557bb67955b0, entries=entries@entry=0x762afe9fff58,
    offset=0, maxsize=131072, dostat=false) at ../hw/9pfs/codir.c:226
  #3  0x0000557b7625c1f9 in v9fs_do_readdir (pdu=0x557bb67d2eb0,
    fidp=0x557bb67955b0, offset=<optimized out>,
    max_count=<optimized out>) at ../hw/9pfs/9p.c:2488
  #4  v9fs_readdir (opaque=0x557bb67d2eb0) at ../hw/9pfs/9p.c:2602

That's because V9fsFidOpenState was declared as union type. So the
same memory region is used for either an open POSIX file handle (int),
or a POSIX DIR* pointer, etc., so 9p server incorrectly used the
previously opened (valid) POSIX file handle (0xf) as DIR* pointer,
eventually causing a crash in glibc's rewinddir() function.

Root cause was therefore a missing check in 9p server's 'Treaddir'
request handler, which must ensure that the client supplied FID was
really opened as directory stream before trying to access the
aforementioned union and its DIR* member.

Cc: qemu-stable@nongnu.org
Fixes: d62dbb51f7 ("virtio-9p: Add fidtype so that we can do type ...")
Reported-by: Akihiro Suda <suda.kyoto@gmail.com>
Tested-by: Akihiro Suda <suda.kyoto@gmail.com>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <E1t8GnN-002RS8-E2@kylie.crudebyte.com>
---
 hw/9pfs/9p.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index af636cfb2d..9a291d1b51 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2587,6 +2587,11 @@ static void coroutine_fn v9fs_readdir(void *opaque)
         retval = -EINVAL;
         goto out_nofid;
     }
+    if (fidp->fid_type != P9_FID_DIR) {
+        warn_report_once("9p: bad client: T_readdir on non-directory stream");
+        retval = -ENOTDIR;
+        goto out;
+    }
     if (!fidp->fs.dir.stream) {
         retval = -EINVAL;
         goto out;
-- 
2.30.2


