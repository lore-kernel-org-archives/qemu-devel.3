Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B86CCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 21:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIvzw-0008MJ-9s; Tue, 11 Nov 2025 16:33:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIvzt-000868-5P
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:33:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIvzr-00027X-Pf
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762896831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mmHhshZnNaiyS7BfkMJf8KcDdSyD7WnoCR26ukj/Z4w=;
 b=IGBwjp6tVqpauHYxrWzWckb4z3nbmttkygqLmzEqRPKPbfCbjsHOh740VIYSqdrBMTrUaA
 WVBwJTun87YuMtUm3ixTVVE9HhUVUn41WX7Q/FTfIRMOj8pTR7zxPgIdfziXRN3aYpe+0J
 wfNLkl+N79dQguqdDN1xeCjXHpsWKVg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-FXOHVokvMJG5Mu1OxRDNRw-1; Tue,
 11 Nov 2025 16:33:48 -0500
X-MC-Unique: FXOHVokvMJG5Mu1OxRDNRw-1
X-Mimecast-MFC-AGG-ID: FXOHVokvMJG5Mu1OxRDNRw_1762896826
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92D721800358; Tue, 11 Nov 2025 21:33:46 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.225.214])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 07A9F30044E0; Tue, 11 Nov 2025 21:33:44 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 21/28] qcow2: rename update_refcount_discard to queue_discard
Date: Tue, 11 Nov 2025 22:32:31 +0100
Message-ID: <20251111213238.181992-22-kwolf@redhat.com>
In-Reply-To: <20251111213238.181992-1-kwolf@redhat.com>
References: <20251111213238.181992-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jean-Louis Dupond <jean-louis@dupond.be>

The function just queues discards, and doesn't do any refcount change.
So let's change the function name to align with its function.

Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
Message-ID: <20250513132628.1055549-2-jean-louis@dupond.be>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.51.1


