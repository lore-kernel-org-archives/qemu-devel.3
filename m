Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86ED2C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 17:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiba3-00024z-F1; Sat, 11 Jul 2026 13:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harsh.prateek.bora@gmail.com>)
 id 1wiba1-00024B-0a
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 13:33:33 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <harsh.prateek.bora@gmail.com>)
 id 1wibZz-0006q5-6l
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 13:33:32 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c15e2dab83eso272538866b.1
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2026 10:33:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783791209; cv=none;
 d=google.com; s=arc-20260327;
 b=QyLktwCKVH1NrVzDmLop4d48PRrobKcQxjG0Xk6uUd1T90uvq8f9MCvfeM7EMaNR4Q
 ZSaTwUtKOR0O/Pw9VPt/orO9oAU90hvWfQZZ/ix2wvfIv6o/8mQo/cV+TzzpFe9vy89+
 IpTt/1/A+dl8Zf0BFC1/MrwfIsmdung+wSbYDT+mDPkdMYib2dO+eL2+y0OKPsxallsj
 l0S3tsiokSUrZm70vOAMpkGbTNHa7obXBj5YvaVDVaaRjZQ8ertIJlLqiExsrOvi294c
 WTq7eaV394n/SlBNqDe7TtvYmoJf55IETrMQn6D0myrjBwP2oS2etanJW5H57Pty1+Ys
 ZmEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JS3CKX8TG+RSRMmVQSeQiQae+JhkZskL580Opidbw14=;
 fh=ZJ1VvLnMvAqWxrEqPCK1ID0Kyo2AFjApb30uZRj6pHI=;
 b=lOmnjZC+rPkDEU+Ytr20vnc7GUMPXq2/lKaNWus4KLSvCSzqAZLIWvtSDFOOmZ4tR8
 MxuFdW/+cRq7wmkVnTQObrO2ruJfpDRxz+PcAei0Kf13r1M0VhzoW0H/0CVBO9yL02NH
 16ILPCY/17eL6HwFIUQgLsfQ6vetO7Ruxp0XEgDlbEgqATRzXQwq3FQTQSfCE0+HZs6P
 6p1kM1Csws95rjyNffdxme0maOqyMkz8qVim3Mm612VrDURk3kl3d86G2q3fZVIvD1Pe
 E9o1XaXjgq8ztsi8EvJ2dHt1OchQMqbDU+Y6t1QrSTSElu4GNXxQ+KSxP3YV44QMP2Sa
 E5Rg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783791209; x=1784396009; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JS3CKX8TG+RSRMmVQSeQiQae+JhkZskL580Opidbw14=;
 b=PfyttqIZZu4uE8H32/oQG0aGMYPw5ciICHh2CEtbNUD+jNihu80AyZ8r3Fr3ZZDU3y
 Z4Y3c3Aqp8/4AZdjadoPwHL7Xr3ZllwK1NR9ujrez+9ZQfDVbiF9FWGsHcktOiATkyss
 bvoOmydoT1uAKxiMNFYZ6vtmt6X6w5WRmZjzs+NA1LOC7v/RAnY5OcJ4yinh3c9Fogc5
 l3+xuHgEDBQadL5vSbFEVQiTKZDrpjubR58bVdiVaq6geycGq6szY2XqT2eXiRCqvaO0
 yAEccZki10A5cowQR8Sble4VEwHhSacyaxxFbwXr/k7s872G62/h+NHPj0P9+AkwwpIk
 jnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783791209; x=1784396009;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JS3CKX8TG+RSRMmVQSeQiQae+JhkZskL580Opidbw14=;
 b=pINFSfiV6uD4XrQOsrVQfc8fZrI8ptCkd2IlL6Q68a1s8iO+UyvI4cFzp404Txm5qG
 47u6I/9Duyj3BqEOGWFZT0BG0w8wIse3yuOwEiWJ2gdW+LvPa7tJlF82QwYsPODnxJfq
 e6GS6K42/seL31xBqd8g0ajZH6HwCbg+31EyymaEitiXjDO9nHCkx2p+7QqDaaQMrL91
 HB69eDP1jE3JwOdtee+eYWTai1faAu2ZK8KxC8Nnfp5VSUQiyyjkPkgasA6d982fEryl
 rMuUDT6EwZ+3xEU2M8DGv5L9RXmWcC2syYX4OU6myDofXL8DDjBf0ZXP9YOP40r/6qR8
 dlIg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rru8pCQzy3SNIXzrlGdr9fktGTmyjq1CpFCaShztUdnN+Djo4/jn0jynYZ0v6Mkoo/Wm50XhDwVwp1u@nongnu.org
X-Gm-Message-State: AOJu0YxGg/V6PDErrpU/t2mFRolX20vTHJORq40M1mkROGpuU6nWScSt
 ks0CSWfHf4dew4n6IJ06yY1/9yYU621GzH+xlEQB8TwAHbzcCsXhOWk1f+ijR231+S0iSDeq6Ri
 nMXuC1VbiAi8d265DyYrV1e6foM8DwkY=
X-Gm-Gg: AfdE7cldZQ10cdPtD/FH1+p2TIlbYv5hHQdCr21Sxkir9rW3hD+dSqTAKc/xWxnYIZb
 zF1zIKdXxzoRpqzOUHEzJ5SoWhAW6c2tjdLmGrhv6v+juSH9kkvJIx5B7R+ccrApCewGKn4T6Dp
 0VHOYu1yz7z69bRyAdgPQq2kMq7T/57IP1M0NnbbnZuHx5pcle1G6EzSf3l2T1iUzLi6G4OpZus
 gnilzMqSmXIIBrrjjwwv3Sr/7qy6SQT6VXy0zgUWWFKiWty0ByQat7QU7YAcA/11kzxX4EU
X-Received: by 2002:a17:907:9d1a:b0:c16:2d90:68d9 with SMTP id
 a640c23a62f3a-c162d9081fcmr73653366b.56.1783791209022; Sat, 11 Jul 2026
 10:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-34-richard.henderson@linaro.org>
 <bf1b73da-919c-4b02-8b46-78b939077610@linux.ibm.com>
 <8e9907db-68b6-4644-9c16-6fbbbcd52b0b@linaro.org>
In-Reply-To: <8e9907db-68b6-4644-9c16-6fbbbcd52b0b@linaro.org>
From: Harsh Prateek Bora <harsh.prateek.bora@gmail.com>
Date: Sat, 11 Jul 2026 23:03:15 +0530
X-Gm-Features: AVVi8CeoQLoGHON4QB-S6VQPELhcoguijpSA5B6ecc8ZnZl6xcpSNSKFTTO4taY
Message-ID: <CAEuJdmptUafKhzTaRu1j07cyh5eD_vxbMrqyHO7GwWQ=ZRNT8Q@mail.gmail.com>
Subject: Re: [PATCH v3 33/51] target/ppc: Simplify
 ppc_cpu_debug_check_watchpoint
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org, 
 Shivaprasad G Bhat <sbhat@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, jcmvbkbc@gmail.com, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: multipart/alternative; boundary="0000000000005e089b065659418e"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=harsh.prateek.bora@gmail.com; helo=mail-ej1-x632.google.com
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

--0000000000005e089b065659418e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 11 Jul, 2026, 10:22=E2=80=AFpm Richard Henderson, <
richard.henderson@linaro.org> wrote:

> On 7/11/26 03:54, Harsh Prateek Bora wrote:
> > + Cedric, Shiva
> >
> > On 11/07/26 2:23 am, Richard Henderson wrote:
> >> We don't need to check either ISA bit, because that's already
> >> done starting with SPR registration.  Replace target_ulong with
> >> uint64_t, as we're under TARGET_PPC64.
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >>   target/ppc/tcg-excp_helper.c | 30 +++++++++---------------------
> >>   1 file changed, 9 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper=
.c
> >> index 99ffe4a820..4065440949 100644
> >> --- a/target/ppc/tcg-excp_helper.c
> >> +++ b/target/ppc/tcg-excp_helper.c
> >> @@ -353,35 +353,23 @@ bool ppc_cpu_debug_check_watchpoint(CPUState *cs=
,
> CPUBreakpoint *wp)
> >>   {
> >>   #if defined(TARGET_PPC64)
> >>       CPUPPCState *env =3D cpu_env(cs);
> >> -    bool wt, wti, hv, sv, pr;
> >> -    uint32_t dawrx;
> >> +    uint32_t dawrx =3D env->spr[wp->id ? SPR_DAWRX1 : SPR_DAWRX0];
> >> +    bool wt =3D extract32(dawrx, PPC_BIT_NR(59), 1);
> >> +    bool wti =3D extract32(dawrx, PPC_BIT_NR(60), 1);
> >> +    bool hv =3D extract32(dawrx, PPC_BIT_NR(61), 1);
> >> +    bool sv =3D extract32(dawrx, PPC_BIT_NR(62), 1);
> >> +    bool pr =3D extract32(dawrx, PPC_BIT_NR(62), 1);
> >> -    if ((env->insns_flags2 & PPC2_ISA207S) &&
> >> -        (wp =3D=3D env->dawr_watchpoint[0])) {
> >> -        dawrx =3D env->spr[SPR_DAWRX0];
> >> -    } else if ((env->insns_flags2 & PPC2_ISA310) &&
> >> -               (wp =3D=3D env->dawr_watchpoint[1])) {
> >> -        dawrx =3D env->spr[SPR_DAWRX1];
> >> -    } else {
> >
> > Previously, there were different ISA version checks resulting in
> different behaviour, now
> > with this change we are allowing for both ISA versions. Not sure if thi=
s
> would be an
> > expected behaviour?
>
> Per the commit comment, the ISA version checks are done when registering
> the system
> register.  One cannot write to DAWRX1 unless ISA310, and therefore
> dawr_watchpoint[1] will
> not be set nor wp->id be 1.
>

Thanks for confirming, Richard!

Regards
Harsh

>
>
> r~
>
>

--0000000000005e089b065659418e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, 11 Jul, 2026, 10:22=E2=
=80=AFpm Richard Henderson, &lt;<a href=3D"mailto:richard.henderson@linaro.=
org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On 7/11/26 03:54, Harsh Prateek Bora wrote:<br>
&gt; + Cedric, Shiva<br>
&gt; <br>
&gt; On 11/07/26 2:23 am, Richard Henderson wrote:<br>
&gt;&gt; We don&#39;t need to check either ISA bit, because that&#39;s alre=
ady<br>
&gt;&gt; done starting with SPR registration.=C2=A0 Replace target_ulong wi=
th<br>
&gt;&gt; uint64_t, as we&#39;re under TARGET_PPC64.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.hen=
derson@linaro.org" target=3D"_blank" rel=3D"noreferrer">richard.henderson@l=
inaro.org</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; =C2=A0 target/ppc/tcg-excp_helper.c | 30 +++++++++----------------=
-----<br>
&gt;&gt; =C2=A0 1 file changed, 9 insertions(+), 21 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_he=
lper.c<br>
&gt;&gt; index 99ffe4a820..4065440949 100644<br>
&gt;&gt; --- a/target/ppc/tcg-excp_helper.c<br>
&gt;&gt; +++ b/target/ppc/tcg-excp_helper.c<br>
&gt;&gt; @@ -353,35 +353,23 @@ bool ppc_cpu_debug_check_watchpoint(CPUState=
 *cs, CPUBreakpoint *wp)<br>
&gt;&gt; =C2=A0 {<br>
&gt;&gt; =C2=A0 #if defined(TARGET_PPC64)<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPUPPCState *env =3D cpu_env(cs);<b=
r>
&gt;&gt; -=C2=A0=C2=A0=C2=A0 bool wt, wti, hv, sv, pr;<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0 uint32_t dawrx;<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 uint32_t dawrx =3D env-&gt;spr[wp-&gt;id ? SPR=
_DAWRX1 : SPR_DAWRX0];<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 bool wt =3D extract32(dawrx, PPC_BIT_NR(59), 1=
);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 bool wti =3D extract32(dawrx, PPC_BIT_NR(60), =
1);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 bool hv =3D extract32(dawrx, PPC_BIT_NR(61), 1=
);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 bool sv =3D extract32(dawrx, PPC_BIT_NR(62), 1=
);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 bool pr =3D extract32(dawrx, PPC_BIT_NR(62), 1=
);<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0 if ((env-&gt;insns_flags2 &amp; PPC2_ISA207S) =
&amp;&amp;<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (wp =3D=3D env-&gt;daw=
r_watchpoint[0])) {<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dawrx =3D env-&gt;spr[=
SPR_DAWRX0];<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0 } else if ((env-&gt;insns_flags2 &amp; PPC2_IS=
A310) &amp;&amp;<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (wp =3D=3D env-&gt;dawr_watchpoint[1])) {<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dawrx =3D env-&gt;spr[=
SPR_DAWRX1];<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0 } else {<br>
&gt; <br>
&gt; Previously, there were different ISA version checks resulting in diffe=
rent behaviour, now <br>
&gt; with this change we are allowing for both ISA versions. Not sure if th=
is would be an <br>
&gt; expected behaviour?<br>
<br>
Per the commit comment, the ISA version checks are done when registering th=
e system <br>
register.=C2=A0 One cannot write to DAWRX1 unless ISA310, and therefore daw=
r_watchpoint[1] will <br>
not be set nor wp-&gt;id be 1.<br></blockquote></div></div><div dir=3D"auto=
"><br></div><div dir=3D"auto">Thanks for confirming, Richard!</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Regards=C2=A0</div><div dir=3D"auto">=
Harsh=C2=A0</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_co=
ntainer"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">
<br>
<br>
r~<br>
<br>
</blockquote></div></div></div>

--0000000000005e089b065659418e--

