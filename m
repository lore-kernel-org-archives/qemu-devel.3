Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D93CA5FA0
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAjIQ-0000Sx-Ii; Sun, 27 Sep 2026 03:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAjHm-00006G-C1; Sun, 27 Sep 2026 03:27:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAjHk-0005RE-DK; Sun, 27 Sep 2026 03:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790494013; bh=oC2OdQipuIfHht6ooejKFBxt2QCVeFHcjtBDdwa2rHc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WcWCJZlWc5tn7NgCkmCu5P9qnVrMaJKXZ/EzZfYR58DZwXY9WQfj9EELU/nhn2aqp
 Ub9TXmJzmaMxmIM7b0vBDF4TzyPidbG10bCuEgHfK07+zTLzJ9QtF1BuJ0h3TQ/tEm
 vnxRPKtB3TbK4ktMszxRLKbxGRrngxuIBU1Sf73XgYZrIhTmCaO2XDI2Q4V1mbkotL
 BiggVMpvcz0DCZnr5O+g611gcJt/NgYGCSw+c3WzbA/R5oWrbIjvKWAs4a+pCsfzOz
 H0Z6JmjqGiixNLeiZ0gOidT6FSSVpljOKFhNsNUFE4aIMmwHcwCKC7hCUM/L+y2cEx
 dyk94os63fj+g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0FB7E1D8ABA;
 Sun, 27 Sep 2026 10:26:53 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0D18043204C;
 Sun, 27 Sep 2026 10:26:53 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id DE14D5E623; Sun, 27 Sep 2026 10:26:52 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 v2 56/72] hw/9pfs: mutate FID path from main thread
 only (CVE-2026-93834)
Date: Sun, 27 Sep 2026 10:25:48 +0300
Message-ID: <20260927072622.93656-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260927020824@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260927020824@cover.tls.msk.ru>
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

v9fs_co_open2() is the only code that mutates a FID path from a worker
thread: inside its v9fs_co_run_in_worker() block it frees fidp->path
and copies in the new path under the held FID path write lock.

Every other FID path mutation in the 9p codebase happens on the main
thread, so main thread readers (v9fs_walk(), v9fs_xattrwalk(),
v9fs_stat(), v9fs_co_name_to_path()) rely on the same (main) thread
atomicity and don't take the path read lock themselves on main thread.

Fix this by making the worker thread block in v9fs_co_open2() read-only
with respect to the FID: render the new path into the local 'path'
variable only and copy it to fidp->path after the worker block returned
back to the main thread and still under the held write lock of the FID,
like every other FID path mutation does.

Fixes: 02cb7f3a25 ("hw/9pfs: Use read-write lock for protecting fid path.")
Fixes: CVE-2026-93834
Reported-by: Milad Nasr <https://gitlab.com/sirkhezr>
Suggested-by: Milad Nasr <https://gitlab.com/sirkhezr>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4491
Reviewed-by: Greg Kurz <groug@kaod.org>
Link: https://lore.kernel.org/qemu-devel/E1x8d3N-003M3F-Pz@kylie.crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit fe9e30899ffceef25cf345ec83f76546afca19dd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/cofile.c b/hw/9pfs/cofile.c
index 71174c3e4ab..af36d5b24fd 100644
--- a/hw/9pfs/cofile.c
+++ b/hw/9pfs/cofile.c
@@ -143,10 +143,11 @@ int coroutine_fn v9fs_co_open2(V9fsPDU *pdu, V9fsFidState *fidp,
     cred.fc_mode = mode & 07777;
     cred.fc_uid = fidp->uid;
     cred.fc_gid = gid;
+    v9fs_path_init(&path);
     /*
      * Hold the directory fid lock so that directory path name
-     * don't change. Take the write lock to be sure this fid
-     * cannot be used by another operation.
+     * don't change. Take the write lock since the fid path is
+     * mutated below on success.
      */
     v9fs_path_write_lock(s);
     v9fs_co_run_in_worker(
@@ -156,23 +157,30 @@ int coroutine_fn v9fs_co_open2(V9fsPDU *pdu, V9fsFidState *fidp,
             if (err < 0) {
                 err = -errno;
             } else {
-                v9fs_path_init(&path);
                 err = v9fs_name_to_path(s, &fidp->path, name->data, &path);
                 if (!err) {
                     err = s->ops->lstat(&s->ctx, &path, stbuf);
                     if (err < 0) {
                         err = -errno;
                         s->ops->close(&s->ctx, &fidp->fs);
-                    } else {
-                        v9fs_path_copy(&fidp->path, &path);
                     }
                 } else {
                     s->ops->close(&s->ctx, &fidp->fs);
                 }
-                v9fs_path_free(&path);
             }
         });
+    /*
+     * The fid path must not be mutated from the worker thread: other
+     * requests may access the same fid on the main thread, and the main
+     * thread never takes the path lock for reads. Mutate the new path
+     * here, on the main thread and still under the held write lock, like
+     * every other mutation of a fid path.
+     */
+    if (!err) {
+        v9fs_path_copy(&fidp->path, &path);
+    }
     v9fs_path_unlock(s);
+    v9fs_path_free(&path);
     if (!err) {
         total_open_fd++;
         if (total_open_fd > open_fd_hw) {
-- 
2.47.3


