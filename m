Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31096C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 12:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUQgJ-00031T-Cc; Mon, 29 Jan 2024 07:24:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rUQgF-0002tE-CR
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 07:24:03 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rUQgD-0006Ap-G7
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 07:24:03 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 075AB1FCF7;
 Mon, 29 Jan 2024 12:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706531038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WNjg0LVkC3lDbwt8241g+gFXDfd4wsfs9xmN5JR4ouI=;
 b=b/BTbBzc3n53yCYG2TzUJWQMOtpqeOcrtfvCBDOU6mUQrGn3JaBdKdYfrxW7bQ8ut+/bKI
 JRLHJLJuNmfDwRpg+kFZbmaJoTUwWXWj30aUBLEJeRwk8hW8W76nspjblMdsEz8Ytvoi2Z
 3cBt/Xu7HxFZGJ4/42qyKsTtpyDML78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706531038;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WNjg0LVkC3lDbwt8241g+gFXDfd4wsfs9xmN5JR4ouI=;
 b=JLwlDRRMw/+RkEDTOCa38RSP42JnwaZRbDEML/3l6jAE1y6IhUuraEpS7naccJw9ReTiKC
 +qe8gByxR1ChjyDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706531038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WNjg0LVkC3lDbwt8241g+gFXDfd4wsfs9xmN5JR4ouI=;
 b=b/BTbBzc3n53yCYG2TzUJWQMOtpqeOcrtfvCBDOU6mUQrGn3JaBdKdYfrxW7bQ8ut+/bKI
 JRLHJLJuNmfDwRpg+kFZbmaJoTUwWXWj30aUBLEJeRwk8hW8W76nspjblMdsEz8Ytvoi2Z
 3cBt/Xu7HxFZGJ4/42qyKsTtpyDML78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706531038;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WNjg0LVkC3lDbwt8241g+gFXDfd4wsfs9xmN5JR4ouI=;
 b=JLwlDRRMw/+RkEDTOCa38RSP42JnwaZRbDEML/3l6jAE1y6IhUuraEpS7naccJw9ReTiKC
 +qe8gByxR1ChjyDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87F5012FF7;
 Mon, 29 Jan 2024 12:23:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wBf1E92Yt2XzGAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 29 Jan 2024 12:23:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 04/17] migration/multifd: Set p->running = true in the
 right place
In-Reply-To: <Zbcm1nXzQ_r0eGG0@x1n>
References: <20240125162528.7552-1-avihaih@nvidia.com>
 <20240125162528.7552-5-avihaih@nvidia.com> <87a5otw2ps.fsf@suse.de>
 <78fa90f7-d062-4f23-8035-841a0ffef8af@nvidia.com> <Zbcm1nXzQ_r0eGG0@x1n>
Date: Mon, 29 Jan 2024 09:23:55 -0300
Message-ID: <87plxke3ac.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email];
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

> On Sun, Jan 28, 2024 at 05:43:52PM +0200, Avihai Horon wrote:
>> 
>> On 25/01/2024 22:57, Fabiano Rosas wrote:
>> > External email: Use caution opening links or attachments
>> > 
>> > 
>> > Avihai Horon <avihaih@nvidia.com> writes:
>> > 
>> > > The commit in the fixes line moved multifd thread creation to a
>> > > different location, but forgot to move the p->running = true assignment
>> > > as well. Thus, p->running is set to true before multifd thread is
>> > > actually created.
>> > > 
>> > > p->running is used in multifd_save_cleanup() to decide whether to join
>> > > the multifd thread or not.
>> > > 
>> > > With TLS, an error in multifd_tls_channel_connect() can lead to a
>> > > segmentation fault because p->running is true but p->thread is never
>> > > initialized, so multifd_save_cleanup() tries to join an uninitialized
>> > > thread.
>> > > 
>> > > Fix it by moving p->running = true assignment right after multifd thread
>> > > creation. Also move qio_channel_set_delay() to there, as this is where
>> > > it used to be originally.
>> > > 
>> > > Fixes: 29647140157a ("migration/tls: add support for multifd tls-handshake")
>> > > Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> > Just for context, I haven't looked at this patch yet, but we were
>> > planning to remove p->running altogether:
>> > 
>> > https://lore.kernel.org/r/20231110200241.20679-1-farosas@suse.de
>> 
>> Thanks for putting me in the picture.
>> I see that there has been a discussion about the multifd creation/treadown
>> flow.
>> In light of this discussion, I can already see a few problems in my series
>> that I didn't notice before (such as the TLS handshake thread leak).
>> The thread you mentioned here and some of my patches point out some problems
>> in multifd creation/treardown. I guess we can discuss it and see what's the
>> best way to solve them.
>> 
>> Regarding this patch, your solution indeed solves the bug that this patch
>> addresses, so maybe this could be dropped (or only noted in your patch).
>> 
>> Maybe I should also put you (and Peter) in context for this whole series --
>> I am writing it as preparation for adding a separate migration channel for
>> VFIO device migration, so VFIO devices could be migrated in parallel.
>> So this series tries to lay down some foundations to facilitate it.
>
> Avihai, is the throughput the only reason that VFIO would like to have a
> separate channel?
>
> I'm wondering if we can also use multifd threads to send vfio data at some
> point.  Now multifd indeed is closely bound to ram pages but maybe it'll
> change in the near future to take any load?

We're not far away from it IMO. We just need to gradually kick the pages
concept out of multifd.

Again, for context, I have played with this recently:

https://gitlab.com/farosas/qemu/-/commits/multifd-packet-cleanups?ref_type=heads

I'd be happy with any solution that turns that p->pages into something
opaque that multifd has no knowledge about.


