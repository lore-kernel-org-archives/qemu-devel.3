Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789DAC369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u58Hy-0007fO-EX; Wed, 16 Apr 2025 15:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58Hw-0007eu-U0
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:19:12 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58Hu-0006Zo-ML
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:19:12 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-30549dacd53so28808a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744831149; x=1745435949; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dwk3/a54sUTMaj/7L92xVmaCUIQ0Ne8F6Gq7ZnQd64o=;
 b=u2zxWMWXfvyEQESd3eCLj6Jll46AHQ8exy132/yaDKOA00L8HMNb5KEm/4yrIgjjOE
 yGOLJgSx7MeaJ0ObVGTOD8JFCeMapBr4KspXL+qNRsgoGuxkgl2iX5cfyX1X2dJzoxd8
 sSffVq1585FgQjYyhqdzE2P6hfFiB10ff8ToNRCBoAE0N7cUT7H611e1t1JhoSe5pG2L
 t7MwGzxFAobG6WWd5gMHf7ZpL+pnwOMqU/O0irQJQxd1/QpO+S6gnk7964oys3PRpHGh
 JOT7816y9Z+ITtf8C8qldlfq4ra+s7G0Fq6SEKs3tyFoarppN2R3j5iM/jmX+P5dX4iC
 BV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744831149; x=1745435949;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dwk3/a54sUTMaj/7L92xVmaCUIQ0Ne8F6Gq7ZnQd64o=;
 b=MRHftZMI+VoE37hnViMGxQpInKBtRNKxaaWS9xwrnRLDFnNeSPo5PxITu5SJt5mxiV
 7wiVUu0FglR0bvkflKnUhp5chbDuKplTwn2WnGoiTBvc5zFkbjP+dFMYDOsU+TY08fFx
 0yb0NseB8chZu7rtjz4RFBXPJDOJUmxnp7S1kYjpI6XFqaVQrwEq9pBOFB4DNwuGNTnU
 /2NNwxxVe3RuUs7bT43hFLZRkLIraum+n4uujAge0plalmOm5NHGy9kmhRBH9sOEe8pF
 FXX/Psu2NfN87cFzFt3eTrFb9DUG5+yfHVZce78TefhxEQiyO4YD8DRWaFYSbWAS8tMS
 ru1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCZwOCiQqjV9xzc/BBhRXR0jyedLVvm/8MDtqb3RrOfCvmZB/8O0+lvZn57a3gysKNSqTkHNbpU9rS@nongnu.org
X-Gm-Message-State: AOJu0Yz63Wl7pRab52cuwgzTdvyPIT5eg7iPYx5eiZVOBMn6RH0uZfGf
 SZMKYLzt2ws5JhbSlvWlObiUDfYJZ1+QkX+3zUcVUlcfJP5xeXEt3hMNt0JIksg=
X-Gm-Gg: ASbGncsWCH1VN//MaVh5wDw8/fDEFbM+DMgWoeSal6tm2js2vmopwRNg55MFnn48WnL
 3lwv/8dTvio75crwmaCR/Ugrn0+793xXfPvcOrrQ3PsmortwqmjhuwKYnv4eTsCr3hthvazuRyn
 ulZWTdkOcKSWJeveowkyXBWGvEMJ0ZehrLG5bxa0tfhwiPvJcbVy/BScC9PsmnBBW6o1ETLSLPr
 Y7seE97NO5H8aveCB8dpgZ7yR99pA/6ndAOyJiHDWlW6dvzQ693EDGW69EeTcN/a1NvoIbr7aMd
 b+Ec4YM/vBwlDKF7E0VqIxOOYccM6BRpgvpDfsC5jIsFHZpNqP5U5g==
X-Google-Smtp-Source: AGHT+IHj8RglvkzTXKCRGHsHbLz0HUn/zjlijrf851oatR9Ev44xEmT9VwGlaLvToKekIx7Zh6HqZg==
X-Received: by 2002:a17:90b:5446:b0:2ff:6e58:89f5 with SMTP id
 98e67ed59e1d1-3086f68d557mr21900a91.6.1744831149085; 
 Wed, 16 Apr 2025 12:19:09 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30861212ff4sm2016313a91.24.2025.04.16.12.19.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:19:08 -0700 (PDT)
Message-ID: <3bc59b0f-97ee-4cb0-9eff-f13ea8c7fd26@linaro.org>
Date: Wed, 16 Apr 2025 12:19:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 144/163] tcg/sparc64: Hoist tcg_cond_to_bcond lookup
 out of tcg_out_movcc
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-145-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-145-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102b.google.com
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
> Pass the sparc COND_* value not the tcg TCG_COND_* value.
> This makes the usage within add2/sub2 clearer.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/sparc64/tcg-target.c.inc | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
> index 12f0dbd23d..350a7f6332 100644
> --- a/tcg/sparc64/tcg-target.c.inc
> +++ b/tcg/sparc64/tcg-target.c.inc
> @@ -652,11 +652,10 @@ static void tcg_out_brcond_i32(TCGContext *s, TCGCond cond, TCGReg arg1,
>       tcg_out_nop(s);
>   }
>   
> -static void tcg_out_movcc(TCGContext *s, TCGCond cond, int cc, TCGReg ret,
> +static void tcg_out_movcc(TCGContext *s, int scond, int cc, TCGReg ret,
>                             int32_t v1, int v1const)
>   {
> -    tcg_out32(s, ARITH_MOVCC | cc | INSN_RD(ret)
> -              | INSN_RS1(tcg_cond_to_bcond[cond])
> +    tcg_out32(s, ARITH_MOVCC | cc | INSN_RD(ret) | INSN_RS1(scond)
>                 | (v1const ? INSN_IMM11(v1) : INSN_RS2(v1)));
>   }
>   
> @@ -665,7 +664,7 @@ static void tcg_out_movcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
>                                   int32_t v1, int v1const)
>   {
>       tcg_out_cmp(s, cond, c1, c2, c2const);
> -    tcg_out_movcc(s, cond, MOVCC_ICC, ret, v1, v1const);
> +    tcg_out_movcc(s, tcg_cond_to_bcond[cond], MOVCC_ICC, ret, v1, v1const);
>   }
>   
>   static void tcg_out_brcond_i64(TCGContext *s, TCGCond cond, TCGReg arg1,
> @@ -709,7 +708,7 @@ static void tcg_out_movcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
>           tcg_out_movr(s, rcond, ret, c1, v1, v1const);
>       } else {
>           tcg_out_cmp(s, cond, c1, c2, c2const);
> -        tcg_out_movcc(s, cond, MOVCC_XCC, ret, v1, v1const);
> +        tcg_out_movcc(s, tcg_cond_to_bcond[cond], MOVCC_XCC, ret, v1, v1const);
>       }
>   }
>   
> @@ -763,7 +762,8 @@ static void tcg_out_setcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
>       default:
>           tcg_out_cmp(s, cond, c1, c2, c2const);
>           tcg_out_movi_s13(s, ret, 0);
> -        tcg_out_movcc(s, cond, MOVCC_ICC, ret, neg ? -1 : 1, 1);
> +        tcg_out_movcc(s, tcg_cond_to_bcond[cond],
> +                      MOVCC_ICC, ret, neg ? -1 : 1, 1);
>           return;
>       }
>   
> @@ -818,7 +818,8 @@ static void tcg_out_setcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
>       } else {
>           tcg_out_cmp(s, cond, c1, c2, c2const);
>           tcg_out_movi_s13(s, ret, 0);
> -        tcg_out_movcc(s, cond, MOVCC_XCC, ret, neg ? -1 : 1, 1);
> +        tcg_out_movcc(s, tcg_cond_to_bcond[cond],
> +                      MOVCC_XCC, ret, neg ? -1 : 1, 1);
>       }
>   }
>   
> @@ -956,10 +957,10 @@ static void tcg_out_addsub2_i64(TCGContext *s, TCGReg rl, TCGReg rh,
>   	if (rh == ah) {
>               tcg_out_arithi(s, TCG_REG_T2, ah, 1,
>   			   is_sub ? ARITH_SUB : ARITH_ADD);
> -            tcg_out_movcc(s, TCG_COND_LTU, MOVCC_XCC, rh, TCG_REG_T2, 0);
> +            tcg_out_movcc(s, COND_CS, MOVCC_XCC, rh, TCG_REG_T2, 0);
>   	} else {
>               tcg_out_arithi(s, rh, ah, 1, is_sub ? ARITH_SUB : ARITH_ADD);
> -	    tcg_out_movcc(s, TCG_COND_GEU, MOVCC_XCC, rh, ah, 0);
> +	    tcg_out_movcc(s, COND_CC, MOVCC_XCC, rh, ah, 0);
>   	}
>       } else {
>           /*
> @@ -974,7 +975,7 @@ static void tcg_out_addsub2_i64(TCGContext *s, TCGReg rl, TCGReg rh,
>                              is_sub ? ARITH_SUB : ARITH_ADD);
>           }
>           /* ... smoosh T2 back to original BH if carry is clear ... */
> -        tcg_out_movcc(s, TCG_COND_GEU, MOVCC_XCC, TCG_REG_T2, bh, bhconst);
> +        tcg_out_movcc(s, COND_CC, MOVCC_XCC, TCG_REG_T2, bh, bhconst);
>   	/* ... and finally perform the arithmetic with the new operand.  */
>           tcg_out_arith(s, rh, ah, TCG_REG_T2, is_sub ? ARITH_SUB : ARITH_ADD);
>       }

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


