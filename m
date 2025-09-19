Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F309CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 21:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzibC-00046a-RD; Fri, 19 Sep 2025 17:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uzibB-00046R-1o
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:24:57 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uzib8-0000YD-Pp
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:24:56 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2E0131F7EC;
 Fri, 19 Sep 2025 21:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758317092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BsJImeTEiyRrv/6byDt4ZZ2ltHAsgQy4d4KC2FFd4+Y=;
 b=v9QB0x+hq5FkzXzy2kSARBc5KDd4BpXi3cGda8xH2cXAsSkaNV3N47XRrSY+fxJ+CjM46o
 K4SEM7GWkvtuM+5zAHl3zgB/rfphXKa/QRzgnmUeTwj7ETjrWll7+70I8pKg7EobIagEpx
 IG+JB5truxbukDu8yxeTItUETdAegt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758317092;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BsJImeTEiyRrv/6byDt4ZZ2ltHAsgQy4d4KC2FFd4+Y=;
 b=Zsc5sbBFp/qNEaVmdq/ReMhS6mJuHw99RAdfbBxRsS3dsbIu/MU4cqGMU90bYiVs1GOknV
 cXg+SQuisU3s/NBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758317092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BsJImeTEiyRrv/6byDt4ZZ2ltHAsgQy4d4KC2FFd4+Y=;
 b=v9QB0x+hq5FkzXzy2kSARBc5KDd4BpXi3cGda8xH2cXAsSkaNV3N47XRrSY+fxJ+CjM46o
 K4SEM7GWkvtuM+5zAHl3zgB/rfphXKa/QRzgnmUeTwj7ETjrWll7+70I8pKg7EobIagEpx
 IG+JB5truxbukDu8yxeTItUETdAegt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758317092;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BsJImeTEiyRrv/6byDt4ZZ2ltHAsgQy4d4KC2FFd4+Y=;
 b=Zsc5sbBFp/qNEaVmdq/ReMhS6mJuHw99RAdfbBxRsS3dsbIu/MU4cqGMU90bYiVs1GOknV
 cXg+SQuisU3s/NBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D8B913A78;
 Fri, 19 Sep 2025 21:24:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VanDFyPKzWiIJQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 19 Sep 2025 21:24:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Marco Cavenati <Marco.Cavenati@eurecom.fr>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Prasad Pandit
 <ppandit@redhat.com>
Subject: Re: [PATCH] migration: add  FEATURE_SEEKABLE to QIOChannelBlock
In-Reply-To: <1b7bdf-68c98b00-641-3c30b780@162059662>
References: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
 <87jz7rhjzq.fsf@suse.de> <1b7bdf-68c98b00-641-3c30b780@162059662>
Date: Fri, 19 Sep 2025 18:24:48 -0300
Message-ID: <87ecs2t9sv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
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

"Marco Cavenati" <Marco.Cavenati@eurecom.fr> writes:

> Hello Fabiano,
>
> On Thursday, April 10, 2025 21:52 CEST, Fabiano Rosas <farosas@suse.de> wrote:
>
>> Marco Cavenati <Marco.Cavenati@eurecom.fr> writes:
>> 
>> > Enable the use of the mapped-ram migration feature with savevm/loadvm
>> > snapshots by adding the QIO_CHANNEL_FEATURE_SEEKABLE feature to
>> > QIOChannelBlock. Implement io_preadv and io_pwritev methods to provide
>> > positioned I/O capabilities that don't modify the channel's position
>> > pointer.
>> 
>> We'll need to add the infrastructure to reject multifd and direct-io
>> before this. The rest of the capabilities should not affect mapped-ram,
>> so it's fine (for now) if we don't honor them.
>
> Do you have any status update on this infrastructure you mentioned?
>

I'm doing the work suggested by Daniel of passing migration
configuration options via the commands themselves. When that is ready we
can include savevm and have it only accept mapped-ram and clear all
other options.

But don't worry about that, propose your changes and I'll make sure to
have *something* ready before it merges. I don't see an issue with
merging this single patch, for instance:
https://lore.kernel.org/r/20250327143934.7935-2-farosas@suse.de

>> What about zero page handling? Mapped-ram doesn't send zero pages
>> because the file will always have zeroes in it and the migration
>> destination is guaranteed to not have been running previously. I believe
>> loading a snapshot in a VM that's already been running would leave stale
>> data in the guest's memory.
>
> About the zero handling I'd like to hear your opinion about this idea I
> proposed a while back:
> The scenarios where zeroing is not required (incoming migration and
> -loadvm) share a common characteristic: the VM has not yet run in the
> current QEMU process.
> To avoid splitting read_ramblock_mapped_ram(), could we implement
> a check to determine if the VM has ever run and decide whether to zero
> the memory based on that? Maybe using RunState?
>

We could just as well add some flag to load_snapshot() since we know
which invocations are guaranteed to happen with clean memory.

But if you can use existing code for that it would be great. Adding a
global guest_has_ever_run flag, not so much. What's the MachineInitPhase
before -loadvm?

> Then we can add something like this to read_ramblock_mapped_ram()
> ...
> clear_bit_idx = 0;
> for (...) {
>     // Zero pages
>     if (guest_has_ever_run()) {
>         unread = TARGET_PAGE_SIZE * (set_bit_idx - clear_bit_idx);
>         offset = clear_bit_idx << TARGET_PAGE_BITS;
>         host = host_from_ram_block_offset(block, offset);
>         if (!host) {...}
>         ram_handle_zero(host, unread);
>     }
>     // Non-zero pages
>     clear_bit_idx = find_next_zero_bit(bitmap, num_pages, set_bit_idx + 1);
> ...
> (Plus trailing zero pages handling)
>

The suggestion of splitting read_ramblock_mapped_ram() was to spare you
from having to touch this code. =) But since you already know how to do
it, then yes, let's add the change inline.

> Thank you :)
> Marco

