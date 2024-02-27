Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660DFC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rey0s-0002LJ-Dl; Tue, 27 Feb 2024 09:00:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rey0q-0002Jf-Ht
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:00:53 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rey0o-0001Dj-7L
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:00:52 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8B0041FB96;
 Tue, 27 Feb 2024 14:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709042447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5wqHdM5g7GOHtXa4QCRDvVkR8pbLz0z2eeAgVKjHzag=;
 b=0X2pvXzeBnjeUHAk7SWhmgxY+AtcqyjqyY3aXsboxt8O0Ti3i3ekcVpWzMnUPDKZ3EhVBt
 Il5+/G9TyBDyTBjmFocGMoYe/Pp6eHA64CLdY3jHuWdJJnU4tlZyPZgESlk9dLKRTCBjFX
 1FjqS9klOvpQcK7FBnTrpqcOasEwjNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709042447;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5wqHdM5g7GOHtXa4QCRDvVkR8pbLz0z2eeAgVKjHzag=;
 b=jS2u+uTHpIocwc97S/Q3NP6x1QQTAiWo/tzMYeImO4nTt/j2GSgQ6TCgS0aIBmB4FW4jbU
 wsgS+KAbI6esiYCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709042447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5wqHdM5g7GOHtXa4QCRDvVkR8pbLz0z2eeAgVKjHzag=;
 b=0X2pvXzeBnjeUHAk7SWhmgxY+AtcqyjqyY3aXsboxt8O0Ti3i3ekcVpWzMnUPDKZ3EhVBt
 Il5+/G9TyBDyTBjmFocGMoYe/Pp6eHA64CLdY3jHuWdJJnU4tlZyPZgESlk9dLKRTCBjFX
 1FjqS9klOvpQcK7FBnTrpqcOasEwjNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709042447;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5wqHdM5g7GOHtXa4QCRDvVkR8pbLz0z2eeAgVKjHzag=;
 b=jS2u+uTHpIocwc97S/Q3NP6x1QQTAiWo/tzMYeImO4nTt/j2GSgQ6TCgS0aIBmB4FW4jbU
 wsgS+KAbI6esiYCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10E3813A65;
 Tue, 27 Feb 2024 14:00:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fcdbMg7r3WVtNwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 27 Feb 2024 14:00:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Claudio
 Fontana <cfontana@suse.de>
Subject: Re: [PATCH v4 22/34] migration/multifd: Prepare multifd sync for
 fixed-ram migration
In-Reply-To: <Zd1cj4jkIpUktu6k@x1n>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-23-farosas@suse.de> <ZdxCLmKFirsXPia-@x1n>
 <87y1b6alej.fsf@suse.de> <Zd1cj4jkIpUktu6k@x1n>
Date: Tue, 27 Feb 2024 11:00:44 -0300
Message-ID: <87plwivwfn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> On Mon, Feb 26, 2024 at 07:52:20PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Tue, Feb 20, 2024 at 07:41:26PM -0300, Fabiano Rosas wrote:
>> >> The fixed-ram migration can be performed live or non-live, but it is
>> >> always asynchronous, i.e. the source machine and the destination
>> >> machine are not migrating at the same time. We only need some pieces
>> >> of the multifd sync operations.
>> >> 
>> >> multifd_send_sync_main()
>> >> ------------------------
>> >>   Issued by the ram migration code on the migration thread, causes the
>> >>   multifd send channels to synchronize with the migration thread and
>> >>   makes the sending side emit a packet with the MULTIFD_FLUSH flag.
>> >> 
>> >>   With fixed-ram we want to maintain the sync on the sending side
>> >>   because that provides ordering between the rounds of dirty pages when
>> >>   migrating live.
>> >> 
>> >> MULTIFD_FLUSH
>> >> -------------
>> >>   On the receiving side, the presence of the MULTIFD_FLUSH flag on a
>> >>   packet causes the receiving channels to start synchronizing with the
>> >>   main thread.
>> >> 
>> >>   We're not using packets with fixed-ram, so there's no MULTIFD_FLUSH
>> >>   flag and therefore no channel sync on the receiving side.
>> >> 
>> >> multifd_recv_sync_main()
>> >> ------------------------
>> >>   Issued by the migration thread when the ram migration flag
>> >>   RAM_SAVE_FLAG_MULTIFD_FLUSH is received, causes the migration thread
>> >>   on the receiving side to start synchronizing with the recv
>> >>   channels. Due to compatibility, this is also issued when
>> >>   RAM_SAVE_FLAG_EOS is received.
>> >> 
>> >>   For fixed-ram we only need to synchronize the channels at the end of
>> >>   migration to avoid doing cleanup before the channels have finished
>> >>   their IO.
>> >> 
>> >> Make sure the multifd syncs are only issued at the appropriate
>> >> times. Note that due to pre-existing backward compatibility issues, we
>> >> have the multifd_flush_after_each_section property that enables an
>> >> older behavior of synchronizing channels more frequently (and
>> >> inefficiently). Fixed-ram should always run with that property
>> >> disabled (default).
>> >
>> > What if the user enables multifd_flush_after_each_section=true?
>> >
>> > IMHO we don't necessarily need to attach the fixed-ram loading flush to any
>> > flag in the stream.  For fixed-ram IIUC all the loads will happen in one
>> > shot of ram_load() anyway when parsing the ramblock list, so.. how about we
>> > decouple the fixed-ram load flush from the stream by always do a sync in
>> > ram_load() unconditionally?
>> 
>> I would like to. But it's not possible because ram_load() is called once
>> per section. So once for each EOS flag on the stream. We'll have at
>> least two calls to ram_load(), once due to qemu_savevm_state_iterate()
>> and another due to qemu_savevm_state_complete_precopy().
>> 
>> The fact that fixed-ram can use just one load doesn't change the fact
>> that we perform more than one "save". So we'll need to use the FLUSH
>> flag in this case unfortunately.
>
> After I re-read it, I found one more issue.
>
> Now recv side sync is "once and for all" - it doesn't allow a second time
> to sync_main because it syncs only until quits.  That is IMHO making the
> code much harder to maintain, and we'll need rich comment to explain why is
> that happening.
>
> Ideally any "sync main" for recv threads can be called multiple times.  And
> IMHO it's not really hard.  Actually it can make the code much cleaner by
> merging some logic between socket-based and file-based from that regard.
>
> I tried to play with your branch and propose something like this, just to
> show what I meant. This should allow all new fixed-ram test to pass here,
> meanwhile it should allow sync main on recv side to be re-entrant, sharing
> the logic with socket-based as much as possible:
>
> =====
> diff --git a/migration/multifd.c b/migration/multifd.c
> index a0202b5661..28480f6cfe 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -86,10 +86,8 @@ struct {
>      /* number of created threads */
>      int count;
>      /*
> -     * For sockets: this is posted once for each MULTIFD_FLAG_SYNC flag.
> -     *
> -     * For files: this is only posted at the end of the file load to mark
> -     *            completion of the load process.
> +     * This is always posted by the recv threads, the main thread uses it
> +     * to wait for recv threads to finish assigned tasks.
>       */
>      QemuSemaphore sem_sync;
>      /* global number of generated multifd packets */
> @@ -1316,38 +1314,55 @@ void multifd_recv_cleanup(void)
>      multifd_recv_cleanup_state();
>  }
>  
> -
> -/*
> - * Wait until all channels have finished receiving data. Once this
> - * function returns, cleanup routines are safe to run.
> - */
> -static void multifd_file_recv_sync(void)
> +static void multifd_recv_file_sync_request(void)
>  {
>      int i;
>  
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
>  
> -        trace_multifd_recv_sync_main_wait(p->id);
> -
> +        /*
> +         * We play a trick here: instead of using a separate pending_sync
> +         * to send a sync request (like what we do on senders), we simply
> +         * kick the recv thread once without setting pending_job.
> +         *
> +         * If there's already a pending_job, the thread will only see it
> +         * after it processed the current.  If there's no pending_job,
> +         * it'll see this immediately.
> +         */
>          qemu_sem_post(&p->sem);
> -
>          trace_multifd_recv_sync_main_signal(p->id);
> -        qemu_sem_wait(&p->sem_sync);
>      }
> -    return;
>  }
>  
> +/*
> + * Request a sync for all the multifd recv threads.
> + *
> + * For socket-based, sync request is much more complicated, which relies on
> + * collaborations between both explicit RAM_SAVE_FLAG_MULTIFD_FLUSH in the
> + * main stream, and MULTIFD_FLAG_SYNC flag in per-channel protocol.  Here
> + * it should be invoked by the main stream request.
> + *
> + * For file-based, it is much simpler, because there's no need for a strong
> + * sync semantics between the main thread and the recv threads.  What we
> + * need is only to make sure all recv threads finished their tasks.
> + */
>  void multifd_recv_sync_main(void)
>  {
> +    bool file_based = !multifd_use_packets();
>      int i;
>  
>      if (!migrate_multifd()) {
>          return;
>      }
>  
> -    if (!multifd_use_packets()) {
> -        return multifd_file_recv_sync();
> +    if (file_based) {
> +        /*
> +         * File-based multifd requires an explicit sync request because
> +         * tasks are assigned by the main recv thread, rather than parsed
> +         * through the multifd channels.
> +         */
> +        multifd_recv_file_sync_request();
>      }
>  
>      for (i = 0; i < migrate_multifd_channels(); i++) {
> @@ -1356,6 +1371,11 @@ void multifd_recv_sync_main(void)
>          trace_multifd_recv_sync_main_wait(p->id);
>          qemu_sem_wait(&multifd_recv_state->sem_sync);
>      }
> +
> +    if (file_based) {
> +        return;
> +    }
> +
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
>  
> @@ -1420,11 +1440,12 @@ static void *multifd_recv_thread(void *opaque)
>              }
>  
>              /*
> -             * Migration thread did not send work, break and signal
> -             * sem_sync so it knows we're not lagging behind.
> +             * Migration thread did not send work, this emulates
> +             * pending_sync, post sem_sync to notify the main thread.
>               */
>              if (!qatomic_read(&p->pending_job)) {
> -                break;
> +                qemu_sem_post(&multifd_recv_state->sem_sync);
> +                continue;
>              }
>  
>              has_data = !!p->data->size;
> @@ -1449,10 +1470,6 @@ static void *multifd_recv_thread(void *opaque)
>          }
>      }
>  
> -    if (!use_packets) {
> -        qemu_sem_post(&p->sem_sync);
> -    }
> -
>      if (local_err) {
>          multifd_recv_terminate_threads(local_err);
>          error_free(local_err);
>
> ==========
>
> Note that I used multifd_recv_state->sem_sync to send the message rather
> than p->sem, not only because socket-based has similar logic on using that
> sem, but also because main thread shouldn't care about "which" recv thread
> has finished, but "all recv threads are idle".
>
> Do you think this should work out for us in a nicer way?
>

I don't really like the interleaving of file and socket logic at
multifd_recv_sync_main(), but I can live with it.

Waiting on multifd_recv_state->sem_sync is problematic because if the
thread has an error, that will hang forever.

Actually, I don't even see this being handled in _current_ code
anywhere, we probably have a bug there. I guess we need to add one more
"post this sem just because" somewhere. multifd_recv_kick_main probably.

> Then we talk about the other issue, on whether we should rely on migration
> stream to flush recv threads.  My answer is still hopefully a no.
>
> In the ideal case, fixed-ram image format should even be tailed to not use
> a live stream protocol.  For example, currently during ram iterations we
> should flush quite a lot of ram QEMU_VM_SECTION_PART sections contains
> mostly rubbish but then ending that with RAM_SAVE_FLAG_EOS. Then we keep
> doing this in the iteration loop.  Here the real meat is during processing
> of QEMU_VM_SECTION_PART, the src QEMU will update the guest pages with
> fixed offsets in the file.  That however doesn't really contribute to
> anything valuable in the migration stream itself (things sent over
> to_dst_file).
>
> AFAIU we chose to still use that logic only for simplicity, even if we know
> those EOSs and all RAM streams are garbage.  Now we tend to add one
> dependency on part of the garbage, which is RAM_SAVE_FLAG_MULTIFD_FLUSH in
> this case; which is useful in socket-based but shouldn't be necessary for
> file.
>
> I think I have a solution besides ram_load(): ultimately fixed-ram stores
> all guest mem in the QEMU_VM_SECTION_START section of the ram, through all
> of the RAM_SAVE_FLAG_MEM_SIZE (which leads to parse_ramblocks()).  If so,
> perhaps we can do one shot sync for file at the end of parse_ramblocks()?
> Then we decouple sync_main on recv for file-based completely against all
> stream flags.

Yeah, that could work. I think I'll blacklist all unused flags using the
invalid_flags logic.

Thanks

