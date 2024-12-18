Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01749E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 20:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO0ZE-0004HQ-VN; Wed, 18 Dec 2024 15:22:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tO0ZC-00048B-GU
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 15:22:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tO0ZA-0000Vs-6d
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 15:22:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734553361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sbTFyEUFj5Gb2diz9tKDOY+CTlRvFOJxJ6AbMc03kVY=;
 b=h1SYE18bl136bEIPX5z71lluVt6TKD4lJsZD/aTlLJRcj3NfuoVeQmXISjd7gKtt5I9xOW
 SRPYp+1B9YhHheVjKdwwlQ3jNpHFXSBYN2+mF1e5hxMCuYHJzWJ/brAyo22vlG5NxOy64b
 20oOOWW9QYzTVw41cVjnJouQKsa0rk0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-fvEYWbDvN5uQHBAg1K_Edw-1; Wed, 18 Dec 2024 15:22:37 -0500
X-MC-Unique: fvEYWbDvN5uQHBAg1K_Edw-1
X-Mimecast-MFC-AGG-ID: fvEYWbDvN5uQHBAg1K_Edw
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4679becb47eso41250221cf.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 12:22:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734553357; x=1735158157;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sbTFyEUFj5Gb2diz9tKDOY+CTlRvFOJxJ6AbMc03kVY=;
 b=AQlkA/u9aLmcDLvRBn1AwEDhxN3wnHNUMYq5CI4e9FYrqawvxXfqtyYgcSMQ+l0Uvu
 XJXSpOq7VKayrY5+zG0sZ2X77971FiAd3yOW1TG1f0kG3R7XHECqkKTwSXeymsjVbuuH
 U33T0bZWBUAlUnl6i07YdcZzH1tpDq2/e/iqQDC94sypy7XvX74lFA6d1bqtKOAexvAR
 Gk4zz7KTgHbcMrIAYY7JdpkTi1dF9znXxs0bdBUYN8Bg7/VLkfxWC7f6xvv94wmWrtO1
 Wy/QHamoSPgOWAgTuC3NWANx9M8+iZqy0jd3NxgFE6eHrp2DeqVoMEzDTDTsNVBXS74t
 wQQw==
X-Gm-Message-State: AOJu0YyqJtZutG1b54Iimp0m0Xr9r6E+pmvjWRnfcnRg0jh2ykodDAQj
 gyCAltZ5Vjhyc+N6YXPG1haCe6N0/McXdT1XIHNZejVANkwzHIWOFfVz0YF16tjKTFhfV1jwtm1
 0sY7GzR/7VMmrieCMDPj+ezzXenwGtgZi7TASu+ceGTy0sis3zRYf
X-Gm-Gg: ASbGncuWbvIgXqhj6Edx2xOU//RHnyCZzg/u684uyPByjOGeLe58zuwqcQbuaMkbnyk
 5rwQUJWgqYKoKuWAYl5rb0mKqq6d0taTvXXy715EvCc4zc63o7A/5jJNBtyGvSFvSsIv+W1uj5u
 9xmR8SInhmlDiUNTDt4Uiz+D8rjj3gA0ylrWAwRQFngOupbgKcJFeDfF0VoUkba44s9lBsX8tp0
 6/46ZH14XJahthhDysP+0OiKJ7D8N/ZcU5NXiNnu/klq3Ym0jAM4zBHCPlHvcqVEbEIunU6dwuu
 bEN8RRZIZ5TtQgyGyg==
X-Received: by 2002:a05:622a:60f:b0:467:48f3:3452 with SMTP id
 d75a77b69052e-46a3a924777mr16647231cf.56.1734553357057; 
 Wed, 18 Dec 2024 12:22:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMsobJnVvWQKhs9z6wmB43AlIm5kAxDsE5HDE5Gk8eJwiInEqDLWJxH9gm57Rx4vwfzZfhpg==
X-Received: by 2002:a05:622a:60f:b0:467:48f3:3452 with SMTP id
 d75a77b69052e-46a3a924777mr16646841cf.56.1734553356668; 
 Wed, 18 Dec 2024 12:22:36 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467b2ca620bsm54493181cf.31.2024.12.18.12.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 12:22:35 -0800 (PST)
Date: Wed, 18 Dec 2024 15:22:33 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 19/22] tests/qtest/migration: Add migration-test-smoke
Message-ID: <Z2MvCRYKLmYCj55i@x1n>
References: <20241113194630.3385-1-farosas@suse.de>
 <20241113194630.3385-20-farosas@suse.de> <Z2MKesakYn3fn2ue@x1n>
 <87h670vozv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h670vozv.fsf@suse.de>
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

On Wed, Dec 18, 2024 at 03:13:08PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Nov 13, 2024 at 04:46:27PM -0300, Fabiano Rosas wrote:
> >> diff --git a/tests/qtest/migration-test-smoke.c b/tests/qtest/migration-test-smoke.c
> >> new file mode 100644
> >> index 0000000000..ff2d72881f
> >> --- /dev/null
> >> +++ b/tests/qtest/migration-test-smoke.c
> >> @@ -0,0 +1,39 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> >> +
> >> +#include "qemu/osdep.h"
> >> +#include "libqtest.h"
> >> +#include "migration/test-framework.h"
> >> +#include "qemu/module.h"
> >> +
> >> +int main(int argc, char **argv)
> >> +{
> >> +    MigrationTestEnv *env;
> >> +    int ret;
> >> +
> >> +    g_test_init(&argc, &argv, NULL);
> >> +    env = migration_get_env();
> >> +    module_call_init(MODULE_INIT_QOM);
> >> +
> >> +    if (env->has_kvm) {
> >> +        g_test_message(
> >> +            "Smoke tests already run as part of the full suite on KVM hosts");
> >> +        goto out;
> >> +    }
> >
> > So the "smoke" here is almost "tcg".. and if i want to run a smoke test on
> > a kvm-enabled host, it's noop.. which isn't easy to understand why.
> >
> > If to rethink our goal, we have two requirements:
> >
> >   (1) We want to categorize migration tests, so some are quick, some are
> >       slow, some might be flacky.  Maybe more, but it's about putting one
> >       test into only one bucket, and there're >1 buckets.
> 
> It's true that the smoke test should never have slow or flaky tests, but
> we can't use this categorization for anything else. IOW, what you
> describe here is not a goal. If a test is found to be slow we put it
> under slow and it will only run with -m slow/thorough, that's it. We can
> just ignore this.

I could have missed something, but I still think it's the same issue.  In
general, I think we want to provide different levels of tests, like:

  - Level 1: the minimum set of tests (aka, the "smoke" idea here)
  - Level 2: normal set of tests (aka, whatever we used to run by default)
  - Level 3: slow tests (aka, only ran with '-m slow' before)
  - Level 4: flaky tests (aka, only ran when QEMU_TEST_FLAKY_TESTS set)

Then we want to run level1 test only in tcg, and level1+2 in kvm.  We can
only trigger level 1-3 or level 1-4 in manual tests.

We used to have different way to provide the level idea, now I think we can
consider provide that level in migration-test in one shot.  Obviously it's
more than quick/slow so I don't think we can reuse "-m", but we can add our
own test level "--level" parameter, so --level N means run all tests lower
than level N, for example.

> 
> >
> >   (2) We want to run only a small portion of tests on tcg, more tests on
> >       kvm.
> 
> Yes. Guests are fast with KVM and slow with TCG (generally) and the KVM
> hosts are the ones where it's actually important to ensure all migration
> features work OK. Non-KVM will only care about save/restore of
> snapshots. Therefore we don't need to have all tests running with TCG,
> only the smoke set.
> 
> And "smoke set" is arbitrary, not tied to speed, but of course no slow
> tests please (which already happens because we don't pass -m slow to
> migration-test-smoke).
> 
> >
> > Ideally, we don't need two separate main test files, do we?
> >
> > I mean, we can do (1) with the existing migration-test.c, with the help of
> > either gtest's "-m" or something we invent.  The only unfortunate part is
> > qtest only have quick/slow, afaiu the "thorough" mode is the same as
> > "slow".. while we don't yet have real "perf" tests.  It means we only have
> > two buckets if we want to reuse gtest's "-m".
> >
> > Maybe it's enough?  If not, we can implement >2 categories in whatever
> > form, either custom argv/argc cmdline, or env variable.
> >
> > Then, if we always categorize one test (let me try to not reuse glib's
> > terms to be clear) into any of: FAST|NORMAL|SLOW|..., then we have a single
> 
> It's either normal or slow. Because we only know a test is only after it
> bothers us.

So I wonder if we can provide four levels, as above.. and define it for
each test in migration-test.

> 
> > migration-test that have different level of tests.  We can invoke
> > "migration-test --mode FAST" if kvm is not supported, and invoke the same
> > "migration-test --mode SLOW" if kvm is supported.
> 
> This is messy due to how qtest/meson.build works. Having two tests is
> the clean change. Otherwise we'll have to add "if migration-test" or
> create artificial test names to be able to restrict the arguments that
> are passed to the test per arch.

Indeed it'll need a few extra lines in meson, but it doesn't look too bad,
but yeah if anyone is not happy with it we can rethink.  I just want to
know whether it's still acceptable.

I tried to code it up, it looks like this:

====8<====
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index c5a70021c5..5bec33b627 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -392,6 +392,12 @@ if dbus_display
   qtests += {'dbus-display-test': [dbus_display1, gio]}
 endif
 
+if run_command('test', '-e', '/dev/kvm', check: false).returncode() == 0
+  has_kvm = true
+else
+  has_kvm =false
+endif
+
 qtest_executables = {}
 foreach dir : target_dirs
   if not dir.endswith('-softmmu')
@@ -434,11 +440,21 @@ foreach dir : target_dirs
         test: executable(test, src, dependencies: deps)
       }
     endif
+    test_args = ['--tap', '-k']
+    if test == 'migration-test'
+      if host_os == 'linux' and cpu == target_base and has_kvm
+        # Only run full migration test if host kvm supported
+        test_args += ['-m', 'thorough']
+      else
+        test_args += ['-m', 'quick']
+      endif
+    endif
+
     test('qtest-@0@/@1@'.format(target_base, test),
          qtest_executables[test],
          depends: [test_deps, qtest_emulator, emulator_modules],
          env: qtest_env,
-         args: ['--tap', '-k'],
+         args: test_args,
          protocol: 'tap',
          timeout: slow_qtests.get(test, 60),
          priority: slow_qtests.get(test, 60),
====8<====

I still used "-m" but just to show the idea.  I also wonder whether other
tests would have similar demands.. otherwise are we destined to not be able
to use qtest cmdline at all as long as we use meson?

> 
> I also *think* we cannot have anything extra in argv because gtester
> expects to be able to parse those.

We can definitely hijack argv/argc before passing it over to glib.

> 
> >
> > Would this be nicer?  At least we can still run a pretty fast smoke / FAST
> > test even on kvm. Basically, untangle accel v.s. "test category".
> 
> We could just remove the restriction from migration-test-smoke if that's
> an issue.

Not the only issue, but the idea of it. In general, IMHO it'll be good we
don't attach host info to a test program.

IOW, I want to keep the test in a way so that we'll be able to run whatever
level of test on whatever host, at least when when I run migration-test
manually.

So e.g. I also want to be able to run full set of tests on TCG too whenever
needed.  So I still feel like we mangled these two issues together which
might be unnecessarily.

-- 
Peter Xu


