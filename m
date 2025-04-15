Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C684FC369B8
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 21:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4niK-0006Gp-5X; Tue, 15 Apr 2025 17:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4nhz-00060i-Nv
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:20:51 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4nhg-0004Li-5y
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:20:32 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-301c4850194so4722330a91.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 14:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744752018; x=1745356818; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qi9y6V/onY/vrsFPkU+ZQBlWHQU4RoS7ebTflkNe/4c=;
 b=etK4X6YzOHKxxEe7s1XtKf+1/lVMGpjDcjc5vNw0KJ1+3ImykN+n8v9EMDV7/DOXPa
 kFo5Qqod208bmK6Vje1p+8UsM6/jZcuW19bqS2N+H/eqx3WIg639pAGxjheymy05Btgj
 bj+/7bdltseId+tk0IgIfg3dGh68qFlE4+ruxrP/lKx6BaO3SDzQp6vHHgviL1hZ0jZF
 1jh6RIknui+/ZGIb2I85MTaHJ4U3N87XZJ0PvbGTJZTTrQ2HEPFQddXpGyaNMq8bVN8U
 VDJIJdHYVmiPEoN/cw7ovYtAmfauf95wY6PmQKB7Xoo0QWpVaKt+fdA+IPP+LILHqzr2
 DV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744752018; x=1745356818;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qi9y6V/onY/vrsFPkU+ZQBlWHQU4RoS7ebTflkNe/4c=;
 b=UQWHgF4+ox/B5hRmW53kmTxYUBZu9myQkPg8aHl6MezKPmZCaVz0lP/21Do6u3cOBh
 sqKzfdWQK2lpt3Fi0iT9lDCb3u7kwS/e8S5zUatK/TVGv9GVDW6i990Q+LrxH0uRei9Q
 /+s+S6JpNz2T44PpO2B9fAHLVq4hhEtKsgGfd7oqbJeJxjGBXdETl2xzK6iWZr/KOKnZ
 oiS7Xub/pgBetqmY+iu7v/rVrAoejNMvgWEHRDcgb2KWtPibi1qQFopF3Go8N1VAyYuu
 keXyolftWOMQhRIm7Zp8tFlIgZbGYKS2Vt/wlM35dTuU/tOiDk/yPM6bs6uQvh/C7fh3
 dcfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWptqh1QNN1b6dk5baKVy13rB0f0CL8EnCfG+zaWdge44ByKjijrRtNJsEZX+Dc+jUzbCuhVGjWjrZ0@nongnu.org
X-Gm-Message-State: AOJu0Yz7ZkY7npm1yLYhHZ3w8+nKfKQNQa5q8sBBFRXi2QWrMJz0kfg5
 70sccn25j7sC804C2nbB0pZP4Tbm87WozrNdz5jdcG5fEK80ITeJ7yGS9DYgdKs=
X-Gm-Gg: ASbGncuv8wSJz4SiT4zY6+nNTvh5i3EGF6LtoWnRUSeA1ZZN3ooYe0N3KQEEBx62qtQ
 I4OU5PpzeB9X1fMQBiGJz62CQ2AHeLn80aX09kjwtRHUDXPIkGJ2J9JyX+q9Gk/Z9TOAUt/2i+a
 /jmq2jhD3+LWdO3SInyKTl5I3OiJ8IpCngXgFlrJ3uqiq+Kb2v5W0qunWRhpuKa3YrTVl8Xiz+v
 2UwttbtBfWVxZlHO45qgSp1LUZphSF33GT3iyDEGh7lUp7CtC0M8QQSuNFqaVXZggAhn6aSSb/F
 YFI/AdGeGAYXX1Vs3vEqgYyi7pUsCKLEcVxD8wALCywoRndBpuRqoQ==
X-Google-Smtp-Source: AGHT+IEISvSKM+oFPOkKkUZ+QYbY8w993neZzGd00uADFX7ovenjZBH5PJf2paMflYM8aTefOSSLUg==
X-Received: by 2002:a17:90b:58c3:b0:2ff:702f:7172 with SMTP id
 98e67ed59e1d1-3085efeadd5mr1127118a91.33.1744752018530; 
 Tue, 15 Apr 2025 14:20:18 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30861212533sm57593a91.22.2025.04.15.14.20.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 14:20:18 -0700 (PDT)
Message-ID: <0b1e784e-0d1c-41b2-84a8-1005152bbd98@linaro.org>
Date: Tue, 15 Apr 2025 14:20:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 074/163] tcg/tci: Support negsetcond
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-75-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-75-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
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
>   tcg/tci/tcg-target-has.h |  4 ++--
>   tcg/tci/tcg-target.c.inc | 13 +++++++++++++
>   2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/tcg/tci/tcg-target-has.h b/tcg/tci/tcg-target-has.h
> index 2402889bec..7787347e05 100644
> --- a/tcg/tci/tcg-target-has.h
> +++ b/tcg/tci/tcg-target-has.h
> @@ -10,7 +10,7 @@
>   #define TCG_TARGET_HAS_bswap16_i32      1
>   #define TCG_TARGET_HAS_bswap32_i32      1
>   #define TCG_TARGET_HAS_extract2_i32     0
> -#define TCG_TARGET_HAS_negsetcond_i32   0
> +#define TCG_TARGET_HAS_negsetcond_i32   1
>   #define TCG_TARGET_HAS_qemu_st8_i32     0
>   
>   #if TCG_TARGET_REG_BITS == 64
> @@ -19,7 +19,7 @@
>   #define TCG_TARGET_HAS_bswap32_i64      1
>   #define TCG_TARGET_HAS_bswap64_i64      1
>   #define TCG_TARGET_HAS_extract2_i64     0
> -#define TCG_TARGET_HAS_negsetcond_i64   0
> +#define TCG_TARGET_HAS_negsetcond_i64   1
>   #define TCG_TARGET_HAS_add2_i32         1
>   #define TCG_TARGET_HAS_sub2_i32         1
>   #define TCG_TARGET_HAS_add2_i64         1
> diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
> index 563529e055..2eb323b5c5 100644
> --- a/tcg/tci/tcg-target.c.inc
> +++ b/tcg/tci/tcg-target.c.inc
> @@ -79,6 +79,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
>   
>       case INDEX_op_setcond_i32:
>       case INDEX_op_setcond_i64:
> +    case INDEX_op_negsetcond_i32:
> +    case INDEX_op_negsetcond_i64:
>       case INDEX_op_deposit_i32:
>       case INDEX_op_deposit_i64:
>           return C_O1_I2(r, r, r);
> @@ -966,6 +968,17 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
>                             args[3], args[4], args[5]);
>           break;
>   
> +    case INDEX_op_negsetcond_i32:
> +        tcg_out_op_rrrc(s, INDEX_op_setcond_i32,
> +                        args[0], args[1], args[2], args[3]);
> +        tcg_out_op_rr(s, INDEX_op_neg, args[0], args[0]);
> +        break;
> +    case INDEX_op_negsetcond_i64:
> +        tcg_out_op_rrrc(s, INDEX_op_setcond_i64,
> +                        args[0], args[1], args[2], args[3]);
> +        tcg_out_op_rr(s, INDEX_op_neg, args[0], args[0]);
> +        break;
> +
>       CASE_32_64(ld8u)
>       CASE_32_64(ld8s)
>       CASE_32_64(ld16u)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


