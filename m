Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901C8C02192
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 08:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgQI-0001Yw-18; Tue, 28 Jan 2025 02:54:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgQ8-0001IJ-Nz; Tue, 28 Jan 2025 02:54:06 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgQ7-0007qY-1m; Tue, 28 Jan 2025 02:54:04 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C924AE1AC6;
 Tue, 28 Jan 2025 10:52:59 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 43FE61A62B5;
 Tue, 28 Jan 2025 10:53:25 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 2393E52001; Tue, 28 Jan 2025 10:53:25 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.16 13/31] 9pfs: fix 'Tgetattr' after unlink
Date: Tue, 28 Jan 2025 00:41:05 +0300
Message-Id: <20250127214124.3730126-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.16-20250128004119@cover.tls.msk.ru>
References: <qemu-stable-7.2.16-20250128004119@cover.tls.msk.ru>
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

With a valid file ID (FID) of an open file, it should be possible to send
a 'Tgettattr' 9p request and successfully receive a 'Rgetattr' response,
even if the file has been removed in the meantime. Currently this would
fail with ENOENT.

I.e. this fixes the following misbehaviour with a 9p Linux client:

  open("/home/tst/filename", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
  unlink("/home/tst/filename") = 0
  fstat(3, 0x23aa1a8) = -1 ENOENT (No such file or directory)

Expected results:

  open("/home/tst/filename", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
  unlink("/home/tst/filename") = 0
  fstat(3, {st_mode=S_IFREG|0600, st_size=0, ...}) = 0

This is because 9p server is always using a path name based lstat() call
which fails as soon as the file got removed. So to fix this, use fstat()
whenever we have an open file descriptor already.

Fixes: 00ede4c2529b ("virtio-9p: getattr server implementation...")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/103
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <4c41ad47f449a5cc8bfa9285743e029080d5f324.1732465720.git.qemu_oss@crudebyte.com>
(cherry picked from commit c81e7219e0736f80bfd3553676a19e2992cff41d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index cfe90f63cb..d950ad6de6 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1605,7 +1605,13 @@ static void coroutine_fn v9fs_getattr(void *opaque)
         retval = -ENOENT;
         goto out_nofid;
     }
-    retval = v9fs_co_lstat(pdu, &fidp->path, &stbuf);
+    if ((fidp->fid_type == P9_FID_FILE && fidp->fs.fd != -1) ||
+        (fidp->fid_type == P9_FID_DIR && fidp->fs.dir.stream))
+    {
+        retval = v9fs_co_fstat(pdu, fidp, &stbuf);
+    } else {
+        retval = v9fs_co_lstat(pdu, &fidp->path, &stbuf);
+    }
     if (retval < 0) {
         goto out;
     }
-- 
2.39.5


