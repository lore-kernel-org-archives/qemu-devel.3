Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE72ACD98E1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 02:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZgCz-00062c-20; Tue, 16 Jun 2026 22:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wZgCx-000629-4x
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 22:40:51 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wZgCv-0002F4-28
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 22:40:50 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-7dd5a8dc8a2so32514777b3.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 19:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781664048; cv=none;
 d=google.com; s=arc-20240605;
 b=L6c7pzkjsRZ2vu3B4dNJFAORxHxyISnqFq0KclR0lywWRoc96FAKpSFYNEu13nSBL7
 hja9sZM68GtDA3xWGymrZcOl1SqlA4iWfCsgRaKWXGfHvO5lsnfyx50lwkqCTU5TKh3u
 EUClUM35Re2xSpb4kNYSsllLSNYpRFP+SJc9y/TnPCJEUK+SgNx2m1aa4Td19cDXbTL1
 Eavq29EMaUhYnKuEt2oW4Sa0gVhZYOwmztoUOD48VMp+1iK/q1W2PZ6qCPlASacapoZv
 e8Qcj2HTSWcTTtFEcbXee8TEmFgFug1TwtZhQnoT9FmSxeXO6oQzRHpM5psSpotxAS1z
 FVCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ki+tQbmsrw6Ylm0o1sjml5MOnRY8/qYyCKJzfB4soxA=;
 fh=PoAwrGxG0ksViGPk6BU8l+zs3La3sU3NDYGHuylDZV4=;
 b=hmQNaYLYnwaTLYV3ebnqWEYhwxINA4yf8iLIg2RFLBgXV8CcnCqvd47giTNLbQ/YRo
 SEuVfBAwlYAhesB8xTOEDp3GBQMD6NK4EFKYbOs2WTWOJb0z42uUJLDm12ATNv6N1AJ0
 dU55Nq7FkqwYMQgMTe2KeZFBfSXmjCQqMnarxCvUwsOCXM8Ps4hN+DH5MhQfgd+difgt
 P2+2MGo+T8Emg87SKj/jQIILPb+lCNVSaKo/VhTzcVfKiFwdOxbwHxrvdXvXAwaFBzGl
 XrRiPKo6+fQP/kn3vqiaxHbbc97zW+MHXZyOSSjqDNJHw/JhhNPYMCdRVi0aDsS/rEW3
 OhYQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1781664048; x=1782268848; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ki+tQbmsrw6Ylm0o1sjml5MOnRY8/qYyCKJzfB4soxA=;
 b=KakuuWWzV+utpx+ZUBD+hro0fCFfXch7MFvnfXZ5hLPEeutdWcLoJIcB0OnYeVSc9Z
 d7XkBsQwA7GnZPxzgaoy4PLeFFQXpwXC3dN85uMKOObgyc46wlhSTCLnZxOPOHy3tFP2
 rho8MmDjnJYwnBpqG2IazWTF+psHM+CJxPf94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781664048; x=1782268848;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ki+tQbmsrw6Ylm0o1sjml5MOnRY8/qYyCKJzfB4soxA=;
 b=BXvE3T6akoVxCI+OJHus8RLoEPlyhTjiDsQd1jUzk8LvIVKQQhlyHjBASyyawI0Lte
 Hbd69rJ2MIWIPd1rtBFr1APdjB4U0sjzfvydh9NuQ4YcavVZ2wep2sgcDIFZndqxPKTn
 BumsXgWZ44/Y/V9I807Qt688DQJ81MzeoUm1t9kb5QXd5zhza8AIX0J4JeDfKmMrFN6u
 HysBZOqk5r16CLsm355sn9ViCvB4LQcxWsVnNYsgKxXmcCPUdD48AXhJTyTwFFc6ccBd
 9/Zq1ularoX273dGN+tBBhYqI9KoQbgo7FLifH5VNawmkuCk6/nXC9hCfxr+xkoIxNLi
 oRlA==
X-Gm-Message-State: AOJu0Yw3cDplaPtmuyixKRE/5qTzrJFUGQ4ehoO6YyUIeOtp0lMHTR2y
 PlM+shOVOQQkpXDfUqJ3zOHQtl56PxYD1KVCjnCF3lyx+QQOp82tOyYOUgois3K/JHKxfIJH+R9
 welXVq4eylHpv5U3c8TCDNDomNQx+bbs=
X-Gm-Gg: AfdE7clmXVpP1p7sJaioybYkxgJL6TK67zaUZL2BjQElC1k62CwZOPB3/CWyxmrTKoW
 wPPY7HLnNqdEQiDXXVTeC+OrJCVxeItiWRZkIWlzLtXV5NiX+EryL6QMs45Ct5sk4KGlecAlruC
 5OL1jvPiD1z5MwLnll6pr9SZx5olOUu1UfNq4nOB1A0fXMmZ8GfcqNLlLFz3jc6Xmesl/omdF/3
 R/+26VlaOoGvJUGR4e8OOWy1sagiuv29wSiCxGZcwbiDCJu0INqR4XkL2r8Ggj4HycOqf50M9xC
 RlzPfIsZsgmXHN/h6pi+OWWMxqLA0Y751zKT4RwfixVVxGR/e96gGVyUJukVAn05Rdb15hFVesI
 8oQg8CrrmGynm4g==
X-Received: by 2002:a05:690c:9b0a:b0:7dc:9693:57b0 with SMTP id
 00721157ae682-7fe5ff70384mr17848287b3.42.1781664047707; Tue, 16 Jun 2026
 19:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260520125406.28693-1-anjo@rev.ng>
 <20260520125406.28693-16-anjo@rev.ng>
 <6633f78c-2291-4f6e-9ef0-9d3198cd30a6@oss.qualcomm.com>
 <aiAc8ZZtYhJ5hJ-7@hive.localdomain>
In-Reply-To: <aiAc8ZZtYhJ5hJ-7@hive.localdomain>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 17 Jun 2026 12:10:36 +0930
X-Gm-Features: AVVi8CcSIM56Ko_AT2ccLcq7kob5LvXphbV3UCG4mWf0MwgO5s5Dn0AyNcPR4Sk
Message-ID: <CACPK8XeM5HAjfUJ4t_crwB_wLfmYfigm_=d0qPPXNDVyFTECSw@mail.gmail.com>
Subject: Re: [PATCH v7 15/27] target/riscv: Fix arguments to board IMSIC
 emulation callbacks
To: Anton Johansson <anjo@rev.ng>, alistair.francis@wdc.com, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pierrick.bouvier@linaro.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=joel.stan@gmail.com; helo=mail-yw1-x112a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hello Alistair,

On Wed, 3 Jun 2026 at 21:59, Anton Johansson via <qemu-riscv@nongnu.org> wrote:
>
> On 03/06/26, Daniel Henrique Barboza wrote:
> > Hi,
> >
> > This patch is causing a seg fault in rmw_xireg_aia():

It looks like this version of the patch made it into master in your
latest pull request.

We don't have any boot tests that set aia=aplic-imsic, so none of the
in-tree tests caught it.

I'll send a patch and a new test.

Cheers,

Joel

> > #0  0x0000aaaaab3bda20 in rmw_xireg_aia
> >     (env=0xaaaaac194d80, csrno=849, isel=114, val=0x0, new_val=0, wr_mask=18446744073709551615)
> >     at ../target/riscv/csr.c:2735
> > #1  0x0000aaaaab3be320 in rmw_xireg (env=0xaaaaac194d80, csrno=849, val=0x0, new_val=0, wr_mask=18446744073709551615)
> >     at ../target/riscv/csr.c:2950
> > #2  0x0000aaaaab3c5628 in riscv_csrrw_do64
> >     (env=0xaaaaac194d80, csrno=849, ret_value=0x0, new_value=0, write_mask=18446744073709551615, ra=281472560986724)
> >     at ../target/riscv/csr.c:5813
> > #3  0x0000aaaaab3c5884 in riscv_csrrw
> >     (env=0xaaaaac194d80, csrno=849, ret_value=0x0, new_value=0, write_mask=18446744073709551615, ra=281472560986724)
> >     at ../target/riscv/csr.c:5871
> > #4  0x0000aaaaab3cb670 in helper_csrw (env=0xaaaaac194d80, csr=849, src=0) at ../target/riscv/op_helper.c:75

> > >               /* Call machine specific IMSIC register emulation */
> > > -            ret = env->aia_ireg_rmw_fn[priv](env->aia_ireg_rmw_fn_arg[priv],
> > > +            ret = env->aia_ireg_rmw_cb[priv](env->aia_ireg_rmw_cb_arg[priv],
> > >                                       AIA_MAKE_IREG(isel, priv, virt, vgein,
> > >                                                     riscv_cpu_mxl_bits(env)),
> > > -                                    val, new_val, wr_mask);
> > > +                                    &wide_val, new_val, wr_mask);
> > > +            *val = wide_val;
> >
> > Here.  We can't just do *val = wide_val because there's no guarantee that *val,
> > i.e. the 'ret_value' of riscv_csr_op_fn(), is not NULL:
> >
> > typedef RISCVException (*riscv_csr_op_fn)(CPURISCVState *env, int csrno,
> >                                           target_ulong *ret_value,  <--------
> >                                           target_ulong new_value,
> >                                           target_ulong write_mask);
> >
> > This fixes it:
> >
> >    if (val) {
> >        *val = wide_val;
> >    }
> >
>
> Agh, good catch and thank you Daniel! I'll address this in a v8.
> Alistair, if it's easier for you to do this change on your end, feel
> free to do so and ignore my v8. Unsure of the praxis in this situation.
>
> --
> Anton Johansson
> rev.ng Labs Srl.
>

