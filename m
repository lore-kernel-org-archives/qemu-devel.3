Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34D9E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOg2j-0003E6-Ix; Fri, 20 Dec 2024 11:40:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tOg2g-0003Dc-KF
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:39:59 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tOg2c-0005F6-RB
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:39:58 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C7F2A21249;
 Fri, 20 Dec 2024 16:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734712791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EUB+pd09qzDOIutJbZDNlr+yiSsv3gQCHVNUcDNNGbU=;
 b=l8/hZcBapuCpu5nrDgW2V0KWxb0laInPTbYn4ZOT1yCqufPBiHJgMnTTvQtAlVi832gSsl
 tl4mS+IXl5AE/biAHDI2jxOSqfs1UZlUTuEl/lCm26I57J3fqgvMs2JHr8cwkhDH/dVFv6
 QTJubYtdGESjbmDdAWpTYflPxZIP/sM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734712791;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EUB+pd09qzDOIutJbZDNlr+yiSsv3gQCHVNUcDNNGbU=;
 b=Hu5q3jIjN5yitMgC+lvS6DE+Y4XOhfoMuCv6hfDJtP/HYK7ASpixxkA3cc9qphPk21vzsb
 cxBpqrFVDq0T/aBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734712791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EUB+pd09qzDOIutJbZDNlr+yiSsv3gQCHVNUcDNNGbU=;
 b=l8/hZcBapuCpu5nrDgW2V0KWxb0laInPTbYn4ZOT1yCqufPBiHJgMnTTvQtAlVi832gSsl
 tl4mS+IXl5AE/biAHDI2jxOSqfs1UZlUTuEl/lCm26I57J3fqgvMs2JHr8cwkhDH/dVFv6
 QTJubYtdGESjbmDdAWpTYflPxZIP/sM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734712791;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EUB+pd09qzDOIutJbZDNlr+yiSsv3gQCHVNUcDNNGbU=;
 b=Hu5q3jIjN5yitMgC+lvS6DE+Y4XOhfoMuCv6hfDJtP/HYK7ASpixxkA3cc9qphPk21vzsb
 cxBpqrFVDq0T/aBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D7D113A63;
 Fri, 20 Dec 2024 16:39:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dhMgBdedZWdJbgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 20 Dec 2024 16:39:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 19/22] tests/qtest/migration: Add migration-test-smoke
In-Reply-To: <Z2WKzdDIyiSCHI9f@x1n>
References: <20241113194630.3385-1-farosas@suse.de>
 <20241113194630.3385-20-farosas@suse.de> <Z2MKesakYn3fn2ue@x1n>
 <87h670vozv.fsf@suse.de> <Z2MvCRYKLmYCj55i@x1n> <875xngvgwe.fsf@suse.de>
 <Z2NHBQc9ixuvJ3k_@x1n> <8734ijvg2q.fsf@suse.de> <Z2Ra7c7svRVbYw1k@x1n>
 <87wmfvtqpz.fsf@suse.de> <Z2WKzdDIyiSCHI9f@x1n>
Date: Fri, 20 Dec 2024 13:39:48 -0300
Message-ID: <87o716tijv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, Dec 19, 2024 at 04:31:04PM -0300, Fabiano Rosas wrote:
>> We shouldn't change stuff that's also used by the rest of the
>> community. People know about QEMU_TEST_FLAKY_TESTS and -m slow. These
>> must continue to work the same.
>
> I see what I overlook; it's used much more than I thought in qtest and we
> also have a CI for it.. So ok, let's keep at least QEMU_TEST_FLAKY_TESTS.
>
> But again, I don't think it matters much even if we rename it, it means the
> flaky CI test won't run these two migration tests, but that's not the end
> of the world either, if you see what I meant.  CI relies on the normal
> tests rather than flaky tests to present.
>
> We should be able to move in / take out FLAKY tests at will, as that's not
> what CI is really relying on.  Here renaming the macro in migration test
> almost means we take both out.
>
>> 
>> We can say: "Internally we don't allow slow and flaky to be in the smoke
>> set".
>> 
>> We cannot say: "In migration-test QEMU_TEST_FLAKY_TESTS is actually
>> QEMU_MIG_TEST_FLAKY, -m slow is actually QEMU_MIG_TEST_EXTRA, -m slow
>> just implies KVM and -m quick implies TCG. Easy peasy!"
>> 
>> >
>> >>   endif
>> >> 
>> >> cmdline invocations:
>> >>   ./migration-test                 # runs smoke, i.e. level 1
>> >>   ./migration-test -m slow         # runs smoke only, no slow tests in the smoke set
>> >>   FLAKY=1 ./migration-test         # runs smoke only, no flaky tests in the smoke set
>> >> 
>> >>   ./migration-test --full          # runs full set, i.e. level 2
>> >>   ./migration-test --full -m slow  # runs full set + slow tests
>> >>   FLAKY=1 ./migration-test --full  # runs full set + flaky tests
>> 
>> Don't see this^ as a matrix of --full and -m. This is identical to what
>> we have today, with the addition of a flag that determines the amount of
>> tests run. We could call it other names if we want:
>> 
>> --size small/large
>> --testset smoke/full
>> 
>> >> 
>> >> I made the first one like that so the compat tests in CI now run less
>> >> tests. We don't need full set during compat because that job is about
>> >> catching changes in device code. It would also make the argument easier
>> >> to enable the compat job for all migration-test-supported archs.
>> >> 
>> >> >> 
>> >> >> I think the best we can do is have a qtest_migration_level_<ARCH> and
>> >> >> set it for every arch.
>> >> >> 
>> >> >> Also note that we must keep plain 'migration-test' invocation working
>> >> >> because of the compat test.
>> >> >
>> >> > We won't break it if we only switch to levels, right?
>> >> >
>> >> > Btw, I also don't know why we need to.  IIRC the compat test runs the test
>> >> > in previous release (but only feeds the new QEMU binary to the old
>> >> > migration-test)?  I think that's one reason why we decided to use the old
>> >> > migration-test (so we won't have new tests ran on compat tests, which is a
>> >> > loss), just to avoid any change in migration-test will break the compat
>> >> > test.. so I assume that should be fine regardless..
>> >> 
>> >> I meant we shouldn't break the command line invocation:
>> >> 
>> >> ./tests/qtest/migration-test -p <test_name>
>> >> 
>> >> As in, we cannot change the test name or add mandatory flags. Otherwise
>> >> we have a discrepancy betweem what the CI job is calling vs. what the
>> >> build actually provides. We run the tests from the previous build, but
>> >> the CI job is current.
>> >
>> > I failed to follow here.  Our CI doesn't hardcode any <test_name>, right?
>> > It should invoke "migration-test" in the old build, feeding new QEMU binary
>> > to it, run whatever are there in the old test.
>> 
>> Yes, but we have the words "migration-test" in the CI .yaml *today*. It
>> doesn't matter if it invokes the tests from the last release. If we
>> changed the name to "migration-foobar", then the CI job continues to
>> work up until 10.0 is released. It then breaks immediately in the first
>> commit of 10.0.50 because the previous release will now have the
>> "migration-foobar" name while the CI still calls for "migration-test".
>
> Not fair at all: nobody suggested to rename the test!
>

Right, you suggested new comand line options (level) and I simply
*mentioned* that we should pay attention to not affect that CI job. The
rest of the exchange is just me trying to clarify. I was not using this
as an argument against your idea.

>> 
>> Basically the point is that CI .yaml changes take effect immediately
>> while test cmdline changes only take effect (in CI) on the next release.
>
> Yes, but so far the "API" is the test name only (and actually not.. more
> below), and at least no path involved.  That's why I want to make sure
> we're on the same page.  So looks like at least "what tests to run by
> default", and "full path of each of the test case" can still change.
>
> Here's the "more below" part: logically if we want we can change the name
> of migration-test.  We need to teach the CI on which version of QEMU to use
> which program to test in the compat tests.  It isn't really hard (a git-tag
> -> prog-name hash), it's just unnecessary to change the test name at all.
>

Sure, we could add code around it if we wanted indeed.

>> 
>> >
>> >> 
>> >> Another point that is more of an annoyance is that the migration-test
>> >> invocation not being stable affectes debug, bisect, etc. When debugging
>> >> the recent multifd regression I already had to keep changing from
>> >> /multifd/tcp/... to /multifd/tcp/uri/... when changing QEMU versions.
>> >
>> > So I could have missed something above, and I can understand this adds
>> > burden to bisections.  However I do prefer we can change test path any way
>> > we want (even if in most cases we shouldn't ever touch them, and we should
>> > still try to not change them as frequent).  IOW we also need to consider
>> > the overhead of keeping test paths to be part of ABI as well.
>> 
>> It's annoying, that's all. Makes me 1% more grumpy.
>
> I'm not going to change any.. but keeping it a protocol is another thing.
>
> So to summarize..
>
> My plan (after adjustment, keeping the name of QEMU_TEST_FLAKY_TESTS) is to
> introduce QEMU_TEST_EXTRA_TESTS (renamed following FLAKY) and cover the
> three current "slow" tests.  Then we stick with -m for the new quick/slow,
> which maps to tcg/kvm directly.  That saves the extra --full parameter.
>
> The diff v.s. your plan is, afaict, you prefer introducing yet another
> --full parameter.
>
> Yours is good that we stick with the whole test in compat tests with no
> extra change, which is a benefit indeed.

It's the other way around. If we add --full, then compat will be !full,
so it will start running less tests. This is a "breaking change" of
sorts, but since the whole point of the series is to run less stuff in
general, then I think it's aligned with the plan.

>
> If go with my plan, the default compat behavior will start to change after
> 10.0 released.  We need to do one more step if we still prefer the wholeset
> run in compat test, which is at the start of 10.1, we send a patch to
> change compat test's parameter from none to "-m slow".
>
> Feel free to go ahead with whatever you prefer.  To me, the more important
> bit is whether we both think that one program is better than two, and also
> that means decouple host setup v.s. tests. I don't have a strong opinion
> otherwise..

Yeah, I can't deal with subverting -m slow. My initial version had this
and it didn't felt right. Maybe in 2025 I'll be a new man and we can do
differently. Let's see =)

