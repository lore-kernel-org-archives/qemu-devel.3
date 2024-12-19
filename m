Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E68DE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJK1-00050i-Kn; Thu, 19 Dec 2024 11:24:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tOIbR-000433-3z
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:38:17 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tOIbO-0004JB-A8
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:38:16 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7647321108;
 Thu, 19 Dec 2024 15:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734622689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3FptKihuQWbLDNku13oJrADqvpBQ8JPu/cLh+53hVZc=;
 b=ob20YaDUErkG0RsMMgCxELsLKgBI6vkV/pDspUuwvAMgQzSYkwx/AZ4yhXmAce0ZnLa4AR
 eboteYW0H3u876JOae9nEnr/mAq8Q38/muaEj/ElQJGxdvcKXKXeJUG78g4/TZ6xA1RhuU
 TTr0JGP8yGr5p6DAQtBtkKgUAMFy7PA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734622689;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3FptKihuQWbLDNku13oJrADqvpBQ8JPu/cLh+53hVZc=;
 b=OElxSrkBKXHAhRlWeLkiqy/XXec+I295UXrORiDcHL7+rh98Si2G/BinUZ56+E5jMvCJpr
 /VKKWQP43BlsdhCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734622688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3FptKihuQWbLDNku13oJrADqvpBQ8JPu/cLh+53hVZc=;
 b=GCJiqnkfL8/oXVFTA81xRdjSF53GxI6+2pJ6nOXIiqlroyhiWAHRDrAtwtb0tZRf7alyXv
 4Hcb400HRlXvpcO22i+x2ol2bmA4VlVPHG1jVBq5Kq6PgOeapxpUO1JAfYrPvidK7feuUx
 l59allmv4yLZQQGXmaFY8pFQ1rzg2SU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734622688;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3FptKihuQWbLDNku13oJrADqvpBQ8JPu/cLh+53hVZc=;
 b=yf+K4PRbGpjmh2wrEXPpvM5YkXoYhtsJ9K6f1LaJy/vqBJyogeaijx6fPk/i2o3JhuEZZG
 VVf2clYc268iHgBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F169C13A77;
 Thu, 19 Dec 2024 15:38:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tTgdLd89ZGcJPgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 19 Dec 2024 15:38:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 19/22] tests/qtest/migration: Add migration-test-smoke
In-Reply-To: <Z2NHBQc9ixuvJ3k_@x1n>
References: <20241113194630.3385-1-farosas@suse.de>
 <20241113194630.3385-20-farosas@suse.de> <Z2MKesakYn3fn2ue@x1n>
 <87h670vozv.fsf@suse.de> <Z2MvCRYKLmYCj55i@x1n> <875xngvgwe.fsf@suse.de>
 <Z2NHBQc9ixuvJ3k_@x1n>
Date: Thu, 19 Dec 2024 12:38:05 -0300
Message-ID: <8734ijvg2q.fsf@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

> On Wed, Dec 18, 2024 at 06:08:01PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Wed, Dec 18, 2024 at 03:13:08PM -0300, Fabiano Rosas wrote:
>> >> Peter Xu <peterx@redhat.com> writes:
>> >> 
>> >> > On Wed, Nov 13, 2024 at 04:46:27PM -0300, Fabiano Rosas wrote:
>> >> >> diff --git a/tests/qtest/migration-test-smoke.c b/tests/qtest/migration-test-smoke.c
>> >> >> new file mode 100644
>> >> >> index 0000000000..ff2d72881f
>> >> >> --- /dev/null
>> >> >> +++ b/tests/qtest/migration-test-smoke.c
>> >> >> @@ -0,0 +1,39 @@
>> >> >> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> >> >> +
>> >> >> +#include "qemu/osdep.h"
>> >> >> +#include "libqtest.h"
>> >> >> +#include "migration/test-framework.h"
>> >> >> +#include "qemu/module.h"
>> >> >> +
>> >> >> +int main(int argc, char **argv)
>> >> >> +{
>> >> >> +    MigrationTestEnv *env;
>> >> >> +    int ret;
>> >> >> +
>> >> >> +    g_test_init(&argc, &argv, NULL);
>> >> >> +    env = migration_get_env();
>> >> >> +    module_call_init(MODULE_INIT_QOM);
>> >> >> +
>> >> >> +    if (env->has_kvm) {
>> >> >> +        g_test_message(
>> >> >> +            "Smoke tests already run as part of the full suite on KVM hosts");
>> >> >> +        goto out;
>> >> >> +    }
>> >> >
>> >> > So the "smoke" here is almost "tcg".. and if i want to run a smoke test on
>> >> > a kvm-enabled host, it's noop.. which isn't easy to understand why.
>> >> >
>> >> > If to rethink our goal, we have two requirements:
>> >> >
>> >> >   (1) We want to categorize migration tests, so some are quick, some are
>> >> >       slow, some might be flacky.  Maybe more, but it's about putting one
>> >> >       test into only one bucket, and there're >1 buckets.
>> >> 
>> >> It's true that the smoke test should never have slow or flaky tests, but
>> >> we can't use this categorization for anything else. IOW, what you
>> >> describe here is not a goal. If a test is found to be slow we put it
>> >> under slow and it will only run with -m slow/thorough, that's it. We can
>> >> just ignore this.
>> >
>> > I could have missed something, but I still think it's the same issue.  In
>> > general, I think we want to provide different levels of tests, like:
>> >
>> >   - Level 1: the minimum set of tests (aka, the "smoke" idea here)
>> >   - Level 2: normal set of tests (aka, whatever we used to run by default)
>> >   - Level 3: slow tests (aka, only ran with '-m slow' before)
>> 
>> How are you going to make this one work? 'migration-test --level 3'
>> vs. 'migration-test --level 3 -m slow' vs. 'migration-test -m slow'
>> 
>> The only way I can see is to not have a level 3 at all and just use -m
>> slow.
>
> I meant remove "-m" and remove QEMU_TEST_FLAKY_TESTS, instead replacing all
> of them using --level.  Then migration-test ignores '-m' in the future
> because it's simply not enough for us.
>

Even if we remove -m, it will still be passed in when people run make
SPEED=slow check and people who know about glib/qtests will continue to
try to use it.

Ignoring -m and FLAKY will create a diversion from the rest of qtest and
QEMU tests in general. I think the best approach is to drop levels 3 and
4 from this proposal and just ignore those options altogether.

If we're going to have a single binary as you suggest, then there's no
harm still using -m slow and FLAKY as usual. We call level 1: "smoke
tests", level 2: "full set" and we put in some code to prevent
registering a smoke test as slow or flaky and that's it.

... and of course, if there's only two levels, then we only need a
boolean flag: --full

IOW, I still don't think slow and flaky have anything to do with what
we're trying to do here. I do appreciate that a single binary is better
than two.

>> 
>> >   - Level 4: flaky tests (aka, only ran when QEMU_TEST_FLAKY_TESTS set)
>> >
>> > Then we want to run level1 test only in tcg, and level1+2 in kvm.  We can
>> > only trigger level 1-3 or level 1-4 in manual tests.
>> >
>> > We used to have different way to provide the level idea, now I think we can
>> > consider provide that level in migration-test in one shot.  Obviously it's
>> > more than quick/slow so I don't think we can reuse "-m", but we can add our
>> >
>> > own test level "--level" parameter, so --level N means run all tests lower
>> > than level N, for example.
>> >
>> 
>> I'm not sure that works semantically for level 4. Because the reason one
>> runs flaky tests is different from the reason one runs the other
>> tests. So we probably don't want to run a bunch of tests just to get to
>> the broken ones.
>> 
>> But we don't need to spend too much time on this. I hate the idea of
>> flaky tests anyway. Whatever we choose they'll just sit there doing
>> nothing.
>
> Yes how to treat flaky tests isn't important yet.  If we don't care about
> QEMU_TEST_FLAKY_TESTS then we make it three levels.  The idea is the same.
>
>> 
>> >> 
>> >> >
>> >> >   (2) We want to run only a small portion of tests on tcg, more tests on
>> >> >       kvm.
>> >> 
>> >> Yes. Guests are fast with KVM and slow with TCG (generally) and the KVM
>> >> hosts are the ones where it's actually important to ensure all migration
>> >> features work OK. Non-KVM will only care about save/restore of
>> >> snapshots. Therefore we don't need to have all tests running with TCG,
>> >> only the smoke set.
>> >> 
>> >> And "smoke set" is arbitrary, not tied to speed, but of course no slow
>> >> tests please (which already happens because we don't pass -m slow to
>> >> migration-test-smoke).
>> >> 
>> >> >
>> >> > Ideally, we don't need two separate main test files, do we?
>> >> >
>> >> > I mean, we can do (1) with the existing migration-test.c, with the help of
>> >> > either gtest's "-m" or something we invent.  The only unfortunate part is
>> >> > qtest only have quick/slow, afaiu the "thorough" mode is the same as
>> >> > "slow".. while we don't yet have real "perf" tests.  It means we only have
>> >> > two buckets if we want to reuse gtest's "-m".
>> >> >
>> >> > Maybe it's enough?  If not, we can implement >2 categories in whatever
>> >> > form, either custom argv/argc cmdline, or env variable.
>> >> >
>> >> > Then, if we always categorize one test (let me try to not reuse glib's
>> >> > terms to be clear) into any of: FAST|NORMAL|SLOW|..., then we have a single
>> >> 
>> >> It's either normal or slow. Because we only know a test is only after it
>> >> bothers us.
>> >
>> > So I wonder if we can provide four levels, as above.. and define it for
>> > each test in migration-test.
>> >
>> >> 
>> >> > migration-test that have different level of tests.  We can invoke
>> >> > "migration-test --mode FAST" if kvm is not supported, and invoke the same
>> >> > "migration-test --mode SLOW" if kvm is supported.
>> >> 
>> >> This is messy due to how qtest/meson.build works. Having two tests is
>> >> the clean change. Otherwise we'll have to add "if migration-test" or
>> >> create artificial test names to be able to restrict the arguments that
>> >> are passed to the test per arch.
>> >
>> > Indeed it'll need a few extra lines in meson, but it doesn't look too bad,
>> > but yeah if anyone is not happy with it we can rethink.  I just want to
>> > know whether it's still acceptable.
>> >
>> > I tried to code it up, it looks like this:
>> >
>> > ====8<====
>> > diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>> > index c5a70021c5..5bec33b627 100644
>> > --- a/tests/qtest/meson.build
>> > +++ b/tests/qtest/meson.build
>> > @@ -392,6 +392,12 @@ if dbus_display
>> >    qtests += {'dbus-display-test': [dbus_display1, gio]}
>> >  endif
>> >  
>> > +if run_command('test', '-e', '/dev/kvm', check: false).returncode() == 0
>> > +  has_kvm = true
>> > +else
>> > +  has_kvm =false
>> > +endif
>> 
>> This is not right. Checking /dev/kvm at configure time doesn't ensure it
>> will be present at test runtime. It also doesn't account for builds with
>
> Why the test runtime would be a different host versus whoever setup the
> meson build?
>

User permissions, containers, configuration changes in between build
time and runtime, etc.

Also, it's quite convenient to be able to pass any QEMU binary to any
version of the tests, I do that with downstream builds sometimes.

>> CONFIG_KVM=n or builds without both KVM and TCG. This needs to be done
>> inside the test.
>
> This is true, but IIUC that's not a blocker, as we can use (btw, I found
> fs.exists() a better alternative than my previous hack):
>
> if fs.exists('/dev/kvm') and 'CONFIG_KVM' in config_all_accel
>   has_kvm = true
> else
>   has_kvm = false
> endif
>

I dislike this, however I'm thinking what's the worse that could happen
if there's a mismatch between configure and runtime? We'd just run a
different set of tests.

Can we make it:

meson.build:
  # If there's KVM support, run the full set of migration tests as KVM
  # hosts tend to use more migration features than just save/restore.
  if fs.exists('/dev/kvm')
    migration_test_args = "--full"
  endif

cmdline invocations:
  ./migration-test                 # runs smoke, i.e. level 1
  ./migration-test -m slow         # runs smoke only, no slow tests in the smoke set
  FLAKY=1 ./migration-test         # runs smoke only, no flaky tests in the smoke set

  ./migration-test --full          # runs full set, i.e. level 2
  ./migration-test --full -m slow  # runs full set + slow tests
  FLAKY=1 ./migration-test --full  # runs full set + flaky tests

I made the first one like that so the compat tests in CI now run less
tests. We don't need full set during compat because that job is about
catching changes in device code. It would also make the argument easier
to enable the compat job for all migration-test-supported archs.

>> 
>> I think the best we can do is have a qtest_migration_level_<ARCH> and
>> set it for every arch.
>> 
>> Also note that we must keep plain 'migration-test' invocation working
>> because of the compat test.
>
> We won't break it if we only switch to levels, right?
>
> Btw, I also don't know why we need to.  IIRC the compat test runs the test
> in previous release (but only feeds the new QEMU binary to the old
> migration-test)?  I think that's one reason why we decided to use the old
> migration-test (so we won't have new tests ran on compat tests, which is a
> loss), just to avoid any change in migration-test will break the compat
> test.. so I assume that should be fine regardless..

I meant we shouldn't break the command line invocation:

./tests/qtest/migration-test -p <test_name>

As in, we cannot change the test name or add mandatory flags. Otherwise
we have a discrepancy betweem what the CI job is calling vs. what the
build actually provides. We run the tests from the previous build, but
the CI job is current.

Another point that is more of an annoyance is that the migration-test
invocation not being stable affectes debug, bisect, etc. When debugging
the recent multifd regression I already had to keep changing from
/multifd/tcp/... to /multifd/tcp/uri/... when changing QEMU versions.

