Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5004BC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 13:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rokeH-0006M6-9R; Mon, 25 Mar 2024 09:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhuyangyang14@huawei.com>)
 id 1rogNC-0008Fx-Sg; Mon, 25 Mar 2024 05:12:06 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhuyangyang14@huawei.com>)
 id 1rogN9-0002a6-QP; Mon, 25 Mar 2024 05:12:06 -0400
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4V36ZF3FvlztQX7;
 Mon, 25 Mar 2024 17:09:25 +0800 (CST)
Received: from dggpeml500011.china.huawei.com (unknown [7.185.36.84])
 by mail.maildlp.com (Postfix) with ESMTPS id 0DE0918007C;
 Mon, 25 Mar 2024 17:11:48 +0800 (CST)
Received: from huawei.com (10.91.158.201) by dggpeml500011.china.huawei.com
 (7.185.36.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 25 Mar
 2024 17:11:47 +0800
To: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 <qemu-block@nongnu.org>, <qemu-devel@nongnu.org>
CC: <qemu-stable@nongnu.org>, <luolongmin@huawei.com>,
 <suxiaodong1@huawei.com>, <chenxiaoyu48@huawei.com>, <wangyan122@huawei.com>, 
 <yebiaoxiang@huawei.com>
Subject: [PATCH v1] coroutine: avoid inserting duplicate coroutine to
 co_queue_wakeup
Date: Mon, 25 Mar 2024 17:18:50 +0800
Message-ID: <20240325091850.1087235-1-zhuyangyang14@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.91.158.201]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500011.china.huawei.com (7.185.36.84)
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=zhuyangyang14@huawei.com; helo=szxga01-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 25 Mar 2024 09:45:59 -0400
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

If g_main_loop_run()/aio_poll() is called in the coroutine context,
the pending coroutine may be woken up repeatedly, and the co_queue_wakeup
may be disordered.

When the poll() syscall exited in g_main_loop_run()/aio_poll(), it means
some listened events is completed. Therefore, the completion callback
function is dispatched.

If this callback function needs to invoke aio_co_enter(), it will only
wake up the coroutine (because we are already in coroutine context),
which may cause that the data on this listening event_fd/socket_fd
is not read/cleared. When the next poll () exits, it will be woken up again
and inserted into the wakeup queue again.

For example, if TLS is enabled in NBD, the server will call g_main_loop_run()
in the coroutine, and repeatedly wake up the io_read event on a socket.
The call stack is as follows:

aio_co_enter()
aio_co_wake()
qio_channel_restart_read()
aio_dispatch_handler()
aio_dispatch_handlers()
aio_dispatch()
aio_ctx_dispatch()
g_main_context_dispatch()
g_main_loop_run()
nbd_negotiate_handle_starttls()
nbd_negotiate_options()
nbd_negotiate()
nbd_co_client_start()
coroutine_trampoline()

Signed-off-by: zhuyangyang <zhuyangyang14@huawei.com>
---
 util/async.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/util/async.c b/util/async.c
index 0467890052..25fc1e6083 100644
--- a/util/async.c
+++ b/util/async.c
@@ -705,7 +705,18 @@ void aio_co_enter(AioContext *ctx, Coroutine *co)
     if (qemu_in_coroutine()) {
         Coroutine *self = qemu_coroutine_self();
         assert(self != co);
-        QSIMPLEQ_INSERT_TAIL(&self->co_queue_wakeup, co, co_queue_next);
+        /*
+         * If the Coroutine *co is already in the co_queue_wakeup, this
+         * repeated insertion will causes the loss of other queue element
+         * or infinite loop.
+         * For examplex:
+         * Head->a->b->c->NULL, after insert_tail(head, b) => Head->a->b->NULL
+         * Head->a-b>->NULL, after insert_tail(head, b) => Head->a->b->b...
+         */
+        if (!co->co_queue_next.sqe_next &&
+            self->co_queue_wakeup.sqh_last != &co->co_queue_next.sqe_next) {
+            QSIMPLEQ_INSERT_TAIL(&self->co_queue_wakeup, co, co_queue_next);
+        }
     } else {
         qemu_aio_coroutine_enter(ctx, co);
     }
-- 
2.33.0


