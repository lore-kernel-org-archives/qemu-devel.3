Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3750F5A8AA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 19:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEtwS-0008Ov-SM; Mon, 20 Apr 2026 15:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wEtwR-0008Oe-OB
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 15:05:55 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wEtwP-00044L-RS
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 15:05:55 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-82f946efa38so1619568b3a.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 12:05:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776711952; cv=none;
 d=google.com; s=arc-20240605;
 b=A1hJTARQ3NlgYfqViuYKh1654BCB+s5a9FZxLRNvDVAIj8vlJWKilNaerF4nlVT1oi
 LgNHkUp/FCzTXE/sTjSQ86bczpLtS+qPAQkfjRljQo+TeIHA9m20/AOF2hSSqDtBMLhB
 RnP8qfo4iPKpZSdizvxEFn5Bm1XtXbihPVy1AWKM+QnT3Md2mvZwjSoPm1E7FRXaX5LM
 ZVZ8rx1HKZL2m+yc3/mn9G6jwMYIhnkzFE5McFAg4afuAgnGLXzJ5tX+2uQLJltAmais
 F2lbkgVqIbYNdymwzOF8EvzjAfc/NFGgT1cGPN/D+AixbcSffPAV6NK9EATBV5J3XwAW
 Mnhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bs/11m1B/FNeZApXrEX0eUfuMH5e747kNGe6oXSS310=;
 fh=JtM5zhuksVPSy7PfxFil/7v72qjhRS/xvFxFmI18LHU=;
 b=WdZumpY/Wi32lFLnuSpkPYXQ3zVWfzmvHu4SpL5iHwn4e1oKa3/UrAEPo/9c89R3LQ
 npES+Nayrxj7LyC0WpAJTW+o6v/QpoCAtahw9fyLRGUnRCOq7RfONZsFrruPApnTc36u
 K72DAGMmxpHgSRY8tq4eYH6Tdl/LUh+Mplm8A5eGjnDqa30laxnRwV1BdM+igcwfYTjM
 nQjG/y80QrepqqvtCCgL3r06qWGjb2EleaJ4RmGAabJlJwDa7kVJpAgiT1CIbWxp2YLb
 17DN2XcjPbb36cLKsgX28Kp4NP0ib/CN+yo844owZiODuitvbN7wbh8aeWbuJA0sb64B
 PXHA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776711952; x=1777316752; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bs/11m1B/FNeZApXrEX0eUfuMH5e747kNGe6oXSS310=;
 b=fj4AGpFc0GxJufKkOwADj4LWy9lAPnE7GnkLVli6/HxHCeZnCE5BlUvAVuMF1Uho0e
 9zB5tbHmu92A1acecMNO9bSrjqDcZ6qFw1+uzwCQQYMy5pkiNf4DnAbEah/n62lSfevT
 TR5yxmVPixM7nqjKXCB04cznZbe51CWw28pXtby6OPlAniimqKLw+GCS+u+xn5m5FVva
 /px6EhTjjon0vuWA7OBfhIZZQ8Q3rRzKj+MdPE0mILZijKWgB/P4Zd0BX4vPcTkzx9M7
 7drzo1oj0FvlAhSxl7enTGIM+tgbOrbqhlOBs6KOy9eACmOp7Ds1wUcpQXqpvEohFCtd
 Nk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776711952; x=1777316752;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bs/11m1B/FNeZApXrEX0eUfuMH5e747kNGe6oXSS310=;
 b=pv147A98cp8aLNdg4HjI1TvAv699Rsffim78dSXoFesAM8mKbuVeg9B82X1bPtgxC+
 ltA3dVm3sTr5OVTR8rh4CXkjP97D5SggjJy/WlxDBSC3u7MWbch3yDRGqo/GZN1Qa7Y5
 8W8T2KteWFRiByjCOgVBuoowoVJly3p9FLJvd3RWgXo3zfLB3fv3wVdhZl2WVJWztBpU
 AA+UoIkHnqcmLAjreiuMQ+noqxG1QQw2PIH8UnYPAY//6kZhg8jA3uq5Iz9iZ0I05x1Q
 FTIOharMwAtOgGIGzdBypnO9Hk3xzv2y/DJelc8nLrQ92CbSTv/2rqnfTiHbXU4mNBM0
 jPxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9I28vUss2sWVoZDdDVmDQ8EswXuUBIhOdf0mYQBYKEquXGX23U4c+5pcyDPjeSb4jgJdKdJuSscarj@nongnu.org
X-Gm-Message-State: AOJu0YzjJDklv8zrP5kdeOCZ+/SixUVYg8mw9W7SHSeLl5oPL5BLjq+O
 3fKjNxsVsf2/CZovcQG2w53Z7cmILJ1IV5IjI66vj8YiwNPRri/clOuC4Z4/8zpU+Rv+cXmNyaL
 gKZRHlS0kL9Wx74S10d0XuQEJNtNMziQ=
X-Gm-Gg: AeBDievZoGcNbJBUdgdvx+djtcPpBQy55/u1lbDQjiUPHJxp2uk/4HVJ5c5C58+tYTD
 bJFbEY3qPlDngiK7jokBf+pBYoNx6mkfRoAEyvpGM7IvAEfs7aN3RsVuxFucvISigNw3gKuaCKc
 BrKk4xqIiJOv+CRu4GOvKsZN+BehU4Uzyzqbhgke4P7sfUom1BadjpR5hlw99dDqrYFydAPnjQT
 Tzr5sxnd0oxpFEmvxVDv7GH8UVUJjjbatmUASRsuLYpzfSk19ugTve00Fagwt9rq8PWvjzTlQ8S
 2AG7r/ukBPN9bp/CdO98e66fSsF04xNJJxwOTqfTN1iDRFB9sA==
X-Received: by 2002:a05:6a00:1916:b0:82a:6e4b:5b4d with SMTP id
 d2e1a72fcca58-82f8b5295dfmr11507027b3a.23.1776711951389; Mon, 20 Apr 2026
 12:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
 <20260401152657.314902-38-brian.cain@oss.qualcomm.com>
 <ebd8b10e-90d9-4267-b117-9e9a8a564cf5@oss.qualcomm.com>
 <CAEqNhNamfBvyhE4JFp5xDwgB3S6dxN8UnL04-VM2juKoTY2OzQ@mail.gmail.com>
 <67c40737-c5f0-4b4c-afaa-cf466fd7460f@oss.qualcomm.com>
In-Reply-To: <67c40737-c5f0-4b4c-afaa-cf466fd7460f@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 20 Apr 2026 13:05:40 -0600
X-Gm-Features: AQROBzABn11tvOnhEnxa2YtffQkS9ywsBRG3MYXmBJF1GeVubUTVhBYTBvLqWKw
Message-ID: <CAATN3NqhL8-9tH25jvFz5nRAP_MHh1dfAZREn+9uwqFCLDCttw@mail.gmail.com>
Subject: Re: [PATCH v6 37/37] target/hexagon: Add hex_interrupts support
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>, Sid Manning <sidneym@quicinc.com>,
 Michael Lambert <mlambert@quicinc.com>
Content-Type: multipart/alternative; boundary="000000000000bb1882064fe8fcb4"
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000bb1882064fe8fcb4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 12:34=E2=80=AFPM Pierrick Bouvier <
pierrick.bouvier@oss.qualcomm.com> wrote:

> On 4/20/2026 11:12 AM, Brian Cain wrote:
> > On Mon, Apr 20, 2026 at 12:54=E2=80=AFPM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 4/1/2026 8:26 AM, Brian Cain wrote:
> >>> From: Brian Cain <bcain@quicinc.com>
> >>>
> >>> Co-authored-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> >>> Co-authored-by: Sid Manning <sidneym@quicinc.com>
> >>> Co-authored-by: Michael Lambert <mlambert@quicinc.com>
> >>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> >>> ---
> >>>    target/hexagon/cpu.h            |   2 +
> >>>    target/hexagon/hex_interrupts.h |  15 ++
> >>>    target/hexagon/cpu.c            |   4 +
> >>>    target/hexagon/hex_interrupts.c | 379
> ++++++++++++++++++++++++++++++++
> >>>    4 files changed, 400 insertions(+)
> >>>    create mode 100644 target/hexagon/hex_interrupts.h
> >>>    create mode 100644 target/hexagon/hex_interrupts.c
> >>>
> >>> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> >>> index 4e9c65f785a..9ae8e104043 100644
> >>> --- a/target/hexagon/cpu.c
> >>> +++ b/target/hexagon/cpu.c
> >>> @@ -59,6 +59,9 @@ static ObjectClass *hexagon_cpu_class_by_name(const
> char *cpu_model)
> >>>
> >>>    static const Property hexagon_cpu_properties[] =3D {
> >>>    #if !defined(CONFIG_USER_ONLY)
> >>> +    DEFINE_PROP_UINT32("exec-start-addr", HexagonCPU, boot_addr,
> 0xffffffff),
> >>> +    DEFINE_PROP_LINK("global-regs", HexagonCPU, globalregs,
> >>> +        TYPE_HEXAGON_GLOBALREG, HexagonGlobalRegState *),
> >>>        DEFINE_PROP_UINT32("htid", HexagonCPU, htid, 0),
> >>>    #endif
> >> I expect global-regs to always be set, and thus cpu->globalregs to
> >> always be non NULL.
> >> Thus why should be check if it's set in all interrupts related
> functions?
> >
> > I did this for `-machine=3Dnone` test cases.  It may be overkill, but
> > there's definitely *some* target/hexagon/ code that gets executed for
> > those.
> >
>
> I see.
>
> > I'll take a closer look and maybe we can omit these.
> >
>
> In this case, we might simply add a wrapper hex_{read/write}_global_regs
> which has no effect if cpu->globalregs is NULL.
> For the code that still needs to check if globalregs is really
> available, `if (cpu->globalregs)` can still be used.
>

These functions already exist.  I like the idea of putting the null checks
there.

Taylor

--000000000000bb1882064fe8fcb4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 20,=
 2026 at 12:34=E2=80=AFPM Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.b=
ouvier@oss.qualcomm.com">pierrick.bouvier@oss.qualcomm.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 4/20/2026 11:1=
2 AM, Brian Cain wrote:<br>
&gt; On Mon, Apr 20, 2026 at 12:54=E2=80=AFPM Pierrick Bouvier<br>
&gt; &lt;<a href=3D"mailto:pierrick.bouvier@oss.qualcomm.com" target=3D"_bl=
ank">pierrick.bouvier@oss.qualcomm.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On 4/1/2026 8:26 AM, Brian Cain wrote:<br>
&gt;&gt;&gt; From: Brian Cain &lt;<a href=3D"mailto:bcain@quicinc.com" targ=
et=3D"_blank">bcain@quicinc.com</a>&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Co-authored-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsi=
mpson@gmail.com" target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt;<br>
&gt;&gt;&gt; Co-authored-by: Sid Manning &lt;<a href=3D"mailto:sidneym@quic=
inc.com" target=3D"_blank">sidneym@quicinc.com</a>&gt;<br>
&gt;&gt;&gt; Co-authored-by: Michael Lambert &lt;<a href=3D"mailto:mlambert=
@quicinc.com" target=3D"_blank">mlambert@quicinc.com</a>&gt;<br>
&gt;&gt;&gt; Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss=
.qualcomm.com" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 target/hexagon/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 target/hexagon/hex_interrupts.h |=C2=A0 15 ++<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 target/hexagon/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A04 +<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 target/hexagon/hex_interrupts.c | 379 +++++++++++=
+++++++++++++++++++++<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 4 files changed, 400 insertions(+)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 create mode 100644 target/hexagon/hex_interrupts.=
h<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 create mode 100644 target/hexagon/hex_interrupts.=
c<br>
&gt;&gt;&gt;<br>&gt;&gt;&gt; diff --git a/target/hexagon/cpu.c b/target/hex=
agon/cpu.c<br>
&gt;&gt;&gt; index 4e9c65f785a..9ae8e104043 100644<br>
&gt;&gt;&gt; --- a/target/hexagon/cpu.c<br>
&gt;&gt;&gt; +++ b/target/hexagon/cpu.c<br>
&gt;&gt;&gt; @@ -59,6 +59,9 @@ static ObjectClass *hexagon_cpu_class_by_nam=
e(const char *cpu_model)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 static const Property hexagon_cpu_properties[] =
=3D {<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 #if !defined(CONFIG_USER_ONLY)<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;exec-start-addr&quot;,=
 HexagonCPU, boot_addr, 0xffffffff),<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_PROP_LINK(&quot;global-regs&quot;, Hexag=
onCPU, globalregs,<br>
&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_HEXAGON_GLOBALREG, HexagonGl=
obalRegState *),<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 DEFINE_PROP_UINT32(&quot;htid&quot;=
, HexagonCPU, htid, 0),<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 #endif<br>
&gt;&gt; I expect global-regs to always be set, and thus cpu-&gt;globalregs=
 to<br>
&gt;&gt; always be non NULL.<br>
&gt;&gt; Thus why should be check if it&#39;s set in all interrupts related=
 functions?<br>
&gt; <br>
&gt; I did this for `-machine=3Dnone` test cases.=C2=A0 It may be overkill,=
 but<br>
&gt; there&#39;s definitely *some* target/hexagon/ code that gets executed =
for<br>
&gt; those.<br>
&gt;<br>
<br>
I see.<br>
<br>
&gt; I&#39;ll take a closer look and maybe we can omit these.<br>
&gt;<br>
<br>
In this case, we might simply add a wrapper hex_{read/write}_global_regs <b=
r>
which has no effect if cpu-&gt;globalregs is NULL.<br>
For the code that still needs to check if globalregs is really <br>
available, `if (cpu-&gt;globalregs)` can still be used.<br></blockquote><di=
v><br></div><div>These functions already exist.=C2=A0 I like the idea of pu=
tting the null checks there.</div><div><br></div><div>Taylor</div><div>=C2=
=A0</div></div></div>

--000000000000bb1882064fe8fcb4--

