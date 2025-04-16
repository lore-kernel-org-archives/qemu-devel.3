Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28241C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 18:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u57wu-0008Pq-20; Wed, 16 Apr 2025 14:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u57wf-0008Mm-FS
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 14:57:14 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u57wd-000354-Pp
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 14:57:13 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-227b828de00so238465ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 11:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744829829; x=1745434629; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cAUNlIED6s0k2AJAk2AEh7JIynTcZe4H0ElS3DeBSyA=;
 b=l26A7iArilWYiwnEqj3m7RPYn32h5KdTuLxXrvvEPpYnY9WpvEVq//IRBdYz6zUHc7
 BGtKnWnVDUZJfWbchzHHWSspN7m+5HEAMGQLfilgqqwCxxc+eJqTJRjSRbTUVrIrml8g
 gTOpxUg5b8RM3L3lLqsh0NVDCC3vEYK/Efp99Zy923xTGCWexg28NrmVugAb3Ze2hO8P
 hNW8PvwuVbPgIXgKVWulSI8Ez0gfO8r2EQmUxD3182IeYg6FJi0CUOGjK1529UlqQvlO
 pYLObWBI92cY0Nq/T1AFp4nZqZWOXEWsU8DqkvUETlH7O+OfNn6wtL0euVG6LXKTXbXX
 vh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744829829; x=1745434629;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cAUNlIED6s0k2AJAk2AEh7JIynTcZe4H0ElS3DeBSyA=;
 b=hDGsK5lAjzs6J01xhOZaaFXZRMLxoNLwWhK/E1Uso5ZnO8SgUpIBWQAiavUxTlx8zP
 RjmgOfNcPiOhW8vsXDM+MHWC701OCXJWN45phSMDVNIjiGaNzJs5P5yQm/zpMf7oMj/C
 BPqmT/Sxu0sqsvtTy5/A16ctTetH4xtyQSVbbuzseXP/F6mZEcP3ZEbBR+dhu6ZFtCFg
 xozNBjXfJJ5rkKhzevglKr4DVnfJe9w9s3/uS/ERoPVpLY6oGNwNALgpu0b8L4UKDPq3
 t1jCLpT/Lv7jgf+6zKg7WLite0fRUykXlxzWMJ6kTI8XIuExM2e05u711cjfPL164upv
 uALA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7+QPwad9o957p6Caj3UZsTgSLvbFcrX9SGPBf50s7xeJhF0PVTNf+2wwooLFAieqlBnjUXIWFzetK@nongnu.org
X-Gm-Message-State: AOJu0YyGRrJd+kRiGla6+63k8ntW22C33IljLck0piyEcZ/pgeVaoZZt
 Yun3AEQAR4+/7Eq5poj7ct1eDAKNIxg4Ehi4/qPSiNcSBcaDgjnqRPdG+cCcWIpnNyAoOgYEFjT
 y
X-Gm-Gg: ASbGncv9O6nQ0mcn/UWNLQUoiM00OsJVR/+9pXnjdJ3GxSPUTGYBiXNlJpoK6esCCqP
 qkj3QQcy3v/5yTJm6euhAOE38gIHjk5NbNX8XEN3f/IkEUFLNZ91YgUWRO/C3nId0AZzJRnyt5S
 6BewDAg5CnLzW6TLZ2IEWEwnILK7eRXGC3w4pU2AvoTmuuhI5uz9o2hpC7t37QwNG2I+9l5uwjX
 hkMPdksnK6EVkoNxaCnvd/FuKu2tK7gqa4xqpXK7Q2Q/10rMXoRB0MR6NuNntMdJjoM2HMRagGI
 E+VX7KpHR7kCeaykUZYpRUeQUfvqb6iXxw6UIXlmlQsWhdwAKodNOA==
X-Google-Smtp-Source: AGHT+IHskOXS9q7kEC9MhwYdK31/dc6mLtGOvG8q7B6/ZUuExBJt1YZrLI0JQaHeWAcFbjCt6VvDng==
X-Received: by 2002:a17:902:e5c9:b0:220:e156:63e0 with SMTP id
 d9443c01a7336-22c358c2a16mr34117065ad.8.1744829829592; 
 Wed, 16 Apr 2025 11:57:09 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33ef0e83sm17871635ad.35.2025.04.16.11.57.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 11:57:09 -0700 (PDT)
Message-ID: <4f2c5ebb-479e-49bb-9f34-0a4cbf464f5b@linaro.org>
Date: Wed, 16 Apr 2025 11:57:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 117/163] tcg: Use add carry opcodes to expand add2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-118-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-118-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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
> index 127338b994..f17ec658fb 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -1102,7 +1102,13 @@ void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
>   void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
>                         TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
>   {
> -    if (TCG_TARGET_HAS_add2_i32) {
> +    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I32, 0)) {
> +        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
> +        tcg_gen_op3_i32(INDEX_op_addco, t0, al, bl);
> +        tcg_gen_op3_i32(INDEX_op_addci, rh, ah, bh);
> +        tcg_gen_mov_i32(rl, t0);
> +        tcg_temp_free_i32(t0);
> +    } else if (TCG_TARGET_HAS_add2_i32) {
>           tcg_gen_op6_i32(INDEX_op_add2_i32, rl, rh, al, ah, bl, bh);
>       } else {
>           TCGv_i32 t0 = tcg_temp_ebb_new_i32();
> @@ -2822,7 +2828,26 @@ void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
>   void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
>                         TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
>   {
> -    if (TCG_TARGET_HAS_add2_i64) {
> +    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_REG, 0)) {
> +        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
> +
> +        if (TCG_TARGET_REG_BITS == 32) {
> +            tcg_gen_op3_i32(INDEX_op_addco, TCGV_LOW(t0),
> +                            TCGV_LOW(al), TCGV_LOW(bl));
> +            tcg_gen_op3_i32(INDEX_op_addcio, TCGV_HIGH(t0),
> +                            TCGV_HIGH(al), TCGV_HIGH(bl));
> +            tcg_gen_op3_i32(INDEX_op_addcio, TCGV_LOW(rh),
> +                            TCGV_LOW(ah), TCGV_LOW(bh));
> +            tcg_gen_op3_i32(INDEX_op_addci, TCGV_HIGH(rh),
> +                            TCGV_HIGH(ah), TCGV_HIGH(bh));
> +        } else {
> +            tcg_gen_op3_i64(INDEX_op_addco, t0, al, bl);
> +            tcg_gen_op3_i64(INDEX_op_addci, rh, ah, bh);
> +        }
> +
> +        tcg_gen_mov_i64(rl, t0);
> +        tcg_temp_free_i64(t0);
> +    } else if (TCG_TARGET_HAS_add2_i64) {
>           tcg_gen_op6_i64(INDEX_op_add2_i64, rl, rh, al, ah, bl, bh);
>       } else {
>           TCGv_i64 t0 = tcg_temp_ebb_new_i64();

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


