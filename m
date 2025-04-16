Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C09FC369C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u58DQ-00027y-I0; Wed, 16 Apr 2025 15:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58DN-0001zP-8b
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:14:29 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58DL-0005g2-Cl
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:14:28 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-736c1138ae5so7093735b3a.3
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744830865; x=1745435665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rNhVvlTqODBOKzhtKotqyia7sbVFOzs9lUKyX900nXI=;
 b=tMnOpYHI/ntdfuao3g7c+yZQ+RBIueJ38INlo1IhSM3aY9j5I0VviRKNpPYOVOoqHO
 QBTcymr2Tghzfy/odSefSQNR+rhOv9SJj7JWjfJUFTzcJ9i0D0aBKUi/GaRySgM5ZfqA
 4O954ATEaQbpLho81wdCGYHEUwBDMU3lY+P7XtsRjDrX8rccUm0Z1BRFPsCtFo8wDECG
 quvWCRd1q4K3ofgxJl5eL9zX3pW0ohqJqP4AUMBerR0JdJETXyTv3vZgkPV5G5ZFbX+X
 kn5qe21dAz3M6a7vPjdWNEuwtU4uNqtTe90iWpLQxLxkzdxrAPLcZpEvqBVWPbQEsmug
 DYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744830865; x=1745435665;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rNhVvlTqODBOKzhtKotqyia7sbVFOzs9lUKyX900nXI=;
 b=omXQX/0Gow3igwRCQz8ZxZGvdIssxbfM0I0urFEl2iZs+332sSw0xE0dJTFDCqZBKh
 Kmhp93DNXqJ8MQtjP41hHt1Kw22o48sy5Mg18S7O8ImVUPYafosMfAyzMNnGqy2sy/tJ
 U/u89TzXza3sGlsIvOByQiZd+TQGnxRb27aHjDA3rF6OwrqHCVGdOB+Hykq5yXH1um9E
 QE577TmwwXzbEnX805U82MN5nPD4Xmgi5k6sj0vH7piaFUTT0i7XoVKkwo2sK9OoRfHJ
 MyV6jsJRlswozu8ymUj+k6w5VMmIyHuhDNRAaTzsEPNjo97JSXHBciAvTbq9fw0jockj
 De3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+VnbD5prN/1+ZNfFN4B9VMtbRMV5kyxdKe7VAFL1a7QWi6xGEks7NNxHjGNq7efVtdh2c+0Ivu9hp@nongnu.org
X-Gm-Message-State: AOJu0YyuWGLY++/sZsy3J+GBuokVWlRXuP4g71AzeVjfHInSHmte94ej
 9e4mUhE6kPDHlpBLcLTps4rMsIsxmc3G+HV0MbfsoskG/bOhZta+2Lz8Hvc2a5Dd2L2Bt8Uc3SS
 a
X-Gm-Gg: ASbGncvpabOIcOdkcficKmOvol2gn/h+82YBbijO8FYqteFfxcrvM2iwEgjk98Fj99Z
 bYkXlltha5d6hHZ/KdTyqLZ30oHmn/x+T7zDTLxzI9Mz3kyDme1bLqwsnonAbyoIMuTWU+GJIXx
 RvXu+u4+BhuwdMouynqB2FM2/RwFxbfbTIKApktZISHO5xYa1NulFPzXSd7IeC4RmRcqV3Sya94
 sFqoqPiVpkRqboaBn1NgaMtn6nyGmgaW2zp8dE9AQydLzyxP2jCX86Hsvmc1l49yM5QgMuY7msw
 1/McnjHx5Qt6gAL83GfRgNrTLYqQUTJIGyrYGPcg/W+KMNNxZ0R1IQ==
X-Google-Smtp-Source: AGHT+IEb66t8HBPFH3gerSSvKbHe0p0hwtlXs23rVBoMbvBf0YWaAFB0XkucNCemm49kDpE3fqvdeA==
X-Received: by 2002:a05:6a00:139f:b0:736:5c8e:baaa with SMTP id
 d2e1a72fcca58-73c266bef31mr3550052b3a.2.1744830865506; 
 Wed, 16 Apr 2025 12:14:25 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21c6de4sm11228135b3a.67.2025.04.16.12.14.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:14:25 -0700 (PDT)
Message-ID: <d6652bec-bda5-4381-9126-45e451b9659c@linaro.org>
Date: Wed, 16 Apr 2025 12:14:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 136/163] tcg/arm: Remove support for add2/sub2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-137-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-137-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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
>   tcg/arm/tcg-target-con-set.h |  2 --
>   tcg/arm/tcg-target-has.h     |  4 +--
>   tcg/arm/tcg-target.c.inc     | 47 ------------------------------------
>   3 files changed, 2 insertions(+), 51 deletions(-)
> 
> diff --git a/tcg/arm/tcg-target-con-set.h b/tcg/arm/tcg-target-con-set.h
> index a44625ba63..16b1193228 100644
> --- a/tcg/arm/tcg-target-con-set.h
> +++ b/tcg/arm/tcg-target-con-set.h
> @@ -45,5 +45,3 @@ C_O1_I4(r, r, rIN, rIK, 0)
>   C_O2_I1(e, p, q)
>   C_O2_I2(e, p, q, q)
>   C_O2_I2(r, r, r, r)
> -C_O2_I4(r, r, r, r, rIN, rIK)
> -C_O2_I4(r, r, rI, rI, rIN, rIK)
> diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
> index 3973df1f12..f4bd15c68a 100644
> --- a/tcg/arm/tcg-target-has.h
> +++ b/tcg/arm/tcg-target-has.h
> @@ -24,8 +24,8 @@ extern bool use_neon_instructions;
>   #endif
>   
>   /* optional instructions */
> -#define TCG_TARGET_HAS_add2_i32         1
> -#define TCG_TARGET_HAS_sub2_i32         1
> +#define TCG_TARGET_HAS_add2_i32         0
> +#define TCG_TARGET_HAS_sub2_i32         0
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
>   
>   #define TCG_TARGET_HAS_qemu_ldst_i128   0
> diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
> index c464c54ffd..3c9042ebfa 100644
> --- a/tcg/arm/tcg-target.c.inc
> +++ b/tcg/arm/tcg-target.c.inc
> @@ -2518,8 +2518,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                          const TCGArg args[TCG_MAX_OP_ARGS],
>                          const int const_args[TCG_MAX_OP_ARGS])
>   {
> -    TCGArg a0, a1, a2, a3, a4, a5;
> -
>       switch (opc) {
>       case INDEX_op_goto_ptr:
>           tcg_out_b_reg(s, COND_AL, args[0]);
> @@ -2553,47 +2551,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>           tcg_out_st32(s, COND_AL, args[0], args[1], args[2]);
>           break;
>   
> -    case INDEX_op_add2_i32:
> -        a0 = args[0], a1 = args[1], a2 = args[2];
> -        a3 = args[3], a4 = args[4], a5 = args[5];
> -        if (a0 == a3 || (a0 == a5 && !const_args[5])) {
> -            a0 = TCG_REG_TMP;
> -        }
> -        tcg_out_dat_rIN(s, COND_AL, ARITH_ADD | TO_CPSR, ARITH_SUB | TO_CPSR,
> -                        a0, a2, a4, const_args[4]);
> -        tcg_out_dat_rIK(s, COND_AL, ARITH_ADC, ARITH_SBC,
> -                        a1, a3, a5, const_args[5]);
> -        tcg_out_mov_reg(s, COND_AL, args[0], a0);
> -        break;
> -    case INDEX_op_sub2_i32:
> -        a0 = args[0], a1 = args[1], a2 = args[2];
> -        a3 = args[3], a4 = args[4], a5 = args[5];
> -        if ((a0 == a3 && !const_args[3]) || (a0 == a5 && !const_args[5])) {
> -            a0 = TCG_REG_TMP;
> -        }
> -        if (const_args[2]) {
> -            if (const_args[4]) {
> -                tcg_out_movi32(s, COND_AL, a0, a4);
> -                a4 = a0;
> -            }
> -            tcg_out_dat_rI(s, COND_AL, ARITH_RSB | TO_CPSR, a0, a4, a2, 1);
> -        } else {
> -            tcg_out_dat_rIN(s, COND_AL, ARITH_SUB | TO_CPSR,
> -                            ARITH_ADD | TO_CPSR, a0, a2, a4, const_args[4]);
> -        }
> -        if (const_args[3]) {
> -            if (const_args[5]) {
> -                tcg_out_movi32(s, COND_AL, a1, a5);
> -                a5 = a1;
> -            }
> -            tcg_out_dat_rI(s, COND_AL, ARITH_RSC, a1, a5, a3, 1);
> -        } else {
> -            tcg_out_dat_rIK(s, COND_AL, ARITH_SBC, ARITH_ADC,
> -                            a1, a3, a5, const_args[5]);
> -        }
> -        tcg_out_mov_reg(s, COND_AL, args[0], a0);
> -        break;
> -
>       case INDEX_op_qemu_ld_i32:
>           tcg_out_qemu_ld(s, args[0], -1, args[1], args[2], TCG_TYPE_I32);
>           break;
> @@ -2639,10 +2596,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>       case INDEX_op_st_i32:
>           return C_O0_I2(r, r);
>   
> -    case INDEX_op_add2_i32:
> -        return C_O2_I4(r, r, r, r, rIN, rIK);
> -    case INDEX_op_sub2_i32:
> -        return C_O2_I4(r, r, rI, rI, rIN, rIK);
>       case INDEX_op_qemu_ld_i32:
>           return C_O1_I1(r, q);
>       case INDEX_op_qemu_ld_i64:

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


