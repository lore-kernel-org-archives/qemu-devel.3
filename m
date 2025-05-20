Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B86F7C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMZB-0002JY-WF; Tue, 20 May 2025 08:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uHMZ8-0002Ip-UZ
 for qemu-devel@nongnu.org; Tue, 20 May 2025 08:59:32 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uHMZ0-0001td-30
 for qemu-devel@nongnu.org; Tue, 20 May 2025 08:59:30 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-875b8e006f8so1549750241.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 05:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747745958; x=1748350758; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pMfbpzXhOe+YUNzUqs3qyQQ11n1TNRt1IoQEcji45Mg=;
 b=VzmeSbB7AAvYCSrsbpWLwyiTqYC7B2wmVAlsmtP+lP+ujGmcYNnUBZPoPSqXRhT5ND
 Z8eF7ASZPotyi3A7JxuAM44yuur0UZsGoOYZ6VFPf9ks2I8+vFVQnqFM92Wzm8pJNXdP
 uebJVmDFHkjiZQ6ncCCiWsgOtPDkDG3+RgVNwHZ9Jkjv8Z/8/c827ABYuFOOLM7YkzjO
 xCFMvD0YM67IKBQQg6chGOtkHVKC2wDeJpabHPemO+JrIdcu5QBnCLZjhFDgqRast8H6
 htPOeVdbMoR9ZiGNBcSCKGgX0SnQeWXqCX2BCh5M/n0LXIju3dER+mtt9By5828+0fB6
 dIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745958; x=1748350758;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pMfbpzXhOe+YUNzUqs3qyQQ11n1TNRt1IoQEcji45Mg=;
 b=d4w6LB5q8BQVjK7jGw6VJJ1rNuBDw+D4vM6zTUZh9GgeLbcBuHoT/Ttwt+8X2aq6yo
 7wjv5TkoZrujhPQaK8PEziVyRpKBZk+mbbwGdU2p0L1PFX8oATJD8Rpgg/1buAiIykqR
 IT5LCGltsq9eDG3yiWWSWK/CRq8fBEmEDcuucWsGTTda1uVA/OeZDAIgV2N9PRePFvg9
 TyKi6kOJ7FHdtC94VU1+M6rzLx61cWmSv/hoQgoNiTnbsiTDcWGEIbFEsbj6CPE61NDk
 Ht01+N5xY30polfwXXB5L+QOPsGKvNtgmBn8q5TRO34gse+37ISjz4H207KqiMslClqr
 bL3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpDoZjYSLqMAhJl4jj6KST+9mlCOnsqHobyYWTC2KkeELcqRM7/ElhEE+A0udl+RiI2gBhFaa0cjnR@nongnu.org
X-Gm-Message-State: AOJu0YzgiV30alB2kheOzog0QBw9VaBYHYos2ZOkeEUZKoPcThDZHy4S
 t8nh/ie7FJ+O0k53dBxvai1fDNYhJqXCdTI0fNnhjyo0KnGlyKfMO+R8vB7wndVldsQ=
X-Gm-Gg: ASbGncv1S7v+lAA/83HmEB7pMuknhCdPskrRtJaXNZZip9DHfK33keA2ETxjLZFkLHD
 AaMWOaHgApQGc2TxyjLfGKXPU0sZCERpES+x+cvdgb4WcL0a6PKg9XWb/ye82EJ1m5Y1U5Re9L+
 x+WtszG90aQ6ul2a9JHJLozCEfI3fzsKlhHs8HxTsvl6yV00K1B4Ja/tu9frbQsEY1c+9MlTQf7
 O957GcwPZ2xI4NksvnnYPC+OMzEcjRhRiIhlFGO/YrMnYzHcs6oYygxlyr1WvvQaxdOYRgNlaO3
 QONAWgKXtZT77VH+DGabPmp4Wah35VrrERCqBDYVnP5J81GuCHRSH7Cj08iiDcQ9tt6GjTa+unh
 CfBXGVyUQAfAoIshUHuVzpqKPl57kTw==
X-Google-Smtp-Source: AGHT+IFKgYKB604zweJHprKgWRyGnab9wUzEFJH0S2YLMfCNpKEt9wZ3MpkQ29S7qNaI5ujnFEghdg==
X-Received: by 2002:a05:6102:4411:b0:4dd:b259:ef3c with SMTP id
 ada2fe7eead31-4dfa6b685f7mr15755055137.9.1747745957959; 
 Tue, 20 May 2025 05:59:17 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b401:d47f:6989:b93e:2caa:f174?
 ([2804:7f0:b401:d47f:6989:b93e:2caa:f174])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4dfa66fdb81sm7956484137.18.2025.05.20.05.59.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 05:59:17 -0700 (PDT)
Message-ID: <c5b50b92-c580-4bc4-94ec-73e445fce312@linaro.org>
Date: Tue, 20 May 2025 09:59:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/22] hw/i386/acpi-build: Turn build_q35_osc_method into
 a generic method
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org
References: <20250514170431.2786231-1-eric.auger@redhat.com>
 <20250514170431.2786231-8-eric.auger@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250514170431.2786231-8-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=gustavo.romero@linaro.org; helo=mail-ua1-x932.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Hi Eric,

On 5/14/25 14:00, Eric Auger wrote:
> GPEX acpi_dsdt_add_pci_osc() does basically the same as
> build_q35_osc_method().
> 
> Rename build_q35_osc_method() into build_pci_host_bridge_osc_method()
> and move it into hw/acpi/aml-build.c. In a subsequent patch we will
> use this later in place of acpi_dsdt_add_pci_osc().
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

> ---
>   include/hw/acpi/aml-build.h |  2 ++
>   hw/acpi/aml-build.c         | 50 ++++++++++++++++++++++++++++++++++
>   hw/i386/acpi-build.c        | 54 ++-----------------------------------
>   3 files changed, 54 insertions(+), 52 deletions(-)
> 
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index c18f681342..177d60b414 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -508,4 +508,6 @@ void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog,
>   void build_spcr(GArray *table_data, BIOSLinker *linker,
>                   const AcpiSpcrData *f, const uint8_t rev,
>                   const char *oem_id, const char *oem_table_id, const char *name);
> +
> +Aml *build_pci_host_bridge_osc_method(bool enable_native_pcie_hotplug);
>   #endif
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index f8f93a9f66..ba1dfe0b52 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -2614,3 +2614,53 @@ Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_source)
>   
>       return var;
>   }
> +
> +Aml *build_pci_host_bridge_osc_method(bool enable_native_pcie_hotplug)
> +{
> +    Aml *if_ctx;
> +    Aml *if_ctx2;
> +    Aml *else_ctx;
> +    Aml *method;
> +    Aml *a_cwd1 = aml_name("CDW1");
> +    Aml *a_ctrl = aml_local(0);
> +
> +    method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
> +    aml_append(method, aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
> +
> +    if_ctx = aml_if(aml_equal(
> +        aml_arg(0), aml_touuid("33DB4D5B-1FF7-401C-9657-7441C03DD766")));
> +    aml_append(if_ctx, aml_create_dword_field(aml_arg(3), aml_int(4), "CDW2"));
> +    aml_append(if_ctx, aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
> +
> +    aml_append(if_ctx, aml_store(aml_name("CDW3"), a_ctrl));
> +
> +    /*
> +     * Always allow native PME, AER (no dependencies)
> +     * Allow SHPC (PCI bridges can have SHPC controller)
> +     * Disable PCIe Native Hot-plug if ACPI PCI Hot-plug is enabled.
> +     */
> +    aml_append(if_ctx, aml_and(a_ctrl,
> +        aml_int(0x1E | (enable_native_pcie_hotplug ? 0x1 : 0x0)), a_ctrl));
> +
> +    if_ctx2 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(1))));
> +    /* Unknown revision */
> +    aml_append(if_ctx2, aml_or(a_cwd1, aml_int(0x08), a_cwd1));
> +    aml_append(if_ctx, if_ctx2);
> +
> +    if_ctx2 = aml_if(aml_lnot(aml_equal(aml_name("CDW3"), a_ctrl)));
> +    /* Capabilities bits were masked */
> +    aml_append(if_ctx2, aml_or(a_cwd1, aml_int(0x10), a_cwd1));
> +    aml_append(if_ctx, if_ctx2);
> +
> +    /* Update DWORD3 in the buffer */
> +    aml_append(if_ctx, aml_store(a_ctrl, aml_name("CDW3")));
> +    aml_append(method, if_ctx);
> +
> +    else_ctx = aml_else();
> +    /* Unrecognized UUID */
> +    aml_append(else_ctx, aml_or(a_cwd1, aml_int(4), a_cwd1));
> +    aml_append(method, else_ctx);
> +
> +    aml_append(method, aml_return(aml_arg(3)));
> +    return method;
> +}
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b92765fbd9..41fde88b22 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1111,56 +1111,6 @@ static Aml *build_q35_dram_controller(const AcpiMcfgInfo *mcfg)
>       return dev;
>   }
>   
> -static Aml *build_q35_osc_method(bool enable_native_pcie_hotplug)
> -{
> -    Aml *if_ctx;
> -    Aml *if_ctx2;
> -    Aml *else_ctx;
> -    Aml *method;
> -    Aml *a_cwd1 = aml_name("CDW1");
> -    Aml *a_ctrl = aml_local(0);
> -
> -    method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
> -    aml_append(method, aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
> -
> -    if_ctx = aml_if(aml_equal(
> -        aml_arg(0), aml_touuid("33DB4D5B-1FF7-401C-9657-7441C03DD766")));
> -    aml_append(if_ctx, aml_create_dword_field(aml_arg(3), aml_int(4), "CDW2"));
> -    aml_append(if_ctx, aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
> -
> -    aml_append(if_ctx, aml_store(aml_name("CDW3"), a_ctrl));
> -
> -    /*
> -     * Always allow native PME, AER (no dependencies)
> -     * Allow SHPC (PCI bridges can have SHPC controller)
> -     * Disable PCIe Native Hot-plug if ACPI PCI Hot-plug is enabled.
> -     */
> -    aml_append(if_ctx, aml_and(a_ctrl,
> -        aml_int(0x1E | (enable_native_pcie_hotplug ? 0x1 : 0x0)), a_ctrl));
> -
> -    if_ctx2 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(1))));
> -    /* Unknown revision */
> -    aml_append(if_ctx2, aml_or(a_cwd1, aml_int(0x08), a_cwd1));
> -    aml_append(if_ctx, if_ctx2);
> -
> -    if_ctx2 = aml_if(aml_lnot(aml_equal(aml_name("CDW3"), a_ctrl)));
> -    /* Capabilities bits were masked */
> -    aml_append(if_ctx2, aml_or(a_cwd1, aml_int(0x10), a_cwd1));
> -    aml_append(if_ctx, if_ctx2);
> -
> -    /* Update DWORD3 in the buffer */
> -    aml_append(if_ctx, aml_store(a_ctrl, aml_name("CDW3")));
> -    aml_append(method, if_ctx);
> -
> -    else_ctx = aml_else();
> -    /* Unrecognized UUID */
> -    aml_append(else_ctx, aml_or(a_cwd1, aml_int(4), a_cwd1));
> -    aml_append(method, else_ctx);
> -
> -    aml_append(method, aml_return(aml_arg(3)));
> -    return method;
> -}
> -
>   static void build_acpi0017(Aml *table)
>   {
>       Aml *dev, *scope, *method;
> @@ -1231,7 +1181,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>           aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
>           aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
>           aml_append(dev, aml_name_decl("_UID", aml_int(pcmc->pci_root_uid)));
> -        aml_append(dev, build_q35_osc_method(!pm->pcihp_bridge_en));
> +        aml_append(dev, build_pci_host_bridge_osc_method(!pm->pcihp_bridge_en));
>           aml_append(dev, aml_pci_edsm());
>           aml_append(sb_scope, dev);
>           if (mcfg_valid) {
> @@ -1353,7 +1303,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>                   aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
>   
>                   /* Expander bridges do not have ACPI PCI Hot-plug enabled */
> -                aml_append(dev, build_q35_osc_method(true));
> +                aml_append(dev, build_pci_host_bridge_osc_method(true));
>               } else {
>                   aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
>               }


