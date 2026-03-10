Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FCBFD4F04
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 16:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzvX-0003mv-Rh; Tue, 10 Mar 2026 12:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzvU-0003Yq-TC
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:27:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzvS-0000zk-3l
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773160036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dXevCX+TKSamsDo/RaI3tSNiKHhigt69wLKY0jDj1bk=;
 b=VGSrhszawmxgOo0Ux9It20M2YTtCAdBVgQnhdc3TBaS8eGTtlwRuVI6DUIvrzJ0PGIjo1F
 5UVLxil/xlop/P3EGT/r5WZjErHXLzmKBj/3YjHA1tlURIfB4v0L7M7lojpekoflxzLo5T
 6JzisEo7oFdS+oFI1/cunkoE9bDeHTo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-betGy7E2OeqhPiu1Fb74bg-1; Tue,
 10 Mar 2026 12:27:14 -0400
X-MC-Unique: betGy7E2OeqhPiu1Fb74bg-1
X-Mimecast-MFC-AGG-ID: betGy7E2OeqhPiu1Fb74bg_1773160033
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09BE4180034E; Tue, 10 Mar 2026 16:27:13 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.224.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D8A9F19560A6; Tue, 10 Mar 2026 16:27:11 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 26/28] block/nfs: add support for libnfs v6
Date: Tue, 10 Mar 2026 17:26:20 +0100
Message-ID: <20260310162622.333137-27-kwolf@redhat.com>
In-Reply-To: <20260310162622.333137-1-kwolf@redhat.com>
References: <20260310162622.333137-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Peter Lieven <pl@dlhnet.de>

libnfs v6 added a new api structure for read and write requests.

This effectively also adds zero copy read support for cases where
the qiov coming from the block layer has only one vector.

The .brdv_refresh_limits implementation is needed because libnfs v6
silently dropped support for splitting large read/write request into
chunks.

Signed-off-by: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Signed-off-by: Peter Lieven <pl@dlhnet.de>
Message-ID: <20260306142840.72923-1-pl@dlhnet.de>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/nfs.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 meson.build |  2 +-
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index b78f4f86e85..53e267fa755 100644
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
index f45885f05a1..bb0d1d993a5 100644
--- a/meson.build
+++ b/meson.build
@@ -1157,7 +1157,7 @@ endif
 
 libnfs = not_found
 if not get_option('libnfs').auto() or have_block
-  libnfs = dependency('libnfs', version: ['>=1.9.3', '<6.0.0'],
+  libnfs = dependency('libnfs', version: '>=1.9.3',
                       required: get_option('libnfs'),
                       method: 'pkg-config')
 endif
-- 
2.53.0


