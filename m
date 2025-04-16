Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCE9C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u58EO-0003mC-Gq; Wed, 16 Apr 2025 15:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58EH-0003cH-CD
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:15:29 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58EF-0005wh-12
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:15:24 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-73972a54919so6221905b3a.3
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744830921; x=1745435721; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fQ/of8aPJYLDLababTuNqc7Nc0WYlun/866O7ViEG9w=;
 b=uyP/vpnHk4XofG5qw+vQIuVLfo9RS4ASxEzJh8O/BrAyGdDxRjE5e0vtLRu+FtK8Bd
 sY+WKO6vD1A5khBkiYOVD+R1vaSr610xppPUhy74cS8PaFAvl3ES46wkbKukBohEKefv
 RdGCCVadDZpsRFUh0pGDIgtGLJ+d8A5dfUVbM5mrT0YwJAzVTkdzpmZjc+Xy444rhvpG
 hlKqhkebeb123l1/ffzbW4RjGOC4c+l9zRkwP4ix89t1Vy5SboxLm4UFlovjsIZWXVGr
 YRNMUApe0UP4GxGPVqS9hFs21ZD6TBcMp8BhmkatULBq8E5k676hH7UxCYWT8u+nchw1
 UFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744830921; x=1745435721;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fQ/of8aPJYLDLababTuNqc7Nc0WYlun/866O7ViEG9w=;
 b=sgV5S5/wkKTwYoq8alDx6Rk/FrQDR8wiDmCaaSkSuqAZAmBqBqVZT9t/78+2A2/Tvc
 /c7LUYi+0CSzbWRgbFC2xJp1e0Dl7PjiZgeq4O11LNe2QQTNJT0AaZJ6h7omJ03Kouw5
 xmqbqLLLgSSV/OPx1iwQwBQEhW/huUJs09jxpjol775eQn147gGmB0N77/T3kQ2bEFh/
 BAXAxihpkDJvx22hmmqF81J10rVtDnH1be3OZimailzBraZR7Xa4sI2SYfEZPLPQkytU
 0VkLpxVHcjiYWSkVkCIe1AvmO/ZJ0+EKqwW9xJSQCrQnlZz1oWS0UTbjC0uei6EAtd3E
 SxYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcV96kmh88ZT6ZPi7pM2lM0AWir8ug7KnWzaCsFpe5/ItTTohwGPxvpo6n3dz+TzcliGL5kW0cIkLP@nongnu.org
X-Gm-Message-State: AOJu0YyFAXtxl6RYjqOBnwRA2wnbrzz1WXs473I4IiwkHxfiXw2lnPK8
 4M7MHUR0SOjt7J9/vY7oCjiQ5+Q6M+4AtdQqvTdNBKCv1mPvcKqTm251Lkdbmlc=
X-Gm-Gg: ASbGnctPfFfrHKs6TyUI8F9jhGi24YXsVSeBKJpbaF5FUc+QS1c3Jn6vATR3JXj3fhI
 khvzMGOKNlLY05huIhoTck1O7W9w0GLW0f4tYbYbS7bwdmJ5AFHm0zgjz/MHzf32d2uBxepdnMg
 vIm2SHXpjEdLVq4WWu7HyPUiFBxxkVZsTvIjgy/pvQRpqZU1ss5O9h1GK+TyzGSGuPCZhZkegor
 hfkaF3ImyfpiAgKFs0IC3f44Dj8/D64Ox2aPt4on+jDX2pkNyMsfbmgzhnZRqh2l9RFdparcF5B
 P8+zUR5poNR9cjLTcBSYPJk6ajLEiwRwkI5k9LRr8da5MTtEaUB0sQ==
X-Google-Smtp-Source: AGHT+IE/i+8LrmGS+c9pnEU8leGqMRYmdbX5qzoG0woSTSdgNVwSaP7w1l91K8cvAhfT5AMJU6FPEw==
X-Received: by 2002:a05:6a00:279f:b0:739:50c0:b3fe with SMTP id
 d2e1a72fcca58-73c266e6567mr5220093b3a.8.1744830921262; 
 Wed, 16 Apr 2025 12:15:21 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e32dsm10816990b3a.150.2025.04.16.12.15.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:15:20 -0700 (PDT)
Message-ID: <2c81224e-e692-4506-b3dc-e624d1c07854@linaro.org>
Date: Wed, 16 Apr 2025 12:15:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 138/163] tcg/ppc: Remove support for add2/sub2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-139-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-139-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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
> We have replaced this with support for add/sub carry.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/ppc/tcg-target-con-set.h |  2 --
>   tcg/ppc/tcg-target-has.h     | 11 +++----
>   tcg/ppc/tcg-target.c.inc     | 60 ------------------------------------
>   3 files changed, 4 insertions(+), 69 deletions(-)
> 
> diff --git a/tcg/ppc/tcg-target-con-set.h b/tcg/ppc/tcg-target-con-set.h
> index 9ea26c40ae..da7a383bff 100644
> --- a/tcg/ppc/tcg-target-con-set.h
> +++ b/tcg/ppc/tcg-target-con-set.h
> @@ -41,5 +41,3 @@ C_O1_I4(r, r, r, rU, rC)
>   C_O2_I1(r, r, r)
>   C_N1O1_I1(o, m, r)
>   C_O2_I2(r, r, r, r)
> -C_O2_I4(r, r, rI, rZM, r, r)
> -C_O2_I4(r, r, r, r, rI, rZM)
> diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
> index 8d832ce99c..4dda668706 100644
> --- a/tcg/ppc/tcg-target-has.h
> +++ b/tcg/ppc/tcg-target-has.h
> @@ -18,16 +18,13 @@
>   
>   /* optional instructions */
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
> -
> -#if TCG_TARGET_REG_BITS == 64
>   #define TCG_TARGET_HAS_add2_i32         0
>   #define TCG_TARGET_HAS_sub2_i32         0
> +
> +#if TCG_TARGET_REG_BITS == 64
>   #define TCG_TARGET_HAS_extr_i64_i32     0
> -#define TCG_TARGET_HAS_add2_i64         1
> -#define TCG_TARGET_HAS_sub2_i64         1
> -#else
> -#define TCG_TARGET_HAS_add2_i32         1
> -#define TCG_TARGET_HAS_sub2_i32         1
> +#define TCG_TARGET_HAS_add2_i64         0
> +#define TCG_TARGET_HAS_sub2_i64         0
>   #endif
>   
>   #define TCG_TARGET_HAS_qemu_ldst_i128   \
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 0b151db0e4..91df9610ec 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -3663,8 +3663,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
>                          const int const_args[TCG_MAX_OP_ARGS])
>   {
> -    TCGArg a0, a1;
> -
>       switch (opc) {
>       case INDEX_op_goto_ptr:
>           tcg_out32(s, MTSPR | RS(args[0]) | CTR);
> @@ -3760,57 +3758,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
>           break;
>   
> -#if TCG_TARGET_REG_BITS == 64
> -    case INDEX_op_add2_i64:
> -#else
> -    case INDEX_op_add2_i32:
> -#endif
> -        /* Note that the CA bit is defined based on the word size of the
> -           environment.  So in 64-bit mode it's always carry-out of bit 63.
> -           The fallback code using deposit works just as well for 32-bit.  */
> -        a0 = args[0], a1 = args[1];
> -        if (a0 == args[3] || (!const_args[5] && a0 == args[5])) {
> -            a0 = TCG_REG_R0;
> -        }
> -        if (const_args[4]) {
> -            tcg_out32(s, ADDIC | TAI(a0, args[2], args[4]));
> -        } else {
> -            tcg_out32(s, ADDC | TAB(a0, args[2], args[4]));
> -        }
> -        if (const_args[5]) {
> -            tcg_out32(s, (args[5] ? ADDME : ADDZE) | RT(a1) | RA(args[3]));
> -        } else {
> -            tcg_out32(s, ADDE | TAB(a1, args[3], args[5]));
> -        }
> -        if (a0 != args[0]) {
> -            tcg_out_mov(s, TCG_TYPE_REG, args[0], a0);
> -        }
> -        break;
> -
> -#if TCG_TARGET_REG_BITS == 64
> -    case INDEX_op_sub2_i64:
> -#else
> -    case INDEX_op_sub2_i32:
> -#endif
> -        a0 = args[0], a1 = args[1];
> -        if (a0 == args[5] || (!const_args[3] && a0 == args[3])) {
> -            a0 = TCG_REG_R0;
> -        }
> -        if (const_args[2]) {
> -            tcg_out32(s, SUBFIC | TAI(a0, args[4], args[2]));
> -        } else {
> -            tcg_out32(s, SUBFC | TAB(a0, args[4], args[2]));
> -        }
> -        if (const_args[3]) {
> -            tcg_out32(s, (args[3] ? SUBFME : SUBFZE) | RT(a1) | RA(args[5]));
> -        } else {
> -            tcg_out32(s, SUBFE | TAB(a1, args[5], args[3]));
> -        }
> -        if (a0 != args[0]) {
> -            tcg_out_mov(s, TCG_TYPE_REG, args[0], a0);
> -        }
> -        break;
> -
>       case INDEX_op_mb:
>           tcg_out_mb(s, args[0]);
>           break;
> @@ -4456,13 +4403,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_st_i64:
>           return C_O0_I2(r, r);
>   
> -    case INDEX_op_add2_i64:
> -    case INDEX_op_add2_i32:
> -        return C_O2_I4(r, r, r, r, rI, rZM);
> -    case INDEX_op_sub2_i64:
> -    case INDEX_op_sub2_i32:
> -        return C_O2_I4(r, r, rI, rZM, r, r);
> -
>       case INDEX_op_qemu_ld_i32:
>           return C_O1_I1(r, r);
>       case INDEX_op_qemu_ld_i64:

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


