Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9967C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 12:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYP1l-0003wW-2C; Thu, 16 Jan 2025 07:31:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tYP1i-0003vb-CT
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 07:31:10 -0500
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tYP1e-0001CH-26
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 07:31:10 -0500
Received: by mail-oo1-xc43.google.com with SMTP id
 006d021491bc7-5f2dee7d218so360148eaf.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 04:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1737030659; x=1737635459; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SPCmTHJ30+Z0P1UK1SYBdnSWIoFkUkGXia6Kn2gnWy0=;
 b=ID4/BN2gayaVQf/I3VxCaXuTaTpWUws0HcRolO4D3wwqG6hZKowkQeYRNKIs9LWKW/
 Mpe5YdmetwyOHBsLRDlgeSjLVE4NSKZybcjPkbbf05fOi9S0xtxkuj9L0HOEwZJYK6ch
 CddskU+HSlAkfzrXppMxAGh4dkffUW0TE1DzQlsn/WgiS+4shY4qN7YDS1SpxXH2xyBG
 /Oz7HO+NLuwXqDxdmrw7vlRvrdMEwrgSQIG6/f4KOS9wPs8XfwVMdQlSx3kZnmXkIQyZ
 1adyXAB+C060g5GWmSO9E9OG9XCwe4qyUjLk4GUIjRKqbli8OlFYkFVJCo9CjuR7b1/D
 EnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737030659; x=1737635459;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SPCmTHJ30+Z0P1UK1SYBdnSWIoFkUkGXia6Kn2gnWy0=;
 b=DckY4beh4+vz0l32Dxdx5+3xW6Nj2XHwmXUqyhZeZ1I7xgNFOXSYEo0KyPNwCk3I31
 VLc4HlJDju88CCBtEFm83Rao1JIfFxC0i9Ui1boqXPUuiGlsK4V6SqJZAi21Z4J4/Mwc
 s1E3Dp/vwIUYtaC3cM7RqLAZL6FVNvWwLHPkHVICYsels2hQdjkivn9FwdjRx1GqNfHZ
 Xd4e+EdBhOGLxRuAqBSSp5P0CBGU0DFgsn0lJWFBED+3PUxUx/bQlAImCzr1LA1orD+Z
 zALv2zC5rfvBbjTRFYZaXwVzn4hkAWnPLZiq2CqBOCKGnRcrZPzW+sHZmjbdRfN6KmWF
 o6mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk0cLJkmX3LGYD1rHVFeISpSP24FRScy+gBNYf3jldO2P1qSMqaQkIn7QuO+Un6tiHQ+ga1M96OnnF@nongnu.org
X-Gm-Message-State: AOJu0YwsErgDBaT8tsfYIjCkgFScQuGmQemZP8bcpjZfrTd6R3b8gttQ
 CO15ChnQxrqBpKQ2GvG7LmJwrU79ibD+T5DW1jWty82PeKj9e/MI5gVyrq/QM4g=
X-Gm-Gg: ASbGncu7H8btN6Dx7/uqcAOofq+PxQyom2eqgdVKcmtBHmgMsgRvcJxKPPyBGDnhRs1
 FU3KJ6W4XjuyUOupHiEgFTpQ1S8Z8r4A07+UyXb809hI202Wmk24UrbTl3mPAgcUvIhHTxley8A
 I3FjFfOM7HtI0gxD5kUFVQLuPoYCP2cR54/Pdn4rTBsIPOwFd0y1UZI9YklT1syCUreutxVR4JP
 ogEVakKVwqOBBUcCQH6umDUgdbSN2HqeEM9OPC1RmIiZPZ4EmR0b/2MV3hKcpF8cAkqJjk=
X-Google-Smtp-Source: AGHT+IE7wl4YuZItxTjDj/1ruvAQAQzbgS4LvbC1/QAlid7NU8gis0U7HISlsnpUvJEz3IzQziJ/zg==
X-Received: by 2002:a05:6820:4d02:b0:5f8:91b0:6c0f with SMTP id
 006d021491bc7-5f891b06d2amr14225383eaf.6.1737030658914; 
 Thu, 16 Jan 2025 04:30:58 -0800 (PST)
Received: from [192.168.68.110] ([191.202.238.10])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f882641dc9sm6677161eaf.13.2025.01.16.04.30.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 04:30:57 -0800 (PST)
Message-ID: <4fc33d8d-e443-43c3-9809-7f9c025f2883@ventanamicro.com>
Date: Thu, 16 Jan 2025 09:30:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/riscv: Fix the hpmevent mask
To: Atish Patra <atishp@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 bin.meng@windriver.com, alistair.francis@wdc.com
References: <20250115-pmu_minor_fixes-v1-0-c32388defb02@rivosinc.com>
 <20250115-pmu_minor_fixes-v1-1-c32388defb02@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250115-pmu_minor_fixes-v1-1-c32388defb02@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc43.google.com
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



On 1/15/25 9:49 PM, Atish Patra wrote:
> As per the latest privilege specification v1.13[1], the sscofpmf
> only reserves first 8 bits of hpmeventX. Update the corresponding
> masks accordingly.
> 
> [1]https://github.com/riscv/riscv-isa-manual/issues/1578
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu_bits.h | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index f97c48a3943f..b48c0af9d48e 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -9,6 +9,10 @@
>                    (((uint64_t)(val) * ((mask) & ~((mask) << 1))) & \
>                    (uint64_t)(mask)))
>   
> +#ifndef GENMASK_ULL
> +#define GENMASK_ULL(h, l) (((~0ULL) >> (63 - (h) + (l))) << (l))
> +#endif
> +
>   /* Extension context status mask */
>   #define EXT_STATUS_MASK     0x3ULL
>   
> @@ -933,9 +937,8 @@ typedef enum RISCVException {
>                                               MHPMEVENTH_BIT_VSINH | \
>                                               MHPMEVENTH_BIT_VUINH)
>   
> -#define MHPMEVENT_SSCOF_MASK               _ULL(0xFFFF000000000000)
> -#define MHPMEVENT_IDX_MASK                 0xFFFFF
> -#define MHPMEVENT_SSCOF_RESVD              16
> +#define MHPMEVENT_SSCOF_MASK               GENMASK_ULL(63, 56)
> +#define MHPMEVENT_IDX_MASK                 (~MHPMEVENT_SSCOF_MASK)
>   
>   /* RISC-V-specific interrupt pending bits. */
>   #define CPU_INTERRUPT_RNMI                 CPU_INTERRUPT_TGT_EXT_0
> 


