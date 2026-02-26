Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF5BFD8FCF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 16:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vveJM-00011l-0s; Thu, 26 Feb 2026 11:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vveJJ-00011O-3D
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 11:33:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vveJG-0000yX-1a
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 11:33:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772123633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BJVX9inQjvP7mLOetWSznqPp5QP+PzSMRIxGl2hnmuY=;
 b=FCjWFeN0CCjdp/t111fTb1FvLMmvnGOmVr1f2YnNvKGmxCX40dT92KdAVOn75Bi94+nz7r
 WQauqVBxoK3x/ai0AUaWnqQJMNr5Wlgf6HrpFMrumRDo0mQtfeTBF8pWP8k0oxB+dl2LT4
 pTCGWPCcT27zUmRlfbNRpJPYEUtaQyI=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-Cl-7-vUUM96BhKvg-sSAlQ-1; Thu, 26 Feb 2026 11:33:51 -0500
X-MC-Unique: Cl-7-vUUM96BhKvg-sSAlQ-1
X-Mimecast-MFC-AGG-ID: Cl-7-vUUM96BhKvg-sSAlQ_1772123631
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-64c98481d1eso1723189d50.2
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 08:33:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772123631; cv=none;
 d=google.com; s=arc-20240605;
 b=gkXYyh653QKDvee3cNaXVz4TYOAjLGd4BKyL3N1sb4V6ipLa/tYF8qaSPV/f/2brnM
 h8KPmx++/lQbFns3sbox+vVjR/B4HuG9cE84R9oINlfjZkBRRcTGkISF+rWn9UaACDbh
 /HO0zprnr/E3bpUCFrOAMb4IQGG6oYThdrMS+9AaZNleG2dGURaTNLOry1M4aRBG5h7E
 sZ7grHkl4/GxfvZoyDkrsSxpXY/SH20ug4dl9rMWQQp4SF6QPskPOjzU/y88ehcP8LsS
 A34n8p/wZDwCiaAHT7CCulC0IG5pyCmk9T1bBRIKYFPovwp6ta4X9Mwt70ROWKUypxcr
 HJHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BJVX9inQjvP7mLOetWSznqPp5QP+PzSMRIxGl2hnmuY=;
 fh=ObKPTrjYCgo7QhUsUU1R/s2OQvcF7mim5CNR+CGqk9k=;
 b=SCelrsDJZTgppgOxC/XFmRgw4MM3oaAAhy+uyKbUlo3Mzv0oMDIU9yNYPdnREUAd64
 G/1QTBsmwXMA53J+XpZBuZqc8RvWMWbZv2F7nePhOwIh4LohoyIooZC8H5q8qz6/IEaA
 omX8VhF4acsz4pGg+nicPetNywB4/9tuftsijrLWnlN9Euz47nGqHHW+YWxDioKAlY5w
 4ydZSjztAJuUCqapsQcG7FkH55CyUQZEZFiR4vdiOVNcwcp23AXgewbiZ6UTHMvjssfj
 Z5aYuQcsZj/G/mdVvQ752d2rZL2EPAwRDSJNo1tSeM6n2W2mO3pWDSRy+seGV4pcB+Co
 pxew==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772123631; x=1772728431; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BJVX9inQjvP7mLOetWSznqPp5QP+PzSMRIxGl2hnmuY=;
 b=loXZpSpRFgsVpTLfN1QW6PNL1AyGzB7ZvBCfU8K9uPBHp7emsUA6N9mdjn5Qp8qoWW
 4cjn0AYOemx0daxkdWulUnaNgH9k5LQme4eq1hFQ8gEtuRx6Vc3blSbiHcPpEZp8+WWx
 cucVtn0sIPxyUT+TNxn2mQbCzo91MhKeZuL64Kl8NnRispw9OcsROwgBpQcMMGGUUd5c
 riNQJObToIlT+Kslm7XEy7tFarlMmJtiCFdDshTahznHHsgkR2pjOgA3Ke7YXeK6sBn2
 0YLJHvwStmKD1YlN8jccpG9IQgmIhB4EI0FbZ9386r4jbpw6rswHzz+3FahHDxjdr16I
 C7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772123631; x=1772728431;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BJVX9inQjvP7mLOetWSznqPp5QP+PzSMRIxGl2hnmuY=;
 b=ODFZH+RuLih1M73rNyBURGr8732b7cb5mpSNOjBBsghwhZtfMiFWboc6C+EqUk5Nkx
 KNr3pJWtMjbUTN3luAbdDHpH4epi02m6D4xoZLmxB1ZkS+mdETPQXFGp7xkZbr8B0bwd
 FLfjVd5ReC+gVO+G8Bgu8eXYco7r9B/jAqb/UzHtxCUwFAih8ceFNfjyQknsseCXUG2K
 InQuUsFOq/oIHRJJIxhL0OYQ38olSlhsTXHaT9J9f82l0Le/tcMT3qOa53e35i+1vtCg
 e5U8AHZdqk5As+JX7XcqQv7F3/i0upixyrST7Z+9AvAP5K6nUKYomBUD0MTDpzsIyQz1
 Vc6A==
X-Gm-Message-State: AOJu0YysZi9F/a3sMDPPvkI7CrsktBgBnEHjalSFDDOaBSZgPxve49Vm
 Q44VZEv+UqbqE1anSAMGJeq73/zejsY/d9S39t+o7jmZuFKAf7PVLCXrXWA5krjomci3IPwu0uj
 2PUJDw74qwLYngf4nhOwxzKvYMg+/ufnWVAfyRsVaVoCCwBeguGN3ClJA39Nqt5064tGVgjQpw4
 PZYWALzMdnsYsV2dTlQ/5OvcgamT44f5k=
X-Gm-Gg: ATEYQzzuGGR59kZ2w5VesQly6dOFmGpLUb6P6024AEefytZlJUhXoDStfcMByZR7w/w
 CCOq+VyBgFS4iKD7bxQtC6rA7rZbwftfrFA8bLnsjva5sz5wZX5146FUd7xmbjy7sOqRMYmV3I3
 qNQhiFNvqyCgWvUjFWGinfrKr4pQlE2P3jhVnjBFaTLD5ekNUvExSi4LQ6KoUSGVHBH5BXE0p8h
 r9hd6k/8fjvkzy3aZuN006AphKpCjvcxTOGMw==
X-Received: by 2002:a05:690e:12c6:b0:64c:9bc9:307f with SMTP id
 956f58d0204a3-64cb24d5e56mr3853410d50.42.1772123630591; 
 Thu, 26 Feb 2026 08:33:50 -0800 (PST)
X-Received: by 2002:a05:690e:12c6:b0:64c:9bc9:307f with SMTP id
 956f58d0204a3-64cb24d5e56mr3853378d50.42.1772123629894; Thu, 26 Feb 2026
 08:33:49 -0800 (PST)
MIME-Version: 1.0
References: <20260225210415.972192-1-jsnow@redhat.com>
 <20260225210415.972192-3-jsnow@redhat.com>
 <e1f90992-2336-45b3-bd90-ea7a242ce16f@redhat.com>
In-Reply-To: <e1f90992-2336-45b3-bd90-ea7a242ce16f@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 26 Feb 2026 11:33:38 -0500
X-Gm-Features: AaiRm53Z_JwwpoN1MOuqRM4EuwGOrC7pdzUhOfuaPSRUQVZq2SL7avGTcSG5YlU
Message-ID: <CAFn=p-b5G0C4-P0nHUZ00t5x5-QUCJYMK7j2KfduSxcuQ6MaDA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] python: replace avocado tests with pytest
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000759ea9064bbcaff1"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000759ea9064bbcaff1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026, 3:32=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrote:

> On 25/02/2026 22.04, John Snow wrote:
> > Following suit with the rest of this repository, drop avocado and
> > replace it with the Python standard "pytest" package.
> >
> > In this case, we do not truly need pytest as all we are using it for is
> > running other python processes formerly launched by shell scripts, but
> > this matches how the standalone python-qemu-qmp package does things,
> > which keeps things simple on my end.
> >
> > (pytest version chosen based off of Debian 11's package version as
> queried by
> > repology; under the assumption that this is the likely the oldest
> > version we currently leverage in testing.)
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >   python/Makefile          |  4 +-
> >   python/setup.cfg         |  1 +
> >   python/tests/linters.py  | 89 +++++++++++++++++++++++++++++++++++++++=
+
> >   python/tests/minreqs.txt |  1 +
> >   4 files changed, 93 insertions(+), 2 deletions(-)
> >   create mode 100644 python/tests/linters.py
> >
> > diff --git a/python/Makefile b/python/Makefile
> > index b6c9cd1bce2..42994d39618 100644
> > --- a/python/Makefile
> > +++ b/python/Makefile
> > @@ -105,7 +105,7 @@ develop:
> >
> >   .PHONY: check
> >   check:
> > -     @avocado --config avocado.cfg run tests/
> > +     @pytest -v tests/*.py
> >
> >   .PHONY: check-tox
> >   check-tox:
> > @@ -113,7 +113,7 @@ check-tox:
> >
> >   .PHONY: check-coverage
> >   check-coverage:
> > -     @coverage run -m avocado --config avocado.cfg run tests/*.py
> > +     @coverage run -m pytest -v tests/*.py
> >       @coverage combine
> >       @coverage html
> >       @coverage report
> > diff --git a/python/setup.cfg b/python/setup.cfg
> > index c46a95f8d41..03344526730 100644
> > --- a/python/setup.cfg
> > +++ b/python/setup.cfg
> > @@ -43,6 +43,7 @@ devel =3D
> >       mypy >=3D 1.4.0
> >       pylint >=3D 2.17.3
> >       pylint !=3D 3.2.4; python_version<"3.9"
> > +    pytest >=3D 6.0.2
> >       tox >=3D 3.18.0
> >       sphinx >=3D 3.4.3
> >
> > diff --git a/python/tests/linters.py b/python/tests/linters.py
> > new file mode 100644
> > index 00000000000..28556c09910
> > --- /dev/null
> > +++ b/python/tests/linters.py
> > @@ -0,0 +1,89 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +import os
> > +import subprocess
> > +import sys
> > +
> > +
> > +def pyrun(*args):
> > +    subprocess.run((sys.executable, *args), check=3DTrue)
> > +
> > +
> > +class TestLinters:
> > +
> > +    def test_flake8_pkg(self):
> > +        pyrun("-m", "flake8", "qemu/")
> > +
> > +    def test_flake8_scripts(self):
> > +        pyrun("-m", "flake8", "scripts/")
> > +
> > +    def test_flake8_qapi(self):
> > +        pyrun("-m", "flake8",
> > +              "../scripts/qapi/",
> > +              "../docs/sphinx/qapidoc.py",
> > +              "../docs/sphinx/qapi_domain.py")
> > +
> > +    def test_isort_pkg(self):
> > +        pyrun("-m", "isort", "-c", "qemu/")
> > +
> > +    def test_isort_scripts(self):
> > +        pyrun("-m", "isort", "-c", "scripts/")
> > +
> > +    def test_isort_qapi(self):
> > +        pyrun("-m", "isort", "--sp", ".", "-c", "../scripts/qapi/")
> > +
> > +    def test_isort_qapi_sphinx(self):
> > +        # Force isort to recognize 'compat' as a local module and not
> > +        # third-party
> > +        pyrun("-m", "isort", "--sp", ".", "-c", "-p", "compat",
> > +              "../docs/sphinx/qapi_domain.py",
> > +              "../docs/sphinx/qapidoc.py")
> > +
> > +    def test_mypy_pkg(self):
> > +        pyrun("-m", "mypy", "-p", "qemu")
> > +
> > +    def test_mypy_scripts(self):
> > +        pyrun("-m", "mypy", "scripts/")
> > +
> > +    def test_mypy_qapi(self):
> > +        pyrun("-m", "mypy", "../scripts/qapi")
> > +
> > +    def test_mypy_iotests(self):
> > +        cwd =3D os.getcwd()
> > +        try:
> > +            os.chdir("../tests/qemu-iotests/")
> > +            pyrun("-m", "linters", "--mypy")
> > +        finally:
> > +            os.chdir(cwd)
>
> Not my area of expertise, but as far as I know, the iotest linters are
> already run during "make check-block", see tests/qemu-iotests/297 ... so
> aren't we checking those iotests now twice? ... so maybe best leave the
> iotests out of this script?
>

297 is skipped if the deps aren't there, this is a guaranteed run.

Plan is (someday, eventually) to drop 297 and leave it to the Python check.



>
> > +    # Setuptools v60 introduced the SETUPTOOLS_USE_DISTUTILS=3Dstdlib
> > +    # workaround; stdlib distutils was fully removed in Python
> > +    # 3.12+. Once we are on >=3D3.12+ exclusively, this workaround can=
 be
> > +    # dropped safely. Until then, it is needed for some versions on
> > +    # Fedora/Debian distributions which relied upon distro-patched
> > +    # setuptools present in CPython, but not within setuptools itself.
> > +
> > +    def test_pylint_pkg(self):
> > +        os.environ['SETUPTOOLS_USE_DISTUTILS'] =3D 'stdlib'
> > +        pyrun("-m", "pylint", "qemu/")
> > +
> > +    def test_pylint_scripts(self):
> > +        os.environ['SETUPTOOLS_USE_DISTUTILS'] =3D 'stdlib'
> > +        pyrun("-m", "pylint", "qemu/")
>
> That should be "scripts/" instead of "qemu/", shouldn't it?
>

...Oops! Sorry...


> > +    def test_pylint_qapi(self):
> > +        os.environ['SETUPTOOLS_USE_DISTUTILS'] =3D 'stdlib'
> > +        pyrun("-m", "pylint",
> > +              "--rcfile=3D../scripts/qapi/pylintrc",
> > +              "../scripts/qapi/",
> > +              "../docs/sphinx/qapidoc.py",
> > +              "../docs/sphinx/qapi_domain.py")
> > +
> > +    def test_pylint_iotests(self):
> > +        os.environ['SETUPTOOLS_USE_DISTUTILS'] =3D 'stdlib'
> > +        cwd =3D os.getcwd()
> > +        try:
> > +            os.chdir("../tests/qemu-iotests/")
> > +            pyrun("-m", "linters", "--pylint")
> > +        finally:
> > +            os.chdir(cwd)
>
> Same question here about the iotests as above.
>
>   Thomas
>
>

--000000000000759ea9064bbcaff1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 26, 2026, 3:32=E2=80=
=AFAM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 25/02/2026 22.04,=
 John Snow wrote:<br>
&gt; Following suit with the rest of this repository, drop avocado and<br>
&gt; replace it with the Python standard &quot;pytest&quot; package.<br>
&gt; <br>
&gt; In this case, we do not truly need pytest as all we are using it for i=
s<br>
&gt; running other python processes formerly launched by shell scripts, but=
<br>
&gt; this matches how the standalone python-qemu-qmp package does things,<b=
r>
&gt; which keeps things simple on my end.<br>
&gt; <br>
&gt; (pytest version chosen based off of Debian 11&#39;s package version as=
 queried by<br>
&gt; repology; under the assumption that this is the likely the oldest<br>
&gt; version we currently leverage in testing.)<br>
&gt; <br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0python/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
4 +-<br>
&gt;=C2=A0 =C2=A0python/setup.cfg=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
1 +<br>
&gt;=C2=A0 =C2=A0python/tests/linters.py=C2=A0 | 89 +++++++++++++++++++++++=
+++++++++++++++++<br>
&gt;=C2=A0 =C2=A0python/tests/minreqs.txt |=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A04 files changed, 93 insertions(+), 2 deletions(-)<br>
&gt;=C2=A0 =C2=A0create mode 100644 python/tests/linters.py<br>
&gt; <br>
&gt; diff --git a/python/Makefile b/python/Makefile<br>
&gt; index b6c9cd1bce2..42994d39618 100644<br>
&gt; --- a/python/Makefile<br>
&gt; +++ b/python/Makefile<br>
&gt; @@ -105,7 +105,7 @@ develop:<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0.PHONY: check<br>
&gt;=C2=A0 =C2=A0check:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0@avocado --config avocado.cfg run tests/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0@pytest -v tests/*.py<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0.PHONY: check-tox<br>
&gt;=C2=A0 =C2=A0check-tox:<br>
&gt; @@ -113,7 +113,7 @@ check-tox:<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0.PHONY: check-coverage<br>
&gt;=C2=A0 =C2=A0check-coverage:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0@coverage run -m avocado --config avocado.cfg run=
 tests/*.py<br>
&gt; +=C2=A0 =C2=A0 =C2=A0@coverage run -m pytest -v tests/*.py<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0@coverage combine<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0@coverage html<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0@coverage report<br>
&gt; diff --git a/python/setup.cfg b/python/setup.cfg<br>
&gt; index c46a95f8d41..03344526730 100644<br>
&gt; --- a/python/setup.cfg<br>
&gt; +++ b/python/setup.cfg<br>
&gt; @@ -43,6 +43,7 @@ devel =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0mypy &gt;=3D 1.4.0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pylint &gt;=3D 2.17.3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pylint !=3D 3.2.4; python_version&lt;&quot;3=
.9&quot;<br>
&gt; +=C2=A0 =C2=A0 pytest &gt;=3D 6.0.2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tox &gt;=3D 3.18.0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sphinx &gt;=3D 3.4.3<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/python/tests/linters.py b/python/tests/linters.py<br>
&gt; new file mode 100644<br>
&gt; index 00000000000..28556c09910<br>
&gt; --- /dev/null<br>
&gt; +++ b/python/tests/linters.py<br>
&gt; @@ -0,0 +1,89 @@<br>
&gt; +# SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; +<br>
&gt; +import os<br>
&gt; +import subprocess<br>
&gt; +import sys<br>
&gt; +<br>
&gt; +<br>
&gt; +def pyrun(*args):<br>
&gt; +=C2=A0 =C2=A0 subprocess.run((sys.executable, *args), check=3DTrue)<b=
r>
&gt; +<br>
&gt; +<br>
&gt; +class TestLinters:<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def test_flake8_pkg(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pyrun(&quot;-m&quot;, &quot;flake8&quot;,=
 &quot;qemu/&quot;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def test_flake8_scripts(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pyrun(&quot;-m&quot;, &quot;flake8&quot;,=
 &quot;scripts/&quot;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def test_flake8_qapi(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pyrun(&quot;-m&quot;, &quot;flake8&quot;,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;../scripts/qap=
i/&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;../docs/sphinx=
/qapidoc.py&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;../docs/sphinx=
/qapi_domain.py&quot;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def test_isort_pkg(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pyrun(&quot;-m&quot;, &quot;isort&quot;, =
&quot;-c&quot;, &quot;qemu/&quot;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def test_isort_scripts(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pyrun(&quot;-m&quot;, &quot;isort&quot;, =
&quot;-c&quot;, &quot;scripts/&quot;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def test_isort_qapi(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pyrun(&quot;-m&quot;, &quot;isort&quot;, =
&quot;--sp&quot;, &quot;.&quot;, &quot;-c&quot;, &quot;../scripts/qapi/&quo=
t;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def test_isort_qapi_sphinx(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Force isort to recognize &#39;compat&#3=
9; as a local module and not<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # third-party<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pyrun(&quot;-m&quot;, &quot;isort&quot;, =
&quot;--sp&quot;, &quot;.&quot;, &quot;-c&quot;, &quot;-p&quot;, &quot;comp=
at&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;../docs/sphinx=
/qapi_domain.py&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;../docs/sphinx=
/qapidoc.py&quot;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def test_mypy_pkg(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pyrun(&quot;-m&quot;, &quot;mypy&quot;, &=
quot;-p&quot;, &quot;qemu&quot;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def test_mypy_scripts(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pyrun(&quot;-m&quot;, &quot;mypy&quot;, &=
quot;scripts/&quot;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def test_mypy_qapi(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pyrun(&quot;-m&quot;, &quot;mypy&quot;, &=
quot;../scripts/qapi&quot;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def test_mypy_iotests(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cwd =3D os.getcwd()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.chdir(&quot;../tests/qem=
u-iotests/&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pyrun(&quot;-m&quot;, &quot=
;linters&quot;, &quot;--mypy&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 finally:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.chdir(cwd)<br>
<br>
Not my area of expertise, but as far as I know, the iotest linters are <br>
already run during &quot;make check-block&quot;, see tests/qemu-iotests/297=
 ... so <br>
aren&#39;t we checking those iotests now twice? ... so maybe best leave the=
 <br>
iotests out of this script?<br></blockquote></div></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">297 is skipped if the deps aren&#39;t there, thi=
s is a guaranteed run.</div><div dir=3D"auto"><br></div><div dir=3D"auto">P=
lan is (someday, eventually) to drop 297 and leave it to the Python check.<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"au=
to"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">
<br>
<br>
&gt; +=C2=A0 =C2=A0 # Setuptools v60 introduced the SETUPTOOLS_USE_DISTUTIL=
S=3Dstdlib<br>
&gt; +=C2=A0 =C2=A0 # workaround; stdlib distutils was fully removed in Pyt=
hon<br>
&gt; +=C2=A0 =C2=A0 # 3.12+. Once we are on &gt;=3D3.12+ exclusively, this =
workaround can be<br>
&gt; +=C2=A0 =C2=A0 # dropped safely. Until then, it is needed for some ver=
sions on<br>
&gt; +=C2=A0 =C2=A0 # Fedora/Debian distributions which relied upon distro-=
patched<br>
&gt; +=C2=A0 =C2=A0 # setuptools present in CPython, but not within setupto=
ols itself.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def test_pylint_pkg(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.environ[&#39;SETUPTOOLS_USE_DISTUTILS&=
#39;] =3D &#39;stdlib&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pyrun(&quot;-m&quot;, &quot;pylint&quot;,=
 &quot;qemu/&quot;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def test_pylint_scripts(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.environ[&#39;SETUPTOOLS_USE_DISTUTILS&=
#39;] =3D &#39;stdlib&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pyrun(&quot;-m&quot;, &quot;pylint&quot;,=
 &quot;qemu/&quot;)<br>
<br>
That should be &quot;scripts/&quot; instead of &quot;qemu/&quot;, shouldn&#=
39;t it?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">...Oops! Sorry...</div><div dir=3D"auto"><br></div><div dir=3D"au=
to"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">
<br>
&gt; +=C2=A0 =C2=A0 def test_pylint_qapi(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.environ[&#39;SETUPTOOLS_USE_DISTUTILS&=
#39;] =3D &#39;stdlib&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pyrun(&quot;-m&quot;, &quot;pylint&quot;,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;--rcfile=3D../=
scripts/qapi/pylintrc&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;../scripts/qap=
i/&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;../docs/sphinx=
/qapidoc.py&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;../docs/sphinx=
/qapi_domain.py&quot;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def test_pylint_iotests(self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.environ[&#39;SETUPTOOLS_USE_DISTUTILS&=
#39;] =3D &#39;stdlib&#39;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cwd =3D os.getcwd()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.chdir(&quot;../tests/qem=
u-iotests/&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pyrun(&quot;-m&quot;, &quot=
;linters&quot;, &quot;--pylint&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 finally:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.chdir(cwd)<br>
<br>
Same question here about the iotests as above.<br>
<br>
=C2=A0 Thomas<br>
<br>
</blockquote></div></div></div>

--000000000000759ea9064bbcaff1--


