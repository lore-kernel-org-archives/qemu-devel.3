Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038ADC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 17:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvJRx-0003ID-Ka; Thu, 20 Mar 2025 13:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tvJRk-0003Fj-Cc
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 13:12:46 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tvJRi-00009E-8y
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 13:12:44 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C2CDC1F7A2;
 Thu, 20 Mar 2025 17:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742490759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PvqLhAEoL888A0TL6P9eqR/giRjDha47y+MELl0W1iQ=;
 b=TRGFgUlsxHGuEZq6noatBlIpO+/i7iIqGDBDyENr8L34ecFiNj1q90aXhKit8jjraOyNWi
 Z+TUEp9qDwCJ5E+F8Ynw4VYTZTJyy/MOBuwrwmCfezCJHT4joXmwoMp9Ecf6EdyaTKxfgF
 esRmDuVQedzoM1D+8iycHWHsK5h5Lyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742490759;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PvqLhAEoL888A0TL6P9eqR/giRjDha47y+MELl0W1iQ=;
 b=0bkTcNYQxjUtP1APZg+zN2CBMqkVhPcehKjJba8Kj8aS8fwCqtRWI75Lu8HD/futfARlZF
 Q4X8Di/sfl8afKCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742490758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PvqLhAEoL888A0TL6P9eqR/giRjDha47y+MELl0W1iQ=;
 b=r5m8UygallbWSvUvKPXWLpoLV7q960O/1G1LqD07LbtQdbWUnCgRtOfQpcW1bmyzhNKKIL
 IyGp8m/rNwTbpxdjjNnouZq99Ii+mlpG6pmRngkgbzCXqPqew/QPc4nDxVlOi4S1UElQuX
 BxA+pP/fheX6cEBMpsT0uv1XAudzc9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742490758;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PvqLhAEoL888A0TL6P9eqR/giRjDha47y+MELl0W1iQ=;
 b=zbM7Qn99JhdbpO98j76LwqRyu0Gff9R8X0oBA2e7nhKqSltTtZ3rdGp7OwxKYz1qzNUzFw
 4c6+Wg/jji9IMbAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40D1F13757;
 Thu, 20 Mar 2025 17:12:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jp+nAIZM3GcUFwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 20 Mar 2025 17:12:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org, "Maciej S .
 Szmigiero" <mail@maciej.szmigiero.name>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>
Subject: Re: [PATCH 1/2] migration: Add some documentation for multifd
In-Reply-To: <Z9w6s1XkDw6Qpr2v@x1.local>
References: <20250307134203.29443-1-farosas@suse.de>
 <20250307134203.29443-2-farosas@suse.de>
 <CAE8KmOx0KQ7OfbyivQ_256JVRugtJ8ekykxtQw-uz91Uiuv-tg@mail.gmail.com>
 <875xk3bw1i.fsf@suse.de> <Z9w6s1XkDw6Qpr2v@x1.local>
Date: Thu, 20 Mar 2025 14:12:35 -0300
Message-ID: <8734f7bp8c.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> On Thu, Mar 20, 2025 at 11:45:29AM -0300, Fabiano Rosas wrote:
>> There's a bunch of other issues as well:
>> 
>> - no clear distinction between what should go in the header and what
>>   should go in the packet.
>> 
>> - the header taking up one slot in the iov, which should in theory be
>>   responsibility of the client
>> 
>> - the whole multifd_ops situation which doesn't allow a clear interface
>>   between multifd and client
>> 
>> - the lack of uniformity between send/recv in regards to doing I/O from
>>   multifd code or from client code
>> 
>> - the recv having two different modes of operation, socket and file
>
> I can't say I know the answer of all of them, but to me the last one is
> kind of by design - obviously the old multifd was designed to be more or
> less event driven on dest side, but that doesn't play well on files.
>

Yes, it's entirely by design. But it does create an extra hurdle in the
end. The event driven model requires metadata to inform the IO thread
what to do with the data collected (write to RAM at address X). The
other model doesn't require that as it has a payload already included,
so it just populates the fields. The problem is that we tied file
migration with !packets, but if we want to use iovs all around, we'd
still want packets (due to magic and version) although it'd be way
easier to collect the actual data in MultiFDRecvData instead of passing
information through the header and then doing the work at ->recv().

> To be fair, I didn't invent multifd, but IMHO Juan did a great job
> designing it from scratch, at least it has a bunch of benefits
> comparing to the old protocol especially on perf side (even though
> when initially proposed I was not a fan of how the locking was
> designed.. but it should be much easier to understand after previous
> refactors).
>

Good point. My rant means no demerit at all to the current design, I'm
just objectively pointing out the parts I think are getting in the way.

> And just to say, we can change the code or protocol in whatever way we want
> if that could make it better.  So instead of the rant (which is still
> welcomed whenever you feel like :), we can go for whatever you see fit with
> compat properties (and if with a handshake, that's even less of a concern).

Point taken (on the HS as well).

