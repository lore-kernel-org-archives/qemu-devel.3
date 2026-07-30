Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376A1C55162
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 15:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpT2L-0004IU-RB; Thu, 30 Jul 2026 11:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wpT29-0004Cy-Cf
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 11:50:57 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wpT27-0006aP-Ey
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 11:50:57 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 72E6F7D300;
 Thu, 30 Jul 2026 15:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785426649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j4NZEWiNncz1n6/Hnpe1Y2XxThf8CILdzhjak4roPG8=;
 b=QIrgfL2tXdIKBsElxIRuiJjce+1W/ZZeLngSHyy69/VDqZFBMxWWmNZVSOuZvjFROmZyRa
 xlqbyqdHGFQIsFKmKt0U24M7MDGzdZ/f7v2LsAdnwjAx+b7A9oNzVsQDBPUFEGTHdsHSav
 6NUViw5LQjN4l7i6z9+6+XWX0lhllfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785426649;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j4NZEWiNncz1n6/Hnpe1Y2XxThf8CILdzhjak4roPG8=;
 b=9vuQZ+pnDPl98xzPDj1fWTuUIRLCzguki0mvPieSRg33UQ7pGPipDOPPOwsvkR9c8FwbXR
 WcacpmD3DxBK0qDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785426645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j4NZEWiNncz1n6/Hnpe1Y2XxThf8CILdzhjak4roPG8=;
 b=2aEDmz9YNPn66ytEQoI0CQpJpxTnQv6dc2tHvjY+uZdPj1ej/6P1MIhpwvTXxXhup3jGEH
 Tx5IP505wOxo9cnI7TGmfNl3XwKdiOZiTCtPoXLbuNsL4K3ek8vwzDpfGByZZshRbFCHip
 KKFgLvHeFcZkbLaQoa+xHXo5AwPvUaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785426645;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j4NZEWiNncz1n6/Hnpe1Y2XxThf8CILdzhjak4roPG8=;
 b=7N7qDyNX6dnDW5oGHiJjwPKamY/IEb67FZ6MrUqclcttd/WdS0A6FcJD6XYr6GRImhQuo2
 hkz/D9iwZwVztADg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1586C779CC;
 Thu, 30 Jul 2026 15:50:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SGYsNtRya2qXcQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 30 Jul 2026 15:50:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Alexandr
 Moshkov <dtalexundeer@yandex-team.ru>, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 0/4] migration: Remove extra type-checking from vmstate
 macros
In-Reply-To: <amteJEbrPguzFpH5@x1.local>
References: <20260729225227.1170574-1-farosas@suse.de>
 <amtbGkfKvPCJgDec@x1.local> <amteJEbrPguzFpH5@x1.local>
Date: Thu, 30 Jul 2026 12:50:38 -0300
Message-ID: <87se50mq7l.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
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

> On Thu, Jul 30, 2026 at 10:09:30AM -0400, Peter Xu wrote:
>> On Wed, Jul 29, 2026 at 07:52:23PM -0300, Fabiano Rosas wrote:
>> > Hi, this is basically what I ranted about in:
>> > https://lore.kernel.org/r/87jyqeomqz.fsf@suse.de
>> > 
>> > I'm replacing the per-integer-size type checks with a single "int that
>> > fits in 32bit" check. This allows several lines of duplicated code to
>> > be removed.
>> > 
>> > I haven't changed the macro names in the device code yet. If this
>> > series gets positive feedback then I'll send per-subsystem patches
>> > doing that.
>> > 
>> > CI run: https://gitlab.com/farosas/qemu/-/pipelines/2716814081
>> > Also tested:
>> > - migration-test --full --thorough
>> > - x86_64 compat run forwards and backwards for previous 3 QEMU releases
>> > - s390x compat run forwards and backwards for previous 2 QEMU releases
>> > - ppc64 compat run forwards and backwards for previous QEMU release
>> > - migration-test smoke ASAN/UBSAN run
>> > 
>> > Fabiano Rosas (4):
>> >   migration: Remove VMSTATE_ARRAY_INT32_UNSAFE
>> >   migration: Introduce VMStateOffset
>> >   migration: Remove redundant flags
>> >   migration: Remove duplicate vmstate macros
>> 
>> Nice work!
>> 
>> I think I was only looking at VBUFFER side and I thought it was fine
>> sticking with 32bit even signed or not, not a huge deal.  But cleaning up
>> VARRAY whole thing together looks definitely an improvement.  I definitely
>> like your version here.
>> 
>> I assume with your series I can drop both of my patches here, right?
>> 
>>   [PATCH v2 1/5] migration: Fix possible overflow in vmstate_handle_alloc()
>>   https://lore.kernel.org/r/20260728210417.1925078-2-peterx@redhat.com
>>   (I'll still respin with the rest)
>> 
>>   [PATCH] vhost/migration: Fix incorrect size used in inflight->addr in VMSD
>>   https://lore.kernel.org/r/20260728153942.1891677-1-peterx@redhat.com
>> 
>> The only missing piece would be an multiply overflow check in
>> vmstate_handle_alloc(), if you could add that check too while rewritting
>> that in patch 1 then I think it'll cover all.
>> 
>> Vladimir's ask in the separate email makes sense: I wonder if we can also
>> do one step further and merge VBUFFER into VARRAY.
>> 
>> The other trivial thing is, while looking, I found one trivial macro
>> VMSTATE_PARTIAL_VBUFFER not used; can drop it altogether.
>
> Now officially declare support for u64 on all these offsets, we also need
> to double check on our alignment with security issues.
>
> Similar reports will not be a bug anymore but results will be the same I
> assume: it's anything the attacker can feed a u64 directly (instead of an
> int32_t negative overflow), result is still failing a malloc() with
> enormously large numbers, legally this time.
>

Sprinkle some try_alloc maybe? Shouldn't be just a few from the
migration code itself.

> Do you still plan to work on finding per-user upper limit or whatever of
> that kind?  I'd say time spent working on series like this worths more than
> that, but I still want to check with you while looking at this solution.
>

I thought of some things for the future, but I don't have anything
concrete, only experiments:

1) For all vmstate macros that take an unbounded size, length, etc, add
a new variant:

 VMSTATE_FOO_BAR_V()
+VMSTATE_FOO_BAR_V_BOUNDED()

And allow the vmstate writer to provide a "Bounds" object (format to be
defined) and the vmstate core would just use that if it's there and
that's it. I still think that's a functionality the migration code
should have in its API.

2) Allowing a transfer limit in bytes to be set in QEMUFile, which can
be adjusted at will, maybe using some context-manager-like construct:

WITH_RX_CAP(f, 1024) {
    qemu_get_byte();
    qemu_get_byte();
    vmstate_load_vmsd()
    qemu_get_buf();
    ...
}

I'm still not sure how useful these would be.

> I suppose with this, one option is we can close all tickets reporting
> security issues while allocating with all u64 fields.
>
> Thanks,

