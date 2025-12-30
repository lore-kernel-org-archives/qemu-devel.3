Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D19E9410E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 05:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaRuY-0007AE-U7; Tue, 30 Dec 2025 00:04:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vaRuV-00079f-I6
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 00:04:43 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vaRuQ-0000bi-J7
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 00:04:40 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a0833b5aeeso132006245ad.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 21:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767071075; x=1767675875; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YR5mVQ+/C22dw+Ug1XJ75YsLYXIoxjNUS0GVdqfiw3U=;
 b=LaC5WAOhBOEY5JipnGBnm66me+u+Kb7YJmXp3o0G/+1+TYpQyre+sdx+uQMjqeanQE
 IE0d5B9F1/JHVOJ5jWmBnIlJx1K+8//USwgRFOAAnCur8jFtfAkO44hBPtwzaXP4syBg
 CbFLcj4NXuR5hcVg71izCmnmA7k+QZsL64GA65WJea0XcT9g2MABt5wpO06UZYuKJheF
 0TcVLC8RQhnEqRgEAE4z3r+xDKaGI0xPGGTSQ5LZ3jQAQx9lnrUxVIMN71chrOyspgCm
 nwt9iZQ0wmyuv2xkFFpjaRmItYHAFbC9Q7aX54eZ8mvz0QOjuzfqzDt31oNXLaDcCqrE
 2jgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767071075; x=1767675875;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YR5mVQ+/C22dw+Ug1XJ75YsLYXIoxjNUS0GVdqfiw3U=;
 b=KOae5qFwg8CHeo0jro9UYjDS4u6z+HCcOfG4/gGTHXz+8/G2KD37jAHwCo1cRujcfM
 qHUJ70PrBwI3N3vjGHSgkz68aMhdejWSDrXpd2ploum69aIqyuf3v52tIX7o6oX61YJH
 OxasyFs5k6RKtR6NWtY402cw9SX/gFU9ZnzYB+C9I6+KOBIqkt9t9j7wODblj6gDTvgB
 abr0ZrY3SIL33apY0ymWja2n+3SQCc1VRlW2YnRAlGwaaWvaa01vAvOj/FD4v7ZAjO+g
 u0rO62FWTNXyavEpPju0GuVOtsXb5NcZSrlofuUx5whIxYht/9PIRaW3DXzVuFvJ6FrR
 H8+A==
X-Gm-Message-State: AOJu0YwUq1jiSFO3GDxBXGwdgVxzMoKQ+3neaaCzeF6mJ+nrqvpQhkzJ
 0Lg7kP4PeHp4QOa9W+sRTJKdXkIVj0XoBQ2gtdGea8kaZEnpVNMG24T1n4CFutouu/jYdhCNsfr
 bcxjzlS2jx2YdVmCJXhQCsQmCsOOtDYBgCnCVSeBghhp6SmXIp7ISUDHDxA==
X-Gm-Gg: AY/fxX5hNpkvMe+JzDHSYxJPlaZsse/V2ingoWRJ3PLgGEcSGDBMX8SZT2GAt8ptxNt
 l/vvMMzdAsQlUKaCcXjaizetYGgOLwZ2hXsUls7wSaTHl2l/QEKt7yYoz4J0ginnPz07VHZ+yI8
 T1pa3n1Duh/OvB+AWwAJvAVsTu1cSKjirWV2bUrFAW3/tMFY385ALFKUFbwndhiik9a9Qqbjokx
 RD3NQlRpyQlw1TgRrIgju3PfFyCGXZsuyyeyH+3y0F26zusQZkvearR87FlxUbBhIIlE6CQuw==
X-Google-Smtp-Source: AGHT+IHDxXkrdFRsUsYWZB0j6NGKdGs81/cFj3vnBN8Pur3CN3yEhXZPjmWT39j/uHxVMTEyP1A1oY+lP+mRCPsto68=
X-Received: by 2002:a05:7022:2526:b0:11b:9386:826a with SMTP id
 a92af1059eb24-1217230352bmr32497859c88.47.1767071075195; Mon, 29 Dec 2025
 21:04:35 -0800 (PST)
MIME-Version: 1.0
References: <20251223102547.13337-1-jay.chang@sifive.com>
 <9eeda21f-f7ba-4908-84a2-4daccc4af6a8@linaro.org>
In-Reply-To: <9eeda21f-f7ba-4908-84a2-4daccc4af6a8@linaro.org>
From: Jay Chang <jay.chang@sifive.com>
Date: Tue, 30 Dec 2025 13:04:23 +0800
X-Gm-Features: AQt7F2qKEatGyLZ2ES-ynXR1cx0J7dECBHRYPpKY0OnlK6u3vD4kkpX7uCkajcg
Message-ID: <CACNNAjMnyGBmqo82TfDtzUob3+DPCBoo5hh+T8K8=AXuvHfOSw@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Align pmp size to pmp-granularity
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Frank Chang <frank.chang@sifive.com>
Content-Type: multipart/alternative; boundary="000000000000baed0f0647244bcb"
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=jay.chang@sifive.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000baed0f0647244bcb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

Thank you for the suggestion. QEMU_ALIGN_UP() is not suitable for
NAPOT because the logic is different:

- QEMU_ALIGN_UP() performs alignment (rounds up to the nearest multiple)
- NAPOT requires setting lower bits to 1 (not rounding up)

For example, with g=3D3 and this_addr=3D0x1005:
- Current code: 0x1005 | 0x3 =3D 0x1007 (sets lower 2 bits)
- QEMU_ALIGN_UP: QEMU_ALIGN_UP(0x1005, 4) =3D 0x1008 (rounds up)

However, you're right that the TOR case can be improved using
ROUND_DOWN() since it clears lower bits (which is alignment)

I'll update the patch with this improvement.

On Sun, Dec 28, 2025 at 1:03=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Hi,
>
> On 23/12/25 11:25, Jay Chang wrote:
> > When configuring pmpcfg (TOR, NA4, or NAPOT) and pmpaddr, if the
> > value is smaller than the PMP granularity, it automatically aligned
> > to the PMP granularity.
> >
> > Signed-off-by: Jay Chang <jay.chang@sifive.com>
> > Reviewed-by: Frank Chang <frank.chang@sifive.com>
> > ---
> >   target/riscv/pmp.c | 10 ++++++++--
> >   1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> > index 3ef62d26ad..01b337f529 100644
> > --- a/target/riscv/pmp.c
> > +++ b/target/riscv/pmp.c
> > @@ -167,11 +167,12 @@ static bool pmp_write_cfg(CPURISCVState *env,
> uint32_t pmp_index, uint8_t val)
> >               uint8_t a_field =3D pmp_get_a_field(val);
> >               /*
> >                * When granularity g >=3D 1 (i.e., granularity > 4 bytes=
),
> > -             * the NA4 (Naturally Aligned 4-byte) mode is not selectab=
le
> > +             * the NA4 (Naturally Aligned 4-byte) mode is not
> selectable.
> > +             * In this case, an NA4 setting is reinterpreted as a NAPO=
T
> mode.
> >                */
> >               if ((riscv_cpu_cfg(env)->pmp_granularity >
> >                   MIN_RISCV_PMP_GRANULARITY) && (a_field =3D=3D
> PMP_AMATCH_NA4)) {
> > -                    return false;
> > +                    val |=3D PMP_AMATCH;
> >               }
> >               env->pmp_state.pmp[pmp_index].cfg_reg =3D val;
> >               pmp_update_rule_addr(env, pmp_index);
> > @@ -251,6 +252,11 @@ void pmp_update_rule_addr(CPURISCVState *env,
> uint32_t pmp_index)
> >           break;
> >
> >       case PMP_AMATCH_NAPOT:
> > +        /* Align to pmp_granularity */
> > +        if (g >=3D 2) {
> > +            this_addr |=3D ((1ULL << (g - 1ULL)) - 1ULL);
>
> Could we use QEMU_ALIGN_UP() here?
>
> > +        }
> > +
> >           pmp_decode_napot(this_addr, &sa, &ea);
> >           break;
> >
>
>

--000000000000baed0f0647244bcb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0Philippe,<br><br>Thank you for the suggestion. QEM=
U_ALIGN_UP() is not suitable for<br>NAPOT because the logic is different:<b=
r><br>- QEMU_ALIGN_UP() performs alignment (rounds up to the nearest multip=
le)<br>- NAPOT requires setting lower bits to 1 (not rounding up)<br><br>Fo=
r example, with g=3D3 and this_addr=3D0x1005:<br>- Current code: 0x1005 | 0=
x3 =3D 0x1007 (sets lower 2 bits)<br>- QEMU_ALIGN_UP: QEMU_ALIGN_UP(0x1005,=
 4) =3D 0x1008 (rounds up)<br><br>However, you&#39;re right that the TOR ca=
se can be improved using<br>ROUND_DOWN() since it clears lower bits (which =
is alignment)<br><br>I&#39;ll update the patch with this improvement.<br></=
div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Sun, Dec 28, 2025 at 1:03=E2=80=AFAM Philippe Mathie=
u-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<=
br>
<br>
On 23/12/25 11:25, Jay Chang wrote:<br>
&gt; When configuring pmpcfg (TOR, NA4, or NAPOT) and pmpaddr, if the<br>
&gt; value is smaller than the PMP granularity, it automatically aligned<br=
>
&gt; to the PMP granularity.<br>
&gt; <br>
&gt; Signed-off-by: Jay Chang &lt;<a href=3D"mailto:jay.chang@sifive.com" t=
arget=3D"_blank">jay.chang@sifive.com</a>&gt;<br>
&gt; Reviewed-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com"=
 target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/riscv/pmp.c | 10 ++++++++--<br>
&gt;=C2=A0 =C2=A01 file changed, 8 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c<br>
&gt; index 3ef62d26ad..01b337f529 100644<br>
&gt; --- a/target/riscv/pmp.c<br>
&gt; +++ b/target/riscv/pmp.c<br>
&gt; @@ -167,11 +167,12 @@ static bool pmp_write_cfg(CPURISCVState *env, ui=
nt32_t pmp_index, uint8_t val)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t a_field =
=3D pmp_get_a_field(val);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * When granular=
ity g &gt;=3D 1 (i.e., granularity &gt; 4 bytes),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the NA4 (Naturally =
Aligned 4-byte) mode is not selectable<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the NA4 (Naturally =
Aligned 4-byte) mode is not selectable.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* In this case, an NA=
4 setting is reinterpreted as a NAPOT mode.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((riscv_cpu_c=
fg(env)-&gt;pmp_granularity &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MI=
N_RISCV_PMP_GRANULARITY) &amp;&amp; (a_field =3D=3D PMP_AMATCH_NA4)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 return false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 val |=3D PMP_AMATCH;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;pmp_stat=
e.pmp[pmp_index].cfg_reg =3D val;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pmp_update_rule_=
addr(env, pmp_index);<br>
&gt; @@ -251,6 +252,11 @@ void pmp_update_rule_addr(CPURISCVState *env, uin=
t32_t pmp_index)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case PMP_AMATCH_NAPOT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Align to pmp_granularity */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g &gt;=3D 2) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 this_addr |=3D ((1ULL &lt;&=
lt; (g - 1ULL)) - 1ULL);<br>
<br>
Could we use QEMU_ALIGN_UP() here?<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pmp_decode_napot(this_addr, &a=
mp;sa, &amp;ea);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0<br>
<br>
</blockquote></div>

--000000000000baed0f0647244bcb--

