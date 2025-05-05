Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F84C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBsWr-0002ls-QQ; Mon, 05 May 2025 05:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <f2bb367d2b265c6c0ead1e0d4a8f7c43310b3107@kylie.crudebyte.com>)
 id 1uBsWp-0002lF-Hz
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:54:27 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <f2bb367d2b265c6c0ead1e0d4a8f7c43310b3107@kylie.crudebyte.com>)
 id 1uBsWn-0005Ff-TY
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=oyO2mqwCHl47iGA7Q3ZhtH/x6hTM+QH2IElqURqdUIg=; b=E1TPt
 ofxOz7ZT4lUeJ7W9lHf0348vLJ8T9Cd1RdHGd9hoOx+uGypOB9C3Tk8eO8OqGJxqQZlcoFJQbFlua
 MyZQ+1NoD7I97mBl9yg9vOfd8kSawEIsA2C/0z2bN9/wk/ZCJ0on5CwMnr63YKrkm4zbrnFFwSrIR
 LLNkirw5w0QA79Dyc4IZiU9GHbPIwLDYPeQOeWCLC8dHVeGez8R1EK0u37QYHHXDybvceRFvPCacH
 bk5dkMbqleoEj5ETqdoAD+D08PAotF8aihVBiA/qYaj6oMWmj1qBYdKsCjL68aZTwY8sNRWokeiVF
 cgcUGY0ZFGG5VBtfgz2Rq4ujrsLxdNB88I6XginWtK/uV5Hk0gYVQ7C8YIPph00++Yd9doQV2nVm9
 I89NE54OCWRb3nBfKUWeDDfWwUt1IRFlbQrBSvWIoj3/GpE30MnuvAtqeUf/oyZ2bpIGYS1w5Q8XJ
 7gzVeq1dS61rNux++P77spvmKUfn4X/dTSN0wG3GGmo85B+yK/GPuxmh1snGGKXGKBQE5MR+coVzo
 34n93vwUywzSW+ByCxN6o+Q5uINw9cvx1MzI+/uI25dsOtd/vyEqaPAiFBhjmOqH7tzb38COKCj3/
 eRAzEnFMs2idcrSW5nStfov+x87Tqx0HgzKHEwB1eIiPqexBgSjzSEpo1V/938=;
Message-Id: <f2bb367d2b265c6c0ead1e0d4a8f7c43310b3107.1746438650.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1746438650.git.qemu_oss@crudebyte.com>
References: <cover.1746438650.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 05 May 2025 11:50:51 +0200
Subject: [PULL 4/9] 9pfs: Don't use file descriptors in core code
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=f2bb367d2b265c6c0ead1e0d4a8f7c43310b3107@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

v9fs_getattr() currently peeks into V9fsFidOpenState to know if a fid
has a valid file descriptor or directory stream. Even though the fields
are accessible, this is an implementation detail of the local backend
that should not be manipulated directly by the server code.

Abstract that with a new has_valid_file_handle() backend operation.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-Id: <20250312152933.383967-3-groug@kaod.org>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 fsdev/file-op-9p.h | 1 +
 hw/9pfs/9p-local.c | 8 ++++++++
 hw/9pfs/9p-synth.c | 6 ++++++
 hw/9pfs/9p.c       | 9 ++++++---
 4 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index 4997677460..b815cea44e 100644
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
index 99b9560a52..b16132299f 100644
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
index 2abaf3a291..be0492b400 100644
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
index 80b190ff5b..4586822d24 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1593,6 +1593,11 @@ out_nofid:
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
@@ -1615,9 +1620,7 @@ static void coroutine_fn v9fs_getattr(void *opaque)
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
2.30.2


