Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5094C3DA61
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 19:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUWy7-0002YB-16; Thu, 18 Jul 2024 15:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sUWy4-0002Xc-WD
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 15:39:09 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sUWy3-0002q3-68
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 15:39:08 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C822A1FC24;
 Thu, 18 Jul 2024 19:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721331543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RRciD2WRpFdnmw/oxM8HnCWRx3Jm4KUN3Dn7of1BTVs=;
 b=F1y+Sqt19kSF4efWZIBLkFvfJHphpZguBT2gCG0lt6fAc5Wckk6L82FQkRsAJrTl8NIAEK
 uSOcmVz8gnnpxlPDt1QBM7yPrlt//9uMDkrINo1CN0084SsHHWfmYusm7GE+U9cUeM3w6s
 grU/EE50cFmlh1WLg4p8z2CAtvpfYoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721331543;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RRciD2WRpFdnmw/oxM8HnCWRx3Jm4KUN3Dn7of1BTVs=;
 b=GG6BpoyyK+VDhGbzDlnpPMR1YDvfrSneEs1F8Z5Ie4XnQ+SK6cLHsGdi/5wWHiWtkDQXiB
 wiIaL1ae1uAu4QAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721331543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RRciD2WRpFdnmw/oxM8HnCWRx3Jm4KUN3Dn7of1BTVs=;
 b=F1y+Sqt19kSF4efWZIBLkFvfJHphpZguBT2gCG0lt6fAc5Wckk6L82FQkRsAJrTl8NIAEK
 uSOcmVz8gnnpxlPDt1QBM7yPrlt//9uMDkrINo1CN0084SsHHWfmYusm7GE+U9cUeM3w6s
 grU/EE50cFmlh1WLg4p8z2CAtvpfYoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721331543;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RRciD2WRpFdnmw/oxM8HnCWRx3Jm4KUN3Dn7of1BTVs=;
 b=GG6BpoyyK+VDhGbzDlnpPMR1YDvfrSneEs1F8Z5Ie4XnQ+SK6cLHsGdi/5wWHiWtkDQXiB
 wiIaL1ae1uAu4QAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E0031379D;
 Thu, 18 Jul 2024 19:39:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tG3PBVdvmWYZcAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 18 Jul 2024 19:39:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: "Wang, Lei" <lei4.wang@intel.com>, qemu-devel@nongnu.org, "Maciej S .
 Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH 6/7] migration/multifd: Move payload storage out of
 the channel parameters
In-Reply-To: <ZpAEIvbNr-ANuASV@x1n>
References: <20240620212111.29319-1-farosas@suse.de>
 <20240620212111.29319-7-farosas@suse.de>
 <e60bc0c7-dc49-400e-88f1-a30c32943f25@intel.com> <Zn15y693g0AkDbYD@x1n>
 <877cdtfcsi.fsf@suse.de> <Zo7cncqkxB89AUBe@x1n> <87y169dmu3.fsf@suse.de>
 <Zo8DaHbWlrNe3RXL@x1n> <87msmodnly.fsf@suse.de> <ZpAEIvbNr-ANuASV@x1n>
Date: Thu, 18 Jul 2024 16:39:00 -0300
Message-ID: <87jzhi1odn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.30 / 50.00];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_THREE(0.00)[4]; MID_RHS_MATCH_FROM(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
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

> On Thu, Jul 11, 2024 at 11:12:09AM -0300, Fabiano Rosas wrote:
>> What about the QEMUFile traffic? There's an iov in there. I have been
>> thinking of replacing some of qemu-file.c guts with calls to
>> multifd. Instead of several qemu_put_byte() we could construct an iov
>> and give it to multifd for transfering, call multifd_sync at the end and
>> get rid of the QEMUFile entirely. I don't have that completely laid out
>> at the moment, but I think it should be possible. I get concerned about
>> making assumptions on the types of data we're ever going to want to
>> transmit. I bet someone thought in the past that multifd would never be
>> used for anything other than ram.
>
> Hold on a bit.. there're two things I want to clarity with you.
>
> Firstly, qemu_put_byte() has buffering on f->buf[].  Directly changing them
> to iochannels may regress performance.  I never checked, but I would assume
> some buffering will be needed for small chunk of data even with iochannels.
>
> Secondly, why multifd has things to do with this?  What you're talking
> about is more like the rework of qemufile->iochannel thing to me, and IIUC
> that doesn't yet involve multifd.  For many of such conversions, it'll
> still be operating on the main channel, which is not the multifd channels.
> What matters might be about what's in your mind to be put over multifd
> channels there.
>
>> 
>> >
>> > I wonder why handshake needs to be done per-thread.  I was naturally
>> > thinking the handshake should happen sequentially, talking over everything
>> > including multifd.
>> 
>> Well, it would still be thread based. Just that it would be 1 thread and
>> it would not be managed by multifd. I don't see the point. We could make
>> everything be multifd-based. Any piece of data that needs to reach the
>> other side of the migration could be sent through multifd, no?
>
> Hmm.... yes we can. But what do we gain from it, if we know it'll be a few
> MBs in total?  There ain't a lot of huge stuff to move, it seems to me.
>
>> 
>> Also, when you say "per-thread", that's the model we're trying to get
>> away from. There should be nothing "per-thread", the threads just
>> consume the data produced by the clients. Anything "per-thread" that is
>> not strictly related to the thread model should go away. For instance,
>> p->page_size, p->page_count, p->write_flags, p->flags, etc. None of
>> these should be in MultiFDSendParams. That thing should be (say)
>> MultifdChannelState and contain only the semaphores and control flags
>> for the threads.
>> 
>> It would be nice if we could once and for all have a model that can
>> dispatch data transfers without having to fiddle with threading all the
>> time. Any time someone wants to do something different in the migration
>> code, there it goes a random qemu_create_thread() flying around.
>
> That's exactly what I want to avoid.  Not all things will need a thread,
> only performance relevant ones.
>
> So now we have multifd threads, they're for IO throughputs: if we want to
> push a fast NIC, that's the only way to go.  Anything wants to push that
> NIC, should use multifd.
>
> Then it turns out we want more concurrency, it's about VFIO save()/load()
> of the kenrel drivers and it can block.  Same to other devices that can
> take time to save()/load() if it can happen concurrently in the future.  I
> think that's the reason why I suggested the VFIO solution to provide a
> generic concept of thread pool so it services a generic purpose, and can be
> reused in the future.
>
> I hope that'll stop anyone else on migration to create yet another thread
> randomly, and I definitely don't like that either.  I would _suspect_ the
> next one to come as such is TDX.. I remember at least in the very initial
> proposal years ago, TDX migration involves its own "channel" to migrate,
> migration.c may not even know where is that channel.  We'll see.
>
> [...]
>
>> > One thing to mention is that when with an union we may probably need to get
>> > rid of multifd_send_state->pages already.
>> 
>> Hehe, please don't do this like "oh, by the way...". This is a major
>> pain point. I've been complaining about that "holding of client data"
>> since the fist time I read that code. So if you're going to propose
>> something, it needs to account for that.
>
> The client puts something into a buffer (SendData), then it delivers it to
> multifd (who silently switches the buffer).  After enqueued, the client
> assumes the buffer is sent and reusable again.
>
> It looks pretty common to me, what is the concern within the procedure?
> What's the "holding of client data" issue?
>

v2 is ready, but unfortunately this approach doesn't work. When client A
takes the payload, it fills it with it's data, which may include
allocating memory. MultiFDPages_t does that for the offset. This means
we need a round of free/malloc at every packet sent. For every client
and every allocation they decide to do.

