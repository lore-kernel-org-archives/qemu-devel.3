Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87370CD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 14:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNAJd-0000Xs-I1; Wed, 13 May 2026 10:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wNAJX-0000Xa-0f
 for qemu-devel@nongnu.org; Wed, 13 May 2026 10:11:55 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wNAJT-00070e-VY
 for qemu-devel@nongnu.org; Wed, 13 May 2026 10:11:54 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2FC7476726;
 Wed, 13 May 2026 14:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778681510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HhdCAdEL95MNdzpDq11VYuSajHnt3lEtQjPtO+sExes=;
 b=lqCfcfG3H9amlf2yPtGfTldOvrnNtV31gXtZC5142b6NHM8CWvKP1FP12QjnJPfj08ZJcM
 fic8lsTRX9V6r0bVM7fE2jIRTgHpl0ejkmi0zR8AdyvZh+8FrLXer7X5+DTvxu++TzGC4+
 7zRzbyjWJnDJ+5s6DxuwS9umE0sSkic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778681510;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HhdCAdEL95MNdzpDq11VYuSajHnt3lEtQjPtO+sExes=;
 b=3sV2w+G9TiwH7fUDx2WisyCISzUKPsovG+HkDncIWm7BVoYnl3D+wwjJ1PgYNl/djNL2Re
 31XFOk5z2z6jPoBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778681510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HhdCAdEL95MNdzpDq11VYuSajHnt3lEtQjPtO+sExes=;
 b=lqCfcfG3H9amlf2yPtGfTldOvrnNtV31gXtZC5142b6NHM8CWvKP1FP12QjnJPfj08ZJcM
 fic8lsTRX9V6r0bVM7fE2jIRTgHpl0ejkmi0zR8AdyvZh+8FrLXer7X5+DTvxu++TzGC4+
 7zRzbyjWJnDJ+5s6DxuwS9umE0sSkic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778681510;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HhdCAdEL95MNdzpDq11VYuSajHnt3lEtQjPtO+sExes=;
 b=3sV2w+G9TiwH7fUDx2WisyCISzUKPsovG+HkDncIWm7BVoYnl3D+wwjJ1PgYNl/djNL2Re
 31XFOk5z2z6jPoBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8A8D593AA;
 Wed, 13 May 2026 14:11:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kkBBIqWGBGqmCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 13 May 2026 14:11:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, Alex
 =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-block@nongnu.org, Cleber Rosa
 <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow
 <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>
Subject: Re: [PATCH 14/16] tests: add QEMU_TEST_IO_SKIP for skipping I/O tests
In-Reply-To: <dd212ed3-8cde-4397-9585-9eb5439fe44e@oss.qualcomm.com>
References: <agNPkLRe0Rf4NYcU@redhat.com>
 <cc8714c3-143d-4f63-a608-d301e8ba023b@oss.qualcomm.com>
 <agNXCf5eXNQmhCAV@redhat.com>
 <55b66ce4-218c-462f-8e48-0775d5c36cba@oss.qualcomm.com>
 <agNbJS1WeWaxZ_Gx@redhat.com>
 <31eb8204-97bb-4f0e-b90a-048d1b5bf05d@oss.qualcomm.com>
 <agNiPRnoyxd7rBbz@redhat.com>
 <cd3c6a2a-96ad-4276-aa61-8d458d702ba5@oss.qualcomm.com>
 <agN1a8IULLnpAjUa@redhat.com>
 <d997f55b-2e27-478c-9135-a694b7aa8052@oss.qualcomm.com>
 <agN4xgx6Hh2FdYIq@redhat.com>
 <dd212ed3-8cde-4397-9585-9eb5439fe44e@oss.qualcomm.com>
Date: Wed, 13 May 2026 11:11:47 -0300
Message-ID: <87v7crwg9o.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 5/12/2026 12:00 PM, Daniel P. Berrang=C3=A9 wrote:
>> On Tue, May 12, 2026 at 11:52:45AM -0700, Pierrick Bouvier wrote:
>>> On 5/12/2026 11:46 AM, Daniel P. Berrang=C3=A9 wrote:
>>>> On Tue, May 12, 2026 at 10:53:05AM -0700, Pierrick Bouvier wrote:
>>>>> On 5/12/2026 10:24 AM, Daniel P. Berrang=C3=A9 wrote:
>>>>>> On Tue, May 12, 2026 at 10:09:53AM -0700, Pierrick Bouvier wrote:
>>>>>>> On 5/12/2026 9:53 AM, Daniel P. Berrang=C3=A9 wrote:
>>>>>>>> On Tue, May 12, 2026 at 09:47:12AM -0700, Pierrick Bouvier wrote:
>>>>>>>>> On 5/12/2026 9:36 AM, Daniel P. Berrang=C3=A9 wrote:
>>>>>>>>>> On Tue, May 12, 2026 at 09:19:45AM -0700, Pierrick Bouvier wrote:
>>>>>>>>>>> On 5/12/2026 9:06 AM, Daniel P. Berrang=C3=A9 wrote:
>>>>>>>>>>>> On Tue, May 12, 2026 at 08:56:54AM -0700, Pierrick Bouvier wro=
te:
>>>>>>>>>>>>> On 4/24/2026 8:42 AM, Daniel P. Berrang=C3=A9 wrote:
>>>>>>>>>>>>>> The nature of block I/O tests is such that there can be unex=
pected false
>>>>>>>>>>>>>> positive failures in certain scenarios that have not been en=
countered
>>>>>>>>>>>>>> before, and sometimes non-deterministic failures that are ha=
rd to
>>>>>>>>>>>>>> reproduce.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Before enabling the I/O tests as gating jobs in CI, there ne=
eds to be a
>>>>>>>>>>>>>> mechanism to dynamically mark tests as skipped, without havi=
ng to commit
>>>>>>>>>>>>>> code changes.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> This introduces the QEMU_TEST_IO_SKIP environment variable t=
hat is set
>>>>>>>>>>>>>> to a list of FORMAT-OR-PROTOCOL:NAME pairs. The intent is th=
at this
>>>>>>>>>>>>>> variable can be set as a GitLab CI pipeline variable to temp=
orarily
>>>>>>>>>>>>>> disable a test while problems are being debugged.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>>>>>>>>>>>>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>  docs/devel/testing/main.rst      |  7 +++++++
>>>>>>>>>>>>>>  tests/qemu-iotests/testrunner.py | 16 ++++++++++++++++
>>>>>>>>>>>>>>  2 files changed, 23 insertions(+)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> diff --git a/docs/devel/testing/main.rst b/docs/devel/testin=
g/main.rst
>>>>>>>>>>>>>> index 797111009a..f779a64415 100644
>>>>>>>>>>>>>> --- a/docs/devel/testing/main.rst
>>>>>>>>>>>>>> +++ b/docs/devel/testing/main.rst
>>>>>>>>>>>>>> @@ -284,6 +284,13 @@ that are specific to certain cache mode.
>>>>>>>>>>>>>>  More options are supported by the ``./check`` script, run `=
`./check -h`` for
>>>>>>>>>>>>>>  help.
>>>>>>>>>>>>>>=20=20
>>>>>>>>>>>>>> +If a test program is known to be broken, it can be disabled=
 by setting
>>>>>>>>>>>>>> +the ``QEMU_TEST_IO_SKIP`` environment variable with a list =
of tests to
>>>>>>>>>>>>>> +be skipped. The values are of the form FORMAT-OR-PROTOCOL:N=
AME, the
>>>>>>>>>>>>>> +leading component can be omitted to skip the test for all f=
ormats and
>>>>>>>>>>>>>> +protocols. For example ``export QEMU_TEST_IO_SKIP=3D"luks:1=
49 185 iov-padding``
>>>>>>>>>>>>>> +will skip ``149`` for LUKS only, and ``185`` and ``iov-padd=
ing`` for all.
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>  Writing a new test case
>>>>>>>>>>>>>>  ~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>>>>>>>>>=20=20
>>>>>>>>>>>>>> diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-i=
otests/testrunner.py
>>>>>>>>>>>>>> index dbe2dddc32..ecb5d4529f 100644
>>>>>>>>>>>>>> --- a/tests/qemu-iotests/testrunner.py
>>>>>>>>>>>>>> +++ b/tests/qemu-iotests/testrunner.py
>>>>>>>>>>>>>> @@ -145,6 +145,18 @@ def __init__(self, env: TestEnv, tap: b=
ool =3D False,
>>>>>>>>>>>>>>=20=20
>>>>>>>>>>>>>>          self._stack: contextlib.ExitStack
>>>>>>>>>>>>>>=20=20
>>>>>>>>>>>>>> +        self.skip =3D {}
>>>>>>>>>>>>>> +        for rule in os.environ.get("QEMU_TEST_IO_SKIP", "")=
.split(" "):
>>>>>>>>>>>>>> +            rule =3D rule.strip()
>>>>>>>>>>>>>> +            if rule =3D=3D "":
>>>>>>>>>>>>>> +                continue
>>>>>>>>>>>>>> +            if ":" in rule:
>>>>>>>>>>>>>> +                fmt, name =3D rule.split(":")
>>>>>>>>>>>>>> +                if fmt in ("", env.imgfmt, env.imgproto):
>>>>>>>>>>>>>> +                    self.skip[name] =3D True
>>>>>>>>>>>>>> +            else:
>>>>>>>>>>>>>> +                self.skip[rule] =3D True
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>      def __enter__(self) -> 'TestRunner':
>>>>>>>>>>>>>>          self._stack =3D contextlib.ExitStack()
>>>>>>>>>>>>>>          self._stack.enter_context(self.env)
>>>>>>>>>>>>>> @@ -251,6 +263,10 @@ def do_run_test(self, test: str) -> Tes=
tResult:
>>>>>>>>>>>>>>                                description=3D'No qualified o=
utput '
>>>>>>>>>>>>>>                                            f'(expected {f_re=
ference})')
>>>>>>>>>>>>>>=20=20
>>>>>>>>>>>>>> +        if f_test.name in self.skip:
>>>>>>>>>>>>>> +            return TestResult(status=3D'not run',
>>>>>>>>>>>>>> +                              description=3D'Listed in QEMU=
_TEST_IO_SKIP')
>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>          args =3D [str(f_test.resolve())]
>>>>>>>>>>>>>>          env =3D self.env.prepare_subprocess(args)
>>>>>>>>>>>>>>=20=20
>>>>>>>>>>>>>
>>>>>>>>>>>>> Why not simply remove the broken tests, and create issues to =
add them
>>>>>>>>>>>>> again in the future?
>>>>>>>>>>>>
>>>>>>>>>>>> In theory that's what our policy today is, but in practice it =
is
>>>>>>>>>>>> too much of a burden on the release co-ordinator, to expect th=
em
>>>>>>>>>>>> to create such a patch themselves, or wait on a subsys maintai=
ner
>>>>>>>>>>>> todo it for them.
>>>>>>>>>>>>
>>>>>>>>>>>> They end up just ignoring brokenness in CI which is a bad prac=
tice,
>>>>>>>>>>>> and will prevent us ever making CI truely gating or switching =
to
>>>>>>>>>>>> using MRs for pull requests. This gives us a super-fast way to=
 skip
>>>>>>>>>>>> flaky tests, while the subsystem maintainers figure out the ri=
ght
>>>>>>>>>>>> permanent answer.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I disagree on this one, merging a single patch doing a git rm, =
and a git
>>>>>>>>>>> revert later is not more expensive than merging a variable modi=
fying a
>>>>>>>>>>> variable in a yaml file.
>>>>>>>>>>
>>>>>>>>>> Any code changes like that need to be sent back to the subsystem
>>>>>>>>>> maintainer to be acked. IMHO the release manager should not be
>>>>>>>>>> unilaterally deleting tests without peer review.  So that's
>>>>>>>>>> got a non-negligible turn around time, during which CI is broken.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I accept the argument, but it seems like a workaround for a human
>>>>>>>>> process, more than a proper solution to the problem.
>>>>>>>>>
>>>>>>>>> It would be better to have a proper policy for build/test fixes, =
instead
>>>>>>>>> of implementing local overrides to this.
>>>>>>>>>
>>>>>>>>>> Setting an env variable to skip a problematic test is something
>>>>>>>>>> reasonable to do with zero oversight.
>>>>>>>>>>
>>>>>>>>>>> The issue with this approach is that people running tests local=
ly will
>>>>>>>>>>> not see which tests are skipped, and will see false positives. =
So you
>>>>>>>>>>> just keep CI green, but not the test base itself.
>>>>>>>>>>
>>>>>>>>>> I would still expect the release manager to file a bug about any
>>>>>>>>>> flaky test they disable via the env var, and the subsystem maint=
ainer
>>>>>>>>>> should still be fixing it or disabling it such that tests won't =
fail
>>>>>>>>>> more broadly, or deciding to remove it if terminally broken.
>>>>>>>>>>
>>>>>>>>>> We're just decoupling the process so that there is an immediate
>>>>>>>>>> workaround possible. It can also be used by people working in
>>>>>>>>>> their forks - often I've been testing stuff in my fork, but
>>>>>>>>>> see spurious failures because git master has a non-deterministic
>>>>>>>>>> test failure merged. I would like to easily skip those in my fork
>>>>>>>>>> too, without adding extra commits to me working branches, as that
>>>>>>>>>> would require the same commit to be duped into several in-progre=
ss
>>>>>>>>>> branches, vs setting the env var once.
>>>>>>>>>>
>>>>>>>>>>> The risk I see is that some tests will stay forever in this skip
>>>>>>>>>>> variable, so it will be dead code for CI, but still alive and f=
ailing
>>>>>>>>>>> for people running tests manually who hit the regression.
>>>>>>>>>>
>>>>>>>>>> Again, there should be a bug filed for any flaky test. Anyone can
>>>>>>>>>> do this, if they see it locally or in their fork CI, or in stagi=
ng
>>>>>>>>>> CI. If no one can see an obvious fix, then anyone can also propo=
se
>>>>>>>>>> to disable the test.
>>>>>>>>>>
>>>>>>>>>>> If you still want an alternative to removing test, implementing=
 a
>>>>>>>>>>> skip_list in tests/qemu-iotests/meson.build is better than an e=
nv var
>>>>>>>>>>> IMHO, and achieves the exact same effect, for CI and for users.
>>>>>>>>>>>
>>>>>>>>>>> What do you think?
>>>>>>>>>>
>>>>>>>>>> IMHO there needs to be a way to skip flaky tests which does not
>>>>>>>>>> require code changes as the only available option. Code changes
>>>>>>>>>> are the permanent fix, env var is the immediate workaround.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I'm not sure all this answers to my question about How to ensure =
users
>>>>>>>>> who run tests and the CI both see the same skip list.
>>>>>>>>>
>>>>>>>>> I don't mind having an env var, a black list in meson or any other
>>>>>>>>> solution, but having different results on a dev machine and in CI=
 is not
>>>>>>>>> a good design. So whatever the solution is, the CI yaml file is n=
ot the
>>>>>>>>> proper place to store this information.
>>>>>>>>
>>>>>>>> AFAICT the test 185 that is being skipped in the CI yaml file only
>>>>>>>> fails when run under gitlab. I've never seen a failure running it
>>>>>>>> locally.
>>>>>>>>
>>>>>>>> If it failed locally too, then I'd agree that it should not be
>>>>>>>> skipped in the CI yaml, but universally skipped in all scenarios.
>>>>>>>>
>>>>>>>
>>>>>>> If I get all this correctly, we add a generic mechanic to be able to
>>>>>>> gate CI with block tests just because there is a single test failing
>>>>>>> with a single driver. Is that the right approach?
>>>>>>
>>>>>> The env variable is the generic mechanism.
>>>>>>
>>>>>> The yaml file exclusion for 185 is the special case, but we get
>>>>>> that basically for free with the former.
>>>>>>
>>>>>>> In the future, do we expect to merge code breaking tests?
>>>>>>
>>>>>> Yes. We will certainly merge more non-deterministic tests. We've seen
>>>>>> this over & over again. Something passes CI initially but after a
>>>>>> number of CI pipelines turns out to be flaky
>>>>>>
>>>>>
>>>>> Then we can mark them as flaky in tests/qemu-iotests/meson.build.
>>>>
>>>> That is a long term solution. It does not address the immediate
>>>> time critical goal to have the ability to fix a broken CI pipeline
>>>> immediately by skipping the test without waiting for code changes.
>>>>
>>>>> It seems like you ignore the point that there is a problem between
>>>>> setting something in CI only vs making something that works for all
>>>>> users. I'm not against an env var, I just don't see how it answers th=
is
>>>>> need.
>>>>
>>>> Again, I'm not saying that we fix this only for CI. The env var is
>>>> to allow broken jobs to be immediately skipped, while waiting for
>>>> code changes to permanently skipped/fix the tests. The latter
>>>> addresses it for every scenario.
>>>>
>>>
>>> I might have missed where we have a default value for this env var, out
>>> of yaml file, that makes it apply the exact same set of skip tests for
>>> CI, and for users running tests manually.
>>>
>>> Where is this default applied for both CI and users?
>>>
>>> I understand it's not needed for test 185 which fails only in GitLab,
>>> but as you mentioned, we'll probably have non deterministic tests in the
>>> future, so we need to consider this.
>>=20
>> I was considering any change in meson.build to permanently skip a
>> test would be independent of the env var handling, and outside the
>> scope of this series since there's no need for it here.
>>
>
> Where is the default value for this env var applied for both CI and
> users? yaml is for CI only.
>

Hi all,

I think Pierrick's concern is valid, but I see it slightly differently:

In the case of an environment variable, it's possible to set it without
any code change (even to .yaml files), by setting "-o ci.variable=3D<val>"
at git push time and also by setting directly in GitLab's web interface
under "New Pipeline". So it allows anyone wanting to "just get work
done" to skip broken tests for the duration of a pipeline.

It also works when running locally and skipping some tests for the
single local run.

All temporary changes, of course.

For the case of a flaky test that will need to be disabled for longer
than a single run, could we standardize on a list committed to
meson.build, so it works for both CI and local?  I think so, and I think
it's a good idea. Having recently taking up maintainership of QTests I
sometimes stumble into disabled tests that have been there for years and
everyone forgot about them. Same with the migration subsystem. Having a
single place to check from time to time would be helpful.

Migration, by the way, has been using the env variable approach in qtest
like this:

    /*
     * Our CI system has problems with shared memory.
     * Don't run this test until we find a workaround.
     */
    if (getenv("QEMU_TEST_FLAKY_TESTS")) {

Which is a case in which a single list committed in meson.build wouldn't
help. We actually do want to skip this only for CI.
("problems with shared memory" here means that CI environments simply
don't have enough shared memory space available to run all the tests
that make use of it)

A further complication is that in the migration case above, that skip
does not apply to the entire migration-test, it applies to a sub-test
(./migration-test -p /x86/migration/mode/reboot). Constructs in
meson.build would not be able to skip this, they can only skip the
entire migration-test. There is an -x option that gtester accepts, so
we'd need to write some meson-fu to invoke "./migration-test -x
/x86/migration/mode/reboot -x ..." if any subtest is to be skipped (note
that this is not migration-specific, all qtests that invoke
g_test_add_data* more than once are like this).

Maybe we could work on a proposal to improve this in a generic way for
all test frameworks.

PS: I'd even say there's a lot we could make common between
frameworks. A bunch of what happens around running a test is generic
programming, not tied to a specific programming language or accelerator
(in case of qtest).


>>=20
>> With regards,
>> Daniel

