Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0ABFE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 21:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO1HA-0003Gn-5n; Wed, 18 Dec 2024 16:08:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tO1H8-0003GH-Ue
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 16:08:10 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tO1H4-0005eK-QX
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 16:08:10 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 066A11F38E;
 Wed, 18 Dec 2024 21:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734556085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uTKIYtSQQc1RzljgmHBvI064YXn1z/9tJ+18/Zk27Qk=;
 b=yUJQ5ye9ayc/vfTVAzKDobY57YXgS1u1xSu7KNihN+7qC9qGmBXuPTiCBCGwJsClW3KJjx
 OwNntsI6gVqXduRnY9ikALE+I3Z+x1Aj+OCT0HddML1JTkgx06uZMnvJ7xAbWF5oxL545a
 J8VM0CgoOD6muNgfZ43b47PEBSQqd1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734556085;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uTKIYtSQQc1RzljgmHBvI064YXn1z/9tJ+18/Zk27Qk=;
 b=DuRXRrNCeK7KV9077ri51Bmi41KgA0x3ubG1SljStg7NWlYJmUeIpRdVLpUSTSqgKbejg5
 ZuBKlZNGj3J7FyBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734556085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uTKIYtSQQc1RzljgmHBvI064YXn1z/9tJ+18/Zk27Qk=;
 b=yUJQ5ye9ayc/vfTVAzKDobY57YXgS1u1xSu7KNihN+7qC9qGmBXuPTiCBCGwJsClW3KJjx
 OwNntsI6gVqXduRnY9ikALE+I3Z+x1Aj+OCT0HddML1JTkgx06uZMnvJ7xAbWF5oxL545a
 J8VM0CgoOD6muNgfZ43b47PEBSQqd1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734556085;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uTKIYtSQQc1RzljgmHBvI064YXn1z/9tJ+18/Zk27Qk=;
 b=DuRXRrNCeK7KV9077ri51Bmi41KgA0x3ubG1SljStg7NWlYJmUeIpRdVLpUSTSqgKbejg5
 ZuBKlZNGj3J7FyBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74950132EA;
 Wed, 18 Dec 2024 21:08:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id T7C1DrQ5Y2fgGAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 18 Dec 2024 21:08:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 19/22] tests/qtest/migration: Add migration-test-smoke
In-Reply-To: <Z2MvCRYKLmYCj55i@x1n>
References: <20241113194630.3385-1-farosas@suse.de>
 <20241113194630.3385-20-farosas@suse.de> <Z2MKesakYn3fn2ue@x1n>
 <87h670vozv.fsf@suse.de> <Z2MvCRYKLmYCj55i@x1n>
Date: Wed, 18 Dec 2024 18:08:01 -0300
Message-ID: <875xngvgwe.fsf@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
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

> On Wed, Dec 18, 2024 at 03:13:08PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Wed, Nov 13, 2024 at 04:46:27PM -0300, Fabiano Rosas wrote:
>> >> diff --git a/tests/qtest/migration-test-smoke.c b/tests/qtest/migration-test-smoke.c
>> >> new file mode 100644
>> >> index 0000000000..ff2d72881f
>> >> --- /dev/null
>> >> +++ b/tests/qtest/migration-test-smoke.c
>> >> @@ -0,0 +1,39 @@
>> >> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> >> +
>> >> +#include "qemu/osdep.h"
>> >> +#include "libqtest.h"
>> >> +#include "migration/test-framework.h"
>> >> +#include "qemu/module.h"
>> >> +
>> >> +int main(int argc, char **argv)
>> >> +{
>> >> +    MigrationTestEnv *env;
>> >> +    int ret;
>> >> +
>> >> +    g_test_init(&argc, &argv, NULL);
>> >> +    env = migration_get_env();
>> >> +    module_call_init(MODULE_INIT_QOM);
>> >> +
>> >> +    if (env->has_kvm) {
>> >> +        g_test_message(
>> >> +            "Smoke tests already run as part of the full suite on KVM hosts");
>> >> +        goto out;
>> >> +    }
>> >
>> > So the "smoke" here is almost "tcg".. and if i want to run a smoke test on
>> > a kvm-enabled host, it's noop.. which isn't easy to understand why.
>> >
>> > If to rethink our goal, we have two requirements:
>> >
>> >   (1) We want to categorize migration tests, so some are quick, some are
>> >       slow, some might be flacky.  Maybe more, but it's about putting one
>> >       test into only one bucket, and there're >1 buckets.
>> 
>> It's true that the smoke test should never have slow or flaky tests, but
>> we can't use this categorization for anything else. IOW, what you
>> describe here is not a goal. If a test is found to be slow we put it
>> under slow and it will only run with -m slow/thorough, that's it. We can
>> just ignore this.
>
> I could have missed something, but I still think it's the same issue.  In
> general, I think we want to provide different levels of tests, like:
>
>   - Level 1: the minimum set of tests (aka, the "smoke" idea here)
>   - Level 2: normal set of tests (aka, whatever we used to run by default)
>   - Level 3: slow tests (aka, only ran with '-m slow' before)

How are you going to make this one work? 'migration-test --level 3'
vs. 'migration-test --level 3 -m slow' vs. 'migration-test -m slow'

The only way I can see is to not have a level 3 at all and just use -m
slow.

>   - Level 4: flaky tests (aka, only ran when QEMU_TEST_FLAKY_TESTS set)
>
> Then we want to run level1 test only in tcg, and level1+2 in kvm.  We can
> only trigger level 1-3 or level 1-4 in manual tests.
>
> We used to have different way to provide the level idea, now I think we can
> consider provide that level in migration-test in one shot.  Obviously it's
> more than quick/slow so I don't think we can reuse "-m", but we can add our
>
> own test level "--level" parameter, so --level N means run all tests lower
> than level N, for example.
>

I'm not sure that works semantically for level 4. Because the reason one
runs flaky tests is different from the reason one runs the other
tests. So we probably don't want to run a bunch of tests just to get to
the broken ones.

But we don't need to spend too much time on this. I hate the idea of
flaky tests anyway. Whatever we choose they'll just sit there doing
nothing.

>> 
>> >
>> >   (2) We want to run only a small portion of tests on tcg, more tests on
>> >       kvm.
>> 
>> Yes. Guests are fast with KVM and slow with TCG (generally) and the KVM
>> hosts are the ones where it's actually important to ensure all migration
>> features work OK. Non-KVM will only care about save/restore of
>> snapshots. Therefore we don't need to have all tests running with TCG,
>> only the smoke set.
>> 
>> And "smoke set" is arbitrary, not tied to speed, but of course no slow
>> tests please (which already happens because we don't pass -m slow to
>> migration-test-smoke).
>> 
>> >
>> > Ideally, we don't need two separate main test files, do we?
>> >
>> > I mean, we can do (1) with the existing migration-test.c, with the help of
>> > either gtest's "-m" or something we invent.  The only unfortunate part is
>> > qtest only have quick/slow, afaiu the "thorough" mode is the same as
>> > "slow".. while we don't yet have real "perf" tests.  It means we only have
>> > two buckets if we want to reuse gtest's "-m".
>> >
>> > Maybe it's enough?  If not, we can implement >2 categories in whatever
>> > form, either custom argv/argc cmdline, or env variable.
>> >
>> > Then, if we always categorize one test (let me try to not reuse glib's
>> > terms to be clear) into any of: FAST|NORMAL|SLOW|..., then we have a single
>> 
>> It's either normal or slow. Because we only know a test is only after it
>> bothers us.
>
> So I wonder if we can provide four levels, as above.. and define it for
> each test in migration-test.
>
>> 
>> > migration-test that have different level of tests.  We can invoke
>> > "migration-test --mode FAST" if kvm is not supported, and invoke the same
>> > "migration-test --mode SLOW" if kvm is supported.
>> 
>> This is messy due to how qtest/meson.build works. Having two tests is
>> the clean change. Otherwise we'll have to add "if migration-test" or
>> create artificial test names to be able to restrict the arguments that
>> are passed to the test per arch.
>
> Indeed it'll need a few extra lines in meson, but it doesn't look too bad,
> but yeah if anyone is not happy with it we can rethink.  I just want to
> know whether it's still acceptable.
>
> I tried to code it up, it looks like this:
>
> ====8<====
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index c5a70021c5..5bec33b627 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -392,6 +392,12 @@ if dbus_display
>    qtests += {'dbus-display-test': [dbus_display1, gio]}
>  endif
>  
> +if run_command('test', '-e', '/dev/kvm', check: false).returncode() == 0
> +  has_kvm = true
> +else
> +  has_kvm =false
> +endif

This is not right. Checking /dev/kvm at configure time doesn't ensure it
will be present at test runtime. It also doesn't account for builds with
CONFIG_KVM=n or builds without both KVM and TCG. This needs to be done
inside the test.

I think the best we can do is have a qtest_migration_level_<ARCH> and
set it for every arch.

Also note that we must keep plain 'migration-test' invocation working
because of the compat test.

> +
>  qtest_executables = {}
>  foreach dir : target_dirs
>    if not dir.endswith('-softmmu')
> @@ -434,11 +440,21 @@ foreach dir : target_dirs
>          test: executable(test, src, dependencies: deps)
>        }
>      endif
> +    test_args = ['--tap', '-k']
> +    if test == 'migration-test'
> +      if host_os == 'linux' and cpu == target_base and has_kvm
> +        # Only run full migration test if host kvm supported
> +        test_args += ['-m', 'thorough']
> +      else
> +        test_args += ['-m', 'quick']
> +      endif
> +    endif
> +
>      test('qtest-@0@/@1@'.format(target_base, test),
>           qtest_executables[test],
>           depends: [test_deps, qtest_emulator, emulator_modules],
>           env: qtest_env,
> -         args: ['--tap', '-k'],
> +         args: test_args,
>           protocol: 'tap',
>           timeout: slow_qtests.get(test, 60),
>           priority: slow_qtests.get(test, 60),
> ====8<====
>
> I still used "-m" but just to show the idea.  I also wonder whether other
> tests would have similar demands.. otherwise are we destined to not be able
> to use qtest cmdline at all as long as we use meson?
>
>> 
>> I also *think* we cannot have anything extra in argv because gtester
>> expects to be able to parse those.
>
> We can definitely hijack argv/argc before passing it over to glib.
>
>> 
>> >
>> > Would this be nicer?  At least we can still run a pretty fast smoke / FAST
>> > test even on kvm. Basically, untangle accel v.s. "test category".
>> 
>> We could just remove the restriction from migration-test-smoke if that's
>> an issue.
>
> Not the only issue, but the idea of it. In general, IMHO it'll be good we
> don't attach host info to a test program.
>
> IOW, I want to keep the test in a way so that we'll be able to run whatever
> level of test on whatever host, at least when when I run migration-test
> manually.
>
> So e.g. I also want to be able to run full set of tests on TCG too whenever
> needed.  So I still feel like we mangled these two issues together which
> might be unnecessarily.

