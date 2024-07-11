Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6E1C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 21:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS15z-0003NS-5d; Thu, 11 Jul 2024 17:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sS15x-0003MV-D9
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 17:12:53 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sS15v-0006CT-Hk
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 17:12:53 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C23671FB4B;
 Thu, 11 Jul 2024 21:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720732367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NdGbNHSyvbcr0DDdD+UzePB44/fqETZwIKfI6gS8b+4=;
 b=X+PqddZghOIYRQFq6Ib4FRsicuxe3ULmR3LuZ4XRfcedt956yRX8mObSb9D0L8wMLrw/wA
 JdbMswylcYZV7G+bq0avAxDckOo9wedSyL+tdlDQCMkEbC4kp5tYRhh46+3wBM1Vx/t6lL
 Sciiy7xcEKoq8cREHn3TXt1vzoXB6pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720732367;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NdGbNHSyvbcr0DDdD+UzePB44/fqETZwIKfI6gS8b+4=;
 b=wEWEDzcdmWzg/cZ796TQM64uuDlBw4rfZ+rt6tidUdjqwO9h4d73c2SVcTV8Pp4NnPdeXf
 UjVtU//oqVkHNgDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=X+PqddZg;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wEWEDzcd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720732367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NdGbNHSyvbcr0DDdD+UzePB44/fqETZwIKfI6gS8b+4=;
 b=X+PqddZghOIYRQFq6Ib4FRsicuxe3ULmR3LuZ4XRfcedt956yRX8mObSb9D0L8wMLrw/wA
 JdbMswylcYZV7G+bq0avAxDckOo9wedSyL+tdlDQCMkEbC4kp5tYRhh46+3wBM1Vx/t6lL
 Sciiy7xcEKoq8cREHn3TXt1vzoXB6pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720732367;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NdGbNHSyvbcr0DDdD+UzePB44/fqETZwIKfI6gS8b+4=;
 b=wEWEDzcdmWzg/cZ796TQM64uuDlBw4rfZ+rt6tidUdjqwO9h4d73c2SVcTV8Pp4NnPdeXf
 UjVtU//oqVkHNgDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 476B3136AF;
 Thu, 11 Jul 2024 21:12:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +aneAs9KkGY5fQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 11 Jul 2024 21:12:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: "Wang, Lei" <lei4.wang@intel.com>, qemu-devel@nongnu.org, "Maciej S .
 Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH 6/7] migration/multifd: Move payload storage out of
 the channel parameters
In-Reply-To: <ZpBAL3U6G46OBGEN@x1n>
References: <20240620212111.29319-7-farosas@suse.de>
 <e60bc0c7-dc49-400e-88f1-a30c32943f25@intel.com> <Zn15y693g0AkDbYD@x1n>
 <877cdtfcsi.fsf@suse.de> <Zo7cncqkxB89AUBe@x1n> <87y169dmu3.fsf@suse.de>
 <Zo8DaHbWlrNe3RXL@x1n> <87msmodnly.fsf@suse.de> <ZpAEIvbNr-ANuASV@x1n>
 <87bk33en41.fsf@suse.de> <ZpBAL3U6G46OBGEN@x1n>
Date: Thu, 11 Jul 2024 18:12:44 -0300
Message-ID: <878qy7eipf.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: C23671FB4B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.51 / 50.00];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
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

> On Thu, Jul 11, 2024 at 04:37:34PM -0300, Fabiano Rosas wrote:
>
> [...]
>
>> We also don't flush the iov at once, so f->buf seems redundant to
>> me. But of course, if we touch any of that we must ensure we're not
>> dropping any major optimization.
>
> Yes some tests over that would be more persuasive when it comes.
>
> Per my limited experience in the past few years: memcpy on chips nowadays
> is pretty cheap.  You'll see very soon one more example of that when you
> start to look at the qatzip series: that series decided to do one more
> memcpy for all guest pages, to make it a larger chunk of buffer instead of
> submitting the compression tasks in 4k chunks (while I thought 4k wasn't
> too small itself).
>
> That may be more involved so may not be a great example (e.g. the
> compression algo can be special in this case where it just likes larger
> buffers), but it's not uncommon that I see people trade things with memcpy,
> especially small buffers.
>
> [...]
>
>> Any piece of code that fills an iov with data is prone to be able to
>> send that data through multifd. From this perspective, multifd is just a
>> way to give work to an iochannel. We don't *need* to use it, but it
>> might be simple enough to the point that the benefit of ditching
>> QEMUFile can be reached without too much rework.
>> 
>> Say we provision multifd threads early and leave them waiting for any
>> part of the migration code to send some data. We could have n-1 threads
>> idle waiting for the bulk of the data and use a single thread for any
>> early traffic that does not need to be parallel.
>> 
>> I'm not suggesting we do any of this right away or even that this is the
>> correct way to go, I'm just letting you know some of my ideas and why I
>> think ram + device state might not be the only data we put through
>> multifd.
>
> We can wait and see whether that can be of any use in the future, even if
> so, we still have chance to add more types into the union, I think.  But
> again, I don't expect.
>
> My gut feeling: we shouldn't bother putting any (1) non-huge-chunk, or (2)
> non-IO, data onto multifd.  Again, I would ask "why not the main channel",
> otherwise.
>
> [...]
>
>> Just to be clear, do you want a thread-pool to replace multifd? Or would
>> that be only used for concurrency on the producer side?
>
> Not replace multifd.  It's just that I was imagining multifd threads only
> manage IO stuff, nothing else.
>
> I was indeed thinking whether we can reuse multifd threads, but then I
> found there's risk mangling these two concepts, as: when we do more than IO
> in multifd threads (e.g., talking to VFIO kernel fetching data which can
> block), we have risk of blocking IO even if we can push more so the NICs
> can be idle again.  There's also the complexity where the job fetches data
> from VFIO kernel and want to enqueue again, it means an multifd task can
> enqueue to itself, and circular enqueue can be challenging: imagine 8
> concurrent tasks (with a total of 8 multifd threads) trying to enqueue at
> the same time; they hunger themselves to death.  Things like that.  Then I
> figured the rest jobs are really fn(void*) type of things; they should
> deserve their own pool of threads.
>
> So the VFIO threads (used to be per-device) becomes migration worker
> threads, we need them for both src/dst: on dst there's still pending work
> to apply the continuous VFIO data back to the kernel driver, and that can't
> be done by multifd thread too due to similar same reason.  Then those dest
> side worker threads can also do load() not only for VFIO but also other
> device states if we can add more.
>
> So to summary, we'll have:
>
>   - 1 main thread (send / recv)
>   - N multifd threads (IOs only)
>   - M worker threads (jobs only)
>
> Of course, postcopy not involved..  How's that sound?

Looks good. There's a better divide between producer and consumer this
way. I think it will help when designing new features.

One observation is that we'll still have two different entities doing IO
(multifd threads and the migration thread), which I would prefer were
using a common code at a higher level than the iochannel.

One thing that I tried to look into for mapped-ram was whether we could
set up iouring in the migration code, but got entirely discouraged by
the migration thread doing IO at random points. And of course, you've
seen what we had to do with direct-io. That was in part due to having
the migration thread in parallel doing it's small writes at undetermined
points in time.

