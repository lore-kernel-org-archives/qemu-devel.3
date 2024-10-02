Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73035CF6D2D
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 15:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw17i-0005kN-Ie; Wed, 02 Oct 2024 11:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sw17b-0005in-Hp; Wed, 02 Oct 2024 11:18:36 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sw17Y-0004pu-24; Wed, 02 Oct 2024 11:18:35 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:1301:0:640:a2b5:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id C609760D30;
 Wed,  2 Oct 2024 18:18:27 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:8026::1:2f])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 7IdRVm1IaeA0-rsO9gE16; Wed, 02 Oct 2024 18:18:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1727882307;
 bh=RHDSD3U4nA/3Sd5wOiK3cqtvM+3ZOtb10Qlpw51um1g=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=QGf3k9oFDnOistf4ku2AWtp1JG0ZDi/q7UcmYyhRL/2S4ZS5kkBRxy8uBfFa+9Wt8
 YjooAiWhAnKHOPAm5RtfARx2mL6nH8vY4yfL/5F9MNPntl3GarI8W2alykVG0sDAxj
 enk405iVV9z2noYkW8nm3b/3JJIek3UZFc5c0kGE=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com,
 dave@treblig.org, hreitz@redhat.com, kwolf@redhat.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v3 1/2] qapi: add qom-path to BLOCK_IO_ERROR event
Date: Wed,  2 Oct 2024 18:18:05 +0300
Message-Id: <20241002151806.592469-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002151806.592469-1-vsementsov@yandex-team.ru>
References: <20241002151806.592469-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We need something more reliable than "device" (which absent in modern
interfaces) and "node-name" (which may absent, and actually don't
specify the device, which is a source of error) to make a per-device
throttling for the event in the following commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/block-backend.c | 21 +++++++++++++++++----
 qapi/block-core.json  |  7 +++++--
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index db6f9b92a3..9b70f44aec 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1028,22 +1028,34 @@ DeviceState *blk_get_attached_dev(BlockBackend *blk)
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
@@ -2140,6 +2152,7 @@ static void send_qmp_error_event(BlockBackend *blk,
 
     optype = is_read ? IO_OPERATION_TYPE_READ : IO_OPERATION_TYPE_WRITE;
     qapi_event_send_block_io_error(blk_name(blk),
+                                   blk_get_attached_dev_path(blk),
                                    bs ? bdrv_get_node_name(bs) : NULL, optype,
                                    action, blk_iostatus_is_enabled(blk),
                                    error == ENOSPC, strerror(error));
diff --git a/qapi/block-core.json b/qapi/block-core.json
index c3b0a2376b..b3743022be 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5580,6 +5580,8 @@
 #
 # Emitted when a disk I/O error occurs
 #
+# @qom-path: path to the device object in the QOM tree (since 9.2)
+#
 # @device: device name.  This is always present for compatibility
 #     reasons, but it can be empty ("") if the image does not have a
 #     device name associated.
@@ -5610,7 +5612,8 @@
 # .. qmp-example::
 #
 #     <- { "event": "BLOCK_IO_ERROR",
-#          "data": { "device": "ide0-hd1",
+#          "data": { "qom-path": "/machine/unattached/device[0]",
+#                    "device": "ide0-hd1",
 #                    "node-name": "#block212",
 #                    "operation": "write",
 #                    "action": "stop",
@@ -5618,7 +5621,7 @@
 #          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
 ##
 { 'event': 'BLOCK_IO_ERROR',
-  'data': { 'device': 'str', '*node-name': 'str',
+  'data': { 'qom-path': 'str', 'device': 'str', '*node-name': 'str',
             'operation': 'IoOperationType',
             'action': 'BlockErrorAction', '*nospace': 'bool',
             'reason': 'str' } }
-- 
2.34.1


