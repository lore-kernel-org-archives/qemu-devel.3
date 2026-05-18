Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C59ECD4F50
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 18:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP2mG-0006kD-46; Mon, 18 May 2026 14:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <1d11dcbfc95b811dcdb48c6d7f3894d0ebd073a2@kylie.crudebyte.com>)
 id 1wP2lK-0006Lj-0p; Mon, 18 May 2026 14:32:36 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <1d11dcbfc95b811dcdb48c6d7f3894d0ebd073a2@kylie.crudebyte.com>)
 id 1wP2lC-0002PA-10; Mon, 18 May 2026 14:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=nRxWZaQWIF566VG4Viq1KZglD+FlmXtv4gAEQLaY6TY=; b=kPmx7
 IS2t2T4ndZnaPvnjEnyzDTbDNVddGM8MejIImqyyYJJiNcbTezbY2ZDbRN/8HtKrlfoKf2sGHN7Zk
 6OnVU7/jcFotJdoi7xFSnJNbcak340JyzdMXkGRTw4M61j83OUjj1BNPMGAWpLXOCKrnhk1FNUa4M
 KLfIJ4ZWMoUigVapTZGJAP6jW+yOaMGR4BPhVucgXV+wb4LR8W+nvzwJYy3a/behK+/t90TRkjF0q
 sWAD1XV6lNZK9fL9gyG8pRCJj4sWnUGNomDieeqS94HmE6w8gvsjZ/t7tLQuVS/SH7Rz704v1Ulf3
 7JPK9J7S97DKsu2yW5j+ON/uxe5crlEhh8H3QUzB3ImnCCIt8KS1ieND8wR2fXoeu+m/Ee+FelSVQ
 50rmQzkpEdp60uCe/PbuvQJoDbRh5fnQ31zWhCky+rfLLNGvVoMtVUFSh+WZpSQxii0VlHHoGd6+V
 GS1LYmEDkWRH90yYNF0z5RlVjyC9OtH/LnvnQRXIUOBB0p5RZIhNxXj+VicXCBryuCo025UIA43Xv
 XmmPwg6AKW209MwKxtsQGpe/u3GybJv1j4NRBC+ov3FsMY1Ny5t67HnsDowUxcZFQe9/MfJTsloMC
 +Zqdl92sTyyYbe8CXMHKN0y7bwz2mROZeFSbB6vSTLj7LYKgOHeADbcVBMJ3b4=;
Message-ID: <1d11dcbfc95b811dcdb48c6d7f3894d0ebd073a2.1779126034.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1779126034.git.qemu_oss@crudebyte.com>
References: <cover.1779126034.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 18 May 2026 19:35:59 +0200
Subject: [PATCH 4/6] hw/9pfs: let callers of v9fs_path_sprintf() and
 v9fs_fix_path() handle errors
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Jia Jia <physicalmtea@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=1d11dcbfc95b811dcdb48c6d7f3894d0ebd073a2@kylie.crudebyte.com;
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
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3358
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p-local.c | 23 ++++++++++++++++-------
 hw/9pfs/9p.c       | 18 +++++++++++++-----
 2 files changed, 29 insertions(+), 12 deletions(-)

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


