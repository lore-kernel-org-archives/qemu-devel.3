Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDD1C41513
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 11:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOFRC-00052a-Cr; Mon, 01 Jul 2024 07:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <w.bumiller@proxmox.com>)
 id 1sOFQm-0004od-Fo
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:42:50 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <w.bumiller@proxmox.com>)
 id 1sOFQf-0006hR-8N
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:42:47 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 0742B45902;
 Mon,  1 Jul 2024 13:42:31 +0200 (CEST)
From: Wolfgang Bumiller <w.bumiller@proxmox.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH 1/2] graph-lock: make sure reader_count access is atomic
Date: Mon,  1 Jul 2024 13:42:29 +0200
Message-Id: <20240701114230.193307-2-w.bumiller@proxmox.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701114230.193307-1-w.bumiller@proxmox.com>
References: <20240701114230.193307-1-w.bumiller@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106;
 envelope-from=w.bumiller@proxmox.com; helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

There's one case where `reader_count` is accessed non-atomically. This
was likely seen as being "guarded by a mutex" held in that block, but
other access to this does not actually depend on the mutex and already
uses atomics.

Additionally this replaces the pattern of atomic_set(atomic_read() +
1) with qatomic_inc() (and -1 with _dec)

Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
---
 block/graph-lock.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/block/graph-lock.c b/block/graph-lock.c
index c81162b147..32fb29b841 100644
--- a/block/graph-lock.c
+++ b/block/graph-lock.c
@@ -176,8 +176,7 @@ void coroutine_fn bdrv_graph_co_rdlock(void)
     bdrv_graph = qemu_get_current_aio_context()->bdrv_graph;
 
     for (;;) {
-        qatomic_set(&bdrv_graph->reader_count,
-                    bdrv_graph->reader_count + 1);
+        qatomic_inc(&bdrv_graph->reader_count);
         /* make sure writer sees reader_count before we check has_writer */
         smp_mb();
 
@@ -226,7 +225,7 @@ void coroutine_fn bdrv_graph_co_rdlock(void)
             }
 
             /* slow path where reader sleeps */
-            bdrv_graph->reader_count--;
+            qatomic_dec(&bdrv_graph->reader_count);
             aio_wait_kick();
             qemu_co_queue_wait(&reader_queue, &aio_context_list_lock);
         }
@@ -238,8 +237,7 @@ void coroutine_fn bdrv_graph_co_rdunlock(void)
     BdrvGraphRWlock *bdrv_graph;
     bdrv_graph = qemu_get_current_aio_context()->bdrv_graph;
 
-    qatomic_store_release(&bdrv_graph->reader_count,
-                          bdrv_graph->reader_count - 1);
+    qatomic_dec(&bdrv_graph->reader_count);
     /* make sure writer sees reader_count before we check has_writer */
     smp_mb();
 
-- 
2.39.2



