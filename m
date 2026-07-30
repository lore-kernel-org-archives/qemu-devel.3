Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD53C55164
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 15:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpSpC-0008Mc-KU; Thu, 30 Jul 2026 11:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wpSpA-0008MD-BL
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 11:37:32 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wpSp8-0003pS-Jz
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 11:37:32 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8DF973E2C;
 Thu, 30 Jul 2026 15:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785425844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mO5Rh04uWDPYLHX7xQSUweHncyGn5Cd7rSlnXpDUR5Q=;
 b=gJEkcE/eHa4MHDnA6pllLfJ+EO1dM2fU8JacTzplShPdGvRmzW6VAZZl/D78dt2ad8193n
 hUD6eFYgnF0b+Kn3FU/FoSatLt1Y717pPZo32a2XSwwR4mcfKors8QKZx7Aon9LBpjZ58j
 ObwOSvbbCZAVTciAcZlFQUvPM/+aA34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785425844;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mO5Rh04uWDPYLHX7xQSUweHncyGn5Cd7rSlnXpDUR5Q=;
 b=z+qtBnqB2DeiC50zqF3kvcfVDmrpezK3a7bcYNrsdYKD6s+cqq3+1ZuvbW7kI8VlAaKnuU
 DuNjh9UIC3TGeuAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785425840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mO5Rh04uWDPYLHX7xQSUweHncyGn5Cd7rSlnXpDUR5Q=;
 b=ilz8Ybpwje9MQ7K+w37/8zDfWTbmvspd1Qj06jjxXYdaxRpV+lhJ5LyyWRsAoYwDF57yRH
 w7Szz7pUQHwf/ahuGOAPZNV4J8prZbfw78+u6C4xmZVnYLbAW2Lf3EfJSy2AGm7Qy2AFw2
 kBhbiZurgJIkI3kJcpvXTwAlptFhDOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785425840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mO5Rh04uWDPYLHX7xQSUweHncyGn5Cd7rSlnXpDUR5Q=;
 b=WqjBQUQF62uVIp6r7ujzPTQKHwlLJYksnizGLaqbbw6jqlefHyywq1Ohr3GFGCBWgCdJ1J
 9WbN7fICwvPtkABg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F009779CC;
 Thu, 30 Jul 2026 15:37:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XaCpALBva2pYZAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 30 Jul 2026 15:37:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Alexandr
 Moshkov <dtalexundeer@yandex-team.ru>, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 0/4] migration: Remove extra type-checking from vmstate
 macros
In-Reply-To: <amtbGkfKvPCJgDec@x1.local>
References: <20260729225227.1170574-1-farosas@suse.de>
 <amtbGkfKvPCJgDec@x1.local>
Date: Thu, 30 Jul 2026 12:37:13 -0300
Message-ID: <87v79wmqty.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
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

> On Wed, Jul 29, 2026 at 07:52:23PM -0300, Fabiano Rosas wrote:
>> Hi, this is basically what I ranted about in:
>> https://lore.kernel.org/r/87jyqeomqz.fsf@suse.de
>> 
>> I'm replacing the per-integer-size type checks with a single "int that
>> fits in 32bit" check. This allows several lines of duplicated code to
>> be removed.
>> 
>> I haven't changed the macro names in the device code yet. If this
>> series gets positive feedback then I'll send per-subsystem patches
>> doing that.
>> 
>> CI run: https://gitlab.com/farosas/qemu/-/pipelines/2716814081
>> Also tested:
>> - migration-test --full --thorough
>> - x86_64 compat run forwards and backwards for previous 3 QEMU releases
>> - s390x compat run forwards and backwards for previous 2 QEMU releases
>> - ppc64 compat run forwards and backwards for previous QEMU release
>> - migration-test smoke ASAN/UBSAN run
>> 
>> Fabiano Rosas (4):
>>   migration: Remove VMSTATE_ARRAY_INT32_UNSAFE
>>   migration: Introduce VMStateOffset
>>   migration: Remove redundant flags
>>   migration: Remove duplicate vmstate macros
>
> Nice work!
>
> I think I was only looking at VBUFFER side and I thought it was fine
> sticking with 32bit even signed or not, not a huge deal.  But cleaning up
> VARRAY whole thing together looks definitely an improvement.  I definitely
> like your version here.
>
> I assume with your series I can drop both of my patches here, right?
>
>   [PATCH v2 1/5] migration: Fix possible overflow in vmstate_handle_alloc()
>   https://lore.kernel.org/r/20260728210417.1925078-2-peterx@redhat.com
>   (I'll still respin with the rest)
>
>   [PATCH] vhost/migration: Fix incorrect size used in inflight->addr in VMSD
>   https://lore.kernel.org/r/20260728153942.1891677-1-peterx@redhat.com
>
> The only missing piece would be an multiply overflow check in
> vmstate_handle_alloc(), if you could add that check too while rewritting
> that in patch 1 then I think it'll cover all.
>
> Vladimir's ask in the separate email makes sense: I wonder if we can also
> do one step further and merge VBUFFER into VARRAY.
>
> The other trivial thing is, while looking, I found one trivial macro
> VMSTATE_PARTIAL_VBUFFER not used; can drop it altogether.

I can look at it all. Just a heads-up, I'll be off for a couple of weeks
starting tomorrow.

