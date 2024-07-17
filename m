Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F77C3DA60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 20:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUB7U-0005iZ-9a; Wed, 17 Jul 2024 16:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sUB7S-0005i5-9E
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 16:19:22 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sUB7Q-0001cp-2p
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 16:19:22 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4ED4F21BF1;
 Wed, 17 Jul 2024 20:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721247558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p9HBWqlNiNSDRl4n4hu419jZEm/cP0jx5lw6rVsh+gk=;
 b=je3mOYuvaUOW9pNBGz7WhqSC8WFV8P/suvBo3uwmsCG6ZTmF5l6UJEDK1EMABSL74JA4gE
 hCUMUodxWa8Rcco1Q1XbNB6L4X8w9RrrhWcrB1/aIrTE6isSengZb22sHXFJddrun08ys4
 a3yLHXL/uaBh91PWS5446sQLvKQzlE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721247558;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p9HBWqlNiNSDRl4n4hu419jZEm/cP0jx5lw6rVsh+gk=;
 b=EcXNGFKFNai8a+D+KbTcYgB1DOnEFgJIVYOFdJJnHA7GRLcdoXd3rb3KC135Ebgr4YXHbb
 lxU8zzAoft7YMLAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721247558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p9HBWqlNiNSDRl4n4hu419jZEm/cP0jx5lw6rVsh+gk=;
 b=je3mOYuvaUOW9pNBGz7WhqSC8WFV8P/suvBo3uwmsCG6ZTmF5l6UJEDK1EMABSL74JA4gE
 hCUMUodxWa8Rcco1Q1XbNB6L4X8w9RrrhWcrB1/aIrTE6isSengZb22sHXFJddrun08ys4
 a3yLHXL/uaBh91PWS5446sQLvKQzlE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721247558;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p9HBWqlNiNSDRl4n4hu419jZEm/cP0jx5lw6rVsh+gk=;
 b=EcXNGFKFNai8a+D+KbTcYgB1DOnEFgJIVYOFdJJnHA7GRLcdoXd3rb3KC135Ebgr4YXHbb
 lxU8zzAoft7YMLAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C68411368F;
 Wed, 17 Jul 2024 20:19:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id z043I0UnmGa0ZwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Jul 2024 20:19:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, "Maciej S. Szmigiero"
 <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Avihai
 Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v1 00/13] Multifd =?utf-8?Q?=F0=9F=94=80?= device state
 transfer support with VFIO consumer
In-Reply-To: <ZpgSTCAGbKwWi_o8@x1n>
References: <ZniFH14DT6ycjbrL@x1n>
 <b0dc8bc4-742b-474b-a4c4-4e190fd6af37@maciej.szmigiero.name>
 <Znr9mOo_t0DkkLbD@x1n>
 <9e85016e-ac72-4207-8e69-8cba054cefb7@maciej.szmigiero.name>
 <Znt0FQHJEtGxcLxj@x1n>
 <2066bb2e-ccb3-45b8-aaf7-c39303e7f993@maciej.szmigiero.name>
 <ZnxAZDcjlZ5oerq-@x1n>
 <73630858-3b65-4fc5-8f5f-a1f494c5c111@maciej.szmigiero.name>
 <Zn19kaeFiYuwwc4B@x1n>
 <35969f33-f6f3-4c34-8b9d-8c1ebac3305e@maciej.szmigiero.name>
 <ZpgSTCAGbKwWi_o8@x1n>
Date: Wed, 17 Jul 2024 17:19:15 -0300
Message-ID: <87msmf22m4.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [3.80 / 50.00]; BAYES_SPAM(5.10)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_RHS_MATCH_FROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email]
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

> On Tue, Jul 16, 2024 at 10:10:12PM +0200, Maciej S. Szmigiero wrote:
>> On 27.06.2024 16:56, Peter Xu wrote:
>> > On Thu, Jun 27, 2024 at 11:14:28AM +0200, Maciej S. Szmigiero wrote:
>> > > On 26.06.2024 18:23, Peter Xu wrote:
>> > > > On Wed, Jun 26, 2024 at 05:47:34PM +0200, Maciej S. Szmigiero wrote:
>> > > > > On 26.06.2024 03:51, Peter Xu wrote:
>> > > > > > On Wed, Jun 26, 2024 at 12:44:29AM +0200, Maciej S. Szmigiero wrote:
>> > > > > > > On 25.06.2024 19:25, Peter Xu wrote:
>> > > > > > > > On Mon, Jun 24, 2024 at 09:51:18PM +0200, Maciej S. Szmigiero wrote:
>> > > > > > > > > Hi Peter,
>> > > > > > > > 
>> > > > > > > > Hi, Maciej,
>> > > > > > > > 
>> > > > > > > > > 
>> > > > > > > > > On 23.06.2024 22:27, Peter Xu wrote:
>> > > > > > > > > > On Tue, Jun 18, 2024 at 06:12:18PM +0200, Maciej S. Szmigiero wrote:
>> > > > > > > > > > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>> > > > > > > > > > > 
>> > > > > > > > > > > This is an updated v1 patch series of the RFC (v0) series located here:
>> > > > > > > > > > > https://lore.kernel.org/qemu-devel/cover.1713269378.git.maciej.szmigiero@oracle.com/
>> > > > > > > > > > 
>> > > > > > > > > > OK I took some hours thinking about this today, and here's some high level
>> > > > > > > > > > comments for this series.  I'll start with which are more relevant to what
>> > > > > > > > > > Fabiano has already suggested in the other thread, then I'll add some more.
>> > > > > > > > > > 
>> > > > > > > > > > https://lore.kernel.org/r/20240620212111.29319-1-farosas@suse.de
>> > > > > > > > > 
>> > > > > > > > > That's a long list, thanks for these comments.
>> > > > > > > > > 
>> > > > > > > > > I have responded to them inline below.
>> > > > > > > > > (..)
>> > > > > > > 
>> > > > > > > 2) Submit this operation to the thread pool and wait for it to complete,
>> > > > > > 
>> > > > > > VFIO doesn't need to have its own code waiting.  If this pool is for
>> > > > > > migration purpose in general, qemu migration framework will need to wait at
>> > > > > > some point for all jobs to finish before moving on.  Perhaps it should be
>> > > > > > at the end of the non-iterative session.
>> > > > > 
>> > > > > So essentially, instead of calling save_live_complete_precopy_end handlers
>> > > > > from the migration code you would like to hard-code its current VFIO
>> > > > > implementation of calling vfio_save_complete_precopy_async_thread_thread_terminate().
>> > > > > 
>> > > > > Only it wouldn't be then called VFIO precopy async thread terminate but some
>> > > > > generic device state async precopy thread terminate function.
>> > > > 
>> > > > I don't understand what did you mean by "hard code".
>> > > 
>> > > "Hard code" wasn't maybe the best expression here.
>> > > 
>> > > I meant the move of the functionality that's provided by
>> > > vfio_save_complete_precopy_async_thread_thread_terminate() in this patch set
>> > > to the common migration code.
>> > 
>> > I see.  That function only does a thread_join() so far.
>> > 
>> > So can I understand it as below [1] should work for us, and it'll be clean
>> > too (with nothing to hard-code)?
>> 
>> It will need some signal to the worker threads pool to terminate before
>> waiting for them to finish (as the code in [1] just waits).
>> 
>> In the case of current vfio_save_complete_precopy_async_thread() implementation,
>> this signal isn't necessary as this thread simply terminates when it has read
>> all the date it needs from the device.
>> 
>> In a worker threads pool case there will be some threads waiting for
>> jobs to be queued to them and so they will need to be somehow signaled
>> to exit.
>
> Right.  We may need something like multifd_send_should_exit() +
> MultiFDSendParams.sem.  It'll be nicer if we can generalize that part so
> multifd threads can also rebase to that thread model, but maybe I'm asking
> too much.
>
>> 
>> > The time to join() the worker threads can be even later, until
>> > migrate_fd_cleanup() on sender side.  You may have a better idea on when
>> > would be the best place to do it when start working on it.
>> > 
>> > > 
>> > > > What I was saying is if we target the worker thread pool to be used for
>> > > > "concurrently dump vmstates", then it'll make sense to make sure all the
>> > > > jobs there were flushed after qemu dumps all non-iterables (because this
>> > > > should be the last step of the switchover).
>> > > > 
>> > > > I expect it looks like this:
>> > > > 
>> > > >     while (pool->active_threads) {
>> > > >         qemu_sem_wait(&pool->job_done);
>> > > >     }
>> > 
>> > [1]
>> > 
>> (..)
>> > > I think that with this thread pool introduction we'll unfortunately almost certainly
>> > > need to target this patch set at 9.2, since these overall changes (and Fabiano
>> > > patches too) will need good testing, might uncover some performance regressions
>> > > (for example related to the number of buffers limit or Fabiano multifd changes),
>> > > bring some review comments from other people, etc.
>> > > 
>> > > In addition to that, we are in the middle of holiday season and a lot of people
>> > > aren't available - like Fabiano said he will be available only in a few weeks.
>> > 
>> > Right, that's unfortunate.  Let's see, but still I really hope we can also
>> > get some feedback from Fabiano before it lands, even with that we have
>> > chance for 9.1 but it's just challenging, it's the same condition I
>> > mentioned since the 1st email.  And before Fabiano's back (he's the active
>> > maintainer for this release), I'm personally happy if you can propose
>> > something that can land earlier in this release partly.  E.g., if you want
>> > we can at least upstream Fabiano's idea first, or some more on top.
>> > 
>> > For that, also feel to have a look at my comment today:
>> > 
>> > https://lore.kernel.org/r/Zn15y693g0AkDbYD@x1n
>> > 
>> > Feel free to comment there too.  There's a tiny uncertainty there so far on
>> > specifying "max size for a device state" if do what I suggested, as multifd
>> > setup will need to allocate an enum buffer suitable for both ram + device.
>> > But I think that's not an issue and you'll tackle that properly when
>> > working on it.  It's more about whether you agree on what I said as a
>> > general concept.
>> > 
>> 
>> Since it seems that the discussion on Fabiano's patch set has subsided I think
>> I will start by basing my updated patch set on top of his RFC and then if
>> Fabiano wants to submit v1/v2 of his patch set then I will rebase mine on top
>> of it.
>> 
>> Otherwise, you can wait until I have a v2 ready and then we can work with that.
>
> Oh I thought you already started modifying his patchset.
>
> In this case, AFAIR Fabiano has plan to rework that RFC series, so maybe
> you want to double check with him, and can also wait for his new version if
> that's easier, because I do expect there'll be major changes.
>
> Fabiano?

Don't wait on me. I think I can make the changes Peter suggested without
affecting too much the interfaces used by this series. If it comes to
it, I can rebase this series "under" Maciej's.

