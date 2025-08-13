Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA149CA0EC4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 07:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1um5mn-0000Mh-Ld; Wed, 13 Aug 2025 03:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1um5mg-0000LR-Nz
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 03:20:31 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1um5mU-0005IM-Ol
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 03:20:27 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b792b0b829so6171976f8f.3
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 00:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755069610; x=1755674410; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WQTtxtQdlX1t1TsEgSAiwwjV/2WtLrcIDCPiTf8TT00=;
 b=CfncDKN/x8F1qHQm9Q8AZOiviQJ2VdsPip7uTsI2WWLARZ7r0M9X8ho0sqB1L0KFNb
 x1PaaBz71RbwXM+scoaokFEFVSAOCieZShWLW4AMZCKwG/7RvNpX3zZ3yg716K5wFj44
 TPmcv+lAFMGhH8Foxi4fs6/vKweQSxO2C6epCfrX0F69b6zol+H4Pfu+Sb0bKEQ9tiC+
 /Fx1LTxMvPi/p76boSn6X+cbEV47eA7I53cH4ydYNAYPuDNxVQdXJk7rVFvmmrWaQ5sT
 5++Q7bu/91MCtqjuhtNbD/4i+nsCdE7qs8tQ9f5WzaWg8UbQVgygXjgddvaPkDJwuIJ9
 +cHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755069610; x=1755674410;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WQTtxtQdlX1t1TsEgSAiwwjV/2WtLrcIDCPiTf8TT00=;
 b=uXaEsgqB2NIPdyvcIFUR/dVypaCGiOLIQ3Zzupq1B0ZFYcCazBz+axoqGeIAcnnO0T
 iZ8Y3kGAUZIhIrCPdzytL97VaIY5KMxKYHijp8fvz7H3WGoA9IULvVSyLdPIBpB9pXuh
 bLYKUGbSR1U4Z3A2FpRo2xb7HIiHqGYPIkRFAkiIk1H1cj4BpYvkUrVEdAtiW9auJBob
 ImKW2ZSE06DXStcsAPayzXdc9xlosf3qKbHfJ6+GnuHxbckpxsM4eKl9l0IQ2a7oE5fA
 FY/t4CuqRnmMlHAkKWEEI8nsd4chyI5x+cJmQEwFTiBfs6xQxkQrw0PkU3WsF6eyPSPV
 7B9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu33tkqDH5XoQlNHHse9OVX4b7oDWPJPAeMiW/8J7vu1RY5STxSLxc8MC/mjrKPbYeXVsPzwbeKRzU@nongnu.org
X-Gm-Message-State: AOJu0YwORrQxai0pIZvOzm6uhaOiOIzvlgY/7VZ4mVqyDnHvy7oOQTxw
 dutEQWfY+om2xzQxOLsUkfeDiNw0MeQfGhH0HdGYGWCaPtJH0TYpxglQGOVTYnsHI84=
X-Gm-Gg: ASbGncuq7ILPP+YG9Nc6XOBl0pEr1DuM6LWrcpef2S7Zzz7yz2OHdMsA3dPGAZ6N1Io
 eb04VbbNLKILTkWW1IZoLBuEs4RBZkFtCNo98sB29EC5vvvE2e973NhYA30O3gfPn1vkTsHjzVH
 dTku5n0DR4bDUAfFLvSWtobnrkaQifKZ2weBKaP7x+XELNeWNVdX0CA/61c97+uoiu32oQ7eviu
 p4CCN1XpPdSA9H7/Ptn5FZcIRhgCEMVBcZUGt70hcD0JQ6+Eyu4DdztfAiB5hIHYDLEZIuADYSp
 XphqbLg60TaGeiy2OZbc39b6iE7fRsVk7vYskSSaL0AgZHisMgnjoIX48+pXS0hEpK4kyuz57Dm
 D1kEcwSRYCKJ4GK+bc1ZWndvCCPGjxytbf40M/RZPAU054K1wFd3aVV0KoFxVGqPScQ==
X-Google-Smtp-Source: AGHT+IEnFvesOVp/yx5bxq+58jLQX7eMBUkTUcXy6Mb+9tN9E9pkeyh7rVw3I+FuPgioRBGLkYy/PQ==
X-Received: by 2002:a5d:5f82:0:b0:3b8:f8e5:f6be with SMTP id
 ffacd0b85a97d-3b917e76db5mr1179495f8f.4.1755069609648; 
 Wed, 13 Aug 2025 00:20:09 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4534b3sm46619890f8f.47.2025.08.13.00.20.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Aug 2025 00:20:09 -0700 (PDT)
Message-ID: <08f2c3ff-a509-4a96-a515-b3ceae2ea9ea@linaro.org>
Date: Wed, 13 Aug 2025 09:20:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/11] target/arm/hvf: Sync registers used at EL2
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250811170611.37482-1-philmd@linaro.org>
 <20250811170611.37482-10-philmd@linaro.org>
 <ce436008-3a53-4e31-a563-188cb3b1654d@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ce436008-3a53-4e31-a563-188cb3b1654d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 12/8/25 02:20, Richard Henderson wrote:
> On 8/12/25 03:06, Philippe Mathieu-Daudé wrote:
>> From: Mohamed Mediouni <mohamed@unpredictable.fr>
>>
>> When starting up the VM at EL2, more sysregs are available. Sync the 
>> state of those.
>>
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> [PMD: Adapted to host_cpu_feature_supported() API]
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/arm/hvf/hvf.c | 34 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index 5174973991f..778dc3cedf7 100644
>> --- a/target/arm/hvf/hvf.c
>> +++ b/target/arm/hvf/hvf.c
>> @@ -400,6 +400,7 @@ static const struct hvf_reg_match 
>> hvf_fpreg_match[] = {
>>   struct hvf_sreg_match {
>>       int reg;
>>       uint32_t key;
>> +    bool el2;
>>       uint32_t cp_idx;
>>   };
>> @@ -545,6 +546,27 @@ static struct hvf_sreg_match hvf_sreg_match[] = {
>>       { HV_SYS_REG_CNTV_CTL_EL0, HVF_SYSREG(14, 3, 3, 3, 1) },
>>       { HV_SYS_REG_CNTV_CVAL_EL0, HVF_SYSREG(14, 3, 3, 3, 2) },
>>       { HV_SYS_REG_SP_EL1, HVF_SYSREG(4, 1, 3, 4, 0) },

[*]

>> +    /* EL2 */
>> +    { HV_SYS_REG_CPTR_EL2, HVF_SYSREG(1, 1, 3, 4, 2), .el2 = true },
>> +    { HV_SYS_REG_ELR_EL2, HVF_SYSREG(4, 0, 3, 4, 1), .el2 = true },
>> +    { HV_SYS_REG_ESR_EL2, HVF_SYSREG(5, 2, 3, 4, 0), .el2 = true },
>> +    { HV_SYS_REG_FAR_EL2, HVF_SYSREG(6, 0, 3, 4, 0), .el2 = true },
>> +    { HV_SYS_REG_HCR_EL2, HVF_SYSREG(1, 1, 3, 4, 0), .el2 = true },
>> +    { HV_SYS_REG_HPFAR_EL2, HVF_SYSREG(6, 0, 3, 4, 4), .el2 = true },
>> +    { HV_SYS_REG_MAIR_EL2, HVF_SYSREG(10, 2, 3, 4, 0), .el2 = true },
>> +    { HV_SYS_REG_MDCR_EL2, HVF_SYSREG(1, 1, 3, 4, 1), .el2 = true },
>> +    { HV_SYS_REG_SCTLR_EL2, HVF_SYSREG(1, 0, 3, 4, 0), .el2 = true },
>> +    { HV_SYS_REG_SPSR_EL2, HVF_SYSREG(4, 0, 3, 4, 0), .el2 = true },
>> +    { HV_SYS_REG_SP_EL2, HVF_SYSREG(4, 1, 3, 6, 0), .el2 = true},
>> +    { HV_SYS_REG_TCR_EL2, HVF_SYSREG(2, 0, 3, 4, 2), .el2 = true },
>> +    { HV_SYS_REG_TPIDR_EL2, HVF_SYSREG(13, 0, 3, 4, 2), .el2 = true },
>> +    { HV_SYS_REG_TTBR0_EL2, HVF_SYSREG(2, 0, 3, 4, 0), .el2 = true },
>> +    { HV_SYS_REG_TTBR1_EL2, HVF_SYSREG(2, 0, 3, 4, 1), .el2 = true },
>> +    { HV_SYS_REG_VBAR_EL2, HVF_SYSREG(12, 0, 3, 4, 0), .el2 = true },
>> +    { HV_SYS_REG_VMPIDR_EL2, HVF_SYSREG(0, 0, 3, 4, 5), .el2 = true },
>> +    { HV_SYS_REG_VPIDR_EL2, HVF_SYSREG(0, 0, 3, 4, 0), .el2 = true },
>> +    { HV_SYS_REG_VTCR_EL2, HVF_SYSREG(2, 1, 3, 4, 2), .el2 = true },
>> +    { HV_SYS_REG_VTTBR_EL2, HVF_SYSREG(2, 1, 3, 4, 0), .el2 = true },
> 
> Note that el2 == opc1 in {4,5}.

Does this also work with HV_SYS_REG_SP_EL1 (see [*])?
I suppose so, after reading commit 67d10fc4737 ("target/arm: Trap
sysreg accesses for FEAT_NV") addition:

/**
  * arm_cpreg_trap_in_nv: Return true if cpreg traps in nested
  * virtualization
  *
  * Return true if this cpreg is one which should be trapped to EL2
  * if it is executed at EL1 when nested virtualization is enabled
  * via HCR_EL2.NV.
  */
static inline bool arm_cpreg_traps_in_nv(const ARMCPRegInfo *ri)
{
     /*
      * The Arm ARM defines the registers to be trapped in terms of
      * their names (I_TZTZL). However the underlying principle is "if
      * it would UNDEF at EL1 but work at EL2 then it should trap", and
      * the way the encoding of sysregs and system instructions is done
      * means that the right set of registers is exactly those where
      * the opc1 field is 4 or 5. (You can see this also in the assert
      * we do that the opc1 field and the permissions mask line up in
      * define_one_arm_cp_reg_with_opaque().)
      * Checking the opc1 field is easier for us and avoids the problem
      * that we do not consistently use the right architectural names
      * for all sysregs, since we treat the name field as largely for
      * debug.
      *
      * However we do this check, it is going to be at least potentially
      * fragile to future new sysregs, but this seems the least likely
      * to break.
      *
      * In particular, note that the released sysreg XML defines that
      * the FEAT_MEC sysregs and instructions do not follow this FEAT_NV
      * trapping rule, so we will need to add an ARM_CP_* flag to
      * indicate "register does not trap on NV" to handle those if/when
      * we implement FEAT_MEC.
      */
     return ri->opc1 == 4 || ri->opc1 == 5;
}

 From v2:

 >> @@ -608,6 +630,11 @@ int hvf_get_registers(CPUState *cpu)
 >>               continue;
 >>           }
 >> +        if (hvf_sreg_match[i].el2
 >> +            && !host_cpu_feature_supported(ARM_FEATURE_EL2)) {
 >> +            continue;
 >> +        }
 >
 > I thought you were going to change this to arm_feature(&cpu->env,
 > ARM_FEATURE_EL2).

We want to use HVF to get these registers on M3 / M4, but not on
M1 / M2 when split-accel in use where we emulate them.

Expected logic:

     if (
         // this is an EL2 register ...
         hvf_reg_traps_in_nv(i)
         // ... and CPU doesn't provide EL2 ...
         && (!arm_feature(&cpu->env, ARM_FEATURE_EL2)
             // ... or we are emulating EL2 (split-accel) ...
             || tcg_enabled())
     ) {
         // ... then do not get the register with the HVF API ...
         continue;
     }
     // ... otherwise by default use HVF.
     hv_vcpu_get_sys_reg(cpu->accel->fd, hvf_sreg_match[i].reg, &val);


