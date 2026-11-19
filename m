Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63734606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ovhcloud.com header.i=@ovhcloud.com header.a=rsa-sha256 header.s=mailout header.b=HHoi4bbu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU3Q5-0004T8-Gv; Thu, 19 Nov 2026 09:47:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xU3Pv-0004Qz-AU; Thu, 19 Nov 2026 09:47:17 -0500
Received: from 2.mo508.mail-out.ovh.net ([5.135.90.177])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xU3Pp-0006D4-K2; Thu, 19 Nov 2026 09:47:13 -0500
Received: from DAGFR11EX3.OVH.local (unknown [10.110.58.62])
 by mo508.mail-out.ovh.net (Postfix) with ESMTPS id 4jVhBR3vVRz7tDf;
 Thu, 19 Nov 2026 14:46:55 +0000 (UTC)
Received: from ovhcloud.com (109.190.254.2) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 15:46:54 +0100
From: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, <eblake@redhat.com>, <vsementsov@yandex-team.ru>, 
 <kwolf@redhat.com>, <hreitz@redhat.com>, <stefanha@redhat.com>,
 <fam@euphon.net>, Guillaume Vincke <guillaume.vincke@ovhcloud.com>
Subject: [PATCH 2/5] block: Refresh the connection before block_resize
Date: Thu, 19 Nov 2026 15:46:29 +0100
Message-ID: <20261119144632.232457-3-guillaume.vincke@ovhcloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119144632.232457-1-guillaume.vincke@ovhcloud.com>
References: <20261119144632.232457-1-guillaume.vincke@ovhcloud.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CAS2.OVH.local (172.16.1.2) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 855402457260638685
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTGOS8EGrX643+ovyXsH+QFTmB5aOgoJ08jxUdSO/s6XgvT7M/VuQQ/Ds/8vMAVUddgP1bWDSw41OV9jyN0q52MhAPgS0yoC2ODGuYv1BBob7jhQ7dDNOfGz7zhBa7QJumewrS892C6gqnCQx9qVlOOB+KxYueih+lDUybnRAI53OitkcpkFTDvwmUxZnALuqa95QZrlzfljSUx8on3qABkAFuxLMjxQP7sm7omnCeHybC2x1J2w07QRuPY6b/1YmXdD271GM23xOVXa9HL1eexNQ/d+NppEKUVhgxm4GKbkD1Pt3B/0ooUNcyKYtby1iye42fekcpfDjPqPXYgcnp0Ldss2GKTgWCKuexDgcgQKIee2fxVRHp6S7qUfwBwiQRly/D/qh1frVKd/5Jg6O3Rxnq9bOg3LugFeB5DWUFufWXb5ZgJgxd/RzfuCqhtU1aFhvKDHTlJ+BTnsCbhtIwkWbSOhgYbTd8Jmrfu7fe5d0R233HIFRF7D6HYwAt8MCNDlIIZMSPkXC3eN6c8EeZRtKzHRwmgHeEYcmr3AGznj0HJi0JqJHeqU/62P1cFgmbIARf7kuPPjt1N1HUhO7eD3D8Z3DSqbSIi0XeNxjUZCk7ECoVuXsP2A0VGcp2eG6vUC5jqYPmurlx97j1sYInsgoowAdtRVsOt+nSiAQiQoPQ
DKIM-Signature: a=rsa-sha256; bh=d/DytXrpjrrOlaVJ3b69UCyHaZFzBJ41QwLBqIEFELE=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1795099615; v=1; 
 b=HHoi4bbuZaef68dr0/TMrRoIUdLyDDVkwoXLkKUTr7RM7DsZL1z8F6sUPfgJJ0PA/Xe1TuqZ
 Bl1p7BV4X/Z1hgTlRUoTSpV/Jc3XegautqXzbEXgAREMDI+122wKGeQw4UiC3odzbpDcOLzV1+T
 8V/m6Q7x2gvJRMP9VFNNqGIA=
Received-SPF: pass client-ip=5.135.90.177;
 envelope-from=guillaume.vincke@ovhcloud.com; helo=2.mo508.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: guillaume.vincke@ovhcloud.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a network based device is not connected, there is no way for the
backend to notify a change. For instance, the NBD client relies on lazy
reconnection. Therefore, if an NBD backend changes size, there is
currently no way to update the device size until at least one I/O
operation is sent.

This patch adds the bdrv_co_refresh_connection callback to the
BlockDriver structure so a reconnection can be forced. Considering
nbd_co_truncate() does not perform any I/O, it also modifies the QMP
block_resize implementation to execute the callback, if defined, before
truncating.

No functional change.

Signed-off-by: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
---
 block/block-backend.c             | 12 ++++++++++++
 block/io.c                        | 24 ++++++++++++++++++++++++
 blockdev.c                        |  9 +++++++++
 include/block/block-io.h          |  8 ++++++++
 include/block/block_int-common.h  |  3 +++
 include/system/block-backend-io.h |  2 ++
 6 files changed, 58 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 656c0aed67..b133bb8292 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2600,6 +2600,18 @@ int coroutine_fn blk_co_truncate(BlockBackend *blk, int64_t offset, bool exact,
     return bdrv_co_truncate(blk->root, offset, exact, prealloc, flags, errp);
 }
 
+int coroutine_fn blk_co_refresh_connection(BlockBackend *blk, Error **errp)
+{
+    IO_OR_GS_CODE();
+    GRAPH_RDLOCK_GUARD();
+    if (!blk_co_is_available(blk)) {
+        error_setg(errp, "No medium inserted");
+        return -ENOMEDIUM;
+    }
+
+    return bdrv_co_refresh_connection(blk->root, errp);
+}
+
 int blk_save_vmstate(BlockBackend *blk, const uint8_t *buf,
                      int64_t pos, int size)
 {
diff --git a/block/io.c b/block/io.c
index e4568d4d24..3c5c05b9a0 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3274,6 +3274,30 @@ out:
     return ret;
 }
 
+int coroutine_fn bdrv_co_refresh_connection(BdrvChild *child, Error **errp)
+{
+    BlockDriverState *bs = child->bs;
+    BlockDriver *drv = bs->drv;
+    int ret;
+    IO_CODE();
+    assert_bdrv_graph_readable();
+
+    if (!drv) {
+        error_setg(errp, "No medium inserted");
+        return -ENOMEDIUM;
+    }
+
+    if (!drv->bdrv_co_refresh_connection) {
+        return 0;
+    }
+
+    bdrv_inc_in_flight(bs);
+    ret = drv->bdrv_co_refresh_connection(bs, errp);
+    bdrv_dec_in_flight(bs);
+
+    return ret;
+}
+
 int coroutine_fn bdrv_co_ioctl(BlockDriverState *bs, int req, void *buf)
 {
     BlockDriver *drv = bs->drv;
diff --git a/blockdev.c b/blockdev.c
index 0f70973326..5d6d618bce 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2314,6 +2314,7 @@ void coroutine_fn qmp_block_resize(const char *device, const char *node_name,
     BlockBackend *blk;
     BlockDriverState *bs;
     AioContext *old_ctx;
+    int ret;
 
     bs = bdrv_lookup_bs(device, node_name, &local_err);
     if (local_err) {
@@ -2338,6 +2339,14 @@ void coroutine_fn qmp_block_resize(const char *device, const char *node_name,
         return;
     }
 
+    old_ctx = bdrv_co_enter(bs);
+    ret = blk_co_refresh_connection(blk, errp);
+    bdrv_co_leave(bs, old_ctx);
+    if (ret < 0) {
+        blk_co_unref(blk);
+        return;
+    }
+
     bdrv_drained_begin(bs);
 
     old_ctx = bdrv_co_enter(bs);
diff --git a/include/block/block-io.h b/include/block/block-io.h
index f671476f08..5a7328fed5 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -114,6 +114,14 @@ int coroutine_fn GRAPH_RDLOCK bdrv_co_flush(BlockDriverState *bs);
 int coroutine_fn GRAPH_RDLOCK bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
                                                int64_t bytes);
 
+/*
+ * Ensure the connection is ready to process requests by re-establishing it if
+ * closed.
+ * Returns 0 when the driver does not declare the callback.
+ */
+int coroutine_fn GRAPH_RDLOCK bdrv_co_refresh_connection(BdrvChild *child,
+                                                         Error **errp);
+
 /* Report zone information of zone block device. */
 int coroutine_fn GRAPH_RDLOCK bdrv_co_zone_report(BlockDriverState *bs,
                                                   int64_t offset,
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 0c7746a544..a0411e2947 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -591,6 +591,9 @@ struct BlockDriver {
     int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_pdiscard)(
         BlockDriverState *bs, int64_t offset, int64_t bytes);
 
+    int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_refresh_connection)(
+        BlockDriverState *bs, Error **errp);
+
     /*
      * Map [offset, offset + nbytes) range onto a child of @bs to copy from,
      * and invoke bdrv_co_copy_range_from(child, ...), or invoke
diff --git a/include/system/block-backend-io.h b/include/system/block-backend-io.h
index 78d410b8df..811264622c 100644
--- a/include/system/block-backend-io.h
+++ b/include/system/block-backend-io.h
@@ -238,4 +238,6 @@ int coroutine_fn blk_co_truncate(BlockBackend *blk, int64_t offset, bool exact,
                                  PreallocMode prealloc, BdrvRequestFlags flags,
                                  Error **errp);
 
+int coroutine_fn blk_co_refresh_connection(BlockBackend *blk, Error **errp);
+
 #endif /* BLOCK_BACKEND_IO_H */
-- 
2.43.0


