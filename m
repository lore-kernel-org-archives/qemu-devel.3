Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF69E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 21:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsp0x-0005Js-K5; Wed, 18 Feb 2026 16:23:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vsp0v-0005Ja-9z
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:23:17 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vsp0s-00018K-Mm
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:23:17 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3549bba5302so121952a91.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 13:23:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771449793; cv=none;
 d=google.com; s=arc-20240605;
 b=Wc06RLdMvl2SjL51caReo7GFKCIqjnr+igMcsoD2FbcX8QE74d5jyJ3REWB2tzxrw4
 XqVaTOpwwHIT1+MgipnoUiW3Fz/bL7ThnIvEKJk4/dXJk311pbLqGHt0ExTC80nPSKAr
 NB9klFE0szqA7orAv8ZJ2RNk7zu1zyW4f/Oa3Elain9sP3dKeuYv8ZfnCx18gs1Tw9xG
 lpmtXYceJBv5djTTumPP81iUKG5kh/o07AfZuUMtNTycXPv0qu0EVgWf+wTTJ2JWWgSN
 n10ykdpymAsRscY7Q7qVyhMnXuc7sy3suxvsznoy3oUvPy5N0PtoxW3kQgffzV4gijvU
 ajPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3ONVMC2H9/apWAtHoVt7RWmqAYD48MskY4ITJEaGysw=;
 fh=iLzEtxmiNgCkCU6glI8f3s4x0sxyI9KGvh0S9V3ICRE=;
 b=b6/4wEXr2kBuk2JQ5OataD61rTaxvYaqvNI74oilMU0VcMLZTVAfFirAYpM0DBz0XX
 KFPfoJo5LX/NPsjg6aZYX44NxolK4g20cqmjf5RuLbUsMg92h7XyCg+jghg+QPLAHAwj
 MT16EHOxiXtC8fammn5yCmwfgwtdzxDi7eGkLtrRftXEaNLO87rUd69z9eD586olQ8hz
 ezloSfCKO7irLDjD+1Q50dYq1vWF4ZB9zoaZA3p9eIdbqccDD7ei4u9UpHnpzpGCbkQE
 GY8bUQrqX6aj9jrNbrpfXmwoWrrA1CkyrbJTwiBwDcw1sI3Zc0Fot4k+Jabl4LdRdg/b
 DV4g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771449793; x=1772054593;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3ONVMC2H9/apWAtHoVt7RWmqAYD48MskY4ITJEaGysw=;
 b=BJ/R81pS2mk8PhqMAl8UwIQn4fSSCPEqwP39Q4zXw5N5wbssXa6sU8i0oxBV7JQwjw
 suEQ72S9MoiWLakpNF18//4OSAuSkr0kLfeoqHGhdtyUL5iNT1H8bzyFV0VI0DVp7wF7
 g9JvfTvaSVyfBNf3pi7iUQjh4c0cxpZG2dYc/o3+jNb+t9QccVBBaOS3wGjwisv8tMUj
 2JZi++7SVa9ezayckANl2xJKmeYZ5CWyVUlaqIlq7Uxe406vchLAvX1IAODeIBu/6NYI
 P+Dj2aes9j298SFuJKN9VRC0EyNtYEi5pXBierJA82Vvzc/SjxSo+9MUjnRwYv1oJTKj
 XaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771449793; x=1772054593;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ONVMC2H9/apWAtHoVt7RWmqAYD48MskY4ITJEaGysw=;
 b=OuuRbFPJ/mUvQUxi90smLckOuUdBqRTRZtUhxBYpBdLAvmKxlcZAMZBsx7Tq5mT6AP
 sNbCEYJZZFjECbWW8q0ui3a17ER1Ru27hEaQSMS4mVpFpNUZ+TCXgiXbrV8RM5qdptNJ
 FC6qG1RURW0CHpDZ2vSAE8d+dKp7r+9Ew7mEqZdcaHKoIathHuErUw1+oyfxzxNBRP77
 ANVvi2hngtSwk5B/TNDDyTh8Cc0+Wmk23aKoMTueEw/40UF4jGbL48gS8CCyFoiYdWVx
 AlLvO0YkSdKsn4hdJ5AldL/LbsRUlLbweHpLmwjQ9eJqwpPG9MOakTWsPCAMpOACnJaF
 o3Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjW9icjjNhHF6vuZxTKSQ+stbPtNNWU1xpwJ7wdC3/YT9obLESbTHNxWHJa04i5DZkOsfa18ZB4mY9@nongnu.org
X-Gm-Message-State: AOJu0Yw2nuzn57VhoCTKMmE5oMtilfRiabRW9gwHu+2IISSahSOX3AVa
 VzHXlNFr0A3NPaQjxGYkFgkpdObZ0nB7szEnFqSjZatRRW3FAR4tI2Vhxn/u8BXYhyvRBzPH0UW
 pnYZMPXxMSNLZe/PeZ3iJ43aq6kgByCE/LArvS9hLG9oMc74KQ04+few=
X-Gm-Gg: AZuq6aJzyWCH5hF3y8jLKUsYIUJ4/pNVWPvkqAeD0Rk9k1Kwov0yknNO/0gmkb0Zmq2
 scnhDGIwvGfZYUKD0ZJngzxlMGAKgAFpKQ5SE0FhLaL4rWZV8dG1DkV6xLyf6qHBM+o9ybGvZCR
 ql3uspn1a5TFazCdc4u1PEgnWJpSdVs3JVGd+4EyYtVBzjK+HLhZ466RagGbz/+3JklmFQqS8un
 fFnb66Da2hk1jDJo7fM6Ipn4R1UUOuwLJtlRyHsw40V+VXQYAFS7GpkPVYN/qo9F7Gmq45zdb7z
 gXSH5FFpRw7hiNtvow==
X-Received: by 2002:a17:90b:52cf:b0:354:c6f3:d365 with SMTP id
 98e67ed59e1d1-356aad5ef36mr16357566a91.17.1771449792689; Wed, 18 Feb 2026
 13:23:12 -0800 (PST)
MIME-Version: 1.0
References: <CAFn=p-YGckyEF8GCOviMJ-FfWsM_dDa6nqEBJChPmUxP7Ydi_w@mail.gmail.com>
 <87wm0afsnh.fsf@pond.sub.org>
 <56a8affc-e786-4dc8-81bd-c1f78a224afd@redhat.com>
 <CAFn=p-YqRu3eaR+RvpCi3uaq8Y7s0pGtXwOLztqMDCqYG6McPA@mail.gmail.com>
 <CABgObfaRzjaGTdXGHG=BeHFgGJaC4tt0eKOJu=L=SYWpQmm+6w@mail.gmail.com>
 <CAFn=p-ZdzRuisd6g65A+VXyDKXnTuBc0gnt0ApbhVBZG5GhJZQ@mail.gmail.com>
In-Reply-To: <CAFn=p-ZdzRuisd6g65A+VXyDKXnTuBc0gnt0ApbhVBZG5GhJZQ@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 18 Feb 2026 14:23:01 -0700
X-Gm-Features: AaiRm5264qt6za-ZpQow0MKlPYZZxLXgsl-SbvvOZISug_rzSy77SuMmNU-mqAY
Message-ID: <CANCZdfr-ab65iUD488H8BVPUfCaNP2NP8HJGcQMZi5FSLNsNJw@mail.gmail.com>
Subject: Re: CentOS 9, Python, and other Fairytales
To: John Snow <jsnow@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a1851e064b1fcb77"
Received-SPF: none client-ip=2607:f8b0:4864:20::1036;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000a1851e064b1fcb77
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 1:42=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:

> On Wed, Feb 18, 2026 at 3:26=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
> >
> >
> >
> > Il mer 18 feb 2026, 18:10 John Snow <jsnow@redhat.com> ha scritto:
> >>
> >>
> >>
> >> On Wed, Feb 18, 2026, 6:48=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.c=
om>
> wrote:
> >>>
> >>> >> With most of the new sticking points being debian 12 (EOL in June)
> or
> >>> >> FreeBSD (timeline uncertain for when they'll re-modernize their
> python
> >>> >> stack)
> >>> >>
> >>> >> One edge case here, however, is Sphinx, which does not actually
> have a
> >>> >> modern package in centOS stream 9.
> >>> >>
> >>> >> CentOS currently ships 3.4.3, but it would not be usable if using
> the
> >>> >> optional 3.12 upgrade. If we ignore this, both FreeBSD and Debian =
12
> >>> >> have sphinx 5.3.0 to offer us, which is a reasonable version jump,
> but
> >>> >> it means that CentOS would not be able to build docs unless you
> >>> >> enabled `--online` for configuring QEMU or sideloaded Sphinx
> >>> >> otherwise.
> >>> >
> >>> > CentOS 9 reaches end of life on May 31 next year.  I do not think
> >>> > keeping its ability to build bleeding edge docs offline out of the
> box
> >>> > for its final year (give or take) is worth your time, or anybody's.
> >>>
> >>> That's exactly the reason why we (John and I) introduced mkvenv.py,
> >>> except it was CentOS 8 and SLES 15 at the time
> >>> (https://www.qemu.org/2023/03/24/python/):
> >>>
> >>> "Some of these tools are run through the python3 executable, while
> >>> others are invoked directly as sphinx-build or meson, and this can
> >>> create inconsistencies. For example, QEMU=E2=80=99s configure script =
checks for
> >>> a minimum version of Python and rejects too-old interpreters. However=
,
> >>> what would happen if code run by Sphinx used a different version?
> >>>
> >>> This situation has been largely hypothetical until recently; QEMU=E2=
=80=99s
> >>> Python code is already tested with a wide range of versions of the
> >>> interpreter, and it would not be a huge issue if Sphinx used a
> different
> >>> version of Python as long as both of them were supported. This will
> >>> change in version 8.1 of QEMU, which will bump the minimum supported
> >>> version of Python from 3.6 to 3.8. While all the distros that QEMU
> >>> supports have a recent-enough interpreter, the default on RHEL8 and
> >>> SLES15 is still version 3.6, and that is what all binaries in /usr/bi=
n
> >>> use unconditionally."
> >>>
> >>> So yeah, there's precedent for doing this, and it's the right thing t=
o
> >>> do anyway.
> >>>
> >>> >> My plan:
> >>> >> - Wait and see what happens after the current QEMU release
> >>> >> - Gleefully drop Ubuntu 22.04 in April (Allows Python 3.11+)
> >>> >> - Gleefully drop Debian 12 in June
> >>> >> - Hold my breath and see if FreeBSD happens to modernize by this
> point
> >>> >> (They have until October 2027 to do so, so it's a dice roll if the=
y
> >>> >> will or not)
> >>> >> - Do a big round of Python modernization all at once; either to 3.=
11
> >>> >> or 3.12 depending, and either to Sphinx 5.x or 7.x depending, pray
> for
> >>> >> forgiveness that I am removing CentOS stream 9's ability to build
> docs
> >>> >> offline so I don't have to wait another six months and then do
> another
> >>> >> big cleanup round
> >>>
> >>> The main nice features of 3.12 are improved f-strings, which are nice
> >>> but not really a necessity.
> >>>
> >>> If I read it correctly, https://www.freshports.org/lang/python says i=
t
> >>> has 3.9 on PPC and 3.11 elsewhere, but
> >>> https://www.freshports.org/lang/python311 says 3.11 exists on PPC as
> well.
> >>>
> >>> I'd go for 3.11 and Sphinx 7.  For FreeBSD we can require Python from
> Ports.
> >>
> >>
> >> freebsd ports is currently at 3.11, which is the main reason I am
> saying "see what freebsd does by June"
> >>
> >> if they update, we can have Python 3.12 and Sphinx 7.x. If they don't,
> we get 3.11 and 5.x
> >
> >
> > Why can't we do 3.11 and 7.x, and let freebsd also get sphinx from pypi
> until they update?
>
> Hm, I guess no reason, beyond my recalcitrance on breaking docs on a
> supported build platform unless absolutely necessary. It'd still be my
> preference to align with the native distro repo/ports versions if at
> all possible, but I suppose if FreeBSD doesn't fix itself by June or
> so that we can consider dropping docs support with ports packages at
> that time.
>
> (I think I just have Stockholm Syndrome from arguing for "unnecessary
> version bumps to get shiny new toys" and prefer to let those arguments
> come from my seniors ... so I stick with very safe changes when at all
> possible.)
>

When I asked a week or two ago, the FreeBSD python maintainers were busy
upgrading, but there was too much fallout still going from 3.11 to 3.12,
but they'd hope to work through it soon...   I didn't press them for a more
refined version of 'soon'.

Warner


> >
> > Paolo
> >
> >> . Both are good jumps, but on the chance I can make the bigger jump,
> I'd rather do it in one round instead of two.
> >>
> >>>
> >>> Paolo
> >>>
>
>
>

--000000000000a1851e064b1fcb77
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 18,=
 2026 at 1:42=E2=80=AFPM John Snow &lt;<a href=3D"mailto:jsnow@redhat.com">=
jsnow@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">On Wed, Feb 18, 2026 at 3:26=E2=80=AFPM Paolo Bonzini &lt;<=
a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank">pbonzini@redhat.com=
</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Il mer 18 feb 2026, 18:10 John Snow &lt;<a href=3D"mailto:jsnow@redhat=
.com" target=3D"_blank">jsnow@redhat.com</a>&gt; ha scritto:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On Wed, Feb 18, 2026, 6:48=E2=80=AFAM Paolo Bonzini &lt;<a href=3D=
"mailto:pbonzini@redhat.com" target=3D"_blank">pbonzini@redhat.com</a>&gt; =
wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; With most of the new sticking points being debian 12 =
(EOL in June) or<br>
&gt;&gt;&gt; &gt;&gt; FreeBSD (timeline uncertain for when they&#39;ll re-m=
odernize their python<br>
&gt;&gt;&gt; &gt;&gt; stack)<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; One edge case here, however, is Sphinx, which does no=
t actually have a<br>
&gt;&gt;&gt; &gt;&gt; modern package in centOS stream 9.<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; CentOS currently ships 3.4.3, but it would not be usa=
ble if using the<br>
&gt;&gt;&gt; &gt;&gt; optional 3.12 upgrade. If we ignore this, both FreeBS=
D and Debian 12<br>
&gt;&gt;&gt; &gt;&gt; have sphinx 5.3.0 to offer us, which is a reasonable =
version jump, but<br>
&gt;&gt;&gt; &gt;&gt; it means that CentOS would not be able to build docs =
unless you<br>
&gt;&gt;&gt; &gt;&gt; enabled `--online` for configuring QEMU or sideloaded=
 Sphinx<br>
&gt;&gt;&gt; &gt;&gt; otherwise.<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; CentOS 9 reaches end of life on May 31 next year.=C2=A0 I=
 do not think<br>
&gt;&gt;&gt; &gt; keeping its ability to build bleeding edge docs offline o=
ut of the box<br>
&gt;&gt;&gt; &gt; for its final year (give or take) is worth your time, or =
anybody&#39;s.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; That&#39;s exactly the reason why we (John and I) introduced m=
kvenv.py,<br>
&gt;&gt;&gt; except it was CentOS 8 and SLES 15 at the time<br>
&gt;&gt;&gt; (<a href=3D"https://www.qemu.org/2023/03/24/python/" rel=3D"no=
referrer" target=3D"_blank">https://www.qemu.org/2023/03/24/python/</a>):<b=
r>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &quot;Some of these tools are run through the python3 executab=
le, while<br>
&gt;&gt;&gt; others are invoked directly as sphinx-build or meson, and this=
 can<br>
&gt;&gt;&gt; create inconsistencies. For example, QEMU=E2=80=99s configure =
script checks for<br>
&gt;&gt;&gt; a minimum version of Python and rejects too-old interpreters. =
However,<br>
&gt;&gt;&gt; what would happen if code run by Sphinx used a different versi=
on?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This situation has been largely hypothetical until recently; Q=
EMU=E2=80=99s<br>
&gt;&gt;&gt; Python code is already tested with a wide range of versions of=
 the<br>
&gt;&gt;&gt; interpreter, and it would not be a huge issue if Sphinx used a=
 different<br>
&gt;&gt;&gt; version of Python as long as both of them were supported. This=
 will<br>
&gt;&gt;&gt; change in version 8.1 of QEMU, which will bump the minimum sup=
ported<br>
&gt;&gt;&gt; version of Python from 3.6 to 3.8. While all the distros that =
QEMU<br>
&gt;&gt;&gt; supports have a recent-enough interpreter, the default on RHEL=
8 and<br>
&gt;&gt;&gt; SLES15 is still version 3.6, and that is what all binaries in =
/usr/bin<br>
&gt;&gt;&gt; use unconditionally.&quot;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; So yeah, there&#39;s precedent for doing this, and it&#39;s th=
e right thing to<br>
&gt;&gt;&gt; do anyway.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; My plan:<br>
&gt;&gt;&gt; &gt;&gt; - Wait and see what happens after the current QEMU re=
lease<br>
&gt;&gt;&gt; &gt;&gt; - Gleefully drop Ubuntu 22.04 in April (Allows Python=
 3.11+)<br>
&gt;&gt;&gt; &gt;&gt; - Gleefully drop Debian 12 in June<br>
&gt;&gt;&gt; &gt;&gt; - Hold my breath and see if FreeBSD happens to modern=
ize by this point<br>
&gt;&gt;&gt; &gt;&gt; (They have until October 2027 to do so, so it&#39;s a=
 dice roll if they<br>
&gt;&gt;&gt; &gt;&gt; will or not)<br>
&gt;&gt;&gt; &gt;&gt; - Do a big round of Python modernization all at once;=
 either to 3.11<br>
&gt;&gt;&gt; &gt;&gt; or 3.12 depending, and either to Sphinx 5.x or 7.x de=
pending, pray for<br>
&gt;&gt;&gt; &gt;&gt; forgiveness that I am removing CentOS stream 9&#39;s =
ability to build docs<br>
&gt;&gt;&gt; &gt;&gt; offline so I don&#39;t have to wait another six month=
s and then do another<br>
&gt;&gt;&gt; &gt;&gt; big cleanup round<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The main nice features of 3.12 are improved f-strings, which a=
re nice<br>
&gt;&gt;&gt; but not really a necessity.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; If I read it correctly, <a href=3D"https://www.freshports.org/=
lang/python" rel=3D"noreferrer" target=3D"_blank">https://www.freshports.or=
g/lang/python</a> says it<br>
&gt;&gt;&gt; has 3.9 on PPC and 3.11 elsewhere, but<br>
&gt;&gt;&gt; <a href=3D"https://www.freshports.org/lang/python311" rel=3D"n=
oreferrer" target=3D"_blank">https://www.freshports.org/lang/python311</a> =
says 3.11 exists on PPC as well.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I&#39;d go for 3.11 and Sphinx 7.=C2=A0 For FreeBSD we can req=
uire Python from Ports.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; freebsd ports is currently at 3.11, which is the main reason I am =
saying &quot;see what freebsd does by June&quot;<br>
&gt;&gt;<br>
&gt;&gt; if they update, we can have Python 3.12 and Sphinx 7.x. If they do=
n&#39;t, we get 3.11 and 5.x<br>
&gt;<br>
&gt;<br>
&gt; Why can&#39;t we do 3.11 and 7.x, and let freebsd also get sphinx from=
 pypi until they update?<br>
<br>
Hm, I guess no reason, beyond my recalcitrance on breaking docs on a<br>
supported build platform unless absolutely necessary. It&#39;d still be my<=
br>
preference to align with the native distro repo/ports versions if at<br>
all possible, but I suppose if FreeBSD doesn&#39;t fix itself by June or<br=
>
so that we can consider dropping docs support with ports packages at<br>
that time.<br>
<br>
(I think I just have Stockholm Syndrome from arguing for &quot;unnecessary<=
br>
version bumps to get shiny new toys&quot; and prefer to let those arguments=
<br>
come from my seniors ... so I stick with very safe changes when at all<br>
possible.)<br></blockquote><div><br></div><div>When I asked a week or two a=
go, the FreeBSD python maintainers were busy upgrading, but there was too m=
uch fallout still going from 3.11 to 3.12, but they&#39;d hope to work thro=
ugh it soon...=C2=A0 =C2=A0I didn&#39;t press them for a more refined versi=
on of &#39;soon&#39;.</div><div><br></div><div>Warner</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;<br>
&gt; Paolo<br>
&gt;<br>
&gt;&gt; . Both are good jumps, but on the chance I can make the bigger jum=
p, I&#39;d rather do it in one round instead of two.<br>
&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Paolo<br>
&gt;&gt;&gt;<br>
<br>
<br>
</blockquote></div></div>

--000000000000a1851e064b1fcb77--

