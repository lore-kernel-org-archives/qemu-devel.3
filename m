Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B23D59D77
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 16:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU67R-0004H1-J3; Fri, 12 Dec 2025 11:35:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vU67O-0004Fe-Gv
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 11:35:46 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vU67M-0000qG-6j
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 11:35:46 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4557d35bfc0so413161b6e.1
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 08:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765557342; x=1766162142; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CRn2cAfq6o9o6ET0g7VVtzytU5FRK1wTb7BO1Yf10x4=;
 b=SDwNEC02w1tyfHfknxCsTqXVBIcv7D0hpyyjeFh/VM4hW1wN362TxSq3f07l9QkBKd
 1yX03wrJ9hJvNqsUNMYYah5quppSO15/lZDGGHmB6SyxuJLhQkklb2NTJr7w2rXc5XQx
 9yQywxKr5IzYMgUkdPOZE75/dhm7kQ2dTIKt24Daq7JGCRd8F3JF4+sMEa/ZIS2evjyx
 qgMl0eMQtE/37bCEcT9r8m9KYEer3qnyGl4bu6wFP8dBo0YBCozg+cPHP3Dye05EEqIM
 kSLrKowWjEgc5oNI/xR9gro76ikUFOIeCyL3ZwcPV62KUHGYmtL0XxLFLGB+ZSNAivVT
 L70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765557342; x=1766162142;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CRn2cAfq6o9o6ET0g7VVtzytU5FRK1wTb7BO1Yf10x4=;
 b=OwS4p1HzJgu5jNvpZuDFPnrW6uAyA1DMSRB/xxW3cvhJmyNN3dmr4IW1YcS1RCfc5f
 GxWkheMJpNACeC1YNanRNJuLsMnQqlQyUrxU220P1jDg6Y9whQp/NAxWaqjD5VD117m+
 bOuQFrm5IdzchCe3YZG+3/HtCPQK3hoWh4AY/wmrB56DV5vXef8zFb5wwIS4+vtve4+R
 SuW/KFi7lnUUMAnTWMbyFyXglb4qoALVV7LAkuWf6W2NgH7ke4JfgY3hzJJhyOmrPk5M
 TnyGOh3Pzz5mg97zHIJQ1LK1+moBP0Yfi4+XKwUxX2qVFu1YSUGfBc6XL2UsUWR30sF9
 4P0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvmeRXGTqTKEteyfwmE3yiLk3Hcf+O8flsN2FvxRQ7/YrS5afva4OiXoAVIiBiGRt62Am/adL+edRE@nongnu.org
X-Gm-Message-State: AOJu0Yz2Ng847AD8OmZMK8QvdBQgSo/bLbIQtLPXhZ5v90jU6cAXVTrr
 XRDtb2W8mKmRn6OhUrvWr7ELN/hEvcNpwYDT8WGunMPszkqOsuybwiifjqTndp8J4dk=
X-Gm-Gg: AY/fxX5Q/c347t+DANVWfAyMSmJtRi0YrtbHup+uEkbZ1wbe0eRkVO78Pmp6paoqcvw
 +wpwyR+GfzVP0JQvY7PrvZxz4PFAMFwnrT7bEDKQV0Pj905+fFB1PB2mrkbXRtxPKE/CalhdB2B
 beJVaSyuoq3q/F79ot57KbGa/RMSKlUINoUFV5K5HR6xbaJWepbenehGQ1KjDe0i1NdTlWR84yV
 gN/YJI0Ywf8eVWWpQv6R+IKgkC+AQOmtMYeIDSUhU+iCg2RrGU/6HMrQSbeZgQrB3Ov16kWCMez
 EFhrksZuKOk9XvgdklCFJQajxPz7Mvio78U9Z9DyipqS9LnVkrZtRNdJb91J2Y1uXYSF8oKOsGb
 3jiZJjmgtNAKu7+8mi2fxwziJoUi03SYlIryR2GZ2Fj7ddV8HegoGhMw3VpYYd0aX9JDLau/RP7
 zpyawiBXI7DZt8IwzmEPB76o2Qe5fb
X-Google-Smtp-Source: AGHT+IHTDbgujio86A0J+rdgfiJSGgVqw2yFjX8lxYVKHZzz7+hUstC5ziBPnIbRKncVuZDsndi5/A==
X-Received: by 2002:a05:6808:4f2b:b0:450:be6c:8528 with SMTP id
 5614622812f47-455ac823bd5mr1384410b6e.2.1765557342280; 
 Fri, 12 Dec 2025 08:35:42 -0800 (PST)
Received: from [10.229.62.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-45598b992d6sm2829886b6e.7.2025.12.12.08.35.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 08:35:41 -0800 (PST)
Message-ID: <b0ea5035-bbbe-43cf-aa29-8585c2662070@linaro.org>
Date: Fri, 12 Dec 2025 10:35:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v3 14/22] target/mips: Drop almask argument of
 HELPER_LD_ATOMIC() macro
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20251126202200.23100-1-philmd@linaro.org>
 <20251126202200.23100-15-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251126202200.23100-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

On 11/26/25 14:21, Philippe Mathieu-Daudé wrote:
> HELPER_LD_ATOMIC() now has a MemOpIdx, from which we
> can extract the MemOp size. Use it to check the address
> alignment.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/ldst_helper.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)

True, but adding MO_ALIGN to the MemOpIdx (and thus to the MemOp) might be more useful, 
allowing you to remove this explicit check.


r~

> 
> diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
> index 013cd825dac..bef384575c2 100644
> --- a/target/mips/tcg/ldst_helper.c
> +++ b/target/mips/tcg/ldst_helper.c
> @@ -29,12 +29,14 @@
>   
>   #ifndef CONFIG_USER_ONLY
>   
> -#define HELPER_LD_ATOMIC(name, almask, cpu_load)                              \
> +#define HELPER_LD_ATOMIC(name, cpu_load)                                      \
>   target_ulong helper_##name(CPUMIPSState *env, target_ulong arg, int memop_idx)\
>   {                                                                             \
>       MemOpIdx oi = memop_idx;                                                  \
>       unsigned mem_idx = get_mmuidx(oi);                                        \
> -    if (arg & almask) {                                                       \
> +    MemOp op = get_memop(oi);                                                 \
> +    unsigned size = memop_size(op);                                           \
> +    if (arg & (size - 1)) {                                                   \
>           if (!(env->hflags & MIPS_HFLAG_DM)) {                                 \
>               env->CP0_BadVAddr = arg;                                          \
>           }                                                                     \
> @@ -52,14 +54,14 @@ static target_ulong loads4(CPUMIPSState *env, target_ulong arg,
>   {
>       return (target_long)(int32_t)cpu_ldl_mmuidx_ra(env, arg, mem_idx, ra);
>   }
> -HELPER_LD_ATOMIC(ll, 0x3, loads4)
> +HELPER_LD_ATOMIC(ll, loads4)
>   #ifdef TARGET_MIPS64
>   static target_ulong loadu8(CPUMIPSState *env, target_ulong arg,
>                              unsigned mem_idx, uintptr_t ra)
>   {
>       return (target_ulong)cpu_ldq_mmuidx_ra(env, arg, mem_idx, ra);
>   }
> -HELPER_LD_ATOMIC(lld, 0x7, loadu8)
> +HELPER_LD_ATOMIC(lld, loadu8)
>   #endif
>   #undef HELPER_LD_ATOMIC
>   


