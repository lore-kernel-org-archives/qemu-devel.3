Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B6BD116F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 13:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQQQH-0000z2-JO; Tue, 02 Dec 2025 08:28:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vQQQF-0000xy-Tv
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 08:28:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vQQQD-00006S-Nc
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 08:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764682078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/gg8ckfZEG/rBI/px/Xb/AAOhmR+HIowBpRGPsM0NmY=;
 b=MIue1i1FlpQdSepu9ZqXuJtWY2ieOPSTC3TFqsEi5JFB8PlB5N+t23aJvNhGeYR/o7eJfw
 EWSSB5S2EDROLnSDlvAfG80QshZOcOgim5LzZCFqPCzUIXoxP9JlyPLCrdp5rQM1wmzacg
 oY21tqqJUAbrxHXRJcSk8ZVAP8Zz7Oc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-uClwrfeQOcesn2H-pCvWHA-1; Tue,
 02 Dec 2025 08:16:36 -0500
X-MC-Unique: uClwrfeQOcesn2H-pCvWHA-1
X-Mimecast-MFC-AGG-ID: uClwrfeQOcesn2H-pCvWHA_1764681395
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB6DF1801233; Tue,  2 Dec 2025 13:16:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D0BA195608E; Tue,  2 Dec 2025 13:16:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B599321E6A27; Tue, 02 Dec 2025 14:16:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>,  qemu-devel@nongnu.org,  farosas@suse.de,
 John Snow <jsnow@redhat.com>
Subject: Re: Migration and the Job abstraction
In-Reply-To: <aSTgphDaC1nFMRcW@x1.local> (Peter Xu's message of "Mon, 24 Nov
 2025 17:48:06 -0500")
References: <20251115083500.2753895-1-armbru@redhat.com>
 <aRtHWbWcTh3OF2wY@x1.local> <87a50jlr8f.fsf@pond.sub.org>
 <aRyuZbS7iALvx-BT@x1.local> <87cy5ecvoc.fsf@pond.sub.org>
 <aR4vdRcORY4em3yB@x1.local> <878qg1uhbd.fsf_-_@pond.sub.org>
 <aR8GsDYMwWDT4oeN@redhat.com> <aSTgphDaC1nFMRcW@x1.local>
Date: Tue, 02 Dec 2025 14:16:31 +0100
Message-ID: <87cy4xt45s.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

> On Thu, Nov 20, 2025 at 01:16:48PM +0100, Kevin Wolf wrote:
>> Am 20.11.2025 um 11:30 hat Markus Armbruster geschrieben:
>> > Peter Xu <peterx@redhat.com> writes:
>> > > On Wed, Nov 19, 2025 at 08:45:39AM +0100, Markus Armbruster wrote:
>> > >> [*] If the job abstraction had been available in time, migration would
>> > >> totally be a job.  There's no *design* reason for it being not a job.
>> > >> Plenty of implementation and backward compatibility reasons, though.
>> > >
>> > > There might be something common between Jobs that block uses and a
>> > > migration process.  If so, we can provide CommonJob and make MigrationJob
>> > > and BlockJobs dependent on it.
>> 
>> Conceptually, live migration and the mirror block job are _really_
>> similar. You have a bulk copy phase and you keep copying data that has
>> changed to bring both sides in sync. When both sides are close enough,
>> you stop new changes from coming in, copy the small remainder and finish
>> the thing.
>> 
>> The main difference is that mirror copies disk content whereas live
>> migration mostly copies RAM. But that's irrelevant conceptually.
>
> True at least until here..
>
>> 
>> So it makes a lot of sense to me that the same user-visible state
>> machine should be applicable to both.
>
> MigrationStatus should have quite some more states that block mirror may
> not use.  They're added over time.
>
>> 
>> (I'm not saying that we have to do this, just that I expect it to be
>> possible.)
>> 
>> > > Possible challenges of adopting Jobs in migration flow
>> > > ======================================================
>> > >
>> > > - Many Jobs defined property doesn't directly suite migration
>> > >
>> > >   - JobStatus is not directly suitable for migration purposes.  There're
>> > >     some of the JobStatus that I can't think of any use
>> > >     (e.g. JOB_STATUS_WAITING, JOB_STATUS_PENDING, which is fine, because we
>> > >     can simply not use it), but there're other status that migration needs
>> > >     but isn't availble. Introducing them seems to be an overkill instead to
>> > >     block layer's use case.
>> 
>> Which other status does live migration have that the user cares about?
>> 
>> Does it have to be a status on the Job level or could it be some kind of
>> substatus that could be represented by job-specific information in
>> query-jobs? (Which doesn't exist yet, but I think we have been talking
>> about it multiple times before.)
>
> Yes, sub-status might work, but I'm not sure how well even if so.  We can
> evaluate this when we have more solid idea on switching the code over.
>
> Meanwhile, the need of sub-status may be a hint at least to me that
> migration shouldn't move over.

Not to me.

Like the existing jobs, migration would be a specialization of Job.

Digression: in OO, we use subtypes for specialization.  QAPI doesn't
really support subtyping.  Instead, we commonly make do with the
old-fashioned way: unions.  For jobs, we haven't had to.  On output
(query-job, events), there has been no need for job-specific data.  On
input, we simply use job-specific commands to create the jobs.

Having a specialization refine a common state machine feels natural to
me.

> IIUC, the major functionality that the Jobs layer provides is about either
> Jobs status change, or verbs that can invoke hooks.  If migration cannot
> leverage Jobs interface to either (1) reduce its own code, or (2) getting
> improvements, then we don't need to move to Jobs interface either.  IMHO if
> we can settle the two questions (1,2) above, then we can help decide
> whether this is worth exploring.

Yes, these are the right questions, but we should consider external
interface in addition to implementation.

Example for reduced interface complexity: generic job-cancel superseding
migrate_cancel.

Example for improved interface: migration gaining a progress meter from
generic query-jobs.

> [1]
>
> I apologize if above was a wrong statement, because that was only based on
> my quick glimpse over job.c.  Please correct me if so.

These are the right questions whether you got all the details right or
not!

> Maybe there is some QEMU feature that may depend on Jobs so that if
> migration moved over then migration can also benefit from the feature?

Transactions?  Like ...

>> > The Job abstraction defines possible states and state transitions.  Each
>> > job finds its own path from the initial state @created to the final
>> > state @concluded.  If a state doesn't make sense for a certain type of
>> > job, it simply doesn't go there.
>> 
>> Note that most states are really managed by the common Job abstraction.
>> The job itself only goes potentially from RUNNING to READY, and then
>> implicitly to WAITING/ABORTING when it returns from .run().
>> 
>> Everything else only exists so that management tools can orchestrate
>> jobs in the right way and can query errors before the job disappears.
>> I'm not sure if WAITING is really useless for migration.

... this:

>>                                                          In theory, you
>> could have a job transaction of some mirror jobs for the disks and live
>> migration for the device state, and of course you want both to finish
>> and switch over at the same time. I'm also not completely sure if it
>> will actually be used in practice, but the Job infrastructure gives you
>> the option for free.

Like Kevin, I can't tell whether anybody wants this.  It does feel
nifty, doesn't it?

>> PENDING and the associated job-finalize already exists in live migration
>> in the form of pause-before-switchover/pre-switchover status and
>> migrate-continue. So I don't think you can argue you have no use for it.
>
> Yes, if we want, we can map some migration status into some of those.
>
>> 
>> > So, job states migration doesn't want are only a problem if there is no
>> > path from start to finish that doesn't go through unwanted states.
>> > 
>> > There may also be states migration wants that aren't job states.  We
>> > could make them job states.  Or we map multiple migration states to a
>> > single job state, i.e. have the job state *abstract* from migration
>> > state details.
>> > 
>> > >   - Similarly to JobVerb.  E.g. JOB_VERB_CHANGE doesn't seem to apply to
>> > >     any concept to migration, but it misses quite some others
>> > >     (e.g. JOB_VERB_SET_DOWNTIME, JOB_VERB_POSTCOPY_START, and more).
>> 
>> How is SET_DOWNTIME or POSTCOPY_START not just a form of CHANGE?
>
> I don't know, hence I listed it. :) If it fits, it's great.
>
> However if so, I wonder why JOB_VERB_SET_SPEED isn't part of CHANGE
> already.  If we go further, RESUME/DISMISS/... can all be seen as CHANGE.

Jobs use separate commands to trigger state machine state transitions:
job-resume, job-dismiss, ...

For other configuration bits that can be changed while the job runs, all
we have is block-job-set-speed and block-job-change.  Perhaps these
should both be superseded by a generic reconfiguration interface.

Migration's configuration interface has grown over many, many years, and
it shows.  This isn't criticism!  It's what happens when something is so
useful that it gets extended again and again.  We've talked about making
that interface simpler and more regular.  Extending the job interface
for migration should do that.

>> > JobVerb is used internally to restrict certain job commands to certain
>> > job states.  For instance, command job-dismiss is rejected unless job is
>> > in state @concluded.
>> > 
>> > This governs the generic job-FOO commands.  It also covers the legacy
>> > block-job-FOO commands, because these wrap around the same C core as the
>> > job-FOO commands.
>> > 
>> > We could have commands specific to a certain job type (say migration
>> > jobs) that bypass the JobVerb infrastructure, and do their own thing to
>> > restrict themselves to certain states.  Probably stupid if the states
>> > that matter are job states.  Probably necessary if they aren't (say a
>> > more fine-grained migration state).
>> 
>> I suspect we would have to look at specific examples to figure out how
>> to represent them best. In general, I think a generic job-change (to be
>> added as a more generic version of block-job-change) and job-specific
>> data in query-jobs can cover a lot.
>> 
>> You may want to have job-specific QMP events outside of the Job
>> mechanism, or we could have a generic one to notify the user that
>> something in the queryable state has changed.

[...]

> IMHO if we want to move on with this idea, it'll be great if someone can
> help answer what major benefits migration can get to move over, as I asked
> above [1].  We'll likely need to pay quite some for it (including Libvirt
> adopting the new interface), so I want to double check what we get.

Fair!

> Thanks,


