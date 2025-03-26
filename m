Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43FBC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 20:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txXB3-0005AJ-CP; Wed, 26 Mar 2025 16:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1txXB1-00059y-Ie
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 16:16:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1txXAr-0002W7-JL
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 16:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743020186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qVVAbl18UkFg852ZBOVprYAhdWUCxChPlhHJ0WvTVk8=;
 b=Uane48W5zqmzSwVhExoR5MltWpDhFVsQ0oBmND2YS/6oPdJEbM90evFAb2kYGcXMT8E8ZA
 xSOl+hJIrwHa2dsEtiVZ/itRZHmFI0NCsYv41++2mr3d5lME6lnp37UPwLdoh7J9ssT2HN
 CfFDRb82ptY5iYzoFs+A/pqYfzhnFgY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-VwWscVZ_Og-MPu1xi86chA-1; Wed, 26 Mar 2025 16:16:24 -0400
X-MC-Unique: VwWscVZ_Og-MPu1xi86chA-1
X-Mimecast-MFC-AGG-ID: VwWscVZ_Og-MPu1xi86chA_1743020184
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ff8c5d185aso453031a91.1
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 13:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743020184; x=1743624984;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qVVAbl18UkFg852ZBOVprYAhdWUCxChPlhHJ0WvTVk8=;
 b=Y+s6H22FkSmMK8SZbIvlscFdhfhzgwgQTSrBald4uZgNV2QKryQRf5nPGAfKrsXT4z
 +UI6P92wulPNqrc5BWNrx+EKhN4I08wLXO/zcTMsYytK5fRvBBh1TXWRrt3OJESLvIta
 D9Krlz4G2Gj5DcLNXsY4n8E0B7hHFyJ+RuTIICAv8TsKo3MN3T6/4aHz2Y6A8MAjIo+Z
 0fqUVyuhOfFArhWdRuJHK/u6jx5Mnk2rLx99A5FKtl6BtEyWoSygSk+UPkMRAB2zbH9J
 2P8U9wsO9+CJKwfICz2x9MGpT9I9OWRxTPot3bWgXWpB9BR98pRmn+HAUsBE/Pr1pvIJ
 990Q==
X-Gm-Message-State: AOJu0YzXApnel88HYOfAuHqvK7frs7gSmmHhIfrL89xNAZhHCZW7Lplh
 yq68DC4Kz+SBjRMCAJpa4NSSVa7MpW1/brpc7X3nq2MLDuMrVC1+dYsWD6e/rQ4Vt14stbMCjDk
 gADq6m3zvHOK81sf8P7zGPULj+Qcf9Ulg7wzGVXTJuCVl77L1PP7rGPVbshYbZZOYzitxMvFaUA
 zYkMygJ1MDWYs2wj6l155B5ttg5Qo=
X-Gm-Gg: ASbGncu9/dj0wPVIt0VjuFNORXMgWKVT3mZSAJXDTbDZoD7U6HlsPHBOMxKFnxoHpk6
 2+hdRwUYhONvLLFwcvBJjJDclH+ycwm1VXP1vVmyl5jmgz3X1Vy+WTavpFdZRuufVys+7hLRr6S
 ZCQPvR+fXTWiY6DjOLwFC2VJDksD9U
X-Received: by 2002:a17:90a:c2cb:b0:2ee:d024:e4fc with SMTP id
 98e67ed59e1d1-303a8e78b3emr1688700a91.33.1743020183845; 
 Wed, 26 Mar 2025 13:16:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm9P2CBdWcDx4wOsUAgJ6mNJMA4KrSALl0nkJLtVHE50SuLUr5vU9jIY2+Ph2EUyBUX1QZa3/t/L/0YbfEbtE=
X-Received: by 2002:a17:90a:c2cb:b0:2ee:d024:e4fc with SMTP id
 98e67ed59e1d1-303a8e78b3emr1688655a91.33.1743020183477; Wed, 26 Mar 2025
 13:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250321222347.299121-1-jsnow@redhat.com>
 <20250321222347.299121-5-jsnow@redhat.com>
 <87jz8dpmwa.fsf@pond.sub.org>
 <CAFn=p-brXaJZBxUsJAQGsPvOF7MovAWfH3bdMMHQYCrkJWQVeA@mail.gmail.com>
 <877c4cfhgh.fsf@pond.sub.org>
In-Reply-To: <877c4cfhgh.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 26 Mar 2025 16:16:09 -0400
X-Gm-Features: AQ5f1JopSTXPsJtr87xdAUnsF2-1wByxzZNulXBWWL_8MIfzZv8DsgdTDAdpiTc
Message-ID: <CAFn=p-akBnMY2fkEO-RJLBvTSLtZqc_qQw5UgSKrKSKuWccXyg@mail.gmail.com>
Subject: Re: [PATCH 4/5] python: add qapi static analysis tests
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000df79e106314482df"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000df79e106314482df
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 2:13=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Tue, Mar 25, 2025 at 3:53=E2=80=AFAM Markus Armbruster <armbru@redha=
t.com>
> wrote:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > Update the python tests to also check qapi. No idea why I didn't do
> this
> >> > before. I guess I was counting on moving it under python/ and then
> just
> >> > forgot after that was NACKed. Oops, this turns out to be really easy=
.
> >> >
> >> > flake8, isort and mypy use the tool configuration from the existing
> >> > python directory (in setup.cfg). pylint continues to use the special
> >> > configuration located in scripts/qapi/ - that configuration is more
> >> > permissive. If we wish to unify the two configurations, that's a
> >> > separate series and a discussion for a later date.
> >> >
> >> > As a result of this patch, one would be able to run any of the
> following
> >> > tests locally from the qemu.git/python directory and have it cover t=
he
> >> > scripts/qapi/ module as well. All of the following options run the
> >> > python tests, static analysis tests, and linter checks; but with
> >> > different combinations of dependencies and interpreters.
> >> >
> >> > - "make check-minreqs" Run tests specifically under our oldest
> supported
> >> >   Python and our oldest supported dependencies. This is the test tha=
t
> >> >   runs on GitLab as "check-python-minreqs". This helps ensure we do
> not
> >> >   regress support on older platforms accidentally.
> >> >
> >> > - "make check-tox" Runs the tests under the newest supported
> >> >   dependencies, but under each supported version of Python in turn. =
At
> >> >   time of writing, this is Python 3.8 to 3.13 inclusive. This test
> helps
> >> >   catch bleeding-edge problems before they become problems for
> developer
> >> >   workstations. This is the GitLab test "check-python-tox" and is an
> >> >   optionally run, may-fail test due to the unpredictable nature of n=
ew
> >> >   dependencies being released into the ecosystem that may cause
> >> >   regressions.
> >> >
> >> > - "make check-dev" Runs the tests under the newest supported
> >> >   dependencies using whatever version of Python the user happens to
> have
> >> >   installed. This is a quick convenience check that does not map to
> any
> >> >   particular GitLab test.
> >> >
> >> > (Note! check-dev may be busted on Fedora 41 and bleeding edge versio=
ns
> >> > of setuptools. That's unrelated to this patch and I'll address it
> >> > separately and soon. Thank you for your patience, --mgmt)
> >> >
> >> > Signed-off-by: John Snow <jsnow@redhat.com>
> >>
> >> Let's mention this is a step towards having "make check" run the stati=
c
> >> analysis we want developers to run, but we're not there, yet.
> >>
> >
> > It both is and isn't. That we can now check qapi and the qapi sphinx
> > extensions from the same place as we do linting for python/ is sufficie=
nt
> > justification in and of itself, regardless of how we improve and
> integrate
> > this testing later on.
>
> Alright.
>
> >> > ---
> >> >  python/setup.cfg            |  1 +
> >> >  python/tests/minreqs.txt    | 21 +++++++++++++++++++++
> >> >  python/tests/qapi-flake8.sh |  4 ++++
> >> >  python/tests/qapi-isort.sh  |  6 ++++++
> >> >  python/tests/qapi-mypy.sh   |  2 ++
> >> >  python/tests/qapi-pylint.sh |  6 ++++++
> >> >  scripts/qapi/pylintrc       |  1 +
> >> >  7 files changed, 41 insertions(+)
> >> >  create mode 100755 python/tests/qapi-flake8.sh
> >> >  create mode 100755 python/tests/qapi-isort.sh
> >> >  create mode 100755 python/tests/qapi-mypy.sh
> >> >  create mode 100755 python/tests/qapi-pylint.sh
> >> >
> >> > diff --git a/python/setup.cfg b/python/setup.cfg
> >> > index cf5af7e6641..84d8a1fd30d 100644
> >> > --- a/python/setup.cfg
> >> > +++ b/python/setup.cfg
> >> > @@ -47,6 +47,7 @@ devel =3D
> >> >      urwid >=3D 2.1.2
> >> >      urwid-readline >=3D 0.13
> >> >      Pygments >=3D 2.9.0
> >> > +    sphinx >=3D 3.4.3
> >> >
> >> >  # Provides qom-fuse functionality
> >> >  fuse =3D
> >> > diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
> >> > index 19c0f5e4c50..94928936d44 100644
> >> > --- a/python/tests/minreqs.txt
> >> > +++ b/python/tests/minreqs.txt
> >> > @@ -11,6 +11,9 @@
> >> >  # When adding new dependencies, pin the very oldest non-yanked
> version
> >> >  # on PyPI that allows the test suite to pass.
> >> >
> >> > +# Dependencies for qapidoc/qapi_domain et al
> >> > +sphinx=3D=3D3.4.3
> >> > +
> >> >  # Dependencies for the TUI addon (Required for successful linting)
> >> >  urwid=3D=3D2.1.2
> >> >  urwid-readline=3D=3D0.13
> >> > @@ -49,3 +52,21 @@ platformdirs=3D=3D2.2.0
> >> >  toml=3D=3D0.10.0
> >> >  tomlkit=3D=3D0.10.1
> >> >  wrapt=3D=3D1.14.0
> >> > +
> >> > +# Transitive sphinx dependencies
> >> > +Jinja2=3D=3D2.7
> >> > +MarkupSafe=3D=3D1.1.0
> >> > +alabaster=3D=3D0.7.1
> >> > +babel=3D=3D1.3
> >> > +docutils=3D=3D0.12
> >> > +imagesize=3D=3D0.5.0
> >> > +packaging=3D=3D14.0
> >> > +pytz=3D=3D2011b0
> >> > +requests=3D=3D2.5.0
> >> > +snowballstemmer=3D=3D1.1
> >> > +sphinxcontrib-applehelp=3D=3D1.0.0
> >> > +sphinxcontrib-devhelp=3D=3D1.0.0
> >> > +sphinxcontrib-htmlhelp=3D=3D1.0.0
> >> > +sphinxcontrib-jsmath=3D=3D1.0.0
> >> > +sphinxcontrib-qthelp=3D=3D1.0.0
> >> > +sphinxcontrib-serializinghtml=3D=3D1.0.0
> >>
> >> This wasn't there when I last saw this patch.  The previous patch also
> >> updates this file.  How did you decide which updates go where?  Or is
> >> this an accident?
> >>
> >
> > The previous patch pins dependencies that already existed, but we
> neglected
> > to pin in this file. It's fixing an existing oversight.
> >
> > This patch adds a bunch of new pinned dependencies for Sphinx, which we
> > need for type-checking Sphinx extensions.
>
> So... the previous patch fixes existing tests, and this one extends
> their coverage to the modern parts of docs/sphinx/.  Correct?
>

Yep.


>
> Which tests exactly?  I just asked that on the previous patch.
>

minreqs.txt concerns only make check-minreqs, but the shell script tests
that just invoke a linter concern all launch avenues: make check, make
check-dev, make check-tox, make check-minreqs.


>
> [...]
>
> >> > diff --git a/scripts/qapi/pylintrc b/scripts/qapi/pylintrc
> >> > index d24eece7411..e16283ada3d 100644
> >> > --- a/scripts/qapi/pylintrc
> >> > +++ b/scripts/qapi/pylintrc
> >> > @@ -19,6 +19,7 @@ disable=3Dconsider-using-f-string,
> >> >          too-many-instance-attributes,
> >> >          too-many-positional-arguments,
> >> >          too-many-statements,
> >> > +        unknown-option-value,
> >> >          useless-option-value,
> >> >
> >> >  [REPORTS]
> >>
> >> This wasn't there when I last saw this patch.  PATCH 1 also updates th=
is
> >> file.  How did you decide which updates go where?  Or is this an
> >> accident?
> >
> >
> > I didn't add the Sphinx extensions last time you saw this series, so
> that's
> > new. This winds up being needed to tolerate the "too many positional
> > arguments" option which only applies to newer pylint versions - older
> > versions will complain about the option being unrecognized. In order to
> > continue allowing a wide version of pylint versions, we need this optio=
n.
>
> Got it.  Worth a comment?
>

Yep, I can update the commit message.

--000000000000df79e106314482df
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 26,=
 2025 at 2:13=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Tue, Mar 25, 2025 at 3:53=E2=80=AFAM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; w=
rote:<br>
&gt;<br>
&gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank=
">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; Update the python tests to also check qapi. No idea why I did=
n&#39;t do this<br>
&gt;&gt; &gt; before. I guess I was counting on moving it under python/ and=
 then just<br>
&gt;&gt; &gt; forgot after that was NACKed. Oops, this turns out to be real=
ly easy.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; flake8, isort and mypy use the tool configuration from the ex=
isting<br>
&gt;&gt; &gt; python directory (in setup.cfg). pylint continues to use the =
special<br>
&gt;&gt; &gt; configuration located in scripts/qapi/ - that configuration i=
s more<br>
&gt;&gt; &gt; permissive. If we wish to unify the two configurations, that&=
#39;s a<br>
&gt;&gt; &gt; separate series and a discussion for a later date.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; As a result of this patch, one would be able to run any of th=
e following<br>
&gt;&gt; &gt; tests locally from the qemu.git/python directory and have it =
cover the<br>
&gt;&gt; &gt; scripts/qapi/ module as well. All of the following options ru=
n the<br>
&gt;&gt; &gt; python tests, static analysis tests, and linter checks; but w=
ith<br>
&gt;&gt; &gt; different combinations of dependencies and interpreters.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; - &quot;make check-minreqs&quot; Run tests specifically under=
 our oldest supported<br>
&gt;&gt; &gt;=C2=A0 =C2=A0Python and our oldest supported dependencies. Thi=
s is the test that<br>
&gt;&gt; &gt;=C2=A0 =C2=A0runs on GitLab as &quot;check-python-minreqs&quot=
;. This helps ensure we do not<br>
&gt;&gt; &gt;=C2=A0 =C2=A0regress support on older platforms accidentally.<=
br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; - &quot;make check-tox&quot; Runs the tests under the newest =
supported<br>
&gt;&gt; &gt;=C2=A0 =C2=A0dependencies, but under each supported version of=
 Python in turn. At<br>
&gt;&gt; &gt;=C2=A0 =C2=A0time of writing, this is Python 3.8 to 3.13 inclu=
sive. This test helps<br>
&gt;&gt; &gt;=C2=A0 =C2=A0catch bleeding-edge problems before they become p=
roblems for developer<br>
&gt;&gt; &gt;=C2=A0 =C2=A0workstations. This is the GitLab test &quot;check=
-python-tox&quot; and is an<br>
&gt;&gt; &gt;=C2=A0 =C2=A0optionally run, may-fail test due to the unpredic=
table nature of new<br>
&gt;&gt; &gt;=C2=A0 =C2=A0dependencies being released into the ecosystem th=
at may cause<br>
&gt;&gt; &gt;=C2=A0 =C2=A0regressions.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; - &quot;make check-dev&quot; Runs the tests under the newest =
supported<br>
&gt;&gt; &gt;=C2=A0 =C2=A0dependencies using whatever version of Python the=
 user happens to have<br>
&gt;&gt; &gt;=C2=A0 =C2=A0installed. This is a quick convenience check that=
 does not map to any<br>
&gt;&gt; &gt;=C2=A0 =C2=A0particular GitLab test.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; (Note! check-dev may be busted on Fedora 41 and bleeding edge=
 versions<br>
&gt;&gt; &gt; of setuptools. That&#39;s unrelated to this patch and I&#39;l=
l address it<br>
&gt;&gt; &gt; separately and soon. Thank you for your patience, --mgmt)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.c=
om" target=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; Let&#39;s mention this is a step towards having &quot;make check&q=
uot; run the static<br>
&gt;&gt; analysis we want developers to run, but we&#39;re not there, yet.<=
br>
&gt;&gt;<br>
&gt;<br>
&gt; It both is and isn&#39;t. That we can now check qapi and the qapi sphi=
nx<br>
&gt; extensions from the same place as we do linting for python/ is suffici=
ent<br>
&gt; justification in and of itself, regardless of how we improve and integ=
rate<br>
&gt; this testing later on.<br>
<br>
Alright.<br>
<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 python/setup.cfg=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 1 +<br>
&gt;&gt; &gt;=C2=A0 python/tests/minreqs.txt=C2=A0 =C2=A0 | 21 ++++++++++++=
+++++++++<br>
&gt;&gt; &gt;=C2=A0 python/tests/qapi-flake8.sh |=C2=A0 4 ++++<br>
&gt;&gt; &gt;=C2=A0 python/tests/qapi-isort.sh=C2=A0 |=C2=A0 6 ++++++<br>
&gt;&gt; &gt;=C2=A0 python/tests/qapi-mypy.sh=C2=A0 =C2=A0|=C2=A0 2 ++<br>
&gt;&gt; &gt;=C2=A0 python/tests/qapi-pylint.sh |=C2=A0 6 ++++++<br>
&gt;&gt; &gt;=C2=A0 scripts/qapi/pylintrc=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 1 +<br>
&gt;&gt; &gt;=C2=A0 7 files changed, 41 insertions(+)<br>
&gt;&gt; &gt;=C2=A0 create mode 100755 python/tests/qapi-flake8.sh<br>
&gt;&gt; &gt;=C2=A0 create mode 100755 python/tests/qapi-isort.sh<br>
&gt;&gt; &gt;=C2=A0 create mode 100755 python/tests/qapi-mypy.sh<br>
&gt;&gt; &gt;=C2=A0 create mode 100755 python/tests/qapi-pylint.sh<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/python/setup.cfg b/python/setup.cfg<br>
&gt;&gt; &gt; index cf5af7e6641..84d8a1fd30d 100644<br>
&gt;&gt; &gt; --- a/python/setup.cfg<br>
&gt;&gt; &gt; +++ b/python/setup.cfg<br>
&gt;&gt; &gt; @@ -47,6 +47,7 @@ devel =3D<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 urwid &gt;=3D 2.1.2<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 urwid-readline &gt;=3D 0.13<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 Pygments &gt;=3D 2.9.0<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 sphinx &gt;=3D 3.4.3<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 # Provides qom-fuse functionality<br>
&gt;&gt; &gt;=C2=A0 fuse =3D<br>
&gt;&gt; &gt; diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.=
txt<br>
&gt;&gt; &gt; index 19c0f5e4c50..94928936d44 100644<br>
&gt;&gt; &gt; --- a/python/tests/minreqs.txt<br>
&gt;&gt; &gt; +++ b/python/tests/minreqs.txt<br>
&gt;&gt; &gt; @@ -11,6 +11,9 @@<br>
&gt;&gt; &gt;=C2=A0 # When adding new dependencies, pin the very oldest non=
-yanked version<br>
&gt;&gt; &gt;=C2=A0 # on PyPI that allows the test suite to pass.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; +# Dependencies for qapidoc/qapi_domain et al<br>
&gt;&gt; &gt; +sphinx=3D=3D3.4.3<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt;=C2=A0 # Dependencies for the TUI addon (Required for successf=
ul linting)<br>
&gt;&gt; &gt;=C2=A0 urwid=3D=3D2.1.2<br>
&gt;&gt; &gt;=C2=A0 urwid-readline=3D=3D0.13<br>
&gt;&gt; &gt; @@ -49,3 +52,21 @@ platformdirs=3D=3D2.2.0<br>
&gt;&gt; &gt;=C2=A0 toml=3D=3D0.10.0<br>
&gt;&gt; &gt;=C2=A0 tomlkit=3D=3D0.10.1<br>
&gt;&gt; &gt;=C2=A0 wrapt=3D=3D1.14.0<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +# Transitive sphinx dependencies<br>
&gt;&gt; &gt; +Jinja2=3D=3D2.7<br>
&gt;&gt; &gt; +MarkupSafe=3D=3D1.1.0<br>
&gt;&gt; &gt; +alabaster=3D=3D0.7.1<br>
&gt;&gt; &gt; +babel=3D=3D1.3<br>
&gt;&gt; &gt; +docutils=3D=3D0.12<br>
&gt;&gt; &gt; +imagesize=3D=3D0.5.0<br>
&gt;&gt; &gt; +packaging=3D=3D14.0<br>
&gt;&gt; &gt; +pytz=3D=3D2011b0<br>
&gt;&gt; &gt; +requests=3D=3D2.5.0<br>
&gt;&gt; &gt; +snowballstemmer=3D=3D1.1<br>
&gt;&gt; &gt; +sphinxcontrib-applehelp=3D=3D1.0.0<br>
&gt;&gt; &gt; +sphinxcontrib-devhelp=3D=3D1.0.0<br>
&gt;&gt; &gt; +sphinxcontrib-htmlhelp=3D=3D1.0.0<br>
&gt;&gt; &gt; +sphinxcontrib-jsmath=3D=3D1.0.0<br>
&gt;&gt; &gt; +sphinxcontrib-qthelp=3D=3D1.0.0<br>
&gt;&gt; &gt; +sphinxcontrib-serializinghtml=3D=3D1.0.0<br>
&gt;&gt;<br>
&gt;&gt; This wasn&#39;t there when I last saw this patch.=C2=A0 The previo=
us patch also<br>
&gt;&gt; updates this file.=C2=A0 How did you decide which updates go where=
?=C2=A0 Or is<br>
&gt;&gt; this an accident?<br>
&gt;&gt;<br>
&gt;<br>
&gt; The previous patch pins dependencies that already existed, but we negl=
ected<br>
&gt; to pin in this file. It&#39;s fixing an existing oversight.<br>
&gt;<br>
&gt; This patch adds a bunch of new pinned dependencies for Sphinx, which w=
e<br>
&gt; need for type-checking Sphinx extensions.<br>
<br>
So... the previous patch fixes existing tests, and this one extends<br>
their coverage to the modern parts of docs/sphinx/.=C2=A0 Correct?<br></blo=
ckquote><div><br></div><div>Yep.</div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
<br>
Which tests exactly?=C2=A0 I just asked that on the previous patch.<br></bl=
ockquote><div><br></div><div>minreqs.txt concerns only make check-minreqs, =
but the shell script tests that just invoke a linter concern all launch ave=
nues: make check, make check-dev, make check-tox, make check-minreqs.</div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
[...]<br>
<br>
&gt;&gt; &gt; diff --git a/scripts/qapi/pylintrc b/scripts/qapi/pylintrc<br=
>
&gt;&gt; &gt; index d24eece7411..e16283ada3d 100644<br>
&gt;&gt; &gt; --- a/scripts/qapi/pylintrc<br>
&gt;&gt; &gt; +++ b/scripts/qapi/pylintrc<br>
&gt;&gt; &gt; @@ -19,6 +19,7 @@ disable=3Dconsider-using-f-string,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 too-many-instance-attribute=
s,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 too-many-positional-argumen=
ts,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 too-many-statements,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unknown-option-value,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 useless-option-value,<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 [REPORTS]<br>
&gt;&gt;<br>
&gt;&gt; This wasn&#39;t there when I last saw this patch.=C2=A0 PATCH 1 al=
so updates this<br>
&gt;&gt; file.=C2=A0 How did you decide which updates go where?=C2=A0 Or is=
 this an<br>
&gt;&gt; accident?<br>
&gt;<br>
&gt;<br>
&gt; I didn&#39;t add the Sphinx extensions last time you saw this series, =
so that&#39;s<br>
&gt; new. This winds up being needed to tolerate the &quot;too many positio=
nal<br>
&gt; arguments&quot; option which only applies to newer pylint versions - o=
lder<br>
&gt; versions will complain about the option being unrecognized. In order t=
o<br>
&gt; continue allowing a wide version of pylint versions, we need this opti=
on.<br>
<br>
Got it.=C2=A0 Worth a comment?<br></blockquote><div><br></div><div>Yep, I c=
an update the commit message.</div><div>=C2=A0</div></div></div>

--000000000000df79e106314482df--


