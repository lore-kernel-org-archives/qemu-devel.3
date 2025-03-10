Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA44C28B2E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 10:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trah8-0006OO-SF; Mon, 10 Mar 2025 06:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1trah4-0006NM-J9
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:49:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1trah2-0004rg-GB
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741603747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=I36Dcvi268C2V8W9mc+7VsefR7nGxhlXfzQDjKPhpfE=;
 b=Li04kZXkOiLbTYJZdQ7zVhNxKdCvltzl8g373JRH8wTnhgK9FOqAyWKZY7ANMZAIcIIaEu
 P4HvjRa7GsTkeOrxYFI9z8nbSW+lIgsSwadFD9AQBW9huKJj7cLbqAUnSo/Y6JDE0lJldC
 Idc0VbiaIIFZ2lUaxxVWPo6BXMV+S7o=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-UyEXadnENGW9rt4aAi1DbQ-1; Mon,
 10 Mar 2025 06:49:03 -0400
X-MC-Unique: UyEXadnENGW9rt4aAi1DbQ-1
X-Mimecast-MFC-AGG-ID: UyEXadnENGW9rt4aAi1DbQ_1741603743
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FEE519560A1; Mon, 10 Mar 2025 10:49:02 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.225.222])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF1721800944; Mon, 10 Mar 2025 10:49:00 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, gerben@altlinux.org, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH] block: Zero block driver state before reopening
Date: Mon, 10 Mar 2025 11:48:58 +0100
Message-ID: <20250310104858.28221-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Block drivers assume in their .bdrv_open() implementation that their
state in bs->opaque has been zeroed; it is initially allocated with
g_malloc0() in bdrv_open_driver().

bdrv_snapshot_goto() needs to make sure that it is zeroed again before
calling drv->bdrv_open() to avoid that block drivers use stale values.

One symptom of this bug is VMDK running into a double free when the user
tries to apply an internal snapshot like 'qemu-img snapshot -a test
test.vmdk'. This should be a graceful error because VMDK doesn't support
internal snapshots.

==25507== Invalid free() / delete / delete[] / realloc()
==25507==    at 0x484B347: realloc (vg_replace_malloc.c:1801)
==25507==    by 0x54B592A: g_realloc (gmem.c:171)
==25507==    by 0x1B221D: vmdk_add_extent (../block/vmdk.c:570)
==25507==    by 0x1B1084: vmdk_open_sparse (../block/vmdk.c:1059)
==25507==    by 0x1AF3D8: vmdk_open (../block/vmdk.c:1371)
==25507==    by 0x1A2AE0: bdrv_snapshot_goto (../block/snapshot.c:299)
==25507==    by 0x205C77: img_snapshot (../qemu-img.c:3500)
==25507==    by 0x58FA087: (below main) (libc_start_call_main.h:58)
==25507==  Address 0x832f3e0 is 0 bytes inside a block of size 272 free'd
==25507==    at 0x4846B83: free (vg_replace_malloc.c:989)
==25507==    by 0x54AEAC4: g_free (gmem.c:208)
==25507==    by 0x1AF629: vmdk_close (../block/vmdk.c:2889)
==25507==    by 0x1A2A9C: bdrv_snapshot_goto (../block/snapshot.c:290)
==25507==    by 0x205C77: img_snapshot (../qemu-img.c:3500)
==25507==    by 0x58FA087: (below main) (libc_start_call_main.h:58)

This error was discovered by fuzzing qemu-img.

Cc: qemu-stable@nongnu.org
Reported-by: Denis Rastyogin <gerben@altlinux.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/snapshot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/snapshot.c b/block/snapshot.c
index 9c44780e96..22567f1fb9 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -296,6 +296,7 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
         bdrv_graph_wrunlock();
 
         ret = bdrv_snapshot_goto(fallback_bs, snapshot_id, errp);
+        memset(bs->opaque, 0, drv->instance_size);
         open_ret = drv->bdrv_open(bs, options, bs->open_flags, &local_err);
         qobject_unref(options);
         if (open_ret < 0) {
-- 
2.48.1


