Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C560C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 14:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWz5t-0007Xw-GE; Thu, 25 Jul 2024 10:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWz5r-0007N3-6y
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 10:05:19 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWz5o-0004Kb-Qi
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 10:05:18 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-59f9f59b827so1236252a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 07:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721916315; x=1722521115; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jAQ8h7ug9mzXLs8u7xkHpfHgVDuK7aq0ju1TyGgW5fs=;
 b=Z6ash/Rf80LAl/tbg4hs5nsCFgC5/osHJjFnIikdQXQmW7rDAzrXXgQ8JwV+vyRPeX
 tS+Y2/h075LbvhZhfhCYEa7W7tQq0Gmf78YRAYaNYlpuWzFQcfomZf7LX3pcc+Z5/jfV
 dHDF3N6jbx8tC/Ew7TZxHW4j7Dllj8bL3Ds7aTzXmjZdx4ZTOAB40Zp38lcF8GurqbVU
 ZMYkxEPpCd/KWX9WEoPS2CTFa/cDdXsCt1IomOi5rRJn4VSkJpQBlfNc+prXYWSI3Mx+
 +Vk+FyLUeVhrhfGT/9AscLO5gzWGprX1bs8JIQF8X33VrgHjEFTzV1TZkY8cY2Nu35TV
 V6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721916315; x=1722521115;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jAQ8h7ug9mzXLs8u7xkHpfHgVDuK7aq0ju1TyGgW5fs=;
 b=vGjiae6x9bs0wLP1Nd1VkzmyZfKXZDCcla6NXPrbWt/YyApqyfpLi2TrYd/b3cvchC
 +euCOKd4tfDBjGKk8gDNsSTnBTQjYVCybGQ5aXh4kKEj+miVEEFt8WPeWTg9+Q+CWQaz
 AMCyQTpO4gD2sqO8ussyd4T8ddRrURRpymBG7wsg6VKmwH4C88PKXMzzAGhK8YjDfqSP
 J26h7z4jIRaLKE7Oll5Yr+BHeRA1vO7Tw8idKvViEyQ0hPfmGzovajuuaoDQDGU6Qrp0
 FKGknfHRykvoy7G2jKTbRfcGbeLtw/3tc2zOk0K/S2fsa1dTfr3mcXBIBYawHk7YVx6V
 HBXw==
X-Gm-Message-State: AOJu0Yx4b1Z2VIf9z8AZbeYa03ZaJ2720KdnXGQW5KFMtUg669AgVy8u
 pCjTvvS91VyMWZwulYATe7o9QnE71xqAcMFEYtxeoXyl03q2M4zDDjAN9i327WlDyBxh8JgnT9+
 hUveqVEHzXJSVksouLBamLfxDxqWiF18Wr/ks2Q==
X-Google-Smtp-Source: AGHT+IHfM3gazbTj85hU7TfeqeTy6wqCRoPDEkyMUldtAzAuY3EBYx9Oblow7VhGwj15biUqQYobKAQMILdXv2eRkPY=
X-Received: by 2002:a05:6402:50d3:b0:58b:fd23:7065 with SMTP id
 4fb4d7f45d1cf-5ac2a7b7195mr2234133a12.16.1721916314859; Thu, 25 Jul 2024
 07:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
 <20240718021012.2057986-27-alistair.francis@wdc.com>
 <CAFEAcA-Lrnt30uvR5k+GVsM-goKuD7ZQzzxOpxocBf3C6BzvMg@mail.gmail.com>
In-Reply-To: <CAFEAcA-Lrnt30uvR5k+GVsM-goKuD7ZQzzxOpxocBf3C6BzvMg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jul 2024 15:05:02 +0100
Message-ID: <CAFEAcA88WWBRidvQp0+TLNh21gGo+JAa4dNKA55m99a2b59dAg@mail.gmail.com>
Subject: Re: [PULL 26/30] target/riscv: Do not setup pmu timer if OF is
 disabled
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Atish Patra <atishp@rivosinc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Sat, 20 Jul 2024 at 16:19, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 18 Jul 2024 at 03:15, Alistair Francis <alistair23@gmail.com> wrote:
> >
> > From: Atish Patra <atishp@rivosinc.com>
> >
> > The timer is setup function is invoked in both hpmcounter
> > write and mcountinhibit write path. If the OF bit set, the
> > LCOFI interrupt is disabled. There is no benefitting in
> > setting up the qemu timer until LCOFI is cleared to indicate
> > that interrupts can be fired again.
> > Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > Message-ID: <20240711-smcntrpmf_v7-v8-12-b7c38ae7b263@rivosinc.com>
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/pmu.c | 56 ++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 44 insertions(+), 12 deletions(-)
> >
> > diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
> > index a4729f6c53..3cc0b3648c 100644
> > --- a/target/riscv/pmu.c
> > +++ b/target/riscv/pmu.c
> > @@ -416,14 +416,49 @@ int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
> >      return 0;
> >  }
>
> Hi; I was looking at an issue Coverity flagged up with this code (CID
> 1558461, 1558463):
>
> > +static bool pmu_hpmevent_is_of_set(CPURISCVState *env, uint32_t ctr_idx)
> > +{
> > +    target_ulong mhpmevent_val;
> > +    uint64_t of_bit_mask;
> > +
> > +    if (riscv_cpu_mxl(env) == MXL_RV32) {
> > +        mhpmevent_val = env->mhpmeventh_val[ctr_idx];
> > +        of_bit_mask = MHPMEVENTH_BIT_OF;
> > +     } else {
> > +        mhpmevent_val = env->mhpmevent_val[ctr_idx];
> > +        of_bit_mask = MHPMEVENT_BIT_OF;
>
> MHPMEVENT_BIT_OF is defined as BIT_ULL(63)...
>
> > +    }
> > +
> > +    return get_field(mhpmevent_val, of_bit_mask);
>
> ...but we pass it to get_field(), whose definition is:
>
> #define get_field(reg, mask) (((reg) & \
>                  (uint64_t)(mask)) / ((mask) & ~((mask) << 1)))
>
> Notice that part of this expression is "(mask) << 1". So Coverity complains
> that we took a constant value and shifted it right off the top.
>
> I think this is probably a false positive

Having worked through some examples I'm happy that this is
a false positive and the expression used here does the
right thing even when the mask goes right up to bit 63.
So I've closed the Coverity issues as false positives;
whether we decide it's worth converting the riscv target to
use QEMU's more standard accessor macros is a separate issue.

If we do want to keep these get_field/set_field macros,
could we add a documentation comment that says what they
do, including description of what the arguments are?

thanks
-- PMM

