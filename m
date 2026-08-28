Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CB3C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 17:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x00mY-0000hU-5k; Fri, 28 Aug 2026 13:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x00mW-0000hM-Io
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 13:54:24 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x00mT-0000Sz-Hf
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 13:54:24 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c2544ff970dso187862566b.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 10:54:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787939660; cv=none;
 d=google.com; s=arc-20260327;
 b=Dxzt92OZjIoix4MeG27X9zhVuRqYZdTVt3d/WOXtNfn+h8e5hqpPxd8RdUDuxBAWRl
 ByRSM0OIWjmzCy8pAZujxSkpVNXQnduxqYm4GfZ4T+Cufo+d/dALcQAGM9kzbaI9x1zD
 CpRaWmcJch+VEeXkrOYqYWsENECftJ6zLicPPhSL3OfpXVnzY05IXQ3+ef18nCU/Ab9R
 NcQ5c+Nn89y1e3WC/eHZHh91YWZca5CTz0KSeyDbh13nVNNlvYwYffFUOdB52gF5FSyT
 Qxcq6PHgrtJhHAIwg5oy690E7LQPr0koHT5sIlaFxzAJ8bliOdAn/hW4XbSN06XHyWEX
 pvuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DBwN8Mp6cW07lj7ZIAWJz2LNuYIdk/COVrrrdMER2gA=;
 fh=8YDWES56AuShO05lvkeo9BAZUyS+9TOk+iL2zufTinA=;
 b=NrlwnngmtcUbVFKqOc2p66D3YDdfwxYq+iN48o6Is8Uajs/W6v5Hv/W7huB79gSobR
 hLds43d+HxBbtzTpXNBsexLHP0pvX9Wllp1+7IZocv/FQxNaqCgU1FhMqU71kw2CmaU8
 7QP2WZe9DWm0RwWo9e5E8A82SDTj4nEj+IaRnlFSiyjDDYQ8NpQDSUTobOrwK5AVa5a3
 LHb4eY+jpE180IH2tZbSMmAAgO9yjVXverGrbogjSjcmeB1OmjrgEZmXL6cXl2+Pb9mP
 YmGKT6AIb4/xThApFg1dP9xk/VPGCmNinvJakV0RO4RGrow90rYeOu4iiu5Kxk+bspzH
 ewmw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787939660; x=1788544460; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DBwN8Mp6cW07lj7ZIAWJz2LNuYIdk/COVrrrdMER2gA=;
 b=LSA3jqTiiFvoZFrxG7zswzZlgfh/KGbuTCBFto4bRb64xmzU+nxwtnAwBRcIRs64kc
 ecwewTFzYETLcUDJPhf/mq3cE8/Fe2tiFNCNJ2lRo0bPNh3nA+98yX/FWl01ZaLrIKyi
 QEpFdoz/bTNNJ8OiYhicZuSwwRUBst2d7xPaK7M2hHpGkRjGduh7EsdS5ZkwrXbylYwE
 sz98PkC/cBbIDA6NzmiYOTez6N24YghDD4Yoll+s3EEB6rDo90gfdHpeQdd04OKNee3D
 hNkabJLlBMioqrK3soa/pVrMZFda4DqKVy3qukf5qx8YKzMgub9/W8WSU9gWvWmDbSUc
 vT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787939660; x=1788544460;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DBwN8Mp6cW07lj7ZIAWJz2LNuYIdk/COVrrrdMER2gA=;
 b=p4BJyUN8UEUOVVhQ762MruLdk7rAkJxP4bKMcOw4zW9Tm+ZRNn+zCCuKCFBLVEkzl3
 oyVeKQLDLdMqvOK9MLNkdS5oo5c8Lnk06N7WawGTbW0G7972AbD2tPOCDaMSb4MW674c
 +7eR9beuoGNBe8tsC0alqxQwm+vJhz8BEvjDLtu59oH87uKVMVOjHTfIX72p19tnsuDl
 5tgtV3qOrNsvjSw3+E8uVEl9paPrAAJSlPNIoBHEbAsCBW1nv0t8/Dr1tD7J5aRvJD2x
 nv+nBZSYdgOPT3Y40m8G3ciUKn42zuQuM4M9CREZSdR1aTE3yZh6cyxFtpa7abpIYRd8
 EbrA==
X-Gm-Message-State: AFuF++nlZsUwNKfyz4nbJLJ/HbzN1u6osZLYfUrdfv96mDAjHkdc09wN
 W3r1KCn3exQU3biitEqpSZCRlkCfZg4NyJ0R/AZUUXaasREuOoi7VtiDa0mMFYGAbsUgdOReaRB
 8sUx+yWLHng1FzmDmtkQcqeT4h0ZdKX4=
X-Gm-Gg: AR+sD10vNt36xr2+anvO0KYraYA3+1W4zWgn1PQkWe2oPenImO92ph5IrO65macy9Ok
 EmzH30DYzogYbBVjGRxc1AzeXtsvh9cvIRsthKioyos2kuC8ms0QUdMlVt5KYXgw5MWzOPRURRB
 ei6PGHbudw0g6ct2bSu7HHpyFxKRMz8PUWJ1dFlaFyNGe0Hy/ZzU05zMyDGrqkZpZRXGzM0a7KW
 r/751sYEQEQiuoyxVx82k6v9Y8jCvR/a+Jl1h0rdfUTqITzYQrxxLGCDEd5vQMOKJiIklrZByI6
 nc/ytl/z2O3LlFXwoTB+nZw91p2Kt2TRrTzj3DgwMHciPg==
X-Received: by 2002:a17:906:9c95:b0:c21:450d:cd7e with SMTP id
 a640c23a62f3a-c2556c6409emr640106866b.9.1787939659423; Fri, 28 Aug 2026
 10:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE8g0nAJPoJvjZGR_KpEAo+C+S7+QTdZGhagBQE_diDXcw@mail.gmail.com>
 <a38bf9f3-cbdb-43bd-9753-924b30c02db4@oss.qualcomm.com>
In-Reply-To: <a38bf9f3-cbdb-43bd-9753-924b30c02db4@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Sat, 29 Aug 2026 01:54:07 +0800
X-Gm-Features: AcwNN1W4V44bDHHXPwsupgLYtjL_A5VCj2MHfM-d8FdLZ7lMpOHE3Fg8wTjDsJk
Message-ID: <CAE2XoE-we=__uHK3QfYeTRBbePmRFOXSFY_E0ZFZwc-rvODDcw@mail.gmail.com>
Subject: Re: [PATCH 00/27] single-binary: implement dynamic filtering for
 machine types
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-level <qemu-devel@nongnu.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, 
 Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: multipart/alternative; boundary="00000000000047a504065a1f2499"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej1-x62d.google.com
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--00000000000047a504065a1f2499
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

can we use both=EF=BC=9F first is the enum=EF=BC=8C  then the is_available =
handler.

         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> =E4=BA=8E 2026=E5=B9=
=B48=E6=9C=8829=E6=97=A5=E5=91=A8=E5=85=AD 01:10=E5=86=99=E9=81=93=EF=BC=9A

> On 8/28/2026 2:51 AM, Yonggang Luo wrote:
> >
> >
> > On Fri, Jul 24, 2026 at 8:11=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com
> > <mailto:pierrick.bouvier@oss.qualcomm.com>> wrote:
> >>
> >> Now that we can link a single-binary with at least two targets (arm,
> > aarch64),
> >> we want to make sure that we expose the same set of machines (later
> > devices and
> >> cpus) than target binaries. For that, we implemented a static
> > filtering based on
> >> target interfaces that each machine will implement to declare which
> > targets have
> >> this machine.
> >>
> >> However, we discovered that this static filtering is not enough.
> > Indeed, some
> >> machines and devices do not depend only on target, and their presence
> > can depend
> >> on Kconfig or host/target combination. Thus, our static approach can't
> > work, and
> >> we need something more flexible.
> >>
> >> This series adds a new TYPE_TARGET_SPECIFIC, that declare a single
> > function
> >> bool is_available(void). From there, any machine type (and later
> > devices and
> >> cpus) can implement it to override their presence for each target.
> >> We first replace the existing static mechanism with this, and once
> > done, we
> >> cleanup all the old interface. One nice benefit is that we can get rid
> of
> >> config/targets/*.c files, which saves duplication.
> >
> >
> >   About target-filtering, we already have
> >
> > enum {
> >     QEMU_ARCH_ALPHA =3D       (1UL << SYS_EMU_TARGET_ALPHA),
> >     QEMU_ARCH_ARM =3D         (1UL << SYS_EMU_TARGET_ARM) |
> >                             (1UL << SYS_EMU_TARGET_AARCH64),
> >     QEMU_ARCH_I386 =3D        (1UL << SYS_EMU_TARGET_I386) |
> >                             (1UL << SYS_EMU_TARGET_X86_64),
> >     QEMU_ARCH_M68K =3D        (1UL << SYS_EMU_TARGET_M68K),
> >     QEMU_ARCH_MICROBLAZE =3D  (1UL << SYS_EMU_TARGET_MICROBLAZE),
> >     QEMU_ARCH_MIPS =3D        (1UL << SYS_EMU_TARGET_MIPS) |
> >                             (1UL << SYS_EMU_TARGET_MIPSEL) |
> >                             (1UL << SYS_EMU_TARGET_MIPS64) |
> >                             (1UL << SYS_EMU_TARGET_MIPS64EL),
> >     QEMU_ARCH_PPC =3D         (1UL << SYS_EMU_TARGET_PPC) |
> >                             (1UL << SYS_EMU_TARGET_PPC64),
> >     QEMU_ARCH_S390X =3D       (1UL << SYS_EMU_TARGET_S390X),
> >     QEMU_ARCH_SH4 =3D         (1UL << SYS_EMU_TARGET_SH4) |
> >                             (1UL << SYS_EMU_TARGET_SH4EB),
> >     QEMU_ARCH_SPARC =3D       (1UL << SYS_EMU_TARGET_SPARC) |
> >                             (1UL << SYS_EMU_TARGET_SPARC64),
> >     QEMU_ARCH_XTENSA =3D      (1UL << SYS_EMU_TARGET_XTENSA) |
> >                             (1UL << SYS_EMU_TARGET_XTENSAEB),
> >     QEMU_ARCH_OR1K =3D        (1UL << SYS_EMU_TARGET_OR1K),
> >     QEMU_ARCH_TRICORE =3D     (1UL << SYS_EMU_TARGET_TRICORE),
> >     QEMU_ARCH_HPPA =3D        (1UL << SYS_EMU_TARGET_HPPA),
> >     QEMU_ARCH_RISCV =3D       (1UL << SYS_EMU_TARGET_RISCV32) |
> >                             (1UL << SYS_EMU_TARGET_RISCV64),
> >     QEMU_ARCH_RX =3D          (1UL << SYS_EMU_TARGET_RX),
> >     QEMU_ARCH_AVR =3D         (1UL << SYS_EMU_TARGET_AVR),
> >     QEMU_ARCH_HEXAGON =3D     (1UL << SYS_EMU_TARGET_HEXAGON),
> >     QEMU_ARCH_LOONGARCH =3D   (1UL << SYS_EMU_TARGET_LOONGARCH64),
> >     QEMU_ARCH_ALL =3D         UINT32_MAX,
> > };
> >
> > Can we use this to do target filtering instead? And we can extend this
> > to maximal uint128_t to support maximal 128 targets in future, so it's
> > not a burden to use it as a enum
> >
> > and for arm or mips we can use QEMU_ARCH_ARM QEMU_ARCH_MIPS  to support
> > multiple targets in a single integer.
> >
>
> It's not enough, as some types depend on target config, and not only on
> target itself. That's why this series exist, because I wrongly assumed
> target would be enough when designing the original filtering, and it
> proved to be insufficient.
>
> Concrete examples here are x-remote and nitro machines.
>
> >
> >
> > --
> >          =E6=AD=A4=E8=87=B4
> > =E7=A4=BC
> > =E7=BD=97=E5=8B=87=E5=88=9A
> > Yours
> >     sincerely,
> > Yonggang Luo
>
>

--00000000000047a504065a1f2499
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>can we use both=EF=BC=9F first is the enum=EF=BC=8C=
=C2=A0 then the is_available handler.</div><div><br></div><div data-smartma=
il=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=B4=
<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sinc=
erely,<br>Yonggang Luo<br></div></div><br><div class=3D"gmail_quote gmail_q=
uote_container"><div dir=3D"ltr" class=3D"gmail_attr">Pierrick Bouvier &lt;=
<a href=3D"mailto:pierrick.bouvier@oss.qualcomm.com">pierrick.bouvier@oss.q=
ualcomm.com</a>&gt; =E4=BA=8E 2026=E5=B9=B48=E6=9C=8829=E6=97=A5=E5=91=A8=
=E5=85=AD 01:10=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">On 8/28/2026 2:51 AM, Yonggang Luo wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Fri, Jul 24, 2026 at 8:11=E2=80=AFAM Pierrick Bouvier<br>
&gt; &lt;<a href=3D"mailto:pierrick.bouvier@oss.qualcomm.com" target=3D"_bl=
ank" rel=3D"noreferrer">pierrick.bouvier@oss.qualcomm.com</a><br>
&gt; &lt;mailto:<a href=3D"mailto:pierrick.bouvier@oss.qualcomm.com" target=
=3D"_blank" rel=3D"noreferrer">pierrick.bouvier@oss.qualcomm.com</a>&gt;&gt=
; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Now that we can link a single-binary with at least two targets (ar=
m,<br>
&gt; aarch64),<br>
&gt;&gt; we want to make sure that we expose the same set of machines (late=
r<br>
&gt; devices and<br>
&gt;&gt; cpus) than target binaries. For that, we implemented a static<br>
&gt; filtering based on<br>
&gt;&gt; target interfaces that each machine will implement to declare whic=
h<br>
&gt; targets have<br>
&gt;&gt; this machine.<br>
&gt;&gt;<br>
&gt;&gt; However, we discovered that this static filtering is not enough.<b=
r>
&gt; Indeed, some<br>
&gt;&gt; machines and devices do not depend only on target, and their prese=
nce<br>
&gt; can depend<br>
&gt;&gt; on Kconfig or host/target combination. Thus, our static approach c=
an&#39;t<br>
&gt; work, and<br>
&gt;&gt; we need something more flexible.<br>
&gt;&gt;<br>
&gt;&gt; This series adds a new TYPE_TARGET_SPECIFIC, that declare a single=
<br>
&gt; function<br>
&gt;&gt; bool is_available(void). From there, any machine type (and later<b=
r>
&gt; devices and<br>
&gt;&gt; cpus) can implement it to override their presence for each target.=
<br>
&gt;&gt; We first replace the existing static mechanism with this, and once=
<br>
&gt; done, we<br>
&gt;&gt; cleanup all the old interface. One nice benefit is that we can get=
 rid of<br>
&gt;&gt; config/targets/*.c files, which saves duplication.<br>
&gt; <br>
&gt; <br>
&gt; =C2=A0 About target-filtering, we already have=C2=A0<br>
&gt; <br>
&gt; enum {<br>
&gt; =C2=A0 =C2=A0 QEMU_ARCH_ALPHA =3D =C2=A0 =C2=A0 =C2=A0 (1UL &lt;&lt; S=
YS_EMU_TARGET_ALPHA),<br>
&gt; =C2=A0 =C2=A0 QEMU_ARCH_ARM =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1UL &lt;&=
lt; SYS_EMU_TARGET_ARM) |<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1UL &lt;&lt; SYS_EMU_TARGET_AARCH64),<br>
&gt; =C2=A0 =C2=A0 QEMU_ARCH_I386 =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0(1UL &lt;&=
lt; SYS_EMU_TARGET_I386) |<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1UL &lt;&lt; SYS_EMU_TARGET_X86_64),<br>
&gt; =C2=A0 =C2=A0 QEMU_ARCH_M68K =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0(1UL &lt;&=
lt; SYS_EMU_TARGET_M68K),<br>
&gt; =C2=A0 =C2=A0 QEMU_ARCH_MICROBLAZE =3D =C2=A0(1UL &lt;&lt; SYS_EMU_TAR=
GET_MICROBLAZE),<br>
&gt; =C2=A0 =C2=A0 QEMU_ARCH_MIPS =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0(1UL &lt;&=
lt; SYS_EMU_TARGET_MIPS) |<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1UL &lt;&lt; SYS_EMU_TARGET_MIPSEL) |<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1UL &lt;&lt; SYS_EMU_TARGET_MIPS64) |<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1UL &lt;&lt; SYS_EMU_TARGET_MIPS64EL),<br>
&gt; =C2=A0 =C2=A0 QEMU_ARCH_PPC =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1UL &lt;&=
lt; SYS_EMU_TARGET_PPC) |<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1UL &lt;&lt; SYS_EMU_TARGET_PPC64),<br>
&gt; =C2=A0 =C2=A0 QEMU_ARCH_S390X =3D =C2=A0 =C2=A0 =C2=A0 (1UL &lt;&lt; S=
YS_EMU_TARGET_S390X),<br>
&gt; =C2=A0 =C2=A0 QEMU_ARCH_SH4 =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1UL &lt;&=
lt; SYS_EMU_TARGET_SH4) |<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1UL &lt;&lt; SYS_EMU_TARGET_SH4EB),<br>
&gt; =C2=A0 =C2=A0 QEMU_ARCH_SPARC =3D =C2=A0 =C2=A0 =C2=A0 (1UL &lt;&lt; S=
YS_EMU_TARGET_SPARC) |<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1UL &lt;&lt; SYS_EMU_TARGET_SPARC64),<br>
&gt; =C2=A0 =C2=A0 QEMU_ARCH_XTENSA =3D =C2=A0 =C2=A0 =C2=A0(1UL &lt;&lt; S=
YS_EMU_TARGET_XTENSA) |<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1UL &lt;&lt; SYS_EMU_TARGET_XTENSAEB),<br>
&gt; =C2=A0 =C2=A0 QEMU_ARCH_OR1K =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0(1UL &lt;&=
lt; SYS_EMU_TARGET_OR1K),<br>
&gt; =C2=A0 =C2=A0 QEMU_ARCH_TRICORE =3D =C2=A0 =C2=A0 (1UL &lt;&lt; SYS_EM=
U_TARGET_TRICORE),<br>
&gt; =C2=A0 =C2=A0 QEMU_ARCH_HPPA =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0(1UL &lt;&=
lt; SYS_EMU_TARGET_HPPA),<br>
&gt; =C2=A0 =C2=A0 QEMU_ARCH_RISCV =3D =C2=A0 =C2=A0 =C2=A0 (1UL &lt;&lt; S=
YS_EMU_TARGET_RISCV32) |<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1UL &lt;&lt; SYS_EMU_TARGET_RISCV64),<br>
&gt; =C2=A0 =C2=A0 QEMU_ARCH_RX =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1UL =
&lt;&lt; SYS_EMU_TARGET_RX),<br>
&gt; =C2=A0 =C2=A0 QEMU_ARCH_AVR =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1UL &lt;&=
lt; SYS_EMU_TARGET_AVR),<br>
&gt; =C2=A0 =C2=A0 QEMU_ARCH_HEXAGON =3D =C2=A0 =C2=A0 (1UL &lt;&lt; SYS_EM=
U_TARGET_HEXAGON),<br>
&gt; =C2=A0 =C2=A0 QEMU_ARCH_LOONGARCH =3D =C2=A0 (1UL &lt;&lt; SYS_EMU_TAR=
GET_LOONGARCH64),<br>
&gt; =C2=A0 =C2=A0 QEMU_ARCH_ALL =3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 UINT32_MAX=
,<br>
&gt; };<br>
&gt; <br>
&gt; Can we use this to do target filtering instead? And we can extend this=
<br>
&gt; to maximal uint128_t to support maximal 128 targets in future, so it&#=
39;s<br>
&gt; not a burden to use it as a enum<br>
&gt; <br>
&gt; and for arm or mips we can use=C2=A0QEMU_ARCH_ARM=C2=A0QEMU_ARCH_MIPS=
=C2=A0 to support<br>
&gt; multiple targets in a single integer.<br>
&gt;<br>
<br>
It&#39;s not enough, as some types depend on target config, and not only on=
<br>
target itself. That&#39;s why this series exist, because I wrongly assumed<=
br>
target would be enough when designing the original filtering, and it<br>
proved to be insufficient.<br>
<br>
Concrete examples here are x-remote and nitro machines.<br>
<br>
&gt; <br>
&gt; <br>
&gt; --<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>
&gt; =E7=A4=BC<br>
&gt; =E7=BD=97=E5=8B=87=E5=88=9A<br>
&gt; Yours<br>
&gt; =C2=A0 =C2=A0 sincerely,<br>
&gt; Yonggang Luo<br>
<br>
</blockquote></div>

--00000000000047a504065a1f2499--

