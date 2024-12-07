Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE1FE7716E
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 07:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJp7C-000804-0C; Sat, 07 Dec 2024 02:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tJp7A-0007zq-V6; Sat, 07 Dec 2024 02:20:32 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tJp78-0005o0-OL; Sat, 07 Dec 2024 02:20:32 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d3bdccba49so2399853a12.1; 
 Fri, 06 Dec 2024 23:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733556023; x=1734160823; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aYQ+KnAc3H7/kkUuw8nuj1LkePNLl61hf3R7Fu5nQ6o=;
 b=jwa/dRCcvWimQ37LHwnMiMSfbi03gt6LCaCnhRtrw65hp/TBVFcg/R7egzyRf0I7Ed
 W56hyCCnxz95II/AAFcBr1EkKE320SsRsVB+rDc80+cU5GJAWfBbeSns++p8/ZMimdEF
 gaHcmln0O7dqamIbGSMs3V3jg/ebEP54elomlH/XzJXwo9khibuiT9ZtLpm4vajVWzK5
 uoFmk8s0qlrUTN1ZKVMFATpjqfsy05WTeFhlbONSgAze5Ms8YK3hAVn8ILnHFpKomfoO
 Eu/WiTO+vSIygwEQlz/A10wtVky0YQoY94p0Nklkb7VPoPY45EOerVcutpKVT+aBD1fI
 b+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733556023; x=1734160823;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aYQ+KnAc3H7/kkUuw8nuj1LkePNLl61hf3R7Fu5nQ6o=;
 b=jHmy9qLOYj9EF/Kh4Rv+IB1Ylyhs+5wUwjh/SpkdSev37aVvb44UTPVTb0h77qWbv8
 bRy5O2nMfFvognU/W2v5NY4k+2laomysGCphD2L2aZvtLCE9YLe526JuKjhhFtwYl2/H
 Wev+Nlt3/vDjm9hkCyz9+q92jJW74EMbF56R28u7CuXt4EoZXvh6XylG9XQYms/EjsVo
 WJvaEbf6ziZ0apwdj7Anfu3JG+sVAl0lawhuCdnIdK9OvaprN/oQCp6pMmMjesANQpsP
 cNcjn/JE01qhd/sX/Iz5Z06h4a8hBnAtNGFK2wDwUfdZ+mFzz7wBp+dKhF0VYEJzcpdB
 j9Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdMayHfbch0df1uG9rEdvo2aowrycl/ne/00uplTWHQExDcrHY8MClk5CSj97P6Udla8P7p5XkcW//8w==@nongnu.org,
 AJvYcCWp9KdE4UWbg5lt+GLywb8hrgtg0gjBR3lI4k1hMgwy1IwJsk7VVEFtZGn67VHYXGle1RgF/ENjmouP@nongnu.org
X-Gm-Message-State: AOJu0YyyNWbl79uuoVaSKwOayfcrqwHWAtNAuL/tffHG6zSjuy3JujJR
 3Xhi/6jLuYXV0Dnxdp+AmAPPbedrz6oyTEbocmegauWymN+F/kxOzd/v+ESl0dJnGod5xSYWK3D
 sOUGzQcrw+E6bwPlq6MeeL99MX/pJTQ==
X-Gm-Gg: ASbGncvIP+DukoBCtCTSCiEOxrCgH9nAKAcdlunRDZKOJCvw3cPWPWOUtcPY4NyQXG8
 nNaXjE2wTDhXvLKyLcUVIQcVCwM/0rGg=
X-Google-Smtp-Source: AGHT+IHB+wa06ni3qhay9Jot4E7KIf+lA6pQoYH+y19NzvrPyA+qBQjQtDG8rw9NBu80z6At8B1bmM0NwpBNKCb1ZrY=
X-Received: by 2002:a05:6402:3789:b0:5d1:23c8:f4cd with SMTP id
 4fb4d7f45d1cf-5d3be67ffa0mr5632165a12.11.1733556021867; Fri, 06 Dec 2024
 23:20:21 -0800 (PST)
MIME-Version: 1.0
References: <20241205112304.593204-1-baturo.alexey@gmail.com>
 <20241205112304.593204-4-baturo.alexey@gmail.com>
 <9f616eaf-11fd-4772-9e7f-2404059419bb@ventanamicro.com>
In-Reply-To: <9f616eaf-11fd-4772-9e7f-2404059419bb@ventanamicro.com>
From: Alexey Baturo <baturo.alexey@gmail.com>
Date: Sat, 7 Dec 2024 10:20:10 +0300
Message-ID: <CAFukJ-DaZ=OYEWDDBku2Ksi+9MGZWDLJbF8n5jPq3M665Gk3EQ@mail.gmail.com>
Subject: Re: [PATCH v12 3/7] target/riscv: Add helper functions to calculate
 current number of masked bits for pointer masking
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com, 
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e1bcd10628a8f692"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ed1-x52e.google.com
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

--000000000000e1bcd10628a8f692
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Daniel.
Let's wait for about a week or so for other suggestions to the patches and
then I'll send a new updated series.

=D1=81=D0=B1, 7 =D0=B4=D0=B5=D0=BA. 2024=E2=80=AF=D0=B3. =D0=B2 00:08, Dani=
el Henrique Barboza <
dbarboza@ventanamicro.com>:

>
>
> On 12/5/24 8:23 AM, baturo.alexey@gmail.com wrote:
> > From: Alexey Baturo <baturo.alexey@gmail.com>
> >
> > Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
> > ---
> >   target/riscv/cpu.h        |  5 +++
> >   target/riscv/cpu_helper.c | 74 ++++++++++++++++++++++++++++++++++++++=
+
> >   2 files changed, 79 insertions(+)
> >
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 417ff45544..74d7076f5a 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -768,8 +768,13 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vadd=
r
> *pc,
> >
> >   bool riscv_cpu_is_32bit(RISCVCPU *cpu);
> >
> > +bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
> > +RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
> > +int riscv_pm_get_pmlen(RISCVPmPmm pmm);
> > +
> >   RISCVException riscv_csrr(CPURISCVState *env, int csrno,
> >                             target_ulong *ret_value);
> > +
> >   RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
> >                              target_ulong *ret_value,
> >                              target_ulong new_value, target_ulong
> write_mask);
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index dba04851d5..2558f869f2 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -214,6 +214,80 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vadd=
r
> *pc,
> >       *pflags =3D flags;
> >   }
> >
> > +RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
> > +{
> > +    RISCVPmPmm pmm =3D PMM_FIELD_DISABLED;
> > +#ifndef CONFIG_USER_ONLY
> > +    if (get_field(env->mstatus, MSTATUS_MPRV) &&
> > +        get_field(env->mstatus, MSTATUS_MXR)) {
> > +        return pmm;
> > +    }
> > +    int priv_mode =3D cpu_address_mode(env);
> > +    /* Get current PMM field */
> > +    switch (priv_mode) {
> > +    case PRV_M:
> > +        if (riscv_cpu_cfg(env)->ext_smmpm) {
> > +            pmm =3D get_field(env->mseccfg, MSECCFG_PMM);
> > +        }
> > +        break;
> > +    case PRV_S:
> > +        if (riscv_cpu_cfg(env)->ext_smnpm) {
> > +            if (get_field(env->mstatus, MSTATUS_MPV)) {
> > +                pmm =3D get_field(env->henvcfg, HENVCFG_PMM);
> > +            } else {
> > +                pmm =3D get_field(env->menvcfg, MENVCFG_PMM);
> > +            }
> > +        }
> > +        break;
> > +    case PRV_U:
> > +        if (riscv_has_ext(env, RVS)) {
> > +            if (riscv_cpu_cfg(env)->ext_ssnpm) {
> > +                pmm =3D get_field(env->senvcfg, SENVCFG_PMM);
> > +            }
> > +        } else {
> > +            if (riscv_cpu_cfg(env)->ext_smnpm) {
> > +                pmm =3D get_field(env->menvcfg, MENVCFG_PMM);
> > +            }
> > +        }
> > +        break;
> > +    default:
> > +        g_assert_not_reached();
> > +    }
> > +#endif
> > +    return pmm;
> > +}
> > +
> > +bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)
> > +{
> > +    bool virt_mem_en =3D false;
> > +#ifndef CONFIG_USER_ONLY
> > +    int satp_mode =3D 0;
> > +    int priv_mode =3D cpu_address_mode(env);
> > +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> > +        satp_mode =3D get_field(env->satp, SATP32_MODE);
> > +    } else {
> > +        satp_mode =3D get_field(env->satp, SATP64_MODE);
> > +    }
> > +    virt_mem_en =3D ((satp_mode !=3D VM_1_10_MBARE) && (priv_mode !=3D
> PRV_M));
> > +#endif
> > +    return virt_mem_en;
> > +}
> > +
> > +int riscv_pm_get_pmlen(RISCVPmPmm pmm)
> > +{
> > +    switch (pmm) {
> > +    case PMM_FIELD_DISABLED:
> > +        return 0;
> > +    case PMM_FIELD_PMLEN7:
> > +        return 7;
> > +    case PMM_FIELD_PMLEN16:
> > +        return 16;
> > +    default:
> > +        g_assert_not_reached();
> > +    }
> > +    return -1;
>
> You don't need a 'return -1' here since all possible return values are
> already
> covered in the 'switch' and the default label is using
> g_assert_not_reached(),
> i.e. you'll never return -1. The compiler will be fine with it - we use
> this
> kind of pattern all the time (cpu_get_fcfien() does this in this same
> file).
>
> You can remove the -1 return and even turn the helper to uint32_t. That w=
ay
> the caller knows that there's no need to handle negative values.
>
>
> Thanks,
>
> Daniel
>
>
> > +}
> > +
> >   #ifndef CONFIG_USER_ONLY
> >
> >   /*
>
>

--000000000000e1bcd10628a8f692
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Daniel.<div>Let&#39;s wait for about a week or so f=
or other suggestions to the patches and then I&#39;ll send a new updated se=
ries.</div></div><br><div class=3D"gmail_quote gmail_quote_container"><div =
dir=3D"ltr" class=3D"gmail_attr">=D1=81=D0=B1, 7 =D0=B4=D0=B5=D0=BA. 2024=
=E2=80=AF=D0=B3. =D0=B2 00:08, Daniel Henrique Barboza &lt;<a href=3D"mailt=
o:dbarboza@ventanamicro.com">dbarboza@ventanamicro.com</a>&gt;:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 12/5/24 8:23 AM, <a href=3D"mailto:baturo.alexey@gmail.com" target=3D"_b=
lank">baturo.alexey@gmail.com</a> wrote:<br>
&gt; From: Alexey Baturo &lt;<a href=3D"mailto:baturo.alexey@gmail.com" tar=
get=3D"_blank">baturo.alexey@gmail.com</a>&gt;<br>
&gt; <br>
&gt; Signed-off-by: Alexey Baturo &lt;<a href=3D"mailto:baturo.alexey@gmail=
.com" target=3D"_blank">baturo.alexey@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 5 ++=
+<br>
&gt;=C2=A0 =C2=A0target/riscv/cpu_helper.c | 74 +++++++++++++++++++++++++++=
++++++++++++<br>
&gt;=C2=A0 =C2=A02 files changed, 79 insertions(+)<br>
&gt; <br>
&gt; diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h<br>
&gt; index 417ff45544..74d7076f5a 100644<br>
&gt; --- a/target/riscv/cpu.h<br>
&gt; +++ b/target/riscv/cpu.h<br>
&gt; @@ -768,8 +768,13 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vad=
dr *pc,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0bool riscv_cpu_is_32bit(RISCVCPU *cpu);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);<br>
&gt; +RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);<br>
&gt; +int riscv_pm_get_pmlen(RISCVPmPmm pmm);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0RISCVException riscv_csrr(CPURISCVState *env, int csrno,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_ulong *ret_value);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0RISCVException riscv_csrrw(CPURISCVState *env, int csrno,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_ulong *ret_value,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_ulong new_value, target_ulong wri=
te_mask);<br>
&gt; diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c<br>
&gt; index dba04851d5..2558f869f2 100644<br>
&gt; --- a/target/riscv/cpu_helper.c<br>
&gt; +++ b/target/riscv/cpu_helper.c<br>
&gt; @@ -214,6 +214,80 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vad=
dr *pc,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*pflags =3D flags;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 RISCVPmPmm pmm =3D PMM_FIELD_DISABLED;<br>
&gt; +#ifndef CONFIG_USER_ONLY<br>
&gt; +=C2=A0 =C2=A0 if (get_field(env-&gt;mstatus, MSTATUS_MPRV) &amp;&amp;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_field(env-&gt;mstatus, MSTATUS_MXR)) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return pmm;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 int priv_mode =3D cpu_address_mode(env);<br>
&gt; +=C2=A0 =C2=A0 /* Get current PMM field */<br>
&gt; +=C2=A0 =C2=A0 switch (priv_mode) {<br>
&gt; +=C2=A0 =C2=A0 case PRV_M:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (riscv_cpu_cfg(env)-&gt;ext_smmpm) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pmm =3D get_field(env-&gt;m=
seccfg, MSECCFG_PMM);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case PRV_S:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (riscv_cpu_cfg(env)-&gt;ext_smnpm) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_field(env-&gt;mstat=
us, MSTATUS_MPV)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pmm =3D get_f=
ield(env-&gt;henvcfg, HENVCFG_PMM);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pmm =3D get_f=
ield(env-&gt;menvcfg, MENVCFG_PMM);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case PRV_U:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (riscv_has_ext(env, RVS)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (riscv_cpu_cfg(env)-&gt;=
ext_ssnpm) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pmm =3D get_f=
ield(env-&gt;senvcfg, SENVCFG_PMM);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (riscv_cpu_cfg(env)-&gt;=
ext_smnpm) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pmm =3D get_f=
ield(env-&gt;menvcfg, MENVCFG_PMM);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_not_reached();<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +#endif<br>
&gt; +=C2=A0 =C2=A0 return pmm;<br>
&gt; +}<br>
&gt; +<br>
&gt; +bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 bool virt_mem_en =3D false;<br>
&gt; +#ifndef CONFIG_USER_ONLY<br>
&gt; +=C2=A0 =C2=A0 int satp_mode =3D 0;<br>
&gt; +=C2=A0 =C2=A0 int priv_mode =3D cpu_address_mode(env);<br>
&gt; +=C2=A0 =C2=A0 if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 satp_mode =3D get_field(env-&gt;satp, SAT=
P32_MODE);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 satp_mode =3D get_field(env-&gt;satp, SAT=
P64_MODE);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 virt_mem_en =3D ((satp_mode !=3D VM_1_10_MBARE) &amp;&a=
mp; (priv_mode !=3D PRV_M));<br>
&gt; +#endif<br>
&gt; +=C2=A0 =C2=A0 return virt_mem_en;<br>
&gt; +}<br>
&gt; +<br>
&gt; +int riscv_pm_get_pmlen(RISCVPmPmm pmm)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 switch (pmm) {<br>
&gt; +=C2=A0 =C2=A0 case PMM_FIELD_DISABLED:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 case PMM_FIELD_PMLEN7:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 7;<br>
&gt; +=C2=A0 =C2=A0 case PMM_FIELD_PMLEN16:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 16;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_not_reached();<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return -1;<br>
<br>
You don&#39;t need a &#39;return -1&#39; here since all possible return val=
ues are already<br>
covered in the &#39;switch&#39; and the default label is using g_assert_not=
_reached(),<br>
i.e. you&#39;ll never return -1. The compiler will be fine with it - we use=
 this<br>
kind of pattern all the time (cpu_get_fcfien() does this in this same file)=
.<br>
<br>
You can remove the -1 return and even turn the helper to uint32_t. That way=
<br>
the caller knows that there&#39;s no need to handle negative values.<br>
<br>
<br>
Thanks,<br>
<br>
Daniel<br>
<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0#ifndef CONFIG_USER_ONLY<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/*<br>
<br>
</blockquote></div>

--000000000000e1bcd10628a8f692--

