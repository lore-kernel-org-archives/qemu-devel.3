Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4380CC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 22:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfPy3-0001ve-Jy; Thu, 02 Jul 2026 18:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfPy1-0001v3-RZ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 18:33:09 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfPy0-0006n3-7W
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 18:33:09 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2cace7da66eso3460455ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 15:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783031586; x=1783636386; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wjtzt6622TmlKL2+S/5LJwuIq5VNHw3Gnueyp4reLWk=;
 b=ttlWIkG40vrurl+wBhX+qsyZIz8JwnTykl97azSHgHjekT4VXNtb7hhL6/pR+O/n2s
 WQoIWPTrN8xfN93FdQbHGG4ICd7JwyF45UyHFXiGHve8msqwqR0SP2AA2MMs4uELnqHh
 iLg5qBrX5zLl/lwVM2rz0aSt4ZmtflXWFx7/GCKdVi0Gibi0yNAozhCcNbrtHu9JsK7n
 wC1FZfjDtEAUwBUfiaE+K8x5um8y7/m0TycYpW6S6t9vVISI/vs7fHj7wpWxf1LIqqYy
 cuRjsc97UPqQj0DrDJNHLZJ89irr1km9WIi7z4uGxx41BhlWrMTXiltfBBOOZokC/F57
 KR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783031586; x=1783636386;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wjtzt6622TmlKL2+S/5LJwuIq5VNHw3Gnueyp4reLWk=;
 b=mozeyYzbeoAe6fvC/SUo07sQQGTlTXiVTvXkXX0bbv1r74JR8GwZVLBMfKapn+H4au
 rC/RCRVh/SewJocOaTQtiHujPGtaVQTsq9zDTNkzmUD05h6fJK6GwGamv1a3o7CFljft
 fu/HbYXY8H8oHCzGVqpiV8KRPfCubef6pYwhBbDYXcxL73suaHgKSW1/oD6pFLNUmaT6
 8bZJxH7BXyetg7/dkV6dQWXa0SmpuJlI8jTCM/w0hOYh8JweFVdb3qHVcOMdcvP2CO57
 DkfhJuht/sUVfqI17l9Tn9//DsxkHnfPTYu5h62BmlRGHGGHnSGUvZFOkdM9IopR4liF
 5Scg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqQHi7gEfAqHSFRUrYSHdB7vHEOUvXbRL5jch9wsSGW5H2TcNRk7RCn9QbFPVRvVZUZrVAb6eLC3ojF@nongnu.org
X-Gm-Message-State: AOJu0YxwnN6e2snY2ZQF1oeue/1QLCeLxd0T4N5nmnEF1TfmKEn8W+N1
 Fy0nZvix8Ee5CYYPq0xDN7bvFLnFpi6cxfbFAi63Y3kbZsHnODM+pImgXzkLDS4qsYY=
X-Gm-Gg: AfdE7cl/6NiLDQM5/0bzAG7DFMtCfVEJhu++t3GaIC3gbHWgen1rNTI0SsEUT6TxUYY
 kN/i91+e98RnDRb1GKrOg8SVGDXvQGR95hD9H6wNrA5lneeEvQcGQCeemfhEKvFSklwVa6l+B3M
 YEiHp2fU08mmLioHkiCzfTR88BggEy/Ju3NX5X3eB20h7TyV3JnrdXBCFN7iiHGAAnD0LIDMrE5
 X6mKrxQsmNNZ/1QUcRxOKeB3zs9r8l/eno3oHcx74cVW64Blhwf5JaCQi3Db2IkJMyANfn1tEWP
 YUhX4g5ZXk3/btMIhemlPBmC/j1aXY6PkBdpQLzvrtpBjD4u0DiMrXDzpq8AnlYzQdcrkHHXY1L
 eKscnv6vVtsarstcXbmUxeWtznSe6rCVOD7VYXiZ81a8Q2Y8rjcCLrFfOedOTj+Ka89kEut97VU
 27pX7dVgxKvmNACscyGURq8JVbaPnuWcF/OZDCPd+qsVnt2XhKDlEPl7G+9A==
X-Received: by 2002:a17:902:fc43:b0:2c6:9f14:c50c with SMTP id
 d9443c01a7336-2ca7e6a0e95mr86171705ad.13.1783031586196; 
 Thu, 02 Jul 2026 15:33:06 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca9a8dadd7sm19081125ad.6.2026.07.02.15.33.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 15:33:05 -0700 (PDT)
Message-ID: <8ea31c58-09ef-434d-a522-b743ece14c41@linaro.org>
Date: Thu, 2 Jul 2026 15:33:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] target/arm: Implement CPACR.ASEDIS and HCPTR.TASE
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260702184019.3431139-1-peter.maydell@linaro.org>
 <20260702184019.3431139-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260702184019.3431139-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 7/2/26 11:40, Peter Maydell wrote:
> +static int neon_exception_el(CPUARMState *env, int cur_el)
> +{
> +    /*
> +     * Return the EL to trap to for A32 Neon specific traps
> +     * (CPACR.ASEDIS and HCPTR.TASE). In the pseudocode these
> +     * are checked in the same function as the more general trap
> +     * bits that we handle in fp_exception_el(). Fortunately it
> +     * is always the case that if the trap/enable bits specify
> +     * taking an exception to different ELs for the Neon-specific
> +     * insns and the general fp insns then the trap to the lower
> +     * of the two ELs has priority, so we can calculate the two
> +     * target ELs separately and pick the right destination later.
> +     * Compare AArch32_CheckAdvSIMDOrFPEnabled().
> +     */
> +    uint64_t hcr_el2 = arm_hcr_el2_eff(env);
> +    bool cpacr_asedis = FIELD_EX64(env->cp15.cpacr_el1, CPACR, ASEDIS);

CPACR.AESDIS overlaps CPACR_EL1.TCPAC, so we're missing a
check for arm_el_is_aa64(env, 1), when cur_el == 0.

> +    bool hcptr_tase = FIELD_EX64(env->cp15.cptr_el[2], HCPTR, TASE);
> +
> +    if (arm_feature(env, ARM_FEATURE_NO_NEON_TRAPS)) {
> +        /* This CPU doesn't implement the trap bits (Cortex-A8) */
> +        return 0;
> +    }
> +
> +    /*
> +     * CPACR doesn't exist before v6, but neither does Neon, so we can
> +     * assume that if we're testing this then the trap exists.
> +     */
> +
> +    if (arm_feature(env, ARM_FEATURE_EL2) && arm_el_is_aa64(env, 2)) {
> +        /*
> +         * The AArch64 CPTR_EL2 has no equivalent to HCPTR.TASE; only
> +         * an AArch32 EL2 can trap Neon specifically.
> +         */
> +        hcptr_tase = false;
> +    }
> +
> +    /*
> +     * NSACR.NSASEDIS makes the effective values of HCPTR.TASE and
> +     * CPACR.ASEDIS be 1 in NonSecure state. NSACR has no
> +     * effect unless EL3 exists and is AArch32.
> +     */
> +    if ((arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
> +         cur_el <= 2 && !arm_is_secure_below_el3(env))) {

Note extra ().

> +        if (FIELD_EX32(env->cp15.nsacr, NSACR, NSASEDIS)) {
> +            cpacr_asedis = true;
> +            hcptr_tase = true;
> +        }
> +    }
> +
> +    /* CPACR is ignored if E2H+TGE are both set */
> +    if ((hcr_el2 & (HCR_E2H | HCR_TGE)) != (HCR_E2H | HCR_TGE)) {
> +        if (cpacr_asedis) {
> +            if (!arm_el_is_aa64(env, 3)
> +                && (cur_el == 3 || arm_is_secure_below_el3(env))) {
> +                /* Trap from Secure PL0 or PL1 to Secure PL1 */
> +                return 3;
> +            }
> +            if (cur_el <= 1) {
> +                /* trap from EL0 or EL1 to EL1 */
> +                return 1;
> +            }
> +        }
> +    }

I wonder if some reorg is in order.

     bool cpacr_aesdis = FIELD_EX64(...);
     bool hcptr_tase = FIELD_EX64(...);

     if (arm_el_is_aa64(env, 3)) {
         if (arm_el_is_aa64(env, 2)) {
             /* CPTR_EL2 has no equivalent to HCPTR.TASE */
             hcptr_tase = false;
         }
         if (arm_el_is_aa64(env, 1)) {
             /* CPACR_EL1 has no equivalent to CPACR.AESDIS */
             cpacr_aesdis = false;
         }
     } else if (cur_el == 3 || arm_is_secure_below_el3(env)) {
         if (cpacr_aesdis) {
             /* Trap from Secure PL0 or PL1 to Secure PL1 */
             return 3;
         }
     } else if (arm_feature(env, ARM_FEATURE_EL3)) {
         if (FIELD_EX32(env->cp15.nsacr, NSACR, NSASEDIS)) {
             cpacr_asedis = true;
             hcptr_tase = true;
         }
     }

     if (cur_el <= 1 && cpacr_asedis) {
         return 1;
     }
     if (cur_el <= 2 && hcptr_tase) {
         return 2;
     }
     return 0;

     /* TODO since arm_el_is_aa64 is non-trivial, perhaps */

     switch (arm_min_aa64_el(env)) {
     case 1:
         cpacr_aesdis = false;
         /* fall through */
     case 2:
         hcptr_tase = false;
         break;
     case -1: /* !arm_feature(ARM_FEATURE_AARCH64) */
         ...
     }


r~

