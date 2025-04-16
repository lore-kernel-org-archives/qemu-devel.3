Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5F6C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u584Z-0000GM-Qm; Wed, 16 Apr 2025 15:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u584Y-0000Fy-44
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:05:22 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u584W-0004VO-Ce
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:05:21 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-225df540edcso12627465ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744830319; x=1745435119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sVh8eyr9RG3yKaunb9GPXO9K8sD6s7YTFnsmU2wSdWk=;
 b=GcndXQv3nyxOcLkBbUjG941u337fD97o0zL39OfMD1W9tcFQr9gdyZLp3TkOrH8PsB
 TOaXxCyHsFgJ13QQIWPvz/xFJ5SBF3wqYB2CKx1+oTCBZVCdA6Qp80pvSx9PL68kXvb0
 M/Bh+kjqaeJl2sa8LePyyYDoYs/e8YPN1+i7JsR7yXXaSqgxCqefMXczFU/j3KpERtlU
 gI1QJVOSbpk6Xyq1wdsGDi+irEVJmSIFyVzu7A4aBCizR872TD76tRRGb/apjIMbQzLM
 q/5LIqpvEU9g/XNm3ULo2GwFs5MdGg6m7gHr8+/A6vObq/K8xulQI0Ww1vukD9xFASBU
 FdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744830319; x=1745435119;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sVh8eyr9RG3yKaunb9GPXO9K8sD6s7YTFnsmU2wSdWk=;
 b=CJQP4KvB5vZCQ4B0ufpQoOTvr6tXrg1qU1HEg651kyAhHsp59NDK0yug0QAUA5pC/b
 8qfanIhTwuFmy2RYpT4MfsIdqQA/aKQ6STsSnD/0ImAEh/YdRGcDggNqO0mqZESs/SeJ
 WlGedT1IUsUmdW5e66yVWXMG5o76B/hWgHIDKuMUON4rj85p6RKoyETsOO8pHwFpx08r
 GiNXw8gVRaypmHTr2QskCmOVAGvpkBlya895coNB6KKxzZJWTyvLexjePTOaqF9cqNYl
 GEB/KyqNJvTVfBlPQ/Kd4XxspgEuyTSrEaH4cPkepOpcABnP/ajmrmF+ayoXvNwj05N1
 5shA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsFD6O88NmRiuLY/evCUT/fxDmD5cRLi8W/h/I3HbYiEuEoWRCcFKeWzCX+E+WAaTYpnOwmq7BtXv6@nongnu.org
X-Gm-Message-State: AOJu0YzFoAEyBadhe6FsAWLDByJMc1i2itLBdZDIvyKyk1dZ/msB3D+B
 vqGFuKDD5DcA5C3foGzbX6WS8bWOyKmiuQOss6Ymmz12fht55oA0AdJyiD4VKm4=
X-Gm-Gg: ASbGncutONVWn2kkzjhjBgVCbuV1qB/HUBN9u7yBTbbkibt3XnnIj4hiNlPYGAuLt0N
 LDDTrDtOTx9Pby9Q+Hpf+H09i5BmTTZJ5fDCqKIF4SNDUpIB+0FZ833Pp3fOyMLo+eJCaUAPC63
 x03lX65TgTCXOLbndWwMY7SDcNWv5xzMoXcQqRY/elfqF6I4M37Capbfg66Do5kNzD2kvlMF4sw
 TMQ4WGoHE5TJ0qU3UToFdwFuo8z/RXUpcJRpLc743kwByYUVZg0rMzIRdq+ivbm59MWCPSm8X3x
 FmrqlFwBfHD69dobvFYQQhewwHxMEwoG7GZf3kXXPeGPfEQKbFZDDA==
X-Google-Smtp-Source: AGHT+IFPF2Px+ZgOYJO7ZKxHXmfFgoONsel4G9Txj68yb5WHFACMTpgaKrvlkTHALPWs8WJjzdbHbQ==
X-Received: by 2002:a17:902:e54d:b0:215:58be:3349 with SMTP id
 d9443c01a7336-22c419c4c72mr450335ad.14.1744830318754; 
 Wed, 16 Apr 2025 12:05:18 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33fccafcsm17954975ad.205.2025.04.16.12.05.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:05:18 -0700 (PDT)
Message-ID: <b709e88b-7d14-4260-bc14-98594ede0842@linaro.org>
Date: Wed, 16 Apr 2025 12:05:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 125/163] target/hppa: Use tcg_gen_addcio_i64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-126-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-126-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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
> Use this in do_add, do_sub, and do_ds, all of which need
> add with carry-in and carry-out.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/translate.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 0d0d1bc99b..c92b09bae2 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -1208,10 +1208,10 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 orig_in1,
>           cb_msb = tcg_temp_new_i64();
>           cb = tcg_temp_new_i64();
>   
> -        tcg_gen_add2_i64(dest, cb_msb, in1, ctx->zero, in2, ctx->zero);
>           if (is_c) {
> -            tcg_gen_add2_i64(dest, cb_msb, dest, cb_msb,
> -                             get_psw_carry(ctx, d), ctx->zero);
> +            tcg_gen_addcio_i64(dest, cb_msb, in1, in2, get_psw_carry(ctx, d));
> +        } else {
> +            tcg_gen_add2_i64(dest, cb_msb, in1, ctx->zero, in2, ctx->zero);
>           }
>           tcg_gen_xor_i64(cb, in1, in2);
>           tcg_gen_xor_i64(cb, cb, dest);
> @@ -1307,9 +1307,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
>       if (is_b) {
>           /* DEST,C = IN1 + ~IN2 + C.  */
>           tcg_gen_not_i64(cb, in2);
> -        tcg_gen_add2_i64(dest, cb_msb, in1, ctx->zero,
> -                         get_psw_carry(ctx, d), ctx->zero);
> -        tcg_gen_add2_i64(dest, cb_msb, dest, cb_msb, cb, ctx->zero);
> +        tcg_gen_addcio_i64(dest, cb_msb, in1, cb, get_psw_carry(ctx, d));
>           tcg_gen_xor_i64(cb, cb, in1);
>           tcg_gen_xor_i64(cb, cb, dest);
>       } else {
> @@ -3007,9 +3005,7 @@ static bool trans_ds(DisasContext *ctx, arg_rrr_cf *a)
>       tcg_gen_xor_i64(add2, in2, addc);
>       tcg_gen_andi_i64(addc, addc, 1);
>   
> -    tcg_gen_add2_i64(dest, cpu_psw_cb_msb, add1, ctx->zero, add2, ctx->zero);
> -    tcg_gen_add2_i64(dest, cpu_psw_cb_msb, dest, cpu_psw_cb_msb,
> -                     addc, ctx->zero);
> +    tcg_gen_addcio_i64(dest, cpu_psw_cb_msb, add1, add2, addc);
>   
>       /* Write back the result register.  */
>       save_gpr(ctx, a->t, dest);
> @@ -3552,8 +3548,7 @@ static bool do_addb(DisasContext *ctx, unsigned r, TCGv_i64 in1,
>           TCGv_i64 cb = tcg_temp_new_i64();
>           TCGv_i64 cb_msb = tcg_temp_new_i64();
>   
> -        tcg_gen_movi_i64(cb_msb, 0);
> -        tcg_gen_add2_i64(dest, cb_msb, in1, cb_msb, in2, cb_msb);
> +        tcg_gen_add2_i64(dest, cb_msb, in1, ctx->zero, in2, ctx->zero);
>           tcg_gen_xor_i64(cb, in1, in2);
>           tcg_gen_xor_i64(cb, cb, dest);
>           cb_cond = get_carry(ctx, d, cb, cb_msb);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


