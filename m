Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AE4C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 21:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXpu8-00079f-6x; Wed, 07 Feb 2024 16:56:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXpu6-000783-Jd
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 16:56:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXpu5-0007eF-1I
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 16:56:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707342984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a7p5x2fcwKWLwW7RHE3p8xiZBd6Y/sYtDmGs1L7gZkM=;
 b=ir0LrAVobarVXe8STN7Ar1rR7bKM2DkLLeC1BZO5rfcFjT9B87eGXYfpujyFS8nSnG/HFn
 eCuBbwZ3LcF1kbkfn8qnNUc7UzmSg8ZmiHEeGtxFqyL//RihVwGD+VA6lVe5g9XvPo+z0S
 zW4Yidb7zOUj4Mrlh3xDNOuHyvxPOoo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-fu3H8selNy-p459LkpqW2Q-1; Wed,
 07 Feb 2024 16:56:21 -0500
X-MC-Unique: fu3H8selNy-p459LkpqW2Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DCBD3C11C74;
 Wed,  7 Feb 2024 21:56:21 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A58DC492BC6;
 Wed,  7 Feb 2024 21:56:20 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 12/16] blkio: Respect memory-alignment for bounce buffer
 allocations
Date: Wed,  7 Feb 2024 22:56:02 +0100
Message-ID: <20240207215606.206038-13-kwolf@redhat.com>
In-Reply-To: <20240207215606.206038-1-kwolf@redhat.com>
References: <20240207215606.206038-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

blkio_alloc_mem_region() requires that the requested buffer size is a
multiple of the memory-alignment property. If it isn't, the allocation
fails with a return value of -EINVAL.

Fix the call in blkio_resize_bounce_pool() to make sure the requested
size is properly aligned.

I observed this problem with vhost-vdpa, which requires page aligned
memory. As the virtio-blk device behind it still had 512 byte blocks, we
got bs->bl.request_alignment = 512, but actually any request that needed
a bounce buffer and was not aligned to 4k would fail without this fix.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20240131173140.42398-1-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/blkio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blkio.c b/block/blkio.c
index bc2f21784c..882e1c297b 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -89,6 +89,9 @@ static int blkio_resize_bounce_pool(BDRVBlkioState *s, int64_t bytes)
     /* Pad size to reduce frequency of resize calls */
     bytes += 128 * 1024;
 
+    /* Align the pool size to avoid blkio_alloc_mem_region() failure */
+    bytes = QEMU_ALIGN_UP(bytes, s->mem_region_alignment);
+
     WITH_QEMU_LOCK_GUARD(&s->blkio_lock) {
         int ret;
 
-- 
2.43.0


