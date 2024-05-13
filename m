Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AEEC25B5F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 06:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6PEf-0007TL-TA; Mon, 13 May 2024 02:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1s6PEM-00077S-Lt; Mon, 13 May 2024 02:32:14 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1s6PEI-0003we-MM; Mon, 13 May 2024 02:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=jQdqmK1nf19RwtsWKWHuGRHEKfLo+KSie5FkgkRKt3s=; b=R/KyBnDTdZtT
 Xh5gq01vgYK9HfSyhT38hUo0QY8TdUQMU5HxJ+JiJwD3LvPlGPYVNkf+HPwoKMK5DSVBc/FiLMWa2
 2qqp/ccQ45QNr2qEo82ECCIPZThDqDCEI/APEfHKOAa0Ssx2cqIMvoni1Hq8QgJoDPkyN0bHya13y
 WTgB5nQ5atP0pKqMSbsslzt4WK09fIAxLtnqqtRHBs8JhhLgjqp5Kmuus3VBfHqEpzUo7UrWmHZtG
 YW34jm2CF18HJxe+tsoU3+vkZOrtrsk9wVJNtrqK0uNGFeEEZuvALSYpKPXllBB0RPEwmSfTgbavd
 PWzRzY3tYHLKT/JuKuSh0w==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1s6PAR-000qpR-1q;
 Mon, 13 May 2024 08:31:56 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, jean-louis@dupond.be,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v2 01/11] qcow2: make function update_refcount_discard() global
Date: Mon, 13 May 2024 09:31:53 +0300
Message-Id: <20240513063203.113911-2-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
References: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

We are going to need it for discarding separate subclusters.  The
function itself doesn't do anything with the refcount tables, it simply
adds a discard request to the queue, so rename it to qcow2_queue_discard().

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/qcow2-refcount.c | 8 ++++----
 block/qcow2.h          | 2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 0266542cee..2026f5fa21 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -754,8 +754,8 @@ void qcow2_process_discards(BlockDriverState *bs, int ret)
     }
 }
 
-static void update_refcount_discard(BlockDriverState *bs,
-                                    uint64_t offset, uint64_t length)
+void qcow2_queue_discard(BlockDriverState *bs, uint64_t offset,
+                         uint64_t length)
 {
     BDRVQcow2State *s = bs->opaque;
     Qcow2DiscardRegion *d, *p, *next;
@@ -902,7 +902,7 @@ update_refcount(BlockDriverState *bs, int64_t offset, int64_t length,
             }
 
             if (s->discard_passthrough[type]) {
-                update_refcount_discard(bs, cluster_offset, s->cluster_size);
+                qcow2_queue_discard(bs, cluster_offset, s->cluster_size);
             }
         }
     }
@@ -3619,7 +3619,7 @@ qcow2_discard_refcount_block(BlockDriverState *bs, uint64_t discard_block_offs)
         /* discard refblock from the cache if refblock is cached */
         qcow2_cache_discard(s->refcount_block_cache, refblock);
     }
-    update_refcount_discard(bs, discard_block_offs, s->cluster_size);
+    qcow2_queue_discard(bs, discard_block_offs, s->cluster_size);
 
     return 0;
 }
diff --git a/block/qcow2.h b/block/qcow2.h
index a9e3481c6e..197bdcdf53 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -891,6 +891,8 @@ int coroutine_fn qcow2_check_refcounts(BlockDriverState *bs, BdrvCheckResult *re
                                        BdrvCheckMode fix);
 
 void GRAPH_RDLOCK qcow2_process_discards(BlockDriverState *bs, int ret);
+void qcow2_queue_discard(BlockDriverState *bs, uint64_t offset,
+                         uint64_t length);
 
 int GRAPH_RDLOCK
 qcow2_check_metadata_overlap(BlockDriverState *bs, int ign, int64_t offset,
-- 
2.39.3


