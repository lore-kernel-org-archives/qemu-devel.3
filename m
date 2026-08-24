Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172DFC5DF9B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyUcb-0005c4-N4; Mon, 24 Aug 2026 09:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyUcZ-0005bn-Pl
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:21:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyUcW-0000C4-5m
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787577706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SON+iv8/G3HwUilchkR9LKHL3XAuI8BxUwwk/uyPrVA=;
 b=LXNufAr8EewVArkyjHsZASOfnGeUC1pTvkNRHDjtVppETigpyeAVj3POV0kUZebsOGeGrV
 d4ORHQH/Rm/9hVnazof1H/fLsVdA6T8aonsuyIpyMtVWyV5WMS7VbltIn++Id/DXMMYTnL
 XcaY+IbmJnW0U3i5QWOSaPmjaP4OMJQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-pu2PsWT5PRudMLQe-GLQ9g-1; Mon, 24 Aug 2026 09:21:44 -0400
X-MC-Unique: pu2PsWT5PRudMLQe-GLQ9g-1
X-Mimecast-MFC-AGG-ID: pu2PsWT5PRudMLQe-GLQ9g_1787577704
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-820111eb28aso64966147b3.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 06:21:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787577704; cv=none;
 d=google.com; s=arc-20260327;
 b=ePEE2VzNEeE9IUORspZag/pqBw656zpYZSY3uf/SY0saHaSG9wUAzA6erMJx/FyQxI
 564WUdVNNf+eF2wjmeIW5WutNIv+aVO8MLky9OImhZPB2oKUb+uNBrgdsfHv+CJhpJzT
 rccdEySB4vzpr05X6TgK+OnBf5kryqgQAEnHAuhyIFVp06CyJI0A216fRVx/izvr42Y/
 ALY+W93qSeSzzk2QZNtnVo8tJm9fjiKgdCjsq4yaiqZ3mxLBCYlmYG0snaN5vwkZaJ/I
 VBC4rRspaB1MMYzb4FGQ0Mdg/INA/HFIc04taod1h6oIdEvT2L+idUwD+cqGAUvWCjyj
 lGqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SON+iv8/G3HwUilchkR9LKHL3XAuI8BxUwwk/uyPrVA=;
 fh=+CST0TXx71lD21Rer44p5WlsCPmiM151TXzxSuT4aVY=;
 b=W6MQ7D+e+6tFt/SIgwdQLG9IUjlvqfpoOWepDIFgFuswtPZLpCeq8ikFZ2cRH0Qzjq
 N5onnRhhO5Gu0rj/amPWFOsBhuM/2omZ9rBxeF5EZGf7oNLyTzTa3xW/ApK01Wlg7r6+
 Xm8WfHJGlhWDCOZO745lOj6MzY9LfNxnkH5oDg3m99+B8gmVI5wAumcz5P9jlGIyJCMy
 Y1mtSWfngXfq7gE9vQsDUqRW/JquIeafM0M0MD77mivl4iIzcWdVvgETWUYBw8cfkz4/
 A8vX136chvI0QiaGYBySgevw5cUR4u9i8RyQwAWgVvcRE0FbF1BDot8z0kcxqLCg6yng
 Yq5g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787577704; x=1788182504; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SON+iv8/G3HwUilchkR9LKHL3XAuI8BxUwwk/uyPrVA=;
 b=bv0uKFmraDxIuiJ80diCf/VRnTQIGskBQawD5xf0sAVQ5dtpOOcFrLrQq4OvgIxeYx
 SJE0V8JfKdXBoT8Udhg64WY7v/YI7ktpOL1UfICcCy3OvrV9AJoNijxz5HisrPET8qsI
 8ntnuCtDe1Zq6i4VYEgSuDXGYeRIgFjMIAAvTF4VlT4OIKD9evw0CBNrUDEYHus2H/7+
 MknJWritq8LtS6VtqJAA1Fep/7ce6HlwZJTqbgBZUH6lXYMFIzV7cgUzStGLMG02bKnt
 2ykuzN/7MRUyoCV71a8t6AqO17vtwSWbXzT+FiRbHmtbiaSMZydDbbOGkaC7zRS+6hBh
 YOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787577704; x=1788182504;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SON+iv8/G3HwUilchkR9LKHL3XAuI8BxUwwk/uyPrVA=;
 b=T+DRiCAAE7jnjz9DIE9S00dgRZ2rHZ+dmVLgdmwM4gdurGGxITxfz9Uxnga6vxNBdP
 AUBqdJUdtGp2VeN5JdAva9EbidqOV8gfKIHQCn2F49ExJlpZ2CN/j0XdF/AGwCbuJbjS
 43u2kGpdgwg79eIVWbEkTBU/a7Rr75zHCpxmSMh3GFZHCr5BOm5CAgsoNWY2a/OgW3Y0
 x0+aAcGf0rtcpE9ooWdfYOfZrnzejBGfD6d8Vqahf3L3JVOdVRlB6aG+cGFkTh8mv0vl
 LOlFPhWnnYHaeh5uUK//5BBHIPhiQcjEKZMtJjlA1TxlRWhZ1JA5MHR/xbvpCqQG+EAq
 LGGA==
X-Gm-Message-State: AFuF++kvay64PO0pLuvYscD+2PTCMXzz+52YopF+wGRsk38GkxMRHi5r
 8FPCX/VjCJE9vxe10hZl7QZhQoTvAUh/pxX29vZCA45I5Kp5Pwx0K/4qctPUywF7s4G8pAdvEQ+
 w5fdDOwMMrp5DataOQaD2JNkByLk0OSt9PivF0+8M/39EMzRYokessmi+nqhn1BIgUKNT8eqhPM
 8R1f1HtE0se1V64sTyBnSypo4I9rHdcUA=
X-Gm-Gg: AR+sD12GRaHhTL/9Qh4SuLKiaVCj9SvaMVRM0C713sMXCJOh643IBJYVNI57eH4TaoR
 a4FWNA3KKJkJYYckdKGjCGqt3qqm0JmSE9P0PJNXH3f62f0VOUOFSTuaTxNNvRhgy/mFCvKT/Iy
 48spIKoydGupZIQAiTDFXJZNjr7sBKTfw529k40u353zmtkgHSYyueAtFPno58JCKY1MjsFEGdw
 I/fOqlTPfrR1iXs
X-Received: by 2002:a05:690e:bc7:b0:66d:506:ff4c with SMTP id
 956f58d0204a3-66d0507016emr2363161d50.11.1787577704260; 
 Mon, 24 Aug 2026 06:21:44 -0700 (PDT)
X-Received: by 2002:a05:690e:bc7:b0:66d:506:ff4c with SMTP id
 956f58d0204a3-66d0507016emr2363126d50.11.1787577703593; Mon, 24 Aug 2026
 06:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260824052859.880475-1-jsnow@redhat.com>
 <20260824052859.880475-11-jsnow@redhat.com>
 <aoxEPn9w_DZBwVMY@redhat.com>
In-Reply-To: <aoxEPn9w_DZBwVMY@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 24 Aug 2026 09:21:31 -0400
X-Gm-Features: AcwNN1VGxOqJq_GbrrdtO4w3NbFXprhKVXcFOm2_Xm1EGfXbg1CsO7Kl5n765yk
Message-ID: <CAFn=p-at3o4cRe0uD47M8_xNaasCLkN0KHCyWySCZ30nwMm4XQ@mail.gmail.com>
Subject: Re: [PATCH 10/12] sphinx: require sphinx 7.2.6
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Cleber Rosa <crosa@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: multipart/alternative; boundary="0000000000000822d30659cade33"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

--0000000000000822d30659cade33
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026, 9:16=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@red=
hat.com>
wrote:

> On Mon, Aug 24, 2026 at 01:28:56AM -0400, John Snow wrote:
> > Make the extraordinary leap from Sphinx 3.4.3 to Sphinx
> > 7.2.6. Simplifications and cleanup will follow in subsequent patches.
>
> Does this have any implications on what platforms we build docs
> on ? If so, mention any notable impacted platforms in the commit
> message.
>

Technically not, since Paolo already dropped 3.9 from the CentOS container.

But, yes, CentOS9 will require sourcing Sphinx from PyPI and I'll update
the python upgrade commit to mention this.

This commit itself doesn't actually restrict any of our supported
platforms, see the cover letter version chart.


> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/conf.py             |  4 ++--
> >  python/setup.cfg         |  2 +-
> >  python/tests/minreqs.txt | 29 ++++++++++++++++-------------
> >  pythondeps.toml          |  4 ++--
> >  4 files changed, 21 insertions(+), 18 deletions(-)
> >
> > diff --git a/docs/conf.py b/docs/conf.py
> > index 7e35d2158d3..cded047b539 100644
> > --- a/docs/conf.py
> > +++ b/docs/conf.py
> > @@ -51,9 +51,9 @@
> >
> >  # If your documentation needs a minimal Sphinx version, state it here.
> >  #
> > -# 3.4.3 is the oldest version of Sphinx that ships on a platform we
> > +# 7.2.6 is the oldest version of Sphinx that ships on a platform we
> >  # pledge build support for.
> > -needs_sphinx =3D '3.4.3'
> > +needs_sphinx =3D '7.2.6'
> >
> >  # Add any Sphinx extension module names here, as strings. They can be
> >  # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
> > diff --git a/python/setup.cfg b/python/setup.cfg
> > index ebb4230899c..927f72a46f6 100644
> > --- a/python/setup.cfg
> > +++ b/python/setup.cfg
> > @@ -41,7 +41,7 @@ devel =3D
> >      pylint >=3D 2.17.3
> >      pytest >=3D 6.2.4
> >      tox >=3D 3.18.0
> > -    sphinx >=3D 3.4.3
> > +    sphinx >=3D 7.2.6
> >
> >  # Provides qom-fuse functionality
> >  fuse =3D
> > diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
> > index 85cfa08cf76..7154ad40040 100644
> > --- a/python/tests/minreqs.txt
> > +++ b/python/tests/minreqs.txt
> > @@ -12,7 +12,7 @@
> >  # on PyPI that allows the test suite to pass.
> >
> >  # Dependencies for qapidoc/qapi_domain et al
> > -sphinx=3D=3D3.4.3
> > +sphinx=3D=3D7.2.6
> >
> >  # Dependencies for qemu.machine
> >  qemu.qmp=3D=3D0.0.6
> > @@ -48,23 +48,26 @@ platformdirs=3D=3D2.2.0
> >  tomlkit=3D=3D0.10.1
> >
> >  # Transitive sphinx dependencies
> > -Jinja2=3D=3D2.7
> > -MarkupSafe=3D=3D1.1.0
> >  alabaster=3D=3D0.7.1
> > -babel=3D=3D1.3
> > -docutils=3D=3D0.12
> > -imagesize=3D=3D0.5.0
> > -packaging=3D=3D14.0
> > -Pygments=3D=3D2.0
> > -pytz=3D=3D2014.9
> > -requests=3D=3D2.5.0
> > -snowballstemmer=3D=3D1.1
> > +babel=3D=3D2.9
> > +certifi=3D=3D2023.5.7
> > +charset-normalizer=3D=3D2.0.0
> > +docutils=3D=3D0.18.1
> > +idna=3D=3D2.5
> > +imagesize=3D=3D1.3
> > +Jinja2=3D=3D3.0.0
> > +MarkupSafe=3D=3D2.0
> > +packaging=3D=3D21.0
> > +Pygments=3D=3D2.14
> > +requests=3D=3D2.25.0
> > +snowballstemmer=3D=3D2.0
> >  sphinxcontrib-applehelp=3D=3D1.0.0
> >  sphinxcontrib-devhelp=3D=3D1.0.0
> > -sphinxcontrib-htmlhelp=3D=3D1.0.0
> > +sphinxcontrib-htmlhelp=3D=3D2.0.0
> >  sphinxcontrib-jsmath=3D=3D1.0.0
> >  sphinxcontrib-qthelp=3D=3D1.0.0
> > -sphinxcontrib-serializinghtml=3D=3D1.0.0
> > +sphinxcontrib-serializinghtml=3D=3D1.1.9
> > +urllib3=3D=3D1.26
> >
> >  # Transitive pytest dependencies
> >  attrs=3D=3D19.2.0
> > diff --git a/pythondeps.toml b/pythondeps.toml
> > index b1879c1a4da..f0f3af915a1 100644
> > --- a/pythondeps.toml
> > +++ b/pythondeps.toml
> > @@ -28,8 +28,8 @@ meson =3D { accepted =3D ">=3D1.12.0", installed =3D =
"1.12.0",
> canary =3D "meson" }
> >
> >  [docs]
> >  # Please keep the installed versions in sync with docs/requirements.tx=
t
> > -sphinx =3D { accepted =3D ">=3D3.4.3", installed =3D "6.2.1", canary =
=3D
> "sphinx-build" }
> > -sphinx_rtd_theme =3D { accepted =3D ">=3D0.5", installed =3D "1.2.2" }
> > +sphinx =3D { accepted =3D ">=3D7.2.6", installed =3D "7.2.6", canary =
=3D
> "sphinx-build" }
> > +sphinx_rtd_theme =3D { accepted =3D ">=3D1.2.2", installed =3D "1.2.2"=
 }
> >
> >  # This test group is for dependencies required to run various tooling
> >  # and tests that should always be installed at configure time. It shou=
ld
> > --
> > 2.55.0
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

--0000000000000822d30659cade33
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 24, 2026, 9:16=E2=80=
=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">be=
rrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On=
 Mon, Aug 24, 2026 at 01:28:56AM -0400, John Snow wrote:<br>
&gt; Make the extraordinary leap from Sphinx 3.4.3 to Sphinx<br>
&gt; 7.2.6. Simplifications and cleanup will follow in subsequent patches.<=
br>
<br>
Does this have any implications on what platforms we build docs<br>
on ? If so, mention any notable impacted platforms in the commit<br>
message.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Technically not, since Paolo already dropped 3.9 from the CentOS =
container.</div><div dir=3D"auto"><br></div><div dir=3D"auto">But, yes, Cen=
tOS9 will require sourcing Sphinx from PyPI and I&#39;ll update the python =
upgrade commit to mention this.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">This commit itself doesn&#39;t actually restrict any of our suppo=
rted platforms, see the cover letter version chart.</div><div dir=3D"auto">=
<br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container=
"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">
<br>
&gt; <br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/conf.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 4 ++--<br>
&gt;=C2=A0 python/setup.cfg=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<b=
r>
&gt;=C2=A0 python/tests/minreqs.txt | 29 ++++++++++++++++-------------<br>
&gt;=C2=A0 pythondeps.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++--=
<br>
&gt;=C2=A0 4 files changed, 21 insertions(+), 18 deletions(-)<br>
&gt; <br>
&gt; diff --git a/docs/conf.py b/docs/conf.py<br>
&gt; index 7e35d2158d3..cded047b539 100644<br>
&gt; --- a/docs/conf.py<br>
&gt; +++ b/docs/conf.py<br>
&gt; @@ -51,9 +51,9 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # If your documentation needs a minimal Sphinx version, state it=
 here.<br>
&gt;=C2=A0 #<br>
&gt; -# 3.4.3 is the oldest version of Sphinx that ships on a platform we<b=
r>
&gt; +# 7.2.6 is the oldest version of Sphinx that ships on a platform we<b=
r>
&gt;=C2=A0 # pledge build support for.<br>
&gt; -needs_sphinx =3D &#39;3.4.3&#39;<br>
&gt; +needs_sphinx =3D &#39;7.2.6&#39;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # Add any Sphinx extension module names here, as strings. They c=
an be<br>
&gt;=C2=A0 # extensions coming with Sphinx (named &#39;sphinx.ext.*&#39;) o=
r your custom<br>
&gt; diff --git a/python/setup.cfg b/python/setup.cfg<br>
&gt; index ebb4230899c..927f72a46f6 100644<br>
&gt; --- a/python/setup.cfg<br>
&gt; +++ b/python/setup.cfg<br>
&gt; @@ -41,7 +41,7 @@ devel =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 pylint &gt;=3D 2.17.3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 pytest &gt;=3D 6.2.4<br>
&gt;=C2=A0 =C2=A0 =C2=A0 tox &gt;=3D 3.18.0<br>
&gt; -=C2=A0 =C2=A0 sphinx &gt;=3D 3.4.3<br>
&gt; +=C2=A0 =C2=A0 sphinx &gt;=3D 7.2.6<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # Provides qom-fuse functionality<br>
&gt;=C2=A0 fuse =3D<br>
&gt; diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt<br>
&gt; index 85cfa08cf76..7154ad40040 100644<br>
&gt; --- a/python/tests/minreqs.txt<br>
&gt; +++ b/python/tests/minreqs.txt<br>
&gt; @@ -12,7 +12,7 @@<br>
&gt;=C2=A0 # on PyPI that allows the test suite to pass.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # Dependencies for qapidoc/qapi_domain et al<br>
&gt; -sphinx=3D=3D3.4.3<br>
&gt; +sphinx=3D=3D7.2.6<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # Dependencies for qemu.machine<br>
&gt;=C2=A0 qemu.qmp=3D=3D0.0.6<br>
&gt; @@ -48,23 +48,26 @@ platformdirs=3D=3D2.2.0<br>
&gt;=C2=A0 tomlkit=3D=3D0.10.1<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # Transitive sphinx dependencies<br>
&gt; -Jinja2=3D=3D2.7<br>
&gt; -MarkupSafe=3D=3D1.1.0<br>
&gt;=C2=A0 alabaster=3D=3D0.7.1<br>
&gt; -babel=3D=3D1.3<br>
&gt; -docutils=3D=3D0.12<br>
&gt; -imagesize=3D=3D0.5.0<br>
&gt; -packaging=3D=3D14.0<br>
&gt; -Pygments=3D=3D2.0<br>
&gt; -pytz=3D=3D2014.9<br>
&gt; -requests=3D=3D2.5.0<br>
&gt; -snowballstemmer=3D=3D1.1<br>
&gt; +babel=3D=3D2.9<br>
&gt; +certifi=3D=3D2023.5.7<br>
&gt; +charset-normalizer=3D=3D2.0.0<br>
&gt; +docutils=3D=3D0.18.1<br>
&gt; +idna=3D=3D2.5<br>
&gt; +imagesize=3D=3D1.3<br>
&gt; +Jinja2=3D=3D3.0.0<br>
&gt; +MarkupSafe=3D=3D2.0<br>
&gt; +packaging=3D=3D21.0<br>
&gt; +Pygments=3D=3D2.14<br>
&gt; +requests=3D=3D2.25.0<br>
&gt; +snowballstemmer=3D=3D2.0<br>
&gt;=C2=A0 sphinxcontrib-applehelp=3D=3D1.0.0<br>
&gt;=C2=A0 sphinxcontrib-devhelp=3D=3D1.0.0<br>
&gt; -sphinxcontrib-htmlhelp=3D=3D1.0.0<br>
&gt; +sphinxcontrib-htmlhelp=3D=3D2.0.0<br>
&gt;=C2=A0 sphinxcontrib-jsmath=3D=3D1.0.0<br>
&gt;=C2=A0 sphinxcontrib-qthelp=3D=3D1.0.0<br>
&gt; -sphinxcontrib-serializinghtml=3D=3D1.0.0<br>
&gt; +sphinxcontrib-serializinghtml=3D=3D1.1.9<br>
&gt; +urllib3=3D=3D1.26<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # Transitive pytest dependencies<br>
&gt;=C2=A0 attrs=3D=3D19.2.0<br>
&gt; diff --git a/pythondeps.toml b/pythondeps.toml<br>
&gt; index b1879c1a4da..f0f3af915a1 100644<br>
&gt; --- a/pythondeps.toml<br>
&gt; +++ b/pythondeps.toml<br>
&gt; @@ -28,8 +28,8 @@ meson =3D { accepted =3D &quot;&gt;=3D1.12.0&quot;, =
installed =3D &quot;1.12.0&quot;, canary =3D &quot;meson&quot; }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 [docs]<br>
&gt;=C2=A0 # Please keep the installed versions in sync with docs/requireme=
nts.txt<br>
&gt; -sphinx =3D { accepted =3D &quot;&gt;=3D3.4.3&quot;, installed =3D &qu=
ot;6.2.1&quot;, canary =3D &quot;sphinx-build&quot; }<br>
&gt; -sphinx_rtd_theme =3D { accepted =3D &quot;&gt;=3D0.5&quot;, installed=
 =3D &quot;1.2.2&quot; }<br>
&gt; +sphinx =3D { accepted =3D &quot;&gt;=3D7.2.6&quot;, installed =3D &qu=
ot;7.2.6&quot;, canary =3D &quot;sphinx-build&quot; }<br>
&gt; +sphinx_rtd_theme =3D { accepted =3D &quot;&gt;=3D1.2.2&quot;, install=
ed =3D &quot;1.2.2&quot; }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # This test group is for dependencies required to run various to=
oling<br>
&gt;=C2=A0 # and tests that should always be installed at configure time. I=
t should<br>
&gt; -- <br>
&gt; 2.55.0<br>
&gt; <br>
&gt; <br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0~~=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 <a href=3D"https://hachyderm.io/@berrange" rel=3D"noreferrer=
 noreferrer" target=3D"_blank">https://hachyderm.io/@berrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://entangle-photo.org" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://entangle-photo.org</a> :|<b=
r>
|: <a href=3D"https://pixelfed.art/berrange" rel=3D"noreferrer noreferrer" =
target=3D"_blank">https://pixelfed.art/berrange</a>=C2=A0 =C2=A0~~=C2=A0 =
=C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
<br>
</blockquote></div></div></div>

--0000000000000822d30659cade33--


