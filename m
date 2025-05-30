Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C90C5B543
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 15:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL1PO-00040m-Om; Fri, 30 May 2025 11:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1PD-0003Pe-8X; Fri, 30 May 2025 11:12:23 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1P8-0002Ht-R7; Fri, 30 May 2025 11:12:22 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 2758244B15;
 Fri, 30 May 2025 17:11:46 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v4 28/48] block: mark bdrv_set_backing_hd() as GRAPH_UNLOCKED
Date: Fri, 30 May 2025 17:11:05 +0200
Message-Id: <20250530151125.955508-29-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530151125.955508-1-f.ebner@proxmox.com>
References: <20250530151125.955508-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The function bdrv_set_backing_hd() calls bdrv_drain_all_begin(), which
must be called with the graph unlocked.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 include/block/block-global-state.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index 84a2a4ecd5..009b9ac946 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -100,8 +100,9 @@ bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp);
 BlockDriverState * coroutine_fn no_co_wrapper
 bdrv_co_open_blockdev_ref(BlockdevRef *ref, Error **errp);
 
-int bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
-                        Error **errp);
+int GRAPH_UNLOCKED
+bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
+                    Error **errp);
 int GRAPH_WRLOCK
 bdrv_set_backing_hd_drained(BlockDriverState *bs, BlockDriverState *backing_hd,
                             Error **errp);
-- 
2.39.5



