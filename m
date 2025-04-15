Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0495C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 13:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4ggT-00028z-Jc; Tue, 15 Apr 2025 09:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u4ggR-00028c-He
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 09:50:39 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u4ggL-0001K2-A0
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 09:50:39 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F232821114;
 Tue, 15 Apr 2025 13:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744725031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N/S5UX6+6GIosqgh79dSz88wZdFjXtdu3mQKjRxgY1U=;
 b=vgkZDSGwgr2CU7SOB/bMmURD+yYUD9AVrkBf92qvuYPjZu8s1hR2S6hxQQXwXkWIfYUj+y
 npjWRI+0YbIjXu8raYoyoXlR5lAsgiSsCPrVCVeV3ELCjW+p6weX05J763fAqNqiMp2SV5
 CdkffWn7cfusVcZ+CTfxIesYmiI6+5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744725031;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N/S5UX6+6GIosqgh79dSz88wZdFjXtdu3mQKjRxgY1U=;
 b=OJGIj0ny2tish42tJu61mT+moSMXDI0u/5BVmTRUISt7i9/G0i6HEE1qeZqr5dZ8Zm7QNW
 A1s5i6u8vRqJowDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744725030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N/S5UX6+6GIosqgh79dSz88wZdFjXtdu3mQKjRxgY1U=;
 b=RDwFO/2zIbUEa1WCcWyp5a3hG7ER0PDbaczWrn4sr41g30LkLBscCtRIjMad0UGqLegGuN
 QQ+mxKnGOTUpD+JxEFc6e9nxj7iqXEB+fvzXHN5KBIxzusntnou8OISydQwBPO16h2DlRI
 tWxU+pfAlLiwObdH88hfquZAgAyrlRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744725030;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N/S5UX6+6GIosqgh79dSz88wZdFjXtdu3mQKjRxgY1U=;
 b=5XEJuo7gioaiqX1WnHP4fb0II6G48RjvX+pIh3r4nEKZIHRvcdY1Dz2Be1RpUpFTPRqAVD
 tcUEOitszXbawaCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A77E13A9F;
 Tue, 15 Apr 2025 13:50:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CAlJCCZk/mdtLgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 15 Apr 2025 13:50:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Marco Cavenati <Marco.Cavenati@eurecom.fr>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Prasad Pandit
 <ppandit@redhat.com>
Subject: Re: [PATCH] migration: add   FEATURE_SEEKABLE to QIOChannelBlock
In-Reply-To: <7cd3c-67fe3180-3d9-10622a60@195384178>
References: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
 <87jz7rhjzq.fsf@suse.de> <4caa0-67f8d780-a89-60718600@156698708>
 <87ecxyhon3.fsf@suse.de> <7cd3c-67fe3180-3d9-10622a60@195384178>
Date: Tue, 15 Apr 2025 10:50:27 -0300
Message-ID: <87plhdfs9o.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
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

"Marco Cavenati" <Marco.Cavenati@eurecom.fr> writes:

> On Friday, April 11, 2025 14:24 CEST, Fabiano Rosas <farosas@suse.de> wrote:
>
>> > If bitmap 0 implies zero page, we could call `ram_handle_zero`
>> > in `read_ramblock_mapped_ram` for the clear bits.
>> > Or do you fear this might be unnecessary expensive for migration?
>> 
>> Yes, unfortunately the peformance difference is noticeable. But we could
>> have a slightly different algorithm for savevm. At this point it might
>> be easier to just duplicate read_ramblock_mapped_ram(), check for savevm
>> in there and see what that the resulting code looks like.
>
> I tried to get some numbers in a "bad case" scenario restoring a
> clean, fully booted, idle Debian VM with 4GB of ram. The zero pages
> are ~90%. I'm using a nvme ssd to store the snapshot and I repeated
> the restore 10 times with and without zeroing (`ram_handle_zero`).
> The restore takes on average +25% of time.
> (It's not a broad nor deep investigation.)
>
> So, I see your point on performance, but I'm not fully comfortable
> with the difference in zero page handling between mapped-ram on
> and mapped-ram off. In the former case zero pages are skipped, while
> in the latter they are explicitly zeroed.
> Enabling mapped-ram has the implicit effect to also skip zero-pages.
> I think it is an optimization not really bound to mapped-ram and it
> could be better to have this feature external to mapped-ram, enabled
> when the destination ram is known to be already zeroed (also for
> mapped-ram off ideally).
>

From a design perspective that makes sense. The only use case currently
would be mapped-ram _migration_ (as opposed to snapshot) because
non-mapped-ram migration is usually done live. The stream of pages will
potentially have several versions of the same page, therefore we need to
clear it when it's a zero page.

We'd benefit from a separate "don't load zero pages" option only when
the VM is guaranteed to be stopped and more importantly, not allowed to
be unstopped. This is the tricky part. We have experimented with and
dropped the idea of detecting a stopped-vm-migration for mapped-ram (the
idea back then was not to do better zero page handling, but skip dirty
tracking altogether).

Since we're dealing with snapshots here, which are asynchronous, I'm
wondering wheter it would make sense to extend the zero-page-detection
option to the destination. Then we could bind the loadvm process to
zero-page-detection=none because I don't think we can safely ignore them
anyway.

>> By the way, what's your overall goal with enabling the feature? Do you
>> intent to enable further capabilities for snapshot? Specifically
>> multifd. I belive the zero page skip is responsible for most of the
>> performance gains for mapped-ram without direct-io and multifd. The
>> benefit of bounded stream size doesn't apply to snapshots because
>> they're not live.
>
> My overall goal is a hot-loadvm feature that currently lives in a fork
> downstream and has a long way before getting in a mergeable state :)

Cool. Don't hesitate to send stuff our way, the sooner and more often we
discuss this, the better the chances of getting it merged upstream.

Do you use libvirt at all? Mapped-ram support has been added to it in
the latest version. The original use-case for mapped-ram was quick
snapshot saving and loading after all. Libvirt does it in a way that
does not use savevm, which might be helpful.

> In a nutshell, I'm using dirty page tracking to load from the snapshot
> only the pages that have been dirtied between two loadvm;
> mapped-ram is required to seek and read only the dirtied pages.

But then you'd have a bitmap of pages you could correlate with the
file_bmap and force-load whatever pages you need. It doesn't seem like
zero page handling would affect you too much in that case.

