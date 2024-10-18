Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB82D3000A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1nNr-0003fb-L7; Fri, 18 Oct 2024 09:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1nNq-0003fN-Dk
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:51:14 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1nNo-0003pn-8K
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:51:14 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DD5AD21BAC;
 Fri, 18 Oct 2024 13:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729259467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcwS89eTgtSFqEzZCizHlepTRkpI+Hwf7yXt4T6jDKk=;
 b=gK0lv3dlDeKyH0GWId+6oK/y/+82Hx10rHUQ4qaTs6UMevDSeiI0Vew2+qFB+srHwMlOdB
 m51/3b3wyqg1AOLxbb5N31rrz7EQ1gKUnj7+YF5IOZK66C/LVcalv2zUQlTROt2xn7CrQS
 nxZ6yZm9MK+N3YVdSqj9B1zoRRxEOYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729259467;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcwS89eTgtSFqEzZCizHlepTRkpI+Hwf7yXt4T6jDKk=;
 b=9BUMZa6LsfmvS1zuOgK2pG+XV7DJSTF9o7l6Y7Fq7duIGn07ry8eQVkTX8FUbDdIw0osB0
 aaSKOEa5xcJrm1CQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hgrvYtpu;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=N2iZ5wDu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729259466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcwS89eTgtSFqEzZCizHlepTRkpI+Hwf7yXt4T6jDKk=;
 b=hgrvYtpupsGbCUdy+wsbFy7HRd3veiFgyKH+GvsE7wSxsatzu1O9H5HBYyAzNJByv9dq02
 1f6ziEnSnYezVumZ9p79i9CdBNu3InYtShGOiws4uWOymP8wvLDq0bo+y+naz0VgynzI7s
 MV/l8YUifQrftl8Pk5gCUDu4sekU2D8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729259466;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcwS89eTgtSFqEzZCizHlepTRkpI+Hwf7yXt4T6jDKk=;
 b=N2iZ5wDuDJ2EOaeHj95pX7YNWYlTxJLsRZvkkoYQytYZdud+RaeIpEubD+nmy81iN2s3K/
 Su7TAI/gw7d0/5DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 676FE13680;
 Fri, 18 Oct 2024 13:51:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AyXKC8pnEmcFLAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 18 Oct 2024 13:51:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Alex =?utf-8?Q?Be?=
 =?utf-8?Q?nn=C3=A9e?=
 <alex.bennee@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Wainer dos Santos Moschetta
 <wainersm@redhat.com>
Subject: Re: [PATCH 4/4] ci: Add check-migration-quick to the clang job
In-Reply-To: <ZxIxsw265Au7fI-x@redhat.com>
References: <20241017143211.17771-1-farosas@suse.de>
 <20241017143211.17771-5-farosas@suse.de> <ZxEl4zYgHLoLeHCT@redhat.com>
 <87r08e3d74.fsf@suse.de> <ZxIj694WqXwwMRIY@redhat.com>
 <CAFEAcA8XCBrbqGDesL+5su-2Bk_YR1iQ6_X_j9tJZmNK1Kw=pQ@mail.gmail.com>
 <ZxIxsw265Au7fI-x@redhat.com>
Date: Fri, 18 Oct 2024 10:51:03 -0300
Message-ID: <87zfn11pvc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: DD5AD21BAC
X-Rspamd-Action: no action
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Oct 18, 2024 at 10:46:55AM +0100, Peter Maydell wrote:
>> On Fri, 18 Oct 2024 at 10:01, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
>> >
>> > On Thu, Oct 17, 2024 at 01:29:35PM -0300, Fabiano Rosas wrote:
>> > > Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> > >
>> > > > On Thu, Oct 17, 2024 at 11:32:11AM -0300, Fabiano Rosas wrote:
>> > > >> Recent changes to how we invoke the migration tests have
>> > > >> (intentionally) caused them to not be part of the check-qtest tar=
get
>> > > >> anymore. Add the check-migration-quick target so we don't lose
>> > > >> migration code testing in this job.
>> > > >
>> > > > But 'check-migration-quick' is only the subset of migration tests,
>> > > > 'check-migration' is all of the migration tests. So surely this is
>> > > > a massive regressions in covage in CI pipelines.
>> > >
>> > > I'm not sure it is. There are tests there already for all the major
>> > > parts of the code: precopy, postcopy, multifd, socket. Besides, we c=
an
>> > > tweak migration-quick to cover spots where we think we're losing
>> > > coverage.
>> >
>> > Each of the tests in migration-test  were added for a good reason,
>> > generally to address testing gaps where we had functional regressions
>> > in the past. I don't think its a good idea to stop running such tests
>> > in CI as gating on new contributions. Any time we've had optional
>> > tests in QEMU, we've seen repeated regressions in the area in question.
>> >
>> > > Since our CI offers nothing in terms of reproducibility or
>> > > debuggability, I don't think it's productive to have an increasing
>> > > amount of tests running in CI if that means we'll be dealing with
>> > > timeouts and intermittent crashes constantly.
>> >
>> > Test reliability is a different thing. If a particular test is
>> > flaky, it needs to either be fixed or disabled. Splitting into
>> > a fast & slow grouping doesn't address reliability, just hides
>> > the problem from view.
>>=20
>> A lot of the current reliability issue is timeouts -- sometimes
>> our CI runners just run really slow (I have seen an example where
>> between a normal and a slow run on the same commit both the
>> compile and test times were 10x different...) So any test
>> that is not a fast-to-complete is much much more likely to
>> hit its timeout if the runner is running slowly. When I am
>> doing CI testing for merges "migration test timed out again"
>> is really really common.
>
> If its frequently timing out, then we've got the timeouts
> wrong, or we have some genuine bugs in there to be fixed.
>
>> > > No disagreement here. But then I'm going to need advice on what to do
>> > > when other maintainers ask us to stop writing migration tests because
>> > > they take too long. I cannot send contributors away nor merge code
>> > > without tests.
>> >
>> > In general, I think it is unreasonable for other maintainers to
>> > tell us to stop adding test coverage for migration, and would
>> > push back against such a request.
>>=20
>> We do not have infinite CI resources, unfortunately. Migration
>> is competing with everything else for time on CI. You have to
>> find a balance between "what do we run every time" and "what
>> do we only run when specifically testing a migration pullreq".
>> Similarly, there's a lot of iotests but we don't run all of them
>> for every block backend for every CI job via "make check".
>
> The combos we don't run for iotests are a good source of
> regressions too :-(
>
>> Long test times for tests run under "make check" are also bad
>> for individual developers -- if I'm running "make check" to
>> test a target/arm change I've made I don't really want that
>> to then spend 15 minutes testing the migration code that
>> I haven't touched and that is vanishingly unlikely to be
>> affected by my patches.
>
> Migration-test *used* to take 15 minutes to run, but that was a
> very long time ago. A run of it today is around 1m20.
>
> That said, if you are building multiple system emulators, we
> run the same test multiple times, and with the number of
> targets we have, that will be painful.
>
> That could be a good reason to split the migration-test into
> two distinct programs. One program that runs for every target,
> and one that is only run once, for some arbitrary "primary"
> target ?

What do you mean by distinct programs? It's not the migration-test that
decides on which targets it runs, it's meson.build. We register a test()
for each target, same as with any other qtest. Maybe I misunderstood
you...

>  Or could we make use of glib's g_test_thorough
> for this - a primary target runs with "SPEED=3Dthrough" and
> all other targets with normal settings. That would give us
> a way to optimize any of the qtests to reduce redundant
> testing where appropriate.

This still requires a new make target I think. Otherwise we'd run *all*
thorough tests for a QEMU target and not only migration-test in thorough
mode.

>
>
> If we move alot of testing out into a migration unit test,
> this also solves the redundancy problem.
>
>
> With regards,
> Daniel

