Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B212C021AA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 12:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjzzb-0001gd-8t; Mon, 17 Feb 2025 07:12:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjzzQ-0001d7-TF
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:12:45 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjzzO-0004na-Qu
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:12:44 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4398c8c8b2cso4051215e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 04:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739794360; x=1740399160; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8eM8oFEYWnyyWQ+xb/mm8kDNl3z/EdSH7maZB8kHxjE=;
 b=HPy0E+OykBOgR0WKf2jocoTGB+gBE3OEPlp+E9OwI2hTg5vN8dUbevSKEY10COFOd2
 ejyuTiSz+zNZjwbFKyf46zYtyBm8PvilFB7Sks3MV+GOOenPGa8hj6hpaeiNYqYpHrEZ
 mgpcDgMko7Dn8OFeB/KU/TBEmc5QQjhUhXbubFXF4daBbQus16hsflcMlwmqWvYCPN0D
 E+Bm6EkVq9RA6mzvtXwWehh8Vns3L0PbnUvPt9VIl+FhOpEIKMJms7qBwoZPZ4z7KdO3
 8g1ebplDugzt5oPwUWnYOzp4WSVMuTuGyjE4wf8md+oOZIdRmN3MqGWD5oWflB3tx6LU
 rv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739794360; x=1740399160;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8eM8oFEYWnyyWQ+xb/mm8kDNl3z/EdSH7maZB8kHxjE=;
 b=E+kWQdaSJUhFAtotHvibmXPw4D/MiOX9i3DS2j9LpgqUapykeIffr9RpxWDpgwVdW2
 8iLdtrKo+oBKDcQAYQPVjNxES5mAc67Tr1g0ISh04LN3Faj50zSsw5vVk++to27oJ8Dh
 8+4QrapQvx00FRhRMEWZhqRxI+hsDpWohUeq5UZFymSWrTSL/G5a6GzCbrxCRezCOZiy
 wE2OnzfDOgFmk97QGlzZ8TFXcrk3Agr0obvlVZdUp7MIA1lqnN18UFNxA1f0fBBadeoy
 aMAdL7n/EMow/u5eQNFY+58QyF5lSChiM5WyW8Qbdzvd0avLRAdNGe1SXINKNY2OysLU
 KQLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkz7tWSooYMNozddCvuVMIXXKQwjpCbiH6IS1Eeyn/hauOxYFDCJ3C6dkmDcBiIT3barCkNjx2AMLB@nongnu.org
X-Gm-Message-State: AOJu0YzkHc5MeaELvpadg01RpBusBgfha7L1s7B1Ztsyr7R6vhHEHxcb
 aJVI94Vl+WisRVHkS6YG4hi0brvv6s4HQhirVXHqIIc6IgpetjwWIXy+HIFGg7g=
X-Gm-Gg: ASbGncvZOdbMeHftp8fPbaVBNltUO7K1eMe0TrAAyYl+7QHMfV4wcX9wN+KuXBFfejH
 lg6CjhNMbVJp6y3VjYHaXMJKCjXotswypPOqycdRycT/TdyIEzXm4pbfjoUbggvOBnP/Vhi76S+
 sxX6wEMq/qXpHlMNVb5RFqWobQ5MuUJClprnivru/PuRDT8CQogggllANw0EXI+pOXbaOlSAKeZ
 uc4Xoim0KZDl9CpIAOkwJsaET8AZb9GkSwKAIDN2L5xVIe0QtTFm6o/0RjFu94jFGbVo8KPMpYn
 2dKVR0n/iytf/tVxxcAmrYYjzGIumIBPx88=
X-Google-Smtp-Source: AGHT+IG+M/oe+Va+kJ6o886gpWQYB6CTCpozchMnyY+vwC5TGeLCJedyc5s6mcU3cadcvio4TM/98A==
X-Received: by 2002:a05:600c:4ecd:b0:439:35e2:bb45 with SMTP id
 5b1f17b1804b1-4396e6dfd41mr94084945e9.18.1739794360528; 
 Mon, 17 Feb 2025 04:12:40 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398937341csm15335815e9.24.2025.02.17.04.12.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 04:12:40 -0800 (PST)
Message-ID: <73389661-e759-42c5-845b-7d2a28b2a303@linaro.org>
Date: Mon, 17 Feb 2025 13:12:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] tcg/arm: Drop addrhi from prepare_host_addr
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250205040341.2056361-1-richard.henderson@linaro.org>
 <20250205040341.2056361-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250205040341.2056361-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 5/2/25 05:03, Richard Henderson wrote:
> The guest address will now always be TCG_TYPE_I32.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/arm/tcg-target.c.inc | 63 ++++++++++++++--------------------------
>   1 file changed, 21 insertions(+), 42 deletions(-)


>           /*
>            * Add the tlb_table pointer, creating the CPUTLBEntry address in R1.
> -         * Load the tlb comparator into R2/R3 and the fast path addend into R1.
> +         * Load the tlb comparator into R2 and the fast path addend into R1.
>            */
>           QEMU_BUILD_BUG_ON(HOST_BIG_ENDIAN);
>           if (cmp_off == 0) {
> -            if (s->addr_type == TCG_TYPE_I32) {
> -                tcg_out_ld32_rwb(s, COND_AL, TCG_REG_R2,
> -                                 TCG_REG_R1, TCG_REG_R0);
> -            } else {
> -                tcg_out_ldrd_rwb(s, COND_AL, TCG_REG_R2,
> -                                 TCG_REG_R1, TCG_REG_R0);
> -            }
> +            tcg_out_ld32_rwb(s, COND_AL, TCG_REG_R2, TCG_REG_R1, TCG_REG_R0);
>           } else {
>               tcg_out_dat_reg(s, COND_AL, ARITH_ADD,
>                               TCG_REG_R1, TCG_REG_R1, TCG_REG_R0, 0);
> -            if (s->addr_type == TCG_TYPE_I32) {
> -                tcg_out_ld32_12(s, COND_AL, TCG_REG_R2, TCG_REG_R1, cmp_off);
> -            } else {
> -                tcg_out_ldrd_8(s, COND_AL, TCG_REG_R2, TCG_REG_R1, cmp_off);
> -            }
> +            tcg_out_ld32_12(s, COND_AL, TCG_REG_R2, TCG_REG_R1, cmp_off);
>           }

With this change:

-- >8 --
@@ -678,8 +678,2 @@ static void tcg_out_ldrd_r(TCGContext *s, ARMCond 
cond, TCGReg rt,

-static void __attribute__((unused))
-tcg_out_ldrd_rwb(TCGContext *s, ARMCond cond, TCGReg rt, TCGReg rn, 
TCGReg rm)
-{
-    tcg_out_memop_r(s, cond, INSN_LDRD_REG, rt, rn, rm, 1, 1, 1);
-}
-
  static void __attribute__((unused))
---

squashed:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


