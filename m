Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97505C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 21:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb4xF-0000Cu-BS; Mon, 05 Aug 2024 17:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sb4xD-0008UR-HT
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 17:09:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sb4xB-0008T4-26
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 17:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722892149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/g0sHsnAjTQQwqSUZTxHOBU5uq4XarRAoERO1KomibQ=;
 b=JTFOksgqMtxNAzFLqmkE66g70lqoRzCXgg2hkSrHEoe3zZp+eEgT45hKyv1+Q+0MKLJw+9
 bTuHdD0aDZTIu23nanQUDWSEw02dQQ8Q05T1DJGjVXgY949gxBmUCeLHOXR6+TRTFBwBwO
 UljPYIRWcuq5nOYsAmaB7Orbx0Yvfb4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-Ad9bJgZdO5CgvRA1zr2OJg-1; Mon,
 05 Aug 2024 17:09:06 -0400
X-MC-Unique: Ad9bJgZdO5CgvRA1zr2OJg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C508519560B1; Mon,  5 Aug 2024 21:09:05 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.224])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6BE2530001B7; Mon,  5 Aug 2024 21:09:04 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 02/13] block-copy: Fix missing graph lock
Date: Mon,  5 Aug 2024 23:08:40 +0200
Message-ID: <20240805210851.314076-3-kwolf@redhat.com>
In-Reply-To: <20240805210851.314076-1-kwolf@redhat.com>
References: <20240805210851.314076-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Message-ID: <20240627181245.281403-2-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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


