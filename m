Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0C9C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u580Y-0005bb-Vn; Wed, 16 Apr 2025 15:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u57zs-0005U2-Pn
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:00:32 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u57zq-0003gq-Fm
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:00:32 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-736b34a71a1so8408493b3a.0
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744830029; x=1745434829; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CSz3Ylhv7yNonx18PtvYR/mN1GLO1+i3JXoR/J4tCRw=;
 b=Z6dPl1RQCK5stEce+4WRwZEt8d/5NtiL6ooVys6FmiIXliKewOZG4BTTFyy2HP65Hz
 ihi1froSWx1rLliBnGA/tLpRf4EUciARec7CsFt6i9mpr3GFOXie4Pzv6qDKnoAwY3Wu
 Suq6oK4dxY0KtUIU/+ixw6ZanyEbfiAdII4htsSfdgvUOkkneLLik4ibUt9MeGILOrdf
 ArcUk3EUWIZWiXYxiKCc8vyj8ujs2uzOOSrlcZ39t6dSBJNlKySmKWWWk7RFBVmlDY5+
 0PdPHpdORAJFfX28SoJg84aUSJH3NYaBct9gk8kB+XvnKjENoPqnv3Ai1Sb94G+9EmE4
 eq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744830029; x=1745434829;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CSz3Ylhv7yNonx18PtvYR/mN1GLO1+i3JXoR/J4tCRw=;
 b=k/muH490d7iFnPk0K8laWETbX1sYy2rXVZ96Urhq2eK6RdZTdcnyrzAagRUIjS5ZjH
 /Ur5nSr8Va+9DTGvoFWSL5y4jW/b1MXqzMSar2kojnXlRr/0oOw1CBNJLi1BNIjs+ApZ
 ++zN7MCTC3yRmNiLdD8lrI1qQ1oLulMsnI8FwSjJMR0M9hJWJ+X2oBFEwN4MscfEUMNN
 ZYZFbKf7U/rDW32VWOM1lYzPSG7bw9scvvQC2tNI7EZzXVHEKCzxsqRZX+BBV0mJfVtf
 knxElLjIG1QOnX3i4NpURiWn2XVqoPYMjb/MLW5mJwlXUAppt3V2xO8MPqBbIJHq89gl
 Vzsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk8gx55e2ps6asFtjAM593n5sVIPzdjJuDUyyVvqfYSu0GNXP3Ub9/GaAy+Ld1UQo2FrRc1xHBzFnG@nongnu.org
X-Gm-Message-State: AOJu0YwRYyEX3LXhSnA4PBQ/96WBFAtPWSvFvIRRgTAklkpJiG4bWapc
 Xl0oD4xoU0LOfVoHgu4kQ2ZkjgE4VZa5Xd06wWFVUI2scogCi/5mNTdjMwSQK4UPsfAdZYZSutu
 5
X-Gm-Gg: ASbGnctf65ICFwdJHPfs3NrUcypXnW57p3lnfTwG0Nq2OR19ny5sb0xmurC7keTyjVK
 r1HQjCL8iTqxcSrOxIwQ9cUtmPVUhqJzaXctP+KUIy1MOREptWJCq/OryIPko0hB+SjeS4vPsfy
 MeSghczWsxB8nVlCaRkv0x/epVHQdfeq06L90uY6rsJnjfUPDB04MWU9639atxeCmwhd4tn4MBO
 psZ+JV6SVlxNkEJY6QX7E4OZDZzyV51cDu+B9+iPzOYlJYYuJiM9oP+jzug0HNESlMnZbYFOGGa
 fGK+f0igD5vcbubCHcBN3FGe1BVXqdW1OPQil3Ea3MHp7VrdaX4akA==
X-Google-Smtp-Source: AGHT+IGVq21wxwpdrmHgCMOApkJ27cl2G/W4JNuNDmmU9aJHiSktxNYMHTuuLlKXImcM97+RiqZ2cA==
X-Received: by 2002:a05:6a21:8cc1:b0:1f5:7df9:f13c with SMTP id
 adf61e73a8af0-203b400cfdfmr3846382637.41.1744830028852; 
 Wed, 16 Apr 2025 12:00:28 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f833asm10810852b3a.111.2025.04.16.12.00.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:00:28 -0700 (PDT)
Message-ID: <c345e249-3a4f-4988-8505-2cfb3d76edd1@linaro.org>
Date: Wed, 16 Apr 2025 12:00:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 124/163] target/arm: Use tcg_gen_addcio_* for ADCS
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-125-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-125-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 4/15/25 12:24, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c |  8 ++------
>   target/arm/tcg/translate.c     | 17 +++--------------
>   2 files changed, 5 insertions(+), 20 deletions(-)
> 
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index 934d66848a..99545a900d 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -1076,11 +1076,9 @@ static void gen_adc_CC(int sf, TCGv_i64 dest, TCGv_i64 t0, TCGv_i64 t1)
>           TCGv_i64 cf_64 = tcg_temp_new_i64();
>           TCGv_i64 vf_64 = tcg_temp_new_i64();
>           TCGv_i64 tmp = tcg_temp_new_i64();
> -        TCGv_i64 zero = tcg_constant_i64(0);
>   
>           tcg_gen_extu_i32_i64(cf_64, cpu_CF);
> -        tcg_gen_add2_i64(result, cf_64, t0, zero, cf_64, zero);
> -        tcg_gen_add2_i64(result, cf_64, result, cf_64, t1, zero);
> +        tcg_gen_addcio_i64(result, cf_64, t0, t1, cf_64);
>           tcg_gen_extrl_i64_i32(cpu_CF, cf_64);
>           gen_set_NZ64(result);
>   
> @@ -1094,12 +1092,10 @@ static void gen_adc_CC(int sf, TCGv_i64 dest, TCGv_i64 t0, TCGv_i64 t1)
>           TCGv_i32 t0_32 = tcg_temp_new_i32();
>           TCGv_i32 t1_32 = tcg_temp_new_i32();
>           TCGv_i32 tmp = tcg_temp_new_i32();
> -        TCGv_i32 zero = tcg_constant_i32(0);
>   
>           tcg_gen_extrl_i64_i32(t0_32, t0);
>           tcg_gen_extrl_i64_i32(t1_32, t1);
> -        tcg_gen_add2_i32(cpu_NF, cpu_CF, t0_32, zero, cpu_CF, zero);
> -        tcg_gen_add2_i32(cpu_NF, cpu_CF, cpu_NF, cpu_CF, t1_32, zero);
> +        tcg_gen_addcio_i32(cpu_NF, cpu_CF, t0_32, t1_32, cpu_CF);
>   
>           tcg_gen_mov_i32(cpu_ZF, cpu_NF);
>           tcg_gen_xor_i32(cpu_VF, cpu_NF, t0_32);
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index d280018138..e5aa76d44a 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -493,20 +493,9 @@ static void gen_add_CC(TCGv_i32 dest, TCGv_i32 t0, TCGv_i32 t1)
>   static void gen_adc_CC(TCGv_i32 dest, TCGv_i32 t0, TCGv_i32 t1)
>   {
>       TCGv_i32 tmp = tcg_temp_new_i32();
> -    if (tcg_op_supported(INDEX_op_add2_i32, TCG_TYPE_I32, 0)) {
> -        tcg_gen_movi_i32(tmp, 0);
> -        tcg_gen_add2_i32(cpu_NF, cpu_CF, t0, tmp, cpu_CF, tmp);
> -        tcg_gen_add2_i32(cpu_NF, cpu_CF, cpu_NF, cpu_CF, t1, tmp);
> -    } else {
> -        TCGv_i64 q0 = tcg_temp_new_i64();
> -        TCGv_i64 q1 = tcg_temp_new_i64();
> -        tcg_gen_extu_i32_i64(q0, t0);
> -        tcg_gen_extu_i32_i64(q1, t1);
> -        tcg_gen_add_i64(q0, q0, q1);
> -        tcg_gen_extu_i32_i64(q1, cpu_CF);
> -        tcg_gen_add_i64(q0, q0, q1);
> -        tcg_gen_extr_i64_i32(cpu_NF, cpu_CF, q0);
> -    }
> +
> +    tcg_gen_addcio_i32(cpu_NF, cpu_CF, t0, t1, cpu_CF);
> +
>       tcg_gen_mov_i32(cpu_ZF, cpu_NF);
>       tcg_gen_xor_i32(cpu_VF, cpu_NF, t0);
>       tcg_gen_xor_i32(tmp, t0, t1);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


