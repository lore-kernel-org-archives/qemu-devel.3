Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121B2C0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 08:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgZj-000801-M4; Tue, 28 Jan 2025 03:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgZK-0007I6-0H; Tue, 28 Jan 2025 03:03:39 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgZH-0002I3-Rc; Tue, 28 Jan 2025 03:03:33 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DF4B1E1B60;
 Tue, 28 Jan 2025 10:57:08 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5B2661A6313;
 Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 1255C520B7; Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Dirk Herrendorfer <d.herrendoerfer@de.ibm.com>, Greg Kurz <groug@kaod.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.3 25/58] 9pfs: fix regression regarding CVE-2023-2861
Date: Mon, 27 Jan 2025 23:25:11 +0300
Message-Id: <20250127202547.3723716-25-mjt@tls.msk.ru>
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

The released fix for this CVE:

  f6b0de53fb8 ("9pfs: prevent opening special files (CVE-2023-2861)")

caused a regression with security_model=passthrough. When handling a
'Tmknod' request there was a side effect that 'Tmknod' request could fail
as 9p server was trying to adjust permissions:

  #6  close_if_special_file (fd=30) at ../hw/9pfs/9p-util.h:140
  #7  openat_file (mode=<optimized out>, flags=2228224,
      name=<optimized out>, dirfd=<optimized out>) at
      ../hw/9pfs/9p-util.h:181
  #8  fchmodat_nofollow (dirfd=dirfd@entry=31,
      name=name@entry=0x5555577ea6e0 "mysocket", mode=493) at
      ../hw/9pfs/9p-local.c:360
  #9  local_set_cred_passthrough (credp=0x7ffbbc4ace10, name=0x5555577ea6e0
      "mysocket", dirfd=31, fs_ctx=0x55555811f528) at
      ../hw/9pfs/9p-local.c:457
  #10 local_mknod (fs_ctx=0x55555811f528, dir_path=<optimized out>,
      name=0x5555577ea6e0 "mysocket", credp=0x7ffbbc4ace10) at
      ../hw/9pfs/9p-local.c:702
  #11 v9fs_co_mknod (pdu=pdu@entry=0x555558121140,
      fidp=fidp@entry=0x5555574c46c0, name=name@entry=0x7ffbbc4aced0,
      uid=1000, gid=1000, dev=<optimized out>, mode=49645,
      stbuf=0x7ffbbc4acef0) at ../hw/9pfs/cofs.c:205
  #12 v9fs_mknod (opaque=0x555558121140) at ../hw/9pfs/9p.c:3711

That's because server was opening the special file to adjust permissions,
however it was using O_PATH and it would have not returned the file
descriptor to guest. So the call to close_if_special_file() on that branch
was incorrect.

Let's lift the restriction introduced by f6b0de53fb8 such that it would
allow to open special files on host if O_PATH flag is supplied, not only
for 9p server's own operations as described above, but also for any client
'Topen' request.

It is safe to allow opening special files with O_PATH on host, because
O_PATH only allows path based operations on the resulting file descriptor
and prevents I/O such as read() and write() on that file descriptor.

Fixes: f6b0de53fb8 ("9pfs: prevent opening special files (CVE-2023-2861)")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2337
Reported-by: Dirk Herrendorfer <d.herrendoerfer@de.ibm.com>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Tested-by: Dirk Herrendorfer <d.herrendoerfer@de.ibm.com>
Message-Id: <E1tJWbk-007BH4-OB@kylie.crudebyte.com>
(cherry picked from commit d06a9d843fb65351e0e4dc42ba0c404f01ea92b3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index 51c94b0116..95ee4da9bd 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -177,20 +177,27 @@ again:
         return -1;
     }
 
-    if (close_if_special_file(fd) < 0) {
-        return -1;
-    }
-
-    serrno = errno;
-    /* O_NONBLOCK was only needed to open the file. Let's drop it. We don't
-     * do that with O_PATH since fcntl(F_SETFL) isn't supported, and openat()
-     * ignored it anyway.
-     */
+    /* Only if O_PATH is not set ... */
     if (!(flags & O_PATH_9P_UTIL)) {
+        /*
+         * Prevent I/O on special files (device files, etc.) on host side,
+         * however it is safe and required to allow opening them with O_PATH,
+         * as this is limited to (required) path based operations only.
+         */
+        if (close_if_special_file(fd) < 0) {
+            return -1;
+        }
+
+        serrno = errno;
+        /*
+         * O_NONBLOCK was only needed to open the file. Let's drop it. We don't
+         * do that with O_PATH since fcntl(F_SETFL) isn't supported, and
+         * openat() ignored it anyway.
+         */
         ret = fcntl(fd, F_SETFL, flags);
         assert(!ret);
+        errno = serrno;
     }
-    errno = serrno;
     return fd;
 }
 
-- 
2.39.5


