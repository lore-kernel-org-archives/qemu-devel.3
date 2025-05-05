Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369A8C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBsX3-0002qs-Pc; Mon, 05 May 2025 05:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <371a269ff8ce561c28e4fa03bb49e4940f990637@kylie.crudebyte.com>)
 id 1uBsX1-0002pN-LO
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:54:39 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <371a269ff8ce561c28e4fa03bb49e4940f990637@kylie.crudebyte.com>)
 id 1uBsWz-0005HG-RR
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=t/0feC26H2wQMLu3d7ad5AcGmcbMPiwv+MCHrSUoGgY=; b=jdrnd
 n8XFK8MkTCFoaf0XYXLDzI8vtYR2vo5AxXqjTzSOcfCWgL0Dn8I5RSbN3AuFuUOZq0UOQqnNRBwtH
 sTjrDVlqU2/tzOmlOkz5muk7IvJws7l9PZ6JQlSTo2suXNqM944gjIwcRHkujoOX5TwXyTXotO7B6
 qXyfk1GITgrP+Dh/okfI0lJzQ63KQP31o9QQuvFjfaxZIY22DRQxKnrafSTTG8Pxvl3RU7eMLHoRI
 5YLaFS7U+rb6YXXGjPd1umcgLXujea62IVwExxOXO2DmjvhhT+89KZ//WrpO+f1k0IFDluCrclsGY
 aNusc0+0gXumTflrwRwn4/UWhUfAYIW2ux56Bpq2nVbEOmwBXSy9Iq8Afn8iPbwyDQrIAQNZWSMyq
 VIz8BPP/JVD/APP46tk9Bz2dZiiD1XfhEasfR/W7is568Zb6dsm8hyKjsH1lHCYczUNO1pLVXVY/K
 PhQrVCLjJItvr/iOKUE2w5aNPqKMiRKhT3y9M8ig0AhWimHOC1zR8d0Rp15Q2yIY4wtZn8sydrZDN
 5JGS+AZojtoFWrCaRMNVER/bSuslzd9tADJiMT2PuMX26MurX2b88+sPSOToFt0kbBgzb/e4z6K3c
 tPnZ9Fc2PpZOnFKdgEgGNw7nGstOzZGWY1aNLzHHEZM5eqEv1rGIV7ey9sZoss=;
Message-Id: <371a269ff8ce561c28e4fa03bb49e4940f990637.1746438650.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1746438650.git.qemu_oss@crudebyte.com>
References: <cover.1746438650.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 05 May 2025 11:50:51 +0200
Subject: [PULL 6/9] 9pfs: Introduce futimens file op
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=371a269ff8ce561c28e4fa03bb49e4940f990637@kylie.crudebyte.com;
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

From: Greg Kurz <groug@kaod.org>

Add an futimens operation to the fs driver and use if when a fid has
a valid file descriptor. This is required to support more cases where
the client wants to do an action on an unlinked file which it still
has an open file decriptor for.

Only 9P2000.L was considered.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-Id: <20250312152933.383967-5-groug@kaod.org>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 fsdev/file-op-9p.h |  2 ++
 hw/9pfs/9p-local.c |  9 +++++++++
 hw/9pfs/9p-synth.c |  8 ++++++++
 hw/9pfs/9p-util.h  |  1 +
 hw/9pfs/9p.c       |  6 +++++-
 hw/9pfs/cofs.c     | 19 +++++++++++++++++++
 hw/9pfs/coth.h     |  2 ++
 7 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index 26ba1438c0..b9dae8c84c 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -129,6 +129,8 @@ struct FileOperations {
     int (*chown)(FsContext *, V9fsPath *, FsCred *);
     int (*mknod)(FsContext *, V9fsPath *, const char *, FsCred *);
     int (*utimensat)(FsContext *, V9fsPath *, const struct timespec *);
+    int (*futimens)(FsContext *ctx, int fid_type, V9fsFidOpenState *fs,
+                    const struct timespec *times);
     int (*remove)(FsContext *, const char *);
     int (*symlink)(FsContext *, const char *, V9fsPath *,
                    const char *, FsCred *);
diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 0b33da8d2a..31e216227c 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1100,6 +1100,14 @@ out:
     return ret;
 }
 
+static int local_futimens(FsContext *s, int fid_type, V9fsFidOpenState *fs,
+                          const struct timespec *times)
+{
+    int fd = local_fid_fd(fid_type, fs);
+
+    return qemu_futimens(fd, times);
+}
+
 static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
                                  int flags)
 {
@@ -1626,4 +1634,5 @@ FileOperations local_ops = {
     .unlinkat = local_unlinkat,
     .has_valid_file_handle = local_has_valid_file_handle,
     .ftruncate = local_ftruncate,
+    .futimens = local_futimens,
 };
diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index 3d28afc4d0..9cd1884224 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -424,6 +424,13 @@ static int synth_utimensat(FsContext *fs_ctx, V9fsPath *path,
     return 0;
 }
 
+static int synth_futimens(FsContext *fs_ctx, int fid_type, V9fsFidOpenState *fs,
+                          const struct timespec *buf)
+{
+    errno = ENOSYS;
+    return -1;
+}
+
 static int synth_remove(FsContext *ctx, const char *path)
 {
     errno = EPERM;
@@ -664,4 +671,5 @@ FileOperations synth_ops = {
     .unlinkat     = synth_unlinkat,
     .has_valid_file_handle = synth_has_valid_file_handle,
     .ftruncate    = synth_ftruncate,
+    .futimens     = synth_futimens,
 };
diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index 7bc4ec8e85..a1924fe3f0 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -103,6 +103,7 @@ static inline int errno_to_dotl(int err) {
 #define qemu_renameat   renameat
 #define qemu_utimensat  utimensat
 #define qemu_unlinkat   unlinkat
+#define qemu_futimens   futimens
 
 static inline void close_preserve_errno(int fd)
 {
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index c96f2d2d3d..b22df3aa2b 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1727,7 +1727,11 @@ static void coroutine_fn v9fs_setattr(void *opaque)
         } else {
             times[1].tv_nsec = UTIME_OMIT;
         }
-        err = v9fs_co_utimensat(pdu, &fidp->path, times);
+        if (fid_has_valid_file_handle(pdu->s, fidp)) {
+            err = v9fs_co_futimens(pdu, fidp, times);
+        } else {
+            err = v9fs_co_utimensat(pdu, &fidp->path, times);
+        }
         if (err < 0) {
             goto out;
         }
diff --git a/hw/9pfs/cofs.c b/hw/9pfs/cofs.c
index 893466fb1a..12fa8c9fe9 100644
--- a/hw/9pfs/cofs.c
+++ b/hw/9pfs/cofs.c
@@ -139,6 +139,25 @@ int coroutine_fn v9fs_co_utimensat(V9fsPDU *pdu, V9fsPath *path,
     return err;
 }
 
+int coroutine_fn v9fs_co_futimens(V9fsPDU *pdu, V9fsFidState *fidp,
+                                  struct timespec times[2])
+{
+    int err;
+    V9fsState *s = pdu->s;
+
+    if (v9fs_request_cancelled(pdu)) {
+        return -EINTR;
+    }
+    v9fs_co_run_in_worker(
+        {
+            err = s->ops->futimens(&s->ctx, fidp->fid_type, &fidp->fs, times);
+            if (err < 0) {
+                err = -errno;
+            }
+        });
+    return err;
+}
+
 int coroutine_fn v9fs_co_chown(V9fsPDU *pdu, V9fsPath *path, uid_t uid,
                                gid_t gid)
 {
diff --git a/hw/9pfs/coth.h b/hw/9pfs/coth.h
index 62e922dc12..7906fa7782 100644
--- a/hw/9pfs/coth.h
+++ b/hw/9pfs/coth.h
@@ -71,6 +71,8 @@ int coroutine_fn v9fs_co_statfs(V9fsPDU *, V9fsPath *, struct statfs *);
 int coroutine_fn v9fs_co_lstat(V9fsPDU *, V9fsPath *, struct stat *);
 int coroutine_fn v9fs_co_chmod(V9fsPDU *, V9fsPath *, mode_t);
 int coroutine_fn v9fs_co_utimensat(V9fsPDU *, V9fsPath *, struct timespec [2]);
+int coroutine_fn v9fs_co_futimens(V9fsPDU *pdu, V9fsFidState *fidp,
+                                  struct timespec times[2]);
 int coroutine_fn v9fs_co_chown(V9fsPDU *, V9fsPath *, uid_t, gid_t);
 int coroutine_fn v9fs_co_truncate(V9fsPDU *, V9fsPath *, off_t);
 int coroutine_fn v9fs_co_ftruncate(V9fsPDU *pdu, V9fsFidState *fidp,
-- 
2.30.2


