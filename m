Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03810CD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 12:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrGky-0006VF-QY; Mon, 01 Apr 2024 08:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhuyangyang14@huawei.com>)
 id 1rrGkv-0006UW-Hn; Mon, 01 Apr 2024 08:27:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhuyangyang14@huawei.com>)
 id 1rrGks-0007iV-LD; Mon, 01 Apr 2024 08:27:17 -0400
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4V7Vc558KYz1wplv;
 Mon,  1 Apr 2024 20:26:13 +0800 (CST)
Received: from dggpeml500011.china.huawei.com (unknown [7.185.36.84])
 by mail.maildlp.com (Postfix) with ESMTPS id 40FA51402CA;
 Mon,  1 Apr 2024 20:27:05 +0800 (CST)
Received: from huawei.com (10.91.158.201) by dggpeml500011.china.huawei.com
 (7.185.36.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 1 Apr
 2024 20:27:04 +0800
To: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
CC: <qemu-block@nongnu.org>, <qemu-devel@nongnu.org>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, <kwolf@redhat.com>,
 <luolongmin@huawei.com>, <suxiaodong1@huawei.com>, <chenxiaoyu48@huawei.com>, 
 <wangyan122@huawei.com>, <yebiaoxiang@huawei.com>, <zhuyangyang14@huawei.com>
Subject: [PATCH v2 0/1] coroutine: avoid inserting duplicate coroutine to
 co_queue_wakeup
Date: Mon, 1 Apr 2024 20:33:42 +0800
Message-ID: <20240401123342.3947762-1-zhuyangyang14@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.91.158.201]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500011.china.huawei.com (7.185.36.84)
Received-SPF: pass client-ip=45.249.212.32;
 envelope-from=zhuyangyang14@huawei.com; helo=szxga06-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Zhu Yangyang <zhuyangyang14@huawei.com>
From:  Zhu Yangyang via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The problem that inserting duplicate coroutine to co_queue_wakeu has been
resolved by 7c1f51bf38 ("nbd/server: Fix drained_poll to wake coroutine
in right AioContext") that avoids repeatedly waking up the same coroutine.

The key modifications are as follows:

static void qio_channel_restart_read(void *opaque)
{
    QIOChannel *ioc = opaque;
-   Coroutine *co = ioc->read_coroutine;
+   Coroutine *co = qatomic_xchg(&ioc->read_coroutine, NULL);
+
+   if (!co) {
+       return;
+   }

    /* Assert that aio_co_wake() reenters the coroutine directly */
    assert(qemu_get_current_aio_context() ==
           qemu_coroutine_get_aio_context(co));
    aio_co_wake(co);
}

The root cause is that poll() is invoked in coroutine context, so fix it.

Changes in v2:
Drop the changes to aio_co_enter and instead fix the poll() call in the nbd/server.

Zhu Yangyang (1):
  nbd/server: do not poll within a coroutine context

 nbd/client.c       |  7 ++++---
 nbd/common.c       | 19 ++++++++++++++++---
 nbd/nbd-internal.h |  6 +++---
 nbd/server.c       | 10 +++++-----
 4 files changed, 28 insertions(+), 14 deletions(-)

-- 
2.33.0


