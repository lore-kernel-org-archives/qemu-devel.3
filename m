Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DEEC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 09:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnDji-0008Jc-Lm; Wed, 26 Feb 2025 04:29:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnDjV-0008DL-Nv
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:29:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnDjS-00048Y-1O
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740562171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uX6iEgHmYLmEB9RWyb0VNxAvDVE+/yjg75mFLz6ImVw=;
 b=inDotOuqaQ+1SWywUcGV+KTvWnetY+1q7ZOciemjfvgiS6A1iAGrvRe1/Mt8Hv3/GrYRYk
 /H5VCdtNbJuGPjpRu/PS4xUBs9+c3FR9nGFOUR21rnyHek8AijWkp5cthGQgpwhFTxfwpQ
 U2T311LCXet4J2cXM9oqb+FWus4F6N8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-A7LPqAnkMluISjrb4xbVBQ-1; Wed,
 26 Feb 2025 04:29:27 -0500
X-MC-Unique: A7LPqAnkMluISjrb4xbVBQ-1
X-Mimecast-MFC-AGG-ID: A7LPqAnkMluISjrb4xbVBQ_1740562166
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 025E2180056F; Wed, 26 Feb 2025 09:29:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2269719560AB; Wed, 26 Feb 2025 09:29:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ACE3621E675E; Wed, 26 Feb 2025 10:29:22 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Thomas
 Huth <thuth@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Cleber Rosa
 <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 02/10] python: add qapi static analysis tests
In-Reply-To: <CAFn=p-Y-jr289LnWULq60Fj=+dA2=CHhRQ7wQD-NZGwKUk3tLQ@mail.gmail.com>
 (John Snow's message of "Mon, 24 Feb 2025 10:07:49 -0500")
References: <20250224033741.222749-1-jsnow@redhat.com>
 <20250224033741.222749-3-jsnow@redhat.com>
 <87o6yrfrjc.fsf@pond.sub.org>
 <CAFn=p-Y-jr289LnWULq60Fj=+dA2=CHhRQ7wQD-NZGwKUk3tLQ@mail.gmail.com>
Date: Wed, 26 Feb 2025 10:29:22 +0100
Message-ID: <87cyf52gwd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

John Snow <jsnow@redhat.com> writes:

> On Mon, Feb 24, 2025 at 7:36=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Update the python tests to also check qapi. No idea why I didn't do th=
is
>> > before. I guess I was counting on moving it under python/ and then just
>> > forgot after that was NACKed. Oops, this turns out to be really easy.
>> >
>> > flake8, isort and mypy use the tool configuration from the existing
>> > python directory. pylint continues to use the special configuration
>> > located in scripts/qapi/ - that configuration is more permissive. If we
>> > wish to unify the two configurations, that's a separate series and a
>> > discussion for a later date.
>> >
>> > As a result of this patch, one would be able to run any of the followi=
ng
>> > tests locally from the qemu.git/python directory and have it cover the
>> > scripts/qapi/ module as well. All of the following options run the
>> > python tests, static analysis tests, and linter checks; but with
>> > different combinations of dependencies and interpreters.
>> >
>> > - "make check-minreqs" Run tests specifically under our oldest support=
ed
>> >   Python and our oldest supported dependencies. This is the test that
>> >   runs on GitLab as "check-python-minreqs". This helps ensure we do not
>> >   regress support on older platforms accidentally.
>> >
>> > - "make check-tox" Runs the tests under the newest supported
>> >   dependencies, but under each supported version of Python in turn. At
>> >   time of writing, this is Python 3.8 to 3.13 inclusive. This test hel=
ps
>> >   catch bleeding-edge problems before they become problems for develop=
er
>> >   workstations. This is the GitLab test "check-python-tox" and is an
>> >   optionally run, may-fail test due to the unpredictable nature of new
>> >   dependencies being released into the ecosystem that may cause
>> >   regressions.
>> >
>> > - "make check-dev" Runs the tests under the newest supported
>> >   dependencies using whatever version of Python the user happens to ha=
ve
>> >   installed. This is a quick convenience check that does not map to any
>> >   particular GitLab test.
>> >
>> > (Note! check-dev may be busted on Fedora 41 and bleeding edge versions
>>
>> It is for me.
>>
>> > of setuptools. That's unrelated to this patch and I'll address it
>> > separately and soon. Thank you for your patience, --mgmt)
>>
>> Which of these tests, if any, run in "make check"?  In CI?
>>
>
> Under "make check", the top-level test in qemu.git, none. I swear on my
> future grave

"Not today!"

>              I am trying to fix that,

Also not today.  SCNR!

>                                       but there are barriers to it. Adding
> make check support means installing testing dependencies in the configure
> venv, which means a slower ./configure invocation. I am trying to figure
> out how to minimize this penalty for cases where we either do not want to,
> or can't, run the python tests. It's a long story, we can talk about it
> later.
>
> In CI, the "check-minreqs" test will run by default as a must-pass test
> under the job "check python minreqs".
>
> "check-tox" is an optional job in the CI pipeline that is allowed to fail
> as a warning, due to the nature of this test checking bleeding edge
> dependencies.
>
> All three local invocations run the exact same tests (literally "make
> check" in the python dir), just under different combinations of
> dependencies and python versions. "check-minreqs" is more or less the
> "canonical" one that *must* succeed, but as a Python maintainer I do my
> best to enforce "check-tox" as well, though it does lag behind.
>
> So, this isn't a perfect solution yet but it's certainly much better than
> carrying around ad-hoc linter shell scripts and attempting to manage the
> dependencies yourself. At least we all have access to the same invocation=
s.

So:

* At some point, we'll integrate whatever we want developers to run into
  "make check".  Until then:

* Running "make check-dev" is nice and good enough.  CI might find
  additional problems.  Expected to be rare and no big deal.

* Running "make check-minreqs" locally will get the exact same results
  as the same test in CI will.  Run if you care.

* "make check-tox" is an early warning system.  Don't run unless you're
  interested in preventing potential future problems.

Acked-by: Markus Armbruster <armbru@redhat.com>

[...]


