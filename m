Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717E1C35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 07:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvWXO-0003QI-2r; Fri, 21 Mar 2025 03:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zoudongjie@huawei.com>)
 id 1tvWX0-0003MY-KQ; Fri, 21 Mar 2025 03:11:02 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zoudongjie@huawei.com>)
 id 1tvWWy-0007tt-0I; Fri, 21 Mar 2025 03:11:02 -0400
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZJtq16MJ3ztR74;
 Fri, 21 Mar 2025 15:09:17 +0800 (CST)
Received: from kwepemk500007.china.huawei.com (unknown [7.202.194.92])
 by mail.maildlp.com (Postfix) with ESMTPS id 66399140135;
 Fri, 21 Mar 2025 15:10:45 +0800 (CST)
Received: from huawei.com (10.246.99.19) by kwepemk500007.china.huawei.com
 (7.202.194.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 21 Mar
 2025 15:10:43 +0800
To: <qemu-devel@nongnu.org>
CC: <stefanha@redhat.com>, <kwolf@redhat.com>, <fam@euphon.net>,
 <hreitz@redhat.com>, <alex.chen@huawei.com>, <chenjianfei3@huawei.com>,
 <eric.fangyi@huawei.com>, <luolongmin@huawei.com>, <mujinsheng@huawei.com>,
 <qemu-block@nongnu.org>, <qemu-stable@nongnu.org>, <renxuming@huawei.com>,
 <suxiaodong1@huawei.com>, <wangjian161@huawei.com>, <wangyan122@huawei.com>,
 <yebiaoxiang@huawei.com>, <zhuyangyang14@huawei.com>, <zoudongjie@huawei.com>
Subject: [PATCH v2 0/2] qapi/throttle: Fix qmp_block_set_io_throttle blocked
 for too long
Date: Fri, 21 Mar 2025 15:09:15 +0800
Message-ID: <20250321070917.2889854-1-zoudongjie@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.246.99.19]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk500007.china.huawei.com (7.202.194.92)
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=zoudongjie@huawei.com; helo=szxga02-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

First of all, thanks to Stefan Hajnoczi for his suggestions,
I made the following changes in this patch:

  1. Support 0 in BDRV_POLL_WHILE_TIMEOUT(), 0 means infinite.
  2. Use uint64_t timeout_ns instead of int64 timeout to name variables.
  3. Use timer_pending() to check for expiry instead of explicitly checking
     against the deadline for BDRV_POLL_WHILE_TIMEOUT().
  4. Add documentation for bdrv_drained_begin_timeout(), note that bdrv_drained_end()
     must be called when -ETIMEDOUT is returned.
  5. Add a timeout parameter to the qmp_block_set_io_throttle() instead of hardcoding
     the timeout, and the default value is 0, mean an infinite timeout.

v1 patch link:
https://lore.kernel.org/qemu-devel/20250308101618.721954-1-zoudongjie@huawei.com/

Zhu Yangyang (2):
  io/block: Refactoring the bdrv_drained_begin() function and implement
    a timeout mechanism.
  qapi/throttle: add timeout parameter for qmp_block_set_io_throttle()

 block/block-backend.c                       | 14 ++++-
 block/io.c                                  | 58 +++++++++++++++++----
 block/qapi-system.c                         | 10 +++-
 include/block/aio-wait.h                    | 49 +++++++++++++++++
 include/block/block-io.h                    | 22 +++++++-
 include/system/block-backend-global-state.h |  1 +
 qapi/block-core.json                        |  5 +-
 util/aio-wait.c                             |  5 ++
 8 files changed, 150 insertions(+), 14 deletions(-)

-- 
2.33.0


