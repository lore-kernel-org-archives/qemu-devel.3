Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3D9C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 17:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s96iv-0004FC-3l; Mon, 20 May 2024 13:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s96is-0004F1-5J
 for qemu-devel@nongnu.org; Mon, 20 May 2024 13:22:54 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s96iq-0007Bo-AZ
 for qemu-devel@nongnu.org; Mon, 20 May 2024 13:22:53 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5206a5854adso3368028e87.0
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 10:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716225770; x=1716830570; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wldE+U99LMMyrfroJg3IZRBdIOB0cmQp5cVQCi02LZw=;
 b=iQmhMscc5lStCBUcJkG6FdA+gyaTqtqnYUZKmu5+huupp/VWpi/En2sI3ODZVbIkPR
 XlKC75Ltgan6rQHGG5hOJ/dWH8hBNBEvHOGL15S0qtQDO4rfPz8OGjReWVBPGhTN6B95
 PRDJivI5Jagji3xh9GHZwsn84sBy//EyXyLBwTCgyqixpGBES3on2UDCkdQVe9TYiIOI
 SH9qWb6fLHPVge8doD+Ha8glZJFZ/a/Uo0c8w2YFos9YgIf9LZu2eI6U4b3qiU7ydeoE
 JZwRtwRPPRzgXMLXc5vgAjaJA/V7LC6kfPl6PErEkPvxonxPIptFg92/0DDsRHGCati5
 bcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716225770; x=1716830570;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wldE+U99LMMyrfroJg3IZRBdIOB0cmQp5cVQCi02LZw=;
 b=vM8nsmRt3HkKJkvedsN72IHxbp3dt8J2DJSB+TO8JDXUgj5bz/u1s7gbcMVVwMe/M6
 TaIBWZYHUnqCouxGT+coFHoDJ1iC+LTE3naX00bjjvSfnzup4LDWIdL0XIF0vYN5wXXe
 2mSi41nU1vB+W59tLaqPRnWfz6PGulmDSauWnz8CoZFotHKUXS6BOBmUm1J85nLhFnp2
 aeRmoHb4clL9TnUAwxnv/Gd7wLQI+YXIL3GRN2p/oJjZiLKcn9jeznYzlSKp8A033zfC
 fwXPCiDChA25/b9Qre2WD7BSHW6kwyGeJEgOm8cy9T+pVHTlOxYlcxtQnvqPYX3RAMwp
 RrUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPNceThB9UbEcW1QhPZplXku6x6vWRNLWi1teRfW/NRhWAsYvi0/z4DlaJyyt0klhZYN5mXfL/HbcR0hUBDmZUhIAE4fI=
X-Gm-Message-State: AOJu0YzuEshqZ+tvSQ0369nJQOQCDEc17DIHDICtNPLKzhRMIyMYBTah
 aQaFVAgLHFSkuNrFYHhP4Nk/IZpNAazZOcKY7lFEJhm6UPgmOd9hb/Hr1X1C3WziitcH/RMh3z3
 KlyFsil1jOJAyR1on9zJjC+VV2Lh7OqtwOgQKbg==
X-Google-Smtp-Source: AGHT+IGKEcj+Vk5q3AmPdyiGbKhdvWfYETVloQUhMgGDJFicpVOlDPp6YntjbdNx9Ogiv6spxIR3tNmh+XYhvY4E2ho=
X-Received: by 2002:ac2:4c8c:0:b0:51d:a87e:27ec with SMTP id
 2adb3069b0e04-5220fc735f1mr18731480e87.9.1716225770061; Mon, 20 May 2024
 10:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240513233305.2975295-1-perry@mosi.io>
 <42e47d17-1d49-43e8-abd6-76abdcb159dc@linaro.org>
In-Reply-To: <42e47d17-1d49-43e8-abd6-76abdcb159dc@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2024 18:22:38 +0100
Message-ID: <CAFEAcA9t9t7R9FR9mwEssT8+7XVcaBdThetZawB+VmL+0OcxDg@mail.gmail.com>
Subject: Re: [PATCH] physmem: allow debug writes to MMIO regions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Perry Hung <perry@mosi.io>, qemu-devel@nongnu.org, pbonzini@redhat.com, 
 peterx@redhat.com, david@redhat.com, 
 Andreas Rasmusson <andreas.rasmusson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 15 May 2024 at 13:49, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Perry,
>
> On 14/5/24 01:33, Perry Hung wrote:
> > Writes from GDB to memory-mapped IO regions are currently silently
> > dropped. cpu_memory_rw_debug() calls address_space_write_rom(), which
> > calls address_space_write_rom_internal(), which ignores all non-ram/rom
> > regions.
> >
> > Add a check for MMIO regions and direct those to address_space_rw()
> > instead.
> >
>
> Reported-by: Andreas Rasmusson <andreas.rasmusson@gmail.com>
> BugLink: https://bugs.launchpad.net/qemu/+bug/1625216
>
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/213
> > Signed-off-by: Perry Hung <perry@mosi.io>
> > ---
> >   system/physmem.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/system/physmem.c b/system/physmem.c
> > index 342b7a8fd4..013cdd2ab1 100644
> > --- a/system/physmem.c
> > +++ b/system/physmem.c
> > @@ -3508,7 +3508,10 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr add=
r,
> >           if (l > len)
> >               l =3D len;
> >           phys_addr +=3D (addr & ~TARGET_PAGE_MASK);
> > -        if (is_write) {
> > +        if (cpu_physical_memory_is_io(phys_addr)) {
> > +            res =3D address_space_rw(cpu->cpu_ases[asidx].as, phys_add=
r, attrs,
> > +                                   buf, l, is_write);
> > +        } else if (is_write) {
> >               res =3D address_space_write_rom(cpu->cpu_ases[asidx].as, =
phys_addr,
> >                                             attrs, buf, l);
> >           } else {

The other option is to make address_space_write_rom_internal()
also write to devices...

> I wonder if we shouldn't be safer with a preliminary patch
> adding a 'can_do_io' boolean argument to cpu_memory_rw_debug()
> (updating the call sites), then this patch would become:
>
>      if (can_do_io && cpu_physical_memory_is_io(phys_addr)) {
>
> One of my worries for example is if someone accidently insert
> a breakpoint at a I/O address, the device might change its
> state and return MEMTX_OK which is confusing.

You can definitely do some silly things if we remove this
restriction.

On the other hand if you're using gdb as a debugger on real
(bare metal) hardware does anything stop you doing that?

-- PMM

