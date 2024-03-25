Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3090DC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 16:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1romlS-0003kp-Gk; Mon, 25 Mar 2024 12:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1roml0-0003T0-15
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 12:01:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1romkw-0005kA-I6
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 12:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711382460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=niH2PBWi973DXYoASSr/+4XT38z48kea3DCy/O/XEtI=;
 b=bEvulJGqmrvTnYv5iWCfQwC4zSDw7ZhAnVBsmpu38HHFxKMyivyUZbtYSdxITmplH0Lz0g
 Bsc7TDSgsG6gEuddCTt8/B9Z62cKFfNax1IcRo+YkCJ+vS0K+fS+ccfQ9AsTaqHSxGeetv
 wZfyoZb8Bk65juxYrPE4CcDyKrWYR3A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-dUjRJFpOODWEdTDAbnpOmw-1; Mon, 25 Mar 2024 12:00:56 -0400
X-MC-Unique: dUjRJFpOODWEdTDAbnpOmw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00374801803;
 Mon, 25 Mar 2024 16:00:56 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.200])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C57D63C20;
 Mon, 25 Mar 2024 16:00:53 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:00:31 -0500
From: Eric Blake <eblake@redhat.com>
To: zhuyangyang <zhuyangyang14@huawei.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 luolongmin@huawei.com, suxiaodong1@huawei.com, chenxiaoyu48@huawei.com, 
 wangyan122@huawei.com, yebiaoxiang@huawei.com
Subject: Re: [PATCH v1] coroutine: avoid inserting duplicate coroutine to
 co_queue_wakeup
Message-ID: <wac6lbzuvpdyttfpuoeac4ygps2elzktf5dcw22wruaupqy5r6@sfausqavuvil>
References: <20240325091850.1087235-1-zhuyangyang14@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325091850.1087235-1-zhuyangyang14@huawei.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I've seen (and agree with) Stefan's reply that a more thorough audit
is needed, but am still providing a preliminary review based on what I
see here.

On Mon, Mar 25, 2024 at 05:18:50PM +0800, zhuyangyang via wrote:
> If g_main_loop_run()/aio_poll() is called in the coroutine context,
> the pending coroutine may be woken up repeatedly, and the co_queue_wakeup
> may be disordered.

coroutine context should not be doing anything that can block; you may
have uncovered a bigger bug that we need to address.

> 
> When the poll() syscall exited in g_main_loop_run()/aio_poll(), it means
> some listened events is completed. Therefore, the completion callback
> function is dispatched.
> 
> If this callback function needs to invoke aio_co_enter(), it will only
> wake up the coroutine (because we are already in coroutine context),
> which may cause that the data on this listening event_fd/socket_fd
> is not read/cleared. When the next poll () exits, it will be woken up again
> and inserted into the wakeup queue again.
> 
> For example, if TLS is enabled in NBD, the server will call g_main_loop_run()
> in the coroutine, and repeatedly wake up the io_read event on a socket.
> The call stack is as follows:
> 
> aio_co_enter()
> aio_co_wake()
> qio_channel_restart_read()
> aio_dispatch_handler()
> aio_dispatch_handlers()
> aio_dispatch()
> aio_ctx_dispatch()
> g_main_context_dispatch()
> g_main_loop_run()
> nbd_negotiate_handle_starttls()
> nbd_negotiate_options()
> nbd_negotiate()
> nbd_co_client_start()
> coroutine_trampoline()
> 
> Signed-off-by: zhuyangyang <zhuyangyang14@huawei.com>
> ---
>  util/async.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/util/async.c b/util/async.c
> index 0467890052..25fc1e6083 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -705,7 +705,18 @@ void aio_co_enter(AioContext *ctx, Coroutine *co)
>      if (qemu_in_coroutine()) {
>          Coroutine *self = qemu_coroutine_self();
>          assert(self != co);
> -        QSIMPLEQ_INSERT_TAIL(&self->co_queue_wakeup, co, co_queue_next);
> +        /*
> +         * If the Coroutine *co is already in the co_queue_wakeup, this
> +         * repeated insertion will causes the loss of other queue element

s/causes/cause/

> +         * or infinite loop.
> +         * For examplex:

s/examplex/example/

> +         * Head->a->b->c->NULL, after insert_tail(head, b) => Head->a->b->NULL
> +         * Head->a-b>->NULL, after insert_tail(head, b) => Head->a->b->b...

s/b>->/b->/

> +         */
> +        if (!co->co_queue_next.sqe_next &&
> +            self->co_queue_wakeup.sqh_last != &co->co_queue_next.sqe_next) {
> +            QSIMPLEQ_INSERT_TAIL(&self->co_queue_wakeup, co, co_queue_next);
> +        }
>      } else {
>          qemu_aio_coroutine_enter(ctx, co);
>      }

Intuitively, attacking the symptoms (avoiding bogus list insertion
when it is already on the list) makes sense; but I want to make sure
we attack the root cause.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


