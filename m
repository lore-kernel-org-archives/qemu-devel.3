Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B0AC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 20:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhEii-0000Bx-2h; Mon, 04 Mar 2024 15:15:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhEiT-0000BK-QY
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 15:15:17 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhEiO-0004kk-AO
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 15:15:17 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 445BE20501;
 Mon,  4 Mar 2024 20:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709583308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIlBWCAEPSs4aBr4rRrdrRA/cc5IW0MoQ0Jpqous+6c=;
 b=AARCq9C6wnfiqE6/3NoDoeoTa30acJ99jYvXBGsHjjNKWOOkwmld6gr+wuxTT227Xeam4E
 dvsN7CbH1jQdFUKL7ITc4yCANS2dD4OfvVEpcXPEOMrrlrNhy6rMPgb0vZ76wcWLS5Z5nz
 b6H0EvehN+ut1ZG0S1k/3EbiknicSr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709583308;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIlBWCAEPSs4aBr4rRrdrRA/cc5IW0MoQ0Jpqous+6c=;
 b=hKeziRYVCPS75uGX71zvMXX2gkyVQSPu+K65lbGO72aynLelLpl7pBPSOJ7M1a44pwTXt0
 uxoMHLFsP8LvArCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709583308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIlBWCAEPSs4aBr4rRrdrRA/cc5IW0MoQ0Jpqous+6c=;
 b=AARCq9C6wnfiqE6/3NoDoeoTa30acJ99jYvXBGsHjjNKWOOkwmld6gr+wuxTT227Xeam4E
 dvsN7CbH1jQdFUKL7ITc4yCANS2dD4OfvVEpcXPEOMrrlrNhy6rMPgb0vZ76wcWLS5Z5nz
 b6H0EvehN+ut1ZG0S1k/3EbiknicSr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709583308;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIlBWCAEPSs4aBr4rRrdrRA/cc5IW0MoQ0Jpqous+6c=;
 b=hKeziRYVCPS75uGX71zvMXX2gkyVQSPu+K65lbGO72aynLelLpl7pBPSOJ7M1a44pwTXt0
 uxoMHLFsP8LvArCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C428413A58;
 Mon,  4 Mar 2024 20:15:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K6EQIssr5mWEOwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 04 Mar 2024 20:15:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Claudio Fontana
 <cfontana@suse.de>
Subject: Re: [PATCH v6 00/23] migration: File based migration with multifd
 and mapped-ram
In-Reply-To: <ZeXIoVho09HtXKQQ@x1n>
References: <20240229153017.2221-1-farosas@suse.de> <ZeXAGEVFWt4Z8QeN@x1n>
 <ZeXBsR0ctl4evdYb@redhat.com> <ZeXEROyMmHffj1b2@x1n>
 <ZeXIoVho09HtXKQQ@x1n>
Date: Mon, 04 Mar 2024 17:15:05 -0300
Message-ID: <87r0gp21py.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> On Mon, Mar 04, 2024 at 08:53:24PM +0800, Peter Xu wrote:
>> On Mon, Mar 04, 2024 at 12:42:25PM +0000, Daniel P. Berrang=C3=A9 wrote:
>> > On Mon, Mar 04, 2024 at 08:35:36PM +0800, Peter Xu wrote:
>> > > Fabiano,
>> > >=20
>> > > On Thu, Feb 29, 2024 at 12:29:54PM -0300, Fabiano Rosas wrote:
>> > > > =3D> guest: 128 GB RAM - 120 GB dirty - 1 vcpu in tight loop dirty=
ing memory
>> > >=20
>> > > I'm curious normally how much time does it take to do the final fdat=
async()
>> > > for you when you did this test.

I measured and it takes ~4s for the live migration and ~2s for the
non-live. I didn't notice this before because the VM goes into
postmigrate, so it's paused anyway.

>> > >=20
>> > > I finally got a relatively large system today and gave it a quick sh=
ot over
>> > > 128G (100G busy dirty) mapped-ram snapshot with 8 multifd channels. =
 The
>> > > migration save/load does all fine, so I don't think there's anything=
 wrong
>> > > with the patchset, however when save completes (I'll need to stop the
>> > > workload as my disk isn't fast enough I guess..) I'll always hit a s=
uper
>> > > long hang of QEMU on fdatasync() on XFS during which the main thread=
 is in
>> > > UNINTERRUPTIBLE state.
>> >=20
>> > That isn't very surprising. If you don't have O_DIRECT enabled, then
>> > all that disk I/O from the migrate is going to be in RAM, and thus the
>> > fdatasync() is likely to trigger writing out alot of data.
>> >=20
>> > Blocking the main QEMU thread though is pretty unhelpful. That suggests
>> > the data sync needs to be moved to a non-main thread.
>>=20
>> Perhaps migration thread itself can also be a candidate, then.
>>=20
>> >=20
>> > With O_DIRECT meanwhile there should be essentially no hit from fdatas=
ync.
>>=20
>> The update of COMPLETED status can be a good place of a marker point to
>> show such flush done if from the gut feeling of a user POV.  If that mak=
es
>> sense, maybe we can do that sync before setting COMPLETED.

At the migration completion I believe the multifd threads will have
already cleaned up and dropped the reference to the channel, it might be
too late then.

In the multifd threads, we'll be wasting (like we are today) the extra
syscalls after the first sync succeeds.

>>=20
>> No matter which thread does that sync, it's still a pity that it'll go i=
nto
>> UNINTERRUPTIBLE during fdatasync(), then whoever wants to e.g. attach a =
gdb
>> onto it to have a look will also hang.
>
> Or... would it be nicer we get rid of the fdatasync() but leave that for
> upper layers?  QEMU used to support file: migration already, it never
> manage cache behavior; it does smell like something shouldn't be done in
> QEMU when thinking about it, at least mapped-ram is nothing special to me
> from this regard.
>
> User should be able to control that either manually (sync), or Libvirt can
> do that after QEMU quits; after all Libvirt holds the fd itself?  It shou=
ld
> allow us to get rid of above UNINTERRUPTIBLE / un-debuggable period of QE=
MU
> went away.  Another side benefit: rather than holding all of QEMU resourc=
es
> (especially, guest RAM) when waiting for a super slow disk flush, Libvirt=
 /
> upper layer can do that separately after releasing all the QEMU resources
> first.

I like the idea of QEMU having a self-contained
implementation. Specially since we'll add O_DIRECT support, which is
already quite heavy-handed if we're talking about managing cache
behavior.

However, it's not trivial to find the right place to add the sync.
Wherever we put it there will be some implications, such as ensuring the
sync works even after migration failure, avoiding concurrent cleanup,
etc.

In any case, I don't think it's correct to have the sync at
qio_channel_close(), now that we've seen it might block for a long
time. We could at the very least have a qio_channel_flush()[1] which the
QIOChannelFile implements with fdatasync(). Then the clients can choose
when to sync.

1- we already have that actually and it's coupled to zero_copy. I don't
see why not make the function more generic.

