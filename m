Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545B7606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JvXToVux
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTMpB-0006bs-9q; Tue, 17 Nov 2026 12:18:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xTMp9-0006at-0n
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:18:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xTMp7-0006bM-JB
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794935904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=goYzro8Ll5RWFNp/oJjIQrPkpGv0L0RDI/7uWC2pE2k=;
 b=JvXToVuxVQTH1RprmjAtJ/sRjN2MDC5ST8wjq8jz8A0kdDbjjzQqovS3Gww52BBpGXYJP3
 XD6r9chnB6wPvs2n0rlqyfsNIyojoEv3UTGEAxZOpbikYStXTLZ/FWKXKUb3207B6dGq4K
 i94zLDVi9koQ53/QB1hJ1ijiZAri37U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-ydAhOLvRNfqJZ3i6xNtUaQ-1; Tue,
 17 Nov 2026 12:18:20 -0500
X-MC-Unique: ydAhOLvRNfqJZ3i6xNtUaQ-1
X-Mimecast-MFC-AGG-ID: ydAhOLvRNfqJZ3i6xNtUaQ_1794935899
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7ECFA18002C5; Tue, 17 Nov 2026 17:18:19 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2C06B195B3C5; Tue, 17 Nov 2026 17:18:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 8/8] block: notify only the replaced child in
 bdrv_replace_child_bs()
Date: Tue, 17 Nov 2026 18:17:58 +0100
Message-ID: <20261117171758.237462-9-kwolf@redhat.com>
In-Reply-To: <20261117171758.237462-1-kwolf@redhat.com>
References: <20261117171758.237462-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

bdrv_replace_child_bs() compares the sizes of the old and the new node
to decide whether @child has to be told, and then notifies every parent
of new_bs. The other parents already had that node and its size, so
they get a resize event for nothing: a scsi-hd sharing the new node
reports CAPACITY DATA HAS CHANGED to its guest although the capacity is
the same.

Notify @child alone. bdrv_parent_cb_resize() has no user left, so drop
it.

Fixes: 8b267376df87 ("block: notify the parent when a replaced child has a different size")
Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261105203752.3169635-4-den@openvz.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-io.h | 3 ---
 block.c                      | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/block/block_int-io.h b/include/block/block_int-io.h
index 3cb72fecd4f..6aa7b2184e9 100644
--- a/include/block/block_int-io.h
+++ b/include/block/block_int-io.h
@@ -206,7 +206,4 @@ bdrv_co_child_notify_resize(BdrvChild *c);
 void co_wrapper_bdrv_rdlock
 bdrv_child_notify_resize(BdrvChild *c);
 
-void co_wrapper_bdrv_rdlock
-bdrv_parent_cb_resize(BlockDriverState *bs);
-
 #endif /* BLOCK_INT_IO_H */
diff --git a/block.c b/block.c
index 9df1a48c06b..c3e7059556a 100644
--- a/block.c
+++ b/block.c
@@ -5590,7 +5590,7 @@ int bdrv_replace_child_bs(BdrvChild *child, BlockDriverState *new_bs,
         int64_t new_len = bdrv_getlength(new_bs);
 
         if (new_len >= 0 && new_len != old_len) {
-            bdrv_parent_cb_resize(new_bs);
+            bdrv_child_notify_resize(child);
         }
     }
 
-- 
2.56.1


