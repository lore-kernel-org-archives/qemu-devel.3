Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1D0C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 10:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEnRr-0001BP-Bj; Wed, 05 Jun 2024 06:00:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1sEnRa-0000yY-1t
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 06:00:34 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1sEnRW-00047W-2B
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 06:00:33 -0400
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VvNBb4K1mzmY1p;
 Wed,  5 Jun 2024 17:55:51 +0800 (CST)
Received: from dggpeml100007.china.huawei.com (unknown [7.185.36.28])
 by mail.maildlp.com (Postfix) with ESMTPS id BB3E9180069;
 Wed,  5 Jun 2024 18:00:24 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (7.185.36.61) by
 dggpeml100007.china.huawei.com (7.185.36.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 18:00:24 +0800
Received: from dggpemf200006.china.huawei.com ([7.185.36.61]) by
 dggpemf200006.china.huawei.com ([7.185.36.61]) with mapi id 15.02.1544.011;
 Wed, 5 Jun 2024 18:00:24 +0800
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peterx@redhat.com"
 <peterx@redhat.com>, "yu.zhang@ionos.com" <yu.zhang@ionos.com>,
 "mgalaxy@akamai.com" <mgalaxy@akamai.com>, "elmar.gerdes@ionos.com"
 <elmar.gerdes@ionos.com>, zhengchuan <zhengchuan@huawei.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "armbru@redhat.com"
 <armbru@redhat.com>, "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, Xiexiangyou
 <xiexiangyou@huawei.com>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "lixiao (H)" <lixiao91@huawei.com>,
 "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>, Wangjialin
 <wangjialin23@huawei.com>
Subject: RE: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Thread-Topic: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Thread-Index: AQHatni5B+Psi4bf8k2CmAL8rvKhtrG4SOsAgACn7MA=
Date: Wed, 5 Jun 2024 10:00:24 +0000
Message-ID: <e39d065823da4ef9beb5b37c17c9a990@huawei.com>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <20240605035622-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240605035622-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.124.235]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=arei.gonglei@huawei.com; helo=szxga02-in.huawei.com
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
Reply-to:  "Gonglei (Arei)" <arei.gonglei@huawei.com>
From:  "Gonglei (Arei)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Wednesday, June 5, 2024 3:57 PM
> To: Gonglei (Arei) <arei.gonglei@huawei.com>
> Cc: qemu-devel@nongnu.org; peterx@redhat.com; yu.zhang@ionos.com;
> mgalaxy@akamai.com; elmar.gerdes@ionos.com; zhengchuan
> <zhengchuan@huawei.com>; berrange@redhat.com; armbru@redhat.com;
> lizhijian@fujitsu.com; pbonzini@redhat.com; Xiexiangyou
> <xiexiangyou@huawei.com>; linux-rdma@vger.kernel.org; lixiao (H)
> <lixiao91@huawei.com>; jinpu.wang@ionos.com; Wangjialin
> <wangjialin23@huawei.com>
> Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket AP=
I
>=20
> On Tue, Jun 04, 2024 at 08:14:06PM +0800, Gonglei wrote:
> > From: Jialin Wang <wangjialin23@huawei.com>
> >
> > Hi,
> >
> > This patch series attempts to refactor RDMA live migration by
> > introducing a new QIOChannelRDMA class based on the rsocket API.
> >
> > The /usr/include/rdma/rsocket.h provides a higher level rsocket API
> > that is a 1-1 match of the normal kernel 'sockets' API, which hides
> > the detail of rdma protocol into rsocket and allows us to add support
> > for some modern features like multifd more easily.
> >
> > Here is the previous discussion on refactoring RDMA live migration
> > using the rsocket API:
> >
> > https://lore.kernel.org/qemu-devel/20240328130255.52257-1-philmd@linar
> > o.org/
> >
> > We have encountered some bugs when using rsocket and plan to submit
> > them to the rdma-core community.
> >
> > In addition, the use of rsocket makes our programming more convenient,
> > but it must be noted that this method introduces multiple memory
> > copies, which can be imagined that there will be a certain performance
> > degradation, hoping that friends with RDMA network cards can help verif=
y,
> thank you!
>=20
> So you didn't test it with an RDMA card?

Yep, we tested it by Soft-ROCE.

> You really should test with an RDMA card though, for correctness as much =
as
> performance.
>=20
We will, we just don't have RDMA cards environment on hand at the moment.

Regards,
-Gonglei

>=20
> > Jialin Wang (6):
> >   migration: remove RDMA live migration temporarily
> >   io: add QIOChannelRDMA class
> >   io/channel-rdma: support working in coroutine
> >   tests/unit: add test-io-channel-rdma.c
> >   migration: introduce new RDMA live migration
> >   migration/rdma: support multifd for RDMA migration
> >
> >  docs/rdma.txt                     |  420 ---
> >  include/io/channel-rdma.h         |  165 ++
> >  io/channel-rdma.c                 |  798 ++++++
> >  io/meson.build                    |    1 +
> >  io/trace-events                   |   14 +
> >  meson.build                       |    6 -
> >  migration/meson.build             |    3 +-
> >  migration/migration-stats.c       |    5 +-
> >  migration/migration-stats.h       |    4 -
> >  migration/migration.c             |   13 +-
> >  migration/migration.h             |    9 -
> >  migration/multifd.c               |   10 +
> >  migration/options.c               |   16 -
> >  migration/options.h               |    2 -
> >  migration/qemu-file.c             |    1 -
> >  migration/ram.c                   |   90 +-
> >  migration/rdma.c                  | 4205 +----------------------------
> >  migration/rdma.h                  |   67 +-
> >  migration/savevm.c                |    2 +-
> >  migration/trace-events            |   68 +-
> >  qapi/migration.json               |   13 +-
> >  scripts/analyze-migration.py      |    3 -
> >  tests/unit/meson.build            |    1 +
> >  tests/unit/test-io-channel-rdma.c |  276 ++
> >  24 files changed, 1360 insertions(+), 4832 deletions(-)  delete mode
> > 100644 docs/rdma.txt  create mode 100644 include/io/channel-rdma.h
> > create mode 100644 io/channel-rdma.c  create mode 100644
> > tests/unit/test-io-channel-rdma.c
> >
> > --
> > 2.43.0


