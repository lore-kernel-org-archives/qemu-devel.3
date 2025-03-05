Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC1DC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 15:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpqs1-0002IJ-IM; Wed, 05 Mar 2025 10:41:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpqry-00026J-Qv
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:41:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpqrv-0002f3-SF
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741189269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eyyf8rV/VxBOcLYFclb0Eao9AnUNAIGwQF6bvMhzHM4=;
 b=gr7MmTXpqsgQqt4Wsb54y2E+ZL8/iCz420cMfjqOcanzcTqaknMBSm89G3t9WQK6j1jdzY
 YsrktSSDfj4iMyuGVUVQ5NGB8taBAVH8vYTUeFU3CC8bmWSioGGgriU3sbAc0wrN92VcaP
 rX4WxNwQVk6Sw/rSNwzpTumiaJRe7yE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37--Nb9vmibP82Qlfglz9iC9Q-1; Wed, 05 Mar 2025 10:40:58 -0500
X-MC-Unique: -Nb9vmibP82Qlfglz9iC9Q-1
X-Mimecast-MFC-AGG-ID: -Nb9vmibP82Qlfglz9iC9Q_1741189257
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2fe8de1297eso1981737a91.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 07:40:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741189257; x=1741794057;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Eyyf8rV/VxBOcLYFclb0Eao9AnUNAIGwQF6bvMhzHM4=;
 b=WwErwHBNgxa9m76qD0+vSteX/seNwfSgZ92e/alhLQAmiWkD0dm8E0h8/l9gE7eyYD
 K40EJygN1mFWkBEZGKrGZyHzGFw2RPndlzvTEt5Kqi4ocS2anr3dV846+gV7mKUYYsUC
 Qtmw2JeA3JzLlhFf6Zg/dXUW8/nJIZstoQiNIFBYPeDtw9vxtsKUxysYRYD1Au6ccmDJ
 NEIMkq6bfAZRjj2eiz43hZzpsvrB1gOO0qo/HDcz4MvK9lJ/hXySGcT2k43QJ3tkYLXM
 Fj7VjUmys6ALoKzFv6vuEuk5EZ17aCtyHNQomg1NLeJkanY/SAZkFG0XpreK0mr71ePb
 iGxw==
X-Gm-Message-State: AOJu0YyNYs0UhfWHM7s14xtx4M6896neoqaFurh35GNEnGEP3oZZjYjU
 m8DmXrn6G/kWORbHPybX7LSVmNlX8k24xsL+9dSvhvj5/YSpTXvnqZG0lJWZ9RyehInOBdDciJQ
 /QdlWwVdcGK3Rbb8AdLJ9sP6uUWyLEJ01fBsfeTaK3CRHvYVNIeNO4R5rfSm2ImWSu5ygM6m2yF
 ytycSEoCrOXNivGdn5onM5bmj2ZtA=
X-Gm-Gg: ASbGnctKLguj4kCUzxGzBjA2obVTx67GnhSZuKZbVdIB/L5clo3VyFdStAkD0DxDms7
 oj13MkgfYYaeoVYBWzciqOYXzQ5rIIWbkoLJtv+KBFM0rDM5+OIHbgEGeWgHr8DCXo18GPRyb/o
 lY5vPI9ZN02hsSyDTc4s0zS5bUBrU6
X-Received: by 2002:a17:90b:2514:b0:2ff:556f:bf9 with SMTP id
 98e67ed59e1d1-2ff556f0c91mr2262535a91.4.1741189257073; 
 Wed, 05 Mar 2025 07:40:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IET1yb/7AaMPYK9R6pij7s7ZnCy96u/dftcIpda2B7Z9gQ1zMv3sTKn7hzop6lWcGd60BVIUq2iNXA5e3xlSDo=
X-Received: by 2002:a17:90b:2514:b0:2ff:556f:bf9 with SMTP id
 98e67ed59e1d1-2ff556f0c91mr2262518a91.4.1741189256788; Wed, 05 Mar 2025
 07:40:56 -0800 (PST)
MIME-Version: 1.0
References: <20250305034610.960147-1-jsnow@redhat.com>
 <87jz93n281.fsf@pond.sub.org>
In-Reply-To: <87jz93n281.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 5 Mar 2025 10:40:44 -0500
X-Gm-Features: AQ5f1JpxpzXOGbdTgs8r-H7uXkVmEDNBRE9gEdVagC_y_1gSCkgzdflZTc0oFEs
Message-ID: <CAFn=p-bjRSAX=76uvowX=qUBgpRL8EoWEwLwLTjL+2MxcYWOOw@mail.gmail.com>
Subject: Re: [PATCH 00/57] docs: Add new QAPI transmogrifier
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002355e4062f9a3764"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000002355e4062f9a3764
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025, 6:31=E2=80=AFAM Markus Armbruster <armbru@redhat.com> =
wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Hi! This series is based on armbru/pull-qapi-2025-02-26.
> >
> > This series is a "minimum viable" version of the new QAPI documentation
> > system. It does the bare minimum under the new framework, saving nice
> > features for later.
>
> Not saved for later: a massive improvement of the generated
> documentation's looks and usability.  Moreover, I hope the new generator
> will be easier to maintain than the old one, because its inner workings
> are closer to how Sphinx expects such things to work.  Fair?
>

I hope so too, though some of the sphinx version compatibility hacks are
possibly fairly porcelain. The most egregious of them are for versions
prior to Sphinx 4.1.

Almost all of the compatibility hacks are factored into compat.py and they
are all documented with what versions they're there for. Most of the
ugliest is pre-4.1.


> >
> > Patches 3-29 implement the qapi_domain extension.
> > Patches 30-57 implement the qapidoc "Transmogrifier".
> >
> > This series is still "RFC" quality, though it's quite nearly actually
> > ready for inclusion. The "add transmogrifier test document" patch is no=
t
> > intended for actual merge, it's just there to demonstrate the new
> > document generator by producing output in docs/manual/qapi/index.html.
> >
> > Known shortcomings in this series:
> >
> > - Still no new QAPI unit tests. I'll add those for next go-around.
>
> Not a blocker as far as I'm concerned, because I feel you're unlikely to
> run away from this :)
>

=F0=9F=98=85


> > - No new documentation. Also for next revision. I'll document the QAPI
> >   domain syntax and give a brief overview of how the transmogrifier
> >   functions, and a quick rundown of any new rST syntax that may be
> >   pertinent to QAPI documentation writers.
>
> Likewise.
>
> > - IFCOND information is still rendered in two places, we'll need to
> >   decide where and how we want to render it.
>
> I'll have a look, and then we'll talk.
>
> > - No QAPI namespace support ... yet. So we can't enable it for QMP, QGA
> >   and QSD simultaneously just yet. I don't think it will be difficult.
> >
> > Unknown shortcomings in this series:
> >
> > - ???
>
> I'll try to find some, but I'm not overly optimistic ;)
>

Missing documentation for undocumented members. You found one! :)


> > New stuff overall from the last iteration of this series:
> >
> > - @foo is processed into ``foo`
> > - "The members of ..." messages have been temporarily re-added until we
> >   can smooth over the inliner.
> > - This series runs under Sphinx 3.4.3 to Sphinx 8.2.0 inclusive. It
> >   truly is a Christmas miracle. (please clap)
>
> *clap* clap* clap*
>
> This is waaaay harder than it has any right to be.
>
> > - This series now fully type checks and lint checks under Sphinx 8.2.0,
> >   but may not type check under earlier Sphinx versions. Achieving this
> >   alone, nevermind in conjunction with the above, was a literal
> >   herculean labor.
>
> scripts/qapi/ remains clean for me.  docs/sphinx/ improves from no type
> checking to type checking with a version newer than the one I have on my
> development box right now, which I count as an improvement.
>
> > I really must stress again how frustratingly difficult it was to achiev=
e
> > the prior two bullet points. I *do* in fact want a cookie and/or an
> > award ribbon.
>
> We owe you an entire layer cake, with a marzipan figurine of your
> conquering self on top.  Seriously, I could not have done this.
>

It's the stuff in compat.py that was the absolute hardest. You need that
stuff for this to work on the version ranges it works for, but typing it
was an extra special torture.

>

--0000000000002355e4062f9a3764
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 5, 2025, 6:31=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Hi! This series is based on armbru/pull-qapi-2025-02-26.<br>
&gt;<br>
&gt; This series is a &quot;minimum viable&quot; version of the new QAPI do=
cumentation<br>
&gt; system. It does the bare minimum under the new framework, saving nice<=
br>
&gt; features for later.<br>
<br>
Not saved for later: a massive improvement of the generated<br>
documentation&#39;s looks and usability.=C2=A0 Moreover, I hope the new gen=
erator<br>
will be easier to maintain than the old one, because its inner workings<br>
are closer to how Sphinx expects such things to work.=C2=A0 Fair?<br></bloc=
kquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I hope so =
too, though some of the sphinx version compatibility hacks are possibly fai=
rly porcelain. The most egregious of them are for versions prior to Sphinx =
4.1.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Almost all of the c=
ompatibility hacks are factored into compat.py and they are all documented =
with what versions they&#39;re there for. Most of the ugliest is pre-4.1.</=
div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote=
 gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;<br>
&gt; Patches 3-29 implement the qapi_domain extension.<br>
&gt; Patches 30-57 implement the qapidoc &quot;Transmogrifier&quot;.<br>
&gt;<br>
&gt; This series is still &quot;RFC&quot; quality, though it&#39;s quite ne=
arly actually<br>
&gt; ready for inclusion. The &quot;add transmogrifier test document&quot; =
patch is not<br>
&gt; intended for actual merge, it&#39;s just there to demonstrate the new<=
br>
&gt; document generator by producing output in docs/manual/qapi/index.html.=
<br>
&gt;<br>
&gt; Known shortcomings in this series:<br>
&gt;<br>
&gt; - Still no new QAPI unit tests. I&#39;ll add those for next go-around.=
<br>
<br>
Not a blocker as far as I&#39;m concerned, because I feel you&#39;re unlike=
ly to<br>
run away from this :)<br></blockquote></div></div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">=F0=9F=98=85</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">
<br>
&gt; - No new documentation. Also for next revision. I&#39;ll document the =
QAPI<br>
&gt;=C2=A0 =C2=A0domain syntax and give a brief overview of how the transmo=
grifier<br>
&gt;=C2=A0 =C2=A0functions, and a quick rundown of any new rST syntax that =
may be<br>
&gt;=C2=A0 =C2=A0pertinent to QAPI documentation writers.<br>
<br>
Likewise.<br>
<br>
&gt; - IFCOND information is still rendered in two places, we&#39;ll need t=
o<br>
&gt;=C2=A0 =C2=A0decide where and how we want to render it.<br>
<br>
I&#39;ll have a look, and then we&#39;ll talk.<br>
<br>
&gt; - No QAPI namespace support ... yet. So we can&#39;t enable it for QMP=
, QGA<br>
&gt;=C2=A0 =C2=A0and QSD simultaneously just yet. I don&#39;t think it will=
 be difficult.<br>
&gt;<br>
&gt; Unknown shortcomings in this series:<br>
&gt;<br>
&gt; - ???<br>
<br>
I&#39;ll try to find some, but I&#39;m not overly optimistic ;)<br></blockq=
uote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Missing docu=
mentation for undocumented members. You found one! :)</div><div dir=3D"auto=
"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_contain=
er"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">
<br>
&gt; New stuff overall from the last iteration of this series:<br>
&gt;<br>
&gt; - @foo is processed into ``foo`<br>
&gt; - &quot;The members of ...&quot; messages have been temporarily re-add=
ed until we<br>
&gt;=C2=A0 =C2=A0can smooth over the inliner.<br>
&gt; - This series runs under Sphinx 3.4.3 to Sphinx 8.2.0 inclusive. It<br=
>
&gt;=C2=A0 =C2=A0truly is a Christmas miracle. (please clap)<br>
<br>
*clap* clap* clap*<br>
<br>
This is waaaay harder than it has any right to be.<br>
<br>
&gt; - This series now fully type checks and lint checks under Sphinx 8.2.0=
,<br>
&gt;=C2=A0 =C2=A0but may not type check under earlier Sphinx versions. Achi=
eving this<br>
&gt;=C2=A0 =C2=A0alone, nevermind in conjunction with the above, was a lite=
ral<br>
&gt;=C2=A0 =C2=A0herculean labor.<br>
<br>
scripts/qapi/ remains clean for me.=C2=A0 docs/sphinx/ improves from no typ=
e<br>
checking to type checking with a version newer than the one I have on my<br=
>
development box right now, which I count as an improvement.<br>
<br>
&gt; I really must stress again how frustratingly difficult it was to achie=
ve<br>
&gt; the prior two bullet points. I *do* in fact want a cookie and/or an<br=
>
&gt; award ribbon.<br>
<br>
We owe you an entire layer cake, with a marzipan figurine of your<br>
conquering self on top.=C2=A0 Seriously, I could not have done this.<br></b=
lockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">It&#39;=
s the stuff in compat.py that was the absolute hardest. You need that stuff=
 for this to work on the version ranges it works for, but typing it was an =
extra special torture.</div><div dir=3D"auto"><div class=3D"gmail_quote gma=
il_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--0000000000002355e4062f9a3764--


