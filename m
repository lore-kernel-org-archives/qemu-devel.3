Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940F9C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWNv-0006iA-8y; Mon, 10 Feb 2025 11:11:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWNL-0006Th-Dr
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWNF-0000yD-2Y
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739203861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S/S5lmaKswLBSshRUt/WkDc1HX2POn1fCwhrBtuWa78=;
 b=ZWwCAJYwMLHk3rEAe0qibo8Iwf0q4DbaaN2CRbG/WcSH/EDWm0bPdzaIW5NZKqkHvu6pb0
 tZwas05ux44BtzTt6vZ/DmWNfGhmissqA10Thfe9ectDvJ5lz9llbj99jhRanh45TJVH8I
 mgaqGviQBmBST6PQMJsW4PvQLwgIM7Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-qtVvUXz_NrWG0yfrhcUy8w-1; Mon,
 10 Feb 2025 11:11:00 -0500
X-MC-Unique: qtVvUXz_NrWG0yfrhcUy8w-1
X-Mimecast-MFC-AGG-ID: qtVvUXz_NrWG0yfrhcUy8w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 364B4180087B; Mon, 10 Feb 2025 16:10:59 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.225.156])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E5E15195608D; Mon, 10 Feb 2025 16:10:57 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 04/25] block: Fix leak in send_qmp_error_event
Date: Mon, 10 Feb 2025 17:10:13 +0100
Message-ID: <20250210161034.76494-5-kwolf@redhat.com>
In-Reply-To: <20250210161034.76494-1-kwolf@redhat.com>
References: <20250210161034.76494-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
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

From: Fabiano Rosas <farosas@suse.de>

ASAN detected a leak when running the ahci-test
/ahci/io/dma/lba28/retry:

Direct leak of 35 byte(s) in 1 object(s) allocated from:
    #0 in malloc
    #1 in __vasprintf_internal
    #2 in vasprintf
    #3 in g_vasprintf
    #4 in g_strdup_vprintf
    #5 in g_strdup_printf
    #6 in object_get_canonical_path ../qom/object.c:2096:19
    #7 in blk_get_attached_dev_id_or_path ../block/block-backend.c:1033:12
    #8 in blk_get_attached_dev_path ../block/block-backend.c:1047:12
    #9 in send_qmp_error_event ../block/block-backend.c:2140:36
    #10 in blk_error_action ../block/block-backend.c:2172:9
    #11 in ide_handle_rw_error ../hw/ide/core.c:875:5
    #12 in ide_dma_cb ../hw/ide/core.c:894:13
    #13 in dma_complete ../system/dma-helpers.c:107:9
    #14 in dma_blk_cb ../system/dma-helpers.c:129:9
    #15 in blk_aio_complete ../block/block-backend.c:1552:9
    #16 in blk_aio_write_entry ../block/block-backend.c:1619:5
    #17 in coroutine_trampoline ../util/coroutine-ucontext.c:175:9

Plug the leak by freeing the device path string.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241111145214.8261-1-farosas@suse.de>
[PMD: Use g_autofree]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241111170333.43833-3-philmd@linaro.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/block-backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 789fc6d4ea..b610582644 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2138,10 +2138,10 @@ static void send_qmp_error_event(BlockBackend *blk,
 {
     IoOperationType optype;
     BlockDriverState *bs = blk_bs(blk);
+    g_autofree char *path = blk_get_attached_dev_path(blk);
 
     optype = is_read ? IO_OPERATION_TYPE_READ : IO_OPERATION_TYPE_WRITE;
-    qapi_event_send_block_io_error(blk_name(blk),
-                                   blk_get_attached_dev_path(blk),
+    qapi_event_send_block_io_error(blk_name(blk), path,
                                    bs ? bdrv_get_node_name(bs) : NULL, optype,
                                    action, blk_iostatus_is_enabled(blk),
                                    error == ENOSPC, strerror(error));
-- 
2.48.1


