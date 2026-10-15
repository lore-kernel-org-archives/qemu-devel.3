Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44D4CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHLVy-0004og-8Z; Thu, 15 Oct 2026 09:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xHLVs-0004nV-Fk
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:28:54 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xHLVp-0006ST-3e
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:28:52 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 434D121CE0;
 Thu, 15 Oct 2026 13:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792070927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iuC9/3b71Ec+othq3n/qtklPr7hUR3hvwNCUrUZ5OcI=;
 b=rjxdOPoZP4H0GOd05kEhwRBrtRI+vLBiWZ5iES2Yi77Ty1TLVYtC7xpCsdIe0EqY1RIN2g
 TpN+gLrOUGobMVikK+rqbqjHCzHcGkVrV+S4bCEeufv5pCLaso0mgULmgavcjGKmuftbdv
 2qK7O8BfyPs5Ulf0ewe3856Rl8zYrFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792070927;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iuC9/3b71Ec+othq3n/qtklPr7hUR3hvwNCUrUZ5OcI=;
 b=+xVZStVntm8zMyhWsMxZixNfh1I96xa9GlTXov+WCEJPNBg/xGiwvdXHv6RL/eqIPIH9Ls
 gV5D/jesHUUhPiDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rjxdOPoZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+xVZStVn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792070927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iuC9/3b71Ec+othq3n/qtklPr7hUR3hvwNCUrUZ5OcI=;
 b=rjxdOPoZP4H0GOd05kEhwRBrtRI+vLBiWZ5iES2Yi77Ty1TLVYtC7xpCsdIe0EqY1RIN2g
 TpN+gLrOUGobMVikK+rqbqjHCzHcGkVrV+S4bCEeufv5pCLaso0mgULmgavcjGKmuftbdv
 2qK7O8BfyPs5Ulf0ewe3856Rl8zYrFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792070927;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iuC9/3b71Ec+othq3n/qtklPr7hUR3hvwNCUrUZ5OcI=;
 b=+xVZStVntm8zMyhWsMxZixNfh1I96xa9GlTXov+WCEJPNBg/xGiwvdXHv6RL/eqIPIH9Ls
 gV5D/jesHUUhPiDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4165132C9;
 Thu, 15 Oct 2026 13:28:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0X9vFQ7V0GpLUQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 15 Oct 2026 13:28:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Akash Kulhalli <akulhall@redhat.com>, Juraj Marcin
 <jmarcin@redhat.com>
Subject: Re: [PATCH v2 6/7] migration: Fix incoming channel race with
 multifd and preempt_pre_7_2
In-Reply-To: <20261006182046.3767283-7-peterx@redhat.com>
References: <20261006182046.3767283-1-peterx@redhat.com>
 <20261006182046.3767283-7-peterx@redhat.com>
Date: Thu, 15 Oct 2026 10:28:44 -0300
Message-ID: <87se27ks8j.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 434D121CE0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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
> features enabled with postcopy-preempt mode (machine type 7.2, implies
> preempt_pre_7_2=on):
>
>   - First, main channel connect() happens,
>   - Second, postcopy_preempt_setup() invokes connect() for preempt channel,
>   - Last, in migration_thread(), multifd_send_setup() invokes connect()s
>     for all the multifd channels
>
> However on an old QEMU, it expect the channels arrive in order of
> "main"->"multifd"->"preempt".  Even on a new QEMU, the destination expects
> the same order of arrival on the channels when the channels are not
> peekable.
>
> For peekable channels (non-tls sockets), this time we'll likely see preempt
> channel appearing very soon, peeking at it causing main thread hang, like
> mentioned in the PROBLEM section above.
>
> SOLUTION
> ========
>
> One major problem of current hang is we try to peek at preempt channel,
> which offers nothing at the beginning.
>
> Since we'll need to accept stream from old binaries (QEMU 10.1 to 11.1),
> arrival of preempt channel early is unavoidable.
>
> What we can do, though, is to allow concurrent monitoring of all channels
> rather than one.  Meanwhile, we shouldn't peek at anything that has no
> data.
>
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
>   - If preempt enabled,
>
>     - If we have one registered IO watch with the IOC, it must be the
>       preempt channel,
>
>     - If we have no further IO watch, wait for the next accept(), which
>       must be the preempt channel.
>
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
> BugLink: https://redhat.atlassian.net/browse/RHEL-254933
> Fixes: e27418861288 ("migration: enable multifd and postcopy together")
> Reported-by: Juraj Marcin <jmarcin@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

