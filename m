Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F62D2D0E4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 12:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfdW6-0007uz-6J; Tue, 13 Jan 2026 07:28:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vfdVB-0006lz-7w
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 07:28:02 -0500
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vfdV5-0004Yu-4C
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 07:27:57 -0500
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4f4cd02f915so55433501cf.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 04:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1768307273; x=1768912073; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l5fzdefdl++Aa9VicXyN1D1+ycPdpOm3p6oX327rAgA=;
 b=Y5iIAKzqZWvLxRc9XiGYBJ5qmfUhhx/I3gnuPFfAxmpZiE/WyaV7H3TwSRbrzOabX4
 CaPQd9MeA1vMMrpqJihrskt5781ct3Vps09/7SWjfnZuEwMtu8XdNYnHby5rjeBINa4B
 Kvm0yo3dIg/pyPo7y6nUfgcUXcitMi2G1WTZr8cuYBjt3CC0ww9U2Ca51vi9oEmMprQK
 0LZ0yceouQYEgaSFEu9CupPxX2rS9yCq+A5EaQqcOLUfGwnD5X0s//2XNOX0FAnIMMRw
 drojJgglUHvkMVAIzOFy2s3bN6K5re4lopPUl6s5UReps/9WeIRiX/CenwMBLuReIuD3
 Z9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768307273; x=1768912073;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l5fzdefdl++Aa9VicXyN1D1+ycPdpOm3p6oX327rAgA=;
 b=hiAwIz8mQkhaGjQ4bC/kgDu4T44Vbr/PalLcJ33knGwHXDeNrb5LYwTYCHreAvkpe6
 WAM1MkSbz0DYhVgo63hdgqqd8yD+CTgAPymP0nAw7DbOM2LhBYJBFAHDdxkN0olvTeEu
 jXP4QQV5VqIPJEK5O2kr0iNenWCcg2ISlyY//VME9dhIWBvAAAZAWc3hQGGejacC35hF
 YShyG//+VvCfQqow9/IUsGDS9x/RJ6UiGIlC7CMna0IGDoQj6/PIGVVtS1ipyrd58J6/
 4dNnZNWBcTsF/919kk/GHH8PO0BeGQ0LWTUesqt7VxL9+mX/LX+WeFRUXpbrxwvb2TZI
 3Q8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdZ2od0nxjvYGHHnyMT6GYx8Id0q0/08LUrbTO14FGgPSNE1jcCabY7L4AVzLCeCbxXLK85vftb2bQ@nongnu.org
X-Gm-Message-State: AOJu0Yywm4VoD7BcVXfk/C2dAqa5NtYuiFztfJKd7F7/0yUu/Ds8k3yK
 ZYGXyJdQ83xBkUQCXGhKaBSJ2TtgQdaYy7jC2uxkjDO9tqw7kHmqpm0F/D1Ipy1gjhg=
X-Gm-Gg: AY/fxX5Mgl2RmBI10Qo9tVAauO6nzozaWstahWqCUVjO1cf4W2k0sIQI8TujTULecDx
 ru0vz35oLFIcRCh43gVjfkhsZwQRUt2w3efVy5AAqlxIlBdPDrYamIGycCYG8Ht1tI+gZ/yyDz7
 GDWr3ZSWzfhI81Qf9pkpveXtvxWnrj5kyRSiWznALdBHn6I1oHfThwaO6hthEBYQvEXRBNQkHKQ
 E8JMtOUvZA0jNAG7HvPj8tQcT52x+yKChe65Nu7adMtUOPe/pxKa2QfY9vESyM68H+mJPyuIPUq
 ZDDsdGnBnUmCRj7FtuOSy8Tu+cZQ9PAZYFFN23GlWCHXc3vccKNP2PAen0uvJnhOG0sYoPRwh7h
 vY+anE1Ke6tgE9R4tynXgQcgCfjquznhhDR3nZLWPXEyTyJtLsSA0TG99w1az6vsMgndfDs0iux
 VgZk1RbCP2beALJs3eI9un0BO3WEn/R+w3xzgA/fnD
X-Google-Smtp-Source: AGHT+IHCXsvzxShQ+qOwy45TEDxlrdZEXdGI0j9krCFNb/agXmgxIqdK86cTk4TjBdG3bKPv8G7Fhw==
X-Received: by 2002:a05:622a:580d:b0:4ed:b83f:78a3 with SMTP id
 d75a77b69052e-4ffb4a44a76mr274350771cf.47.1768307273355; 
 Tue, 13 Jan 2026 04:27:53 -0800 (PST)
Received: from [192.168.68.103] ([152.234.121.223])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ffa8d3d34fsm139963141cf.4.2026.01.13.04.27.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 04:27:52 -0800 (PST)
Message-ID: <be628a59-f73e-4302-8ef6-d9a0c4e38e7e@ventanamicro.com>
Date: Tue, 13 Jan 2026 09:27:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/riscv/aia: Provide number of irq sources
To: Joel Stanley <joel@jms.id.au>, Alistair Francis
 <alistair.francis@wdc.com>, Sunil V L <sunilvl@ventanamicro.com>,
 qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
References: <20260109133125.397364-1-joel@jms.id.au>
 <20260109133125.397364-3-joel@jms.id.au>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260109133125.397364-3-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qt1-x831.google.com
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



On 1/9/2026 10:31 AM, Joel Stanley wrote:
> Instead of hard coding the number of IRQ sources used by the APLIC pass
> it in as a parameter. This allows other machines to configure this as
> required.
> 
> The maximum number of sources is 1023.

I suppose we always had this source limit but never really added a check
for it. Since you're parametrizing it, might as well add an early check 
for it:

g_assert(num_sources <= 1023);


Inside riscv_create_aia() and acpi_dsdt_add_plic_aplic().


The rest LGTM. Thanks,


Daniel

> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   hw/riscv/aia.h             |  1 +
>   include/hw/riscv/virt.h    |  1 +
>   hw/riscv/aia.c             |  5 +++--
>   hw/riscv/virt-acpi-build.c | 22 +++++++++++++---------
>   hw/riscv/virt.c            |  2 ++
>   5 files changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
> index 50c48ea4d79c..a63a1ab293fe 100644
> --- a/hw/riscv/aia.h
> +++ b/hw/riscv/aia.h
> @@ -48,6 +48,7 @@
>   uint32_t imsic_num_bits(uint32_t count);
>   
>   DeviceState *riscv_create_aia(bool msimode, int aia_guests,
> +                             uint16_t num_sources,
>                                const MemMapEntry *aplic_m,
>                                const MemMapEntry *aplic_s,
>                                const MemMapEntry *imsic_m,
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 25ec5c665780..fa7fe8d4f648 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -64,6 +64,7 @@ struct RISCVVirtState {
>       struct GPEXHost *gpex_host;
>       OnOffAuto iommu_sys;
>       uint16_t pci_iommu_bdf;
> +    uint16_t num_sources;
>   };
>   
>   enum {
> diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
> index 0a89d7b49b7b..8d45a21f85e2 100644
> --- a/hw/riscv/aia.c
> +++ b/hw/riscv/aia.c
> @@ -25,6 +25,7 @@ uint32_t imsic_num_bits(uint32_t count)
>   }
>   
>   DeviceState *riscv_create_aia(bool msimode, int aia_guests,
> +                             uint16_t num_sources,
>                                const MemMapEntry *aplic_m,
>                                const MemMapEntry *aplic_s,
>                                const MemMapEntry *imsic_m,
> @@ -65,7 +66,7 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
>                                        aplic_m->size,
>                                        (msimode) ? 0 : base_hartid,
>                                        (msimode) ? 0 : hart_count,
> -                                     VIRT_IRQCHIP_NUM_SOURCES,
> +                                     num_sources,
>                                        VIRT_IRQCHIP_NUM_PRIO_BITS,
>                                        msimode, true, NULL);
>       }
> @@ -76,7 +77,7 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
>                                    aplic_s->size,
>                                    (msimode) ? 0 : base_hartid,
>                                    (msimode) ? 0 : hart_count,
> -                                 VIRT_IRQCHIP_NUM_SOURCES,
> +                                 num_sources,
>                                    VIRT_IRQCHIP_NUM_PRIO_BITS,
>                                    msimode, false, aplic_m_dev);
>   
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index b091a9df9e0f..8da60fe127c4 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -144,6 +144,7 @@ static void acpi_dsdt_add_cpus(Aml *scope, RISCVVirtState *s)
>   }
>   
>   static void acpi_dsdt_add_plic_aplic(Aml *scope, uint8_t socket_count,
> +                                     uint16_t num_sources,
>                                        uint64_t mmio_base, uint64_t mmio_size,
>                                        const char *hid)
>   {
> @@ -153,7 +154,7 @@ static void acpi_dsdt_add_plic_aplic(Aml *scope, uint8_t socket_count,
>   
>       for (socket = 0; socket < socket_count; socket++) {
>           plic_aplic_addr = mmio_base + mmio_size * socket;
> -        gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
> +        gsi_base = num_sources * socket;
>           Aml *dev = aml_device("IC%.02X", socket);
>           aml_append(dev, aml_name_decl("_HID", aml_string("%s", hid)));
>           aml_append(dev, aml_name_decl("_UID", aml_int(socket)));
> @@ -469,10 +470,13 @@ static void build_dsdt(GArray *table_data,
>       socket_count = riscv_socket_count(ms);
>   
>       if (s->aia_type == VIRT_AIA_TYPE_NONE) {
> -        acpi_dsdt_add_plic_aplic(scope, socket_count, memmap[VIRT_PLIC].base,
> -                                 memmap[VIRT_PLIC].size, "RSCV0001");
> +        acpi_dsdt_add_plic_aplic(scope, socket_count, s->num_sources,
> +                                 memmap[VIRT_PLIC].base,
> +                                 memmap[VIRT_PLIC].size,
> +                                 "RSCV0001");
>       } else {
> -        acpi_dsdt_add_plic_aplic(scope, socket_count, memmap[VIRT_APLIC_S].base,
> +        acpi_dsdt_add_plic_aplic(scope, socket_count, s->num_sources,
> +                                 memmap[VIRT_APLIC_S].base,
>                                    memmap[VIRT_APLIC_S].size, "RSCV0002");
>       }
>   
> @@ -489,15 +493,15 @@ static void build_dsdt(GArray *table_data,
>       } else if (socket_count == 2) {
>           virtio_acpi_dsdt_add(scope, memmap[VIRT_VIRTIO].base,
>                                memmap[VIRT_VIRTIO].size,
> -                             VIRTIO_IRQ + VIRT_IRQCHIP_NUM_SOURCES, 0,
> +                             VIRTIO_IRQ + s->num_sources, 0,
>                                VIRTIO_COUNT);
> -        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURCES);
> +        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + s->num_sources);
>       } else {
>           virtio_acpi_dsdt_add(scope, memmap[VIRT_VIRTIO].base,
>                                memmap[VIRT_VIRTIO].size,
> -                             VIRTIO_IRQ + VIRT_IRQCHIP_NUM_SOURCES, 0,
> +                             VIRTIO_IRQ + s->num_sources, 0,
>                                VIRTIO_COUNT);
> -        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURCES * 2);
> +        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + s->num_sources * 2);
>       }
>   
>       aml_append(dsdt, scope);
> @@ -576,7 +580,7 @@ static void build_madt(GArray *table_data,
>           for (socket = 0; socket < riscv_socket_count(ms); socket++) {
>               aplic_addr = s->memmap[VIRT_APLIC_S].base +
>                                s->memmap[VIRT_APLIC_S].size * socket;
> -            gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
> +            gsi_base = s->num_sources * socket;
>               build_append_int_noprefix(table_data, 0x1A, 1);    /* Type */
>               build_append_int_noprefix(table_data, 36, 1);      /* Length */
>               build_append_int_noprefix(table_data, 1, 1);       /* Version */
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 01115a0fb946..e5df5a5d4638 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1556,6 +1556,7 @@ static void virt_machine_init(MachineState *machine)
>           } else {
>               s->irqchip[i] = riscv_create_aia(s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC,
>                                                s->aia_guests,
> +                                             s->num_sources,
>                                                &s->memmap[VIRT_APLIC_M],
>                                                &s->memmap[VIRT_APLIC_S],
>                                                &s->memmap[VIRT_IMSIC_M],
> @@ -1690,6 +1691,7 @@ static void virt_machine_instance_init(Object *obj)
>       s->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
>       s->acpi = ON_OFF_AUTO_AUTO;
>       s->iommu_sys = ON_OFF_AUTO_AUTO;
> +    s->num_sources = VIRT_IRQCHIP_NUM_SOURCES;
>   }
>   
>   static char *virt_get_aia_guests(Object *obj, Error **errp)


