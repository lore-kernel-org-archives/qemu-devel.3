Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FFDE83847
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 00:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs9F4-0002bD-Gr; Mon, 16 Feb 2026 19:47:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vs9F0-0002aY-Sw
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 19:47:03 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vs9Ez-0001kZ-2p
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 19:47:02 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ad20007c73so9549315ad.2
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 16:47:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771289220; cv=none;
 d=google.com; s=arc-20240605;
 b=d83H9GxLsF5BaJlOA4eIYMoD7Gzc4cSlvIDtXHvWFnhZeFqNNuFapLbTGlyzFaapuQ
 Kohx7lI6UVcbPaLQuMQas8G1eeHmRih+LV+1BDMbq56S2xoGxc34fXTo62r+dpzyON6Q
 RHP6UF+jTTtGuSu3DzG7ZRIkdWnPfGNXAWFXia5/Td7PdCyKW4u/k87Vo6XjrR+SwbUR
 eFWQPzO5aEptpStKA3r/ra/LrhgsYuvzl/yxCDfGWhm2GztqfxUYRf1GN/MgBtthYkrq
 H1wjVijKdd9STpyrJuH4C1CLyOxwjmUzabjFxOsogsm7Kbo1UZ8TCl/sAU6LEuVvC/Yh
 lDFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=z5lBDMTciADyjcriuNB9zyyfLOae4aBwDdlgMmq0azs=;
 fh=1CYvNObfo4jq90HtGYf42Wh+iAUT/qO8Wac6PonGhMA=;
 b=E/Vqceog2008I4wZXJAI+l39uYvWqI/Wgw5B8HBByEFlUlMBQcPqP3D3+s1oqsReBZ
 Yc2kAvbUXJhQww6xqgjkrZj9s7+Kkww6z7JBw7NEH0Bl+Z2y42u4dObE37D5BimmQnzK
 qYv+zZlNsD1pCkSLMOBh8W+z+hH60TBloC5lDH4dNkT7Yu1TwIEBZtcMZqaiJ82p2CUX
 MseGC/UOfOSNBqj5B7+qC1ibliwGU1J0R1L2hUt8gwSfYg6p0Etx7HUI9Gj1Hm/xBd8O
 6ZVrTd6ugmTsU9zZQsBvZ4MtlKLSAEmZlrmv3OHlrGsMqEdNor6aYYU3pgCfk504V0+V
 qqEA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771289220; x=1771894020; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z5lBDMTciADyjcriuNB9zyyfLOae4aBwDdlgMmq0azs=;
 b=AXc45QayW5n9Jc7urrY20E3Tt1QXTxA+qu0BFFtEsYUsrKhNncQsqb9oRi19eRskda
 ugSmh/abo/b0c6e+8zKw72EJfeZMFg7e6Uc9p4FjbIpI0x+KcSFusYp2XGv8YV5fYuWC
 jqHcfTEs5twmyw+jljulZbHaXuyx8+YyDqDDb7JU+rkSGVE+jfVHuZwSR7PNW4TTJ0IA
 z8QnDDD1oNoGMfGy/Y21qzz9m42Vgstyq+GMfxDdq1+mWjbe+oDNsT6YLaukVEYsgTsL
 hWrqr9wMs/p3A/7BKSu2KgTC+mvzbAppaGRzYR0aNCeut4lnJRv/vG6shVDIhTWOMAqu
 NNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771289220; x=1771894020;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z5lBDMTciADyjcriuNB9zyyfLOae4aBwDdlgMmq0azs=;
 b=H3YEJNdgzPmF0W8563rbOHTPf3rr+31TLo5j4p1O0uLH6+1Obk3WV7bPY2kz04he7V
 qHUIjqhw4deop/nS9Nw5SmZ0l/jieLoK0AP/+X6lAQOc3WzUEb7bYXiNvFJqcm+IbT0l
 ifAnemoeZIB0njJIV8W2bOomQ9jsiS4/BWm6lvd32FpitVmVoBhNwzSKHhaBM1iOw8uJ
 W2I8JHnPTZrVgu/MyYI8BY8oCA5cDoH8nMVP/aUSYwnj8tuTEowHPztfUmdz0utMPvM9
 id9JFjuHpf4uJCpX5L+k5reyd6iL72lsHieX08lvyC+PmbXtXwFKyLBSclgRAJXXA94F
 q2OA==
X-Gm-Message-State: AOJu0YyIdtmmfXL7pQZEKhm3UE8D1gxBbs63ZLfS1z6RY3XbcE/snPNP
 EQVDVOnO+yrq46VvR9+SbJNAH2jibKds4koGTOZjbRFP++E6IA4jyHSMGlGuT+JmtVBIJM3y8uU
 xIwU6COcSbGpGMnEzV17v8lqXAddrMto=
X-Gm-Gg: AZuq6aLMFYmXJxprXuv5BIS1+rav6EXGZ51mlmaRZb6bI0LmCgErA8hzz98mBPV6U5j
 Efu1tUasOSQn8Pf7rxnPQd0q/PvZIIn6pK1nLhMyTua1NVxs1HTIBcB6WyDiBVkZnZ1xXqyNu2H
 tYlHGKtnu2G57Y00HtM2wvrKbITgMuftt9OBDkHH4NTE7RD+DricmlUTsQ/YCQgDSagky9o3PzW
 j578DUDdDCBOk0MBMAF/68uRviMxQKjsKcZFtL1E+5DyZn5vbFhvQyLOd/gAHlAcJijrvtfF/zZ
 gG+1piiqoXGBNJnyd4AmfRE2+CfxAhwtfpgAReCMVGSA4HsWCw==
X-Received: by 2002:a17:903:1111:b0:2a3:e70d:5817 with SMTP id
 d9443c01a7336-2ad172ba852mr86101205ad.0.1771289219558; Mon, 16 Feb 2026
 16:46:59 -0800 (PST)
MIME-Version: 1.0
References: <20260215220422.212249-1-ltaylorsimpson@gmail.com>
 <20260215220422.212249-3-ltaylorsimpson@gmail.com>
 <aZMy2j7pxhNePNl_@hive.localdomain>
In-Reply-To: <aZMy2j7pxhNePNl_@hive.localdomain>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 16 Feb 2026 17:46:48 -0700
X-Gm-Features: AaiRm51tb13xlwWZHim31qjkN92PtOGmF1pWh75HESPW7WweQ1CmErsizPyHpBY
Message-ID: <CAATN3NqDC_aHmsQ_yu-YkDw2OnjPyoi2_wDHeBWpEecn+pxn3A@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] Hexagon (linux-user/hexagon) Identify Hexagon
 version in ELF file
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, 
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com, 
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org, 
 philmd@linaro.org, ale@rev.ng
Content-Type: multipart/alternative; boundary="000000000000b9f3ca064afa68c6"
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pl1-x635.google.com
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

--000000000000b9f3ca064afa68c6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 8:05=E2=80=AFAM Anton Johansson <anjo@rev.ng> wrote=
:

> On 15/02/26, Taylor Simpson wrote:
> > Return proper Hexagon CPU version from get_elf_cpu_model
> >
> > Co-authored-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> > Co-authored-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> > ---
> >  linux-user/hexagon/elfload.c | 43 ++++++++++++++++++++++--------------
> >  1 file changed, 26 insertions(+), 17 deletions(-)
> >
> > diff --git a/linux-user/hexagon/elfload.c b/linux-user/hexagon/elfload.=
c
> > index d8b545032a..39b0201814 100644
> > --- a/linux-user/hexagon/elfload.c
> > +++ b/linux-user/hexagon/elfload.c
> > @@ -10,23 +10,32 @@ const char *get_elf_cpu_model(uint32_t eflags)
> >      static char buf[32];
> >      int err;
> >
> > -    /* For now, treat anything newer than v5 as a v73 */
> > -    /* FIXME - Disable instructions that are newer than the specified
> arch */
> > -    if (eflags =3D=3D 0x04 ||    /* v5  */
> > -        eflags =3D=3D 0x05 ||    /* v55 */
> > -        eflags =3D=3D 0x60 ||    /* v60 */
> > -        eflags =3D=3D 0x61 ||    /* v61 */
> > -        eflags =3D=3D 0x62 ||    /* v62 */
> > -        eflags =3D=3D 0x65 ||    /* v65 */
> > -        eflags =3D=3D 0x66 ||    /* v66 */
> > -        eflags =3D=3D 0x67 ||    /* v67 */
> > -        eflags =3D=3D 0x8067 ||  /* v67t */
> > -        eflags =3D=3D 0x68 ||    /* v68 */
> > -        eflags =3D=3D 0x69 ||    /* v69 */
> > -        eflags =3D=3D 0x71 ||    /* v71 */
> > -        eflags =3D=3D 0x8071 ||  /* v71t */
> > -        eflags =3D=3D 0x73       /* v73 */
> > -       ) {
> > +    switch (eflags) {
> > +    case 0x04:
> > +        return "v5";
> > +    case 0x05:
> > +        return "v55";
> > +    case 0x60:
> > +        return "v60";
> > +    case 0x61:
> > +        return "v61";
> > +    case 0x62:
> > +        return "v62";
> > +    case 0x65:
> > +        return "v65";
> > +    case 0x66:
> > +        return "v66";
> > +    case 0x67:
> > +    case 0x8067:        /* v67t */
> > +        return "v67";
> > +    case 0x68:
> > +        return "v68";
> > +    case 0x69:
> > +        return "v69";
> > +    case 0x71:
> > +    case 0x8071:        /* v71t */
> > +        return "v71";
> > +    case 0x73:
> >          return "v73";
> >      }
>
> Hmm could we not add v67t/v71t to HexagonVersion and use the enums here?
>
> --
> Anton Johansson
> rev.ng Labs Srl.
>

Brian Cain, please advise.  Aren't the "t" cores just
micorarchitecture differences that aren't modelled in QEMU?

Thanks,
Taylor

--000000000000b9f3ca064afa68c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 16,=
 2026 at 8:05=E2=80=AFAM Anton Johansson &lt;<a href=3D"mailto:anjo@rev.ng"=
>anjo@rev.ng</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">On 15/02/26, Taylor Simpson wrote:<br>
&gt; Return proper Hexagon CPU version from get_elf_cpu_model<br>
&gt; <br>
&gt; Co-authored-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:mathe=
us.bernardino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qu=
alcomm.com</a>&gt;<br>
&gt; Co-authored-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualco=
mm.com" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
&gt; Signed-off-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gma=
il.com" target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 linux-user/hexagon/elfload.c | 43 ++++++++++++++++++++++--------=
------<br>
&gt;=C2=A0 1 file changed, 26 insertions(+), 17 deletions(-)<br>
&gt; <br>
&gt; diff --git a/linux-user/hexagon/elfload.c b/linux-user/hexagon/elfload=
.c<br>
&gt; index d8b545032a..39b0201814 100644<br>
&gt; --- a/linux-user/hexagon/elfload.c<br>
&gt; +++ b/linux-user/hexagon/elfload.c<br>
&gt; @@ -10,23 +10,32 @@ const char *get_elf_cpu_model(uint32_t eflags)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 static char buf[32];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int err;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 /* For now, treat anything newer than v5 as a v73 */<br=
>
&gt; -=C2=A0 =C2=A0 /* FIXME - Disable instructions that are newer than the=
 specified arch */<br>
&gt; -=C2=A0 =C2=A0 if (eflags =3D=3D 0x04 ||=C2=A0 =C2=A0 /* v5=C2=A0 */<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 eflags =3D=3D 0x05 ||=C2=A0 =C2=A0 /* v55=
 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 eflags =3D=3D 0x60 ||=C2=A0 =C2=A0 /* v60=
 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 eflags =3D=3D 0x61 ||=C2=A0 =C2=A0 /* v61=
 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 eflags =3D=3D 0x62 ||=C2=A0 =C2=A0 /* v62=
 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 eflags =3D=3D 0x65 ||=C2=A0 =C2=A0 /* v65=
 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 eflags =3D=3D 0x66 ||=C2=A0 =C2=A0 /* v66=
 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 eflags =3D=3D 0x67 ||=C2=A0 =C2=A0 /* v67=
 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 eflags =3D=3D 0x8067 ||=C2=A0 /* v67t */<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 eflags =3D=3D 0x68 ||=C2=A0 =C2=A0 /* v68=
 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 eflags =3D=3D 0x69 ||=C2=A0 =C2=A0 /* v69=
 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 eflags =3D=3D 0x71 ||=C2=A0 =C2=A0 /* v71=
 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 eflags =3D=3D 0x8071 ||=C2=A0 /* v71t */<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 eflags =3D=3D 0x73=C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* v73 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0) {<br>
&gt; +=C2=A0 =C2=A0 switch (eflags) {<br>
&gt; +=C2=A0 =C2=A0 case 0x04:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;v5&quot;;<br>
&gt; +=C2=A0 =C2=A0 case 0x05:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;v55&quot;;<br>
&gt; +=C2=A0 =C2=A0 case 0x60:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;v60&quot;;<br>
&gt; +=C2=A0 =C2=A0 case 0x61:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;v61&quot;;<br>
&gt; +=C2=A0 =C2=A0 case 0x62:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;v62&quot;;<br>
&gt; +=C2=A0 =C2=A0 case 0x65:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;v65&quot;;<br>
&gt; +=C2=A0 =C2=A0 case 0x66:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;v66&quot;;<br>
&gt; +=C2=A0 =C2=A0 case 0x67:<br>
&gt; +=C2=A0 =C2=A0 case 0x8067:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* v67t */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;v67&quot;;<br>
&gt; +=C2=A0 =C2=A0 case 0x68:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;v68&quot;;<br>
&gt; +=C2=A0 =C2=A0 case 0x69:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;v69&quot;;<br>
&gt; +=C2=A0 =C2=A0 case 0x71:<br>
&gt; +=C2=A0 =C2=A0 case 0x8071:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* v71t */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;v71&quot;;<br>
&gt; +=C2=A0 =C2=A0 case 0x73:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;v73&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
<br>
Hmm could we not add v67t/v71t to HexagonVersion and use the enums here?<br=
>
<br>
-- <br>
Anton Johansson<br>
rev.ng Labs Srl.<br></blockquote><div><br></div><div>Brian Cain, please adv=
ise.=C2=A0 Aren&#39;t the &quot;t&quot; cores just micorarchitecture=C2=A0d=
ifferences that aren&#39;t modelled in QEMU?</div><div><br></div><div>Thank=
s,</div><div>Taylor</div><div><br></div></div></div>

--000000000000b9f3ca064afa68c6--

