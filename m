Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8E7D7833C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIAKX-00029n-8F; Mon, 02 Dec 2024 12:35:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAKL-00025b-FZ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:35:20 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIAKK-0002nt-1S
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:35:17 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3ea55e95d0fso2206737b6e.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733160915; x=1733765715; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y3at7gTgeYudeP0m6NxUjMC2lv5/xPaWGTJ1ghJT7Zc=;
 b=X/QoyxvHo5TCWbrTBa5mzC6TyUyfDRST5KX+OuQv370fSWQUmWTZjUgrDP0s01KjPC
 WTTfmQ9uYdz9hlBnI4qBuYbFOym2K7ExcLAUUxm/lB7BdlJNE/2JYRWdaLhbO6mH6Jvu
 q/aZSR2qpfcX1B+iX5BM4Gvj8z+xycv1NTC71QaAKc4cbpOSRFYd6oXPad9u0g/FXLSN
 +Drp8Cfm8GtdShyE31tKxXpQSpMpeHBxKixbHVIW4PRnSRAPzh4+LK1qcKqGc3/E889T
 DdHHvvmfkMZ2pll1u8BHOdohtaRefw1LB1RmeV/OCoexvq5Hg9UftEXDfQzbcjqgKJoS
 CTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733160915; x=1733765715;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y3at7gTgeYudeP0m6NxUjMC2lv5/xPaWGTJ1ghJT7Zc=;
 b=AauJ4EDpRlRHN4WQiI/xPrzevPJ2hlvWS7ttHNI56RVBFUKJKlUc0rwOh93Q8Ln/71
 +OBGyUPhXGBDhQ9GqPCKpzhqIK3Lc6L+30YhAhHvH3T4LxvZpZrv00/ZDZa5xUckZuCj
 reX+THd3uTstptqg+cjKixDeiMN2A2HtEkFnfmOWzty1x18u+WxWinRufo/kVVXu/1pD
 1Y6y2FIN7ZmdspyMU/RJAiE2M9DgnND/cbL7WLyWM8RXWvsDuQBxz1FsbAZqHkhfZlGJ
 r80zmF6eBaM0fRrC5y83lbOEDIy1O1DFy9X5ra7il+QmG9lSzDDZbBBvRGCyK7LAm/gt
 AE8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO6ac+BVWSvNOJOLQ8SNaqWaTMrtEyqCvzvqQwiCr1PZwbx28AaKPh0N6/fNrNiXumIYPZPZuUx8du@nongnu.org
X-Gm-Message-State: AOJu0YxTToiw4ZIo/JV3FV6o85mWnKX57gySEVeQBmhUWBIzuBe16p7f
 UwSt6xaL5tFjsO4IEcK7/nfUgo3w16FGIQnzZE4FhrRNJQS2s1R5IDuwvJTBF/08FasTmv+dsu3
 bCPs=
X-Gm-Gg: ASbGncuk4rTbFkvAJ84zsS32mXB0SNMguDvIr2s55j7XyeYY2rt3rk64OL7fDMytm0D
 Ac7Xv1zyh1b/WR/m7h/V1dl+s2K2bN4NzD6087neerW9grtpLA+ePeu2p8/ZFqo7BblO1wh31b0
 b4TSBNV11XExIJTpJXLlO8CTGjo/A/vi7wDWYqE1tuuQZsQh6os6vBzeQi/pzWxIA1VgHdc5pQq
 eW0cxmu4/rRlk6nb+Ues/tA3Ziahf++WeBAd5s6p3IlaKY+6LVAw3bWZtiWUIbmeCRT49I=
X-Google-Smtp-Source: AGHT+IG8O2H1yvAbZS8djmDtKtgXXYn7HR6WMtp5gjDZXzbj6VvDwlZMeHk74CfauRXManzvGJTFAQ==
X-Received: by 2002:a05:6808:205:b0:3ea:556e:4816 with SMTP id
 5614622812f47-3ea6dd49740mr16605309b6e.30.1733160914808; 
 Mon, 02 Dec 2024 09:35:14 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f21a311700sm2337032eaf.6.2024.12.02.09.35.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:35:14 -0800 (PST)
Message-ID: <bc45004b-0b1b-411b-9fb2-37ca162fcfbe@linaro.org>
Date: Mon, 2 Dec 2024 11:35:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 46/54] target/sh4: Set default NaN pattern
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-47-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-47-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/2/24 07:13, Peter Maydell wrote:
> Set the default NaN pattern explicitly for sh4. Note that sh4
> is one of the only three targets (the others being HPPA and
> sometimes MIPS) that has snan_bit_is_one set.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/sh4/cpu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
> index 8f07261dcfd..d5008859b8e 100644
> --- a/target/sh4/cpu.c
> +++ b/target/sh4/cpu.c
> @@ -127,6 +127,8 @@ static void superh_cpu_reset_hold(Object *obj, ResetType type)
>       set_flush_to_zero(1, &env->fp_status);
>   #endif
>       set_default_nan_mode(1, &env->fp_status);
> +    /* sign bit clear, set all frac bits other than msb */
> +    set_float_default_nan_pattern(0b00111111, &env->fp_status);
>   }
>   
>   static void superh_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

