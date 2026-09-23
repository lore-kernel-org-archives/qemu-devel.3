Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D797BC98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9PIs-0000nI-3I; Wed, 23 Sep 2026 11:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x9PIh-0000mJ-4W
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 11:54:27 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x9PIb-0001HE-O8
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 11:54:26 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CDFD01FFA7;
 Wed, 23 Sep 2026 15:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790178855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sf1gUb7pr8jJPHfUwwaU9Z4WhLlWEY7oPFN6DPaoY6k=;
 b=DtfCtqab8IQ3syS4YZLHCSpazADRvJrq3uaNnUqM8MZLnhuhCAl/ZA12Zyxv31pfzaCB6w
 8s5jlZt5ARR7BUun7kvHI3ulV9cRl0ZqLCK7/lD+/n8JprFrvhCpiTdMbslbZ1n8lWihco
 oTE6RQI+i2C1dlWKF8BVCdNXfdsEYNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790178855;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sf1gUb7pr8jJPHfUwwaU9Z4WhLlWEY7oPFN6DPaoY6k=;
 b=b1SoVhMslYZSoWlx+g8DsZpTo6lZ1VqTvdzeKB3WayP0iqE0pFbkpsoOPWVFtg29WG4Ig8
 g+kB5UFzBiLZrFAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Aqn4LvGn;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5ufkaRnf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790178850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sf1gUb7pr8jJPHfUwwaU9Z4WhLlWEY7oPFN6DPaoY6k=;
 b=Aqn4LvGneGbILqqxAW0Qs7txY3HxpQcXu7flzK4V9mroWrDviIcDaYd4GTtepfq+Y40SwI
 dhinV0i/T/TxgQV8j1BaCbZP3HdIsshf0+kEjE1Ho87l7kzJ1wLbv8dLYyURjlCwBSpTeD
 4rcs92KYi3h9Vjr4DN/iraoiNIgxG2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790178850;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sf1gUb7pr8jJPHfUwwaU9Z4WhLlWEY7oPFN6DPaoY6k=;
 b=5ufkaRnfvd9gu/ooU44w5YjY1rIbppZlsdBFAfYiknRK9NySYjh4iykUaCv7iEy9N2imqk
 iUUskFVc7BlCndDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 228D313432;
 Wed, 23 Sep 2026 15:54:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5JA+LiH2s2qiRwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 23 Sep 2026 15:54:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akash Kulhalli <akulhall@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 6/7] migration: Fix incoming channel race with multifd
 and preempt_pre_7_2
In-Reply-To: <20260916213558.587304-7-peterx@redhat.com>
References: <20260916213558.587304-1-peterx@redhat.com>
 <20260916213558.587304-7-peterx@redhat.com>
Date: Wed, 23 Sep 2026 12:54:07 -0300
Message-ID: <87ik3w9d5s.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CDFD01FFA7
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.de:+]
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

> PROBLEM
> =======
>
> Migration reliably hangs with old machine types (7.2-) when these migration
> capabilities are enabled: multifd, postcopy-ram, postcopy-preempt.

Is there a way to make this patch unrelated to the 7.2 issue? I think
this muddles the discussion a bit. This is a real improvement despite
any bug.

>
> Simplest reproducer :
>
>   $ QTEST_QEMU_MACHINE_TYPE=pc-q35-7.2 \
>       QTEST_QEMU_BINARY=./qemu-system-x86_64 \
>       ./tests/qtest/migration-test --full \
>       -r /x86_64/migration/multifd+postcopy/preempt/plain
>
> Current workaround is to kill destination QEMU, cancel the migration on
> source (with/without yank), disable one or more of the features, and retry.
>
> The hang is caused by receiving preempt channel before most of the multifd
> channels, the peek buffer operation will stuck forever.
>
> Incoming side QEMU hang (with relevant tracepoints enabled):
>
>   migrate_set_state new state setup
>   migration_socket_incoming_accepted
>   migration_set_incoming_channel ioc=0x557d82c1caa0 ioctype=qio-channel-socket
>   migration_socket_incoming_accepted
>   migration_set_incoming_channel ioc=0x557d83023840 ioctype=qio-channel-socket
>   multifd_recv_new_channel channel 1
>   migration_socket_incoming_accepted
>   migration_set_incoming_channel ioc=0x557d830c08c0 ioctype=qio-channel-socket
>   multifd_recv_new_channel channel 0
>   multifd_recv_thread_start 1
>   migration_socket_incoming_accepted
>   migration_set_incoming_channel ioc=0x557d8284a010 ioctype=qio-channel-socket
>   multifd_recv_thread_start 0
>   multifd_recv_unfill channel 0 packet_num 0 flags 0x1 next packet size 0
>   multifd_recv_unfill channel 1 packet_num 1 flags 0x1 next packet size 0
>   [dest qemu hangs here]
>
> Incoming side backtrace:
>
>   __syscall_cancel_arch
>   __internal_syscall_cancel
>   __syscall_cancel
>   recvmsg
>   qio_channel_socket_readv
>   qio_channel_readv_full
>   migration_channel_read_peek
>   migration_channel_identify
>   migration_channel_process_incoming
>   socket_accept_incoming_migration
>   qio_net_listener_channel_func
>   qio_channel_fd_source_dispatch
>   g_main_context_dispatch_unlocked.lto_priv
>   g_main_context_dispatch
>   glib_pollfds_poll
>   os_host_main_loop_wait
>   main_loop_wait
>   qemu_main_loop
>   qemu_default_main
>   main
>
> This patch tries to fix it, from incoming side first.  This patch alone
> should enable single-direction migration to this new QEMU.  The next patch
> will propose a fix for the outgoing path, fixing new->old migrations.
>
> BACKGROUND
> ==========
>
> preempt_pre_7_2 used to be a flag marking QEMU releases 7.1/7.2 only
> because they have a flaw on channel establishment on preempt channel.
>
> Now, after we have multifd + postcopy support, new QEMU binaries can
> migrate old machine types with both features enabled.  Juraj reported
> constant migration hang at the very beginning for those old machine types
> in our downstream systems with such setup.  Juraj found it's because of
> this flag.
>
> QEMU source initiates channels in this order on current master when both
> features enabled with postcopy-preempt mode:
>
>   - First, main channel connect() happens,
>   - Second, postcopy_preempt_setup() invokes connect() for preempt channel,
>   - Last, in migration_thread(), multifd_send_setup() invokes connect()s
>     for all the multifd channels

Other way around, no?

(master/11.1/src) only starts preempt when postcopy starts.
(master/11.1/dst) peeks main, peeks multifd, preempt comes when main and
multifd have already been found, so it is assumed to be preempt.

>
> However on an old QEMU, it expect the channels arrive in order of
> "main"->"multifd"->"preempt".  Even on a new QEMU, the destination expects
> the same order of arrival on the channels when the channels are not
> peekable.
>

(master/7.2/src) starts main, then preempt, then multifd.
(master/7.2 or 11.1/dst) peeks main, peeks multifd then hangs because preempt is
peekable but doesn't send data right away.

> For peekable channels (non-tls sockets), this time we'll likely see preempt
> channel appearing very soon, peeking at it causing main thread hang, like
> mentioned in the PROBLEM section above.
>

Yes.

> SOLUTION
> ========
>
> One major problem of current hang is we try to peek at preempt channel,
> which offers nothing at the beginning.
>
> Since we'll need to accept stream from old binaries, arrival of preempt
> channel early is unavoidable.
>

No, because old binary doesn't support multifd+postcopy, so there's only
either main + multifd or main + preempt.

New binary with old machine type is the only one that can send preempt
early.

> What we can do, though, is to allow concurrent monitoring of all channels
> rather than one.  Meanwhile, we shouldn't peek at anything that has no
> data.
>

I wonder why do we need to peek at all. Can't we start n threads and
recv() a data chunk of fixed size (smaller than the preempt request) on
every channel that comes up? Each thread puts the (data chunk + ioc) on
a list and exits. The channels that don't send data would just sit there
until something comes up.

Most channels would have data with a magic value right away so we'd
empty the list before the preempt request comes up. But having a list
means we can just iterate it when a consumer that has not yet received a
channel asks for a piece of data.

We could also check that the data in the supposed preempt channel is a
page request.

> migration_channel_read_peek() almost does the wait, but it's too late.
> This patch proposes to watch all channels from the start without reading at
> them at all, relying on an IO watch attached.  This will make sure (1) for
> preempt channel, we never read on it (watch can be gracefully disarmed when
> we know it's preempt channel later) (2) since we have one IO watch for each
> channel, then we can allow accept() to happen in almost any order, process
> only when there's some header to read.
>
> To maintain these watches, a new GArray @channels_early is introduced, with
> each element to be a (ioc, GSource) tuple (@MigEarlyIncomingChannel), so
> that QEMU can manage all the IO watches later with it.  Here I used GSource
> rather than io_tag because the GSource may or may not be attached to the
> default main thread gcontext: when OOB is used, it may be the iothread
> context instead.  IOW, g_source_remove() on io_tags stops working, which
> only works for default main context.
>
> The trick this patch used is when we have the ability to wait on all
> channel headers at the same time, we pick one by one from main and multifd
> channels (since both of the types will contain headers dumped right at the
> very beginning), leave preempt channel alone.  It means, after dest QEMU
> finds all main and multifd channels, there are three possibilities:
>
>   - If preempt not enabled, we finished full channel establishment, done.
>

I don't see why we need "channel establishment" at all. We're simply
taking iochannels and putting them into named QEMUFiles, this means
nothing. We could keep a list of unknown channels around indefinitely
and fetch them lazily when the data is needed. By that point, the
channels that have magic values would have already been identified and
what's left is the unindentified channel.

This would allow us add new channels with a proper header without
interfering with the old channels. As long as the new channels are not
to be consumed too soon.

>   - If preempt enabled,
>
>     - If we have one registered IO watch with the IOC, it must be the
>       preempt channel,
>
>     - If we have no further IO watch, wait for the next accept(), which
>       must be the preempt channel.
>

Ok, so watch all connections concurrently and pick the last one as
preempt.

> This will make channel establish work on incoming side even with the old
> QEMU binaries.
>
> While working on it, I managed to refactor the peeking logic quite a bit:
> we used to have a very convoluted migration_channel_identify() function,
> taking care of two different cases:
>
> (1) when the channel is peekable (like normal socket channels),
> (2) when the channel is not peekable (like TLS or file migrations).
>
> This patch refactored that part to make it crystal clear on how we make
> decisions on which channel is which, and split the peek/identify paths.
>

I'm still bothered about the peek. The data is all intended for the
destination machine, it owns it all, it can just consume it and put it
in the pocket.

> One example incoming migration from pc-q35-7.2 after this patch applied,
> and with relevant tracepoints set (8 multifd channels, 1 preempt channel):
>
>   migrate_set_state new state setup
>   migration_channel_process_incoming ioc=0x557dc8af4e20 ioctype=qio-channel-socket
>   migration_incoming_channel_watch ioc=0x557dc8af4e20 ioctype=qio-channel-socket
>   migration_channel_process_incoming ioc=0x557dc8abc5d0 ioctype=qio-channel-socket
>   migration_incoming_channel_watch ioc=0x557dc8abc5d0 ioctype=qio-channel-socket
>   migration_channel_process_incoming ioc=0x557dc953d680 ioctype=qio-channel-socket
>   migration_incoming_channel_watch ioc=0x557dc953d680 ioctype=qio-channel-socket
>   migration_set_incoming_channel ioc=0x557dc8abc5d0 ioctype=qio-channel-socket type=MULTIFD
>   migration_channel_process_incoming ioc=0x557dc898a820 ioctype=qio-channel-socket
>   migration_incoming_channel_watch ioc=0x557dc898a820 ioctype=qio-channel-socket
>   migration_set_incoming_channel ioc=0x557dc953d680 ioctype=qio-channel-socket type=MULTIFD
>   migration_channel_process_incoming ioc=0x557dc919bd70 ioctype=qio-channel-socket
>   migration_incoming_channel_watch ioc=0x557dc919bd70 ioctype=qio-channel-socket
>   migration_set_incoming_channel ioc=0x557dc898a820 ioctype=qio-channel-socket type=MULTIFD
>   migration_channel_process_incoming ioc=0x557dc8734b20 ioctype=qio-channel-socket
>   migration_incoming_channel_watch ioc=0x557dc8734b20 ioctype=qio-channel-socket
>   migration_set_incoming_channel ioc=0x557dc919bd70 ioctype=qio-channel-socket type=MULTIFD
>   migration_channel_process_incoming ioc=0x557dc898bdf0 ioctype=qio-channel-socket
>   migration_incoming_channel_watch ioc=0x557dc898bdf0 ioctype=qio-channel-socket
>   migration_set_incoming_channel ioc=0x557dc8734b20 ioctype=qio-channel-socket type=MULTIFD
>   migration_channel_process_incoming ioc=0x557dc968cfd0 ioctype=qio-channel-socket
>   migration_incoming_channel_watch ioc=0x557dc968cfd0 ioctype=qio-channel-socket
>   migration_set_incoming_channel ioc=0x557dc898bdf0 ioctype=qio-channel-socket type=MULTIFD
>   migration_channel_process_incoming ioc=0x557dc8c31810 ioctype=qio-channel-socket
>   migration_incoming_channel_watch ioc=0x557dc8c31810 ioctype=qio-channel-socket
>   migration_set_incoming_channel ioc=0x557dc968cfd0 ioctype=qio-channel-socket type=MULTIFD
>   migration_set_incoming_channel ioc=0x557dc8c31810 ioctype=qio-channel-socket type=MULTIFD
>   migration_set_incoming_channel ioc=0x557dc8af4e20 ioctype=qio-channel-socket type=MAIN

Hm, multifd came first? Have you registered watches in reverse order or
something? Not sure if it matters much.

>   migration_start_incoming
>   migrate_set_state new state active
>   migration_channel_process_incoming ioc=0x557dc8966160 ioctype=qio-channel-socket
>   migration_set_incoming_channel ioc=0x557dc8966160 ioctype=qio-channel-socket type=PREEMPT
>
> While at it, I renamed the four channel incoming/outgoing tracepoints, make
> all to follow migration_[incoming|outgoing]_channel_*().  Especially for
> incoming, then we can enable migration_incoming_channel* for incoming
> channel debuggings.
>
> FINAL NOTE ON TLS
> =================
>
> Note that this solution isn't a magic bullet fixing everything.  TLS is not
> fixable with this approach because TLS isn't peekable channel, hence the
> watch won't help.
>
> We can have other ways to hack it to make it work, e.g. we can make TLS
> channels peekable too, but I don't want to pollute the TLS iochannel only
> for this: let's hope handshake will arrive soon so we can drop these code.
>
> For now, when TLS is involved with such old machine type (7.2-), one needs
> to migrate it out with any combination of features except enabling all
> four (multifd + TLS + postcopy + preempt) to a patched binary, after that,
> all combinations will start working.
>

I don't understand where TLS comes into this. You mean TLS is not
peekable so if we use TLS for the multifd channels, then we cannot
tell them apart from preempt?

> BugLink: https://redhat.atlassian.net/browse/RHEL-254933
> Fixes: e27418861288 ("migration: enable multifd and postcopy together")
> Reported-by: Juraj Marcin <jmarcin@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/channel.h    |   3 +
>  migration/migration.h  |  35 ++++
>  migration/channel.c    | 414 +++++++++++++++++++++++++++++++++++------
>  migration/migration.c  |  23 ++-
>  migration/trace-events |   7 +-
>  5 files changed, 421 insertions(+), 61 deletions(-)
>

I'll wait for your replies before reviewing the code in detail.

> diff --git a/migration/channel.h b/migration/channel.h
> index 678712f291..40bd339a3e 100644
> --- a/migration/channel.h
> +++ b/migration/channel.h
> @@ -49,4 +49,7 @@ bool migration_channel_parse_input(const char *uri,
>                                     MigrationChannel **main_channelp,
>                                     MigrationChannel **cpr_channelp,
>                                     Error **errp);
> +
> +void migration_incoming_free_early_channels(MigrationIncomingState *mis);
> +
>  #endif
> diff --git a/migration/migration.h b/migration/migration.h
> index 683bc7bdd5..6f23e1805b 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -90,6 +90,28 @@ typedef enum {
>      PREEMPT_THREAD_QUIT,
>  } PreemptThreadStatus;
>  
> +typedef struct {
> +    /*
> +     * The GSource we have allocated to track G_IO_IN events for the
> +     * channel.  Note: it may not be attached to the default main gcontext,
> +     * for example, when in case of io watch created during an OOB
> +     * migrate-recover command.
> +     */
> +    GSource *source;
> +    /* The channel we will identify later after getting some buffers to read */
> +    QIOChannel *ioc;
> +} MigEarlyIncomingChannel;
> +
> +typedef struct {
> +    GArray *channels;
> +    /*
> +     * In most cases, channels are only operated with BQl, but since we
> +     * have OOB command support, don't assume it, just use a standalone
> +     * mutex to protect any access to the channels array.
> +     */
> +    QemuMutex mutex;
> +} MigEarlyIncomingChannels;
> +
>  /* State for the incoming migration */
>  struct MigrationIncomingState {
>      QEMUFile *from_src_file;
> @@ -255,6 +277,19 @@ struct MigrationIncomingState {
>  
>      /* Do exit on incoming migration failure */
>      bool exit_on_error;
> +
> +    /*
> +     * Maintains all channels only at early stage.  After incoming
> +     * migration started, this should be an empty array and no use anymore.
> +     *
> +     * TODO: we logically only need this to make new QEMU binaries work for
> +     * old machines who have @preempt_pre_7_2 set on the source, but it's
> +     * also good to have this early stage anyway, making sure when peek the
> +     * channel there will be something in the channel.  Ideally, we should
> +     * manage all migration channels in the future with proper headers,
> +     * then we can drop this.
> +     */
> +    MigEarlyIncomingChannels channels_early;
>  };
>  
>  MigrationIncomingState *migration_incoming_get_current(void);
> diff --git a/migration/channel.c b/migration/channel.c
> index b9065efd03..acb7ef5206 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -12,6 +12,8 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/error-report.h"
>  #include "channel.h"
>  #include "exec.h"
>  #include "fd.h"
> @@ -146,61 +148,84 @@ bool migration_has_all_channels(void)
>      return true;
>  }
>  
> -static MigChannelType migration_channel_identify(MigrationIncomingState *mis,
> -                                                 QIOChannel *ioc, Error **errp)
> +static bool qio_channel_is_peekable(QIOChannel *ioc)
> +{
> +    return qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK);
> +}
> +
> +/*
> + * With multiple channels, it is possible that we receive channels out of
> + * order on destination side, causing incorrect mapping of source channels
> + * on destination side.
> + *
> + * When the channel is peekable (e.g. non-TLS socket channels), check
> + * channel MAGIC to decide type of channel.
> + *
> + * Please note this is best effort, postcopy preempt channel does not send
> + * any magic number so avoid it for postcopy live migration.
> + *
> + * Returns: >0 if success, ==0 (CH_NONE) if error.  If error happened,
> + * *errp must be set.
> + */
> +static MigChannelType migration_channel_peek(MigrationIncomingState *mis,
> +                                             QIOChannel *ioc,
> +                                             Error **errp)
>  {
>      MigChannelType channel = CH_NONE;
>      uint32_t channel_magic = 0;
>      int ret = 0;
>  
> -    if (!migration_has_main_and_multifd_channels()) {
> -        if (qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
> -            /*
> -             * With multiple channels, it is possible that we receive channels
> -             * out of order on destination side, causing incorrect mapping of
> -             * source channels on destination side. Check channel MAGIC to
> -             * decide type of channel. Please note this is best effort,
> -             * postcopy preempt channel does not send any magic number so
> -             * avoid it for postcopy live migration. Also tls live migration
> -             * already does tls handshake while initializing main channel so
> -             * with tls this issue is not possible.
> -             */
> -            ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
> -                                              sizeof(channel_magic), errp);
> -            if (ret != 0) {
> -                goto out;
> -            }
> +    assert(qio_channel_is_peekable(ioc));
>  
> -            channel_magic = be32_to_cpu(channel_magic);
> -            if (channel_magic == QEMU_VM_FILE_MAGIC) {
> -                channel = CH_MAIN;
> -            } else if (channel_magic == MULTIFD_MAGIC) {
> -                assert(migrate_multifd());
> -                channel = CH_MULTIFD;
> -            } else if (!mis->from_src_file &&
> -                        mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
> -                /* reconnect main channel for postcopy recovery */
> -                channel = CH_MAIN;
> -            } else {
> -                error_setg(errp, "unknown channel magic: %u", channel_magic);
> -            }
> -        } else if (mis->from_src_file && migrate_multifd()) {
> -            /*
> -             * Non-peekable channels like tls/file are processed as
> -             * multifd channels when multifd is enabled.
> -             */
> -            channel = CH_MULTIFD;
> -        } else if (!mis->from_src_file) {
> -            channel = CH_MAIN;
> -        } else {
> -            error_setg(errp, "non-peekable channel used without multifd");
> -        }
> +    ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
> +                                      sizeof(channel_magic), errp);
> +    if (ret != 0) {
> +        /* Failed */
> +        return channel;
> +    }
> +
> +    channel_magic = be32_to_cpu(channel_magic);
> +
> +    if (channel_magic == QEMU_VM_FILE_MAGIC) {
> +        channel = CH_MAIN;
> +    } else if (channel_magic == MULTIFD_MAGIC) {
> +        assert(migrate_multifd());
> +        channel = CH_MULTIFD;
> +    } else if (!mis->from_src_file &&
> +               mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
> +        /* reconnect main channel for postcopy recovery */
> +        channel = CH_MAIN;
>      } else {
> +        error_setg(errp, "Unknown channel magic: %u", channel_magic);
> +    }
> +
> +    return channel;
> +}
> +
> +/*
> + * Returns: >0 if success, ==0 (CH_NONE) if error.  If error happened,
> + * *errp must be set.
> + */
> +static MigChannelType migration_channel_identify(MigrationIncomingState *mis,
> +                                                 QIOChannel *ioc, Error **errp)
> +{
> +    MigChannelType channel = CH_NONE;
> +
> +    if (migration_has_main_and_multifd_channels()) {
>          assert(migrate_postcopy_preempt());
>          channel = CH_POSTCOPY;
> +    } else if (!mis->from_src_file) {
> +        channel = CH_MAIN;
> +    } else if (migrate_multifd()) {
> +        /*
> +         * Non-peekable channels like tls/file are processed as
> +         * multifd channels when multifd is enabled.
> +         */
> +        channel = CH_MULTIFD;
> +    } else {
> +        error_setg(errp, "Unexpected non-peekable channel observed");
>      }
>  
> -out:
>      return channel;
>  }
>  
> @@ -214,31 +239,275 @@ static void migration_incoming_error_propagate(MigrationIncomingState *mis,
>      }
>  }
>  
> +/* Must be with mis->channels_early.mutex held */
> +static void
> +migration_incoming_early_channel_insert(MigrationIncomingState *mis,
> +                                        QIOChannel *ioc,
> +                                        GSource *source)
> +{
> +    MigEarlyIncomingChannel chan = {
> +        .source = source,
> +        .ioc = ioc,
> +    };
> +
> +    object_ref(OBJECT(ioc));
> +    g_source_ref(source);
> +
> +    g_array_append_val(mis->channels_early.channels, chan);
> +}
> +
> +static void migration_incoming_early_channel_free(GArray *channels, int i)
> +{
> +    MigEarlyIncomingChannel *chan;
> +
> +    chan = &g_array_index(channels, MigEarlyIncomingChannel, i);
> +
> +    g_source_destroy(chan->source);
> +    g_source_unref(chan->source);
> +    object_unref(OBJECT(chan->ioc));
> +
> +    g_array_remove_index_fast(channels, i);
> +}
> +
> +/*
> + * Remove this channel from the monitoring of @channels_early array.
> + * Return true if found and successful, false otherwise.
> + */
> +static bool
> +migration_incoming_early_channel_remove(MigrationIncomingState *mis,
> +                                        QIOChannel *ioc)
> +{
> +    GArray *channels = mis->channels_early.channels;
> +    MigEarlyIncomingChannel *chan;
> +    int i;
> +
> +    QEMU_LOCK_GUARD(&mis->channels_early.mutex);
> +
> +    for (i = 0; i < channels->len; i++) {
> +        chan = &g_array_index(channels, MigEarlyIncomingChannel, i);
> +        if (chan->ioc != ioc) {
> +            continue;
> +        }
> +        migration_incoming_early_channel_free(channels, i);
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +void migration_incoming_free_early_channels(MigrationIncomingState *mis)
> +{
> +    GArray *channels = mis->channels_early.channels;
> +
> +    QEMU_LOCK_GUARD(&mis->channels_early.mutex);
> +
> +    while (channels->len) {
> +        migration_incoming_early_channel_free(channels, 0);
> +    }
> +}
> +
> +static bool migration_incoming_setup_channel(QIOChannel *ioc,
> +                                             MigChannelType ch,
> +                                             Error **errp)
> +{
> +    trace_migration_incoming_channel_set(ioc,
> +                                         object_get_typename(OBJECT(ioc)),
> +                                         mig_channel_str[ch]);
> +    migration_ioc_register_yank(ioc);
> +    /* TODO: make this return the success status instead */
> +    migration_incoming_setup(ioc, ch, errp);
> +
> +    return *errp == NULL;
> +}
> +
>  static bool migration_incoming_channel_install(MigrationIncomingState *mis,
>                                                 QIOChannel *ioc,
>                                                 Error **errp)
>  {
> -    MigChannelType ch = migration_channel_identify(mis, ioc, errp);
> +    MigChannelType ch;
> +    bool ret;
> +
> +    if (qio_channel_is_peekable(ioc)) {
> +        ch = migration_channel_peek(mis, ioc, errp);
> +    } else {
> +        ch = migration_channel_identify(mis, ioc, errp);
> +    }
>  
>      if (!ch) {
> -        assert(*errp);
>          return false;
>      }
>  
> -    trace_migration_set_incoming_channel(ioc,
> -                                         object_get_typename(OBJECT(ioc)),
> -                                         mig_channel_str[ch]);
> -    migration_ioc_register_yank(ioc);
> +    ret = migration_incoming_setup_channel(ioc, ch, errp);
> +    if (!ret) {
> +        return false;
> +    }
>  
> -    if (migration_incoming_setup(ioc, ch, errp)) {
> +    /* Installation succeeded, kickoff migration if needed */
> +    if (migration_has_main_and_multifd_channels()) {
>          migration_start_incoming();
>      }
>  
> -    if (*errp) {
> -        return false;
> +    return true;
> +}
> +
> +static void
> +migration_incoming_channel_preempt_setup(QIOChannel *ioc)
> +{
> +    assert(migrate_postcopy_preempt());
> +    /* Installation of preempt channel should never fail */
> +    migration_incoming_setup_channel(ioc, CH_POSTCOPY, &error_abort);
> +}
> +
> +static void
> +migration_incoming_detect_preempt_channel(MigrationIncomingState *mis)
> +{
> +    GArray *channels = mis->channels_early.channels;
> +    MigEarlyIncomingChannel *chan;
> +
> +    QEMU_LOCK_GUARD(&mis->channels_early.mutex);
> +
> +    /* When preempt mode not enabled, nothing to detect.. */
> +    if (!migrate_postcopy_preempt()) {
> +        /*
> +         * .. but if we found something pending, throw an error only, which
> +         * should not happen.  Even if it happens, resources will still be
> +         * released after incoming migration is completedly.
> +         */
> +        if (channels->len) {
> +            error_report("%s: Found %u unused channels",
> +                         __func__, channels->len);
> +        }
> +        return;
>      }
>  
> -    return true;
> +    /* Preempt channel hasn't yet arrived?  Process it later */
> +    if (!channels->len) {
> +        return;
> +    }
> +
> +    /*
> +     * More than one channel should never happen.. capture it in case if
> +     * it happens, then there's not much we can do.
> +     */
> +    if (channels->len > 1) {
> +        error_report("%s: Found %u unused channels, "
> +                     "can't identify preempt channel",
> +                     __func__, channels->len);
> +        return;
> +    }
> +
> +    assert(channels->len == 1);
> +    /* This is the preempt channel, install it directly */
> +    chan = &g_array_index(channels, MigEarlyIncomingChannel, 0);
> +    migration_incoming_channel_preempt_setup(chan->ioc);
> +    migration_incoming_early_channel_free(channels, 0);
> +}
> +
> +static gboolean migration_incoming_channel_readable(QIOChannel *ioc,
> +                                                    GIOCondition condition,
> +                                                    gpointer opaque)
> +{
> +    MigrationIncomingState *mis = opaque;
> +    Error *local_err = NULL;
> +
> +    /*
> +     * No need to monitor this channel anymore as long as anything arrived,
> +     * remove it from tracking.
> +     *
> +     * NOTE: this means if partial data arrived we may still block here,
> +     * but it shouldn't happen in production, only malicious stream.  Since
> +     * migration stream is trusted (either due to trusted network, or TLS),
> +     * that's non-issue.
> +     *
> +     * NOTE2: this will also release the ioc ref that we used to hold, but
> +     * it's fine since we have at least one more refcount in the current
> +     * event handler.
> +     *
> +     * NOTE3: it's theoretically possible that this entry is gone reaching
> +     * here. Example: the main thread is doing incoming cleanup having this
> +     * one removed, while this watch can be registered on the monitor
> +     * iothread's context and fired at the exact same time but in the
> +     * iothread instead.  If it happens, skip the rest.  I'm not sure if
> +     * this could happen at all, may depend on iothread lifespan management
> +     * in the main thread, but be prepared.
> +     */
> +    if (!migration_incoming_early_channel_remove(mis, ioc)) {
> +        goto out;
> +    }
> +
> +    if (!migration_incoming_channel_install(mis, ioc, &local_err)) {
> +        goto out;
> +    }
> +
> +    if (migration_has_main_and_multifd_channels()) {
> +        /*
> +         * Possibilities when reaching here:
> +         *
> +         * (1) if preempt not enabled, this should be no-op, all done,
> +         * (2) if preempt enabled,
> +         *   (2.a) preempt channel arrived @channels_early, handle it now
> +         *   (2.b) preempt channel not arrived, to be handled in
> +         *         migration_channel_process_incoming() later
> +         */
> +        migration_incoming_detect_preempt_channel(mis);
> +    }
> +
> +out:
> +    if (local_err) {
> +        migration_incoming_error_propagate(mis, local_err);
> +    }
> +
> +    /*
> +     * NOTE: we should have already detached the GSource, returning
> +     * G_SOURCE_REMOVE to be logically consistent only.
> +     */
> +    return G_SOURCE_REMOVE;
> +}
> +
> +static void migration_incoming_channel_watch(MigrationIncomingState *mis,
> +                                             QIOChannel *ioc)
> +{
> +    GMainContext *context = g_main_context_get_thread_default();
> +    GSource *source;
> +    guint io_tag;
> +
> +    trace_migration_incoming_channel_watch(ioc,
> +                                           object_get_typename(OBJECT(ioc)));
> +
> +    /*
> +     * Careful: this can be run from either the main thread or the monitor
> +     * iothread when migrate_recover is used with OOB=on, so we need to
> +     * take the lock and use the full version to specify the correct
> +     * context.
> +     */
> +    QEMU_LOCK_GUARD(&mis->channels_early.mutex);
> +
> +    /*
> +     * We should never watch an @ioc that is not peekable, because there's
> +     * no point.  What is worse is we lose the real order of accept()s via
> +     * the asynchronous IO watch operation.
> +     *
> +     * Another note is TLS channel (non-peekable) may or may not work
> +     * properly with IO watch due to its current .io_create_watch() impl,
> +     * which is another story.  Just guard both points.
> +     */
> +    assert(qio_channel_is_peekable(ioc));
> +    io_tag = qio_channel_add_watch_full(ioc, G_IO_IN,
> +                                        migration_incoming_channel_readable,
> +                                        mis, NULL, context);
> +
> +    /*
> +     * Replace this if one day qio_channel_add_watch*() API can directly
> +     * return the GSource*.. for now, stick with it.
> +     */
> +    source = g_main_context_find_source_by_id(context, io_tag);
> +    /*
> +     * Nothing can race with adding the IO watch, aka, concurrent removal
> +     * is not possible when we have the lock.  So it must be present.
> +     */
> +    assert(source);
> +
> +    migration_incoming_early_channel_insert(mis, ioc, source);
>  }
>  
>  /**
> @@ -254,13 +523,44 @@ void migration_channel_process_incoming(QIOChannel *ioc)
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      Error *local_err = NULL;
>  
> -    trace_migration_channel_process_incoming(
> +    trace_migration_incoming_channel_process(
>          ioc, object_get_typename(OBJECT(ioc)));
>  
>      if (migrate_channel_requires_tls_upgrade(ioc)) {
>          migration_tls_channel_process_incoming(ioc, &local_err);
>      } else {
> -        migration_incoming_channel_install(mis, ioc, &local_err);
> +        if (migration_has_main_and_multifd_channels()) {
> +            /*
> +             * If all main+multifd channels are present already, this must
> +             * be the preempt channel.
> +             *
> +             * QEMU can't register an IO watch for it if there is only the
> +             * last preempt channel left, because it means the IO watch
> +             * will never fire and nobody will pick it up: we rely on the
> +             * one before the last one to pick both.
> +             *
> +             * See comment in migration_incoming_channel_readable() on
> +             * the migration_incoming_detect_preempt_channel() call.
> +             */
> +            migration_incoming_channel_preempt_setup(ioc);
> +        } else {
> +            /*
> +             * Register an IO watch for peekable channels, so that channels
> +             * can be accept()ed with any order.
> +             *
> +             * Non-peekable channels (file, TLS, etc.) cannot register IO
> +             * watch, not only because there's no data to look at to help
> +             * making the decision, but also because after registering we
> +             * will lose the real ordering we get from accept(), which is
> +             * still so far the only source of truth to identify a channel
> +             * in such case.
> +             */
> +            if (qio_channel_is_peekable(ioc)) {
> +                migration_incoming_channel_watch(mis, ioc);
> +            } else {
> +                migration_incoming_channel_install(mis, ioc, &local_err);
> +            }
> +        }
>      }
>  
>      if (local_err) {
> @@ -270,7 +570,7 @@ void migration_channel_process_incoming(QIOChannel *ioc)
>  
>  void migration_channel_connect_outgoing(MigrationState *s, QIOChannel *ioc)
>  {
> -    trace_migration_set_outgoing_channel(ioc, object_get_typename(OBJECT(ioc)));
> +    trace_migration_outgoing_channel_set(ioc, object_get_typename(OBJECT(ioc)));
>  
>      if (migrate_channel_requires_tls_upgrade(ioc)) {
>          Error *local_err = NULL;
> diff --git a/migration/migration.c b/migration/migration.c
> index cfadcc79c2..4cc4077a76 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -334,6 +334,10 @@ void migration_object_init(void)
>      current_incoming->page_requested = g_tree_new(page_request_addr_cmp);
>  
>      current_incoming->exit_on_error = INMIGRATE_DEFAULT_EXIT_ON_ERROR;
> +    /* zero_terminated=false, clear_=true */
> +    current_incoming->channels_early.channels =
> +        g_array_new(FALSE, TRUE, sizeof(MigEarlyIncomingChannel));
> +    qemu_mutex_init(&current_incoming->channels_early.mutex);
>  
>      migration_object_check(current_migration, &error_fatal);
>  
> @@ -447,6 +451,24 @@ void migration_incoming_state_destroy(void)
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      PostcopyState ps = postcopy_state_get();
>  
> +    /* Cleanup listener to make sure no further accept() for sockets */
> +    migration_incoming_transport_cleanup(mis);
> +
> +    /*
> +     * It's safer to free channel watches earlier than most of the rest, in
> +     * case the IO watches could fire in the monitor iothread concurrently
> +     * against this function.
> +     *
> +     * Above migration_incoming_transport_cleanup() should have disarmed
> +     * anything that we could accept() new sockets.
> +     *
> +     * Here return of migration_incoming_free_early_channels() makes sure
> +     * even if something already fired concurrently, it won't really do
> +     * anything but return - see migration_incoming_early_channel_remove()
> +     * and its return code for details.
> +     */
> +    migration_incoming_free_early_channels(mis);
> +
>      multifd_recv_cleanup();
>  
>      if (ps != POSTCOPY_INCOMING_NONE) {
> @@ -491,7 +513,6 @@ void migration_incoming_state_destroy(void)
>          mis->postcopy_remote_fds = NULL;
>      }
>  
> -    migration_incoming_transport_cleanup(mis);
>      qemu_event_reset(&mis->main_thread_load_event);
>  
>      if (mis->page_requested) {
> diff --git a/migration/trace-events b/migration/trace-events
> index 9ef42f54d1..c408deeb72 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -207,9 +207,10 @@ migration_start_incoming(void) ""
>  migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma) "qemu_file %" PRIu64 " multifd %" PRIu64 " RDMA %" PRIu64
>  
>  # channel.c
> -migration_channel_process_incoming(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
> -migration_set_incoming_channel(void *ioc, const char *ioctype, const char *type) "ioc=%p ioctype=%s type=%s"
> -migration_set_outgoing_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
> +migration_outgoing_channel_set(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
> +migration_incoming_channel_process(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
> +migration_incoming_channel_set(void *ioc, const char *ioctype, const char *type) "ioc=%p ioctype=%s type=%s"
> +migration_incoming_channel_watch(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
>  
>  # global_state.c
>  migrate_state_too_big(void) ""

