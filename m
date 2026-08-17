Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D771C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvuwg-00007U-15; Mon, 17 Aug 2026 06:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1wvuwd-0008Ui-Jv
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 06:51:55 -0400
Received: from va-1-113.ptr.blmpb.com ([209.127.230.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1wvuwb-0005Ft-Vx
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 06:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1786963910; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Bns1KSbePA20dhJKI9rmE1kfQHZ8i2phCZvZRWjPPAw=;
 b=oZU64RfvlvTL7NjnVjJRwtLOPvQ6PgXTY46goFERVtY5oHy6nH7IYuG3f/YKK0HFgFNw0E
 Tm4TTEfnRbbcR5upIqAhTSYnDQbgZ+U/2I/YRy5SrQ/sSaNWzlsiQEI7DoreXC3fOL36Kt
 Pmuii4EvtwV/rl8I9Pi+IgyhJ56W1Gv5PxG/RNBuMiTG/wns7sfqHlxmP9eaLhGstnfIXg
 OYzALfGIZ4vNrvH8hRWpq6WsLZh09eO6zDjFDS0pvjBKpuZ8VppQXNyoER5d0NlDsgiQ4H
 7uKodqXG26f3j9/Nyzsus4XFyCM5vCClxIzTnGA6+cFqCIf3VJ2xOrmg3+hFEA==
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a82e7c4+b33d2d+nongnu.org+yanfei.xu@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <qemu-devel@nongnu.org>
Date: Mon, 17 Aug 2026 18:51:17 +0800
In-Reply-To: <20260817105117.3072040-1-yanfei.xu@bytedance.com>
Subject: [PATCH 3/3] migration/rdma: Retry control sends on full queue
Message-Id: <20260817105117.3072040-4-yanfei.xu@bytedance.com>
Content-Transfer-Encoding: 7bit
Cc: <peterx@redhat.com>, <farosas@suse.de>, <lizhijian@fujitsu.com>, 
 "Yanfei Xu" <yanfei.xu@bytedance.com>
References: <20260817105117.3072040-1-yanfei.xu@bytedance.com>
X-Mailer: git-send-email 2.20.1
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>
Received-SPF: pass client-ip=209.127.230.113;
 envelope-from=yanfei.xu@bytedance.com; helo=va-1-113.ptr.blmpb.com
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

RAM writes and control messages share the send queue.  If
outstanding writes fill it, RDMA writes drain a completion and retry,
but control sends fail the migration.

Drain one outstanding write and retry the control send on ENOMEM.

Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
---
 migration/rdma.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 6e8436ccc1..d1f44a5f55 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1572,9 +1572,19 @@ static int qemu_rdma_post_send_control(RDMAContext *rdma, uint8_t *buf,
         memcpy(wr->control + sizeof(RDMAControlHeader), buf, head->len);
     }
 
-
+retry:
     ret = ibv_post_send(rdma->qp, &send_wr, &bad_wr);
 
+    if (ret == ENOMEM && rdma->nb_sent) {
+        ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL);
+        if (ret < 0) {
+            error_setg(errp, "rdma migration: failed to make room for "
+                       "control send");
+            return -1;
+        }
+        goto retry;
+    }
+
     if (ret > 0) {
         error_setg(errp, "Failed to use post IB SEND for control");
         return -1;
-- 
2.20.1

