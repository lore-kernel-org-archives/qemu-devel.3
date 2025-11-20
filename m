Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46987CF884D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 12:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM3b1-0004Uu-8K; Thu, 20 Nov 2025 07:17:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vM3av-0004UP-2A
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 07:17:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vM3ar-0007oj-Sk
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 07:17:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763641014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pTQNE0r3/HxQy5usdCXgS8+jWS8LIj6l+lAXOsFxrII=;
 b=ih9KGvAahSg6cbb3LK4+x3yB1T+nSciiYThUn0pkWwDRlXPaWjMx3TayOYLXonmnF8TK3y
 UHDeiNtDN+Q3B5vIHfE7vHlMrr/ksYJNvJoGXSY8ACuC5sWhpI3Avs8+hQCW9FmqHjJN7f
 nAoHnG0PpwDJBtMB+bkLPhZwB1euqD8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-8Qt0ViGQPX6GVdvwM8NGhg-1; Thu,
 20 Nov 2025 07:16:53 -0500
X-MC-Unique: 8Qt0ViGQPX6GVdvwM8NGhg-1
X-Mimecast-MFC-AGG-ID: 8Qt0ViGQPX6GVdvwM8NGhg_1763641012
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F22E1956096; Thu, 20 Nov 2025 12:16:52 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.132])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C99D3001E83; Thu, 20 Nov 2025 12:16:50 +0000 (UTC)
Date: Thu, 20 Nov 2025 13:16:48 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, farosas@suse.de,
 John Snow <jsnow@redhat.com>
Subject: Re: Migration and the Job abstraction (was: [PATCH 0/3] migration:
 Error fixes and improvements)
Message-ID: <aR8GsDYMwWDT4oeN@redhat.com>
References: <20251115083500.2753895-1-armbru@redhat.com>
 <aRtHWbWcTh3OF2wY@x1.local> <87a50jlr8f.fsf@pond.sub.org>
 <aRyuZbS7iALvx-BT@x1.local> <87cy5ecvoc.fsf@pond.sub.org>
 <aR4vdRcORY4em3yB@x1.local> <878qg1uhbd.fsf_-_@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qg1uhbd.fsf_-_@pond.sub.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Am 20.11.2025 um 11:30 hat Markus Armbruster geschrieben:
> Peter Xu <peterx@redhat.com> writes:
> > On Wed, Nov 19, 2025 at 08:45:39AM +0100, Markus Armbruster wrote:
> >> [*] If the job abstraction had been available in time, migration would
> >> totally be a job.  There's no *design* reason for it being not a job.
> >> Plenty of implementation and backward compatibility reasons, though.
> >
> > There might be something common between Jobs that block uses and a
> > migration process.  If so, we can provide CommonJob and make MigrationJob
> > and BlockJobs dependent on it.

Conceptually, live migration and the mirror block job are _really_
similar. You have a bulk copy phase and you keep copying data that has
changed to bring both sides in sync. When both sides are close enough,
you stop new changes from coming in, copy the small remainder and finish
the thing.

The main difference is that mirror copies disk content whereas live
migration mostly copies RAM. But that's irrelevant conceptually.

So it makes a lot of sense to me that the same user-visible state
machine should be applicable to both.

(I'm not saying that we have to do this, just that I expect it to be
possible.)

> > Possible challenges of adopting Jobs in migration flow
> > ======================================================
> >
> > - Many Jobs defined property doesn't directly suite migration
> >
> >   - JobStatus is not directly suitable for migration purposes.  There're
> >     some of the JobStatus that I can't think of any use
> >     (e.g. JOB_STATUS_WAITING, JOB_STATUS_PENDING, which is fine, because we
> >     can simply not use it), but there're other status that migration needs
> >     but isn't availble. Introducing them seems to be an overkill instead to
> >     block layer's use case.

Which other status does live migration have that the user cares about?

Does it have to be a status on the Job level or could it be some kind of
substatus that could be represented by job-specific information in
query-jobs? (Which doesn't exist yet, but I think we have been talking
about it multiple times before.)

> The Job abstraction defines possible states and state transitions.  Each
> job finds its own path from the initial state @created to the final
> state @concluded.  If a state doesn't make sense for a certain type of
> job, it simply doesn't go there.

Note that most states are really managed by the common Job abstraction.
The job itself only goes potentially from RUNNING to READY, and then
implicitly to WAITING/ABORTING when it returns from .run().

Everything else only exists so that management tools can orchestrate
jobs in the right way and can query errors before the job disappears.

I'm not sure if WAITING is really useless for migration. In theory, you
could have a job transaction of some mirror jobs for the disks and live
migration for the device state, and of course you want both to finish
and switch over at the same time. I'm also not completely sure if it
will actually be used in practice, but the Job infrastructure gives you
the option for free.

PENDING and the associated job-finalize already exists in live migration
in the form of pause-before-switchover/pre-switchover status and
migrate-continue. So I don't think you can argue you have no use for it.

> So, job states migration doesn't want are only a problem if there is no
> path from start to finish that doesn't go through unwanted states.
> 
> There may also be states migration wants that aren't job states.  We
> could make them job states.  Or we map multiple migration states to a
> single job state, i.e. have the job state *abstract* from migration
> state details.
> 
> >   - Similarly to JobVerb.  E.g. JOB_VERB_CHANGE doesn't seem to apply to
> >     any concept to migration, but it misses quite some others
> >     (e.g. JOB_VERB_SET_DOWNTIME, JOB_VERB_POSTCOPY_START, and more).

How is SET_DOWNTIME or POSTCOPY_START not just a form of CHANGE?

> JobVerb is used internally to restrict certain job commands to certain
> job states.  For instance, command job-dismiss is rejected unless job is
> in state @concluded.
> 
> This governs the generic job-FOO commands.  It also covers the legacy
> block-job-FOO commands, because these wrap around the same C core as the
> job-FOO commands.
> 
> We could have commands specific to a certain job type (say migration
> jobs) that bypass the JobVerb infrastructure, and do their own thing to
> restrict themselves to certain states.  Probably stupid if the states
> that matter are job states.  Probably necessary if they aren't (say a
> more fine-grained migration state).

I suspect we would have to look at specific examples to figure out how
to represent them best. In general, I think a generic job-change (to be
added as a more generic version of block-job-change) and job-specific
data in query-jobs can cover a lot.

You may want to have job-specific QMP events outside of the Job
mechanism, or we could have a generic one to notify the user that
something in the queryable state has changed.

> >   - Similarly, JobInfo reports in current-progress (which is not optional
> >     but required), which may make perfect sense for block jobs. However
> >     migration is OTOH convergence-triggered process, or user-triggered (in
> >     case of postcopy).  It doesn't have a quantified process but only
> >     "COMPLETED" / "IN_PROGRESS".
> 
> Is there really no way to track migration progress approximately?

Of course there is. mirror in its default configuration is no different.
When things are dirtied, the amount of work to do simply grows.

> Here's the relevant doc comment:
> 
>     # @current-progress: Progress made until now.  The unit is arbitrary
>     #     and the value can only meaningfully be used for the ratio of
>     #     @current-progress to @total-progress.  The value is
>     #     monotonically increasing.
>     #
>     # @total-progress: Estimated @current-progress value at the completion
>     #     of the job.  This value can arbitrarily change while the job is
>     #     running, in both directions.
> 
> I think this should work fine for convergence-triggered finish.
> @current-progress could be the number of "things" sent (for some
> arbitrary, convenient choice of "things").  Monotonotically increasing.
> @total-progress then would have to be a more or less rough estimate of
> @current-progress plus what still needs to be sent.  For RAM,
> @current-progress could be number of pages sent, ane @total-progress
> could be number of pages sent + (possibly estimated) number of dirty
> pages.  Multiply by page size if that makes adding the estimated size of
> the non-RAM transfers easier.
> 
> I haven't thought about postcopy.

Postcopy should ask for every "thing" only once, so if you knew the
number of remaining "things" when you switched to postcopy, you can
simply continue to increase current-progress and leave total-progress
unchanged (which might already be what automatically happens because the
number of dirty pages can't grow on an inactive source instance any
more).

> >   - Another very major example that I have discussed a few times
> >     previously, Jobs are close attached to AioContext, while migration
> >     doesn't have, meanwhile migration is moving even further away from
> >     event driven model..  See:
> >
> >     https://lore.kernel.org/all/20251022192612.2737648-1-peterx@redhat.com/#t

The main loop of a job runs in a coroutine in an AioContext, yes, and
that is the context where you will get callbacks from, too. If the job
doesn't explicitly put itself anywhere else, it will be in the main
thread. Nothing stops you from firing off as many worker threads as you
want to, though.

This separation of the migration thread and its management interface
running in a different thread isn't new, though: Your existing QMP
commands always run in the main thread, too.

> >   There're just too many example showing that Jobs are defined almost only
> >   for block layer.. e.g. job-finalize (which may not make much sense in a
> >   migration context anyway..) mentions finalizing of graph changes, which
> >   also doesn't exist in migration process.

s/graph changes/switchover/ for migration.

I suppose "changes to global state" might be a more accurate generic
description.

> >   So if we rewrite migration somehow with Jobs or keeping migration in mind
> >   designing Jobs, Jobs may need to be very bloated containing both
> >   migration and block layer requirements.
> >
> > - Migration involves "two" QEMU instances instead of one
> >
> >   I'm guessing existing Jobs operations are not as such, and providing such
> >   mechanisms in "Jobs" only for migration may introduce unnecessary code
> >   that block layer will never use.
> >
> >   E.g. postcopy migration attached the two QEMU instances to represent one
> >   VM instance.  I do not have a clear picture in mind yet on how we can
> >   manage that if we see it as two separate Jobs on each side, and what
> >   happens if each side operates on its own Job with different purposes, and
> >   how we should connect two Jobs to say they're relevant (or maybe we don't
> >   need to?).

Don't you already run two different code paths on the source and the
destination host? Why would they be the same job?

Block migration isn't very different. You typically have an NBD export
running on one side and have a mirror job connecting to it on the other
side. One part doesn't make sense without the other, but that doesn't
mean that they are the same thing.

> > - More challenges on dest QEMU (VM loader) than src QEMU
> >
> >   Unlike on the src side, the dest QEMU, when in an incoming state, is not
> >   a VM at all yet, but waiting to receive the migration data to become a
> >   working VM. It's not a generic long term process, but a pure listening
> >   port of QEMU where QEMU can do nothing without this "job" being
> >   completed..
> >
> >   If we think about CPR it's even more complicated, because we essential
> >   require part of incoming process to happen before almost everything.. it
> >   may even include monitors being initialized.

I'm not sure that the destination side should be a job. I suppose with
postcopy migration you have at least some background task, but with
precopy you don't even have that.

Is there much that the user can manage on the destination side apart
from just waiting for migration to finish?

> > - Deep integration with other subsystems
> >
> >   Migration is deeply integrated into many other subsystems (auto-converge
> >   being able to throttle vCPUs, RAM being able to ignore empty pages
> >   reported from balloons, dirty trackings per-module, etc.), so we're not
> >   sure if there'll be some limitation from Jobs (when designed with block
> >   layer in mind) that will make such transition harder.
> >
> >   For example, we at least want to make sure Jobs won't have simple locks
> >   that will be held while running migration, that can further deadlock if
> >   the migration code may invoke something else that tries to re-take the
> >   Jobs lock, which may cause dead-locks.

I don't know why anything in the actual system emulation would want to
access the migration job and take its locks?

But that aside, jobs are made for long running background tasks. While
they have a mutex to protect the generic state, you're not supposed to
hold it for a long time.

> >   Or, since migration runs nowadays with quite some threads concurrently,
> >   whether the main migration Job can always properly synchronize between
> >   all of them with no problem (maybe yes, but I just don't know Jobs enough
> >   to say).  This is also a relevant question about how much AioContext
> >   plays a role in core of Jobs idea and whether it can work well with
> >   complicated threaded environment.

Why wouldn't they be able to do that when a QMP handler in the main loop
can do it correctly?

Kevin


