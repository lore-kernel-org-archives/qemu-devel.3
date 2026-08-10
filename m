Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE00FC5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 20:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtWzj-0005GM-RK; Mon, 10 Aug 2026 16:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wtWzi-0005G9-U7
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 16:53:14 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wtWzh-0003NA-7N
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 16:53:14 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2cf50c6f235so1751455ad.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 13:53:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786395191; cv=none;
 d=google.com; s=arc-20260327;
 b=lV24V04TAYY5K7Yu6sakkSg92JRXRCIZNMqL9Ea0wST+ymi9nkwp0kIZ3T07McDRZf
 vYQkyLuLqplkNRIcRsVG0v4cXJKBZm4bJgeiRNoIHL5ypCJ4nem/WnORBo3aTNebHZir
 sYsfoGFDFrtSY933smBUG4tSxtmw5QQurFJKqsk7Q/uJSVOiy1YlmU+Vc2U0+/qmr405
 sOnjKS1u5zs1oYicKeZQYsIHRMEUwiOzBGVmp5FaoCdTyVjKGm+iFtW5aGQl2GftT+KC
 Y7ebff47W/0pP/gqoV803eHGY9zEjsO2KBFpm/2tPdlkn1vnIF2TKlr1IV5ATbk3ZPav
 TCcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7CbD++GQdW4Dgp/saTJcJk8ah6NvdNd1bQkPIkcov20=;
 fh=Tv1hKPs+cXWynI23hL3wQd3MOt1ixTT8ANGq27q0/yE=;
 b=AMY1um3AVbDGtWQqyS+Rth25sRRGQxEBemhQHbhFffwD1nHarJwZ0X/9ClkqkDZ+Ql
 2gHhi4qJNipztjYqZjPlwIiAPw6zWQMrvHS5sz5KySVufvm1414hDZ3wGHb9GeU+06Fa
 7Jfq+PAzCKLpO43XVMjATTCeRcNoiaU4KRBEffqzpZ+8SGOPo0Y7UMEkvSvVRa3iMZoS
 k+TSw+x8992+qKSNb7MKpa1HyfubT4cVk6kUJk9aizX+ZiNgP3QWpGNYRr0LGO0pWMZ5
 cHrq6g1NRmeutIvTSlUWSDh3OGta5lCHKDfZ96SAgm8/5Pyrr5/U+CZCkfFA/t2doWQd
 Yr6g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786395191; x=1786999991; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7CbD++GQdW4Dgp/saTJcJk8ah6NvdNd1bQkPIkcov20=;
 b=pwIWDuVjd95dvEwzVNR2628pAFRgyUtltlj127HRMpoPR1ZtpK4f96wDihCILn9BIi
 Y+dEUf41YaiulwKB0Idkk9AiWmmxmh/NO9SNc42QABvX8mEdoQWoMMJH8mtE4T5/gBaO
 KEnRX8oQrS0taT716pt4wYnJVOpoMNdGlN6lKgfBPwtw1xr62TPPCIq7TUw9uCIUDLTt
 XstfgD8+ZP5czMBHlylOl/+GxRCKs50DpaTHptaREuYEixcO+dqgbLIsVSx196rsBjKE
 vcR+Oxq4l5yV+dngcRobNDP9nOU9DgjCxa5WwKo3SDXZbLfjWs3fQL/DtmI03+5BJWC3
 BqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786395191; x=1786999991;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7CbD++GQdW4Dgp/saTJcJk8ah6NvdNd1bQkPIkcov20=;
 b=cZ2Im1D9zsWrTzJ9rfpSBQHz+UvMuvBA8OJiS3dFwHUl7Q8k6mATU/epheT+rPHT4A
 wcjNR0xvJixB3/DDhwhTCcRz+ZDr6I6rSJyXJPWdOJkhoguLX6rIFT9GSwKxiGk3K7vb
 I+iALwkh7WKkvgdzmiZYomkrFiDPEIc4olCXYo7gpJONhnrgfh9HNa9z7WVnRbV0WMt5
 3IxOB9KX5Zw/cQtVspMO79LbS5zQ1Mtt/7+ia/JHApgZGPmIeb3/HxQaFrRaI4g4E7pL
 rLS936c+kJr7kFaNrq7SLDg17KeaVTcGNYrseqbKkCoCkflfQZDkxSWdOb9rcyfe2fZT
 YlDg==
X-Gm-Message-State: AOJu0YxjWHUkk/I6ldMGf5O18+OwKuIg/QlSppIhGfc3Lk3thYYH+xIp
 mndmew39ZBL7wjO48qQHiOSSejwKKqwrz3lk0XxLx+nmQiEfibHt3zYpcDjHlfp0IYegp6UrQut
 ffME36giBFV80zkMO/qQyPJKvK1rrIiM=
X-Gm-Gg: AR+sD11QdXcZrb/e2RufWZ8vW/ruOe6Mxk+Lbm3Ogm9zveOdaEmVHrS2rGyxymaqi1Q
 F0ucsZoreNGdAO5q3vlr3tYJYJD4qbZiqRp3L2Hg4ndMm9p7ZANPKdYK/3w5w3/AUPoZ+HsdiH/
 DRIoGuyzKdpjkQmM7n+F96jRh1rxGPYvbmsd0GmKhk3iuB++1geHU28nmBrYfappUfUD+eVIujs
 RTPMoKUfOPVvVj2KnVX3apSKdWdjZ2MmJ4H+kZi76dOmqAbjjtodQMeypqA5X/yhY4TW+VC74V+
 zHpD+NNaewmS2uZM+8IUvr+R+WMVYU2kzWrjTUnEpPXQZhtynR4BbUSxrllF25Sd/oOvthmKMzv
 g
X-Received: by 2002:a17:903:388c:b0:2cf:4339:aaa with SMTP id
 d9443c01a7336-2d0ca7fbb6bmr559001935ad.12.1786395191496; Mon, 10 Aug 2026
 13:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260810182804.27310-1-ltaylorsimpson@gmail.com>
 <57bf1075-cf49-4ccd-8893-94d32d4be313@oss.qualcomm.com>
In-Reply-To: <57bf1075-cf49-4ccd-8893-94d32d4be313@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 10 Aug 2026 14:53:00 -0600
X-Gm-Features: AUfX_mzSYln5fXqCH9hzFl-K4C3NPGfwQlkCMvbVh1lhZjPFpRngmEnyEAl1Zsw
Message-ID: <CAATN3NoX9jxBv4mjXwRxJ3puooZFEJrE5_LnoPMabnX=WwD0sg@mail.gmail.com>
Subject: Re: [PATCH] Hexagon (target/hexagon) Clean up disassembly of control
 and system regs
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com, 
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng
Content-Type: multipart/alternative; boundary="000000000000d155830658b78a7a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pl1-x62b.google.com
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

--000000000000d155830658b78a7a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 1:34=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

>
> On 8/10/2026 1:28 PM, Taylor Simpson wrote:
> > Change disassembly of control regs from C{num}/{name} to {name}
> > Change disassembly of system regs from S{num}/r{num} to {name}
> >
> > Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> > ---
> >   target/hexagon/printinsn.c      | 22 ++++++++++++++++++----
> >   target/hexagon/gen_printinsn.py | 14 ++++++++------
> >   2 files changed, 26 insertions(+), 10 deletions(-)
> >
> > diff --git a/target/hexagon/printinsn.c b/target/hexagon/printinsn.c
> > index a7e46f4bcd..b55d3b0b35 100644
> > --- a/target/hexagon/printinsn.c
> > +++ b/target/hexagon/printinsn.c
> > @@ -23,18 +23,32 @@
> >   #include "internal.h"
> >   #include "decode.h"
> >
> > +static char regstr[10];
> > +
> >   static const char *sreg2str(unsigned int reg)
> >   {
> > -    if (reg < TOTAL_PER_THREAD_REGS) {
> > -        return hexagon_regnames[reg];
> > +#ifndef CONFIG_USER_ONLY
> > +    if (reg < NUM_SREGS) {
> > +        return hexagon_sregnames[reg];
> >       } else {
> > -        return "???";
> > +        snprintf(regstr, sizeof(regstr), "S%d", reg);
> > +        return regstr;
> >       }
> > +#else
> > +    snprintf(regstr, sizeof(regstr), "S%d", reg);
> > +    return regstr;
> > +#endif
> >   }
> >
> >   static const char *creg2str(unsigned int reg)
> >   {
> > -    return sreg2str(reg + HEX_REG_SA0);
> > +    unsigned int gpr =3D reg + HEX_REG_SA0;
> > +    if (gpr < TOTAL_PER_THREAD_REGS) {
> > +        return hexagon_regnames[gpr];
> > +    } else {
> > +        snprintf(regstr, sizeof(regstr), "C%d", reg);
> > +        return regstr;
> > +    }
> >   }
> >
>
>
> Seems like this change also depends on some kind of mutex around
> regstr[] so that we know it's not being used concurrently by multiple
> threads.  Translation is single-threaded but if we gained another caller
> we wouldn't remember to come back and remediate this.
>
> I suppose we could take an input buffer/length.  Or maybe we just add
> another static _regnames[] array to solve the lifetime/race problems?
>
>
How about putting a regstr field in the Insn struct (and pass Insn* to
these two functions)?

Thanks,
Taylor

--000000000000d155830658b78a7a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 10,=
 2026 at 1:34=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex"><br>
On 8/10/2026 1:28 PM, Taylor Simpson wrote:<br>
&gt; Change disassembly of control regs from C{num}/{name} to {name}<br>
&gt; Change disassembly of system regs from S{num}/r{num} to {name}<br>
&gt;<br>
&gt; Signed-off-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gma=
il.com" target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/hexagon/printinsn.c=C2=A0 =C2=A0 =C2=A0 | 22 ++++++=
++++++++++++----<br>
&gt;=C2=A0 =C2=A0target/hexagon/gen_printinsn.py | 14 ++++++++------<br>
&gt;=C2=A0 =C2=A02 files changed, 26 insertions(+), 10 deletions(-)<br>
&gt;<br>
&gt; diff --git a/target/hexagon/printinsn.c b/target/hexagon/printinsn.c<b=
r>
&gt; index a7e46f4bcd..b55d3b0b35 100644<br>
&gt; --- a/target/hexagon/printinsn.c<br>
&gt; +++ b/target/hexagon/printinsn.c<br>
&gt; @@ -23,18 +23,32 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;internal.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;decode.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static char regstr[10];<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static const char *sreg2str(unsigned int reg)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 if (reg &lt; TOTAL_PER_THREAD_REGS) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return hexagon_regnames[reg];<br>
&gt; +#ifndef CONFIG_USER_ONLY<br>
&gt; +=C2=A0 =C2=A0 if (reg &lt; NUM_SREGS) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return hexagon_sregnames[reg];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;???&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(regstr, sizeof(regstr), &quot;S%=
d&quot;, reg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return regstr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +#else<br>
&gt; +=C2=A0 =C2=A0 snprintf(regstr, sizeof(regstr), &quot;S%d&quot;, reg);=
<br>
&gt; +=C2=A0 =C2=A0 return regstr;<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static const char *creg2str(unsigned int reg)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 return sreg2str(reg + HEX_REG_SA0);<br>
&gt; +=C2=A0 =C2=A0 unsigned int gpr =3D reg + HEX_REG_SA0;<br>
&gt; +=C2=A0 =C2=A0 if (gpr &lt; TOTAL_PER_THREAD_REGS) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return hexagon_regnames[gpr];<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(regstr, sizeof(regstr), &quot;C%=
d&quot;, reg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return regstr;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
<br>
<br>
Seems like this change also depends on some kind of mutex around <br>
regstr[] so that we know it&#39;s not being used concurrently by multiple <=
br>
threads.=C2=A0 Translation is single-threaded but if we gained another call=
er <br>
we wouldn&#39;t remember to come back and remediate this.<br>
<br>
I suppose we could take an input buffer/length.=C2=A0 Or maybe we just add =
<br>
another static _regnames[] array to solve the lifetime/race problems?<br><b=
r></blockquote><div><br></div><div>How about putting a=C2=A0regstr=C2=A0fie=
ld in the Insn struct (and pass Insn* to these two functions)?</div><div><b=
r></div><div>Thanks,</div><div>Taylor</div><div><br></div></div></div>

--000000000000d155830658b78a7a--

