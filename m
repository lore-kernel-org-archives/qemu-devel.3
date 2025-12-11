Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB2BD41D69
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 16:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTjiI-0006Kp-PC; Thu, 11 Dec 2025 11:40:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vTji2-0005vX-AL
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:40:10 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vTji0-00046O-F4
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:40:06 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b735e278fa1so66699866b.0
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 08:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1765471203; x=1766076003; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=To3wjVfwIqCu0t2ukPxPiPmiZQFg9lBjdBNYJKxC2H8=;
 b=d+ESebN84JOxztTHWzJpLnxjMd+olFk5OyC0s+s5D3V6DO5SKac7l/+D2j1/Ewcg2N
 xGiZKZ/uWfusHqC3s6ln3d38aKZIYVxehsv3FPX12TaBC1iuj3QLunZ3DMow2mEracR/
 rpHGp5vowhkNC+O2Xk5FqIuZJx7Zu9V399qAyX+i+gd4ms8bcuOx7FAwCaQXsrg8lMn6
 EIDgzdtV3TnyFY86cdPf0P6wIuF3AiTrERDSWND2eZ2IsIVP9S4M7YKihE6sqA6szo/x
 nJ4QU6BNrCy/B+Y91LwKpsKkDmF2e3Jwqji5a/1f9F/53xqkq0H0Ezz0ta21NhsLILtW
 dGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765471203; x=1766076003;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=To3wjVfwIqCu0t2ukPxPiPmiZQFg9lBjdBNYJKxC2H8=;
 b=ZWdOOgs1IcqrRvDyfUOQew1KzL49RrMJJw1iOPjCc9KWCGpWjYeWoMuGucqWVTIwpj
 CbGFnM0+iyf7JqvDYFcfOwqBpsOYFjNQrqPkm7hmQPGGTJBiOSpZmskoptyllwtPVExb
 QQ2lV5Ydw2tRcm63E3soP+ScTd5mLuhBrtLf6NZu67x0VZx3K3cmdxvDfdfaihcW11zN
 Eji4/e+4JjFERVD7aVTqqIJlCweDG1/9V6bTmR59v5FRHXYOuO28Wsk17jw4pvqTUh7S
 GkvN0qIPGrQ1DMgbRVRCwPaS4ZDG9HibP3aXrUhOpWoVlsTwnco23o+BLLe5cAkO9KAj
 7neA==
X-Gm-Message-State: AOJu0YxaNFsxpH2WF3t167EdigO/rK5C5PNtUNNISAgzWFkTHUApEF3V
 Yaxb1xlrMtssB1IJT1k7d9JM1wDG0YWjhoQIKuQXtgdhPiJAFRu3O/Q/6tv2WIxy9epHaoW2El8
 lW/o78aXvF1cCE5HLLQqOq6vNBtXQhTV3Hw7K0Bm/3Q==
X-Gm-Gg: AY/fxX7Qt6HvSE5iA3a1GHYW50joIF+nTVMZtE7BD3hqzG1pdLNzu7bhsyZJR7UMRYl
 RgJEGlsM909BKMRbwxgYSmj8ELk9ndamhfIne9YyqSQ9AocoSMuvbtfHoOBNWfv/OanCN5bQ4X1
 ZdPyKP9VpS83+PpNUxwc15vTuhhG+4Hf1cJdkt44qAcTtTpSolwGZYreF7ecM4vn+Iv8Nnmzbfq
 GiL+nEQscj8tVdAXyD41d7R6cCk4wDVzV1A0mt5smWmewGBo+ThrWsgLb3wZkLuPADvQpmVDoxI
 mGjflboY
X-Google-Smtp-Source: AGHT+IFIOk7NsuylPuSvtJIPdJXME7YddEYAXwrPyDxTwotFiucbKOxs2BGEf0t8Ad4/L9btOnkl3zw0jIjeX76y9c8=
X-Received: by 2002:a17:907:3c8e:b0:b4b:dd7e:65f2 with SMTP id
 a640c23a62f3a-b7ce823a835mr811987066b.5.1765471202628; Thu, 11 Dec 2025
 08:40:02 -0800 (PST)
MIME-Version: 1.0
References: <20251121050413.3718427-1-frank.chang@sifive.com>
 <20251121050413.3718427-3-frank.chang@sifive.com>
 <DEHV52Y49XZ0.1VF1MA5VMXMCV@ventanamicro.com>
In-Reply-To: <DEHV52Y49XZ0.1VF1MA5VMXMCV@ventanamicro.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Fri, 12 Dec 2025 00:39:50 +0800
X-Gm-Features: AQt7F2qJru3Jq3NKAdbfMYQx2nhWClss_rpKJT9LZdOiM_hI730lZUyCZ1j4_Zc
Message-ID: <CAE_xrPirUgfcxqogdvbuMj8Ah4cVrjzURCGoujg3F_T2r-UuXA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] target/riscv: Add a helper to return the current
 effective priv mode
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>, 
 qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e4e44a0645afcb0e"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=frank.chang@sifive.com; helo=mail-ej1-x636.google.com
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

--000000000000e4e44a0645afcb0e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Radim,

On Tue, Nov 25, 2025 at 10:59=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcm=
ar@ventanamicro.com>
wrote:

> 2025-11-21T13:04:09+08:00, <frank.chang@sifive.com>:
> > From: Frank Chang <frank.chang@sifive.com>
> >
> > This helper returns the current effective privilege mode.
> >
> > Signed-off-by: Frank Chang <frank.chang@sifive.com>
> > ---
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > @@ -38,6 +38,46 @@
> > +bool riscv_cpu_eff_priv(CPURISCVState *env, int *priv, bool *virt)
>
> I wonder if this function shouldn't be defined in a header file, so it
>

Are you saying that we "should" define it in a header file?


> can be inlined, because returning values through pointers is quite
> inefficient,


> > +{
> > +#ifndef CONFIG_USER_ONLY
> > +    int mode =3D env->priv;
> > +    bool virt_enabled =3D env->virt_enabled;
> > +    bool mode_modified =3D false;
> > +
> > +#ifndef CONFIG_USER_ONLY
>
> We know CONFIG_USER_ONLY is not defined at this point.
>
> > +    if (mode =3D=3D PRV_M && get_field(env->mstatus, MSTATUS_MPRV)) {
> > +        mode =3D get_field(env->mstatus, MSTATUS_MPP);
> > +        virt_enabled =3D get_field(env->mstatus, MSTATUS_MPV) && (mode=
 !=3D
> PRV_M);
> > +        mode_modified =3D true;
> > +    }
> > +#endif
> > +
> > +    if (priv) {
> > +        *priv =3D mode;
> > +    }
> > +
> > +    if (virt) {
> > +        *virt =3D virt_enabled;
> > +    }
> > +
> > +    return mode_modified;
> > +#else
> > +    *priv =3D env->priv;
>
> Since it's #ifdef CONFIG_USER_ONLY, we can just say
>
>        *priv =3D PRV_U;
>
>
> > +    *virt =3D false;
> > +    return false;
> > +#endif
> > +}
> > +
> >  int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
> >  {
> >  #ifdef CONFIG_USER_ONLY
> > @@ -45,19 +85,14 @@ int riscv_env_mmu_index(CPURISCVState *env, bool
> ifetch)
> >  #else
> >      bool virt =3D env->virt_enabled;
> >      int mode =3D env->priv;
> > +    bool mode_modified =3D false;
> >
> >      /* All priv -> mmu_idx mapping are here */
> >      if (!ifetch) {
> > -        uint64_t status =3D env->mstatus;
> > -
> > -        if (mode =3D=3D PRV_M && get_field(status, MSTATUS_MPRV)) {
> > -            mode =3D get_field(env->mstatus, MSTATUS_MPP);
> > -            virt =3D get_field(env->mstatus, MSTATUS_MPV) &&
> > -                   (mode !=3D PRV_M);
> > -            if (virt) {
> > -                status =3D env->vsstatus;
> > -            }
> > -        }
> > +        mode_modified =3D riscv_cpu_eff_priv(env, &mode, &virt);
> > +        uint64_t status =3D (mode_modified && virt) ? env->vsstatus :
> > +                                                    env->mstatus;
>
> It is likely a bug that MPRV=3D1+MPV=3D1 behaves differently from virt=3D=
1,
> but your patch preserves the current behavior, as it should.
>
> I had a few nitpicks, but important parts seem fine
>
> Reviewed-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@ventanamicro.com>
>
> Thanks.
>

--000000000000e4e44a0645afcb0e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi=C2=A0Radim,</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 25, 2=
025 at 10:59=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 &lt;<a href=3D"mailto:r=
krcmar@ventanamicro.com">rkrcmar@ventanamicro.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">2025-11-21T13:04:09+08:00,=
 &lt;<a href=3D"mailto:frank.chang@sifive.com" target=3D"_blank">frank.chan=
g@sifive.com</a>&gt;:<br>
&gt; From: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" target=
=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt;<br>
&gt; This helper returns the current effective privilege mode.<br>
&gt;<br>
&gt; Signed-off-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.co=
m" target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; ---<br>
&gt; diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c<br>
&gt; @@ -38,6 +38,46 @@<br>
&gt; +bool riscv_cpu_eff_priv(CPURISCVState *env, int *priv, bool *virt)<br=
>
<br>
I wonder if this function shouldn&#39;t be defined in a header file, so it<=
br></blockquote><div><br></div><div>Are you saying that we &quot;should&quo=
t; define it in a header file?</div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
can be inlined, because returning values through pointers is quite<br>
inefficient,=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
<br>
&gt; +{<br>
&gt; +#ifndef CONFIG_USER_ONLY<br>
&gt; +=C2=A0 =C2=A0 int mode =3D env-&gt;priv;<br>
&gt; +=C2=A0 =C2=A0 bool virt_enabled =3D env-&gt;virt_enabled;<br>
&gt; +=C2=A0 =C2=A0 bool mode_modified =3D false;<br>
&gt; +<br>
&gt; +#ifndef CONFIG_USER_ONLY<br>
<br>
We know CONFIG_USER_ONLY is not defined at this point.<br>
<br>
&gt; +=C2=A0 =C2=A0 if (mode =3D=3D PRV_M &amp;&amp; get_field(env-&gt;msta=
tus, MSTATUS_MPRV)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mode =3D get_field(env-&gt;mstatus, MSTAT=
US_MPP);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virt_enabled =3D get_field(env-&gt;mstatu=
s, MSTATUS_MPV) &amp;&amp; (mode !=3D PRV_M);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mode_modified =3D true;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +#endif<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (priv) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *priv =3D mode;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (virt) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *virt =3D virt_enabled;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return mode_modified;<br>
&gt; +#else<br>
&gt; +=C2=A0 =C2=A0 *priv =3D env-&gt;priv;<br>
<br>
Since it&#39;s #ifdef CONFIG_USER_ONLY, we can just say<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0*priv =3D PRV_U;<br>
<br>
<br>
&gt; +=C2=A0 =C2=A0 *virt =3D false;<br>
&gt; +=C2=A0 =C2=A0 return false;<br>
&gt; +#endif<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 #ifdef CONFIG_USER_ONLY<br>
&gt; @@ -45,19 +85,14 @@ int riscv_env_mmu_index(CPURISCVState *env, bool i=
fetch)<br>
&gt;=C2=A0 #else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool virt =3D env-&gt;virt_enabled;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int mode =3D env-&gt;priv;<br>
&gt; +=C2=A0 =C2=A0 bool mode_modified =3D false;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* All priv -&gt; mmu_idx mapping are here */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!ifetch) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t status =3D env-&gt;mstatus;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mode =3D=3D PRV_M &amp;&amp; get_fiel=
d(status, MSTATUS_MPRV)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mode =3D get_field(env-&gt;=
mstatus, MSTATUS_MPP);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virt =3D get_field(env-&gt;=
mstatus, MSTATUS_MPV) &amp;&amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
(mode !=3D PRV_M);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (virt) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D en=
v-&gt;vsstatus;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mode_modified =3D riscv_cpu_eff_priv(env,=
 &amp;mode, &amp;virt);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t status =3D (mode_modified &amp;&=
amp; virt) ? env-&gt;vsstatus :<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;mstatus;<br>
<br>
It is likely a bug that MPRV=3D1+MPV=3D1 behaves differently from virt=3D1,=
<br>
but your patch preserves the current behavior, as it should.<br>
<br>
I had a few nitpicks, but important parts seem fine<br>
<br>
Reviewed-by: Radim Kr=C4=8Dm=C3=A1=C5=99 &lt;<a href=3D"mailto:rkrcmar@vent=
anamicro.com" target=3D"_blank">rkrcmar@ventanamicro.com</a>&gt;<br>
<br>
Thanks.<br>
</blockquote></div></div>

--000000000000e4e44a0645afcb0e--

