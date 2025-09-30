Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A1ECAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 20:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3giU-0005eE-3y; Tue, 30 Sep 2025 16:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v3giD-0005Y5-BB
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:12:37 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v3gi6-0003Xz-Ip
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:12:36 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DA9A61F7F4;
 Tue, 30 Sep 2025 20:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759263143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=shEu4G18dSBOX4qt1/KNBQqnB/V7KVsnJOxiCYaTOaw=;
 b=kIOW0Zfl2Jh1dyKLvoUtE5/eJKUSU/KfIp5sVobOKspJoOFLTNP9HiSrrZ3JD9dGPZsZd/
 Tl9u2JOTns22u3N7/wWruie70opLx8q3XkgeeASS3syAbBnm0gRaan7vfgdqrflAMZKmlv
 m+A4qQr7YdBwC8brhAVl1Q74lhrMZ1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759263143;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=shEu4G18dSBOX4qt1/KNBQqnB/V7KVsnJOxiCYaTOaw=;
 b=sUpbCc/PpfvIf4XqIjic0aDFg1/tGDQpgjI+3duIz+dwXDQIQKPxMMqOyVwTSzu2mdV+j9
 XH5Dr3FiFkUKzSBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759263142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=shEu4G18dSBOX4qt1/KNBQqnB/V7KVsnJOxiCYaTOaw=;
 b=CIklOlw9i97D7MCw7WF60mrRau74cqzymsKrCapvJNB1W/B7d3H0zDeIlAMOP44GnixFiR
 SwWgNesK3pfCsTpEpdBuQAbGYdqmjET0OyrpoNgSdiUwgvR4l0om75VhuUObil08YDM3g/
 aOL0CPKnnaO+I2d9gM8+s74DlLKjwYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759263142;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=shEu4G18dSBOX4qt1/KNBQqnB/V7KVsnJOxiCYaTOaw=;
 b=ZOKjoc7nFsLIhcIvuyvOMAhINIXzSYRlojFpAboXRZBHclc8L2b9RiluO07x8Z2Jac8M54
 Ahae4mk0tz5FHaDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FB051342D;
 Tue, 30 Sep 2025 20:12:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qRpfCaY53GhCPgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 30 Sep 2025 20:12:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Marco Cavenati <Marco.Cavenati@eurecom.fr>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Prasad Pandit
 <ppandit@redhat.com>
Subject: Re: [PATCH] migration: add   FEATURE_SEEKABLE to QIOChannelBlock
In-Reply-To: <1b7bdf-68d17080-aab-3c30b780@82293076>
References: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
 <87jz7rhjzq.fsf@suse.de> <1b7bdf-68c98b00-641-3c30b780@162059662>
 <87ecs2t9sv.fsf@suse.de> <1b7bdf-68d17080-aab-3c30b780@82293076>
Date: Tue, 30 Sep 2025 17:12:19 -0300
Message-ID: <877bxfvgws.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> On Friday, September 19, 2025 23:24 CEST, Fabiano Rosas <farosas@suse.de>=
 wrote:
>
>> "Marco Cavenati" <Marco.Cavenati@eurecom.fr> writes:
>>=20
>> > Hello Fabiano,
>> >
>> > On Thursday, April 10, 2025 21:52 CEST, Fabiano Rosas <farosas@suse.de=
> wrote:
>> >
>> >> Marco Cavenati <Marco.Cavenati@eurecom.fr> writes:
>> >>=20
>> >> > Enable the use of the mapped-ram migration feature with savevm/load=
vm
>> >> > snapshots by adding the QIO_CHANNEL_FEATURE_SEEKABLE feature to
>> >> > QIOChannelBlock. Implement io_preadv and io_pwritev methods to prov=
ide
>> >> > positioned I/O capabilities that don't modify the channel's position
>> >> > pointer.
>> >>=20
>> >> We'll need to add the infrastructure to reject multifd and direct-io
>> >> before this. The rest of the capabilities should not affect mapped-ra=
m,
>> >> so it's fine (for now) if we don't honor them.
>> >
>> > Do you have any status update on this infrastructure you mentioned?
>> >
>>=20
>> I'm doing the work suggested by Daniel of passing migration
>> configuration options via the commands themselves. When that is ready we
>> can include savevm and have it only accept mapped-ram and clear all
>> other options.
>>=20
>> But don't worry about that, propose your changes and I'll make sure to
>> have *something* ready before it merges. I don't see an issue with
>> merging this single patch, for instance:
>> https://lore.kernel.org/r/20250327143934.7935-2-farosas@suse.de
>
> Perfect!
>
>> >> What about zero page handling? Mapped-ram doesn't send zero pages
>> >> because the file will always have zeroes in it and the migration
>> >> destination is guaranteed to not have been running previously. I beli=
eve
>> >> loading a snapshot in a VM that's already been running would leave st=
ale
>> >> data in the guest's memory.
>> >
>> > About the zero handling I'd like to hear your opinion about this idea I
>> > proposed a while back:
>> > The scenarios where zeroing is not required (incoming migration and
>> > -loadvm) share a common characteristic: the VM has not yet run in the
>> > current QEMU process.
>> > To avoid splitting read_ramblock_mapped_ram(), could we implement
>> > a check to determine if the VM has ever run and decide whether to zero
>> > the memory based on that? Maybe using RunState?
>> >
>>=20
>> We could just as well add some flag to load_snapshot() since we know
>> which invocations are guaranteed to happen with clean memory.
>>=20
>> But if you can use existing code for that it would be great. Adding a
>> global guest_has_ever_run flag, not so much. What's the MachineInitPhase
>> before -loadvm?
>
> MachineInitPhase is set to PHASE_MACHINE_READY during ram_load() for
> both -loadvm and HMP loadvm, so unfortunately that isn=E2=80=99t an optio=
n.
>
> RunState during ram_load() is
> - RUN_STATE_INMIGRATE for -incoming,
> - RUN_STATE_PRELAUNCH for -loadvm
> - RUN_STATE_RESTORE_VM for HMP loadvm.
> But I=E2=80=99m not sure how reliable (or unreliable) it would be to depe=
nd on this
> to infer that RAM is zero.
>

I wouldn't mind using INMIGRATE and PRELAUNCH, seeing how INMIGRATE is
used indiscriminately around the codebase. And PRELAUNCH is actually
descriptive.

Maybe it's best if you pick an easy method, such as this one, and we'll
iterate on it once you send a patch.

> As for using a flag, I don=E2=80=99t see an obvious way to pass one down =
through
> load_snapshot -> qemu_loadvm_state -> ... -> read_ramblock_mapped_ram.
> Do you already have something in mind?
>

MigrateIncomingState

> Thank you
> Marco

