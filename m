Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8B1606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FRYYy54M
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTMp8-0006a6-9h; Tue, 17 Nov 2026 12:18:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xTMp4-0006Y5-PS
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:18:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xTMp3-0006aL-8U
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:18:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794935901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ce6aUHCZ7Rx31iKQJVNhPpVlzSao3T5q4N453t3rLrE=;
 b=FRYYy54MwHZfNuqVXZdekCLu8ZfRYbnmf9FTKOJDlAAhJS5r2e70rPYmyW7M0BL99QRc9z
 FZ4iegjvPO8WKcJLX+V0QL5C3ZjtcnsnM+nAjGgummObPxvc/S4GxM9aXOdheYzfmzLrgv
 6oXnZIhrRkz8d3JqquTwSfe9k7bgwlI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-hA3dP4gcOrKxixHnyxqsGA-1; Tue,
 17 Nov 2026 12:18:17 -0500
X-MC-Unique: hA3dP4gcOrKxixHnyxqsGA-1
X-Mimecast-MFC-AGG-ID: hA3dP4gcOrKxixHnyxqsGA_1794935896
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05D3C1800599; Tue, 17 Nov 2026 17:18:16 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6B507195B3C7; Tue, 17 Nov 2026 17:18:14 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 6/8] block: read the old child length after draining in
 bdrv_replace_child_bs()
Date: Tue, 17 Nov 2026 18:17:56 +0100
Message-ID: <20261117171758.237462-7-kwolf@redhat.com>
In-Reply-To: <20261117171758.237462-1-kwolf@redhat.com>
References: <20261117171758.237462-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Denis V. Lunev" <den@openvz.org>

bdrv_drained_begin() runs nested event loops, and old_bs can be resized
from there by something other than the BlockBackend being switched: an
export truncating it, or a block job completing. old_len read before
the drain is then stale, and comparing it with new_len sends a
notification the parent does not need or skips one it does.

Read it once both nodes are drained, so that the read, the comparison
and the notification see the same sizes. A resize which completes in
the drain notifies the parents of old_bs, @child included, on its own.

Fixes: 8b267376df87 ("block: notify the parent when a replaced child has a different size")
Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261105203752.3169635-2-den@openvz.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 006c3413406..9df1a48c06b 100644
--- a/block.c
+++ b/block.c
@@ -5566,11 +5566,12 @@ int bdrv_replace_child_bs(BdrvChild *child, BlockDriverState *new_bs,
 
     GLOBAL_STATE_CODE();
 
-    old_len = bdrv_getlength(old_bs);
-
     bdrv_ref(old_bs);
     bdrv_drained_begin(old_bs);
     bdrv_drained_begin(new_bs);
+
+    old_len = bdrv_getlength(old_bs);
+
     bdrv_graph_wrlock();
 
     bdrv_replace_child_tran(child, new_bs, tran);
-- 
2.56.1


