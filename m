Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6210DC982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8d3X-0002FV-QV; Mon, 21 Sep 2026 08:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <2ecdcd9af56ca251fe689edf09d8029fd0feeed9@kylie.crudebyte.com>)
 id 1x8d3U-0002FD-2X; Mon, 21 Sep 2026 08:23:32 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <2ecdcd9af56ca251fe689edf09d8029fd0feeed9@kylie.crudebyte.com>)
 id 1x8d3R-0000jR-RK; Mon, 21 Sep 2026 08:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Message-Id:Cc:To:Subject:Date:From:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=xRAjs31oYZHJT4KXgomXBio+IZsCVIU9k+xalIhBFOc=; b=CXlIt
 CynFewY7G99g22mP1deW58kibTLszBV0+UVOSkAoSzsCMRcjJVkAxj996YOT3zBrOx4NlOF9EA4b4
 Z4H9s4ydTUh0YNhGhX4d/1oT23Apg6RdsPWp8Di5hQIIUbcjoCojVG3rT6CXdKl1aOBvMekAl41GN
 V8ktJbG9LwrlDnvAm8okq+VrEqhIV84lWwlhswcwZ/1Qg0AYcEw/rEEuV+dFKPpK3GWvSpqJMoVYk
 aWtgPwKT9x+xCY0tyvTIhCOKewFpS3KOTUMxAih9DPoz4w41llaNkpv6YbH46IEO30W30XEyhOIGB
 bomBD6Zxypk6exbOdNGOME2m0AK0QplneLFNhG6N7Ue6nFFbcqDTLXZiywnP4aa2x/A+fpXWXlYRs
 wonWHzhDbODZXCr075DoNvQC/qfZ0kHwmPm9jIL9P0MkLlxXDRs2XLN2td4+3hio9i89v2bP/pVQZ
 ZsfZJ7Uex8YAnGAPoQZs7Fs6bQdo+OJfF28QYwn98jXGoIVrAd316ZzViDc+p7cbLzYfzndp4jIqb
 ktWnzfCZZYl8/fDxUiqeKy5K0qYt4XkBUse1gjK+a+hBSQVH7i+tIHPpKscHlscqOKYaeMlMxq0ci
 ckQ0hvBgRAfHaT0gO1lTu4eZ1jUIDqJg4nmqLHf9PBNfbamOVn6VmCogPq3U8g=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 21 Sep 2026 14:18:58 +0200
Subject: [PATCH] hw/9pfs: mutate FID path from main thread only
 (CVE-2026-93834)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
    Greg Kurz <groug@kaod.org>
Message-Id: <E1x8d3N-003M3F-Pz@kylie.crudebyte.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=2ecdcd9af56ca251fe689edf09d8029fd0feeed9@kylie.crudebyte.com;
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
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/cofile.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/hw/9pfs/cofile.c b/hw/9pfs/cofile.c
index 6e775c8e41..27fe5bfb20 100644
--- a/hw/9pfs/cofile.c
+++ b/hw/9pfs/cofile.c
@@ -144,10 +144,11 @@ int coroutine_fn v9fs_co_open2(V9fsPDU *pdu, V9fsFidState *fidp,
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
@@ -157,23 +158,30 @@ int coroutine_fn v9fs_co_open2(V9fsPDU *pdu, V9fsFidState *fidp,
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


