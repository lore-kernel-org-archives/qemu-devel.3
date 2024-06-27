Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F60C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 18:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMtcZ-0005VQ-DU; Thu, 27 Jun 2024 14:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sMtcP-0005RI-42
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 14:13:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sMtcL-0006nO-J7
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 14:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719511989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gec3LUcZiAY4dxA2bnifaJaoSCKN9ssV4ZLYVPjMR7k=;
 b=TGfPMhk203uQdgQdWLZsUU41Dpmz2+1E3+nmIfEN8/Iz+XYSr6xGHuYbt7YaPNzUbYkT6M
 H9Ed+RnKrYCWvxpmY7wKJewsYoJ9JijlJEav5FmPvor2DqX1Exp96p0NBfcN7ZTtRgLhlk
 /xkBlnT0a/0UY4UXLcaBE/MMwSr4vkQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-G7RbJyETNUuhDiOsoSpBCw-1; Thu,
 27 Jun 2024 14:13:05 -0400
X-MC-Unique: G7RbJyETNUuhDiOsoSpBCw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E78E019560B5; Thu, 27 Jun 2024 18:13:04 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.213])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EA70D1955BD4; Thu, 27 Jun 2024 18:13:02 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eblake@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 1/2] block-copy: Fix missing graph lock
Date: Thu, 27 Jun 2024 20:12:44 +0200
Message-ID: <20240627181245.281403-2-kwolf@redhat.com>
In-Reply-To: <20240627181245.281403-1-kwolf@redhat.com>
References: <20240627181245.281403-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The graph lock needs to be held when calling bdrv_co_pdiscard(). Fix
block_copy_task_entry() to take it for the call.

WITH_GRAPH_RDLOCK_GUARD() was implemented in a weak way because of
limitations in clang's Thread Safety Analysis at the time, so that it
only asserts that the lock is held (which allows calling functions that
require the lock), but we never deal with the unlocking (so even after
the scope of the guard, the compiler assumes that the lock is still
held). This is why the compiler didn't catch this locking error.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/block-copy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 7e3b378528..cc618e4561 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -595,7 +595,9 @@ static coroutine_fn int block_copy_task_entry(AioTask *task)
     if (s->discard_source && ret == 0) {
         int64_t nbytes =
             MIN(t->req.offset + t->req.bytes, s->len) - t->req.offset;
-        bdrv_co_pdiscard(s->source, t->req.offset, nbytes);
+        WITH_GRAPH_RDLOCK_GUARD() {
+            bdrv_co_pdiscard(s->source, t->req.offset, nbytes);
+        }
     }
 
     return ret;
-- 
2.45.2


