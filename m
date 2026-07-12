Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E97C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wild0-0002oI-4g; Sun, 12 Jul 2026 00:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilcx-0002hG-ES; Sun, 12 Jul 2026 00:17:15 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilcv-0006Lj-E8; Sun, 12 Jul 2026 00:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829780; bh=u1nWC9gQeIVwKTsz8GMyhTzE1qrL1/SscLdFG4jJ4Gs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dDCSbln9OomYpWlyi1XYYx6Nq55b3DMBmRSiOdDLcgqTaaxAwcY/Rw1IQHxwa47uY
 JHsM1LHsnd7Jd/m1JTDtDdR75FeSPbeYWz4xD1ymzH7w8FfwrU5DdZCu1uTWGmImOG
 j4AWSn619EDE21qmzcgaONCNfeSocKO0YS/cuf1Q+5xI8fCgYwH0h/sphp52tscPUi
 PnWHEeMuWABdalzQ5vqOTWhYs3IlohM/TiEf7UbyQynq1hdUSiOOHhklJ0Hu2P6ojE
 5Ts7H25PFGm5TlBD8V4i82oci6msni664SM2WBF6TJSObr+1KfQYwIcRZ8IIfE19A+
 FrufeWKL0jbMg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E97201C0BE8;
 Sun, 12 Jul 2026 07:16:20 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 27A0C3EB948;
 Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 335E6133D3; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Feifan Qian <bea1e@proton.me>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 13/75] hw/9pfs: add xattr FID limit to prevent memory
 exhaustion
Date: Sun, 12 Jul 2026 07:14:31 +0300
Message-ID: <20260712041539.108341-13-mjt@tls.msk.ru>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a limit on the number of simultaneously open xattr FIDs to prevent
host memory exhaustion attacks. Each xattr FID contains a buffer for the
xattr value, and without a limit, a malicious priviliged guest with
direct communication access to 9p server could create a huge number of
xattr FIDs until host memory is eventually exhausted.

Fix this by:

 - add xattr_fid_limit to struct FsContext for the max. amount
 - add xattr_fid_count to struct FsContext for the current amount
 - init xattr_fid_limit with 1024
 - init xattr_fid_count with 0
 - add function xattr_fid_count_inc() to increment the count
 - add function xattr_fid_count_decr() to decrement the count
 - call xattr_fid_count_inc() in Txattrcreate handler
 - call xattr_fid_count_inc() in Txattrwalk handler
 - call xattr_fid_count_decr() when a xattr FID is freed

Additionally:

 - reset the xattr FID counter in virtfs_reset()

When the limit is reached then xattr_fid_count_inc() returns -ENOSPC and
the request handler is aborted on its error path without turning the
FID into an xattr type and without allocating memory for the xattr.

The default value of 1024 was chosen, as (sane usage of) xattr requests
in the 9p protocol are usually very short-lived, and even machines with
128 cores with very high xattr activity should have plenty of head room
without ever hitting this limit.

Fixes: 10b468bdc5 ("virtio-9p: Implement TXATTRCREATE")
Fixes: CVE-2026-8348
Reported-by: Feifan Qian <bea1e@proton.me>
Link: https://lore.kernel.org/qemu-devel/eb3787869745d47234fb662600187bf773e1ef8a.1781361555.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit 693b296b176d1829b10855d9831bd2ad21b2cdcf)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index 29057d0d363..f3800018954 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -79,6 +79,11 @@ typedef struct ExtendedOps {
 
 #define V9FS_SEC_MASK               0x0000003C
 
+/*
+ * Limits the maximum amount of simultaneously open xattr FIDs to prevent
+ * host memory exhaustion (as each xattr FID contains a xattr value buffer).
+ */
+#define V9FS_MAX_XATTR_DEFAULT  1024
 
 typedef struct FileOperations FileOperations;
 typedef struct XattrOperations XattrOperations;
@@ -107,6 +112,10 @@ struct FsContext {
     void *private;
     mode_t fmode;
     mode_t dmode;
+    /* max. amount of simultaneously open xattr FIDs */
+    uint32_t xattr_fid_limit;
+    /* current amount of open xattr FIDs */
+    uint32_t xattr_fid_count;
 };
 
 struct V9fsPath {
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index a4f9544e13b..1255f4ff920 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -263,6 +263,31 @@ static size_t v9fs_string_size(V9fsString *str)
     return str->size;
 }
 
+static int xattr_fid_count_inc(V9fsPDU *pdu)
+{
+    V9fsState *s = pdu->s;
+
+    if (s->ctx.xattr_fid_limit > 0 &&
+        s->ctx.xattr_fid_count >= s->ctx.xattr_fid_limit) {
+        error_report_once("9pfs: xattr_fid_count limit exceeded "
+                          "(configurable by option 'max_xattr').");
+        return -ENOSPC;
+    }
+    s->ctx.xattr_fid_count++;
+    return 0;
+}
+
+static void xattr_fid_count_decr(V9fsPDU *pdu)
+{
+    V9fsState *s = pdu->s;
+
+    if (s->ctx.xattr_fid_count > 0) {
+        s->ctx.xattr_fid_count--;
+    } else {
+        error_report_once("9pfs: xattr_fid_count underflow detected");
+    }
+}
+
 /*
  * returns 0 if fid got re-opened, 1 if not, < 0 on error
  */
@@ -395,6 +420,7 @@ static int coroutine_fn free_fid(V9fsPDU *pdu, V9fsFidState *fidp)
         }
     } else if (fidp->fid_type == P9_FID_XATTR) {
         retval = v9fs_xattr_fid_clunk(pdu, fidp);
+        xattr_fid_count_decr(pdu);
     }
     v9fs_path_free(&fidp->path);
     g_free(fidp);
@@ -624,6 +650,14 @@ static void coroutine_fn virtfs_reset(V9fsPDU *pdu)
         fidp->clunked = true;
         put_fid(pdu, fidp);
     }
+
+    /*
+     * Explicitly reset the xattr FID counter.
+     *
+     * free_fid() already decrements the counter for each P9_FID_XATTR, so the
+     * counter should already be zero, hence this is just a defensive measure.
+     */
+    s->ctx.xattr_fid_count = 0;
 }
 
 #define P9_QID_TYPE_DIR         0x80
@@ -4027,6 +4061,14 @@ static void coroutine_fn v9fs_xattrwalk(void *opaque)
             clunk_fid(s, xattr_fidp->fid);
             goto out;
         }
+
+        /* Check xattr FID limit */
+        err = xattr_fid_count_inc(pdu);
+        if (err < 0) {
+            clunk_fid(s, xattr_fidp->fid);
+            goto out;
+        }
+
         /*
          * Read the xattr value
          */
@@ -4034,6 +4076,7 @@ static void coroutine_fn v9fs_xattrwalk(void *opaque)
         xattr_fidp->fid_type = P9_FID_XATTR;
         xattr_fidp->fs.xattr.xattrwalk_fid = true;
         xattr_fidp->fs.xattr.value = g_malloc0(size);
+
         if (size) {
             err = v9fs_co_llistxattr(pdu, &xattr_fidp->path,
                                      xattr_fidp->fs.xattr.value,
@@ -4060,6 +4103,14 @@ static void coroutine_fn v9fs_xattrwalk(void *opaque)
             clunk_fid(s, xattr_fidp->fid);
             goto out;
         }
+
+        /* Check xattr FID limit */
+        err = xattr_fid_count_inc(pdu);
+        if (err < 0) {
+            clunk_fid(s, xattr_fidp->fid);
+            goto out;
+        }
+
         /*
          * Read the xattr value
          */
@@ -4067,6 +4118,7 @@ static void coroutine_fn v9fs_xattrwalk(void *opaque)
         xattr_fidp->fid_type = P9_FID_XATTR;
         xattr_fidp->fs.xattr.xattrwalk_fid = true;
         xattr_fidp->fs.xattr.value = g_malloc0(size);
+
         if (size) {
             err = v9fs_co_lgetxattr(pdu, &xattr_fidp->path,
                                     &name, xattr_fidp->fs.xattr.value,
@@ -4158,6 +4210,12 @@ static void coroutine_fn v9fs_xattrcreate(void *opaque)
         goto out_put_fid;
     }
 
+    /* Check xattr FID limit */
+    err = xattr_fid_count_inc(pdu);
+    if (err < 0) {
+        goto out_put_fid;
+    }
+
     /* Make the file fid point to xattr */
     xattr_fidp = file_fidp;
     xattr_fidp->fid_type = P9_FID_XATTR;
@@ -4420,6 +4478,10 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
 
     s->reclaiming = false;
 
+    /* init xattr FID limit */
+    s->ctx.xattr_fid_limit = V9FS_MAX_XATTR_DEFAULT;
+    s->ctx.xattr_fid_count = 0;
+
     rc = 0;
 out:
     if (rc) {
-- 
2.47.3


