Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1829FDEE3F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 18:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFyYm-0000BP-KA; Thu, 23 Apr 2026 14:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFyYg-0000A5-Rr
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 14:13:51 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFyYe-0001eG-Us
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 14:13:50 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 14B726A882;
 Thu, 23 Apr 2026 18:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776968025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q20U6eOEGJ4QF4mgjAuoIPKx9fNOiQXdZrjIwTJ2JKk=;
 b=HIhBI4ac1iF1R2WHJnJxiA2kR41lX7wmS0+ip2D+wmP/kuq+kAwwRZpX8bXp9IYAsKRtmr
 mZLMslbKj4nmgb1YmTC4PDpkqn8XPamUShUvqtmhnStULgrTRD1o7Vjl1Q5A4M5FyRybkA
 cyPbpUk5dsgWGlIA2TN5oT2iQgAbc50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776968025;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q20U6eOEGJ4QF4mgjAuoIPKx9fNOiQXdZrjIwTJ2JKk=;
 b=aysQVU2QNTizt+0BzPHXRMIck7xQ7RmC7iOClW0fmsh4UVD7EAKtfDwQg3FYVlNhui6C43
 F0drd6Gq4k1IAnCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776968025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q20U6eOEGJ4QF4mgjAuoIPKx9fNOiQXdZrjIwTJ2JKk=;
 b=HIhBI4ac1iF1R2WHJnJxiA2kR41lX7wmS0+ip2D+wmP/kuq+kAwwRZpX8bXp9IYAsKRtmr
 mZLMslbKj4nmgb1YmTC4PDpkqn8XPamUShUvqtmhnStULgrTRD1o7Vjl1Q5A4M5FyRybkA
 cyPbpUk5dsgWGlIA2TN5oT2iQgAbc50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776968025;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q20U6eOEGJ4QF4mgjAuoIPKx9fNOiQXdZrjIwTJ2JKk=;
 b=aysQVU2QNTizt+0BzPHXRMIck7xQ7RmC7iOClW0fmsh4UVD7EAKtfDwQg3FYVlNhui6C43
 F0drd6Gq4k1IAnCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DB21593A3;
 Thu, 23 Apr 2026 18:13:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id diKtGlhh6mniSgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 18:13:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] migration/multifd: fix channel count TOCTOU race on
 cancel and retry
In-Reply-To: <aepFf11lBgdXK6CB@x1.local>
References: <20260422161202.34150-1-viking4@gmail.com>
 <20260422161202.34150-2-viking4@gmail.com> <87o6jaeig8.fsf@suse.de>
 <aepFf11lBgdXK6CB@x1.local>
Date: Thu, 23 Apr 2026 15:13:42 -0300
Message-ID: <87ik9hee95.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FREEMAIL_CC(0.00)[gmail.com,nongnu.org];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Apr 22, 2026 at 07:30:47PM -0300, Fabiano Rosas wrote:
>> Trieu Huynh <vikingtc4@gmail.com> writes:
>> 
>> > From: Trieu Huynh <vikingtc4@gmail.com>
>> >
>> > When a multifd migration is cancelled and the user changes
>> > multifd-channels via QMP before cleanup completes, the shutdown and
>> > termination loops re-read migrate_multifd_channels() which now returns
>> > the new value.
>> 
>> Right, so this is because migrate-set-parameters is allowed to set
>> so-called (by me) runtime options, such as downtime-limit, which means
>
> I like this new name, if we ever need a name for such..
>
>> we cannot block it while migration_is_running() = true as we do for
>> migrate-set-capabilities. The "right" fix here is something I discussed
>> with Peter a while back, which is to write a whitelist of commands that
>> we're certain have no negative effect during migration runtime (or are
>> simply required as part of normal functioning) and block everything else
>> behind a migration_is_running() check.
>> 
>> Still, I think we can consider this patch in isolation for now... Let me
>> continue looking.
>> 
>> > This causes the loops to iterate over, for instance
>> > fewer channels than were created, leaving yank functions of the
>> > abandoned channels still registered when yank_unregister_instance()
>> > is called, triggering an abort:
>> >   qemu-system-x86_64: ../util/yank.c:107: yank_unregister_instance:
>> >   Assertion `QLIST_EMPTY(&entry->yankfns)' failed.
>> >   Aborted (core dumped)
>> 
>> Ah yes, the assert machine doing it's job as usual.
>> 
>> >
>> > Fix by storing the channel count at setup time and using that frozen
>> > value in all subsequent loops. The live parameter
>> > migrate_multifd_channels() is now only read once during setup, ensuring
>> > teardown always operates on the exact set of channels that were created.
>> >
>> 
>> Take a look at multifd_send(), there's some shenanigans there as well
>> regarding changing the number of channels on the fly. Could we drop that
>> logic with this patch?
>
> I don't know anything allows dynamic number of channels.  If it's about:
>
>     /*
>      * next_channel can remain from a previous migration that was
>      * using more channels, so ensure it doesn't overflow if the
>      * limit is lower now.
>      */
>
> It's about another migration after a failed/cancelled migration only, where
> next_channel is currently a static variable.
>

Ah, right. Nevermind, then.

>> 
>> > Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
>> > ---
>> >  migration/multifd.c | 13 ++++++++-----
>> >  1 file changed, 8 insertions(+), 5 deletions(-)
>> 
>> Hmm, I see 20 instances of migrate_multifd_channels() being used in
>> multifd.c. It seems you missed some.
>> 
>> >
>> > diff --git a/migration/multifd.c b/migration/multifd.c
>> > index 035cb70f7b..69c8f6747b 100644
>> > --- a/migration/multifd.c
>> > +++ b/migration/multifd.c
>> > @@ -75,6 +75,8 @@ struct {
>> >      int exiting;
>> >      /* multifd ops */
>> >      const MultiFDMethods *ops;
>> > +    /* number of channels created (fixed at setup) */
>> > +    int channel_num;
>> 
>> Reads like "channel number" to me. As in "the number of the
>> channel". I'd use n_channels, num_channels or channels_num.
>> 
>> Naming aside... we'll then have three variables representing number of
>> multifd channels:
>> 
>> s->parameters.multifd_channels
>> multifd_send_state->channel_num
>> multifd_recv_state->channel_num
>> 
>> (or just 2 and inconsistent representation between send/recv, which is
>> worse IMO)
>> 

Looking again at this argument I put (too many variables), I notice we
also have multifd_send_state->channels_ready and
multifd_recv_state->count, both of which should contain the right number
of channels after multifd_send_setup() and migration_start_incoming(),
respectively. Maybe we could unify all of this into a single semaphore
used in both sides and take the semaphore count as number of
channels. @Peter, do you think it's worth it?

>> Let's go back to the core issue I described at the start, could we
>> instead check at migrate_params_test_apply() whether migration is
>> running and return an error when trying to change multifd channels?
>> 
>> There might be issues with current_migration going away while QMP is
>> still dispatching, but I'm not sure it will be productive if we start to
>> solve locally the troubles caused by each parameter when changed at
>> migration runtime.
>
> Agreed, I think we should fix it with the whitelist idea.
>
> If you haven't started looking at this (??), I wonder if Trieu would like
> to look at it as a replacement of this patch.

I haven't started. Feel free to take.

