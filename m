Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1C3FD8FE8
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 17:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvfWw-0007cp-UF; Thu, 26 Feb 2026 12:52:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vvfWt-0007ca-RG
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 12:52:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vvfWr-0008TJ-V7
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 12:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772128320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aGb/lmGGa6pt6DoY2qzEC/Nr+2ZST4xwaLwBFAnBcyk=;
 b=J6HoQGskGrksbtbXhiDh/B4mxZU4D43bv1gz7gZBdL7Oy2DFFuDvnmV8PFahntSzGte6Ym
 J8vQPHxAyE7OdKzAoaJNBwV0HxG9U/ye+C/q+pleXkCIBpmksanabcIAlIJBP2nczzt+Sn
 s+mvSOaEy+pnION1zJ7FlSrYyclksU0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-8ernzKuVOrSYrbzN0i2Ikw-1; Thu, 26 Feb 2026 12:51:58 -0500
X-MC-Unique: 8ernzKuVOrSYrbzN0i2Ikw-1
X-Mimecast-MFC-AGG-ID: 8ernzKuVOrSYrbzN0i2Ikw_1772128318
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-79868eae64fso24268817b3.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 09:51:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772128318; cv=none;
 d=google.com; s=arc-20240605;
 b=A1CJ7srgekUEz/2PvsF3nrKCe3Lb+BQKJyiQxGe4giYp/NRTo7QonWZ25DTIm1ORzt
 VzZsArG7mIA2SyAAuPmbgjpwSzuQCaB08z8jeiwEJ6T3yvaDZ6tvfYQ/8t2ovBzfWZEZ
 nmOYXsUi30mcShPX0xdsu+SWVn5it8IBFssZkfByHAnF+C/siXp02XGAFBChHbh+xDi8
 OkaaBt40hdS2u9L2GZON+x4nlKlcGHaPBszSaXkFsW9KnL5qv6tmapBjuRv8/olnWBvg
 sbfNOa2vG6Il0q618Y97t4EpdRbYXgOqyJpNAncKY9lcCVYSvK9URtczOwbsNJSjACkO
 J82g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aGb/lmGGa6pt6DoY2qzEC/Nr+2ZST4xwaLwBFAnBcyk=;
 fh=XzBuknDOpMWBbu+VXGIDfqUZ/ryxq1MzEkPeMMiXjDQ=;
 b=TKepPMLJEu/yzH91zwq5evlIffK3JIiacOxYtHSWbrPxi9tFvkLRX8M0wvngcsM3Ej
 X7opLZlJGeKd+6HGv/vaqS9PqNS0N2XTm/D6uYld7dhC6MqA4rgBXOBgKLagmQwrj8Nu
 vaIkomSDWOH3qHadPctWH0gTJs1rRopFtmih3tzbTr0PPm/5icSAlJeWXCka6d++Afxh
 KjbDK4aXT54j9ZAHv/XpRFcD/b5aLiCvs3WnVFw3G4U718vRMbYgHSZQX1jt/ArdIHj6
 GHow9U3Pzne2BVuzx62GrKDgxr2Vlxrqg3werGxoBLUFNwttHidvR35m3GX3fkHObWra
 d4iA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772128318; x=1772733118; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aGb/lmGGa6pt6DoY2qzEC/Nr+2ZST4xwaLwBFAnBcyk=;
 b=VdwXmh+8noKK+TVUpCNc8/o+8g+CQ8v4O8ldquANCCdD0cjf8XNsyOJ8zmSVPldxAi
 Fkpgk+1ompcB/Vcsqo+T2CRb7yEJufHwSF1rJ+7F5la6Cytz/qDOL4QPWWlwAYef6okP
 l5LcR/Uqx/+nwIy3hXUnNyWm1uzNr/tFxJW1RFe5J70xfKSwqubY/rwzN1ctAJ+Off78
 gSnX3KTyujXk9g7TXhacYVcReaXLZQJRKs1tCQXpvkFTqR3TT2dO2ifTA5/3f5zqJtcA
 3XwzRLZMuygioh8hoNCifInh2QCkDyl90OR0bzkRr6O3qut2U/BgYwq41bhx4oldn95l
 aSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772128318; x=1772733118;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aGb/lmGGa6pt6DoY2qzEC/Nr+2ZST4xwaLwBFAnBcyk=;
 b=K4OAeXqaFqPqKlKjreH13Z6Fbi+BVQnJyTZbFL3vxZ/WLglBv8d/zRxJJP0X3UOX8f
 c2IAVEcoXwPj3REnjKTU1u1JQNfhNNJSMoRD3KM3vNTNjb2smF8UIqQpeZ4C7RFQ9RVC
 iklfNbrSsJVVt2gGWaU9mQeC0DeVPaxc/APCWTILKrI9XO6zwPwCKvdE3bFy2MXKi1dt
 Sw7HWG+K5MWFGHFB3zEnHjxzsxpNtOBuJg+fh57IgH4cIdadoQbWb6TC6W6j0LkiNLlP
 ocXIqWDNZWYWIJYWOfwDx38BVrEbkQMp6NHQUZWsMP1Delrz1wOchCB+j5VleuHyvMiN
 xg+Q==
X-Gm-Message-State: AOJu0YzEHbnx1ko/7Gt+PSr4UxYmgRcZein54VYl0eW9SSc3osuIFe+1
 bBHhP8q34Ry/IZ8yE2qMZrXgh5/tkbnaQ1p1YvHcxy0QAvmmCrLbC/uKK3copwWi1Bz5b440p9n
 10uDQTib1RuwtUh4XRPmvy6f/ixegpLY3Qu/S267Psm8Dp7F92IJ0dv4xBtNc+a6rrFuxAEZnGo
 iyeFygv3sDtCkiA1E6Sml8V3zrg+z9fJ0=
X-Gm-Gg: ATEYQzzyIqF69yQppzWXBHZjeTCn1jrc2JkwqwmM+M3o2pWnmHYz7a9CXa2kc4o/w3E
 h5sMfZyXJftfnduFW1IIKlny5rN06qfTf70eY51wAftatTFp8tnb2cjyy+TyxusMRRwfs/lkveo
 PlITII3qh6ROCnJgMxXNRvt5iU6AackMSMnsmumoPPLrIWF/PjuYhSiJ3L2f8J8LTCfYWr8eA5/
 to8ldaI8OGsP3DXc0jlUh/2N0Szxqv1oZJxjQ==
X-Received: by 2002:a05:690e:2552:b0:649:af6b:7427 with SMTP id
 956f58d0204a3-64cc237d23dmr74336d50.78.1772128318219; 
 Thu, 26 Feb 2026 09:51:58 -0800 (PST)
X-Received: by 2002:a05:690e:2552:b0:649:af6b:7427 with SMTP id
 956f58d0204a3-64cc237d23dmr74324d50.78.1772128317753; Thu, 26 Feb 2026
 09:51:57 -0800 (PST)
MIME-Version: 1.0
References: <20260225192808.957477-1-jsnow@redhat.com>
 <20260225192808.957477-3-jsnow@redhat.com>
 <aaBYBfryWrYRMT2G@redhat.com>
In-Reply-To: <aaBYBfryWrYRMT2G@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 26 Feb 2026 12:51:46 -0500
X-Gm-Features: AaiRm51qyK3mi7205kzmt1vHuVpOzr21SjD3NzF7R_R01_AN_F81qy7L-ANZ2Jg
Message-ID: <CAFn=p-YsiOiBy0VRdbXS0=PFtWkj_OzaMz+QPeku294=17mHXg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] python: replace avocado tests with pytest
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Feb 26, 2026 at 9:26=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Wed, Feb 25, 2026 at 02:28:06PM -0500, John Snow wrote:
> > Following suit with the rest of this repository, drop avocado and
> > replace it with the Python standard "pytest" package.
> >
> > In this case, we do not truly need pytest as all we are using it for is
> > running other python processes formerly launched by shell scripts, but
> > this matches how the standalone python-qemu-qmp package does things,
> > which keeps things simple on my end.
>
> From the POV of QEMU we don't really want 'pytest' in the loop
> any more than we want avocado. The desire is for "meson" to be
> the test harness.
>
> If this use of a pytest is just a temporary stepping stone
> towards fully integrating with meson, then that's acceptable
> but lets note that this is a temporary solution in the commit
> message.

Admittedly I wasn't thinking about just using meson directly, so I
suppose this *is* just a stepping stone. My only question for meson
integration is how can I set up the deps so that "make check" will try
to install the linting deps and run the python tests, but skips these
tests if we are offline and don't have the deps. i.e. "try to run
these tests, but don't error out if we can't"

Hazarding a guess: make the python tests depend on a linter group, add
a custom target for that linter group, allow failure in that custom
target (how?), then configure the individual meson test cases to skip
if the deps are not present.

(Guess I'll go look at your older series and see how you handled this...)

>
> >
> > (pytest version chosen based off of Debian 11's package version as quer=
ied by
> > repology; under the assumption that this is the likely the oldest
> > version we currently leverage in testing.)
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  python/Makefile          |  4 +-
> >  python/setup.cfg         |  1 +
> >  python/tests/linters.py  | 89 ++++++++++++++++++++++++++++++++++++++++
> >  python/tests/minreqs.txt |  1 +
> >  4 files changed, 93 insertions(+), 2 deletions(-)
> >  create mode 100644 python/tests/linters.py
> >
> > diff --git a/python/Makefile b/python/Makefile
> > index b6c9cd1bce2..42994d39618 100644
> > --- a/python/Makefile
> > +++ b/python/Makefile
> > @@ -105,7 +105,7 @@ develop:
> >
> >  .PHONY: check
> >  check:
> > -     @avocado --config avocado.cfg run tests/
> > +     @pytest -v tests/*.py
> >
> >  .PHONY: check-tox
> >  check-tox:
> > @@ -113,7 +113,7 @@ check-tox:
> >
> >  .PHONY: check-coverage
> >  check-coverage:
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
> >      mypy >=3D 1.4.0
> >      pylint >=3D 2.17.3
> >      pylint !=3D 3.2.4; python_version<"3.9"
> > +    pytest >=3D 6.0.2
> >      tox >=3D 3.18.0
> >      sphinx >=3D 3.4.3
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
>
> from subprocess import check_call

oooh.

>
> > +import sys
> > +
> > +
> > +def pyrun(*args):
> > +    subprocess.run((sys.executable, *args), check=3DTrue)
>
> Not sure this is worth the trouble compared to doing...
>
>
> > +
> > +
> > +class TestLinters:
> > +
> > +    def test_flake8_pkg(self):
> > +        pyrun("-m", "flake8", "qemu/")
>
> ...this inline:
>
>     check_call([sys.executable, "-m", "flake8", "qemu/"])
>
>
> > +    def test_mypy_iotests(self):
> > +        cwd =3D os.getcwd()
> > +        try:
> > +            os.chdir("../tests/qemu-iotests/")
> > +            pyrun("-m", "linters", "--mypy")
> > +        finally:
> > +            os.chdir(cwd)
>
> This dance could be replaced with
>
>     check_call([sys.executable, "-m", "linters", "--mpypy"],
>                cwd=3D"../tests/qemu-iotests/")

Learning new things every day.

>
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


