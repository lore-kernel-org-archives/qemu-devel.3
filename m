Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4060C369C5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 18:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u57wv-0008R0-RE; Wed, 16 Apr 2025 14:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u57wr-0008PJ-1f
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 14:57:26 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u57wp-00036D-31
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 14:57:24 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22423adf751so276665ad.2
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 11:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744829838; x=1745434638; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pF50KJIbCMiAAMwKnzA1i9qQ8ccRc4K4y7sUwVB0ygA=;
 b=YniA6kYdhlBQl9FISrd4g0CrnAK6lC+Ze9yGu09OyPtYyS63dnen8xQhzGVfj5q1RP
 byxMTAXlbg9a8EI7OXpzaxIEEPRLhF29GFt3BqrYku3NZPZy1g4ETp3xFQr/iv1b5TGW
 wWkoXBoqh9PF4ocYbyVFsZqRHqvgoD1qO1ELxd1WKSb+OD7yVtsN6QzKxDJdMhN5hVa8
 eafvAxmk4UiLP69zAM0TNoxbLoV15DzQGITcANTn2P03VjqpZ+3JOKmYvbNz/35ILj4w
 iD3fQXr826m0WzN22uoMDvDNKSTl6bwR1cU9YFqdsiCTTlGBC/LNj06d4zvlqzSBC86R
 rbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744829838; x=1745434638;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pF50KJIbCMiAAMwKnzA1i9qQ8ccRc4K4y7sUwVB0ygA=;
 b=Yz+2aEgewF/Zm8NIR58B53zmLrO6h2noK2PyRR7j8glNGdlRw9JmFrirjGFErWupTS
 APnMSOwwYahpw0fwYWVdlwyak0veCX7lf4qP7CW1Vk5whgsaySEiQ6wklJg5/OqDGWum
 jAvWPpBTyvfwNtsEUiJz9uWYdZrzeFBoSRgpN272AEGTpPNcO0wEFlO/V7DxsiOE2CFo
 QjP+rUlVLugaz+1lJ+VknhEUyB5yqizpKK3XJHUHAHyux6NNeaq/uZrT2UaH12fMJgoa
 VchaDhpJ2Kn1EvojKsVqnUuey7zp9hS7HVS64lfJ5pndUE2Pu9BZBW5i5LoY0GVxx+z7
 LJug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNABGrMUBI/BvgwxSKVUCmQPbZmNJYoU5s29TLig9fVUZoX672uEYHwl18tdGKkWciORcxo8cJn940@nongnu.org
X-Gm-Message-State: AOJu0YyJ21jb8EOxlFcZVMFsSqeQ7DyliV++MMKmCd5iQ3d357Sod+Tu
 ih4EONho8XRrxi43ZoRUsY7tdjJZACZOdWkgbXN08PTFZreYoC+KTt24Ix3dQgw=
X-Gm-Gg: ASbGnctaoSuZPfe0KlQvaUN3eMR3/+MXDhlKz1vovH/SAbMyCQxNwAcrsqknHCX/cUO
 SufFe3a+BeMCUYPCuehXpfqJycm2/lIkrGSGuf7rwxAaAvj+Wf5EoZ2nNOYeYrKdYqR5QjYmObL
 R2efzGWPHE3/1xa4CFGaFT1XJzPtvH/tISkRD+cY+2JyxngmytCHxHeo3c6YD0SczhxJgpTJfGL
 KOvSnhsxRZEZ6kyXFYe9FOiKCV80P07hcR9UY+PPiL3W5Z8i4NQo2fsD8Z5ap1yZ2aaHo3SNzDN
 SbXHteJcHyJBC58+lBznyrc6A8IqV+6fN90mI3eRkbastlH4KnJZYg==
X-Google-Smtp-Source: AGHT+IEAmX+tBmQ4B/6qc4ue2xzD7f6QESlswNWFes6r5EHOOCEG7wJ2f1EjeTze/dMuEQd5rcbC4A==
X-Received: by 2002:a17:903:2383:b0:229:1717:8826 with SMTP id
 d9443c01a7336-22c358fd48bmr50876365ad.28.1744829838079; 
 Wed, 16 Apr 2025 11:57:18 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33fe6aa0sm17940675ad.222.2025.04.16.11.57.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 11:57:17 -0700 (PDT)
Message-ID: <6f528f8b-f03c-41be-9085-ab6cba94a6fd@linaro.org>
Date: Wed, 16 Apr 2025 11:57:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 118/163] tcg: Use sub carry opcodes to expand sub2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-119-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-119-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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
>   tcg/tcg-op.c | 29 +++++++++++++++++++++++++++--
>   1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index f17ec658fb..447b0ebacd 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -1126,7 +1126,13 @@ void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
>   void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
>                         TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
>   {
> -    if (TCG_TARGET_HAS_sub2_i32) {
> +    if (tcg_op_supported(INDEX_op_subbi, TCG_TYPE_I32, 0)) {
> +        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
> +        tcg_gen_op3_i32(INDEX_op_subbo, t0, al, bl);
> +        tcg_gen_op3_i32(INDEX_op_subbi, rh, ah, bh);
> +        tcg_gen_mov_i32(rl, t0);
> +        tcg_temp_free_i32(t0);
> +    } else if (TCG_TARGET_HAS_sub2_i32) {
>           tcg_gen_op6_i32(INDEX_op_sub2_i32, rl, rh, al, ah, bl, bh);
>       } else {
>           TCGv_i32 t0 = tcg_temp_ebb_new_i32();
> @@ -2865,7 +2871,26 @@ void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
>   void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
>                         TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
>   {
> -    if (TCG_TARGET_HAS_sub2_i64) {
> +    if (tcg_op_supported(INDEX_op_subbi, TCG_TYPE_REG, 0)) {
> +        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
> +
> +        if (TCG_TARGET_REG_BITS == 32) {
> +            tcg_gen_op3_i32(INDEX_op_subbo, TCGV_LOW(t0),
> +                            TCGV_LOW(al), TCGV_LOW(bl));
> +            tcg_gen_op3_i32(INDEX_op_subbio, TCGV_HIGH(t0),
> +                            TCGV_HIGH(al), TCGV_HIGH(bl));
> +            tcg_gen_op3_i32(INDEX_op_subbio, TCGV_LOW(rh),
> +                            TCGV_LOW(ah), TCGV_LOW(bh));
> +            tcg_gen_op3_i32(INDEX_op_subbi, TCGV_HIGH(rh),
> +                            TCGV_HIGH(ah), TCGV_HIGH(bh));
> +        } else {
> +            tcg_gen_op3_i64(INDEX_op_subbo, t0, al, bl);
> +            tcg_gen_op3_i64(INDEX_op_subbi, rh, ah, bh);
> +        }
> +
> +        tcg_gen_mov_i64(rl, t0);
> +        tcg_temp_free_i64(t0);
> +    } else if (TCG_TARGET_HAS_sub2_i64) {
>           tcg_gen_op6_i64(INDEX_op_sub2_i64, rl, rh, al, ah, bl, bh);
>       } else {
>           TCGv_i64 t0 = tcg_temp_ebb_new_i64();

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


