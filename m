Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CD8EB2700
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 21:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpv8s-0000rU-44; Tue, 10 Feb 2026 16:19:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vpv8q-0000qt-NQ
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 16:19:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vpv8n-0004fi-MD
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 16:19:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770758363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5GDPOHrKUf+sixRUQzb7aTOFE5CJDv4TiQsg14Jm2Xg=;
 b=apmSub+TV5ZxvMU6Rgvk9yXuq2V2cJEU319XJ6HIpXgJQdvf6pOFIVzO09xt8NO+qLTV96
 KiWMpTYeNO+k6Kq+kssySgFCSO5c5rI1zU6YMwyn62nMuyKmC3OU7xXrovZ6dDDeSx069u
 KEv8YoUi9AoASad1JnI4D2zo4MS+AOM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-ytOdGnxfNBSvGtrCit4xZA-1; Tue,
 10 Feb 2026 16:19:17 -0500
X-MC-Unique: ytOdGnxfNBSvGtrCit4xZA-1
X-Mimecast-MFC-AGG-ID: ytOdGnxfNBSvGtrCit4xZA_1770758356
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0CCBD18004AD; Tue, 10 Feb 2026 21:19:16 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.253])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C24E19560A3; Tue, 10 Feb 2026 21:19:13 +0000 (UTC)
Date: Tue, 10 Feb 2026 22:19:11 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: Jean-Louis Dupond <jean-louis@dupond.be>, qemu-devel@nongnu.org,
 dionbosschieter@gmail.com
Subject: Re: (in guest) disk corruption during snapshots
Message-ID: <aYugz2szo3Y9dVMd@redhat.com>
References: <4853b0e5-8ec3-41e9-9a53-b1912b8e4449@dupond.be>
 <aef520c2-3296-4eb4-999c-faa757c9b2a3@proxmox.com>
 <aYRi660MmeMtobZG@redhat.com>
 <d909ce08-c2eb-4eff-b973-498456dec12c@proxmox.com>
 <aYTE9hf0mMTOUUTJ@redhat.com>
 <85464bcb-2cb5-4cef-b6ef-8f309d6f7d8e@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85464bcb-2cb5-4cef-b6ef-8f309d6f7d8e@proxmox.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 09.02.2026 um 12:42 hat Fiona Ebner geschrieben:
> Am 05.02.26 um 5:26 PM schrieb Kevin Wolf:
> > Am 05.02.2026 um 11:45 hat Fiona Ebner geschrieben:
> >> Am 05.02.26 um 10:28 AM schrieb Kevin Wolf:
> >>> Am 05.02.2026 um 09:59 hat Fiona Ebner geschrieben:
> >>>> Hi,
> >>>>
> >>>> Am 03.02.26 um 3:24 PM schrieb Jean-Louis Dupond:
> >>>>> Hi,
> >>>>>
> >>>>> Since some months we were observing disk corruption within the VM when
> >>>>> enabling backups (which triggers snapshots).
> >>>>> After a lot of troubleshooting, we were able to track down the commit
> >>>>> that caused it:
> >>>>> https://gitlab.com/qemu-project/qemu/-/
> >>>>> commit/058cfca5645a9ed7cb2bdb77d15f2eacaf343694
> >>>>>
> >>>>> More info in the issue:
> >>>>> https://gitlab.com/qemu-project/qemu/-/issues/3273
> >>>>>
> >>>>> Now this seems to be caused by a race between disabling the
> >>>>> dirty_bitmaps and the tracking implemented in the mirror top layer.
> >>>>> Kevin shared me a possible solution:
> >>>>>
> >>>>> diff --git a/block/mirror.c b/block/mirror.c
> >>>>> index b344182c747..f76e43f22c1 100644
> >>>>> --- a/block/mirror.c
> >>>>> +++ b/block/mirror.c
> >>>>> @@ -1122,6 +1122,9 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
> >>>>>       * accessing it.
> >>>>>       */
> >>>>>      mirror_top_opaque->job = s;
> >>>>> +    if (s->copy_mode != MIRROR_COPY_MODE_WRITE_BLOCKING) {
> >>>>> +        bdrv_disable_dirty_bitmap(s->dirty_bitmap);
> >>>>> +    }
> >>>>>  
> >>>>>      assert(!s->dbi);
> >>>>>      s->dbi = bdrv_dirty_iter_new(s->dirty_bitmap);
> >>>>> @@ -2018,7 +2021,9 @@ static BlockJob *mirror_start_job(
> >>>>>       * The dirty bitmap is set by bdrv_mirror_top_do_write() when not in active
> >>>>>       * mode.
> >>>>>       */
> >>>>> -    bdrv_disable_dirty_bitmap(s->dirty_bitmap);
> >>>>> +    if (s->copy_mode == MIRROR_COPY_MODE_WRITE_BLOCKING) {
> >>>>> +        bdrv_disable_dirty_bitmap(s->dirty_bitmap);
> >>>>> +    }
> >>>>>  
> >>>>>      bdrv_graph_wrlock_drained();
> >>>>>      ret = block_job_add_bdrv(&s->common, "source", bs, 0,
> >>>>>
> >>>>>
> >>>>> Running this for some hours already, and it seems to fix the issue.
> >>>>>
> >>>>> Let's open up the discussion if this is the proper way to fix it, or if
> >>>>> there are better alternatives :)
> >>>>
> >>>> Yes, I do think this is the proper solution. I ended up with essentially
> >>>> the same yesterday (see the Gitlab issue). I moved the disabling
> >>>> unconditionally, but there should be no need to delay the disabling if
> >>>> using write-blocking mode. I would suggest moving the comment on top of
> >>>> the changed hunk in mirror_start_job() along to the new hunk in
> >>>> mirror_run().
> >>>
> >>> I didn't actually write this as a proper patch, but just as a quick
> >>> thing Jean-Louis could test, so yes, all of the details are up for
> >>> discussion.
> >>>
> >>> You're right that there is no need to delay disabling the bitmap in
> >>> active mode, but it probably also doesn't hurt to keep it enabled for a
> >>> little while? Maybe we should do it like you did just to keep the code a
> >>> little simpler.
> >>
> >> Yes, it shouldn't hurt. Looking at the code again,
> >> should_copy_to_target() will evaluate to false before the job is set, so
> >> it might be necessary for write-blocking mode too?
> > 
> > I didn't check that part yet, but that is actually a very good point!
> > 
> > Yes, I agree, so your version of the fix is even more correct. It seems
> > write blocking mode is not actually write blocking until the very same
> > point in the code. (We should mention that in the comment as well.)
> > 
> >>> There is another approach I had in mind, but wasn't as sure about, so I
> >>> didn't suggest it for the testing to see if this race is even the
> >>> problem we're seeing in practice: Is there a reason why populating the
> >>> initial dirty bitmap (i.e. the second part of mirror_dirty_init()) can't
> >>> just come after setting 'mirror_top_opaque->job'? Then we could simply
> >>> leave the bitmap disabled all the time and rely solely on the mirror
> >>> job's own tracking. That would feel a little more consistent than using
> >>> the block layer just to plug a small race window during startup.
> >>
> >> Interesting idea! In write-blocking mode, it will lead to writes during
> >> dirty bitmap initialization already being synced to the target, so
> >> leading to a bit of duplicate work.
> > 
> > That's true, and I don't see an easy way to avoid it if we do things in
> > this order. Probably not a big deal in practice, but also a bit ugly.
> 
> We do support changing the copy mode after the job is started (see
> mirror_change()). If we really want to avoid the duplicate work, we
> could always start in background mode and switch to write-blocking only
> after initializing the bitmap, if that's what the user wanted. There is
> a comment in mirror_change() stating:
> 
> The implementation relies on the fact that copy_mode is only written
> under the BQL. Otherwise, further synchronization would be required.
> 
> so we'd need to be careful if going for this. Discussion from back then:
> https://lore.kernel.org/qemu-devel/ZTAO+TJuztCHDsUW@redhat.com/

Yes, I guess that could be done.

I'm not sure if that's really worthwhile, though, when we know that just
disabling the bitmap later does the trick without adding much code and
having to be careful.

So I'm currently inclined to just take your patch and file my thought
away as an interesting idea without practical use.

> >> Git history tells me why setting the job ended up where it is now:
> >>
> >>> commit 32125b14606a454ed109ea6d9da32c747e94926f
> >>> Author: Kevin Wolf <kwolf@redhat.com>
> >>> Date:   Fri Feb 3 16:21:41 2023 +0100
> >>>
> >>>     mirror: Fix access of uninitialised fields during start
> >>>     
> >>>     bdrv_mirror_top_pwritev() accesses the job object when active mirroring
> >>>     is enabled. It disables this code during early initialisation while
> >>>     s->job isn't set yet.
> >>>     
> >>>     However, s->job is still set way too early when the job object isn't
> >>>     fully initialised. For example, &s->ops_in_flight isn't initialised yet
> >>>     and the in_flight bitmap doesn't exist yet. This causes crashes when a
> >>>     write request comes in too early.
> >>>     
> >>>     Move the assignment of s->job to when the mirror job is actually fully
> >>>     initialised to make sure that the mirror_top driver doesn't access it
> >>>     too early.
> >>
> >> Right before initializing the dirty bitmap, the other fields of the job
> >> object are already initialized, so the problem described in that commit
> >> message should not resurface.
> >>
> >> That said, not sure I'm not missing something.
> > 
> > Yes, I think it requires splitting mirror_dirty_init() as I said, but
> > otherwise I don't see a problem at the moment. I could still be missing
> > something, of course.
> > 
> >> Something else I'm wondering about: do we need to use atomics for
> >> setting and accessing MirrorBDSOpaque.job? At least with virtio-blk
> >> using iothread-vq-mapping, mirror_run() and bdrv_mirror_top_do_write()
> >> might be called in different threads.
> > 
> > This might not even be enough. At first I thought that barriers might be
> > enough to make sure that MirrorBDSOpaque.job is set before the bitmap is
> > disabled. But bdrv_set_dirty() with its check if the dirty bitmap is
> > enabled happens only in bdrv_co_write_req_finish() after the request
> > completes. So we have a race where the switch could happen while a
> > request is in the middle between mirror_top_bs and bdrv_set_dirty() and
> > neither place would mark the request dirty.
> 
> This is for the approach with setting job and then disabling the bitmap
> in mirror_run().

Yes.

> With your suggestion of having the bitmap disabled from the beginning
> and setting the job before initializing the bitmap, using barriers would
> be enough, or?

It's not obvious what the barrier would synchronise with. Correct me if
I'm wrong, the idea is that the two possible cases are:

1. Some request started in mirror_top_bs while s->job == NULL. This
   implies copy_to_target == false.
2. Set mirror_top_opaque->job
3. The request completes, sees s->job and calls bdrv_set_dirty_bitmap()

1. Some request started in mirror_top_bs while s->job == NULL
2. Set mirror_top_opaque->job
3. The request completes, still sees s->job == NULL and skips the bitmap
4. mirror_dirty_init() -> bdrv_co_is_allocated_above() picks up the
   change and dirties the bitmap

The important question is if this bad case is possible, too:

1. Some request started in mirror_top_bs while s->job == NULL
2. Set mirror_top_opaque->job
3. mirror_dirty_init() -> bdrv_co_is_allocated_above() runs and because
   the request hasn't completed yet, the block isn't allocated
4. The request completes, still sees s->job == NULL and skips the
   bitmap, and nothing else will mark it dirty either

And that is where atomics/barriers will make sure that the new s->job is
seen in bdrv_mirror_top_do_write(). Ok, fair enough, but it doesn't feel
obvious and I'm still confused what the best qemu/atomic.h operation for
this is.

Let me try another angle:

The whole trouble starts with the possibility of having !copy_to_target
&& !s->job in bdrv_mirror_top_do_write() and then we neither copy nor
mark something dirty. What if we still have the dirty bitmap enabled on
the block layer level and explicitly handle the !copy_to_target &&
!s->job case by calling bdrv_set_dirty() in bdrv_mirror_top_do_write()?
bdrv_set_dirty_bitmap() is then just the slightly optimised version for
once the job has finished initialisation.

During job startup we would then usually call bdrv_set_dirty() twice,
but who cares? And it would fix the race because then we're guaranteed
that bdrv_mirror_top_do_write() either copies or sets a dirty bit, but
it never does neither.

Kevin


