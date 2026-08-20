Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0198C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 07:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwxLC-0005d0-En; Thu, 20 Aug 2026 03:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1wwxLA-0005cs-UK
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 03:37:33 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1wwxL8-0002dT-Kk
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 03:37:32 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6b14971e862so315202eaf.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 00:37:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787211449; cv=none;
 d=google.com; s=arc-20260327;
 b=puJyw7DdkkrTEUz0OuDDeit2psH6DTxq056XRIx8FibME1VN09ao89AH4QEhrx5BXw
 gUdzils5VbWItwAqP3X9V5VgyVtzENmRsPmB8zm0tJdpOtb+DU1IxxXgK723uTxPyksQ
 fUq25KEFWgyiYd7EOGU6VPPm0kEsAFEwv4ncTNUlAaY8ZIzcd0EwbhOLFnyaeYQBWtck
 QVWVXM15bCIk2CJ0N6wh2F2uFn7WNQpJyXxa+pLKvMn+LbVQVbGfPSQWkAbtVViBUrRx
 R6ZqaBFEslGAdYjJa6lB1Coefk9hG8UJkivVRhmItjSxCpUsHBaQKuLGFYwb2mj5jT9e
 U2pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mSDG+7alLNMuzqmLjUosyc4ssBIaaH8dl6Tjp9XN0PY=;
 fh=LOst6OIdEaBMuurtzYNBHMLjQ7N+6u1lDyAAXE75Ms4=;
 b=Y+pAKVY/OEQ2/Q4uSq69bZFE9ixUo055u7mQWYDdNz5P1OM2xUYLOcswYdnns3XbH0
 2Gyk/uX6NF6o0eOF/iCGJ8rcY6whojCUSdFGndICssSxMhAN6Q0kFrtmlGwE0XXT/G4k
 jogQQ/lXfc6EANw87G9YN3bbvdiFr8rBa/2GbcWphRcNPinNNuGFyeTNIk+5Dt7Jlmox
 5ldYx+b/evwll9sotXzvtXMxui/Ds2KIFtgw9jYNiNmMXO+Xf/ZogxhvIf3D3wU3UUnA
 d6QnV3RlN4SJSNAdDKFawdqoUNKuCKYU1JPNna1JlSdRq3WJ+G87WfuUlsiLCo+l7Ggt
 2eTg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787211449; x=1787816249; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mSDG+7alLNMuzqmLjUosyc4ssBIaaH8dl6Tjp9XN0PY=;
 b=jmCPCbJW8lyxpkeLVGWxVNIA2AYDcCgY3UA9xHvZBZS9DTaMdi48ovn4J1gaQSZwJ3
 j9ZNBo97AJHOuVgwAtMumQ9cAk+R5THGRemz69I1Ojq/421XgLC3h573pCVcc3jQ5kTf
 rMDoDnWBIxzlI95W8A9OfcO4bgcWbHF0eFGIpEQsQWTTy+MrcaJshlxg6F7SYLumgSpQ
 VsOCzfOahswmfQta3GVQww/biULc5As7rG2YY+o4h8xDGKXX4vC8cS1l7r+6FZH5RRj3
 FRBemTddN3otNyPQnpC8bRjPu+sWXOQOz/jlMisavAloWsXgZJv5qtYQNnuM6LpjEPGv
 JEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787211449; x=1787816249;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mSDG+7alLNMuzqmLjUosyc4ssBIaaH8dl6Tjp9XN0PY=;
 b=N2iaBPRvZMDYpCrU4KT5zyj2qTjEZBhJfgnzgXVBEPsUBdNwwLmQ0gAL6Lo7YlRCYs
 xVibemqOWFZKSiQ3OVfxXkENYssVu2NF2pr1pdRegpilZ2/sVv8bfmF0M5XNvLzfN/zG
 cY6XMYPxoIX0t7hOSuUbFMfVIrF67gfHyckyoEJSBSaRw7xEZbmOJtASoF7YDgqbzrb7
 T1RfEjtHHa57fmWkozfWJ4Gj01eOnwhdytxcjGCGCGgMOQ8CU6IWzpaxOv+pW+biAdki
 ddmSSnfZGEjBIbOeL3gmXd/5mE1b8EASypYG22ocQCHgRT6k1kkmB/CEIG+fzTHgpOEV
 5k4w==
X-Gm-Message-State: AOJu0YwZYku/d/LwKewWVgPpvIYdnWW3Mlwqx9Z3GcYawQCblwypf6Sx
 R4qokQhMb4NZps1E7hnNiSk2tY3vrlXDk8I8FlDPyN3k10lqS4UiuJds3M7RZrSqjJz9a7NFAq8
 8YC0Zd4QqD1BK2zDf7jZgKBmD9ahTe8I=
X-Gm-Gg: AR+sD13LXuee1zQu6toUy3w9jKOqsRAf8A6X5BQ3k1PxxHg+0W+UGiA+oi1myMw638Z
 hjc6S00FhOffx9yWjuLfhW4FPlqM1PvjTK5uG0FyaT3q2K0cWycF+laor/sXmoc54bOc6LHgwOR
 Pw8z8WwcppVgcrcerdZegBLYzxfvCpg4BYdWONJzH0C/4grS2fkpcSpln2W5yGn6HyRlww0b4yt
 QpXvwVefoqzedQ5s8Dq9F+6EG8djQH/qI57EPY5sXAYyunfhujR/nWu2/mtiAmYcTR5TpIrs8Gl
 f7MnVaWt6nnGnRoqTRvvqqOPHkHKPBecpne96SeFkBd/gA==
X-Received: by 2002:a4a:ee06:0:b0:6b1:349a:8e2c with SMTP id
 006d021491bc7-6b14921f899mr3760888eaf.16.1787211449108; Thu, 20 Aug 2026
 00:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260818022225.31801-1-54weasels@gmail.com>
 <20260818022225.31801-4-54weasels@gmail.com>
 <42bbf4b2-8491-0f2a-f8c1-c07870c73189@eik.bme.hu>
In-Reply-To: <42bbf4b2-8491-0f2a-f8c1-c07870c73189@eik.bme.hu>
From: Purr Box <54weasels@gmail.com>
Date: Thu, 20 Aug 2026 00:37:18 -0700
X-Gm-Features: AcwNN1Udi-r2krDgM4ecizEzCm51nlmjrS1ShkH6XY0vZUJL2-oYkENKpJhYTZE
Message-ID: <CAFWf6u--hbXgeCd9_xaOgDPydGtF7-Ao_MOEyuias5u4wZG+Fg@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] target/m68k: Fix NMI pending for Level 7 interrupts
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Content-Type: multipart/alternative; boundary="000000000000900f4406597597a9"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=54weasels@gmail.com; helo=mail-oo1-xc2e.google.com
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

--000000000000900f4406597597a9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zoltan,

nmi_pending captures the edge transition, while pending_level =3D=3D 7 refl=
ects
the current level. Level 7 interrupts are edge-triggered =E2=80=94 only the
transition from a level less than 7 to level 7 initiates an NMI. If we just
tested pending_level =3D=3D 7, then it would act as level-triggered (the SR=
.I <
pending_level check passes on every re-entry from rte as long as Level 7
stays asserted), which violates the spec.

Concretely, nmi_pending:
- Is set true only on the rising edge: level =3D=3D 7 && pending_level !=3D=
 7
- Is cleared after the NMI is taken: nmi_pending =3D false
- Is not re-set if Level 7 remains continuously asserted
This matters on the Sun-3 where the PROM routes the Intersil 7170 clock to
Level 7 (intreg=3D0x81). The IRQC re-evaluates on every clock tick, keeping
pending_level =3D=3D 7. Without the separate edge flag, the CPU would take =
a
spurious NMI on every interrupt check instead of once per tick.

Thanks,
Dan.

On Tue, Aug 18, 2026 at 3:56=E2=80=AFAM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:

> On Mon, 17 Aug 2026, 54weasels wrote:
> > High level description:
> > Level 7 interrupts are Non-Maskable Interrupts (NMI) on the M68k
> architecture. The hardware asserts an NMI only on the rising edge of the
> level 7 signal. The current QEMU implementation treats level 7 like a
> standard level interrupt. This patch ensures proper NMI edge-triggered
> semantics for level 7, which is strictly required by the Sun-3
> keyboard/mouse NMI routing logic.
> >
> > Impact on existing functionality:
> > Corrects NMI edge-triggering for all M68k boards, adhering closely to
> the Motorola specifications. Existing boards will now correctly require a=
n
> edge transition to trigger consecutive NMIs.
> >
> > Context: This patch was originally submitted as part of the monolithic
> Sun-3 Machine Emulation series (
> https://patchew.org/QEMU/20260503015756.99176-1-54weasels@gmail.com/) and
> has been split into atomic components.
> > ---
> > target/m68k/cpu.h       |  1 +
> > target/m68k/helper.c    |  6 ++++++
> > target/m68k/op_helper.c | 14 ++++++--------
> > 3 files changed, 13 insertions(+), 8 deletions(-)
> >
> > diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> > index 7cf3791108..058777b891 100644
> > --- a/target/m68k/cpu.h
> > +++ b/target/m68k/cpu.h
> > @@ -148,6 +148,7 @@ typedef struct CPUArchState {
> >
> >     int pending_vector;
> >     int pending_level;
> > +    bool nmi_pending;
>
> What's the difference between nmi_pending and pending_level =3D=3D 7? If
> nothing do we need a new variable for it or could just test pending_level=
?
>
> Regards,
> BALATON Zoltan
>
> >     /* Fields up to this point are cleared by a CPU reset */
> >     struct {} end_reset_fields;
> > diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> > index 68f523ea84..93739ccda7 100644
> > --- a/target/m68k/helper.c
> > +++ b/target/m68k/helper.c
> > @@ -949,6 +949,12 @@ void m68k_set_irq_level(M68kCPU *cpu, int level,
> uint8_t vector)
> >     CPUState *cs =3D CPU(cpu);
> >     CPUM68KState *env =3D &cpu->env;
> >
> > +    if (level =3D=3D 7 && env->pending_level !=3D 7) {
> > +        env->nmi_pending =3D true;
> > +    } else if (level !=3D 7) {
> > +        env->nmi_pending =3D false;
> > +    }
> > +
> >     env->pending_level =3D level;
> >     env->pending_vector =3D vector;
> >     if (level) {
> > diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
> > index 38f7a68981..30af4a2631 100644
> > --- a/target/m68k/op_helper.c
> > +++ b/target/m68k/op_helper.c
> > @@ -522,14 +522,12 @@ bool m68k_cpu_exec_interrupt(CPUState *cs, int
> interrupt_request)
> > {
> >     CPUM68KState *env =3D cpu_env(cs);
> >
> > -    if (interrupt_request & CPU_INTERRUPT_HARD
> > -        && ((env->sr & SR_I) >> SR_I_SHIFT) < env->pending_level) {
> > -        /*
> > -         * Real hardware gets the interrupt vector via an IACK cycle
> > -         * at this point.  Current emulated hardware doesn't rely on
> > -         * this, so we provide/save the vector when the interrupt is
> > -         * first signalled.
> > -         */
> > +    if (env->nmi_pending) {
> > +        env->nmi_pending =3D false;
> > +        cs->exception_index =3D env->pending_vector;
> > +        do_interrupt_m68k_hardirq(env);
> > +        return true;
> > +    } else if (((env->sr & SR_I) >> SR_I_SHIFT) < env->pending_level) =
{
> >         cs->exception_index =3D env->pending_vector;
> >         do_interrupt_m68k_hardirq(env);
> >         return true;
> >
>

--000000000000900f4406597597a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Zoltan,<br><br>nmi_pending captures the edge transition=
, while pending_level =3D=3D 7 reflects the current level. Level 7 interrup=
ts are edge-triggered =E2=80=94 only the transition from a level less than =
7 to level 7 initiates an NMI. If we just tested pending_level =3D=3D 7, th=
en it would act as level-triggered (the SR.I &lt; pending_level check passe=
s on every re-entry from rte as long as Level 7 stays asserted), which viol=
ates the spec.<br><br>Concretely, nmi_pending:<br>- Is set true only on the=
 rising edge: level =3D=3D 7 &amp;&amp; pending_level !=3D 7<br>- Is cleare=
d after the NMI is taken: nmi_pending =3D false<br>- Is not re-set if Level=
 7 remains continuously asserted<br>This matters on the Sun-3 where the PRO=
M routes the Intersil 7170 clock to Level 7 (intreg=3D0x81). The IRQC re-ev=
aluates on every clock tick, keeping pending_level =3D=3D 7. Without the se=
parate edge flag, the CPU would take a spurious NMI on every interrupt chec=
k instead of once per tick.<br><br>Thanks,<div>Dan.</div></div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Tue, Aug 18, 2026 at 3:56=E2=80=AFAM BALATON Zoltan &lt;<a href=3D"m=
ailto:balaton@eik.bme.hu">balaton@eik.bme.hu</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">On Mon, 17 Aug 2026, 54weasels =
wrote:<br>
&gt; High level description:<br>
&gt; Level 7 interrupts are Non-Maskable Interrupts (NMI) on the M68k archi=
tecture. The hardware asserts an NMI only on the rising edge of the level 7=
 signal. The current QEMU implementation treats level 7 like a standard lev=
el interrupt. This patch ensures proper NMI edge-triggered semantics for le=
vel 7, which is strictly required by the Sun-3 keyboard/mouse NMI routing l=
ogic.<br>
&gt;<br>
&gt; Impact on existing functionality:<br>
&gt; Corrects NMI edge-triggering for all M68k boards, adhering closely to =
the Motorola specifications. Existing boards will now correctly require an =
edge transition to trigger consecutive NMIs.<br>
&gt;<br>
&gt; Context: This patch was originally submitted as part of the monolithic=
 Sun-3 Machine Emulation series (<a href=3D"https://patchew.org/QEMU/202605=
03015756.99176-1-54weasels@gmail.com/" rel=3D"noreferrer" target=3D"_blank"=
>https://patchew.org/QEMU/20260503015756.99176-1-54weasels@gmail.com/</a>) =
and has been split into atomic components.<br>
&gt; ---<br>
&gt; target/m68k/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt; target/m68k/helper.c=C2=A0 =C2=A0 |=C2=A0 6 ++++++<br>
&gt; target/m68k/op_helper.c | 14 ++++++--------<br>
&gt; 3 files changed, 13 insertions(+), 8 deletions(-)<br>
&gt;<br>
&gt; diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h<br>
&gt; index 7cf3791108..058777b891 100644<br>
&gt; --- a/target/m68k/cpu.h<br>
&gt; +++ b/target/m68k/cpu.h<br>
&gt; @@ -148,6 +148,7 @@ typedef struct CPUArchState {<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0int pending_vector;<br>
&gt;=C2=A0 =C2=A0 =C2=A0int pending_level;<br>
&gt; +=C2=A0 =C2=A0 bool nmi_pending;<br>
<br>
What&#39;s the difference between nmi_pending and pending_level =3D=3D 7? I=
f <br>
nothing do we need a new variable for it or could just test pending_level?<=
br>
<br>
Regards,<br>
BALATON Zoltan<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0/* Fields up to this point are cleared by a CPU res=
et */<br>
&gt;=C2=A0 =C2=A0 =C2=A0struct {} end_reset_fields;<br>
&gt; diff --git a/target/m68k/helper.c b/target/m68k/helper.c<br>
&gt; index 68f523ea84..93739ccda7 100644<br>
&gt; --- a/target/m68k/helper.c<br>
&gt; +++ b/target/m68k/helper.c<br>
&gt; @@ -949,6 +949,12 @@ void m68k_set_irq_level(M68kCPU *cpu, int level, =
uint8_t vector)<br>
&gt;=C2=A0 =C2=A0 =C2=A0CPUState *cs =3D CPU(cpu);<br>
&gt;=C2=A0 =C2=A0 =C2=A0CPUM68KState *env =3D &amp;cpu-&gt;env;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 if (level =3D=3D 7 &amp;&amp; env-&gt;pending_level !=
=3D 7) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;nmi_pending =3D true;<br>
&gt; +=C2=A0 =C2=A0 } else if (level !=3D 7) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;nmi_pending =3D false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0env-&gt;pending_level =3D level;<br>
&gt;=C2=A0 =C2=A0 =C2=A0env-&gt;pending_vector =3D vector;<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (level) {<br>
&gt; diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c<br>
&gt; index 38f7a68981..30af4a2631 100644<br>
&gt; --- a/target/m68k/op_helper.c<br>
&gt; +++ b/target/m68k/op_helper.c<br>
&gt; @@ -522,14 +522,12 @@ bool m68k_cpu_exec_interrupt(CPUState *cs, int i=
nterrupt_request)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0CPUM68KState *env =3D cpu_env(cs);<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 if (interrupt_request &amp; CPU_INTERRUPT_HARD<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; ((env-&gt;sr &amp; SR_I) &gt;&=
gt; SR_I_SHIFT) &lt; env-&gt;pending_level) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Real hardware gets the interrupt =
vector via an IACK cycle<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* at this point.=C2=A0 Current emul=
ated hardware doesn&#39;t rely on<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* this, so we provide/save the vect=
or when the interrupt is<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* first signalled.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 if (env-&gt;nmi_pending) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;nmi_pending =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cs-&gt;exception_index =3D env-&gt;pendin=
g_vector;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_interrupt_m68k_hardirq(env);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 } else if (((env-&gt;sr &amp; SR_I) &gt;&gt; SR_I_SHIFT=
) &lt; env-&gt;pending_level) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cs-&gt;exception_index =3D env-&gt;pe=
nding_vector;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_interrupt_m68k_hardirq(env);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
&gt;<br>
</blockquote></div>

--000000000000900f4406597597a9--

