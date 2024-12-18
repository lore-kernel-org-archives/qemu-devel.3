Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1AAE7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2AG-0006Dm-10; Wed, 18 Dec 2024 17:05:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tO2AD-0006DX-Do
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:05:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tO2AB-0005Ho-77
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734559500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wDelh8jdNP8Wg3HZ0KGQumMBBKAqQ90N+I9N9Y0hcOg=;
 b=gMGKxIjuZeyBeF06SMWHYze+Jys33b7xgPEaKd779Facc9E0DwfzGuv4F/+i6KnnPI4SuT
 BmgL+9qeBXQXpxfpnxqHanGNuisvONASqo2pcB2UrCQzWXzB0RVBXWot/RUQmQU01U8xU9
 kwxzuecBqtUjZ/4E9oiLJS7dfVI+XLA=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-nTNRnGWgOfa0qoWYgDLm1A-1; Wed, 18 Dec 2024 17:04:57 -0500
X-MC-Unique: nTNRnGWgOfa0qoWYgDLm1A-1
X-Mimecast-MFC-AGG-ID: nTNRnGWgOfa0qoWYgDLm1A
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-844cffcb685so14848139f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:04:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734559497; x=1735164297;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wDelh8jdNP8Wg3HZ0KGQumMBBKAqQ90N+I9N9Y0hcOg=;
 b=VBbj7yZXuuXrY4LyscSDsDaxSvO8C0jLimNUx+9zN+4JzzNHGqSkftFo29XvZ0/T4B
 Cy/AgpMAOvBW5R/4qbOVh39s2IC+CIhU6YpZOefeQT2gMZfOP8u7NT27QTPrqeBy7K/m
 PnwnZFw55gnAHTOzU/6Nh/qtc1e+B/gGp8AJU5QJllmkS+/K0M1oR50ld/3f9fYHncly
 Q6NMgtQm57vvaoHF60od9pE45yQHSVbjJ36P8Q6OGmmiYkL88kW0MFEzTNcwNblQA875
 MieGzlJEhjkMoSFDOQQKKcZkb4UyT22Krz2BaGwOHrKG1KZxrf1o73eJbfGvpVn69us0
 ptwA==
X-Gm-Message-State: AOJu0Yytuo4Ih8S4Wc/yxn1sy8dlilZIfcJnjwt6q4LRSHP5VlYTVYLP
 8EciGBLDN0fYQF7IdIHJufSuwkgB43Jy7qr5rxp44VBaYmAYmTAHcKwTX8hlLIJoSu1gFyWqh90
 l7k8mE4rEoppvfIvchsUTv6ftUud+ykLZN0ytFHVxcAZ5HbMZ2kO2
X-Gm-Gg: ASbGnctiNaq6+lxziwyvmiESrel5TYwzxhAjo79dzO4aW2+w3ukHcaHx8+bwbVZv6ea
 nW4v7acdBl9zeTPEZ0RvNdkeDoB2icNKR6nItbIBzw8IWL+C2uEyiEsBhbc54pPTFuKuBMSFFyE
 Th6X+yxAra4eOrLMbA/TjoWAEpLc29ZJbwOXnzpSG0w5619zA4k1M0fvQl1h3b9pCkF5GMXarCi
 LW8Cz9UEDcfVWrv2ZtoXY+bUXUup46MaS2d0JiiUWtPM+k4Eh8K9biu1hvkV7hDrJaandTo3K8L
 /2sEln+22hdEs5x3rw==
X-Received: by 2002:a05:6602:2c88:b0:803:5e55:ecb2 with SMTP id
 ca18e2360f4ac-8475831e21emr480947239f.0.1734559496700; 
 Wed, 18 Dec 2024 14:04:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDXF+/V/OBCBEwiF/8Ie8W6gU/IK+NCnAvfPxpl8mE97lgbXe/PPCpNEgwNQ1nTIHHloUYOQ==
X-Received: by 2002:a05:6602:2c88:b0:803:5e55:ecb2 with SMTP id
 ca18e2360f4ac-8475831e21emr480945239f.0.1734559496248; 
 Wed, 18 Dec 2024 14:04:56 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e5e3c69bd4sm2430275173.148.2024.12.18.14.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:04:55 -0800 (PST)
Date: Wed, 18 Dec 2024 17:04:53 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 19/22] tests/qtest/migration: Add migration-test-smoke
Message-ID: <Z2NHBQc9ixuvJ3k_@x1n>
References: <20241113194630.3385-1-farosas@suse.de>
 <20241113194630.3385-20-farosas@suse.de> <Z2MKesakYn3fn2ue@x1n>
 <87h670vozv.fsf@suse.de> <Z2MvCRYKLmYCj55i@x1n>
 <875xngvgwe.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875xngvgwe.fsf@suse.de>
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

On Wed, Dec 18, 2024 at 06:08:01PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Dec 18, 2024 at 03:13:08PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Wed, Nov 13, 2024 at 04:46:27PM -0300, Fabiano Rosas wrote:
> >> >> diff --git a/tests/qtest/migration-test-smoke.c b/tests/qtest/migration-test-smoke.c
> >> >> new file mode 100644
> >> >> index 0000000000..ff2d72881f
> >> >> --- /dev/null
> >> >> +++ b/tests/qtest/migration-test-smoke.c
> >> >> @@ -0,0 +1,39 @@
> >> >> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> >> >> +
> >> >> +#include "qemu/osdep.h"
> >> >> +#include "libqtest.h"
> >> >> +#include "migration/test-framework.h"
> >> >> +#include "qemu/module.h"
> >> >> +
> >> >> +int main(int argc, char **argv)
> >> >> +{
> >> >> +    MigrationTestEnv *env;
> >> >> +    int ret;
> >> >> +
> >> >> +    g_test_init(&argc, &argv, NULL);
> >> >> +    env = migration_get_env();
> >> >> +    module_call_init(MODULE_INIT_QOM);
> >> >> +
> >> >> +    if (env->has_kvm) {
> >> >> +        g_test_message(
> >> >> +            "Smoke tests already run as part of the full suite on KVM hosts");
> >> >> +        goto out;
> >> >> +    }
> >> >
> >> > So the "smoke" here is almost "tcg".. and if i want to run a smoke test on
> >> > a kvm-enabled host, it's noop.. which isn't easy to understand why.
> >> >
> >> > If to rethink our goal, we have two requirements:
> >> >
> >> >   (1) We want to categorize migration tests, so some are quick, some are
> >> >       slow, some might be flacky.  Maybe more, but it's about putting one
> >> >       test into only one bucket, and there're >1 buckets.
> >> 
> >> It's true that the smoke test should never have slow or flaky tests, but
> >> we can't use this categorization for anything else. IOW, what you
> >> describe here is not a goal. If a test is found to be slow we put it
> >> under slow and it will only run with -m slow/thorough, that's it. We can
> >> just ignore this.
> >
> > I could have missed something, but I still think it's the same issue.  In
> > general, I think we want to provide different levels of tests, like:
> >
> >   - Level 1: the minimum set of tests (aka, the "smoke" idea here)
> >   - Level 2: normal set of tests (aka, whatever we used to run by default)
> >   - Level 3: slow tests (aka, only ran with '-m slow' before)
> 
> How are you going to make this one work? 'migration-test --level 3'
> vs. 'migration-test --level 3 -m slow' vs. 'migration-test -m slow'
> 
> The only way I can see is to not have a level 3 at all and just use -m
> slow.

I meant remove "-m" and remove QEMU_TEST_FLAKY_TESTS, instead replacing all
of them using --level.  Then migration-test ignores '-m' in the future
because it's simply not enough for us.

> 
> >   - Level 4: flaky tests (aka, only ran when QEMU_TEST_FLAKY_TESTS set)
> >
> > Then we want to run level1 test only in tcg, and level1+2 in kvm.  We can
> > only trigger level 1-3 or level 1-4 in manual tests.
> >
> > We used to have different way to provide the level idea, now I think we can
> > consider provide that level in migration-test in one shot.  Obviously it's
> > more than quick/slow so I don't think we can reuse "-m", but we can add our
> >
> > own test level "--level" parameter, so --level N means run all tests lower
> > than level N, for example.
> >
> 
> I'm not sure that works semantically for level 4. Because the reason one
> runs flaky tests is different from the reason one runs the other
> tests. So we probably don't want to run a bunch of tests just to get to
> the broken ones.
> 
> But we don't need to spend too much time on this. I hate the idea of
> flaky tests anyway. Whatever we choose they'll just sit there doing
> nothing.

Yes how to treat flaky tests isn't important yet.  If we don't care about
QEMU_TEST_FLAKY_TESTS then we make it three levels.  The idea is the same.

> 
> >> 
> >> >
> >> >   (2) We want to run only a small portion of tests on tcg, more tests on
> >> >       kvm.
> >> 
> >> Yes. Guests are fast with KVM and slow with TCG (generally) and the KVM
> >> hosts are the ones where it's actually important to ensure all migration
> >> features work OK. Non-KVM will only care about save/restore of
> >> snapshots. Therefore we don't need to have all tests running with TCG,
> >> only the smoke set.
> >> 
> >> And "smoke set" is arbitrary, not tied to speed, but of course no slow
> >> tests please (which already happens because we don't pass -m slow to
> >> migration-test-smoke).
> >> 
> >> >
> >> > Ideally, we don't need two separate main test files, do we?
> >> >
> >> > I mean, we can do (1) with the existing migration-test.c, with the help of
> >> > either gtest's "-m" or something we invent.  The only unfortunate part is
> >> > qtest only have quick/slow, afaiu the "thorough" mode is the same as
> >> > "slow".. while we don't yet have real "perf" tests.  It means we only have
> >> > two buckets if we want to reuse gtest's "-m".
> >> >
> >> > Maybe it's enough?  If not, we can implement >2 categories in whatever
> >> > form, either custom argv/argc cmdline, or env variable.
> >> >
> >> > Then, if we always categorize one test (let me try to not reuse glib's
> >> > terms to be clear) into any of: FAST|NORMAL|SLOW|..., then we have a single
> >> 
> >> It's either normal or slow. Because we only know a test is only after it
> >> bothers us.
> >
> > So I wonder if we can provide four levels, as above.. and define it for
> > each test in migration-test.
> >
> >> 
> >> > migration-test that have different level of tests.  We can invoke
> >> > "migration-test --mode FAST" if kvm is not supported, and invoke the same
> >> > "migration-test --mode SLOW" if kvm is supported.
> >> 
> >> This is messy due to how qtest/meson.build works. Having two tests is
> >> the clean change. Otherwise we'll have to add "if migration-test" or
> >> create artificial test names to be able to restrict the arguments that
> >> are passed to the test per arch.
> >
> > Indeed it'll need a few extra lines in meson, but it doesn't look too bad,
> > but yeah if anyone is not happy with it we can rethink.  I just want to
> > know whether it's still acceptable.
> >
> > I tried to code it up, it looks like this:
> >
> > ====8<====
> > diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> > index c5a70021c5..5bec33b627 100644
> > --- a/tests/qtest/meson.build
> > +++ b/tests/qtest/meson.build
> > @@ -392,6 +392,12 @@ if dbus_display
> >    qtests += {'dbus-display-test': [dbus_display1, gio]}
> >  endif
> >  
> > +if run_command('test', '-e', '/dev/kvm', check: false).returncode() == 0
> > +  has_kvm = true
> > +else
> > +  has_kvm =false
> > +endif
> 
> This is not right. Checking /dev/kvm at configure time doesn't ensure it
> will be present at test runtime. It also doesn't account for builds with

Why the test runtime would be a different host versus whoever setup the
meson build?

> CONFIG_KVM=n or builds without both KVM and TCG. This needs to be done
> inside the test.

This is true, but IIUC that's not a blocker, as we can use (btw, I found
fs.exists() a better alternative than my previous hack):

if fs.exists('/dev/kvm') and 'CONFIG_KVM' in config_all_accel
  has_kvm = true
else
  has_kvm = false
endif

> 
> I think the best we can do is have a qtest_migration_level_<ARCH> and
> set it for every arch.
> 
> Also note that we must keep plain 'migration-test' invocation working
> because of the compat test.

We won't break it if we only switch to levels, right?

Btw, I also don't know why we need to.  IIRC the compat test runs the test
in previous release (but only feeds the new QEMU binary to the old
migration-test)?  I think that's one reason why we decided to use the old
migration-test (so we won't have new tests ran on compat tests, which is a
loss), just to avoid any change in migration-test will break the compat
test.. so I assume that should be fine regardless..

-- 
Peter Xu


