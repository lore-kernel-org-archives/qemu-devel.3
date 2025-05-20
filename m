Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B597C54E90
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 18:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHSAT-0007O0-6o; Tue, 20 May 2025 14:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uHSAH-0007Ml-Hw
 for qemu-devel@nongnu.org; Tue, 20 May 2025 14:58:14 -0400
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uHSAF-0006s3-IC
 for qemu-devel@nongnu.org; Tue, 20 May 2025 14:58:13 -0400
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-87bff37733cso953111241.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 11:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747767489; x=1748372289; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+Ue0VZQscjx8uhCq0onSbkcHY4DNhqmljR6iVQYURFg=;
 b=Jj60f3RKdAQFCQGawML++/LfuguKiAjJz0dHQa1ZcoTpF5w5TIpRmfIvArM5IJ4nBj
 A4tciUYWZ22HAazSTWTNAo95GPnlT1WHKu1Hqxci7W4yGYxYuEooHwBxBizEd46kzAwU
 eHrNIuL7SEETBdEXkR6ZBRMQHhGwb1iSOnbxyFYB7m+DragU29gGiN/UzzyOU820qD1S
 9M/uXk0EwXwdrrDwEymhxtCuiHZCLcJ7UYmytFjGFoEypujxLL1zBUSjY4J2lruYQKag
 GuA1roxbiThK1Ecofsy+lCVhHPiyLepF1pz6OBk9B8n///eizcoIy2xmVa2bHEhZ/dvF
 h42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747767489; x=1748372289;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+Ue0VZQscjx8uhCq0onSbkcHY4DNhqmljR6iVQYURFg=;
 b=TE5xe/FM8RRjeiGL/rSaVmfKx6CA0px42/E/8XJkXZ7qdhP1L9t6aV6uwgSphjwOTb
 2RDCeVI3UBgIkbbfVooN0n99pvt9evNVH5PyMwJ+9WtPZT6LumSSalWGvWQ5QR1l/v71
 7vtfR56og4BasEa3qXC1/5c2I+yembgjZSfuPu+YO+0MOdyFveKEFsmSH628eqasEp+I
 IIUWN+HyvlJWQqFCyrZiCsEgEmfJFzCb9LlXEZtTmWWISMnAnxF2HNoZhBq18Ngk6D0Q
 sUHTHghcYYty3UQqWNCI6btutyaahTHBqOFuSsUXJR2s0P2C+9lhMRV3uacXakMK4pjA
 tZPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+I3/lP68pCKlMvUDMi5Wq/W/ft61ytTb/wiHZjcBWsrtaJgbnGvnmH/1Z50NsRyzrPG6K+hXzfTkC@nongnu.org
X-Gm-Message-State: AOJu0YxKqOX7EeodIt3q3xhS45ELs2jM6gx1qj8WSPhg9N/9Qq3IEBwE
 zc0ohnY4Qzbbs0ZnGFVyfHvmtR94bmfOd3JU1aGvHCXMwgygmOeUuItB09jHiW2uQws=
X-Gm-Gg: ASbGnctrs0qfUDRqFN5dKxUBnEXg1kTthkXqt7ZCJPqpW4+nz7aJtQzFep1vDR2FW3G
 eeyP3wv/eLv02ZGdDCZiUzu+4DKd1G5op+PnhjrlOC3yGVAjlojiCZaVLds8wRcgNBP8nYt+VCI
 nzZ13JvZXY3pSBzbVHmwlwx/CNAgIH19nEFFAipshM37R0qkPYyP7FfrHAZi2tfNNSJOJyYw5xE
 xeka3L0PJxvyTGYsh96yMsKpqRgrJA7v/HKecnpvnetyX/hTSYPY9BCCAXrukujgWXx8J5hVXjR
 AxjaipFKLCXzeD1JHR1YP1OrUNV9iKu8S8mbyKiaZl26IjvwqSJclyFVqmplHMPZrTRiFMhiShi
 Tda1aa0guqkzeex07wWpqMy+ejYQA8w==
X-Google-Smtp-Source: AGHT+IEYsxuw76BIJpy7FPh1SF0z5jHGnsk5SRBuhcKIDVKrJiSYhfm+5Ml2c8n5Rwoy7UF+AEzSdw==
X-Received: by 2002:a05:6102:3a11:b0:4de:c7fe:34b3 with SMTP id
 ada2fe7eead31-4e0415565bemr16740595137.0.1747767488722; 
 Tue, 20 May 2025 11:58:08 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b401:d47f:6989:b93e:2caa:f174?
 ([2804:7f0:b401:d47f:6989:b93e:2caa:f174])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4dfa66bcfdesm8450619137.11.2025.05.20.11.58.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 11:58:08 -0700 (PDT)
Message-ID: <7fca6021-8dc9-422f-850e-227df3ccf6aa@linaro.org>
Date: Tue, 20 May 2025 15:57:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/22] hw/i386/acpi-build: Introduce
 build_append_pcihp_resources() helper
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org
References: <20250514170431.2786231-1-eric.auger@redhat.com>
 <20250514170431.2786231-10-eric.auger@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250514170431.2786231-10-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=gustavo.romero@linaro.org; helo=mail-ua1-x931.google.com
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

Hi Eric,

On 5/14/25 14:00, Eric Auger wrote:
> Extract the code that reserves resources for ACPI PCI hotplug
> into a new helper named build_append_pcihp_resources() and
> move it to pcihp.c. We will reuse it on ARM.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   include/hw/acpi/pcihp.h |  2 ++
>   hw/acpi/pcihp.c         | 20 ++++++++++++++++++++
>   hw/i386/acpi-build.c    | 15 ++-------------
>   3 files changed, 24 insertions(+), 13 deletions(-)

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> index 95efe9a804..ec9b010e4a 100644
> --- a/include/hw/acpi/pcihp.h
> +++ b/include/hw/acpi/pcihp.h
> @@ -75,6 +75,8 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>   
>   void build_acpi_pci_hotplug(Aml *table, uint64_t pcihp_addr);
>   void build_append_pci_dsm_func0_common(Aml *ctx, Aml *retvar);
> +void build_append_pcihp_resources(Aml *table,
> +                                  uint64_t io_addr, uint64_t io_len);
>   
>   /* Called on reset */
>   void acpi_pcihp_reset(AcpiPciHpState *s);
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index e0260f67e6..fb54c31f77 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -685,6 +685,26 @@ void build_acpi_pci_hotplug(Aml *table, uint64_t pcihp_addr)
>       aml_append(table, scope);
>   }
>   
> +/* Reserve PCIHP resources */
> +void build_append_pcihp_resources(Aml *scope /* \\_SB.PCI0 */,
> +                                  uint64_t io_addr, uint64_t io_len)
> +{
> +    Aml *dev, *crs;
> +
> +    dev = aml_device("PHPR");
> +    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A06")));
> +    aml_append(dev,
> +               aml_name_decl("_UID", aml_string("PCI Hotplug resources")));
> +    /* device present, functioning, decoding, not shown in UI */
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xB)));
> +    crs = aml_resource_template();
> +    aml_append(crs,
> +        aml_io(AML_DECODE16, io_addr, io_addr, 1, io_len)
> +    );
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +    aml_append(scope, dev);
> +}
> +
>   const VMStateDescription vmstate_acpi_pcihp_pci_status = {
>       .name = "acpi_pcihp_pci_status",
>       .version_id = 1,
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 41fde88b22..ca59185aac 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1432,19 +1432,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>   
>       /* reserve PCIHP resources */
>       if (pm->pcihp_io_len && (pm->pcihp_bridge_en || pm->pcihp_root_en)) {
> -        dev = aml_device("PHPR");
> -        aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A06")));
> -        aml_append(dev,
> -            aml_name_decl("_UID", aml_string("PCI Hotplug resources")));
> -        /* device present, functioning, decoding, not shown in UI */
> -        aml_append(dev, aml_name_decl("_STA", aml_int(0xB)));
> -        crs = aml_resource_template();
> -        aml_append(crs,
> -            aml_io(AML_DECODE16, pm->pcihp_io_base, pm->pcihp_io_base, 1,
> -                   pm->pcihp_io_len)
> -        );
> -        aml_append(dev, aml_name_decl("_CRS", crs));
> -        aml_append(scope, dev);
> +        build_append_pcihp_resources(scope,
> +                                      pm->pcihp_io_base, pm->pcihp_io_len);
>       }
>       aml_append(dsdt, scope);
>   


