Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E52CA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 15:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uveGB-0007Rg-9e; Mon, 08 Sep 2025 11:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uveFz-0007NR-Fs
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 11:58:17 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uveFm-0008G2-Du
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 11:58:11 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-71d5fb5e34cso48645567b3.0
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 08:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757347079; x=1757951879; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gLon0Fa9WtHF8CAU41HAAqYVB0puzXq3puXxutd3qw4=;
 b=YFVfhXRJEY+cRcJxfcCjsxVFNY/saSN3TG2ULd5NT7hDacI7ypQDLL5x0CYpLtxETd
 t808IS2KwJYkv5lCRZ5QG6aFWfZZ9pqLQTbW8FjKz7UZeXQX7I4MX2Fmkeb0NHo97tB/
 o9lW96FTpms8CGNumY3mvIPJutT2gB9RqQW94q/whGq4s602l4SWSbg851TP1hBxXPMi
 gRjsxKqHYVJ+6h28VVd1wnkH4VdM6//9AsZnPE5oSsdutmWj7AYNxVIyUIth/zGOcq6U
 Ri8sR6H/LKNHjVTwjkuKCrQE/DP1Z+pXM6oIKEhg6EQ3GfQn8QXLJwSh3xcsmY7LbQHN
 U/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757347079; x=1757951879;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gLon0Fa9WtHF8CAU41HAAqYVB0puzXq3puXxutd3qw4=;
 b=LpKaigsVgLI32JdhLoiRfUx3mDaH/Y1MGlAQCoYTQp5e96QZXNMA+vtaXMHw/mkvNv
 NjATOOWW6AZ8wiT8PJaO7jCXnB/p7fq8Icg4JOXJSkWnXe1dQkWv6NGxGUKZ0QQbzS3W
 EjY3leTAI+Q6qSAgDBr2FjBrNFu/VTn1MpBeIJFMkjOBNuixeBwDlJ1++jkraF8ubym5
 tzFgFo4uuh1JCtYI525f6jAx4M8A8cfFnYLwWTyDMT+cadLK5Qg00/9lgRL0qaGT4NUo
 VXxFs/ruOiQypfeQRsyUTmFU3CSrffoTAGXQC9ufJ2YUh4iYXdu91gvsc8F2reO6Yf6Z
 LvdA==
X-Gm-Message-State: AOJu0YxtRHBn+ZU05XfH6d2gGqE4xujHAAaCMT/2EagTC8GgJDmgQntc
 UrL3bsSx70qXrxwAs3aECbBildQfwJPd7wiOsiTJwsF+P62M3Xz9NKT9b/qq9oCR+Xr3kNTqYoU
 TuAfviCFUVLH3tNo3LxVvTrN0J3CHN30fOfCtvKDJ/w==
X-Gm-Gg: ASbGncs7ut3x8yioWvE0DsIm609VOq4p3rvdu96gl2jBxmPtOvFnmiLFnqBHTC8AWNS
 fcPJiPbfkGpCOZVdrPjARdMyDdqZBXGe9OQ9o/ACQOXoczGoeb4pElgTRBoBKNdmTolLUwX+EV/
 yNKZJxyukRhXWjQzLdXdzjgNyQVTh+dLk2U97yHsxbdKwlZN31iGwV90HbUZ5oz1D4ga1AEwj2Y
 nqNeiXA
X-Google-Smtp-Source: AGHT+IEIkONnkWI0Oh6NJfM9qh/alTRvBzkMzMtDZQlP0wSpkJZZfsN4O5Yh/5HJ+f3mx4og11VIOl9okWsyUfNzV+c=
X-Received: by 2002:a05:690c:25c5:b0:724:ba3e:8315 with SMTP id
 00721157ae682-72808a4d735mr75880277b3.7.1757347078706; Mon, 08 Sep 2025
 08:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250830054128.448363-1-richard.henderson@linaro.org>
 <20250830054128.448363-51-richard.henderson@linaro.org>
In-Reply-To: <20250830054128.448363-51-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Sep 2025 16:57:47 +0100
X-Gm-Features: Ac12FXyKQQRdd6nyhJ4RKoMlZK62U5A2pfB1HvKrndm1bnMvxTe9t-qXQC4sbog
Message-ID: <CAFEAcA-DbtHsjPPhRwhbDQ+QZxwSu2Yfs9xacRbFFJVNvm8M=A@mail.gmail.com>
Subject: Re: [PATCH v4 50/84] target/arm: Expand pstate to 64 bits
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, 30 Aug 2025 at 18:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The ARM now defines 36 bits in SPSR_ELx in aarch64 mode, so
> it's time to bite the bullet and extend PSTATE to match.
>
> Most changes are straightforward, adjusting printf formats,
> changing local variable types.  More complex is migration,
> where to maintain backward compatibility a new pstate64
> record is introduced, and only when one of the extensions
> that sets bits 32-35 are active.
>
> The fate of gdbstub is left undecided for the moment.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>



> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index 8dbeca2867..9b00c14b4a 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -836,6 +836,61 @@ static const VMStateInfo vmstate_cpsr = {
>      .put = put_cpsr,
>  };
>
> +static int get_pstate64_1(QEMUFile *f, void *opaque, size_t size,
> +                          const VMStateField *field)

Why the _1 suffix ?

> +{
> +    ARMCPU *cpu = opaque;
> +    CPUARMState *env = &cpu->env;
> +    uint64_t val = qemu_get_be64(f);
> +
> +    env->aarch64 = ((val & PSTATE_nRW) == 0);
> +    pstate_write(env, val);

We should either enforce that the value has nRW == 0
(failing migration by returning nonzero if it is not) or
else handle the case where nRW != 0 via cpsr_write().

I note that there is actually a defined bit above 32
in the SPSR_ELx format for exceptions taken from
AArch32 to AArch64: PPEND, used with FEAT_SEBEP. That
suggests we should probably at least consider handling
64-bit AArch32 "CPSR" values, though FEAT_SEBEP in
particular may be out of scope for us.

Incidentally I think we are not correctly migrating
PSTATE.SS when in AArch32 -- we will migrate the CPSR
via cpsr_read() / cpsr_write(), but that view doesn't have
the PSTATE.SS bit in it. Possibly these things could
be addressed at the same time, so we have a subsection
for 64-bit pstate/cpsr, and its save/load uses
cpsr_read_for_spsr_elx() (and a corresponding _write_
that we don't have yet) when AArch32, and the .needed
function is "if top 32 bits not all zero, or PSTATE_SS bit
is set".

> +    return 0;
> +}
> +
> +static int put_pstate64_1(QEMUFile *f, void *opaque, size_t size,
> +                          const VMStateField *field, JSONWriter *vmdesc)
> +{
> +    ARMCPU *cpu = opaque;
> +    CPUARMState *env = &cpu->env;
> +    uint64_t val = pstate_read(env);
> +
> +    qemu_put_be64(f, val);
> +    return 0;
> +}
> +
> +static const VMStateInfo vmstate_pstate64_1 = {
> +    .name = "pstate64",
> +    .get = get_pstate64_1,
> +    .put = put_pstate64_1,
> +};
> +
> +static bool pstate64_needed(void *opaque)
> +{
> +    ARMCPU *cpu = opaque;
> +    CPUARMState *env = &cpu->env;
> +
> +    return is_a64(env) && pstate_read(env) > UINT32_MAX;
> +}
> +
> +static const VMStateDescription vmstate_pstate64 = {
> +    .name = "cpu/pstate64",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = pstate64_needed,
> +    .fields = (const VMStateField[]) {
> +        {
> +            .name = "pstate64",
> +            .version_id = 0,
> +            .size = sizeof(uint64_t),
> +            .info = &vmstate_pstate64_1,
> +            .flags = VMS_SINGLE,
> +            .offset = 0,
> +        },
> +        VMSTATE_END_OF_LIST()
> +    },
> +};

Probably worth also adding a comment to get_cpsr() along
the lines of "If any bits are set in the upper 32 bits of
PSTATE then the cpu/pstate64 subsection will override this
pstate_write() later with the full 64-bit PSTATE."

> +
>  static int get_power(QEMUFile *f, void *opaque, size_t size,
>                      const VMStateField *field)
>  {
> @@ -1119,6 +1174,7 @@ const VMStateDescription vmstate_arm_cpu = {
>          &vmstate_serror,
>          &vmstate_irq_line_state,
>          &vmstate_wfxt_timer,
> +        &vmstate_pstate64,
>          NULL
>      }
>  };
> diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
> index 71c6c44ee8..f61adf1f80 100644
> --- a/target/arm/tcg/helper-a64.c
> +++ b/target/arm/tcg/helper-a64.c
> @@ -639,7 +639,7 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
>      ARMCPU *cpu = env_archcpu(env);
>      int cur_el = arm_current_el(env);
>      unsigned int spsr_idx = aarch64_banked_spsr_index(cur_el);
> -    uint32_t spsr = env->banked_spsr[spsr_idx];
> +    uint64_t spsr = env->banked_spsr[spsr_idx];
>      int new_el;
>      bool return_to_aa64 = (spsr & PSTATE_nRW) == 0;

thanks
-- PMM

