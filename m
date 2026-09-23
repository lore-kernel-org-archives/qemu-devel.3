Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68438C9830D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9VUS-000437-L7; Wed, 23 Sep 2026 18:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x9VUO-00042v-L0
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 18:30:56 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x9VUM-0007sy-A0
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 18:30:56 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 021FB1FDAE;
 Wed, 23 Sep 2026 22:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790202648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ttkrqx4H+t+XCayqkkgnrWUAPqYjQvxjZifJ19d5lUc=;
 b=NLT4uNht1Kzknm2FpxLA39/JLZyEgYmZROpCAY3cbtlEwPvr7xKJkGzDr0CnFdm+Z0Y+Zn
 3NGafbh70GuVB/NxRaNC4sIGCblv8f/ght5BsmR5JHnDVLtbUWrUUhuvALLxQQ3QpJOPzl
 1yCBMsUvaI+09mB8XSIbd10/t/GCSAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790202648;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ttkrqx4H+t+XCayqkkgnrWUAPqYjQvxjZifJ19d5lUc=;
 b=Ta012u8CIzj7gudKPFHRCZu34iQ+goLMjOck86BkRIPZr5BAwpYph8I0Ij/fpzNK4rZmBf
 GHhQkp64o9RwOMBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790202644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ttkrqx4H+t+XCayqkkgnrWUAPqYjQvxjZifJ19d5lUc=;
 b=uqhh0Eodips/w7eMtdvJLMHg22Q9YRAqhESTlAezkOVJwyavJHZ8WTiaS6H95noOa+1moy
 OzEh5CbA59R6InXaJ4t/IV2n3qEDtqUOwoRRXg51zShlFR5NXb4MyBBoh9tJluwULmZZNg
 Hb7wYQFhFQ2VH70M96Zwu9zp/WFuu8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790202644;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ttkrqx4H+t+XCayqkkgnrWUAPqYjQvxjZifJ19d5lUc=;
 b=r8O6OZGaGX3XWVSgvJS2olDL1CiDb76rxyIBuTd41uJv8PznRSdYjepNJ7htufe9+3npcb
 XOB3xiak2fiFSzBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 798FF134E8;
 Wed, 23 Sep 2026 22:30:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id e5sPCBNTtGpNZwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 23 Sep 2026 22:30:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Akash Kulhalli <akulhall@redhat.com>, Juraj
 Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 7/7] migration: Postpone the outgoing preempt channel
 for preempt_pre_7_2
In-Reply-To: <arQ1f6w_CKn1jUzg@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260916213558.587304-1-peterx@redhat.com>
 <20260916213558.587304-8-peterx@redhat.com> <87o6doami6.fsf@suse.de>
 <arQ1f6w_CKn1jUzg@zhexu-thinkpadt14gen5.rmtcaon.csb>
Date: Wed, 23 Sep 2026 19:30:36 -0300
Message-ID: <87a4p7a9df.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

> On Tue, Sep 22, 2026 at 08:34:41PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > This is the corresponding outgoing fix for the same problem mentioned in
>> > the previous patch.
>> >
>> > The idea is simple: either migration to an old QEMU or when TLS is enabled,
>> > we rely on correct ordering of channels to make it work: first main, then
>> > multifd, finally preempt.
>> >
>> > This patch re-orders multifd and postcopy preempt channel on outgoing side,
>> > but only for the old machine types where preempt_pre_7_2 set, to make it
>> > follow the right orders to create the channels.
>> >
>> > Keep the resume path alone because the resume path never involve multifd
>> > channels, even if multifd is enabled.  For that, fun fact: when multifd is
>> > enabled with postcopy preempt, network interruption will break all multifd
>> > channels, but they're never re-connected, until they got recycled at the
>> > end of postcopy migration.
>> 
>> Is this a separate bug? Do we need to add some cleanup?
>
> Not a bug?  The resume path only happens during postcopy phase, during
> which multifd (even if enabled) is ignored.
>

Ah, I though you meant multifd+postcopy could leave multifd channels
behind in case of network failure.

>> 
>> > OTOH, multifd_recv_all_channels_created()
>> > reports true even after postcopy network down, as multifd_recv_state->count
>> > is never decremented.
>> >
>> 
>> Seems normal to me. We're not even trying to reconnect multifd.
>
> The clean way to do this is, whenever we recycled all the channels we reset
> it.  Ideally they should have been recycled when switching to postcopy, but
> that's non-issue, I agree.  It's just not that intuitive, IMHO.  But I can
> definitely drop this paragraph if it caused confusions.
>

You're not wrong, but we can very well have something that counts up
when channels are created and doesn't count down when they are removed.

>> 
>> > Fixes: e27418861288 ("migration: enable multifd and postcopy together")
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  migration/migration.c | 32 +++++++++++++++++++++++---------
>> >  1 file changed, 23 insertions(+), 9 deletions(-)
>> >
>> > diff --git a/migration/migration.c b/migration/migration.c
>> > index 4cc4077a76..f8d664808f 100644
>> > --- a/migration/migration.c
>> > +++ b/migration/migration.c
>> > @@ -3733,6 +3733,20 @@ static void *migration_thread(void *opaque)
>> >          goto out;
>> >      }
>> >  
>> > +    /*
>> > +     * Only for old 7.1/7.2 machine types running on new binaries (that
>> > +     * supports multifd+postcopy+preempt).  Makes sure to initiate the
>> > +     * connect() after multifd channels because the old (broken) binaries
>> > +     * assumes the order of channels, which we cannot fix anymore.
>> > +     *
>> > +     * multifd_send_setup() will make sure all multifd channels will be
>> > +     * connected first, then initiate preempt channel here guarantees the
>> > +     * ordering to those old binaries.
>> > +     */
>> 
>> It's a bit confusing what's old binary, what's new binary here. Old/new
>
> Yeah, I used "new binaries" to reference 10.1+ on the first line (while in
> context of 7.1/7.2 machine types, they're "new"), but then used "old
> (broken) binaries" on the 3rd line (while in context of after fixing
> incoming side after previous patch, in which case not-fixed ones are
> "old").
>
> My bad, it's probably confusing whoever reads it.
>
> I wrote a new comment:
>
>     /*
>      * Only for old 7.1/7.2 machine types (preempt mode supported since

s/old//

>      * 7.1).  Connect the preempt channel only after multifd channels,
>      * because some QEMU versions (v10.1 to v11.1) will assume the order of
>      * channels to be: (1) main, then (2) multifd channels, then (3)
>      * preempt channel.  IOW, (3) must be after (2).

The last part is not necessary.

>      *
>      * multifd_send_setup() makes sure all multifd channels be connected
>      * first, then initiate preempt channel here guarantees the ordering to
>      * those QEMU binaries.
>      */
>

Thanks, that's better.

>> don't really apply I think as there are more than two cases when we look
>> at the global picture. There's before 7.1, before 7.2, before the
>> preempt_pre_7_2 flag, before the multifd+postcopy support, before this
>
> Most things before multifd+postcopy work do not matter much, because as you
> also mentioned these binaries can't enable both features, so it is not a
> concern in term of channel misorders.
>
>> series, etc. Specially since this code is exactly the same as the one
>> under if (resume), but there we're talking about a different new/old.
>
> Just to mention, we need that separate connection for resuming case below
> in migration_start_outgoing(), because the resuming case doesn't start a
> new migration_thread but reuse the old one.  It means that's the only place
> we can reconnect the preempt channel in resume case.
>
>> 
>> Also, maybe we should avoid framing the assumption on the order of
>> channels as "broken", that's how it always worked and is just a case of
>> unimaginative assumptions, i.e. not knowing multifd would ever run along
>> preempt. The real bug is that v10.1 added a "new" channel to the mix
>> without working on compatibility.
>
> Yes, I feel like we're on the same page.  I think it was used to how it
> always worked before multifd+postcopy merged.  After it merged, it's not
> how it worked, it should never worked, IIUC, hence "broken" after 10.1+.
>
>> 
>> In this series you're doing both: fixing the bug that v10.1 introduced
>> and improving the code to not assume the order of channels.
>
> Note that relying on order of channels are actually OK in 99.9% cases.. So
> that's why I tend to make it a "fix", even if it smells like a feature.
>
> Or say, I'll backport this whole series, when ready, to our zstream, as a
> fix too.  This is the smallest change set I can come up with even if it
> contains something looks like a feature..
>

Yeah, I was trying to come up with a simple fix you could backport where
we could just check s->preempt_pre_7_2 during discovery and force the
order to be correct, but it didn't work.

>> 
>> > +    if (migrate_postcopy_preempt() && s->preempt_pre_7_2) {
>> > +        postcopy_preempt_setup(s);
>> > +    }
>> 
>> Don't you want to check for multifd as well and apply this fix only to
>> the case that can actually trigger it? To avoid inadvertently changing
>> the normal postcopy case.
>
> It's my intention to move this for both cases when multifd is enabled or
> not, because I think it's simpler and cleaner.
>
> If I check multifd here, I'll need to move the migration_start_outgoing()
> code below to check !multifd instead, it'll look like:
>
>   migration_start_outgoing()
>     ...
>     if (resume || !multifd)
>       connect_preempt();
>     if (resume)
>       ...
>
> It looks uglier, so I chose this path forward.  It seems all safe.
>     

Ok, maybe add some words saying you intend to affect both cases.

>> 
>> > +
>> >      bql_lock();
>> >      qemu_savevm_state_header(s->to_dst_file);
>> >      bql_unlock();
>> > @@ -4013,16 +4027,16 @@ void migration_start_outgoing(MigrationState *s)
>> >          open_return_path_on_source(s);
>> >      }
>> >  
>> > -    /*
>> > -     * This needs to be done before resuming a postcopy.  Note: for newer
>> > -     * QEMUs we will delay the channel creation until postcopy_start(), to
>> > -     * avoid disorder of channel creations.
>> > -     */
>> > -    if (migrate_postcopy_preempt() && s->preempt_pre_7_2) {
>> > -        postcopy_preempt_setup(s);
>> > -    }
>> > -
>> 
>> Hm, this used to happen before qmp_migrate() returns. Now it's in the
>
> I think qmp_migrate() should have returned already when creating preempt
> channel, either on master or after applying this patch?
>
> Only socket based URI can use preempt mode, so when reaching here (say, on
> master branch), it should be part of socket_outgoing_migration(), async
> operation of qio_channel_socket_connect_async().
>

Yes, of course, I forgot it's async.

>> migration thread and after multifd channels connect, there's a big
>> window there. We added a lot of code to ensure cleanup of multifd
>> happens properly and without races with TLS thread creation, etc. Have
>> you considered such issues?
>
> Hmm, I'm not aware of the races with TLS thread issue.
>
> /me asks for more hints..
>

Oh, the work we did to ensure cleanup doesn't happen before all threads
are up and running. The semaphore for multifd when creating channels I
added and the changes to tls_thread_created you did. Nevermind, I got
confused with the async part above.

>> 
>> >      if (resume) {
>> > +        /*
>> > +         * This needs to be done before resuming a postcopy.  Note: for newer
>> > +         * QEMUs we will delay the channel creation until postcopy_start(), to
>> > +         * avoid disorder of channel creations.
>> > +         */
>> > +        if (migrate_postcopy_preempt() && s->preempt_pre_7_2) {
>> > +            postcopy_preempt_setup(s);
>> > +        }
>> > +
>> >          /* Wakeup the main migration thread to do the recovery */
>> >          migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP,
>> >                            MIGRATION_STATUS_POSTCOPY_RECOVER);
>> 

