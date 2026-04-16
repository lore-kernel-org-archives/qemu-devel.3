Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BD2F8A160
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 12:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDLhh-0004ij-2f; Thu, 16 Apr 2026 08:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wDLha-0004eM-7K
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 08:20:11 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wDLhY-0005BW-7f
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 08:20:09 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1B6DB5BCFA;
 Thu, 16 Apr 2026 12:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776342003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EaUuFcR2IcdWo9pL/06FbovWY2y2zLnNz1jjK83GdUg=;
 b=N70j+XNWvF+GBDp5mrectjGptgRc4m0r9UcRkA5JDhgUrt6JLISa+S3W+SVEZGfBfqrip6
 kGpBiEmRBXs0lLbakwembJN45m2PaExMs+s1UPZB/Vb0D8WLFEoloHCQHe7768cwnc6/qZ
 M8czQFWuueM9AVSuHj8VD8zyJXQFeDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776342003;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EaUuFcR2IcdWo9pL/06FbovWY2y2zLnNz1jjK83GdUg=;
 b=bDD0lFNY8PnZiRLEAoRwyTqrkmeak//6f0VZtB+TKV76tSla0ugQFOqVqlqxeYhfVYKfPq
 99a+W678lPklcGBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776342002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EaUuFcR2IcdWo9pL/06FbovWY2y2zLnNz1jjK83GdUg=;
 b=oN6VDfbnDNUaLld/w/oyu/0yPiMhI5iZ+GMGfBsmNbN7vDnzL+mFl0lvPeLxdF3FFcql4V
 NeF5kM5BUKTiZQ14L1M9IjITNOGLjnYF8IBP6h6TxTLkLIDIFfT13d/WucGaXIfaCZVkrD
 i7WTBSkZ5Bi8GmTthUoQmh9X6C1q2oY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776342002;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EaUuFcR2IcdWo9pL/06FbovWY2y2zLnNz1jjK83GdUg=;
 b=nTtAWcOLsM52qkif6FQRlVH96EUK+y48vSg0ZvMSJ5hAUScngXSYmvTmmIkLJzJbi5S+6S
 yknEdYiwFym3yQAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAB52593A3;
 Thu, 16 Apr 2026 12:20:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RJE3HvHT4Gm+FAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 16 Apr 2026 12:20:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, "Maciej S.
 Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v1] migration: Use QAPI_CLONE_MEMBERS in
 migrate_params_test_apply
In-Reply-To: <CAFEAcA8dwXxFodsg6gk473aEWBXynFAwaohrMqY3ca5c4FxzMw@mail.gmail.com>
References: <20260414223718.23965-1-farosas@suse.de> <87zf34xp7k.fsf@suse.de>
 <CAFEAcA8dwXxFodsg6gk473aEWBXynFAwaohrMqY3ca5c4FxzMw@mail.gmail.com>
Date: Thu, 16 Apr 2026 09:19:51 -0300
Message-ID: <87wly7xfko.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 15 Apr 2026 at 15:39, Fabiano Rosas <farosas@suse.de> wrote:
>>
>> Fabiano Rosas <farosas@suse.de> writes:
>>
>> > Use QAPI_CLONE_MEMBERS instead of making an assignment. The QAPI
>> > method makes the handling of the TLS strings more intuitive because it
>> > clones them as well.
>> >
>> > This also fixes a segfault when a NULL TLS option is accessed as part
>> > of a validation check for another option (e.g. in the zero-copy +
>> > multifd compression case). Details follow:
>> >
>> > Currently, after copying s->parameters to the temporary
>> > MigrationParameters object before migrate_params_check(), the
>> > references in temporary object to the TLS options are dropped, either
>> > because:
>> >
>> > a) the user set a new option, in which case that's fine as
>> >    s->parameters still holds the reference to the old memory or,
>> >
>> > b) the user did not set a new option, in which case keeping the
>> >    references in the temporary object would later cause them to be
>> >    freed along with it, leading to double-free when s->parameters is
>> >    also freed later on.
>> >
>> > In this second case, it was overlooked that the TLS options can be
>> > accessed already during migrate_params_check() as part of validation
>> > of another option. Those pointers should not have been cleared.
>> >
>> > Using QAPI_CLONE_MEMBERS fixes the issue because the temporary object
>> > is not stealing a reference from s->parameters anymore.
>> >
>> > Fixes: aed97f0563 ("migration: Normalize tls arguments")
>> > Reported-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
>> > Link: https://lore.kernel.org/r/a65a1049-9f19-460a-8e27-a62bb30d2727@maciej.szmigiero.name
>> > Reviewed-by: Peter Xu <peterx@redhat.com>
>> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> > ---
>> > NOTE#1: For the release we could have a simpler fix just checking for
>> > NULL, but that would allow two unsupported configurations to be
>> > accepted: zero-copy with either multifd compression or TLS.
>> >
>>
>> Peter Xu just pointed out on IRC that it's actually only the zero-copy +
>> TLS configuration that will be allowed with the simpler fix. I think
>> it's best we go that route instead and hold this patch until after the
>> release.
>
> rc4 has already been tagged and I really don't want to put anything
> more into 11.0 unless it is a super high priority release-blocker
> kind of a bug. The fact that this is a fix for a commit that's
> been in git for pretty much the whole of the 11.0 cycle without anybody
> noticing earlier suggests it probably isn't that important ?
>
> If we want to put it in then the commit message needs to clearly
> state the severity (e.g. "everybody trying to use migration
> hits a segfault") that makes it release-critical.
>
> Otherwise we should put this into 11.1 and with the usual cc:stable
> so it is backported to the 11.0 stable series.
>

Makes sense.

@Peter Xu, do you agree with leaving this to stable? Given that
it needs multifd and zero-copy-send to be both set, I'd say it doesn't
have that large of a user base.

@Maciej, what's the impact for you?

