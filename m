Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D282DC35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 07:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvWXT-0003QM-S8; Fri, 21 Mar 2025 03:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zoudongjie@huawei.com>)
 id 1tvWX0-0003Ma-Rx; Fri, 21 Mar 2025 03:11:03 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zoudongjie@huawei.com>)
 id 1tvWWy-000833-8Q; Fri, 21 Mar 2025 03:11:02 -0400
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZJtmF2ngfzvWr0;
 Fri, 21 Mar 2025 15:06:53 +0800 (CST)
Received: from kwepemk500007.china.huawei.com (unknown [7.202.194.92])
 by mail.maildlp.com (Postfix) with ESMTPS id DE2F21800B3;
 Fri, 21 Mar 2025 15:10:47 +0800 (CST)
Received: from huawei.com (10.246.99.19) by kwepemk500007.china.huawei.com
 (7.202.194.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 21 Mar
 2025 15:10:46 +0800
To: <qemu-devel@nongnu.org>
CC: <stefanha@redhat.com>, <kwolf@redhat.com>, <fam@euphon.net>,
 <hreitz@redhat.com>, <alex.chen@huawei.com>, <chenjianfei3@huawei.com>,
 <eric.fangyi@huawei.com>, <luolongmin@huawei.com>, <mujinsheng@huawei.com>,
 <qemu-block@nongnu.org>, <qemu-stable@nongnu.org>, <renxuming@huawei.com>,
 <suxiaodong1@huawei.com>, <wangjian161@huawei.com>, <wangyan122@huawei.com>,
 <yebiaoxiang@huawei.com>, <zhuyangyang14@huawei.com>, <zoudongjie@huawei.com>
Subject: [PATCH v2 2/2] qapi/throttle: add timeout parameter for
 qmp_block_set_io_throttle()
Date: Fri, 21 Mar 2025 15:09:17 +0800
Message-ID: <20250321070917.2889854-3-zoudongjie@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250321070917.2889854-1-zoudongjie@huawei.com>
References: <20250321070917.2889854-1-zoudongjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.246.99.19]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk500007.china.huawei.com (7.202.194.92)
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=zoudongjie@huawei.com; helo=szxga01-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-to:  zoudongjie <zoudongjie@huawei.com>
From:  zoudongjie via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Zhu Yangyang <zhuyangyang14@huawei.com>

Calling qmp_block_set_io_throttle() will be blocked for a long time
when a network disk is configured and the network failure is just about
to occur.

Therefore, we add a timeout parameter for qmp_block_set_io_throttle to control
its execution duration.

The default value of timeout is 0, that is infinite wait, consistent with
previous behavior.

Signed-off-by: Zhu Yangyang <zhuyangyang14@huawei.com>
---
 block/block-backend.c                       | 14 +++++++++++++-
 block/qapi-system.c                         | 10 +++++++++-
 include/system/block-backend-global-state.h |  1 +
 qapi/block-core.json                        |  5 ++++-
 4 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index a402db13f2..fc1554ea55 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2679,20 +2679,32 @@ void blk_set_io_limits(BlockBackend *blk, ThrottleConfig *cfg)
 }
 
 void blk_io_limits_disable(BlockBackend *blk)
+{
+    blk_io_limits_disable_timeout(blk, 0);
+}
+
+int blk_io_limits_disable_timeout(BlockBackend *blk, uint64_t timeout_ns)
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
+        ret = bdrv_drained_begin_timeout(bs, timeout_ns);
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
index 54b7409b2b..3b7ba0959c 100644
--- a/block/qapi-system.c
+++ b/block/qapi-system.c
@@ -423,6 +423,7 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
     ThrottleConfig cfg;
     BlockDriverState *bs;
     BlockBackend *blk;
+    uint64_t timeout_ns;
 
     blk = qmp_get_blk(arg->device, arg->id, errp);
     if (!blk) {
@@ -444,6 +445,10 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
     cfg.buckets[THROTTLE_OPS_READ].avg  = arg->iops_rd;
     cfg.buckets[THROTTLE_OPS_WRITE].avg = arg->iops_wr;
 
+    timeout_ns = 0; /* 0 means infinite */
+    if (arg->has_timeout) {
+        timeout_ns = arg->timeout * NANOSECONDS_PER_SECOND;
+    }
     if (arg->has_bps_max) {
         cfg.buckets[THROTTLE_BPS_TOTAL].max = arg->bps_max;
     }
@@ -502,7 +507,10 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
         blk_set_io_limits(blk, &cfg);
     } else if (blk_get_public(blk)->throttle_group_member.throttle_state) {
         /* If all throttling settings are set to 0, disable I/O limits */
-        blk_io_limits_disable(blk);
+        if (blk_io_limits_disable_timeout(blk, timeout_ns) < 0) {
+            error_setg(errp, "Blk io limits disable timeout");
+            return;
+        }
     }
 }
 
diff --git a/include/system/block-backend-global-state.h b/include/system/block-backend-global-state.h
index 35b5e8380b..8a2a6cbda4 100644
--- a/include/system/block-backend-global-state.h
+++ b/include/system/block-backend-global-state.h
@@ -110,6 +110,7 @@ int blk_probe_geometry(BlockBackend *blk, HDGeometry *geo);
 
 void blk_set_io_limits(BlockBackend *blk, ThrottleConfig *cfg);
 void blk_io_limits_disable(BlockBackend *blk);
+int blk_io_limits_disable_timeout(BlockBackend *blk, uint64_t timeout_ns);
 void blk_io_limits_enable(BlockBackend *blk, const char *group);
 void blk_io_limits_update_group(BlockBackend *blk, const char *group);
 void blk_set_force_allow_inactivate(BlockBackend *blk);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index b1937780e1..88ef593efd 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2626,6 +2626,9 @@
 #
 # @group: throttle group name (Since 2.4)
 #
+# @timeout: In seconds. Timeout for block_set_io_throttle,
+#     0 means no limit. Defaults to 0. (Since 10.0)
+#
 # Features:
 #
 # @deprecated: Member @device is deprecated.  Use @id instead.
@@ -2642,7 +2645,7 @@
             '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
             '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
             '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
-            '*iops_size': 'int', '*group': 'str' } }
+            '*iops_size': 'int', '*group': 'str', '*timeout': 'uint32'} }
 
 ##
 # @ThrottleLimits:
-- 
2.33.0


