Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D72E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 17:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOKYV-00052M-TO; Thu, 19 Dec 2024 12:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tOKYU-000520-5z
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:43:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tOKYR-0002hw-Qr
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734630198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZPXAVMJiguzV484szX95KlaF2swrAXwS3x1byqlskYk=;
 b=CHOrOjnjYFH7VCDuSB0YM3T1sqPvACGfWMzmr1pv0AP8mlOwoLn6+BotYOI8/EQnGhUKxi
 +7HKzjPpDHLCTIaCXNW8uij+8oUV8cmaEpWhofM9MjxKgla3h4bESb8mBfXmeZt1zcq+Qi
 gh/GuIcv+0s7woqfBRtrxjX4odVi3hY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-XpNHY3PiMdCS5FQxD2ck6w-1; Thu, 19 Dec 2024 12:42:09 -0500
X-MC-Unique: XpNHY3PiMdCS5FQxD2ck6w-1
X-Mimecast-MFC-AGG-ID: XpNHY3PiMdCS5FQxD2ck6w
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-467b0b0aed4so20298681cf.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 09:42:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734630129; x=1735234929;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZPXAVMJiguzV484szX95KlaF2swrAXwS3x1byqlskYk=;
 b=H4+HN7R7ngAhGaDrKyb7tBMc8RJOJKW/3CnhPuQMlZMG8/onqLvM6rIAMvxRzs9E6V
 e3d9aR0c8FGYFN2HzvhvujZDyDHLsGP+CGCNgfbpn3rKEtIX2Pr1TkiWyl82PIrZ5Aug
 vmwPn25KXVaF7coNgyvtuoj6F9OpmksNt1hmr7E7mElO23gJ+RvL46eX5RaFowZAqEpl
 keeO1oPPhWJ9ze/kLM3Iv/1bCMh8lP3GY1CcPPsGsjYTdIJowesvgQmnDE7Zy1Z+8z1K
 HbfwktFnP/djQd2yZzBb3NFjQcaDyiTvQBtw6YntgQgwoe3IfEaDk6Xzyr94t7KrvSFn
 Ek2Q==
X-Gm-Message-State: AOJu0Yyq6RZdsNJfdsWgGPCUuj+8Z31Qmol3nci7sqtsc4x4IFJUCOWP
 bAqjoVbJYcR28OXlDpYUMyi0ANtFmvEf6An7vhgKwfjy4YpDHECC4Q1zgmZkxaHIgdP+3XLQtPl
 uUZMdM3o259dmRkWwNIyZQzvOUYoKEOiJh1WTa7WuTm/Hbm+40lfx
X-Gm-Gg: ASbGnctYEoQo5l5XOrfLJK8pqSljzq6pun9V06cZUEYu2VTRK6U/Oh+8lfhp07yFs0s
 9zcbnSBY9sd0DPGRdz0jJXxtuegiV58fPCDU98hMnLBLroj2216I7HPs4GqCZSJmLYVIK53ZAGY
 I8ZhN04TGiv/T5iliKGlh3ipo1yZmuyG2r0yQaankaNfAz+EXLogGANWX5THG6jtcH0yXDYKcKG
 TErE5Y/O0yKRaO+yylkSbVwWFQVlkU0hLaGU5IAT9EvVRaJdsCAaXGqhbQkwhZzbX1VqDGxiY+J
 7aADpwhYxiewcaJhBA==
X-Received: by 2002:a05:622a:180c:b0:467:6dd9:c964 with SMTP id
 d75a77b69052e-46908eb4ca7mr122823021cf.53.1734630128919; 
 Thu, 19 Dec 2024 09:42:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYou3Isz6TrE0SBrS9/69yM2AaRB05Zhh1h1TstQQWg2w/kVSkB510hiyCpuR6xaqwrv+LWw==
X-Received: by 2002:a05:622a:180c:b0:467:6dd9:c964 with SMTP id
 d75a77b69052e-46908eb4ca7mr122822341cf.53.1734630128340; 
 Thu, 19 Dec 2024 09:42:08 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3eb17766sm8191751cf.64.2024.12.19.09.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 09:42:07 -0800 (PST)
Date: Thu, 19 Dec 2024 12:42:05 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 19/22] tests/qtest/migration: Add migration-test-smoke
Message-ID: <Z2Ra7c7svRVbYw1k@x1n>
References: <20241113194630.3385-1-farosas@suse.de>
 <20241113194630.3385-20-farosas@suse.de> <Z2MKesakYn3fn2ue@x1n>
 <87h670vozv.fsf@suse.de> <Z2MvCRYKLmYCj55i@x1n>
 <875xngvgwe.fsf@suse.de> <Z2NHBQc9ixuvJ3k_@x1n>
 <8734ijvg2q.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8734ijvg2q.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Dec 19, 2024 at 12:38:05PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Dec 18, 2024 at 06:08:01PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Wed, Dec 18, 2024 at 03:13:08PM -0300, Fabiano Rosas wrote:
> >> >> Peter Xu <peterx@redhat.com> writes:
> >> >> 
> >> >> > On Wed, Nov 13, 2024 at 04:46:27PM -0300, Fabiano Rosas wrote:
> >> >> >> diff --git a/tests/qtest/migration-test-smoke.c b/tests/qtest/migration-test-smoke.c
> >> >> >> new file mode 100644
> >> >> >> index 0000000000..ff2d72881f
> >> >> >> --- /dev/null
> >> >> >> +++ b/tests/qtest/migration-test-smoke.c
> >> >> >> @@ -0,0 +1,39 @@
> >> >> >> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> >> >> >> +
> >> >> >> +#include "qemu/osdep.h"
> >> >> >> +#include "libqtest.h"
> >> >> >> +#include "migration/test-framework.h"
> >> >> >> +#include "qemu/module.h"
> >> >> >> +
> >> >> >> +int main(int argc, char **argv)
> >> >> >> +{
> >> >> >> +    MigrationTestEnv *env;
> >> >> >> +    int ret;
> >> >> >> +
> >> >> >> +    g_test_init(&argc, &argv, NULL);
> >> >> >> +    env = migration_get_env();
> >> >> >> +    module_call_init(MODULE_INIT_QOM);
> >> >> >> +
> >> >> >> +    if (env->has_kvm) {
> >> >> >> +        g_test_message(
> >> >> >> +            "Smoke tests already run as part of the full suite on KVM hosts");
> >> >> >> +        goto out;
> >> >> >> +    }
> >> >> >
> >> >> > So the "smoke" here is almost "tcg".. and if i want to run a smoke test on
> >> >> > a kvm-enabled host, it's noop.. which isn't easy to understand why.
> >> >> >
> >> >> > If to rethink our goal, we have two requirements:
> >> >> >
> >> >> >   (1) We want to categorize migration tests, so some are quick, some are
> >> >> >       slow, some might be flacky.  Maybe more, but it's about putting one
> >> >> >       test into only one bucket, and there're >1 buckets.
> >> >> 
> >> >> It's true that the smoke test should never have slow or flaky tests, but
> >> >> we can't use this categorization for anything else. IOW, what you
> >> >> describe here is not a goal. If a test is found to be slow we put it
> >> >> under slow and it will only run with -m slow/thorough, that's it. We can
> >> >> just ignore this.
> >> >
> >> > I could have missed something, but I still think it's the same issue.  In
> >> > general, I think we want to provide different levels of tests, like:
> >> >
> >> >   - Level 1: the minimum set of tests (aka, the "smoke" idea here)
> >> >   - Level 2: normal set of tests (aka, whatever we used to run by default)
> >> >   - Level 3: slow tests (aka, only ran with '-m slow' before)
> >> 
> >> How are you going to make this one work? 'migration-test --level 3'
> >> vs. 'migration-test --level 3 -m slow' vs. 'migration-test -m slow'
> >> 
> >> The only way I can see is to not have a level 3 at all and just use -m
> >> slow.
> >
> > I meant remove "-m" and remove QEMU_TEST_FLAKY_TESTS, instead replacing all
> > of them using --level.  Then migration-test ignores '-m' in the future
> > because it's simply not enough for us.
> >
> 
> Even if we remove -m, it will still be passed in when people run make
> SPEED=slow check and people who know about glib/qtests will continue to
> try to use it.
> 
> Ignoring -m and FLAKY will create a diversion from the rest of qtest and
> QEMU tests in general. I think the best approach is to drop levels 3 and
> 4 from this proposal and just ignore those options altogether.
> 
> If we're going to have a single binary as you suggest, then there's no
> harm still using -m slow and FLAKY as usual. We call level 1: "smoke
> tests", level 2: "full set" and we put in some code to prevent
> registering a smoke test as slow or flaky and that's it.
> 
> ... and of course, if there's only two levels, then we only need a
> boolean flag: --full
> 
> IOW, I still don't think slow and flaky have anything to do with what
> we're trying to do here. I do appreciate that a single binary is better
> than two.

Yes, the major goal is to keep it a single binary.

We can make it two levels.  However if so I'd rather reuse -m, then we keep
"-m quick" for tcg, "-m slow" for tcg+kvm.  We can move the current "slow
tests" into another env var: basically those ones (dirtylimit, auto
converge, xbzrle, iirc) and FLAKY ones won't be run by anyone but us.

> 
> >> 
> >> >   - Level 4: flaky tests (aka, only ran when QEMU_TEST_FLAKY_TESTS set)
> >> >
> >> > Then we want to run level1 test only in tcg, and level1+2 in kvm.  We can
> >> > only trigger level 1-3 or level 1-4 in manual tests.
> >> >
> >> > We used to have different way to provide the level idea, now I think we can
> >> > consider provide that level in migration-test in one shot.  Obviously it's
> >> > more than quick/slow so I don't think we can reuse "-m", but we can add our
> >> >
> >> > own test level "--level" parameter, so --level N means run all tests lower
> >> > than level N, for example.
> >> >
> >> 
> >> I'm not sure that works semantically for level 4. Because the reason one
> >> runs flaky tests is different from the reason one runs the other
> >> tests. So we probably don't want to run a bunch of tests just to get to
> >> the broken ones.
> >> 
> >> But we don't need to spend too much time on this. I hate the idea of
> >> flaky tests anyway. Whatever we choose they'll just sit there doing
> >> nothing.
> >
> > Yes how to treat flaky tests isn't important yet.  If we don't care about
> > QEMU_TEST_FLAKY_TESTS then we make it three levels.  The idea is the same.
> >
> >> 
> >> >> 
> >> >> >
> >> >> >   (2) We want to run only a small portion of tests on tcg, more tests on
> >> >> >       kvm.
> >> >> 
> >> >> Yes. Guests are fast with KVM and slow with TCG (generally) and the KVM
> >> >> hosts are the ones where it's actually important to ensure all migration
> >> >> features work OK. Non-KVM will only care about save/restore of
> >> >> snapshots. Therefore we don't need to have all tests running with TCG,
> >> >> only the smoke set.
> >> >> 
> >> >> And "smoke set" is arbitrary, not tied to speed, but of course no slow
> >> >> tests please (which already happens because we don't pass -m slow to
> >> >> migration-test-smoke).
> >> >> 
> >> >> >
> >> >> > Ideally, we don't need two separate main test files, do we?
> >> >> >
> >> >> > I mean, we can do (1) with the existing migration-test.c, with the help of
> >> >> > either gtest's "-m" or something we invent.  The only unfortunate part is
> >> >> > qtest only have quick/slow, afaiu the "thorough" mode is the same as
> >> >> > "slow".. while we don't yet have real "perf" tests.  It means we only have
> >> >> > two buckets if we want to reuse gtest's "-m".
> >> >> >
> >> >> > Maybe it's enough?  If not, we can implement >2 categories in whatever
> >> >> > form, either custom argv/argc cmdline, or env variable.
> >> >> >
> >> >> > Then, if we always categorize one test (let me try to not reuse glib's
> >> >> > terms to be clear) into any of: FAST|NORMAL|SLOW|..., then we have a single
> >> >> 
> >> >> It's either normal or slow. Because we only know a test is only after it
> >> >> bothers us.
> >> >
> >> > So I wonder if we can provide four levels, as above.. and define it for
> >> > each test in migration-test.
> >> >
> >> >> 
> >> >> > migration-test that have different level of tests.  We can invoke
> >> >> > "migration-test --mode FAST" if kvm is not supported, and invoke the same
> >> >> > "migration-test --mode SLOW" if kvm is supported.
> >> >> 
> >> >> This is messy due to how qtest/meson.build works. Having two tests is
> >> >> the clean change. Otherwise we'll have to add "if migration-test" or
> >> >> create artificial test names to be able to restrict the arguments that
> >> >> are passed to the test per arch.
> >> >
> >> > Indeed it'll need a few extra lines in meson, but it doesn't look too bad,
> >> > but yeah if anyone is not happy with it we can rethink.  I just want to
> >> > know whether it's still acceptable.
> >> >
> >> > I tried to code it up, it looks like this:
> >> >
> >> > ====8<====
> >> > diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> >> > index c5a70021c5..5bec33b627 100644
> >> > --- a/tests/qtest/meson.build
> >> > +++ b/tests/qtest/meson.build
> >> > @@ -392,6 +392,12 @@ if dbus_display
> >> >    qtests += {'dbus-display-test': [dbus_display1, gio]}
> >> >  endif
> >> >  
> >> > +if run_command('test', '-e', '/dev/kvm', check: false).returncode() == 0
> >> > +  has_kvm = true
> >> > +else
> >> > +  has_kvm =false
> >> > +endif
> >> 
> >> This is not right. Checking /dev/kvm at configure time doesn't ensure it
> >> will be present at test runtime. It also doesn't account for builds with
> >
> > Why the test runtime would be a different host versus whoever setup the
> > meson build?
> >
> 
> User permissions, containers, configuration changes in between build
> time and runtime, etc.

I was thinking there's no way in CI that it can be done separately.  But
yeah I don't know well on CI.. so if it can happen easily that's a problem.

> 
> Also, it's quite convenient to be able to pass any QEMU binary to any
> version of the tests, I do that with downstream builds sometimes.

IIUC we're only talking about "meson test" behavior, I assume
migration-test should be mostly unaffected on how it'll be used, except
that indeed we're changing "how to define quick/slow tests".  More below.

> 
> >> CONFIG_KVM=n or builds without both KVM and TCG. This needs to be done
> >> inside the test.
> >
> > This is true, but IIUC that's not a blocker, as we can use (btw, I found
> > fs.exists() a better alternative than my previous hack):
> >
> > if fs.exists('/dev/kvm') and 'CONFIG_KVM' in config_all_accel
> >   has_kvm = true
> > else
> >   has_kvm = false
> > endif
> >
> 
> I dislike this, however I'm thinking what's the worse that could happen
> if there's a mismatch between configure and runtime? We'd just run a
> different set of tests.
> 
> Can we make it:
> 
> meson.build:
>   # If there's KVM support, run the full set of migration tests as KVM
>   # hosts tend to use more migration features than just save/restore.
>   if fs.exists('/dev/kvm')
>     migration_test_args = "--full"

So IMHO we could go "-m slow | -m thorough" here, as mentioned above, just
to avoid making it a matrix of (--full, -m) combinations.

Then move all old slow tests into (just to avoid using "slow" as a word):

  if (getenv("QEMU_MIG_TEST_EXTRA")) ...

And rename FLAKY into:

  if (getenv("QEMU_MIG_TEST_FLAKY")) ...

Then we test it with QEMU_MIG_TEST_FLAKY=1 and QEMU_MIG_TEST_EXTRA=1 if we
want all tests.

>   endif
> 
> cmdline invocations:
>   ./migration-test                 # runs smoke, i.e. level 1
>   ./migration-test -m slow         # runs smoke only, no slow tests in the smoke set
>   FLAKY=1 ./migration-test         # runs smoke only, no flaky tests in the smoke set
> 
>   ./migration-test --full          # runs full set, i.e. level 2
>   ./migration-test --full -m slow  # runs full set + slow tests
>   FLAKY=1 ./migration-test --full  # runs full set + flaky tests
> 
> I made the first one like that so the compat tests in CI now run less
> tests. We don't need full set during compat because that job is about
> catching changes in device code. It would also make the argument easier
> to enable the compat job for all migration-test-supported archs.
> 
> >> 
> >> I think the best we can do is have a qtest_migration_level_<ARCH> and
> >> set it for every arch.
> >> 
> >> Also note that we must keep plain 'migration-test' invocation working
> >> because of the compat test.
> >
> > We won't break it if we only switch to levels, right?
> >
> > Btw, I also don't know why we need to.  IIRC the compat test runs the test
> > in previous release (but only feeds the new QEMU binary to the old
> > migration-test)?  I think that's one reason why we decided to use the old
> > migration-test (so we won't have new tests ran on compat tests, which is a
> > loss), just to avoid any change in migration-test will break the compat
> > test.. so I assume that should be fine regardless..
> 
> I meant we shouldn't break the command line invocation:
> 
> ./tests/qtest/migration-test -p <test_name>
> 
> As in, we cannot change the test name or add mandatory flags. Otherwise
> we have a discrepancy betweem what the CI job is calling vs. what the
> build actually provides. We run the tests from the previous build, but
> the CI job is current.

I failed to follow here.  Our CI doesn't hardcode any <test_name>, right?
It should invoke "migration-test" in the old build, feeding new QEMU binary
to it, run whatever are there in the old test.

> 
> Another point that is more of an annoyance is that the migration-test
> invocation not being stable affectes debug, bisect, etc. When debugging
> the recent multifd regression I already had to keep changing from
> /multifd/tcp/... to /multifd/tcp/uri/... when changing QEMU versions.

So I could have missed something above, and I can understand this adds
burden to bisections.  However I do prefer we can change test path any way
we want (even if in most cases we shouldn't ever touch them, and we should
still try to not change them as frequent).  IOW we also need to consider
the overhead of keeping test paths to be part of ABI as well.

-- 
Peter Xu


