Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA535C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 09:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnbXb-0003T3-Ui; Fri, 22 Mar 2024 05:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rnbXZ-0003RS-T1; Fri, 22 Mar 2024 05:50:21 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rnbXW-00020j-Vy; Fri, 22 Mar 2024 05:50:21 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 9C99241059;
 Fri, 22 Mar 2024 10:50:14 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, fam@euphon.net, stefanha@redhat.com,
 t.lamprecht@proxmox.com, w.bumiller@proxmox.com
Subject: [PATCH v3 3/4] block-backend: fix edge case in bdrv_next_cleanup()
 where BDS associated to BB changes
Date: Fri, 22 Mar 2024 10:50:08 +0100
Message-Id: <20240322095009.346989-4-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240322095009.346989-1-f.ebner@proxmox.com>
References: <20240322095009.346989-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Same rationale as for commit "block-backend: fix edge case in
bdrv_next() where BDS associated to BB changes". The block graph might
change between the bdrv_next() call and the bdrv_next_cleanup() call,
so it could be that the associated BDS is not the same that was
referenced previously anymore. Instead, rely on bdrv_next() to set
it->bs to the BDS it referenced and unreference that one in any case.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

New in v3.

 block/block-backend.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 28af1eb17a..db6f9b92a3 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -663,13 +663,10 @@ void bdrv_next_cleanup(BdrvNextIterator *it)
     /* Must be called from the main loop */
     assert(qemu_get_current_aio_context() == qemu_get_aio_context());
 
-    if (it->phase == BDRV_NEXT_BACKEND_ROOTS) {
-        if (it->blk) {
-            bdrv_unref(blk_bs(it->blk));
-            blk_unref(it->blk);
-        }
-    } else {
-        bdrv_unref(it->bs);
+    bdrv_unref(it->bs);
+
+    if (it->phase == BDRV_NEXT_BACKEND_ROOTS && it->blk) {
+        blk_unref(it->blk);
     }
 
     bdrv_next_reset(it);
-- 
2.39.2



