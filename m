Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD5DC369B8
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 21:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4nh8-00057y-71; Tue, 15 Apr 2025 17:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4ngv-00054z-C7
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:19:38 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4ngt-0003uR-Dw
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:19:37 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-306b6ae4fb2so6085191a91.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 14:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744751974; x=1745356774; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gLdr0gJ7z6MT9Rhyd4uRW7mHYN5IPmrRYWXdqNR1cL8=;
 b=ltnOsZEwWB3bPSZPJH1FkzpXjqIHAbQleyMVYmkC/bSCfvDcJxCyc+Gpzq/LQb0Wa8
 Ebkr41mTeQm5FKaxEFBCE3a3NexvEP2Swaq1j0U6AXWNrGOB1srQUNajohJI915y9LUb
 lCupsmFxazkry7cMwXEiA05B8xski3QTQmoZcL39IJira/hozwdk11haw/lMj+8iYETR
 O4VBz1ZQ0/DlYsSpe4yu8jvcTdhso7DmFgMMF5DD6tAOOBnqSGmlIxYmh4SXyu2SWheK
 ZMSiRM7mbyhRwPtd4YNxLO78sqpkATTrA+WNmVX4Lc36amZZIG4ZoA6ZEWRR9rFUHt21
 ygkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744751974; x=1745356774;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gLdr0gJ7z6MT9Rhyd4uRW7mHYN5IPmrRYWXdqNR1cL8=;
 b=MnRZ9vhHoqSfLrX/OqG2hjWqdRXl9adbb44TCkoJ9pCqXa4RgqFPpfhqYUJ8bUYAZX
 MGLcTtWCpQZk+VCMwuyGZ0jDncCftdqWkw17PkJjmLfHv375oL69/siM0+l0OJFFPUwU
 cw+zrNCT/BI2FNkle8KnegFZgBnnEXbkzK/13vvBntbptwnpPMnrl8dtB+0xomfyOlwR
 IyJ2v1GiBB12aSL2Xdm+BFGU9fETBLYHjRdI6ccb7Hl+2HrOLyCQCd1Yq9M9YAMvAF5b
 VPLGfDyKDohRyp5SgPypepo/lrTGlfhcXJ8dn3idwpnKeh/eBKgIqAlksUS5d4XTs56N
 yYtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwDkrpjWWZTjraYWHr3ZqHLdRCvvry8hQk90qtXMW4R+lbHMWp7Gmwd+Hl4tCL5uL+nIYzJK0+YaEz@nongnu.org
X-Gm-Message-State: AOJu0YzC3V/xgsdEvupNkuf/LDu349kwd8vcDtwc7fYZAYq2jYB+K71z
 /eUJ3FMfZVmlTvByP6ZSH4g630MhmndquwqHrblFHeWDPLje3wceWxEpVzKFaLg=
X-Gm-Gg: ASbGncvdMIXdsZgSJR4BqmQW3t5TODHNW1uQnKyF073oRbH9cfjDQB4ay47EVfHo/VV
 C5uPkS7P156T7avG/h8uX/3uiewnWlRCl5mSOCLjjSFdvS79crxzvACj766FV2jKnAYLP4ewbjY
 OXNR/hLd0WsulKYdM04Y3xOidm1fLg5SrVN1o366MEHnJIUjDOlQQDBrS/yShg+W8EO47E+WHGD
 0WwlLNpHcTvfcUg1bFJpnxuKx3mGzXXzmAhZ5PdH43KyDwCUx2jpjs8nr7XYa928fQ/Om5x+7tf
 t6VcMdQzd5e7Of4czTfqV/c8BIDmlV/LVKHWeeau46PoxLWw9KXV2Q==
X-Google-Smtp-Source: AGHT+IFXzlLPmNJnSmkCaTcqXaDw6L13Ctqp2U2X2dzg9LOL7IetH/qNQOgWpYDW1w+NPu35/WgWCg==
X-Received: by 2002:a17:90b:5247:b0:2ee:b875:6d30 with SMTP id
 98e67ed59e1d1-3085eef1b7fmr1108123a91.9.1744751973736; 
 Tue, 15 Apr 2025 14:19:33 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-308611fa162sm56810a91.20.2025.04.15.14.19.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 14:19:33 -0700 (PDT)
Message-ID: <ebb9fc5e-44e6-4093-8c55-3dbfdc8cf278@linaro.org>
Date: Tue, 15 Apr 2025 14:19:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 072/163] tcg/loongarch64: Support negsetcond
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-73-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-73-richard.henderson@linaro.org>
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

On 4/15/25 12:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/loongarch64/tcg-target-con-set.h |  2 --
>   tcg/loongarch64/tcg-target-has.h     |  4 ++--
>   tcg/loongarch64/tcg-target.c.inc     | 34 ++++++++++++++++++++++------
>   3 files changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
> index da84e4d49c..c145d4ab66 100644
> --- a/tcg/loongarch64/tcg-target-con-set.h
> +++ b/tcg/loongarch64/tcg-target-con-set.h
> @@ -29,8 +29,6 @@ C_O1_I2(r, r, rJ)
>   C_O1_I2(r, r, rU)
>   C_O1_I2(r, r, rW)
>   C_O1_I2(r, 0, rz)
> -C_O1_I2(r, rz, ri)
> -C_O1_I2(r, rz, rJ)
>   C_O1_I2(w, w, w)
>   C_O1_I2(w, w, wM)
>   C_O1_I2(w, w, wA)
> diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
> index 12a721b4da..e9bb913961 100644
> --- a/tcg/loongarch64/tcg-target-has.h
> +++ b/tcg/loongarch64/tcg-target-has.h
> @@ -10,7 +10,7 @@
>   #include "host/cpuinfo.h"
>   
>   /* optional instructions */
> -#define TCG_TARGET_HAS_negsetcond_i32   0
> +#define TCG_TARGET_HAS_negsetcond_i32   1
>   #define TCG_TARGET_HAS_extract2_i32     0
>   #define TCG_TARGET_HAS_add2_i32         0
>   #define TCG_TARGET_HAS_sub2_i32         0
> @@ -19,7 +19,7 @@
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
>   
>   /* 64-bit operations */
> -#define TCG_TARGET_HAS_negsetcond_i64   0
> +#define TCG_TARGET_HAS_negsetcond_i64   1
>   #define TCG_TARGET_HAS_extract2_i64     0
>   #define TCG_TARGET_HAS_extr_i64_i32     1
>   #define TCG_TARGET_HAS_bswap16_i64      1
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index aed1d9712d..c4f908f3ae 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -634,14 +634,29 @@ static int tcg_out_setcond_int(TCGContext *s, TCGCond cond, TCGReg ret,
>   }
>   
>   static void tcg_out_setcond(TCGContext *s, TCGCond cond, TCGReg ret,
> -                            TCGReg arg1, tcg_target_long arg2, bool c2)
> +                            TCGReg arg1, tcg_target_long arg2,
> +                            bool c2, bool neg)
>   {
>       int tmpflags = tcg_out_setcond_int(s, cond, ret, arg1, arg2, c2);
> +    TCGReg tmp = tmpflags & ~SETCOND_FLAGS;
>   
> -    if (tmpflags != ret) {
> -        TCGReg tmp = tmpflags & ~SETCOND_FLAGS;
> -
> +    if (neg) {
> +        /* If intermediate result is zero/non-zero: test != 0. */
> +        if (tmpflags & SETCOND_NEZ) {
> +            tcg_out_opc_sltu(s, ret, TCG_REG_ZERO, tmp);
> +            tmp = ret;
> +        }
> +        /* Produce the 0/-1 result. */
> +        if (tmpflags & SETCOND_INV) {
> +            tcg_out_opc_addi_d(s, ret, tmp, -1);
> +        } else {
> +            tcg_out_opc_sub_d(s, ret, TCG_REG_ZERO, tmp);
> +        }
> +    } else {
>           switch (tmpflags & SETCOND_FLAGS) {
> +        case 0:
> +            tcg_debug_assert(tmp == ret);
> +            break;
>           case SETCOND_INV:
>               /* Intermediate result is boolean: simply invert. */
>               tcg_out_opc_xori(s, ret, tmp, 1);
> @@ -1788,7 +1803,11 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>   
>       case INDEX_op_setcond_i32:
>       case INDEX_op_setcond_i64:
> -        tcg_out_setcond(s, args[3], a0, a1, a2, c2);
> +        tcg_out_setcond(s, args[3], a0, a1, a2, c2, false);
> +        break;
> +    case INDEX_op_negsetcond_i32:
> +    case INDEX_op_negsetcond_i64:
> +        tcg_out_setcond(s, args[3], a0, a1, a2, c2, true);
>           break;
>   
>       case INDEX_op_movcond_i32:
> @@ -2428,9 +2447,10 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>           return C_O1_I2(r, 0, rz);
>   
>       case INDEX_op_setcond_i32:
> -        return C_O1_I2(r, rz, ri);
>       case INDEX_op_setcond_i64:
> -        return C_O1_I2(r, rz, rJ);
> +    case INDEX_op_negsetcond_i32:
> +    case INDEX_op_negsetcond_i64:
> +        return C_O1_I2(r, r, rJ);
>   
>       case INDEX_op_movcond_i32:
>       case INDEX_op_movcond_i64:

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


