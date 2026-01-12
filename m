Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726DFCF45C8
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 19:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfNqw-0003qg-8M; Mon, 12 Jan 2026 14:45:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vfNqu-0003oQ-6D
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 14:45:24 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vfNqs-00017G-6J
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 14:45:23 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9E7283369B;
 Mon, 12 Jan 2026 19:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768247120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xZx+ps2MJ6xBhNiKhHxyGEPzTqk0NV0k+2IhKIjSecE=;
 b=qmUxph3+reacaWQuS9SYE2BTV3AuddzcTAGiCz30KxZQLnhWaup1RKeZVj7OEOzrsBJsv3
 MC1UmA8YwmSpuC3f6QUoMJWtFj8Zw4U0lwJt33PGmly5o9Q3uWDKFgyBeTxo73EW5MJaMh
 mUNwGz5cmXTjtCkQcQ4KnXm+69oBfbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768247120;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xZx+ps2MJ6xBhNiKhHxyGEPzTqk0NV0k+2IhKIjSecE=;
 b=mFQpvU99svUXsNUWABnsOUL8D21FUo0IJ0E0BUekpTy69kTMjpN1IoFUdsSIMplEk9W6zC
 C+7UdneHN+BZgXAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768247119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xZx+ps2MJ6xBhNiKhHxyGEPzTqk0NV0k+2IhKIjSecE=;
 b=peBmeR+hiexju+6vJOozTXliS7sDx0ixjN9xNL6JjlAh5LwYF+etmrNI4HaK0KpboAv2jl
 b1A8IY7IL+RWwbVZh4c+09jR2afv6o3TGtWTZXpQZcDA+qfCXjlEI+A4cKGygkMiSDR3H/
 s6WOSgmnrXaeS9Rp7/zMHM7tpb1FGLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768247119;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xZx+ps2MJ6xBhNiKhHxyGEPzTqk0NV0k+2IhKIjSecE=;
 b=y+qThhGh3ZWSPccUh8yuzAmclDEMNaI+bHSnNJQ6JRjJyiNPXw7LJ+FUrQEJ+Q8FfGXayq
 U0MmLPNxlEeTnRCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CFF83EA63;
 Mon, 12 Jan 2026 19:45:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WdJkM05PZWlSGwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 12 Jan 2026 19:45:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Prasad Pandit
 <pjp@fedoraproject.org>
Subject: Re: [PATCH] migration: introduce MIGRATION_STATUS_FAILING
In-Reply-To: <CAE8KmOx0ikDueu-znY14RCmp6weX_G+CJMUrQOmOuv-OPwPR+Q@mail.gmail.com>
References: <20251222114822.327623-1-ppandit@redhat.com>
 <87h5tilhcq.fsf@suse.de> <aUq1oA73W9rAdCgG@x1.local>
 <CAE8KmOzcOdYhnxpDr8BMV8zjixpEh9r+COe=xyLfXCVWKD0CRw@mail.gmail.com>
 <87zf6q26q5.fsf@suse.de>
 <CAE8KmOzxDn7X7rohJGT5AeW3+5oJFgueVtaQCpUc2bmBvrgRXg@mail.gmail.com>
 <874ioxzhcm.fsf@suse.de>
 <CAE8KmOx0ikDueu-znY14RCmp6weX_G+CJMUrQOmOuv-OPwPR+Q@mail.gmail.com>
Date: Mon, 12 Jan 2026 16:45:16 -0300
Message-ID: <87y0m2zkc3.fsf@suse.de>
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
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
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
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Prasad Pandit <ppandit@redhat.com> writes:

> Hello Fabiano,
>
> On Wed, 7 Jan 2026 at 18:54, Fabiano Rosas <farosas@suse.de> wrote:
>> I like this because it forces us to determine more clearly what is the
>> necessary condition for a state change. This could eventually allow the
>> abstraction of the qapi_event_send_migration() to a higher
>> layer. Something like:
>>
>> void qmp_migrate() {
>>     t:migrate=true
>>
>>     migration_setup() :: do setup, mig_setup_done=true
>>     migration_advance_state() :: checks the triggers, changes state and
>>                                  sends the event
>>
>>     migration_start() :: migrate, mig_done=true
>>                          failure, mig_failed=true
>>                          etc
>>     migration_advance_state()
>>
>>     migrate_vmstate() :: device state migration, mig_device_done=true
>>     migration_advance_state()
>>
>>  etc..
>> }
>>
>> IOW, we could do a better job of separating what is work, what is
>> migration control flow, what is error handling, etc.
>
> * Yes, indeed. Above skeleton code conveys the plausible
> segregation/stages well.
>
>> What I'm trying to convey is that we have:
>>
>> 1) events API that needs to be kept stable, this list of states that
>>    libvirt sees and at what moments we emit them.
> ===
>   qemuProcessHandleMigrationStatus & qemuMigrationUpdateJobType
>     -> https://gitlab.com/libvirt/libvirt/-/blob/master/src/qemu/qemu_process.c#L1766
>     -> https://gitlab.com/libvirt/libvirt/-/blob/master/src/qemu/qemu_migration.c?ref_type=heads#L1931
> ===
> * I was trying to see how libvirtd(8) handles QEMU migration states.
> Looking at the above functions there, it seems they don't do much with
> it. Only MIGRATION_STATUS_POSTCOPY_* has some handling, while other
> states are not handled for anything. Interestingly, there's no _FAILED
> state in there, maybe they call it _ERROR.
>
> * While I get the importance of not breaking APIs, still, simplifying
> migration states on the QEMU side should help them too.
>

Also remember libvirt is not the only consumer of events from QEMU,
there are other platforms as well.

>> 2) MigrationStatus being used as an internal record of the current
>>    (loosely defined) migration phase. This is "arbitrary", hence we're
>>    discussing adding a new MigrationStatus "just" to make sure we don't
>>    start a new migration at the wrong moment.
>>
>> I'm trying to understand if you want to cover 1, 2 or both.
>>
>> I would suggest we first take all of the internal tracking, i.e. #2, the
>> "if (state==MIGRATION_STATUS)" code and convert them to use some other
>> state tracking, either the triggers as you suggest, or random booleans
>> sprinkled all over, it's not immediately important.
>>
>> Once that is done, then we could freeze the #1, MigrationStatus. It
>> would only change whenever we wanted to change the API and that should
>> be a well documented change.
>
> * Yes, sounds good. We could start with the QEMU internal state/phase
> tracking and then go to #1 above once we see how it all works in
> practice.
>
>> Ok, maybe I'm splittling hairs here, I was trying to understand whether
>> all of these "if (s->state ...)" have the same semantics.
>>
>> a) For cases such as CANCELLING: that could be a simple
>>    s->trigger[MIGRATE_CANCEL]=1.
>>
>>   (we're not removing the CANCELLING state due to the API stability, but
>>   still)
>>
>> b) For error conditions: s->event[FAILED]=1, then (possibly at a later
>>    point in migration_change_state):
>>
>>    if (s->event[FAILED] && !s->trigger[MIGRATE_CANCEL]) {
>>       migrate_set_state(s->state, MIGRATION_STATUS_FAILED);
>>    }
>
> * Do we have to check !MIGRATE_CANCEL like this? It's not clean.

There are failures that happen _because_ we cancelled. As I've mentioned
somewhere else before, the cancellation is not "informed" to all threads
running migration code, there are some code paths that will simply fail
as a result of migration_cancel(). We need to allow cancelling to work
in a possibly stuck thread (such as a blocked recv in the return path),
but this means we end up calling qemu_file_shutdown indiscriminately.

In these cases, parts of the code would set FAILED, but that failure is
a result of cancelling. We've determined that migrate-cancel should
always lead to CANCELLED and a new migration should always be possible.

> Ideally if an error/failure event occurs before the user cancels, then
> cancel can be ignored, no? Because migration is anyway going to stop
> or end.

This is ok, call it an error and done.

> OTOH, if we cancel while processing an error/failure, end user
> may not see that error because we report - migration was cancelled.
>

This is interesting, I _think_ it wouldn't be possible to cancel while
handling an error due to BQL locked, the migrate-cancel wouldn't be
issued while migration_cleanup is ongoing. However, I don't think we ever
tested this scenario in particular. Maybe you could try to catch
something by modifying the /migration/cancel tests, if you're willing.


>> b) For postcopy resume/pause, etc, maybe an actual state machine that can
>>    only be in one state would be helpful.
>>
>> c) For "we reached this point, so set this state", most of those could
>>    just be an invocation to migration_change_state() and, as you
>>    suggest, that would look for the evidence elsewhere to know what
>>    state to set:
>>
>>    if (s->trigger[MIGRATE] && s->event[COMPLETED]) {
>>       migrate_set_state(s->state, MIGRATION_STATUS_COMPLETED);
>>    }
>
> * Yes, right. We need to define/differentiate between _what_ is the
> state and _why_ is that state.
>
> * How do we go from here? Next step?
>

You could send a PoC patch with your idea fixing this FAILING bug? We'd
need a trigger for migrate, set_caps, etc and the failed event.

If that new patch doesn't get consensus then we merge this one and work
on a new design as time permits.

---

Aside from the QAPI states, there are some internal states we already
track with separate flags, e.g.:

rp_thread_created, start_postcopy, migration_thread_running,
switchover_acked, postcopy_package_loaded, fault_thread_quit,
preempt_thread_status, load_threads_abort.

A bit array could maybe cover all of these and more.

