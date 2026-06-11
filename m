Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC37CD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXcZ1-0001hF-JS; Thu, 11 Jun 2026 06:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wXcYy-0001gP-W9; Thu, 11 Jun 2026 06:23:05 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wXcYw-0002RK-MK; Thu, 11 Jun 2026 06:23:04 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B491E4314D;
 Thu, 11 Jun 2026 12:22:52 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	hreitz@redhat.com,
	kwolf@redhat.com
Subject: [PATCH 2/3] blockdev: mirror: do not require a root block node
Date: Thu, 11 Jun 2026 12:22:27 +0200
Message-ID: <20260611102247.622275-3-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260611102247.622275-1-f.ebner@proxmox.com>
References: <20260611102247.622275-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1781173323975
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

The mirror block job currently only operates on a root block node. It
might be desired to use a throttle node as the root node for limiting
the guest IO, without also limiting mirror operations.

There is no obvious reason why mirror should only be able to operate
on a root block node.

When there is no explicit @replaces argument, implicit filters on top
are skipped. Allowing mirror to operate on non-root nodes does not
change that fact and keeps the behavior consistent with the
documentation for @replaces.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 blockdev.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 6e86c6262f..0f70973326 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2987,13 +2987,19 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
     bool target_is_zero;
     int ret;
 
-    bs = qmp_get_root_bs(arg->device, errp);
+    bdrv_graph_rdlock_main_loop();
+    bs = bdrv_lookup_bs(arg->device, arg->device, errp);
     if (!bs) {
+        bdrv_graph_rdunlock_main_loop();
+        return;
+    }
+    if (!bdrv_is_inserted(bs)) {
+        error_setg(errp, "Device has no medium");
+        bdrv_graph_rdunlock_main_loop();
         return;
     }
 
     /* Early check to avoid creating target */
-    bdrv_graph_rdlock_main_loop();
     if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_MIRROR_SOURCE, errp)) {
         bdrv_graph_rdunlock_main_loop();
         return;
@@ -3150,10 +3156,18 @@ void qmp_blockdev_mirror(const char *job_id,
     BlockMirrorBackingMode backing_mode = MIRROR_LEAVE_BACKING_CHAIN;
     int ret;
 
-    bs = qmp_get_root_bs(device, errp);
+    bdrv_graph_rdlock_main_loop();
+    bs = bdrv_lookup_bs(device, device, errp);
     if (!bs) {
+        bdrv_graph_rdunlock_main_loop();
         return;
     }
+    if (!bdrv_is_inserted(bs)) {
+        error_setg(errp, "Device has no medium");
+        bdrv_graph_rdunlock_main_loop();
+        return;
+    }
+    bdrv_graph_rdunlock_main_loop();
 
     target_bs = bdrv_lookup_bs(target, target, errp);
     if (!target_bs) {
-- 
2.47.3



