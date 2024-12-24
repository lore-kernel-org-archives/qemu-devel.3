Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD8FE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 16:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ7L9-0006Nh-F1; Tue, 24 Dec 2024 11:00:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQ7L4-0006Ma-Ks
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 11:00:57 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQ7Ky-0000sW-En
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 11:00:54 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43623f0c574so35559575e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 08:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735056046; x=1735660846; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D21RsUCvV9sGFUSNH1oCTIM4L8z7UjeOs7mwnT3PWTw=;
 b=oUHHnM56v0zcUoH1mgc03SmFZQ+mxwVYPxmi85Pqqfxc/Sw22I0MALlVQbe7WY4KlH
 8607l9Vw+JNW4Wqpshq++fe1JSkU1SIFGwd46yXBBI9nCQA81Sv410JatOzCvRF/Zp+X
 91X8EzEkoiyy/cD4Fm+Q1fYwUfl+bz9sGqTDDvfvsM/2lzlBHO1q99WxgjvOZXvnwenk
 lVDSJTxjja4RgLzy5eua8QAhkEDdcwkQ5b3bf1LC05z7J0m3Y1RGNQaMrxSczdfA2jyN
 RQx4UffjIAJ5plXEnbsYCbwSdtP36RLFZyM3KONUMSVO604h07+JdKunHgzjTxIkMWY2
 Ldrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735056046; x=1735660846;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D21RsUCvV9sGFUSNH1oCTIM4L8z7UjeOs7mwnT3PWTw=;
 b=EKwW9pVYNo/ziRA9/AUUxZo9AbSstaZdS6uwRTPXNZ3RcM7qnWl7lV54YCAKOetmBK
 nvWvD+YDoB8fy+kq5Y5jhsfIyn+hAqhd+uHJ0vRiGMSkytX+eqlxygMmFe7rz/zlCCF4
 ROc79S683Wj6pvm+WU7PemStDmhjApso+pyED6ueIjDkstbjQCEtZoIjlhSvE07FKYIM
 DnTg4RpH23v1q3Jptx568uGGq+5qYstArVqQzDSpz5piEiPzyxJ1NrIebxkTM8sOKjBl
 8C529FR0YpK7H3MYbrevW1CzK3x6C04yVQTC8c+q6B3ln89ycvJ4lZ8CaSNDU6JgbQ+K
 LUuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOjmI8r8cj+UzD4aaBksNsDM+G4gmckJhbou4BgS/yn/VX5Z+oeWaVOdKySOrrP1pONpSHBo+LoX5g@nongnu.org
X-Gm-Message-State: AOJu0YwGvspi6hZxTBg7mghwdAlJViQIhVHc+2WbeCTzsp3XxjVRWrhh
 G9aaE/PXkuYygbJ+PztPZr9CC/2oWbD8GvQ9oxGFffnKKNfIjz4wali8Yru1PDqFbILYBCZ00eK
 E
X-Gm-Gg: ASbGnctQG6ZPwPuIIkjyR/PwZTEpzMw7JMTfyrm0uH0qxlb/NFKtwj6waW2iEciuFL9
 Y6/BJvnO502r7MSPR169Ann9zCXdbSDseqXtkkbabclxGsOA18N/wrkTxkCMGPXxMrjs6P1BO03
 nS2mFsp/ima12IuUABmji/R1hnL3WX9+cLzW/9Vokdqx8GMRfmE71vW0MKeI/o6u+NJXlBigLOG
 gjvBdDWrHixs8LwYHlIlR5195XWJPbuxyaFHHdcyz1PRlUnwCv8rrjlLBEG+yLaDjY=
X-Google-Smtp-Source: AGHT+IH83v4tRbnGS/IB+MsAB9AKxFX4333FrckLHhdiwH4qelkEHUF5eURylEHVGyZsr33iy3vbEQ==
X-Received: by 2002:a05:6000:18ab:b0:386:1cd3:8a05 with SMTP id
 ffacd0b85a97d-38a223fd47fmr15412902f8f.54.1735056046335; 
 Tue, 24 Dec 2024 08:00:46 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b3b295sm209627475e9.33.2024.12.24.08.00.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Dec 2024 08:00:45 -0800 (PST)
Message-ID: <c138716f-baa5-4fca-82b7-972c66570450@linaro.org>
Date: Tue, 24 Dec 2024 17:00:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] hw/loongarch/boot: Refactor EFI booting protocol
 generation
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
References: <20241224-la-booting-v3-0-a15bee060a43@flygoat.com>
 <20241224-la-booting-v3-1-a15bee060a43@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241224-la-booting-v3-1-a15bee060a43@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Hi,

On 24/12/24 15:24, Jiaxun Yang wrote:
> Refector EFI style booting data structure generation to
> support 32bit EFI variant on LoongArch32 CPU.
> 
> All data structs are filled with padding members if necessary
> and marked as QEMU_PACKED to avoid host ABI alignment impact.
> 
> Host endian is being cared as well.
> 
> It also fixed various problems in old implementation such
> as null pointer on empty string, memory desc map_size not set,
> incorrect memory map definition and so on.
> 
> Reviewed-by: Song Gao <gaosong@loongson.cn>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   hw/loongarch/boot.c         | 220 ++++++++++++++++++++++++++++++--------------
>   include/hw/loongarch/boot.h | 106 +++++++++++++++++----
>   2 files changed, 238 insertions(+), 88 deletions(-)


> +#define EFI_BOOT_MEMMAP_TABLE_GEN(type)                                     \
> +static void init_efi_boot_memmap_##type(void *guidp, void **p)              \
> +{                                                                           \
> +    struct efi_boot_memmap_##type *boot_memmap = *p;                        \
> +    efi_guid_t tbl_guid = LINUX_EFI_BOOT_MEMMAP_GUID;                       \
> +                                                                            \
> +    /* efi_configuration_table 1 */                                         \
> +    guidcpy(guidp, &tbl_guid);                                              \
> +                                                                            \
> +    boot_memmap->desc_size = cpu_to_le##type(sizeof(efi_memory_desc_t));    \

I'd prefer we avoid macros and use the ld/stN API, passing the
size as argument:

        stn_le_p(&boot_memmap->desc_size, size,
                 sizeof(efi_memory_desc_t));

Ideally splitting the patch in 3, first convert to use the API
as stn_le_p(ptr, 8, value), then second patch propagate the size,
and the third add the size=4 case.

> +    boot_memmap->desc_ver = cpu_to_le32(1);                                 \
> +    boot_memmap->map_size = cpu_to_le##type(boot_memmap->desc_size *        \
> +                                            memmap_entries);                \
> +    memmap_write_descs(boot_memmap->map);                                   \
> +    *p += sizeof(struct efi_boot_memmap_##type);                            \
> +}
>   
> -    init_efi_boot_memmap(systab, p, start);
> -    p += ROUND_UP(sizeof(struct efi_boot_memmap) +
> -                  sizeof(efi_memory_desc_t) * memmap_entries, 64 * KiB);
> -    init_efi_initrd_table(systab, p, start);
> -    p += ROUND_UP(sizeof(struct efi_initrd), 64 * KiB);
> -    init_efi_fdt_table(systab);
> +#define EFI_INITRD_TABLE_GEN(type)                                          \
> +static void init_efi_initrd_table_##type(void *guidp, void **p)             \
> +{                                                                           \
> +    efi_guid_t tbl_guid = LINUX_EFI_INITRD_MEDIA_GUID;                      \
> +    struct efi_initrd_##type *initrd_table = *p;                            \
> +                                                                            \
> +    /* efi_configuration_table  */                                          \
> +    guidcpy(guidp, &tbl_guid);                                              \
> +                                                                            \
> +    initrd_table->base = cpu_to_le##type(initrd_offset);                    \
> +    initrd_table->size = cpu_to_le##type(initrd_size);                      \
> +    *p += sizeof(struct efi_initrd_##type);                                 \
> +}


> +EFI_INIT_SYSTAB_GEN(32)
> +EFI_INIT_SYSTAB_GEN(64)


> -static void init_boot_rom(struct loongarch_boot_info *info, void *p)
> +static void init_boot_rom(struct loongarch_boot_info *info, void *p,
> +                          bool is_64bit)
>   {
>       void *start = p;
>   
>       init_cmdline(info, p, start);
>       p += COMMAND_LINE_SIZE;
>   
> -    init_systab(info, p, start);
> +    if (is_64bit)
> +        init_systab_64(info, p, start);
> +    else
> +        init_systab_32(info, p, start);
>   }


