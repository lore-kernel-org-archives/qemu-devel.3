Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197F5606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=RhcyiKe6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLDQ-0001lU-OH; Mon, 26 Oct 2026 09:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLD9-00012V-6q; Mon, 26 Oct 2026 09:58:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLD5-0000Q7-Nt; Mon, 26 Oct 2026 09:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793022944; bh=8jUjmTXlTZuKfKVWSHTmZ5STpytAD1aA4v/4s6XCOaA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RhcyiKe6Iz4U987ADdD+CSVjUuBMPPLDAYnP/2lpevdBrSdsd93Sr4VzuFiI7xsjX
 SFW0wIwlcd9oGALYTmHIXgabCrBBqZMaHOQJGFMZi/JVhhyfUffL7eMjiKmaovej+x
 tkR6U3kI4ShG0fXO+vI7oDOeHHa0ON6raKEVWnomO2obRHCPcZfdpt2WnApQnlx4cN
 QswcgjyW6SNaUAT1nEEPAklf/jXOklSgb9k06U4FD/7OaSODvRxGDKK1QFVDLKDktM
 VkOWTthr7W/mT1sMHwOITR9vqzRDZUFcjwu5XiPeDBjtBSN0CnFvuYywz1/N6SSR+l
 ZHTyMpo6oHfMg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 106191E12A0;
 Mon, 26 Oct 2026 16:55:44 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0DE4844B8F1;
 Mon, 26 Oct 2026 16:55:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id EE6FE934C7; Mon, 26 Oct 2026 16:55:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 v2 83/98] hw/9pfs: fix dirent stream protection for
 legacy (9p2000.u) Tread
Date: Mon, 26 Oct 2026 16:55:10 +0300
Message-ID: <20261026135529.1019772-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261026165135@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261026165135@cover.tls.msk.ru>
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
index 4764d9db13b..730d1279bb3 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2421,6 +2421,10 @@ v9fs_xattr_read(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
     return offset;
 }
 
+/*
+ * The only caller of this function (v9fs_read()) holds the per-FID readdir
+ * lock during the whole call of this function.
+ */
 static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
                                                   V9fsFidState *fidp,
                                                   uint32_t max_count)
@@ -2431,6 +2435,7 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
     int32_t count = 0;
     struct stat stbuf;
     off_t saved_dir_pos;
+    off_t current_dir_pos;
     struct dirent *dent;
 
     /* save the directory position */
@@ -2442,12 +2447,11 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
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
@@ -2461,8 +2465,6 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
             break;
         }
         if ((count + v9stat.size + 2) > max_count) {
-            v9fs_readdir_unlock(&fidp->fs.dir);
-
             /* Ran out of buffer. Set dir back to old position and return */
             v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
             v9fs_stat_free(&v9stat);
@@ -2473,8 +2475,6 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
         /* 11 = 7 + 4 (7 = start offset, 4 = space for storing count) */
         len = pdu_marshal(pdu, 11 + count, "S", &v9stat);
 
-        v9fs_readdir_unlock(&fidp->fs.dir);
-
         if (len < 0) {
             v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
             v9fs_stat_free(&v9stat);
@@ -2484,11 +2484,9 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
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
@@ -2528,10 +2526,17 @@ static void coroutine_fn v9fs_read(void *opaque)
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


