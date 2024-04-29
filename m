Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AA7C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 14:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1RrV-0001Az-4I; Mon, 29 Apr 2024 10:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s1RrG-000179-OR; Mon, 29 Apr 2024 10:19:55 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s1RrC-0000d2-3e; Mon, 29 Apr 2024 10:19:53 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 0D51848060;
 Mon, 29 Apr 2024 16:19:38 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com,
 f.weber@proxmox.com
Subject: [PATCH] block/copy-before-write: use uint64_t for timeout in
 nanoseconds
Date: Mon, 29 Apr 2024 16:19:34 +0200
Message-Id: <20240429141934.442154-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
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

rather than the uint32_t for which the maximum is slightly more than 4
seconds and larger values would overflow. The QAPI interface allows
specifying the number of seconds, so only values 0 to 4 are safe right
now, other values lead to a much lower timeout than a user expects.

The block_copy() call where this is used already takes a uint64_t for
the timeout, so no change required there.

Fixes: 6db7fd1ca9 ("block/copy-before-write: implement cbw-timeout option")
Reported-by: Friedrich Weber <f.weber@proxmox.com>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block/copy-before-write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index 8aba27a71d..026fa9840f 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -43,7 +43,7 @@ typedef struct BDRVCopyBeforeWriteState {
     BlockCopyState *bcs;
     BdrvChild *target;
     OnCbwError on_cbw_error;
-    uint32_t cbw_timeout_ns;
+    uint64_t cbw_timeout_ns;
 
     /*
      * @lock: protects access to @access_bitmap, @done_bitmap and
-- 
2.39.2



