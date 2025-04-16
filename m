Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD28C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:10:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5890-0005FR-PI; Wed, 16 Apr 2025 15:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u588z-0005FF-GS
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:09:57 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u588x-000511-TN
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:09:57 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736aaeed234so6006046b3a.0
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744830594; x=1745435394; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g0uzB7mI7nFtYqpQychyxSlWGbi2IAKJXwShVzxeScE=;
 b=TAbHtODJgPvnWegfOqm1e8HZibvsWy9wC1UpPewestAqAnal4i/G6h2a4xfr/pSIYU
 r3jP7Tiji1oCFGwZ3I+nfK8b1Kll11BVwyEjWYe0uIQw6Fwro1p5pNB8Hzs806ME4K3v
 XotNk3yLqSCWdCreWh4ynrXvGAhA3pP9ebwKotONWSek2zZLyJDuHRq+ZNFNSmhjVSqL
 7Qy9SbsMmi5lXYmsah+9UKGYqnlqjED/jAeAufUJS17qTb+edTNuaUDKalMV4l/ovicg
 dUYURnE3ROnGS2xqSSkuBGrbOFfyeqOvi7lQgq/VtXSC9zzyINcxDC/bJbeKudFwDj4i
 PHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744830594; x=1745435394;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g0uzB7mI7nFtYqpQychyxSlWGbi2IAKJXwShVzxeScE=;
 b=M2Hh+ZO2uomq66m17rQLJB5D1nlm5iOOtqh/wO12IBo2HBETjKZpc1+s57T/EAQv8c
 Y3sSs6yND2b2Hrp5ppAK8wbXpr/iNQB7EVP94zUcEO71vRbwxhi4IYeo/aEM1hc5TDlf
 Bm4u9CfcfSvyWQm3sV2msza9WMATOkb0b3yRpSRWuHp8/T2YghH3Y7UEXrM0U85V89TZ
 24HYHvAcJMEOm4UfvQjvRaeazWRFm/kxwT51/ORQw79AESwPiFHwcwpEvt1n9kAqJdq7
 cpXBWAmvai0ju8NKjvlFY3eGjimR4Tjx+FAltHGiRCY1FMbTq1elofC4EJ66E7TKBeCy
 vsUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWspe36i8b3Tp3v0lKS6Fgy/epbOVMbrRPLmDSSw0i40SVvfZb9zsWAUKAbjM+ENOUssGbXN7ftsUQ1@nongnu.org
X-Gm-Message-State: AOJu0YzYWHnGN0CqlqkmhPwWs4JD8D//7d0D+isVgR7pwrC26bR+djrN
 8jZ2PFbJKh6rhV6b9bVqoJDlOe6S8wHTD6lJmnm9nEzyBWxad9h91Ly8kvOeYV8+PFkde3WqeOu
 A
X-Gm-Gg: ASbGncvcFMADv1/Oh8IT4ABsLkIZ91PL1WUUeB8sJOA3hyDi3NAwnAzcH/ozLJ0X9x6
 Lw+quy/2Pny30EBfoZaOHNre9IspAyAFMEeoayrO8OBsSDBJn4UX074v5tQbd3Bc4mQyiig7oI9
 jFstHj5x/zD3Ai9WooK/HRhhEbQzVcga087eBF5Po+2oHlP4vlSfSy23VZCDXqC89urPT/oODH3
 AiCZ7QWrUGZbAR+AxEx/2kFbv4UdzSuPGTAgomTBZOy0yMf1yalAFZBAoZGgKWYJvqVr8UbVajo
 gjSpmnupo11NeI6EkkI/AXEktBMLwo8Nxr7DXVxXUYg/pE/QOOWVGw==
X-Google-Smtp-Source: AGHT+IEP/AsDKW/r+c8LPZkCBuO/jyUN+KoJSzNjJvFgmfgE/Y4gI1I2FyB89Uubis/8tqh0uTzICg==
X-Received: by 2002:a05:6a00:279f:b0:739:50c0:b3fe with SMTP id
 d2e1a72fcca58-73c266e6567mr5192197b3a.8.1744830594161; 
 Wed, 16 Apr 2025 12:09:54 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f1065sm11117838b3a.106.2025.04.16.12.09.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:09:53 -0700 (PDT)
Message-ID: <db5897e4-ce0a-4ebe-9192-a7af611ff50a@linaro.org>
Date: Wed, 16 Apr 2025 12:09:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 132/163] target/tricore: Use tcg_gen_addcio_i32 for
 gen_addc_CC
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-133-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-133-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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
>   target/tricore/translate.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/target/tricore/translate.c b/target/tricore/translate.c
> index 5ae685cc5b..2036ac2cd6 100644
> --- a/target/tricore/translate.c
> +++ b/target/tricore/translate.c
> @@ -1345,15 +1345,11 @@ static inline void gen_addi_CC(TCGv ret, TCGv r1, int32_t con)
>   
>   static inline void gen_addc_CC(TCGv ret, TCGv r1, TCGv r2)
>   {
> -    TCGv carry = tcg_temp_new_i32();
> -    TCGv t0    = tcg_temp_new_i32();
> +    TCGv t0     = tcg_temp_new_i32();
>       TCGv result = tcg_temp_new_i32();
>   
> -    tcg_gen_movi_tl(t0, 0);
> -    tcg_gen_setcondi_tl(TCG_COND_NE, carry, cpu_PSW_C, 0);
>       /* Addition, carry and set C/V/SV bits */
> -    tcg_gen_add2_i32(result, cpu_PSW_C, r1, t0, carry, t0);
> -    tcg_gen_add2_i32(result, cpu_PSW_C, result, cpu_PSW_C, r2, t0);
> +    tcg_gen_addcio_i32(result, cpu_PSW_C, r1, r2, cpu_PSW_C);
>       /* calc V bit */
>       tcg_gen_xor_tl(cpu_PSW_V, result, r1);
>       tcg_gen_xor_tl(t0, r1, r2);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


