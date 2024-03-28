Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAC2C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 08:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rplXL-0001D9-RQ; Thu, 28 Mar 2024 04:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rplXJ-0001CF-Bb
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 04:55:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rplXH-0008Gw-L0
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 04:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711616098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ea+V2R4QPLGiWoEtzklhax8Wy2PbJTs/5/I96ARgc38=;
 b=aHOQ6FgJf4rrnSw3DDU4y3A2dvgSKr7R/6N4PI5UC3PrG5jTC0PS6WQoBss1aq4B59TyHa
 74y6UCia79J9GFxzzi9CS37pzfDO2BqDZAFyNy+L8MgjqvgFg1Q2jv2j7rQxVnpYhZuO9x
 QHBIMu4oMnX5IIcokMp76PYdzDDgys0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-x5gNBdgGPUOO-JEqr5Saag-1; Thu, 28 Mar 2024 04:54:54 -0400
X-MC-Unique: x5gNBdgGPUOO-JEqr5Saag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C5358007AB;
 Thu, 28 Mar 2024 08:54:53 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8725B17AA0;
 Thu, 28 Mar 2024 08:54:51 +0000 (UTC)
Date: Thu, 28 Mar 2024 09:54:46 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 zhuyangyang <zhuyangyang14@huawei.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, luolongmin@huawei.com,
 suxiaodong1@huawei.com, chenxiaoyu48@huawei.com,
 wangyan122@huawei.com, yebiaoxiang@huawei.com
Subject: Re: [PATCH v1] coroutine: avoid inserting duplicate coroutine to
 co_queue_wakeup
Message-ID: <ZgUwVjz_yKgFT7o5@redhat.com>
References: <20240325091850.1087235-1-zhuyangyang14@huawei.com>
 <20240325155041.GA1898401@fedora>
 <dio6iqptfp7hvptuwreadxknpvptprmrcprfjsso52di4osxic@z4dwt43okhax>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dio6iqptfp7hvptuwreadxknpvptprmrcprfjsso52di4osxic@z4dwt43okhax>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Am 27.03.2024 um 23:13 hat Eric Blake geschrieben:
> On Mon, Mar 25, 2024 at 11:50:41AM -0400, Stefan Hajnoczi wrote:
> > On Mon, Mar 25, 2024 at 05:18:50PM +0800, zhuyangyang wrote:
> > > If g_main_loop_run()/aio_poll() is called in the coroutine context,
> > > the pending coroutine may be woken up repeatedly, and the co_queue_wakeup
> > > may be disordered.
> > 
> > aio_poll() must not be called from coroutine context:
> > 
> >   bool no_coroutine_fn aio_poll(AioContext *ctx, bool blocking);
> >        ^^^^^^^^^^^^^^^
> > 
> > Coroutines are not supposed to block. Instead, they should yield.
> > 
> > > When the poll() syscall exited in g_main_loop_run()/aio_poll(), it means
> > > some listened events is completed. Therefore, the completion callback
> > > function is dispatched.
> > > 
> > > If this callback function needs to invoke aio_co_enter(), it will only
> > > wake up the coroutine (because we are already in coroutine context),
> > > which may cause that the data on this listening event_fd/socket_fd
> > > is not read/cleared. When the next poll () exits, it will be woken up again
> > > and inserted into the wakeup queue again.
> > > 
> > > For example, if TLS is enabled in NBD, the server will call g_main_loop_run()
> > > in the coroutine, and repeatedly wake up the io_read event on a socket.
> > > The call stack is as follows:
> > > 
> > > aio_co_enter()
> > > aio_co_wake()
> > > qio_channel_restart_read()
> > > aio_dispatch_handler()
> > > aio_dispatch_handlers()
> > > aio_dispatch()
> > > aio_ctx_dispatch()
> > > g_main_context_dispatch()
> > > g_main_loop_run()
> > > nbd_negotiate_handle_starttls()
> > 
> > This code does not look like it was designed to run in coroutine
> > context. Two options:
> > 
> > 1. Don't run it in coroutine context (e.g. use a BH instead). This
> >    avoids blocking the coroutine but calling g_main_loop_run() is still
> >    ugly, in my opinion.
> > 
> > 2. Get rid of data.loop and use coroutine APIs instead:
> > 
> >    while (!data.complete) {
> >        qemu_coroutine_yield();
> >    }
> > 
> >    and update nbd_tls_handshake() to call aio_co_wake(data->co) instead
> >    of g_main_loop_quit(data->loop).
> > 
> >    This requires auditing the code to check whether the event loop might
> >    invoke something that interferes with
> >    nbd_negotiate_handle_starttls(). Typically this means monitor
> >    commands or fd activity that could change the state of this
> >    connection while it is yielded. This is where the real work is but
> >    hopefully it will not be that hard to figure out.
> 
> I agree that 1) is ugly.  So far, I've added some temporary
> assertions, to see when qio_channel_tls_handshake is reached; it looks
> like nbd/server.c is calling it from within coroutine context, but
> nbd/client.c is calling it from the main loop.  The qio code handles
> either, but now I'm stuck in trying to get client.c into having the
> right coroutine context; the TLS handshake is done before the usual
> BlockDriverState *bs object is available, so I'm not even sure what
> aio context, if any, I should be using.  But on my first try, I'm
> hitting:
> 
> qemu-img: ../util/async.c:707: aio_co_enter: Assertion `self != co' failed.
> 
> so I obviously got something wrong.

Hard to tell without seeing the code, but it looks like you're trying to
wake up the coroutine while you're still executing in the context of the
same coroutine.

It looks like the documentation of qio_channel_tls_handshake() is wrong
and the function can return and call the callback immediately without
dropping out of coroutine context.

A rather heavy-handed, but obvious approach would be moving the
qio_channel_tls_handshake() into a BH, then you know you'll always be
outside of coroutine context in the callback.

But maybe it would be enough to just check if the coroutine isn't
already active:

    if (!qemu_coroutine_entered(co)) {
        aio_wake_co(co);
    }

> It may be possible to use block_gen_c to turn nbd_receive_negotiate
> and nbd_receive_export_list into co_wrapper functions, if I can audit
> that all of their code goes through qio (and is therefore
> coroutine-safe), but that work is still ongoing.

If it's possible, I think that would be nicer in the code and would also
reduce the time the guest is blocked while we're creating a new NBD
connection.

*reads code*

Hm... Actually, one thing I was completely unaware of is that all of
this is running in a separate thread, so maybe the existing synchronous
code already doesn't block the guest. nbd_co_establish_connection()
starts this thread. The thread doesn't have an AioContext, so anything
that involves scheduling something in an AioContext (including BHs and
waking up coroutines) will result in code running in a different thread.

I'm not sure why a thread is used in the first place (does it do
something that coroutines can't do?) and if running parts of the code in
a different thread would be a problem, but we should probably have a
look at this first. Mixing threads and coroutines feels strange.

Kevin


