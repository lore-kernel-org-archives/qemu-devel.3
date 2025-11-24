Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC89CFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 19:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNcW9-0005SE-C4; Mon, 24 Nov 2025 14:46:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vNcW3-0005Gu-7m
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 14:46:28 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vNcVy-0007gC-PK
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 14:46:25 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7b86e0d9615so5607020b3a.0
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 11:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764013576; x=1764618376; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tOvOegWh7Munx3fSN0wi/2oYkGIg7jneLjN/pk3sRhw=;
 b=BVNUp7rdllsZ7+XZOtNu49VhEb9SxVHJPviGiAlTDqeTAMaLnnkFZ6ymNiH7NMPeWp
 nBRe1SrtsbNTaPl0gLrWktKd7khvx4HBYiGn6hInFcZJIDvyKZ+ILyJCnQbCANK1At5/
 GUWbgnJC9Gmnj/4JCt48SgQY+EUlIG5nV9ymKy+hSrD4Api77P27AJbRbTM/dpbfVIEk
 ZcROsIOzjf0m5SoajIPLl0m0MtWCAGoO2G/0IHkXZqx34IqeSWglL64oyPT/NCGNgbiy
 HVGnV/LXgoc9g2+UKDkWHZHnt9Jvwm+jwzQxpv1JG+sI/xJwouoZSRCqWqHOdA815eii
 7Aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764013576; x=1764618376;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tOvOegWh7Munx3fSN0wi/2oYkGIg7jneLjN/pk3sRhw=;
 b=K3hT7HWiGCc7WQPjrfo4JZny7tw6g8cCUUZ0euuCNDpf/lJ9L04wRFemze6m87IZg/
 TE4ENSRwnNdcfuYDtCgZtq6bultWBpf1DoTXyVYf5w/cGaR9ElSlAPQK8WmQ2FsfzRpF
 ivf+J5cdy03oxpHmv+i0V+Buo5jni/4wqdWMdJi31LZQa2PXNDzNzhvb6u7LO3y87EOB
 DZCCFH81bt3iLdDE/MLiViWmpIy990Pk7W4PWCl9fXxDdqifgv3Dtf5jp5Lo0qgwqYLy
 wvUAb3pOf2D9cGWZfKUzHoUOqlgsvbX5LwZzt0q4rvCjQnr/kl3qBn4sNEiHCu1k2uX9
 p+YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqyx4+Nmzsxzfyv2vS1qBJ9nKahMXExROOGQx+z1/ncbONtJeuP0Ir1nf3R59s1E6yzD3HfKFmvWNK@nongnu.org
X-Gm-Message-State: AOJu0YyaF8S071YxDnpXSDDDAlhPENsFhlOZ/+jRQKdXYOnsFzqCoaFv
 MBT2+qQJjDTCUZg51npe5Jz/JcSI0UK7HSfwxXrqjXWUtLYhYAwfW7KPpO3tUsxFpy0=
X-Gm-Gg: ASbGncuRKHhe+nNsj2+plTw9vkguMtW+nSUImygNsQzB8kGk4025dFVt0c+KQe22cb9
 he7XTrc/VAQuKbo2vy2OYdRQHsZabZ1hlQNafdkOnpdMzAmAkS7KPZHAQ/dmF737fDfZhZ+csxo
 pKld/BBlqvhMMVaznaqg0g3/zCa0VSgGyuCaPwDEOTiRqAHJzKRLV6whme56ExBAkrEudqzyBKW
 PnVyDzTuIRmmFDgYpS56uAYapkjfcR+YLxenJRvBBQAkKLHL4RgzyI0Uh+fI2KdUc9w7d7drMPY
 SDgex8uOKSCZH3xMsTKHZzOGYxzDN+/OVQoMBrH6KOKB+YberGGSx2GbeskkcTYL5fZkjttTjPr
 tYT9WHq+DquRIYA+9N/min5Cm8djhaugpMrbhExgaZN3r8OO8nqK5esAZ9r6iJM9VNfTNeZG7WA
 t48CzDc1fbvnfvhmiB9aG0sFxsik7k0wjiQ1QkdJZsiLnSe8/bwg==
X-Google-Smtp-Source: AGHT+IGZ1bldYrSvEOghB0iI0NBZWGjkMQ7W+dX/1C1bjWPgW0IfXT1Ue/9xMwkM+Aow4e0SgSlUFg==
X-Received: by 2002:a05:6a00:1ad2:b0:7a2:7237:79ff with SMTP id
 d2e1a72fcca58-7c58c4a4fe3mr12374724b3a.7.1764013576417; 
 Mon, 24 Nov 2025 11:46:16 -0800 (PST)
Received: from [192.168.0.4] (174-21-76-60.tukw.qwest.net. [174.21.76.60])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7c3f0b63dbcsm15469070b3a.50.2025.11.24.11.46.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 11:46:15 -0800 (PST)
Message-ID: <119ec250-2532-452d-a8f8-0fdbb2f1a8b8@linaro.org>
Date: Mon, 24 Nov 2025 11:46:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/arm: Enable ID_AA64MMFR4_EL1 register.
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
References: <20251120125833.123813-1-jim.macarthur@linaro.org>
 <20251120125833.123813-2-jim.macarthur@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251120125833.123813-2-jim.macarthur@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 11/20/25 04:54, Jim MacArthur wrote:
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>   target/arm/cpu-sysregs.h.inc | 1 +
>   target/arm/helper.c          | 4 ++--
>   2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~>
> diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
> index 2bb2861c62..2ba49d8478 100644
> --- a/target/arm/cpu-sysregs.h.inc
> +++ b/target/arm/cpu-sysregs.h.inc
> @@ -14,6 +14,7 @@ DEF(ID_AA64MMFR0_EL1, 3, 0, 0, 7, 0)
>   DEF(ID_AA64MMFR1_EL1, 3, 0, 0, 7, 1)
>   DEF(ID_AA64MMFR2_EL1, 3, 0, 0, 7, 2)
>   DEF(ID_AA64MMFR3_EL1, 3, 0, 0, 7, 3)
> +DEF(ID_AA64MMFR4_EL1, 3, 0, 0, 7, 4)
>   DEF(ID_PFR0_EL1, 3, 0, 0, 1, 0)
>   DEF(ID_PFR1_EL1, 3, 0, 0, 1, 1)
>   DEF(ID_DFR0_EL1, 3, 0, 0, 1, 2)
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 27ebc6f29b..c20334fa65 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6566,11 +6566,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                 .access = PL1_R, .type = ARM_CP_CONST,
>                 .accessfn = access_aa64_tid3,
>                 .resetvalue = GET_IDREG(isar, ID_AA64MMFR3) },
> -            { .name = "ID_AA64MMFR4_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
> +            { .name = "ID_AA64MMFR4_EL1", .state = ARM_CP_STATE_AA64,
>                 .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 4,
>                 .access = PL1_R, .type = ARM_CP_CONST,
>                 .accessfn = access_aa64_tid3,
> -              .resetvalue = 0 },
> +              .resetvalue = GET_IDREG(isar, ID_AA64MMFR4) },
>               { .name = "ID_AA64MMFR5_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
>                 .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 5,
>                 .access = PL1_R, .type = ARM_CP_CONST,


