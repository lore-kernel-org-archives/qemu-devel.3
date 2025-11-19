Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58EACF2594
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 07:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLctA-00066l-8a; Wed, 19 Nov 2025 02:46:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vLcsy-00062Q-G4
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 02:45:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vLcsv-0002oF-Hz
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 02:45:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763538347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pbJFLwCQqVVZDlds2JiTzZGMzmuTs1uNm6dPXPecdAk=;
 b=EafRZHyydzUr6QeIpNk+/Zbbh/63WIeYn7OIgZjx2pclYS1Q2AhVML1Vb/6j0/08UcD6wn
 viKfpnSZl+uBFnuFbD2KXtXEFcDjRRAhBoxO3LmscrOqG5ZNFGAQ1UeLY45ne/Zior6KvZ
 Bz0Rh8MXt8NziE509D+u+SB5dTQIk/w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-DG8Y7ZpPOwqOjL8a1lvgjQ-1; Wed,
 19 Nov 2025 02:45:44 -0500
X-MC-Unique: DG8Y7ZpPOwqOjL8a1lvgjQ-1
X-Mimecast-MFC-AGG-ID: DG8Y7ZpPOwqOjL8a1lvgjQ_1763538343
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 402D01800342; Wed, 19 Nov 2025 07:45:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2F3B18004A3; Wed, 19 Nov 2025 07:45:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C329D21E6A27; Wed, 19 Nov 2025 08:45:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  farosas@suse.de
Subject: Re: [PATCH 0/3] migration: Error fixes and improvements
In-Reply-To: <aRyuZbS7iALvx-BT@x1.local> (Peter Xu's message of "Tue, 18 Nov
 2025 12:35:33 -0500")
References: <20251115083500.2753895-1-armbru@redhat.com>
 <aRtHWbWcTh3OF2wY@x1.local> <87a50jlr8f.fsf@pond.sub.org>
 <aRyuZbS7iALvx-BT@x1.local>
Date: Wed, 19 Nov 2025 08:45:39 +0100
Message-ID: <87cy5ecvoc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

> On Tue, Nov 18, 2025 at 08:44:32AM +0100, Markus Armbruster wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Sat, Nov 15, 2025 at 09:34:57AM +0100, Markus Armbruster wrote:
>> >> Maintainers decide what to take for 10.2, if anything.
>> >> 
>> >> Let me know if you'd prefer the "perhaps should take ownership" idea
>> >> in PATCH 1's commit message.
>> >
>> > I recall I had such patch previously, so I digged it out:
>> >
>> > https://lore.kernel.org/all/20230705163502.331007-3-peterx@redhat.com/
>> >
>> > I found that I dropped it in v3's post of that series, where I mentioned in
>> > the change log that either way is not clean, so I dropped that until I
>> > could have a better understanding:
>> >
>> > https://lore.kernel.org/all/20231004220240.167175-1-peterx@redhat.com/
>> >
>> > I think at that time I should have hit an use case where the caller forgot
>> > to error_copy(), hence passing it in causing an UAF.
>> 
>> Use-after-free can happen if the caller holds on to its reference until
>> after the stored Error is freed.  In other words, holding on to the
>> reference is safe only until the stored Error is freed, and any safety
>> argument will have to reason about the stored Error's lifetime.  No idea
>> how difficult or brittle such an argument would be.
>> 
>> >                                                       Then I thought memory
>> > leak was better in error path comparing to UAF if the API was used wrong
>> > either way.
>> 
>> Fair point.
>> 
>> > But feel free to share your thoughts.  We can definitely revisit this.
>> 
>> migrate_set_error(s, err) stores a copy of @err in @s unless @s already
>> has an Error stored.
>> 
>> I see 26 calls of migrate_set_error().
>> 
>> * 11 call error_free() immediately, and 2 call it via g_autoptr().  3
>>   neglect to call it.  My patch fixes them.  Total is 16 out of 26.
>
> Yes, I appreciate that!
>
>> 
>> * 6 report and free with error_report_err(), i.e. we store the error for
>>   later *and* report it now.  Gives me an uneasy feeling.  How is the
>>   stored error handled?  Will it be reported again?  That would likely
>>   be wrong.
>
> Migration as a module outlives me working as a developer on QEMU.. so I can
> only share my two cents that still resides in my memory, which may or may
> not always be the truth..

It was already big & complicated back when *I* started!

> I think one issue is migration used to error_report() things all over the
> places,

Yes, except even error_report() didn't exist, yet.  It made sense at the
time.

>         but then we thought it a good idea to try remember the error so
> that libvirt can query at any time if necessary.  With that, starting from
> QEMU 2.7 we introduced error-desc into query-migrate results.  That's what
> s->error was about.
>
> But then, could we drop the error_report() / error_report_err()s?  Likely
> not, because there might be user relying on the printed errors to see what
> happened..  Making query-migrate the only source of error report adds
> complexity to those users and may cause confusions..  Hence the extra
> references sometimes needed after migrate_set_error(), almost for keeping
> behaviors to print it out as the old times (I didn't check each of them,
> though).

Yes.

The core of migration is a long-running background task.  We have
command line options and monitor commands to start and control it.

QMP commands need to pass their errors to the QMP core by setting @errp.
Any code they call should pass them the same way.  Conceptually easy,
although converting old code to pass error up instead of reporting them
can be tedious.

HMP commands should wrap around QMP commands an report to their monitor.
No issues there, as far as I know.

The hairy part is the background task.

I believe it used to simply do its job, reporting errors to stderr along
the way, until it either succeeded or failed.  The errors reported made
success / failure "obvious" for users.

This can report multiple errors, which can be confusing.

Worse, it was no good for management applications.  These need to
observe migration as a state machine, with final success and error
states, where the error state comes with an indication of what went
wrong.  So we made migration store the first of certain errors in the
migration state in addition to reporting to stderr.

"First", because we store only when the state doesn't already have an
error.  "Certain", because I doubt we do it for all errors we report.

Compare this to how jobs solve this problem.  These are a much, much
later invention, and designed for management applications from the
start[*].  A job is a state machine.  Management applications can
observe and control the state.  Errors are not supposed to be reported,
they should be fed to the state machine, which goes into an error state
then.  The job is not supposed to do actual work in an error state.
Therefore, no further errors should be possible.  When something goes
wrong, we get a single error, stored in the job state, where the
management application can find it.

Migration is also a state machine, and we long ago retrofitted the means
for management applications to observe and control the state.  What we
haven't done is the disciplined feeding of errors to the state machine.
We can still get multiple errors.  We store the first of certain errors
where the managament application can find it, but whether that error
suffices to explain what went wrong is a crap shot.  As long as that's
the case, we need to spew the other errors to stderr, where a human can
find it.

>> * 3 wrap migrate_set_error():
>> 
>>   - multifd_send_set_error()
>> 
>>     Its callers both call error_free() immediately.
>> 
>>   - migration_connect_set_error()
>> 
>>     3 callers.
>> 
>>     qmp_migrate() and qmp_migrate_finish() propagate to their callers,
>>     i.e. we store the error for later *and* have callers handle it now.
>>     Same uneasy feeling as above.
>> 
>>     One of migration_connect()'s callers passes NULL, the other calls
>>     error_free() immediately.
>> 
>>   - multifd_recv_terminate_threads()
>> 
>>     Two callers pass NULL, one calls error_free() immediately, and
>>     multifd_recv_new_channel() propagates.  Uneasy feeling again.
>> 
>> * qemu_savevm_state_setup() confuses me.  It sets @errp on failure, and
>>   stores some (uneasy feeling), but not all of these errors with
>>   migrate_set_error().  See below.
>
> Yes, I also agree qemu_savevm_state_setup() is confusing on error
> handlings.  I'll comment below.
>
>> 
>> Summary:
>> 
>> * We're prone to leaking the Error passed to migrate_set_error().
>> 
>> * If we replaced it by a function that takes ownership, we may become
>>   prone to use-after-free.  I write "may" because I'm unsure when
>>   exactly a use after calling this ownership-taking function would be
>>   unsafe.
>> 
>> * The "forked" Error handling makes me uneasy.  I'm sure we do it for
>>   reasons.  Can you help me understand them?
>
> Hope above would provide some context.  In short, IMHO it's a mixture
> demand of "print the error immediately like the old behavior" and "remember
> the error too when query".

I figure that's how far we were able to drag migration forward.  More
dragging is called for, but it's hard work, and there's so much else to
do.

>> > I queued the series for this release, thanks Markus.
>> 
>> Thanks!
>> 
>> 
>> Bonus content:
>> 
>>     int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
>>     {
>>         ERRP_GUARD();
>>         MigrationState *ms = migrate_get_current();
>>         JSONWriter *vmdesc = ms->vmdesc;
>>         SaveStateEntry *se;
>>         int ret = 0;
>> 
>>         if (vmdesc) {
>>             json_writer_int64(vmdesc, "page_size", qemu_target_page_size());
>>             json_writer_start_array(vmdesc, "devices");
>>         }
>> 
>>         trace_savevm_state_setup();
>>         QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> 
>> The function does work in a loop.
>> 
>> This work can fail in two places, setting @errp.  When it does, we
>> return.
>> 
>>             if (se->vmsd && se->vmsd->early_setup) {
>> 
>> First one:
>> 
>>                 ret = vmstate_save(f, se, vmdesc, errp);
>>                 if (ret) {
>> 
>> vmstate_save() set @errp and returned an error code.
>> 
>>                     migrate_set_error(ms, *errp);
>>                     qemu_file_set_error(f, ret);
>> 
>> Store @errp in @ms, and the error code in @f.
>> 
>> Aside: storing error state in two places feels like one too many.
>
> Correct.  It's once again legacy of migration code where it used to set
> error onto fds (e.g. that'll start to fail all qemufile APIs on this fd,
> and qemufile API is not well designed IMHO.. which is another story), but
> then we start to have string-based Errors and I guess we didn't try harder
> to unify both.
>
>> 
>>                     break;
>> 
>> This break jumps to if (ret) { return ret; }, so it's a roundabout way
>> to return ret.  Meh.
>
> IIUC some people prefer such way so the function returns at a single point
> (easier to add common cleanup codes, for example).  But I'd confess I also
> prefer a direct return. :)

I don't believe in complicating control flow to make future cleanup
easier to add.  If we ever we add it, we need to review the entire
function to make sure it's called when needed no matter what.

>> 
>>                 }
>>                 continue;
>>             }
>> 
>>             if (!se->ops || !se->ops->save_setup) {
>>                 continue;
>>             }
>>             if (se->ops->is_active) {
>>                 if (!se->ops->is_active(se->opaque)) {
>>                     continue;
>>                 }
>>             }
>>             save_section_header(f, se, QEMU_VM_SECTION_START);
>> 
>> Second one:
>> 
>>             ret = se->ops->save_setup(f, se->opaque, errp);
>>             save_section_footer(f, se);
>>             if (ret < 0) {
>> 
>> ->save_setup() set @errp and returned an error code.
>> 
>>                 qemu_file_set_error(f, ret);
>> 
>> This time we store only the error code.  Why not @errp?
>
> IIUC migrate_set_error() above was redundant instead, because
> qemu_savevm_state_setup()'s caller will do migrate_set_error().

%-}

> Said that, we shouldn't need to randomly call qemu_file_set_error() either
> deep in this function.. may need some cleanups.
>
>> 
>>                 break;
>> 
>> Again, a roundabout way to return ret.
>> 
>>             }
>> 
>> Obviously ret >= 0 here.  I believe @errp is not set.
>
> I don't think in this path ret can be >0..  but yeah this is pretty
> unobvious even if true.  That's also why I liked QEMU's current preferences
> of "bool fn(..., Error **errp)".. at least in new codes.

Me too.  When all we need the return value to express is success
vs. failure, bool has served us much better than int.

>                                                           Maybe I should
> ping Vladimir on his recent work here?
>
> https://lore.kernel.org/r/20251028231347.194844-1-vsementsov@yandex-team.ru
>
> That'll be part of such cleanup effort (and yes unfortunately many
> migration related cleanups will need a lot of code churns...).

I know...

Can we afford modest efforts to reduce the mess one step at a time?

>>         }
>> 
>> We get here either via break or normal loop termination.
>> 
>> If via break, ret != 0 and @errp set.
>> 
>> If via normal loop termination, ret >= 0 and @errp not set.
>> 
>>         if (ret) {
>>             return ret;
>> 
>> If via normal loop termination, and ret > 0, we return failure (I think)
>> without setting @errp.  I hope this can't happen, because ->save_setup()
>> never returns > 0.  But it's unclean even then.
>> 
>>         }
>> 
>> I trust @errp is still unset here.  This is the case if we take the
>> return right above when @errp has been set.
>> 
>>         /* TODO: Should we check that errp is set in case of failure ? */
>>         return precopy_notify(PRECOPY_NOTIFY_SETUP, errp);
>> 
>> This time we store nothing.  Why?
>
> I think the clean way is we do not store anything when this function
> provided Error**.

Point!

>>     }
>> 
>> I think this function would be easier to understand if we replaced break
>> by return.
>
> I'll see what I can do with this function.
>
> Thanks!

You're welcome!


[*] If the job abstraction had been available in time, migration would
totally be a job.  There's no *design* reason for it being not a job.
Plenty of implementation and backward compatibility reasons, though.


