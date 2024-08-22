Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7600AC52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 17:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shBFp-0006QN-OR; Thu, 22 Aug 2024 13:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1shBFj-0006PU-Oq
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 13:05:39 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1shBFh-0005nY-Ry
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 13:05:39 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9CCC422204;
 Thu, 22 Aug 2024 17:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724346333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uFC49L6zrnxKrBgflvgL15AtogFtnue/06o9VrlfVjs=;
 b=nNgcC7fmmugEeaBrFRK0NLK5ALM5aGrNmUEaIQMm199xfy18Av7k4TZN1zlEEz4oSAsgVV
 G/+3ktVEkR94k+E2RvS2nBS52wxspupqnrVVOq45rfV8HXwwnSH3jgYeyfxf2YocbJll49
 oLHO9VpZsumrUrgV0zEUK+jzqay3Ve4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724346333;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uFC49L6zrnxKrBgflvgL15AtogFtnue/06o9VrlfVjs=;
 b=AWiBEdOoy+47yzUeUkT63Z8CRxOV8FumP4qnwS4R8QSiTimGigSod1/N4j/YVmd5mhznGI
 UgjCM64fl4lDk3Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724346333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uFC49L6zrnxKrBgflvgL15AtogFtnue/06o9VrlfVjs=;
 b=nNgcC7fmmugEeaBrFRK0NLK5ALM5aGrNmUEaIQMm199xfy18Av7k4TZN1zlEEz4oSAsgVV
 G/+3ktVEkR94k+E2RvS2nBS52wxspupqnrVVOq45rfV8HXwwnSH3jgYeyfxf2YocbJll49
 oLHO9VpZsumrUrgV0zEUK+jzqay3Ve4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724346333;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uFC49L6zrnxKrBgflvgL15AtogFtnue/06o9VrlfVjs=;
 b=AWiBEdOoy+47yzUeUkT63Z8CRxOV8FumP4qnwS4R8QSiTimGigSod1/N4j/YVmd5mhznGI
 UgjCM64fl4lDk3Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 284F2139D3;
 Thu, 22 Aug 2024 17:05:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oUuDN9xvx2ZoEgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 22 Aug 2024 17:05:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v3 12/14] migration/multifd: Allow multifd sync without
 flush
In-Reply-To: <Zsdi432b2dobNhMj@x1n>
References: <20240801123516.4498-1-farosas@suse.de>
 <20240801123516.4498-13-farosas@suse.de> <ZsdhY2ijx9nhSdLz@x1n>
 <Zsdi432b2dobNhMj@x1n>
Date: Thu, 22 Aug 2024 14:05:30 -0300
Message-ID: <87ttfcxzc5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.25 / 50.00]; BAYES_HAM(-3.00)[99.98%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.16)[-0.787]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Thu, Aug 22, 2024 at 12:03:47PM -0400, Peter Xu wrote:
>> On Thu, Aug 01, 2024 at 09:35:14AM -0300, Fabiano Rosas wrote:
>> > Separate the multifd sync from flushing the client data to the
>> > channels. These two operations are closely related but not strictly
>> > necessary to be executed together.
>> > 
>> > The multifd sync is intrinsic to how multifd works. The multiple
>> > channels operate independently and may finish IO out of order in
>> > relation to each other. This applies also between the source and
>> > destination QEMU.
>> > 
>> > Flushing the data that is left in the client-owned data structures
>> > (e.g. MultiFDPages_t) prior to sync is usually the right thing to do,
>> > but that is particular to how the ram migration is implemented with
>> > several passes over dirty data.
>> > 
>> > Make these two routines separate, allowing future code to call the
>> > sync by itself if needed. This also allows the usage of
>> > multifd_ram_send to be isolated to ram code.
>> 
>> What's the usage of sync but not flush here?
>
> Oh I think I see your point.. I think flush+sync is always needed, it's
> just that RAM may not always be the one to flush, but something else.
> Makes sense then.
>

I'm thinking of "flush" here as a last multifd_send() before sync. We
need multiple multifd_send() along the migration to send the data, but
we might not need this extra flush. It could be that there's nothing to
flush and the code guarantees it:

 <populate MultiFDSendData>
 multifd_send()
 sync

Where RAM currently does:

 multifd_queue_page()
 multifd_queue_page()
 multifd_queue_page()
 ...
 multifd_queue_page()
 multifd_send()
 sync

Today there is a multifd_send() inside multifd_queue_page() and the
amount sent depends on the ram.c code. At the time sync gets called,
there could be data queued but not yet sent. Another client (not ram)
could just produce data in a deterministic manner and match that with
calls to multifd_send().

> If you want, you may touch up the commit message to clarify that.  E.g. I
> still don't see any use case that we want to sync without a flush, that
> part might be a bit ambiguous.
>
> If my understanding is correct, take this:
>
> Reviewed-by: Peter Xu <peterx@redhat.com>

