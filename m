Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219D1C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 22:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thbzQ-0000Kf-3u; Mon, 10 Feb 2025 17:10:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thbzO-0000F8-6x
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:10:50 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thbzL-00015K-12
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:10:49 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2f9b91dff71so7551831a91.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 14:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739225445; x=1739830245; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hx6rXmOzmhNZfCCRok9AvvrGUo50eO9KKj9SQEthRLs=;
 b=Ks5MJZ/eV22l8SqIdWwMJXCDuzI00lchH8VxJ9ylVvTfPWaWDG7z+sFo0WlP+EFpUH
 pj+QwFl3YrhyPYFUuXjgko3vb2N7MSaGtBjnPgQXQkxVUgb2Kkl6C9o/VGXC9ObVHZXL
 pIzl/dGbLF+HcHW/PqZjTf7bStadH220kckv0UT5cK+8tkoEsOGuW25Uz6Nd+mccTxmx
 hKvp8MMF974r+t3FAamVmKPEItPR9WdlXq60d4eToY6NpVFqrlkbL7hiQc3LPS/eJucR
 O7a5VZTGSO7l4+J1R8/UKIwjdpHgibDxUFJ1XfKL/A2o16sHmbnQNq19H76YgP9yKDCj
 0sZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739225445; x=1739830245;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hx6rXmOzmhNZfCCRok9AvvrGUo50eO9KKj9SQEthRLs=;
 b=VkKxSZeKcnUCcnM/O79zPSVyCp/YQhmrE/qZdYdOcE/cQbT9DVlx+p2Bap8gnBJwl6
 A4eIawviEcupmWiRx0G4F+yVPb4TFCY7Iz1ey4vPMlQwuu0A31Ykn5ka/4ovl1pT+JzA
 S4soRu4HosIPaLgPttURYM84FVh+vBUYTvMzcKvCU3DstOO56FJbEojMuJL5gnRiirSi
 93mzkJV/yB47FCU7d/jT9Dg5BuBWNUtm6bS42EwN61OuRogesw36LlJ7ydwUGRmWnD6V
 CQrSfVRW28JQZBBmwPGHXAAkBU/UEt46ZJzphhVqkEXI+ZFGGcevs4+eSRcKg2ZaGp9r
 lSrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiB5HDXgO7QsgRoDNW76QiS8KPBd0mGtwiVSKKVhA/VFc5nQJPJD43UT8Y61cLnUngGaFx/j1hvVmT@nongnu.org
X-Gm-Message-State: AOJu0Yy4b6dyU9Se8PyAbb6H7g+rUfC3diJSavkUs4RtYAFloF+tzZ0P
 SireESc2zAj8NLlihzR8eH5umPxePwR82ywzVyElZuTXYyWPmi8tJmw62LPH3iU=
X-Gm-Gg: ASbGncvrEwXXzO4SuG8JUv4WQ9Q2v+8fRy1M8qkmkfm7snkORpVudJb45qoAZAUbM3u
 n58BXkz7GI64nsen7BH8ye5SFgtrv4sCaNlbC1pzHFp4ufSAXyDXmc868q5vWH/NVOxJ6iIyK0S
 LvQIoHpDh9s6thbOdRueXJZT+kxaVwO/3UtgyrKIeOXa1C4DGNqIGfZxZ91NpqFev7Rf4neaBgd
 pRfJ7ChewsxxLMGI9BnHD+9Mi1ti0k0sRxDKClmIdSixZM/d2PDbqOKHuo8d9Wq0M2CmAmdu2Zb
 yBzB7ZHsE6zCG2W2/HtuLR6yTlPAd0N3s66rrsi8M1tQUMWf52rmqhQ=
X-Google-Smtp-Source: AGHT+IE8Xd5J8m/j5D/BQMOhUQ1I6AEZTyxs+l7FKjSA6ZQkhxhFkJB6xwlKcEpWHwzuPC21+3uJUQ==
X-Received: by 2002:a17:90b:184d:b0:2ee:fdf3:38dd with SMTP id
 98e67ed59e1d1-2fa242e5d0dmr18722411a91.23.1739225445366; 
 Mon, 10 Feb 2025 14:10:45 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa618e5e18sm4344939a91.41.2025.02.10.14.10.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 14:10:45 -0800 (PST)
Message-ID: <7056fbfc-58eb-4881-a6ee-67b3e608a336@linaro.org>
Date: Mon, 10 Feb 2025 14:10:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] target/arm: Set disassemble_info::endian value
 in disas_set_info()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, Thomas Huth
 <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org
References: <20250210212931.62401-1-philmd@linaro.org>
 <20250210212931.62401-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250210212931.62401-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 2/10/25 13:29, Philippe Mathieu-Daudé wrote:
> Have the CPUClass::disas_set_info() callback set the
> disassemble_info::endian field.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/cpu.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 94f1c55622b..68b3a9d3ab0 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1188,7 +1188,7 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
>   {
>       ARMCPU *ac = ARM_CPU(cpu);
>       CPUARMState *env = &ac->env;
> -    bool sctlr_b;
> +    bool sctlr_b = arm_sctlr_b(env);
>   
>       if (is_a64(env)) {
>           info->cap_arch = CS_ARCH_ARM64;
> @@ -1215,13 +1215,9 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
>           info->cap_mode = cap_mode;
>       }
>   
> -    sctlr_b = arm_sctlr_b(env);
> +    info->endian = BFD_ENDIAN_LITTLE;
>       if (bswap_code(sctlr_b)) {
> -#if TARGET_BIG_ENDIAN
> -        info->endian = BFD_ENDIAN_LITTLE;
> -#else
> -        info->endian = BFD_ENDIAN_BIG;
> -#endif
> +        info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
>       }
>       info->flags &= ~INSN_ARM_BE32;
>   #ifndef CONFIG_USER_ONLY

This is a faithful adjustment to the existing code, so,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

However:

(1) aarch64 code is always little-endian,
(2) sctlr_b is always false from armv7 (and thus always false for aarch64)
(3) I think the BE32 logic is wrong -- CONFIG_USER_ONLY is irrelevant.
     See linux-user/arm/cpu_loop.c, target_cpu_copy_regs.


r~

