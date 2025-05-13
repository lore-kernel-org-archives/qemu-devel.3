Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A583C3ABD7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 13:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEpeu-0006Tt-6u; Tue, 13 May 2025 09:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1uEper-0006SH-Hu; Tue, 13 May 2025 09:26:57 -0400
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1uEpej-00073k-NI; Tue, 13 May 2025 09:26:57 -0400
Received: from localhost.localdomain (unknown
 [IPv6:2a00:1c98:fff1:1001:aee7:ee9c:3ae8:78e2])
 by apollo.dupie.be (Postfix) with ESMTPSA id 249BE1520F7B;
 Tue, 13 May 2025 15:26:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1747142803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=99J0rIeuUVgTKW9n/MWFRRiskaq30r22kpTzoYJPRJQ=;
 b=jyHuf6LbpsWTsLICEj0ZKC9OK5O1pNPwVjwp1rTHi+tV4TwDgH3J4ZtoUeYqbF0Dl2tJnM
 pywGkFbPw9IT7O+/vNaJPyjomuF3eJVFeFKEwOTtVLUDKFQoZDwxeOSTNTynAslDdQYmsW
 n/GzRT2RiZyfVtIHXwetFRm9bmEfEU2chrWiHK5YWyijHoH9FSXqpOhCs6ZzunWh/Pr44B
 ZrbXCmVglKsNAwHEuyObccI8ZWaJG7/ULNqrrilddkYpXoE2nG9Q6145FBxSKEnLCxrJct
 1t9xFIM99RPomiJFuKm3xfvKrzwlVPvFJV5sZEACxAsDL01+Stg/stTkzMPkaQ==
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org,
 Jean-Louis Dupond <jean-louis@dupond.be>
Subject: [PATCH v2 1/2] qcow2: rename update_refcount_discard to queue_discard
Date: Tue, 13 May 2025 15:26:27 +0200
Message-ID: <20250513132628.1055549-2-jean-louis@dupond.be>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513132628.1055549-1-jean-louis@dupond.be>
References: <20250513132628.1055549-1-jean-louis@dupond.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=51.159.20.238; envelope-from=jean-louis@dupond.be;
 helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The function just queues discards, and doesn't do any refcount change.
So let's change the function name to align with its function.

Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
---
 block/qcow2-refcount.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 0266542cee..8fb210501c 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -754,8 +754,8 @@ void qcow2_process_discards(BlockDriverState *bs, int ret)
     }
 }
 
-static void update_refcount_discard(BlockDriverState *bs,
-                                    uint64_t offset, uint64_t length)
+static void queue_discard(BlockDriverState *bs,
+                          uint64_t offset, uint64_t length)
 {
     BDRVQcow2State *s = bs->opaque;
     Qcow2DiscardRegion *d, *p, *next;
@@ -902,7 +902,7 @@ update_refcount(BlockDriverState *bs, int64_t offset, int64_t length,
             }
 
             if (s->discard_passthrough[type]) {
-                update_refcount_discard(bs, cluster_offset, s->cluster_size);
+                queue_discard(bs, cluster_offset, s->cluster_size);
             }
         }
     }
@@ -3619,7 +3619,7 @@ qcow2_discard_refcount_block(BlockDriverState *bs, uint64_t discard_block_offs)
         /* discard refblock from the cache if refblock is cached */
         qcow2_cache_discard(s->refcount_block_cache, refblock);
     }
-    update_refcount_discard(bs, discard_block_offs, s->cluster_size);
+    queue_discard(bs, discard_block_offs, s->cluster_size);
 
     return 0;
 }
-- 
2.49.0


