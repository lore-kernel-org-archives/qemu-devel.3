Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FC7CD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 11:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp5H8-0004BS-BN; Tue, 26 Mar 2024 07:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhuyangyang14@huawei.com>)
 id 1rp5H3-0004AA-0H; Tue, 26 Mar 2024 07:47:25 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhuyangyang14@huawei.com>)
 id 1rp5Gu-0005I9-VF; Tue, 26 Mar 2024 07:47:20 -0400
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V3nyN31RZzXjsg;
 Tue, 26 Mar 2024 19:44:12 +0800 (CST)
Received: from dggpeml500011.china.huawei.com (unknown [7.185.36.84])
 by mail.maildlp.com (Postfix) with ESMTPS id 189B81400DD;
 Tue, 26 Mar 2024 19:46:58 +0800 (CST)
Received: from huawei.com (10.91.158.201) by dggpeml500011.china.huawei.com
 (7.185.36.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 26 Mar
 2024 19:46:57 +0800
To: <stefanha@redhat.com>
CC: <chenxiaoyu48@huawei.com>, <eblake@redhat.com>, <fam@euphon.net>,
 <kwolf@redhat.com>, <luolongmin@huawei.com>, <qemu-block@nongnu.org>,
 <qemu-devel@nongnu.org>, <qemu-stable@nongnu.org>, <suxiaodong1@huawei.com>,
 <wangyan122@huawei.com>, <yebiaoxiang@huawei.com>, <zhuyangyang14@huawei.com>
Subject: Re: [PATCH v1] coroutine: avoid inserting duplicate coroutine to
 co_queue_wakeup
Date: Tue, 26 Mar 2024 19:53:56 +0800
Message-ID: <20240326115356.2495562-1-zhuyangyang14@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240325155041.GA1898401@fedora>
References: <20240325155041.GA1898401@fedora>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.91.158.201]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500011.china.huawei.com (7.185.36.84)
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=zhuyangyang14@huawei.com; helo=szxga02-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Reply-to:  zhuyangyang <zhuyangyang14@huawei.com>
From:  zhuyangyang via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 25 Mar 2024 11:50:41 -0400, Stefan Hajnoczi wrote:
> On Mon, Mar 25, 2024 at 05:18:50PM +0800, zhuyangyang wrote:
> > If g_main_loop_run()/aio_poll() is called in the coroutine context,
> > the pending coroutine may be woken up repeatedly, and the co_queue_wakeup
> > may be disordered.
> 
> aio_poll() must not be called from coroutine context:
> 
>   bool no_coroutine_fn aio_poll(AioContext *ctx, bool blocking);
>        ^^^^^^^^^^^^^^^
> 
> Coroutines are not supposed to block. Instead, they should yield.
> 
> > When the poll() syscall exited in g_main_loop_run()/aio_poll(), it means
> > some listened events is completed. Therefore, the completion callback
> > function is dispatched.
> > 
> > If this callback function needs to invoke aio_co_enter(), it will only
> > wake up the coroutine (because we are already in coroutine context),
> > which may cause that the data on this listening event_fd/socket_fd
> > is not read/cleared. When the next poll () exits, it will be woken up again
> > and inserted into the wakeup queue again.
> > 
> > For example, if TLS is enabled in NBD, the server will call g_main_loop_run()
> > in the coroutine, and repeatedly wake up the io_read event on a socket.
> > The call stack is as follows:
> > 
> > aio_co_enter()
> > aio_co_wake()
> > qio_channel_restart_read()
> > aio_dispatch_handler()
> > aio_dispatch_handlers()
> > aio_dispatch()
> > aio_ctx_dispatch()
> > g_main_context_dispatch()
> > g_main_loop_run()
> > nbd_negotiate_handle_starttls()
> 
> This code does not look like it was designed to run in coroutine
> context. Two options:
> 
> 1. Don't run it in coroutine context (e.g. use a BH instead). This
>    avoids blocking the coroutine but calling g_main_loop_run() is still
>    ugly, in my opinion.
> 
> 2. Get rid of data.loop and use coroutine APIs instead:
> 
>    while (!data.complete) {
>        qemu_coroutine_yield();
>    }
> 
>    and update nbd_tls_handshake() to call aio_co_wake(data->co) instead
>    of g_main_loop_quit(data->loop).
> 
>    This requires auditing the code to check whether the event loop might
>    invoke something that interferes with
>    nbd_negotiate_handle_starttls(). Typically this means monitor
>    commands or fd activity that could change the state of this
>    connection while it is yielded. This is where the real work is but
>    hopefully it will not be that hard to figure out.

Thank you for your help, I'll try to fix it using the coroutine api.

> 
> > nbd_negotiate_options()
> > nbd_negotiate()
> > nbd_co_client_start()
> > coroutine_trampoline()
> > 

-- 
Best Regards,
Zhu Yangyang

