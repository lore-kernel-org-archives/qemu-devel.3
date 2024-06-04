Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A88C27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 12:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sET3p-0003ic-5P; Tue, 04 Jun 2024 08:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1sET3l-0003gK-EO
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 08:14:37 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1sET3h-0006wG-6p
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 08:14:36 -0400
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VtqDH0l8gzxRTf;
 Tue,  4 Jun 2024 20:10:23 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
 by mail.maildlp.com (Postfix) with ESMTPS id CF78D180085;
 Tue,  4 Jun 2024 20:14:18 +0800 (CST)
Received: from DESKTOP-8LI8G6S.china.huawei.com (10.173.124.235) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Jun 2024 20:14:18 +0800
To: <qemu-devel@nongnu.org>
CC: <peterx@redhat.com>, <yu.zhang@ionos.com>, <mgalaxy@akamai.com>,
 <elmar.gerdes@ionos.com>, <zhengchuan@huawei.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <lizhijian@fujitsu.com>, <pbonzini@redhat.com>,
 <mst@redhat.com>, <xiexiangyou@huawei.com>, <linux-rdma@vger.kernel.org>,
 <lixiao91@huawei.com>, <arei.gonglei@huawei.com>, <jinpu.wang@ionos.com>,
 Jialin Wang <wangjialin23@huawei.com>
Subject: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Date: Tue, 4 Jun 2024 20:14:06 +0800
Message-ID: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
X-Mailer: git-send-email 2.8.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.124.235]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=arei.gonglei@huawei.com; helo=szxga01-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Gonglei <arei.gonglei@huawei.com>
From:  Gonglei via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jialin Wang <wangjialin23@huawei.com>

Hi,

This patch series attempts to refactor RDMA live migration by
introducing a new QIOChannelRDMA class based on the rsocket API.

The /usr/include/rdma/rsocket.h provides a higher level rsocket API
that is a 1-1 match of the normal kernel 'sockets' API, which hides the
detail of rdma protocol into rsocket and allows us to add support for
some modern features like multifd more easily.

Here is the previous discussion on refactoring RDMA live migration using
the rsocket API:

https://lore.kernel.org/qemu-devel/20240328130255.52257-1-philmd@linaro.org/

We have encountered some bugs when using rsocket and plan to submit them to
the rdma-core community.

In addition, the use of rsocket makes our programming more convenient,
but it must be noted that this method introduces multiple memory copies,
which can be imagined that there will be a certain performance degradation,
hoping that friends with RDMA network cards can help verify, thank you!

Jialin Wang (6):
  migration: remove RDMA live migration temporarily
  io: add QIOChannelRDMA class
  io/channel-rdma: support working in coroutine
  tests/unit: add test-io-channel-rdma.c
  migration: introduce new RDMA live migration
  migration/rdma: support multifd for RDMA migration

 docs/rdma.txt                     |  420 ---
 include/io/channel-rdma.h         |  165 ++
 io/channel-rdma.c                 |  798 ++++++
 io/meson.build                    |    1 +
 io/trace-events                   |   14 +
 meson.build                       |    6 -
 migration/meson.build             |    3 +-
 migration/migration-stats.c       |    5 +-
 migration/migration-stats.h       |    4 -
 migration/migration.c             |   13 +-
 migration/migration.h             |    9 -
 migration/multifd.c               |   10 +
 migration/options.c               |   16 -
 migration/options.h               |    2 -
 migration/qemu-file.c             |    1 -
 migration/ram.c                   |   90 +-
 migration/rdma.c                  | 4205 +----------------------------
 migration/rdma.h                  |   67 +-
 migration/savevm.c                |    2 +-
 migration/trace-events            |   68 +-
 qapi/migration.json               |   13 +-
 scripts/analyze-migration.py      |    3 -
 tests/unit/meson.build            |    1 +
 tests/unit/test-io-channel-rdma.c |  276 ++
 24 files changed, 1360 insertions(+), 4832 deletions(-)
 delete mode 100644 docs/rdma.txt
 create mode 100644 include/io/channel-rdma.h
 create mode 100644 io/channel-rdma.c
 create mode 100644 tests/unit/test-io-channel-rdma.c

-- 
2.43.0


