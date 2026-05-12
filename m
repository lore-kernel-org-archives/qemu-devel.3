Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DADCD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 16:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMpd9-0007dk-Su; Tue, 12 May 2026 12:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMpd6-0007cB-EW
 for qemu-devel@nongnu.org; Tue, 12 May 2026 12:06:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMpd3-0002qJ-3U
 for qemu-devel@nongnu.org; Tue, 12 May 2026 12:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778601999;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y6hJWuXJholrkQ4fKa9NCmWiNzURpD7RHBFlLs/0G58=;
 b=hzLHjujwCiOvOlWJBFAqWgym9NncQFcm3cIH5SkPAsVMuxA/xAv2aj/04KhvR5KOlvNvlw
 5souZUfXLf7SJDPiL0INLwU5W+cgGjWV52pDHRFmnf87r4WF1cDUrYDjvbOsw+l5WhkHeb
 w8TkUlzxn0S639vUb6rj9AuBdl+eFmI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-eFfROKc4N_CSNox_8BC8yQ-1; Tue,
 12 May 2026 12:06:34 -0400
X-MC-Unique: eFfROKc4N_CSNox_8BC8yQ-1
X-Mimecast-MFC-AGG-ID: eFfROKc4N_CSNox_8BC8yQ_1778601993
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 158F019560AD; Tue, 12 May 2026 16:06:33 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.86])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEC1F180034E; Tue, 12 May 2026 16:06:28 +0000 (UTC)
Date: Tue, 12 May 2026 17:06:24 +0100
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
Message-ID: <agNPkLRe0Rf4NYcU@redhat.com>
References: <20260424154205.364268-1-berrange@redhat.com>
 <20260424154205.364268-15-berrange@redhat.com>
 <fa8be3d8-6d76-4811-83ab-69c256e8e44f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa8be3d8-6d76-4811-83ab-69c256e8e44f@oss.qualcomm.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, May 12, 2026 at 08:56:54AM -0700, Pierrick Bouvier wrote:
> On 4/24/2026 8:42 AM, Daniel P. Berrangé wrote:
> > The nature of block I/O tests is such that there can be unexpected false
> > positive failures in certain scenarios that have not been encountered
> > before, and sometimes non-deterministic failures that are hard to
> > reproduce.
> > 
> > Before enabling the I/O tests as gating jobs in CI, there needs to be a
> > mechanism to dynamically mark tests as skipped, without having to commit
> > code changes.
> > 
> > This introduces the QEMU_TEST_IO_SKIP environment variable that is set
> > to a list of FORMAT-OR-PROTOCOL:NAME pairs. The intent is that this
> > variable can be set as a GitLab CI pipeline variable to temporarily
> > disable a test while problems are being debugged.
> > 
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  docs/devel/testing/main.rst      |  7 +++++++
> >  tests/qemu-iotests/testrunner.py | 16 ++++++++++++++++
> >  2 files changed, 23 insertions(+)
> > 
> > diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
> > index 797111009a..f779a64415 100644
> > --- a/docs/devel/testing/main.rst
> > +++ b/docs/devel/testing/main.rst
> > @@ -284,6 +284,13 @@ that are specific to certain cache mode.
> >  More options are supported by the ``./check`` script, run ``./check -h`` for
> >  help.
> >  
> > +If a test program is known to be broken, it can be disabled by setting
> > +the ``QEMU_TEST_IO_SKIP`` environment variable with a list of tests to
> > +be skipped. The values are of the form FORMAT-OR-PROTOCOL:NAME, the
> > +leading component can be omitted to skip the test for all formats and
> > +protocols. For example ``export QEMU_TEST_IO_SKIP="luks:149 185 iov-padding``
> > +will skip ``149`` for LUKS only, and ``185`` and ``iov-padding`` for all.
> > +
> >  Writing a new test case
> >  ~~~~~~~~~~~~~~~~~~~~~~~
> >  
> > diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
> > index dbe2dddc32..ecb5d4529f 100644
> > --- a/tests/qemu-iotests/testrunner.py
> > +++ b/tests/qemu-iotests/testrunner.py
> > @@ -145,6 +145,18 @@ def __init__(self, env: TestEnv, tap: bool = False,
> >  
> >          self._stack: contextlib.ExitStack
> >  
> > +        self.skip = {}
> > +        for rule in os.environ.get("QEMU_TEST_IO_SKIP", "").split(" "):
> > +            rule = rule.strip()
> > +            if rule == "":
> > +                continue
> > +            if ":" in rule:
> > +                fmt, name = rule.split(":")
> > +                if fmt in ("", env.imgfmt, env.imgproto):
> > +                    self.skip[name] = True
> > +            else:
> > +                self.skip[rule] = True
> > +
> >      def __enter__(self) -> 'TestRunner':
> >          self._stack = contextlib.ExitStack()
> >          self._stack.enter_context(self.env)
> > @@ -251,6 +263,10 @@ def do_run_test(self, test: str) -> TestResult:
> >                                description='No qualified output '
> >                                            f'(expected {f_reference})')
> >  
> > +        if f_test.name in self.skip:
> > +            return TestResult(status='not run',
> > +                              description='Listed in QEMU_TEST_IO_SKIP')
> > +
> >          args = [str(f_test.resolve())]
> >          env = self.env.prepare_subprocess(args)
> >  
> 
> Why not simply remove the broken tests, and create issues to add them
> again in the future?

In theory that's what our policy today is, but in practice it is
too much of a burden on the release co-ordinator, to expect them
to create such a patch themselves, or wait on a subsys maintainer
todo it for them.

They end up just ignoring brokenness in CI which is a bad practice,
and will prevent us ever making CI truely gating or switching to
using MRs for pull requests. This gives us a super-fast way to skip
flaky tests, while the subsystem maintainers figure out the right
permanent answer.

> Once it's green, in theory, code breaking existing tests should not be
> merged, right? So what would be the usage of this variable?

We have had a pretty decent chunk of non-deterministic test failures,
so there is high likelihood we can merge stuff that passes once and
then subsequently fails some subset of the time. This non-determinism
is one of the key reasons that we currently only have a hand picked
selection of block I/O tests run by meson.

While I've tested this series and haven't see any non-determinstic
failures in what I'm proposing to enable thus far, I think there is
still a pretty high chance we'll uncover some more.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


