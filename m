Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F9ACFA471
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 05:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMJNW-0001nm-J8; Fri, 21 Nov 2025 00:08:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vMJNB-0001mM-9a
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 00:07:55 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vMJN6-0007cc-IJ
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 00:07:53 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b72cbc24637so291697066b.0
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 21:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1763701663; x=1764306463; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DTSbMUov2pjukjGphiofxGDq18oZxGzUXhTQ5QEf5hI=;
 b=VniNUPuQnrJ3EVWA2QudzIPrB8WXqYj7lgaOvBBPeJaaKTi7IgORUMyZeJQjjmbWRF
 rYsIxBSiGOkS+U1k4xKv/oGHhTLvZdsicpsH7yoK38F0Kjnn1Mov+OdYmhDF5NmSd+E0
 +1xAi3dbNAJiVa0yBLWW5Anvw01Qz615QU0S5d5tW7m1wcXfmRwRdGfjt+K2Chc1O0Ym
 hPgKwdaWGzJnV+SeJscb0OuU8WDIdeB9GEkusdxgDJnMxDZiFHSC0/36zzKoqbvwklmD
 r/PBa2H4Hh8xFCiAOw1oX6dGNA3kt28RjMyWVvLR7dk9Bn/U/hfqfLwHgXPSemV+BZ1A
 1B3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763701663; x=1764306463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DTSbMUov2pjukjGphiofxGDq18oZxGzUXhTQ5QEf5hI=;
 b=gzpYG4geqiyrJINMQBsAF/e+LvK7jduGPha1y3U4pTgFXIgSLCDdrRQ/XdhncUFUmo
 ZqeEpPmusntkItxfb9mlKf5y1LLEHwFBCsVVHHYG3hxoS0evqWYqKtIr1MP/yFniilHm
 D5ko4i0/M+a64fbOzWUrqfU15bc9rBj7i62bTEgtucUNtdlwl6ZjUwt3h/nAoNqbyZ/z
 aZ6ZtYEVa7ryvnTtnnVLBA8kSwT5jM75Vl1IOtlq9StccG3SIIA6ZSqH2JkzZHa4ran3
 I3d++j1XBP+Pj/JQn8HK0z0ggC68LBhYCspol336LGyMkl106CgwxxXgOP+Jje6W4WEi
 D8aA==
X-Gm-Message-State: AOJu0Yxyb8Io9bbIjEtUPizZvwm8f4uD8bPW/4yk9ClBzE6zy9UyLwLl
 9hicDTTTDm9EEW0lGZYiLEsLVNkqP4inH1oZxlS3SVPrCdqLkQPi9NlrfLbO06XrRkpqEQtVz1/
 bJiO+zNpPXs0YNjxR6d4hfXkiSjmhxprbeJ4yTVt7xQ==
X-Gm-Gg: ASbGnctfhzJ9wqlSSL4KdU8lbNrpx0LBQTai84hUYf4LnwY8kcsIjJBJYMPsS0VYcjV
 5fgu68avMAGGH3j/N9NEybgV6+Qfq6+aCDSEcDIjmV8gOXcdEDFChdYaZ3ZE92D830nvPBTf1bf
 WJLK2MWm7OWpWtfAUbnAkI53y+XbO2gn/DJ50bUOdUoWySVaSKggWxKkrpRJy6Lx/R0XKW7x3E5
 HJgEzzacrROAWjyVDO35zgXKC5cLXdd5uXbs+9P2MmWvlyCZA2y6q5XdxyRAcTP71Glyj2cpQ==
X-Google-Smtp-Source: AGHT+IHSTytDzanijA5kQFXdaL4mlaydhSKgklENn5wRKhpuwMhoewNjTMRI0gW/m/SIYhDpPhEdXaP3pF0A+mvAuy8=
X-Received: by 2002:a17:907:6e9e:b0:b72:56ad:c9c0 with SMTP id
 a640c23a62f3a-b76717008e6mr90169666b.17.1763701662907; Thu, 20 Nov 2025
 21:07:42 -0800 (PST)
MIME-Version: 1.0
References: <20251118105936.2839054-1-frank.chang@sifive.com>
 <20251118105936.2839054-3-frank.chang@sifive.com>
 <DEBV4FNF28A7.5SB1P3YUJTA@ventanamicro.com>
In-Reply-To: <DEBV4FNF28A7.5SB1P3YUJTA@ventanamicro.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Fri, 21 Nov 2025 13:07:31 +0800
X-Gm-Features: AWmQ_blTodJTNNZwSbGBArWgCX6HA2iArnFxVFqQhqotsgY98an74k2CVajvRJs
Message-ID: <CAE_xrPi_TKWJZJ-bzJNYsRLH_g9fz25Sk6Z9H-ksByxL7xH4VQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] target/riscv: Fix pointer masking PMM field selection
 logic
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>, 
 qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000001b8eec064413cbed"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=frank.chang@sifive.com; helo=mail-ej1-x62a.google.com
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

--0000000000001b8eec064413cbed
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 9:42=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcma=
r@ventanamicro.com>
wrote:

> 2025-11-18T18:59:35+08:00, <frank.chang@sifive.com>:
> > From: Frank Chang <frank.chang@sifive.com>
> >
> > mstatus.MPV only records the previous virtualization state, and does no=
t
> > affect pointer masking according to the Zjpm specification.
> >
> > This patch rewrites riscv_pm_get_pmm() to follow the architectural
> > definition of Smmpm, Smnpm, and Ssnpm.
> >
> > The resulting PMM source for each mode is summarized below:
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
> > ---
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > @@ -154,22 +154,30 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
> >          }
> >          break;
> >      case PRV_S:
> > -        if (riscv_cpu_cfg(env)->ext_smnpm) {
> > -            if (get_field(env->mstatus, MSTATUS_MPV)) {
> > -                return get_field(env->henvcfg, HENVCFG_PMM);
> > -            } else {
> > +        if (!env->virt_enabled) {
> > +            if (riscv_cpu_cfg(env)->ext_smnpm) {
>
> It wasn't correct before, but it doesn't seem correct now either.
> MPRV+MPV+MPP change the effective access mode to VS without setting
> virt_enabled, and henvcfg is supposed to be used in that case.
>

Hi Radim,

Thanks for the review.

I've sent out the v2 patchset to address these issues:
https://lore.kernel.org/qemu-riscv/20251121050413.3718427-1-frank.chang@sif=
ive.com/

Regards,
Frank Chang


>
> I liked the way you described the desired behavior in the commit
> message:
>
>   M-mode:  mseccfg.PMM
>   S-mode:  menvcfg.PMM
>   U-mode:  senvcfg.PMM
>   VS-mode: henvcfg.PMM
>   VU-mode: senvcfg.PMM
>
> Can we have a "switch (get_effective_access_mode(env))" with the same
> structure?
>
> Thanks.
>
> ---
> Other bugs I noticed while skimming the adjust_addr_body() and
> riscv_pm_get_pmm():
> * Sign extension for HLV/HSV must be performed when vsatp.MODE !=3D Bare.
> * The sign extension also depends on the effective mode, and not on the
>   current mode.
> * MXR should set PMLEN=3D0 for all accesses that aren't M to M, not just
>   when using MPRV.
>

--0000000000001b8eec064413cbed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>On Tue, Nov 18, 2025 at 9:42=E2=80=AFPM Radim Kr=C4=
=8Dm=C3=A1=C5=99 &lt;<a href=3D"mailto:rkrcmar@ventanamicro.com">rkrcmar@ve=
ntanamicro.com</a>&gt; wrote:</div><div class=3D"gmail_quote gmail_quote_co=
ntainer"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">2025-11-18T18:59=
:35+08:00, &lt;<a href=3D"mailto:frank.chang@sifive.com" target=3D"_blank">=
frank.chang@sifive.com</a>&gt;:<br>
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
&gt; The resulting PMM source for each mode is summarized below:<br>
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
&gt; ---<br>
&gt; diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c<br>
&gt; @@ -154,22 +154,30 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case PRV_S:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (riscv_cpu_cfg(env)-&gt;ext_smnpm) {<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_field(env-&gt;mstat=
us, MSTATUS_MPV)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return get_fi=
eld(env-&gt;henvcfg, HENVCFG_PMM);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!env-&gt;virt_enabled) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (riscv_cpu_cfg(env)-&gt;=
ext_smnpm) {<br>
<br>
It wasn&#39;t correct before, but it doesn&#39;t seem correct now either.<b=
r>
MPRV+MPV+MPP change the effective access mode to VS without setting<br>
virt_enabled, and henvcfg is supposed to be used in that case.<br></blockqu=
ote><div><br></div><div>Hi Radim,</div><div><br></div><div>Thanks for the=
=C2=A0review.</div><div><br></div><div>I&#39;ve sent out the v2 patchset to=
 address these issues:</div><a href=3D"https://lore.kernel.org/qemu-riscv/2=
0251121050413.3718427-1-frank.chang@sifive.com/">https://lore.kernel.org/qe=
mu-riscv/20251121050413.3718427-1-frank.chang@sifive.com/</a><br><div><br><=
/div><div>Regards,</div><div>Frank Chang</div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<br>
I liked the way you described the desired behavior in the commit<br>
message:<br>
<br>
=C2=A0 M-mode:=C2=A0 mseccfg.PMM<br>
=C2=A0 S-mode:=C2=A0 menvcfg.PMM<br>
=C2=A0 U-mode:=C2=A0 senvcfg.PMM<br>
=C2=A0 VS-mode: henvcfg.PMM<br>
=C2=A0 VU-mode: senvcfg.PMM<br>
<br>
Can we have a &quot;switch (get_effective_access_mode(env))&quot; with the =
same<br>
structure?<br>
<br>
Thanks.<br>
<br>
---<br>
Other bugs I noticed while skimming the adjust_addr_body() and<br>
riscv_pm_get_pmm():<br>
* Sign extension for HLV/HSV must be performed when vsatp.MODE !=3D Bare.<b=
r>
* The sign extension also depends on the effective mode, and not on the<br>
=C2=A0 current mode.<br>
* MXR should set PMLEN=3D0 for all accesses that aren&#39;t M to M, not jus=
t<br>
=C2=A0 when using MPRV.<br>
</blockquote></div></div>

--0000000000001b8eec064413cbed--

