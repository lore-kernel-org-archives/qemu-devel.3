Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040ABC2BA1B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 17:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts3P6-00013v-Ox; Tue, 11 Mar 2025 13:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1ts3P5-00013a-9a
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:28:31 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1ts3P3-0004wX-5K
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:28:31 -0400
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-I2Bodd4IMeG5pBfn4pQ3jw-1; Tue,
 11 Mar 2025 13:28:24 -0400
X-MC-Unique: I2Bodd4IMeG5pBfn4pQ3jw-1
X-Mimecast-MFC-AGG-ID: I2Bodd4IMeG5pBfn4pQ3jw_1741714103
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DB0F180AF52; Tue, 11 Mar 2025 17:28:23 +0000 (UTC)
Received: from bahia.redhat.com (unknown [10.44.32.85])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 785871944F2F; Tue, 11 Mar 2025 17:28:21 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v2 3/6] 9pfs: Introduce ftruncate file op
Date: Tue, 11 Mar 2025 18:28:06 +0100
Message-ID: <20250311172809.250913-4-groug@kaod.org>
In-Reply-To: <20250311172809.250913-1-groug@kaod.org>
References: <20250311172809.250913-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: softfail client-ip=207.211.30.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

Add an ftruncate operation to the fs driver and use if when a fid has
a valid file descriptor. This is required to support more cases where
the client wants to do an action on an unlinked file which it still
has an open file decriptor for.

Only 9P2000.L was considered.

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Signed-off-by: Greg Kurz <groug@kaod.org>

v2: - moved v9fs_co_ftruncate() near v9fs_co_truncate() in coth.h
    - similar change in file-op-9p.h
---
 fsdev/file-op-9p.h |  2 ++
 hw/9pfs/9p-local.c |  9 +++++++++
 hw/9pfs/9p-synth.c |  8 ++++++++
 hw/9pfs/9p.c       |  6 +++++-
 hw/9pfs/cofs.c     | 18 ++++++++++++++++++
 hw/9pfs/coth.h     |  2 ++
 6 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index b815cea44e85..26ba1438c0ed 100644
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
index b16132299f2c..0b33da8d2a46 100644
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
index be0492b400e1..3d28afc4d03d 100644
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
index 10363f1a1df8..4616bd763012 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1733,7 +1733,11 @@ static void coroutine_fn v9fs_setattr(void *opaque)
         }
     }
     if (v9iattr.valid & (P9_ATTR_SIZE)) {
-        err = v9fs_co_truncate(pdu, &fidp->path, v9iattr.size);
+        if (fid_has_valid_handle(pdu->s, fidp)) {
+            err = v9fs_co_ftruncate(pdu, fidp, v9iattr.size);
+        } else {
+            err = v9fs_co_truncate(pdu, &fidp->path, v9iattr.size);
+        }
         if (err < 0) {
             goto out;
         }
diff --git a/hw/9pfs/cofs.c b/hw/9pfs/cofs.c
index 67e3ae5c5ccd..893466fb1a44 100644
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
index 2c54249b3577..62e922dc12e3 100644
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
2.48.1


