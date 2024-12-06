Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE88E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 12:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJXDp-00033C-JQ; Fri, 06 Dec 2024 07:14:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <02b187d2741b2e443ef2f8d9c06304b0e787141c@kylie.crudebyte.com>)
 id 1tJXDn-00032y-W2; Fri, 06 Dec 2024 07:14:12 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <02b187d2741b2e443ef2f8d9c06304b0e787141c@kylie.crudebyte.com>)
 id 1tJXDl-0000Jq-0g; Fri, 06 Dec 2024 07:14:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Message-Id:Cc:To:Subject:Date:From:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=hy28A+xIh7NxJZwXboK2eNBA0J/sSecnIM++lmdTSc4=; b=h2eRs
 ySa8O9Gf+P7Rk2oPeUYhQYMyYDmNJ0owdIyRL6qvh4GGS5UOBI9NBS1wAkDHTO4kyBJAT+CcwgHZB
 s+s7qNmNpKaJlrSQfEumf9J+uZXG+Q+gvjWf82yWx2XL+qbW4KCoNes6rmhnkY/Cf/FUJzzF1aFOW
 dIiqmQaGp7GM1GPIKCS0D9alNbXtNCx/233Yo2zoSXVBhQ/TOSqOP3RZvjOTyHAaiZwdMMps7I1F+
 6jgu0kuZQX02XF86XWwg0it+Y/RCcMsGTPNYK9paC1XdGA08BdBwMh/ph2gNV9To6gv/Gl0+6QPk9
 2RgNYmmHtZyjd2t1GM4F1boM/kk7Bc7sWElTfNnF9gdhIelqRPAonuudoSitR9ac7RBjlbsG+msfa
 Rhae50KdyEipN9Sx4PzXlBkHSAsIpHs17x9feriWC5VfbRTerceEYPe5+yn+u5lVjcrqSkZkRO0n0
 4uU60RFwtmk0OholwI8KmNg+7iA3GxvX0A27V85XONFzpS9dg7N2NX7P6ARE2IIsLSzBr9zrLVDXe
 ClzK1gixSnv/V5XPYDeYd461ddk/cV/xCMCwLY75IW4yc50U5wKQoRFRaFszJtoST6+fjoULUF21S
 3N+j1MeXV6W3zgh+OqSFHcNdCxY0S0ut3dNGPr12HOd0FaBlN+sy4qZEVdoTo8=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 6 Dec 2024 12:20:29 +0100
Subject: [PATCH] 9pfs: fix regression regarding CVE-2023-2861
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Dirk Herrendorfer <d.herrendoerfer@de.ibm.com>,
 Yanwu Shen <ywsPlz@gmail.com>, Jietao Xiao <shawtao1125@gmail.com>,
 Jinku Li <jkli@xidian.edu.cn>, Wenbo Shen <shenwenbo@zju.edu.cn>,
 Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <E1tJWbk-007BH4-OB@kylie.crudebyte.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=02b187d2741b2e443ef2f8d9c06304b0e787141c@kylie.crudebyte.com;
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
---
 hw/9pfs/9p-util.h | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

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


