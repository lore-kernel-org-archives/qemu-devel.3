Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F27C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 21:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9U9W-0003Ck-KF; Wed, 23 Sep 2026 17:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x9U9R-0003Bq-Tn
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 17:05:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x9U9N-00084P-8d
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 17:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790197505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5yd/9HZc4/l6Y/h2H8cSsj4cn/CFKCB/3R4DoyG2Zlw=;
 b=Ydm71/h3AhsGwSOa9Gfl8efWmP994Qy4y7WeoFr3xP3jAFtTd7VVHCR2pIAKD+JYnoaCWy
 Ho8oYfigfOVYR33VgPtcW9AZSsi1qXOjCCMXLn9Ib2HmSpIKnl0JUzdMI0NmgFV2lT+csE
 fiyE//S72cH4MXlum9ooFOzy2+GYgZ8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646--NrIfGldNPC4vOJBjhrbTQ-1; Wed, 23 Sep 2026 17:05:03 -0400
X-MC-Unique: -NrIfGldNPC4vOJBjhrbTQ-1
X-Mimecast-MFC-AGG-ID: -NrIfGldNPC4vOJBjhrbTQ_1790197503
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93a3f673221so315119085a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 14:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790197503; x=1790802303; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5yd/9HZc4/l6Y/h2H8cSsj4cn/CFKCB/3R4DoyG2Zlw=;
 b=SGifRHj8tay8T+NUMqTo7KXk43EEGlNGF86GkrygpJD273rIAvz0MZaB0rn5YZhFfy
 DaZJm+7/OB6BH5q9REqI347HgWyc5K/rOErZYpY9xwN+NMlMF9iV8hAwlsiRX3iJbsPj
 +T7NpveCUlHBzXAgjA63FaVvlxAjo46PJVuF8eOIpx/+/LLUvV94WTBQJ4mHD59xXQSh
 gM/kyRbnpCQfNrPjbISNnmI/Mk8Cf4DoALLamxr7WOQhhfiusZPK8PI4PgnUIKJ6+Glx
 cGBmFPycNW5ZW/qdZNwwWEqKzJb/+HpsRW0TFCe6btgSB54u5D1hRjVnzgHVGsniYclo
 H/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790197503; x=1790802303;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5yd/9HZc4/l6Y/h2H8cSsj4cn/CFKCB/3R4DoyG2Zlw=;
 b=T6XHydoVXDPmYZ6W6ElL/ywRxtiuhkYJIC8SRA3IPokhXjEJxPQQWZxZ+kZdh5BPn7
 f4EKtZ/LKOzfNOduya4dHhtt55t9ZkKQVNwvez4b1W7Zip5FEKcChQLrxqQFBvbXR2Fb
 fuziFYA3B7bACjCT7gVQhm00jON1UlrUvU7aIry7s5DSgLvixbknZVKdo8TMmWOrnJKC
 qWG4S6GYft4t7FPwpaSHiXvYLcQBtkMSu/lmo9+QKipQJwW3WjBM3L7qEZn4pfa2FF/7
 w30PtZuCP/6o1A1kKpsrgSw9bMwI3gUiJhdAalTxlIwoa725WIUHsMvCUhakIuydqovD
 OHDw==
X-Gm-Message-State: AFuF++no0B8pZzUV+FGe/NUnszHmcy3Gc6Lnl9+yYiclMpZQxy/XDoOy
 YtBHL1pCm3De/QbXgmBTBidStmkEvWR6at5uITjRp3RznRzSIgRbKDva/UbpuvKL32u5aBZrI4x
 Z9sIzxa7ALkkXnXFa5RCfyBlOPOWVFyNFfuHMsJDZ0wzcYcBQEFa+Soa4
X-Gm-Gg: AYBFou1U55kH8h2lS+KoleH0ggsKCVpbVLseT4nQ/nhBPv+YGsykU2I37zKNuYZn4iT
 G/0QEW7mrm5rqSpoET0DYKX3mvQeIYlrvwbTy4T2oDanztBr/nGHyFOCrDz4iIFVWqzY6kn1wWi
 kPMCEjMzjIBhU8kYeSfx9t6ZxGb56TkaSFlxlhOXvMqSZzGnnRyIxEw+jrHihuyrqnM6ANtwdyQ
 yxFc2Nnhv02LpVOqIbwU1nnnwSeZoJEFSQzmQU5yDcqWyCnCLXLBZgwZfnGHTbDqve0rIH446tI
 Ma5ufRK4hGwj4Xopg1acKzl+rVsLG/fCt9UybmYyBgPw4QAk9STpXJjYWWe3f+7RFKt4OeLnhoT
 TZpBYmA==
X-Received: by 2002:a05:620a:269b:b0:939:6de8:43d8 with SMTP id
 af79cd13be357-93c3469c671mr68044985a.44.1790197502538; 
 Wed, 23 Sep 2026 14:05:02 -0700 (PDT)
X-Received: by 2002:a05:620a:269b:b0:939:6de8:43d8 with SMTP id
 af79cd13be357-93c3469c671mr68035485a.44.1790197501752; 
 Wed, 23 Sep 2026 14:05:01 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c2488d223sm309815685a.32.2026.09.23.14.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 14:05:00 -0700 (PDT)
Date: Wed, 23 Sep 2026 17:04:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Akash Kulhalli <akulhall@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 6/7] migration: Fix incoming channel race with multifd
 and preempt_pre_7_2
Message-ID: <arQ--2rmvQsX-DzE@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260916213558.587304-1-peterx@redhat.com>
 <20260916213558.587304-7-peterx@redhat.com>
 <87ik3w9d5s.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ik3w9d5s.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 23, 2026 at 12:54:07PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > PROBLEM
> > =======
> >
> > Migration reliably hangs with old machine types (7.2-) when these migration
> > capabilities are enabled: multifd, postcopy-ram, postcopy-preempt.
> 
> Is there a way to make this patch unrelated to the 7.2 issue? I think
> this muddles the discussion a bit. This is a real improvement despite
> any bug.

I agree this change will make the channel mgmt also more flexible, but
logically we almost don't need it if there's no such bug [*]..  at very
minimum, I can add some paragraph before the problem describing this too.
Would that help?

[*] NOTE: I still agree iowatch is in general always good, but then after
we have handshake feature ready, we don't need iowatch anymore because we
can simply attach header for all channels including preempt channel, then
it's readable too (not only peekable).  I plan to work on handshake feature
after I came back from kvm forum.  If that can land, after 6 years we
should be able to revert this whole thing include old channel mgmt.  No
peek / iowatch / ... needed here for channel establishments.

> 
> >
> > Simplest reproducer :
> >
> >   $ QTEST_QEMU_MACHINE_TYPE=pc-q35-7.2 \
> >       QTEST_QEMU_BINARY=./qemu-system-x86_64 \
> >       ./tests/qtest/migration-test --full \
> >       -r /x86_64/migration/multifd+postcopy/preempt/plain
> >
> > Current workaround is to kill destination QEMU, cancel the migration on
> > source (with/without yank), disable one or more of the features, and retry.
> >
> > The hang is caused by receiving preempt channel before most of the multifd
> > channels, the peek buffer operation will stuck forever.
> >
> > Incoming side QEMU hang (with relevant tracepoints enabled):
> >
> >   migrate_set_state new state setup
> >   migration_socket_incoming_accepted
> >   migration_set_incoming_channel ioc=0x557d82c1caa0 ioctype=qio-channel-socket
> >   migration_socket_incoming_accepted
> >   migration_set_incoming_channel ioc=0x557d83023840 ioctype=qio-channel-socket
> >   multifd_recv_new_channel channel 1
> >   migration_socket_incoming_accepted
> >   migration_set_incoming_channel ioc=0x557d830c08c0 ioctype=qio-channel-socket
> >   multifd_recv_new_channel channel 0
> >   multifd_recv_thread_start 1
> >   migration_socket_incoming_accepted
> >   migration_set_incoming_channel ioc=0x557d8284a010 ioctype=qio-channel-socket
> >   multifd_recv_thread_start 0
> >   multifd_recv_unfill channel 0 packet_num 0 flags 0x1 next packet size 0
> >   multifd_recv_unfill channel 1 packet_num 1 flags 0x1 next packet size 0
> >   [dest qemu hangs here]
> >
> > Incoming side backtrace:
> >
> >   __syscall_cancel_arch
> >   __internal_syscall_cancel
> >   __syscall_cancel
> >   recvmsg
> >   qio_channel_socket_readv
> >   qio_channel_readv_full
> >   migration_channel_read_peek
> >   migration_channel_identify
> >   migration_channel_process_incoming
> >   socket_accept_incoming_migration
> >   qio_net_listener_channel_func
> >   qio_channel_fd_source_dispatch
> >   g_main_context_dispatch_unlocked.lto_priv
> >   g_main_context_dispatch
> >   glib_pollfds_poll
> >   os_host_main_loop_wait
> >   main_loop_wait
> >   qemu_main_loop
> >   qemu_default_main
> >   main
> >
> > This patch tries to fix it, from incoming side first.  This patch alone
> > should enable single-direction migration to this new QEMU.  The next patch
> > will propose a fix for the outgoing path, fixing new->old migrations.
> >
> > BACKGROUND
> > ==========
> >
> > preempt_pre_7_2 used to be a flag marking QEMU releases 7.1/7.2 only
> > because they have a flaw on channel establishment on preempt channel.
> >
> > Now, after we have multifd + postcopy support, new QEMU binaries can
> > migrate old machine types with both features enabled.  Juraj reported
> > constant migration hang at the very beginning for those old machine types
> > in our downstream systems with such setup.  Juraj found it's because of
> > this flag.
> >
> > QEMU source initiates channels in this order on current master when both
> > features enabled with postcopy-preempt mode:
> >
> >   - First, main channel connect() happens,
> >   - Second, postcopy_preempt_setup() invokes connect() for preempt channel,
> >   - Last, in migration_thread(), multifd_send_setup() invokes connect()s
> >     for all the multifd channels
> 
> Other way around, no?
> 
> (master/11.1/src) only starts preempt when postcopy starts.
> (master/11.1/dst) peeks main, peeks multifd, preempt comes when main and
> multifd have already been found, so it is assumed to be preempt.

Yes, only when with newer machine types (8.0+).  The statement here should
be correct for machine type 7.2, which is what this bug is about.  How
about I update the previous sentence to be this instead?

  QEMU source initiates channels in this order on current master when both
  features enabled with postcopy-preempt mode (machine type 7.2, implies
  preempt_pre_7_2=on):

> 
> >
> > However on an old QEMU, it expect the channels arrive in order of
> > "main"->"multifd"->"preempt".  Even on a new QEMU, the destination expects
> > the same order of arrival on the channels when the channels are not
> > peekable.
> >
> 
> (master/7.2/src) starts main, then preempt, then multifd.
> (master/7.2 or 11.1/dst) peeks main, peeks multifd then hangs because preempt is
> peekable but doesn't send data right away.

Yes.

> 
> > For peekable channels (non-tls sockets), this time we'll likely see preempt
> > channel appearing very soon, peeking at it causing main thread hang, like
> > mentioned in the PROBLEM section above.
> >
> 
> Yes.
> 
> > SOLUTION
> > ========
> >
> > One major problem of current hang is we try to peek at preempt channel,
> > which offers nothing at the beginning.
> >
> > Since we'll need to accept stream from old binaries, arrival of preempt
> > channel early is unavoidable.
> >
> 
> No, because old binary doesn't support multifd+postcopy, so there's only
> either main + multifd or main + preempt.
> 
> New binary with old machine type is the only one that can send preempt
> early.

I'll update this sentence to be:

  Since we'll need to accept stream from old binaries (QEMU 10.1 to 11.1),
  arrival of preempt channel early is unavoidable.

> 
> > What we can do, though, is to allow concurrent monitoring of all channels
> > rather than one.  Meanwhile, we shouldn't peek at anything that has no
> > data.
> >
> 
> I wonder why do we need to peek at all. Can't we start n threads and
> recv() a data chunk of fixed size (smaller than the preempt request) on
> every channel that comes up? Each thread puts the (data chunk + ioc) on
> a list and exits. The channels that don't send data would just sit there
> until something comes up.
> 
> Most channels would have data with a magic value right away so we'd
> empty the list before the preempt request comes up. But having a list
> means we can just iterate it when a consumer that has not yet received a
> channel asks for a piece of data.
> 
> We could also check that the data in the supposed preempt channel is a
> page request.

I'm not sure I fully get your proposal here, just to mention: preempt
channel has no data, recv() on it hangs like what already happens with this
bug.  Then, how do we recycle a hanged recv() thread with its ioc?

The other question is, anything else that wants to read from any migration
channel will need to take this (data chunk, ioc) info, because it needs to
read from "data chunk" first until depleted.  That's awkward.

Actually, since this solution doesn't work for TLS, I wanted to do
something like this and make TLS iochannel peekable (basically we can keep
that data chunk inside ioc for tls only), then as long as peekable this
solution will work too for TLS.  But I thought about it and I think it's
not worth it.  It'll pollute tls code.

> 
> > migration_channel_read_peek() almost does the wait, but it's too late.
> > This patch proposes to watch all channels from the start without reading at
> > them at all, relying on an IO watch attached.  This will make sure (1) for
> > preempt channel, we never read on it (watch can be gracefully disarmed when
> > we know it's preempt channel later) (2) since we have one IO watch for each
> > channel, then we can allow accept() to happen in almost any order, process
> > only when there's some header to read.
> >
> > To maintain these watches, a new GArray @channels_early is introduced, with
> > each element to be a (ioc, GSource) tuple (@MigEarlyIncomingChannel), so
> > that QEMU can manage all the IO watches later with it.  Here I used GSource
> > rather than io_tag because the GSource may or may not be attached to the
> > default main thread gcontext: when OOB is used, it may be the iothread
> > context instead.  IOW, g_source_remove() on io_tags stops working, which
> > only works for default main context.
> >
> > The trick this patch used is when we have the ability to wait on all
> > channel headers at the same time, we pick one by one from main and multifd
> > channels (since both of the types will contain headers dumped right at the
> > very beginning), leave preempt channel alone.  It means, after dest QEMU
> > finds all main and multifd channels, there are three possibilities:
> >
> >   - If preempt not enabled, we finished full channel establishment, done.
> >
> 
> I don't see why we need "channel establishment" at all. We're simply
> taking iochannels and putting them into named QEMUFiles, this means
> nothing. We could keep a list of unknown channels around indefinitely
> and fetch them lazily when the data is needed. By that point, the
> channels that have magic values would have already been identified and
> what's left is the unindentified channel.

Isn't that kind of what this iowatch does?   It puts channels into the
MigEarlyIncomingChannel, until it has something to read.  The only
difference is, this patch will wait for all magics arrived to continue
rather than continue then wait randomly at later points: I don't see how to
achieve that without modifying code later.

> 
> This would allow us add new channels with a proper header without
> interfering with the old channels. As long as the new channels are not
> to be consumed too soon.

I hope we don't introduce new channels until we have the handshake feature
ready.  Again, I'll prioritize that feature.

> 
> >   - If preempt enabled,
> >
> >     - If we have one registered IO watch with the IOC, it must be the
> >       preempt channel,
> >
> >     - If we have no further IO watch, wait for the next accept(), which
> >       must be the preempt channel.
> >
> 
> Ok, so watch all connections concurrently and pick the last one as
> preempt.

Right.

> 
> > This will make channel establish work on incoming side even with the old
> > QEMU binaries.
> >
> > While working on it, I managed to refactor the peeking logic quite a bit:
> > we used to have a very convoluted migration_channel_identify() function,
> > taking care of two different cases:
> >
> > (1) when the channel is peekable (like normal socket channels),
> > (2) when the channel is not peekable (like TLS or file migrations).
> >
> > This patch refactored that part to make it crystal clear on how we make
> > decisions on which channel is which, and split the peek/identify paths.
> >
> 
> I'm still bothered about the peek. The data is all intended for the
> destination machine, it owns it all, it can just consume it and put it
> in the pocket.

With MSG_PEEK, such buffer doesn't help.

Without MSG_PEEK (TLS's case) it may help, but again, I decided to not go
with it, and I'll just prioritize the handshake feature instead.

> 
> > One example incoming migration from pc-q35-7.2 after this patch applied,
> > and with relevant tracepoints set (8 multifd channels, 1 preempt channel):
> >
> >   migrate_set_state new state setup
> >   migration_channel_process_incoming ioc=0x557dc8af4e20 ioctype=qio-channel-socket
> >   migration_incoming_channel_watch ioc=0x557dc8af4e20 ioctype=qio-channel-socket
> >   migration_channel_process_incoming ioc=0x557dc8abc5d0 ioctype=qio-channel-socket
> >   migration_incoming_channel_watch ioc=0x557dc8abc5d0 ioctype=qio-channel-socket
> >   migration_channel_process_incoming ioc=0x557dc953d680 ioctype=qio-channel-socket
> >   migration_incoming_channel_watch ioc=0x557dc953d680 ioctype=qio-channel-socket
> >   migration_set_incoming_channel ioc=0x557dc8abc5d0 ioctype=qio-channel-socket type=MULTIFD
> >   migration_channel_process_incoming ioc=0x557dc898a820 ioctype=qio-channel-socket
> >   migration_incoming_channel_watch ioc=0x557dc898a820 ioctype=qio-channel-socket
> >   migration_set_incoming_channel ioc=0x557dc953d680 ioctype=qio-channel-socket type=MULTIFD
> >   migration_channel_process_incoming ioc=0x557dc919bd70 ioctype=qio-channel-socket
> >   migration_incoming_channel_watch ioc=0x557dc919bd70 ioctype=qio-channel-socket
> >   migration_set_incoming_channel ioc=0x557dc898a820 ioctype=qio-channel-socket type=MULTIFD
> >   migration_channel_process_incoming ioc=0x557dc8734b20 ioctype=qio-channel-socket
> >   migration_incoming_channel_watch ioc=0x557dc8734b20 ioctype=qio-channel-socket
> >   migration_set_incoming_channel ioc=0x557dc919bd70 ioctype=qio-channel-socket type=MULTIFD
> >   migration_channel_process_incoming ioc=0x557dc898bdf0 ioctype=qio-channel-socket
> >   migration_incoming_channel_watch ioc=0x557dc898bdf0 ioctype=qio-channel-socket
> >   migration_set_incoming_channel ioc=0x557dc8734b20 ioctype=qio-channel-socket type=MULTIFD
> >   migration_channel_process_incoming ioc=0x557dc968cfd0 ioctype=qio-channel-socket
> >   migration_incoming_channel_watch ioc=0x557dc968cfd0 ioctype=qio-channel-socket
> >   migration_set_incoming_channel ioc=0x557dc898bdf0 ioctype=qio-channel-socket type=MULTIFD
> >   migration_channel_process_incoming ioc=0x557dc8c31810 ioctype=qio-channel-socket
> >   migration_incoming_channel_watch ioc=0x557dc8c31810 ioctype=qio-channel-socket
> >   migration_set_incoming_channel ioc=0x557dc968cfd0 ioctype=qio-channel-socket type=MULTIFD
> >   migration_set_incoming_channel ioc=0x557dc8c31810 ioctype=qio-channel-socket type=MULTIFD
> >   migration_set_incoming_channel ioc=0x557dc8af4e20 ioctype=qio-channel-socket type=MAIN
> 
> Hm, multifd came first? Have you registered watches in reverse order or
> something? Not sure if it matters much.

This is after the patchset applied.  Multifd channels should come first
because I changed preempt channel to be after multifd in the next patch.
So this is expected behavior.

> 
> >   migration_start_incoming
> >   migrate_set_state new state active
> >   migration_channel_process_incoming ioc=0x557dc8966160 ioctype=qio-channel-socket
> >   migration_set_incoming_channel ioc=0x557dc8966160 ioctype=qio-channel-socket type=PREEMPT
> >
> > While at it, I renamed the four channel incoming/outgoing tracepoints, make
> > all to follow migration_[incoming|outgoing]_channel_*().  Especially for
> > incoming, then we can enable migration_incoming_channel* for incoming
> > channel debuggings.
> >
> > FINAL NOTE ON TLS
> > =================
> >
> > Note that this solution isn't a magic bullet fixing everything.  TLS is not
> > fixable with this approach because TLS isn't peekable channel, hence the
> > watch won't help.
> >
> > We can have other ways to hack it to make it work, e.g. we can make TLS
> > channels peekable too, but I don't want to pollute the TLS iochannel only
> > for this: let's hope handshake will arrive soon so we can drop these code.
> >
> > For now, when TLS is involved with such old machine type (7.2-), one needs
> > to migrate it out with any combination of features except enabling all
> > four (multifd + TLS + postcopy + preempt) to a patched binary, after that,
> > all combinations will start working.
> >
> 
> I don't understand where TLS comes into this. You mean TLS is not
> peekable so if we use TLS for the multifd channels, then we cannot
> tell them apart from preempt?

Yep.  TLS channels doesn't set QIO_CHANNEL_FEATURE_READ_MSG_PEEK, so it's
not peekable.  Internally, it's simply because there's no simple MSG_PEEK
equivalent for gnutls facilities, IIUC.

> 
> > BugLink: https://redhat.atlassian.net/browse/RHEL-254933
> > Fixes: e27418861288 ("migration: enable multifd and postcopy together")
> > Reported-by: Juraj Marcin <jmarcin@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/channel.h    |   3 +
> >  migration/migration.h  |  35 ++++
> >  migration/channel.c    | 414 +++++++++++++++++++++++++++++++++++------
> >  migration/migration.c  |  23 ++-
> >  migration/trace-events |   7 +-
> >  5 files changed, 421 insertions(+), 61 deletions(-)
> >
> 
> I'll wait for your replies before reviewing the code in detail.

Sure, the change is slightly involved indeed, it makes more sense we
clarify problems and high level things before going into details if there's
anything unclear.  Let me know if there're more things you'd ask, or things
I overlooked.

-- 
Peter Xu


