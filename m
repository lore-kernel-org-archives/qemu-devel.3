Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58ECECD3443
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKdev-0006mS-EP; Wed, 06 May 2026 10:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wKdeK-0006Rx-5n; Wed, 06 May 2026 10:54:57 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wKdeG-0005s9-Ua; Wed, 06 May 2026 10:54:55 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 8FC61444F3;
 Wed, 06 May 2026 16:54:39 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 qemu-stable@nongnu.org
Subject: [PATCH 1/3] block/export/fuse: use struct fuse_init_in
Date: Wed,  6 May 2026 16:49:56 +0200
Message-ID: <20260506145424.10249-2-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260506145424.10249-1-f.ebner@proxmox.com>
References: <20260506145424.10249-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1778079171148
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

The code is switched to use the current 'struct fuse_init_in' in
preparation to use the FUSE_DIRECT_IO_ALLOW_MMAP feature, which is
part of the flags2 member that got added in protocol version 5.36.

To not break compatibility with older kernels, the check for whether
the full header of an operation was read in co_read_from_fuse_fd()
needs to be adapted. In particular, for a FUSE_INIT operation, the
protocol version must be considered, because the length of the header
changed with protocol version 7.36. Always using the length of the
old, shorter struct was inaccurate, since for newer protocol versions
this might mean accepting a truncated read for FUSE_INIT.

Users of the init header that want to use parts of the extended
structure must check with the using_old_fuse_init_in() helper function
if they may do so.

Cc: qemu-stable@nongnu.org
Fixes: a94a1d7699 ("fuse: Manually process requests (without libfuse)")
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block/export/fuse.c | 56 +++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index a2a478d293..35218e3197 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -51,23 +51,16 @@
 #define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 1 * 1024 * 1024))
 #define FUSE_MAX_WRITE_BYTES (64 * 1024)
 
-/*
- * fuse_init_in structure before 7.36.  We don't need the flags2 field added
- * there, so we can work with the smaller older structure to stay compatible
- * with older kernels.
- */
-struct fuse_init_in_compat {
-    uint32_t major;
-    uint32_t minor;
-    uint32_t max_readahead;
-    uint32_t flags;
-};
-
 typedef struct FuseRequestInHeader {
     struct fuse_in_header common;
     /* All supported requests */
     union {
-        struct fuse_init_in_compat init;
+        /*
+         * When using_old_fuse_init_in() is true, then the smaller older struct
+         * is used by the kernel. The flags2 member and other new members must
+         * be treated as absent then.
+         */
+        struct fuse_init_in init;
         struct fuse_open_in open;
         struct fuse_setattr_in setattr;
         struct fuse_read_in read;
@@ -629,6 +622,16 @@ static int clone_fuse_fd(int fd, Error **errp)
     return new_fd;
 }
 
+/**
+ * Check whether the smaller older fuse_init_in structure from before protocol
+ * version 7.36 is used. The flags2 member and other new members must be treated
+ * as absent then.
+ */
+static bool using_old_fuse_init_in(const struct fuse_init_in *in)
+{
+    return in->major < 7 || (in->major == 7 && in->minor < 36);
+}
+
 /**
  * Try to read a single request from the FUSE FD.
  * Takes a FuseQueue pointer in `opaque`.
@@ -693,6 +696,31 @@ static void coroutine_fn co_read_from_fuse_fd(void *opaque)
         goto no_request;
     }
 
+    /*
+     * If the request is of type FUSE_INIT, need to check the version to
+     * actually determine the length of the fuse_init_in structure used by the
+     * kernel. In protocol version 7.36, the structure was extended.
+     */
+    if (in_hdr->common.opcode == FUSE_INIT) {
+        /* Length of the fuse_init_in structure before 7.36. */
+        size_t old_init_hdr_len = 16;
+
+        /*
+         * Expect at least the size of the smaller older structure to ensure the
+         * version can be checked.
+         */
+        if (unlikely(ret < sizeof(in_hdr->common) + old_init_hdr_len)) {
+            error_report("FUSE_INIT request truncated, read only %zi bytes",
+                         ret);
+            fuse_write_err(fuse_fd, &in_hdr->common, -EINVAL);
+            goto no_request;
+        }
+
+        if (using_old_fuse_init_in(&in_hdr->init)) {
+            op_hdr_len = old_init_hdr_len;
+        }
+    }
+
     if (unlikely(ret < sizeof(in_hdr->common) + op_hdr_len)) {
         error_report("FUSE request truncated, expected %zu bytes, read %zi "
                      "bytes",
@@ -826,7 +854,7 @@ static bool is_regular_file(const char *path, Error **errp)
  */
 static ssize_t coroutine_fn GRAPH_RDLOCK
 fuse_co_init(FuseExport *exp, struct fuse_init_out *out,
-             const struct fuse_init_in_compat *in)
+             const struct fuse_init_in *in)
 {
     const uint32_t supported_flags = FUSE_ASYNC_READ | FUSE_ASYNC_DIO;
 
-- 
2.47.3



