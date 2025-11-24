Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F335CFD317
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 22:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNfM4-0007Sr-7N; Mon, 24 Nov 2025 17:48:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNfM2-0007S4-Gb
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 17:48:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNfLy-0004Fd-I4
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 17:48:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764024491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rAFvQ6Ena5Gqmcr0mPXma7fHC8vilPsEontPbgGa0wQ=;
 b=SDv07eIepNrmBsWjXfZJWBztn0VgQtwYY8736g4SWhkQhDZlu5SHAJL5EwY/F54FAJTcWD
 FReGkYb6psTfpHfxZVz/E2+m3vLhJPxPjwxXFfXfH853drFIjcEcCg9C2vqqTdx1NrXRn2
 5iLQSwAd8XHWaTj0VpugD9bg8vZAAnY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-hbpdAFZ8P5ie3VxVx4mpcw-1; Mon, 24 Nov 2025 17:48:09 -0500
X-MC-Unique: hbpdAFZ8P5ie3VxVx4mpcw-1
X-Mimecast-MFC-AGG-ID: hbpdAFZ8P5ie3VxVx4mpcw_1764024489
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b22d590227so536317285a.1
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 14:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764024489; x=1764629289; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rAFvQ6Ena5Gqmcr0mPXma7fHC8vilPsEontPbgGa0wQ=;
 b=UHCKF3CecjE1ipzftArZ7aM1grmRp/9aqXYeUP8s1b5nLXt4Vz39+CtNW1Xu2a5dey
 zr0ghhGe/AaNcAX1JkFduLtDnjZJaofHlR4K5ZvkV4yBnyUTbHCkGAoCZr8TKEwqYjZC
 oqC37E+xHfZbb4oZxxrKXuJZ+QTACAU5iAXw/grxjYlACmGWKJ/QLG3+pCydUbuP/A60
 2wcNXiQeda76T5TyNR3pHjywSN3Jf2qneLzTY28GzZULllhBZu1eQc1dnY2iNeRb1vGa
 yys3ddoWH/eVDd0ATz5Q3azAw+HKIWUFBnSt+/5wWQDuBbZUxrSHpw77ccNEtmUN1fsB
 Bcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764024489; x=1764629289;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rAFvQ6Ena5Gqmcr0mPXma7fHC8vilPsEontPbgGa0wQ=;
 b=v0cva2IzJogjNgraUjgdeqoff0re+iQXEUEaWbVASGObfJZ5BEp5iHd6lHT2qpwjV4
 BOZHyD+lXWPzB3XwxKYK35lwCI/arjUE/XGqM8zlWy1Gss1mxg9DFW77Gq627Anu8jSM
 ibNHBUm1BpFQMmzZwogf1G4hEJ8OVDJmQ0psFVvBrD/J8/o26mgM7FV2opa0K4XdQtMB
 PK9rPQHVsI9reLCDvqAqteUTw6HR3kyPIrKlP3f7W19eqfTE9mSNH0NtEXjWHtQJJ2Oi
 XaaZnMnNdO1j1Gxe/vBBHmVPHphE3XDdZTVZ80YjFApku9WrTP4kRt6nTDsqM/imentr
 +ipg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP4pyPI5MX4KRIOnuBBmz3JrgGsmpYDzYRYPRE1EI8JzZP6tRAIaokRYW0z+zzn9AuI0rhWP72dgTW@nongnu.org
X-Gm-Message-State: AOJu0YzN0A/1yyQ00dssXX/waRIPrCR/VcHynzk6EfweQhhK1orXc7Zl
 dCG9qkH+FcYVAuprLG+89SUVIJOh++ZFqZb/qA62p+9f8r0dQgsB9oknKCSLKFLXGQMYxCC2RaO
 kuaOb6zEOca2O4FGVYuEdME1vlx7ASjkG3ou65csf7ceou4R4KFnOpR+u
X-Gm-Gg: ASbGnctQJKgiecRJ/Hb3BrknX8cslsEVbZLe7I3nl/NSiLinWcVZ64urZPzNvzIoAGe
 RfaL2Xccgi3n+zEjxlrVyo8zjuqdZskY1RMR5TLdC3dWHkE4WENiBWBqY46hgi6ARhC934fLysz
 t0aeg3fl6fkCC511w82tCk9wydjeASjMq4SHlZ6+l+WB6AWRj11Uczz7SULmMrUvzzrxVbnm13Z
 X/O8qKU7rg5mEp7m2JDDlUiiEByQSNRqSRF0G9TVcbpcRLcryqwynP18NDnT+gsmQ3jcW38UVG5
 wAZFFExgK1FfiIKvcRPaGO+/fyJHCH3ycqgEcgmFiM6rwWjvPeUc74ACyXX66ShoCtyWIEn4iYg
 XXNg=
X-Received: by 2002:a05:620a:bc1:b0:8b2:e069:6912 with SMTP id
 af79cd13be357-8b4ebd9ebf7mr100552385a.50.1764024489030; 
 Mon, 24 Nov 2025 14:48:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwKAnvortdH5IPyqPIn9/m53s6rBwAtYQ9PYI2tjSg1en8r6YJKVA8nNzZQQyuzpVLhzvvpg==
X-Received: by 2002:a05:620a:bc1:b0:8b2:e069:6912 with SMTP id
 af79cd13be357-8b4ebd9ebf7mr100548285a.50.1764024488286; 
 Mon, 24 Nov 2025 14:48:08 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b3295db3e3sm1034020685a.43.2025.11.24.14.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 14:48:07 -0800 (PST)
Date: Mon, 24 Nov 2025 17:48:06 -0500
From: Peter Xu <peterx@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 farosas@suse.de, John Snow <jsnow@redhat.com>
Subject: Re: Migration and the Job abstraction (was: [PATCH 0/3] migration:
 Error fixes and improvements)
Message-ID: <aSTgphDaC1nFMRcW@x1.local>
References: <20251115083500.2753895-1-armbru@redhat.com>
 <aRtHWbWcTh3OF2wY@x1.local> <87a50jlr8f.fsf@pond.sub.org>
 <aRyuZbS7iALvx-BT@x1.local> <87cy5ecvoc.fsf@pond.sub.org>
 <aR4vdRcORY4em3yB@x1.local> <878qg1uhbd.fsf_-_@pond.sub.org>
 <aR8GsDYMwWDT4oeN@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aR8GsDYMwWDT4oeN@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Nov 20, 2025 at 01:16:48PM +0100, Kevin Wolf wrote:
> Am 20.11.2025 um 11:30 hat Markus Armbruster geschrieben:
> > Peter Xu <peterx@redhat.com> writes:
> > > On Wed, Nov 19, 2025 at 08:45:39AM +0100, Markus Armbruster wrote:
> > >> [*] If the job abstraction had been available in time, migration would
> > >> totally be a job.  There's no *design* reason for it being not a job.
> > >> Plenty of implementation and backward compatibility reasons, though.
> > >
> > > There might be something common between Jobs that block uses and a
> > > migration process.  If so, we can provide CommonJob and make MigrationJob
> > > and BlockJobs dependent on it.
> 
> Conceptually, live migration and the mirror block job are _really_
> similar. You have a bulk copy phase and you keep copying data that has
> changed to bring both sides in sync. When both sides are close enough,
> you stop new changes from coming in, copy the small remainder and finish
> the thing.
> 
> The main difference is that mirror copies disk content whereas live
> migration mostly copies RAM. But that's irrelevant conceptually.

True at least until here..

> 
> So it makes a lot of sense to me that the same user-visible state
> machine should be applicable to both.

MigrationStatus should have quite some more states that block mirror may
not use.  They're added over time.

> 
> (I'm not saying that we have to do this, just that I expect it to be
> possible.)
> 
> > > Possible challenges of adopting Jobs in migration flow
> > > ======================================================
> > >
> > > - Many Jobs defined property doesn't directly suite migration
> > >
> > >   - JobStatus is not directly suitable for migration purposes.  There're
> > >     some of the JobStatus that I can't think of any use
> > >     (e.g. JOB_STATUS_WAITING, JOB_STATUS_PENDING, which is fine, because we
> > >     can simply not use it), but there're other status that migration needs
> > >     but isn't availble. Introducing them seems to be an overkill instead to
> > >     block layer's use case.
> 
> Which other status does live migration have that the user cares about?
> 
> Does it have to be a status on the Job level or could it be some kind of
> substatus that could be represented by job-specific information in
> query-jobs? (Which doesn't exist yet, but I think we have been talking
> about it multiple times before.)

Yes, sub-status might work, but I'm not sure how well even if so.  We can
evaluate this when we have more solid idea on switching the code over.

Meanwhile, the need of sub-status may be a hint at least to me that
migration shouldn't move over.

IIUC, the major functionality that the Jobs layer provides is about either
Jobs status change, or verbs that can invoke hooks.  If migration cannot
leverage Jobs interface to either (1) reduce its own code, or (2) getting
improvements, then we don't need to move to Jobs interface either.  IMHO if
we can settle the two questions (1,2) above, then we can help decide
whether this is worth exploring.

[1]

I apologize if above was a wrong statement, because that was only based on
my quick glimpse over job.c.  Please correct me if so.

Maybe there is some QEMU feature that may depend on Jobs so that if
migration moved over then migration can also benefit from the feature?

> 
> > The Job abstraction defines possible states and state transitions.  Each
> > job finds its own path from the initial state @created to the final
> > state @concluded.  If a state doesn't make sense for a certain type of
> > job, it simply doesn't go there.
> 
> Note that most states are really managed by the common Job abstraction.
> The job itself only goes potentially from RUNNING to READY, and then
> implicitly to WAITING/ABORTING when it returns from .run().
> 
> Everything else only exists so that management tools can orchestrate
> jobs in the right way and can query errors before the job disappears.
> 
> I'm not sure if WAITING is really useless for migration. In theory, you
> could have a job transaction of some mirror jobs for the disks and live
> migration for the device state, and of course you want both to finish
> and switch over at the same time. I'm also not completely sure if it
> will actually be used in practice, but the Job infrastructure gives you
> the option for free.
> 
> PENDING and the associated job-finalize already exists in live migration
> in the form of pause-before-switchover/pre-switchover status and
> migrate-continue. So I don't think you can argue you have no use for it.

Yes, if we want, we can map some migration status into some of those.

> 
> > So, job states migration doesn't want are only a problem if there is no
> > path from start to finish that doesn't go through unwanted states.
> > 
> > There may also be states migration wants that aren't job states.  We
> > could make them job states.  Or we map multiple migration states to a
> > single job state, i.e. have the job state *abstract* from migration
> > state details.
> > 
> > >   - Similarly to JobVerb.  E.g. JOB_VERB_CHANGE doesn't seem to apply to
> > >     any concept to migration, but it misses quite some others
> > >     (e.g. JOB_VERB_SET_DOWNTIME, JOB_VERB_POSTCOPY_START, and more).
> 
> How is SET_DOWNTIME or POSTCOPY_START not just a form of CHANGE?

I don't know, hence I listed it. :) If it fits, it's great.

However if so, I wonder why JOB_VERB_SET_SPEED isn't part of CHANGE
already.  If we go further, RESUME/DISMISS/... can all be seen as CHANGE.

> 
> > JobVerb is used internally to restrict certain job commands to certain
> > job states.  For instance, command job-dismiss is rejected unless job is
> > in state @concluded.
> > 
> > This governs the generic job-FOO commands.  It also covers the legacy
> > block-job-FOO commands, because these wrap around the same C core as the
> > job-FOO commands.
> > 
> > We could have commands specific to a certain job type (say migration
> > jobs) that bypass the JobVerb infrastructure, and do their own thing to
> > restrict themselves to certain states.  Probably stupid if the states
> > that matter are job states.  Probably necessary if they aren't (say a
> > more fine-grained migration state).
> 
> I suspect we would have to look at specific examples to figure out how
> to represent them best. In general, I think a generic job-change (to be
> added as a more generic version of block-job-change) and job-specific
> data in query-jobs can cover a lot.
> 
> You may want to have job-specific QMP events outside of the Job
> mechanism, or we could have a generic one to notify the user that
> something in the queryable state has changed.
> 
> > >   - Similarly, JobInfo reports in current-progress (which is not optional
> > >     but required), which may make perfect sense for block jobs. However
> > >     migration is OTOH convergence-triggered process, or user-triggered (in
> > >     case of postcopy).  It doesn't have a quantified process but only
> > >     "COMPLETED" / "IN_PROGRESS".
> > 
> > Is there really no way to track migration progress approximately?
> 
> Of course there is. mirror in its default configuration is no different.
> When things are dirtied, the amount of work to do simply grows.

Yes, I actually didn't notice total-progress can change and mentioned in
the doc below.  If both CURRENT and TOTAL can change, it can always
represents both precopy and postcopy.

> 
> > Here's the relevant doc comment:
> > 
> >     # @current-progress: Progress made until now.  The unit is arbitrary
> >     #     and the value can only meaningfully be used for the ratio of
> >     #     @current-progress to @total-progress.  The value is
> >     #     monotonically increasing.
> >     #
> >     # @total-progress: Estimated @current-progress value at the completion
> >     #     of the job.  This value can arbitrarily change while the job is
> >     #     running, in both directions.
> > 
> > I think this should work fine for convergence-triggered finish.
> > @current-progress could be the number of "things" sent (for some
> > arbitrary, convenient choice of "things").  Monotonotically increasing.
> > @total-progress then would have to be a more or less rough estimate of
> > @current-progress plus what still needs to be sent.  For RAM,
> > @current-progress could be number of pages sent, ane @total-progress
> > could be number of pages sent + (possibly estimated) number of dirty
> > pages.  Multiply by page size if that makes adding the estimated size of
> > the non-RAM transfers easier.
> > 
> > I haven't thought about postcopy.
> 
> Postcopy should ask for every "thing" only once, so if you knew the
> number of remaining "things" when you switched to postcopy, you can
> simply continue to increase current-progress and leave total-progress
> unchanged (which might already be what automatically happens because the
> number of dirty pages can't grow on an inactive source instance any
> more).

Yes, precopy increases both CURRENT and TOTAL at different time (CURRENT
increases by pushing data frequently, TOTAL increases by sync operations),
postcopy only increases CURRENT, so postcopy is in this case more like a
limited scope work.

> 
> > >   - Another very major example that I have discussed a few times
> > >     previously, Jobs are close attached to AioContext, while migration
> > >     doesn't have, meanwhile migration is moving even further away from
> > >     event driven model..  See:
> > >
> > >     https://lore.kernel.org/all/20251022192612.2737648-1-peterx@redhat.com/#t
> 
> The main loop of a job runs in a coroutine in an AioContext, yes, and
> that is the context where you will get callbacks from, too. If the job
> doesn't explicitly put itself anywhere else, it will be in the main
> thread. Nothing stops you from firing off as many worker threads as you
> want to, though.
> 
> This separation of the migration thread and its management interface
> running in a different thread isn't new, though: Your existing QMP
> commands always run in the main thread, too.

Yes, currently the QMP handler is responsible for preparing IO handles,
then it'll be migration thread's work.  Meanwhile we're trying to move away
from coroutines completely even if QMP handlers still run in main thread /
iothread.  If my other series to threadify loadvm would land, then only
snapshot code will need coroutines.

We have quite some trouble using both coroutine and threads, one can refer
to the last few patches of my above series on what I want to revert to get
an idea.  That may not be the full list of troubles.

OTOH, if aio context is one feature for Jobs, it also means it's less
meaningful we rewrite migration API to Jobs.  Instead of a feature
migration can ignore, it is just yet another burden if we still want to
reduce coroutines to minimum..

> 
> > >   There're just too many example showing that Jobs are defined almost only
> > >   for block layer.. e.g. job-finalize (which may not make much sense in a
> > >   migration context anyway..) mentions finalizing of graph changes, which
> > >   also doesn't exist in migration process.
> 
> s/graph changes/switchover/ for migration.
> 
> I suppose "changes to global state" might be a more accurate generic
> description.
> 
> > >   So if we rewrite migration somehow with Jobs or keeping migration in mind
> > >   designing Jobs, Jobs may need to be very bloated containing both
> > >   migration and block layer requirements.
> > >
> > > - Migration involves "two" QEMU instances instead of one
> > >
> > >   I'm guessing existing Jobs operations are not as such, and providing such
> > >   mechanisms in "Jobs" only for migration may introduce unnecessary code
> > >   that block layer will never use.
> > >
> > >   E.g. postcopy migration attached the two QEMU instances to represent one
> > >   VM instance.  I do not have a clear picture in mind yet on how we can
> > >   manage that if we see it as two separate Jobs on each side, and what
> > >   happens if each side operates on its own Job with different purposes, and
> > >   how we should connect two Jobs to say they're relevant (or maybe we don't
> > >   need to?).
> 
> Don't you already run two different code paths on the source and the
> destination host? Why would they be the same job?

Not the same job, but correlated jobs somehow.

For migration the major use case is -incoming defer, which essentially
still use "migrate_incoming" to create a "Job".

I don't think it differs so much from QMP "migrate" at the 1st glance.
However that is still so special for sure, that's why I wonder if we should
make it a Job, and also the benefit of doing it.

And I didn't discuss CPR.  It's totally different, we can put that aside as
of now.

> 
> Block migration isn't very different. You typically have an NBD export
> running on one side and have a mirror job connecting to it on the other
> side. One part doesn't make sense without the other, but that doesn't
> mean that they are the same thing.

Yes.

> 
> > > - More challenges on dest QEMU (VM loader) than src QEMU
> > >
> > >   Unlike on the src side, the dest QEMU, when in an incoming state, is not
> > >   a VM at all yet, but waiting to receive the migration data to become a
> > >   working VM. It's not a generic long term process, but a pure listening
> > >   port of QEMU where QEMU can do nothing without this "job" being
> > >   completed..
> > >
> > >   If we think about CPR it's even more complicated, because we essential
> > >   require part of incoming process to happen before almost everything.. it
> > >   may even include monitors being initialized.
> 
> I'm not sure that the destination side should be a job. I suppose with
> postcopy migration you have at least some background task, but with
> precopy you don't even have that.

It may depend on how to define tasks.  E.g. we may have multifd threads
receiving and applying data.

> 
> Is there much that the user can manage on the destination side apart
> from just waiting for migration to finish?

Not much the user can do for precopy.  Postcopy is definitely different.

> 
> > > - Deep integration with other subsystems
> > >
> > >   Migration is deeply integrated into many other subsystems (auto-converge
> > >   being able to throttle vCPUs, RAM being able to ignore empty pages
> > >   reported from balloons, dirty trackings per-module, etc.), so we're not
> > >   sure if there'll be some limitation from Jobs (when designed with block
> > >   layer in mind) that will make such transition harder.
> > >
> > >   For example, we at least want to make sure Jobs won't have simple locks
> > >   that will be held while running migration, that can further deadlock if
> > >   the migration code may invoke something else that tries to re-take the
> > >   Jobs lock, which may cause dead-locks.
> 
> I don't know why anything in the actual system emulation would want to
> access the migration job and take its locks?

I don't know.  However since block layer is also a sub-module to migration,
we need to consider e.g. any post_load() of any block device VMSD, and
whether that can involve such issues.  Or maybe something can happen in a
migration notifier that can cause a chain effect.

Those logically should only run in a thread so likely it's fine, however
even if for each of the migration hooks to be attached to the Jobs VERBS
we'll still need to be careful.  I still remember the chaos when working on
some old bug where aio_poll() invoked even without a job mutex and whatever
it can schedule..

> 
> But that aside, jobs are made for long running background tasks. While
> they have a mutex to protect the generic state, you're not supposed to
> hold it for a long time.
> 
> > >   Or, since migration runs nowadays with quite some threads concurrently,
> > >   whether the main migration Job can always properly synchronize between
> > >   all of them with no problem (maybe yes, but I just don't know Jobs enough
> > >   to say).  This is also a relevant question about how much AioContext
> > >   plays a role in core of Jobs idea and whether it can work well with
> > >   complicated threaded environment.
> 
> Why wouldn't they be able to do that when a QMP handler in the main loop
> can do it correctly?

IMHO if we want to move on with this idea, it'll be great if someone can
help answer what major benefits migration can get to move over, as I asked
above [1].  We'll likely need to pay quite some for it (including Libvirt
adopting the new interface), so I want to double check what we get.

Thanks,

-- 
Peter Xu


