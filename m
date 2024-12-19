Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B99E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 19:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOMEu-0001Gb-V9; Thu, 19 Dec 2024 14:31:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tOMEr-0001Fa-Rr
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 14:31:15 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tOMEn-0002XQ-Cl
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 14:31:13 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BB5CB1F392;
 Thu, 19 Dec 2024 19:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734636667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=loP7t9CfAin61nX8yYxrtY0juvQp20zbcq8phKZknO8=;
 b=y9dgjOHhkHv7tiIUrPTPia1MR952alv+2WmYY+ZxqkT9IWX5pt0Zi7UDJ4HSDQ2/MdAoWb
 iQ6ipw1YW3Nm4HqY+HXzWqrh8NTh7rWm+JPF77WGUDlcjVw7djdGUjSt3O60E1XofuVrEV
 eF2oX9Mmsp47IhMOemJIekQsrozvezI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734636667;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=loP7t9CfAin61nX8yYxrtY0juvQp20zbcq8phKZknO8=;
 b=PKyZQOiGcBL0Ed6N35UOwtFHaEgeEYS+a5gYSHNcCmA7HZh/x/lS2RuFb/FR7ZsiBInEVm
 fgB5E+TzeeOmYcAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734636667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=loP7t9CfAin61nX8yYxrtY0juvQp20zbcq8phKZknO8=;
 b=y9dgjOHhkHv7tiIUrPTPia1MR952alv+2WmYY+ZxqkT9IWX5pt0Zi7UDJ4HSDQ2/MdAoWb
 iQ6ipw1YW3Nm4HqY+HXzWqrh8NTh7rWm+JPF77WGUDlcjVw7djdGUjSt3O60E1XofuVrEV
 eF2oX9Mmsp47IhMOemJIekQsrozvezI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734636667;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=loP7t9CfAin61nX8yYxrtY0juvQp20zbcq8phKZknO8=;
 b=PKyZQOiGcBL0Ed6N35UOwtFHaEgeEYS+a5gYSHNcCmA7HZh/x/lS2RuFb/FR7ZsiBInEVm
 fgB5E+TzeeOmYcAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4232D13A32;
 Thu, 19 Dec 2024 19:31:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qZonAnt0ZGfDfgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 19 Dec 2024 19:31:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 19/22] tests/qtest/migration: Add migration-test-smoke
In-Reply-To: <Z2Ra7c7svRVbYw1k@x1n>
References: <20241113194630.3385-1-farosas@suse.de>
 <20241113194630.3385-20-farosas@suse.de> <Z2MKesakYn3fn2ue@x1n>
 <87h670vozv.fsf@suse.de> <Z2MvCRYKLmYCj55i@x1n> <875xngvgwe.fsf@suse.de>
 <Z2NHBQc9ixuvJ3k_@x1n> <8734ijvg2q.fsf@suse.de> <Z2Ra7c7svRVbYw1k@x1n>
Date: Thu, 19 Dec 2024 16:31:04 -0300
Message-ID: <87wmfvtqpz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.993]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> On Thu, Dec 19, 2024 at 12:38:05PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Wed, Dec 18, 2024 at 06:08:01PM -0300, Fabiano Rosas wrote:
>> >> Peter Xu <peterx@redhat.com> writes:
>> >> 
>> >> > On Wed, Dec 18, 2024 at 03:13:08PM -0300, Fabiano Rosas wrote:
>> >> >> Peter Xu <peterx@redhat.com> writes:
>> >> >> 
>> >> >> > On Wed, Nov 13, 2024 at 04:46:27PM -0300, Fabiano Rosas wrote:
>> >> >> >> diff --git a/tests/qtest/migration-test-smoke.c b/tests/qtest/migration-test-smoke.c
>> >> >> >> new file mode 100644
>> >> >> >> index 0000000000..ff2d72881f
>> >> >> >> --- /dev/null
>> >> >> >> +++ b/tests/qtest/migration-test-smoke.c
>> >> >> >> @@ -0,0 +1,39 @@
>> >> >> >> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> >> >> >> +
>> >> >> >> +#include "qemu/osdep.h"
>> >> >> >> +#include "libqtest.h"
>> >> >> >> +#include "migration/test-framework.h"
>> >> >> >> +#include "qemu/module.h"
>> >> >> >> +
>> >> >> >> +int main(int argc, char **argv)
>> >> >> >> +{
>> >> >> >> +    MigrationTestEnv *env;
>> >> >> >> +    int ret;
>> >> >> >> +
>> >> >> >> +    g_test_init(&argc, &argv, NULL);
>> >> >> >> +    env = migration_get_env();
>> >> >> >> +    module_call_init(MODULE_INIT_QOM);
>> >> >> >> +
>> >> >> >> +    if (env->has_kvm) {
>> >> >> >> +        g_test_message(
>> >> >> >> +            "Smoke tests already run as part of the full suite on KVM hosts");
>> >> >> >> +        goto out;
>> >> >> >> +    }
>> >> >> >
>> >> >> > So the "smoke" here is almost "tcg".. and if i want to run a smoke test on
>> >> >> > a kvm-enabled host, it's noop.. which isn't easy to understand why.
>> >> >> >
>> >> >> > If to rethink our goal, we have two requirements:
>> >> >> >
>> >> >> >   (1) We want to categorize migration tests, so some are quick, some are
>> >> >> >       slow, some might be flacky.  Maybe more, but it's about putting one
>> >> >> >       test into only one bucket, and there're >1 buckets.
>> >> >> 
>> >> >> It's true that the smoke test should never have slow or flaky tests, but
>> >> >> we can't use this categorization for anything else. IOW, what you
>> >> >> describe here is not a goal. If a test is found to be slow we put it
>> >> >> under slow and it will only run with -m slow/thorough, that's it. We can
>> >> >> just ignore this.
>> >> >
>> >> > I could have missed something, but I still think it's the same issue.  In
>> >> > general, I think we want to provide different levels of tests, like:
>> >> >
>> >> >   - Level 1: the minimum set of tests (aka, the "smoke" idea here)
>> >> >   - Level 2: normal set of tests (aka, whatever we used to run by default)
>> >> >   - Level 3: slow tests (aka, only ran with '-m slow' before)
>> >> 
>> >> How are you going to make this one work? 'migration-test --level 3'
>> >> vs. 'migration-test --level 3 -m slow' vs. 'migration-test -m slow'
>> >> 
>> >> The only way I can see is to not have a level 3 at all and just use -m
>> >> slow.
>> >
>> > I meant remove "-m" and remove QEMU_TEST_FLAKY_TESTS, instead replacing all
>> > of them using --level.  Then migration-test ignores '-m' in the future
>> > because it's simply not enough for us.
>> >
>> 
>> Even if we remove -m, it will still be passed in when people run make
>> SPEED=slow check and people who know about glib/qtests will continue to
>> try to use it.
>> 
>> Ignoring -m and FLAKY will create a diversion from the rest of qtest and
>> QEMU tests in general. I think the best approach is to drop levels 3 and
>> 4 from this proposal and just ignore those options altogether.
>> 
>> If we're going to have a single binary as you suggest, then there's no
>> harm still using -m slow and FLAKY as usual. We call level 1: "smoke
>> tests", level 2: "full set" and we put in some code to prevent
>> registering a smoke test as slow or flaky and that's it.
>> 
>> ... and of course, if there's only two levels, then we only need a
>> boolean flag: --full
>> 
>> IOW, I still don't think slow and flaky have anything to do with what
>> we're trying to do here. I do appreciate that a single binary is better
>> than two.
>
> Yes, the major goal is to keep it a single binary.
>
> We can make it two levels.  However if so I'd rather reuse -m, then we keep
> "-m quick" for tcg, "-m slow" for tcg+kvm.  We can move the current "slow

I don't understand why you insist in bringing slow/quick into this. '-m
quick' is for quick tests and '-m slow' is for slow tests. What we're
doing here is: "small set" vs. "large set". Except for our own sanity
we're excluding slow tests from the "small set", otherwise the
perception of smallness is counteracted by the perception of slowness.

Then, we're determining arbitrarily that the small set is to be run only
on TCG hosts and the large set is to be run in the KVM hosts. And via
cmdline we want to be able to run anything basically.

> tests" into another env var: basically those ones (dirtylimit, auto
> converge, xbzrle, iirc) and FLAKY ones won't be run by anyone but us.
>
>> 
>> >> 
>> >> >
>> >> > Indeed it'll need a few extra lines in meson, but it doesn't look too bad,
>> >> > but yeah if anyone is not happy with it we can rethink.  I just want to
>> >> > know whether it's still acceptable.
>> >> >
>> >> > I tried to code it up, it looks like this:
>> >> >
>> >> > ====8<====
>> >> > diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>> >> > index c5a70021c5..5bec33b627 100644
>> >> > --- a/tests/qtest/meson.build
>> >> > +++ b/tests/qtest/meson.build
>> >> > @@ -392,6 +392,12 @@ if dbus_display
>> >> >    qtests += {'dbus-display-test': [dbus_display1, gio]}
>> >> >  endif
>> >> >  
>> >> > +if run_command('test', '-e', '/dev/kvm', check: false).returncode() == 0
>> >> > +  has_kvm = true
>> >> > +else
>> >> > +  has_kvm =false
>> >> > +endif
>> >> 
>> >> This is not right. Checking /dev/kvm at configure time doesn't ensure it
>> >> will be present at test runtime. It also doesn't account for builds with
>> >
>> > Why the test runtime would be a different host versus whoever setup the
>> > meson build?
>> >
>> 
>> User permissions, containers, configuration changes in between build
>> time and runtime, etc.
>
> I was thinking there's no way in CI that it can be done separately.  But
> yeah I don't know well on CI.. so if it can happen easily that's a problem.
>

I was thinking more of make check in peoples machines. Who knows what
sort of setups QEMU developers have... As for CI, I don't think it
should change and as I said, if it does then the test itself should be
able to cope.

>> 
>> Also, it's quite convenient to be able to pass any QEMU binary to any
>> version of the tests, I do that with downstream builds sometimes.
>
> IIUC we're only talking about "meson test" behavior, I assume
> migration-test should be mostly unaffected on how it'll be used, except
> that indeed we're changing "how to define quick/slow tests".  More below.
>

Yes, indeed.

>> 
>> >> CONFIG_KVM=n or builds without both KVM and TCG. This needs to be done
>> >> inside the test.
>> >
>> > This is true, but IIUC that's not a blocker, as we can use (btw, I found
>> > fs.exists() a better alternative than my previous hack):
>> >
>> > if fs.exists('/dev/kvm') and 'CONFIG_KVM' in config_all_accel
>> >   has_kvm = true
>> > else
>> >   has_kvm = false
>> > endif
>> >
>> 
>> I dislike this, however I'm thinking what's the worse that could happen
>> if there's a mismatch between configure and runtime? We'd just run a
>> different set of tests.
>> 
>> Can we make it:
>> 
>> meson.build:
>>   # If there's KVM support, run the full set of migration tests as KVM
>>   # hosts tend to use more migration features than just save/restore.
>>   if fs.exists('/dev/kvm')
>>     migration_test_args = "--full"
>
> So IMHO we could go "-m slow | -m thorough" here, as mentioned above, just
> to avoid making it a matrix of (--full, -m) combinations.
>
> Then move all old slow tests into (just to avoid using "slow" as a word):
>
>   if (getenv("QEMU_MIG_TEST_EXTRA")) ...
>
> And rename FLAKY into:
>
>   if (getenv("QEMU_MIG_TEST_FLAKY")) ...
>
> Then we test it with QEMU_MIG_TEST_FLAKY=1 and QEMU_MIG_TEST_EXTRA=1 if we
> want all tests.

We shouldn't change stuff that's also used by the rest of the
community. People know about QEMU_TEST_FLAKY_TESTS and -m slow. These
must continue to work the same.

We can say: "Internally we don't allow slow and flaky to be in the smoke
set".

We cannot say: "In migration-test QEMU_TEST_FLAKY_TESTS is actually
QEMU_MIG_TEST_FLAKY, -m slow is actually QEMU_MIG_TEST_EXTRA, -m slow
just implies KVM and -m quick implies TCG. Easy peasy!"

>
>>   endif
>> 
>> cmdline invocations:
>>   ./migration-test                 # runs smoke, i.e. level 1
>>   ./migration-test -m slow         # runs smoke only, no slow tests in the smoke set
>>   FLAKY=1 ./migration-test         # runs smoke only, no flaky tests in the smoke set
>> 
>>   ./migration-test --full          # runs full set, i.e. level 2
>>   ./migration-test --full -m slow  # runs full set + slow tests
>>   FLAKY=1 ./migration-test --full  # runs full set + flaky tests

Don't see this^ as a matrix of --full and -m. This is identical to what
we have today, with the addition of a flag that determines the amount of
tests run. We could call it other names if we want:

--size small/large
--testset smoke/full

>> 
>> I made the first one like that so the compat tests in CI now run less
>> tests. We don't need full set during compat because that job is about
>> catching changes in device code. It would also make the argument easier
>> to enable the compat job for all migration-test-supported archs.
>> 
>> >> 
>> >> I think the best we can do is have a qtest_migration_level_<ARCH> and
>> >> set it for every arch.
>> >> 
>> >> Also note that we must keep plain 'migration-test' invocation working
>> >> because of the compat test.
>> >
>> > We won't break it if we only switch to levels, right?
>> >
>> > Btw, I also don't know why we need to.  IIRC the compat test runs the test
>> > in previous release (but only feeds the new QEMU binary to the old
>> > migration-test)?  I think that's one reason why we decided to use the old
>> > migration-test (so we won't have new tests ran on compat tests, which is a
>> > loss), just to avoid any change in migration-test will break the compat
>> > test.. so I assume that should be fine regardless..
>> 
>> I meant we shouldn't break the command line invocation:
>> 
>> ./tests/qtest/migration-test -p <test_name>
>> 
>> As in, we cannot change the test name or add mandatory flags. Otherwise
>> we have a discrepancy betweem what the CI job is calling vs. what the
>> build actually provides. We run the tests from the previous build, but
>> the CI job is current.
>
> I failed to follow here.  Our CI doesn't hardcode any <test_name>, right?
> It should invoke "migration-test" in the old build, feeding new QEMU binary
> to it, run whatever are there in the old test.

Yes, but we have the words "migration-test" in the CI .yaml *today*. It
doesn't matter if it invokes the tests from the last release. If we
changed the name to "migration-foobar", then the CI job continues to
work up until 10.0 is released. It then breaks immediately in the first
commit of 10.0.50 because the previous release will now have the
"migration-foobar" name while the CI still calls for "migration-test".

Basically the point is that CI .yaml changes take effect immediately
while test cmdline changes only take effect (in CI) on the next release.

>
>> 
>> Another point that is more of an annoyance is that the migration-test
>> invocation not being stable affectes debug, bisect, etc. When debugging
>> the recent multifd regression I already had to keep changing from
>> /multifd/tcp/... to /multifd/tcp/uri/... when changing QEMU versions.
>
> So I could have missed something above, and I can understand this adds
> burden to bisections.  However I do prefer we can change test path any way
> we want (even if in most cases we shouldn't ever touch them, and we should
> still try to not change them as frequent).  IOW we also need to consider
> the overhead of keeping test paths to be part of ABI as well.

It's annoying, that's all. Makes me 1% more grumpy.

