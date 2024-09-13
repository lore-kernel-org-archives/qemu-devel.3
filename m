Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EF3FC6171
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 18:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spB0R-0005WD-SK; Fri, 13 Sep 2024 14:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1spB0O-0005V4-QD
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 14:26:53 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1spB0L-00047q-Vj
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 14:26:52 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 21C2F1F391;
 Fri, 13 Sep 2024 18:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726252007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eYnqShdg4DZVqs3YStXgkvp85EMlKdu8BH/+WO1Nz3g=;
 b=WcPMC4Af1dUj60NWHwmCldwt2P4acRxlCuCmfBlMBvZre/vGLsa4SveGGx/wsIFtgth58m
 x/cANRqS/Fu0JB1M+3srN9J3dUBoc4whW1Uv2CFS67UmVN0JOHXuxetmw8iXoGAp2ISNCJ
 0sKYn+V8zOcY3AEuWpj/q/nrOzU2sd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726252007;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eYnqShdg4DZVqs3YStXgkvp85EMlKdu8BH/+WO1Nz3g=;
 b=KEpW3OoqnsZLYH10XV2IuVXF/A3of6s/pLQnhE8l2zAVxwoYV0UfT2OM6Z9IK8vPO/YSgA
 nyyxz/ieAmHCaFAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726252007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eYnqShdg4DZVqs3YStXgkvp85EMlKdu8BH/+WO1Nz3g=;
 b=WcPMC4Af1dUj60NWHwmCldwt2P4acRxlCuCmfBlMBvZre/vGLsa4SveGGx/wsIFtgth58m
 x/cANRqS/Fu0JB1M+3srN9J3dUBoc4whW1Uv2CFS67UmVN0JOHXuxetmw8iXoGAp2ISNCJ
 0sKYn+V8zOcY3AEuWpj/q/nrOzU2sd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726252007;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eYnqShdg4DZVqs3YStXgkvp85EMlKdu8BH/+WO1Nz3g=;
 b=KEpW3OoqnsZLYH10XV2IuVXF/A3of6s/pLQnhE8l2zAVxwoYV0UfT2OM6Z9IK8vPO/YSgA
 nyyxz/ieAmHCaFAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B8A713A72;
 Fri, 13 Sep 2024 18:26:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ltz+F+aD5GaAAwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 13 Sep 2024 18:26:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: mail@maciej.szmigiero.name, Alex Williamson
 <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, Eric
 Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 12/17] migration/multifd: Device state transfer
 support - send side
In-Reply-To: <ZuRYouLwikc4OYye@x1n>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <fdcfd68dfcf3b20278a4495eb639905b2a8e8ff3.1724701542.git.maciej.szmigiero@oracle.com>
 <87h6b4nosy.fsf@suse.de> <ZuCickYhs3nf2ERC@x1n> <87zfoc1zms.fsf@suse.de>
 <ZuOGAb3988ExsrHi@x1n> <87o74r1yfw.fsf@suse.de> <ZuRJ8i4T_vUzrawY@x1n>
 <87ldzv1tpb.fsf@suse.de> <ZuRYouLwikc4OYye@x1n>
Date: Fri, 13 Sep 2024 15:26:43 -0300
Message-ID: <87a5gb1kbg.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Peter Xu <peterx@redhat.com> writes:

> On Fri, Sep 13, 2024 at 12:04:00PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Fri, Sep 13, 2024 at 10:21:39AM -0300, Fabiano Rosas wrote:
>> >> Peter Xu <peterx@redhat.com> writes:
>> >> 
>> >> > On Thu, Sep 12, 2024 at 03:43:39PM -0300, Fabiano Rosas wrote:
>> >> >> Peter Xu <peterx@redhat.com> writes:
>> >> >> 
>> >> >> Hi Peter, sorry if I'm not very enthusiastic by this, I'm sure you
>> >> >> understand the rework is a little frustrating.
>> >> >
>> >> > That's OK.
>> >> >
>> >> > [For some reason my email sync program decided to give up working for
>> >> >  hours.  I got more time looking at a tsc bug, which is good, but then I
>> >> >  miss a lot of emails..]
>> >> >
>> >> >> 
>> >> >> > On Wed, Aug 28, 2024 at 09:41:17PM -0300, Fabiano Rosas wrote:
>> >> >> >> > +size_t multifd_device_state_payload_size(void)
>> >> >> >> > +{
>> >> >> >> > +    return sizeof(MultiFDDeviceState_t);
>> >> >> >> > +}
>> >> >> >> 
>> >> >> >> This will not be necessary because the payload size is the same as the
>> >> >> >> data type. We only need it for the special case where the MultiFDPages_t
>> >> >> >> is smaller than the total ram payload size.
>> >> >> >
>> >> >> > Today I was thinking maybe we should really clean this up, as the current
>> >> >> > multifd_send_data_alloc() is indeed too tricky (blame me.. who requested
>> >> >> > that more or less).  Knowing that VFIO can use dynamic buffers with ->idstr
>> >> >> > and ->buf (I was thinking it could be buf[1M].. but I was wrong...) made
>> >> >> > that feeling stronger.
>> >> >> 
>> >> >> If we're going to commit bad code and then rewrite it a week later, we
>> >> >> could have just let the original series from Maciej merge without any of
>> >> >> this.
>> >> >
>> >> > Why it's "bad code"?
>> >> >
>> >> > It runs pretty well, I don't think it's bad code.  You wrote it, and I
>> >> > don't think it's bad at all.
>> >> 
>> >> Code that forces us to do arithmetic in order to properly allocate
>> >> memory and comes with a big comment explaining how we're dodging
>> >> compiler warnings is bad code in my book.
>> >> 
>> >> >
>> >> > But now we're rethinking after reading Maciej's new series.
>> >> >Personally I don't think it's a major problem.
>> >> >
>> >> > Note that we're not changing the design back: what was initially proposed
>> >> > was the client submitting an array of multifd objects.  I still don't think
>> >> > that's right.
>> >> >
>> >> > What the change goes so far is we make the union a struct, however that's
>> >> > still N+2 objects not 2*N, where 2 came from RAM+VFIO.  I think the
>> >> > important bits are still there (from your previous refactor series).
>> >> >
>> >> 
>> >> You fail to appreciate that before the RFC series, multifd already
>> >> allocated N for the pages.
>> >
>> > It depends on how you see it, IMHO.  I think it allocates N not for the
>> > "pages" but for the "threads", because the threads can be busy with those
>> > buffers, no matter if it's "page" or "device data".
>> 
>> Each MultiFD*Params had a p->pages, so N channels, N p->pages. The
>> device state series would add p->device_state, one per channel. So 2N +
>> 2 (for the extra slot).
>
> Then it makes sense to have SendData covering pages+device_state.  I think
> it's what we have now, but maybe I missed the point.

I misunderstood you. You're saying that you see the N as per-thread
instead of per-client-per-thread. That's one perspective indeed. It was
not what the device state series had going for it, so I still think that
this could have been a separate discussion independent of the p->pages
-> p->data change. But let's not drag this argument on, it's been
discussed and the code has been merged.

>
>> 
>> >
>> >> The device state adds another client, so that
>> >> would be another N anyway. The problem the RFC tried to solve was that
>> >> multifd channels owned that 2N, so the array was added to move the
>> >> memory into the client's ownership. IOW, it wasn't even the RFC series
>> >> that made it 2N, that was the multifd design all along. Now in hindsight
>> >> I don't think we should have went with the memory saving discussion.
>> >
>> > I think I could have made that feeling that I only wanted to save memory,
>> > if so, I'm sorry.  But do you still remember I mentioned "we can make it a
>> > struct, too" before your series landed?  Then you think it's ok to keep
>> > using union, and I'm ok too! At least at that time.  I don't think that's a
>> > huge deal.  I don't think each route we go must be perfect, but we try the
>> > best to make it as good.
>> 
>> Yep, I did agree with all of this. I'm just saying I now think I
>> shouldn't have.
>> 
>> >
>> > I don't think any discussion must not happen.  I agree memory consumption
>> > is not the 1st thing to worry, but I don't see why it can't be discussed.
>> 
>> It can be discussed, sure, but then 3 months pass and we're still
>> talking about it. Saved ~64k and spent 3 months. We could have just as
>> well said: "let's do a pass to optimize memory consumption after the
>> device state series is in".
>
> We didn't discuss 3 months on discussing memory consumption only!  It's
> unfair to think it like that.

Ok, you're right.

>
>> 
>> >
>> > Note that I never said we can't save those memory either - I plan to have
>> > follow up patches (for this, after Maciej's series land.. that's why I even
>> > didn't yet mention) to allow modules report device state buffer size.  I
>> > just didn't say, yet, and don't plan to worry before vfio series lands.
>> > When with that, we'll save 1M*N when no vfio device attached (but we'll
>> > need to handle hotplug).  So I think we don't need to lose any finally.
>> >
>> > However I think we need to get straight with the base design on how vfio
>> > should use multifd, because it's important bit and I don't want to rework
>> > important bits after a huge feature, if we know a better directions.
>> >
>> > I don't even think what I proposed patch 1-3 here is a must to me, I should
>> > be clear again here just in case we have similar discussions
>> > afterwards.. that I'm ok with below be done after Maciej's:
>> >
>> >   - Avoid memory allocations per-packet (done in patch 2-3)
>> >   - Avoid unnecessary data copy (done in patch 2-3)
>> >   - Avoid allocate device buffers when no device will use (not proposed)
>> >
>> > But I'm not ok building everything on top of the idea of not using multifd
>> > buffers in the current way, because that can involve a lot of changes:
>> > that's where buffer passes from up to down or backwards, and the interface
>> > needs change a lot too.  We already have that in master so it's not a
>> > problem now.
>> >
>> >> 
>> >> >> I already suggested it a couple of times, we shouldn't be doing
>> >> >> core refactorings underneath contributors' patches, this is too
>> >> >> fragile. Just let people contribute their code and we can change it
>> >> >> later.
>> >> >
>> >> > I sincerely don't think a lot needs changing... only patch 1.  Basically
>> >> > patch 1 on top of your previous rework series will be at least what I want,
>> >> > but I'm open to comments from you guys.
>> >> 
>> >> Don't get me wrong, I'm very much in favor of what you're doing
>> >> here. However, I don't think it's ok to be backtracking on our design
>> >> while other people have series in flight that depend on it. You
>> >> certainly know the feeling of trying to merge a feature and having
>> >> maintainers ask you to rewrite a bunch code just to be able to start
>> >> working. That's not ideal.
>> >
>> > I as a patch writer always like to do that when it's essential.  Normally
>> > the case is I don't have enough reviewer resources to help me get a better
>> > design, or discuss about it.
>> 
>> Right, but we can't keep providing a moving target. See the thread pool
>> discussion for an example. It's hard to work that way. The discussion
>> here is similar, we introduced the union, now we're moving to the
>> struct. And you're right that the changes here are small, so let's not
>> get caught in that.
>
> What's your suggestion on the thread pool?  Should we merge the change
> where vfio creates the threads on its own (assuming vfio maintainers are ok
> with it)?

This is not a simple answer and I'm not exactly sure where to draw the
line, but in this case I'm inclined to say: yes.

>
> I would say no, that's what I suggested.  I'd start with reusing
> ThreadPool, then we found issue when Stefan reported worry on abusing the
> API.  All these discussions seem sensible to me so far.  We can't rush on
> these until we figure things out step by step.  I don't see a way.

The problem is that using a thread pool is something that we've agreed
on for a while and is even in the migration TODO list. It's not
something that came up as a result of the device state series. I know
this is not anyone's intent, but it starts to feel like gatekeeping.

The fact that migration lacks a thread pool, that multifd threads have
historically caused issues and that what's in util/thread-pool.c is only
useful to the block layer are all preexisting problems of this code
base. We could be (and are) working to improve those regardless of what
new features are being contributed. I'm not sure it's productive to pick
problems we have had for a while and present those as prerequisites for
merging new code.

But as I said, there's a line to be drawn somewhere and I don't know
exactly where it lies. I understand the points that were brought up in
favor of first figuring out the thread pool situation, those are not at
all unreasonable.

>
> I saw Cedric suggesting to not even create a thread on recv side.  I am not
> sure whether that's easy, but I'd agree with Cedric if possible.  I think
> Maciej could have a point where it can block mutlifd threads, aka, IO
> threads, which might be unwanted.
>
> However said that, I still think device (even if threads needed) should not
> randomly create threads during migration.  It'll be a nightmare.

The thread-pool approach is being looked at to solve this particular
problem, but we have also discussed in the past that multifd threads
themselves should be managed by a thread pool. Will we add this
requirement to what is being done now? Otherwise, don't we risk having
an implementation that doesn't serve the rest of multifd? Do we even
know what the requirements are? Keep in mind that we're already not
modifying the existing ThreadPool, but planning to write a new one.

>
>> 
>> >
>> > When vfio is the new user of multifd vfio needs to do the heavy lifting to
>> > draft the api.
>> 
>> Well, multifd could have provided a flexible API to being with. That's
>> entirely on us. I have been toying with allowing more clients since at
>> least 1 year ago. We just couldn't get there in time.
>> 
>> >
>> >> 
>> >> I tried to quickly insert the RFC series before the device state series
>> >> progressed too much, but it's 3 months later and we're still discussing
>> >> it, maybe we don't need to do it this way.
>> >
>> > Can I get that of your feeling from when you were working on
>> > mapped-ram?
>> 
>> At that time I had already committed to helping maintain the code, so
>> the time spent there already went into the maintainer bucket anyway. If
>> I were instead just trying to drive-by, then that would have been a
>> pain.
>
> I don't think you became a maintainer changed how I would review mapped-ram
> series.
>
> OTOH, "I became a maintainer" could, because I know I am more responsible
> to a chunk of code until I leave (and please let me know any time when you
> think you're ready to take migration on your own).  That's a real
> difference to me.

Right, that's my point. I don't mind that what I'm doing takes time. I'm
not going anywhere. I do mind that because we're not going anywhere, we
start to drag people into a constant state of improving the next little
thing. Again, our definition of what constitutes "a little thing" is of
course different.

>
>> 
>> > That series does take long enough, I agree.  Not so bad yet with the VFIO
>> > series - it's good to have you around because you provide great reviews.
>> > I'm also trying the best to not let a series dangle for more than a year.
>> > I don't think 3 months is long with this feature: this is the 1st multifd
>> > extrenal user (and file mapping is also in another angle), it can take some
>> > time.
>> 
>> Oh, I don't mean the VFIO series is taking long. That's a complex
>> feature indeed. I just mean going from p->pages to p->data could have
>> taken less time. I'm suggesting we might have overdone there a bit.
>> 
>> >
>> > Sorry if it's so, but sorry again I don't think I get convinced: I think we
>> > need to go this way to build blocks one by one, and we need to make sure
>> > lower blocks are hopefully solid enough to take the upper ones.  Again I'm
>> > ok with small things that go against it, but not major designs.  We
>> > shouldn't go rewrite major designs if we seem to know a better one.
>> >
>> >> 
>> >> And ok, let's consider the current situation a special case. But I would
>> >> like to avoid in the future this kind of uncertainty. 
>> >> 
>> >> >
>> >> > Note that patch 2-3 will be on top of Maciej's changes and they're totally
>> >> > not relevant to what we merged so far.  Hence, nothing relevant there to
>> >> > what you worked.  And this is the diff of patch 1:
>> >> >
>> >> >  migration/multifd.h              | 16 +++++++++++-----
>> >> >  migration/multifd-device-state.c |  8 ++++++--
>> >> >  migration/multifd-nocomp.c       | 13 ++++++-------
>> >> >  migration/multifd.c              | 25 ++++++-------------------
>> >> >  4 files changed, 29 insertions(+), 33 deletions(-)
>> >> >
>> >> > It's only 33 lines removed (many of which are comments..), it's not a huge
>> >> > lot.  I don't know why you feel so bad at this...
>> >> >
>> >> > It's probably because we maintain migration together, or we can keep our
>> >> > own way of work.  I don't think we did anything wrong yet so far.
>> >> >
>> >> > We can definitely talk about this in next 1:1.
>> >> >
>> >> >> 
>> >> >> This is also why I've been trying hard to separate core multifd
>> >> >> functionality from migration code that uses multifd to transmit their
>> >> >> data.
>> >> >> 
>> >> >> My original RFC plus the suggestion to extend multifd_ops for device
>> >> >> state would have (almost) made it so that no client code would be left
>> >> >> in multifd. We could have been turning this thing upside down and it
>> >> >> wouldn't affect anyone in terms of code conflicts.
>> >> >
>> >> > Do you mean you preferred the 2*N approach?
>> >> >
>> >> 
>> >> 2*N, where N is usually not larger than 32 and the payload size is
>> >> 1k. Yes, I'd trade that off no problem.
>> >
>> > I think it's a problem.
>> >
>> > Vdpa when involved with exactly the same pattern of how vfio uses it (as
>> > they're really alike underneath) then vdpa will need its own array of
>> > buffers, or it'll need to take the same vfio lock which doesn't make sense
>> > to me.
>> >
>> > N+2, or, N+M (M is the user) is the minimum buffers we need.  N because
>> > multifd can be worst case 100% busy on all threads occupying the buffers.
>> > M because M users can be worst case 100% pre-filling.  It's either about
>> > memory consumption, or about logical sensibility.
>> 
>> I'm aware of the memory consumption. Still, we're not forced to use the
>> minimum amount of space we can. If using more memory can lead to a
>> better design in the medium term, we're allowed to make that choice.
>> 
>> Hey, I'm not even saying we *should* have gone with 2N. I think it's
>> good that we're now N+M. But I think we also lost some design
>> flexibility due to that.
>> 
>> >
>> >> 
>> >> >> 
>> >> >> The ship has already sailed, so your patches below are fine, I have just
>> >> >> some small comments.
>> >> >
>> >> > I'm not sure what you meant about "ship sailed", but we should merge code
>> >> > whenever we think is the most correct.
>> >> 
>> >> As you put above, I agree that the important bits of the original series
>> >> have been preserved, but other secondary goals were lost, such as the
>> >> more abstract separation between multifd & client code and that is the
>> >> ship that has sailed.
>> >> 
>> >> That series was not: "introduce this array for no reason", we also lost
>> >> the ability to abstract the payload from the multifd threads when we
>> >> dropped the .alloc_fn callback for instance. The last patch you posted
>> >
>> > I don't remember the details there, but my memory was that it was too
>> > flexible while we seem to reach the consensus that we only process either
>> > RAM or device, nothing else.
>> 
>> Indeed. I'm being unfair here, sorry.
>> 
>> >
>> >> here now adds multifd_device_state_prepare, somewhat ignoring that the
>> >> ram code also has the same pattern and it could be made to use the same
>> >> API.
>> >
>> > I need some further elaborations to understand.
>> >
>> > multifd_device_state_prepare currently does a few things: taking ownership
>> > of the temp device state object, fill in idstr / instance_id, taking the
>> > lock (so far is needed because we only have one device state object).  None
>> > of them seems to be needed for RAM yet.
>> >
>> > Feel free to send a rfc patch if that helps.
>> 
>> What if I don't send a patch, wait for it to get merged and then send a
>> refactoring on top so we don't add yet another detour to this
>> conversation? =)
>
> I thought it shouldn't conflict much if with ram only, and I used to mean
> that can be a "comment in the form of patch".  But yeah, sure thing.

