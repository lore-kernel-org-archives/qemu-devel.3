Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4135AD2CE01
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 16:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3I4i-0000Zc-OJ; Tue, 22 Oct 2024 12:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3I4e-0000Qp-0s
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:49:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3I4c-00068J-Fl
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729615773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rMpQ5CTt7Zy94AtlruARh6XIoc4CG8eA88qWMFobVeo=;
 b=RaE3jx5WPmDAJAFxzImM8ZmCUduX5yHzfQKsLpyiFjhB3Nr2xtMdwt3wMBl0TPfRZjR4c9
 xeG7rU4hcMV8naXL3Ar99x/MKCPc8zg3lPmo7gyudbSmJTDTH9tU8z5tkAbhNUcvElBwOB
 auGNKKVm07RPuLd86qQckZNG0Js0Qz4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-H1zftW-UPXy4Rkr5c4Am8w-1; Tue,
 22 Oct 2024 12:49:32 -0400
X-MC-Unique: H1zftW-UPXy4Rkr5c4Am8w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA39E1956096; Tue, 22 Oct 2024 16:49:31 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.70])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 256091955E70; Tue, 22 Oct 2024 16:49:29 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 7/9] qapi: add qom-path to BLOCK_IO_ERROR event
Date: Tue, 22 Oct 2024 18:49:01 +0200
Message-ID: <20241022164903.282174-8-kwolf@redhat.com>
In-Reply-To: <20241022164903.282174-1-kwolf@redhat.com>
References: <20241022164903.282174-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

We need something more reliable than "device" (which absent in modern
interfaces) and "node-name" (which may absent, and actually don't
specify the device, which is a source of error) to make a per-device
throttling for the event in the following commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20241002151806.592469-2-vsementsov@yandex-team.ru>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json  |  7 +++++--
 block/block-backend.c | 21 +++++++++++++++++----
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 2feae8e697..fe63ba6cbf 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5584,6 +5584,8 @@
 #
 # Emitted when a disk I/O error occurs
 #
+# @qom-path: path to the device object in the QOM tree (since 9.2)
+#
 # @device: device name.  This is always present for compatibility
 #     reasons, but it can be empty ("") if the image does not have a
 #     device name associated.
@@ -5614,7 +5616,8 @@
 # .. qmp-example::
 #
 #     <- { "event": "BLOCK_IO_ERROR",
-#          "data": { "device": "ide0-hd1",
+#          "data": { "qom-path": "/machine/unattached/device[0]",
+#                    "device": "ide0-hd1",
 #                    "node-name": "#block212",
 #                    "operation": "write",
 #                    "action": "stop",
@@ -5622,7 +5625,7 @@
 #          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
 ##
 { 'event': 'BLOCK_IO_ERROR',
-  'data': { 'device': 'str', '*node-name': 'str',
+  'data': { 'qom-path': 'str', 'device': 'str', '*node-name': 'str',
             'operation': 'IoOperationType',
             'action': 'BlockErrorAction', '*nospace': 'bool',
             'reason': 'str' } }
diff --git a/block/block-backend.c b/block/block-backend.c
index 7bea43bf72..85bcdedcef 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1019,22 +1019,34 @@ DeviceState *blk_get_attached_dev(BlockBackend *blk)
     return blk->dev;
 }
 
-/* Return the qdev ID, or if no ID is assigned the QOM path, of the block
- * device attached to the BlockBackend. */
-char *blk_get_attached_dev_id(BlockBackend *blk)
+static char *blk_get_attached_dev_id_or_path(BlockBackend *blk, bool want_id)
 {
     DeviceState *dev = blk->dev;
     IO_CODE();
 
     if (!dev) {
         return g_strdup("");
-    } else if (dev->id) {
+    } else if (want_id && dev->id) {
         return g_strdup(dev->id);
     }
 
     return object_get_canonical_path(OBJECT(dev)) ?: g_strdup("");
 }
 
+/*
+ * Return the qdev ID, or if no ID is assigned the QOM path, of the block
+ * device attached to the BlockBackend.
+ */
+char *blk_get_attached_dev_id(BlockBackend *blk)
+{
+    return blk_get_attached_dev_id_or_path(blk, true);
+}
+
+static char *blk_get_attached_dev_path(BlockBackend *blk)
+{
+    return blk_get_attached_dev_id_or_path(blk, false);
+}
+
 /*
  * Return the BlockBackend which has the device model @dev attached if it
  * exists, else null.
@@ -2125,6 +2137,7 @@ static void send_qmp_error_event(BlockBackend *blk,
 
     optype = is_read ? IO_OPERATION_TYPE_READ : IO_OPERATION_TYPE_WRITE;
     qapi_event_send_block_io_error(blk_name(blk),
+                                   blk_get_attached_dev_path(blk),
                                    bs ? bdrv_get_node_name(bs) : NULL, optype,
                                    action, blk_iostatus_is_enabled(blk),
                                    error == ENOSPC, strerror(error));
-- 
2.47.0


