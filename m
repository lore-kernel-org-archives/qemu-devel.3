Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C98CAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 11:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0ers-000424-R8; Mon, 22 Sep 2025 07:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luzhipeng@cestc.cn>)
 id 1v0erp-00041a-H9; Mon, 22 Sep 2025 07:38:01 -0400
Received: from smtp-pop-umt-1.cecloud.com ([1.203.97.246]
 helo=smtp.cecloud.com) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luzhipeng@cestc.cn>)
 id 1v0erk-0002zO-Rm; Mon, 22 Sep 2025 07:38:00 -0400
Received: from localhost (localhost [127.0.0.1])
 by smtp.cecloud.com (Postfix) with ESMTP id CB7827C0113;
 Mon, 22 Sep 2025 19:37:43 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [111.48.69.245])
 by smtp.cecloud.com (postfix) whith ESMTP id
 P2727722T281471788773744S1758541042646696_; 
 Mon, 22 Sep 2025 19:37:42 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: luzhipeng@cestc.cn
X-SENDER: luzhipeng@cestc.cn
X-LOGIN-NAME: luzhipeng@cestc.cn
X-FST-TO: qemu-block@nongnu.org
X-RCPT-COUNT: 6
X-LOCAL-RCPT-COUNT: 1
X-MUTI-DOMAIN-COUNT: 0
X-SENDER-IP: 111.48.69.245
X-ATTACHMENT-NUM: 0
X-UNIQUE-TAG: <a4144ca1cbe28597e869cf5c640d6576>
X-System-Flag: 0
From: luzhipeng <luzhipeng@cestc.cn>
To: qemu-block@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-devel@nongnu.org,
 luzhipeng <luzhipeng@cestc.cn>
Subject: [PATCH] mirror: Optimize mirroring for zero blocks in
 mirror_read_complete
Date: Mon, 22 Sep 2025 19:36:54 +0800
Message-ID: <20250922113657.391-1-luzhipeng@cestc.cn>
X-Mailer: git-send-email 2.45.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=1.203.97.246; envelope-from=luzhipeng@cestc.cn;
 helo=smtp.cecloud.com
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

When mirroring data blocks, detect if the read data consists entirely of
zeros. If so, use blk_co_pwrite_zeroes() instead of regular write to
improve performance.

Signed-off-by: luzhipeng <luzhipeng@cestc.cn>
---
 block/mirror.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/block/mirror.c b/block/mirror.c
index b344182c74..535112f65d 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -269,6 +269,33 @@ static void coroutine_fn mirror_read_complete(MirrorOp *op, int ret)
         return;
     }
 
+    /* Check if the read data is all zeros */
+    bool is_zero = true;
+    for (int i = 0; i < op->qiov.niov; i++) {
+        if (!buffer_is_zero(op->qiov.iov[i].iov_base,
+                           op->qiov.iov[i].iov_len)) {
+            is_zero = false;
+            break;
+        }
+    }
+
+    /* Write to target - optimized path for zero blocks */
+    if (is_zero) {
+        /*
+         * Use zero-writing interface which may:
+         * 1. Avoid actual data transfer
+         * 2. Enable storage-level optimizations
+         * 3. Potentially unmap blocks (if supported)
+         */
+        ret = blk_co_pwrite_zeroes(s->target, op->offset,
+                                 op->qiov.size,
+                                 BDRV_REQ_MAY_UNMAP);
+    } else {
+        /* Normal data write path */
+        ret = blk_co_pwritev(s->target, op->offset,
+                           op->qiov.size, &op->qiov, 0);
+    }
+
     ret = blk_co_pwritev(s->target, op->offset, op->qiov.size, &op->qiov, 0);
     mirror_write_complete(op, ret);
 }
-- 
2.45.1.windows.1




