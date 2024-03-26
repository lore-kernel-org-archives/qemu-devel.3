Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FAFCD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 12:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp5mJ-0008Ej-S0; Tue, 26 Mar 2024 08:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhuyangyang14@huawei.com>)
 id 1rp5lr-00089k-FE; Tue, 26 Mar 2024 08:19:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhuyangyang14@huawei.com>)
 id 1rp5le-00050w-UJ; Tue, 26 Mar 2024 08:19:05 -0400
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4V3pjX2smMz1wnNm;
 Tue, 26 Mar 2024 20:18:08 +0800 (CST)
Received: from dggpeml500011.china.huawei.com (unknown [7.185.36.84])
 by mail.maildlp.com (Postfix) with ESMTPS id 4F5281A016C;
 Tue, 26 Mar 2024 20:18:57 +0800 (CST)
Received: from huawei.com (10.91.158.201) by dggpeml500011.china.huawei.com
 (7.185.36.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 26 Mar
 2024 20:18:56 +0800
To: <eblake@redhat.com>
CC: <chenxiaoyu48@huawei.com>, <fam@euphon.net>, <luolongmin@huawei.com>,
 <qemu-block@nongnu.org>, <qemu-devel@nongnu.org>, <qemu-stable@nongnu.org>,
 <stefanha@redhat.com>, <suxiaodong1@huawei.com>, <wangyan122@huawei.com>,
 <yebiaoxiang@huawei.com>, <zhuyangyang14@huawei.com>
Subject: Re: [PATCH v1] coroutine: avoid inserting duplicate coroutine to
 co_queue_wakeup
Date: Tue, 26 Mar 2024 20:25:59 +0800
Message-ID: <20240326122559.2777462-1-zhuyangyang14@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <wac6lbzuvpdyttfpuoeac4ygps2elzktf5dcw22wruaupqy5r6@sfausqavuvil>
References: <wac6lbzuvpdyttfpuoeac4ygps2elzktf5dcw22wruaupqy5r6@sfausqavuvil>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.91.158.201]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
Reply-to:  zhuyangyang <zhuyangyang14@huawei.com>
From:  zhuyangyang via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 25 Mar 2024 11:00:31 -0500 Eric Blake wrote:
> >  util/async.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/util/async.c b/util/async.c
> > index 0467890052..25fc1e6083 100644
> > --- a/util/async.c
> > +++ b/util/async.c
> > @@ -705,7 +705,18 @@ void aio_co_enter(AioContext *ctx, Coroutine *co)
> >      if (qemu_in_coroutine()) {
> >          Coroutine *self = qemu_coroutine_self();
> >          assert(self != co);
> > -        QSIMPLEQ_INSERT_TAIL(&self->co_queue_wakeup, co, co_queue_next);
> > +        /*
> > +         * If the Coroutine *co is already in the co_queue_wakeup, this
> > +         * repeated insertion will causes the loss of other queue element
> 
> s/causes/cause/
> 
> > +         * or infinite loop.
> > +         * For examplex:
> 
> s/examplex/example/
> 
> > +         * Head->a->b->c->NULL, after insert_tail(head, b) => Head->a->b->NULL
> > +         * Head->a-b>->NULL, after insert_tail(head, b) => Head->a->b->b...
> 
> s/b>->/b->/
> 
> > +         */
> > +        if (!co->co_queue_next.sqe_next &&
> > +            self->co_queue_wakeup.sqh_last != &co->co_queue_next.sqe_next) {
> > +            QSIMPLEQ_INSERT_TAIL(&self->co_queue_wakeup, co, co_queue_next);
> > +        }
> >      } else {
> >          qemu_aio_coroutine_enter(ctx, co);
> >      }
> 
> Intuitively, attacking the symptoms (avoiding bogus list insertion
> when it is already on the list) makes sense; but I want to make sure
> we attack the root cause.

Repairing the nbd_negotiate_handle_starttls() can solve this problem, therefore,
I'm not sure if this commit is still needed.

--
Best Regards,
Zhu Yangyang


