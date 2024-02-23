Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEE0C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 12:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdUs1-0007YC-7K; Fri, 23 Feb 2024 07:41:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rdUpy-00075z-T4
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:39:34 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rdUpq-00038e-UB
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:39:34 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 19CEF1FBB5;
 Fri, 23 Feb 2024 12:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708691965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dK2rCsMw+TNlWZOeP8q1If5eK1wEPcLB+ZfWbg+Ez7w=;
 b=A0zRymI9PG3nsUhAYnDX7dmcqsxxvEv25HTaEBdb1CXuKDjEE2gaNnD23f01Xp0W58u7Xs
 jNFd7EKvJWfw1ToThKlBeFakW/wtJs+/Cfdw2an2CJ3J8LlDMO8pmGz0fZaLPfCBQdaDTn
 DT6oGMaAhZTLeRcmXG1CBEH4sVNSUgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708691965;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dK2rCsMw+TNlWZOeP8q1If5eK1wEPcLB+ZfWbg+Ez7w=;
 b=DimnQKCc1g8e0qypvGuVX7UOeZNpFA+edpnpgQzVGqmzCyDyd9B/VfydgJg8worWbkhX1o
 9YxRxvUsal7TJtAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708691963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dK2rCsMw+TNlWZOeP8q1If5eK1wEPcLB+ZfWbg+Ez7w=;
 b=JBWNEXiJHhpdDJMEcD69EJNYZ/gb1fNEgNLc4sG3thXuwhayrPlHP8MiJ6JnA+Mr8zBVX2
 18uTuBthjGn4NDRDZhtoZ2ukVb4/2Ewn85PHkBfRFvNoXhW0Bw573eb6k4IWfOclhUe/TT
 X4BjO3ILumf++MRuhupxNahfeXlyec4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708691963;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dK2rCsMw+TNlWZOeP8q1If5eK1wEPcLB+ZfWbg+Ez7w=;
 b=FjAhaZ2igQm+wORMCqIGk6peJ30jf0cCKUk9SfWv/RyLISiSMCg9tsWpjDCLBZhN9cqO+f
 F1K8LKCCTfmTIbBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95E5D133DC;
 Fri, 23 Feb 2024 12:39:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VVKNF/qR2GXNdgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Feb 2024 12:39:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: Fix qmp_query_migrate mbps value
In-Reply-To: <Zdfh7oOARA6p-Iob@x1n>
References: <20240219194457.26923-1-farosas@suse.de> <ZdVlUsTDJA4hdNhg@x1n>
 <87y1beascb.fsf@suse.de> <ZdcWmVffLWhNB-Q8@x1n> <ZddMRroqCeuRWGFA@x1n>
 <87ttm0a9t3.fsf@suse.de> <Zdfh7oOARA6p-Iob@x1n>
Date: Fri, 23 Feb 2024 09:39:12 -0300
Message-ID: <87frxj9wy7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Thu, Feb 22, 2024 at 10:49:12AM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Thu, Feb 22, 2024 at 05:40:41PM +0800, Peter Xu wrote:
>> >> On Wed, Feb 21, 2024 at 09:56:36AM -0300, Fabiano Rosas wrote:
>> >> > Peter Xu <peterx@redhat.com> writes:
>> >> > 
>> >> > > On Mon, Feb 19, 2024 at 04:44:57PM -0300, Fabiano Rosas wrote:
>> >> > >> The QMP command query_migrate might see incorrect throughput numbers
>> >> > >> if it runs after we've set the migration completion status but before
>> >> > >> migration_calculate_complete() has updated s->total_time and s->mbps.
>> >> > >> 
>> >> > >> The migration status would show COMPLETED, but the throughput value
>> >> > >> would be the one from the last iteration and not the one from the
>> >> > >> whole migration. This will usually be a larger value due to the time
>> >> > >> period being smaller (one iteration).
>> >> > >> 
>> >> > >> Move migration_calculate_complete() earlier so that the status
>> >> > >> MIGRATION_STATUS_COMPLETED is only emitted after the final counters
>> >> > >> update.
>> >> > >> 
>> >> > >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> >> > >> ---
>> >> > >> CI run: https://gitlab.com/farosas/qemu/-/pipelines/1182405776
>> >> > >> ---
>> >> > >>  migration/migration.c | 10 ++++++----
>> >> > >>  1 file changed, 6 insertions(+), 4 deletions(-)
>> >> > >> 
>> >> > >> diff --git a/migration/migration.c b/migration/migration.c
>> >> > >> index ab21de2cad..7486d59da0 100644
>> >> > >> --- a/migration/migration.c
>> >> > >> +++ b/migration/migration.c
>> >> > >> @@ -102,6 +102,7 @@ static int migration_maybe_pause(MigrationState *s,
>> >> > >>                                   int new_state);
>> >> > >>  static void migrate_fd_cancel(MigrationState *s);
>> >> > >>  static bool close_return_path_on_source(MigrationState *s);
>> >> > >> +static void migration_calculate_complete(MigrationState *s);
>> >> > >>  
>> >> > >>  static void migration_downtime_start(MigrationState *s)
>> >> > >>  {
>> >> > >> @@ -2746,6 +2747,7 @@ static void migration_completion(MigrationState *s)
>> >> > >>          migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
>> >> > >>                            MIGRATION_STATUS_COLO);
>> >> > >>      } else {
>> >> > >> +        migration_calculate_complete(s);
>> >> > >>          migrate_set_state(&s->state, current_active_state,
>> >> > >>                            MIGRATION_STATUS_COMPLETED);
>> >> > >>      }
>> >> > >> @@ -2784,6 +2786,7 @@ static void bg_migration_completion(MigrationState *s)
>> >> > >>          goto fail;
>> >> > >>      }
>> >> > >>  
>> >> > >> +    migration_calculate_complete(s);
>> >> > >>      migrate_set_state(&s->state, current_active_state,
>> >> > >>                        MIGRATION_STATUS_COMPLETED);
>> >> > >>      return;
>> >> > >> @@ -2993,12 +2996,15 @@ static void migration_calculate_complete(MigrationState *s)
>> >> > >>      int64_t end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>> >> > >>      int64_t transfer_time;
>> >> > >>  
>> >> > >> +    /* QMP could read from these concurrently */
>> >> > >> +    bql_lock();
>> >> > >>      migration_downtime_end(s);
>> >> > >>      s->total_time = end_time - s->start_time;
>> >> > >>      transfer_time = s->total_time - s->setup_time;
>> >> > >>      if (transfer_time) {
>> >> > >>          s->mbps = ((double) bytes * 8.0) / transfer_time / 1000;
>> >> > >>      }
>> >> > >> +    bql_unlock();
>> >> > >
>> >> > > The lock is not needed?
>> >> > >
>> >> > > AFAIU that was needed because of things like runstate_set() rather than
>> >> > > setting of these fields.
>> >> > >
>> >> > 
>> >> > Don't we need to keep the total_time and mbps update atomic? Otherwise
>> >> > query-migrate might see (say) total_time=0 and mbps=<correct value> or
>> >> > total_time=<correct value> and mbps=<previous value>.
>> >> 
>> >> I thought it wasn't a major concern, but what you said makes sense; taking
>> >> it one more time doesn't really hurt after all to provide such benefit.
>> >> 
>> >> > 
>> >> > Also, what orders s->mbps update before the s->state update? I'd say we
>> >> > should probably hold the lock around the whole total_time,mbps,state
>> >> > update.
>> >> 
>> >> IMHO that's fine; mutex unlock implies a RELEASE.  See atomic.rst:
>> >> 
>> >> - ``pthread_mutex_lock`` has acquire semantics, ``pthread_mutex_unlock`` has
>> >>   release semantics and synchronizes with a ``pthread_mutex_lock`` for the
>> >>   same mutex.
>> >
>> > Hmm perhaps I wrote too soon.. it should only guarantee the ordering of the
>> > update on the lock variable itself v.s. any previous R&Ws, nothing else.
>> > Only if the other side uses bql_lock() will it guarantee proper ordering.
>> >
>> > Put them in bql should work, but I hesitate such use to start using bql
>> > to protect state updates.
>> 
>> Well, on the other hand that's a major use-case of the BQL: protecting
>> state that's used by QMP.
>> 
>> >
>> > How about we drop the lock, but use an explicit smp_mb_release()?  We may
>> > also want to use smb_load_acquire() in fill_source_migration_info() to use
>> > on reading &s->state (all will need some comment).  To me, making sure the
>> > total mbps is valid seems more important; while the other races are less
>> > harmful, and may not be a major concern?
>> 
>> That more closely reflects the problem we're trying to solve, which is
>> just an ordering one. However, the QMP code already holds the BQL, we
>> could just take benefit of that instead of adding more complex
>> synchronization primitives.
>> 
>> May I suggest we keep it simple and move that last migrate_set_state
>> into the BQL as well?
>
> It's okay to me, but then let's also extend the comment a little bit on the
> two exact requirements we're persuing (atomicity of updating fields,
> ordering of state update v.s. mbps)?

Ok, I'll respin with these changes.

>
> We can also rename migration_calculate_complete() to something like
> migration_completion_finalize()?  Then move the state update into it.

I've been planning to merge migration_completion() and
migration_iteration_finish(). It's too unintuitive to do the completion
routine deep inside migration_iteration_run(). AFAICS those are all tail
calls, so we could bring migration_completion() up into the
migration_thread top level.

So if you'll allow me I think I'll refrain from moving the state into
migration_calculate_complete() for now.

