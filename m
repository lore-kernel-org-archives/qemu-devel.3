Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83975C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 22:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpbWN-0006tD-0c; Wed, 27 Mar 2024 18:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rpbWL-0006sf-9g
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 18:13:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rpbWJ-0005Wj-Cv
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 18:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711577597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7LbmpPdLAcDtfx16s4DCE9oP8dWo7L/IU1HuGCZEgZ4=;
 b=iz0kLHMmC38Rq5CD9a/xEA7A8B797AJvWwKMZZqPBUdfG4v66C5/r/+bzyHu+gDrhQOsC3
 sBd92ZUKhzR8BxSP9xJL/Dpt8mKoCEojwF2RVyC1bOKV1n+gBJR3aNXWcoRwD8cDqtovvt
 KUbF2w9j6kcdgg0aMEmp2damXq72Vuk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-ZeTG8zc_M-CONB33Gxa6YQ-1; Wed, 27 Mar 2024 18:13:12 -0400
X-MC-Unique: ZeTG8zc_M-CONB33Gxa6YQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2969E101A523;
 Wed, 27 Mar 2024 22:13:12 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CD9C200AFA5;
 Wed, 27 Mar 2024 22:13:09 +0000 (UTC)
Date: Wed, 27 Mar 2024 17:13:03 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: zhuyangyang <zhuyangyang14@huawei.com>, Fam Zheng <fam@euphon.net>, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 luolongmin@huawei.com, suxiaodong1@huawei.com, chenxiaoyu48@huawei.com, 
 wangyan122@huawei.com, yebiaoxiang@huawei.com, kwolf@redhat.com
Subject: Re: [PATCH v1] coroutine: avoid inserting duplicate coroutine to
 co_queue_wakeup
Message-ID: <dio6iqptfp7hvptuwreadxknpvptprmrcprfjsso52di4osxic@z4dwt43okhax>
References: <20240325091850.1087235-1-zhuyangyang14@huawei.com>
 <20240325155041.GA1898401@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325155041.GA1898401@fedora>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 25, 2024 at 11:50:41AM -0400, Stefan Hajnoczi wrote:
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

I agree that 1) is ugly.  So far, I've added some temporary
assertions, to see when qio_channel_tls_handshake is reached; it looks
like nbd/server.c is calling it from within coroutine context, but
nbd/client.c is calling it from the main loop.  The qio code handles
either, but now I'm stuck in trying to get client.c into having the
right coroutine context; the TLS handshake is done before the usual
BlockDriverState *bs object is available, so I'm not even sure what
aio context, if any, I should be using.  But on my first try, I'm
hitting:

qemu-img: ../util/async.c:707: aio_co_enter: Assertion `self != co' failed.

so I obviously got something wrong.

It may be possible to use block_gen_c to turn nbd_receive_negotiate
and nbd_receive_export_list into co_wrapper functions, if I can audit
that all of their code goes through qio (and is therefore
coroutine-safe), but that work is still ongoing.

At any rate, qemu-iotest 233 should be good for testing that changes
in this area work; I've also been testing with libnbd (test
interop/interop-qemu-nbd-tls-certs hits qemu's server.c) and nbdkit
(test tests/test-tls-psk.sh hits qemu's client.c).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


