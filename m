Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F28CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 17:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMqqU-0003wl-9H; Tue, 12 May 2026 13:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMqqS-0003wC-Mz
 for qemu-devel@nongnu.org; Tue, 12 May 2026 13:24:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMqqI-0008Cn-Ph
 for qemu-devel@nongnu.org; Tue, 12 May 2026 13:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778606665;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Of0z16qbpQJ6dtdrX5uuhqhJA2Fyr8jXLOzbP5xVEAA=;
 b=UuHRSkKMvsV2vgaMdAG9BKpRMg4f64MGhru8yD6SBG4YClZ7o09Ff/WEEy4zfW3vfeoelx
 /LvEL9MMBvU9QfjOD0gcEXqvMkXDjdnQzF6YzHHVItothWaRudWMl+qxaLiGRRyC9M5hks
 kLug3ctbBiegpFUPbQl3uw7Ew3koiq0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-wpmZBYEVN3OTDvDKH7GK6A-1; Tue,
 12 May 2026 13:24:21 -0400
X-MC-Unique: wpmZBYEVN3OTDvDKH7GK6A-1
X-Mimecast-MFC-AGG-ID: wpmZBYEVN3OTDvDKH7GK6A_1778606660
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A0E7B18005B5; Tue, 12 May 2026 17:24:20 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.86])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D641018004A3; Tue, 12 May 2026 17:24:16 +0000 (UTC)
Date: Tue, 12 May 2026 18:24:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 14/16] tests: add QEMU_TEST_IO_SKIP for skipping I/O tests
Message-ID: <agNiPRnoyxd7rBbz@redhat.com>
References: <20260424154205.364268-1-berrange@redhat.com>
 <20260424154205.364268-15-berrange@redhat.com>
 <fa8be3d8-6d76-4811-83ab-69c256e8e44f@oss.qualcomm.com>
 <agNPkLRe0Rf4NYcU@redhat.com>
 <cc8714c3-143d-4f63-a608-d301e8ba023b@oss.qualcomm.com>
 <agNXCf5eXNQmhCAV@redhat.com>
 <55b66ce4-218c-462f-8e48-0775d5c36cba@oss.qualcomm.com>
 <agNbJS1WeWaxZ_Gx@redhat.com>
 <31eb8204-97bb-4f0e-b90a-048d1b5bf05d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31eb8204-97bb-4f0e-b90a-048d1b5bf05d@oss.qualcomm.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, May 12, 2026 at 10:09:53AM -0700, Pierrick Bouvier wrote:
> On 5/12/2026 9:53 AM, Daniel P. Berrangé wrote:
> > On Tue, May 12, 2026 at 09:47:12AM -0700, Pierrick Bouvier wrote:
> >> On 5/12/2026 9:36 AM, Daniel P. Berrangé wrote:
> >>> On Tue, May 12, 2026 at 09:19:45AM -0700, Pierrick Bouvier wrote:
> >>>> On 5/12/2026 9:06 AM, Daniel P. Berrangé wrote:
> >>>>> On Tue, May 12, 2026 at 08:56:54AM -0700, Pierrick Bouvier wrote:
> >>>>>> On 4/24/2026 8:42 AM, Daniel P. Berrangé wrote:
> >>>>>>> The nature of block I/O tests is such that there can be unexpected false
> >>>>>>> positive failures in certain scenarios that have not been encountered
> >>>>>>> before, and sometimes non-deterministic failures that are hard to
> >>>>>>> reproduce.
> >>>>>>>
> >>>>>>> Before enabling the I/O tests as gating jobs in CI, there needs to be a
> >>>>>>> mechanism to dynamically mark tests as skipped, without having to commit
> >>>>>>> code changes.
> >>>>>>>
> >>>>>>> This introduces the QEMU_TEST_IO_SKIP environment variable that is set
> >>>>>>> to a list of FORMAT-OR-PROTOCOL:NAME pairs. The intent is that this
> >>>>>>> variable can be set as a GitLab CI pipeline variable to temporarily
> >>>>>>> disable a test while problems are being debugged.
> >>>>>>>
> >>>>>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
> >>>>>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> >>>>>>> ---
> >>>>>>>  docs/devel/testing/main.rst      |  7 +++++++
> >>>>>>>  tests/qemu-iotests/testrunner.py | 16 ++++++++++++++++
> >>>>>>>  2 files changed, 23 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
> >>>>>>> index 797111009a..f779a64415 100644
> >>>>>>> --- a/docs/devel/testing/main.rst
> >>>>>>> +++ b/docs/devel/testing/main.rst
> >>>>>>> @@ -284,6 +284,13 @@ that are specific to certain cache mode.
> >>>>>>>  More options are supported by the ``./check`` script, run ``./check -h`` for
> >>>>>>>  help.
> >>>>>>>  
> >>>>>>> +If a test program is known to be broken, it can be disabled by setting
> >>>>>>> +the ``QEMU_TEST_IO_SKIP`` environment variable with a list of tests to
> >>>>>>> +be skipped. The values are of the form FORMAT-OR-PROTOCOL:NAME, the
> >>>>>>> +leading component can be omitted to skip the test for all formats and
> >>>>>>> +protocols. For example ``export QEMU_TEST_IO_SKIP="luks:149 185 iov-padding``
> >>>>>>> +will skip ``149`` for LUKS only, and ``185`` and ``iov-padding`` for all.
> >>>>>>> +
> >>>>>>>  Writing a new test case
> >>>>>>>  ~~~~~~~~~~~~~~~~~~~~~~~
> >>>>>>>  
> >>>>>>> diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
> >>>>>>> index dbe2dddc32..ecb5d4529f 100644
> >>>>>>> --- a/tests/qemu-iotests/testrunner.py
> >>>>>>> +++ b/tests/qemu-iotests/testrunner.py
> >>>>>>> @@ -145,6 +145,18 @@ def __init__(self, env: TestEnv, tap: bool = False,
> >>>>>>>  
> >>>>>>>          self._stack: contextlib.ExitStack
> >>>>>>>  
> >>>>>>> +        self.skip = {}
> >>>>>>> +        for rule in os.environ.get("QEMU_TEST_IO_SKIP", "").split(" "):
> >>>>>>> +            rule = rule.strip()
> >>>>>>> +            if rule == "":
> >>>>>>> +                continue
> >>>>>>> +            if ":" in rule:
> >>>>>>> +                fmt, name = rule.split(":")
> >>>>>>> +                if fmt in ("", env.imgfmt, env.imgproto):
> >>>>>>> +                    self.skip[name] = True
> >>>>>>> +            else:
> >>>>>>> +                self.skip[rule] = True
> >>>>>>> +
> >>>>>>>      def __enter__(self) -> 'TestRunner':
> >>>>>>>          self._stack = contextlib.ExitStack()
> >>>>>>>          self._stack.enter_context(self.env)
> >>>>>>> @@ -251,6 +263,10 @@ def do_run_test(self, test: str) -> TestResult:
> >>>>>>>                                description='No qualified output '
> >>>>>>>                                            f'(expected {f_reference})')
> >>>>>>>  
> >>>>>>> +        if f_test.name in self.skip:
> >>>>>>> +            return TestResult(status='not run',
> >>>>>>> +                              description='Listed in QEMU_TEST_IO_SKIP')
> >>>>>>> +
> >>>>>>>          args = [str(f_test.resolve())]
> >>>>>>>          env = self.env.prepare_subprocess(args)
> >>>>>>>  
> >>>>>>
> >>>>>> Why not simply remove the broken tests, and create issues to add them
> >>>>>> again in the future?
> >>>>>
> >>>>> In theory that's what our policy today is, but in practice it is
> >>>>> too much of a burden on the release co-ordinator, to expect them
> >>>>> to create such a patch themselves, or wait on a subsys maintainer
> >>>>> todo it for them.
> >>>>>
> >>>>> They end up just ignoring brokenness in CI which is a bad practice,
> >>>>> and will prevent us ever making CI truely gating or switching to
> >>>>> using MRs for pull requests. This gives us a super-fast way to skip
> >>>>> flaky tests, while the subsystem maintainers figure out the right
> >>>>> permanent answer.
> >>>>>
> >>>>
> >>>> I disagree on this one, merging a single patch doing a git rm, and a git
> >>>> revert later is not more expensive than merging a variable modifying a
> >>>> variable in a yaml file.
> >>>
> >>> Any code changes like that need to be sent back to the subsystem
> >>> maintainer to be acked. IMHO the release manager should not be
> >>> unilaterally deleting tests without peer review.  So that's
> >>> got a non-negligible turn around time, during which CI is broken.
> >>>
> >>
> >> I accept the argument, but it seems like a workaround for a human
> >> process, more than a proper solution to the problem.
> >>
> >> It would be better to have a proper policy for build/test fixes, instead
> >> of implementing local overrides to this.
> >>
> >>> Setting an env variable to skip a problematic test is something
> >>> reasonable to do with zero oversight.
> >>>
> >>>> The issue with this approach is that people running tests locally will
> >>>> not see which tests are skipped, and will see false positives. So you
> >>>> just keep CI green, but not the test base itself.
> >>>
> >>> I would still expect the release manager to file a bug about any
> >>> flaky test they disable via the env var, and the subsystem maintainer
> >>> should still be fixing it or disabling it such that tests won't fail
> >>> more broadly, or deciding to remove it if terminally broken.
> >>>
> >>> We're just decoupling the process so that there is an immediate
> >>> workaround possible. It can also be used by people working in
> >>> their forks - often I've been testing stuff in my fork, but
> >>> see spurious failures because git master has a non-deterministic
> >>> test failure merged. I would like to easily skip those in my fork
> >>> too, without adding extra commits to me working branches, as that
> >>> would require the same commit to be duped into several in-progress
> >>> branches, vs setting the env var once.
> >>>
> >>>> The risk I see is that some tests will stay forever in this skip
> >>>> variable, so it will be dead code for CI, but still alive and failing
> >>>> for people running tests manually who hit the regression.
> >>>
> >>> Again, there should be a bug filed for any flaky test. Anyone can
> >>> do this, if they see it locally or in their fork CI, or in staging
> >>> CI. If no one can see an obvious fix, then anyone can also propose
> >>> to disable the test.
> >>>
> >>>> If you still want an alternative to removing test, implementing a
> >>>> skip_list in tests/qemu-iotests/meson.build is better than an env var
> >>>> IMHO, and achieves the exact same effect, for CI and for users.
> >>>>
> >>>> What do you think?
> >>>
> >>> IMHO there needs to be a way to skip flaky tests which does not
> >>> require code changes as the only available option. Code changes
> >>> are the permanent fix, env var is the immediate workaround.
> >>>
> >>
> >> I'm not sure all this answers to my question about How to ensure users
> >> who run tests and the CI both see the same skip list.
> >>
> >> I don't mind having an env var, a black list in meson or any other
> >> solution, but having different results on a dev machine and in CI is not
> >> a good design. So whatever the solution is, the CI yaml file is not the
> >> proper place to store this information.
> > 
> > AFAICT the test 185 that is being skipped in the CI yaml file only
> > fails when run under gitlab. I've never seen a failure running it
> > locally.
> > 
> > If it failed locally too, then I'd agree that it should not be
> > skipped in the CI yaml, but universally skipped in all scenarios.
> >
> 
> If I get all this correctly, we add a generic mechanic to be able to
> gate CI with block tests just because there is a single test failing
> with a single driver. Is that the right approach?

The env variable is the generic mechanism.

The yaml file exclusion for 185 is the special case, but we get
that basically for free with the former.

> In the future, do we expect to merge code breaking tests?

Yes. We will certainly merge more non-deterministic tests. We've seen
this over & over again. Something passes CI initially but after a
number of CI pipelines turns out to be flaky

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


