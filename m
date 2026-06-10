Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B906ECD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 19:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXOXf-0005Pz-Ik; Wed, 10 Jun 2026 15:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <boudewijn@delta-utec.com>)
 id 1wXOGi-0007zr-HZ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 15:07:16 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <boudewijn@delta-utec.com>)
 id 1wXOGf-0003cp-J1
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 15:07:16 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-68bd9fce347so13447653a12.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 12:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=delta-utec-com.20251104.gappssmtp.com; s=20251104; t=1781118430; x=1781723230;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VtuZje5ep0/pQroy012NV/DqIdWrSu6s6F3AGCDFIgY=;
 b=qkXgeKPcqDx1sslUHrvvRvsdQHAFiR2xGKQ4wtOg5+8mxlKhDiQDNsp64hmoaEK6Sn
 UTWHdn2F8oa4Y4LV8Jt0wZj7OMfJXuE+2/FWrH/TQ3nc+vGsiy31WKiWCZXsW6ij8M2s
 lxG3FfmyGYweXZogEM+2Hguq6HTvq14vKLGppC+fOwHUZAzEv5u1g3NFgIQmYL5Xb4lK
 REGChigAEx1UUtXke26LYXuiZR7q528VgRFcj1Lh6AZd4y0Mq78BIGVAbiB/m431al1M
 fVOkxLNWB5nTNCuvAHf07LT+9Lo5cp+PwmXz86YXAvrkznyj2RilIM3PjYUI5nW7TSSt
 QW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781118430; x=1781723230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VtuZje5ep0/pQroy012NV/DqIdWrSu6s6F3AGCDFIgY=;
 b=paqIKQBv/lFyLxd0BUKBZ+hZ6pZ8xDbZkjMd/tqbpvwBlJs0CoAC/DkvBeaFWYgKCu
 icjbP6IlxkfeT3vOMSy3k/0khWLoq9VBvs92/CyRUy3lZGhuppOEKKX69LRyAEi2rIC/
 5MpwvysSsnYoIX1HmEAukWqzzxf58mmBBR3RvE5HiLwyANa9tLhxG8IMOH2PBQMiP5Ds
 HSoubP5gVgsPQGERJSVdJmsNrcY+AQsQHLJrluxZUOxGTuv2VuXQ5MaFqrtSluX0kfAR
 mJahvim0DOKi+1cdZUn4JiiwYSgBgUxSvU7DMOYtPKSZSCDooJz7ZIZ3ZAj0kc7Bt78s
 GQPA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/305HSP2PPZjB4L+OrYWuDN3kYZzvK39voFz672eY2uCsshZtLpLnttobD4VpB29rnmKhx0TZu9kdI@nongnu.org
X-Gm-Message-State: AOJu0YwMb+EfhOasWOge1McnJaQqG+47ejOC3vcumpTwhQS72zoCoGYI
 yXSRETrVBQ0C5xeyFLveNh9rgqArxKE5MxWGKHbqJnpt854pZn71kFWE/8vXiban3A==
X-Gm-Gg: Acq92OG9GtBiXGpOe77Cy+gXk0LjjYO/A/BmWyT+p0B3QdQwriZJt12E+BBlB8aubXC
 GPBVrkk4TxSltCeyKv/Lu6JeyuSvTWj4yMXfC/no+bJAVI4LwHWUEY5HjWENWO8CYg7BevAm3O7
 9n1Z5PNjA1jxmY5s5ujUTcq8kpJH2pv63zCiL32nsc5z2qsCKcnoUhi1N+jPwMYc+tFrmRzYUkT
 N9EBeMmERHZBhC5cwz24YsgvgCqFcIZgzvzK7YGMljut0UaSjtRN/ew5jwkQO+DRyUNBtnWb6e+
 P/0XIbAZ4wwSzOhBQ2pW91TnZ0cEsxxG3huRlWz+PLahJIO/my0EeNNQCPupzR+Ly75RM9KtVoP
 jDAAwjt5xHK4FYYQBR9kdtXM6bpix8m5JzXRSm1bIBAYm2I0KdRzW3/psmLZged/V2vILtMIAc3
 vrodA/KArcSrzc8vJKc6g9x8OUsGfTsHRNKforfgabpAb6OxTcGp9tJeaWJxC62mIJZtVpFRcP4
 BnUg/vp9mpUDW27Kl69GKdmRjucA4eqLx1PPyd9gyu2Pok2ppMBhnIkxKFw/DZMvmia/Iq3eQ==
X-Received: by 2002:a17:907:6eaa:b0:beb:2665:f37c with SMTP id
 a640c23a62f3a-bf939b06202mr505544066b.46.1781118430298; 
 Wed, 10 Jun 2026 12:07:10 -0700 (PDT)
Received: from bou-desktop.arnhem.chello.nl
 (2001-1c00-3406-6b00-7381-4d95-f9f6-8b59.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:3406:6b00:7381:4d95:f9f6:8b59])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf051770c7csm1232291066b.12.2026.06.10.12.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 12:07:09 -0700 (PDT)
From: Boudewijn van der Heide <boudewijn@delta-utec.com>
To: kwolf@redhat.com
Cc: boudewijn@delta-utec.com, hreitz@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PATCH] block: switch to co_wrapper_mixed for blk_lock_medium()
 and blk_eject()
Date: Wed, 10 Jun 2026 21:05:48 +0200
Message-ID: <20260610190548.10763-1-boudewijn@delta-utec.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aiksHyfQnJIs_1OH@redhat.com>
References: <aiksHyfQnJIs_1OH@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::531;
 envelope-from=boudewijn@delta-utec.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 10 Jun 2026 15:24:46 -0400
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

> > > > scsi_disk_emulate_command() can be called from a coroutine;
> > > > when req->cmd.buf[0] is ALLOW_MEDIUM_REMOVAL, the synchronous
> > > > blk_lock_medium() is called, which hits assert(!qemu_in_coroutine()),
> > > > and crashes:
> > > > 
> > > > 	qemu-system-hppa: block/block-gen.c:1692: blk_lock_medium:
> > > > 	Assertion `!qemu_in_coroutine()' failed.
> > > > 
> > > > blk_eject() has the same problem, it can be called from coroutine,
> > > > because the same vtable entry (SCSIReqOps.send_command,
> > > > scsi_disk_emulate_command() here) calls blk_eject when req->cmd.buf[0]
> > > > is START_STOP.
> > > > 
> > > > Fix by switching to co_wrapper_mixed for blk_lock_medium() and
> > > > blk_eject() instead of just co_wrapper.
> > > > 
> > > > Signed-off-by: Boudewijn van der Heide <boudewijn@delta-utec.com>
> > > 
> > > Yes, that will fix your immediate symptoms. I'm not completely sure if
> > > that's the level where we want to fix things, though, which is why I
> > > added Paolo and Stefan to Cc.
> > > > ---
> > > > Observed crash on fedora qemu-10.1.5-1.fc43 on x86_64 host using qemu-system-hppa.
> > > > 
> > > > trace:
> > > > 
> > > > Thread 1 (...):
> > > >         # 5 __assert_fail (...) at assert.c
> > > >         # 6 blk_lock_medium (...) at block/block-gen.c
> > > >         # 7 scsi_disk_emulate_command (...) at ../hw/scsi/scsi-disk.c
> > > >         # 8 scsi_req_enqueue (...) at ../hw/scsi/scsi-bus.c
> > > >         # 9 lsi_do_command (...) at ../hw/scsi/lsi53c895a.c
> > > >         # 10 lsi_execute_script (...) at ../hw/scsi/lsi53c895a.c
> > > >         # 11 scsi_read_complete_noio (...) at ../hw/scsi/scsi-disk.c
> > > >         # 12 blk_aio_complete (...) at ../block/block-backend.c
> > > >         # 14 blk_aio_read_entry (...) at ../block/block-backend.c
> > > >         # 15 in coroutine_trampoline (...) at ../util/coroutine-ucontext.c
> > > > 
> > > > blk_eject() has the same path, but req->cmd.buf[0] is START_STOP instead
> > > > of ALLOW_MEDIUM_REMOVAL inside scsi_disk_emulate_command(),
> > > > so fix that aswell.
> > > 
> > > This would be useful information to have in the commit message proper.

I can add that in a later revision if you would want to, do you mean the trace,
or the comment, or both?

> > > 
> > > The step from #10 to #11 seems to be a rather big one that left out
> > > intermediate function calls, so I'm not sure if I fully understand it.
> > > 
> > > Either way, I don't think lsi_execute_script() and the functions called
> > > by it were ever written with the intention to run in a coroutine. I'm
> > > almost sure that problems can be in more than just the two functions
> > > you're changing here. So my question is mostly, should the path involve
> > > a BH somewhere to break out of coroutine context, instead of making one
> > > or two specific cases work?
> > 
> > The code path in this bug is from the block layer (blk_aio_read_entry ->
> > blk_aio_complete) to scsi-disk (scsi_read_complete_noio) into the LSI
> > device (probably lsi_command_complete -> lsi_resume_script ->
> > lsi_execute_script).

IIUC, from what I can see,
we can trace it manually to this
(note; I reversed it to make it more readable):

         # 11 scsi_read_complete_noio (...) at ../hw/scsi/scsi-disk.c

         scsi_read_complete_noio() ->
         scsi_req_data(&r->req, r->qiov.size);
         r->req->bus->info->transfer_data
             // from the &r->req in scsi_req_data() call; 
             // void (*transfer_data) vtable ->

         .transfer_data = lsi_transfer_data,  
             // inside scsibusinfo lsi_scsi_info, for our lsi here ->

         lsi_transfer_data() ->
         lsi_resume_script() ->
         lsi_execute_script() ->
         # 10 lsi_execute_script (...) at ../hw/scsi/lsi53c895a.c

Also for the BH breakout path idea, IMHO it would be a bit hacky.
I tested something local, but I had to defer mid-execution script
to a cb and it would be mimicking essentially what the co_wrapper_mixed
generated code would do.

> > I'm not sure if the LSI device, which is unaware of coroutines, should
> > have to work around this. It seems cleaner for blk_aio_preadv() to
> > invoke cb() from outside coroutine context since that API does not say
> > anything about coroutine contexts.

I'm also not sure if LSI device should handle/intereact with this.

Also I'm not sure that blk_aio_preadv()/blk_aio_prwv()
is the right place for this, we would be changing the API semantics there, no?
blk_aio_preadv() calls blk_aio_prwv(), which takes CoroutineEntry co_entry
and then calls qemu_coroutine_create().

> > On the other hand, there will be a performance overhead for leaving
> > coroutine context even when it would be fine to run in a coroutine...
> 
> Yes, I don't think it should be done by the block layer when most
> callbacks are just fine with running in a coroutine. I was thinking that
> maybe something in the SCSI layer should do it, or even scsi-disk
> specifically. Though of course, if virtio-scsi doesn't have the problem
> (does it?), taking the performance overhead for fixing LSI is probably
> also not what we want.
> 
> Another, more radical solution, could be to move SCSI requests as a
> whole into coroutines, changing the assumption everywhere from
> no_coroutine_fn to coroutine_fn without bothering with mixed functions
> at all. The SCSI state machine is quite complex and I often find the
> control flow in the current callback-based code hard to understand, so I
> think this has the potential to improve the code, though of course it
> would also be a big change.

I think I agree that refactoring SCSI requests all into coroutines
would be a good future approach, however what if there is some path
for SCSI state machine that really can't handle coroutines somewhere
and so then up in the chain you make it no_coroutine_fn,
we would still be leaving other downstream paths which are coroutine safe off the table
and we would be in the same situation as we currently are.

Maybe it's worth considering adding some compile time checking
for the coroutine wrapper generator. 
This would ensure coroutine API being upheld at compile-time.
Though, this might be a pretty big undertaking, with potentially
some compiler specific hacks.

> Or, of course, we just take this patch, and keep fixing instances of
> the problem as they come up.

We can do both IMO, for shorter term we can patch the offending paths
like I did in my patch here and also formulate a long term approach.

> Kevin

Thanks,
Boudewijn

> > > 
> > > > ---
> > > >  include/system/block-backend-io.h | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/include/system/block-backend-io.h b/include/system/block-backend-io.h
> > > > index fd84723d9d..7368ad5c09 100644
> > > > --- a/include/system/block-backend-io.h
> > > > +++ b/include/system/block-backend-io.h
> > > > @@ -81,10 +81,10 @@ bool coroutine_fn GRAPH_RDLOCK blk_co_is_available(BlockBackend *blk);
> > > >  bool co_wrapper_mixed_bdrv_rdlock blk_is_available(BlockBackend *blk);
> > > >  
> > > >  void coroutine_fn blk_co_lock_medium(BlockBackend *blk, bool locked);
> > > > -void co_wrapper blk_lock_medium(BlockBackend *blk, bool locked);
> > > > +void co_wrapper_mixed blk_lock_medium(BlockBackend *blk, bool locked);
> > > >  
> > > >  void coroutine_fn blk_co_eject(BlockBackend *blk, bool eject_flag);
> > > > -void co_wrapper blk_eject(BlockBackend *blk, bool eject_flag);
> > > > +void co_wrapper_mixed blk_eject(BlockBackend *blk, bool eject_flag);
> > > >  
> > > >  int64_t coroutine_fn blk_co_getlength(BlockBackend *blk);
> > > >  int64_t co_wrapper_mixed blk_getlength(BlockBackend *blk);
> > > > -- 
> > > > 2.54.0
> > > > 
> > >

