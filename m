Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DE1EED606
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 13:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sokC1-0004HC-Nh; Thu, 12 Sep 2024 09:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sokC0-0004GG-9I
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 09:49:04 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sokBy-0000zA-Ga
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 09:49:04 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DC5501FB78;
 Thu, 12 Sep 2024 13:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726148937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2xJsPU/MG/k9xXSl1mg6tECZuhFCti1dFLgXJGY5QKA=;
 b=p9HeZd5uawb6T9qR+4jNcme9p1pBKnDJhQzzckGhRmA9zt0gtttJbHd2g77p5iMxL/4WX6
 1X8t1J3rnJScsrHComXcY1gqymqG/EazO/qElTroO2wfhg0kt4qjKuTEIMnBd/T3wavEz4
 BMdY+RaDBJBOu05CzqDexP0MPMv50bM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726148937;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2xJsPU/MG/k9xXSl1mg6tECZuhFCti1dFLgXJGY5QKA=;
 b=Wu1QHPjrRYEO1Pi0xa81E5zlUDxB1c7D3Koyemf12Zxp0Kzvs4Iaj5rascZM17ouRdfHAF
 0jSpbCvtrSTlHrDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726148936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2xJsPU/MG/k9xXSl1mg6tECZuhFCti1dFLgXJGY5QKA=;
 b=DuWxP424NbKnOsvNF1IM9Jcx8jr/M16pqNCmeVGxIfRmcUmDFxpeUVseIvEmvLHTtlGYzg
 y8gCe42csenvUvoYc6hBS5njd/QuHBoUIL4AHV34QwcdEzkCjuY/lkeNfsviP2kqz7+hBe
 4t1ZeoSVrK2+C9YM8uNwnp3E6KW7dpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726148936;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2xJsPU/MG/k9xXSl1mg6tECZuhFCti1dFLgXJGY5QKA=;
 b=5KsH5/6E+itz2CVWNMdyHYIoYqsWnSAVa2+6ZTtAuJykN49B3e4zf8HgqiLrQobbaqCS1q
 gWntnur4iFaLAaBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54C8013A73;
 Thu, 12 Sep 2024 13:48:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QXQAB0jx4mYNdgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 12 Sep 2024 13:48:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Xu <peterx@redhat.com>, Hyman Huang <yong.huang@smartx.com>,
 qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, David Hildenbrand <david@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH RFC 10/10] tests/migration-tests: Add test case for
 responsive CPU throttle
In-Reply-To: <CAFEAcA9YkZiSSOAj0zH2OwF9AcziJT-zpnNVQn8BXizhSXHVOA@mail.gmail.com>
References: <cover.1725889277.git.yong.huang@smartx.com>
 <96eeea4efd3417212d6e2639bc118b90d4dcf926.1725889277.git.yong.huang@smartx.com>
 <CAFEAcA99=bn4x_BjgsAsrVitXNxOUSNviz=TGezJEB+=Zj603w@mail.gmail.com>
 <Zt8H6pC2yQ2DD7DV@x1n> <87frq8lcgp.fsf@suse.de> <ZuC4pYT-atQwWePv@x1n>
 <87seu7qhao.fsf@suse.de> <ZuG-SijLg8Q27boE@x1n> <87ed5qq8e2.fsf@suse.de>
 <ZuH_pvnTCumKuXTh@x1n> <87bk0trifq.fsf@suse.de>
 <CAFEAcA9YkZiSSOAj0zH2OwF9AcziJT-zpnNVQn8BXizhSXHVOA@mail.gmail.com>
Date: Thu, 12 Sep 2024 10:48:53 -0300
Message-ID: <87wmjhvv7e.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[9];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:mid,suse.de:email]
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 11 Sept 2024 at 22:26, Fabiano Rosas <farosas@suse.de> wrote:
>> I don't think we're discussing total CI time at this point, so the math
>> doesn't really add up. We're not looking into making the CI finish
>> faster. We're looking into making migration-test finish faster. That
>> would reduce timeouts in CI, speed-up make check and reduce the chance
>> of random race conditions* affecting other people/staging runs.
>
> Right. The reason migration-test appears on my radar is because
> it is very frequently the thing that shows up as "this sometimes
> just fails or just times out and if you hit retry it goes away
> again". That might not be migration-test's fault specifically,
> because those retries tend to be certain CI configs (s390,
> the i686-tci one), and I have some theories about what might be
> causing it (e.g. build system runs 4 migration-tests in parallel,
> which means 8 QEMU processes which is too many for the number
> of host CPUs). But right now I look at CI job failures and my reaction
> is "oh, it's the migration-test failing yet again" :-(

And then I go: "oh, people complaining about migration-test again, I
thought we had fixed all the issues this time". It's frustrating for
everyone, as I said previously.

>
> For some examples from this week:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/7802183144
> https://gitlab.com/qemu-project/qemu/-/jobs/7799842373
> https://gitlab.com/qemu-project/qemu/-/jobs/7786579152
> https://gitlab.com/qemu-project/qemu/-/jobs/7786579155

About these:

There are 2 instances of plain-old-SIGSEGV here. Both happen in
non-x86_64 runs and on the /multifd/tcp/plain/cancel test, which means
they're either races or memory ordering issues. Having i386 crashing
points to the former. So having the CI loaded and causing timeouts is
probably what exposed the issue.

The thread is mig/dst/recv_7 and grepping the objdump output shows:
<set_bit_atomic> 55 48 89 e5 48 89 7d e8 48 89 75 e0 48 8b 45 e8 83 e0
3f ba 01 00 00 00 89 c1 48 d3 e2 48 89 d0 48 89 45 f0 48 8b 45 e8 48 c1
e8 06 48 8d 14 c5 00 00 00 00 48 8b 45 e0 48 01 d0 48 89 45 f8 48 8b 45
f8 48 8b 55 f0 <f0> 48 09 10 90 5d c3

I tried a bisect overnight, but it seems the issue has been there since
before 9.0. I'll try to repro with gdb attached or get a core dump.

