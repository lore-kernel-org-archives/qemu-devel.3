Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FE0EF8FF6
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 15:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxo8a-0001hn-T2; Wed, 04 Mar 2026 10:27:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vxo8T-0001an-R0
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:27:43 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vxo8R-0006HU-45
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:27:40 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-439b611274bso2328018f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 07:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772638057; x=1773242857; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uYVVLFYOktXbOXFFF4JHxfLZgR0j24wC8TddASTLjNY=;
 b=FCFO7BmoFXfUk0L/avHIHeLNDdwH883R9T+uwbq/w+CQw4SfqN+poYNHiNCqI1wyTp
 oihndEYLrldgdjFeh6a5yA9PTZMDKT59CgLHbYwlnJ9PzHz76+obLoW6h5fN5xb3NgbY
 YEZIWi0KC2KlpH4tNEPO2K1y13NyhPRp5MmpPto1XANRBE1RsQ/NGVgkyArebuRPhLS7
 SFWE1IcGdQ95zDEekUD3i/YQLOVpUHR6Ndl79WWT1EttZBw9OLdgxnbIwAI+xFvKktid
 bB83PJ3WMwxQVEWh65eOR1twEsOIAPrPupA/d21xhrTx2Tt7RzAJahc09stZQ8BlAEX8
 fBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772638057; x=1773242857;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uYVVLFYOktXbOXFFF4JHxfLZgR0j24wC8TddASTLjNY=;
 b=m6BUiotFLP1boKWUY9FL5IYFfyXiUe8J+uQSRTpJ8Y1J0z7XRBjsVlRSXIvvnnW/FB
 sar+vYVXNMhxj9fcaOMTXlQ/SMoA5uUvD5mX0rQPEgO6wWl1wPgQ+8IsHptgzlawbv+d
 sq4BgdxQrMFpJ2OzLPuXQ6RJiSX5FGz14/EWTdJPPd6QzY0E6uCw2svp+xR7/AAkYiVD
 UtR6og9aFWtEu/Lc085UyFDkk5s4Yg58CfSo7a9d/XfJK03QHuISejkL3JF8jn9FFxxj
 sxCPZlWBIpFJCZD1AtUxLH9MT1BBuHyjws1x1YNgdJ2ySRQHc4yChs6Co4eOnjplW+hN
 5yEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr8NDccy+VijVI0POO+pJDTqP2RPA5FphXAPIsqy73ftsmHkawPnI//ydTm5MycPSv1b0KyA/gHlQP@nongnu.org
X-Gm-Message-State: AOJu0Ywq9FOf6E3MHF1BXCRaSfseDl1TYSbEa47bS3574K8MIfaYn2Jb
 utvrjUlBRfj0Umi/H1+AkWzCx6l014BC4E2xJ5HJzFKp6wAOMpjq9uVtyQkrQJOm7PWZU806TGH
 pE8lTigI=
X-Gm-Gg: ATEYQzxyoLWq830OHkmK+Aosvm2wDvYb4b6RH8Dw2tqdpXn2VlltPHfuJgO4IURYnhW
 YQTlReAs1petex0L7aP9bGtqkHMUQU+66C8xKgh0mN7QPqcD9db1WAsrpFsZkSHOMo8dGSWiInd
 TR6e79u6vgzYVRu1R+2G1wsFBvtBsqkZqxxpVEGjbJMK1lJTK8P8yvps5viUKgVI2EXJSNG7xYX
 zZj7jDS0+QEhzXG2/91+Jm5MmY9GQv8CKKLh7/khwSASLvyp7fH/A8u+l+uyPZt2ZVODdwiSh6P
 labSvUWmeJQMgwY0l+oqEzReOFBLFf7K3gQbjdaAg5wIYtXlc/rBJLQ4IkO2z7VuwVWT54O5a3s
 ggewv4Yj1sZaY1m0lOxBZcS2GDY+gQ6Gh1/9fuqmKoOcsDn/4YKlmM8NVTnSBb2Z5o4lYvrQBc4
 IQBv0/4i6kkmySqXtB/DojtlDyHDjHc1ibgev0pkMlnpBoGs9BokCmEsUfKDJLIWUZKQ==
X-Received: by 2002:a05:6000:26d2:b0:439:9312:4b6d with SMTP id
 ffacd0b85a97d-439c7f79ea1mr4797876f8f.20.1772638056948; 
 Wed, 04 Mar 2026 07:27:36 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b272sm42562290f8f.24.2026.03.04.07.27.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2026 07:27:36 -0800 (PST)
Message-ID: <9a30c7c5-17d2-4767-b874-c1bb698e905a@linaro.org>
Date: Wed, 4 Mar 2026 16:27:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] hppa: Get physical address space bits from
 HPPACPUDef
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
References: <20260303-hppa-c3600-v5-0-277bfe6b40b8@rev.ng>
 <20260303-hppa-c3600-v5-3-277bfe6b40b8@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260303-hppa-c3600-v5-3-277bfe6b40b8@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/3/26 17:11, Anton Johansson via qemu development wrote:
> Reviewed-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/hppa/cpu.h        | 11 ++++++++---
>   hw/hppa/machine.c        |  4 ++--
>   hw/pci-host/astro.c      |  2 +-
>   target/hppa/cpu.c        |  9 ++++++++-
>   target/hppa/mem_helper.c | 39 +++++++++++----------------------------
>   5 files changed, 30 insertions(+), 35 deletions(-)


> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index 5d0d4de09e..bb6b7dc76c 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -181,12 +181,12 @@ static uint64_t linux_kernel_virt_to_phys(void *opaque, uint64_t addr)
>   
>   static uint64_t translate_pa10(void *dummy, uint64_t addr)
>   {
> -    return hppa_abs_to_phys_pa1x(addr);
> +    return hppa_abs_to_phys_pa1x(cpu_env(first_cpu), addr);

I'm not keen of these @first_cpu uses (for heterogeneous emulation
we want to restrict this variable to accel/, and poison it elsewhere
like in hw/). Can we resolve earlier or pass CPUState* around?

>   }
>   
>   static uint64_t translate_pa20(void *dummy, uint64_t addr)
>   {
> -    return hppa_abs_to_phys_pa2_w0(addr);
> +    return hppa_abs_to_phys_pa2_w0(cpu_env(first_cpu), addr);
>   }
>   
>   static HPPACPU *cpu[HPPA_MAX_CPUS];
> diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
> index 00a904277c..d38f81e553 100644
> --- a/hw/pci-host/astro.c
> +++ b/hw/pci-host/astro.c
> @@ -303,7 +303,7 @@ static IOMMUTLBEntry astro_translate_iommu(IOMMUMemoryRegion *iommu,
>        * language which not-coincidentally matches the PSW.W=0 mapping.
>        */
>       if (addr <= UINT32_MAX) {
> -        entry = hppa_abs_to_phys_pa2_w0(addr);
> +        entry = hppa_abs_to_phys_pa2_w0(cpu_env(first_cpu), addr);
>       } else {
>           entry = addr;
>       }
> - *   CPU model        Physical address space bits
> - *   PA-7000--7300LC  32
> - *   PA-8000--8600    40
> - *   PA-8700--8900    44
> - *
> - * FIXME: However, the SeaBIOS firmware that is that tested against
> - * uses 40-bit physical addresses, despite supposedly running a C3700
> - * with a PA-8700 cpu, so use 40-bits for 64-bit.
> - */
> -#define HPPA_PHYS_ADDR_SPACE_BITS_PA20 40
> -#define HPPA_PHYS_ADDR_SPACE_BITS_PA1X 32
> -
> -hwaddr hppa_abs_to_phys_pa1x(vaddr addr)
> +hwaddr hppa_abs_to_phys_pa1x(CPUHPPAState *env, vaddr addr)
>   {
> -    return extract64(addr, 0, HPPA_PHYS_ADDR_SPACE_BITS_PA1X);
> +    return extract64(addr, 0, hppa_phys_addr_bits(env));
>   }
>   
> -hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr)
> +hwaddr hppa_abs_to_phys_pa2_w1(CPUHPPAState *env, vaddr addr)
>   {
>       /*
>        * Figure H-8 "62-bit Absolute Accesses when PSW W-bit is 1" describes
> @@ -64,11 +47,11 @@ hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr)
>        * Since the supported physical address space is below 54 bits, the
>        * H-8 algorithm is moot and all that is left is to truncate.
>        */
> -    QEMU_BUILD_BUG_ON(HPPA_PHYS_ADDR_SPACE_BITS_PA20 > 54);
> -    return sextract64(addr, 0, HPPA_PHYS_ADDR_SPACE_BITS_PA20);
> +    const uint8_t pa = hppa_phys_addr_bits(env);
> +    return sextract64(addr, 0, pa);
>   }
>   
> -hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr)
> +hwaddr hppa_abs_to_phys_pa2_w0(CPUHPPAState *env, vaddr addr)
>   {
>       /*
>        * See Figure H-10, "Absolute Accesses when PSW W-bit is 0",
> @@ -89,7 +72,7 @@ hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr)
>            * is what can be seen on physical machines too.
>            */
>           addr = (uint32_t)addr;
> -        addr |= -1ull << (HPPA_PHYS_ADDR_SPACE_BITS_PA20 - 4);
> +        addr |= -1ull << (hppa_phys_addr_bits(env) - 4);
>       }
>       return addr;
>   }
> @@ -233,13 +216,13 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
>       if (MMU_IDX_MMU_DISABLED(mmu_idx)) {
>           switch (mmu_idx) {
>           case MMU_ABS_W_IDX:
> -            phys = hppa_abs_to_phys_pa2_w1(addr);
> +            phys = hppa_abs_to_phys_pa2_w1(env, addr);
>               break;
>           case MMU_ABS_IDX:
>               if (hppa_is_pa20(env)) {
> -                phys = hppa_abs_to_phys_pa2_w0(addr);
> +                phys = hppa_abs_to_phys_pa2_w0(env, addr);
>               } else {
> -                phys = hppa_abs_to_phys_pa1x(addr);
> +                phys = hppa_abs_to_phys_pa1x(env, addr);
>               }
>               break;
>           default:
> @@ -580,7 +563,7 @@ static void itlbt_pa20(CPUHPPAState *env, target_ulong r1,
>       /* Align per the page size. */
>       ent->pa &= TARGET_PAGE_MASK << mask_shift;
>       /* Ignore the bits beyond physical address space. */
> -    ent->pa = sextract64(ent->pa, 0, HPPA_PHYS_ADDR_SPACE_BITS_PA20);
> +    ent->pa = sextract64(ent->pa, 0, hppa_phys_addr_bits(env));
>   
>       ent->t = extract64(r2, 61, 1);
>       ent->d = extract64(r2, 60, 1);
> 


