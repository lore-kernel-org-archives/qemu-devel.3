Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC87CD8CA8
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 15:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYPsf-0004qy-Nf; Sat, 13 Jun 2026 11:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <eb3787869745d47234fb662600187bf773e1ef8a@kylie.crudebyte.com>)
 id 1wYPse-0004qm-7H; Sat, 13 Jun 2026 11:02:40 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <eb3787869745d47234fb662600187bf773e1ef8a@kylie.crudebyte.com>)
 id 1wYPsc-0003xs-Ik; Sat, 13 Jun 2026 11:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=MfenymRhk48IxUTxbFS7vY9DrB63qmTI315WRZ5gsUk=; b=cITay
 iQi5St9/vzOKchwLTshYTEarm/O53HwqfDqg5jrCi3tB8vag4vRXLO3axOPlnkWzispmN7kpcZcJ2
 Aho5ols0FwLTYvL/JNEcw+QRkF4+z/CoPHeEpAAjHUmgF5dzxzqviBHfgRznKe2/b1kmRz7U+kOMT
 DkeT2xhC44U3btAwxxh8SswDqojdG0BXoTh4L1gj0hAOcWx4GR14+PNppMPrGKUlDcieJpjq0r30F
 ToAqGvavPYq/66vd+td9YjsQv9C/KFocIlrl31o3MSJYGPSHWvsH8npZB3Y22qxyFOVsE1lBeFpmR
 UKumJcWiaKAQ6adGks7Kse4oqqxI4gPgSu93ntVN2HFwxgrLFRVV7T9q2UWy9Lmu3b29uWHd8k6MU
 YeQFDv33tQNAcj9F6J6ETjZC9ckW0tsxr5jaRQ4Zyyat8NpE9w20yPCWgDi17R9EtKYp7DHfeiIOw
 m/X68avZu6x2i0Ahq4yHqNGBXqao/dM38L8DRW8YpliX5sOyFIL3xUoty++/0WksOaEy4Cu62H5zR
 HAWNuc9NA4X7gg23EFEQjx07H79fd/5AqZfvzOHdBzEPdXS37ZyCXW2O7q3z1EN6wtgJx6e4zb+rO
 3ex4gYbjHR5uIEFcde8iBdIfBFWX4/rS4tjMOKsqQjcRQMX2YB/updNoEYj4LI=;
Message-ID: <eb3787869745d47234fb662600187bf773e1ef8a.1781361555.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1781361555.git.qemu_oss@crudebyte.com>
References: <cover.1781361555.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sat, 13 Jun 2026 16:55:49 +0200
Subject: [PATCH v3 01/12] hw/9pfs: add xattr FID limit to prevent memory
 exhaustion
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=eb3787869745d47234fb662600187bf773e1ef8a@kylie.crudebyte.com;
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
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 fsdev/file-op-9p.h |  9 +++++++
 hw/9pfs/9p.c       | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index e8d0661c4b..454761d81d 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -81,6 +81,11 @@ typedef struct ExtendedOps {
 
 #define V9FS_SEC_MASK               0x0000003C
 
+/*
+ * Limits the maximum amount of simultaneously open xattr FIDs to prevent
+ * host memory exhaustion (as each xattr FID contains a xattr value buffer).
+ */
+#define V9FS_MAX_XATTR_DEFAULT  1024
 
 typedef struct FileOperations FileOperations;
 typedef struct XattrOperations XattrOperations;
@@ -109,6 +114,10 @@ struct FsContext {
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
index b4314d2549..053f0cc64b 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -265,6 +265,31 @@ static size_t v9fs_string_size(V9fsString *str)
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
@@ -397,6 +422,7 @@ static int coroutine_fn free_fid(V9fsPDU *pdu, V9fsFidState *fidp)
         }
     } else if (fidp->fid_type == P9_FID_XATTR) {
         retval = v9fs_xattr_fid_clunk(pdu, fidp);
+        xattr_fid_count_decr(pdu);
     }
     v9fs_path_free(&fidp->path);
     g_free(fidp);
@@ -634,6 +660,14 @@ static void coroutine_fn virtfs_reset(V9fsPDU *pdu)
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
@@ -4006,6 +4040,14 @@ static void coroutine_fn v9fs_xattrwalk(void *opaque)
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
@@ -4013,6 +4055,7 @@ static void coroutine_fn v9fs_xattrwalk(void *opaque)
         xattr_fidp->fid_type = P9_FID_XATTR;
         xattr_fidp->fs.xattr.xattrwalk_fid = true;
         xattr_fidp->fs.xattr.value = g_malloc0(size);
+
         if (size) {
             err = v9fs_co_llistxattr(pdu, &xattr_fidp->path,
                                      xattr_fidp->fs.xattr.value,
@@ -4039,6 +4082,14 @@ static void coroutine_fn v9fs_xattrwalk(void *opaque)
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
@@ -4046,6 +4097,7 @@ static void coroutine_fn v9fs_xattrwalk(void *opaque)
         xattr_fidp->fid_type = P9_FID_XATTR;
         xattr_fidp->fs.xattr.xattrwalk_fid = true;
         xattr_fidp->fs.xattr.value = g_malloc0(size);
+
         if (size) {
             err = v9fs_co_lgetxattr(pdu, &xattr_fidp->path,
                                     &name, xattr_fidp->fs.xattr.value,
@@ -4147,6 +4199,12 @@ static void coroutine_fn v9fs_xattrcreate(void *opaque)
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
@@ -4408,6 +4466,10 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
 
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


