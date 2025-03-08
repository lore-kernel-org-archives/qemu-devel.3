Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773F5C35FF3
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 13:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqugK-0004NI-K7; Sat, 08 Mar 2025 08:57:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zoudongjie@huawei.com>)
 id 1tqrEv-0006sV-2d; Sat, 08 Mar 2025 05:17:05 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zoudongjie@huawei.com>)
 id 1tqrEq-000061-UK; Sat, 08 Mar 2025 05:17:04 -0500
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Z8zVN0cKrz1f01S;
 Sat,  8 Mar 2025 18:12:28 +0800 (CST)
Received: from kwepemk500007.china.huawei.com (unknown [7.202.194.92])
 by mail.maildlp.com (Postfix) with ESMTPS id 1DC911A0171;
 Sat,  8 Mar 2025 18:16:45 +0800 (CST)
Received: from huawei.com (10.246.99.19) by kwepemk500007.china.huawei.com
 (7.202.194.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 8 Mar
 2025 18:16:43 +0800
To: <zhuyangyang14@huawei.com>, <qemu-devel@nongnu.org>,
 <stefanha@redhat.com>, <fam@euphon.net>, <hreitz@redhat.com>,
 <qemu-block@nongnu.org>
CC: <qemu-stable@nongnu.org>, <luolongmin@huawei.com>,
 <suxiaodong1@huawei.com>, <wangyan122@huawei.com>, <yebiaoxiang@huawei.com>,
 <wangjian161@huawei.com>, <mujinsheng@huawei.com>, <alex.chen@huawei.com>,
 <eric.fangyi@huawei.com>, <zoudongjie@huawei.com>, <chenjianfei3@huawei.com>, 
 <renxuming@huawei.com>
Subject: [PATCH 2/2] qapi: Fix qmp_block_set_io_throttle blocked for too long
Date: Sat, 8 Mar 2025 18:16:18 +0800
Message-ID: <20250308101618.721954-3-zoudongjie@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250308101618.721954-1-zoudongjie@huawei.com>
References: <20250308101618.721954-1-zoudongjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.246.99.19]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk500007.china.huawei.com (7.202.194.92)
Received-SPF: pass client-ip=45.249.212.35; envelope-from=zoudongjie@huawei.com;
 helo=szxga07-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 08 Mar 2025 08:57:14 -0500
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

bdrv_drained_begin() is blocked for a long time when network storage is used
and the network link has just failed.
Therefore, the timeout period is set here.

Signed-off-by: Zhu Yangyang <zhuyangyang14@huawei.com>
---
 block/block-backend.c                       | 14 +++++++++++++-
 block/qapi-system.c                         |  7 ++++++-
 include/system/block-backend-global-state.h |  1 +
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 9288f7e1c6..409d4559c3 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2691,20 +2691,32 @@ void blk_set_io_limits(BlockBackend *blk, ThrottleConfig *cfg)
 }
 
 void blk_io_limits_disable(BlockBackend *blk)
+{
+    blk_io_limits_disable_timeout(blk, -1);
+}
+
+int blk_io_limits_disable_timeout(BlockBackend *blk, int64_t timeout_ms)
 {
     BlockDriverState *bs = blk_bs(blk);
     ThrottleGroupMember *tgm = &blk->public.throttle_group_member;
+    int ret = 0;
+
     assert(tgm->throttle_state);
     GLOBAL_STATE_CODE();
     if (bs) {
         bdrv_ref(bs);
-        bdrv_drained_begin(bs);
+        ret = bdrv_drained_begin_timeout(bs, timeout_ms);
+        if (ret < 0) {
+            goto out;
+        }
     }
     throttle_group_unregister_tgm(tgm);
+out:
     if (bs) {
         bdrv_drained_end(bs);
         bdrv_unref(bs);
     }
+    return ret;
 }
 
 /* should be called before blk_set_io_limits if a limit is set */
diff --git a/block/qapi-system.c b/block/qapi-system.c
index 54b7409b2b..96fa8e5e51 100644
--- a/block/qapi-system.c
+++ b/block/qapi-system.c
@@ -39,6 +39,8 @@
 #include "system/block-backend.h"
 #include "system/blockdev.h"
 
+#define QMP_BLOCKING_TIMEOUT 5000 /* ms */
+
 static BlockBackend *qmp_get_blk(const char *blk_name, const char *qdev_id,
                                  Error **errp)
 {
@@ -502,7 +504,10 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
         blk_set_io_limits(blk, &cfg);
     } else if (blk_get_public(blk)->throttle_group_member.throttle_state) {
         /* If all throttling settings are set to 0, disable I/O limits */
-        blk_io_limits_disable(blk);
+        if (blk_io_limits_disable_timeout(blk, QMP_BLOCKING_TIMEOUT) < 0) {
+            error_setg(errp, "Blk io limits disable timeout");
+            return;
+        }
     }
 }
 
diff --git a/include/system/block-backend-global-state.h b/include/system/block-backend-global-state.h
index 9cc9b008ec..e55ea9dc64 100644
--- a/include/system/block-backend-global-state.h
+++ b/include/system/block-backend-global-state.h
@@ -111,6 +111,7 @@ int blk_probe_geometry(BlockBackend *blk, HDGeometry *geo);
 
 void blk_set_io_limits(BlockBackend *blk, ThrottleConfig *cfg);
 void blk_io_limits_disable(BlockBackend *blk);
+int blk_io_limits_disable_timeout(BlockBackend *blk, int64_t timeout_ms);
 void blk_io_limits_enable(BlockBackend *blk, const char *group);
 void blk_io_limits_update_group(BlockBackend *blk, const char *group);
 void blk_set_force_allow_inactivate(BlockBackend *blk);
-- 
2.33.0


