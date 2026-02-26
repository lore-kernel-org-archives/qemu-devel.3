Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204B7FD8FD3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 16:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vve9y-0005yT-CT; Thu, 26 Feb 2026 11:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vve9x-0005xu-8W
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 11:24:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vve9u-0007pe-BB
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 11:24:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772123052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QO7I8+4B4NTXDLmtRuXokwHGU/kjO/wKXmZiqPd7ceM=;
 b=InUX+/YuuWOpjvJoOUqi+Vd3kWTS1Eu+6036Rji4brart6IKMR2XB2GwLCeycbC2UQqF4D
 I1gjKwivujR2YXD6oqCmfhdrnmy4IgF6Nu5HGrHDwxskr8QYKw5irt8HE5xfi/3184AavN
 R32Ikgb1UA/z4tEYqvhu3y/gZacKsUc=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-JuRe0HgcPnCjkP6SvzrkmQ-1; Thu, 26 Feb 2026 11:24:10 -0500
X-MC-Unique: JuRe0HgcPnCjkP6SvzrkmQ-1
X-Mimecast-MFC-AGG-ID: JuRe0HgcPnCjkP6SvzrkmQ_1772123050
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-64ca5bae25aso1682174d50.3
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 08:24:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772123050; cv=none;
 d=google.com; s=arc-20240605;
 b=TO6R/tEWHTvOSfmcjHQMk19GUOKgKXEFoilU3HqUCQlssGWt4QGnQQIaXEK9eSnRu/
 pp/Kt4dNgNMmDz6fPqI/QyapjGBKdib/fMLmITE7b8pKFEGk7mlZBXN2uBm8FRKwBR2c
 Xyyk8G7RTmuWG3IYj9zgsn7t0cNRC1EqrFGhdl2ZNpnJ5+di7SPgOO8nH38WyLIizms0
 7bIWNHVKZPsbXhytNovQHQwzg42bPu+lVddSl8iTfJ1qcMMRHga9cMpqeOoivQizSEhw
 LWbTzhjIaFks8MKl8aWb83RTzFHzjgYP3OYGpAWtgo+YU5m1D9ZItRqFmiS6FF4Z2K9Q
 ZuBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QO7I8+4B4NTXDLmtRuXokwHGU/kjO/wKXmZiqPd7ceM=;
 fh=VNFsG6wANPp1ZECopsVB7Ex2xqU2oTIhhrTg6bRRKWM=;
 b=N+CBiLPXSmhlEIOcD5Ma9VKZTVUDUedNH4ZKNCFSCqXSy+OWlZn9a69thfiMi1TtOE
 ew/kfi//rE9s+saYVwNDG1F4GVxPgk1SHFkk+vO5ZMxLIaWY8hpgoLxHBhdm9XI5wiNq
 WhfHBzXqwr6DUbepNVnLnVtnu3FP9ScAxyT6kE34dAhbFWXEGw/sL0UEtpx9SLK6PoJn
 yrm7Uxow1IQlV953nHTENHOj+RqOIEp/XRxNxVHfL1hRk7v9Bva1aX0Kcwi0t7wx0ek6
 Ttjspum3zSq3iQDNHQfB27vlYo0t8MvuZSZS3Ys+FhZB92Sg+NQknAVek6JoFhjCiHC/
 TWFw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772123050; x=1772727850; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QO7I8+4B4NTXDLmtRuXokwHGU/kjO/wKXmZiqPd7ceM=;
 b=WpRIXxEB/JFScfhWDkdHRUIWUu54QdVlRRxQxryInjSDeDVrzTay26Sx1IomfxfheA
 1ygxpUdxI1qqbkcYY6BitTCug+UIl2E5hgUr1RLVy4UR+k9UmmV5AkpdMPPTl1kdmqY7
 Ee4vUZRq857UbHJDXmxJexDqnWnaN9MhQxlhN5zU/VK5bmM2kQkQ78efN1jvhPz51J01
 CWif1NNaH6pGfaWZjF8DR9P/fkPfLu9yycZA3KfRd2MyV91bRO5/y4yEazSiMOujQM0C
 jWWXCa2nSddCrhQHKZoiS3PjJ5dciE28jifAp//co0Jm1EDkYiauUc7uoiOEb4v0lfIX
 bY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772123050; x=1772727850;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QO7I8+4B4NTXDLmtRuXokwHGU/kjO/wKXmZiqPd7ceM=;
 b=Ir5DDdhe1KB4P0TDAi06qYwS20EApj59ew288B6bLYHz/SPOvrQv8CsrGIZVvJHEps
 FRYIZGx7FdjFY1La3D+k6AVtLh5fEIU3/7xWoiCInjDih8IdySPyn6nINmQBYcIGj1/2
 seuywivOqshlofJi5tLFEg5KcY98cGXTuoXSaAkh//bxurvb6KZglFDIaH7N1u0VuOrZ
 ZAWbJjp/cAM5j/N1GRispQ20rDDTSzoMWGFSmmmH3b+3pbfWriTmsfHMDPmgpHH0Y6PA
 WbAYOJflufnLlO5xzzsKIuytdpDN8PcValPaxus7TS8ULcSLbMF1N4idseU160JP/qYy
 tA+Q==
X-Gm-Message-State: AOJu0YwFHikvn3SljVOGAWaVI7Zla1juZ5OxMF9eGPymrNgjz9jHmSwZ
 mlfvUvL2ytcr2Ce5lUXm3leoQrie71AbbFuITPU7XERLTK+o5qqtdlxnPWVm7kKOlXcfeDos3RX
 W402Sc5MRzZQ+n7s+GvOcGfryn7izYGbIWJPVQrA8IHmyYFET4Wbbjgw0xW89G2kNfiOcGFv9pP
 IIUgGTt8GyZsZlRrmU3O5aI+GkGZcdvEA=
X-Gm-Gg: ATEYQzwqWsc7tqF86hbMzb865a8CHklpkXHfTz7Bp3YwYoE9p1ekcmjlk8kpY61lbIC
 0meJVJQBagwCTHdixLr69NGfvdwdFkI40xrarzZk5ooTVVkfdkc9g+sBeND5e+YrKkU+/ErMlTZ
 ZemF52hlsJCEKqYEbRbWtvW1F5m4/9iEwREg86e9PAYyM4GL7pdqnS6c0mlFbA2741gM7NIL/5b
 0hxUUSzDFpOsuDEpNODalbFPHMXzpHv0GqROw==
X-Received: by 2002:a05:690e:408b:b0:649:cc0d:a99b with SMTP id
 956f58d0204a3-64cb7bf809amr1907347d50.11.1772123048621; 
 Thu, 26 Feb 2026 08:24:08 -0800 (PST)
X-Received: by 2002:a05:690e:408b:b0:649:cc0d:a99b with SMTP id
 956f58d0204a3-64cb7bf809amr1907265d50.11.1772123046651; Thu, 26 Feb 2026
 08:24:06 -0800 (PST)
MIME-Version: 1.0
References: <20260225193856.959771-1-jsnow@redhat.com>
 <20260225193856.959771-3-jsnow@redhat.com>
 <87wm00zb0x.fsf@draig.linaro.org>
In-Reply-To: <87wm00zb0x.fsf@draig.linaro.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 26 Feb 2026 11:23:55 -0500
X-Gm-Features: AaiRm51sFcxOJQ9vlC5ij_Gtvv_yzpEgjShOj0JQCdlwFT_je0Q4XZBl5j3YaRU
Message-ID: <CAFn=p-ZV1Qy7ooEYC2tQkYARkspZ1Zh044wXSr5Phxi7TakUfg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] tests: upgrade debian-legacy-test-cross to debian
 13
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b27931064bbc8ce6"
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

--000000000000b27931064bbc8ce6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026, 5:57=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linaro.=
org> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > We no longer require Debian 11 to run these tests; they work properly
> > under Debian 13/Trixie.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> If these all work with Debian 13 we should just punt the compilers into
> debian-all-test-cross and delete this container and redirect its users.
>

Alright, wasn't sure where you wanted em. I'll give it a shot.


> > ---
> >  .../dockerfiles/debian-legacy-test-cross.docker  | 16 +++++-----------
> >  1 file changed, 5 insertions(+), 11 deletions(-)
> >
> > diff --git a/tests/docker/dockerfiles/debian-legacy-test-cross.docker
> b/tests/docker/dockerfiles/debian-legacy-test-cross.docker
> > index 5a6616b7d39..293f31a07d6 100644
> > --- a/tests/docker/dockerfiles/debian-legacy-test-cross.docker
> > +++ b/tests/docker/dockerfiles/debian-legacy-test-cross.docker
> > @@ -1,18 +1,13 @@
> >  # Docker legacy cross-compiler target (tests and minimal qemu)
> >  #
> > -# Compilers for some of our older targets which we cant currently
> > -# upgrade. Currently:
> > -#
> > -#   libc6.1-dev-alpha-cross:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1054412
> > -#   sh4-linux-user: binaries don't run with bookworm compiler
> > -#
> >  # As we are targeting check-tcg here we only need minimal qemu
> >  # dependencies and the relevant cross compilers.
> >
> > -FROM docker.io/library/debian:11-slim
> > +FROM docker.io/library/debian:13-slim
> >
> > -# Duplicate deb line as deb-src
> > -RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >>
> /etc/apt/sources.list
> > +# Add deb-src repository sources
> > +RUN sed -i "s/^Types: deb$/Types: deb deb-src/" \
> > +    /etc/apt/sources.list.d/debian.sources
> >
> >  RUN export DEBIAN_FRONTEND=3Dnoninteractive && \
> >      apt-get update && \
> > @@ -35,12 +30,11 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> >          libc6-dev-sh4-cross \
> >          python3-pip \
> >          python3-setuptools \
> > +        python3-tomli \
> >          python3-venv \
> >          python3-wheel && \
> >          dpkg-query --showformat
> '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
> >
> > -RUN /usr/bin/pip3 install tomli
> > -
> >  ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tool=
s
> >  ENV DEF_TARGET_LIST alpha-linux-user,sh4-linux-user
> >  ENV MAKE /usr/bin/make
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>
>

--000000000000b27931064bbc8ce6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 25, 2026, 5:57=E2=80=
=AFPM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.b=
ennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Joh=
n Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"nor=
eferrer">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; We no longer require Debian 11 to run these tests; they work properly<=
br>
&gt; under Debian 13/Trixie.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
<br>
If these all work with Debian 13 we should just punt the compilers into<br>
debian-all-test-cross and delete this container and redirect its users.<br>=
</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Alri=
ght, wasn&#39;t sure where you wanted em. I&#39;ll give it a shot.</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_=
quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; ---<br>
&gt;=C2=A0 .../dockerfiles/debian-legacy-test-cross.docker=C2=A0 | 16 +++++=
-----------<br>
&gt;=C2=A0 1 file changed, 5 insertions(+), 11 deletions(-)<br>
&gt;<br>
&gt; diff --git a/tests/docker/dockerfiles/debian-legacy-test-cross.docker =
b/tests/docker/dockerfiles/debian-legacy-test-cross.docker<br>
&gt; index 5a6616b7d39..293f31a07d6 100644<br>
&gt; --- a/tests/docker/dockerfiles/debian-legacy-test-cross.docker<br>
&gt; +++ b/tests/docker/dockerfiles/debian-legacy-test-cross.docker<br>
&gt; @@ -1,18 +1,13 @@<br>
&gt;=C2=A0 # Docker legacy cross-compiler target (tests and minimal qemu)<b=
r>
&gt;=C2=A0 #<br>
&gt; -# Compilers for some of our older targets which we cant currently<br>
&gt; -# upgrade. Currently:<br>
&gt; -#<br>
&gt; -#=C2=A0 =C2=A0libc6.1-dev-alpha-cross: <a href=3D"https://bugs.debian=
.org/cgi-bin/bugreport.cgi?bug=3D1054412" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1054412<=
/a><br>
&gt; -#=C2=A0 =C2=A0sh4-linux-user: binaries don&#39;t run with bookworm co=
mpiler<br>
&gt; -#<br>
&gt;=C2=A0 # As we are targeting check-tcg here we only need minimal qemu<b=
r>
&gt;=C2=A0 # dependencies and the relevant cross compilers.<br>
&gt;=C2=A0 <br>
&gt; -FROM <a href=3D"http://docker.io/library/debian:11-slim" rel=3D"noref=
errer noreferrer" target=3D"_blank">docker.io/library/debian:11-slim</a><br=
>
&gt; +FROM <a href=3D"http://docker.io/library/debian:13-slim" rel=3D"noref=
errer noreferrer" target=3D"_blank">docker.io/library/debian:13-slim</a><br=
>
&gt;=C2=A0 <br>
&gt; -# Duplicate deb line as deb-src<br>
&gt; -RUN cat /etc/apt/sources.list | sed &quot;s/^deb\ /deb-src /&quot; &g=
t;&gt; /etc/apt/sources.list<br>
&gt; +# Add deb-src repository sources<br>
&gt; +RUN sed -i &quot;s/^Types: deb$/Types: deb deb-src/&quot; \<br>
&gt; +=C2=A0 =C2=A0 /etc/apt/sources.list.d/debian.sources<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 RUN export DEBIAN_FRONTEND=3Dnoninteractive &amp;&amp; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 apt-get update &amp;&amp; \<br>
&gt; @@ -35,12 +30,11 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 libc6-dev-sh4-cross \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 python3-pip \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 python3-setuptools \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 python3-tomli \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 python3-venv \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 python3-wheel &amp;&amp; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dpkg-query --showformat &#39;${Packa=
ge}_${Version}_${Architecture}\n&#39; --show &gt; /packages.txt<br>
&gt;=C2=A0 <br>
&gt; -RUN /usr/bin/pip3 install tomli<br>
&gt; -<br>
&gt;=C2=A0 ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disabl=
e-tools<br>
&gt;=C2=A0 ENV DEF_TARGET_LIST alpha-linux-user,sh4-linux-user<br>
&gt;=C2=A0 ENV MAKE /usr/bin/make<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
<br>
</blockquote></div></div></div>

--000000000000b27931064bbc8ce6--


