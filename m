Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B10CFC516
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 01:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMciR-0008Mm-9b; Fri, 21 Nov 2025 20:47:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vMbQ7-0004dx-Jx
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:24:10 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vMbPv-0002kU-CD
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:24:04 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3804421005;
 Fri, 21 Nov 2025 12:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1763728686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QFaPabIKbMuIWY+3MALbZM+04nLZi8DoIk2fXFvzU5M=;
 b=KdkqQ6WN19AIaR09pNsn0/WDOXWU+IgKKCoHMZoOOEBOOSjZk890X3M06F8XdUNTkqC02z
 X1DHGzQx7kYeaFTTCiaZvLD+UlTYBpOfa4sP0/uvkPuZP5IzjdRShNYJBkc7pYflXA8vcB
 tPy03X3Dw9nhc0weugLTy/bJbYbVH7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1763728686;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QFaPabIKbMuIWY+3MALbZM+04nLZi8DoIk2fXFvzU5M=;
 b=n6/OmjzAGWr9+OF/laVJbrWsli3L9HIQibiH9UgaW1X2C+MD+JQI0Kiq9gKqU/7/ugBeiH
 81DfkJQzlhb6CGDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1763728685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QFaPabIKbMuIWY+3MALbZM+04nLZi8DoIk2fXFvzU5M=;
 b=cKxZHxyEeRnfEK6T60sp5exZZIxidlWsiPtTJHFEd4U1P1IUGtpyM/CUNzvjw9rVhE6QhZ
 sSSubznUehB115RR4bkGQYl5kcWu/YQOesdNYYJbGkWsty+F6lSazsrsxC3ErXfntbakbi
 JtVu0olw3NQKez2yXW6q4XHHlXZbYUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1763728685;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QFaPabIKbMuIWY+3MALbZM+04nLZi8DoIk2fXFvzU5M=;
 b=rqgqpq5uFAmGr32ZV6sGydlzE9KWTzNhR7iCjAVBNVcsrPfwF81I2hVjBsFp8j4zIdkBQu
 q/E0xj57fprqazBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD79A3EA61;
 Fri, 21 Nov 2025 12:38:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id b/+6GyxdIGmOKQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Nov 2025 12:38:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/3] migration: Error fixes and improvements
In-Reply-To: <aR4vdRcORY4em3yB@x1.local>
References: <20251115083500.2753895-1-armbru@redhat.com>
 <aRtHWbWcTh3OF2wY@x1.local> <87a50jlr8f.fsf@pond.sub.org>
 <aRyuZbS7iALvx-BT@x1.local> <87cy5ecvoc.fsf@pond.sub.org>
 <aR4vdRcORY4em3yB@x1.local>
Date: Fri, 21 Nov 2025 09:38:02 -0300
Message-ID: <87bjkvftn9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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
> IMHO it's not directly relevant to the error reporting issues.
>
> IMHO rewriting migration with Jobs will not help much in error reporting,
> because the challenge for refactoring from migration side is not the "Jobs"
> interfacing, but internally of migration.  Say, even if migration provided
> a "job", it's the "job" impl that did error reporting bad, not the Jobs
> interfacing.. the "job" impl will need to manage quite some threads on its
> own, making sure errors are properly reported at least to the "job"
> interface.
>
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
>
> However, I sincerely don't know how much common function will there be.
> IOW, I doubt even in an imaginery world, if we could go back to when Jobs
> was designed and if we would make migration a Job too (note!  snapshots is
> definitely a too simple migration scenario..).  Is it possible after
> evaluation we still don't?  I don't know, but I think it's possible.
>
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
>
>   - Similarly to JobVerb.  E.g. JOB_VERB_CHANGE doesn't seem to apply to
>     any concept to migration, but it misses quite some others
>     (e.g. JOB_VERB_SET_DOWNTIME, JOB_VERB_POSTCOPY_START, and more).
>
>   - Similarly, JobInfo reports in current-progress (which is not optional
>     but required), which may make perfect sense for block jobs. However
>     migration is OTOH convergence-triggered process, or user-triggered (in
>     case of postcopy).  It doesn't have a quantified process but only
>     "COMPLETED" / "IN_PROGRESS".
>
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

Thanks for looking into this, Peter! I'm saving it for future reference
as well! It was on my todo list to make such an analysis.

I hope Markus can comment on some of those and maybe we can still find a
way to converge, but I think I agree that migration is (at this point) a
little too particular to be retrofitted (which I'd be very much in favor
of, if it were at all feasible).

(wondering what happened in QEMU historically that we devised so many
well designed interfaces, but chose to leave migration aside altogether)

(maybe this right here is what happened)

