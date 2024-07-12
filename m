Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC93C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSFdF-0002Up-Af; Fri, 12 Jul 2024 08:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sSFdD-0002P4-9d
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 08:44:11 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sSFdA-0000Rd-TW
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 08:44:10 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6242C21A1F;
 Fri, 12 Jul 2024 12:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720788245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ln5H0faH2X3ItvkjD27FpT0h9R6pzu5+PtbgOiUq0KI=;
 b=Q/xLe74ihv3ygRJlcOASyU51eS9IiA5WTT7dWoitmmHKx31hVjfNgDunplS0vvSZ8ghvmD
 q8BwNRvBgpu3TZl7QGK5hpLUekyQ+oYuNjvqHtnDZ8MPOzy6LLeTjEKAz5B76sXFY1ySNJ
 i1uZ2IksMnN3Z7G+aQQ0TlwuFbqtMtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720788245;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ln5H0faH2X3ItvkjD27FpT0h9R6pzu5+PtbgOiUq0KI=;
 b=syt5eCXGvyDF/mBV0dwsiI1plJe2UaDdc8XgK74R5czxxMy3lZ+dXgChEj97TPFfJguvJQ
 LilE3XroW6o+CYAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720788245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ln5H0faH2X3ItvkjD27FpT0h9R6pzu5+PtbgOiUq0KI=;
 b=Q/xLe74ihv3ygRJlcOASyU51eS9IiA5WTT7dWoitmmHKx31hVjfNgDunplS0vvSZ8ghvmD
 q8BwNRvBgpu3TZl7QGK5hpLUekyQ+oYuNjvqHtnDZ8MPOzy6LLeTjEKAz5B76sXFY1ySNJ
 i1uZ2IksMnN3Z7G+aQQ0TlwuFbqtMtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720788245;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ln5H0faH2X3ItvkjD27FpT0h9R6pzu5+PtbgOiUq0KI=;
 b=syt5eCXGvyDF/mBV0dwsiI1plJe2UaDdc8XgK74R5czxxMy3lZ+dXgChEj97TPFfJguvJQ
 LilE3XroW6o+CYAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2AEF1373E;
 Fri, 12 Jul 2024 12:44:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aXPzKRQlkWY6WAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 12 Jul 2024 12:44:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: "Wang, Lei" <lei4.wang@intel.com>, qemu-devel@nongnu.org, "Maciej S .
 Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH 6/7] migration/multifd: Move payload storage out of
 the channel parameters
In-Reply-To: <ZpBXejPa8Vac6ZqG@x1n>
References: <Zn15y693g0AkDbYD@x1n> <877cdtfcsi.fsf@suse.de>
 <Zo7cncqkxB89AUBe@x1n> <87y169dmu3.fsf@suse.de> <Zo8DaHbWlrNe3RXL@x1n>
 <87msmodnly.fsf@suse.de> <ZpAEIvbNr-ANuASV@x1n> <87bk33en41.fsf@suse.de>
 <ZpBAL3U6G46OBGEN@x1n> <878qy7eipf.fsf@suse.de> <ZpBXejPa8Vac6ZqG@x1n>
Date: Fri, 12 Jul 2024 09:44:02 -0300
Message-ID: <875xtaeq5p.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.30 / 50.00];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_THREE(0.00)[4]; MID_RHS_MATCH_FROM(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

> On Thu, Jul 11, 2024 at 06:12:44PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Thu, Jul 11, 2024 at 04:37:34PM -0300, Fabiano Rosas wrote:
>> >
>> > [...]
>> >
>> >> We also don't flush the iov at once, so f->buf seems redundant to
>> >> me. But of course, if we touch any of that we must ensure we're not
>> >> dropping any major optimization.
>> >
>> > Yes some tests over that would be more persuasive when it comes.
>> >
>> > Per my limited experience in the past few years: memcpy on chips nowadays
>> > is pretty cheap.  You'll see very soon one more example of that when you
>> > start to look at the qatzip series: that series decided to do one more
>> > memcpy for all guest pages, to make it a larger chunk of buffer instead of
>> > submitting the compression tasks in 4k chunks (while I thought 4k wasn't
>> > too small itself).
>> >
>> > That may be more involved so may not be a great example (e.g. the
>> > compression algo can be special in this case where it just likes larger
>> > buffers), but it's not uncommon that I see people trade things with memcpy,
>> > especially small buffers.
>> >
>> > [...]
>> >
>> >> Any piece of code that fills an iov with data is prone to be able to
>> >> send that data through multifd. From this perspective, multifd is just a
>> >> way to give work to an iochannel. We don't *need* to use it, but it
>> >> might be simple enough to the point that the benefit of ditching
>> >> QEMUFile can be reached without too much rework.
>> >> 
>> >> Say we provision multifd threads early and leave them waiting for any
>> >> part of the migration code to send some data. We could have n-1 threads
>> >> idle waiting for the bulk of the data and use a single thread for any
>> >> early traffic that does not need to be parallel.
>> >> 
>> >> I'm not suggesting we do any of this right away or even that this is the
>> >> correct way to go, I'm just letting you know some of my ideas and why I
>> >> think ram + device state might not be the only data we put through
>> >> multifd.
>> >
>> > We can wait and see whether that can be of any use in the future, even if
>> > so, we still have chance to add more types into the union, I think.  But
>> > again, I don't expect.
>> >
>> > My gut feeling: we shouldn't bother putting any (1) non-huge-chunk, or (2)
>> > non-IO, data onto multifd.  Again, I would ask "why not the main channel",
>> > otherwise.
>> >
>> > [...]
>> >
>> >> Just to be clear, do you want a thread-pool to replace multifd? Or would
>> >> that be only used for concurrency on the producer side?
>> >
>> > Not replace multifd.  It's just that I was imagining multifd threads only
>> > manage IO stuff, nothing else.
>> >
>> > I was indeed thinking whether we can reuse multifd threads, but then I
>> > found there's risk mangling these two concepts, as: when we do more than IO
>> > in multifd threads (e.g., talking to VFIO kernel fetching data which can
>> > block), we have risk of blocking IO even if we can push more so the NICs
>> > can be idle again.  There's also the complexity where the job fetches data
>> > from VFIO kernel and want to enqueue again, it means an multifd task can
>> > enqueue to itself, and circular enqueue can be challenging: imagine 8
>> > concurrent tasks (with a total of 8 multifd threads) trying to enqueue at
>> > the same time; they hunger themselves to death.  Things like that.  Then I
>> > figured the rest jobs are really fn(void*) type of things; they should
>> > deserve their own pool of threads.
>> >
>> > So the VFIO threads (used to be per-device) becomes migration worker
>> > threads, we need them for both src/dst: on dst there's still pending work
>> > to apply the continuous VFIO data back to the kernel driver, and that can't
>> > be done by multifd thread too due to similar same reason.  Then those dest
>> > side worker threads can also do load() not only for VFIO but also other
>> > device states if we can add more.
>> >
>> > So to summary, we'll have:
>> >
>> >   - 1 main thread (send / recv)
>> >   - N multifd threads (IOs only)
>> >   - M worker threads (jobs only)
>> >
>> > Of course, postcopy not involved..  How's that sound?
>> 
>> Looks good. There's a better divide between producer and consumer this
>> way. I think it will help when designing new features.
>> 
>> One observation is that we'll still have two different entities doing IO
>> (multifd threads and the migration thread), which I would prefer were
>> using a common code at a higher level than the iochannel.
>
> At least for the main channel probably yes.  I think Dan has had the idea
> of adding the buffering layer over iochannels, then replace qemufiles with
> that.  Multifd channels looks ok so far to use as raw channels.
>
>> 
>> One thing that I tried to look into for mapped-ram was whether we could
>> set up iouring in the migration code, but got entirely discouraged by
>> the migration thread doing IO at random points. And of course, you've
>> seen what we had to do with direct-io. That was in part due to having
>> the migration thread in parallel doing it's small writes at undetermined
>> points in time.
>
> On the locked_vm part: probably yes, we'd better try to avoid using page
> pinning if possible. It just looks like it becomes a more important
> scenario nowadays to put VMs into containers, it means then such feature
> may not be always usable there.
>
> For the rest: I really don't know much on iouring, but I remember it can be
> fast normally only in a poll model with interrupt-less context?

I'm not sure. I mainly thought about using it to save syscalls on the
write side. But as I said, I didn't look further into it.

> Not sure
> whether it suites here for us, as I guess we should avoid consuming cpu
> resourcess with no good reason, and polling for perf falls into that
> category, I think.  Even without it, kubevirt now already has issue on
> multifd eating cpus, and people observe multifd threads causing vcpu
> threads to be throttled, interrupting guest workloads; they're currently
> put in the same container.  I also not sure how much it'll help comparing
> to when we have the multi-threading ready.  I suspect not that much.

Do you have a reference for that kubevirt issue I could look at? It
maybe interesting to investigate further. Where's the throttling coming
from? And doesn't less vcpu time imply less dirtying and therefore
faster convergence?

