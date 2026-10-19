Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5CACCF2E5
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIoTj-0007xf-8a; Mon, 19 Oct 2026 10:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <12df3256042c8db14984248d0660d14e380b312d@kylie.crudebyte.com>)
 id 1xIoTh-0007kd-40; Mon, 19 Oct 2026 10:36:41 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <12df3256042c8db14984248d0660d14e380b312d@kylie.crudebyte.com>)
 id 1xIoTf-0007XH-5X; Mon, 19 Oct 2026 10:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=upnmIveujoDak5KFIdh40JgC4qu3Wp35hH98+YdcFZ4=; b=rONLP
 vw3Ney5V2+hcLFU7ytWWJDzLorI5B+3/xZWpnqjSf6Ou+excCop9AY7mncrgpwlNhAKR65LB3j2Er
 2TtzH65JVG78FO04QsOOxQOAzQR9lWxnqUc5M3qOeX4ZPCtfdMpknak1m9oDZUu6xQicjbilBwwpY
 veRKpKKbjC8AFwVJu0FCstEZ1DTNYd/N9YmE/flPS6V+1bSuwBkW16kjr+ZJSV8BfL6dnx349ameU
 OOU9er0qb6ElTQ8MVt2ONYHGBFJXNv1FHA/bnA0YvkIF+FFckpvw1k7slcRHMsnzP9bAtwt6wbHgu
 cEOqb8c0Wag3FLpCgH2aCh7b50myslJCRqipx0uYVE57qimLzi7HuGAiFmluPQSkNddJEiSQRIPGw
 NWgdvxZhVCQxnjVFfEMG3+HAjFKAjOOHHc+9ZyalCcoYTlT4XdHp26+atBk4aW8DE3cciLAvAjGyu
 gieaWi6kquu/oscra2pV5WYezhHnfPVn6r0QgpuyYkD/Xn7LfSIPQwHlHfASTrbrL682MiOw/YNk2
 oyQ+RjRQ82olBX0fS27KYaShE/HB3Vpg6xW0rFznBRRvb/JP8tnz1/qsMWy/5g68XYQhoMAtM1Pl9
 7zhI4+rb14yUg42wQJGixxcd+y40ruwIdMoGPJ25MqPcpSrlofhaj/V9HUMkJk=;
Message-ID: <12df3256042c8db14984248d0660d14e380b312d.1792420035.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1792420035.git.qemu_oss@crudebyte.com>
References: <cover.1792420035.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 19 Oct 2026 16:27:16 +0200
Subject: [PULL 6/9] hw/9pfs: fix dirent stream protection for legacy
 (9p2000.u) Tread
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=12df3256042c8db14984248d0660d14e380b312d@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

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
---
 hw/9pfs/9p.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 4764d9db13..730d1279bb 100644
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


