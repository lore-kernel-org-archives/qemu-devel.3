Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDF810AB83B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 01:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5w0Y-00015K-HV; Thu, 26 Mar 2026 21:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5w0V-00014Z-RB
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 21:29:03 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5w0T-0001TD-2J
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 21:29:03 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-82a893d289bso716764b3a.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 18:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774574939; x=1775179739; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BMNlIgsvROGWOoM6qVpmLoL2na6ymGKPAu9yLCoBnFs=;
 b=I5AX71OJ34V67YSVCvpv3Ib9QD2fxFDQYjh7K4qmhF9+C3hmcWC5mhHZtBT72mlU/u
 BV5usKSev+GJysQN1vkZyp9Xu6NqSmqFkGo/N72iYB3fvwNjRtG70nc5jLGcC+en/5gV
 hpTjKm3VlrRVLZgdn0niX6dJa/j8ZNi+SDV1Zr3aWnOJFjFB4+hCGEVuMiBAL7aSem9g
 XcussLAPJJIHLQBmXUDQnr9pcHkNYSHLeM4uDDZ3G6kzhGAwjYJz7Ypof/4iyx8MryiG
 S2RN3dVeI9F7U3m/OYeLHEmgJzjvb2Fp+m8bdZiy2zhxiSDXp9DZ2KTNWeqrCpxy14lv
 UL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774574939; x=1775179739;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BMNlIgsvROGWOoM6qVpmLoL2na6ymGKPAu9yLCoBnFs=;
 b=lMwCUk9JyY5XydbOnNh7sgnhh9uCxsdt1yhDyagODvIQZ4Es65CwzTEu59qi5V3oOk
 KwHn3m6dLaKIHJ64FE94xrWQh8bP5Qw1rEmE0SnrrlEHFShKi6YxBddluqjsoileyOQ9
 DDDwCW18Fndpf4aiRi648oWnu8JJEQllCroKqq9Ls+ZQE/0SDHW/XIW5wMZO5kQaD+sS
 VLMSbJq9d6YFR4o6jsNycC92A4xEsAqtSx7fDMwZ7px23Mytp10BFUlVSzPteiQZ4XLg
 EkXAUsZ+JWSP5+8KDKaXj1CUqgFMnnYplFhRIVz+VPv7zljFXF26EMViljJbwpJ6l0Dj
 Lv0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX84otrEnx/kqXmBbWk42/2QxIVC1yUuxSMI9dZGL+P1gCcGo2w8rQollzQxB4NZ2gMZyFQmD/4Q8im@nongnu.org
X-Gm-Message-State: AOJu0Yx/9ubMKQabP8rhDHlgtZA+sveFZuQ5/BxAOTNzI/K57dqXP0Ux
 dMNUQKRlJndOuQb63LJ2obBPOyGrHakxETCRerxDZ4jkk8ZQrUb28ThWAt5hv4p9LKk=
X-Gm-Gg: ATEYQzxtqx7PcmUL0ysQk2UvJLYBGCXy3TjtRkhu1zma/r2cdxkuX2zUDWZBSNhu9H7
 QdvbBVCTrUTmohy30my5RB0GWc6DPV8Az3qmFEmL3X2KI9VEpIEHpB4o4ADYZ+EBen1XfSQNega
 1D4zDfhoIOZLT6VBhAw8hbW4JP8Y+O0c1tfXp4uyc0I4GNP+SamdZw2jL5zXZ5TLVAk9jgvINre
 h5vaUcFae0xZbIGmOSsR+v6HjflsAmE7YNhCeSbDnFQFCSFspTlm8F/Duc4vCH7y+Fi2EcFJYho
 PjBhr1APCC7OfZB4xbok7e0QUaUjjpgmPETrqfLAUlvG7udAw9QvgZ9R7HtbAO69O3IZn5cdsum
 +T/ewso7PCqbsvyGakw958WonEkJmGDH9CIPV6egSBe5E6kHQOcyfZT73qc78hI1AVm2TB7ZJgb
 q9VhGmPbSVM4b7r/NTEW3QhKWHoW5+Df7pdxX25Mg9fQ==
X-Received: by 2002:a05:6a00:2d98:b0:7f1:7b2a:ab5b with SMTP id
 d2e1a72fcca58-82c95e7b2aamr518087b3a.27.1774574938763; 
 Thu, 26 Mar 2026 18:28:58 -0700 (PDT)
Received: from [172.16.11.156] ([103.100.225.140])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c7f5461c5sm3433479b3a.8.2026.03.26.18.28.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 18:28:58 -0700 (PDT)
Message-ID: <91a286a9-be2c-4f38-b04f-96ee55cf6dfc@linaro.org>
Date: Fri, 27 Mar 2026 11:28:51 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/7] target/arm/ptw: Add MECID checks
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org
References: <20260319022335.22523-1-gustavo.romero@linaro.org>
 <20260319022335.22523-7-gustavo.romero@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260319022335.22523-7-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 3/19/26 12:23, Gustavo Romero wrote:
> Add MECID checks. The MECID registers were introduced before and this
> commit uses them to perform the proper MECID checks, which is part of
> FEAT_MEC implementation.
> 
> On MECID mismatches (wrong MECID) we return a substitute encrypted page
> instead of the real encrypted page, which doesn't hurt performance on
> memory accesses and behaves like FEAT_MEC design on the physical
> hardware.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   target/arm/internals.h |   2 +
>   target/arm/ptw.c       | 215 ++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 216 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 8ec2750847..d668948949 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1473,6 +1473,8 @@ typedef struct GetPhysAddrResult {
>        * with the stage1 protection.
>        */
>       int s2prot;
> +    /* FEAT_MEC AMEC found in Block or Page descriptor. */
> +    bool amec;
>   } GetPhysAddrResult;
>   
>   /**
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 8b8dc09e72..aacc32ba33 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -2090,6 +2090,17 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
>           goto do_fault;
>       }
>   
> +    /*
> +     * XXX(gromero): Add checks for NS bit and AMEC0/1 bits, generating the due
> +     * fault in case AMEC0/1 = 0 and AMEC bit is 1. So far we just get the AMEC
> +     * bit directly in case of a Block or Page descriptor.
> +     *
> +     */
> +    if (((level == 1 || level == 2) && (extract64(descriptor, 0, 2) == 1)) ||
> +        level == 3) {

This test is exactly ...

> +        result->amec = extract64(descriptor, 63, 1);
> +    }
> +
>       if ((descriptor & 2) && (level < 3)) {

... the inverse of this one.  Notice the comment that directly follows:

     /*
      * Block entry at level 1 or 2, or page entry at level 3.
      * These are basically the same thing, although the number

So move the assignment of amec later, with no additional test.

>           /*
>            * Table entry. The top five bits are attributes which may
> @@ -3766,6 +3777,208 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
>       }
>   }
>   
> +static uint32_t *get_mecid_ptr(CPUARMState *env, hwaddr pa)
> +{
> +    MemoryRegion *mr;
> +    AddressSpace *mec_as;
> +    hwaddr mec_paddr, xlat;
> +    MemTxAttrs memattrs = { 0x0 };
> +
> +    /* Find out the page number to use it as an offset in mec AS. */
> +    mec_paddr = pa >> TARGET_PAGE_BITS;
> +    mec_paddr *= 4; /* Assume MECID maximum size is 4 bytes. */
> +    /* MECIDs are kept in their own Address Space. */
> +    mec_as = cpu_get_address_space(env_cpu(env), ARMASIdx_MEC);
> +    mr = address_space_translate(mec_as, mec_paddr, &xlat, NULL, true, memattrs);
> +
> +    /*
> +     * Return pointer in the mec AS associated to physical address 'pa', which
> +     * is used to store the MECID.
> +     */
> +    return memory_region_get_ram_ptr(mr) + xlat;
> +}

In allocation_tag_mem_probe, where we're performing a similar function, I test 
memory_region_is_ram and log an error.  In addition, we have to manually mark these ram 
pages dirty for migration.

Alternately...

> +
> +static uint32_t get_mecid(CPUARMState *env, hwaddr pa)
> +{
> +    return *get_mecid_ptr(env, pa);
> +}
> +
> +static void set_mecid(CPUARMState *env, hwaddr pa, uint32_t mecid)
> +{
> +    *get_mecid_ptr(env, pa) = mecid;
> +}

... drop the direct use of pointers and use address_space_{ldl,stl} instead.

For MTE, there was the additional complication of user-only, which doesn't have these 
separate address spaces, as well as dealing with larger blocks of tag memory.

For MEC, you're only ever touching one entry at a time.

> +
> +/*
> + * Returns 'false' on MECID mismatch and 'true' on MECID match (success).
> + */
> +static bool mecid_check(CPUARMState *env, S1Translate *ptw, hwaddr va,
> +                        MMUAccessType access_type, GetPhysAddrResult *result,
> +                        ARMMMUIdx s1_mmu_idx)
> +{
> +    ARMSecuritySpace ss = ptw->out_space;
> +    /* Final physical address after translation. */
> +    hwaddr pa = result->f.phys_addr;
> +
> +    switch (s1_mmu_idx) {
> +    case ARMMMUIdx_Phys_S:
> +    case ARMMMUIdx_Phys_NS:
> +    case ARMMMUIdx_Phys_Root:
> +    case ARMMMUIdx_Phys_Realm:
> +    case ARMMMUIdx_Stage2:
> +    case ARMMMUIdx_Stage2_S:
> +    /* In the middle of a translation, so result->f.phys_addr has no PA yet. */
> +        return true;
> +        break;
> +    default:
> +        /* Pass */
> +        break;
> +    }

Why do you need to test s1_mmu_idx?
Surely the ptw->in_mmu_idx test below is better?

> +
> +    /* Find out which EL controls EMEC for Stage 1 translations. */
> +    uint32_t el = regime_el(s1_mmu_idx) < 3 ? 2 : 3;
> +
> +    /* XXX(gromero): Do we need to check for SCR_EL3.SCTLR2En when el == 2? */
> +    if (!(cpu_isar_feature(aa64_mec, env_archcpu(env)) &&
> +        (env->cp15.sctlr2_el[el] & SCTLR2_EMEC))) {
> +        /* FEAT_MEC is disabled. */
> +        return true;
> +    }
> +
> +    if (ss != ARMSS_Realm) {
> +        /*
> +         * GPT checks are already done, so if SS is Root here MECIDs are
> +         * irrelevants for EL3 accesses. If SS is Secure or NonSecure that's not
> +         * pertinent to FEAT_MEC. Hence, only proceed with MECID checks if SS is
> +         * Realm.
> +         */
> +        return true;
> +    }

Sort these tests in order of likelyhood and simplicity.

For instance, ss == Realm is least likely and is a trivial test.

In addition, ss == Realm implies ARM_FEATURE_AARCH64, which you have forgotten to test 
before testing isar feature aa64_mec.

> +
> +    bool amec = result->amec;
> +    bool varange_lower = extract64(va, 55, 1) ? false : true;

Use "!" not "?:".

But extracting varange_upper instead would simplify merging E2 with E2&0 regimes, like so:

     varange_upper = regime_has_2_ranges(idx) && extract64(va, 55, 1)

> +    /* MECID in register set given a translation regime. */
> +    uint32_t mecid;
> +
> +    /* ARMMMUIdx after full ptw (all stages). */
> +    ARMMMUIdx ptw_mmu_idx = ptw->in_mmu_idx;
> +
> +    switch (ptw_mmu_idx) {
> +    case ARMMMUIdx_Stage2:
> +    case ARMMMUIdx_Stage2_S:
> +    /* In the middle of a two stage translation, so result->f.phys_addr has no PA yet. */
> +        return true;
> +        break;
> +    default:
> +        /* Pass */
> +        break;
> +    }
> +
> +    /*
> +     * NB: No MECID is used for the ptw itself, i.e., used for the level
> +     * lookups, so AArch64.S1TTWalkMECID() and AArch64.S2TTWalkMECID() are not
> +     * relevant for our FEAT_MEC implementation.
> +     */
> +    bool is_pa_from_s2 = regime_is_stage2(ptw_mmu_idx);

You just rejected the stage2 mmu indexes.

> +    bool is_mmu_disabled = regime_translation_disabled(env, ptw_mmu_idx, ss);
> +    if (is_pa_from_s2) { /* PA from Stage 2. */
> +        /* As per AArch64.S2OutputMECID(). */
> +        mecid = amec ? env->cp15.vmecid_a_el2 : env->cp15.vmecid_p_el2;

So this isn't reachable.
This suggests the switch above is wrong?

> +
> +    } else { /* PA from Stage 1. */
> +        if (is_mmu_disabled) { /* PA from Stage 1 and MMU is disabled. */
> +            /* As per AArch64.S1DisabledOutputMECID(). */
> +            switch (s1_mmu_idx) {
> +            case ARMMMUIdx_E3:
> +                /* MECID = 0 (default), so return without any check. */
> +                return true;
> +                break;

Unreachable break.

> +            case ARMMMUIdx_E2:
> +            case ARMMMUIdx_E20_0:
> +            case ARMMMUIdx_E20_2:
> +            case ARMMMUIdx_E20_2_PAN:
> +                mecid = env->cp15.mecid_p0_el2;
> +                break;
> +            case ARMMMUIdx_E10_0:
> +            case ARMMMUIdx_E10_1:
> +                mecid = env->cp15.vmecid_p_el2;
> +                break;

There are lots of these you've missed.
Better to test regime_el instead.

> +            default:
> +                g_assert_not_reached();
> +            }
> +
> +        } else { /* PA from Stage 1 and MMU is enabled. */
> +            /* As per AArch64.S1OutputMECID(). */
> +            switch (s1_mmu_idx) {
> +            case ARMMMUIdx_E3:
> +                mecid = env->cp15.mecid_rl_a_el3;
> +                break;
> +            case ARMMMUIdx_E2:
> +                mecid = amec ? env->cp15.mecid_a0_el2 : env->cp15.mecid_p0_el2;
> +                break;
> +            case ARMMMUIdx_E20_0:
> +            case ARMMMUIdx_E20_2:
> +            case ARMMMUIdx_E20_2_PAN:
> +                if (varange_lower) {
> +                    mecid = amec ? env->cp15.mecid_a0_el2 : env->cp15.mecid_p0_el2;
> +                } else {
> +                    mecid = amec ? env->cp15.mecid_a1_el2 : env->cp15.mecid_p1_el2;
> +                }
> +                break;

E2 and E20_* can be merged with varange_upper, per above.

> +static bool get_phys_addr_mec(CPUARMState *env, S1Translate *ptw,
> +                              vaddr address,
> +                              MMUAccessType access_type, MemOp memop,
> +                              GetPhysAddrResult *result,
> +                              ARMMMUFaultInfo *fi)
> +
> +{
> +    /*
> +     * After 'address' is resolved by get_phys_addr_nogpc(), ptw->in_mmu_idx can
> +     * change depending on the translation stages, hence stash it.
> +     */
> +    ARMMMUIdx s1_mmu_idx = ptw->in_mmu_idx;
> +
> +    if (get_phys_addr_gpc(env, ptw, address, access_type, memop, result, fi)) {
> +        return true; /* Translation fault. */
> +    }
> +    if (!mecid_check(env, ptw, address, access_type, result, s1_mmu_idx)) {
> +        return true; /* MECID mismatch. */
> +    }

MECID mismatch does *not* raise an exception, therefore returning true is incorrect.

Thus the return value from mecid_check is really unused.


r~

