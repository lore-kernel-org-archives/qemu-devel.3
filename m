Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80782C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 03:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyLLb-0007us-U9; Sun, 23 Aug 2026 23:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1wyLLb-0007ub-3w
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 23:27:43 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1wyLLY-00014A-CE
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 23:27:42 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2d01548ac96so3603515ad.3
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 20:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1787542058; x=1788146858; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=80YaSfqcLb39nB1pHTX7a4wFwPFqJIxhfyTi+OcLQAI=;
 b=aKsJegJ/Yh0wcmd5C73nbN10c1yxBh3IsmEd7UxTLy8lDSHWH8VCN/ubxSMxxU1ZB7
 0O1GIC5MvaJDHywufLn9i1mM8PQaG7dz+hKaWTuK5dx+/WJK7QOzZNMLZD7k7DpZrwPi
 CJb84O5V+0xuSqg2+JVDdYbAgYFGwonCODRXu7AFjuIzTLgWHgl2QSdnCjRe08LFMTm3
 FYibDaGZLICO6VBz1IyWnOrzjltU9LAfIvM5+SdFgPasolBxJcx9pPOvyrgHg7p41fal
 ucrsc870CHvs0X9aF5UgpTd5T5bCEoVbah9wZHFjt/S7d8p+9/yLZxwiib1t4gJoXWWT
 8T6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787542058; x=1788146858;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=80YaSfqcLb39nB1pHTX7a4wFwPFqJIxhfyTi+OcLQAI=;
 b=BVJEs4emB3Kwa/QfWCpadCeX65NjbfQB4jqfXMLvPFAoJlvJy2Mb9hBnv2XEls8JUr
 5+gbz4GsdMSE/zSrocM5jqSbAcQ9pI1VkaUxuEkY8cwYMKbHcnFBGljo9VQ2r2Jgy477
 AUY18w9UjO4FvgcN08pl7QN0G4i8FJq7eIMp8mSoMYZ8PZ7s3o4+qpVpvWeBosi55I0h
 C78Pua5JcnAafUoY6jD8v/bcNIbZuvB3qI2tBi8e8QveUhEJf3xH4aE6pDTGPTkw4ygS
 9alj4xUe2//A7+Ua7035gi4q/hENeDlvIQ2DM5qcIb11mnTngMDo2NDLEPCUTRbXfi4v
 OHRA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqU0MKqFOqdsgfOglXVKmkyhM61ga0I/e5ki59FFHIHrfkaUDeuVcoBUskCO7quNuDpgcnrqZmPCAoM@nongnu.org
X-Gm-Message-State: AFuF++ln+fYQJfvKGiXU0E5CTTQkl7f/wdlJ2jLEAlfFtIRnXm91OCDu
 bVch+LqffGLfcI5kleUs02mzPY6e80eHSxHJ6lsLSVGJ6mXVPNwOw5C1aeOxkWdHkMc=
X-Gm-Gg: AR+sD12WpAGaLi5knp4cuc9MAvfvqs7hMbvVjWec9eGaB9uhsgcjcJX20IE8PANwjVV
 qhIwZh0YoND4Vrb08z3HY/1M5J+v6jdCycSXDCTSzGrgcF8izpZwXxpSp2AhpsBa2htFYQhpRGa
 rgSsxsNqJlgnHjkpDB9OW30dGHKWZDFDatPCgHgMItmYVau4iNmc6fnjizUeHE5vQoCyMK6brUh
 O1TE4/oDgSK6OjRH5av/xO4fLHeP13quEoWEN4zuvHcakaINRDOIG2ULhbZfLj1wGqTk/RuA6fQ
 jKzZcW0fRaqhhq0lBOcrmnLJ6f6AmIlBVZW1JxrNqzGWKK0FAsEOH9wnoZ9bX7MlFvmSl6q5+vT
 sAtZ9gNDYp5TTRimEAEcktUDab5IkaqZhWEVFX2GxrDu/ViUcsf1uEA3sLG+BoICjXF7XbTTQod
 wMjAU1eiOWedHi56cYXKQ2I2GAltznQ+M5YCWzQJJjS6YPW4vVwXBgvXCjf0XkzunfFOJ4raV+x
 vkO/YxWPWCyHiuT
X-Received: by 2002:a17:902:fc4e:b0:2d3:aecd:51f7 with SMTP id
 d9443c01a7336-2d64ae3a7c7mr203295085ad.1.1787542058346; 
 Sun, 23 Aug 2026 20:27:38 -0700 (PDT)
Received: from [172.16.1.33] ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f909c6c9sm24523722eec.6.2026.08.23.20.27.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Aug 2026 20:27:37 -0700 (PDT)
Message-ID: <330c6826-f70d-4dbf-ac04-c045f6f62386@oss.tenstorrent.com>
Date: Mon, 24 Aug 2026 13:27:31 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/riscv: Make s-mode IMSIC stride explicit
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20260824030509.18078-1-joel@jms.id.au>
 <20260824030509.18078-2-joel@jms.id.au>
Content-Language: en-US
From: Portia Stephens <portias@oss.tenstorrent.com>
In-Reply-To: <20260824030509.18078-2-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=portias@tenstorrent.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 24/8/2026 1:05 PM, Joel Stanley wrote:
> Existing machines tightly coupled s-mode IMSIC stride with the guest
> bits value. There need to be enough bits to describe the guest in
> GEILEN, but that's a minimum bound and machines may choose to use a
> larger stride. This change decouples the two and updates Atlantis and
> Virt to use the new API.
>
> AIA guest count used by the Atlantis machine was not correct. It looks
> like a placeholder value was chosen in order to size the stride to
> 0x40000, but this gives the wrong guest count. From the (currently
> internal) docs, the guest count is 5:
>
>> |NUM_GEILEN|5 (0 - 64)|Number of supported guest index from the S-mode interrupt domain|
> Add that value to a define, and add a separate define for the stride, to
> reduce the opportunity for future confusion.
>
> Fixes: 7778f4b27bb1 ("hw/riscv: Add Tenstorrent Atlantis machine")
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   hw/riscv/aia.h         |  1 +
>   hw/riscv/aia.c         |  5 ++---
>   hw/riscv/tt_atlantis.c | 19 +++++++++++--------
>   hw/riscv/virt.c        |  2 ++
>   4 files changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
> index 565f91accc09..3b6d7f962506 100644
> --- a/hw/riscv/aia.h
> +++ b/hw/riscv/aia.h
> @@ -15,6 +15,7 @@ uint32_t imsic_num_bits(uint32_t count);
>   
>   DeviceState *riscv_create_aia(bool msimode, int aia_guests,
>                                uint32_t m_imsic_stride,
> +                             uint32_t s_imsic_stride,
>                                uint16_t num_sources,
>                                const MemMapEntry *aplic_m,
>                                const MemMapEntry *aplic_s,
> diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
> index ed8916002945..c33a3b32bd45 100644
> --- a/hw/riscv/aia.c
> +++ b/hw/riscv/aia.c
> @@ -26,6 +26,7 @@ uint32_t imsic_num_bits(uint32_t count)
>   
>   DeviceState *riscv_create_aia(bool msimode, int aia_guests,
>                                uint32_t m_imsic_stride,
> +                             uint32_t s_imsic_stride,
>                                uint16_t num_sources,
>                                const MemMapEntry *aplic_m,
>                                const MemMapEntry *aplic_s,
> @@ -36,7 +37,6 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
>   {
>       int i;
>       hwaddr addr = 0;
> -    uint32_t guest_bits;
>       DeviceState *aplic_s_dev = NULL;
>       DeviceState *aplic_m_dev = NULL;
>   
> @@ -55,10 +55,9 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
>           }
>   
>           /* Per-socket S-level IMSICs */
> -        guest_bits = imsic_num_bits(aia_guests + 1);
>           addr = imsic_s->base + socket * (1U << IMSIC_MMIO_GROUP_MIN_SHIFT);
>           for (i = 0; i < hart_count; i++) {
> -            riscv_imsic_create(addr + i * IMSIC_HART_SIZE(guest_bits),
> +            riscv_imsic_create(addr + i * s_imsic_stride,
>                                  base_hartid + i, false, 1 + aia_guests,
>                                  num_msis);
>           }
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index d808bcc11c34..88c375684412 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -37,8 +37,12 @@
>   #define TT_IRQCHIP_NUM_MSIS       255
>   #define TT_IRQCHIP_NUM_SOURCES    128
>   #define TT_IRQCHIP_NUM_PRIO_BITS  3
> -#define TT_IRQCHIP_GUESTS         63 /* aia_guests, gives guest_index_bits=6 */
> -#define TT_IRQCHIP_MIMSIC_STRIDE  0x40000
> +#define TT_IMSIC_GUESTS           5
> +#define TT_IMSIC_STRIDE           0x40000 /* Same stride for M and S */
> +#define TT_IMSIC_GUEST_BITS       6
> +
> +/* Stride is fixed by hardware, check it's consistent with guest bits. */
> +QEMU_BUILD_BUG_ON(TT_IMSIC_STRIDE != (0x1000 << TT_IMSIC_GUEST_BITS));
>   
>   #define TT_ACLINT_MTIME_SIZE    0x8050
>   #define TT_ACLINT_MTIME         0x0
> @@ -231,18 +235,16 @@ static void create_fdt_cpu(TTAtlantisState *s, const MemMapEntry *memmap,
>   
>       create_fdt_aclint(s, intc_phandles);
>   
> -    uint32_t imsic_guest_bits = imsic_num_bits(TT_IRQCHIP_GUESTS + 1);
> -
>       /* M-level IMSIC node */
>       uint32_t msi_m_phandle = next_phandle();
>       create_fdt_one_imsic(fdt, &s->memmap[TT_ATL_MIMSIC], ms->smp.cpus,
>                            intc_phandles, msi_m_phandle,
> -                         IRQ_M_EXT, imsic_guest_bits);
> +                         IRQ_M_EXT, TT_IMSIC_GUEST_BITS);
>   
>       /* S-level IMSIC node */
>       create_fdt_one_imsic(fdt, &s->memmap[TT_ATL_SIMSIC], ms->smp.cpus,
>                            intc_phandles, imsic_s_phandle,
> -                         IRQ_S_EXT, imsic_guest_bits);
> +                         IRQ_S_EXT, TT_IMSIC_GUEST_BITS);
>   
>       uint32_t aplic_m_phandle = next_phandle();
>   
> @@ -493,8 +495,9 @@ static void tt_atlantis_machine_init(MachineState *machine)
>                               &error_abort);
>       sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
>   
> -    s->irqchip = riscv_create_aia(true, TT_IRQCHIP_GUESTS,
> -                                  TT_IRQCHIP_MIMSIC_STRIDE,
> +    s->irqchip = riscv_create_aia(true, TT_IMSIC_GUESTS,
> +                                  TT_IMSIC_STRIDE,
> +                                  TT_IMSIC_STRIDE,
>                                     TT_IRQCHIP_NUM_SOURCES,
>                                     &s->memmap[TT_ATL_MAPLIC],
>                                     &s->memmap[TT_ATL_SAPLIC],
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index d58656f70d1b..42d28f4f5a02 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1410,9 +1410,11 @@ static void virt_machine_init(MachineState *machine)
>               s->irqchip[i] = virt_create_plic(s->memmap, i,
>                                                base_hartid, hart_count);
>           } else {
> +            int imsic_bits = imsic_num_bits(s->aia_guests + 1);
>               s->irqchip[i] = riscv_create_aia(s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC,
>                                                s->aia_guests,
>                                                IMSIC_HART_SIZE(0),
> +                                             IMSIC_HART_SIZE(imsic_bits),
>                                                s->num_sources,
>                                                &s->memmap[VIRT_APLIC_M],
>                                                &s->memmap[VIRT_APLIC_S],


Reviewed-by: Portia Stephens <portias@oss.tenstorrent.com>



