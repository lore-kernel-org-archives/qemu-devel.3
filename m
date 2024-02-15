Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD41C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 19:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rahdC-0002Z0-OM; Thu, 15 Feb 2024 14:42:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rahdB-0002YT-Ec
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 14:42:49 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rahdA-0007cX-0N
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 14:42:49 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d7881b1843so11316515ad.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 11:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708026166; x=1708630966; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3IzWdaKbNL5WPD1wSa/h4NlUNQr+Rrw8XqB/TKkg/Gw=;
 b=w/xGqfaleYOBxF8jQjOBNioXP313DhL0/z+7xpinke8xyOvStrYnBzmc51QulSmraX
 eUWJ6rD7iv0unoIswRsKhmhvZI7eJVPdiuYIys3KYKigJG5LLhJwYg5uPM11JjOdWJVh
 vOnIDnutxkRSTE/zTCVOydm25HackxyEEmTeiGNetIqfwXJCHM445zk/bR6Zg0hWpaR4
 AQ9nKJfYqN6JVQk+rfHLPXNNf60xKQSwLmZeWA8fYyFsoo6+1ZUoJyTZp+BzSaAmc4Jz
 Qexqma5r5nf2qd/2bnTWdCteOhAJrLTzFCuPDRXpJ/Sz/m4d/IjmNLNufroHyOnwFYZo
 HC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708026166; x=1708630966;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3IzWdaKbNL5WPD1wSa/h4NlUNQr+Rrw8XqB/TKkg/Gw=;
 b=q5QojEV9+3A7/0DMCNYhplcJoMlEH7g/FNYMqZygo6CNZFl1TTPoDu+50ru0LZnqQF
 LCUuor9FHeXBLsN5zoD/hOMjMomWqf456pKZTdmR7yJHAw6CEnQVU+z8zWN3em4G9Hft
 GS2A9VC86AMOKEystmc9L+0RMXX0oyg2xguklkNbQErbFrv2L6PsHMqhkE83/7SCCEg+
 t6gunjD4OP8gWjXq+Hw3bfObEaily1ZIeOpYkyug3WO7kQBzo4Ca7mxdCvZimTuADc+X
 ztu+Hb9+3nU6iu+YWKWDkqGpYUb/mIjhYjFjP6Y30oMJ1YX3nNU3BemaGaRID5uw6l99
 d3EQ==
X-Gm-Message-State: AOJu0YyMorgdVfedY/OujkEAuk+sEWQwfnxOoDF/B6Lvg+yWvBHmG4S6
 fVvgs45ohWuuFt2aMvI6APMZaDOcp864fNIXdSTpgKHboYueGbO4ueAie44OKNc=
X-Google-Smtp-Source: AGHT+IGRLxVYc11uR3Es8c+pfKzqFZadQXwNxcK0bg782/NNJx+y8gUuvyE1q8lpYIpY6Ris3Ylupg==
X-Received: by 2002:a17:90a:c394:b0:299:2cba:7588 with SMTP id
 h20-20020a17090ac39400b002992cba7588mr696265pjt.1.1708026166523; 
 Thu, 15 Feb 2024 11:42:46 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 qc16-20020a17090b289000b002992ba5b9a3sm375403pjb.45.2024.02.15.11.42.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 11:42:46 -0800 (PST)
Message-ID: <eed2094c-32f9-400d-951a-120c06bb58f9@linaro.org>
Date: Thu, 15 Feb 2024 09:42:43 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: BHRB avoid using host pointer in translated
 code
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Glenn Miles <milesg@linux.vnet.ibm.com>
References: <20240215171512.800892-1-npiggin@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240215171512.800892-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/15/24 07:15, Nicholas Piggin wrote:
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 731dd8df35..3541cd83cd 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -724,7 +724,7 @@ static const VMStateDescription vmstate_bhrb = {
>       .minimum_version_id = 1,
>       .needed = bhrb_needed,
>       .fields = (VMStateField[]) {
> -        VMSTATE_UINTTL(env.bhrb_offset, PowerPCCPU),
> +        VMSTATE_UINT32(env.bhrb_offset, PowerPCCPU),

This requires a version bump.

> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 81afc892de..05f0f1ac52 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4167,21 +4167,24 @@ static void gen_rvwinkle(DisasContext *ctx)
>   #endif /* defined(CONFIG_USER_ONLY) */
>   }
>   
> -static inline TCGv gen_write_bhrb(TCGv base, TCGv offset, TCGv mask, TCGv value)
> +static TCGv_i32 gen_write_bhrb(TCGv_i32 offset, TCGv_i32 mask, TCGv_i64 value)
>   {
> -    TCGv tmp = tcg_temp_new();
> +    TCGv_ptr ptr = tcg_temp_new_ptr();
> +    TCGv_i32 tmp = tcg_temp_new_i32();
>   
> -    /* add base and offset to get address of bhrb entry */
> -    tcg_gen_add_tl(tmp, base, offset);
> +    /* add base and offset to tcg_env to get address of bhrb entry */
> +    tcg_gen_addi_i32(tmp, offset, offsetof(CPUPPCState, bhrb));
> +    tcg_gen_ext_i32_ptr(ptr, tmp);
> +    tcg_gen_add_ptr(ptr, ptr, tcg_env);
>   
>       /* store value into bhrb at bhrb_offset */
> -    tcg_gen_st_i64(value, (TCGv_ptr)tmp, 0);
> +    tcg_gen_st_i64(value, ptr, 0);

Better to add the constant with the store offset.

   tcg_gen_ext_i32_ptr(ptr, offset);
   tcg_gen_add_ptr(ptr, ptr, tcg_env);
   tcg_gen_st_i64(value, ptr, offsetof(bhrb));


r~


