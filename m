Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29D9C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 12:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tevFc-0004iX-Cv; Mon, 03 Feb 2025 07:08:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tevFa-0004iJ-5m
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 07:08:26 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tevFW-0002FK-9O
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 07:08:24 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so84155925ad.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 04:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1738584500; x=1739189300; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aajia+cW/X4YxbxWcfrYWv+FJJ1bSui7r9ZaOLQS54c=;
 b=Nw5xlmqHHXBovRIk2QTVmbykJO5x2shH+o+1f8FaaYiI3NyYIL8q1WGHf4/1KhwqVx
 GN5Zvv+PbI5LFquYlMq122toGpI71dI5i40T5JKSej0VszJGhYapCDw51Gs+1MaI4DM/
 Nv9TNWzRWfYN6mL9lEW7opoJwhHcLfVgL1R8PWNZa3ieRnHH8wSWZr88r+khULqMJgkf
 sPqX4Zyi2uwmSDtjKFx37lYiN3Yr2SHiWylyyoVqW9+y6Sgy01Lhcv8bifjkhGPDwWno
 87OLBv29XxpOXs5Ll7KUYK4FvhQQDuOE3GptU/Hkz6j7o82Y8IYqX20XLdIg5DAlnZTU
 oc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738584500; x=1739189300;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aajia+cW/X4YxbxWcfrYWv+FJJ1bSui7r9ZaOLQS54c=;
 b=CJoF7EPMIA1fvx36grgh8UdFbNb2cI9jUyhD/D0guCWQvAsSIKWF/54GNmZJRwehcj
 +3hqDCfMupiEWM7YZX11YA14Y2AGVfQX96/BDmIHL+VEBzVnMfVwR8LtxweL3ccRHPGr
 EXYELEfet6pL2sxUzb3lPWop1dCn68/IENSrwykNv7T32pMmi4N0k3aHGlD4xWHlMi5Q
 +cIh1q36/rreY9sNz26GkIV2UIG/zBaPTH98Y9i8OzW1mY3rYGg2hPa7UPZ0gt4LBNII
 s8mryRqbYF5eZ8E15+8u/ihgVdki3x5CtS1AGbABj0gL5EHO84NF5y0yrftCGBObQuT2
 CkxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7EaDH6v6De7Vrc9OTNp4WL2FwAJ8XMzuAUgi2PibR/3Dt2JnVEqy42H2vRxsuhWlXdyku9psUFc8r@nongnu.org
X-Gm-Message-State: AOJu0YwZ67l46GTd0Ixmne1TT9ZJ8lZdVuo3AMHNm264K/tZJDXvd701
 huJGymcCklXzLzvCHnGMjzj8I19TcvlUM1ArCfLJud/e9b+P1yK+MEqBrX5oaFs=
X-Gm-Gg: ASbGncserZWir9+Z7FtTU7kc7bo9bsblm0EDawyXS5Pe+9rR1gt/CeKF4RER5O8jXwf
 bHYpVHTLI60QZnHMlWdiq/WgD52Fdto2GpsFC4tDCMVbbMI0eBv+/RALLFHFsk6+rksacDiWy9z
 Gfy2e+WZMAKzZYFL7Pw2P2sQeAo7KZztyJu9YSYJayPO+j4qToB0TvXAoHT3ruUPJw3jr1Iaj3m
 9QDzllg6zWiYm6bdvbWDTkYoDb6z9JSfCXlvoJlnODyFKRJGEsV7JtYnbpNyx7fowZknvFlVDZ2
 Tis87cOmiLsXGaSDNCu/VsFyWICyx48=
X-Google-Smtp-Source: AGHT+IGQXrZF/+FyMz80ZwY0mbSEE/Q/UdMAw2wcl7sSrl5nMiSRhauPKa+2h/dEOcFmVLhHZs7GBg==
X-Received: by 2002:a05:6a00:2c88:b0:725:d1d5:6d86 with SMTP id
 d2e1a72fcca58-72fd0c5b298mr33293901b3a.19.1738584500084; 
 Mon, 03 Feb 2025 04:08:20 -0800 (PST)
Received: from [192.168.68.110] ([177.170.227.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe631bea6sm8243879b3a.22.2025.02.03.04.08.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 04:08:19 -0800 (PST)
Message-ID: <1bef9927-59fa-4c22-987a-29f80cd44a1f@ventanamicro.com>
Date: Mon, 3 Feb 2025 09:08:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] target/riscv: log guest errors when reserved bits
 are set in PTEs
To: julia <midnight@trainwit.ch>, qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <alistair.francis@wdc.com>
References: <20250203061852.2931556-1-midnight@trainwit.ch>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250203061852.2931556-1-midnight@trainwit.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
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



On 2/3/25 3:18 AM, julia wrote:
> For instance, QEMUs newer than b6ecc63c569bb88c0fcadf79fb92bf4b88aefea8
> would silently treat this akin to an unmapped page (as required by the
> RISC-V spec, admittedly). However, not all hardware platforms do (e.g.
> CVA6) which leads to an apparent QEMU bug.
> 
> Instead, log a guest error so that in future, incorrectly set up page
> tables can be debugged without bisecting QEMU.
> 
> Signed-off-by: julia <midnight@trainwit.ch>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu_helper.c | 27 ++++++++++++++++++++++++++-
>   1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index e1dfc4ecbf..3dd8e06044 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1226,14 +1226,27 @@ restart:
>               ppn = pte >> PTE_PPN_SHIFT;
>           } else {
>               if (pte & PTE_RESERVED) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "%s: reserved bits set in PTE: "
> +                              "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
> +                              __func__, pte_addr, pte);
>                   return TRANSLATE_FAIL;
>               }
>   
>               if (!pbmte && (pte & PTE_PBMT)) {
> +                /* Reserved without Svpbmt. */
> +                qemu_log_mask(LOG_GUEST_ERROR, "%s: PBMT bits set in PTE, "
> +                              "and Svpbmt extension is disabled: "
> +                              "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
> +                              __func__, pte_addr, pte);
>                   return TRANSLATE_FAIL;
>               }
>   
>               if (!riscv_cpu_cfg(env)->ext_svnapot && (pte & PTE_N)) {
> +                /* Reserved without Svnapot extension */
> +                qemu_log_mask(LOG_GUEST_ERROR, "%s: N bit set in PTE, "
> +                              "and Svnapot extension is disabled: "
> +                              "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
> +                              __func__, pte_addr, pte);
>                   return TRANSLATE_FAIL;
>               }
>   
> @@ -1244,14 +1257,19 @@ restart:
>               /* Invalid PTE */
>               return TRANSLATE_FAIL;
>           }
> +
>           if (pte & (PTE_R | PTE_W | PTE_X)) {
>               goto leaf;
>           }
>   
> -        /* Inner PTE, continue walking */
>           if (pte & (PTE_D | PTE_A | PTE_U | PTE_ATTR)) {
> +            /* D, A, and U bits are reserved in non-leaf/inner PTEs */
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: D, A, or U bits set in non-leaf PTE: "
> +                          "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
> +                          __func__, pte_addr, pte);
>               return TRANSLATE_FAIL;
>           }
> +        /* Inner PTE, continue walking */
>           base = ppn << PGSHIFT;
>       }
>   
> @@ -1261,10 +1279,17 @@ restart:
>    leaf:
>       if (ppn & ((1ULL << ptshift) - 1)) {
>           /* Misaligned PPN */
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: PPN bits in PTE is misaligned: "
> +                      "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
> +                      __func__, pte_addr, pte);
>           return TRANSLATE_FAIL;
>       }
>       if (!pbmte && (pte & PTE_PBMT)) {
>           /* Reserved without Svpbmt. */
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: PBMT bits set in PTE, "
> +                      "and Svpbmt extension is disabled: "
> +                      "addr: 0x%" HWADDR_PRIx " pte: 0x" TARGET_FMT_lx "\n",
> +                      __func__, pte_addr, pte);
>           return TRANSLATE_FAIL;
>       }
>   


