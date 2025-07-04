Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B001DC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 21:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXnb6-0001w8-RV; Fri, 04 Jul 2025 17:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXnb5-0001vs-OP
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 17:05:27 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXnb4-00086e-5t
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 17:05:27 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2ea58f008e9so1487178fac.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 14:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751663124; x=1752267924; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HnmF+GWdMytPfWe99miS4RSdRwwQ9DvX3uQuYYnubNg=;
 b=PLL60bXq5D82MNJEEdE3yFQ/qobeY7sOfhV04sTfkCz7eP0twvdB9vg4W58ycV9/+0
 1TLblxSTU8S+71fFhL5O/SSBOGFCN6vO7mmbuXFCXYpQ5kL8p0oC+bMk9pVeqrbrHwYl
 xkWwOnp2FH6wvQxow75sQrHYVzHgW4XVTeHTFAPnDQM8ztZt5NuSIKY4vTm62jqqpugl
 7eiQ6twERgVQNHiWlyjeqfWefsfnHPIRF3pwWIERCfrQ31PS7IF56uFVwYH1WABwr2V+
 /KLnQF07H/f/li4Z1UjJhIaUvbKPF0LSsCULhTizLkJwAXM9rCU75u1rY6oJ3C7T7mxF
 cxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751663124; x=1752267924;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HnmF+GWdMytPfWe99miS4RSdRwwQ9DvX3uQuYYnubNg=;
 b=Q57vVckTMIX3MjMG/TZqE5+m1q8hyes9YWRdbk4W7R8RSZawuJ5m75F2iQLSGRY/sn
 zKJnF/KJ/A/Xhwkry+/BqJKKChB4QAGx0Jtlc/Tc8M26gGVt6zS3gHuz5AurskOCLXmu
 sViOIJCt/TZ38WfnjOSDUnNxUVIjW6xOXG65s7RTDKBYokv9auAnq6EXRNuDWqMJuin/
 mXeq0qULsWl4P4C2RTte9hfEaiC/Bpi9gUIW/Kv/I8IgcRObUwnYdtoyAeua4umR5WW5
 H8XmMkG8K2oqykb20JAMmPGldnrOyLKwVLgD3FhvIc32cPcTua2GjPVcqx6B8IYaBAYp
 OTCg==
X-Gm-Message-State: AOJu0YzHdD3Sqk1bACx+kKeiSFSvY65vMWdzm05Xk+iGzub4ebfClY6G
 xa5/8gCUl4qpo4hljJknignWc8C0MwU0Yl6qwWB1oRaeUZG+5X1n65sqWNM44JPMoOo=
X-Gm-Gg: ASbGncswSOMjyWSNxxXJmPBXpZ1ITWg4CsJKmj/ib9XvRnf+FCk0NdtoOb4eftxlo3a
 V4xEL6Zw82gJHxVS/aPJ7XBYUQUfs7hJGsHZN5OgcBs380tA1bchZX5rO2R0yFBlAV1+RT9/Dlp
 ZcmR09fhqO9zSDJ41adIbn+PRCEOZpBxGy+3vOM2X0o111d9cQLKdDIjGrQJipE5eDE+IXGMEmG
 90/XUC5v2LTw8k/WHNJECH8yAEftw+LQ2eRyhFxYf/fwaxEDTdpwbpZ4EuR9QLMwhi5Fe/ptVFd
 Xla6KYG8YPvQYY/LRL65XwPIOauPP7VOAg0EBVSjPiTvXMnSgaCQfYiARb3yu0OTGySnM+Y0Fj9
 Kv31GTgDbuAtgTvqyrSUFxv7HN3O7kuvKDx9G2Z+T
X-Google-Smtp-Source: AGHT+IEzkwZCCR6fG/k4l6BZPscawmW/So7U0vch0ENSLTMH8G/T/YOWK/bNoY0+6nNYtxiCbKzAqg==
X-Received: by 2002:a05:6870:c195:b0:2d5:714b:f661 with SMTP id
 586e51a60fabf-2f796a57083mr2732657fac.12.1751663124384; 
 Fri, 04 Jul 2025 14:05:24 -0700 (PDT)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f790276f63sm705485fac.44.2025.07.04.14.05.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 14:05:24 -0700 (PDT)
Message-ID: <f18ad948-3d14-446f-8d37-041b4f9ffa8c@linaro.org>
Date: Fri, 4 Jul 2025 15:05:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [WIP-for-10.1 v2 2/5] target/arm: Add FEAT_MEC registers
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org
References: <20250704151431.1033520-1-gustavo.romero@linaro.org>
 <20250704151431.1033520-3-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250704151431.1033520-3-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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

On 7/4/25 09:14, Gustavo Romero wrote:
> +        /* MEC registers */
> +        uint64_t mecidr_el2;

Don't need this one.

> +        uint64_t mecid_p0_el2;
> +        uint64_t mecid_a0_el2;
> +        uint64_t mecid_p1_el2;
> +        uint64_t mecid_a1_el2;
> +        uint64_t mecid_rl_a_el3;
> +        uint64_t vmecid_p_el2;
> +        uint64_t vmecid_a_el2;
>       } cp15;
>   
>       struct {
> @@ -2389,6 +2399,10 @@ FIELD(MFAR, FPA, 12, 40)
>   FIELD(MFAR, NSE, 62, 1)
>   FIELD(MFAR, NS, 63, 1)
>   
> +FIELD(MECIDR, MECIDW, 0, 4)
> +FIELD(MECID, MECID, 0, 16)
> +FIELD(VMECID, MECID, 0, 16)

You don't really need these.

> +
>   QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
>   
>   /* If adding a feature bit which corresponds to a Linux ELF
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 889d308807..9f8a284261 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6823,6 +6823,100 @@ static const ARMCPRegInfo nmi_reginfo[] = {
>         .resetfn = arm_cp_reset_ignore },
>   };
>   
> +static void mecidr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    /* MECIDWidthm1 = 15, i.e. 16 bits is the width of a MECID. */
> +    env->cp15.mecidr_el2 = FIELD_DP64(0, MECIDR, MECIDW, 15);
> +}
> +
> +static uint64_t mecidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    uint64_t valid_mask;
> +
> +    if (!arm_is_el2_enabled(env)) {
> +        /* All bits are RES0. */
> +        return 0ULL;
> +    }
> +
> +    valid_mask = R_MECIDR_MECIDW_MASK;
> +    return env->cp15.mecidr_el2 & valid_mask;
> +}

How do you get the arm_is_el2_enabled check?

MECIDR_EL2 is a read-only register with one field: MECIDWidthm1, containing a constant 
value.  I would expect to see

     { .name = "MECIDR_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .opc2 = 7, .crn = 10, .crm = 8,
       .access = PL2_R, .type = ARM_CP_CONST, .reset = MECID_WIDTH - 1 },



> +
> +static CPAccessResult mecid_access(CPUARMState *env,
> +                                   const ARMCPRegInfo *ri, bool isread)
> +{
> +    int el;
> +
> +    el = arm_current_el(env);
> +    if (el == 2 && !(env->cp15.scr_el3 & SCR_MECEN)) {
> +        return CP_ACCESS_TRAP_EL3;
> +    }
> +
> +    return CP_ACCESS_OK;
> +}

It's better practice to initialize local variables when at all possible, especially now 
that we build with -ftrivial-auto-var-init:

     int el = arm_current_el(env);

Missing security state check:

     if (el == 2) {
         if (arm_security_space(env) != ARMSS_Realm) {
             return CP_ACCESS_UNDEFINED;
         }
         if (!(env->cp15.scr_el3 & SCR_MECEN)) {
             return CP_ACCESS_TRAP_EL3;
         }
     }
     return CP_ACCESS_OK;


> +
> +static void mecid_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                        uint64_t value)
> +{
> +    uint64_t valid_mask;
> +
> +    valid_mask = R_MECID_MECID_MASK;
> +    value &= valid_mask;
> +    raw_write(env, ri, value);
> +}

The valid mask does not come from R_MECID_MECID_MASK,
but from the contents of that field.  This should be

     value = extract64(value, 0, MECID_WIDTH);


> +
> +static uint64_t mecid_read(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    uint64_t valid_mask;
> +
> +    valid_mask = R_MECID_MECID_MASK;
> +    return raw_read(env, ri) & valid_mask;
> +}

If you've properly masked writes, you don't need to mask reads too.


> +    { .name = "MECID_RL_A_EL3", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 6, .opc2 = 1, .crn = 10, .crm = 10,
> +      .access = PL2_RW, .accessfn = mecid_access,

.access = PL3_RW, no accessfn.


r~

