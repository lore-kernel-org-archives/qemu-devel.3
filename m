Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0A5C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 09:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpOCR-0000UP-9J; Tue, 04 Mar 2025 04:04:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1tpOCO-0000U5-Ft
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 04:04:24 -0500
Received: from air.basealt.ru ([193.43.8.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1tpOCM-0001dW-1V
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 04:04:24 -0500
Received: from boringlust.malta.altlinux.ru (obninsk.basealt.ru
 [217.15.195.17]) (Authenticated sender: rastyoginds)
 by air.basealt.ru (Postfix) with ESMTPSA id 452AC2336E;
 Tue,  4 Mar 2025 12:04:18 +0300 (MSK)
From: gerben@altlinux.org
To: qemu-devel@nongnu.org,
	kwolf@redhat.com,
	hreitz@redhat.com
Cc: sdl.qemu@linuxtesting.org
Subject: [PATCH] block/vmdk: prevent double-free in extent memory management
Date: Tue,  4 Mar 2025 12:04:02 +0300
Message-ID: <20250304090415.39393-1-gerben@altlinux.org>
X-Mailer: git-send-email 2.42.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.43.8.18; envelope-from=gerben@altlinux.org;
 helo=air.basealt.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Denis Rastyogin <gerben@altlinux.org>

This error was discovered by fuzzing qemu-img.

A double-free issue in the VMDK driver occurs when handling snapshots.
The memory allocated for extent structures is freed twice: first in
vmdk_close (block/vmdk.c) and then in vmdk_add_extent (block/vmdk.c).

The fix ensures the s->extents pointer is set to NULL after freeing,
preventing double-free.

Closes: https://gitlab.com/qemu-project/qemu/-/issues/2853
Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
---
 block/vmdk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/vmdk.c b/block/vmdk.c
index 2adec49912..d6baa54602 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -285,6 +285,7 @@ static void vmdk_free_extents(BlockDriverState *bs)
     bdrv_graph_wrunlock();
 
     g_free(s->extents);
+    s->extents = NULL;
 }
 
 static void vmdk_free_last_extent(BlockDriverState *bs)
-- 
2.42.2


