Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32A7C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 22:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqJtp-0001VD-1x; Thu, 06 Mar 2025 17:41:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqJto-0001V3-5l
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 17:41:04 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqJtm-0003UJ-GU
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 17:41:03 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-224100e9a5cso22758405ad.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 14:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741300861; x=1741905661; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8KL15vyXB9QAQcAPMRlWVMYiXID3l7j5JuqraCt9W7U=;
 b=tDsk10eJVm2tZHwvjukt9/JAAHQGpBeMfF+xv1GbE4AT8MoJ4654rtJ/mO6GFTT5um
 Q4D1/APjO7CXzVOkqi5ej9yPL9iEqq22Z4MTWEV0sfMnIHPwSq90haj01ye1ctI77uwf
 fYNZ7ITr49yy2PmRoD9Z6WtXd6b7IVvkLBgHvU1SDM6DU79qSlSrOgIPnM8uzlBbdsxx
 NJ1d7p1u3Okv3dOTMOnEUJP9cO0Mmwg1xpvFfHXg1gzU1I0+8HwRuCj8FVnVPg2+ixLV
 W8pClBbF83sPsnxcm1NAaQcaBvWIAkjA0eGCw0SJ8VNrHwxaG2TP4LI5FzV0K+EiPQyc
 15Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741300861; x=1741905661;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8KL15vyXB9QAQcAPMRlWVMYiXID3l7j5JuqraCt9W7U=;
 b=Nxjc7/gAHAeI69mWT0nlPZiWMPMYk6+nImco+jp8M8g56urCYSBFmsMBfiD3BfQdur
 su2X6m3BBAi4y/kOTHl0DNSpqWb83aLVNNAVOlAFwa2no5d9FO35yUX64LOQggStrgwa
 ma7nlKBk8qegqK+KDFSi3SAZQSwPvc6sQR9iF0KqFRzahp0HAucccrhMuXicJ1UJdmQw
 YNObe+r4y42nUo8rmA/+POhv/fgBVefvY7bh1kWsB/0S588LS5DoIVCNalZeqOU0yPex
 djK87lViC8Do5h7WAoPM+KEld8ov+jGMjS6FkbrZHaPCksgY6LhxSEFIJUWeyCeAKZVN
 ONsg==
X-Gm-Message-State: AOJu0YyIiKcwSJ0WH3191zzBj3fS9WSXo0JJZ1MUeMaE/yoef+NqprXY
 z2cLuiGQfFy+IUGaSJj3xpNVW5g/ieQAZfvkoZCfa/I560fMXtiijnvGUwHWmzw9B5hPSAvY+Ow
 2
X-Gm-Gg: ASbGncudkoJvIJdZey081GTSaeXAuh/+/6m8/zLm2sBrKTpRA8qNP8UHcAhaNOBZXM+
 Vx3FI71IQj1mUzqWGmi2sL30DW5o00mT2TAR1NzIaF267PPNFtXss8B2un+0VSuSHdGRqWt+pcu
 w2YWUDATsCTNVebCKs+1PUZdhkffkM3CnANgKVeVxi7L3T/OhyscAbugt9/QwHCkfqQ/YJhErgD
 5bXvhL8yk9IcyCvIIfwhVlSGuZT/gBVP5M1Xj58H88IVhDJJhviK+c8NeL0Znq6jTjxzkHpZ51F
 TxKFWnRlP2ntSUqJcOXUfVxZN+2cloU82o8XoNGp04GpxKKH/6ywLFwiOlkWlYoPLo1K3BYGPcK
 v+tDug+b4
X-Google-Smtp-Source: AGHT+IF1+q1+E/zJHmOywZ4m4M6rhHmBcju1m6NI9i51DZK/p0qGHj6sIT7dnBvSLTBGgDRicsB+4A==
X-Received: by 2002:a05:6a00:987:b0:736:6151:c6ca with SMTP id
 d2e1a72fcca58-736aa9e7350mr1856961b3a.4.1741300861063; 
 Thu, 06 Mar 2025 14:41:01 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736985150e6sm1891614b3a.123.2025.03.06.14.41.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 14:41:00 -0800 (PST)
Message-ID: <a378cc0e-07fa-4514-8cd9-8826502e534a@linaro.org>
Date: Thu, 6 Mar 2025 14:40:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] target/arm: Move arm_current_el() and
 arm_el_is_aa64() to internals.h
To: qemu-devel@nongnu.org
References: <20250306163925.2940297-1-peter.maydell@linaro.org>
 <20250306163925.2940297-7-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250306163925.2940297-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 3/6/25 08:39, Peter Maydell wrote:
> The functions arm_current_el() and arm_el_is_aa64() are used only in
> target/arm and in hw/intc/arm_gicv3_cpuif.c.  They're functions that
> query internal state of the CPU.  Move them out of cpu.h and into
> internals.h.
> 
> This means we need to include internals.h in arm_gicv3_cpuif.c, but
> this is justifiable because that file is implementing the GICv3 CPU
> interface, which really is part of the CPU proper; we just ended up
> implementing it in code in hw/intc/ for historical reasons.
> 
> The motivation for this move is that we'd like to change
> arm_el_is_aa64() to add a condition that uses cpu_isar_feature();
> but we don't want to include cpu-features.h in cpu.h.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h          | 66 --------------------------------------
>   target/arm/internals.h    | 67 +++++++++++++++++++++++++++++++++++++++
>   hw/intc/arm_gicv3_cpuif.c |  1 +
>   target/arm/arch_dump.c    |  1 +
>   4 files changed, 69 insertions(+), 66 deletions(-)

Likewise, is there a good reason to keep arm_current_el inline?

I can see that a fair fraction of arm_el_is_aa64 calls have a constant second argument 
(and most of those check el3).  Therefore I can see that keeping that function inline can 
eliminate quite a lot of tests.

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> +/* Return true if the specified exception level is running in AArch64 state. */
> +static inline bool arm_el_is_aa64(CPUARMState *env, int el)
> +{
> +    /*
> +     * This isn't valid for EL0 (if we're in EL0, is_a64() is what you want,
> +     * and if we're not in EL0 then the state of EL0 isn't well defined.)
> +     */
> +    assert(el >= 1 && el <= 3);
> +    bool aa64 = arm_feature(env, ARM_FEATURE_AARCH64);
> +
> +    /*
> +     * The highest exception level is always at the maximum supported
> +     * register width, and then lower levels have a register width controlled
> +     * by bits in the SCR or HCR registers.
> +     */
> +    if (el == 3) {
> +        return aa64;
> +    }
> +
> +    if (arm_feature(env, ARM_FEATURE_EL3) &&
> +        ((env->cp15.scr_el3 & SCR_NS) || !(env->cp15.scr_el3 & SCR_EEL2))) {
> +        aa64 = aa64 && (env->cp15.scr_el3 & SCR_RW);
> +    }
> +
> +    if (el == 2) {
> +        return aa64;
> +    }
> +
> +    if (arm_is_el2_enabled(env)) {
> +        aa64 = aa64 && (env->cp15.hcr_el2 & HCR_RW);
> +    }
> +
> +    return aa64;
> +}

I'll note that this would be clearer with early returns instead of &&.
E.g.

     if (!arm_feature(env, ARM_FEATURE_AARCH64)) {
         return false;
     }
     if (el == 3) {
         return true;
     }

     if (arm_feature(env, ARM_FEATURE_EL3)
         && (env->cp15.scr_el3 & SCR_RW)
         && ((env->cp15.scr_el3 & SCR_NS)
             || !(env->cp15.scr_el3 & SCR_EEL2))) {
         return false;
     }
     if (el == 2) {
         return true;
     }
     ...

But of course not changed with code movement.


r~

