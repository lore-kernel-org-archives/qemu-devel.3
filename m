Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136D6D3000C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1nNu-0003g5-D2; Fri, 18 Oct 2024 09:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1nNt-0003fw-6N
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:51:17 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1nNq-0003q1-T8
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:51:16 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AB6C121BAF;
 Fri, 18 Oct 2024 13:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729259471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hS91+OVFvr4FT63snZz4JzgEtYukhNGGAOt+MrzOKro=;
 b=Gdp34EAE0FvjNyRftUv9gT4TP0nju7XsTMl9jU432gTxQxJWdGb4YNFo70TOXfmWryb+NH
 IoiLcjlHh0MQRM60VO5QxoV2c631ZHPXIjC0WuIZVCiKoKbBMEZ5KWGYr/Rc7A3TUw07h/
 j0/tM5nZ7d+CnK5ccbsf3qi0AHu4hRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729259471;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hS91+OVFvr4FT63snZz4JzgEtYukhNGGAOt+MrzOKro=;
 b=Cn+0yUhUawxQv3QQwHIwAwnjT3/nAhaGiYbEh0nS0akn9FtQTWKfb0gEcF51dgJl/Qnx6f
 NOf37Qh21JZNv8DQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Gdp34EAE;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Cn+0yUhU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729259471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hS91+OVFvr4FT63snZz4JzgEtYukhNGGAOt+MrzOKro=;
 b=Gdp34EAE0FvjNyRftUv9gT4TP0nju7XsTMl9jU432gTxQxJWdGb4YNFo70TOXfmWryb+NH
 IoiLcjlHh0MQRM60VO5QxoV2c631ZHPXIjC0WuIZVCiKoKbBMEZ5KWGYr/Rc7A3TUw07h/
 j0/tM5nZ7d+CnK5ccbsf3qi0AHu4hRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729259471;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hS91+OVFvr4FT63snZz4JzgEtYukhNGGAOt+MrzOKro=;
 b=Cn+0yUhUawxQv3QQwHIwAwnjT3/nAhaGiYbEh0nS0akn9FtQTWKfb0gEcF51dgJl/Qnx6f
 NOf37Qh21JZNv8DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32A8E13680;
 Fri, 18 Oct 2024 13:51:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +u2LOs5nEmcMLAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 18 Oct 2024 13:51:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH 4/4] ci: Add check-migration-quick to the clang job
In-Reply-To: <ZxIj694WqXwwMRIY@redhat.com>
References: <20241017143211.17771-1-farosas@suse.de>
 <20241017143211.17771-5-farosas@suse.de> <ZxEl4zYgHLoLeHCT@redhat.com>
 <87r08e3d74.fsf@suse.de> <ZxIj694WqXwwMRIY@redhat.com>
Date: Fri, 18 Oct 2024 10:51:08 -0300
Message-ID: <87y12l1pv7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AB6C121BAF
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

> On Thu, Oct 17, 2024 at 01:29:35PM -0300, Fabiano Rosas wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Thu, Oct 17, 2024 at 11:32:11AM -0300, Fabiano Rosas wrote:
>> >> Recent changes to how we invoke the migration tests have
>> >> (intentionally) caused them to not be part of the check-qtest target
>> >> anymore. Add the check-migration-quick target so we don't lose
>> >> migration code testing in this job.
>> >
>> > But 'check-migration-quick' is only the subset of migration tests,
>> > 'check-migration' is all of the migration tests. So surely this is
>> > a massive regressions in covage in CI pipelines.
>>=20
>> I'm not sure it is. There are tests there already for all the major
>> parts of the code: precopy, postcopy, multifd, socket. Besides, we can
>> tweak migration-quick to cover spots where we think we're losing
>> coverage.
>
> Each of the tests in migration-test  were added for a good reason,
> generally to address testing gaps where we had functional regressions
> in the past. I don't think its a good idea to stop running such tests
> in CI as gating on new contributions. Any time we've had optional
> tests in QEMU, we've seen repeated regressions in the area in question.
>
>> Since our CI offers nothing in terms of reproducibility or
>> debuggability, I don't think it's productive to have an increasing
>> amount of tests running in CI if that means we'll be dealing with
>> timeouts and intermittent crashes constantly.
>
> Test reliability is a different thing. If a particular test is
> flaky, it needs to either be fixed or disabled.

The problem is that in this community the idea of "fix" is: wait until
someone with the appropriate skill level and interest stumbles upon the
problem on their own and fix it in anger.

For it to be a proper strategy, we'd need to create an issue in gitlab
referencing the bug, have a proper reproducer and encourage contributors
to work on the issue.

Iff the above was in place, then we could disable the test. Otherwise
the test just sits there disabled. In the past there were even tests
committed that *never* ran.

The situation with multifd/cancel alone is absurd:

- It was disabled in March 2023 and stood there *not testing anything*
  while a major refactoring of the test code was happening.

- The test was fixed in June 2023, but not reenabled in fear of getting
  flak from the community for breaking CI again (or at least that's the
  feeling I got from talking to Juan).

- mapped-ram (which relies entirely on multifd) started being worked on
  and I had to enable the test in my own branch to be able to test the
  code properly. While disabled, it caught several issues in mapped-ram.

- In October 2023 the test is re-enabled an immediately exposes issues
  in the code.

This is how I started working on the migration code. Maybe you can
appreciate why I don't feel confident about this fix or disable
strategy. It has eaten many hours of my work.

> Splitting into
> a fast & slow grouping doesn't address reliability, just hides
> the problem from view.

Right, and is that not the same as FLAKY? What good is keeping a test in
view if the only people that can fix it are the ones that would be
seeing the breakage constantly in their own branches anyway?

>
>> > Experience shows us that relying on humans to run tests periodically
>> > doesn't work well, and they'll slowly bit rot. Migration maintainers
>> > don't have a way to run this as gating test for every pull request
>> > that merges, and pull requests coming from non-migration maintainers
>> > can still break migration code.
>>=20
>> Right, but migration code would still be tested with migration-quick
>> which is executed at every make check. Do we really need the full set in
>> every pull request? We must draw a line somewhere, otherwise make check
>> will just balloon in duration.
>
> Again, the tests all exist because migration code is incredibly
> complicated, with a lot of permutations, with a history of being
> very bug / regression prone. With that in mind, it is unavoidable
> that we're going to have a significant testing overhead for
> migration code.

Yep, we should be testing way more actually.

>
> Looking at its execution time right now, I'd say migration test
> is pretty good, considering the permutations we have to target.
>
> It gets a bad reputation because historically it has been as
> much as x20 slower than it is today, and has also struggled
> with reliability. The latter is a reflection of the complexity
> of migration and and IMHO actually justifies greater testing,
> as long as we put in time to address bugs.
>
> Also we've got one single test program, covering an entire
> subsystem in one go, rather than lots of short individual
> test programs, so migration unfairly gets blamed for being
> slow, when it simply covers alot of functionality in one
> program.

And still you think it's not worth it having a separate target for
testing migration. FWIW, I also proposed splittling it into multiple
meson tests, which you also rejected. It would be so much easier to move
all of this into a separate target and let those who want nothing do to
with to just ignore it.

>
>> > Any tests in tree need to be exercised by CI as the minimum bar
>> > to prevent bit rot from merges.
>> >
>>=20
>> No disagreement here. But then I'm going to need advice on what to do
>> when other maintainers ask us to stop writing migration tests because
>> they take too long. I cannot send contributors away nor merge code
>> without tests.
>
> In general, I think it is unreasonable for other maintainers to
> tell us to stop adding test coverage for migration, and would
> push back against such a request.=20

This might be a larger issue in QEMU. I also heard the same back in 2021
when doing ppc work: "don't add too many tests because the CI buckles
and people get mad". The same with adding too much logging really. We're
hostages to the gitlab CI unfortunately.

>
> We should, however, continue to optimize how we add further test
> coverage, where practical, overload testing of multiple features
> onto a single test case helps.
>
> We've already massively optimized the migration-test compared to
> its historical behaviour.
>
> A potentially bigger win could be seen if we change how we exercise
> the migration functionality. Since we had the migration qtest that
> runs a full migration operation, we've tended to expand testing by
> adding new qtest functions. ie we've added a functional test for
> everything we want covered. This is nice & simple, but also expensive.
> We've ignored unit testing, which I think is a mistake.
>
> If i look at the test list:
>
> # /x86_64/migration/bad_dest
> # /x86_64/migration/analyze-script
> # /x86_64/migration/validate_uuid
> # /x86_64/migration/validate_uuid_error
> # /x86_64/migration/validate_uuid_src_not_set
> # /x86_64/migration/validate_uuid_dst_not_set
> # /x86_64/migration/dirty_ring
> # /x86_64/migration/precopy/file
> # /x86_64/migration/precopy/unix/plain
> # /x86_64/migration/precopy/unix/suspend/live
> # /x86_64/migration/precopy/unix/suspend/notlive
> # /x86_64/migration/precopy/unix/tls/psk
> # /x86_64/migration/precopy/unix/tls/x509/default-host
> # /x86_64/migration/precopy/unix/tls/x509/override-host
> # /x86_64/migration/precopy/file/offset
> # /x86_64/migration/precopy/file/mapped-ram
> # /x86_64/migration/precopy/file/offset/fdset
> # /x86_64/migration/precopy/file/offset/bad
> # /x86_64/migration/precopy/file/mapped-ram/live
> # /x86_64/migration/precopy/tcp/plain
> # /x86_64/migration/precopy/tcp/plain/switchover-ack
> # /x86_64/migration/precopy/tcp/tls/psk/match
> # /x86_64/migration/precopy/tcp/tls/psk/mismatch
> # /x86_64/migration/precopy/tcp/tls/x509/default-host
> # /x86_64/migration/precopy/tcp/tls/x509/override-host
> # /x86_64/migration/precopy/tcp/tls/x509/mismatch-host
> # /x86_64/migration/precopy/tcp/tls/x509/friendly-client
> # /x86_64/migration/precopy/tcp/tls/x509/hostile-client
> # /x86_64/migration/precopy/tcp/tls/x509/allow-anon-client
> # /x86_64/migration/precopy/tcp/tls/x509/reject-anon-client
> # /x86_64/migration/precopy/fd/tcp
> # /x86_64/migration/precopy/fd/file
> # /x86_64/migration/multifd/file/mapped-ram
> # /x86_64/migration/multifd/file/mapped-ram/live
> # /x86_64/migration/multifd/file/mapped-ram/dio
> # /x86_64/migration/multifd/file/mapped-ram/fdset
> # /x86_64/migration/multifd/file/mapped-ram/fdset/dio
> # /x86_64/migration/multifd/tcp/uri/plain/none
> # /x86_64/migration/multifd/tcp/channels/plain/none
> # /x86_64/migration/multifd/tcp/plain/cancel
> # /x86_64/migration/multifd/tcp/plain/zlib
> # /x86_64/migration/multifd/tcp/plain/zstd
> # /x86_64/migration/multifd/tcp/plain/zero-page/legacy
> # /x86_64/migration/multifd/tcp/plain/zero-page/none
> # /x86_64/migration/multifd/tcp/tls/psk/match
> # /x86_64/migration/multifd/tcp/tls/psk/mismatch
> # /x86_64/migration/multifd/tcp/tls/x509/default-host
> # /x86_64/migration/multifd/tcp/tls/x509/override-host
> # /x86_64/migration/multifd/tcp/tls/x509/mismatch-host
> # /x86_64/migration/multifd/tcp/tls/x509/allow-anon-client
> # /x86_64/migration/multifd/tcp/tls/x509/reject-anon-client
> # /x86_64/migration/validate_uri/channels/both_set
> # /x86_64/migration/validate_uri/channels/none_set
>
> Individually none of those is very slow on its own - 10 are in
> the 2-3 second range,  35 are 1-2 secs,  and 6 are less than
> 1 second.
>
> A very large portion of those are validating different ways to
> establish migration. Hardly any of them actually need to run
> a migration to completion. Even without running to completion
> though, we have the overheads of spawning 2 QEMUs.
>
> This feels like something that should be amenable to unit testing.
> Might need a little re-factoring of migration code to make it
> easier to run a subset of its logic in isolation, but that'd
> probably be a win anyway, as such work usually makes code cleaner.

I'll invest some time in that. I've no idea how we do unit testing in
QEMU.

>
>> Do we need nightly CI runs? Unit tests? Bear in mind there's a resource
>> allocation issue there. Addressing problems with timeouts/races in our
>> CI is not something any random person can do.
>
> In terms of running time, I think migration-test is acceptable as it is
> to run in 'make check' by default and doesn't justify dropping test
> coverage. We should still look to optimize & move to unit testing more
> code, and any reliability issues are something that needs to be addressed
> too.
>
> With regards,
> Daniel

