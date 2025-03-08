Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A29C28B25
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 13:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tquga-0004pO-7J; Sat, 08 Mar 2025 08:57:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zoudongjie@huawei.com>)
 id 1tqrEt-0006s8-En; Sat, 08 Mar 2025 05:17:04 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zoudongjie@huawei.com>)
 id 1tqrEq-00005l-8v; Sat, 08 Mar 2025 05:17:03 -0500
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z8zVL1hqQz1ltXp;
 Sat,  8 Mar 2025 18:12:26 +0800 (CST)
Received: from kwepemk500007.china.huawei.com (unknown [7.202.194.92])
 by mail.maildlp.com (Postfix) with ESMTPS id 7E29D14011B;
 Sat,  8 Mar 2025 18:16:42 +0800 (CST)
Received: from huawei.com (10.246.99.19) by kwepemk500007.china.huawei.com
 (7.202.194.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 8 Mar
 2025 18:16:40 +0800
To: <zhuyangyang14@huawei.com>, <qemu-devel@nongnu.org>,
 <stefanha@redhat.com>, <fam@euphon.net>, <hreitz@redhat.com>,
 <qemu-block@nongnu.org>
CC: <qemu-stable@nongnu.org>, <luolongmin@huawei.com>,
 <suxiaodong1@huawei.com>, <wangyan122@huawei.com>, <yebiaoxiang@huawei.com>,
 <wangjian161@huawei.com>, <mujinsheng@huawei.com>, <alex.chen@huawei.com>,
 <eric.fangyi@huawei.com>, <zoudongjie@huawei.com>, <chenjianfei3@huawei.com>, 
 <renxuming@huawei.com>
Subject: [PATCH 0/2] qapi: Fix qmp_block_set_io_throttle blocked for too long
Date: Sat, 8 Mar 2025 18:16:16 +0800
Message-ID: <20250308101618.721954-1-zoudongjie@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.246.99.19]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk500007.china.huawei.com (7.202.194.92)
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zoudongjie@huawei.com; helo=szxga05-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 08 Mar 2025 08:57:17 -0500
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

In the disable branch of qmp_block_set_io_throttle(), we call bdrv_drained_begin().
We know that bdrv_drained_begin() is a blocking interface used to wait for all submitted
I/O operations to complete, i.e., to wait until bs->in_flight becomes zero.

Theoretically, once we stop submitting I/O operations, bs->in_flight should quickly
become zero(regardless of success or failure). However, if we are using network storage
and a network link failure occurs at that moment, things become different.
The underlying storage driver will then retry the operation, which may take 1 to 2 minutes
before responding with an I/O error to QEMU. As a result, bdrv_drained_begin() will be blocked
for 1 to 2 minutes, leading to two issues:

1. qmp_block_set_io_throttle() gets blocked, which is an external interface,
   and this can provide a poor user experience.
2. More seriously, qmp_block_set_io_throttle() holds the BQL during its execution, which could
lead to the blocking of vcpu thread, further causing guest os softlockup and potentially a panic.

The stack when qmp_block_set_io_throttle() is blocked is as follows:
At this point, there are no IO submit events or IO response events.
aio_poll() will remain blocked until the network storage reports an EIO to QEMU.

#0  0x00007f54877fc39e in ppoll () from target:/usr/lib64/libc.so.6
#1  0x0000556dced07b7d in ppoll (__ss=0x0, __timeout=0x0, __nfds=<optimized out>, __fds=<optimized out>) at /usr/include/bits/poll2.h:81
#2  0x0000556dcecee599 in fdmon_poll_wait (ctx=0x556de95f8e40, ready_list=0x7ffcc6378b18, timeout=-1) at ../util/fdmon-poll.c:79
#3  0x0000556dceceda9e in aio_poll (ctx=0x556de95f8e40, blocking=blocking@entry=true) at ../util/aio-posix.c:671
#4  0x0000556dcebe654a in bdrv_do_drained_begin (poll=<optimized out>, parent=0x0, bs=0x556de9896420) at ../block/io.c:378
#5  bdrv_do_drained_begin (bs=0x556de9896420, parent=0x0, poll=<optimized out>) at ../block/io.c:347
#6  0x0000556dcebdc5a1 in blk_io_limits_disable (blk=0x556dea739470) at ../block/block-backend.c:2701
#7  0x0000556dce917584 in qmp_block_set_io_throttle (arg=arg@entry=0x7ffcc6378d30, errp=errp@entry=0x7ffcc6378d18) at ../block/qapi-system.c:505
#8  0x0000556dcec5a8d2 in qmp_marshal_block_set_io_throttle (args=<optimized out>, ret=<optimized out>, errp=0x7f5486395ea0) at qapi/qapi-commands-block.c:368
#9  0x0000556dcece3ed9 in do_qmp_dispatch_bh (opaque=0x7f5486395eb0) at ../qapi/qmp-dispatch.c:128
#10 0x0000556dced03c55 in aio_bh_poll (ctx=ctx@entry=0x556de95e07c0) at ../util/async.c:219
#11 0x0000556dceced93e in aio_dispatch (ctx=0x556de95e07c0) at ../util/aio-posix.c:424
#12 0x0000556dced038fe in aio_ctx_dispatch (source=<optimized out>, callback=<optimized out>, user_data=<optimized out>) at ../util/async.c:361
#13 0x00007f5487ec606e in g_main_context_dispatch () from target:/usr/lib64/libglib-2.0.so.0
#14 0x0000556dced04fd8 in glib_pollfds_poll () at ../util/main-loop.c:287
#15 os_host_main_loop_wait (timeout=0) at ../util/main-loop.c:310
#16 main_loop_wait (nonblocking=nonblocking@entry=0) at ../util/main-loop.c:589
#17 0x0000556dce925431 in qemu_main_loop () at ../system/runstate.c:835
#18 0x0000556dcec565c7 in qemu_default_main (opaque=opaque@entry=0x0) at ../system/main.c:48
#19 0x0000556dce6f7848 in main (argc=<optimized out>, argv=<optimized out>) at ../system/main.c:76

Zhu Yangyang (2):
  io/block: Refactoring the bdrv_drained_begin() function and implement
    a timeout mechanism.
  qapi: Fix qmp_block_set_io_throttle blocked for too long

 block/block-backend.c                       | 14 ++++-
 block/io.c                                  | 55 +++++++++++++++----
 block/qapi-system.c                         |  7 ++-
 include/block/aio-wait.h                    | 58 +++++++++++++++++++++
 include/block/block-io.h                    |  7 +++
 include/system/block-backend-global-state.h |  1 +
 util/aio-wait.c                             |  7 +++
 7 files changed, 137 insertions(+), 12 deletions(-)

-- 
2.33.0


