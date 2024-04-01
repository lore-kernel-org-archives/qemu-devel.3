Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC2BCD1283
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 07:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrCYR-0003IH-6U; Mon, 01 Apr 2024 03:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhuyangyang14@huawei.com>)
 id 1rrCYO-0003H9-JG; Mon, 01 Apr 2024 03:58:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhuyangyang14@huawei.com>)
 id 1rrCYL-0003xh-Qd; Mon, 01 Apr 2024 03:58:04 -0400
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V7Ndg0ZRpz1GFLR;
 Mon,  1 Apr 2024 15:57:11 +0800 (CST)
Received: from dggpeml500011.china.huawei.com (unknown [7.185.36.84])
 by mail.maildlp.com (Postfix) with ESMTPS id 43A43140410;
 Mon,  1 Apr 2024 15:57:47 +0800 (CST)
Received: from huawei.com (10.91.158.201) by dggpeml500011.china.huawei.com
 (7.185.36.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 1 Apr
 2024 15:57:46 +0800
To: <eblake@redhat.com>
CC: <chenxiaoyu48@huawei.com>, <fam@euphon.net>, <luolongmin@huawei.com>,
 <qemu-block@nongnu.org>, <qemu-devel@nongnu.org>, <qemu-stable@nongnu.org>,
 <stefanha@redhat.com>, <suxiaodong1@huawei.com>, <wangyan122@huawei.com>,
 <yebiaoxiang@huawei.com>, <zhuyangyang14@huawei.com>
Subject: Re: [PATCH v1] coroutine: avoid inserting duplicate coroutine to
 co_queue_wakeup
Date: Mon, 1 Apr 2024 16:04:40 +0800
Message-ID: <20240401080440.1217376-1-zhuyangyang14@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <dv63ec4btdz32schwrwjebce4m7xbu5tt6fncebi5hzxnmctdy@xflzv6tolvrm>
References: <dv63ec4btdz32schwrwjebce4m7xbu5tt6fncebi5hzxnmctdy@xflzv6tolvrm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.91.158.201]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500011.china.huawei.com (7.185.36.84)
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhuyangyang14@huawei.com; helo=szxga05-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On Thu, 28 Mar 2024 07:40:14 -0500, Eric Blake wrote:
> On Mon, Mar 25, 2024 at 05:18:50PM +0800, zhuyangyang via wrote:
> > If g_main_loop_run()/aio_poll() is called in the coroutine context,
> > the pending coroutine may be woken up repeatedly, and the co_queue_wakeup
> > may be disordered.
> > 
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
> > nbd_negotiate_options()
> > nbd_negotiate()
> > nbd_co_client_start()
> > coroutine_trampoline()
> 
> zhuyangyang, do you have a reliable reproduction setup for how you
> were able to trigger this?  Obviously, it only happens when TLS is
> enabled (we aren't creating a g_main_loop_run for any other NBD
> command), and only when the server is first starting to serve a
> client; is this a case where you were hammering a long-running qemu
> process running an NBD server with multiple clients trying to
> reconnect to the server all near the same time?

This problem cannot be reproduced after 
7c1f51bf38 ("nbd/server: Fix drained_poll to wake coroutine in right AioContext") 
that avoids repeatedly waking up the same coroutine.

Invoking g_main_loop_run() in the coroutine will cause that 
event completion callback function qio_channel_restart_read() is called repeatedly, 
but the coroutine is woken up only once.

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

The root cause is that poll() is invoked in coroutine context.

> 
> If we can come up with a reliable formula for reproducing the
> corrupted coroutine list, it would make a great iotest addition
> alongside the existing qemu-iotests 233 for ensuring that NBD TLS
> traffic is handled correctly in both server and client.
> 
> > 
> > Signed-off-by: zhuyangyang <zhuyangyang14@huawei.com>
> 
> Side note: this appears to be your first qemu contribution (based on
> 'git shortlog --author zhuyangyang').  While I am not in a position to
> presume how you would like your name Anglicized, I will point out that
> the prevailing style is to separate given name from family name (just
> because your username at work has no spaces does not mean that your
> S-o-b has to follow suit).  It is also permissible to list your name
> in native characters alongside or in place of the Anglicized version;
> for example, 'git log --author="Stefano Dong"' shows this technique.


-- 
Best Regards,
Zhu Yangyang


