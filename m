Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EEFC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBsX0-0002ot-FQ; Mon, 05 May 2025 05:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <0c798dd52355f3489b29bba0dfd7df0e24cfa1dd@kylie.crudebyte.com>)
 id 1uBsWw-0002nl-D9
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:54:35 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <0c798dd52355f3489b29bba0dfd7df0e24cfa1dd@kylie.crudebyte.com>)
 id 1uBsWu-0005GJ-Is
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=c6TuOckUB+xdLBrg0kI5CktW0lfDyX0RaJSYWF+/QF4=; b=QysC7
 c9rd4GvNuOzTS4ylJBifv091BnQMw0Oa6EkxjUbOh5i2GfaVPztMQt8pjZ5eR0zb768+Sh4ctHWZk
 Jl6fb4+oXJNggmqbYj9lfeiKOSj4f5WThzrScvTbsQrYtTxK583tNFRpV+2ceOsC+kcN/npcSlEhV
 pqk7IrP8ZBrrhYvtXgvKHN2cdGre32gSwGi6c8CnKasCAyVi6mRCRFN9Cnk+S6pptJz7pXgmsTnZh
 QtlovZcJZMHBC/mjLQXTIwYEMsIphROuNg234IaGAaftiwa4TSk49wMQdkty1c29dYAFVuIFh1hnW
 4ejpQY5I5hFqUYDxIA0ydRMEEAAMtAdMMcvKlQp9iF+zvr9Q25lSLONOyab4WBXEeBLu0dg5WRXS2
 b8TZpyST7udvDea3Z1LYkzbFke8hmpOjZfQbBCM2cV7vRl78GUnOjInx5sD++KwoHxUdIEPrNCbkD
 rFAvf6BG48RHXM1Mz+wgEQ5QFqS1qR+R0+VzHicAjvXPpc37dYKBx/24VXakQ4hazaFKLlz247t2+
 6Ff1H064etVuwb7Zo+B2xfN6f33b8+rm5Ol0+fYAB2T/6nNDm8EY4XvBwsZU8GheQD8slDFyUA4jr
 AGePRS4DBYsnXlv18VKrTEGWuiKDxh4UrEpABf1fDEDDjwhh1QtHvnTmrhqL9Q=;
Message-Id: <0c798dd52355f3489b29bba0dfd7df0e24cfa1dd.1746438650.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1746438650.git.qemu_oss@crudebyte.com>
References: <cover.1746438650.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 05 May 2025 11:50:51 +0200
Subject: [PULL 5/9] 9pfs: Introduce ftruncate file op
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=0c798dd52355f3489b29bba0dfd7df0e24cfa1dd@kylie.crudebyte.com;
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

Add an ftruncate operation to the fs driver and use if when a fid has
a valid file descriptor. This is required to support more cases where
the client wants to do an action on an unlinked file which it still
has an open file decriptor for.

Only 9P2000.L was considered.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-Id: <20250312152933.383967-4-groug@kaod.org>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 fsdev/file-op-9p.h |  2 ++
 hw/9pfs/9p-local.c |  9 +++++++++
 hw/9pfs/9p-synth.c |  8 ++++++++
 hw/9pfs/9p.c       |  6 +++++-
 hw/9pfs/cofs.c     | 18 ++++++++++++++++++
 hw/9pfs/coth.h     |  2 ++
 6 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index b815cea44e..26ba1438c0 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -152,6 +152,8 @@ struct FileOperations {
     int (*fstat)(FsContext *, int, V9fsFidOpenState *, struct stat *);
     int (*rename)(FsContext *, const char *, const char *);
     int (*truncate)(FsContext *, V9fsPath *, off_t);
+    int (*ftruncate)(FsContext *ctx, int fid_type, V9fsFidOpenState *fs,
+                     off_t size);
     int (*fsync)(FsContext *, int, V9fsFidOpenState *, int);
     int (*statfs)(FsContext *s, V9fsPath *path, struct statfs *stbuf);
     ssize_t (*lgetxattr)(FsContext *, V9fsPath *,
diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index b16132299f..0b33da8d2a 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1042,6 +1042,14 @@ static int local_truncate(FsContext *ctx, V9fsPath *fs_path, off_t size)
     return ret;
 }
 
+static int local_ftruncate(FsContext *ctx, int fid_type, V9fsFidOpenState *fs,
+                           off_t size)
+{
+    int fd = local_fid_fd(fid_type, fs);
+
+    return ftruncate(fd, size);
+}
+
 static int local_chown(FsContext *fs_ctx, V9fsPath *fs_path, FsCred *credp)
 {
     char *dirpath = g_path_get_dirname(fs_path->data);
@@ -1617,4 +1625,5 @@ FileOperations local_ops = {
     .renameat  = local_renameat,
     .unlinkat = local_unlinkat,
     .has_valid_file_handle = local_has_valid_file_handle,
+    .ftruncate = local_ftruncate,
 };
diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index be0492b400..3d28afc4d0 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -356,6 +356,13 @@ static int synth_truncate(FsContext *ctx, V9fsPath *path, off_t offset)
     return -1;
 }
 
+static int synth_ftruncate(FsContext *ctx, int fid_type, V9fsFidOpenState *fs,
+                           off_t size)
+{
+    errno = ENOSYS;
+    return -1;
+}
+
 static int synth_chmod(FsContext *fs_ctx, V9fsPath *path, FsCred *credp)
 {
     errno = EPERM;
@@ -656,4 +663,5 @@ FileOperations synth_ops = {
     .renameat     = synth_renameat,
     .unlinkat     = synth_unlinkat,
     .has_valid_file_handle = synth_has_valid_file_handle,
+    .ftruncate    = synth_ftruncate,
 };
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 4586822d24..c96f2d2d3d 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1752,7 +1752,11 @@ static void coroutine_fn v9fs_setattr(void *opaque)
         }
     }
     if (v9iattr.valid & (P9_ATTR_SIZE)) {
-        err = v9fs_co_truncate(pdu, &fidp->path, v9iattr.size);
+        if (fid_has_valid_file_handle(pdu->s, fidp)) {
+            err = v9fs_co_ftruncate(pdu, fidp, v9iattr.size);
+        } else {
+            err = v9fs_co_truncate(pdu, &fidp->path, v9iattr.size);
+        }
         if (err < 0) {
             goto out;
         }
diff --git a/hw/9pfs/cofs.c b/hw/9pfs/cofs.c
index 67e3ae5c5c..893466fb1a 100644
--- a/hw/9pfs/cofs.c
+++ b/hw/9pfs/cofs.c
@@ -184,6 +184,24 @@ int coroutine_fn v9fs_co_truncate(V9fsPDU *pdu, V9fsPath *path, off_t size)
     return err;
 }
 
+int coroutine_fn v9fs_co_ftruncate(V9fsPDU *pdu, V9fsFidState *fidp, off_t size)
+{
+    int err;
+    V9fsState *s = pdu->s;
+
+    if (v9fs_request_cancelled(pdu)) {
+        return -EINTR;
+    }
+    v9fs_co_run_in_worker(
+        {
+            err = s->ops->ftruncate(&s->ctx, fidp->fid_type, &fidp->fs, size);
+            if (err < 0) {
+                err = -errno;
+            }
+        });
+    return err;
+}
+
 int coroutine_fn v9fs_co_mknod(V9fsPDU *pdu, V9fsFidState *fidp,
                                V9fsString *name, uid_t uid, gid_t gid,
                                dev_t dev, mode_t mode, struct stat *stbuf)
diff --git a/hw/9pfs/coth.h b/hw/9pfs/coth.h
index 2c54249b35..62e922dc12 100644
--- a/hw/9pfs/coth.h
+++ b/hw/9pfs/coth.h
@@ -73,6 +73,8 @@ int coroutine_fn v9fs_co_chmod(V9fsPDU *, V9fsPath *, mode_t);
 int coroutine_fn v9fs_co_utimensat(V9fsPDU *, V9fsPath *, struct timespec [2]);
 int coroutine_fn v9fs_co_chown(V9fsPDU *, V9fsPath *, uid_t, gid_t);
 int coroutine_fn v9fs_co_truncate(V9fsPDU *, V9fsPath *, off_t);
+int coroutine_fn v9fs_co_ftruncate(V9fsPDU *pdu, V9fsFidState *fidp,
+                                   off_t size);
 int coroutine_fn v9fs_co_llistxattr(V9fsPDU *, V9fsPath *, void *, size_t);
 int coroutine_fn v9fs_co_lgetxattr(V9fsPDU *, V9fsPath *,
                                    V9fsString *, void *, size_t);
-- 
2.30.2


