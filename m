Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675ABD5E122
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 06:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9fCr-0005Dr-FU; Sat, 09 Nov 2024 01:44:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9fAZ-0006c0-Cq; Sat, 09 Nov 2024 01:42:10 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9fAX-0002fP-Ml; Sat, 09 Nov 2024 01:42:03 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AC187A130A;
 Sat,  9 Nov 2024 09:38:11 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 217F7167DEC;
 Sat,  9 Nov 2024 09:39:06 +0300 (MSK)
Received: (nullmailer pid 3272593 invoked by uid 1000);
 Sat, 09 Nov 2024 06:39:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Akihiro Suda <suda.kyoto@gmail.com>, Greg Kurz <groug@kaod.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.15 33/33] 9pfs: fix crash on 'Treaddir' request
Date: Sat,  9 Nov 2024 09:38:59 +0300
Message-Id: <20241109063903.3272404-33-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.15-20241109093832@cover.tls.msk.ru>
References: <qemu-stable-7.2.15-20241109093832@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

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
(cherry picked from commit 042b4ebfd2298ae01553844124f27d651cdb1071)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 072cf67956..51ad5bfb11 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2596,6 +2596,11 @@ static void coroutine_fn v9fs_readdir(void *opaque)
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


