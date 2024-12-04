Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704CBE7716F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 21:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIwVY-0003hO-L0; Wed, 04 Dec 2024 16:02:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tIwVJ-0003ar-Jx
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 16:01:52 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tIwVE-0000SF-Oq
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 16:01:46 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F16B31F38F;
 Wed,  4 Dec 2024 21:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733346103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5N6oEx37xAT19fr0H5vIcKqgpMidqgoKfVB1Ms1H5Xs=;
 b=0EmmlYhRrLQh8HYfC1xngmjdL8W+1NT6rrYThPsEp8Ie2QfD1MddMFk87idAqT006mDYJD
 39rNqcwkGdQaONP02OlETiLvY1dLzW51vH8nB9RmSkk2LGQKVEO3wf0Fvg5ffuSsz89gyn
 gfrNdLsGwKsRn6uUiXgAM3RPIK1ME5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733346103;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5N6oEx37xAT19fr0H5vIcKqgpMidqgoKfVB1Ms1H5Xs=;
 b=z9+oh7SkBe3JrfIVGcHfq3gazmZ0hSeGz86hMKax7v72PoQu3fTnwwEYa7bsZipTm8GY8A
 1l3CrBr+f7EyheBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733346102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5N6oEx37xAT19fr0H5vIcKqgpMidqgoKfVB1Ms1H5Xs=;
 b=GiBvvjF0elib1QnzgSLHm0GLx1MwBgYFGZ1BKF3qoxi0x7OCQ4WTtKooIblRmb5ugLYMmI
 ICnvIos8A/XNA0to04BrOEkkz/AgR7f15tT6+Sg5aLuTT1enNEgY4kEj8VEf7GYlTLapQ/
 l6X9IZfK/PqbgQk8gOzFgfi00k7CByc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733346102;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5N6oEx37xAT19fr0H5vIcKqgpMidqgoKfVB1Ms1H5Xs=;
 b=I3eAf/D9XWD8nSQtmfe3l4o99TUz/pXn6iF5eMv3MHoMzU52+hkaBLOHhFR8MTvPBvIV0l
 iY8oWwhaX4Ke2ZAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 779C613974;
 Wed,  4 Dec 2024 21:01:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qeqQDzbDUGfNSwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 04 Dec 2024 21:01:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/6] migration: Kick postcopy threads on cancel
In-Reply-To: <Z1DAzzB1SfY_bL17@x1n>
References: <20241202220137.32584-1-farosas@suse.de>
 <20241202220137.32584-3-farosas@suse.de> <Z1Ch8HpiKMoqILDM@x1n>
 <87r06ni84z.fsf@suse.de> <Z1Cv4JM8IbYeiDpR@x1n>
 <Z1C1V25wydbBlsMb@redhat.com> <Z1DAzzB1SfY_bL17@x1n>
Date: Wed, 04 Dec 2024 18:01:39 -0300
Message-ID: <87frn3i2mk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
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

> On Wed, Dec 04, 2024 at 08:02:31PM +0000, Daniel P. Berrang=C3=A9 wrote:
>> On Wed, Dec 04, 2024 at 02:39:12PM -0500, Peter Xu wrote:
>> > On Wed, Dec 04, 2024 at 04:02:36PM -0300, Fabiano Rosas wrote:
>> > > Peter Xu <peterx@redhat.com> writes:
>> > >=20
>> > > > On Mon, Dec 02, 2024 at 07:01:33PM -0300, Fabiano Rosas wrote:
>> > > >> Make sure postcopy threads are released when migrate_cancel is
>> > > >> issued. Kick the postcopy_pause semaphore and have the fault thre=
ad
>> > > >> read 'fault_thread_quit' when joining.
>> > > >>=20
>> > > >> While here fix the comment mentioning userfault_event_fd.
>> > > >>=20
>> > > >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> > > >
>> > > > I remember when working on postcopy, I thought about failing migra=
te-cancel
>> > > > for postcopy in general, rejecting such request.  And when working=
 on the
>> > > > recover feature, there's no concern on having it being cancelled, =
because
>> > > > the user really shouldn't do that..
>> > > >
>> > > > The problem is migrate-cancel means crashing the VM on both sides =
when QEMU
>> > > > already goes into postcopy stage.
>> > >=20
>> > > Well, that's the sillyness of having a cancel command, you can never
>> > > know what "cancel" means. The "documentation" says: "Cancel the curr=
ent
>> > > executing migration process", it doesn't mention anything about the
>> > > consequences of such action.
>> >=20
>> > We definitely need cancel.  It was always used in precopy, and people =
use
>> > it a lot!
>>=20
>> Not a fair benchmark though.
>>=20
>> People use cancel alot because 'precopy' cannot complete in a
>> predictable amount of time, any time guesstime can suddenly
>> get much worse if the guest dirties memory differently. So
>> people give up and cancel it after waiting ridiculously long
>> and never being sure if it is nearing the finish.
>>=20
>> Once a migrate has been switched to 'postcopy' phase, however,
>> we have what should be a highly predictable completion time,
>> directly related to the amount of untransferred pages. That
>> time should not get worse. The amount of time spent in the
>> 'postcopy' phase will depend on how long you let the migrate
>> run in 'precopy' before flipping to 'postcopy'
>
> Right.  And if to be precise - the time doesn't matter, but "how many dir=
ty
> page left".  For extremely busy guests, longer precopy doesn't help, for
> example.. so time isn't very relevant, IMHO.  It's just that postcopy
> always have an upper time limit, which is guest mem size / bw.
>
>>=20
>> IOW, I think there's a reasonable case to be made that NOT
>> having the ability to cancel while in 'postcopy' phase would
>> be mostly acceptable. You give up the ability to cancel for
>> a while, in exchange for a clearly determined completion
>> time.=20
>>=20
>> > > > If the user wants to crash the VM anyway, an easier way to do is k=
illing on
>> > > > both sides.
>> > >=20
>> > > I don't think this is fair. We expose a "cancel" command, we better =
do
>> > > some cancelling or instead reject the command appropriately, not exp=
ect
>> > > the user to "know better".
>> >=20
>> > That's exactly why we should fail it with a proper error message, IMHO.
>> > Because the user may not really understand the impact of postcopy.
>>=20
>> Yep, I think users/apps expect "cancel" to be safe. So if it can't be
>> safe at certain times, we should reject it in those time windows.
>>=20
>> > > > If the user wished to cancel, we should tell them "postcopy cannot=
 be
>> > > > cancelled, until complete".  That's probably the major reason why =
people
>> > > > think postcopy is dangerous to use..
>> > >=20
>> > > We could certainly add that restriction, I don't see a problem with
>> > > it. That said, what is the actual use case for migrate_cancel? And h=
ow
>> > > does that compare with yank? I feel like we've been kind of relying =
on
>> > > nobody using those commands really.
>> >=20
>> > We had "cancel" first, then "yank".  I didn't remember who merged yank,
>> > especially for migration, and why it was ever needed.
>>=20
>> yank is for the case where the network connections are completely stuck,
>> causing QEMU to potentially get stalled in I/O operations until a TCP
>> timeout is reached. yank force unwedges any stuck I/O by aggresively
>> closing the connections. It is most useful in the non-migration use
>> cases though.
>>=20
>> > Migration users should have stick with "cancel" rather than "yank" - q=
mp
>> > "yank" would "FAIL" the migration instead of showing CANCELLED, defini=
tely
>> > should avoid.  I am not aware of anybody that uses "yank" for migratio=
n at
>> > all.
>> >=20
>> > So yeah, both commands are slightly duplicated, and if we want to throw
>> > one, it needs to be yank, not cancel.  I'm fine keeping both..
>>=20
>> I would say the difference is like a graceful shutdown vs pulling the
>> power plug in a bare metal machine
>>=20
>> 'cancel' is intended to be graceful. It should leave you with a function=
al
>> QEMU (or refuse to run if unsafe).
>>=20
>> 'yank' is intended to be forceful, letting you get out of bad situations
>> that would otherwise require you to kill the entire QEMU process, but
>> still with possible associated risk data loss to the QEMU backends.
>>=20
>> They have overlap, but are none the less different.
>
> The question is more about whether yank should be used at all for
> migration only, not about the rest instances.
>
> My answer is yank should never be used for migration, because
> "migrate_cancel" also unplugs the power plug.. It's not anything more
> enforced.  It's only doing less always.
>
> E.g. migration_yank_iochannel() is exactly what we do with
> qmp_migrate_cancel() in the first place, only that migrate_cancel only do=
es
> it on the main channel (on both qemufiles even if ioc is one), however it
> should be suffice, and behave the same way, as strong as "yank".
>
> Meanwhile, "yank" definitely lacks the graceful side of thing, not only on
> "cancelled", but also anything extra in migration_cancel() that wasn't
> about shutdown().  Examples, qmp_migrate_cancel has special care on:
>
>   - migrate_dirty_limit(), where it'll shutdown the limit threads too
>     alongside if migration cancels,
>
>   - process the possible hang case with PRE_SWITCHOVER.
>
>   - if the cancel happened right during switchover, and if at that time t=
he
>     disks are inactivated, it'll re-activate the disks
>
> In general, there's no reason to use yank on migration, IMHO, because it's
> not stronger either on shutting the NIC.
>
> Considering it's confusing to mostly everyone, and tons of people asked me
> about this.. maybe I should send a patch to remove yank from migration?

Take a look at my suggestion in the other thread, it might make yank
make sense for migration after all. But I'm not against the removal,
it's better than the current state IMO.

>
> Thanks,

