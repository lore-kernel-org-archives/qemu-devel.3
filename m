Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEA4D12680
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 10:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HEi-0002ld-TJ; Tue, 05 Nov 2024 05:56:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <ffc631f09a16364cbfd3b1823f4e1028e0c20989@kylie.crudebyte.com>)
 id 1t8HEh-0002jK-Ch; Tue, 05 Nov 2024 05:56:35 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <ffc631f09a16364cbfd3b1823f4e1028e0c20989@kylie.crudebyte.com>)
 id 1t8HEf-0004cA-B8; Tue, 05 Nov 2024 05:56:34 -0500
Date: Tue, 5 Nov 2024 11:25:26 +0100
Subject: [PATCH] 9pfs: fix crash on 'Treaddir' request
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Akihiro Suda <suda.kyoto@gmail.com>,
 jan.dubois@suse.com, anders.f.bjorklund@gmail.com, qemu-stable@nongnu.org,
 Balaji Vijayakumar <kuttibalaji.v6@gmail.com>
Message-Id: <E1t8GnN-002RS8-E2@kylie.crudebyte.com>
Received-SPF: none client-ip=5.189.157.229;
 envelope-from=ffc631f09a16364cbfd3b1823f4e1028e0c20989@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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
Reply-to:  Christian Schoenebeck <qemu_oss@crudebyte.com>
From:  Christian Schoenebeck via <qemu-devel@nongnu.org>
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
2.39.5


