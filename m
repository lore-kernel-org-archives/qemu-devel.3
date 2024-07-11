Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340E9C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 19:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRzbs-00081e-1t; Thu, 11 Jul 2024 15:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sRzbq-0007sl-CM
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 15:37:42 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sRzbo-0005il-5N
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 15:37:42 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C215F1FB41;
 Thu, 11 Jul 2024 19:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720726658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bQ/qecO+1zycz3eDXget8MrS57FSqKliqwl9CnuZ1tA=;
 b=oU6yswcHZbbSY8i1bzkuH4SN+2yVz+iltR+/RBE1aKii2U4WMLF5pFFU4IqU9N2q20MMQh
 eVSpOROX7rXQYqulOOxhzQBFzb+8sZK77UcObnjpXnaF+DfGac2nCf3yhTV9KH7mNRROmc
 N3Mw5Bpjqp1Drmx75tesT9UKlbDPz0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720726658;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bQ/qecO+1zycz3eDXget8MrS57FSqKliqwl9CnuZ1tA=;
 b=S/oPUymUBNv3gZ2gx+m97+ce5kFgwKRtZM5HJknmiF5C82T530KTx9omgifBV2SKT0OJ55
 5k6sM2KOS+p+LWAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=A6nuK5s1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nDPpT7UT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720726657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bQ/qecO+1zycz3eDXget8MrS57FSqKliqwl9CnuZ1tA=;
 b=A6nuK5s1MgRXwSJG7z62rZjntdxouXf+MDmIraeFSrnzza9SCXyTHu5HMFS7Ml0bJKtq00
 sfGvrpbnslCUJ10uZV45b69F/XqbzK+aCaQVOkhYlTmDtcXSyRa153mczMnAUbL6Jw/mam
 Jb+A2+eZAlDrryEeRedKcsh6U5M363w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720726657;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bQ/qecO+1zycz3eDXget8MrS57FSqKliqwl9CnuZ1tA=;
 b=nDPpT7UTQopCtLqN1KbHCxCsbFt2bH7SVFjzkV5iatkKgC26am9zjtvFzZyKAzREz9dhxt
 9OlCQiikndYtzLBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 482F0139E0;
 Thu, 11 Jul 2024 19:37:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QeXmA4E0kGakZwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 11 Jul 2024 19:37:37 +0000
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
Date: Thu, 11 Jul 2024 16:37:34 -0300
Message-ID: <87bk33en41.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: C215F1FB41
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.51 / 50.00];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Spamd-Bar: /
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Right, but there's an extra memcpy to do that. Not sure how those
balance out.

We also don't flush the iov at once, so f->buf seems redundant to
me. But of course, if we touch any of that we must ensure we're not
dropping any major optimization.

> Secondly, why multifd has things to do with this?  What you're talking
> about is more like the rework of qemufile->iochannel thing to me, and IIUC
> that doesn't yet involve multifd.  For many of such conversions, it'll
> still be operating on the main channel, which is not the multifd channels.
> What matters might be about what's in your mind to be put over multifd
> channels there.
>

Any piece of code that fills an iov with data is prone to be able to
send that data through multifd. From this perspective, multifd is just a
way to give work to an iochannel. We don't *need* to use it, but it
might be simple enough to the point that the benefit of ditching
QEMUFile can be reached without too much rework.

Say we provision multifd threads early and leave them waiting for any
part of the migration code to send some data. We could have n-1 threads
idle waiting for the bulk of the data and use a single thread for any
early traffic that does not need to be parallel.

I'm not suggesting we do any of this right away or even that this is the
correct way to go, I'm just letting you know some of my ideas and why I
think ram + device state might not be the only data we put through
multifd.

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

Well it depends on what the alternative is. If we're going to create a
thread to send small chunks of data anyway, we could use the multifd
threads instead.

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

Just to be clear, do you want a thread-pool to replace multifd? Or would
that be only used for concurrency on the producer side?

> I hope that'll stop anyone else on migration to create yet another thread
> randomly, and I definitely don't like that either.  I would _suspect_ the
> next one to come as such is TDX.. I remember at least in the very initial
> proposal years ago, TDX migration involves its own "channel" to migrate,
> migration.c may not even know where is that channel.  We'll see.
>

It would be good if we could standardize on a single structure for data
transfer. Today it's kind of a mess, QEMUFile with it's several data
sizes, iovs, MultiFDPages_t, whatever comes out of this series in
p->data, etc. That makes it difficult to change the underlying model
without rewriting a bunch of logic.

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

No concern, it's just that you didn't mention any of this when you
suggested the union, so I thought you simply ignored it.

"holding of the client data" is what we're discussing here: The fact
that multifd keeps multifd_send_state->pages around for the next call to
multifd_queue_pages() to reach.

Anyway, your M+N suggestion seems to be enough to address this, let's
see.

>> 
>> > The object can't be a global
>> > cache (in which case so far it's N+1, N being n_multifd_channels, while "1"
>> > is the extra buffer as only RAM uses it).  In the union world we'll need to
>> > allocate M+N SendData, where N is still the n_multifd_channels, and M is
>> > the number of users, in VFIO's case, VFIO allocates the cached SendData and
>> > use that to enqueue, right after enqueue it'll get a free one by switching
>> > it with another one in the multifd's array[N].  Same to RAM.  Then there'll
>> > be N+2 SendData and VFIO/RAM needs to free their own SendData when cleanup
>> > (multifd owns the N per-thread only).
>> >
>> 
>> At first sight, that seems to work. It's similar to this series, but
>> you're moving the free slots back into the channels. Should I keep
>> SendData as an actual separate array instead of multiple p->data?
>
> I don't know.. they look similar to me yet so far, as long as multifd is
> managing the N buffers, while the clients will manage one for each.  There
> should have a helper to allocate/free the generic multifd buffers (SendData
> in this case) so everyone should be using that.
>
>> 
>> Let me know, I'll write some code and see what it looks like.
>
> I think Maciej is working on this too since your absence, as I saw he
> decided to base his work on top of yours and he's preparing the new
> version. I hope you two won't conflict or duplicates the work.  Might be
> good to ask / wait and see how far Maciej has been going.

