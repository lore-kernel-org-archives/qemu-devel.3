Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B003CCD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXc9Y-0006kj-Ku; Thu, 11 Jun 2026 05:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wXc9V-0006jo-0X
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:56:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wXc9S-0004qL-ED
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781171800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HD0I2m59+bIXM4EbuuP/csKxSd1MkqC8l2OAJz5UmVc=;
 b=iIWpm+8LM/z5FIsnpn4uLY4uI/TFsFjlJoFeb/c2x2sP4qnYXQXYI06w8eg7rT3DqETRON
 0c1x75yMKTtBsD1x3MYRcSzEpTpU6VUbf3YHMdhWaDVXAsMbnhK6O/3R0mFmGtPOi+BrE4
 lT8PPGYpqdjrrkqwpivGeC2EUql1iP0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-d6c8ewT5OISrLPJA8MIjOA-1; Thu,
 11 Jun 2026 05:56:38 -0400
X-MC-Unique: d6c8ewT5OISrLPJA8MIjOA-1
X-Mimecast-MFC-AGG-ID: d6c8ewT5OISrLPJA8MIjOA_1781171797
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 723651808948; Thu, 11 Jun 2026 09:56:37 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.66])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 479F330001A7; Thu, 11 Jun 2026 09:56:35 +0000 (UTC)
Date: Thu, 11 Jun 2026 11:56:32 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Boudewijn van der Heide <boudewijn@delta-utec.com>
Cc: hreitz@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, stefanha@redhat.com
Subject: SCSI and coroutines (was: [PATCH] block: switch to co_wrapper_mixed
 for blk_lock_medium()) and blk_eject()
Message-ID: <aiqGUKL_C3COxBlp@redhat.com>
References: <aiksHyfQnJIs_1OH@redhat.com>
 <20260610190548.10763-1-boudewijn@delta-utec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610190548.10763-1-boudewijn@delta-utec.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 10.06.2026 um 21:05 hat Boudewijn van der Heide geschrieben:
> > > > > scsi_disk_emulate_command() can be called from a coroutine;
> > > > > when req->cmd.buf[0] is ALLOW_MEDIUM_REMOVAL, the synchronous
> > > > > blk_lock_medium() is called, which hits assert(!qemu_in_coroutine()),
> > > > > and crashes:
> > > > > 
> > > > > 	qemu-system-hppa: block/block-gen.c:1692: blk_lock_medium:
> > > > > 	Assertion `!qemu_in_coroutine()' failed.
> > > > > 
> > > > > blk_eject() has the same problem, it can be called from coroutine,
> > > > > because the same vtable entry (SCSIReqOps.send_command,
> > > > > scsi_disk_emulate_command() here) calls blk_eject when req->cmd.buf[0]
> > > > > is START_STOP.
> > > > > 
> > > > > Fix by switching to co_wrapper_mixed for blk_lock_medium() and
> > > > > blk_eject() instead of just co_wrapper.
> > > > > 
> > > > > Signed-off-by: Boudewijn van der Heide <boudewijn@delta-utec.com>
> > > > 
> > > > Yes, that will fix your immediate symptoms. I'm not completely sure if
> > > > that's the level where we want to fix things, though, which is why I
> > > > added Paolo and Stefan to Cc.
> > > > > ---
> > > > > Observed crash on fedora qemu-10.1.5-1.fc43 on x86_64 host using qemu-system-hppa.
> > > > > 
> > > > > trace:
> > > > > 
> > > > > Thread 1 (...):
> > > > >         # 5 __assert_fail (...) at assert.c
> > > > >         # 6 blk_lock_medium (...) at block/block-gen.c
> > > > >         # 7 scsi_disk_emulate_command (...) at ../hw/scsi/scsi-disk.c
> > > > >         # 8 scsi_req_enqueue (...) at ../hw/scsi/scsi-bus.c
> > > > >         # 9 lsi_do_command (...) at ../hw/scsi/lsi53c895a.c
> > > > >         # 10 lsi_execute_script (...) at ../hw/scsi/lsi53c895a.c
> > > > >         # 11 scsi_read_complete_noio (...) at ../hw/scsi/scsi-disk.c
> > > > >         # 12 blk_aio_complete (...) at ../block/block-backend.c
> > > > >         # 14 blk_aio_read_entry (...) at ../block/block-backend.c
> > > > >         # 15 in coroutine_trampoline (...) at ../util/coroutine-ucontext.c
> > > > > 
> > > > > blk_eject() has the same path, but req->cmd.buf[0] is START_STOP instead
> > > > > of ALLOW_MEDIUM_REMOVAL inside scsi_disk_emulate_command(),
> > > > > so fix that aswell.
> > > > 
> > > > This would be useful information to have in the commit message proper.
> 
> I can add that in a later revision if you would want to, do you mean the trace,
> or the comment, or both?

Both really. If we look at the commit in a few years' time, both will
provide valuable context for what problem the change addressed.

> > > > 
> > > > The step from #10 to #11 seems to be a rather big one that left out
> > > > intermediate function calls, so I'm not sure if I fully understand it.
> > > > 
> > > > Either way, I don't think lsi_execute_script() and the functions called
> > > > by it were ever written with the intention to run in a coroutine. I'm
> > > > almost sure that problems can be in more than just the two functions
> > > > you're changing here. So my question is mostly, should the path involve
> > > > a BH somewhere to break out of coroutine context, instead of making one
> > > > or two specific cases work?
> > > 
> > > The code path in this bug is from the block layer (blk_aio_read_entry ->
> > > blk_aio_complete) to scsi-disk (scsi_read_complete_noio) into the LSI
> > > device (probably lsi_command_complete -> lsi_resume_script ->
> > > lsi_execute_script).
> 
> IIUC, from what I can see,
> we can trace it manually to this
> (note; I reversed it to make it more readable):
> 
>          # 11 scsi_read_complete_noio (...) at ../hw/scsi/scsi-disk.c
> 
>          scsi_read_complete_noio() ->
>          scsi_req_data(&r->req, r->qiov.size);
>          r->req->bus->info->transfer_data
>              // from the &r->req in scsi_req_data() call; 
>              // void (*transfer_data) vtable ->
> 
>          .transfer_data = lsi_transfer_data,  
>              // inside scsibusinfo lsi_scsi_info, for our lsi here ->
> 
>          lsi_transfer_data() ->
>          lsi_resume_script() ->
>          lsi_execute_script() ->
>          # 10 lsi_execute_script (...) at ../hw/scsi/lsi53c895a.c

That makes sense to me, thanks.

> Also for the BH breakout path idea, IMHO it would be a bit hacky.
> I tested something local, but I had to defer mid-execution script
> to a cb and it would be mimicking essentially what the co_wrapper_mixed
> generated code would do.

Using a BH to drop out of coroutine context is the standard approach in
this kind of situation. It's also what no_co_wrapper does internally.

I don't know where you tried to apply it. I think the right place to
drop out of coroutine context in your call trace above would be when
scsi-bus.c calls into the .transfer_data callback. So I'd annotate the
callback as no_coroutine_fn and add a BH for calling it.

> > > I'm not sure if the LSI device, which is unaware of coroutines, should
> > > have to work around this. It seems cleaner for blk_aio_preadv() to
> > > invoke cb() from outside coroutine context since that API does not say
> > > anything about coroutine contexts.
> 
> I'm also not sure if LSI device should handle/intereact with this.
> 
> Also I'm not sure that blk_aio_preadv()/blk_aio_prwv()
> is the right place for this, we would be changing the API semantics there, no?
> blk_aio_preadv() calls blk_aio_prwv(), which takes CoroutineEntry co_entry
> and then calls qemu_coroutine_create().

We can change the semantics of interfaces, of course, if there is a good
reason to do it. I'm just not sure that we have a good reason because in
most devices, a completion callback doesn't do anything that could
possibly yield again, so it doesn't make any difference if it's running
in a coroutine or not. Making sure that it doesn't run in a coroutine is
unnecessary overhead for them.

What we probably should do is annotate the callback type as coroutine_fn
just to document the existing semantics.

> > > On the other hand, there will be a performance overhead for leaving
> > > coroutine context even when it would be fine to run in a coroutine...
> > 
> > Yes, I don't think it should be done by the block layer when most
> > callbacks are just fine with running in a coroutine. I was thinking that
> > maybe something in the SCSI layer should do it, or even scsi-disk
> > specifically. Though of course, if virtio-scsi doesn't have the problem
> > (does it?), taking the performance overhead for fixing LSI is probably
> > also not what we want.
> > 
> > Another, more radical solution, could be to move SCSI requests as a
> > whole into coroutines, changing the assumption everywhere from
> > no_coroutine_fn to coroutine_fn without bothering with mixed functions
> > at all. The SCSI state machine is quite complex and I often find the
> > control flow in the current callback-based code hard to understand, so I
> > think this has the potential to improve the code, though of course it
> > would also be a big change.
> 
> I think I agree that refactoring SCSI requests all into coroutines
> would be a good future approach, however what if there is some path
> for SCSI state machine that really can't handle coroutines somewhere
> and so then up in the chain you make it no_coroutine_fn,
> we would still be leaving other downstream paths which are coroutine
> safe off the table and we would be in the same situation as we
> currently are.

As long as you know that you definitely are in a coroutine, and you want
to call a no_coroutine_fn (which honestly shouldn't usually be something
a SCSI request does), it's not really a problem. You just use a
no_co_wrapper or do the BH dance manually. It's a few lines of code, but
not terribly complicated.

The part that is really problematic today is that for SCSI, it's mostly
undefined what code runs (or can potentially run) in a coroutine and
what code doesn't.

So I think in a first step we'd have to define what the expected context
should be for each SCSI function and especially for the various
callbacks both into SCSI devices and the host controller. Maybe even
just annotate what is true today, though I'm afraid we'd end up with
just documenting everything as mixed and then it wouldn't be massively
useful...

> Maybe it's worth considering adding some compile time checking
> for the coroutine wrapper generator. 
> This would ensure coroutine API being upheld at compile-time.
> Though, this might be a pretty big undertaking, with potentially
> some compiler specific hacks.

We're already using clang's TSA for checking the use of the graph lock.
I think it could also be used to help with coroutines a little bit. I'm
not sure how well coroutine_mixed_fn can be handled with it, though.

It's compiler specific, but that is not really a problem: CI runs build
with clang, so problems would be caught there if someone doesn't pay
enough attention.

I've thought of doing this occasionally, but never seriously looked into
it.

> > Or, of course, we just take this patch, and keep fixing instances of
> > the problem as they come up.
> 
> We can do both IMO, for shorter term we can patch the offending paths
> like I did in my patch here and also formulate a long term approach.

Yes, of course, if we decide that we do want to revamp SCSI to make
requests coroutine based, then that's a big enough project that we'd
probably want to merge a stopgap solution first.

Kevin


