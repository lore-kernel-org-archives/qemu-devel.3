Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D93D41D69
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 16:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTjkC-0007bZ-Ry; Thu, 11 Dec 2025 11:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vTjjk-0007Xt-Km
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:41:56 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vTjji-0004bG-EA
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:41:52 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b7a72874af1so51458666b.3
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 08:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1765471306; x=1766076106; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UhHQE4c5HapRNXHcITOD4vyTDSsx7aYGJAA9kTp3ShM=;
 b=IbtIZYWilsmSRnNrQqIXCWVNNppX3adp3xeQOuRDp0EZl8ovOuFaaZ2trmAHtrTu1+
 NontIe0Rgb4Akd6itf/TVwKTpb/kOaou5910mMFsQtFAQ/sQpGwT4bE8GKWd3RPssdpE
 7xJw/wH5H3F8/dd6tVP3erv5DdMrQ3+z6JHPAzIT2a1XAm32jagoAVvF0q2jpfT8uLwZ
 m6SVLACsx6iVKcfrDCCLCM7egepbrr+ndL08aI0k+w+I53GlrYrkFoULtKg/8Ara42SS
 RVxeJcx4LM0BjQ0cdvOcL9L/Wl3LIgBARM+SGh8XzBZ8Cz2IUKYPaQfNOerUnKSMix60
 sCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765471306; x=1766076106;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UhHQE4c5HapRNXHcITOD4vyTDSsx7aYGJAA9kTp3ShM=;
 b=Bgh1RIkN/sovEt6ZIihNHkak0cP3UlBZSnObdOvQImCaBcRFQ6VxldVQxcwf0UqFDy
 z+jXNSPuhGO8IhdLXE8iHNxWT5gMJeLZssBDXU9MQi8K03zjPazuhAXxX7DRaqSX+qNV
 eEM6aGl1+4G+1XIvWBan4k34uiwY3mVLNZG+aF0j2Ow1mp5KfribqayOD4taaQlf5upA
 2EwTnjgyyOHGNRvIK6nSrq7a3RDQwhQXWQFsePCoMsUR0FCRPRZcWJGdawlX7l84ATjS
 U8DdKcvV3aWL46ISJ+PjQJ8XnYEC5kYNprE+BClhyIMPHYvWJ5RSbvmX60lM06yrsxMN
 bQ3g==
X-Gm-Message-State: AOJu0YzcUPPCg4L+5CQaqSiFtIx3KGrWrx0gJKDakQDjJPJToQkDpkh9
 eybz6PGr0kSNGhBAJMmUw4Swlw2KbeUGW9TbSLmyB22lEI7RRpR68b6MwXep7cY0drzVXRZk2Pk
 93O8L/V5nLmMIOF5qPSdv948QC1zurZBX5CpusfSQfw==
X-Gm-Gg: AY/fxX6cGUBmuuNMhXxJui3P00ChdQ014MfKWoD2ABGJTuotBpfa+X3TUpELM7fqyz8
 hc8/33IuBcL+OUG2PtjfiwctuQ5qBzYH78ov8Qd16g6r891j9+RlP+mLCXm0dqtlGAcwuWNJHKQ
 qWvzVI2s81jfRCz1L115Bqot9hQ/nsfPPH5JBai056ZdsQ3FARy2DHplHSh7rDULcUwDeW0B/A+
 ZbECj0ZC9vAD3WFQ4YbracFtKBMF8z+HFyFqMPySeDxXKjeIviziaW+05UYSHnwih4kvmGGRw==
X-Google-Smtp-Source: AGHT+IFUXBEkw6CAAaNA5fWademBW+96Yv1HqEe5kxp9E2Jgd+yQCBwvRfqwM15PAFLsHpVhxN/ExGDxB5ld6TSZuyM=
X-Received: by 2002:a17:906:cc11:b0:b7d:11b1:10a5 with SMTP id
 a640c23a62f3a-b7d11b12497mr73791166b.33.1765471306393; Thu, 11 Dec 2025
 08:41:46 -0800 (PST)
MIME-Version: 1.0
References: <20251121050413.3718427-1-frank.chang@sifive.com>
 <20251121050413.3718427-4-frank.chang@sifive.com>
 <DEHVPKNHJOPC.2TGKLMGEUF617@ventanamicro.com>
In-Reply-To: <DEHVPKNHJOPC.2TGKLMGEUF617@ventanamicro.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Fri, 12 Dec 2025 00:41:33 +0800
X-Gm-Features: AQt7F2oCbGgH_H1T_cn5cV8Sj7nBOncp3Y3G91rkw6NnBi-3qLEuxYMg1c_lSnw
Message-ID: <CAE_xrPiXK3G92XFOJ_XpEj47CAGXsLfrO7w08NaPprbXN-vN8w@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] target/riscv: Fix pointer masking PMM field
 selection logic
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>, 
 qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000143f750645afd2bd"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=frank.chang@sifive.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000143f750645afd2bd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Radim,

On Tue, Nov 25, 2025 at 11:26=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcm=
ar@ventanamicro.com>
wrote:

> 2025-11-21T13:04:10+08:00, <frank.chang@sifive.com>:
> > From: Frank Chang <frank.chang@sifive.com>
> >
> > mstatus.MPV only records the previous virtualization state, and does no=
t
> > affect pointer masking according to the Zjpm specification.
> >
> > This patch rewrites riscv_pm_get_pmm() to follow the architectural
> > definition of Smmpm, Smnpm, and Ssnpm.
> >
> > The resulting PMM selection logic for each mode is summarized below:
> >
> >   * mstatus.MXR =3D 1: pointer masking disabled
> >
> >   * Smmpm + Smnpm + Ssnpm:
> >       M-mode:  mseccfg.PMM
> >       S-mode:  menvcfg.PMM
> >       U-mode:  senvcfg.PMM
> >       VS-mode: henvcfg.PMM
> >       VU-mode: senvcfg.PMM
> >
> >   * Smmpm + Smnpm (RVS implemented):
> >       M-mode:  mseccfg.PMM
> >       S-mode:  menvcfg.PMM
> >       U/VS/VU: disabled (Ssnpm not present)
> >
> >   * Smmpm + Smnpm (RVS not implemented):
> >       M-mode:  mseccfg.PMM
> >       U-mode:  menvcfg.PMM
> >       S/VS/VU: disabled (no S-mode)
> >
> >   * Smmpm only:
> >       M-mode:  mseccfg.PMM
> >       Other existing modes: pointer masking disabled
> >
> > Signed-off-by: Frank Chang <frank.chang@sifive.com>
> > Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > ---
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> >  RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
> >  {
> >  #ifndef CONFIG_USER_ONLY
> > -    int priv_mode =3D cpu_address_mode(env);
> > +    int priv_mode;
> > +    bool virt;
> >
> > -    if (get_field(env->mstatus, MSTATUS_MPRV) &&
> > -        get_field(env->mstatus, MSTATUS_MXR)) {
> > +    if (get_field(env->mstatus, MSTATUS_MXR)) {
> >          return PMM_FIELD_DISABLED;
> >      }
>
> MSTATUS_MXR doesn't disable Pointer masking in M-mode, and we also need
> to consider virt, where vsstatus.MXR is in effect as well.
>
> >
> > +    riscv_cpu_eff_priv(env, &priv_mode, &virt);
>
> I think you could put something like this here:
>
>       if ((mode !=3D PRV_M && get_field(env->mstatus, MSTATUS_MXR)) ||
>           (virt && get_field(env->vsstatus, MSTATUS_MXR))) {
>           return PMM_FIELD_DISABLED;
>       }
>
> >      /* Get current PMM field */
> >      switch (priv_mode) {
> >      case PRV_M:
> > @@ -189,22 +222,30 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
> >      case PRV_U:
> > -        if (riscv_has_ext(env, RVS)) {
> > +        if (!virt) {
> >              if (riscv_cpu_cfg(env)->ext_ssnpm) {
> >                  return get_field(env->senvcfg, SENVCFG_PMM);
> >              }
> > -        } else {
> > +
> >              if (riscv_cpu_cfg(env)->ext_smnpm) {
> > -                return get_field(env->menvcfg, MENVCFG_PMM);
> > +                if (!riscv_has_ext(env, RVS)) {
> > +                    return get_field(env->menvcfg, MENVCFG_PMM);
> > +                }
> > +            }
> > +        } else {
> > +            if (riscv_cpu_cfg(env)->ext_ssnpm) {
> > +                return get_field(env->senvcfg, SENVCFG_PMM);
> >              }
> >          }
>
> virt doesn't really matter, the original code was correct.
>
> Thanks.
>

Thanks for the review, I've sent out the v3 patchset:
https://patchew.org/QEMU/20251211163826.3998266-1-frank.chang@sifive.com/

Regards,
Frank Chang

--000000000000143f750645afd2bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi=C2=A0Radim,</div><br><div class=3D"gma=
il_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tu=
e, Nov 25, 2025 at 11:26=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 &lt;<a href=
=3D"mailto:rkrcmar@ventanamicro.com">rkrcmar@ventanamicro.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">2025-11-21T13:=
04:10+08:00, &lt;<a href=3D"mailto:frank.chang@sifive.com" target=3D"_blank=
">frank.chang@sifive.com</a>&gt;:<br>
&gt; From: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" target=
=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt;<br>
&gt; mstatus.MPV only records the previous virtualization state, and does n=
ot<br>
&gt; affect pointer masking according to the Zjpm specification.<br>
&gt;<br>
&gt; This patch rewrites riscv_pm_get_pmm() to follow the architectural<br>
&gt; definition of Smmpm, Smnpm, and Ssnpm.<br>
&gt;<br>
&gt; The resulting PMM selection logic for each mode is summarized below:<b=
r>
&gt;<br>
&gt;=C2=A0 =C2=A0* mstatus.MXR =3D 1: pointer masking disabled<br>
&gt;<br>
&gt;=C2=A0 =C2=A0* Smmpm + Smnpm + Ssnpm:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0M-mode:=C2=A0 mseccfg.PMM<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0S-mode:=C2=A0 menvcfg.PMM<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0U-mode:=C2=A0 senvcfg.PMM<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VS-mode: henvcfg.PMM<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VU-mode: senvcfg.PMM<br>
&gt;<br>
&gt;=C2=A0 =C2=A0* Smmpm + Smnpm (RVS implemented):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0M-mode:=C2=A0 mseccfg.PMM<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0S-mode:=C2=A0 menvcfg.PMM<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0U/VS/VU: disabled (Ssnpm not present)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0* Smmpm + Smnpm (RVS not implemented):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0M-mode:=C2=A0 mseccfg.PMM<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0U-mode:=C2=A0 menvcfg.PMM<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0S/VS/VU: disabled (no S-mode)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0* Smmpm only:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0M-mode:=C2=A0 mseccfg.PMM<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Other existing modes: pointer masking disabl=
ed<br>
&gt;<br>
&gt; Signed-off-by: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.co=
m" target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt; Reviewed-by: Daniel Henrique Barboza &lt;<a href=3D"mailto:dbarboza@ve=
ntanamicro.com" target=3D"_blank">dbarboza@ventanamicro.com</a>&gt;<br>
&gt; ---<br>
&gt; diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c<br>
&gt;=C2=A0 RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 #ifndef CONFIG_USER_ONLY<br>
&gt; -=C2=A0 =C2=A0 int priv_mode =3D cpu_address_mode(env);<br>
&gt; +=C2=A0 =C2=A0 int priv_mode;<br>
&gt; +=C2=A0 =C2=A0 bool virt;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 if (get_field(env-&gt;mstatus, MSTATUS_MPRV) &amp;&amp;=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_field(env-&gt;mstatus, MSTATUS_MXR)) =
{<br>
&gt; +=C2=A0 =C2=A0 if (get_field(env-&gt;mstatus, MSTATUS_MXR)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return PMM_FIELD_DISABLED;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
<br>
MSTATUS_MXR doesn&#39;t disable Pointer masking in M-mode, and we also need=
<br>
to consider virt, where vsstatus.MXR is in effect as well.<br>
<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 riscv_cpu_eff_priv(env, &amp;priv_mode, &amp;virt);<br>
<br>
I think you could put something like this here:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 if ((mode !=3D PRV_M &amp;&amp; get_field(env-&gt;msta=
tus, MSTATUS_MXR)) ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (virt &amp;&amp; get_field(env-&gt;vssta=
tus, MSTATUS_MXR))) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return PMM_FIELD_DISABLED;<br>
=C2=A0 =C2=A0 =C2=A0 }<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Get current PMM field */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 switch (priv_mode) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case PRV_M:<br>
&gt; @@ -189,22 +222,30 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 case PRV_U:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (riscv_has_ext(env, RVS)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!virt) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (riscv_cpu_cfg(env)=
-&gt;ext_ssnpm) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return g=
et_field(env-&gt;senvcfg, SENVCFG_PMM);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (riscv_cpu_cfg(env)=
-&gt;ext_smnpm) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return get_fi=
eld(env-&gt;menvcfg, MENVCFG_PMM);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!riscv_ha=
s_ext(env, RVS)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 return get_field(env-&gt;menvcfg, MENVCFG_PMM);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (riscv_cpu_cfg(env)-&gt;=
ext_ssnpm) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return get_fi=
eld(env-&gt;senvcfg, SENVCFG_PMM);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
virt doesn&#39;t really matter, the original code was correct.<br>
<br>
Thanks.<br></blockquote><div><br></div><div>Thanks for the review, I&#39;ve=
 sent out the v3 patchset:</div><div><a href=3D"https://patchew.org/QEMU/20=
251211163826.3998266-1-frank.chang@sifive.com/">https://patchew.org/QEMU/20=
251211163826.3998266-1-frank.chang@sifive.com/</a></div><div><br></div><div=
>Regards,</div><div>Frank Chang</div></div></div>

--000000000000143f750645afd2bd--

