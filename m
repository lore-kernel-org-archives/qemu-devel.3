Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C46D6ACC3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 12:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGH1h-0000Sx-3l; Wed, 27 Nov 2024 07:20:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tGH1P-0000KY-Vb
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:19:56 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tGH1N-00011E-QP
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:19:55 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 854562117E;
 Wed, 27 Nov 2024 12:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732709991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U/rw313yVv3v6gnrQ2e+fqXREyacFflUrzbnxq9/68s=;
 b=bWCUiWo88G/n8WXPPZDroyRdVnarD57WFxlvjZXpd9uosM3i8ZQyUSmOkg2ufWIeuwk3QN
 5fXT9b8HxONZQocrVRUn2SqtNEc+XaNDUtixlo5E6FPBTECbopLV0SXlyCP5fxv47bXKTS
 4n+khjZqcCk00aI+pExCx9RhKs1Rsds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732709991;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U/rw313yVv3v6gnrQ2e+fqXREyacFflUrzbnxq9/68s=;
 b=gBj/WwKvm53aYH2jWkalgra4KXvuyRyXPToqmshLu0t7dyNnMXBhoDRtTDVuOHGWqEtE1z
 wFPtzpOsiECMr+DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732709991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U/rw313yVv3v6gnrQ2e+fqXREyacFflUrzbnxq9/68s=;
 b=bWCUiWo88G/n8WXPPZDroyRdVnarD57WFxlvjZXpd9uosM3i8ZQyUSmOkg2ufWIeuwk3QN
 5fXT9b8HxONZQocrVRUn2SqtNEc+XaNDUtixlo5E6FPBTECbopLV0SXlyCP5fxv47bXKTS
 4n+khjZqcCk00aI+pExCx9RhKs1Rsds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732709991;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U/rw313yVv3v6gnrQ2e+fqXREyacFflUrzbnxq9/68s=;
 b=gBj/WwKvm53aYH2jWkalgra4KXvuyRyXPToqmshLu0t7dyNnMXBhoDRtTDVuOHGWqEtE1z
 wFPtzpOsiECMr+DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F7D4139AA;
 Wed, 27 Nov 2024 12:19:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uJ6tMWYOR2cdbwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 27 Nov 2024 12:19:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, Prasad
 Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v1 3/4] migration: refactor ram_save_target_page functions
In-Reply-To: <CAE8KmOwfzFyBWfq_Vhr-hjT4jGQQqi6_gZwkNGtd8SVLxhi0QQ@mail.gmail.com>
References: <20241126115748.118683-1-ppandit@redhat.com>
 <20241126115748.118683-4-ppandit@redhat.com> <87ed2xn16y.fsf@suse.de>
 <CAE8KmOwfzFyBWfq_Vhr-hjT4jGQQqi6_gZwkNGtd8SVLxhi0QQ@mail.gmail.com>
Date: Wed, 27 Nov 2024 09:19:48 -0300
Message-ID: <878qt4na1n.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Prasad Pandit <ppandit@redhat.com> writes:

> On Wed, 27 Nov 2024 at 02:49, Fabiano Rosas <farosas@suse.de> wrote:
>> This patch should be just the actual refactoring on top of master, with
>> no mention to postcopy at all.
>
> * Okay. We'll have to ensure that it is merged before multifd+postcopy change.

That's ok, just put it at the start of the series.

>
>> > +            if (migrate_multifd() && !migration_in_postcopy()
>> > +                && (!migrate_multifd_flush_after_each_section()
>> > +                    || migrate_mapped_ram())) {
>>
>> This is getting out of hand. We can't keep growing this condition every
>> time something new comes up. Any ideas?
>
> * In 'v0' this series, !migration_in_postcopy() was added to
> migrate_multifd(), which worked, but was not okay.
>
> * Another could be to define a new helper/macro to include above 3-4
> checks. Because migrate_multifd(),
> migrate_multifd_flush_after_each_section() and migrate_mapped_ram()
> appear together at multiple points. But strangely the equation is not
> the same. Sometimes migrate_mapped_ram() is 'true' and sometimes it is
> 'false', so a combined helper may not work.  It is all to accommodate
> different workings of multifd IIUC, if it and precopy used the same
> protocol/stream, maybe such conditionals would go away automatically.
>
>> Yes, although I wonder if we should keep documenting this when we only
>> call this function for a single page and it always returns at most 1.
>> >          if (page_dirty) {
>> >              /* Be strict to return code; it must be 1, or what else? */
>>
>> ... this^ comment, for instance.
>>
>
> * Okay, can remove them.
>
> So to confirm: this refactoring patch should be a separate one by
> itself? And then in the following multifd+postcopy series we just add
> !migration_in_postcopy() check to it?

It doesn't need to be a single patch submission, it could be a patch at
the start of this series. It's just that it needs to logically do only
one thing, which is to move the code around without adding new bits that
don't exist in current master (a strict definition of refactoring). The
multifd+postcopy changes come in a subsequent patch so it's clear that
one patch was just shuffling code around while the rest is part of the
feature enablement.

>
> Thank you.
> ---
>   - Prasad

