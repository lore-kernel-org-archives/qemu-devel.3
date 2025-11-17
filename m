Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3933CEBF61
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 16:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1wY-0001Wf-VX; Mon, 17 Nov 2025 11:19:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vL1vf-0001Fl-Qz
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 11:18:19 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vL1vd-0005HS-JF
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 11:18:11 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42b3108f41fso2756774f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 08:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763396287; x=1764001087; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PEGtx4glEPHESr4eXKn/cYl9f25xI1JVH/ZWB7Z0ENI=;
 b=S/25A5ClgxxcRtjIXRUmfa87re3wtoZ1MLnZEqgowh2/hclIolw9Rz3EgO029MyUHp
 YN3lxenVQrdehsy+mlXVTq1Rq4AjOLRD5NdLGBJYvnAeZ0l1MoLw72unzlzfQvFAU4/e
 0ECXQ59FVyLjhiriKNeFz0g/zTcVpHGhvDOdagQX4hL4A1iBUCqEYtnWBwN0B4GSHW5z
 G9hkdzO6YprjiRLIGMuZ1vYQnxGiVNkWxET4Rd6pLsFjntmJ25uuEwSOEO5SatsjD66i
 rPdwKvtfhA1rFbFipqzo4AmCm90m1EfbvaW4JiyesCH/mWvIqa0491uejBb75raVSoUp
 y0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763396287; x=1764001087;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PEGtx4glEPHESr4eXKn/cYl9f25xI1JVH/ZWB7Z0ENI=;
 b=V1TnX5Y4yYTRtqRSjhaLvz+YTTyEo16tW8zqVR+2xrVM7iKtOxvHrHmm22pqoSLPtg
 uvwt9ERcn83fTVj0NSzOs9fqlGyre0Y5k4OAHt9gFFlHljyTSAry758+2ZkF0yEWWduP
 ZXoVcwCrtMSnJxA7LlJ7aTqF9PR8NFO+y3SxtZi+NL9wDwavvBCPOC5qPNwpCLzl8Ccw
 9x00fAlpETajTlitF4OBzgaUJb/NjBqv9xhaqBiqcdvLsUBXN9Wdc2w5zaKYFNynauql
 TSl8mug2Hh9d5Jn9gLGMf1dhaOQdh+z7ybmngr9TX7SyDwspk/E94M/L9EGPUYsNQRci
 o+Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmgAO8aODmyCFG7A3bE0VFfunyZkHI/hLNGSbmYwqvg9m05NzWJ+Cu+OvBP0wROj1cOADmm9zNJkKa@nongnu.org
X-Gm-Message-State: AOJu0Yy7RG54bd7zcdu63m+S6DGJxM0XERInhprz4EYk3NlDhrZ7ERBz
 l7Fjivm/kfKcxFAFLMeijmGXYQZwz8hym412A1ZhCZLukNUvvsRIpgBKYHwfzcdW0EE=
X-Gm-Gg: ASbGncvgmx0FwUFJo2cGAhRpOiIQ1T96dFzfGjJke6dYX6i/0qWRHzBSe0zseac57Pm
 EKdKIJ7UlqCA4PgQ1kkDFOj9IlIySrmNbgGDkdFZxKmtWc9KOo8o6gKVcOC51Vh95LJyexOJ3T6
 MlR7L9pa5A80dZxkFXPRIr2B+Y0zRsAqRGCW1D8eta+KBQa2GRMNSEtawtJ+ZyJN/9JDmRKhhBd
 2hzkAcGTkNU4c4lRJefOR3fyMQZK5oanaMJX/Vwyp7VUBt4mpOMHirjRJkzpxEYwRG+PS6RjRML
 YsLtD9+qapDLpw5WyJQs60PyLifZAAYlBjmY4lPDVt4c2nItuZvmOztcrYu64m4FHbWefFAk68U
 E6IdbIvJKV0+gNvlVNLnX0SNhEkVf5mnwu6g8mNsYQndBXaqRV/dWyp3IQrzJS9xQ/onKxWm38n
 bAMn9d8sFyf3tpeD7ZbdI0taiduvnM1zYzpEk1W75AtwoEVXXnngSepqS+Z+Kf
X-Google-Smtp-Source: AGHT+IFTF2SwuPmKiSqFIRKIalWaceUxq39Wzs99DbMjOjikzXwBB68Whb6c126THWRFh/lE0xGEbg==
X-Received: by 2002:a05:6000:2008:b0:429:c450:8fad with SMTP id
 ffacd0b85a97d-42b59396f60mr13349573f8f.53.1763396287032; 
 Mon, 17 Nov 2025 08:18:07 -0800 (PST)
Received: from [192.168.8.105] (66.red-37-158-132.dynamicip.rima-tde.net.
 [37.158.132.66]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e845bdsm26131704f8f.12.2025.11.17.08.18.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 08:18:06 -0800 (PST)
Message-ID: <288583e6-42ae-45ba-99d4-376d379a940d@linaro.org>
Date: Mon, 17 Nov 2025 17:18:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 06/10] target/arm: add canonical and no-address tag
 logic
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org
References: <20251116-feat-mte4-v2-0-9a7122b7fa76@gmail.com>
 <20251116-feat-mte4-v2-6-9a7122b7fa76@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251116-feat-mte4-v2-6-9a7122b7fa76@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
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

On 11/17/25 02:40, Gabriel Brookman wrote:
> This feature causes tag checks to compare logical address tags against
> their canonical form rather than against allocation tags. Described in
> the ARM ARM section "Logical Address Tagging".
> 
> Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
> ---
>   target/arm/internals.h      | 40 ++++++++++++++++++++++++++++++++++++++++
>   target/arm/tcg/mte_helper.c | 12 ++++++++++++
>   2 files changed, 52 insertions(+)
> 
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 75677945af..5f0bcdaaac 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1633,6 +1633,46 @@ static inline bool tcma_check(uint32_t desc, int bit55, int ptr_tag)
>       return tcma && match;
>   }
>   
> +/* Return whether or not the second nibble of a VA matches bit 55.  */
> +static inline bool tag_is_canonical(int ptr_tag, int bit55)
> +{
> +    return ((ptr_tag + bit55) & 0xf) == 0;
> +}
> +
> +/* Return true if mtx bits mean that the access is canonically checked.  */
> +static inline bool mtx_check(CPUARMState *env, bool bit55)
> +{
> +    /*
> +     * the MTX bits used in EL0 are those used in whichever EL is used
> +     * for the supervisor. The EL that contains the supervisor uses
> +     * bits 60 and 61 (MTX0 and MTX1), while the other ELs that aren't
> +     * used by the supervisor.
> +     */
> +    int el = arm_current_el(env);
> +    if (el == 0) {
> +        if (HCR_E2H & env->cp15.hcr_el2) {
> +            return (1l << (60 + bit55)) & env->cp15.tcr_el[2];
> +        } else {
> +            return (1l << (60 + bit55)) & env->cp15.tcr_el[1];
> +        }
> +    } else if (el == 1) {
> +        if (HCR_E2H & env->cp15.hcr_el2) {
> +            g_assert_not_reached();
> +        } else {
> +            return (1l << (60 + bit55)) & env->cp15.tcr_el[1];
> +        }
> +    } else if (el == 2) {
> +        if (HCR_E2H & env->cp15.hcr_el2) {
> +            return (1l << (60 + bit55)) & env->cp15.tcr_el[2];
> +        } else {
> +            return (1l << 33) & env->cp15.tcr_el[2];
> +        }
> +    } else if (el == 3) {
> +        return (1l << 33) & env->cp15.tcr_el[3];
> +    }
> +    return false;
> +}

Again, you can't touch hcr_el2 directly.
In this case, you want to use regime_tcr, using the mmu_idx value from mte_probe_int.

Use arm_mmu_idx_to_el() instead of arm_current_el(), so that UNPRIV acceses are handled 
correctly.

Using "l" is always wrong; always ll or preferably ull.
Though really defines for

   bit55 ? TCR_MTX1 : TCR_MTX0

wouldn't go amiss.

You seam to be missing a check for FEAT_MTE_NO_ADDRESS_TAGS or FEAT_MTE_CANONICAL_TAGS.

> +
>   /*
>    * For TBI, ideally, we would do nothing.  Proper behaviour on fault is
>    * for the tag to be present in the FAR_ELx register.  But for user-only
> diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
> index f9fd6fd408..513ee8d6a1 100644
> --- a/target/arm/tcg/mte_helper.c
> +++ b/target/arm/tcg/mte_helper.c
> @@ -799,6 +799,10 @@ static int mte_probe_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
>           return 1;
>       }
>   
> +    if (mtx_check(env, bit55)) {
> +        return tag_is_canonical(ptr_tag, bit55);
> +    }

This could use a comment like

     If mtx is enabled, then the access is MemTag_CanonicallyTagged,
     otherwise it is MemTag_AllocationTagged.  See AArch64.CheckTag.

> +    if (mtx_check(env, bit55)) {
> +        if (tag_is_canonical(ptr_tag, bit55)) {
> +            goto done;
> +        }
> +        mte_check_fail(env, desc, ptr, ra);
> +    }

Likewise.

In the pseudocode, walkparams.mtx is used in AArch64.VAIsOutOfRange, which is part of 
get_phys_addr_lpae() here:

     /*
      * We determined the region when collecting the parameters, but we
      * have not yet validated that the address is valid for the region.
      * Extract the top bits and verify that they all match select.
      *
      * For aa32, if inputsize == addrsize, then we have selected the
      * region by exclusion in aa32_va_parameters and there is no more
      * validation to do here.
      */
     if (inputsize < addrsize) {
         uint64_t top_bits = sextract64(address, inputsize,
                                            addrsize - inputsize);
         if (-top_bits != param.select) {
             /* The gap between the two regions is a Translation fault */
             goto do_translation_fault;
         }
     }

There is also a use in AArch64.S1DisabledOutput, which would correspond to 
get_phys_addr_disabled(), which is relevant before

             if (extract64(address, pamax, addrtop - pamax + 1) != 0) {
                 fi->type = ARMFault_AddressSize;


r~

