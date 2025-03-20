Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC82AC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 07:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvAV4-0008Oj-An; Thu, 20 Mar 2025 03:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvAUz-0008KY-IN
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 03:39:29 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvAUw-0006CW-1R
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 03:39:29 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso2155135e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 00:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742456364; x=1743061164; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nf4r+1HHRl9mM0NAlDwdoIGe7010ICXlf3pq30lWtuw=;
 b=Yu22gQQapy3bJx8+S+rQ1IqYL8Kms3td4eRPJKHKN8watuzyRlDceagj1/s/lgHKNb
 Hw7F7HjCAzFwHvTOBdeP3uoHdtJzlTZEWCuhFJ8UWMeOPwxBLdaAcT+iYSc+Ano88qqS
 MlYUgJgAj/snf7rRsd8BlRIpbqb4p7en6aANvc18K3K6hyqUCFZDE1Gi/k+bncdm3MYE
 bDG137Uf/c+YDy9pRO4VLUKtw7gz4WhiVWrLBVdNro1S53hOobtZQx7cdvAzc7gRA5le
 KI8QBwNKU09DIW0l26Xz5Ep+vvuX24jGbjk9Ke7dIWP4T+pEYeuXfeqkBPIs2GXYfPN9
 Y6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742456364; x=1743061164;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nf4r+1HHRl9mM0NAlDwdoIGe7010ICXlf3pq30lWtuw=;
 b=GQLZThQEbbA9MAcoeYaV8Evn+0KqOXPe44ntRZ7oOODH4JocmL7zALRe4JqU8eO+qm
 NfDjFQvtQvaLFDqdI7nb8UOq1ZRlhD4eby/feAGij/HTx4khMRn0NEGgGP9HyoPnLdNQ
 WxUlngT9qqHbGQkDtiK5zefOXIovI5Uzake0x0TtiywgwrskMzPiDLwnW8Q5K8nBoV4C
 Zqm/fMGTFwpazc6xg5B0uQyIBivQZDR3qvAzo9xiTtc0ettX4hb5byxOF4aXtJWfr2Au
 e0Fhifce57PEuHhSXXdYN5Xfii87IidM3zyyyzMRWD9NtcLTN33o2pkWyVh8LzOFfZ0U
 uKmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiqTQJxkJGmRlIjpIOak1r1IBK5n/LKJIhqnLgemLpdZ824VtTfQzQZSYJ05lNAqnAxXx92zwuPw0Y@nongnu.org
X-Gm-Message-State: AOJu0YxTan6is7d2qTiq+Ezd/PAPKiOqVTjGdvdIWLD1wn3W00Rip8o0
 xsYoA4XPBMyi7EaBFeoQov0UjsVPjOLkeS5Rfw83tf3gLKSeZo8x2EWKQ8rPpo0=
X-Gm-Gg: ASbGncu+kbu0wGRE8V+GwOoQT2eVRQeYvD7dHHy7H9XB7EBgEY5hua7fFChJV5a785e
 uyJGOP4l3c7rgTevhRQYDASyL0YZzd+B/bsCdKCYlxCqt3VYVeB3p9tNCrzQz7/KA1rsw4U47FJ
 UD/Ab05XpQdyGDmG+K2ezHMnV8uAWMZBG++szitWAEzZZ+q+Zil1DT3x9Of2w3X3LRWXkCQEZj2
 92tsxqkyU05QOPxzPxtKHlkKU0C9U3HEcHjgyGjZ4DMUp6lpK5FuOxkBQDt/cqt7kbzYvh1MKFo
 ouVto+EjmljB4z9svqnS8wz3E1itT3x7P2TfD3DAf5DBURCnWHALCgWjLG41qFaJJQ3SZtfnCL8
 o+tvgRyPDTIe3
X-Google-Smtp-Source: AGHT+IF5iFIAmvd5x5g0gVj4Ts/bGYTDsScqRgAbWZ9okMeojOdqKjdJg2n01Qc9M0o0MGM7gNRTVw==
X-Received: by 2002:a05:600c:468f:b0:43c:e7ae:4bcf with SMTP id
 5b1f17b1804b1-43d436c753fmr52805815e9.0.1742456363779; 
 Thu, 20 Mar 2025 00:39:23 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c83b6b37sm23258321f8f.37.2025.03.20.00.39.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 00:39:23 -0700 (PDT)
Message-ID: <91758d60-7fdf-4df8-9513-b3c0ca1ecc4c@linaro.org>
Date: Thu, 20 Mar 2025 08:39:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] target/arm: convert 64 bit gdbstub to new helper
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
 <20250319182255.3096731-5-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250319182255.3096731-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 19/3/25 19:22, Alex Bennée wrote:
> For some of the helpers we need a temporary variable to copy from
> although we could add some helpers to return pointers into env in
> those cases if we wanted to.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/gdbstub64.c | 53 ++++++++++++++++++++++++++----------------
>   1 file changed, 33 insertions(+), 20 deletions(-)
> 
> diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
> index 1a4dbec567..793332af31 100644
> --- a/target/arm/gdbstub64.c
> +++ b/target/arm/gdbstub64.c
> @@ -20,7 +20,7 @@
>   #include "qemu/log.h"
>   #include "cpu.h"
>   #include "internals.h"
> -#include "gdbstub/helpers.h"
> +#include "gdbstub/registers.h"
>   #include "gdbstub/commands.h"
>   #include "tcg/mte_helper.h"
>   #if defined(CONFIG_USER_ONLY) && defined(CONFIG_LINUX)
> @@ -35,15 +35,16 @@ int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>   
>       if (n < 31) {
>           /* Core integer register.  */
> -        return gdb_get_reg64(mem_buf, env->xregs[n]);
> +        return gdb_get_register_value(MO_TEUO, mem_buf, (uint8_t *) &env->xregs[n]);

s/MO_TEUO/MO_TEUQ/

But I think we should get MO_TE from CPUState in prologue.

   MemOp mop = MO_TE; /* FIXME get from CPUState */

   ...
   return gdb_get_register_value(mop | MO_64, mem_buf, &env->xregs[n]);

>       }
>       switch (n) {
>       case 31:
> -        return gdb_get_reg64(mem_buf, env->xregs[31]);
> +        return gdb_get_register_value(MO_TEUO, mem_buf, (uint8_t *) &env->xregs[31]);

s/MO_TEUO/MO_TEUQ/

But harder to get it wrong using the MO_$bit equivalent:

   return gdb_get_register_value(mop | MO_64, mem_buf, &env->xregs[31]);

>       case 32:
> -        return gdb_get_reg64(mem_buf, env->pc);
> +        return gdb_get_register_value(MO_TEUO, mem_buf, (uint8_t *) &env->pc);

s/MO_TEUO/MO_TEUQ/

>       case 33:
> -        return gdb_get_reg32(mem_buf, pstate_read(env));
> +        uint32_t pstate = pstate_read(env);
> +        return gdb_get_register_value(MO_TEUL, mem_buf, (uint8_t *) &pstate);
>       }
>       /* Unknown register.  */
>       return 0;
> @@ -82,23 +83,27 @@ int aarch64_gdb_get_fpu_reg(CPUState *cs, GByteArray *buf, int reg)
>   {
>       ARMCPU *cpu = ARM_CPU(cs);
>       CPUARMState *env = &cpu->env;
> +    uint32_t fpr;
>   
>       switch (reg) {
>       case 0 ... 31:
>       {
>           /* 128 bit FP register - quads are in LE order */
>           uint64_t *q = aa64_vfp_qreg(env, reg);
> -        return gdb_get_reg128(buf, q[1], q[0]);
> +        return gdb_get_register_value(MO_TEUO, buf, (uint8_t *) q);
>       }
>       case 32:
>           /* FPSR */
> -        return gdb_get_reg32(buf, vfp_get_fpsr(env));
> +        fpr = vfp_get_fpsr(env);
> +        break;
>       case 33:
>           /* FPCR */
> -        return gdb_get_reg32(buf, vfp_get_fpcr(env));
> +        fpr = vfp_get_fpcr(env);
> +        break;
>       default:
>           return 0;
>       }
> +    return gdb_get_register_value(MO_TEUL, buf, (uint8_t *) &fpr);
>   }
>   
>   int aarch64_gdb_set_fpu_reg(CPUState *cs, uint8_t *buf, int reg)
> @@ -132,30 +137,37 @@ int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg)
>   {
>       ARMCPU *cpu = ARM_CPU(cs);
>       CPUARMState *env = &cpu->env;
> +    uint32_t fpr;
>   
>       switch (reg) {
>       /* The first 32 registers are the zregs */
>       case 0 ... 31:
>       {
>           int vq, len = 0;
> +        ARMVectorReg *zreg = &env->vfp.zregs[reg];
> +
>           for (vq = 0; vq < cpu->sve_max_vq; vq++) {
> -            len += gdb_get_reg128(buf,
> -                                  env->vfp.zregs[reg].d[vq * 2 + 1],
> -                                  env->vfp.zregs[reg].d[vq * 2]);
> +            len += gdb_get_register_value(MO_TEUQ, buf,
> +                                          (uint8_t *) &zreg->d[vq * 2 + 1]);

s/MO_TEUQ/MO_TEUO/ ?

> +            len += gdb_get_register_value(MO_TEUQ, buf,
> +                                          (uint8_t *) &zreg->d[vq * 2]);

s/MO_TEUQ/MO_TEUO/ ?

>           }
>           return len;
>       }
>       case 32:
> -        return gdb_get_reg32(buf, vfp_get_fpsr(env));
> +        fpr = vfp_get_fpsr(env);
> +        return gdb_get_register_value(MO_TEUL, buf, (uint8_t *) &fpr);
>       case 33:
> -        return gdb_get_reg32(buf, vfp_get_fpcr(env));
> +        fpr = vfp_get_fpcr(env);
> +        return gdb_get_register_value(MO_TEUL, buf, (uint8_t *) &fpr);
>       /* then 16 predicates and the ffr */
>       case 34 ... 50:
>       {
>           int preg = reg - 34;
>           int vq, len = 0;
>           for (vq = 0; vq < cpu->sve_max_vq; vq = vq + 4) {
> -            len += gdb_get_reg64(buf, env->vfp.pregs[preg].p[vq / 4]);
> +            len += gdb_get_register_value(MO_TEUQ, buf,
> +                                          (uint8_t *) &env->vfp.pregs[preg].p[vq / 4]);
>           }
>           return len;
>       }
> @@ -165,8 +177,8 @@ int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg)
>            * We report in Vector Granules (VG) which is 64bit in a Z reg
>            * while the ZCR works in Vector Quads (VQ) which is 128bit chunks.
>            */
> -        int vq = sve_vqm1_for_el(env, arm_current_el(env)) + 1;
> -        return gdb_get_reg64(buf, vq * 2);
> +        uint64_t vq = (sve_vqm1_for_el(env, arm_current_el(env)) + 1) * 2;
> +        return gdb_get_register_value(MO_TEUL, buf, (uint8_t *) &vq);

s/MO_TEUL/MO_TEUQ/

>       }
>       default:
>           /* gdbstub asked for something out our range */
> @@ -248,10 +260,11 @@ int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg)
>               bool is_data = !(reg & 1);
>               bool is_high = reg & 2;
>               ARMMMUIdx mmu_idx = arm_stage1_mmu_idx(env);
> -            ARMVAParameters param;
> +            ARMVAParameters param = aa64_va_parameters(env, -is_high, mmu_idx,
> +                                                       is_data, false);
> +            uint64_t pauth_mask = pauth_ptr_mask(param);
>   
> -            param = aa64_va_parameters(env, -is_high, mmu_idx, is_data, false);
> -            return gdb_get_reg64(buf, pauth_ptr_mask(param));
> +            return gdb_get_register_value(MO_TEUQ, buf, (uint8_t *) &pauth_mask);
>           }
>       default:
>           return 0;
> @@ -399,7 +412,7 @@ int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int reg)
>   
>       tcf0 = extract64(env->cp15.sctlr_el[1], 38, 2);
>   
> -    return gdb_get_reg64(buf, tcf0);
> +    return gdb_get_register_value(MO_TEUQ, buf, (uint8_t *) &tcf0);
>   }
>   
>   int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg)


