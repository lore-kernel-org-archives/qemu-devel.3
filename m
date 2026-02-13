Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E57BEDF151
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqqUQ-0003xc-7o; Fri, 13 Feb 2026 05:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <433d91b2a7751d2df86337a655d321bbed2841db@kylie.crudebyte.com>)
 id 1vqqUM-0003w6-Vi
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:33:31 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <433d91b2a7751d2df86337a655d321bbed2841db@kylie.crudebyte.com>)
 id 1vqqUK-0000v1-9z
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Message-Id:Cc:To:Subject:Date:From:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=ChQcJ6bhf/IOl7AGzGV04RHDMwEkZgcdk7bnXDJBvhg=; b=ct1g8
 BRwF4sj4CXmyvatZK2tTSiBjGFd/ajcq+447kYJSj48Zmb+6mJJZTif8XPDI3Lc7eEUCaE1SBVxEc
 8IBq4rbxuJ49tj9FecPWa4/5i0U98h+2PFP+5YzVrheWFXofNUtdMOI324p+vyCd/XxGLZq0ZV1Wc
 6OFy+iGcBFDUxDYHMpDc771JiHBR7uFVePjebokQoH1cX2uLDG7ySAmsQSYXRwn9d9UlfAUeMnR6d
 aPSk4/MvD2oqFJyBt4V5q8Kxu168UNfwLcfiTivhOkZzwyFUtvr/H4NU8mOWxWLjYhYcvyXIMP3M5
 DY2Pyz9FQMSznIsedpm6KdpmL0w0iGP5+wq7AZNHVMxCk2QXcxPBw7je6mdBDsHzu8k/Lnrjdveot
 Uv6ndLZCf58JssTQf8icXzCym5Ws3N95V0XDARpL4MaBm/CGWTK0emDH8jjYRhoxC1xkXFCCeLJ8d
 lbZBTMWJ+R8Ln8c8kJYW874uNmsmIZbiuIR+GC8/K4TXdVzHNPlBLCIwtlgJrj64+0+HTIFCO91Oz
 Zg44dL2kWDvQSsYrKsci5GYsgdWG227rvJZRo0Hq1oTx6p8MU+NTvNEODwBByrZcJ+tsTrLv7jHKN
 ECFti/RZ8ilIeghoxJuPg9DT67Ln201y4NkCDP6x5A43e8upRuCBiP7qyFcMio=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 13 Feb 2026 10:56:05 +0100
Subject: [PATCH] hw/9pfs: fix heap-buffer-overflow in v9fs_complete_rename
To: qemu-devel@nongnu.org
Cc: Oliver Chang <ochang@google.com>, Alexander Bulekov <alxndr@bu.edu>,
 Mauro Matteo Cascella <mcascell@redhat.com>, Greg Kurz <groug@kaod.org>
Message-Id: <E1vqq09-000FBe-2m@kylie.crudebyte.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=433d91b2a7751d2df86337a655d321bbed2841db@kylie.crudebyte.com;
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

From: Oliver Chang <ochang@google.com>

When `v9fs_complete_rename` is called with `newdirfid == -1`, it attempts to
derive the directory name from `fidp->path.data` using `g_path_get_dirname`.
This logic assumes that `fidp->path.data` always contains a null-terminated
string representing a pathname.

While this assumption holds for the 'local' backend, the 'synth' backend stores
a `V9fsSynthNode *` pointer directly in the `V9fsPath.data` buffer. When using
'synth', `g_path_get_dirname` treats this pointer as a string, often resulting
in a short string like ".".

The subsequent call to `v9fs_co_name_to_path` invokes `synth_name_to_path`,
which expects `dir_path.data` to contain a `V9fsSynthNode *`. It attempts to
read 8 bytes (on 64-bit) from the buffer. If `g_path_get_dirname` returned a
short string, this results in a heap-buffer-overflow read.

Fix this by checking for the `V9FS_PATHNAME_FSCONTEXT` flag in the export
flags. This flag indicates that the backend supports string-based pathnames. If
it is not set (as in the 'synth' backend), return `-EOPNOTSUPP` to prevent
invalid memory access.

Co-authored-by: CodeMender <codemender-patching@google.com>
Fixes: https://issues.oss-fuzz.com/issues/477990727
---
 hw/9pfs/9p.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 6fbe604ce8..546e70f75c 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3310,9 +3310,16 @@ static int coroutine_fn v9fs_complete_rename(V9fsPDU *pdu, V9fsFidState *fidp,
             goto out;
         }
     } else {
-        char *dir_name = g_path_get_dirname(fidp->path.data);
+        char *dir_name;
         V9fsPath dir_path;
 
+        if (!(s->ctx.export_flags & V9FS_PATHNAME_FSCONTEXT)) {
+            /* path renaming is only supported for path based fid */
+            err = -EOPNOTSUPP;
+            goto out;
+        }
+
+        dir_name = g_path_get_dirname(fidp->path.data);
         v9fs_path_init(&dir_path);
         v9fs_path_sprintf(&dir_path, "%s", dir_name);
         g_free(dir_name);
-- 

