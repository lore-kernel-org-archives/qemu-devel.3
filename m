Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99BDCED270
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 06:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy46A-0004AW-Mv; Tue, 08 Oct 2024 02:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sy45z-00046J-OR; Tue, 08 Oct 2024 02:53:24 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sy45x-0006i7-Rn; Tue, 08 Oct 2024 02:53:23 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7e9ff6fb4c6so3409524a12.3; 
 Mon, 07 Oct 2024 23:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728370399; x=1728975199; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yl9wVhYdYzr0dbvFnE/KpqC4pyrVnkoW5bYQFuOcopg=;
 b=LediI65aKEnX/xLfwTVZyipfpTrrIF97+tplZVldswPqyox14JLLQtXPaXDjLX9i5/
 kYt5bNaedJ0POHCyJco1G3oULbyQPWzOdt1sPuAn+3+4g9sRQaYMW7yEbK/TYUVqdzLL
 B7GF/kvZqXLMT1pvcNChZS4T9t/iC2snSzPMjiTIIDIru0ckrHbqSKnnCUzsWnurjgyh
 UJWrqlrb+p2vIT4NYllcG3aR1T3QBj8+O3vqhYk3/LNqTcN89m+COD1HjxLhx1iaqe12
 ZJ3UYABEBaGkntb2J7W/Fgw0GDskWISos88V033KzocK0SKiuG2pkQ+Uxu6cHkO7rnAk
 Si/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728370399; x=1728975199;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yl9wVhYdYzr0dbvFnE/KpqC4pyrVnkoW5bYQFuOcopg=;
 b=OZir6J4Jh9rZt5tPDAZdedSPpW+vOIPpWXrTLeh2arabAGjM4YTTSJJUTqzb0Bttbu
 iTBWXlmsU1rY5vOSnQ+vPL/sSdoAV32wLLPn5qVPSoi+WBYZjcURWrXWGeP/kggoQCMR
 ZKk2NnqI0zquzkpx5wW+yFt8Z2hnzHR/mYya2NP0l2OMl//82xF2CbP9pkxF7dAuxsnT
 vMtknRQyZaQqLxpj2Jyi7sm3LYhzslKBXxIhFR/Kw/7qi3/vr5yinahD7HQWlwixT/nn
 FQM4ShOLdcFXPFEJESPDZyl8Sb1hX771wD+i3W1j/OxSMkYt/o20vqbFMiBTTDl9cV5z
 FTKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIRJWdBFwEUhjilBvCUYsjwzT+Q9ss2+DLfCQBNqfiSA8qL6ojKvQIjRGJ7eFYE3Xc8KeWafSgkaU3@nongnu.org
X-Gm-Message-State: AOJu0Yz/0YNoizj5mg47C1mr60f+LTG7OyNn2leK3PY8idWK31umJyGL
 fTsvc7wI/pE43IlIYcT48fKjH7wX3fwIGOxGFDUwns13hOglsZ06TIDZSA==
X-Google-Smtp-Source: AGHT+IGZSP/uWhV0S4GQKMUGWPIvR7EL57D1jVX5BMQ3q0M43TqZ7Lj/gzkZnhDgAT8W8yqNMmdPLQ==
X-Received: by 2002:a17:90a:b015:b0:2e1:ce67:5d2e with SMTP id
 98e67ed59e1d1-2e1e6213b03mr21534307a91.5.1728370399474; 
 Mon, 07 Oct 2024 23:53:19 -0700 (PDT)
Received: from localhost ([118.210.103.101]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e20af65b7asm6734628a91.34.2024.10.07.23.53.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 23:53:19 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Oct 2024 16:53:15 +1000
Message-Id: <D4Q8666EZOP0.14XMUHAKLYHCU@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>
Cc: <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>, <danielhb413@gmail.com>
Subject: Re: [PATCH v3 09/10] target/ppc: simplify var usage in
 ppc_next_unmasked_interrupt
X-Mailer: aerc 0.18.2
References: <20240913041337.912876-1-harshpb@linux.ibm.com>
 <20240913041337.912876-10-harshpb@linux.ibm.com>
 <e09919a0-061d-90e0-8107-68e509ce08aa@eik.bme.hu>
In-Reply-To: <e09919a0-061d-90e0-8107-68e509ce08aa@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri Sep 13, 2024 at 10:50 PM AEST, BALATON Zoltan wrote:
> On Fri, 13 Sep 2024, Harsh Prateek Bora wrote:
> > As previously done for arch specific handlers, simplify var usage in
> > ppc_next_unmasked_interrupt by caching the env->pending_interrupts and
> > env->spr[SPR_LPCR] in local vars and using it later at multiple places.
> >
> > Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> > ---
> > target/ppc/excp_helper.c | 54 ++++++++++++++++++++--------------------
> > 1 file changed, 27 insertions(+), 27 deletions(-)
> >
> > diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> > index d0e0f609a0..4eeeedff5b 100644
> > --- a/target/ppc/excp_helper.c
> > +++ b/target/ppc/excp_helper.c
> > @@ -2022,31 +2022,31 @@ static int p9_next_unmasked_interrupt(CPUPPCSta=
te *env,
> >
> > static int ppc_next_unmasked_interrupt(CPUPPCState *env)
> > {
> > +    uint32_t pending_interrupts =3D env->pending_interrupts;
> > +    target_ulong lpcr =3D env->spr[SPR_LPCR];
> > +    bool async_deliver;
>
> Maybe easier to review if split into one patch for each variable added so=
=20
> it's easier to see what's replaced and that nothing is missed.

I'm happy to leave squashed since it's pretty simple search/replace
with no logic change, and touching the same lines.

Thanks,
Nick

>
> Regards,
> BALATON Zoltan
>
> > +
> > #ifdef TARGET_PPC64
> >     switch (env->excp_model) {
> >     case POWERPC_EXCP_POWER7:
> > -        return p7_next_unmasked_interrupt(env, env->pending_interrupts=
,
> > -                                          env->spr[SPR_LPCR]);
> > +        return p7_next_unmasked_interrupt(env, pending_interrupts, lpc=
r);
> >     case POWERPC_EXCP_POWER8:
> > -        return p8_next_unmasked_interrupt(env, env->pending_interrupts=
,
> > -                                          env->spr[SPR_LPCR]);
> > +        return p8_next_unmasked_interrupt(env, pending_interrupts, lpc=
r);
> >     case POWERPC_EXCP_POWER9:
> >     case POWERPC_EXCP_POWER10:
> >     case POWERPC_EXCP_POWER11:
> > -        return p9_next_unmasked_interrupt(env, env->pending_interrupts=
,
> > -			                  env->spr[SPR_LPCR]);
> > +        return p9_next_unmasked_interrupt(env, pending_interrupts, lpc=
r);
> >     default:
> >         break;
> >     }
> > #endif
> > -    bool async_deliver;
> >
> >     /* External reset */
> > -    if (env->pending_interrupts & PPC_INTERRUPT_RESET) {
> > +    if (pending_interrupts & PPC_INTERRUPT_RESET) {
> >         return PPC_INTERRUPT_RESET;
> >     }
> >     /* Machine check exception */
> > -    if (env->pending_interrupts & PPC_INTERRUPT_MCK) {
> > +    if (pending_interrupts & PPC_INTERRUPT_MCK) {
> >         return PPC_INTERRUPT_MCK;
> >     }
> > #if 0 /* TODO */
> > @@ -2065,9 +2065,9 @@ static int ppc_next_unmasked_interrupt(CPUPPCStat=
e *env)
> >     async_deliver =3D FIELD_EX64(env->msr, MSR, EE) || env->resume_as_s=
reset;
> >
> >     /* Hypervisor decrementer exception */
> > -    if (env->pending_interrupts & PPC_INTERRUPT_HDECR) {
> > +    if (pending_interrupts & PPC_INTERRUPT_HDECR) {
> >         /* LPCR will be clear when not supported so this will work */
> > -        bool hdice =3D !!(env->spr[SPR_LPCR] & LPCR_HDICE);
> > +        bool hdice =3D !!(lpcr & LPCR_HDICE);
> >         if ((async_deliver || !FIELD_EX64_HV(env->msr)) && hdice) {
> >             /* HDEC clears on delivery */
> >             return PPC_INTERRUPT_HDECR;
> > @@ -2075,18 +2075,18 @@ static int ppc_next_unmasked_interrupt(CPUPPCSt=
ate *env)
> >     }
> >
> >     /* Hypervisor virtualization interrupt */
> > -    if (env->pending_interrupts & PPC_INTERRUPT_HVIRT) {
> > +    if (pending_interrupts & PPC_INTERRUPT_HVIRT) {
> >         /* LPCR will be clear when not supported so this will work */
> > -        bool hvice =3D !!(env->spr[SPR_LPCR] & LPCR_HVICE);
> > +        bool hvice =3D !!(lpcr & LPCR_HVICE);
> >         if ((async_deliver || !FIELD_EX64_HV(env->msr)) && hvice) {
> >             return PPC_INTERRUPT_HVIRT;
> >         }
> >     }
> >
> >     /* External interrupt can ignore MSR:EE under some circumstances */
> > -    if (env->pending_interrupts & PPC_INTERRUPT_EXT) {
> > -        bool lpes0 =3D !!(env->spr[SPR_LPCR] & LPCR_LPES0);
> > -        bool heic =3D !!(env->spr[SPR_LPCR] & LPCR_HEIC);
> > +    if (pending_interrupts & PPC_INTERRUPT_EXT) {
> > +        bool lpes0 =3D !!(lpcr & LPCR_LPES0);
> > +        bool heic =3D !!(lpcr & LPCR_HEIC);
> >         /* HEIC blocks delivery to the hypervisor */
> >         if ((async_deliver && !(heic && FIELD_EX64_HV(env->msr) &&
> >             !FIELD_EX64(env->msr, MSR, PR))) ||
> > @@ -2096,45 +2096,45 @@ static int ppc_next_unmasked_interrupt(CPUPPCSt=
ate *env)
> >     }
> >     if (FIELD_EX64(env->msr, MSR, CE)) {
> >         /* External critical interrupt */
> > -        if (env->pending_interrupts & PPC_INTERRUPT_CEXT) {
> > +        if (pending_interrupts & PPC_INTERRUPT_CEXT) {
> >             return PPC_INTERRUPT_CEXT;
> >         }
> >     }
> >     if (async_deliver !=3D 0) {
> >         /* Watchdog timer on embedded PowerPC */
> > -        if (env->pending_interrupts & PPC_INTERRUPT_WDT) {
> > +        if (pending_interrupts & PPC_INTERRUPT_WDT) {
> >             return PPC_INTERRUPT_WDT;
> >         }
> > -        if (env->pending_interrupts & PPC_INTERRUPT_CDOORBELL) {
> > +        if (pending_interrupts & PPC_INTERRUPT_CDOORBELL) {
> >             return PPC_INTERRUPT_CDOORBELL;
> >         }
> >         /* Fixed interval timer on embedded PowerPC */
> > -        if (env->pending_interrupts & PPC_INTERRUPT_FIT) {
> > +        if (pending_interrupts & PPC_INTERRUPT_FIT) {
> >             return PPC_INTERRUPT_FIT;
> >         }
> >         /* Programmable interval timer on embedded PowerPC */
> > -        if (env->pending_interrupts & PPC_INTERRUPT_PIT) {
> > +        if (pending_interrupts & PPC_INTERRUPT_PIT) {
> >             return PPC_INTERRUPT_PIT;
> >         }
> >         /* Decrementer exception */
> > -        if (env->pending_interrupts & PPC_INTERRUPT_DECR) {
> > +        if (pending_interrupts & PPC_INTERRUPT_DECR) {
> >             return PPC_INTERRUPT_DECR;
> >         }
> > -        if (env->pending_interrupts & PPC_INTERRUPT_DOORBELL) {
> > +        if (pending_interrupts & PPC_INTERRUPT_DOORBELL) {
> >             return PPC_INTERRUPT_DOORBELL;
> >         }
> > -        if (env->pending_interrupts & PPC_INTERRUPT_HDOORBELL) {
> > +        if (pending_interrupts & PPC_INTERRUPT_HDOORBELL) {
> >             return PPC_INTERRUPT_HDOORBELL;
> >         }
> > -        if (env->pending_interrupts & PPC_INTERRUPT_PERFM) {
> > +        if (pending_interrupts & PPC_INTERRUPT_PERFM) {
> >             return PPC_INTERRUPT_PERFM;
> >         }
> >         /* Thermal interrupt */
> > -        if (env->pending_interrupts & PPC_INTERRUPT_THERM) {
> > +        if (pending_interrupts & PPC_INTERRUPT_THERM) {
> >             return PPC_INTERRUPT_THERM;
> >         }
> >         /* EBB exception */
> > -        if (env->pending_interrupts & PPC_INTERRUPT_EBB) {
> > +        if (pending_interrupts & PPC_INTERRUPT_EBB) {
> >             /*
> >              * EBB exception must be taken in problem state and
> >              * with BESCR_GE set.
> >


