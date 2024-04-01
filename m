Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0ED0CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 17:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrLHv-0001I9-LR; Mon, 01 Apr 2024 13:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rrLHu-0001Hy-5N
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 13:17:38 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rrLHr-0006nZ-WD
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 13:17:37 -0400
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E9C20204A7;
 Mon,  1 Apr 2024 17:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1711991851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k5HZW9gfh1Y2axcpoSac+wM/nJgeowBIzB4WXmvyLD4=;
 b=bdbn/opQlO8yH4c9Ue09s4B5ta3WoJluOnH6zMAv6V2rTJNuw60GDd4SbVOJx2iIKVnUaa
 8EHX/LDIsLGUzHlOvboYd53yBgkyQLNj6BjLjKBI6RXq+Zd+rlC48cM2l+vE1m+/iawRKj
 bI7FGETG54jN9TN6VtXVhgzVprQBaHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1711991851;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k5HZW9gfh1Y2axcpoSac+wM/nJgeowBIzB4WXmvyLD4=;
 b=PeADrpXx0sjaPYQ1RVEyp/uyY/PTTNU3Zy5Kv6bdrccA2EI9XTsLTjbgvyJLHbb0+FpdIn
 bMn9YqEx1n2AbEBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 76B081348C;
 Mon,  1 Apr 2024 17:17:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id +dCFDyvsCmbTaAAAn2gu4w
 (envelope-from <farosas@suse.de>); Mon, 01 Apr 2024 17:17:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "Wang, Lei4" <lei4.wang@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH] migration: Yield coroutine when receiving
 MIG_CMD_POSTCOPY_LISTEN
In-Reply-To: <ZgrdIDGe3aNcRu7o@x1n>
References: <20240329033205.26087-1-lei4.wang@intel.com>
 <DS0PR11MB6373254218DDBF279B13FD79DC3A2@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZgrdIDGe3aNcRu7o@x1n>
Date: Mon, 01 Apr 2024 14:17:28 -0300
Message-ID: <87frw5roif.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.11 / 50.00]; TO_DN_EQ_ADDR_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_THREE(0.00)[3]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: E9C20204A7
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> On Fri, Mar 29, 2024 at 08:54:07AM +0000, Wang, Wei W wrote:
>> On Friday, March 29, 2024 11:32 AM, Wang, Lei4 wrote:
>> > When using the post-copy preemption feature to perform post-copy live
>> > migration, the below scenario could lead to a deadlock and the migration will
>> > never finish:
>> > 
>> >  - Source connect() the preemption channel in postcopy_start().
>> >  - Source and the destination side TCP stack finished the 3-way handshake
>> >    thus the connection is successful.
>> >  - The destination side main thread is handling the loading of the bulk RAM
>> >    pages thus it doesn't start to handle the pending connection event in the
>> >    event loop. and doesn't post the semaphore postcopy_qemufile_dst_done for
>> >    the preemption thread.
>> >  - The source side sends non-iterative device states, such as the virtio
>> >    states.
>> >  - The destination main thread starts to receive the virtio states, this
>> >    process may lead to a page fault (e.g., virtio_load()->vring_avail_idx()
>> >    may trigger a page fault since the avail ring page may not be received
>> >    yet).
>
> Ouch.  Yeah I think this part got overlooked when working on the preempt
> channel.
>
>> >  - The page request is sent back to the source side. Source sends the page
>> >    content to the destination side preemption thread.
>> >  - Since the event is not arrived and the semaphore
>> >    postcopy_qemufile_dst_done is not posted, the preemption thread in
>> >    destination side is blocked, and cannot handle receiving the page.
>> >  - The QEMU main load thread on the destination side is stuck at the page
>> >    fault, and cannot yield and handle the connect() event for the
>> >    preemption channel to unblock the preemption thread.
>> >  - The postcopy will stuck there forever since this is a deadlock.
>> > 
>> > The key point to reproduce this bug is that the source side is sending pages at a
>> > rate faster than the destination handling, otherwise, the qemu_get_be64() in
>> > ram_load_precopy() will have a chance to yield since at that time there are no
>> > pending data in the buffer to get. This will make this bug harder to be
>> > reproduced.
>
> How hard would this reproduce?
>
> I'm thinking whether this should be 9.0 material or 9.1.  It's pretty late
> for 9.0 though, but we can still discuss.
>
>> > 
>> > Fix this by yielding the load coroutine when receiving
>> > MIG_CMD_POSTCOPY_LISTEN so the main event loop can handle the
>> > connection event before loading the non-iterative devices state to avoid the
>> > deadlock condition.
>> > 
>> > Signed-off-by: Lei Wang <lei4.wang@intel.com>
>> 
>> This seems to be a regression issue caused by this commit:
>> 737840e2c6ea (migration: Use the number of transferred bytes directly)
>> 
>> Adding qemu_fflush back to migration_rate_exceeded() or ram_save_iterate
>> seems to work (might not be a good fix though).
>> 
>> > ---
>> >  migration/savevm.c | 5 +++++
>> >  1 file changed, 5 insertions(+)
>> > 
>> > diff --git a/migration/savevm.c b/migration/savevm.c index
>> > e386c5267f..8fd4dc92f2 100644
>> > --- a/migration/savevm.c
>> > +++ b/migration/savevm.c
>> > @@ -2445,6 +2445,11 @@ static int loadvm_process_command(QEMUFile *f)
>> >          return loadvm_postcopy_handle_advise(mis, len);
>> > 
>> >      case MIG_CMD_POSTCOPY_LISTEN:
>> > +        if (migrate_postcopy_preempt() && qemu_in_coroutine()) {
>> > +            aio_co_schedule(qemu_get_current_aio_context(),
>> > +                            qemu_coroutine_self());
>> > +            qemu_coroutine_yield();
>> > +        }
>> 
>> The above could be moved to loadvm_postcopy_handle_listen().
>
> I'm not 100% sure such thing (no matter here or moved into it, which does
> look cleaner) would work for us.
>
> The problem is I still don't yet see an ordering restricted on top of (1)
> accept() happens, and (2) receive LISTEN cmd here.  What happens if the
> accept() request is not yet received when reaching LISTEN?  Or is it always
> guaranteed the accept(fd) will always be polled here?
>
> For example, the source QEMU (no matter pre-7.2 or later) will always setup
> the preempt channel asynchrounously, then IIUC it can connect() after
> sending the whole chunk of packed data which should include this LISTEN.  I
> think it means it's not guaranteed this will 100% work, but maybe further
> reduce the possibility of the race.
>
> One right fix that I can think of is moving the sem_wait(&done) into the
> main thread too, so we wait for the sem _before_ reading the packed data,
> so there's no chance of fault.  However I don't think sem_wait() will be
> smart enough to yield when in a coroutine..  In the long term run I think
> we should really make migration loadvm to do work in the thread rather than
> the main thread.  I think it means we have one more example to be listed in
> this todo so that's preferred..
>
> https://wiki.qemu.org/ToDo/LiveMigration#Create_a_thread_for_migration_destination
>
> I attached such draft patch below, but I'm not sure it'll work.  Let me
> know how both of you think about it.
>
>> 
>> Another option is to follow the old way (i.e. pre_7_2) to do postcopy_preempt_setup
>> in migrate_fd_connect. This can save the above overhead of switching to the
>> main thread during the downtime. Seems Peter's previous patch already solved the
>> channel disordering issue. Let's see Peter and others' opinions.
>
> IIUC we still need that pre_7_2 stuff and keep the postponed connect() to
> make sure the ordering is done properly.  Wei, could you elaborate the
> patch you mentioned?  Maybe I missed some spots.
>
> You raised a good point that this may introduce higher downtime.  Did you
> or Lei tried to measure how large it is?  If that is too high, we may need
> to think another solution, e.g., wait the channel connection before vm stop
> happens.
>
> Thanks,
>
>> 
>> >          return loadvm_postcopy_handle_listen(mis);
>> > 
>> 
>> >      case MIG_CMD_POSTCOPY_RUN:
>> > --
>> > 2.39.3
>> 
>
> ===8<===
> diff --git a/migration/migration.c b/migration/migration.c
> index 696762bc64..bacd1328cf 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2593,6 +2593,12 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>      /*
>       * Make sure the receiver can get incoming pages before we send the rest
>       * of the state
> +     *
> +     * When preempt mode enabled, this must be done after we initiate the
> +     * preempt channel, as destination QEMU will wait for the channel when
> +     * processing the LISTEN request.  Currently it may not matter a huge
> +     * deal if we always create the channel asynchrously with a qio task,
> +     * but we need to keep this in mind.
>       */
>      qemu_savevm_send_postcopy_listen(fb);
>  
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index eccff499cb..4f26a89ac9 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -1254,6 +1254,26 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
>      }
>  
>      if (migrate_postcopy_preempt()) {
> +        /*
> +         * The preempt channel is established in asynchronous way.  Wait
> +         * for its completion.
> +         */
> +        while (!qemu_sem_timedwait(&mis->postcopy_qemufile_dst_done, 100)) {
> +            /*
> +             * Note that to make sure the main thread can still schedule an
> +             * accept() request we need to proactively yield for the main
> +             * loop to run for some duration (100ms in this case), which is
> +             * pretty ugly.
> +             *
> +             * TODO: we should do this in a separate thread to load the VM
> +             * rather than in the main thread, just like the source side.
> +             */
> +            if (qemu_in_coroutine()) {
> +                aio_co_schedule(qemu_get_current_aio_context(),
> +                                qemu_coroutine_self());
> +                qemu_coroutine_yield();

I think the correct way to do this these days is
aio_co_reschedule_self().

Anyway, what we are yielding to here? I see qemu_loadvm_state_main()
called from a bunch of places, it's not clear to me where will the
execution resume after yielding. Is that end up going to be
migration_incoming_process()?

I don't know much about the postcopy parts, excuse my ignorance.

> +            }
> +        }
>          /*
>           * This thread needs to be created after the temp pages because
>           * it'll fetch RAM_CHANNEL_POSTCOPY PostcopyTmpPage immediately.
> @@ -1743,12 +1763,6 @@ void *postcopy_preempt_thread(void *opaque)
>  
>      qemu_sem_post(&mis->thread_sync_sem);
>  
> -    /*
> -     * The preempt channel is established in asynchronous way.  Wait
> -     * for its completion.
> -     */
> -    qemu_sem_wait(&mis->postcopy_qemufile_dst_done);
> -
>      /* Sending RAM_SAVE_FLAG_EOS to terminate this thread */
>      qemu_mutex_lock(&mis->postcopy_prio_thread_mutex);
>      while (preempt_thread_should_run(mis)) {
> -- 
> 2.44.0

