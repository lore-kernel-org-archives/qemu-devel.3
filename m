Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0FECD8CA4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 20:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWgAu-0006ME-Jm; Mon, 08 Jun 2026 16:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wWgAq-0006Ln-VC
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 16:02:16 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wWgAo-0001KZ-Sk
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 16:02:16 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0CC726AA22;
 Mon,  8 Jun 2026 20:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780948928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q/K7SdJx5PLBpotlvecwQBT02XXiyNjW87OlaLttjyY=;
 b=yfiIK7ZlkzBZgz9iKYUz/8hpWOwSLUTBKIlro9thP3M5jvwETH9j8ohKkk7rLO+Cl6VnOq
 9r3yejEUEtqxSLjZuMOWOxRfP/tz1HHGYEH8tXzb5G2MNnvhWi82+TXOfuzvKcwrZqUyxk
 SrvUrYrCbtocfsUzI1VSw92qc6nSc3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780948928;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q/K7SdJx5PLBpotlvecwQBT02XXiyNjW87OlaLttjyY=;
 b=tYTvL2UHGBvLJFnxE8DiUcfNLlZHFPeCdedyJ2WTy1RmCDRcyDoKeRmo/RDsUpNEmC0foU
 u92wxHl5xYlzwRAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yfiIK7Zl;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tYTvL2UH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780948928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q/K7SdJx5PLBpotlvecwQBT02XXiyNjW87OlaLttjyY=;
 b=yfiIK7ZlkzBZgz9iKYUz/8hpWOwSLUTBKIlro9thP3M5jvwETH9j8ohKkk7rLO+Cl6VnOq
 9r3yejEUEtqxSLjZuMOWOxRfP/tz1HHGYEH8tXzb5G2MNnvhWi82+TXOfuzvKcwrZqUyxk
 SrvUrYrCbtocfsUzI1VSw92qc6nSc3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780948928;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q/K7SdJx5PLBpotlvecwQBT02XXiyNjW87OlaLttjyY=;
 b=tYTvL2UHGBvLJFnxE8DiUcfNLlZHFPeCdedyJ2WTy1RmCDRcyDoKeRmo/RDsUpNEmC0foU
 u92wxHl5xYlzwRAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E48D779A7;
 Mon,  8 Jun 2026 20:02:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id o1PuG78fJ2rjCgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 08 Jun 2026 20:02:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Subject: Re: artifact download for qtest
In-Reply-To: <aicYc6GGapIJTKdi@redhat.com>
References: <CAK3XEhMNqHbkL2P6Xg3_hJ8WAxhPQgurjvuZg-vXUDZ5=x-RRA@mail.gmail.com>
 <f2516211-6fbc-4714-b674-4276464f94ff@redhat.com> <87v7bs6e2p.fsf@suse.de>
 <aicYc6GGapIJTKdi@redhat.com>
Date: Mon, 08 Jun 2026 17:02:01 -0300
Message-ID: <87se6w6bt2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0CC726AA22
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Jun 08, 2026 at 04:13:02PM -0300, Fabiano Rosas wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>=20
>> > On 30/05/2026 16.56, Ani Sinha wrote:
>> >> Hi,
>> >>=20
>> >> I am trying to write a qtest for which I need an IGVM file. I have the
>> >> file, about 54 MiB in size.
>> >
>> > 54 MiB is quite big, I agree that we likely don't want to check that i=
nto=20
>> > the main repository, especially if it is for a test only...
>> > (BTW, what's its compressed size?)
>> >
>> >> Instead of committing this IGVM binary
>> >> file with the test, I wanted to check if I can put it somewhere, say
>> >> in a gitlab repo and then make the test download it. This would be
>> >> similar to asset downloads for functional tests. No this test cannot
>> >> be a python functional test.  I am wondering if anyone has faced this
>> >> situation before and what the best way to solve this problem is.
>> >
>> > I'm not maintaining the qtests anymore, but I assume that there is no=
=20
>> > interest in duplicating all the asset downloading logic there.
>> >
>>=20
>> It would be nice if we could extract the existing code into a little
>> asset library that could be invoked from the other test frameworks.
>
> IMHO that isn't really practical, all the asset handling is in python.
> It'd be mad to re-implement that in C and then call it from python,
> and the C isn't really going to call the current python either....
>

What about a standalone downloader? I'm still thinking about reusing
more of the common operations between test frameworks. Is it feasible to
have a cmdline app that can be invoked by qtest and place artifacts in a
common place?

>> > What's the exact reason why you cannot do it as a functional test inst=
ead?=20
>> > You could maybe also start the qemu binary there with "-accel qtest -q=
test=20
>> > ..." to fake a qtest environment - a little bit cumbersome, but certai=
nly=20
>> > doable, I think.
>
> ..if we didn't have the historical baggage already, then I'd that
> qtests should conceptually just be a subset of the functional
> tests. Writing them in python would be nicer than doing them in C.
>

But could we make _working_ with them in python be equivalent to C? I
agree it's nice to write tests in a higher level language, but python
specifically is a big pain when it comes to actually finding out why a
test is failing. And debugging is even worse.

The tradeoff is that unittest is clearly superior to glib as a test
runner. Having a more modern way of generating command-lines would be
nice too.

> The qtest service is integrated in QEMU, what's missing is
>
>  * the client side to talk the qtest protocol

python/qemu/machine/qtest.py?

>  * the various bus specific helper APIs
>
> I don't know how hard it would be to bootstrap the client side in
> python, but the general qtest protocol is 2000 lines of C, so
> probably more like 500 lines of python to replace it, plus whatever
> helpers you might want on top. Probably not terribly much work to
> get something useful kickstarted.
>
> NB, I am *not* sugggesting re-writing the actual existing tests,
> just make it possible to write new qtests in python.
>
> With regards,
> Daniel

