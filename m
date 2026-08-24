Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADA4C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyUQe-0007Xn-K9; Mon, 24 Aug 2026 09:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyUQT-0007Si-2E
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:09:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyUQR-00026O-9u
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787576958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B8733lG6Xc9DPhsFnpvhhG+JzQ3FRNjra4onCfZycz8=;
 b=cm8VKx4AD9MfGYnMYVzcDqA+ulU/GZ7p8AM9YX72xSuI5m8ve0/9m9EZuxoniLpjyHu/Q3
 s4CzxrxnE5DhTWkPiRU7c3xuNfPULk9X7PdmbX12L/cN5xwcswtwchMg8XJfXgx/yCYoMN
 0Jp/gkKKpQ9AOo3UcIpjyHTwjjd3Pzw=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-5GlB4PfHO6yrF92COiS0jw-1; Mon, 24 Aug 2026 09:09:16 -0400
X-MC-Unique: 5GlB4PfHO6yrF92COiS0jw-1
X-Mimecast-MFC-AGG-ID: 5GlB4PfHO6yrF92COiS0jw_1787576955
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-66cbfb7ec42so7841304d50.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 06:09:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787576955; cv=none;
 d=google.com; s=arc-20260327;
 b=DRXuoBU+JPIac1JDvEllOtEYRE8KI+lCPXbxjeIZ6733vR95rVZh9uCUJRYRDATLvg
 yRItVJY1+ONdtPUC5uzo7SkcgvkdADxn+1XKUafOET7qwDBXsbCocDwrxa4UuqVETer6
 5clvuwGZ+wNdhwanuZx8EyFMOuoTHO0905Wgcy2IryjJuJE2sPP1RdCO4gN4yWOtjyoJ
 KXzIllVPhu4U7vj4LEwk+sRzf6mabfWdejcbcyV2FuNrgXv6KT1NJZ870rgRQirOPEE9
 aerOyqmn+VRNBHJWcYpaiwsseREQVRKBuJ7YgSCdV173XvCFLttVtfoRNkGpNiWWDWp/
 K8Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=B8733lG6Xc9DPhsFnpvhhG+JzQ3FRNjra4onCfZycz8=;
 fh=Y2XJukwxgwYRiaCw2Q9t+1D6rqfXTT3+haiKb/UMqWY=;
 b=AZULhZVj4sNlQ2meK+zGBpdPAAh2PoClOmyyLLQbFSLrPOaJzGMTPgKBsQvioDKtqi
 NGTXV09ngXpogkcL0yv0yn+ajDBXXngg+Ql+hohLmSlGnmT0KAvywZR3MFtJKEttfdYI
 4jCx+M7TFZZRFTCYPDJ3CgpNKydzKL+xT8z548DZRG69vIgp6gEAG6m3xG6A+3EBXxME
 FYs7gpSNUFN5LxyB8JkvdfMyFu3DpuakyKU0V5Pgi+6EMoirK+WQ5os73TjtDeO5wyIx
 ZQktFdog79nbr11kWqH6yJuKukvn7YKiqzgeTn1jRAlUeSot1I9ym1wUI5y5Gr56GyYS
 1rLg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787576955; x=1788181755; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=B8733lG6Xc9DPhsFnpvhhG+JzQ3FRNjra4onCfZycz8=;
 b=ftVt79a9erJJipu+C1/CJUdD78K4CyGWJ8Wgpr0Gzqx+2UfUAspg/uV/Femv5WO7qn
 P917FWGxVvuzhuH/vyPxzB80/N9VB++ljz+dV4zPOd+GpR68AdyhToLds0W9dWetmosp
 eptLYjpF7rSahUypMfLxze6zdSotaTCUOKy0IdiGpj5O/94t1jlUEPB8x6oJlwQhbH1U
 noYuohaFIiUCiUKyIyrdAC18iMU0uMsEwlhTCnAGWYtYWCLCX/uApbkCzufLtAfZZ2Yl
 MfIoG0kWB4Dr30aFkcdQWl+NyP73YZmRmzHIiCceR6kYeohGXk49Yh2Lkr9PP04NQ2o9
 WhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787576955; x=1788181755;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=B8733lG6Xc9DPhsFnpvhhG+JzQ3FRNjra4onCfZycz8=;
 b=WX7wzxfZeccYyjZucMHmV2im6nBlMRNDLGvWKL8ySH8J/ORPevV1cvaqXA1eSIWb2J
 ccWtGG8Kh4NaSIsEImSipWaIvLsl6G1CGT23TdI/r2Gr3ch3FCltPhc1K4xsMjtKlODr
 40p4qP5WwOGgeb/b9c163xAGEmlwtOGkfXSbq3Z1E8SOLVwsrpmakisfy6oItIiP2e5a
 bNcI5TfjrO0LejElIFPrWHq1Oi17IbRflBqCPOATcvpiePyFD+COWXyA3U9WJMmllcA4
 57jqPigXsyiBZjBn2rr9c1t/twShjQg1o/RweEL8Ha5bxmP6lHOTOmcE57JTMKgSTu9U
 MGVg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrVBK7ZwmJow0RosfdPUKd7lpouVco0bfR9Q8mZp91U7bA8MSFiPJVdjM6qJCmafZIZO1kQVbvSJu5f@nongnu.org
X-Gm-Message-State: AFuF++loKVMG+28pF00aBQGidt1QY/XlnDhFMqd6z1OGtD34olykK+EE
 SYDGz62vwt/q9j/CsLE44hdGqvKf6qAk7T1dP02EarxoPHd3kpKRFU8lQqqkj+LH42hXH1S6pu7
 R79y7u4HxIukYajTdr2a/Rbc4WUHA4xciWZ405zs5dlI+hqJ/1nSfE+3EwkYOqQNYYdeC8CVeAg
 frdWPgOrg+tpGGI08Gh9/QHatuWVwvE1A=
X-Gm-Gg: AR+sD12Mgtc88h28YMhzS5AyJx3IGMKLU/BaUxPyrfjePvxIhBgHrBOe6pp3zBLc0Zu
 I3f36wpmspRTzzteQj9Z+t+OzQF4O8VkwZUmU/KazQw0QCxzmWZs99C2CZzdndUiyomhcXHjyCz
 evzYN3NnOTTq548uiZjhCzy5eCTen+/L0SfcyVEdOwstX9MnBAlmf+4vImDXvGedQ92smZwNZqi
 gPgVCxa3wTZo3SO
X-Received: by 2002:a53:bd12:0:b0:664:e5c5:5b3b with SMTP id
 956f58d0204a3-66cf2241256mr3961887d50.50.1787576954560; 
 Mon, 24 Aug 2026 06:09:14 -0700 (PDT)
X-Received: by 2002:a53:bd12:0:b0:664:e5c5:5b3b with SMTP id
 956f58d0204a3-66cf2241256mr3961862d50.50.1787576953993; Mon, 24 Aug 2026
 06:09:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260824052859.880475-1-jsnow@redhat.com>
 <20260824052859.880475-3-jsnow@redhat.com>
 <178755712683.3526866.11521669620152567935.b4-review@b4>
 <765ebb79-1ac9-4dc2-be13-db1884750bb1@redhat.com>
In-Reply-To: <765ebb79-1ac9-4dc2-be13-db1884750bb1@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 24 Aug 2026 09:09:03 -0400
X-Gm-Features: AcwNN1XdMfGLi42XoyD0ro4l0-g32MM2-0hq97UqbEXQ02PBjaWclahF97zSBpc
Message-ID: <CAFn=p-Zhaxup8sCkaH_qUwzDHHtmecAzRc6uEgkyjoiH7RK2SA@mail.gmail.com>
Subject: Re: [PATCH 02/12] tests: add Python3.12 to centos9.docker
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Kohei Tokunaga <ktokunaga.mail@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Michael Roth <michael.roth@amd.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Cleber Rosa <crosa@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: multipart/alternative; boundary="0000000000005a28470659cab139"
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

--0000000000005a28470659cab139
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026, 4:19=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com> w=
rote:

> On 8/24/26 09:38, marcandre.lureau@redhat.com wrote:
> >> While we recently upgraded to Python 3.11 for the CentOS 9 container,
> >> upgrade it even further to Python 3.12.
> >>
> >> Signed-off-by: John Snow <jsnow@redhat.com>
> >> Message-ID: <20260824052859.880475-3-jsnow@redhat.com>
> >>
> >> diff --git a/tests/docker/dockerfiles/centos9.docker
> b/tests/docker/dockerfiles/centos9.docker
> >> index 6f5c400c2db1..8bfce395f9d7 100644
> >> --- a/tests/docker/dockerfiles/centos9.docker
> >> +++ b/tests/docker/dockerfiles/centos9.docker
> >> @@ -96,10 +96,10 @@ RUN dnf --quiet distro-sync -y && \
> >>                   pkgconfig \
> >>                   pulseaudio-libs-devel \
> >>                   python3-tomli \
> >> -                python3.11 \
> >> -                python3.11-pip \
> >> -                python3.11-setuptools \
> >> -                python3.11-wheel \
> >> +                python3.12 \
> >> +                python3.12-pip \
> >> +                python3.12-setuptools \
> >> +                python3.12-wheel \
> >>                   rdma-core-devel \
> >>                   rust \
> >>                   rust-std-static \
> >> @@ -129,7 +129,7 @@ RUN dnf --quiet distro-sync -y && \
> >>       ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
> >>       ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
> >>
> >> -RUN /usr/bin/pip3.11 install \
> >> +RUN /usr/bin/pip3.12 install \
> >>                        numpy \
> >>                        opencv-python \
> >>                        sphinx \
> >> @@ -139,7 +139,7 @@ ENV
> CCACHE_WRAPPERSDIR=3D"/usr/libexec/ccache-wrappers"
> >>   ENV LANG=3D"en_US.UTF-8"
> >>   ENV MAKE=3D"/usr/bin/make"
> >>   ENV NINJA=3D"/usr/bin/ninja"
> >> -ENV PYTHON=3D"/usr/bin/python3.11"
> >> +ENV PYTHON=3D"/usr/bin/python3.12"
> >>   # As a final step configure the user (if env is defined)
> >>   ARG USER
> >>   ARG UID
> >> diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
> >> index 2b317e0a61c5..5c56e4aca1b0 100644
> >> --- a/tests/lcitool/mappings.yml
> >> +++ b/tests/lcitool/mappings.yml
> >> @@ -4,16 +4,16 @@ mappings:
> >>       Ubuntu2204:
> >>
> >>     python3:
> >> -    CentOSStream9: python3.11
> >> +    CentOSStream9: python3.12
> >>
> >>     python3-devel:
> >> -    CentOSStream9: python3.11-devel
> >> +    CentOSStream9: python3.21-devel
> Or drop it altogether, it seems not to be needed?
>
> Paolo
>

Hah! Oops. Surprised that worked, but it does tell us something, eh?

--0000000000005a28470659cab139
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto"><br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 24, 2026, 4:19=E2=80=AF=
AM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blan=
k" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">On 8/24/26 09:38, <a href=3D"mailto:marcandre.lureau@=
redhat.com" rel=3D"noreferrer noreferrer" target=3D"_blank">marcandre.lurea=
u@redhat.com</a> wrote:<br>
&gt;&gt; While we recently upgraded to Python 3.11 for the CentOS 9 contain=
er,<br>
&gt;&gt; upgrade it even further to Python 3.12.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" r=
el=3D"noreferrer noreferrer" target=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt;&gt; Message-ID: &lt;<a href=3D"mailto:20260824052859.880475-3-jsnow@re=
dhat.com" rel=3D"noreferrer noreferrer" target=3D"_blank">20260824052859.88=
0475-3-jsnow@redhat.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/tests/docker/dockerfiles/centos9.docker b/tests/docke=
r/dockerfiles/centos9.docker<br>
&gt;&gt; index 6f5c400c2db1..8bfce395f9d7 100644<br>
&gt;&gt; --- a/tests/docker/dockerfiles/centos9.docker<br>
&gt;&gt; +++ b/tests/docker/dockerfiles/centos9.docker<br>
&gt;&gt; @@ -96,10 +96,10 @@ RUN dnf --quiet distro-sync -y &amp;&amp; \<br=
>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0pkgconfig \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0pulseaudio-libs-devel \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0python3-tomli \<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 python3.1=
1 \<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 python3.1=
1-pip \<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 python3.1=
1-setuptools \<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 python3.1=
1-wheel \<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 python3.1=
2 \<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 python3.1=
2-pip \<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 python3.1=
2-setuptools \<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 python3.1=
2-wheel \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0rdma-core-devel \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0rust \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0rust-std-static \<br>
&gt;&gt; @@ -129,7 +129,7 @@ RUN dnf --quiet distro-sync -y &amp;&amp; \<br=
>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ln -s /usr/bin/ccache /usr/libexec/ccach=
e-wrappers/clang &amp;&amp; \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ln -s /usr/bin/ccache /usr/libexec/ccach=
e-wrappers/gcc<br>
&gt;&gt;=C2=A0 =C2=A0<br>
&gt;&gt; -RUN /usr/bin/pip3.11 install \<br>
&gt;&gt; +RUN /usr/bin/pip3.12 install \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 numpy \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 opencv-python \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 sphinx \<br>
&gt;&gt; @@ -139,7 +139,7 @@ ENV CCACHE_WRAPPERSDIR=3D&quot;/usr/libexec/cc=
ache-wrappers&quot;<br>
&gt;&gt;=C2=A0 =C2=A0ENV LANG=3D&quot;en_US.UTF-8&quot;<br>
&gt;&gt;=C2=A0 =C2=A0ENV MAKE=3D&quot;/usr/bin/make&quot;<br>
&gt;&gt;=C2=A0 =C2=A0ENV NINJA=3D&quot;/usr/bin/ninja&quot;<br>
&gt;&gt; -ENV PYTHON=3D&quot;/usr/bin/python3.11&quot;<br>
&gt;&gt; +ENV PYTHON=3D&quot;/usr/bin/python3.12&quot;<br>
&gt;&gt;=C2=A0 =C2=A0# As a final step configure the user (if env is define=
d)<br>
&gt;&gt;=C2=A0 =C2=A0ARG USER<br>
&gt;&gt;=C2=A0 =C2=A0ARG UID<br>
&gt;&gt; diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.y=
ml<br>
&gt;&gt; index 2b317e0a61c5..5c56e4aca1b0 100644<br>
&gt;&gt; --- a/tests/lcitool/mappings.yml<br>
&gt;&gt; +++ b/tests/lcitool/mappings.yml<br>
&gt;&gt; @@ -4,16 +4,16 @@ mappings:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Ubuntu2204:<br>
&gt;&gt;=C2=A0 =C2=A0<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0python3:<br>
&gt;&gt; -=C2=A0 =C2=A0 CentOSStream9: python3.11<br>
&gt;&gt; +=C2=A0 =C2=A0 CentOSStream9: python3.12<br>
&gt;&gt;=C2=A0 =C2=A0<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0python3-devel:<br>
&gt;&gt; -=C2=A0 =C2=A0 CentOSStream9: python3.11-devel<br>
&gt;&gt; +=C2=A0 =C2=A0 CentOSStream9: python3.21-devel<br>
Or drop it altogether, it seems not to be needed?<br>
<br>
Paolo<br></blockquote></div><div dir=3D"auto"><br></div><div dir=3D"auto">H=
ah! Oops. Surprised that worked, but it does tell us something, eh?</div></=
div>

--0000000000005a28470659cab139--


