Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92CDC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 06:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txK0b-0001zy-8B; Wed, 26 Mar 2025 02:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1txK0Y-0001yO-Gc
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 02:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1txK0V-000243-F6
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 02:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742969574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1zFfOoJc7RV6sjpycOf3iph+CgExLOtuCuYnxMHOhnM=;
 b=TwhBJaD2JFkoz8u7feOYQLMr/puV1W4M5Ykng4VfG7fuoLoH677hIHeiAJ48GRZXqm5qk4
 YTezDnBFkNJfyXTOiZD9idvEluV/GWAlE2vQfDzQhKbBAmy52kMC7L/0+beJgVi0OavnAO
 dt01QQYa78/byxMnKdEl5nJUftROS+o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-WIittk8CN4y-noZCMV3k2g-1; Wed,
 26 Mar 2025 02:12:51 -0400
X-MC-Unique: WIittk8CN4y-noZCMV3k2g-1
X-Mimecast-MFC-AGG-ID: WIittk8CN4y-noZCMV3k2g_1742969570
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F74519373D7; Wed, 26 Mar 2025 06:12:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3B54180B486; Wed, 26 Mar 2025 06:12:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AC50221E66C7; Wed, 26 Mar 2025 07:12:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  Cleber
 Rosa <crosa@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 4/5] python: add qapi static analysis tests
In-Reply-To: <CAFn=p-brXaJZBxUsJAQGsPvOF7MovAWfH3bdMMHQYCrkJWQVeA@mail.gmail.com>
 (John Snow's message of "Tue, 25 Mar 2025 12:56:37 -0400")
References: <20250321222347.299121-1-jsnow@redhat.com>
 <20250321222347.299121-5-jsnow@redhat.com>
 <87jz8dpmwa.fsf@pond.sub.org>
 <CAFn=p-brXaJZBxUsJAQGsPvOF7MovAWfH3bdMMHQYCrkJWQVeA@mail.gmail.com>
Date: Wed, 26 Mar 2025 07:12:46 +0100
Message-ID: <877c4cfhgh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

John Snow <jsnow@redhat.com> writes:

> On Tue, Mar 25, 2025 at 3:53=E2=80=AFAM Markus Armbruster <armbru@redhat.=
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
>> > python directory (in setup.cfg). pylint continues to use the special
>> > configuration located in scripts/qapi/ - that configuration is more
>> > permissive. If we wish to unify the two configurations, that's a
>> > separate series and a discussion for a later date.
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
>> > of setuptools. That's unrelated to this patch and I'll address it
>> > separately and soon. Thank you for your patience, --mgmt)
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>>
>> Let's mention this is a step towards having "make check" run the static
>> analysis we want developers to run, but we're not there, yet.
>>
>
> It both is and isn't. That we can now check qapi and the qapi sphinx
> extensions from the same place as we do linting for python/ is sufficient
> justification in and of itself, regardless of how we improve and integrate
> this testing later on.

Alright.

>> > ---
>> >  python/setup.cfg            |  1 +
>> >  python/tests/minreqs.txt    | 21 +++++++++++++++++++++
>> >  python/tests/qapi-flake8.sh |  4 ++++
>> >  python/tests/qapi-isort.sh  |  6 ++++++
>> >  python/tests/qapi-mypy.sh   |  2 ++
>> >  python/tests/qapi-pylint.sh |  6 ++++++
>> >  scripts/qapi/pylintrc       |  1 +
>> >  7 files changed, 41 insertions(+)
>> >  create mode 100755 python/tests/qapi-flake8.sh
>> >  create mode 100755 python/tests/qapi-isort.sh
>> >  create mode 100755 python/tests/qapi-mypy.sh
>> >  create mode 100755 python/tests/qapi-pylint.sh
>> >
>> > diff --git a/python/setup.cfg b/python/setup.cfg
>> > index cf5af7e6641..84d8a1fd30d 100644
>> > --- a/python/setup.cfg
>> > +++ b/python/setup.cfg
>> > @@ -47,6 +47,7 @@ devel =3D
>> >      urwid >=3D 2.1.2
>> >      urwid-readline >=3D 0.13
>> >      Pygments >=3D 2.9.0
>> > +    sphinx >=3D 3.4.3
>> >
>> >  # Provides qom-fuse functionality
>> >  fuse =3D
>> > diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
>> > index 19c0f5e4c50..94928936d44 100644
>> > --- a/python/tests/minreqs.txt
>> > +++ b/python/tests/minreqs.txt
>> > @@ -11,6 +11,9 @@
>> >  # When adding new dependencies, pin the very oldest non-yanked version
>> >  # on PyPI that allows the test suite to pass.
>> >
>> > +# Dependencies for qapidoc/qapi_domain et al
>> > +sphinx=3D=3D3.4.3
>> > +
>> >  # Dependencies for the TUI addon (Required for successful linting)
>> >  urwid=3D=3D2.1.2
>> >  urwid-readline=3D=3D0.13
>> > @@ -49,3 +52,21 @@ platformdirs=3D=3D2.2.0
>> >  toml=3D=3D0.10.0
>> >  tomlkit=3D=3D0.10.1
>> >  wrapt=3D=3D1.14.0
>> > +
>> > +# Transitive sphinx dependencies
>> > +Jinja2=3D=3D2.7
>> > +MarkupSafe=3D=3D1.1.0
>> > +alabaster=3D=3D0.7.1
>> > +babel=3D=3D1.3
>> > +docutils=3D=3D0.12
>> > +imagesize=3D=3D0.5.0
>> > +packaging=3D=3D14.0
>> > +pytz=3D=3D2011b0
>> > +requests=3D=3D2.5.0
>> > +snowballstemmer=3D=3D1.1
>> > +sphinxcontrib-applehelp=3D=3D1.0.0
>> > +sphinxcontrib-devhelp=3D=3D1.0.0
>> > +sphinxcontrib-htmlhelp=3D=3D1.0.0
>> > +sphinxcontrib-jsmath=3D=3D1.0.0
>> > +sphinxcontrib-qthelp=3D=3D1.0.0
>> > +sphinxcontrib-serializinghtml=3D=3D1.0.0
>>
>> This wasn't there when I last saw this patch.  The previous patch also
>> updates this file.  How did you decide which updates go where?  Or is
>> this an accident?
>>
>
> The previous patch pins dependencies that already existed, but we neglect=
ed
> to pin in this file. It's fixing an existing oversight.
>
> This patch adds a bunch of new pinned dependencies for Sphinx, which we
> need for type-checking Sphinx extensions.

So... the previous patch fixes existing tests, and this one extends
their coverage to the modern parts of docs/sphinx/.  Correct?

Which tests exactly?  I just asked that on the previous patch.

[...]

>> > diff --git a/scripts/qapi/pylintrc b/scripts/qapi/pylintrc
>> > index d24eece7411..e16283ada3d 100644
>> > --- a/scripts/qapi/pylintrc
>> > +++ b/scripts/qapi/pylintrc
>> > @@ -19,6 +19,7 @@ disable=3Dconsider-using-f-string,
>> >          too-many-instance-attributes,
>> >          too-many-positional-arguments,
>> >          too-many-statements,
>> > +        unknown-option-value,
>> >          useless-option-value,
>> >
>> >  [REPORTS]
>>
>> This wasn't there when I last saw this patch.  PATCH 1 also updates this
>> file.  How did you decide which updates go where?  Or is this an
>> accident?
>
>
> I didn't add the Sphinx extensions last time you saw this series, so that=
's
> new. This winds up being needed to tolerate the "too many positional
> arguments" option which only applies to newer pylint versions - older
> versions will complain about the option being unrecognized. In order to
> continue allowing a wide version of pylint versions, we need this option.

Got it.  Worth a comment?


