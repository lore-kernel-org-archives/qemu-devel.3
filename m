Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B201CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 18:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSfFU-0004JU-VL; Thu, 28 May 2026 14:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSfFS-0004J0-Tb
 for qemu-devel@nongnu.org; Thu, 28 May 2026 14:14:26 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSfFQ-00066f-Me
 for qemu-devel@nongnu.org; Thu, 28 May 2026 14:14:26 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c80203b9d7bso5364089a12.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 11:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779992062; x=1780596862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xBFbAGQ9uuYpfBrVFl8Rrtc/TrpBS0yPKgiam9kue9o=;
 b=FoqZWXL7YzXuF3ugjOxcoG/PHoN4T3itP77RNEUlqR8fPK9p0CS0GXCn1ypuBztrMZ
 otXWz7MHBnoNBRrhyIcwKsc8tWwrNdMavVUObvSOmiWcxEDupO60MBZUUos9gCBbBabp
 23K6Cv1FoLAb4LQkOhoParu83+FspGLE7f/oEvGvTM+E2aKIcqdXL6s9I2fUW+piobA/
 uFh/aV5ao+9dRSJ9B7VJqdhKvlcyKe8FYpPDoIgQTjnE2BDjoltK60Hk5gA5vo8DfX4D
 8YKDqX9RnStRbZmMxnKxVb7fHphjFO8MQU8sVK3GEbaGiE68I73/Vhi6QPWkBeWvWF7g
 HS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779992062; x=1780596862;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xBFbAGQ9uuYpfBrVFl8Rrtc/TrpBS0yPKgiam9kue9o=;
 b=mfG9yaiS3NYm4PiTWji/PyFuJhSQaEjJlqUx9joWXWwGNdG46NaSoBcAePZRX6flbs
 H2ae9W/RY8Qz2v4f3nr3d2pIvH6KzWmbtJhFEyBuGW3iHNm+edIgGr4m8Tw/JkKCxM9+
 wYzJaHMZqBNmJtSGPOA9Wxv0ZqyolpTE54a0/FOyBP6Dv6puofGBdnBmq6/DPZhyTs/4
 nQ2RHLNUdEFNtbNbMVjnvwsdraoD8CZSJcdCToR/uTxPAd/2oImIX9Fgw0/6z2MyHjFP
 +bn1tVsXaoTA+ZFOufq8E0k1griU1hdbmzk9AHl3tSF52vJnIGuhkLMy7Gya6kUsKcSv
 LgGA==
X-Gm-Message-State: AOJu0Yxzxi8X6jYVvIS3Te51yxY2/R7nmmOudi+luTexwvyvwxNW6ycj
 DbjsuQzIj7Jkpibwvtnti72qnTkobEDXzE/JqOwKcUOWIBdaCWXJ7W3JuIj2pUPt35UT4xqpYm8
 REPs+Xy4=
X-Gm-Gg: Acq92OE+/3MhSsdiJnmzewlu5NTHNnCz0z2lbOeSbJRVI6JL+COvrw3cMBS92yRO4Fu
 tDVCP0Lk5qtAW8JI/lehrXZtDHDXGW+Pp7H5dGLDIACiKx+87JSuYE/kkykFSDA7yPOfaMzDCf2
 hGZQc7R3mxkd9hAlNQPcjkVb7rq7LUER6vt9LxiO/WprGB2mgzba0DdfmOO8dkIFvMTmXLbovA4
 03f9D/vFhuL7J5Uj2EBX/NNOSIBg/yFes8s9pCreAIPD5uQPeOFsmDj5Y9oBG8KtayaKGH6H8RX
 AMr1te9LqA/8fjp1qOTKwnb5HjIolq4YRWM43XiWa9mzqgUgd4Wc3OZZuYvvpLJfT0XhM7S8ntO
 Yg1p7/CZ1YGEaZhOjs0AsKMHnm68cwR996eCqRhwK6IsN/6J8Bi1JVHDm5EgKejt57Gj0tVhU2P
 7uiRXo6hXrYReyz4lW2oWRKZBem7DLOFmBOExuSND3/XesUXo=
X-Received: by 2002:a05:6a20:3948:b0:3b3:c28:45bc with SMTP id
 adf61e73a8af0-3b328fa55femr31180640637.48.1779992061905; 
 Thu, 28 May 2026 11:14:21 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8572e70d19sm925a12.1.2026.05.28.11.14.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 11:14:21 -0700 (PDT)
Message-ID: <51826d6a-4b9c-4889-8e58-94f5eac7f768@linaro.org>
Date: Thu, 28 May 2026 11:14:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/arm: Setup new registers for GPC3
To: qemu-devel@nongnu.org
References: <20260528-jmac-gpc3b-v1-0-d34c46c5069f@linaro.org>
 <20260528-jmac-gpc3b-v1-2-d34c46c5069f@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260528-jmac-gpc3b-v1-2-d34c46c5069f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

On 5/28/26 08:34, Jim MacArthur wrote:
> Adds GPCBW_EL3. A custom write function is necessary to flush TLBs
> when this register is written. Also allows write to the GPCBW bit of
> GPCCR_EL3.
> 
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>   target/arm/cpu.h    |  7 +++++++
>   target/arm/helper.c | 19 +++++++++++++++++++
>   2 files changed, 26 insertions(+)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 85552b573c..9944dc9727 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -546,6 +546,7 @@ typedef struct CPUArchState {
>           /* RME registers */
>           uint64_t gpccr_el3;
>           uint64_t gptbr_el3;
> +        uint64_t gpcbw_el3;
>           uint64_t mfar_el3;
>   
>           /* NV2 register */
> @@ -1228,6 +1229,8 @@ void arm_v7m_cpu_do_interrupt(CPUState *cpu);
>   typedef struct ARMGranuleProtectionConfig {
>       /* GPCCR_EL3 */
>       uint64_t gpccr;
> +    /* GPCBW_EL3 */
> +    uint64_t gpcbw;
>       /* GPTBR_EL3 */
>       uint64_t gptbr;
>       /* ID_AA64MMFR0_EL1.PARange */
> @@ -2098,6 +2101,10 @@ FIELD(GPCCR, NA6, 27, 1)
>   FIELD(GPCCR, NA7, 28, 1)
>   FIELD(GPCCR, GPCBW, 29, 1)
>   
> +FIELD(GPCBW, BWSIZE, 37, 2)
> +FIELD(GPCBW, BWSTRIDE, 32, 5)
> +FIELD(GPCBW, BWADDR, 0, 25)
> +
>   FIELD(MFAR, FPA, 12, 40)
>   FIELD(MFAR, NSE, 62, 1)
>   FIELD(MFAR, NS, 63, 1)
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 34487eeaa3..12453fe39f 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -4990,6 +4990,10 @@ static void gpccr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                      R_GPCCR_SPAD_MASK | R_GPCCR_NSPAD_MASK | R_GPCCR_RLPAD_MASK;
>       }
>   
> +    if (cpu_isar_feature(aa64_rme_gpc3 , env_archcpu(env))) {
> +        rw_mask |= R_GPCCR_GPCBW_MASK;
> +    }
> +
>       env->cp15.gpccr_el3 = (value & rw_mask) | (env->cp15.gpccr_el3 & ~rw_mask);
>   }
>   
> @@ -4999,11 +5003,26 @@ static void gpccr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
>                                        env_archcpu(env)->reset_l0gptsz);
>   }
>   
> +static void gpcbw_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                        uint64_t value)
> +{
> +    uint64_t rw_mask = R_GPCBW_BWADDR_MASK | R_GPCBW_BWSTRIDE_MASK |
> +                       R_GPCBW_BWSIZE_MASK;
> +    ARMCPU *cpu = env_archcpu(env);
> +    tlb_flush_by_mmuidx(CPU(cpu), alle1_tlbmask(env));
> +
> +    env->cp15.gpcbw_el3 = (value & rw_mask) | (env->cp15.gpcbw_el3 & ~rw_mask);

There's no need to merge, because all other fields are RES0.
Just value & rw_mask is sufficient.

This is true for GPCCR too, fwiw, but fixing that as a separate patch.


r~


