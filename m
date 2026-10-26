Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2839606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=ZnMY6dnV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLAc-0005E6-M0; Mon, 26 Oct 2026 09:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLAY-00058y-PE; Mon, 26 Oct 2026 09:55:22 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLAW-00008f-3j; Mon, 26 Oct 2026 09:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793022903; bh=TBd6GW8iNODvI6DZrxsyyrGk93BzGav4r51Gj5NUMtE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZnMY6dnVvziNjNlX0COunjwF9mjFD4sa21z47i5tzuGRHOYiTgpas0TKv7aHDlgyv
 4UpKfjM7nvG8oQarL6mrDMH07MruQ0SeSqOxR8w+AktUgGy9+2Vy7jzf+faqSpV2sp
 U1G/5BBUpkbBvGmfs5FSPiHlUEeDmE92rMniPpy3ss+q9vt2B/GS/Y1XMwUY1wopR6
 sFyHw4EYDg7XZUISal3wGAqV1MYxS0/TNj8uYG5tMf0U5ode0375PopOjWrZPPiAtc
 iiIP3FnQGgCbgGUNLds5SUsoT5yqgZsrD4TkhiLH19XP4IWE79ZHU/3Jbcl8+V6sbR
 3tX+MMeCBxboQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AE81F1E1280;
 Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id AA88844B8CC;
 Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 94D109348F; Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 v2 74/91] hw/9pfs: fix dirent stream protection for
 legacy (9p2000.u) Tread
Date: Mon, 26 Oct 2026 16:54:17 +0300
Message-ID: <20261026135441.1019505-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261026165128@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261026165128@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

Concurrent legacy Tread requests (9p2000.u) on the same directory FID
race the FID's shared dirent stream.

In the initial Tread implementation (a92315553d) the dirent stream
was entirely unprotected. Commit 7cde47d4a8 introduced a lock, which
mitigated the problem, but without sufficient full coverage for this
request type, as it only held the lock during individual dirent
stream steps. A concurrent request could mutate the dirent stream in
between. Furthermore the initial rewinddir() (to offset 0) was still
not protected at all.

This could cause corrupted directory entries being returned to
client, with entries missing, duplicate entries and wrong order, up
to heap corruption of 9p server's QEMU process due to garbage seek
targets.

Fix this by holding the lock for the entire directory reading
transaction (i.e. for the whole v9fs_do_readdir_with_stat() call).

Fixes: a92315553d ("virtio-9p: Add P9_TREAD support")
Link: https://lore.kernel.org/qemu-devel/2f0a6e10200bb3a0dbc0f762493cf1f4d642d61b.1791368962.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit 12df3256042c8db14984248d0660d14e380b312d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 7a6655eb9b9..e469ae4768f 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2384,6 +2384,10 @@ static int v9fs_xattr_read(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
     return offset;
 }
 
+/*
+ * The only caller of this function (v9fs_read()) holds the per-FID readdir
+ * lock during the whole call of this function.
+ */
 static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
                                                   V9fsFidState *fidp,
                                                   uint32_t max_count)
@@ -2394,6 +2398,7 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
     int32_t count = 0;
     struct stat stbuf;
     off_t saved_dir_pos;
+    off_t current_dir_pos;
     struct dirent *dent;
 
     /* save the directory position */
@@ -2405,12 +2410,11 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
     while (1) {
         v9fs_path_init(&path);
 
-        v9fs_readdir_lock(&fidp->fs.dir);
-
         err = v9fs_co_readdir(pdu, fidp, &dent);
         if (err || !dent) {
             break;
         }
+        current_dir_pos = qemu_dirent_off(dent);
         err = v9fs_co_name_to_path(pdu, &fidp->path, dent->d_name, &path);
         if (err < 0) {
             break;
@@ -2424,8 +2428,6 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
             break;
         }
         if ((count + v9stat.size + 2) > max_count) {
-            v9fs_readdir_unlock(&fidp->fs.dir);
-
             /* Ran out of buffer. Set dir back to old position and return */
             v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
             v9fs_stat_free(&v9stat);
@@ -2436,8 +2438,6 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
         /* 11 = 7 + 4 (7 = start offset, 4 = space for storing count) */
         len = pdu_marshal(pdu, 11 + count, "S", &v9stat);
 
-        v9fs_readdir_unlock(&fidp->fs.dir);
-
         if (len < 0) {
             v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
             v9fs_stat_free(&v9stat);
@@ -2447,11 +2447,9 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
         count += len;
         v9fs_stat_free(&v9stat);
         v9fs_path_free(&path);
-        saved_dir_pos = qemu_dirent_off(dent);
+        saved_dir_pos = current_dir_pos;
     }
 
-    v9fs_readdir_unlock(&fidp->fs.dir);
-
     v9fs_path_free(&path);
     if (err < 0) {
         return err;
@@ -2491,10 +2489,17 @@ static void coroutine_fn v9fs_read(void *opaque)
             err = -EOPNOTSUPP;
             goto out;
         }
+        /*
+         * Hold the lock for the entire readdir transaction (rewind and
+         * getdents) to prevent dirent stream corruption on concurrent requests
+         * on the same FID.
+         */
+        v9fs_readdir_lock(&fidp->fs.dir);
         if (off == 0) {
             v9fs_co_rewinddir(pdu, fidp);
         }
         count = v9fs_do_readdir_with_stat(pdu, fidp, max_count);
+        v9fs_readdir_unlock(&fidp->fs.dir);
         if (count < 0) {
             err = count;
             goto out;
-- 
2.47.3


