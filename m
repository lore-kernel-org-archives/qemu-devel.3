Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B80EC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 20:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhw6s-0006Yo-0s; Fri, 01 Aug 2025 16:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uhuly-0002z3-VX
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 14:46:33 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uhult-0002Lf-Bx
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 14:46:27 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6154655c8aeso2841885a12.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 11:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754073982; x=1754678782; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V1WsdtdAOKkSd75rKFLd6uwTJ+nElV6N3IiDENxWdoo=;
 b=dEb51J1v3XKmGsSoPZhHjbLsnDUOayF564KZoMXaImItJMrfraU+w47lIOdf/ICYk1
 xhnrrkI93Mqbuqaj2XXBKdsqCX8f5P0GxfpzQ7Zb2f/GxsF1VAngDle7Uyu0vMVaSP7r
 cgAm0VrjFkQEiGn9+7xn4zPAaVgdmr7n4OdcKD/xBLGZuCOqLrPkfmRmsLTKBfBLySC6
 bil0V9mH7Em7nI9bpQ+jV3h5MBnDiCkJ2N/U8MaFjhH099/gCTbcDBvf8w364J91FpAp
 33HgYxvsTphvINWx1slUuchQzZR2dDUC2ik4VXLp1UualRbRJNSAKGSswzOtljscU2AM
 yAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754073982; x=1754678782;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V1WsdtdAOKkSd75rKFLd6uwTJ+nElV6N3IiDENxWdoo=;
 b=Ji09eYb2RM8cEOhCR5YPLbWbFbnaKIc7XviQphYfglUiAvh2ZGjdw0G93AZLIHGKjI
 D5ihdz2HcAnKBeZE4o/sCQu9lPy5V+2z9XRkBf7bWNBNj9oNG3/7A4P0v3830d5/h4YZ
 8VFP7rOVVtdo57MN85b0DwHWNE+mbJchC5dJMb9Khn88IF72KnC8+IHRut+7PWqRYBnh
 aD7Ohh/nuTbMpa+6GF9NFW4GjPMOgFYafqB5UIfn41ddAMpJvk6qp3bKIEbzCVWvyRDN
 7QxsXdWitKT6qVDot/dnuil4ZnuHHry3OxwTMBG2Zn436xtSvrc7QW2VlKsxXWDBG1cJ
 Cexg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHMyEe67x7H9A5Vlxf5zW7/81gf7X9jxE6DkqPBrRMEv6KA1o6fBotV97gGrfAkhkHpNBSZMmS+zho@nongnu.org
X-Gm-Message-State: AOJu0YzHFRxFtcPpjIjYZFMljKdXsj1swEpZMvLkddlo/9r3Jk14bFF4
 jQhkWiBoW7fQ5DXy4v/V4mt9Lil9Q4qxWUhtLKNm3XafW37ukABf66+0kAwoP+oxVODshb9Ftof
 4P92WIn43gny/CbBkUDGp0/Iz24QGzOKZrn9IlSTqmA==
X-Gm-Gg: ASbGncue8OU0rgjc+sFwL7hXb4/tPrARlVGkyQGCG6NHEmLC/11Izg0kt7zU9sG9n03
 AAomv4Wq2Z63BarwNw2MZkb+8unRRdHONFwpdKGgwFtWv4svSMxDSEFfW3XLeDyZwouUeDmOy7N
 MlYjzes12cCptEfWfGYOUSu+5dq49STiLUoQzY0S+4Gt7jkXS+fZKjN0hLgtSeg1TXPu6XIBI/d
 XANmTQ=
X-Google-Smtp-Source: AGHT+IHM5n6x6I1qZkUCLHItuPOtr7ToWuVT13E7uQ2dj3iPI+69vc3dU9LG4zZ5otfj0lrLcJD76p+9tDSDxJKpalc=
X-Received: by 2002:a05:6402:4402:b0:615:b0e2:124b with SMTP id
 4fb4d7f45d1cf-615e715bd27mr367515a12.24.1754073981611; Fri, 01 Aug 2025
 11:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-48-richard.henderson@linaro.org>
 <b2e40787-6043-4d4c-9cbb-731d0e92e25c@linaro.org>
 <CAFEAcA_9tkv1EoM33=G=zW6Pw0gBirvjs-SsDaC8ar8feyH_8g@mail.gmail.com>
In-Reply-To: <CAFEAcA_9tkv1EoM33=G=zW6Pw0gBirvjs-SsDaC8ar8feyH_8g@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 1 Aug 2025 21:45:55 +0300
X-Gm-Features: Ac12FXxTpzSK83haBZOj4Z68AVYNkdwa_OckKDcvce4rjrcnQ9aB8t7ZtztA9HE
Message-ID: <CAAjaMXbd6TF1x13h-N=F+kBL8=+0K+gyVzh6zk-65LjeqqDVSA@mail.gmail.com>
Subject: Re: [PATCH 47/82] target/arm: Expand pstate to 64 bits
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x530.google.com
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

On Fri, Aug 1, 2025 at 4:33=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Thu, 31 Jul 2025 at 21:34, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
> >
> > On 7/27/25 1:02 AM, Richard Henderson wrote:
> > > diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
> > > index 64ee9b3b56..3cef47281a 100644
> > > --- a/target/arm/gdbstub64.c
> > > +++ b/target/arm/gdbstub64.c
> > > @@ -47,6 +47,7 @@ int aarch64_cpu_gdb_read_register(CPUState *cs, GBy=
teArray *mem_buf, int n)
> > >       case 32:
> > >           return gdb_get_reg64(mem_buf, env->pc);
> > >       case 33:
> > > +        /* pstate is now a 64-bit value; can we simply adjust the xm=
l? */
> > >           return gdb_get_reg32(mem_buf, pstate_read(env));
> > >       }
> >
> > If I'm correct, we currently don't expose PSTATE through gdbstub, but
> > only CPSR. This was a bit confusing for me, considering that CPSR is no=
t
> > even supposed to exist in Aarch64.
> > Maybe it's a good opportunity to expose PSTATE instead, which could hav=
e
> > a 64 bits size. This way, we don't break any workflow.
>
> Architecturally, PSTATE is simply an abstract bundling together of
> different information: it is not a particular format of a value,
> whether 32 or 64 bit or otherwise. (This makes it different to
> AArch32 CPSR, which really is a guest-visible register.)
>
> The thing that *is* defined architecturally is the SPSR_ELx format, which
> is where various bits of PSTATE get saved when reporting an exception up
> to a higher exception level (and which is pretty much the AArch32 CPSR
> format when the lower EL is AArch32). (Note that not *all* of PSTATE
> appears in the SPSR_ELx: for example the SME SM and ZA bits are
> considered part of PSTATE but they aren't saved into SPSR_ELx.)
>
> For convenience, various pieces of software pass around information
> in that SPSR_ELx format. Calling this either "CPSR" or "PSTATE"
> is not really correct, but either is perhaps less confusing than
> calling it SPSR when the context is that of the code running at the
> lower EL rather than the higher.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/arm64/include/asm/kgdb.h#n41
> suggests that expanding the existing pstate to 64 bits is probably
> likely to produce problems. Perhaps we should define a pstate_high
> or something for the top 32 bits?
>

IIUC, this is only a problem if you use the default gdb architecture
register map, but QEMU ships its own as part of gdbstub, so it's free
to change register definition of cspr. Or add a new PSTATE register.

> (I'll see if I can find out if anybody's already looked at this
> for the native debug case.)
>
> thanks
> -- PMM
>

