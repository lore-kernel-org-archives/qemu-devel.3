Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80997CFD37C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 16:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNvk4-000755-8k; Tue, 25 Nov 2025 11:18:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vNvj2-0006ia-B0
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 11:17:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vNvj0-000566-SN
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 11:17:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764087426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fbGI+MEiiC6jErCUJoENINEqv/p0bcCbG1DZdiOJh7M=;
 b=UuKSHBQ4xc0EdMGXrI6BmL/WBysiKcZyQw0r8Np804o8OOxgBsw2ZEJm+zaNpDQsS9xJKY
 QMepjCNU1WEbWv0zu+bHbZrbw6MVfjtUIhgcfoeVn+uVcyleTWMmpijjcspwIzQWNhaQS5
 3wqNWs8kJaFkavJUe/eRrleQl4oNthU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-JCOyUmzlNd-dT72nQmOXzA-1; Tue,
 25 Nov 2025 11:17:02 -0500
X-MC-Unique: JCOyUmzlNd-dT72nQmOXzA-1
X-Mimecast-MFC-AGG-ID: JCOyUmzlNd-dT72nQmOXzA_1764087421
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F48F1954B11; Tue, 25 Nov 2025 16:17:01 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.226.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 140671800298; Tue, 25 Nov 2025 16:16:59 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 1/4] block-backend: Fix race when resuming queued requests
Date: Tue, 25 Nov 2025 17:16:45 +0100
Message-ID: <20251125161648.259321-2-kwolf@redhat.com>
In-Reply-To: <20251125161648.259321-1-kwolf@redhat.com>
References: <20251125161648.259321-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

When new requests arrive at a BlockBackend that is currently drained,
these requests are queued until the drain section ends.

There is a race window between blk_root_drained_end() waking up a queued
request in an iothread from the main thread and blk_wait_while_drained()
actually being woken up in the iothread and calling blk_inc_in_flight().
If the BlockBackend is drained again during this window, drain won't
wait for this request and it will sneak in when the BlockBackend is
already supposed to be quiesced. This causes assertion failures in
bdrv_drain_all_begin() and can have other unintended consequences.

Fix this by increasing the in_flight counter immediately when scheduling
the request to be resumed so that the next drain will wait for it to
complete.

Cc: qemu-stable@nongnu.org
Reported-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20251119172720.135424-1-kwolf@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Tested-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/block-backend.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index f8d6ba65c1..d6df369188 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1318,9 +1318,9 @@ static void coroutine_fn blk_wait_while_drained(BlockBackend *blk)
          * section.
          */
         qemu_mutex_lock(&blk->queued_requests_lock);
+        /* blk_root_drained_end() has the corresponding blk_inc_in_flight() */
         blk_dec_in_flight(blk);
         qemu_co_queue_wait(&blk->queued_requests, &blk->queued_requests_lock);
-        blk_inc_in_flight(blk);
         qemu_mutex_unlock(&blk->queued_requests_lock);
     }
 }
@@ -2767,9 +2767,11 @@ static void blk_root_drained_end(BdrvChild *child)
             blk->dev_ops->drained_end(blk->dev_opaque);
         }
         qemu_mutex_lock(&blk->queued_requests_lock);
-        while (qemu_co_enter_next(&blk->queued_requests,
-                                  &blk->queued_requests_lock)) {
+        while (!qemu_co_queue_empty(&blk->queued_requests)) {
             /* Resume all queued requests */
+            blk_inc_in_flight(blk);
+            qemu_co_enter_next(&blk->queued_requests,
+                               &blk->queued_requests_lock);
         }
         qemu_mutex_unlock(&blk->queued_requests_lock);
     }
-- 
2.51.1


