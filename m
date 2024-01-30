Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD60C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 13:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUodR-0008Qf-UB; Tue, 30 Jan 2024 08:58:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rUodE-0008OQ-EY
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 08:58:32 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rUodC-0003jp-Ci
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 08:58:32 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3D8F21F852;
 Tue, 30 Jan 2024 13:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706623107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KogRVjeNmwwJpd83FOu7dnf5rb1a8h1QvFo4fbD2VL0=;
 b=WMdca9JCYzSCF3XC+Mu2EF+elK36tYkmxdk7SA0R0cJ+ThAGwk5BApuymim8Fyk7xKp6Tp
 Hyk/NENj6TWq7q+5kWobD5myXz7xHrc0h4t9LNMpwh/2MneyMXadJcRvfFsUT1BLvToZYZ
 7s2H2+4FuiBt6SDjxybiutwHANocOrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706623107;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KogRVjeNmwwJpd83FOu7dnf5rb1a8h1QvFo4fbD2VL0=;
 b=jq/DbpSoqxBEQlRMzm/DLSVCKTT80vAoA8YROb/gAjzCfxBwKwygQQgOvbZ9Ynn36rnWav
 QTxieqVGYlSQb7BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706623107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KogRVjeNmwwJpd83FOu7dnf5rb1a8h1QvFo4fbD2VL0=;
 b=WMdca9JCYzSCF3XC+Mu2EF+elK36tYkmxdk7SA0R0cJ+ThAGwk5BApuymim8Fyk7xKp6Tp
 Hyk/NENj6TWq7q+5kWobD5myXz7xHrc0h4t9LNMpwh/2MneyMXadJcRvfFsUT1BLvToZYZ
 7s2H2+4FuiBt6SDjxybiutwHANocOrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706623107;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KogRVjeNmwwJpd83FOu7dnf5rb1a8h1QvFo4fbD2VL0=;
 b=jq/DbpSoqxBEQlRMzm/DLSVCKTT80vAoA8YROb/gAjzCfxBwKwygQQgOvbZ9Ynn36rnWav
 QTxieqVGYlSQb7BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8E1F13A66;
 Tue, 30 Jan 2024 13:58:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XmOgH4IAuWWEYwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 30 Jan 2024 13:58:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH] migration/docs: Explain two solutions for VMSD
 compatibility
In-Reply-To: <Zbh7zAqS4_9KnATk@x1n>
References: <20240122070600.16681-1-peterx@redhat.com>
 <87plxtgyxx.fsf@suse.de> <Za81vJgTjFSGT56r@x1n> <87frygdzjl.fsf@suse.de>
 <Zbh7zAqS4_9KnATk@x1n>
Date: Tue, 30 Jan 2024 10:58:24 -0300
Message-ID: <875xzaditb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Mon, Jan 29, 2024 at 10:44:46AM -0300, Fabiano Rosas wrote:
>> > Since we're at it, I would also like to know how you think about whether we
>> > should still suggest people using VMSD versioning, as we know that it won't
>> > work for backward migrations.
>> >
>> > My current thoughts is it is still fine, as it's easier to use, and it
>> > should still be applicable to the cases where a strict migration semantics
>> > are not required.  However it's hard to justify which device needs that
>> > strictness.
>> 
>> I'd prefer if we kept things strict. However I don't think we can do
>> that without having enough testing and specially, clear recipes on how
>> to add compatibility back once it gets lost. Think of that recent thread
>
> If it was broken, IMHO we should just fix it and backport to stable.

(tangent)
Sure, but I'm talking about how do we instruct device developers on
fixing migration bugs. We cannot simply yell "regression!" and expect
people to care.

Once something breaks there's no easy way to determine what's the right
fix. It will always involve copying the migration maintainers and some
back and forth with the device people before we reach an agreement on
what's even broken.

When I say "clear recipes" what I mean is we'd have a "catalogue" of
types of failures that could happen. Those would be both documented in
plain english and also have some instrumentation in the code to produce
a clear error/message.

  E.g.: "Device 'foo' failed to migrate because of error type X: the src
  machine provided more state than the dst was expecting around the
  value Y".

And that "error type X" would come with some docs listing examples of
other similar errors and what strategies we suggest do deal with them.

Currently most migration failures are just a completely helpless:
"blergh, error -5". And the only thing we can say about it upfront is
"well, something must have changed in the stream".

Real migration failures I have seen recently (all fixed already):

1- Some feature bit was mistakenly removed from an arm cpu. Migration
   complains about a 'length' field being different.

2- A group of devices was moved from the machine init to the cpu init on
   pseries. Migration spews some nonsense about an "index".

3- Recent (invalid) bug on -cpu max on arm, a couple of bits were set in
   a register. Migration barfs incomprehensibly with: "error while
   loading state for instance 0x0 of device 'cpu', Operation not
   permitted".

So I bet we could improve these error cases to be a bit more predictable
and that would help device developers to be able to maintain migration
compatibility without making it seem like an arbitrary, hard to achieve
requirement.
(/tangent)

>
> I think Juan used to worry on what happens if someone already used an old
> version of old release, e.g., someone using 8.2.0 may not be able to
> migrate to 8.2.1 if we fix that breakage in 9.0 and backport that to 8.2.1.
> My take is that maybe that's overcomplicated, and maybe we should simply
> only maintain the latest stable version, rather than all.  In this case,
> IMHO it will be less burden if we only guarantee 8.2.1 will be working,
> e.g., when migrating from 8.1.z -> 8.2.1.  Then we should just state a
> known issue in 8.2.0 that it is broken, and both:
>
>   (1) 8.1.z -> 8.2.0, and

Fair enough.

>   (2) 8.2.0 -> 8.2.1

Do you think we may not be able to always ensure that the user can get
out of the broken version? Or do you simply think that's too much work?

I think I agree with you. It's better to have a clear statement of what
we support and make sure that works, rather than having _some_ scenarios
where the user _may_ need to shutdown the VM and _some_ where they _may_
be able to migrate out of the situation. It creates a confusing message
that I imagine would just cause people to avoid using migration
altogether.

> will expect to fail.
>
>> were we discussed an old powerpc issue. How come we can see the fix
>> today in the code but cannot tell which problem it was trying to solve?
>> That's bonkers. Ideally every type of breakage would have a mapping into
>> why it breaks and how to fix it.
>> 
>> So with testing to catch the issue early and a clear step-by-step on how
>> to identify and fix compatibility, then we could require strict
>> compatibility for every device.
>
> I don't think we can guarantee no bug there, but indeed we can do better on
> providing some test framework for device VMSDs.
>
>> 
>> >
>> > For example, any device to be used in migration-test must be forward +
>> > backward migration compatible at least, because you just added the n-1
>> > regression tests to cover both directions.  Said that, only a few devices
>> > are involved because currently our migration-test qemu cmdline is pretty
>> > simple.
>> 
>> We might want to make a distinction between migration core vs. device
>> state testing. I see n-1 testing more like migration core testing. It's
>> bad to break migration, but it's really bad to break migration for
>> everyone because we refactored something deep within migration/.
>> 
>> I also wouldn't mind if we had some simple way for device developers to
>> add migration tests that cover their code. Currently it's infeasible to
>> edit migration-test with new command lines for every device of
>> interest. Maybe we could have a little framework that takes a command
>> line and spits a migration stream? Something really self-contained,
>> behind the device's CONFIG in meson.
>
> I added one more todo:
>
> https://wiki.qemu.org/ToDo/LiveMigration#Device_migration_stream_test_framework
>
> How's that look?  Feel free to modify on your will.

Looks good.

The point about the guest behavior influence is something that Juan has
mentioned as a blocker for testing with static data. I don't think it
would be impossible to have some unit testing at the vmstate with some
artificial values, but it might be too much work to be worth it.

