Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EF8C87FCC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 20:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhZyv-0000tX-05; Thu, 31 Jul 2025 16:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhYic-0000gD-8X
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 15:13:34 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhYiZ-0002IP-3v
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 15:13:33 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-23fd3fe0d81so8241665ad.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 12:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753989209; x=1754594009; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dq6eaC/MXnX/a2vAYULD5I/WrR7dJ1YgCG1l20CTq58=;
 b=VF4ZkwhWfRIDRhshwnmLxi+xHqptXPfmtYBWTETRQS3K0cdjmMtcimQq5gY6eb9Fpy
 WlX4meORQ9Pm1v9DvZNws1WRlLVL8hOE+AxJp2OhzhC9RiNZxyClBxIxGXCPT1jMaQuC
 jwKrwDyS+gHDp90UMLSjV8L3IoGizOVu1QdQZt9TMVaz4tw+a7RFiQ9vK8PteH2PKrvm
 M8wjMUThHMx+myjNZucHWf8xNU0bUySl1LFCiCm2QUE4DPsqtLnssGcdBygji6IooRIo
 PvoG3TfeH1yrKhZPk3prbTMJWlUmNvcPF5qSnWMVc4LqMIgGUaxfnXM5oKK4bWW5Opj4
 Ij7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753989209; x=1754594009;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dq6eaC/MXnX/a2vAYULD5I/WrR7dJ1YgCG1l20CTq58=;
 b=TbeVtSqIBt9iMmDGbXRZehbnkLhwfP6/3uFWi5M8Rk9Li85AI6L1gqb7yd8Zz3D2KG
 TmZLlFskrhNoQiHb0RTridrc+yKTYyL0S4sdJk7krTsslkxGLoqRVmUWwvH/5wd6IxJk
 LfHNt51wLayuEY/39WSjn3E0LbyrvOTfL5Fj/kYkbYHayr5sEdW+cMoz0xxSrT/CQ6jG
 05VUXsJb3ujRiuYJykn5iZC4XZOm2/UwbxupFy3vmSsMhgNFXeLHMGs4z4Z6OoQuomXF
 UcaY0/uF/UBldzyeP5tOi3JulIYeqncEMwRVB23/kPUMMKme9qPaRwYzECDEoJt+lWOY
 FZWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIbskwxVjKAdPljj0Jwu3i0kGHz7e1ZxhdOBuiiC47y670ba0OuioNtPvVKijwc8KHXGM7kwGv29t6@nongnu.org
X-Gm-Message-State: AOJu0YybiV+HzRc2TVYsFUQYbwBysuXNEHEUFL3sXqyy3jjqoCiNzeGP
 lBQE9lca1WAftraovQ9Lj4zheebT8dmJjf2p6BQ5WPDp9Y3it8UDEOyKwDQY15O0NnY=
X-Gm-Gg: ASbGncuHRJeXKW3tW9UK2N8l7ySUK9k6nE1eCIg9pf2xjtRnMNn1ZYGbrtP+TpLrV/a
 5LPXHE6BfOmyksK2bseUj0bBzU7GLaQyyCOKwUXHcajsMXcNeR9dceF5L6bgqir1QflMmyuR+Si
 6MilFynmvirT48azNtuzoCB8brzPai5k4b4Mn7CTxsuDfCZrLapAjGAXT8xO7HzNeT1boOFwRpS
 qSY/U0k/OUGWtpPseIlOy/66UyGj5TtgLbpX63n8r490uE7JLzw5g9SscqqfIrnQW1qI9WyyBsn
 eDmPv3Jgmcu07nEwTacq+/Ad7AdvmbyEh4s05StgoxcTj091QIWPFVcJd4ecwz+O2+YrFoVIsUa
 PVLiyG4mbM/qRKd7Z8TfwCYcw9aKzSru6g24=
X-Google-Smtp-Source: AGHT+IEMYvPzxKxk3Z8IjYMDPXTtwgpPJnx8MQdUrC7XPkGNu/h0hqoCP5dTWqxBI9FNsgNhDM1z/Q==
X-Received: by 2002:a17:902:ef46:b0:240:2145:e50b with SMTP id
 d9443c01a7336-24096a72addmr112796865ad.11.1753989209313; 
 Thu, 31 Jul 2025 12:13:29 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef6aa4sm24353205ad.35.2025.07.31.12.13.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 12:13:28 -0700 (PDT)
Message-ID: <b2e40787-6043-4d4c-9cbb-731d0e92e25c@linaro.org>
Date: Thu, 31 Jul 2025 12:13:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 47/82] target/arm: Expand pstate to 64 bits
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-48-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-48-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h            |  8 +++---
>   target/arm/tcg/translate.h  | 20 ++++++-------
>   target/arm/cpu.c            |  6 ++--
>   target/arm/gdbstub64.c      |  1 +
>   target/arm/helper.c         | 11 ++++----
>   target/arm/machine.c        | 56 +++++++++++++++++++++++++++++++++++++
>   target/arm/tcg/helper-a64.c |  2 +-
>   7 files changed, 81 insertions(+), 23 deletions(-)

...

> diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
> index 64ee9b3b56..3cef47281a 100644
> --- a/target/arm/gdbstub64.c
> +++ b/target/arm/gdbstub64.c
> @@ -47,6 +47,7 @@ int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>       case 32:
>           return gdb_get_reg64(mem_buf, env->pc);
>       case 33:
> +        /* pstate is now a 64-bit value; can we simply adjust the xml? */
>           return gdb_get_reg32(mem_buf, pstate_read(env));
>       }

If I'm correct, we currently don't expose PSTATE through gdbstub, but 
only CPSR. This was a bit confusing for me, considering that CPSR is not 
even supposed to exist in Aarch64.
Maybe it's a good opportunity to expose PSTATE instead, which could have 
a 64 bits size. This way, we don't break any workflow.

...

> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index 8dbeca2867..9b00c14b4a 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -836,6 +836,61 @@ static const VMStateInfo vmstate_cpsr = {
>       .put = put_cpsr,
>   };
>   
> +static int get_pstate64_1(QEMUFile *f, void *opaque, size_t size,
> +                          const VMStateField *field)
> +{
> +    ARMCPU *cpu = opaque;
> +    CPUARMState *env = &cpu->env;
> +    uint64_t val = qemu_get_be64(f);
> +
> +    env->aarch64 = ((val & PSTATE_nRW) == 0);
> +    pstate_write(env, val);
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
> +
>   static int get_power(QEMUFile *f, void *opaque, size_t size,
>                       const VMStateField *field)
>   {
> @@ -1119,6 +1174,7 @@ const VMStateDescription vmstate_arm_cpu = {
>           &vmstate_serror,
>           &vmstate_irq_line_state,
>           &vmstate_wfxt_timer,
> +        &vmstate_pstate64,
>           NULL
>       }
>   };
> diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
> index 71c6c44ee8..f61adf1f80 100644
> --- a/target/arm/tcg/helper-a64.c
> +++ b/target/arm/tcg/helper-a64.c
> @@ -639,7 +639,7 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
>       ARMCPU *cpu = env_archcpu(env);
>       int cur_el = arm_current_el(env);
>       unsigned int spsr_idx = aarch64_banked_spsr_index(cur_el);
> -    uint32_t spsr = env->banked_spsr[spsr_idx];
> +    uint64_t spsr = env->banked_spsr[spsr_idx];
>       int new_el;
>       bool return_to_aa64 = (spsr & PSTATE_nRW) == 0;
>   

Would that be better or worse to simply save the upper 32 bits, 
considering that cpsr already holds the lower ones in Aarch64 mode?

