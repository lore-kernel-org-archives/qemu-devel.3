Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DBFC3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 15:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVBrp-0007OA-45; Sat, 20 Jul 2024 11:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVBrn-0007N0-S8
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 11:19:23 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVBrm-0006js-5Q
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 11:19:23 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5a2ffc3447fso1866789a12.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 08:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721488760; x=1722093560; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bGuakzEDT3A6sVjBDDWj9Q5Jw5tOU9PNvuR9CtPoQe4=;
 b=BchZUkb+zhB3H7rCQ7aEzt4vxNqO9AxVzmuz9rERlTHL3qMpFYpC04+t+UlWU9VYRB
 hloNgbsObO2AX4lmJHVQTJqAsQGy9KKr21cRzFHjpj4r6uE2nTm1/FptdKb5IKtoLOAo
 1k/fU/p/rUo4YDT+HiLQFK7OMplE4DOe9RWsmdKx5cpa0OsfV+ZaksvMZtetVg3pSkrp
 +tRAe6EFTW9T3LWZtCoXde/M5CobRheM+ksk8rRw7tNjqS3Io4yPmtZOnmgp/P1RcpY2
 nIKQWgdBu5JaN0Zsr3wd0bqBPoTvs1Ei2JZpp6RSi+P9Uk1X5bsA4IGM9nFAQf/B/1e5
 qKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721488760; x=1722093560;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bGuakzEDT3A6sVjBDDWj9Q5Jw5tOU9PNvuR9CtPoQe4=;
 b=kE9TSn209T2UwINapEI72cHljBrhqtSGNtNRBB0T/vI1vJquOsrmUZqvCcP8UKDDLC
 oityzItlMPq018xslBcepNM8uyXVzDOhxRhA7wFEF+R2OBcfw0XTOc9kt4hs9NQtE5Nu
 m4vFPzwYUgbJIKUqhiJHsVNB5ox4fFBr2DG955tp2PRJnwdd66RsFPZ4zJpCK8hFZBi8
 8pmo7SEPGjZlXT/H/7+oK5OohquwBS/TNGGfkJWzstgQmbHMd4eiGhU01EEzdOD6T2PV
 394IlgBMPioSEmoWJfXsexSqyT4SSJd3Ki2FQD732pO/F9Fw9/cXjSyZ0RbzU1lsjMpe
 SYYg==
X-Gm-Message-State: AOJu0Yx0E2NRKr/5Tn/uzBOSLfytRlf407TPrQtAG4DilkEYPF7xklfZ
 eeWdYAWRNVaqMYN7Bm2Hvqety4V6ClH/qDS9nxvxoOEU5b/aeJmOHp6LsPxJCtLvat043CG93t9
 L0146xy14Nb0MEm88Ada9ltgddxq9c6jc6oy/jQ==
X-Google-Smtp-Source: AGHT+IEUaY0rUecjXzXRaizcCSSxh6yjfFqTuSRC+A/h0CcdS1PIKsBmQfxe0tJ7PBzhFk5UJsiZ5Rx2sMijlgvqPN0=
X-Received: by 2002:a50:9fa8:0:b0:5a2:6e1c:91ed with SMTP id
 4fb4d7f45d1cf-5a47a61f401mr1193303a12.27.1721488759878; Sat, 20 Jul 2024
 08:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
 <20240718021012.2057986-27-alistair.francis@wdc.com>
In-Reply-To: <20240718021012.2057986-27-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 20 Jul 2024 16:19:09 +0100
Message-ID: <CAFEAcA-Lrnt30uvR5k+GVsM-goKuD7ZQzzxOpxocBf3C6BzvMg@mail.gmail.com>
Subject: Re: [PULL 26/30] target/riscv: Do not setup pmu timer if OF is
 disabled
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Atish Patra <atishp@rivosinc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Thu, 18 Jul 2024 at 03:15, Alistair Francis <alistair23@gmail.com> wrote:
>
> From: Atish Patra <atishp@rivosinc.com>
>
> The timer is setup function is invoked in both hpmcounter
> write and mcountinhibit write path. If the OF bit set, the
> LCOFI interrupt is disabled. There is no benefitting in
> setting up the qemu timer until LCOFI is cleared to indicate
> that interrupts can be fired again.
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Message-ID: <20240711-smcntrpmf_v7-v8-12-b7c38ae7b263@rivosinc.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/pmu.c | 56 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 44 insertions(+), 12 deletions(-)
>
> diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
> index a4729f6c53..3cc0b3648c 100644
> --- a/target/riscv/pmu.c
> +++ b/target/riscv/pmu.c
> @@ -416,14 +416,49 @@ int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
>      return 0;
>  }

Hi; I was looking at an issue Coverity flagged up with this code (CID
1558461, 1558463):

> +static bool pmu_hpmevent_is_of_set(CPURISCVState *env, uint32_t ctr_idx)
> +{
> +    target_ulong mhpmevent_val;
> +    uint64_t of_bit_mask;
> +
> +    if (riscv_cpu_mxl(env) == MXL_RV32) {
> +        mhpmevent_val = env->mhpmeventh_val[ctr_idx];
> +        of_bit_mask = MHPMEVENTH_BIT_OF;
> +     } else {
> +        mhpmevent_val = env->mhpmevent_val[ctr_idx];
> +        of_bit_mask = MHPMEVENT_BIT_OF;

MHPMEVENT_BIT_OF is defined as BIT_ULL(63)...

> +    }
> +
> +    return get_field(mhpmevent_val, of_bit_mask);

...but we pass it to get_field(), whose definition is:

#define get_field(reg, mask) (((reg) & \
                 (uint64_t)(mask)) / ((mask) & ~((mask) << 1)))

Notice that part of this expression is "(mask) << 1". So Coverity complains
that we took a constant value and shifted it right off the top.

I think this is probably a false positive, but why is target/riscv
using its own ad-hoc macros for extracting bitfields? We have
a standard set of extract/deposit macros in bitops.h, and not
using them makes the riscv code harder to read for people who
are used to the rest of the codebase (e.g. to figure out if this
Coverity issue is a false positive I would need to look at these
macros to figure out what exactly they're doing).

thanks
-- PMM

