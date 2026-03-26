Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33FD109E532
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 00:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5YJk-0006cK-1p; Wed, 25 Mar 2026 20:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5YJf-0006bG-Vn
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 20:11:16 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5YJd-00056T-ST
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 20:11:15 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-35a1d4a095bso185870a91.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 17:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774483872; x=1775088672; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zsdbFb6u4zMw4YYIK6WG0OUIGJX/ypnFMA0i5wr7wpU=;
 b=bhFFe9oAMOPqbHvueGOOARj2MDe7frg1W3HSR+qYBlfWR/erGuD7PDm5daQ9nkEmIc
 UMbAHSb6OBJWHYHkmBuw3u/Uklse0hCIYomrzeAVO1vGnYUjGDVlzLZU8Rkt8O5sjhPq
 yE3iwbbB/ShuLJEGz3j2aUhQ75P8dhyN4npxHJszckD9fUrxsbElfrcAalpRMdqNQJNE
 VqmdbqoNAREbyaiQ57iS+HoVB+chCabhIuLwCBHlX5/MT+HKRteFlTIVWlDf8vL+twqW
 XzEkV9PCj8WM/9TACjJRkgUZtftWzf9nL4NKR8vjWjCcqj1j/W5Q+FAE+fvBcb5sIXNT
 G7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774483872; x=1775088672;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zsdbFb6u4zMw4YYIK6WG0OUIGJX/ypnFMA0i5wr7wpU=;
 b=C/31nMRzKAY9FqFb9ZWfaDtBl9x8l+ZNeokDTwLpsPjklHDt6JE7bp/faQ3KwieMJ5
 OT4rCkigJ6GRxJ0jott4Ro2ibT31jIaWWpTe5AgsTuAa1D4JqymOVg0/AgtLJErCirW+
 FexEIYX/WmaHfb+LsAwA5btEhXmD513GQioVOClO71Bfs6zDLSMQM+2Tde0sr0rIiUuo
 gJL0G+rUzHdxePmxAR6l6GeTie777lFVBQbsqEJzSTDLvcrxmdpbyXtUvoRNGcSipl7c
 5OFxl4pFqfxaVnibVVm5uw6AyAGHsqHtuawXxMicubUgXVlG+zf+2t3gpSXKlqhPIi5l
 sJIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn6dEq74hiWOO+RjbAcniwjineFxAb4hYzmPx/AMSM4CZq3umsvUenzETrwgdyDt8g5DxfHAlVMJAF@nongnu.org
X-Gm-Message-State: AOJu0Yw7G3w3LxjvLxaYSGhCzD8l8MmbaE2DaXGgp4JyDrrSTgRYBxmG
 PeOg6vhgCHc6GSjvT+0OMPzkE8eA4TmMqkZ8w9CGecZLUmm95xredkqW/knOmKiJoVA=
X-Gm-Gg: ATEYQzwLlCdNxW3YpsKWPwntaWSOS338U8OyjaD3o/DwrC6gM+JCtV+K58q7x48GbIv
 mREuLtN9FpcC1C6MIVVRriBklpp1Mt/I4v83YmodgVo5c1LDXzUk31nSwjYontNZGaT5vtqwB41
 gRmlIp/0I3kcP5OVWQ8ehM+BIn2MUvG6ZcAqsFy76iJtUmu55uW83LYqmpODLbJZSWpPQ377bSH
 miZwRIREGroDu/VNAdt65HsgxlKFS+o3JkhqEpMzecEiiwlCz8P2fUyMvLc1Jk6sSfllKmsRYkU
 bbqdxGA4dxh1lYQM/xgQN89ts22BDzF7T2IxjEqrE7RXifk9WIz75H/PhH1JvfmuD99EJD9Xr4q
 7BGKQ0KHBoffFTNVWbE/PYv6y5nSRGk534X1nMoppG7a5vZt/p10FrZTehKqKT/innbCH2LU/MF
 ZlbU9LK4uuAk2N4FeexG7z+lSzW0rMid0aUTAo4tYzNL/V1sm6p7Vy
X-Received: by 2002:a17:90b:3c07:b0:35b:a0f0:8327 with SMTP id
 98e67ed59e1d1-35c0d1001a9mr4618261a91.2.1774483871884; 
 Wed, 25 Mar 2026 17:11:11 -0700 (PDT)
Received: from [172.16.11.156] ([103.100.225.140])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c031403e4sm7630987a91.6.2026.03.25.17.11.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 17:11:11 -0700 (PDT)
Message-ID: <54c17a64-a7dc-436a-b2a8-724537f6e68c@linaro.org>
Date: Thu, 26 Mar 2026 10:11:05 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] hw/alpha/typhoon: Fix whitespace and block comment
 style problems
To: Yodel Eldar <yodel.eldar@yodel.dev>, qemu-devel@nongnu.org
References: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
 <20260310-qomify-alpha-v1-1-4375b00a85ff@yodel.dev>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260310-qomify-alpha-v1-1-4375b00a85ff@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 3/11/26 08:31, Yodel Eldar wrote:
> Eliminate trailing whitespaces.
> 
> Use leading "/*", internal "*", and trailing "*/" for block comments.
> 
> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
> ---
>   hw/alpha/typhoon.c | 84 +++++++++++++++++++++++++++++++++---------------------
>   1 file changed, 52 insertions(+), 32 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
> index 7722d4fd00..f392772500 100644
> --- a/hw/alpha/typhoon.c
> +++ b/hw/alpha/typhoon.c
> @@ -34,7 +34,7 @@ typedef struct TyphoonWindow {
>       uint64_t wsm;
>       uint64_t tba;
>   } TyphoonWindow;
> -
> +
>   typedef struct TyphoonPchip {
>       MemoryRegion region;
>       MemoryRegion reg_iack;
> @@ -84,8 +84,10 @@ static MemTxResult cchip_read(void *opaque, hwaddr addr,
>       switch (addr) {
>       case 0x0000:
>           /* CSC: Cchip System Configuration Register.  */
> -        /* All sorts of data here; probably the only thing relevant is
> -           PIP<14> Pchip 1 Present = 0.  */
> +        /*
> +         * All sorts of data here; probably the only thing relevant is
> +         * PIP<14> Pchip 1 Present = 0.
> +         */
>           break;
>   
>       case 0x0040:
> @@ -188,7 +190,7 @@ static MemTxResult cchip_read(void *opaque, hwaddr addr,
>       case 0x0780:
>           /* PWR: Power Management Control.   */
>           break;
> -
> +
>       case 0x0c00: /* CMONCTLA */
>       case 0x0c40: /* CMONCTLB */
>       case 0x0c80: /* CMONCNT01 */
> @@ -440,7 +442,7 @@ static MemTxResult cchip_write(void *opaque, hwaddr addr,
>       case 0x0780:
>           /* PWR: Power Management Control.   */
>           break;
> -
> +
>       case 0x0c00: /* CMONCTLA */
>       case 0x0c40: /* CMONCTLB */
>       case 0x0c80: /* CMONCNT01 */
> @@ -605,8 +607,10 @@ static const MemoryRegionOps pchip_ops = {
>       },
>   };
>   
> -/* A subroutine of typhoon_translate_iommu that builds an IOMMUTLBEntry
> -   using the given translated address and mask.  */
> +/*
> + * A subroutine of typhoon_translate_iommu that builds an IOMMUTLBEntry
> + * using the given translated address and mask.
> + */
>   static bool make_iommu_tlbe(hwaddr taddr, hwaddr mask, IOMMUTLBEntry *ret)
>   {
>       *ret = (IOMMUTLBEntry) {
> @@ -618,8 +622,10 @@ static bool make_iommu_tlbe(hwaddr taddr, hwaddr mask, IOMMUTLBEntry *ret)
>       return true;
>   }
>   
> -/* A subroutine of typhoon_translate_iommu that handles scatter-gather
> -   translation, given the address of the PTE.  */
> +/*
> + * A subroutine of typhoon_translate_iommu that handles scatter-gather
> + * translation, given the address of the PTE.
> + */
>   static bool pte_translate(hwaddr pte_addr, IOMMUTLBEntry *ret)
>   {
>       uint64_t pte = address_space_ldq_le(&address_space_memory, pte_addr,
> @@ -633,8 +639,10 @@ static bool pte_translate(hwaddr pte_addr, IOMMUTLBEntry *ret)
>       return make_iommu_tlbe((pte & 0x3ffffe) << 12, 0x1fff, ret);
>   }
>   
> -/* A subroutine of typhoon_translate_iommu that handles one of the
> -   four single-address-cycle translation windows.  */
> +/*
> + * A subroutine of typhoon_translate_iommu that handles one of the
> + * four single-address-cycle translation windows.
> + */
>   static bool window_translate(TyphoonWindow *win, hwaddr addr,
>                                IOMMUTLBEntry *ret)
>   {
> @@ -668,8 +676,10 @@ static bool window_translate(TyphoonWindow *win, hwaddr addr,
>   }
>   
>   /* Handle PCI-to-system address translation.  */
> -/* TODO: A translation failure here ought to set PCI error codes on the
> -   Pchip and generate a machine check interrupt.  */
> +/*
> + * TODO: A translation failure here ought to set PCI error codes on the
> + * Pchip and generate a machine check interrupt.
> + */
>   static IOMMUTLBEntry typhoon_translate_iommu(IOMMUMemoryRegion *iommu,
>                                                hwaddr addr,
>                                                IOMMUAccessFlags flag,
> @@ -773,10 +783,12 @@ static void typhoon_set_timer_irq(void *opaque, int irq, int level)
>       TyphoonState *s = opaque;
>       int i;
>   
> -    /* Thankfully, the mc146818rtc code doesn't track the IRQ state,
> -       and so we don't have to worry about missing interrupts just
> -       because we never actually ACK the interrupt.  Just ignore any
> -       case of the interrupt level going low.  */
> +    /*
> +     * Thankfully, the mc146818rtc code doesn't track the IRQ state,
> +     * and so we don't have to worry about missing interrupts just
> +     * because we never actually ACK the interrupt.  Just ignore any
> +     * case of the interrupt level going low.
> +     */
>       if (level == 0) {
>           return;
>       }
> @@ -787,14 +799,16 @@ static void typhoon_set_timer_irq(void *opaque, int irq, int level)
>           if (cpu != NULL) {
>               uint32_t iic = s->cchip.iic[i];
>   
> -            /* ??? The verbage in Section 10.2.2.10 isn't 100% clear.
> -               Bit 24 is the OverFlow bit, RO, and set when the count
> -               decrements past 0.  When is OF cleared?  My guess is that
> -               OF is actually cleared when the IIC is written, and that
> -               the ICNT field always decrements.  At least, that's an
> -               interpretation that makes sense, and "allows the CPU to
> -               determine exactly how mant interval timer ticks were
> -               skipped".  At least within the next 4M ticks...  */
> +            /*
> +             * ??? The verbage in Section 10.2.2.10 isn't 100% clear.
> +             * Bit 24 is the OverFlow bit, RO, and set when the count
> +             * decrements past 0.  When is OF cleared?  My guess is that
> +             * OF is actually cleared when the IIC is written, and that
> +             * the ICNT field always decrements.  At least, that's an
> +             * interpretation that makes sense, and "allows the CPU to
> +             * determine exactly how mant interval timer ticks were
> +             * skipped".  At least within the next 4M ticks...
> +             */
>   
>               iic = ((iic - 1) & 0x1ffffff) | (iic & 0x1000000);
>               s->cchip.iic[i] = iic;
> @@ -852,13 +866,17 @@ PCIBus *typhoon_init(MemoryRegion *ram, qemu_irq *p_isa_irq,
>       *p_isa_irq = qemu_allocate_irq(typhoon_set_isa_irq, s, 0);
>       *p_rtc_irq = qemu_allocate_irq(typhoon_set_timer_irq, s, 0);
>   
> -    /* Main memory region, 0x00.0000.0000.  Real hardware supports 32GB,
> -       but the address space hole reserved at this point is 8TB.  */
> +    /*
> +     * Main memory region, 0x00.0000.0000.  Real hardware supports 32GB,
> +     * but the address space hole reserved at this point is 8TB.
> +     */
>       memory_region_add_subregion(addr_space, 0, ram);
>   
>       /* TIGbus, 0x801.0000.0000, 1GB.  */
> -    /* ??? The TIGbus is used for delivering interrupts, and access to
> -       the flash ROM.  I'm not sure that we need to implement it at all.  */
> +    /*
> +     * ??? The TIGbus is used for delivering interrupts, and access to
> +     * the flash ROM.  I'm not sure that we need to implement it at all.
> +     */
>   
>       /* Pchip0 CSRs, 0x801.8000.0000, 256MB.  */
>       memory_region_init_io(&s->pchip.region, OBJECT(s), &pchip_ops, s, "pchip0",
> @@ -916,9 +934,11 @@ PCIBus *typhoon_init(MemoryRegion *ram, qemu_irq *p_isa_irq,
>       memory_region_add_subregion(addr_space, 0x801fe000000ULL,
>                                   &s->pchip.reg_conf);
>   
> -    /* For the record, these are the mappings for the second PCI bus.
> -       We can get away with not implementing them because we indicate
> -       via the Cchip.CSC<PIP> bit that Pchip1 is not present.  */
> +    /*
> +     * For the record, these are the mappings for the second PCI bus.
> +     * We can get away with not implementing them because we indicate
> +     * via the Cchip.CSC<PIP> bit that Pchip1 is not present.
> +     */
>       /* Pchip1 PCI memory, 0x802.0000.0000, 4GB.  */
>       /* Pchip1 CSRs, 0x802.8000.0000, 256MB.  */
>       /* Pchip1 PCI special/interrupt acknowledge, 0x802.F800.0000, 64MB.  */
> 


