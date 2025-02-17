Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AE6C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6lU-0006ME-BJ; Mon, 17 Feb 2025 14:26:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6lR-0006EL-Qr
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:26:45 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6lQ-0007ca-0d
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:26:45 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-220e6028214so75875645ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820402; x=1740425202; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vPcHFoezLtYDHrber4jXyTDfBUZb85GxtQpcUkrQ95A=;
 b=uK2Rkw+naUAyvYzcZ/jRTbjMNKqSMtmPPkUjD2cs2E9yJGE6pf1ujzrdkVy8qIfwDz
 ogNouwVdQLPqaFCyHj0DdIyCvns3TQTSf44i3CnVRv/4HyDadWoFqqqB3FqvjBENjxgC
 UJzG4gWffKvEnbd39vhXp5g7B557Gz21f7GhHEi1md0FRJGHCdaisLr21+NNrSVPhAPY
 6MhrH3oS+iUIiUk6iKRKDTXX846liOyxjxUoT8s+akVCenwBEGqs2mhxYfaU/ndXumN3
 qB23FAkyZatQsyM8jCTLyKUOkvgtr394JKwRBQhLxR6jW7F2/drXIzLVtoY71DdY3e8p
 kUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820402; x=1740425202;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vPcHFoezLtYDHrber4jXyTDfBUZb85GxtQpcUkrQ95A=;
 b=nfubcKlj/jX/3HNccqIxcY29OqpH4lU/bL+WubtgEykMVP3ZE8hQS7HOU5GN+tceSW
 cHI5QTsCy0LQN6reGDAQM5a9SF14FQRXlO64qS8v70MJ5ayGdpN/oMcDpcGgnBYaA6s1
 tdbTVf9LD28i0+hepAhajnJzjFCWFtvwYuj7aF8+BEZ3UjdjV6HaX4TLg+ZmcPedkkKO
 AdI5DMqnzwMT/Mo3bDSeelz1QQB/5U2PuNKBUfeTMdGM5ETl11MALA+TTnYRnnqjV/Si
 WO2wXc7db0gPjn/Ga8DfB0GdeqFb2wvTsGOBiJW8t4SSWrtoWAz4f3slERB4URktpbSx
 xUUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgljN3d2BU5ArOSF2RoQNSAlrDgQRvjqkccBaBWq3w/DPE/G+ngyAH0/4k0qSD7N953hdLkee4/3QF@nongnu.org
X-Gm-Message-State: AOJu0YzK0cwcaCoxcz30rqIMz20dtoM5mWyLSpxMZig39la94mwXthbj
 LR8LyISQzqwJ0ghl3R372t9Ja4cOH25zczTWiJ1/BMvCWWmYL74ANRpKMdBMh9A=
X-Gm-Gg: ASbGncvKV5TYIU36db6mTpKxMF8HZyo0t3JRiq6LwaOOGBzS7vIekZfq7qheBzII5UN
 qqr0wviNUQD2Ayg/2E2bfZNrutk3yE4L5oxVtQX6kQ5UTuhwwnC2PQX+PtUZ+BuX2F4tGLmgN1w
 PFUiwRxs8hoE9NcMxiMvqP4GR1vPrVNagoCq9BykwhIZCWElyeza1tNXtn5ORtf40cp3akkfoXC
 t5cvc1rkNB/fbL3bzcd+zofEGsvTo4qSjnEHHiT9GOG/3k0Ns1MnQAlngLLaoDiT3eP8hG9iPfm
 /KyAQMqcVcSDXKecC+YfBfu13QUBCF/X2J0Ea9Cb9J5gQ200K/NMGWI=
X-Google-Smtp-Source: AGHT+IEs9EFfnoiekUBedJxzLah9NO/SoX3rqPyagGhpkto7QXjE4bNzhFaDXi7CJj6xxf6i0bZ28w==
X-Received: by 2002:a05:6a20:4304:b0:1e0:c56f:7daf with SMTP id
 adf61e73a8af0-1ee8cb0e907mr19229012637.6.1739820402367; 
 Mon, 17 Feb 2025 11:26:42 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adc68bae3e2sm6229583a12.58.2025.02.17.11.26.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 11:26:42 -0800 (PST)
Message-ID: <bbd848a4-6b89-4c41-b381-d90d5c1279a5@linaro.org>
Date: Mon, 17 Feb 2025 11:26:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] fpu: Always decide snan_bit_is_one() at runtime
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
 <20250217125055.160887-9-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250217125055.160887-9-peter.maydell@linaro.org>
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

On 2/17/25 04:50, Peter Maydell wrote:
> Currently we have a compile-time shortcut where we return a hardcode
> value from snan_bit_is_one() on everything except MIPS, because we
> know that's the only target that needs to change
> status->no_signaling_nans at runtime.

Pasto from the previous patch on the variable name.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> Remove the ifdef, so we always look at the status flag.  This means
> we must update the two targets (HPPA and SH4) that were previously
> hardcoded to return true so that they set the status flag correctly.
> 
> This has no behavioural change, but will be necessary if we want to
> build softfloat once for all targets.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/hppa/fpu_helper.c       | 1 +
>   target/sh4/cpu.c               | 1 +
>   fpu/softfloat-specialize.c.inc | 7 -------
>   3 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
> index 8ff4b448049..a62d9d30831 100644
> --- a/target/hppa/fpu_helper.c
> +++ b/target/hppa/fpu_helper.c
> @@ -67,6 +67,7 @@ void HELPER(loaded_fr0)(CPUHPPAState *env)
>       set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
>       /* Default NaN: sign bit clear, msb-1 frac bit set */
>       set_float_default_nan_pattern(0b00100000, &env->fp_status);
> +    set_snan_bit_is_one(true, &env->fp_status);
>       /*
>        * "PA-RISC 2.0 Architecture" says it is IMPDEF whether the flushing
>        * enabled by FPSR.D happens before or after rounding. We pick "before"
> diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
> index 4ac693d99bd..ccfe222bdf3 100644
> --- a/target/sh4/cpu.c
> +++ b/target/sh4/cpu.c
> @@ -128,6 +128,7 @@ static void superh_cpu_reset_hold(Object *obj, ResetType type)
>       set_flush_to_zero(1, &env->fp_status);
>   #endif
>       set_default_nan_mode(1, &env->fp_status);
> +    set_snan_bit_is_one(true, &env->fp_status);
>       /* sign bit clear, set all frac bits other than msb */
>       set_float_default_nan_pattern(0b00111111, &env->fp_status);
>       /*
> diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
> index a2c6afad5da..ba4fa08b7be 100644
> --- a/fpu/softfloat-specialize.c.inc
> +++ b/fpu/softfloat-specialize.c.inc
> @@ -93,17 +93,10 @@ static inline bool no_signaling_nans(float_status *status)
>    * In IEEE 754-1985 this was implementation defined, but in IEEE 754-2008
>    * the msb must be zero.  MIPS is (so far) unique in supporting both the
>    * 2008 revision and backward compatibility with their original choice.
> - * Thus for MIPS we must make the choice at runtime.
>    */
>   static inline bool snan_bit_is_one(float_status *status)
>   {
> -#if defined(TARGET_MIPS)
>       return status->snan_bit_is_one;
> -#elif defined(TARGET_HPPA) || defined(TARGET_SH4)
> -    return 1;
> -#else
> -    return 0;
> -#endif
>   }
>   
>   /*----------------------------------------------------------------------------


