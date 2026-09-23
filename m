Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE03C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9VFb-0001V0-18; Wed, 23 Sep 2026 18:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x9VFZ-0001Ur-D5
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 18:15:37 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x9VFU-0006Th-Vt
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 18:15:37 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4D84B21CA9;
 Wed, 23 Sep 2026 22:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790201726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p8gTI/YNfj65rOorkS7Sv7bIgQ18K0s8Ck+jQVFxX5U=;
 b=N8C0bfd6jJKQf+GYp8uLi7tHqX3rUkUsnxAaDbJfTqKoXnX+8GCCzBU0V23qeIJ9I6TCJ4
 i3D+pJB5yahoVIyPbJYOlbm1Lv/NWoe1rZQqbv2X3fl61+tRR4zR1XXSV1dsy07UCkNl2X
 EHpBkI2ucprN5JNGbsRNoOJW8OmuoYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790201726;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p8gTI/YNfj65rOorkS7Sv7bIgQ18K0s8Ck+jQVFxX5U=;
 b=ac+KuSiL7fLqhqz542oYXf8Jvo3J/6OLhTQ6wGaviDRQZIIWLkLCgExPeNokJC7+GZ4Y5Q
 Qk5HQqI0TVUtoEDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fYWnnStD;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ilz782Mf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790201722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p8gTI/YNfj65rOorkS7Sv7bIgQ18K0s8Ck+jQVFxX5U=;
 b=fYWnnStDBu/VdngCuQ+m966FbUl/cSh+txB4Lx/SVB0m9vmaXqgOX0zL6BEQ1xxbYuDTs5
 QWIbXZ9n29AaxAmbw1mChng6B8d5yvYRMk0+ZGCkdIdm3SZoCofhrNHn+QrVeOylSgyzMj
 vboLojs/osBhcINhVoC0k78FTEC70UE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790201722;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p8gTI/YNfj65rOorkS7Sv7bIgQ18K0s8Ck+jQVFxX5U=;
 b=Ilz782MfJsP7rhPjS/gm06aCDdJEcQgCvgWvh8FAb08IHzaa8H8EERKpa9eFKYh57W9kQe
 0WEmPKtunO68soAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2D22134E8;
 Wed, 23 Sep 2026 22:15:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HHS9EXlPtGrSVgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 23 Sep 2026 22:15:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Akash Kulhalli <akulhall@redhat.com>, Juraj
 Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 6/7] migration: Fix incoming channel race with multifd
 and preempt_pre_7_2
In-Reply-To: <arQ--2rmvQsX-DzE@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260916213558.587304-1-peterx@redhat.com>
 <20260916213558.587304-7-peterx@redhat.com> <87ik3w9d5s.fsf@suse.de>
 <arQ--2rmvQsX-DzE@zhexu-thinkpadt14gen5.rmtcaon.csb>
Date: Wed, 23 Sep 2026 19:15:15 -0300
Message-ID: <87cxu3aa30.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4D84B21CA9
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
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

> On Wed, Sep 23, 2026 at 12:54:07PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > PROBLEM
>> > =======
>> >
>> > Migration reliably hangs with old machine types (7.2-) when these migration
>> > capabilities are enabled: multifd, postcopy-ram, postcopy-preempt.
>> 
>> Is there a way to make this patch unrelated to the 7.2 issue? I think
>> this muddles the discussion a bit. This is a real improvement despite
>> any bug.
>
> I agree this change will make the channel mgmt also more flexible, but
> logically we almost don't need it if there's no such bug [*]..  at very
> minimum, I can add some paragraph before the problem describing this too.
> Would that help?
>
> [*] NOTE: I still agree iowatch is in general always good, but then after
> we have handshake feature ready, we don't need iowatch anymore because we
> can simply attach header for all channels including preempt channel, then
> it's readable too (not only peekable).  I plan to work on handshake feature
> after I came back from kvm forum.  If that can land, after 6 years we
> should be able to revert this whole thing include old channel mgmt.  No
> peek / iowatch / ... needed here for channel establishments.
>
>> 
>> >
>> > Simplest reproducer :
>> >
>> >   $ QTEST_QEMU_MACHINE_TYPE=pc-q35-7.2 \
>> >       QTEST_QEMU_BINARY=./qemu-system-x86_64 \
>> >       ./tests/qtest/migration-test --full \
>> >       -r /x86_64/migration/multifd+postcopy/preempt/plain
>> >
>> > Current workaround is to kill destination QEMU, cancel the migration on
>> > source (with/without yank), disable one or more of the features, and retry.
>> >
>> > The hang is caused by receiving preempt channel before most of the multifd
>> > channels, the peek buffer operation will stuck forever.
>> >
>> > Incoming side QEMU hang (with relevant tracepoints enabled):
>> >
>> >   migrate_set_state new state setup
>> >   migration_socket_incoming_accepted
>> >   migration_set_incoming_channel ioc=0x557d82c1caa0 ioctype=qio-channel-socket
>> >   migration_socket_incoming_accepted
>> >   migration_set_incoming_channel ioc=0x557d83023840 ioctype=qio-channel-socket
>> >   multifd_recv_new_channel channel 1
>> >   migration_socket_incoming_accepted
>> >   migration_set_incoming_channel ioc=0x557d830c08c0 ioctype=qio-channel-socket
>> >   multifd_recv_new_channel channel 0
>> >   multifd_recv_thread_start 1
>> >   migration_socket_incoming_accepted
>> >   migration_set_incoming_channel ioc=0x557d8284a010 ioctype=qio-channel-socket
>> >   multifd_recv_thread_start 0
>> >   multifd_recv_unfill channel 0 packet_num 0 flags 0x1 next packet size 0
>> >   multifd_recv_unfill channel 1 packet_num 1 flags 0x1 next packet size 0
>> >   [dest qemu hangs here]
>> >
>> > Incoming side backtrace:
>> >
>> >   __syscall_cancel_arch
>> >   __internal_syscall_cancel
>> >   __syscall_cancel
>> >   recvmsg
>> >   qio_channel_socket_readv
>> >   qio_channel_readv_full
>> >   migration_channel_read_peek
>> >   migration_channel_identify
>> >   migration_channel_process_incoming
>> >   socket_accept_incoming_migration
>> >   qio_net_listener_channel_func
>> >   qio_channel_fd_source_dispatch
>> >   g_main_context_dispatch_unlocked.lto_priv
>> >   g_main_context_dispatch
>> >   glib_pollfds_poll
>> >   os_host_main_loop_wait
>> >   main_loop_wait
>> >   qemu_main_loop
>> >   qemu_default_main
>> >   main
>> >
>> > This patch tries to fix it, from incoming side first.  This patch alone
>> > should enable single-direction migration to this new QEMU.  The next patch
>> > will propose a fix for the outgoing path, fixing new->old migrations.
>> >
>> > BACKGROUND
>> > ==========
>> >
>> > preempt_pre_7_2 used to be a flag marking QEMU releases 7.1/7.2 only
>> > because they have a flaw on channel establishment on preempt channel.
>> >
>> > Now, after we have multifd + postcopy support, new QEMU binaries can
>> > migrate old machine types with both features enabled.  Juraj reported
>> > constant migration hang at the very beginning for those old machine types
>> > in our downstream systems with such setup.  Juraj found it's because of
>> > this flag.
>> >
>> > QEMU source initiates channels in this order on current master when both
>> > features enabled with postcopy-preempt mode:
>> >
>> >   - First, main channel connect() happens,
>> >   - Second, postcopy_preempt_setup() invokes connect() for preempt channel,
>> >   - Last, in migration_thread(), multifd_send_setup() invokes connect()s
>> >     for all the multifd channels
>> 
>> Other way around, no?
>> 
>> (master/11.1/src) only starts preempt when postcopy starts.
>> (master/11.1/dst) peeks main, peeks multifd, preempt comes when main and
>> multifd have already been found, so it is assumed to be preempt.
>
> Yes, only when with newer machine types (8.0+).  The statement here should
> be correct for machine type 7.2, which is what this bug is about.  How
> about I update the previous sentence to be this instead?
>
>   QEMU source initiates channels in this order on current master when both
>   features enabled with postcopy-preempt mode (machine type 7.2, implies
>   preempt_pre_7_2=on):
>

Ok, but remember the patch affects all versions even if we just mention
7.2. We have this fresh now, but later down the line we might get
confused.

>> 
>> >
>> > However on an old QEMU, it expect the channels arrive in order of
>> > "main"->"multifd"->"preempt".  Even on a new QEMU, the destination expects
>> > the same order of arrival on the channels when the channels are not
>> > peekable.
>> >
>> 
>> (master/7.2/src) starts main, then preempt, then multifd.
>> (master/7.2 or 11.1/dst) peeks main, peeks multifd then hangs because preempt is
>> peekable but doesn't send data right away.
>
> Yes.
>
>> 
>> > For peekable channels (non-tls sockets), this time we'll likely see preempt
>> > channel appearing very soon, peeking at it causing main thread hang, like
>> > mentioned in the PROBLEM section above.
>> >
>> 
>> Yes.
>> 
>> > SOLUTION
>> > ========
>> >
>> > One major problem of current hang is we try to peek at preempt channel,
>> > which offers nothing at the beginning.
>> >
>> > Since we'll need to accept stream from old binaries, arrival of preempt
>> > channel early is unavoidable.
>> >
>> 
>> No, because old binary doesn't support multifd+postcopy, so there's only
>> either main + multifd or main + preempt.
>> 
>> New binary with old machine type is the only one that can send preempt
>> early.
>
> I'll update this sentence to be:
>
>   Since we'll need to accept stream from old binaries (QEMU 10.1 to 11.1),
>   arrival of preempt channel early is unavoidable.
>

I see, you mean not-so-old binaries =)

>> 
>> > What we can do, though, is to allow concurrent monitoring of all channels
>> > rather than one.  Meanwhile, we shouldn't peek at anything that has no
>> > data.
>> >
>> 
>> I wonder why do we need to peek at all. Can't we start n threads and
>> recv() a data chunk of fixed size (smaller than the preempt request) on
>> every channel that comes up? Each thread puts the (data chunk + ioc) on
>> a list and exits. The channels that don't send data would just sit there
>> until something comes up.
>> 
>> Most channels would have data with a magic value right away so we'd
>> empty the list before the preempt request comes up. But having a list
>> means we can just iterate it when a consumer that has not yet received a
>> channel asks for a piece of data.
>> 
>> We could also check that the data in the supposed preempt channel is a
>> page request.
>
> I'm not sure I fully get your proposal here, just to mention: preempt
> channel has no data, recv() on it hangs like what already happens with this
> bug.  Then, how do we recycle a hanged recv() thread with its ioc?
>

We let it hang. Preempt channel is only needed way later. We currently
go through this channel discovery just to do:

        f = qemu_file_new_input(ioc);
        qemu_file_set_blocking(file, true, &error_abort);
        mis->postcopy_qemufile_dst = file;
        qemu_sem_post(&mis->postcopy_qemufile_dst_done);

We need mis->postcopy_qemufile_dst just to pass it to
ram_load_postcopy(). But if we put a layer in between that manages the
ioc data, we could have the _very first_ recv() of ram_load_postcopy()
hang until the request comes. It's functionally almost the same as
waiting on postcopy_qemufile_dst_done.

> The other question is, anything else that wants to read from any migration
> channel will need to take this (data chunk, ioc) info, because it needs to
> read from "data chunk" first until depleted.  That's awkward.
>

Well, "anything else" reading from "any migration channel" is exactly
why we're doing the channel discovery. It's just that today "anything
else" needs to wait for channel identification to happen.

Yes, it needs to be depleted, but it's just the first reads.

> Actually, since this solution doesn't work for TLS, I wanted to do
> something like this and make TLS iochannel peekable (basically we can keep
> that data chunk inside ioc for tls only), then as long as peekable this
> solution will work too for TLS.  But I thought about it and I think it's
> not worth it.  It'll pollute tls code.
>

I'm not sure how strong that argument is. We keep telling ourselves that
the migration code is missing something, but it's not like we need to
cross a bridge to touch any other subsystem. If we need it, we need it.

But fine, of course, if you don't want to touch that bee nest.

>> 
>> > migration_channel_read_peek() almost does the wait, but it's too late.
>> > This patch proposes to watch all channels from the start without reading at
>> > them at all, relying on an IO watch attached.  This will make sure (1) for
>> > preempt channel, we never read on it (watch can be gracefully disarmed when
>> > we know it's preempt channel later) (2) since we have one IO watch for each
>> > channel, then we can allow accept() to happen in almost any order, process
>> > only when there's some header to read.
>> >
>> > To maintain these watches, a new GArray @channels_early is introduced, with
>> > each element to be a (ioc, GSource) tuple (@MigEarlyIncomingChannel), so
>> > that QEMU can manage all the IO watches later with it.  Here I used GSource
>> > rather than io_tag because the GSource may or may not be attached to the
>> > default main thread gcontext: when OOB is used, it may be the iothread
>> > context instead.  IOW, g_source_remove() on io_tags stops working, which
>> > only works for default main context.
>> >
>> > The trick this patch used is when we have the ability to wait on all
>> > channel headers at the same time, we pick one by one from main and multifd
>> > channels (since both of the types will contain headers dumped right at the
>> > very beginning), leave preempt channel alone.  It means, after dest QEMU
>> > finds all main and multifd channels, there are three possibilities:
>> >
>> >   - If preempt not enabled, we finished full channel establishment, done.
>> >
>> 
>> I don't see why we need "channel establishment" at all. We're simply
>> taking iochannels and putting them into named QEMUFiles, this means
>> nothing. We could keep a list of unknown channels around indefinitely
>> and fetch them lazily when the data is needed. By that point, the
>> channels that have magic values would have already been identified and
>> what's left is the unindentified channel.
>
> Isn't that kind of what this iowatch does?   It puts channels into the
> MigEarlyIncomingChannel, until it has something to read.  The only
> difference is, this patch will wait for all magics arrived to continue
> rather than continue then wait randomly at later points: I don't see how to
> achieve that without modifying code later.
>

Right, I'm suggesting to modify the code later. 

>> 
>> This would allow us add new channels with a proper header without
>> interfering with the old channels. As long as the new channels are not
>> to be consumed too soon.
>
> I hope we don't introduce new channels until we have the handshake feature
> ready.  Again, I'll prioritize that feature.
>

I support the handshake idea, I'm just thinking what can be done
incrementally.

I mean we could start sending a header on one of the existing channels
and keep a non-header version for compatibility. The updated code would
pick the new version and ignore the old one, the old code (but still
with this change) would pick the channel without header.

>> 
>> >   - If preempt enabled,
>> >
>> >     - If we have one registered IO watch with the IOC, it must be the
>> >       preempt channel,
>> >
>> >     - If we have no further IO watch, wait for the next accept(), which
>> >       must be the preempt channel.
>> >
>> 
>> Ok, so watch all connections concurrently and pick the last one as
>> preempt.
>
> Right.
>
>> 
>> > This will make channel establish work on incoming side even with the old
>> > QEMU binaries.
>> >
>> > While working on it, I managed to refactor the peeking logic quite a bit:
>> > we used to have a very convoluted migration_channel_identify() function,
>> > taking care of two different cases:
>> >
>> > (1) when the channel is peekable (like normal socket channels),
>> > (2) when the channel is not peekable (like TLS or file migrations).
>> >
>> > This patch refactored that part to make it crystal clear on how we make
>> > decisions on which channel is which, and split the peek/identify paths.
>> >
>> 
>> I'm still bothered about the peek. The data is all intended for the
>> destination machine, it owns it all, it can just consume it and put it
>> in the pocket.
>
> With MSG_PEEK, such buffer doesn't help.
>

Right, but the politeness in not touching data that is not meant for you
by peeking is unnecessary, we could put a temporary orchestrator in
front of it and let it dispatch the first few bytes of data until every
channel is properly identified.

> Without MSG_PEEK (TLS's case) it may help, but again, I decided to not go
> with it, and I'll just prioritize the handshake feature instead.
>

Ok, then I'll continue review of the code in the morning.

>> 
>> > One example incoming migration from pc-q35-7.2 after this patch applied,
>> > and with relevant tracepoints set (8 multifd channels, 1 preempt channel):
>> >
>> >   migrate_set_state new state setup
>> >   migration_channel_process_incoming ioc=0x557dc8af4e20 ioctype=qio-channel-socket
>> >   migration_incoming_channel_watch ioc=0x557dc8af4e20 ioctype=qio-channel-socket
>> >   migration_channel_process_incoming ioc=0x557dc8abc5d0 ioctype=qio-channel-socket
>> >   migration_incoming_channel_watch ioc=0x557dc8abc5d0 ioctype=qio-channel-socket
>> >   migration_channel_process_incoming ioc=0x557dc953d680 ioctype=qio-channel-socket
>> >   migration_incoming_channel_watch ioc=0x557dc953d680 ioctype=qio-channel-socket
>> >   migration_set_incoming_channel ioc=0x557dc8abc5d0 ioctype=qio-channel-socket type=MULTIFD
>> >   migration_channel_process_incoming ioc=0x557dc898a820 ioctype=qio-channel-socket
>> >   migration_incoming_channel_watch ioc=0x557dc898a820 ioctype=qio-channel-socket
>> >   migration_set_incoming_channel ioc=0x557dc953d680 ioctype=qio-channel-socket type=MULTIFD
>> >   migration_channel_process_incoming ioc=0x557dc919bd70 ioctype=qio-channel-socket
>> >   migration_incoming_channel_watch ioc=0x557dc919bd70 ioctype=qio-channel-socket
>> >   migration_set_incoming_channel ioc=0x557dc898a820 ioctype=qio-channel-socket type=MULTIFD
>> >   migration_channel_process_incoming ioc=0x557dc8734b20 ioctype=qio-channel-socket
>> >   migration_incoming_channel_watch ioc=0x557dc8734b20 ioctype=qio-channel-socket
>> >   migration_set_incoming_channel ioc=0x557dc919bd70 ioctype=qio-channel-socket type=MULTIFD
>> >   migration_channel_process_incoming ioc=0x557dc898bdf0 ioctype=qio-channel-socket
>> >   migration_incoming_channel_watch ioc=0x557dc898bdf0 ioctype=qio-channel-socket
>> >   migration_set_incoming_channel ioc=0x557dc8734b20 ioctype=qio-channel-socket type=MULTIFD
>> >   migration_channel_process_incoming ioc=0x557dc968cfd0 ioctype=qio-channel-socket
>> >   migration_incoming_channel_watch ioc=0x557dc968cfd0 ioctype=qio-channel-socket
>> >   migration_set_incoming_channel ioc=0x557dc898bdf0 ioctype=qio-channel-socket type=MULTIFD
>> >   migration_channel_process_incoming ioc=0x557dc8c31810 ioctype=qio-channel-socket
>> >   migration_incoming_channel_watch ioc=0x557dc8c31810 ioctype=qio-channel-socket
>> >   migration_set_incoming_channel ioc=0x557dc968cfd0 ioctype=qio-channel-socket type=MULTIFD
>> >   migration_set_incoming_channel ioc=0x557dc8c31810 ioctype=qio-channel-socket type=MULTIFD
>> >   migration_set_incoming_channel ioc=0x557dc8af4e20 ioctype=qio-channel-socket type=MAIN
>> 
>> Hm, multifd came first? Have you registered watches in reverse order or
>> something? Not sure if it matters much.
>
> This is after the patchset applied.  Multifd channels should come first
> because I changed preempt channel to be after multifd in the next patch.
> So this is expected behavior.
>

I mean they came before MAIN, PREEMPT is down below.

>> 
>> >   migration_start_incoming
>> >   migrate_set_state new state active
>> >   migration_channel_process_incoming ioc=0x557dc8966160 ioctype=qio-channel-socket
>> >   migration_set_incoming_channel ioc=0x557dc8966160 ioctype=qio-channel-socket type=PREEMPT
>> >
>> > While at it, I renamed the four channel incoming/outgoing tracepoints, make
>> > all to follow migration_[incoming|outgoing]_channel_*().  Especially for
>> > incoming, then we can enable migration_incoming_channel* for incoming
>> > channel debuggings.
>> >
>> > FINAL NOTE ON TLS
>> > =================
>> >
>> > Note that this solution isn't a magic bullet fixing everything.  TLS is not
>> > fixable with this approach because TLS isn't peekable channel, hence the
>> > watch won't help.
>> >
>> > We can have other ways to hack it to make it work, e.g. we can make TLS
>> > channels peekable too, but I don't want to pollute the TLS iochannel only
>> > for this: let's hope handshake will arrive soon so we can drop these code.
>> >
>> > For now, when TLS is involved with such old machine type (7.2-), one needs
>> > to migrate it out with any combination of features except enabling all
>> > four (multifd + TLS + postcopy + preempt) to a patched binary, after that,
>> > all combinations will start working.
>> >
>> 
>> I don't understand where TLS comes into this. You mean TLS is not
>> peekable so if we use TLS for the multifd channels, then we cannot
>> tell them apart from preempt?
>
> Yep.  TLS channels doesn't set QIO_CHANNEL_FEATURE_READ_MSG_PEEK, so it's
> not peekable.  Internally, it's simply because there's no simple MSG_PEEK
> equivalent for gnutls facilities, IIUC.
>

Ok, but let me understand this, the data still goes through the peekable
iochannel, right?

    ret = qio_channel_read(tioc->master, buf, len, errp);

So wouldn't it be simple to implement a peek operation? Mostly the io/
layer boilerplate.

>> 
>> > BugLink: https://redhat.atlassian.net/browse/RHEL-254933
>> > Fixes: e27418861288 ("migration: enable multifd and postcopy together")
>> > Reported-by: Juraj Marcin <jmarcin@redhat.com>
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  migration/channel.h    |   3 +
>> >  migration/migration.h  |  35 ++++
>> >  migration/channel.c    | 414 +++++++++++++++++++++++++++++++++++------
>> >  migration/migration.c  |  23 ++-
>> >  migration/trace-events |   7 +-
>> >  5 files changed, 421 insertions(+), 61 deletions(-)
>> >
>> 
>> I'll wait for your replies before reviewing the code in detail.
>
> Sure, the change is slightly involved indeed, it makes more sense we
> clarify problems and high level things before going into details if there's
> anything unclear.  Let me know if there're more things you'd ask, or things
> I overlooked.

I'm fine with it design-wise and functionality-wise. I'm a bit concerned
about memory management, we start messing with GSource, we start having
leaks all over the place. But I haven't looked at it in detail, let's
not worry in advance, I'll tell you tomorrow when I review it properly.

