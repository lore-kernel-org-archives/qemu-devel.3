Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2DBCD98CE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 05:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZM9s-0004On-Dp; Tue, 16 Jun 2026 01:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1wZM9p-0004NG-KU
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 01:16:17 -0400
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1wZM9n-0008HS-3j
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 01:16:17 -0400
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-30b6dad2382so3645864eec.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 22:16:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781586973; cv=none;
 d=google.com; s=arc-20240605;
 b=K/J3D7GTXvk9qMJnPBe5x1EKm0jwDGtJWR4ebOFhgcTn+ElObMOEBVxpKdd7EZfZ//
 B0NiL1g8CD+tv7srClOnZcXtFYhqIe50f2gB701QYoqwK2epGXj/DS7yhb8slNs7pbgG
 ZAnqCKEMfR5FL3j1QoQw2oZEtxwUOswB9O0UC8bFiYN7OqmDltXKCTuIshJwxAcfoTxt
 lAfrpe3v03bR8YOnqUout7uJB4QXt64s8OXTW1nkH+JMxqEfE/iCF9xcH1zeLQS+PNTV
 pLLxGn1SpgphAHOa1B+QZcbpRaKL2UhFMuZi9JeQu9CeeOwHVxtAFdbfesY1Xjo0oruY
 1DKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jgTkpZlRInc+kyAUR/eCBSmUWFcA0IGNgPZuZR0q2CQ=;
 fh=yGWAaXXYYQtYW+LCE7nyqmcq5QIuKbScqyYf4NVD8c4=;
 b=bscUOSbPcFl+gZk5Q4wMCv7i3y1XYwnRG23hdNr03eqKVcOn0hsks5Di9A4ED3ZFbt
 KKIXNghp0ixKHvjrjX4SVzAJLbovfbBFkImQJdn3AWm+CUn2MrZAuNM61Htr+0ztc9Md
 Ge03gCzwouCcSa++oieAhz+cBVYQrUQRNo8Fz1zYlcGqUiN09EU9Jk0pQJ4jKsrRXcBW
 ZEZg1yvqJsXxCwljdbZ3BFIzmq4neymriP13ukwcPLiyoO2C/udQnlU/WUZnsmoDVo3F
 KCnkjxZUk9DRwrRRKClSjk34y3K3H/ReEVDq7X50mJItSHkMekUtRPXzMXVg4anL3kOi
 3g+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781586973; x=1782191773; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jgTkpZlRInc+kyAUR/eCBSmUWFcA0IGNgPZuZR0q2CQ=;
 b=Aq/2GQUVWgBRAmp+JbBqaY4gKRdCMX6Ywse7OENneLr3ZrbLmtrAC8z8UKHDS/NLok
 uVU/1by3Q2OuaqN6AikTeobhOWJXZjWIQbdhDZbGQb+wSHI6k4kQ/hlqGKEzI40RF4dl
 2glOODXL5sHJ6yNKJ6QhMIwkCzsFpFFJhvNMWq2scPxEDQjg3ODcnSN8uyZeyWIOZUi8
 F/P6JQPMmW8N4i+cDtBRmKozAWdbrySzL3+6HgAn1zERYB5lvjK9BxqUJxm0KsgQrUef
 QkiSd7452TqRMoIUUquY5FdJzRqf0FQWM+9Vz9gfDMRwWaITNKRo0fmmNbsKvBzUekq9
 EVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781586973; x=1782191773;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jgTkpZlRInc+kyAUR/eCBSmUWFcA0IGNgPZuZR0q2CQ=;
 b=Me4BRom9jes0SHjn9KLQbZfrEDCJdIMEtIFOXddd7kRgt74pGeMciY7GfsWju9AWWl
 i2H2kZUr9rqXe6BO7uHeG07Ru4wu/sr7GvB7MG0Kx10SyMdWxplvx0RXODdXCx6vgcTn
 1J9x5o/uSR3sAeOcTeMcZ3qkQaeOPZpinBAao8OEvxdgUrbTHUJyg/pvLNWicXiTi34J
 tHxX/K1WMq/479jKeS/dKFkRwzS641PbMinc/raayhRefGPUtWEzjYEQsw5ErhVwVcHh
 edJWT9HROd8TS+41wn12tb2hSK3rreq0+jaaZguaKyFS/eCYxwALaQAzNvetQ5lVQzXL
 l41Q==
X-Gm-Message-State: AOJu0YzskrSt4yY2U0eiQiI9r4DYj52XqdilUzhF+vCPgB69kY56Os61
 xswG7zdLAEe3YMjENwUhH2o6lpWzjCSlLvj4rEWefXN451Qx/sOsCzpQ6GbU34S/Uh4qDCtJNV+
 pMNUGiDLvy+TQKTBCSh8QA2UW0CFjMqlj4g==
X-Gm-Gg: Acq92OGBp+TC4T8Tse9n5U0YGotk1e5H3aUVlrw84LSWByCKcr4jSmSpKUXzIWhhznZ
 m7g+hURVEJqSYfOf1s2OsgvC2CJwcIxhcKlfky0t0zLciglcaWigG/p/w9/x3Q7b5ozZ3yWH6Z0
 FSD2v3aZe4HLhRhApIoK0b3p4LN4eBCPNv1kArvk1lHnM1leE2czmwK8f0xp3OIjG4+2S6W86qi
 c6equiAg6G9FjJ2JWMOaqf3Bcc2xlqYmBfqN+OZ3WwTWGFEIPkmEHLNsKGb6YMG/EkgKlJaO7ia
 FaX1hA==
X-Received: by 2002:a05:7300:547:b0:2fc:9aa8:83da with SMTP id
 5a478bee46e88-308200ce4ccmr10281319eec.29.1781586972882; Mon, 15 Jun 2026
 22:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260608091815.31303-1-apolivodaa433@gmail.com>
In-Reply-To: <20260608091815.31303-1-apolivodaa433@gmail.com>
From: void <apolivodaa433@gmail.com>
Date: Tue, 16 Jun 2026 15:15:47 +1000
X-Gm-Features: AVVi8Cf3oMrL4B6_PWoYEKna_30JwyPB-GmG-XIgOooSC2Q4OCfvKNc6iPlcmw4
Message-ID: <CAGscdFs9AaxPTDCu_bpaMpeh4yqZ1BDwZ0yjo81CAZzJuAOW2A@mail.gmail.com>
Subject: Re: [PATCH v2] target/i386: helper_sysret(): Check that RCX contains
 a canonical address when emulating an Intel CPU
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000a7b92e0654580a89"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1331;
 envelope-from=apolivodaa433@gmail.com; helo=mail-dy1-x1331.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000a7b92e0654580a89
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping
https://lore.kernel.org/qemu-devel/20260608091815.31303-1-apolivodaa433@gma=
il.com/T/#u

=D0=BF=D0=BD, 8 =D0=B8=D1=8E=D0=BD. 2026 =D0=B3., 19:19 Andrey Polivoda <ap=
olivodaa433@gmail.com>:

> Intel and AMD CPUs implement SYSRETQ instruction differently.
> One of these differences is whether a canonicality check of the address
> that
> will be loaded to RIP is performed: Intel CPUs do this check, AMD CPUs
> don't.
>
> Currently, QEMU does not perform this check when emulating Intel CPUs.
> This patch corrects this by implementing the canonlicality check on a new
> RIP
> value from RCX and performing it only when emulating Intel CPUs.
>
> Flags and segment registers' caches are updated only after checking the
> new RIP
> value to ensure that CPU state is not modified in case the #GP(0) excepti=
on
> is raised due to the check failure.
>
> Cc: qemu-devel@nongnu.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Fixes: 14ce26e75513 ("x86_64 target support")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3223
> Signed-off-by: Andrey Polivoda <apolivodaa433@gmail.com>
> ---
>  target/i386/tcg/seg_helper.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
> index 58aac72011..d5c174b7fd 100644
> --- a/target/i386/tcg/seg_helper.c
> +++ b/target/i386/tcg/seg_helper.c
> @@ -1096,17 +1096,22 @@ void helper_sysret(CPUX86State *env, int dflag)
>      selector =3D (env->star >> 48) & 0xffff;
>  #ifdef TARGET_X86_64
>      if (env->hflags & HF_LMA_MASK) {
> -        cpu_load_eflags(env, (uint32_t)(env->regs[11]), TF_MASK | AC_MAS=
K
> -                        | ID_MASK | IF_MASK | IOPL_MASK | VM_MASK |
> RF_MASK |
> -                        NT_MASK);
>          if (dflag =3D=3D 2) {
> +            uint64_t new_rip =3D env->regs[R_ECX];
> +            if (IS_INTEL_CPU(env)) {
> +                int shift =3D (get_pg_mode(env) & PG_MODE_LA57) ? 56 : 4=
7;
> +                int64_t sext =3D (int64_t)new_rip >> shift;
> +                if (sext !=3D 0 && sext !=3D -1) {
> +                    raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
> +                }
> +            }
>              cpu_x86_load_seg_cache(env, R_CS, (selector + 16) | 3,
>                                     0, 0xffffffff,
>                                     DESC_G_MASK | DESC_P_MASK |
>                                     DESC_S_MASK | (3 << DESC_DPL_SHIFT) |
>                                     DESC_CS_MASK | DESC_R_MASK |
> DESC_A_MASK |
>                                     DESC_L_MASK);
> -            env->eip =3D env->regs[R_ECX];
> +            env->eip =3D new_rip;
>          } else {
>              cpu_x86_load_seg_cache(env, R_CS, selector | 3,
>                                     0, 0xffffffff,
> @@ -1120,6 +1125,10 @@ void helper_sysret(CPUX86State *env, int dflag)
>                                 DESC_G_MASK | DESC_B_MASK | DESC_P_MASK |
>                                 DESC_S_MASK | (3 << DESC_DPL_SHIFT) |
>                                 DESC_W_MASK | DESC_A_MASK);
> +
> +        cpu_load_eflags(env, (uint32_t)(env->regs[11]), TF_MASK | AC_MAS=
K
> +                        | ID_MASK | IF_MASK | IOPL_MASK | VM_MASK |
> RF_MASK |
> +                        NT_MASK);
>      } else
>  #endif
>      {
> --
> 2.53.0
>
>

--000000000000a7b92e0654580a89
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">ping<div dir=3D"auto"><a href=3D"https://lore.kernel.org/=
qemu-devel/20260608091815.31303-1-apolivodaa433@gmail.com/T/#u">https://lor=
e.kernel.org/qemu-devel/20260608091815.31303-1-apolivodaa433@gmail.com/T/#u=
</a></div></div><br><div class=3D"gmail_quote gmail_quote_container"><div d=
ir=3D"ltr" class=3D"gmail_attr">=D0=BF=D0=BD, 8 =D0=B8=D1=8E=D0=BD. 2026 =
=D0=B3., 19:19 Andrey Polivoda &lt;<a href=3D"mailto:apolivodaa433@gmail.co=
m">apolivodaa433@gmail.com</a>&gt;:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>Intel and AMD CPUs implement SYSRETQ instruction differently.<br>
One of these differences is whether a canonicality check of the address tha=
t<br>
will be loaded to RIP is performed: Intel CPUs do this check, AMD CPUs don&=
#39;t.<br>
<br>
Currently, QEMU does not perform this check when emulating Intel CPUs.<br>
This patch corrects this by implementing the canonlicality check on a new R=
IP<br>
value from RCX and performing it only when emulating Intel CPUs.<br>
<br>
Flags and segment registers&#39; caches are updated only after checking the=
 new RIP<br>
value to ensure that CPU state is not modified in case the #GP(0) exception=
<br>
is raised due to the check failure.<br>
<br>
Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank" rel=3D"noref=
errer">qemu-devel@nongnu.org</a><br>
Cc: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_bla=
nk" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
Cc: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org" t=
arget=3D"_blank" rel=3D"noreferrer">richard.henderson@linaro.org</a>&gt;<br=
>
Fixes: 14ce26e75513 (&quot;x86_64 target support&quot;)<br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/work_items/3223=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/qemu-p=
roject/qemu/-/work_items/3223</a><br>
Signed-off-by: Andrey Polivoda &lt;<a href=3D"mailto:apolivodaa433@gmail.co=
m" target=3D"_blank" rel=3D"noreferrer">apolivodaa433@gmail.com</a>&gt;<br>
---<br>
=C2=A0target/i386/tcg/seg_helper.c | 17 +++++++++++++----<br>
=C2=A01 file changed, 13 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c<br=
>
index 58aac72011..d5c174b7fd 100644<br>
--- a/target/i386/tcg/seg_helper.c<br>
+++ b/target/i386/tcg/seg_helper.c<br>
@@ -1096,17 +1096,22 @@ void helper_sysret(CPUX86State *env, int dflag)<br>
=C2=A0 =C2=A0 =C2=A0selector =3D (env-&gt;star &gt;&gt; 48) &amp; 0xffff;<b=
r>
=C2=A0#ifdef TARGET_X86_64<br>
=C2=A0 =C2=A0 =C2=A0if (env-&gt;hflags &amp; HF_LMA_MASK) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_load_eflags(env, (uint32_t)(env-&gt;regs[1=
1]), TF_MASK | AC_MASK<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | ID_MASK | IF_MASK | IOPL_MASK | VM_MASK | RF_MASK |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 NT_MASK);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dflag =3D=3D 2) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t new_rip =3D env-&gt;reg=
s[R_ECX];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (IS_INTEL_CPU(env)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int shift =3D (get=
_pg_mode(env) &amp; PG_MODE_LA57) ? 56 : 47;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int64_t sext =3D (=
int64_t)new_rip &gt;&gt; shift;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sext !=3D 0 &a=
mp;&amp; sext !=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rais=
e_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_x86_load_seg_cache(env,=
 R_CS, (selector + 16) | 3,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 0xffffffff,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DESC_G_MASK | DESC_P_M=
ASK |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DESC_S_MASK | (3 &lt;&=
lt; DESC_DPL_SHIFT) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DESC_CS_MASK | DESC_R_=
MASK | DESC_A_MASK |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DESC_L_MASK);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;eip =3D env-&gt;regs[R_E=
CX];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;eip =3D new_rip;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_x86_load_seg_cache(env,=
 R_CS, selector | 3,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, 0xffffffff,<br>
@@ -1120,6 +1125,10 @@ void helper_sysret(CPUX86State *env, int dflag)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DESC_G_MASK | DESC_B_MASK | DESC_P_M=
ASK |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DESC_S_MASK | (3 &lt;&lt; DESC_DPL_S=
HIFT) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DESC_W_MASK | DESC_A_MASK);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_load_eflags(env, (uint32_t)(env-&gt;regs[1=
1]), TF_MASK | AC_MASK<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | ID_MASK | IF_MASK | IOPL_MASK | VM_MASK | RF_MASK |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 NT_MASK);<br>
=C2=A0 =C2=A0 =C2=A0} else<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-- <br>
2.53.0<br>
<br>
</blockquote></div>

--000000000000a7b92e0654580a89--

