Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CC4FC6166
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 16:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp9Ks-0006H6-L7; Fri, 13 Sep 2024 12:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sp9Kn-00064N-Sd; Fri, 13 Sep 2024 12:39:50 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sp9Km-0000qC-6v; Fri, 13 Sep 2024 12:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=g/TdJ5qXyf+1Rtq7JvfFokbbeo/irttxDxGcy32Lx1Y=; b=NEfuouYZGS0h
 GBEenzfZW6KJCwxQX3fDjOGCOycF8SaVsq3Vxyir909D9y/SlfpSDxPMphvP6Fmelesub7QKx53JB
 iCt+ie3NEdKyNZhxY3RhMAGT7CsSpami9TS6GNn7ATZZ6V1d2arOMdYhg8Ayk7fJefhrlRV9EGpwL
 tjYtEZpQ4xnnDF3BfkNVLM7J6KJa8ABEj+NvQFJqINy89CP1/xoUiG9EThsmokDZwqblg08mNXYxI
 /tkpq0LqAdcDar0TA1ricFsqQOv3HfUTVEDUKoLSPR+Ls18xXIDNOJJNTcxvDXT+a+CO8QKIVe0Pr
 Kn1jgfMiRa/KqS4Wmgtq2w==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1sp9Hy-002OPf-2R;
 Fri, 13 Sep 2024 18:39:39 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, stefanha@redhat.com, berto@igalia.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v3 01/12] qcow2: make function update_refcount_discard() global
Date: Fri, 13 Sep 2024 19:39:31 +0300
Message-Id: <20240913163942.423050-2-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240913163942.423050-1-andrey.drobyshev@virtuozzo.com>
References: <20240913163942.423050-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
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


