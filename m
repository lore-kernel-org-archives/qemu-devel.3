Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0CBC44506
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wilcN-0001bv-KS; Sun, 12 Jul 2026 00:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilcL-0001au-7d; Sun, 12 Jul 2026 00:16:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilcJ-0006Eh-HC; Sun, 12 Jul 2026 00:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829780; bh=cGtgySVNMmES5ZCARjyRWzqDlJ9yTk1+cOw7Ki4QPLw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AhpcJWfkZoZBL1BxpxCNuHm5P4or3v3I8kP9z1oDi+CIQIpBl3yK04CIjRp0FesDD
 w73CLam66/IPK6funDbexaDSmKk16Hn2YbdHPyB603GMH3ZEUt2kwFKU9OdPYJM3Q+
 bJFVCceG1mRtryqB5twPmJzXfMOURepHUesg1fZzb5nQlgewGxHWmxc2qPpOsN6Xb8
 RVF6BsCXxfCYtxNJpDemFwzaRZPK8FH5CvUyPruh1PzDtJ9hpRq2I8qRTAjjJc1fnI
 KHdKu3cfEKzfZqHDPKHRE/znShCvFU9N3rjdb+QakCrWiZsv+uOtCA+60YE0xqMZjz
 6hafsT2idCdGQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A88FF1C0BDE;
 Sun, 12 Jul 2026 07:16:20 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D92ED3EB93E;
 Sun, 12 Jul 2026 07:16:30 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 1C4C4133BF; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 03/75] 9pfs: Don't use file descriptors in core code
Date: Sun, 12 Jul 2026 07:14:21 +0300
Message-ID: <20260712041539.108341-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01 autolearn=ham autolearn_force=no
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
(cherry picked from commit f2bb367d2b265c6c0ead1e0d4a8f7c43310b3107)
(Mjt: pick this one up so subsequent commits are applied cleanly)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index c453b6494be..29057d0d363 100644
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
index 5167c43609b..c5309c5ba45 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1584,6 +1584,13 @@ static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
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
@@ -1621,4 +1628,5 @@ FileOperations local_ops = {
     .name_to_path = local_name_to_path,
     .renameat  = local_renameat,
     .unlinkat = local_unlinkat,
+    .has_valid_file_handle = local_has_valid_file_handle,
 };
diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index 2abaf3a2918..be0492b400e 100644
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
index 34ac2c3c9af..52806670235 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1607,6 +1607,11 @@ out_nofid:
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
@@ -1629,9 +1634,7 @@ static void coroutine_fn v9fs_getattr(void *opaque)
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
2.47.3


