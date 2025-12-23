Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA1DE6FE23
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 16:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY4pK-0001KM-94; Tue, 23 Dec 2025 11:01:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vY4oz-0001DI-OQ
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 11:01:14 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vY4oy-0000XW-2g
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 11:01:13 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DD314336EE;
 Tue, 23 Dec 2025 16:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766505669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lpwr5DduYQpuyEFaIElokkyEUbM7eaGUyr5o/9ZS0Ws=;
 b=sv+lV4KxAebZ2DXiC0P1HuhPgJo5PyRilM269Fs0Bu4Q3yIvjyme6NOBX00+Gy0IDoNJos
 g70R7yozs+1vxU1NgmyPtwJ/uauLEeAVwxDtJx47nfr/gFnljjOdH71VsrttTAktZqBnPj
 306HOJ5cYyAj+Ugm4W+VU7SGBcRXqes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766505669;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lpwr5DduYQpuyEFaIElokkyEUbM7eaGUyr5o/9ZS0Ws=;
 b=oxGppU52HOAPVkrP8Ryso+dgP/xspnStanmeKPG9sxOy+NIutBPODKLwRQajKvtW3+wXcE
 4FsOUvMlu4QeNdAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=14s6FDeb;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=r5sZZCfC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766505667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lpwr5DduYQpuyEFaIElokkyEUbM7eaGUyr5o/9ZS0Ws=;
 b=14s6FDebjHD3X2X3YkRROA921/DL7PG5AHXPyRbTLzpx1kGtTb50H44+e2xN1ivDHkhU8J
 S0DwzSltYnx+mww+kzo23vw6fRD+Ys/OCd+JdLaZvffyp5FrI453GhbrgV4JnBpizc7pWX
 rlWFR2Cqfz0M7mrGel/eZ2esl75s0MM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766505667;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lpwr5DduYQpuyEFaIElokkyEUbM7eaGUyr5o/9ZS0Ws=;
 b=r5sZZCfCn+Tb+PD6Vko/T2OGoT20U7RnuyBYBuYg11uR/SyTHflihpzY4LkwSuWbSblXZh
 /2aKpRiYxGG7iHDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55F3A3EA63;
 Tue, 23 Dec 2025 16:01:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1ClcBsO8SmntCQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 23 Dec 2025 16:01:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org, Prasad Pandit
 <pjp@fedoraproject.org>
Subject: Re: [PATCH] migration: introduce MIGRATION_STATUS_FAILING
In-Reply-To: <aUq1oA73W9rAdCgG@x1.local>
References: <20251222114822.327623-1-ppandit@redhat.com>
 <87h5tilhcq.fsf@suse.de> <aUq1oA73W9rAdCgG@x1.local>
Date: Tue, 23 Dec 2025 13:01:03 -0300
Message-ID: <877budkx1c.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DD314336EE
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> On Mon, Dec 22, 2025 at 11:29:57AM -0300, Fabiano Rosas wrote:
>> I'm fine with the general idea:
>> 
>> i) FAILED and CANCELLED are terminal states. It makes sense to not have
>> work happen after they're set.
>> 
>> ii) Using an intermediate state, assuming locking/atomic are correct is
>> a suitable fix for the issue.
>> 
>> iii) Using a FAILING status seems appropriate.
>> 
>> However,
>> 
>> It would be great if we could stop exposing implementation details via
>> QAPI. Does the user really need to see events for CANCELLING and
>> FAILING?
>> 
>> It would probably be easier if we kept MigrationStatus as QAPI only and
>> used a separate mechanism to track the internal states.
>> 
>> That said, we could merge this as is to fix the bug and think about that
>> later.
>
> This bug looks to be there for a long time, IMHO we don't need to rush
> fixing it if we risk adding a new status and revert it quickly...  Let's
> discuss it here, and it's a valid question indeed.
>
> One thing good about exposing such status via QAPI is, it can help us
> diagnose issues by seeing CANCELLING / FAILING even looking at
> query-migrate results (as normally when bug happens we can't see the
> internal status..), so that we know either it's explicitly cancelled, or
> something went wrong.
>
> If it's a completely hidden / internal status, we may see ACTIVE even if
> something wrong happened..
>

On the other hand, we could have more fine-grained statuses and track
them with tracepoints.

> My current hope is any mgmt should normally by default ignore new migration
> states..  If that's always achieved, it looks to me adding FAILING directly
> into migration status would still have some benefits on debugging.
>

Maybe for FAILING it's ok, as we already have CANCELLING and FAILED is
currently mismatched.

> [...]
>
>> > @@ -2907,7 +2914,7 @@ fail_closefb:
>> >      qemu_fclose(fb);
>> >  fail:
>> >      if (ms->state != MIGRATION_STATUS_CANCELLING) {
>> > -        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
>> > +        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILING);
>> >      }
>> 
>> This is a good example where having MigrationStatus makes the code more
>> complicated. This could be exiting=true, running=false, etc. It
>> shouldn't matter why this routine failed. If we reach
>> migration_cleanup() and, at the very end, state is CANCELLING, then we
>> know the cancel command has caused this and set the state to
>> CANCELLED. If the state was something else, then it's unintended and we
>> set FAILED.
>
> If it'll be an internal status, we'll still need to identify if someone
> already have cancelled it, right?
>

I was thinking of keeping CANCELLING, since it's already in the API.

> Assuming we introduce stop_reason flag, making it:
>
> enum {
>     MIG_STOP_REASON_CANCEL,
>     MIG_STOP_REASON_FAIL,
> } MigrationStopReason;
>
> Then we can switch to CANCELLED / FAILED when cleanup from those reasons.
>
> Then here, logically we also need logic like:
>
>     if (stop_reason != MIG_STOP_REASON_CANCEL) {
>         stop_reason = MIG_STOP_REASON_FAIL;
>     }
>
> Because we want to make sure when the user already triggered cancel, it
> won't show FAILED but only show CANCELLED at last?

