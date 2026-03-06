Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6036CF33A92
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 14:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWAy-00079H-IG; Fri, 06 Mar 2026 09:29:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pl@dlhnet.de>)
 id 1vyWAp-00078J-5a; Fri, 06 Mar 2026 09:29:03 -0500
Received: from mailcow.dlhnet.de ([2a01:b1c0::44ca:22ff:fe9b:798c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pl@dlhnet.de>)
 id 1vyWAi-0004pc-9f; Fri, 06 Mar 2026 09:29:02 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AFB4946AEA2; Fri,  6 Mar 2026 15:28:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dlhnet.de; s=dkim;
 t=1772807332; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=YVduhRvlfmWCULF5ggKnw9zwhlMXrPGN+aN1A3qn2Dk=;
 b=aCcq9EouDTbhnVKRTKNtDSW8d3fCeIWgwETmFNgsXKSMM7XZPvy2eBlfUBZPqnlu547a7g
 4zGwXcKb38wW5+g+iOzrfKsPJlXVq3qF3244sZDl0tNUxIlF2dMp90UDy3HCRIjqhDctjI
 WyTGwgavKr69ucus+khlYuU6MTYi2+6D0+1v0f5rP5lG8xwemj2aGfhu7PnH9sO4GT70UQ
 GDO7Rx1jJxZjC2l0E2eO0CpIGzuVH619bNG+ESAdAX7ixpJ1mlEVAaN9O9wzBTJ/Kf6rig
 EFX5G0BHJ9fsl66Ptm5o4CgW+1pckrlXWAsP3ad+/hcNbdmboNzrzCocpAq7ZQ==
Received: by pkgbuilder.localdomain (Postfix, from userid 0)
 id 90747402DC; Fri, 06 Mar 2026 14:28:51 +0000 (UTC)
From: Peter Lieven <pl@dlhnet.de>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pbonzini@redhat.com,
 hreitz@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 philmd@linaro.org, armbru@redhat.com, jsnow@redhat.com, thuth@redhat.com,
 Peter Lieven <pl@dlhnet.de>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: [PATCH] block/nfs: add support for libnfs v6
Date: Fri,  6 Mar 2026 14:28:40 +0000
Message-ID: <20260306142840.72923-1-pl@dlhnet.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Received-SPF: pass client-ip=2a01:b1c0::44ca:22ff:fe9b:798c;
 envelope-from=pl@dlhnet.de; helo=mailcow.dlhnet.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

libnfs v6 added a new api structure for read and write requests.

This effectively also adds zero copy read support for cases where
the qiov coming from the block layer has only one vector.

The .brdv_refresh_limits implementation is needed because libnfs v6
silently dropped support for splitting large read/write request into
chunks.

Signed-off-by: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Signed-off-by: Peter Lieven <pl@dlhnet.de>
---
 block/nfs.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 meson.build |  2 +-
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index b78f4f86e8..53e267fa75 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -69,7 +69,9 @@ typedef struct NFSClient {
 typedef struct NFSRPC {
     BlockDriverState *bs;
     int ret;
+#ifndef LIBNFS_API_V2
     QEMUIOVector *iov;
+#endif
     struct stat *st;
     Coroutine *co;
     NFSClient *client;
@@ -237,6 +239,7 @@ nfs_co_generic_cb(int ret, struct nfs_context *nfs, void *data,
     NFSRPC *task = private_data;
     task->ret = ret;
     assert(!task->st);
+#ifndef LIBNFS_API_V2
     if (task->ret > 0 && task->iov) {
         if (task->ret <= task->iov->size) {
             qemu_iovec_from_buf(task->iov, 0, data, task->ret);
@@ -244,6 +247,7 @@ nfs_co_generic_cb(int ret, struct nfs_context *nfs, void *data,
             task->ret = -EIO;
         }
     }
+#endif
     if (task->ret < 0) {
         error_report("NFS Error: %s", nfs_get_error(nfs));
     }
@@ -266,13 +270,36 @@ static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t offset,
 {
     NFSClient *client = bs->opaque;
     NFSRPC task;
+    char *buf = NULL;
+    bool my_buffer = false;
 
     nfs_co_init_task(bs, &task);
-    task.iov = iov;
+
+#ifdef LIBNFS_API_V2
+    if (iov->niov != 1) {
+        buf = g_try_malloc(bytes);
+        if (bytes && buf == NULL) {
+            return -ENOMEM;
+        }
+        my_buffer = true;
+    } else {
+        buf = iov->iov[0].iov_base;
+    }
+#endif
 
     WITH_QEMU_LOCK_GUARD(&client->mutex) {
+#ifdef LIBNFS_API_V2
+        if (nfs_pread_async(client->context, client->fh,
+                            buf, bytes, offset,
+                            nfs_co_generic_cb, &task) != 0) {
+#else
+        task.iov = iov;
         if (nfs_pread_async(client->context, client->fh,
                             offset, bytes, nfs_co_generic_cb, &task) != 0) {
+#endif
+            if (my_buffer) {
+                g_free(buf);
+            }
             return -ENOMEM;
         }
 
@@ -280,6 +307,13 @@ static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t offset,
     }
     qemu_coroutine_yield();
 
+    if (my_buffer) {
+        if (task.ret > 0) {
+            qemu_iovec_from_buf(iov, 0, buf, task.ret);
+        }
+        g_free(buf);
+    }
+
     if (task.ret < 0) {
         return task.ret;
     }
@@ -315,9 +349,15 @@ static int coroutine_fn nfs_co_pwritev(BlockDriverState *bs, int64_t offset,
     }
 
     WITH_QEMU_LOCK_GUARD(&client->mutex) {
+#ifdef LIBNFS_API_V2
+        if (nfs_pwrite_async(client->context, client->fh,
+                             buf, bytes, offset,
+                             nfs_co_generic_cb, &task) != 0) {
+#else
         if (nfs_pwrite_async(client->context, client->fh,
                              offset, bytes, buf,
                              nfs_co_generic_cb, &task) != 0) {
+#endif
             if (my_buffer) {
                 g_free(buf);
             }
@@ -856,6 +896,13 @@ static void coroutine_fn nfs_co_invalidate_cache(BlockDriverState *bs,
 }
 #endif
 
+static void nfs_refresh_limits(BlockDriverState *bs, Error **errp)
+{
+    NFSClient *client = bs->opaque;
+    bs->bl.max_transfer = MIN((uint32_t)nfs_get_readmax(client->context),
+                              (uint32_t)nfs_get_writemax(client->context));
+}
+
 static const char *nfs_strong_runtime_opts[] = {
     "path",
     "user",
@@ -893,6 +940,7 @@ static BlockDriver bdrv_nfs = {
     .bdrv_detach_aio_context        = nfs_detach_aio_context,
     .bdrv_attach_aio_context        = nfs_attach_aio_context,
     .bdrv_refresh_filename          = nfs_refresh_filename,
+    .bdrv_refresh_limits            = nfs_refresh_limits,
     .bdrv_dirname                   = nfs_dirname,
 
     .strong_runtime_opts            = nfs_strong_runtime_opts,
diff --git a/meson.build b/meson.build
index df841e12e2..3bb78c0788 100644
--- a/meson.build
+++ b/meson.build
@@ -1156,7 +1156,7 @@ endif
 
 libnfs = not_found
 if not get_option('libnfs').auto() or have_block
-  libnfs = dependency('libnfs', version: ['>=1.9.3', '<6.0.0'],
+  libnfs = dependency('libnfs', version: '>=1.9.3',
                       required: get_option('libnfs'),
                       method: 'pkg-config')
 endif
-- 
2.47.3


