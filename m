Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E79E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 15:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOemB-0006Ko-6k; Fri, 20 Dec 2024 10:18:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tOem9-0006KQ-0F
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 10:18:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tOem5-0004Vc-UE
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 10:18:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734707924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2GhfS6zn2qLwUmA1aEd5X6u/7uURM+5lqgC0HLcidWo=;
 b=NVSD0MgXv5BqB3FZxbqt8HjumP7Czo74V5nTqKhJK7XX3/5cuh+CvysKiL2+/PgRHOycqN
 4Lp4BR1D4zJWiIj6n2vcXpaiBuFIZN1n9j+zgJTCMUYt2WdBxnxywTqjB0fcQBXgR6ZZYZ
 nAw7bvk2ER6wvFLFyw70TYsVmIwqAts=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-YT93pL3bMZO5oB_Zlr484A-1; Fri, 20 Dec 2024 10:18:41 -0500
X-MC-Unique: YT93pL3bMZO5oB_Zlr484A-1
X-Mimecast-MFC-AGG-ID: YT93pL3bMZO5oB_Zlr484A
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d87efed6c4so31292086d6.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 07:18:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734707920; x=1735312720;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2GhfS6zn2qLwUmA1aEd5X6u/7uURM+5lqgC0HLcidWo=;
 b=Z80kWJ+pwgPEYX2Rr/Q2wv705XtOKng7tybG01zl8k0yLoUecCYBQHFB3qLDKaiNcQ
 oRYE3nG1YaIL9NTUUusWY7CuwnNqup++dgbhZ1X0XT7jIlM+MlqtD8X8uTvWoq51GtUf
 bpoioBKXja+sdpVa7UaYduIu9xuc8GHmKYzxN9zCAfrPUXD/CnPM1A80YDkWDi0CJFVV
 VS/wQvJf2vUR/bAnwhc86dOoQJ0q28Y+hb+Rt7dDnsLo0s3cSqCztDAN/k3+TEq3Lsm9
 BsIWOSy/JmdIFkHeKzwGxuEXFm8DpiUgTZ/ERl9Gunvk8hG10gd6QDzQ87cbthcwEjEE
 4IEA==
X-Gm-Message-State: AOJu0YwtDDN85OyL/+8ldK+m8Oydlc3IJumVaIJpRrj82mo9ysn+t+nY
 fftYM4t9jf1a1aS3ERz4Dr03VpfMVFHOZh7lKjKx2YbnCOL0AVmFQ+QVd9C7XzzbJ0TbrOHJl3X
 5chuJ9F5Z6y78VAn59uOjwzLGnbomRpj6p4Acae3pMGNBr4i0M2Yp
X-Gm-Gg: ASbGnctf5ef/TI2JqoV4rlCLBGMIGDUs7F5gQN4Ugz61KPUbm7tqw+enWDopk5TG78K
 6vYERpHujHA+PsVxUyq0QIZCEse7ZyHKrunwMUueJvmMlMEoVld6hsSlqbOMpmVcKXKDF3bqHud
 2iybPkgOMD0NY5naQkXl3wj7gT38cfE2xXiLQUDCSD/wQf1mUqWElPl/S6UIKrkd7C6B0ES9+bm
 1Csi6B1m6U7qh/P+sLbXrndHRPzQaJs01arIMYbIrDnue6WyFJ8YcTkLICXD5qtFbv9vXZjKowU
 crUxfVvkz34UeEe1Ew==
X-Received: by 2002:a05:6214:e67:b0:6d8:a5a6:f489 with SMTP id
 6a1803df08f44-6dd2334dab7mr47930396d6.26.1734707920529; 
 Fri, 20 Dec 2024 07:18:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEr9VNrqNjzX0ufTefIwPdIlMlSHAvQXqpa9b8SaJznd5u+RdVZvc/4xpFKKTlN7vFMgjGAlA==
X-Received: by 2002:a05:6214:e67:b0:6d8:a5a6:f489 with SMTP id
 6a1803df08f44-6dd2334dab7mr47930036d6.26.1734707920164; 
 Fri, 20 Dec 2024 07:18:40 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd1810e7b6sm17850946d6.49.2024.12.20.07.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 07:18:39 -0800 (PST)
Date: Fri, 20 Dec 2024 10:18:37 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 19/22] tests/qtest/migration: Add migration-test-smoke
Message-ID: <Z2WKzdDIyiSCHI9f@x1n>
References: <20241113194630.3385-1-farosas@suse.de>
 <20241113194630.3385-20-farosas@suse.de> <Z2MKesakYn3fn2ue@x1n>
 <87h670vozv.fsf@suse.de> <Z2MvCRYKLmYCj55i@x1n>
 <875xngvgwe.fsf@suse.de> <Z2NHBQc9ixuvJ3k_@x1n>
 <8734ijvg2q.fsf@suse.de> <Z2Ra7c7svRVbYw1k@x1n>
 <87wmfvtqpz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wmfvtqpz.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Dec 19, 2024 at 04:31:04PM -0300, Fabiano Rosas wrote:
> We shouldn't change stuff that's also used by the rest of the
> community. People know about QEMU_TEST_FLAKY_TESTS and -m slow. These
> must continue to work the same.

I see what I overlook; it's used much more than I thought in qtest and we
also have a CI for it.. So ok, let's keep at least QEMU_TEST_FLAKY_TESTS.

But again, I don't think it matters much even if we rename it, it means the
flaky CI test won't run these two migration tests, but that's not the end
of the world either, if you see what I meant.  CI relies on the normal
tests rather than flaky tests to present.

We should be able to move in / take out FLAKY tests at will, as that's not
what CI is really relying on.  Here renaming the macro in migration test
almost means we take both out.

> 
> We can say: "Internally we don't allow slow and flaky to be in the smoke
> set".
> 
> We cannot say: "In migration-test QEMU_TEST_FLAKY_TESTS is actually
> QEMU_MIG_TEST_FLAKY, -m slow is actually QEMU_MIG_TEST_EXTRA, -m slow
> just implies KVM and -m quick implies TCG. Easy peasy!"
> 
> >
> >>   endif
> >> 
> >> cmdline invocations:
> >>   ./migration-test                 # runs smoke, i.e. level 1
> >>   ./migration-test -m slow         # runs smoke only, no slow tests in the smoke set
> >>   FLAKY=1 ./migration-test         # runs smoke only, no flaky tests in the smoke set
> >> 
> >>   ./migration-test --full          # runs full set, i.e. level 2
> >>   ./migration-test --full -m slow  # runs full set + slow tests
> >>   FLAKY=1 ./migration-test --full  # runs full set + flaky tests
> 
> Don't see this^ as a matrix of --full and -m. This is identical to what
> we have today, with the addition of a flag that determines the amount of
> tests run. We could call it other names if we want:
> 
> --size small/large
> --testset smoke/full
> 
> >> 
> >> I made the first one like that so the compat tests in CI now run less
> >> tests. We don't need full set during compat because that job is about
> >> catching changes in device code. It would also make the argument easier
> >> to enable the compat job for all migration-test-supported archs.
> >> 
> >> >> 
> >> >> I think the best we can do is have a qtest_migration_level_<ARCH> and
> >> >> set it for every arch.
> >> >> 
> >> >> Also note that we must keep plain 'migration-test' invocation working
> >> >> because of the compat test.
> >> >
> >> > We won't break it if we only switch to levels, right?
> >> >
> >> > Btw, I also don't know why we need to.  IIRC the compat test runs the test
> >> > in previous release (but only feeds the new QEMU binary to the old
> >> > migration-test)?  I think that's one reason why we decided to use the old
> >> > migration-test (so we won't have new tests ran on compat tests, which is a
> >> > loss), just to avoid any change in migration-test will break the compat
> >> > test.. so I assume that should be fine regardless..
> >> 
> >> I meant we shouldn't break the command line invocation:
> >> 
> >> ./tests/qtest/migration-test -p <test_name>
> >> 
> >> As in, we cannot change the test name or add mandatory flags. Otherwise
> >> we have a discrepancy betweem what the CI job is calling vs. what the
> >> build actually provides. We run the tests from the previous build, but
> >> the CI job is current.
> >
> > I failed to follow here.  Our CI doesn't hardcode any <test_name>, right?
> > It should invoke "migration-test" in the old build, feeding new QEMU binary
> > to it, run whatever are there in the old test.
> 
> Yes, but we have the words "migration-test" in the CI .yaml *today*. It
> doesn't matter if it invokes the tests from the last release. If we
> changed the name to "migration-foobar", then the CI job continues to
> work up until 10.0 is released. It then breaks immediately in the first
> commit of 10.0.50 because the previous release will now have the
> "migration-foobar" name while the CI still calls for "migration-test".

Not fair at all: nobody suggested to rename the test!

> 
> Basically the point is that CI .yaml changes take effect immediately
> while test cmdline changes only take effect (in CI) on the next release.

Yes, but so far the "API" is the test name only (and actually not.. more
below), and at least no path involved.  That's why I want to make sure
we're on the same page.  So looks like at least "what tests to run by
default", and "full path of each of the test case" can still change.

Here's the "more below" part: logically if we want we can change the name
of migration-test.  We need to teach the CI on which version of QEMU to use
which program to test in the compat tests.  It isn't really hard (a git-tag
-> prog-name hash), it's just unnecessary to change the test name at all.

> 
> >
> >> 
> >> Another point that is more of an annoyance is that the migration-test
> >> invocation not being stable affectes debug, bisect, etc. When debugging
> >> the recent multifd regression I already had to keep changing from
> >> /multifd/tcp/... to /multifd/tcp/uri/... when changing QEMU versions.
> >
> > So I could have missed something above, and I can understand this adds
> > burden to bisections.  However I do prefer we can change test path any way
> > we want (even if in most cases we shouldn't ever touch them, and we should
> > still try to not change them as frequent).  IOW we also need to consider
> > the overhead of keeping test paths to be part of ABI as well.
> 
> It's annoying, that's all. Makes me 1% more grumpy.

I'm not going to change any.. but keeping it a protocol is another thing.

So to summarize..

My plan (after adjustment, keeping the name of QEMU_TEST_FLAKY_TESTS) is to
introduce QEMU_TEST_EXTRA_TESTS (renamed following FLAKY) and cover the
three current "slow" tests.  Then we stick with -m for the new quick/slow,
which maps to tcg/kvm directly.  That saves the extra --full parameter.

The diff v.s. your plan is, afaict, you prefer introducing yet another
--full parameter.

Yours is good that we stick with the whole test in compat tests with no
extra change, which is a benefit indeed.

If go with my plan, the default compat behavior will start to change after
10.0 released.  We need to do one more step if we still prefer the wholeset
run in compat test, which is at the start of 10.1, we send a patch to
change compat test's parameter from none to "-m slow".

Feel free to go ahead with whatever you prefer.  To me, the more important
bit is whether we both think that one program is better than two, and also
that means decouple host setup v.s. tests. I don't have a strong opinion
otherwise..

-- 
Peter Xu


