Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEF7E77170
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIwAh-0001f5-GW; Wed, 04 Dec 2024 15:40:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tIwAd-0001bt-PT
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:40:27 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tIwAb-0001mx-M8
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:40:27 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2C01B21167;
 Wed,  4 Dec 2024 20:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733344820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jRYmZbkH1vQhSakisaPx1lDP5tb0G7jeEeydHBSC8g0=;
 b=TybyrH7yK19vJpXSi+s4H60vEc40K9ulQ4g24lSyTX5Bgm85mFuqBNBl5OuXUyb51wE/rm
 3kANdAfuQJwaCrlNJvEsVqr7d/hnSYn8VO9RlVh2E1hIIHVKnSGdmrxOMZjR+uWJ+9JIWs
 8fOYctQh9g0JVbtYrInszW3VycIXwus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733344820;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jRYmZbkH1vQhSakisaPx1lDP5tb0G7jeEeydHBSC8g0=;
 b=VcrKn/dkDPsq/cRyabik1NRb5/A+fG5NAu8tCWylpgzGaJ1CKF3dmwG5fWGfxdcHSOAxOc
 kHgrK+T8kmWbpwDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TybyrH7y;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="VcrKn/dk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733344820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jRYmZbkH1vQhSakisaPx1lDP5tb0G7jeEeydHBSC8g0=;
 b=TybyrH7yK19vJpXSi+s4H60vEc40K9ulQ4g24lSyTX5Bgm85mFuqBNBl5OuXUyb51wE/rm
 3kANdAfuQJwaCrlNJvEsVqr7d/hnSYn8VO9RlVh2E1hIIHVKnSGdmrxOMZjR+uWJ+9JIWs
 8fOYctQh9g0JVbtYrInszW3VycIXwus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733344820;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jRYmZbkH1vQhSakisaPx1lDP5tb0G7jeEeydHBSC8g0=;
 b=VcrKn/dkDPsq/cRyabik1NRb5/A+fG5NAu8tCWylpgzGaJ1CKF3dmwG5fWGfxdcHSOAxOc
 kHgrK+T8kmWbpwDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4F2B13647;
 Wed,  4 Dec 2024 20:40:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SNxjGjO+UGdORgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 04 Dec 2024 20:40:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Peter Xu
 <peterx@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/6] migration: Kick postcopy threads on cancel
In-Reply-To: <Z1C1V25wydbBlsMb@redhat.com>
References: <20241202220137.32584-1-farosas@suse.de>
 <20241202220137.32584-3-farosas@suse.de> <Z1Ch8HpiKMoqILDM@x1n>
 <87r06ni84z.fsf@suse.de> <Z1Cv4JM8IbYeiDpR@x1n>
 <Z1C1V25wydbBlsMb@redhat.com>
Date: Wed, 04 Dec 2024 17:40:17 -0300
Message-ID: <87ikrzi3m6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2C01B21167
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Dec 04, 2024 at 02:39:12PM -0500, Peter Xu wrote:
>> On Wed, Dec 04, 2024 at 04:02:36PM -0300, Fabiano Rosas wrote:
>> > Peter Xu <peterx@redhat.com> writes:
>> >=20
>> > > On Mon, Dec 02, 2024 at 07:01:33PM -0300, Fabiano Rosas wrote:
>> > >> Make sure postcopy threads are released when migrate_cancel is
>> > >> issued. Kick the postcopy_pause semaphore and have the fault thread
>> > >> read 'fault_thread_quit' when joining.
>> > >>=20
>> > >> While here fix the comment mentioning userfault_event_fd.
>> > >>=20
>> > >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> > >
>> > > I remember when working on postcopy, I thought about failing migrate=
-cancel
>> > > for postcopy in general, rejecting such request.  And when working o=
n the
>> > > recover feature, there's no concern on having it being cancelled, be=
cause
>> > > the user really shouldn't do that..
>> > >
>> > > The problem is migrate-cancel means crashing the VM on both sides wh=
en QEMU
>> > > already goes into postcopy stage.
>> >=20
>> > Well, that's the sillyness of having a cancel command, you can never
>> > know what "cancel" means. The "documentation" says: "Cancel the current
>> > executing migration process", it doesn't mention anything about the
>> > consequences of such action.
>>=20
>> We definitely need cancel.  It was always used in precopy, and people use
>> it a lot!

To be clear, I'm not arguing against cancel. I'm just pointing out that
it's silly because it's just like pressing C-c in the shell in the
middle of something. What's the expected end state? Completely
unspecified. I don't find it at all "elegant" that we treat cancel like
error and just let the code carry on stumbling and exit
eventually. Because then we have this C-c arriving at random moments in
the middle of stuff. The way we do "exiting" in multifd is way more
maintainable. If that flag is set, then let's exit, otherwise everything
should work.

Note that in some parts of this series I'm checking the CANCELLING
state, which aside from being prone to be racy, is a step in a different
direction than the way we've implemented cancel so far (shutdown and let
the code exit vs. explicitly check against the CANCELLING state).

Hope I'm being coherent, I'm not sure.

>
> Not a fair benchmark though.
>
> People use cancel alot because 'precopy' cannot complete in a
> predictable amount of time, any time guesstime can suddenly
> get much worse if the guest dirties memory differently. So
> people give up and cancel it after waiting ridiculously long
> and never being sure if it is nearing the finish.
>
> Once a migrate has been switched to 'postcopy' phase, however,
> we have what should be a highly predictable completion time,
> directly related to the amount of untransferred pages. That
> time should not get worse. The amount of time spent in the
> 'postcopy' phase will depend on how long you let the migrate
> run in 'precopy' before flipping to 'postcopy'
>
> IOW, I think there's a reasonable case to be made that NOT
> having the ability to cancel while in 'postcopy' phase would
> be mostly acceptable. You give up the ability to cancel for
> a while, in exchange for a clearly determined completion
> time.=20

Some of these words could be in the documentation for cancel to make it
clear what the expectations are.

>
>> > > If the user wants to crash the VM anyway, an easier way to do is kil=
ling on
>> > > both sides.
>> >=20
>> > I don't think this is fair. We expose a "cancel" command, we better do
>> > some cancelling or instead reject the command appropriately, not expect
>> > the user to "know better".
>>=20
>> That's exactly why we should fail it with a proper error message, IMHO.
>> Because the user may not really understand the impact of postcopy.
>
> Yep, I think users/apps expect "cancel" to be safe. So if it can't be
> safe at certain times, we should reject it in those time windows.

Which kind of implies we should test this by migrate->cancel->migrate,
like the multifd test does, and not like this series does. I've been
focusing more on catching crashes/hangs.

>
>> > > If the user wished to cancel, we should tell them "postcopy cannot be
>> > > cancelled, until complete".  That's probably the major reason why pe=
ople
>> > > think postcopy is dangerous to use..
>> >=20
>> > We could certainly add that restriction, I don't see a problem with
>> > it. That said, what is the actual use case for migrate_cancel? And how
>> > does that compare with yank? I feel like we've been kind of relying on
>> > nobody using those commands really.
>>=20
>> We had "cancel" first, then "yank".  I didn't remember who merged yank,
>> especially for migration, and why it was ever needed.
>
> yank is for the case where the network connections are completely stuck,
> causing QEMU to potentially get stalled in I/O operations until a TCP
> timeout is reached. yank force unwedges any stuck I/O by aggresively
> closing the connections. It is most useful in the non-migration use
> cases though.
>

I asked because for socket at least yank and cancel do the same:
shutdown(). It might be more trouble than it's worth it, but I wonder if
we could have everything that can be stuck implement a yank routine and
just have cancel call those. So for instance, when this series does
sem_post on a bunch of semaphores explicitly, the cancel command would
instead call whatever yank routine was registered by the code that can
wait on the semaphore. With this there should be no surprises of a
cancel arriving at a weird moment, because we'd require "code that
sleeps" to implement a yank.

>> Migration users should have stick with "cancel" rather than "yank" - qmp
>> "yank" would "FAIL" the migration instead of showing CANCELLED, definite=
ly
>> should avoid.  I am not aware of anybody that uses "yank" for migration =
at
>> all.
>>=20
>> So yeah, both commands are slightly duplicated, and if we want to throw
>> one, it needs to be yank, not cancel.  I'm fine keeping both..
>
> I would say the difference is like a graceful shutdown vs pulling the
> power plug in a bare metal machine
>
> 'cancel' is intended to be graceful. It should leave you with a functional
> QEMU (or refuse to run if unsafe).
>
> 'yank' is intended to be forceful, letting you get out of bad situations
> that would otherwise require you to kill the entire QEMU process, but
> still with possible associated risk data loss to the QEMU backends.

For migration specifically I don't see much difference. Yank must leave
QEMU in a usable state enough for a second migration to succeed,
otherwise it's useless.

>
> They have overlap, but are none the less different.
>
> With regards,
> Daniel

