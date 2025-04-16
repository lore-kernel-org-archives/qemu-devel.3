Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1675C369C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 18:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u57xw-0002mi-C2; Wed, 16 Apr 2025 14:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u57xs-0002X7-Jx
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 14:58:28 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u57xq-0003FQ-GE
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 14:58:28 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-73bb647eb23so6571661b3a.0
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 11:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744829905; x=1745434705; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2yxwcXVcoAkXz2mi3taqjimZfvE7krX4ycjybWyMA20=;
 b=fLqUpJZwRJ92sAs0n4mfFtOPUKggXYDgP6fU68FcyIF+D3RGVIKDS01pRVAKaKZV+V
 pJflVK2G7i1aSw+9mU03EY2xpxtimraE9lkyD1z+Wb9WbPcuDx5CRZJaRfNfw8OAuDiA
 kYLmQM0XePRC4xZ4dhClA7BT4t7GpGDYncvgtueceYtXip/JHfovJ41WUogdCU0bn9HR
 yGXJ7l3VeBViX7HG3xs9xLsnBRCdXAmkeWK+RJegn1Tkl70ln3pV8U8TcOgJoOyZS2SD
 5KkpKbmMD98JPPexDOyXRbNzuWrAWldv8TMscZweW7MJ64Vd0+B00OoWXkJBT2Ll6aL7
 dTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744829905; x=1745434705;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2yxwcXVcoAkXz2mi3taqjimZfvE7krX4ycjybWyMA20=;
 b=lQ2efOFpK+AELTKvbDm8Y1EY5zvQtIIJODRDa91R4wTKLihz3JXBam7C6z06R+cWUL
 WSYqVWsEqVJNxohtBak3lUjXhVaMjGef3JlPzxhHvvqfeoALxl5f6xhauBBb55ILhKr+
 VxbPhtUBsOpWQlTsuLTTfflGrj3u8I0ITPBvQyHvz9tnf8QTvoUkve9KaGckJxCBhMrK
 pvIG43qUspUepH5v8QVSAKdZIe2ctswY+Xfvd/SpdWyzCjb3CM6djayIahfS1lIk6tez
 DTpl4v0YlcPTrVx57D2MXXHkZE7UzyArqotjHlx9Ry0e8pROeRDhvB5NhKv3YDseOy1X
 JWDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVncpRG38sc41lSYqzxSZzNLQSvXLKRwY7ELeixDy3cG02OLscANl1JtrAY9YbVd6VKWm6UM+6Sgj6E@nongnu.org
X-Gm-Message-State: AOJu0YzOMGvDoP3Bo6NRDMvHfZFVTAHvGR5b2beTy+W1uAYK+DvjBR7T
 af7XXqlZpIazP+O55dY9AElyOwyuKW70t3SOsQPH66hI9YDgMdKKWMUtX1VuJaFQJfADzF/5H71
 m
X-Gm-Gg: ASbGncsn2sideKWrB/VHS2JAXVm+sYwc+YBS3HnQPEqvi8dzThNmbjKHLmd1VgHan0G
 rFyWHeCXAyokvRv8NMmiHosfx4YYQXHDbuP0r1OIrPtRpFldFV63AFsqvK2XqtboE8k/KjDL/4d
 Ip2debpnYeXLbPZxUsgiFcc+HgRqzLgloPmaLCoheNt67MVEM29B4QkMPoxxXxbfRbaDlpPVpgD
 4B68wUX9wllHhWyHhttgHhu45PWCifaobsJ9ulN1pEP5F+9Y3X1LV8O3yk2brw1uxRPohyZtQLL
 YgbbMnDiWSGNt/stNsaxILsRLpH1p9AFQ5p/fjdPPr5OYMeUpYtLsA==
X-Google-Smtp-Source: AGHT+IFUi9Wx0+keKiZLSHwUYeUwvkbL+0owN8Ud/95C2Hhh3mpLDUoirLpg2q1zFNGvjUxxAIyPHg==
X-Received: by 2002:a05:6a00:1485:b0:730:9946:5973 with SMTP id
 d2e1a72fcca58-73c266b993dmr3920917b3a.5.1744829904777; 
 Wed, 16 Apr 2025 11:58:24 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd2198d95sm11153682b3a.17.2025.04.16.11.58.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 11:58:24 -0700 (PDT)
Message-ID: <032b035e-cb83-4d2b-b67c-8f4dd9a511b4@linaro.org>
Date: Wed, 16 Apr 2025 11:58:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 121/163] tcg/i386: Remove support for add2/sub2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-122-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-122-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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
>   tcg/i386/tcg-target-con-set.h |  1 -
>   tcg/i386/tcg-target-has.h     |  8 ++++----
>   tcg/i386/tcg-target.c.inc     | 31 -------------------------------
>   3 files changed, 4 insertions(+), 36 deletions(-)
> 
> diff --git a/tcg/i386/tcg-target-con-set.h b/tcg/i386/tcg-target-con-set.h
> index 0ae9775944..85c93836bb 100644
> --- a/tcg/i386/tcg-target-con-set.h
> +++ b/tcg/i386/tcg-target-con-set.h
> @@ -57,4 +57,3 @@ C_O2_I1(r, r, L)
>   C_O2_I2(a, d, a, r)
>   C_O2_I2(r, r, L, L)
>   C_O2_I3(a, d, 0, 1, r)
> -C_N1_O1_I4(r, r, 0, 1, re, re)
> diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
> index 0328102c2a..a984a6af2e 100644
> --- a/tcg/i386/tcg-target-has.h
> +++ b/tcg/i386/tcg-target-has.h
> @@ -26,14 +26,14 @@
>   #define have_avx512vbmi2  ((cpuinfo & CPUINFO_AVX512VBMI2) && have_avx512vl)
>   
>   /* optional instructions */
> -#define TCG_TARGET_HAS_add2_i32         1
> -#define TCG_TARGET_HAS_sub2_i32         1
> +#define TCG_TARGET_HAS_add2_i32         0
> +#define TCG_TARGET_HAS_sub2_i32         0
>   
>   #if TCG_TARGET_REG_BITS == 64
>   /* Keep 32-bit values zero-extended in a register.  */
>   #define TCG_TARGET_HAS_extr_i64_i32     1
> -#define TCG_TARGET_HAS_add2_i64         1
> -#define TCG_TARGET_HAS_sub2_i64         1
> +#define TCG_TARGET_HAS_add2_i64         0
> +#define TCG_TARGET_HAS_sub2_i64         0
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
>   #else
>   #define TCG_TARGET_HAS_qemu_st8_i32     1
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index 52d3402f29..44f9afc0d6 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -3479,31 +3479,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_qemu_st(s, a0, a1, a2, args[3], TCG_TYPE_I128);
>           break;
>   
> -    OP_32_64(add2):
> -        if (const_args[4]) {
> -            tgen_arithi(s, ARITH_ADD + rexw, a0, args[4], 1);
> -        } else {
> -            tgen_arithr(s, ARITH_ADD + rexw, a0, args[4]);
> -        }
> -        if (const_args[5]) {
> -            tgen_arithi(s, ARITH_ADC + rexw, a1, args[5], 1);
> -        } else {
> -            tgen_arithr(s, ARITH_ADC + rexw, a1, args[5]);
> -        }
> -        break;
> -    OP_32_64(sub2):
> -        if (const_args[4]) {
> -            tgen_arithi(s, ARITH_SUB + rexw, a0, args[4], 1);
> -        } else {
> -            tgen_arithr(s, ARITH_SUB + rexw, a0, args[4]);
> -        }
> -        if (const_args[5]) {
> -            tgen_arithi(s, ARITH_SBB + rexw, a1, args[5], 1);
> -        } else {
> -            tgen_arithr(s, ARITH_SBB + rexw, a1, args[5]);
> -        }
> -        break;
> -
>   #if TCG_TARGET_REG_BITS == 64
>       case INDEX_op_ld32s_i64:
>           tcg_out_modrm_offset(s, OPC_MOVSLQ, a0, a1, a2);
> @@ -4109,12 +4084,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_st_i64:
>           return C_O0_I2(re, r);
>   
> -    case INDEX_op_add2_i32:
> -    case INDEX_op_add2_i64:
> -    case INDEX_op_sub2_i32:
> -    case INDEX_op_sub2_i64:
> -        return C_N1_O1_I4(r, r, 0, 1, re, re);
> -
>       case INDEX_op_qemu_ld_i32:
>           return C_O1_I1(r, L);
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


