Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43401CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMQ9W-0003Ck-57; Mon, 11 May 2026 08:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1wMKIN-0007Y1-Ok
 for qemu-devel@nongnu.org; Mon, 11 May 2026 02:39:17 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1wMKIJ-00076s-GD
 for qemu-devel@nongnu.org; Mon, 11 May 2026 02:39:14 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6967080e6beso1183278eaf.2
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 23:39:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778481548; cv=none;
 d=google.com; s=arc-20240605;
 b=czeg6rOgcQAuegB7r6svhLyKxxI0lbIMfoCgjGNPpypJj3CrkZ9BYUeQqI+rRth9HE
 cbKM57uDMgCQxC6HYrLZ7tNP+/13fzfz7294RwMfNLGE2JWBvFVWXAcml3sZROQ5WfUK
 4Ja7LaSMpOLtoIIrbW5s3uYMaWy2EkSNWuwe1WkQrLGCi57B2WYyD6wnAIUVqhtn9are
 dN+nykWRvUGnNjC6XM+MqC3TgWu9jOL9W5Lpc8++LLoS0Ptw/A5f++mNNboXxBsogrhf
 XtcRX7bABH0nMuK3PNbQyi67z8wiJp5cEHp8i3JwPyczUjeZnQhIM+/b/A7ngq6smI3C
 55BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BwTd/2VcU5LrLheNQdBhHoS7wXes0Dja/fPHQazjQB4=;
 fh=No1cmMwXfCKu2nnnJggxVBYyjGyy4eX7W0X+mcOAKyw=;
 b=UQyftjzsmHVG/KBfF5dxrldcDpaO8/Zv+bG6BHm/iMHx3gRncSbDM3roJfc7thagcn
 wKjgtnQqpPYKUrTj2rnIaWUQw3XkYLvPOB4nBSoSTXxxTUycAM6X8WxCM0T2+2r0oVur
 THb/ArHM84wx3kop65zMnZ8BfvwH2QHA9cmuY+FjVGbKqzWtX55/U6nBLRqyJ21386yY
 s6OxtfORCyPr/D2rGUZb/wfdEmhgHeIE/wvYcM5ygDcjc59F0GT4db7Sf3lIVEmIrQ9z
 adlKfQ0mc8RFRxZbn8EeYzxTF2Y7RTzSidGhjRteG5Rm1/DSQaWZTZw/UHup2o9yvyAU
 bsZQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778481548; x=1779086348; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BwTd/2VcU5LrLheNQdBhHoS7wXes0Dja/fPHQazjQB4=;
 b=rITBBxH4rSHTNFlgKrYHepYBdi2A0qyBlY8KPxhYBox2xlNiMBA/fWECu/O5NifWoE
 N3qaF9VswIvhEgdgz6vlW+Kyn7KbYE4x1PCwDyaU4/oo7n4YmmIEXrrSf/q0YJjxtBLq
 48p/I6zEsLVI0U42f9vfYZp3SpKSXUCLOMSua6r91R43RmWq5ORfXFGbdOMrx1v6Y7VZ
 MklyWA6n6cUeLNL6PGZPmV9KrXw0v9dAMW9A2AfasxAuPkU44uZ+YjTtLv0OEBkt91Ps
 URwf1IyxoQHyd8Hee9N0lYOefBiQMhKcCN4i0rZKQ6vgT6bND4cTFJfgeP6QWOe0SKkY
 gX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778481548; x=1779086348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BwTd/2VcU5LrLheNQdBhHoS7wXes0Dja/fPHQazjQB4=;
 b=QCf+8ZJDzi0Jc8me/TNFclhwih3Eouk4Cyt/dMrgtUUv54G5StSduIvOYQIh/YJdeG
 v3n6ep26HqFP9Igtcuh/JBNrstRVN5BG+NQ9FeRPPka6TqLY4VbYkFwbOLncT2VVPdiT
 KjjKzo2v2UW1iWQAKgKY2lj+2YMYbQ7JCj3+9kaVScFVxSyuGeoDoRxY9J6rwy4+YyBS
 iSC+WLfi7ONh7ITsNkJtoz1jDPUsR1zJoWpkOdxaygW/pHvs3rbTADLRCkJ9M0r6KQsw
 F7KtJKZBoj5c009L9QeTf6EAlySmuyQQHsvsk3zvWMB0BA74ZeRlwXyk1YYEboFD5HmY
 4M9Q==
X-Gm-Message-State: AOJu0Yz8RWRCeS79alLLKHYJDMytPHC749vwsGbDgxajd7ewfkD0OvKK
 JleUddlbjyGJ0edFKJdvUo1Cdb5wDC16mKGYztWGKeUNIrTp0xDNnboCDsIA8MuR6QOISCumNYY
 5npDsOKlIwadZ1Lal1NaYeY6sys0A8b0=
X-Gm-Gg: Acq92OGu4ZTiFsFBsNt3rssJEwYed0G9jDrVYhp+5I/GHtSBKkC7OfVEQDEer/phCwK
 UXWXhn9cuiWOp4Xa3PtaT7N63uOBlBOm6GOeaW2RjWz50f/GwrtNQwXT0qA2q8qFmTKSFXKRI9T
 0S5nBifX6Z4A1KD4iLyFXTQ3YUDW0BqP6rxzFOTXreHp/spz5qXbvLA6eXoEFGHl7DHdv+Mi5C6
 T/mjJ6H7+FUj2oIwzeVYsBVa2Y725Ulm/Embfazpl4eiFkHJeuYDKmZUjYn+sK3PtZLTuJou1MY
 JsaNR8vl
X-Received: by 2002:a05:6820:6ae3:b0:694:8e28:fd6e with SMTP id
 006d021491bc7-69b36d2916amr4062166eaf.38.1778481548301; Sun, 10 May 2026
 23:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260503015756.99176-1-54weasels@gmail.com>
 <20260503015756.99176-2-54weasels@gmail.com>
 <20260510074039.003600dd@tpx1>
In-Reply-To: <20260510074039.003600dd@tpx1>
From: Purr Box <54weasels@gmail.com>
Date: Sun, 10 May 2026 23:38:56 -0700
X-Gm-Features: AVHnY4LLXH3tBkbJt2iqzgm0EXsmdXYd0JRHHzQmzTMWeW-tnNbFSQjuJdHZ1Qk
Message-ID: <CAFWf6u_Mz4EvzJkpzXWUnfYFpKiYrEnfkSR7K0bAphkiCGg0tQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] target/m68k: Implement Physical Bus Error exception
 handling
To: Thomas Huth <th.huth+qemu@posteo.eu>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, thuth@redhat.com
Content-Type: multipart/alternative; boundary="000000000000ed199706518500da"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=54weasels@gmail.com; helo=mail-oo1-xc35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 11 May 2026 08:54:06 -0400
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

--000000000000ed199706518500da
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback, I'll perform the clean-ups and start splitting
some stuff up. If you have more suggestions for how it'll be easiest to
cut, let me know.
I'll resubmit a new patch and reference this one asap.

Thanks again,
Dan.

On Sat, May 9, 2026 at 10:40=E2=80=AFPM Thomas Huth <th.huth+qemu@posteo.eu=
> wrote:

>
>  Hi!
>
> Thanks for your patches ... some comments inline below...
>
> Am Sat,  2 May 2026 18:57:50 -0700
> schrieb 54weasels <54weasels@gmail.com>:
>
> > The M68020 natively maps hardware Bus Error (BERR) timeouts into a Long
> Bus Cycle Fault (Format 0xB). This commit adds the memory exception routi=
ng
> to natively synthesize these EXCP_ACCESS cycle faults. It also implements
> the double-fault / watchdog reset behavior required for Sun-3 hardware
> diagnostics, properly handles FSAVE/FRESTORE for 68881 FPU stubs, and
> properly constructs the 84-byte internal bus fault frame.
> >
> > Signed-off-by: 54weasels <54weasels@gmail.com>
> > ---
> >  target/m68k/cpu.c       |   5 +-
> >  target/m68k/cpu.h       |  18 +++-
> >  target/m68k/helper.c    | 130 ++++++++++++++++++++++++++++-
> >  target/m68k/op_helper.c | 176 ++++++++++++++++++++++++++--------------
> >  target/m68k/translate.c |  31 +++++--
> >  5 files changed, 283 insertions(+), 77 deletions(-)
> >
> > diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> > index d849a4a90f..af375f0bce 100644
> > --- a/target/m68k/cpu.c
> > +++ b/target/m68k/cpu.c
> > @@ -1,3 +1,4 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
>
> Looking at the comment at the top of this file, it clearly states that th=
is
> file is licensed under the Lesser GPL, so this change is wrong.
>
> >  /*
> >   * QEMU Motorola 68k CPU
> >   *
> > @@ -51,8 +52,8 @@ static TCGTBCPUState m68k_get_tb_cpu_state(CPUState
> *cs)
> >      flags =3D (env->macsr >> 4) & TB_FLAGS_MACSR;
> >      if (env->sr & SR_S) {
> >          flags |=3D TB_FLAGS_MSR_S;
> > -        flags |=3D (env->sfc << (TB_FLAGS_SFC_S_BIT - 2)) &
> TB_FLAGS_SFC_S;
> > -        flags |=3D (env->dfc << (TB_FLAGS_DFC_S_BIT - 2)) &
> TB_FLAGS_DFC_S;
> > +    flags |=3D (env->sfc << TB_FLAGS_SFC_S_BIT) & TB_FLAGS_SFC_S;
> > +    flags |=3D (env->dfc << TB_FLAGS_DFC_S_BIT) & TB_FLAGS_DFC_S;
>
> Wrong indentation now?
>
> >      }
> >      if (M68K_SR_TRACE(env->sr) =3D=3D M68K_SR_TRACE_ANY_INS) {
> >          flags |=3D TB_FLAGS_TRACE;
> ...
> > diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
> > index 8148a8852e..84d5270767 100644
> > --- a/target/m68k/op_helper.c
> > +++ b/target/m68k/op_helper.c
> > @@ -1,3 +1,4 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> >  /*
> >   *  M68K helper routines
> >   *
> > @@ -25,6 +26,7 @@
> >  #include "qemu/plugin.h"
> >
> >  #if !defined(CONFIG_USER_ONLY)
> > +#include "system/runstate.h"
> >
> >  static void cf_rte(CPUM68KState *env)
> >  {
> > @@ -73,6 +75,12 @@ throwaway:
> >          case 7:
> >              sp +=3D 52;
> >              break;
> > +        case 0xa: /* Short Bus Cycle Fault (Format 0xA) */
> > +            sp +=3D 32 - 8; /* 32 bytes total - 8 bytes header =3D 24 =
bytes
> */
> > +            break;
> > +        case 0xb: /* Long Bus Cycle Fault (Format 0xB) */
> > +            sp +=3D 92 - 8; /* 92 bytes total - 8 bytes header =3D 84 =
bytes
> */
> > +            break;
> >          }
> >      }
> >      env->aregs[7] =3D sp;
> > @@ -342,56 +350,80 @@ static void m68k_interrupt_all(CPUM68KState *env,
> int is_hw)
> >      switch (cs->exception_index) {
> >      case EXCP_ACCESS:
> >          if (env->mmu.fault) {
> > -            cpu_abort(cs, "DOUBLE MMU FAULT\n");
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "M68K: Double MMU Fault. Halting CPU and
> requesting reset.\n");
> > +            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> > +            cs->halted =3D 1;
> > +            cs->exception_index =3D EXCP_HLT;
> > +            cpu_loop_exit(cs);
> >          }
> >          env->mmu.fault =3D true;
> > -        /* push data 3 */
> > -        sp -=3D 4;
> > -        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> > -        /* push data 2 */
> > -        sp -=3D 4;
> > -        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> > -        /* push data 1 */
> > -        sp -=3D 4;
> > -        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> > -        /* write back 1 / push data 0 */
> > -        sp -=3D 4;
> > -        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> > -        /* write back 1 address */
> > -        sp -=3D 4;
> > -        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> > -        /* write back 2 data */
> > -        sp -=3D 4;
> > -        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> > -        /* write back 2 address */
> > -        sp -=3D 4;
> > -        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> > -        /* write back 3 data */
> > -        sp -=3D 4;
> > -        cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> > -        /* write back 3 address */
> > -        sp -=3D 4;
> > -        cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
> > -        /* fault address */
> > -        sp -=3D 4;
> > -        cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
> > -        /* write back 1 status */
> > -        sp -=3D 2;
> > -        cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> > -        /* write back 2 status */
> > -        sp -=3D 2;
> > -        cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> > -        /* write back 3 status */
> > -        sp -=3D 2;
> > -        cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> > -        /* special status word */
> > -        sp -=3D 2;
> > -        cpu_stw_be_mmuidx_ra(env, sp, env->mmu.ssw, MMU_KERNEL_IDX, 0)=
;
> > -        /* effective address */
> > -        sp -=3D 4;
> > -        cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX, 0);
> > -
> > -        do_stack_frame(env, &sp, 7, oldsr, 0, env->pc);
> > +
> > +        if (m68k_feature(env, M68K_FEATURE_M68040)) {
> > +            /* push data 3 */
> > +            sp -=3D 4;
> > +            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> > +            /* push data 2 */
> > +            sp -=3D 4;
> > +            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> > +            /* push data 1 */
> > +            sp -=3D 4;
> > +            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> > +            /* write back 1 / push data 0 */
> > +            sp -=3D 4;
> > +            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> > +            /* write back 1 address */
> > +            sp -=3D 4;
> > +            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> > +            /* write back 2 data */
> > +            sp -=3D 4;
> > +            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> > +            /* write back 2 address */
> > +            sp -=3D 4;
> > +            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> > +            /* write back 3 data */
> > +            sp -=3D 4;
> > +            cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> > +            /* write back 3 address */
> > +            sp -=3D 4;
> > +            cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX,
> 0);
> > +            /* fault address */
> > +            sp -=3D 4;
> > +            cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX,
> 0);
> > +            /* write back 1 status */
> > +            sp -=3D 2;
> > +            cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> > +            /* write back 2 status */
> > +            sp -=3D 2;
> > +            cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> > +            /* write back 3 status */
> > +            sp -=3D 2;
> > +            cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERNEL_IDX, 0);
> > +            /* special status word */
> > +            sp -=3D 2;
> > +            cpu_stw_be_mmuidx_ra(env, sp, env->mmu.ssw, MMU_KERNEL_IDX=
,
> 0);
> > +            /* effective address */
> > +            sp -=3D 4;
> > +            cpu_stl_be_mmuidx_ra(env, sp, env->mmu.ar, MMU_KERNEL_IDX,
> 0);
> > +
> > +            do_stack_frame(env, &sp, 7, oldsr, 0, env->pc);
> > +        } else {
> > +            /* M68020 Long Bus Cycle Fault (Format 0xB) */
> > +            /*
> > +             * 84 bytes of internal state are pushed before the generi=
c
> > +             * 8-byte header
> > +             */
> > +            sp -=3D 84;
> > +            for (int i =3D 0; i < 84; i +=3D 4) {
> > +                cpu_stl_be_mmuidx_ra(env, sp + i, 0, MMU_KERNEL_IDX, 0=
);
> > +            }
> > +            /* Offset 0x02 from internal frame: SSW */
> > +            cpu_stw_be_mmuidx_ra(env, sp + 2, env->mmu.ssw,
> MMU_KERNEL_IDX, 0);
> > +            /* Offset 0x08 from internal frame: Fault Address */
> > +            cpu_stl_be_mmuidx_ra(env, sp + 8, env->mmu.ar,
> MMU_KERNEL_IDX, 0);
> > +
> > +            do_stack_frame(env, &sp, 0xb, oldsr, 0, env->pc);
> > +        }
>
> Your patch got quite big already and does multiple things at once ... cou=
ld
> you maybe split independent parts like the above fixup for the stack fram=
e
> layout into a separate patch, so that this can get reviewed more easily?
>
> > diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> > index abc1c79f3c..d6fcd6c4d9 100644
> > --- a/target/m68k/translate.c
> > +++ b/target/m68k/translate.c
> > @@ -1,3 +1,4 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
>
> This file is also LPGL, not GPL.
>
>  Thomas
>

--000000000000ed199706518500da
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the feedback, I&#39;ll perform the clean-ups an=
d start splitting some stuff up. If you have more suggestions for how it&#3=
9;ll be easiest to cut, let me=C2=A0know.<div>I&#39;ll resubmit a new patch=
 and reference this one asap.</div><div><br></div><div>Thanks again,</div><=
div>Dan.</div></div><br><div class=3D"gmail_quote gmail_quote_container"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Sat, May 9, 2026 at 10:40=E2=80=AFPM=
 Thomas Huth &lt;<a href=3D"mailto:th.huth%2Bqemu@posteo.eu">th.huth+qemu@p=
osteo.eu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><br>
=C2=A0Hi!<br>
<br>
Thanks for your patches ... some comments inline below...<br>
<br>
Am Sat,=C2=A0 2 May 2026 18:57:50 -0700<br>
schrieb 54weasels &lt;<a href=3D"mailto:54weasels@gmail.com" target=3D"_bla=
nk">54weasels@gmail.com</a>&gt;:<br>
<br>
&gt; The M68020 natively maps hardware Bus Error (BERR) timeouts into a Lon=
g Bus Cycle Fault (Format 0xB). This commit adds the memory exception routi=
ng to natively synthesize these EXCP_ACCESS cycle faults. It also implement=
s the double-fault / watchdog reset behavior required for Sun-3 hardware di=
agnostics, properly handles FSAVE/FRESTORE for 68881 FPU stubs, and properl=
y constructs the 84-byte internal bus fault frame.<br>
&gt; <br>
&gt; Signed-off-by: 54weasels &lt;<a href=3D"mailto:54weasels@gmail.com" ta=
rget=3D"_blank">54weasels@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/m68k/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +-<b=
r>
&gt;=C2=A0 target/m68k/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 18 +++-<br>
&gt;=C2=A0 target/m68k/helper.c=C2=A0 =C2=A0 | 130 ++++++++++++++++++++++++=
++++-<br>
&gt;=C2=A0 target/m68k/op_helper.c | 176 ++++++++++++++++++++++++++--------=
------<br>
&gt;=C2=A0 target/m68k/translate.c |=C2=A0 31 +++++--<br>
&gt;=C2=A0 5 files changed, 283 insertions(+), 77 deletions(-)<br>
&gt; <br>
&gt; diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c<br>
&gt; index d849a4a90f..af375f0bce 100644<br>
&gt; --- a/target/m68k/cpu.c<br>
&gt; +++ b/target/m68k/cpu.c<br>
&gt; @@ -1,3 +1,4 @@<br>
&gt; +/* SPDX-License-Identifier: GPL-2.0-or-later */<br>
<br>
Looking at the comment at the top of this file, it clearly states that this=
<br>
file is licensed under the Lesser GPL, so this change is wrong.<br>
<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* QEMU Motorola 68k CPU<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; @@ -51,8 +52,8 @@ static TCGTBCPUState m68k_get_tb_cpu_state(CPUState =
*cs)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 flags =3D (env-&gt;macsr &gt;&gt; 4) &amp; TB_FLAG=
S_MACSR;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (env-&gt;sr &amp; SR_S) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flags |=3D TB_FLAGS_MSR_S;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 flags |=3D (env-&gt;sfc &lt;&lt; (TB_FLAG=
S_SFC_S_BIT - 2)) &amp; TB_FLAGS_SFC_S;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 flags |=3D (env-&gt;dfc &lt;&lt; (TB_FLAG=
S_DFC_S_BIT - 2)) &amp; TB_FLAGS_DFC_S;<br>
&gt; +=C2=A0 =C2=A0 flags |=3D (env-&gt;sfc &lt;&lt; TB_FLAGS_SFC_S_BIT) &a=
mp; TB_FLAGS_SFC_S;<br>
&gt; +=C2=A0 =C2=A0 flags |=3D (env-&gt;dfc &lt;&lt; TB_FLAGS_DFC_S_BIT) &a=
mp; TB_FLAGS_DFC_S;<br>
<br>
Wrong indentation now?<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (M68K_SR_TRACE(env-&gt;sr) =3D=3D M68K_SR_TRACE=
_ANY_INS) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flags |=3D TB_FLAGS_TRACE;<br>
...<br>
&gt; diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c<br>
&gt; index 8148a8852e..84d5270767 100644<br>
&gt; --- a/target/m68k/op_helper.c<br>
&gt; +++ b/target/m68k/op_helper.c<br>
&gt; @@ -1,3 +1,4 @@<br>
&gt; +/* SPDX-License-Identifier: GPL-2.0-or-later */<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0*=C2=A0 M68K helper routines<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; @@ -25,6 +26,7 @@<br>
&gt;=C2=A0 #include &quot;qemu/plugin.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #if !defined(CONFIG_USER_ONLY)<br>
&gt; +#include &quot;system/runstate.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static void cf_rte(CPUM68KState *env)<br>
&gt;=C2=A0 {<br>
&gt; @@ -73,6 +75,12 @@ throwaway:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 7:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sp +=3D 52;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0xa: /* Short Bus Cycle Fault (Forma=
t 0xA) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sp +=3D 32 - 8; /* 32 bytes=
 total - 8 bytes header =3D 24 bytes */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0xb: /* Long Bus Cycle Fault (Format=
 0xB) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sp +=3D 92 - 8; /* 92 bytes=
 total - 8 bytes header =3D 84 bytes */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 env-&gt;aregs[7] =3D sp;<br>
&gt; @@ -342,56 +350,80 @@ static void m68k_interrupt_all(CPUM68KState *env=
, int is_hw)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 switch (cs-&gt;exception_index) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case EXCP_ACCESS:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (env-&gt;mmu.fault) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_abort(cs, &quot;DOUBLE =
MMU FAULT\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERR=
OR,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &quot;M68K: Double MMU Fault. Halting CPU and request=
ing reset.\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_system_reset_request(S=
HUTDOWN_CAUSE_GUEST_RESET);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cs-&gt;halted =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cs-&gt;exception_index =3D =
EXCP_HLT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_loop_exit(cs);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;mmu.fault =3D true;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* push data 3 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 4;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERN=
EL_IDX, 0);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* push data 2 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 4;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERN=
EL_IDX, 0);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* push data 1 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 4;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERN=
EL_IDX, 0);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* write back 1 / push data 0 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 4;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERN=
EL_IDX, 0);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* write back 1 address */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 4;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERN=
EL_IDX, 0);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* write back 2 data */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 4;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERN=
EL_IDX, 0);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* write back 2 address */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 4;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERN=
EL_IDX, 0);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* write back 3 data */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 4;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stl_be_mmuidx_ra(env, sp, 0, MMU_KERN=
EL_IDX, 0);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* write back 3 address */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 4;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stl_be_mmuidx_ra(env, sp, env-&gt;<a =
href=3D"http://mmu.ar" rel=3D"noreferrer" target=3D"_blank">mmu.ar</a>, MMU=
_KERNEL_IDX, 0);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fault address */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 4;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stl_be_mmuidx_ra(env, sp, env-&gt;<a =
href=3D"http://mmu.ar" rel=3D"noreferrer" target=3D"_blank">mmu.ar</a>, MMU=
_KERNEL_IDX, 0);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* write back 1 status */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 2;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERN=
EL_IDX, 0);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* write back 2 status */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 2;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERN=
EL_IDX, 0);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* write back 3 status */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 2;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stw_be_mmuidx_ra(env, sp, 0, MMU_KERN=
EL_IDX, 0);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* special status word */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 2;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stw_be_mmuidx_ra(env, sp, env-&gt;mmu=
.ssw, MMU_KERNEL_IDX, 0);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* effective address */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 4;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stl_be_mmuidx_ra(env, sp, env-&gt;<a =
href=3D"http://mmu.ar" rel=3D"noreferrer" target=3D"_blank">mmu.ar</a>, MMU=
_KERNEL_IDX, 0);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_stack_frame(env, &amp;sp, 7, oldsr, 0,=
 env-&gt;pc);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (m68k_feature(env, M68K_FEATURE_M68040=
)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* push data 3 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stl_be_mmuidx_ra(env, s=
p, 0, MMU_KERNEL_IDX, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* push data 2 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stl_be_mmuidx_ra(env, s=
p, 0, MMU_KERNEL_IDX, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* push data 1 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stl_be_mmuidx_ra(env, s=
p, 0, MMU_KERNEL_IDX, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* write back 1 / push data=
 0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stl_be_mmuidx_ra(env, s=
p, 0, MMU_KERNEL_IDX, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* write back 1 address */<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stl_be_mmuidx_ra(env, s=
p, 0, MMU_KERNEL_IDX, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* write back 2 data */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stl_be_mmuidx_ra(env, s=
p, 0, MMU_KERNEL_IDX, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* write back 2 address */<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stl_be_mmuidx_ra(env, s=
p, 0, MMU_KERNEL_IDX, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* write back 3 data */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stl_be_mmuidx_ra(env, s=
p, 0, MMU_KERNEL_IDX, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* write back 3 address */<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stl_be_mmuidx_ra(env, s=
p, env-&gt;<a href=3D"http://mmu.ar" rel=3D"noreferrer" target=3D"_blank">m=
mu.ar</a>, MMU_KERNEL_IDX, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fault address */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stl_be_mmuidx_ra(env, s=
p, env-&gt;<a href=3D"http://mmu.ar" rel=3D"noreferrer" target=3D"_blank">m=
mu.ar</a>, MMU_KERNEL_IDX, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* write back 1 status */<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stw_be_mmuidx_ra(env, s=
p, 0, MMU_KERNEL_IDX, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* write back 2 status */<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stw_be_mmuidx_ra(env, s=
p, 0, MMU_KERNEL_IDX, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* write back 3 status */<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stw_be_mmuidx_ra(env, s=
p, 0, MMU_KERNEL_IDX, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* special status word */<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stw_be_mmuidx_ra(env, s=
p, env-&gt;mmu.ssw, MMU_KERNEL_IDX, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* effective address */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stl_be_mmuidx_ra(env, s=
p, env-&gt;<a href=3D"http://mmu.ar" rel=3D"noreferrer" target=3D"_blank">m=
mu.ar</a>, MMU_KERNEL_IDX, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_stack_frame(env, &amp;sp=
, 7, oldsr, 0, env-&gt;pc);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* M68020 Long Bus Cycle Fa=
ult (Format 0xB) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* 84 bytes of interna=
l state are pushed before the generic<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* 8-byte header<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 84;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int i =3D 0; i &lt; 84=
; i +=3D 4) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stl_be_mm=
uidx_ra(env, sp + i, 0, MMU_KERNEL_IDX, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Offset 0x02 from interna=
l frame: SSW */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stw_be_mmuidx_ra(env, s=
p + 2, env-&gt;mmu.ssw, MMU_KERNEL_IDX, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Offset 0x08 from interna=
l frame: Fault Address */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stl_be_mmuidx_ra(env, s=
p + 8, env-&gt;<a href=3D"http://mmu.ar" rel=3D"noreferrer" target=3D"_blan=
k">mmu.ar</a>, MMU_KERNEL_IDX, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_stack_frame(env, &amp;sp=
, 0xb, oldsr, 0, env-&gt;pc);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
Your patch got quite big already and does multiple things at once ... could=
<br>
you maybe split independent parts like the above fixup for the stack frame<=
br>
layout into a separate patch, so that this can get reviewed more easily?<br=
>
<br>
&gt; diff --git a/target/m68k/translate.c b/target/m68k/translate.c<br>
&gt; index abc1c79f3c..d6fcd6c4d9 100644<br>
&gt; --- a/target/m68k/translate.c<br>
&gt; +++ b/target/m68k/translate.c<br>
&gt; @@ -1,3 +1,4 @@<br>
&gt; +/* SPDX-License-Identifier: GPL-2.0-or-later */<br>
<br>
This file is also LPGL, not GPL.<br>
<br>
=C2=A0Thomas<br>
</blockquote></div>

--000000000000ed199706518500da--

