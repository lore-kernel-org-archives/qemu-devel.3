Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C24C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyskd-0005p6-Jk; Tue, 25 Aug 2026 11:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyskc-0005ox-VI
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:07:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyska-0005hu-Kg
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787670461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t9kgDAiN7b0gvAgzeY5FtWOJQgnxRJGHltt0LSM6H5I=;
 b=Cq6rZRmEiMWnp9uXy3LtaEuzbKPXUFnh8IL9GYR1Nvys5LSiDAZeJuCi+e1eFSPpyVpyQJ
 nT8+MxK0WpO2bBttXIMkT681VlxwPt7cjZpWO4CvWag+rWX2HqG+nUuBxBra4Zja7x/oIT
 skv3OipnEHl5ObH+st87QjHMG7ppqv4=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-ObvS-YPvNSWyml6CGWZrfA-1; Tue, 25 Aug 2026 11:07:38 -0400
X-MC-Unique: ObvS-YPvNSWyml6CGWZrfA-1
X-Mimecast-MFC-AGG-ID: ObvS-YPvNSWyml6CGWZrfA_1787670458
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-66ce3040ea9so9581545d50.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 08:07:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787670458; cv=none;
 d=google.com; s=arc-20260327;
 b=fwA3NnUcYC/eQ8zoNSIUjPTbMq1wYoZpOYCRILDG3D4iDuYKUJ0HXWqL0AYH3xi2UY
 cEgnISwLWnxsaaXdMxUEcyrZvrimfRXPdVblD3ITjXXyIAN+VPWoz1vFzg5MUD3+aiq7
 tE4+rwC63OPHOc8w2DscpqD8Krfv03yH6WM789lSEihMVTj6Mgt9Ef+wWw/oosmic0NM
 091Vtt9KJSC3WJLLR4xKmM4s4NO4Q10xyGMKUxD3qt5XorD+168qMIRwEBXdlFoI5xAf
 7fuqI/H1788H3yEPlYnVMZoX25+puJHsvXRJq9c5Eybp8lNXBBOPhlBhuOMCghXMi7F7
 aHTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=t9kgDAiN7b0gvAgzeY5FtWOJQgnxRJGHltt0LSM6H5I=;
 fh=dNOU0ocCnvN5kDKQFHF16npSNEF2i+iSEogTzCN9ncU=;
 b=kvK/aWS8/PoyN5/UeVexPkhu5FZt5Q2mr7FFZmQxUI48qUuQ9wqAue7ePeeE22LS2H
 Oq+W6BWL0zjeJ+iL6HZbi86ZIRKvUvaUok1JtVPMv8yWSA1UmzFrkYa8gy6qWHs0xZdd
 5tWL3G4kRU6jRjUvTlE5gJsOlju6KgVLo+D7PrnrGLh/4aV4FQph6sqjTjpWeSs3q3tF
 jEPR8RwQI/Aafdm40lqHpp6YLjpf3Dk1C9eo9RytwJw5ZZaFxgVdge4UNsRVx+67/1X7
 wtqkp+Zr35DKgoePawqyg6EaUYTYPR4VU7yf0sDJX4Fv6TbfL5NpeFyTU+eotwn3M7js
 VO6w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787670458; x=1788275258; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=t9kgDAiN7b0gvAgzeY5FtWOJQgnxRJGHltt0LSM6H5I=;
 b=dojYh7Av50itzZPFrHIXQDS6Jr+FdCBxgbqcHunnByjFcNIGNssVQ7hfF0wHiF+rm7
 xW7Seke2YUM9nl2SE1lzm74FuJerdwJO9pFs8+W+97QZENkaWk+MP9qTX12nDdIr7NWl
 6iqyUXgmj00eiTlk0n77Zjzd6c7mo+P0RK0DRWXc+fugOs/qiII1iS3hpzSccm39vafF
 hnPbZCpFdByLvbrm8Nv+yb0h19oA3tTyW+injj5+Wyy1Of8RmfQhql4lQU+G8aRf/5vM
 JlAZ52N7PYJJG9fuDrAlD3B62roEU58fVJu1B+iMLAWojDt5srEs5hTxM+TQ/1ZINy7W
 zq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787670458; x=1788275258;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=t9kgDAiN7b0gvAgzeY5FtWOJQgnxRJGHltt0LSM6H5I=;
 b=lWqS6OLmQQWGVVzWjyVfGNMUp0BJyeXlTul1vyIouGr6AppRouiGj4uTm1GjKl8OCY
 C8a51fo9DxMHAKmkVY460jrY8nibu2FmytEZxNz206toOfacsU/2yKQlTqMXiWcavOCl
 z7FlrtNfU29qmvEGq8Uvi83Vek/r9LY7hOWZcqnp1PtmK8SYnFhXOF7HPIbvTlfIkOV6
 H3klrYAGWAMvWLlm/nEfdi4QAWww4P2HTx0N1Gsc1ufEfzBVJacRolFZl3l7HclSAuz4
 NTcwWLoUrmFsbynfSNF5KGTqyGCdVR17DMcMYgKjTj1aUnkB8WL57vrQpDcwRpnaBSZ0
 MZZQ==
X-Gm-Message-State: AFuF++ltWoGLl+YAFYq5GgJL50s3zsmn/bwCqwuXXQwm1vH6p4gsuPIW
 yLIozItu8BiOywdm9Xa3u5xhwDRDURiMadG7zVxGzb2CtB7TGetqecoTR1tG3KA6ZQjzBgb8aJ3
 dJC5ooVyPfLf8ZJJupPoZYStzYslzHES/HNl1MCVqNn+fDkEVCQhpWicJ6FP62cuupWpPybsyl1
 bnMvaCDRRHYmHUNwHMJgdVcvPH3MwnCRQ=
X-Gm-Gg: AR+sD10FCf5QlVKxeE1p0e/SbttTaFJyZN+dqqv3N3VSd4xg23XGpDxoPskGhmjPUvK
 TsMfaeN1MFU2mgy6444f9JbpYzDWoOjsrxcpYDBWsngTkR2LByUULt3PSPI0amt9XkhSARcwTyy
 64uox9Y8+IRweWC4uf7AcYsFjFy1kiCybiqPQK6GUtV1lQCEXaJVMLf/81W5M1EkmBdWDi5dlid
 1VLldzAnOHrpLK8
X-Received: by 2002:a05:690e:169f:b0:66c:c638:8e88 with SMTP id
 956f58d0204a3-66d23c8ec47mr235414d50.2.1787670457719; 
 Tue, 25 Aug 2026 08:07:37 -0700 (PDT)
X-Received: by 2002:a05:690e:169f:b0:66c:c638:8e88 with SMTP id
 956f58d0204a3-66d23c8ec47mr235380d50.2.1787670457109; Tue, 25 Aug 2026
 08:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260825051441.1562454-1-jsnow@redhat.com>
 <20260825051441.1562454-3-jsnow@redhat.com>
 <ao13tT_DZgxA_4Wn@redhat.com>
In-Reply-To: <ao13tT_DZgxA_4Wn@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 25 Aug 2026 11:07:25 -0400
X-Gm-Features: AcwNN1VeJEPOtqIh64x7uH0VWBJMxh8HsHGsxC7Rk1VIOg14kc3SmpCyegFSgqQ
Message-ID: <CAFn=p-akn7yAWXqB3uucJc5wbz+asRYaeqnQHWbOGbyTTJaY7A@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] tests: update FreeBSD dependencies
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Warner Losh <imp@bsdimp.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cleber Rosa <crosa@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Reinoud Zandijk <reinoud@netbsd.org>, 
 Kyle Evans <kevans@freebsd.org>, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: multipart/alternative; boundary="00000000000092eb870659e07659"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

--00000000000092eb870659e07659
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026, 7:08=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@red=
hat.com>
wrote:

> On Tue, Aug 25, 2026 at 01:14:27AM -0400, John Snow wrote:
> > FreeBSD has dropped Python3.11, now defaulting to Python3.12+; upgrade
> > the names of the various dependencies to match.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  tests/lcitool/mappings.yml      |  9 +++++++++
> >  tests/vm/generated/freebsd.json | 12 ++++++------
> >  2 files changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
> > index 1816556dde4..afe52455235 100644
> > --- a/tests/lcitool/mappings.yml
> > +++ b/tests/lcitool/mappings.yml
> > @@ -11,21 +11,29 @@ mappings:
> >
> >    python3-pip:
> >      CentOSStream9: python3.11-pip
> > +    FreeBSD: py312-pip
> >
> >    python3-setuptools:
> >      CentOSStream9: python3.11-setuptools
> > +    FreeBSD: py312-setuptools
> >
> >    python3-sphinx:
> >      CentOSStream9:
> > +    FreeBSD: py312-sphinx
> >
> >    python3-sphinx-rtd-theme:
> >      CentOSStream9:
> > +    FreeBSD: py312-sphinx_rtd_theme
> >
> >    python3-venv:
> >      CentOSStream9: python3.11
> >
> >    python3-wheel:
> >      CentOSStream9: python3.11-wheel
> > +    FreeBSD: py312-wheel
> > +
> > +  python3-numpy:
> > +    FreeBSD: py312-numpy
> >
> >    meson:
> >      # Use Meson from PyPI wherever Rust is enabled
> > @@ -38,6 +46,7 @@ mappings:
> >      apk:
> >      Fedora:
> >      Debian12:
> > +    FreeBSD: py312-tomli
> >
> >    rust:
> >      Debian12: rustc-web
>
> This shouldn't be done here.  libvirt-ci.git needs to be updated to
> have the new names.  FreeBSD does this annoying package rename every
> time a new python version is adopted :-(
>

I figured as much, but wanted to see it run for this series, so I thundered
ahead on the stupid way.

Mea culpa.


> I've proposed the required changes:
>
>   https://gitlab.com/libvirt/libvirt-ci/-/merge_requests/582
>
>
> Once that's merged just updated the tests/lcitool/libvirt-ci git
> submodule commit to latest HEAD and run 'make lcitool-refresh'
> again in this commit.
>

OK, great! Thanks!


> > diff --git a/tests/vm/generated/freebsd.json
> b/tests/vm/generated/freebsd.json
> > index dfa8b41a524..ee3402f0d2b 100644
> > --- a/tests/vm/generated/freebsd.json
> > +++ b/tests/vm/generated/freebsd.json
> > @@ -52,12 +52,12 @@
> >      "pixman",
> >      "pkgconf",
> >      "png",
> > -    "py311-pip",
> > -    "py311-setuptools",
> > -    "py311-sphinx",
> > -    "py311-sphinx_rtd_theme",
> > -    "py311-tomli",
> > -    "py311-wheel",
> > +    "py312-pip",
> > +    "py312-setuptools",
> > +    "py312-sphinx",
> > +    "py312-sphinx_rtd_theme",
> > +    "py312-tomli",
> > +    "py312-wheel",
> >      "python3",
> >      "rpm2cpio",
> >      "rust",
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

--00000000000092eb870659e07659
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 25, 2026, 7:08=E2=80=
=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">be=
rrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On=
 Tue, Aug 25, 2026 at 01:14:27AM -0400, John Snow wrote:<br>
&gt; FreeBSD has dropped Python3.11, now defaulting to Python3.12+; upgrade=
<br>
&gt; the names of the various dependencies to match.<br>
&gt; <br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tests/lcitool/mappings.yml=C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 +++++++=
++<br>
&gt;=C2=A0 tests/vm/generated/freebsd.json | 12 ++++++------<br>
&gt;=C2=A0 2 files changed, 15 insertions(+), 6 deletions(-)<br>
&gt; <br>
&gt; diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml<b=
r>
&gt; index 1816556dde4..afe52455235 100644<br>
&gt; --- a/tests/lcitool/mappings.yml<br>
&gt; +++ b/tests/lcitool/mappings.yml<br>
&gt; @@ -11,21 +11,29 @@ mappings:<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 python3-pip:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 CentOSStream9: python3.11-pip<br>
&gt; +=C2=A0 =C2=A0 FreeBSD: py312-pip<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 python3-setuptools:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 CentOSStream9: python3.11-setuptools<br>
&gt; +=C2=A0 =C2=A0 FreeBSD: py312-setuptools<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 python3-sphinx:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 CentOSStream9:<br>
&gt; +=C2=A0 =C2=A0 FreeBSD: py312-sphinx<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 python3-sphinx-rtd-theme:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 CentOSStream9:<br>
&gt; +=C2=A0 =C2=A0 FreeBSD: py312-sphinx_rtd_theme<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 python3-venv:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 CentOSStream9: python3.11<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 python3-wheel:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 CentOSStream9: python3.11-wheel<br>
&gt; +=C2=A0 =C2=A0 FreeBSD: py312-wheel<br>
&gt; +<br>
&gt; +=C2=A0 python3-numpy:<br>
&gt; +=C2=A0 =C2=A0 FreeBSD: py312-numpy<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 meson:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 # Use Meson from PyPI wherever Rust is enabled<br>
&gt; @@ -38,6 +46,7 @@ mappings:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 apk:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Fedora:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Debian12:<br>
&gt; +=C2=A0 =C2=A0 FreeBSD: py312-tomli<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 rust:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Debian12: rustc-web<br>
<br>
This shouldn&#39;t be done here.=C2=A0 libvirt-ci.git needs to be updated t=
o<br>
have the new names.=C2=A0 FreeBSD does this annoying package rename every<b=
r>
time a new python version is adopted :-(<br></blockquote></div></div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">I figured as much, but wanted to se=
e it run for this series, so I thundered ahead on the stupid way.</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">Mea culpa.</div><div dir=3D"auto"=
><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_containe=
r"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">
<br>
I&#39;ve proposed the required changes:<br>
<br>
=C2=A0 <a href=3D"https://gitlab.com/libvirt/libvirt-ci/-/merge_requests/58=
2" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/libvi=
rt/libvirt-ci/-/merge_requests/582</a><br>
<br>
<br>
Once that&#39;s merged just updated the tests/lcitool/libvirt-ci git<br>
submodule commit to latest HEAD and run &#39;make lcitool-refresh&#39;<br>
again in this commit.<br></blockquote></div></div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">OK, great! Thanks!</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
&gt; diff --git a/tests/vm/generated/freebsd.json b/tests/vm/generated/free=
bsd.json<br>
&gt; index dfa8b41a524..ee3402f0d2b 100644<br>
&gt; --- a/tests/vm/generated/freebsd.json<br>
&gt; +++ b/tests/vm/generated/freebsd.json<br>
&gt; @@ -52,12 +52,12 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;pixman&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;pkgconf&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;png&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;py311-pip&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;py311-setuptools&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;py311-sphinx&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;py311-sphinx_rtd_theme&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;py311-tomli&quot;,<br>
&gt; -=C2=A0 =C2=A0 &quot;py311-wheel&quot;,<br>
&gt; +=C2=A0 =C2=A0 &quot;py312-pip&quot;,<br>
&gt; +=C2=A0 =C2=A0 &quot;py312-setuptools&quot;,<br>
&gt; +=C2=A0 =C2=A0 &quot;py312-sphinx&quot;,<br>
&gt; +=C2=A0 =C2=A0 &quot;py312-sphinx_rtd_theme&quot;,<br>
&gt; +=C2=A0 =C2=A0 &quot;py312-tomli&quot;,<br>
&gt; +=C2=A0 =C2=A0 &quot;py312-wheel&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;python3&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;rpm2cpio&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;rust&quot;,<br>
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

--00000000000092eb870659e07659--


