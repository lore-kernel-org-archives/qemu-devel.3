Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23B9E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 19:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIueC-0000mo-AE; Wed, 04 Dec 2024 14:02:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tIue8-0000mE-7q
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 14:02:48 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tIue2-0002zU-Hs
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 14:02:43 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A3CE4210FB;
 Wed,  4 Dec 2024 19:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733338959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cxprn8X+Oyg5jSWRAf4dNl//8sp7LiQJY17GcKRjCMY=;
 b=P7H/DfeYrRIYYyOKY/ZG+yk8By3aGdau0SEwO1oDmG+ck769AkPrsbt3ofx9yrWkb3ybR+
 poP2+ax9fZbV6jRaP1qPjM2x/QNF87kDUxuGHwrOuMVO2z9i6H/mGNAkh6RT72S4Rf4GUH
 9pew127Ge/LvYq5jm1gEMQk6Tj5u5Y8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733338959;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cxprn8X+Oyg5jSWRAf4dNl//8sp7LiQJY17GcKRjCMY=;
 b=BvNirq1xMoHzP1z0Otchc4CIFAHT1F6xQOhiO89CCUBISg3Oz1V/gE2/GzjPe2NWI4vFF0
 Hg48ZcOwsxVfb0DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733338959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cxprn8X+Oyg5jSWRAf4dNl//8sp7LiQJY17GcKRjCMY=;
 b=P7H/DfeYrRIYYyOKY/ZG+yk8By3aGdau0SEwO1oDmG+ck769AkPrsbt3ofx9yrWkb3ybR+
 poP2+ax9fZbV6jRaP1qPjM2x/QNF87kDUxuGHwrOuMVO2z9i6H/mGNAkh6RT72S4Rf4GUH
 9pew127Ge/LvYq5jm1gEMQk6Tj5u5Y8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733338959;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cxprn8X+Oyg5jSWRAf4dNl//8sp7LiQJY17GcKRjCMY=;
 b=BvNirq1xMoHzP1z0Otchc4CIFAHT1F6xQOhiO89CCUBISg3Oz1V/gE2/GzjPe2NWI4vFF0
 Hg48ZcOwsxVfb0DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29F1813974;
 Wed,  4 Dec 2024 19:02:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zrLlN06nUGdUMAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 04 Dec 2024 19:02:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 2/6] migration: Kick postcopy threads on cancel
In-Reply-To: <Z1Ch8HpiKMoqILDM@x1n>
References: <20241202220137.32584-1-farosas@suse.de>
 <20241202220137.32584-3-farosas@suse.de> <Z1Ch8HpiKMoqILDM@x1n>
Date: Wed, 04 Dec 2024 16:02:36 -0300
Message-ID: <87r06ni84z.fsf@suse.de>
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
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Dec 02, 2024 at 07:01:33PM -0300, Fabiano Rosas wrote:
>> Make sure postcopy threads are released when migrate_cancel is
>> issued. Kick the postcopy_pause semaphore and have the fault thread
>> read 'fault_thread_quit' when joining.
>> 
>> While here fix the comment mentioning userfault_event_fd.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> I remember when working on postcopy, I thought about failing migrate-cancel
> for postcopy in general, rejecting such request.  And when working on the
> recover feature, there's no concern on having it being cancelled, because
> the user really shouldn't do that..
>
> The problem is migrate-cancel means crashing the VM on both sides when QEMU
> already goes into postcopy stage.

Well, that's the sillyness of having a cancel command, you can never
know what "cancel" means. The "documentation" says: "Cancel the current
executing migration process", it doesn't mention anything about the
consequences of such action.

>
> If the user wants to crash the VM anyway, an easier way to do is killing on
> both sides.

I don't think this is fair. We expose a "cancel" command, we better do
some cancelling or instead reject the command appropriately, not expect
the user to "know better".

>
> If the user wished to cancel, we should tell them "postcopy cannot be
> cancelled, until complete".  That's probably the major reason why people
> think postcopy is dangerous to use..

We could certainly add that restriction, I don't see a problem with
it. That said, what is the actual use case for migrate_cancel? And how
does that compare with yank? I feel like we've been kind of relying on
nobody using those commands really.

One truth that we have (because it's tested) is that the multifd
migration allows migrate_cancel on the source and another migration to
start from it.

(btw, that reminds me that multifd+postcopy will probably break that
test).

>
> Or do we have any use case this could be a valid scenario?

Not that I know of. But you're the postcopy expert =)

