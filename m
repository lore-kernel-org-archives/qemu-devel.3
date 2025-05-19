Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C31EC3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 12:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGzut-0005D0-JA; Mon, 19 May 2025 08:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uGzur-00058y-M4
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:48:26 -0400
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uGzun-0008Rd-59
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:48:25 -0400
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-86feb84877aso937745241.3
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 05:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1747658898; x=1748263698; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fuzWbFcRhLb2YxQqI9UvK1P+c54lpB0j2QHrbT7BLhE=;
 b=lYRM0OiPUy8g6o7J/py4a3JeR4I+qJsaJlyjmUxGjrqIZgLeawYxw0Gj+Al0UzWGfo
 PrwvVvoRlmClPRMqNmHOrBu1v0sQ9mFNeIFYBhwsc92lTB073tPZftHvvrQ4cSQ+/aW7
 1gethDsxIygZ/0VW9uRRBVLIST2y/C02dxqxDEyl/+CA2UZDzxGOf4J2MWs8n9KHnXk1
 hAOxjqlG8rHjET15dfDgbYhjKvfPu3lq+MdsJ+NJukeXM/Z/c2wrmUzUldjTZ0sgfqJP
 HtwNKSLQEyQDnyX4TfwNXMjbBabBuEWVVt3vv7n+oSgKPUG+DluTtYU9J5i+XCnzdTBO
 d64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747658898; x=1748263698;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fuzWbFcRhLb2YxQqI9UvK1P+c54lpB0j2QHrbT7BLhE=;
 b=etLVMCfBZnGvs68sZJ1DrfC9kYZMBd2Y3NE3Sz8efLRPl5TVNZ7h5gTXoQ1doSColK
 iAgj/5AUNYwpbfQW780NkYRZTAYhjtsE9QmogVGgURSUSnLDOZtHv3FIrSMkFcbFkQ7C
 P4CINjeya93dx7tE30AqYrGcmzSAkPyAWy3bmyVjXWc1TbF4m0rnQEOTVEqyL5xcq2Nx
 ODr/p42nAqDzAqjVeWTV6F7+aNVwUxNDzDTp9ox8R/OryL9ekGP3y+oSWity/V0H3cU0
 sa7RHey21hUZaUwgmngzLcMARM01RW+ZfxrxBTOf1j7VjQIDG6PVMQp7Wt7atr8GM7Sj
 wLkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFkvooNa9NC/izQTshgwdXomUh0PyCSXeMmLCM7RYli3eZaw+Os3rckVGeN+EfOLfuLGM3F8T+TChT@nongnu.org
X-Gm-Message-State: AOJu0YxN3xcmUrqC8HJHMBaIAGOm8viQ6zju1zQKmTTrt4GiwSI6ohkP
 cylYMi4N+imhJiBWKviqLEn+xv9JA0nbT/bua2JqKEbaQOhveDH3pONRLwqdaoZDzVU=
X-Gm-Gg: ASbGncvBKRdElDOzFXDOG6Yx4e1Y6hMaKF8W4MtKOeMq2/OUSIvuCzMd7KkHg/MHr82
 VYtqSiGU5P2MHEd8x2isIxrGKTopvzz3ViGsvrth3hJAkGiedW0FSXpGwa/2gfB3SSKfsUSQoWT
 Y7oZgN4zK993FO61xQPfpAFBX7SIHgoo5Y3/ZeRuXZT8WNeIPxiCiAwc0M5XAJskrLXGKL+Itgc
 QG5MvflrJ6siugV45vnN/rd11mkRWcmNFFlsUeP5LHZ0CxPrTVAemQn2ibXZFoUHqKvpUWv1zt8
 P5qLpLZrR3mzT4fwJSLajbfj/EGcNpP+pH2P/PS2X+X6gmRsgJx4aEJaIE9Utc36ZRo=
X-Google-Smtp-Source: AGHT+IE5wQAZnxgje0AJwV07zZvKQd3kwT7hNQRKmOqiCCYe57UpctIIGnw0r6jZmI+0Cj53A6mT1Q==
X-Received: by 2002:a05:6122:d19:b0:529:2644:8c with SMTP id
 71dfb90a1353d-52dbcdfccb7mr8564891e0c.8.1747658897968; 
 Mon, 19 May 2025 05:48:17 -0700 (PDT)
Received: from [192.168.68.110] ([152.250.131.100])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-52dbab4e983sm6534167e0c.31.2025.05.19.05.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 May 2025 05:48:17 -0700 (PDT)
Message-ID: <e86af5b2-7d8a-4503-8a5c-5ee2147aa850@ventanamicro.com>
Date: Mon, 19 May 2025 09:48:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] target: riscv: Fix satp mode initialization based on
 profile
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20250516122319.4100121-1-alexghiti@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250516122319.4100121-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ua1-x931.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 5/16/25 9:23 AM, Alexandre Ghiti wrote:
> The satp mode is set using the svXX properties, but that actually
> restricts the satp mode to the minimum required by the profile and
> prevents the use of higher satp modes.

For rva23s64, in "Optional Extensions" we'll find:

https://github.com/riscv/riscv-profiles/blob/main/src/rva23-profile.adoc

- Sv48 Page-based 48-bit virtual-memory system.
- Sv57 Page-based 57-bit virtual-memory system.

So in theory we could go up to sv57 for rva23s64 (and rva22s64, just checked).
Changing satp_mode to the maximum allowed seems sensible.

But allowing all satp modes to go in a profile defeats the purpose, doesn't it?
None of the existing profiles in QEMU claims supports sv64. Granted, I'm not a
satp expert, but removing the satp restriction in profiles doesn't seem right.


Thanks,

Daniel


> 
> Fix this by not setting any svXX property and allow all satp mode to be
> supported.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>   target/riscv/tcg/tcg-cpu.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 5aef9eef36..ca2d2950eb 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1232,9 +1232,6 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
>   #ifndef CONFIG_USER_ONLY
>       if (profile->satp_mode != RISCV_PROFILE_ATTR_UNUSED) {
>           object_property_set_bool(obj, "mmu", true, NULL);
> -        const char *satp_prop = satp_mode_str(profile->satp_mode,
> -                                              riscv_cpu_is_32bit(cpu));
> -        object_property_set_bool(obj, satp_prop, profile->enabled, NULL);
>       }
>   #endif
>   


