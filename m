Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B4CC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 07:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txLFw-0003nP-9O; Wed, 26 Mar 2025 03:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zoudongjie@huawei.com>)
 id 1txLFr-0003m1-10; Wed, 26 Mar 2025 03:32:51 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zoudongjie@huawei.com>)
 id 1txLFo-0003Zq-4U; Wed, 26 Mar 2025 03:32:50 -0400
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZMz1k6rnSzHrJ5;
 Wed, 26 Mar 2025 15:29:14 +0800 (CST)
Received: from kwepemk500007.china.huawei.com (unknown [7.202.194.92])
 by mail.maildlp.com (Postfix) with ESMTPS id 23A591800FD;
 Wed, 26 Mar 2025 15:32:32 +0800 (CST)
Received: from huawei.com (10.246.99.19) by kwepemk500007.china.huawei.com
 (7.202.194.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 26 Mar
 2025 15:32:30 +0800
To: <stefanha@redhat.com>
CC: <alex.chen@huawei.com>, <chenjianfei3@huawei.com>,
 <eric.fangyi@huawei.com>, <fam@euphon.net>, <hreitz@redhat.com>,
 <kwolf@redhat.com>, <luolongmin@huawei.com>, <mujinsheng@huawei.com>,
 <qemu-block@nongnu.org>, <qemu-devel@nongnu.org>, <qemu-stable@nongnu.org>,
 <renxuming@huawei.com>, <suxiaodong1@huawei.com>, <wangjian161@huawei.com>,
 <wangyan122@huawei.com>, <yebiaoxiang@huawei.com>,
 <zhuyangyang14@huawei.com>, <zoudongjie@huawei.com>
Subject: Re: [PATCH v2 1/2] io/block: Refactoring the bdrv_drained_begin()
 function and implement a timeout mechanism.
Date: Wed, 26 Mar 2025 15:30:57 +0800
Message-ID: <20250326073058.1056850-1-zoudongjie@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250324180913.GH64982@fedora>
References: <20250324180913.GH64982@fedora>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.246.99.19]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemk500007.china.huawei.com (7.202.194.92)
Received-SPF: pass client-ip=45.249.212.189;
 envelope-from=zoudongjie@huawei.com; helo=szxga03-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, 24 Mar 2025 14:09:13 -0400, Stefan Hajnoczi wrote:
> On Fri, Mar 21, 2025 at 03:09:16PM +0800, zoudongjie wrote:
> > From: Zhu Yangyang <zhuyangyang14@huawei.com>
> >
> > The bdrv_drained_begin() function is a blocking function. In scenarios where network storage
> > is used and network links fail, it may block for a long time.
> > Therefore, we add a timeout parameter to control the duration of the block.
> >
> > Since bdrv_drained_begin() has been widely adopted, both bdrv_drained_begin()
> > and bdrv_drained_begin_timeout() will be retained.
> ...
> 
> > +/**
> > + * AIO_WAIT_WHILE_TIMEOUT:
> > + *
> > + * Refer to the implementation of AIO_WAIT_WHILE_INTERNAL,
> > + * the timeout parameter is added.
> > + * @timeout_ns: maximum duration to wait, in nanoseconds, except the value
> > + *              is unsigned, 0 means infinite.
> > + */
> > +#define AIO_WAIT_WHILE_TIMEOUT(ctx, cond, timeout_ns) ({                 \
> > +    int ret_ = 0;                                                        \
> > +    uint64_t timeout_ = (timeout_ns);                                    \
> > +    AioWait *wait_ = &global_aio_wait;                                   \
> > +    AioContext *ctx_ = (ctx);                                            \
> > +    AioContext *current_ctx_ = NULL;                                     \
> > +    QEMUTimer timer_;                                                    \
> > +    /* Increment wait_->num_waiters before evaluating cond. */           \
> > +    qatomic_inc(&wait_->num_waiters);                                    \
> > +    /* Paired with smp_mb in aio_wait_kick(). */                         \
> > +    smp_mb__after_rmw();                                                 \
> > +    if (ctx_ && in_aio_context_home_thread(ctx_)) {                      \
> > +        current_ctx_ = ctx_;                                             \
> > +    } else {                                                             \
> > +        assert(qemu_get_current_aio_context() ==                         \
> > +               qemu_get_aio_context());                                  \
> > +        current_ctx_ = qemu_get_aio_context();                           \
> > +    }                                                                    \
> > +    if (timeout_ > 0) {                                                  \
> > +        timer_init_full(&timer_, &current_ctx_->tlg,                     \
> > +                        QEMU_CLOCK_REALTIME,                             \
> > +                        SCALE_NS, 0, aio_wait_timer_cb, NULL);           \
> > +        timer_mod_ns(&timer_,                                            \
> > +                     qemu_clock_get_ns(QEMU_CLOCK_REALTIME) +            \
> > +                     timeout_);                                          \
> > +    }                                                                    \
> > +    while ((cond)) {                                                     \
> > +        aio_poll(current_ctx_, true);                                    \
> > +        if (timeout_ > 0 && !timer_pending(&timer_)) {                   \
> > +            ret_ = -ETIMEDOUT;                                           \
> > +            break;                                                       \
> > +        }                                                                \
> > +    }                                                                    \
> > +    if (timeout_ > 0) {                                                  \
> > +        timer_del(&timer_);                                              \
> > +    }                                                                    \
> > +    qatomic_dec(&wait_->num_waiters);                                    \
> > +    ret_; })
> > +
> >  #define AIO_WAIT_WHILE(ctx, cond)                                  \
> >      AIO_WAIT_WHILE_INTERNAL(ctx, cond)
>
> It would be nice to unify AIO_WAIT_WHILE_INTERNAL() and
> AIO_WAIT_WHILE_TIMEOUT(). I don't see any caller that uses the waited_
> return value from AIO_WAIT_WHILE_INTERNAL(), so I think it's possible to
> replace AIO_WAIT_WHILE_INTERNAL() with AIO_WAIT_WHILE_TIMEOUT(.., ..., 0).
>

Yes, there is no difference between AIO_WAIT_WHILE_INTERNAL() and
AIO_WAIT_WHILE_TIMEOUT() except the return value. It's right to keep the
code uniform. I will modify it in the next version.



