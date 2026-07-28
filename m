Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A33CC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 17:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wolka-0007Ss-2Q; Tue, 28 Jul 2026 13:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wolkV-0007P2-Sz
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:37:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wolkT-0005tJ-O8
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785260268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NgTKXSJ0g2+HCcpre4LqKZbJQ12eE7mQTgcJ1v3nspg=;
 b=CfaXyQVjhflbibWlISyp/233FlDkJy3PGuMVkZQ86zT+6puVGp58z0N7XtNqFVuKbM8wW/
 QB56G8pS8ruD46yMEeZPmb0A3Wj2m408501wq6YPceuw3FTC1h6P/K2y4HGB+ESnJVcsFz
 MxBSAkuAXT4oxDQaSdPW86lOKoB6wYM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-zYGprw2YMtWOQJqWiCXy_Q-1; Tue,
 28 Jul 2026 13:37:47 -0400
X-MC-Unique: zYGprw2YMtWOQJqWiCXy_Q-1
X-Mimecast-MFC-AGG-ID: zYGprw2YMtWOQJqWiCXy_Q_1785260266
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D04B195604B; Tue, 28 Jul 2026 17:37:46 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.49.201])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CAB0A19560AB; Tue, 28 Jul 2026 17:37:44 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 01/17] block/cloop: fix integer overflow in total_sectors
 calculation
Date: Tue, 28 Jul 2026 19:37:23 +0200
Message-ID: <20260728173739.352078-2-kwolf@redhat.com>
In-Reply-To: <20260728173739.352078-1-kwolf@redhat.com>
References: <20260728173739.352078-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: malike <malike@kylinos.cn>

The total_sectors is computed as n_blocks * sectors_per_block where
both operands are uint32_t. The multiplication is performed in 32-bit
arithmetic and can overflow when the product exceeds UINT32_MAX,
producing a value much smaller than the true image size. The result
is assigned to int64_t total_sectors but the 32-bit multiplication
has already wrapped around, and the zero-extension to 64-bit does
not recover the correct value.

This causes the block layer to reject valid I/O requests (DoS) when
the reported total_sectors is smaller than the actual image.

Use 64-bit arithmetic by casting one operand to uint64_t so the
multiplication is performed in 64-bit precision.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3972
Signed-off-by: Ma Like <malike@kylinos.cn>
Message-ID: <20260713031750.58448-1-malike@kylinos.cn>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/cloop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/cloop.c b/block/cloop.c
index 443af1444e8..a16f08e6ef6 100644
--- a/block/cloop.c
+++ b/block/cloop.c
@@ -202,7 +202,8 @@ static int cloop_open(BlockDriverState *bs, QDict *options, int flags,
     s->current_block = s->n_blocks;
 
     s->sectors_per_block = s->block_size/512;
-    bs->total_sectors = s->n_blocks * s->sectors_per_block;
+    /* Cast to uint64_t to prevent uint32_t overflow */
+    bs->total_sectors = (uint64_t)s->n_blocks * s->sectors_per_block;
     qemu_co_mutex_init(&s->lock);
     return 0;
 
-- 
2.55.0


