Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033BFCF857D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 10:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM1wL-0006ot-VS; Thu, 20 Nov 2025 05:31:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vM1wI-0006oQ-5C
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 05:30:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vM1wF-0000yj-HK
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 05:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763634653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eQwZonO8ugXDrpJsoKwVbjRVCuODC5G9MIfMxqdTxEI=;
 b=g7oIupYav8mMj1LnEUuslEd2FaziZ4ki18YNLb8A2d/8LgzMg3voJXOPv7ZCLVAYgqx/oy
 4/KUuCZZg68nGlKTCSEsgydDhOMVS8CQ3cushoSEXlANhGV4pAnCLulC8cT9//gi8MsjLg
 dhoymhEYdtsCg5saz3ADmGQbYX3HNwE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-57Wj_VRlOx-96EjSZIlREg-1; Thu,
 20 Nov 2025 05:30:51 -0500
X-MC-Unique: 57Wj_VRlOx-96EjSZIlREg-1
X-Mimecast-MFC-AGG-ID: 57Wj_VRlOx-96EjSZIlREg_1763634650
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10EE41954234; Thu, 20 Nov 2025 10:30:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EB5630044DB; Thu, 20 Nov 2025 10:30:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D850621E6A27; Thu, 20 Nov 2025 11:30:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  farosas@suse.de,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Migration and the Job abstraction (was: [PATCH 0/3] migration:
 Error fixes and improvements)
In-Reply-To: <aR4vdRcORY4em3yB@x1.local> (Peter Xu's message of "Wed, 19 Nov
 2025 15:58:29 -0500")
References: <20251115083500.2753895-1-armbru@redhat.com>
 <aRtHWbWcTh3OF2wY@x1.local> <87a50jlr8f.fsf@pond.sub.org>
 <aRyuZbS7iALvx-BT@x1.local> <87cy5ecvoc.fsf@pond.sub.org>
 <aR4vdRcORY4em3yB@x1.local>
Date: Thu, 20 Nov 2025 11:30:46 +0100
Message-ID: <878qg1uhbd.fsf_-_@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Nov 19, 2025 at 08:45:39AM +0100, Markus Armbruster wrote:
>
> [...]
>
>> The hairy part is the background task.
>> 
>> I believe it used to simply do its job, reporting errors to stderr along
>> the way, until it either succeeded or failed.  The errors reported made
>> success / failure "obvious" for users.
>> 
>> This can report multiple errors, which can be confusing.
>> 
>> Worse, it was no good for management applications.  These need to
>> observe migration as a state machine, with final success and error
>> states, where the error state comes with an indication of what went
>> wrong.  So we made migration store the first of certain errors in the
>> migration state in addition to reporting to stderr.
>> 
>> "First", because we store only when the state doesn't already have an
>> error.  "Certain", because I doubt we do it for all errors we report.
>> 
>> Compare this to how jobs solve this problem.  These are a much, much
>> later invention, and designed for management applications from the
>> start[*].  A job is a state machine.  Management applications can
>> observe and control the state.  Errors are not supposed to be reported,
>> they should be fed to the state machine, which goes into an error state
>> then.  The job is not supposed to do actual work in an error state.
>> Therefore, no further errors should be possible.  When something goes
>> wrong, we get a single error, stored in the job state, where the
>> management application can find it.
>> 
>> Migration is also a state machine, and we long ago retrofitted the means
>> for management applications to observe and control the state.  What we
>> haven't done is the disciplined feeding of errors to the state machine.
>> We can still get multiple errors.  We store the first of certain errors
>> where the managament application can find it, but whether that error
>> suffices to explain what went wrong is a crap shot.  As long as that's
>> the case, we need to spew the other errors to stderr, where a human can
>> find it.
>
> Since above mentioned once more on the possibility of reusing Jobs idea, I
> did try to list things explicitly this time, that why I think it should be
> challenging and maybe not as worthwhile (?) to do so, however I might be
> wrong.  I attached it at the end of this email almost for myself in the
> future to reference, please feel free comment, or, to ignore all of those!

Challenging definitely, worthwhile unknown, but putting the issues in
writing can only help.

> IMHO it's not directly relevant to the error reporting issues.

There's no hard dependency; migration's error reporting wrongs can
certainly be righted without converting to the job abstraction.
Studying how the job abstraction does errors may still help.

> IMHO rewriting migration with Jobs will not help much in error reporting,
> because the challenge for refactoring from migration side is not the "Jobs"
> interfacing, but internally of migration.  Say, even if migration provided
> a "job", it's the "job" impl that did error reporting bad, not the Jobs
> interfacing.. the "job" impl will need to manage quite some threads on its
> own, making sure errors are properly reported at least to the "job"
> interface.

Point taken.

> Said that, I totally agree we should try to improve error reporting in
> migration.. with / without Jobs.
>
> [...]
>
>> > Maybe I should ping Vladimir on his recent work here?
>> >
>> > https://lore.kernel.org/r/20251028231347.194844-1-vsementsov@yandex-team.ru
>> >
>> > That'll be part of such cleanup effort (and yes unfortunately many
>> > migration related cleanups will need a lot of code churns...).
>> 
>> I know...
>> 
>> Can we afford modest efforts to reduce the mess one step at a time?
>
> Yes, I'll try to follow up on that.
>
> [...]
>
>> [*] If the job abstraction had been available in time, migration would
>> totally be a job.  There's no *design* reason for it being not a job.
>> Plenty of implementation and backward compatibility reasons, though.
>
> There might be something common between Jobs that block uses and a
> migration process.  If so, we can provide CommonJob and make MigrationJob
> and BlockJobs dependent on it.

Ignore BlockJob here, focus on Job.

BlockJob came first, in 2012: commit eeec61f2913 (block: add BlockJob
interface for long-running operations).  It then grew quite a bit to
accomodate new job types and provide more control.

Job appeared in 2018 as "infrastructure for generic background jobs that
aren't tied to a block device" (commit 33e9e9bd62d (job: Create Job,
JobDriver and job_create()).  Substantial parts of the BlockJob
interface are actually deprecated in favor of the Job interface.  I
believe BlockJob still exists for things that are actually
block-specific, and possibly for things we neglected to move over.

So, CommonJob already exists: it's Job, defined in qapi/job.json.

> However, I sincerely don't know how much common function will there be.
> IOW, I doubt even in an imaginery world, if we could go back to when Jobs
> was designed and if we would make migration a Job too (note!  snapshots is
> definitely a too simple migration scenario..).  Is it possible after
> evaluation we still don't?  I don't know, but I think it's possible.

To find out, we'd have to examine how the migration state machine and
interface could map to the Job state machine, and how the Job interface
could map to migration's internal interfaces.

The mapping may lose detail.  Generic Job is supposed to cover the
generic aspects.  Some specific jobs may need job-specific interfaces we
can't or prefer not to fit into Job.

> Thanks!
> Peter
>
>
>
>
> Possible challenges of adopting Jobs in migration flow
> ======================================================
>
> - Many Jobs defined property doesn't directly suite migration
>
>   - JobStatus is not directly suitable for migration purposes.  There're
>     some of the JobStatus that I can't think of any use
>     (e.g. JOB_STATUS_WAITING, JOB_STATUS_PENDING, which is fine, because we
>     can simply not use it), but there're other status that migration needs
>     but isn't availble. Introducing them seems to be an overkill instead to
>     block layer's use case.

The Job abstraction defines possible states and state transitions.  Each
job finds its own path from the initial state @created to the final
state @concluded.  If a state doesn't make sense for a certain type of
job, it simply doesn't go there.

So, job states migration doesn't want are only a problem if there is no
path from start to finish that doesn't go through unwanted states.

There may also be states migration wants that aren't job states.  We
could make them job states.  Or we map multiple migration states to a
single job state, i.e. have the job state *abstract* from migration
state details.

>   - Similarly to JobVerb.  E.g. JOB_VERB_CHANGE doesn't seem to apply to
>     any concept to migration, but it misses quite some others
>     (e.g. JOB_VERB_SET_DOWNTIME, JOB_VERB_POSTCOPY_START, and more).

JobVerb is used internally to restrict certain job commands to certain
job states.  For instance, command job-dismiss is rejected unless job is
in state @concluded.

This governs the generic job-FOO commands.  It also covers the legacy
block-job-FOO commands, because these wrap around the same C core as the
job-FOO commands.

We could have commands specific to a certain job type (say migration
jobs) that bypass the JobVerb infrastructure, and do their own thing to
restrict themselves to certain states.  Probably stupid if the states
that matter are job states.  Probably necessary if they aren't (say a
more fine-grained migration state).

>   - Similarly, JobInfo reports in current-progress (which is not optional
>     but required), which may make perfect sense for block jobs. However
>     migration is OTOH convergence-triggered process, or user-triggered (in
>     case of postcopy).  It doesn't have a quantified process but only
>     "COMPLETED" / "IN_PROGRESS".

Is there really no way to track migration progress approximately?

Here's the relevant doc comment:

    # @current-progress: Progress made until now.  The unit is arbitrary
    #     and the value can only meaningfully be used for the ratio of
    #     @current-progress to @total-progress.  The value is
    #     monotonically increasing.
    #
    # @total-progress: Estimated @current-progress value at the completion
    #     of the job.  This value can arbitrarily change while the job is
    #     running, in both directions.

I think this should work fine for convergence-triggered finish.
@current-progress could be the number of "things" sent (for some
arbitrary, convenient choice of "things").  Monotonotically increasing.
@total-progress then would have to be a more or less rough estimate of
@current-progress plus what still needs to be sent.  For RAM,
@current-progress could be number of pages sent, ane @total-progress
could be number of pages sent + (possibly estimated) number of dirty
pages.  Multiply by page size if that makes adding the estimated size of
the non-RAM transfers easier.

I haven't thought about postcopy.

>   - Another very major example that I have discussed a few times
>     previously, Jobs are close attached to AioContext, while migration
>     doesn't have, meanwhile migration is moving even further away from
>     event driven model..  See:
>
>     https://lore.kernel.org/all/20251022192612.2737648-1-peterx@redhat.com/#t
>
>   There're just too many example showing that Jobs are defined almost only
>   for block layer.. e.g. job-finalize (which may not make much sense in a
>   migration context anyway..) mentions finalizing of graph changes, which
>   also doesn't exist in migration process.
>
>   So if we rewrite migration somehow with Jobs or keeping migration in mind
>   designing Jobs, Jobs may need to be very bloated containing both
>   migration and block layer requirements.
>
> - Migration involves "two" QEMU instances instead of one
>
>   I'm guessing existing Jobs operations are not as such, and providing such
>   mechanisms in "Jobs" only for migration may introduce unnecessary code
>   that block layer will never use.
>
>   E.g. postcopy migration attached the two QEMU instances to represent one
>   VM instance.  I do not have a clear picture in mind yet on how we can
>   manage that if we see it as two separate Jobs on each side, and what
>   happens if each side operates on its own Job with different purposes, and
>   how we should connect two Jobs to say they're relevant (or maybe we don't
>   need to?).
>
> - More challenges on dest QEMU (VM loader) than src QEMU
>
>   Unlike on the src side, the dest QEMU, when in an incoming state, is not
>   a VM at all yet, but waiting to receive the migration data to become a
>   working VM. It's not a generic long term process, but a pure listening
>   port of QEMU where QEMU can do nothing without this "job" being
>   completed..
>
>   If we think about CPR it's even more complicated, because we essential
>   require part of incoming process to happen before almost everything.. it
>   may even include monitors being initialized.
>
> - Deep integration with other subsystems
>
>   Migration is deeply integrated into many other subsystems (auto-converge
>   being able to throttle vCPUs, RAM being able to ignore empty pages
>   reported from balloons, dirty trackings per-module, etc.), so we're not
>   sure if there'll be some limitation from Jobs (when designed with block
>   layer in mind) that will make such transition harder.
>
>   For example, we at least want to make sure Jobs won't have simple locks
>   that will be held while running migration, that can further deadlock if
>   the migration code may invoke something else that tries to re-take the
>   Jobs lock, which may cause dead-locks.
>
>   Or, since migration runs nowadays with quite some threads concurrently,
>   whether the main migration Job can always properly synchronize between
>   all of them with no problem (maybe yes, but I just don't know Jobs enough
>   to say).  This is also a relevant question about how much AioContext
>   plays a role in core of Jobs idea and whether it can work well with
>   complicated threaded environment.

Fair points!

Which ones are due to the external Job interface, and which ones are
"only" due to its current implementation?

Thanks a lot for writing all this!


