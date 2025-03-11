Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19B9C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 16:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts25J-0007dc-B3; Tue, 11 Mar 2025 12:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ts21z-0003sB-93
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:00:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ts21x-0005fI-Fg
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741708832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C4d7rCQo/2zgKQ6hXTlL5Or1bUZEDZQka54b0/Sz75k=;
 b=ZhXizS8MnnmI9KasVKTwQd0olVPO9M/6Mu83U3R0xqbOL07xOdD4LkxfBsYuEMF83MdTdS
 uQAq+Jy7jmV/FAV9tEEOSDRW0C5gsK8gq3aA4rJjlYhIuG5DRHrzd7NwWu9+rnIokyI0gD
 3Ur73JgXew9tvqvvM1FQROxX9wPkK4o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-1X7CheqzNceWke4e0pEBlw-1; Tue,
 11 Mar 2025 12:00:29 -0400
X-MC-Unique: 1X7CheqzNceWke4e0pEBlw-1
X-Mimecast-MFC-AGG-ID: 1X7CheqzNceWke4e0pEBlw_1741708828
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C2B81801A00; Tue, 11 Mar 2025 16:00:28 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.33.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 778301828A95; Tue, 11 Mar 2025 16:00:26 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 01/22] block: Remove unused blk_op_is_blocked()
Date: Tue, 11 Mar 2025 17:00:00 +0100
Message-ID: <20250311160021.349761-2-kwolf@redhat.com>
In-Reply-To: <20250311160021.349761-1-kwolf@redhat.com>
References: <20250311160021.349761-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Commit fc4e394b28 removed the last caller of blk_op_is_blocked(). Remove
the now unused function.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20250206165331.379033-1-kwolf@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/system/block-backend-global-state.h |  1 -
 block/block-backend.c                       | 12 ------------
 2 files changed, 13 deletions(-)

diff --git a/include/system/block-backend-global-state.h b/include/system/block-backend-global-state.h
index 9cc9b008ec..35b5e8380b 100644
--- a/include/system/block-backend-global-state.h
+++ b/include/system/block-backend-global-state.h
@@ -86,7 +86,6 @@ bool blk_supports_write_perm(BlockBackend *blk);
 bool blk_is_sg(BlockBackend *blk);
 void blk_set_enable_write_cache(BlockBackend *blk, bool wce);
 int blk_get_flags(BlockBackend *blk);
-bool blk_op_is_blocked(BlockBackend *blk, BlockOpType op, Error **errp);
 int blk_set_aio_context(BlockBackend *blk, AioContext *new_context,
                         Error **errp);
 void blk_add_aio_context_notifier(BlockBackend *blk,
diff --git a/block/block-backend.c b/block/block-backend.c
index 9288f7e1c6..a402db13f2 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2357,18 +2357,6 @@ void *blk_blockalign(BlockBackend *blk, size_t size)
     return qemu_blockalign(blk ? blk_bs(blk) : NULL, size);
 }
 
-bool blk_op_is_blocked(BlockBackend *blk, BlockOpType op, Error **errp)
-{
-    BlockDriverState *bs = blk_bs(blk);
-    GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
-
-    if (!bs) {
-        return false;
-    }
-
-    return bdrv_op_is_blocked(bs, op, errp);
-}
 
 /**
  * Return BB's current AioContext.  Note that this context may change
-- 
2.48.1


