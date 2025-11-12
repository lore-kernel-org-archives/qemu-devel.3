Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63A8CD13DD
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 16:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJDwk-0001Kg-Gk; Wed, 12 Nov 2025 11:43:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vJDuH-0007g1-8V; Wed, 12 Nov 2025 11:41:20 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vJDuE-0007zs-LT; Wed, 12 Nov 2025 11:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=Eiy+P/m1GSyiAuLf1biu8Qv/nhPfT6ioj5lttzS+EqA=; b=e//r6sqRDTMV
 oOnz3f0Ek50/lusSwCTejbOakWiI47Imb9m6C/WYT2XeTRweB7ZtB+UJlZ3zbGKROB8oTIkjldCif
 jzcbKvTlCyYZLwYLb8MnydZvA8q+oEcxWqPlvXgDezAOTOVa4m+ZeAa/20zdgJEGD3yNJ0sxeFm2l
 HEPmCBNbIOnt8E0UaCa+iVngV8KR/dQ+NVG1Zf290XjyU2PtRLDPXKwQS0C5ROEs/W5cSu6boyo1+
 yZHVTnRehwBO4AgOEMYCOiUhZzsWi0cM0a9tDlbSk1FWNzuYQ+GrAbTByucgJFznxRru0FrOo/U7E
 EXu64d4eZxLdr04G+UPZiA==;
Received: from [130.117.225.5] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1vJDsg-00H2e8-11;
 Wed, 12 Nov 2025 17:41:07 +0100
From: andrey.drobyshev@virtuozzo.com
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, f.ebner@proxmox.com,
 hreitz@redhat.com, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com
Subject: [RFC PATCH 1/1] block: avoid global drain on graph subtrees
 manipulation
Date: Wed, 12 Nov 2025 18:41:08 +0200
Message-ID: <20251112164108.506976-2-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251112164108.506976-1-andrey.drobyshev@virtuozzo.com>
References: <20251112164108.506976-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

The block layer's graph drain series [0] moved many drain operations outside
of graph locks, but introduced a regression: some function now unconditionally
use bdrv_graph_wrlock_drained(), which drains all BDS in the system and
asserts no I/O is in flight.

When 'blockdev-add' creates a new node, it creates a temporary
BlockBackend which is only used for probing, only to delete it later.
Before deletion, it's also attaching child 'file' BDS to that same
BlockBackend in bdrv_open_child_common().

Both blk_remove_bs() and bdrv_open_child_common() call
bdrv_graph_wrlock_drained() unconditionally.  If we have an incoming IO
at the same time, it might lead to assertion failure:

    qemu-system-x86_64: ../block/io.c:441: bdrv_drain_assert_idle: \
        Assertion `qatomic_read(&bs->in_flight) == 0' failed.

The global drain is unnecessary for temporary nodes created during
'blockdev-add'. Only live device roots require full graph draining.

[0] https://lore.kernel.org/qemu-devel/20250530151125.955508-1-f.ebner@proxmox.com/

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block.c               |  8 +++++++-
 block/block-backend.c | 11 ++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index cf08e64add..26dfc624b6 100644
--- a/block.c
+++ b/block.c
@@ -3796,10 +3796,16 @@ bdrv_open_child_common(const char *filename, QDict *options,
         return NULL;
     }
 
-    bdrv_graph_wrlock_drained();
+
+    /* We only need this parent's subtree to be drained, not the entire graph.
+     * So we avoid global drain here.
+     */
+    bdrv_drained_begin(parent);
+    bdrv_graph_wrlock();
     child = bdrv_attach_child(parent, bs, bdref_key, child_class, child_role,
                               errp);
     bdrv_graph_wrunlock();
+    bdrv_drained_end(parent);
 
     return child;
 }
diff --git a/block/block-backend.c b/block/block-backend.c
index f8d6ba65c1..d8110cbaff 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -889,7 +889,16 @@ void blk_remove_bs(BlockBackend *blk)
     root = blk->root;
     blk->root = NULL;
 
-    bdrv_graph_wrlock_drained();
+    if (blk->dev) {
+        bdrv_graph_wrlock_drained();
+    } else {
+        /* We suppose that blk with an unattached dev is temporary (e.g.
+         * used for probing in bdrv_open_inherit()) and therefore global
+         * drain is unnecessary.  Draining of this blk's subtree is done above
+         * in blk_drain().
+         */
+        bdrv_graph_wrlock();
+    }
     bdrv_root_unref_child(root);
     bdrv_graph_wrunlock();
 }
-- 
2.43.5


