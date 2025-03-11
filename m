Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8BDC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 17:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts3PI-00017P-5w; Tue, 11 Mar 2025 13:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1ts3PE-00016c-9t
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:28:40 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1ts3P8-0004wy-9w
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:28:40 -0400
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-z5JMG-stPPmuJ_BS87444A-1; Tue,
 11 Mar 2025 13:28:22 -0400
X-MC-Unique: z5JMG-stPPmuJ_BS87444A-1
X-Mimecast-MFC-AGG-ID: z5JMG-stPPmuJ_BS87444A_1741714101
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8CC3180025A; Tue, 11 Mar 2025 17:28:20 +0000 (UTC)
Received: from bahia.redhat.com (unknown [10.44.32.85])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A8B201955BCB; Tue, 11 Mar 2025 17:28:18 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v2 2/6] 9pfs: Don't use file descriptors in core code
Date: Tue, 11 Mar 2025 18:28:05 +0100
Message-ID: <20250311172809.250913-3-groug@kaod.org>
In-Reply-To: <20250311172809.250913-1-groug@kaod.org>
References: <20250311172809.250913-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: softfail client-ip=205.139.111.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, PDS_OTHER_BAD_TLD=0.413,
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

Signed-off-by: Greg Kurz <groug@kaod.org>

v2: - rename to has_valid_file_handle()
    - don't reuse local_fid_fd()
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
index 7cad2bce6209..10363f1a1df8 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1574,6 +1574,11 @@ out_nofid:
     pdu_complete(pdu, err);
 }
 
+static bool fid_has_valid_handle(V9fsState *s, V9fsFidState *fidp)
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
+    if (fid_has_valid_handle(pdu->s, fidp)) {
         retval = v9fs_co_fstat(pdu, fidp, &stbuf);
     } else {
         retval = v9fs_co_lstat(pdu, &fidp->path, &stbuf);
-- 
2.48.1


