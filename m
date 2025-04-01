Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A7DC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbIr-0005ji-H9; Tue, 01 Apr 2025 09:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zoudongjie@huawei.com>)
 id 1tzbIY-0005Wc-2R; Tue, 01 Apr 2025 09:04:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zoudongjie@huawei.com>)
 id 1tzbIT-0008CE-3T; Tue, 01 Apr 2025 09:04:56 -0400
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZRp4X68Lrz1f1XG;
 Tue,  1 Apr 2025 20:59:56 +0800 (CST)
Received: from kwepemk500007.china.huawei.com (unknown [7.202.194.92])
 by mail.maildlp.com (Postfix) with ESMTPS id 9A19F1402C7;
 Tue,  1 Apr 2025 21:04:44 +0800 (CST)
Received: from huawei.com (10.246.99.19) by kwepemk500007.china.huawei.com
 (7.202.194.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 1 Apr
 2025 21:04:43 +0800
To: <qemu-devel@nongnu.org>
CC: <armbru@redhat.com>, <alex.chen@huawei.com>, <chenjianfei3@huawei.com>,
 <eric.fangyi@huawei.com>, <fam@euphon.net>, <hreitz@redhat.com>,
 <kwolf@redhat.com>, <luolongmin@huawei.com>, <mujinsheng@huawei.com>,
 <qemu-block@nongnu.org>, <qemu-stable@nongnu.org>, <renxuming@huawei.com>,
 <stefanha@redhat.com>, <suxiaodong1@huawei.com>, <wangjian161@huawei.com>,
 <wangyan122@huawei.com>, <yebiaoxiang@huawei.com>,
 <zhuyangyang14@huawei.com>, <zoudongjie@huawei.com>
Subject: [PATCH v4 3/3] qapi/resize: add timeout parameter for
 qmp_block_resize()
Date: Tue, 1 Apr 2025 21:03:00 +0800
Message-ID: <20250401130300.1457584-4-zoudongjie@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250401130300.1457584-1-zoudongjie@huawei.com>
References: <20250401130300.1457584-1-zoudongjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.246.99.19]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemk500007.china.huawei.com (7.202.194.92)
Received-SPF: pass client-ip=45.249.212.35; envelope-from=zoudongjie@huawei.com;
 helo=szxga07-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  zoudongjie <zoudongjie@huawei.com>
From:  zoudongjie via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Zhu Yangyang <zhuyangyang14@huawei.com>

Calling qmp_block_resize() will be blocked for a long time on bdrv_drained_begin()
when a network disk is configured and the network failure is just about
to occur.

Therefore, we add a timeout parameter for qmp_block_resize() to control its
execution duration.

The default value of timeout is 0, that is infinite wait, consistent with
previous behavior.

Signed-off-by: Zhu Yangyang <zhuyangyang14@huawei.com>
---
 block/monitor/block-hmp-cmds.c |  2 +-
 blockdev.c                     | 16 ++++++++++++++--
 qapi/block-core.json           |  6 +++++-
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 6919a49bf5..c24574d950 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -486,7 +486,7 @@ void coroutine_fn hmp_block_resize(Monitor *mon, const QDict *qdict)
     int64_t size = qdict_get_int(qdict, "size");
     Error *err = NULL;
 
-    qmp_block_resize(device, NULL, size, &err);
+    qmp_block_resize(device, NULL, size, false, 0, &err);
     hmp_handle_error(mon, err);
 }
 
diff --git a/blockdev.c b/blockdev.c
index 1d1f27cfff..d1314f4e2a 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2252,12 +2252,15 @@ BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(const char *node,
 }
 
 void coroutine_fn qmp_block_resize(const char *device, const char *node_name,
-                                   int64_t size, Error **errp)
+                                   int64_t size,
+                                   bool has_timeout, uint32_t timeout,
+                                   Error **errp)
 {
     Error *local_err = NULL;
     BlockBackend *blk;
     BlockDriverState *bs;
     AioContext *old_ctx;
+    uint64_t timeout_ns;
 
     bs = bdrv_lookup_bs(device, node_name, &local_err);
     if (local_err) {
@@ -2282,12 +2285,21 @@ void coroutine_fn qmp_block_resize(const char *device, const char *node_name,
         return;
     }
 
-    bdrv_drained_begin(bs);
+    /* Default is 0, that means infinite */
+    timeout_ns = 0;
+    if (has_timeout) {
+        timeout_ns = timeout * NANOSECONDS_PER_SECOND;
+    }
+    if (bdrv_drained_begin_timeout(bs, timeout_ns) < 0) {
+        error_setg(errp, "command timed out");
+        goto out;
+    }
 
     old_ctx = bdrv_co_enter(bs);
     blk_co_truncate(blk, size, false, PREALLOC_MODE_OFF, 0, errp);
     bdrv_co_leave(bs, old_ctx);
 
+out:
     bdrv_drained_end(bs);
     blk_co_unref(blk);
 }
diff --git a/qapi/block-core.json b/qapi/block-core.json
index a75ff1cb0c..2ddff59835 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1460,6 +1460,9 @@
 #
 # @size: new image size in bytes
 #
+# @timeout: In seconds. Timeout for block_resize,
+#     0 means no limit. Defaults to 0. (Since 10.1)
+#
 # Errors:
 #     - If @device is not a valid block device, DeviceNotFound
 #
@@ -1474,7 +1477,8 @@
 { 'command': 'block_resize',
   'data': { '*device': 'str',
             '*node-name': 'str',
-            'size': 'int' },
+            'size': 'int',
+            '*timeout': 'uint32' },
   'coroutine': true,
   'allow-preconfig': true }
 
-- 
2.33.0


