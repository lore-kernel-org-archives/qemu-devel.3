Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86527CD98C5
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 05:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYGkq-0004B6-Mg; Sat, 13 Jun 2026 01:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wYGkp-0004Ar-0D
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 01:17:59 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wYGkm-0001Cp-7Q
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 01:17:58 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bed2b9bfa02so219975166b.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 22:17:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781327873; cv=none;
 d=google.com; s=arc-20240605;
 b=jFs44djhocoTgF37GtGE8dSho8Esym9oDsSSDVQEmJS2hA/hOmheC5JXYbYQMKFD/y
 UOetQ1L7hX4ZS3JCtdqSeJ/7r/qc4SwFDkCqmCa3crqTYFjm6eByfowQk5hdzSwR4T+y
 PLDkc1k57suW+U6Ronzzop7fXUVX1LVQol/S4WGSeLiEzawJDdQnMeveHX6ph/UvvVwR
 yDqISiZAurlclmyUW9hKyr0g8l4G5wz5CUZICYilydxZyjYXS4bG2WAeK7VJJDvs0rsw
 HE48sHwcjYVe5PoUg8nv1uJCcF3en9SS20XDJ8VtZJk6P52g2NzbI14r3bo/19Dt33/S
 7FGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RDj3QVT1rdOi4kEFxEgIgjDtQzMJzkMLnUabvtQLe5U=;
 fh=ilIAX3G+tcfZpT7ytEnnXCpx93tQ810LDBhVCzb4wQk=;
 b=Q4dzsIzgDcVZU1XjYqP/0XBeuysr2kWTFo4yeD9TO8qJ9tHLJ7GEyaTfQP2pctj5eh
 +j3G2kMToFo0IiU3+3t5Q4y8mkToXw2UeafRbI+aR5OO6nhWXs3tWdc7/S9dYktPWehy
 XM7xYa20zcc0NydG1+GNWMdQAkpjZ4Hcrs5eifjca/lGeSUEAV8f+8OX3VjvzfcfX+wB
 xYY4IXR03+VrNnOXRklhmP7cvWddlQ2C95JRovGm+yGEHYsOWYanEKCzBvq7XHrA97GD
 06yjyg6WpBNiMw8zD+eq4s4eStHRlvyiM20ADveeSA5/PrB3yOPeZDHV6LprLpgQJb+B
 4u0w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781327873; x=1781932673; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RDj3QVT1rdOi4kEFxEgIgjDtQzMJzkMLnUabvtQLe5U=;
 b=mscMPf7sBBlom4hEFEZ6Phv0uIZk+2wU0+mcbDufTN7S+x5Yq4BwWu3JlM0bRu5Fm7
 QHGuKwfp+4syckfgpbu4smip1UD7LGLVUnBVsE3y988lP6W+lw8vVQKpk90QrVvl+4AT
 TR4QnZda+SzEWsMl0Xmtbrr6Pky7Vm+MjGx2qta7NpAUnO4zIgwO5Fc/TQKo3zOzQ3KP
 6NcbW65Bdyx8zKmSsgzmUKb3rERz4fjhveoBTBgU9axcCzgI39cWWIewppytxlHM52wj
 qcSTYm52niCaMHT59N9xkBY+VLdsmjGtibE8PRsxMXUyQU+XxF/U7b277r6OqWRwoMrL
 ofTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781327873; x=1781932673;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RDj3QVT1rdOi4kEFxEgIgjDtQzMJzkMLnUabvtQLe5U=;
 b=qAvOAt9M0eP1suq6BjIUwcP8Vwlbo2CukSXO91J+mUjf+KqeKkkn+hjag3LCe6fbsZ
 4TEW/6ypH/Mwg+8mWHyyh8YIgxl174EaHO9oYU9culOoY4EEzf0IjY6qbDCakURnT4H1
 RPDyKsqGj+cBFERyMuSHb9WAW+NTD+sWA3GFIMW1rKK20FGHQaZgYnQMtpAlsOm9Sc84
 EkPV6Wexytul9KcE6USw7pzMZ+TEyuXDqD+XGjDzBnCc2LxEPbegj4K2x6y+jTXzQgEC
 SPASDGGg3sIzRA8oHzP8Gl1pC2mGJ5/pwwe4kyjz8vspXSMFilJTGq59x/WylpvCJeP3
 Q/pw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/B1Amdsw3nTMwClSwF/N5hVYkMGMNY5RVRsxJwgBUNOtwe8FreweoomkGWEK+Xz2NhsQyyDmoTV8BX@nongnu.org
X-Gm-Message-State: AOJu0YwRezFy8qUQuoPobfcjEQpI4UtrWsO+PYaBMLTyrIZOs9R5Ke30
 zqSGLCFezqouhTCBPMcmzvLImsahRufCD9NwaN8UiNC1LAS6IuQn+wrVfRcuETtPV4i37EZ5Lyv
 o6aJE30yGKVI4YqmdYs84wAaia+2wljQ=
X-Gm-Gg: Acq92OHUYGE5GqwCvPKGtGJfRNtpgifvVIguRtDMYn780qjJalEV4qDTmMyogBIrR0a
 328rBWQ58SFUXmBmizVEON36lXujk+XmgOx1dhUKGx3oPTVaitwv6ZFlfZy+uO5Op0hz5Kvshu8
 F5l3C2NTDHuxpxIq2E+b6BVuq8zCgD8zfqTibHrIvVhHRTZ87f9ItZmStEDyoUg5Pr5wNpGPJMI
 p05emNBOCyCPla24SUHgVJvduQ7v9ZPIfxwaYZM7wkcR4OHq+ow1dGdgIvNJjfozGhvEzIDpENR
 yfo=
X-Received: by 2002:a17:907:9997:b0:bdb:805f:e57f with SMTP id
 a640c23a62f3a-bff4961f7b2mr109246266b.1.1781327872829; Fri, 12 Jun 2026
 22:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260605035012.2876664-1-kylefoxaustin.github@gmail.com>
 <CAFEAcA_JpBaHDucOfvc9NYkQhQBu0Py9hULTNcXajUo9gW6VGw@mail.gmail.com>
In-Reply-To: <CAFEAcA_JpBaHDucOfvc9NYkQhQBu0Py9hULTNcXajUo9gW6VGw@mail.gmail.com>
From: kylefoxaustin <kylefoxaustin.github@gmail.com>
Date: Sat, 13 Jun 2026 00:17:42 -0500
X-Gm-Features: AVVi8CdgS-IVnxnNJ_U9mnjYAgaQ3mOQWR-uudE4h-3GIwAMRQou631oa5SkMhw
Message-ID: <CANqqvPcJOA7vKYiq6gU9ai3DYCN0yiwW6S-o2xh2JGQNZtLZnA@mail.gmail.com>
Subject: Re: [PATCH] target/arm: honour CCR.BFHFNMIGN for probed data BusFaults
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000016acb306541bb720"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=kylefoxaustin.github@gmail.com; helo=mail-ej1-x62d.google.com
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

--00000000000016acb306541bb720
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter!
Thanks, great catch.  You're right that the SG stack-word load is an
AccType_NORMAL access and should honour BFHFNMIGN.

I'm working on v2 to incorporate.  Basically v2 adds the check in
v7m_read_sg_stack_word():
on the BusFault path it records BFSR/BFAR as before but, when BFHFNMIGN is
set at negative
execution priority, it completes the access returning UNKNOWN data and
returns true, instead of pending ARMV7M_EXCP_BUS. I left the vector-table,
stacking and unstacking EXCP_BUS sites untouched, per your note that those
are AccType_VECTABLE/STACK/UNSTACK and are not required to honour it.

One question on the register bank: I kept ccr[M_REG_NS] in the new check to
match the expression in the transaction_failed hook from v1, but the nearby
STKOFHFNMIGN code in this file uses ccr[is_secure]. Happy to switch both
sites to [secure] if you think that's more correct here.

v2 follows soon for review.

again many thanks!

-- Kyle


On Mon, Jun 8, 2026 at 6:24=E2=80=AFAM Peter Maydell <peter.maydell@linaro.=
org>
wrote:

> On Fri, 5 Jun 2026 at 04:50, Kyle Fox <kylefoxaustin.github@gmail.com>
> wrote:
> >
> > M-profile CCR.BFHFNMIGN lets software executing at a negative execution
> > priority (in HardFault/NMI, or with FAULTMASK set) suppress precise dat=
a
> > BusFaults caused by load/store instructions: the access completes
> > returning UNKNOWN data, the fault status is recorded in BFSR/BFAR, but =
no
> > BusFault exception is taken. Software uses this to probe for the presen=
ce
> > of a device.
> >
> > QEMU stored CCR.BFHFNMIGN but never consumed it: arm_cpu_do_transaction=
_
> > failed() always raised the external abort, which
> arm_v7m_cpu_do_interrupt()
> > pended as a BusFault and then escalated to a HardFault it could not tak=
e
> at
> > priority -1, aborting the VM with "Lockup: can't escalate 3 to
> HardFault".
> >
> > Honour the bit in arm_cpu_do_transaction_failed(): when the access is a
> > data access from M-profile code at negative priority with BFHFNMIGN set=
,
> > record PRECISERR/BFARVALID and BFAR and return without raising, so the
> > faulting instruction completes instead of re-faulting forever.
> Instruction
> > fetches are unaffected, since BFHFNMIGN applies only to data accesses.
> >
> > This surfaced running the real NXP i.MX 95 System Manager firmware on t=
he
> > emulated Cortex-M33: its SystemMemoryProbe() (set BFHFNMIGN + FAULTMASK=
,
> > do the access, test CFSR.BFARVALID) locked up the VM. With this change
> the
> > SM's debug-monitor memory-probe commands run and recover correctly.
> >
> > Signed-off-by: Kyle Fox <kylefoxaustin.github@gmail.com>
> > ---
> > Found while bringing up an out-of-tree i.MX 95 machine running the real
> NXP
> > System Manager firmware on the emulated Cortex-M33; the change is
> generic to
> > any ARMv7-M guest that probes for devices via BusFault suppression. It =
is
> > independent of (and posted alongside) a separate PMSAv7 MPU align-down
> fix
> > from the same bring-up.
> >
> > The new path only runs for an M-profile data access at negative priorit=
y
> with
> > CCR.BFHFNMIGN set - the previously-broken case that aborted the VM.
> Normal
> > BusFaults (no BFHFNMIGN, or at non-negative priority) and instruction
> fetches
> > are unchanged.
> >
> > Tested on master: qemu-system-arm builds clean, and the ARMv7-M / MPS2
> qtests
> > pass with no regression -- boot-serial (incl. stm32vldiscovery,
> Cortex-M3),
> > the stm32l4x5 suite (Cortex-M4: exti/gpio/rcc/syscfg/usart), microbit,
> > sse-timer and cmsdk-apb-watchdog.
> >
> >  target/arm/tcg/tlb_helper.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
> > index f90765cb59..cbef9cb03e 100644
> > --- a/target/arm/tcg/tlb_helper.c
> > +++ b/target/arm/tcg/tlb_helper.c
> > @@ -10,6 +10,7 @@
> >  #include "helper.h"
> >  #include "internals.h"
> >  #include "cpu-features.h"
> > +#include "hw/intc/armv7m_nvic.h"
> >
> >  /*
> >   * Returns true if the stage 1 translation regime is using LPAE format
> page
> > @@ -318,8 +319,31 @@ void arm_cpu_do_transaction_failed(CPUState *cs,
> hwaddr physaddr,
> >                                     MemTxResult response, uintptr_t
> retaddr)
> >  {
> >      ARMCPU *cpu =3D ARM_CPU(cs);
> > +    CPUARMState *env =3D &cpu->env;
> >      ARMMMUFaultInfo fi =3D {};
> >
> > +    /*
> > +     * For M-profile, CCR.BFHFNMIGN lets software executing at a
> negative
> > +     * priority (in HardFault/NMI, or with FAULTMASK set) suppress
> precise
> > +     * data BusFaults from load/store instructions: the access complet=
es
> > +     * returning UNKNOWN data (the store is dropped), the fault status
> is
> > +     * recorded in BFSR/BFAR, but no BusFault exception is taken. This
> is
> > +     * the mechanism software uses to probe for the presence of a devi=
ce
> > +     * (e.g. the NXP System Manager's SystemMemoryProbe). Honour it by
> > +     * recording the status and returning without raising, so the
> faulting
> > +     * instruction completes rather than re-faulting forever. BFHFNMIG=
N
> > +     * applies only to data accesses, so instruction fetches are
> unaffected.
> > +     */
> > +    if (arm_feature(env, ARM_FEATURE_M) &&
> > +        access_type !=3D MMU_INST_FETCH &&
> > +        (env->v7m.ccr[M_REG_NS] & R_V7M_CCR_BFHFNMIGN_MASK) &&
> > +        armv7m_nvic_neg_prio_requested(env->nvic, env->v7m.secure)) {
> > +        env->v7m.cfsr[M_REG_NS] |=3D
> > +            (R_V7M_CFSR_PRECISERR_MASK | R_V7M_CFSR_BFARVALID_MASK);
> > +        env->v7m.bfar =3D addr;
> > +        return;
> > +    }
>
> Thanks for this patch. This looks good, but it misses a very
> obscure corner case, which is the load of the word from the stack
> performed by the SG instruction. In the pseudocode that is an
> AccType_NORMAL access, so it should honour BFHFNMIGN. In QEMU
> we (for complicated reasons) implement that load manually in
> v7m_read_sg_stack_word(), so it doesn't go through the TCG TLB
> and this transaction_failed hook. So v7m_read_sg_stack_word()
> should check BFHFNMIGN to see if it should pend the ARMV7M_EXCP_BUS.
>
> The other places where we manually pend EXCP_BUS are all ones
> which should not or are not required to honour BFHFNMIGN
> (vector table loads, stacking and unstacking, which are
> AccType_VECTABLE, AccType_STACK, AccType_UNSTACK).
>
> thanks
> -- PMM
>

--00000000000016acb306541bb720
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Peter!</div><div>Thanks, great catch.=C2=A0 You&#3=
9;re right that the SG stack-word load is an</div>AccType_NORMAL access and=
 should honour BFHFNMIGN.<br><div><br></div><div>I&#39;m working on v2 to i=
ncorporate.=C2=A0 Basically=C2=A0v2 adds the check in v7m_read_sg_stack_wor=
d():=C2=A0</div><div>on the BusFault path it=C2=A0records BFSR/BFAR as befo=
re but, when BFHFNMIGN is set at negative</div>execution priority, it compl=
etes the access returning UNKNOWN data and<br>returns true, instead of pend=
ing ARMV7M_EXCP_BUS. I left the vector-table,<br>stacking and unstacking EX=
CP_BUS sites untouched, per your note that those<br>are AccType_VECTABLE/ST=
ACK/UNSTACK and are not required to honour it.<br><br>One question on the r=
egister bank: I kept ccr[M_REG_NS] in the new check to<br>match the express=
ion in the transaction_failed hook from v1, but the nearby<br>STKOFHFNMIGN =
code in this file uses ccr[is_secure]. Happy to switch both<br>sites to [se=
cure] if you think that&#39;s more correct here.<br><br>v2 follows soon for=
 review.<br><br><div>again many thanks!</div><div><br></div>-- Kyle</div><d=
iv dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 8, 2026 at 6:24=E2=80=AFAM =
Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"_bl=
ank">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">On Fri, 5 Jun 2026 at 04:50, Kyle Fox &lt;<a h=
ref=3D"mailto:kylefoxaustin.github@gmail.com" target=3D"_blank">kylefoxaust=
in.github@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; M-profile CCR.BFHFNMIGN lets software executing at a negative executio=
n<br>
&gt; priority (in HardFault/NMI, or with FAULTMASK set) suppress precise da=
ta<br>
&gt; BusFaults caused by load/store instructions: the access completes<br>
&gt; returning UNKNOWN data, the fault status is recorded in BFSR/BFAR, but=
 no<br>
&gt; BusFault exception is taken. Software uses this to probe for the prese=
nce<br>
&gt; of a device.<br>
&gt;<br>
&gt; QEMU stored CCR.BFHFNMIGN but never consumed it: arm_cpu_do_transactio=
n_<br>
&gt; failed() always raised the external abort, which arm_v7m_cpu_do_interr=
upt()<br>
&gt; pended as a BusFault and then escalated to a HardFault it could not ta=
ke at<br>
&gt; priority -1, aborting the VM with &quot;Lockup: can&#39;t escalate 3 t=
o HardFault&quot;.<br>
&gt;<br>
&gt; Honour the bit in arm_cpu_do_transaction_failed(): when the access is =
a<br>
&gt; data access from M-profile code at negative priority with BFHFNMIGN se=
t,<br>
&gt; record PRECISERR/BFARVALID and BFAR and return without raising, so the=
<br>
&gt; faulting instruction completes instead of re-faulting forever. Instruc=
tion<br>
&gt; fetches are unaffected, since BFHFNMIGN applies only to data accesses.=
<br>
&gt;<br>
&gt; This surfaced running the real NXP i.MX 95 System Manager firmware on =
the<br>
&gt; emulated Cortex-M33: its SystemMemoryProbe() (set BFHFNMIGN + FAULTMAS=
K,<br>
&gt; do the access, test CFSR.BFARVALID) locked up the VM. With this change=
 the<br>
&gt; SM&#39;s debug-monitor memory-probe commands run and recover correctly=
.<br>
&gt;<br>
&gt; Signed-off-by: Kyle Fox &lt;<a href=3D"mailto:kylefoxaustin.github@gma=
il.com" target=3D"_blank">kylefoxaustin.github@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; Found while bringing up an out-of-tree i.MX 95 machine running the rea=
l NXP<br>
&gt; System Manager firmware on the emulated Cortex-M33; the change is gene=
ric to<br>
&gt; any ARMv7-M guest that probes for devices via BusFault suppression. It=
 is<br>
&gt; independent of (and posted alongside) a separate PMSAv7 MPU align-down=
 fix<br>
&gt; from the same bring-up.<br>
&gt;<br>
&gt; The new path only runs for an M-profile data access at negative priori=
ty with<br>
&gt; CCR.BFHFNMIGN set - the previously-broken case that aborted the VM. No=
rmal<br>
&gt; BusFaults (no BFHFNMIGN, or at non-negative priority) and instruction =
fetches<br>
&gt; are unchanged.<br>
&gt;<br>
&gt; Tested on master: qemu-system-arm builds clean, and the ARMv7-M / MPS2=
 qtests<br>
&gt; pass with no regression -- boot-serial (incl. stm32vldiscovery, Cortex=
-M3),<br>
&gt; the stm32l4x5 suite (Cortex-M4: exti/gpio/rcc/syscfg/usart), microbit,=
<br>
&gt; sse-timer and cmsdk-apb-watchdog.<br>
&gt;<br>
&gt;=C2=A0 target/arm/tcg/tlb_helper.c | 24 ++++++++++++++++++++++++<br>
&gt;=C2=A0 1 file changed, 24 insertions(+)<br>
&gt;<br>
&gt; diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c=
<br>
&gt; index f90765cb59..cbef9cb03e 100644<br>
&gt; --- a/target/arm/tcg/tlb_helper.c<br>
&gt; +++ b/target/arm/tcg/tlb_helper.c<br>
&gt; @@ -10,6 +10,7 @@<br>
&gt;=C2=A0 #include &quot;helper.h&quot;<br>
&gt;=C2=A0 #include &quot;internals.h&quot;<br>
&gt;=C2=A0 #include &quot;cpu-features.h&quot;<br>
&gt; +#include &quot;hw/intc/armv7m_nvic.h&quot;<br>
&gt;<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* Returns true if the stage 1 translation regime is using =
LPAE format page<br>
&gt; @@ -318,8 +319,31 @@ void arm_cpu_do_transaction_failed(CPUState *cs, =
hwaddr physaddr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MemTxResult r=
esponse, uintptr_t retaddr)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ARMCPU *cpu =3D ARM_CPU(cs);<br>
&gt; +=C2=A0 =C2=A0 CPUARMState *env =3D &amp;cpu-&gt;env;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ARMMMUFaultInfo fi =3D {};<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* For M-profile, CCR.BFHFNMIGN lets software exec=
uting at a negative<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* priority (in HardFault/NMI, or with FAULTMASK s=
et) suppress precise<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* data BusFaults from load/store instructions: th=
e access completes<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* returning UNKNOWN data (the store is dropped), =
the fault status is<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* recorded in BFSR/BFAR, but no BusFault exceptio=
n is taken. This is<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* the mechanism software uses to probe for the pr=
esence of a device<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* (e.g. the NXP System Manager&#39;s SystemMemory=
Probe). Honour it by<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* recording the status and returning without rais=
ing, so the faulting<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* instruction completes rather than re-faulting f=
orever. BFHFNMIGN<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* applies only to data accesses, so instruction f=
etches are unaffected.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 if (arm_feature(env, ARM_FEATURE_M) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 access_type !=3D MMU_INST_FETCH &amp;&amp=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (env-&gt;v7m.ccr[M_REG_NS] &amp; R_V7M_CC=
R_BFHFNMIGN_MASK) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 armv7m_nvic_neg_prio_requested(env-&gt;nv=
ic, env-&gt;v7m.secure)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;v7m.cfsr[M_REG_NS] |=3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (R_V7M_CFSR_PRECISERR_MASK =
| R_V7M_CFSR_BFARVALID_MASK);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;v7m.bfar =3D addr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
Thanks for this patch. This looks good, but it misses a very<br>
obscure corner case, which is the load of the word from the stack<br>
performed by the SG instruction. In the pseudocode that is an<br>
AccType_NORMAL access, so it should honour BFHFNMIGN. In QEMU<br>
we (for complicated reasons) implement that load manually in<br>
v7m_read_sg_stack_word(), so it doesn&#39;t go through the TCG TLB<br>
and this transaction_failed hook. So v7m_read_sg_stack_word()<br>
should check BFHFNMIGN to see if it should pend the ARMV7M_EXCP_BUS.<br>
<br>
The other places where we manually pend EXCP_BUS are all ones<br>
which should not or are not required to honour BFHFNMIGN<br>
(vector table loads, stacking and unstacking, which are<br>
AccType_VECTABLE, AccType_STACK, AccType_UNSTACK).<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div></div>

--00000000000016acb306541bb720--

