Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331CAD30011
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:48:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1oGp-00011e-SE; Fri, 18 Oct 2024 10:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1oGi-0000xM-Cs
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:47:59 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1oGg-0002zz-Bm
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:47:56 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5AD871FDD1;
 Fri, 18 Oct 2024 14:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729262872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cfJawMWtHNHWGuAm8VQboc7q8D5Y3uD9trHhGQzkhWo=;
 b=hvic55e0c38McCnUjWKAahIII+21as/NnUjCx7txtheBnkA4FVsjvbA9tbJrmUOCU6Qk2y
 UNWqzta5gmKhSAUy/wFmY8tWWeNkHPmgH/iX3XWYvQUY9ib9Jgl3tulhiIRHq9R/fb2T7A
 sxsj1B6uDUAFyh2wWJECrpEsKRknht8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729262872;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cfJawMWtHNHWGuAm8VQboc7q8D5Y3uD9trHhGQzkhWo=;
 b=Y9Sy0zzzNj89kZqliZIxOT6Xu37G25ZzKw09pF7Zn7/YvyJGr9baK67mHPaz3geLD+Eu2/
 5b0pKE4YXnAkDBDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729262871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cfJawMWtHNHWGuAm8VQboc7q8D5Y3uD9trHhGQzkhWo=;
 b=xactC+oksOuq+7KpSGHmFvcIjozzstYfS4uPG+aPMMtxevZXtapQpCBknahOsjP6uPI3gX
 z/iV2WXxGJyU7G7JA9hstxhWH4TWXePl187kX2fd4L7GvfkT/KNbB0k6Zcyi/d9Zgbp7G2
 Nwh+1uw00wtOdgClyq4FIcCy25uJUX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729262871;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cfJawMWtHNHWGuAm8VQboc7q8D5Y3uD9trHhGQzkhWo=;
 b=PymIHCUjD1mxbNr48CQLEhLdPQYQidZBIcJGG6q/K5aykYOJGH/ru/Qx0b1BT8eve2OhOD
 tPM5W3yVGFVf89Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8A8913433;
 Fri, 18 Oct 2024 14:47:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cl99JxZ1EmdSPQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 18 Oct 2024 14:47:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH 4/4] ci: Add check-migration-quick to the clang job
In-Reply-To: <ZxJu6vfFVP6lYym_@redhat.com>
References: <20241017143211.17771-1-farosas@suse.de>
 <20241017143211.17771-5-farosas@suse.de> <ZxEl4zYgHLoLeHCT@redhat.com>
 <87r08e3d74.fsf@suse.de> <ZxIj694WqXwwMRIY@redhat.com>
 <87y12l1pv7.fsf@suse.de> <ZxJu6vfFVP6lYym_@redhat.com>
Date: Fri, 18 Oct 2024 11:47:48 -0300
Message-ID: <87r08d1n8r.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Oct 18, 2024 at 10:51:08AM -0300, Fabiano Rosas wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Thu, Oct 17, 2024 at 01:29:35PM -0300, Fabiano Rosas wrote:
>> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> >>=20
>> >> > On Thu, Oct 17, 2024 at 11:32:11AM -0300, Fabiano Rosas wrote:
>> >> >> Recent changes to how we invoke the migration tests have
>> >> >> (intentionally) caused them to not be part of the check-qtest targ=
et
>> >> >> anymore. Add the check-migration-quick target so we don't lose
>> >> >> migration code testing in this job.
>> >> >
>> >> > But 'check-migration-quick' is only the subset of migration tests,
>> >> > 'check-migration' is all of the migration tests. So surely this is
>> >> > a massive regressions in covage in CI pipelines.
>> >>=20
>> >> I'm not sure it is. There are tests there already for all the major
>> >> parts of the code: precopy, postcopy, multifd, socket. Besides, we can
>> >> tweak migration-quick to cover spots where we think we're losing
>> >> coverage.
>> >
>> > Each of the tests in migration-test  were added for a good reason,
>> > generally to address testing gaps where we had functional regressions
>> > in the past. I don't think its a good idea to stop running such tests
>> > in CI as gating on new contributions. Any time we've had optional
>> > tests in QEMU, we've seen repeated regressions in the area in question.
>> >
>> >> Since our CI offers nothing in terms of reproducibility or
>> >> debuggability, I don't think it's productive to have an increasing
>> >> amount of tests running in CI if that means we'll be dealing with
>> >> timeouts and intermittent crashes constantly.
>> >
>> > Test reliability is a different thing. If a particular test is
>> > flaky, it needs to either be fixed or disabled.
>>=20
>> The problem is that in this community the idea of "fix" is: wait until
>> someone with the appropriate skill level and interest stumbles upon the
>> problem on their own and fix it in anger.
>>=20
>> For it to be a proper strategy, we'd need to create an issue in gitlab
>> referencing the bug, have a proper reproducer and encourage contributors
>> to work on the issue.
>
> It is policy that we should be creating issues in gitlab for any
> flaky tests. I wouldn't say we've been perfect at that, but we
> should be doing it, and that link ought to be linked in the code
> if we disable the test there.
>
>> - It was disabled in March 2023 and stood there *not testing anything*
>>   while a major refactoring of the test code was happening.
>>=20
>> - The test was fixed in June 2023, but not reenabled in fear of getting
>>   flak from the community for breaking CI again (or at least that's the
>>   feeling I got from talking to Juan).
>>=20
>> - mapped-ram (which relies entirely on multifd) started being worked on
>>   and I had to enable the test in my own branch to be able to test the
>>   code properly. While disabled, it caught several issues in mapped-ram.
>>=20
>> - In October 2023 the test is re-enabled an immediately exposes issues
>>   in the code.
>>=20
>> This is how I started working on the migration code. Maybe you can
>> appreciate why I don't feel confident about this fix or disable
>> strategy. It has eaten many hours of my work.
>
> The migration subsystem was definitely suffering from insufficient
> maintainer resources available historically, which is reflected
> in some of the testing problems we've had & largely how I ended
> up spending so much time on migration code too.
>
>> > Looking at its execution time right now, I'd say migration test
>> > is pretty good, considering the permutations we have to target.
>> >
>> > It gets a bad reputation because historically it has been as
>> > much as x20 slower than it is today, and has also struggled
>> > with reliability. The latter is a reflection of the complexity
>> > of migration and and IMHO actually justifies greater testing,
>> > as long as we put in time to address bugs.
>> >
>> > Also we've got one single test program, covering an entire
>> > subsystem in one go, rather than lots of short individual
>> > test programs, so migration unfairly gets blamed for being
>> > slow, when it simply covers alot of functionality in one
>> > program.
>>=20
>> And still you think it's not worth it having a separate target for
>> testing migration. FWIW, I also proposed splittling it into multiple
>> meson tests, which you also rejected. It would be so much easier to move
>> all of this into a separate target and let those who want nothing do to
>> with to just ignore it.
>
> In the qtests/meson.build, I see we register separate
> suites - a generic "qtest" suite, and a "qtest-$TARGET"
> suite. What's missing here is a suite for subsystem
> classification, which I guess is more or less what you
> proposed here for migration.
>
> How about (in addition to the idea of splitting migration-test
> into one part run for all targets, and one part run for just
> one target), we generalize this concept to work for any
> subsystem tagging
>
> qtest_subsystems =3D {
>   'migration-test': ['migration'],
>   'cdrom-test': ['block'],
>   'ahci-test': ['block'],
>   ....
> }

This is interesting because it would allow a test to be considered in
more than one subsystem. There are many tests that invoke migration
themselves.

>
>
> then when registering tests we could do
>
>    suites =3D ['qtest', 'qtest-' + target_base]
>    foreach subsys: qtest_subsystems.get(test, [])
>      suites +=3D ['qtest-' + subsys, 'qtest-' + target_base + '-' + subsy=
s]

Hopefully meson won't take this as a hint to construct a 1000 characters
long line when invoking the test.

>    endforeach
>
>    test(....
>          suite: suites)
>
> that would give us a way to run just the migration tests, or
> just the migration tests on x86_64, etc, likewise for other
> subsystems we want to tag, while still keeping 'make check-qtest'
> as the full coverage.
>
>> >> > Any tests in tree need to be exercised by CI as the minimum bar
>> >> > to prevent bit rot from merges.
>> >> >
>> >>=20
>> >> No disagreement here. But then I'm going to need advice on what to do
>> >> when other maintainers ask us to stop writing migration tests because
>> >> they take too long. I cannot send contributors away nor merge code
>> >> without tests.
>> >
>> > In general, I think it is unreasonable for other maintainers to
>> > tell us to stop adding test coverage for migration, and would
>> > push back against such a request.=20
>>=20
>> This might be a larger issue in QEMU. I also heard the same back in 2021
>> when doing ppc work: "don't add too many tests because the CI buckles
>> and people get mad". The same with adding too much logging really. We're
>> hostages to the gitlab CI unfortunately.
>
> Yep, we need more investment in our CI resources. There were some
> ideas discussed at KVM Forum that could help with this, which
> should be publicised soon.

Great. Looking forward to those.

>
>
>> > This feels like something that should be amenable to unit testing.
>> > Might need a little re-factoring of migration code to make it
>> > easier to run a subset of its logic in isolation, but that'd
>> > probably be a win anyway, as such work usually makes code cleaner.
>>=20
>> I'll invest some time in that. I've no idea how we do unit testing in
>> QEMU.
>
> Mostly starts with the standard glib test program setup, where by
> you create a tests/unit/test-<blah>.c file, with functions for
> each test case that you register with g_test_add, same as qtest.
>
> The key difference from qtest is that you then just directly
> link the test binary to the code to be tested, and call into
> it internal QEMU APIs directly. In this case, it would involve
> linking to the 'libmigration' meson static library object.

Thanks for the introduction. I'll pick some self-contained part of
migration and see how far we are from being able to write unit tests.

>
>
> With regards,
> Daniel

