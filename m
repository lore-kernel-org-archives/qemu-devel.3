Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E99BC28B2F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 15:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsO1s-0002uv-KZ; Wed, 12 Mar 2025 11:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tsO1q-0002rf-GB
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 11:29:54 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tsO1n-0001cN-C7
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 11:29:54 -0400
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-8d0yRP1POJuoLzSuZbNBBQ-1; Wed,
 12 Mar 2025 11:29:46 -0400
X-MC-Unique: 8d0yRP1POJuoLzSuZbNBBQ-1
X-Mimecast-MFC-AGG-ID: 8d0yRP1POJuoLzSuZbNBBQ_1741793385
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 965D919560B3; Wed, 12 Mar 2025 15:29:44 +0000 (UTC)
Received: from bahia.redhat.com (unknown [10.44.32.39])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1341A18001E9; Wed, 12 Mar 2025 15:29:41 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v3 2/6] 9pfs: Don't use file descriptors in core code
Date: Wed, 12 Mar 2025 16:29:28 +0100
Message-ID: <20250312152933.383967-3-groug@kaod.org>
In-Reply-To: <20250312152933.383967-1-groug@kaod.org>
References: <20250312152933.383967-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: softfail client-ip=205.139.111.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, PDS_OTHER_BAD_TLD=0.687,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

v9fs_getattr() currently peeks into V9fsFidOpenState to know if a fid
has a valid file descriptor or directory stream. Even though the fields
are accessible, this is an implementation detail of the local backend
that should not be manipulated directly by the server code.

Abstract that with a new has_valid_file_handle() backend operation.

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Signed-off-by: Greg Kurz <groug@kaod.org>

v2: - rename to has_valid_file_handle()
    - don't reuse local_fid_fd()

v3: - rename to fid_has_valid_file_handle()
---
 fsdev/file-op-9p.h | 1 +
 hw/9pfs/9p-local.c | 8 ++++++++
 hw/9pfs/9p-synth.c | 6 ++++++
 hw/9pfs/9p.c       | 9 ++++++---
 4 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index 4997677460e8..b815cea44e85 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -164,6 +164,7 @@ struct FileOperations {
     int (*renameat)(FsContext *ctx, V9fsPath *olddir, const char *old_name,
                     V9fsPath *newdir, const char *new_name);
     int (*unlinkat)(FsContext *ctx, V9fsPath *dir, const char *name, int flags);
+    bool (*has_valid_file_handle)(int fid_type, V9fsFidOpenState *fs);
 };
 
 #endif
diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 99b9560a528b..b16132299f2c 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1572,6 +1572,13 @@ static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
     return 0;
 }
 
+static bool local_has_valid_file_handle(int fid_type, V9fsFidOpenState *fs)
+{
+    return
+        (fid_type == P9_FID_FILE && fs->fd != -1) ||
+        (fid_type == P9_FID_DIR && fs->dir.stream != NULL);
+}
+
 FileOperations local_ops = {
     .parse_opts = local_parse_opts,
     .init  = local_init,
@@ -1609,4 +1616,5 @@ FileOperations local_ops = {
     .name_to_path = local_name_to_path,
     .renameat  = local_renameat,
     .unlinkat = local_unlinkat,
+    .has_valid_file_handle = local_has_valid_file_handle,
 };
diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index 2abaf3a2918a..be0492b400e1 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -615,6 +615,11 @@ static int synth_init(FsContext *ctx, Error **errp)
     return 0;
 }
 
+static bool synth_has_valid_file_handle(int fid_type, V9fsFidOpenState *fs)
+{
+    return false;
+}
+
 FileOperations synth_ops = {
     .init         = synth_init,
     .lstat        = synth_lstat,
@@ -650,4 +655,5 @@ FileOperations synth_ops = {
     .name_to_path = synth_name_to_path,
     .renameat     = synth_renameat,
     .unlinkat     = synth_unlinkat,
+    .has_valid_file_handle = synth_has_valid_file_handle,
 };
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 7cad2bce6209..9e4756c535f5 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1574,6 +1574,11 @@ out_nofid:
     pdu_complete(pdu, err);
 }
 
+static bool fid_has_valid_file_handle(V9fsState *s, V9fsFidState *fidp)
+{
+    return s->ops->has_valid_file_handle(fidp->fid_type, &fidp->fs);
+}
+
 static void coroutine_fn v9fs_getattr(void *opaque)
 {
     int32_t fid;
@@ -1596,9 +1601,7 @@ static void coroutine_fn v9fs_getattr(void *opaque)
         retval = -ENOENT;
         goto out_nofid;
     }
-    if ((fidp->fid_type == P9_FID_FILE && fidp->fs.fd != -1) ||
-        (fidp->fid_type == P9_FID_DIR && fidp->fs.dir.stream))
-    {
+    if (fid_has_valid_file_handle(pdu->s, fidp)) {
         retval = v9fs_co_fstat(pdu, fidp, &stbuf);
     } else {
         retval = v9fs_co_lstat(pdu, &fidp->path, &stbuf);
-- 
2.48.1


