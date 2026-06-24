Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D40CDE003
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:47:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNnG-0000cT-3L; Wed, 24 Jun 2026 09:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNnA-0000A3-8b; Wed, 24 Jun 2026 09:37:24 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNn8-00013l-9R; Wed, 24 Jun 2026 09:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782307998; bh=4tk3GUct0C8a+DpGA4Ou5oAjqkp+/dLPmbzo2Xr5o3Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=X6zsxKGPn2wQB1+bw29DzIaTQMuSL2Z+vp3wt0Hk0Vkmi46MlUp+uCP1nLca+kiHr
 vY1Vchc0PfiSa+wPxyAaiSjAQ8Wxf2IJ3JVbBs31EWoDf63nxKUUskxDtx0ewxAr2/
 6Men0jujbzqXyqmEjlROt0E69+NaE82qajV8Jz6ckk6ASnlo7izY2y+L0D/tEGb4w7
 Tyu0M0KzRvJ2iZjSJIvqYXczaIGXg0ei2YPIBoXy5oxMEpg8z8A/GbvSD6q4NtJk/w
 cZe/TA7snvJ0+FSDjXUFIjdX0+XqqXCMhp6ubZLQksL5nZOYsFTk5chvM5XU2mhvhy
 h35lW64yXr9rQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 57F9E1BA9E0;
 Wed, 24 Jun 2026 16:33:18 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E87B43DEA2F;
 Wed, 24 Jun 2026 16:33:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Wang Jihe <wangjihe.mail@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 046/107] hw/9pfs: let callers of v9fs_path_sprintf()
 and v9fs_fix_path() handle errors
Date: Wed, 24 Jun 2026 16:30:51 +0300
Message-ID: <20260624133301.403266-46-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
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

This patch mitigates issues with very large absolute paths.

- Add error handling to all v9fs_path_sprintf() calls in
  local_name_to_path()

- Update callers of v9fs_fix_path() to check return values.

- When path formatting fails, clunk the affected FIDs to prevent use of
  invalid paths.

- Use g_autofree for temporary variables to simplify code.

Even though paths are usually limited to PATH_MAX (typically 4k) on guest,
this limitation can be circumvented by using *at() functions on guest and
creating very deep directory structures. This was a problem for QEMU 9p
server, as it currently tracks the absolute path for each FID internally
that always requires assembly of a (potentially ver large) absolute path.

A true long-term fix would be getting rid of storing an absolute path for
each FID internally. However that would likely be a massive change with
uncertain implications.

This patch therefore just mitigates the problem by immediately clunking
(i.e. closing) all FIDs whose path exceed a limit that we could handle.
As this only accounts to very unusual large absolute paths not ever been
reported on (sane) production machines, this is currently considered an
acceptable mitigation that should only (counter)affect malicious attempts.

Fixes: 2f008a8c97e2 ("hw/9pfs: Use the correct signed type ...")
Reported-by: Wang Jihe <wangjihe.mail@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3358
Link: https://lore.kernel.org/qemu-devel/1d11dcbfc95b811dcdb48c6d7f3894d0ebd073a2.1779126034.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit 3802c0e755a53b126e717415b54226a468bf7ddf)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 24cb1da90a..aa48306b0e 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1261,26 +1261,35 @@ static int local_name_to_path(FsContext *ctx, V9fsPath *dir_path,
         } else if (!strcmp(name, "..")) {
             if (!strcmp(dir_path->data, ".")) {
                 /* ".." relative to the root is "." */
-                v9fs_path_sprintf(target, ".");
+                if (v9fs_path_sprintf(target, ".") < 0) {
+                    return -1;
+                }
             } else {
-                char *tmp = g_path_get_dirname(dir_path->data);
+                g_autofree char *tmp = g_path_get_dirname(dir_path->data);
                 /* Symbolic links are resolved by the client. We can assume
                  * that ".." relative to "foo/bar" is equivalent to "foo"
                  */
-                v9fs_path_sprintf(target, "%s", tmp);
-                g_free(tmp);
+                if (v9fs_path_sprintf(target, "%s", tmp) < 0) {
+                    return -1;
+                }
             }
         } else {
             assert(!strchr(name, '/'));
-            v9fs_path_sprintf(target, "%s/%s", dir_path->data, name);
+            if (v9fs_path_sprintf(target, "%s/%s", dir_path->data, name) < 0) {
+                return -1;
+            }
         }
     } else if (!strcmp(name, "/") || !strcmp(name, ".") ||
                !strcmp(name, "..")) {
             /* This is the root fid */
-        v9fs_path_sprintf(target, ".");
+        if (v9fs_path_sprintf(target, ".") < 0) {
+            return -1;
+        }
     } else {
         assert(!strchr(name, '/'));
-        v9fs_path_sprintf(target, "./%s", name);
+        if (v9fs_path_sprintf(target, "./%s", name) < 0) {
+            return -1;
+        }
     }
     return 0;
 }
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index d704de644f..b4314d2549 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3325,12 +3325,14 @@ static int coroutine_fn v9fs_complete_rename(V9fsPDU *pdu, V9fsFidState *fidp,
             goto out;
         }
     } else {
-        char *dir_name = g_path_get_dirname(fidp->path.data);
+        g_autofree char *dir_name = g_path_get_dirname(fidp->path.data);
         V9fsPath dir_path;
 
         v9fs_path_init(&dir_path);
-        v9fs_path_sprintf(&dir_path, "%s", dir_name);
-        g_free(dir_name);
+        err = v9fs_path_sprintf(&dir_path, "%s", dir_name);
+        if (err < 0) {
+            goto out;
+        }
 
         err = v9fs_co_name_to_path(pdu, &dir_path, name->data, &new_path);
         v9fs_path_free(&dir_path);
@@ -3351,7 +3353,10 @@ static int coroutine_fn v9fs_complete_rename(V9fsPDU *pdu, V9fsFidState *fidp,
     while (g_hash_table_iter_next(&iter, &fid, (gpointer *) &tfidp)) {
         if (v9fs_path_is_ancestor(&fidp->path, &tfidp->path)) {
             /* replace the name */
-            v9fs_fix_path(&tfidp->path, &new_path, strlen(fidp->path.data));
+            if (v9fs_fix_path(&tfidp->path, &new_path,
+                              strlen(fidp->path.data)) < 0) {
+                clunk_fid(s, tfidp->fid);
+            }
         }
     }
 out:
@@ -3448,7 +3453,10 @@ static int coroutine_fn v9fs_fix_fid_paths(V9fsPDU *pdu, V9fsPath *olddir,
     while (g_hash_table_iter_next(&iter, &fid, (gpointer *) &tfidp)) {
         if (v9fs_path_is_ancestor(&oldpath, &tfidp->path)) {
             /* replace the name */
-            v9fs_fix_path(&tfidp->path, &newpath, strlen(oldpath.data));
+            if (v9fs_fix_path(&tfidp->path, &newpath,
+                              strlen(oldpath.data)) < 0) {
+                clunk_fid(s, tfidp->fid);
+            }
         }
     }
 out:
-- 
2.47.3


