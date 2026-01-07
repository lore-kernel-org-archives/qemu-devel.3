Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D1DCFD626
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTWB-0007NG-Ua; Wed, 07 Jan 2026 08:24:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vdTW7-0007DK-UF
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:24:04 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vdTW5-0005GN-BO
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:24:03 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D1B7E33F29;
 Wed,  7 Jan 2026 13:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767792236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L7B83DrMwNJa9UE3HYpCDAHxCfWVTGOtU18D82EEtZg=;
 b=icGzfQEPTgcgwHTTy/OtWf8h7vHwS3DivFwZr2I53+pqrptHmAwn/xEynVfQHCjk3R4H/M
 pXIFtXHkoUwmmAGgkDsakpIUCOUjLlB7dTdNSRGh2l0ZnLE6B+sVp70DIQMWbxyfo5cNAG
 1vYcV2xoG7Ju4ivkBSOcqVAKBDDULl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767792236;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L7B83DrMwNJa9UE3HYpCDAHxCfWVTGOtU18D82EEtZg=;
 b=MN+DCpGYzWLPqWrHALv/hV+8cyIj84LDmtFp7ihvkGk90/JBZv9S1qwrcW5M9gwURPHZLx
 qXesDCZcVyEFd0Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767792236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L7B83DrMwNJa9UE3HYpCDAHxCfWVTGOtU18D82EEtZg=;
 b=icGzfQEPTgcgwHTTy/OtWf8h7vHwS3DivFwZr2I53+pqrptHmAwn/xEynVfQHCjk3R4H/M
 pXIFtXHkoUwmmAGgkDsakpIUCOUjLlB7dTdNSRGh2l0ZnLE6B+sVp70DIQMWbxyfo5cNAG
 1vYcV2xoG7Ju4ivkBSOcqVAKBDDULl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767792236;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L7B83DrMwNJa9UE3HYpCDAHxCfWVTGOtU18D82EEtZg=;
 b=MN+DCpGYzWLPqWrHALv/hV+8cyIj84LDmtFp7ihvkGk90/JBZv9S1qwrcW5M9gwURPHZLx
 qXesDCZcVyEFd0Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 513B63EA63;
 Wed,  7 Jan 2026 13:23:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uicRBWxeXmnvBAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 07 Jan 2026 13:23:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Prasad Pandit
 <pjp@fedoraproject.org>
Subject: Re: [PATCH] migration: introduce MIGRATION_STATUS_FAILING
In-Reply-To: <CAE8KmOzxDn7X7rohJGT5AeW3+5oJFgueVtaQCpUc2bmBvrgRXg@mail.gmail.com>
References: <20251222114822.327623-1-ppandit@redhat.com>
 <87h5tilhcq.fsf@suse.de> <aUq1oA73W9rAdCgG@x1.local>
 <CAE8KmOzcOdYhnxpDr8BMV8zjixpEh9r+COe=xyLfXCVWKD0CRw@mail.gmail.com>
 <87zf6q26q5.fsf@suse.de>
 <CAE8KmOzxDn7X7rohJGT5AeW3+5oJFgueVtaQCpUc2bmBvrgRXg@mail.gmail.com>
Date: Wed, 07 Jan 2026 10:23:53 -0300
Message-ID: <874ioxzhcm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.993]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_THREE(0.00)[4]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Prasad Pandit <ppandit@redhat.com> writes:

> Hi,
>
> On Tue, 6 Jan 2026 at 19:17, Fabiano Rosas <farosas@suse.de> wrote:
>> If we had a linear state transition table, i.e. a DFA without any
>> branching, that would be ideal. But since we have states that can reach
>> (and be reached from) multiple other states, then we'll always need some
>> input to migration_change_state(). Here you're making it the
>> s->trigger. Where will that come from?
>
> * The trigger or reason can come from the place where we call
> migration_change_state(), there we'll know whether migration has
> paused OR completed OR failed OR cancelled.
>

It would be interesting maybe to restrict the set of
states/triggers/events (I'm not sure) to user-visible phases only, and
those would be defined by anything that's triggered via a QMP
command. Plus the error state which goes in the other direction.

In isolation, having a "trigger" for each QMP command seems like a good
idea to me. It could be just a flag that tells us what is the current
command that's being serviced. Most of migration are actions in response
to a QMP command. This could help with ensuring correctness in
concurrent invocations.

> * Even with branches, the process is still linear as it goes from
> start to finish. Just that we can reach the end state via different
> paths.
>   ===
>     $ grep -ri 'shutting' /var/log/libvirt/qemu/   | cut -d' ' -f 3- |
> sort | uniq
>      shutting down, reason=crashed
>      shutting down, reason=destroyed
>      shutting down, reason=failed
>      shutting down, reason=migrated
>      shutting down, reason=shutdown
> ===
> As we see, guest VM can stop/shutdown due to various reasons.
>
> * Between [migration-start] and [migration-end], we can define
> events/triggers that will lead to the next state. Ex
>
>       - START -> t:connection-established -> ACTIVE

I like this because it forces us to determine more clearly what is the
necessary condition for a state change. This could eventually allow the
abstraction of the qapi_event_send_migration() to a higher
layer. Something like:

void qmp_migrate() {
    t:migrate=true
    
    migration_setup() :: do setup, mig_setup_done=true
    migration_advance_state() :: checks the triggers, changes state and
                                 sends the event

    migration_start() :: migrate, mig_done=true
                         failure, mig_failed=true
                         etc
    migration_advance_state()

    migrate_vmstate() :: device state migration, mig_device_done=true
    migration_advance_state()

 etc..
}

IOW, we could do a better job of separating what is work, what is
migration control flow, what is error handling, etc.

>
> We can reach the ACTIVE state only after connections are established,
> not without that. If connection establishment fails, we reach the END.
>
>      - START  -> t:connection-established -> ACTIVE ->  running   -> END
>
> ACTIVE ->  t:error     ->  END
>
> ACTIVE ->  t:cancel  ->  END
>
> ACTIVE ->  t:pause   ->  PAUSED  -> t:resume -> ACTIVE
>

Looks good, not sure if the actual migration flow would fit this, but
let's assume it would.

>> Looking at runstate.c and job.c, it seems we could at least define a
>> state transition table and do away with the second parameter to
>> migrate_set_state(s, old, new).
>>
>> As we've been discussing, the current state-change mechanism has the
>> dual purpose of emitting the state change event and also serving as
>> internal tracking of the migration state. It's not clear to me whether
>> you're covering both in this proposal or just one of them.
>
> * We are not doing away with migration states, just reducing or
> rationalising them to make it easier. Emitting state change to
> libvirtd(8) and internal tracking should still serve the same. Just
> that in migration_is_running() etc. functions we'll check only if the
> state is ACTIVE, instead of 10 other states which also indicate that
> the migration is running.
>

What I'm trying to convey is that we have:

1) events API that needs to be kept stable, this list of states that
   libvirt sees and at what moments we emit them.

2) MigrationStatus being used as an internal record of the current
   (loosely defined) migration phase. This is "arbitrary", hence we're
   discussing adding a new MigrationStatus "just" to make sure we don't
   start a new migration at the wrong moment.

I'm trying to understand if you want to cover 1, 2 or both.

I would suggest we first take all of the internal tracking, i.e. #2, the
"if (state==MIGRATION_STATUS)" code and convert them to use some other
state tracking, either the triggers as you suggest, or random booleans
sprinkled all over, it's not immediately important.

Once that is done, then we could freeze the #1, MigrationStatus. It
would only change whenever we wanted to change the API and that should
be a well documented change.

>> I don't think we've established actually what are the goals of having
>> any state changes. Do we even need state changes for internal tracking?
>> We could use your s->trigger as an enum and just check it wherever
>> necessary. And keep the MIGRATION_STATUS exclusive for the external API,
>> in which case, it's probably better to just set it unconditionally (in
>> many places migrate_set_state already takes the current state as
>> argument, i.e. it doesn't care about the current state).
>
> * Well as I see it, different states help us to
>       1 - know where the process is at a given time. In case of
> errors/failures or other events to know what actions to take.
>       2 - what actions/triggers/events are possible.
>
> ex. If an error/cancel occurs before ACTIVE state, during connection
> establishment, it may not have to go through migration_cleanup(),
> probably there's nothing to cleanup. Vs if an error/cancel occurs
> after ACTIVE  or in PAUSED state, we know migration_cleanup() is
> needed.  Similarly if we receive t:resume command when in ACTIVE
> state, OR receive t:pause command in PAUSED state,  we know there's
> nothing to do and ignore it.
>

Ok, maybe I'm splittling hairs here, I was trying to understand whether
all of these "if (s->state ...)" have the same semantics.

a) For cases such as CANCELLING: that could be a simple
   s->trigger[MIGRATE_CANCEL]=1.

  (we're not removing the CANCELLING state due to the API stability, but
  still)

b) For error conditions: s->event[FAILED]=1, then (possibly at a later
   point in migration_change_state):

   if (s->event[FAILED] && !s->trigger[MIGRATE_CANCEL]) {
      migrate_set_state(s->state, MIGRATION_STATUS_FAILED);
   }

b) For postcopy resume/pause, etc, maybe an actual state machine that can
   only be in one state would be helpful.

c) For "we reached this point, so set this state", most of those could
   just be an invocation to migration_change_state() and, as you
   suggest, that would look for the evidence elsewhere to know what
   state to set:

   if (s->trigger[MIGRATE] && s->event[COMPLETED]) {
      migrate_set_state(s->state, MIGRATION_STATUS_COMPLETED);
   }

