Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D1CCD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 02:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS4N2-0001kb-T1; Tue, 26 May 2026 22:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wS4Mz-0001gU-Jx
 for qemu-devel@nongnu.org; Tue, 26 May 2026 22:51:46 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wS4Mw-0001qh-O3
 for qemu-devel@nongnu.org; Tue, 26 May 2026 22:51:45 -0400
Received: by mail-lj1-x243.google.com with SMTP id
 38308e7fff4ca-39556b00a85so82742401fa.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 19:51:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779850297; cv=none;
 d=google.com; s=arc-20240605;
 b=GcVKchOIATl9A7M9L4AGTaQsdw2C2CO+ljjn6pSw3M5KG5vy3ktp2Q7/Y1ZAZRlV4i
 QB6+WHYvTdcx1SWgzB77LV17tRoVjhVG9YPT1Q3eCEqW35xOz/bWcrImoVeHm5Ce9FN3
 NICWc0YzPu6OF1JS6hii+ezTlHQyeuOrXt3GZwLBswxdDxWD62Uc2B0R9oxFM1CfmeWK
 9NZqsZvjSXPAp4i31Ff9MUUFW138Ozu+g6xXJBoucsRdSrkSqVK7ltXvv1zxoz5kOY6Z
 SEVJMUFqW9E2cpiXHITdcmAuM8yeDa7J2k1JrR+1ar8uF5U636ev2TjxjVUdo3I6YXnO
 Vi9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WCk6AhWtJfOyvuGJlXvmxmIfxIUYrbTjVFvyl7XyjwA=;
 fh=cGXp66taJ7oVFSchAJCSGREWquHCSyEPFjRudmCzoXo=;
 b=l0GLSnI7pVMFCYudGTSi9aYsekOsuKVpKCVRKeZzviyBAJiWcG/tHl7AbPXDXBT0CF
 JXQPyL4lyRQRZ51MoLgPSAVvtP46fvGC/PY1veFTVWamn+IYtms0ph23Es11l6ron1Cm
 AfMRneny9rOHCZtivLOrg8o4KwiDo8FXElHmGkwkvqDwYhU56B2IwfJMwN/grNbKWBR2
 SIVo/EAJPIPq8PA7+yAoLUCSJU2FT5rhoYItsFyNM8Oqfdod7nyCrRJvP0StScmpM1VR
 JKEEBPaDC1FusaFOpwu09uqD5xI2X/p+YS7V4cT/LbeJ/vwCS/1yfK3J4OUCk2NAXoDt
 8nXQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779850297; x=1780455097; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WCk6AhWtJfOyvuGJlXvmxmIfxIUYrbTjVFvyl7XyjwA=;
 b=dTbBqXOlIukA1JfI6RB4JElatU2vX4pFJy3e3fi5JZjcpye9FSC8kwjnweVs90kTJL
 1wxk0NsB/+H/VljwUq5XhSKttiAlgTfT++DTjKRJbQq82mGhcEhZlbyx/4Q7V+dPteHJ
 y4TsCwurSN4GAsk65G2h8hiQz+4l+B5uEYe4i2MZzXPZtUIW953NHz1zAQpged2tUJ2s
 orMFBq7TKZ3Fa3JmiDGOY9sr10ImD4eFSq8ZixkShxT8nD18JcuXm1UTTEoKSWPD6hxA
 41FhyM/4F4hABchTxVgK+FjsBA1VeXknPmJkNNqcUgzAk4JnOfbLkwWiPC0DDWlh8Oyi
 V4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779850297; x=1780455097;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WCk6AhWtJfOyvuGJlXvmxmIfxIUYrbTjVFvyl7XyjwA=;
 b=YF7B9q9G/1Y5jESh595PLAMNTt4H2KHtL+7bOQYgALfqEfM86f5nIINY2w1zV7ziCq
 5dVuuZXbmCyQkqaZZgB9voNOTDbAJ42RSCc24RmtGNvCteBFhVGsbfQMswEPz5ts65K1
 mXNoLQqAhdJlCwOfBZtj2S6f+Nal3ajUrzrnrKD/7D+5VlcFWkyKpxS9ke1sXUB7WYTp
 82NIbs9tMLUC1cBdJLvfNUPYp21opyqbcd5+ylv18EHNcfE5weLT/NL0op72lf6X/bW1
 rXe/4dh0JCvCjqGEVoPnhaAq+cH5CaIx7jH1545d2rbTEWNKwEPhyzWZbi0eZRaSPUTT
 fPEg==
X-Gm-Message-State: AOJu0YwYu5vFCWHPXMcsCGUqKnBGvVAncmU9C46WV+z4QBqyPmMYnR2L
 UjzqqviHGdLntWVb13NnNn5qjikViFdGGhnbYd4eWpRYuCCW+8kdKHJ9SlcAoyOI+pKnmx/UTOH
 yheQ7T4PBPBsMT+Nls156efUDrDQoCks=
X-Gm-Gg: Acq92OFZ1RmoKbUYAYLjlGmZwHBPvwGH1jdIjanrapTgKW0NDDq484i0JDj5KrI1+K5
 F/sN0SRFwm2a3oALaUL+k0gOb23fOMnYA4WKUb8dfQircaOeYqaU0mvG27t7Zw6rK8DBkulSipT
 NonJX4nORvM4ldG0XhVvXRbaA9deAp995CR/IPSRN9BB2ftFb+xsiUNvwK5v3Q1Ce1xRj54I7DG
 vkG4p4c1cpgKK0URwyxC28sErQVIjT2lqppCHIP3VZlO5Lhl7SvgqJGAweiPolOdKYcn6QWvZYO
 KU8BCd5mhCB7WmVk
X-Received: by 2002:a2e:bd86:0:b0:393:975b:5634 with SMTP id
 38308e7fff4ca-395d8c0f870mr95124411fa.11.1779850297134; Tue, 26 May 2026
 19:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1779792111.git.fritchleybohrer@gmail.com>
 <c33bea8085f103db209eaf06f978297bba727d88.1779792111.git.fritchleybohrer@gmail.com>
 <4e562850-06c3-48f0-9023-d1c5df71e828@linaro.org>
 <c254529af5aee1c33bc143ad72d79839231465f1.camel@wdc.com>
In-Reply-To: <c254529af5aee1c33bc143ad72d79839231465f1.camel@wdc.com>
From: Zephyr Li <fritchleybohrer@gmail.com>
Date: Wed, 27 May 2026 10:51:22 +0800
X-Gm-Features: AVHnY4L3hvD0DltQ-Gjxrd3cvs-VE7Q28jXvhsJjQF_thzmDhkBaQOLgo5GMqXI
Message-ID: <CAN4PorV7mPptdABf08XAeh++xR6Vg43sFGdY_M8pJAGTg5MYVg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] target/riscv: Reject x-misa-w without TCG
To: Alistair Francis <Alistair.Francis@wdc.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, 
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>, 
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, 
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="000000000000b6d11b0652c3b0db"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-lj1-x243.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000b6d11b0652c3b0db
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Philippe and Alistair.

I see, I misunderstood the stub suggestion and also treated
riscv_cpu_validate_set_extensions() too much as a TCG-only helper.

I'll take another look at the validation logic. If the checks are common
architecture feature restrictions, I'll avoid hiding the helper behind a
no-TCG unreachable stub and instead try to move or split the validation
so the common part is available outside TCG as well.

If I still need to reject some no-TCG configuration, I'll make the reason
explicit in the commit message.

Thanks,
Zephyr

On Wed, May 27, 2026 at 7:52=E2=80=AFAM Alistair Francis <Alistair.Francis@=
wdc.com>
wrote:

> On Tue, 2026-05-26 at 14:19 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 26/5/26 13:04, Zephyr Li wrote:
> > > Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
> > > ---
> > >   target/riscv/cpu.c         |  7 +++++++
> > >   target/riscv/tcg/tcg-cpu.h | 10 ++++++++++
> > >   2 files changed, 17 insertions(+)
> > >
> > > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > > index 1dea66972d..8f54610097 100644
> > > --- a/target/riscv/cpu.c
> > > +++ b/target/riscv/cpu.c
> > > @@ -955,6 +955,13 @@ static void riscv_cpu_realize(DeviceState
> > > *dev, Error **errp)
> > >       RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(dev);
> > >       Error *local_err =3D NULL;
> > >
> > > +#ifndef CONFIG_TCG
> > > +    if (cpu->cfg.misa_w) {
> > > +        error_setg(errp, "x-misa-w requires TCG");
> > > +        return;
> > > +    }
> > > +#endif
> > > +
> > >       cpu_exec_realizefn(cs, &local_err);
> > >       if (local_err !=3D NULL) {
> > >           error_propagate(errp, local_err);
> > > diff --git a/target/riscv/tcg/tcg-cpu.h b/target/riscv/tcg/tcg-
> > > cpu.h
> > > index a23716a5ac..20ad294f88 100644
> > > --- a/target/riscv/tcg/tcg-cpu.h
> > > +++ b/target/riscv/tcg/tcg-cpu.h
> > > @@ -22,7 +22,17 @@
> > >
> > >   #include "cpu.h"
> > >
> > > +#ifdef CONFIG_TCG
> > >   void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error
> > > **errp);
> > > +#else
> > > +static inline void riscv_cpu_validate_set_extensions(RISCVCPU
> > > *cpu,
> > > +                                                     Error **errp)
> > > +{
> > > +    (void)cpu;
> > > +    (void)errp;
> > > +    qemu_build_not_reached();
> >
> > By stub I meant a new unit file added to the stub_ss[] meson source
> > set.
> >
> > Anyway, I'm not familiar enough with RISCV but if it works similarly
> > to
> > ARM I'd expect an accelerated 'host' CPU type to have all host-
> > enabled
> > features, with the ability to deselect few of them. In that case, the
> > riscv_cpu_validate_set_extensions() helper wouldn't be TCG specific
> > (since validating the architecture restrictions).
>
> Agreed. This at least needs a commit comment describing why this should
> be disabled
>
> Alistair
>
> >
> > If you need accelerator-specific CPU feature validators, you could
> > dispatch in riscv_cpu_validate_set_extensions, eventually expanding
> > AccelOpsClass.
> >
> > > +}
> > > +#endif
> > >   void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error
> > > **errp);
> > >   bool riscv_cpu_tcg_compatible(RISCVCPU *cpu);
> > >
>

--000000000000b6d11b0652c3b0db
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Philippe and Alistair.<br><br>I see, I misunderstoo=
d the stub suggestion and also treated<br>riscv_cpu_validate_set_extensions=
() too much as a TCG-only helper.<br><br>I&#39;ll take another look at the =
validation logic. If the checks are common<br>architecture feature restrict=
ions, I&#39;ll avoid hiding the helper behind a<br>no-TCG unreachable stub =
and instead try to move or split the validation<br>so the common part is av=
ailable outside TCG as well.<br><br>If I still need to reject some no-TCG c=
onfiguration, I&#39;ll make the reason<br>explicit in the commit message.<b=
r><br>Thanks,<br>Zephyr</div><br><div class=3D"gmail_quote gmail_quote_cont=
ainer"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 27, 2026 at 7:52=
=E2=80=AFAM Alistair Francis &lt;<a href=3D"mailto:Alistair.Francis@wdc.com=
">Alistair.Francis@wdc.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On Tue, 2026-05-26 at 14:19 +0200, Philippe Mathi=
eu-Daud=C3=A9 wrote:<br>
&gt; On 26/5/26 13:04, Zephyr Li wrote:<br>
&gt; &gt; Signed-off-by: Zephyr Li &lt;<a href=3D"mailto:fritchleybohrer@gm=
ail.com" target=3D"_blank">fritchleybohrer@gmail.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt; =C2=A0 target/riscv/cpu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 7 +++++++<br>
&gt; &gt; =C2=A0 target/riscv/tcg/tcg-cpu.h | 10 ++++++++++<br>
&gt; &gt; =C2=A0 2 files changed, 17 insertions(+)<br>
&gt; &gt; <br>
&gt; &gt; diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c<br>
&gt; &gt; index 1dea66972d..8f54610097 100644<br>
&gt; &gt; --- a/target/riscv/cpu.c<br>
&gt; &gt; +++ b/target/riscv/cpu.c<br>
&gt; &gt; @@ -955,6 +955,13 @@ static void riscv_cpu_realize(DeviceState<br=
>
&gt; &gt; *dev, Error **errp)<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RISCVCPUClass *mcc =3D RISCV_CPU_G=
ET_CLASS(dev);<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;<br>
&gt; &gt; =C2=A0 <br>
&gt; &gt; +#ifndef CONFIG_TCG<br>
&gt; &gt; +=C2=A0=C2=A0=C2=A0 if (cpu-&gt;cfg.misa_w) {<br>
&gt; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, &quo=
t;x-misa-w requires TCG&quot;);<br>
&gt; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;<br>
&gt; &gt; +=C2=A0=C2=A0=C2=A0 }<br>
&gt; &gt; +#endif<br>
&gt; &gt; +<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_exec_realizefn(cs, &amp;local_=
err);<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (local_err !=3D NULL) {<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_prop=
agate(errp, local_err);<br>
&gt; &gt; diff --git a/target/riscv/tcg/tcg-cpu.h b/target/riscv/tcg/tcg-<b=
r>
&gt; &gt; cpu.h<br>
&gt; &gt; index a23716a5ac..20ad294f88 100644<br>
&gt; &gt; --- a/target/riscv/tcg/tcg-cpu.h<br>
&gt; &gt; +++ b/target/riscv/tcg/tcg-cpu.h<br>
&gt; &gt; @@ -22,7 +22,17 @@<br>
&gt; &gt; =C2=A0 <br>
&gt; &gt; =C2=A0 #include &quot;cpu.h&quot;<br>
&gt; &gt; =C2=A0 <br>
&gt; &gt; +#ifdef CONFIG_TCG<br>
&gt; &gt; =C2=A0 void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Erro=
r<br>
&gt; &gt; **errp);<br>
&gt; &gt; +#else<br>
&gt; &gt; +static inline void riscv_cpu_validate_set_extensions(RISCVCPU<br=
>
&gt; &gt; *cpu,<br>
&gt; &gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0=C2=A0=C2=A0 (void)cpu;<br>
&gt; &gt; +=C2=A0=C2=A0=C2=A0 (void)errp;<br>
&gt; &gt; +=C2=A0=C2=A0=C2=A0 qemu_build_not_reached();<br>
&gt; <br>
&gt; By stub I meant a new unit file added to the stub_ss[] meson source<br=
>
&gt; set.<br>
&gt; <br>
&gt; Anyway, I&#39;m not familiar enough with RISCV but if it works similar=
ly<br>
&gt; to<br>
&gt; ARM I&#39;d expect an accelerated &#39;host&#39; CPU type to have all =
host-<br>
&gt; enabled<br>
&gt; features, with the ability to deselect few of them. In that case, the<=
br>
&gt; riscv_cpu_validate_set_extensions() helper wouldn&#39;t be TCG specifi=
c<br>
&gt; (since validating the architecture restrictions).<br>
<br>
Agreed. This at least needs a commit comment describing why this should<br>
be disabled<br>
<br>
Alistair<br>
<br>
&gt; <br>
&gt; If you need accelerator-specific CPU feature validators, you could<br>
&gt; dispatch in riscv_cpu_validate_set_extensions, eventually expanding<br=
>
&gt; AccelOpsClass.<br>
&gt; <br>
&gt; &gt; +}<br>
&gt; &gt; +#endif<br>
&gt; &gt; =C2=A0 void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error<=
br>
&gt; &gt; **errp);<br>
&gt; &gt; =C2=A0 bool riscv_cpu_tcg_compatible(RISCVCPU *cpu);<br>
&gt; &gt; =C2=A0 <br>
</blockquote></div>

--000000000000b6d11b0652c3b0db--

