Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59B8C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 13:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1mZJ-0006iV-6P; Mon, 07 Apr 2025 09:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1u1mYV-0006YV-Pl
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 09:30:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1u1mYK-0007Yr-Kt
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 09:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744032613;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5yYQ8iH6g2DJrpmcWfAUZDWMJZm83Xuy4dF4K7MbYHo=;
 b=PGMk0h1ylyy/rogsIRSAIOehbgYRQxoHZSc5sCE9KOE0OCVeeWDXxF5+RwUrV5Hxwfohu3
 fQmFq6E+A/uhJck6wU4c0C/cQB2XoaAuxpKkwrTwE+ROsDU16FjRoVKoa90KTstrjt+I/J
 IN/ZC5qYiWGfvMZDILzMEBvu1tcayJo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-LgYeFR_gN2SxG9TV4ah4eg-1; Mon, 07 Apr 2025 09:30:11 -0400
X-MC-Unique: LgYeFR_gN2SxG9TV4ah4eg-1
X-Mimecast-MFC-AGG-ID: LgYeFR_gN2SxG9TV4ah4eg_1744032610
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43ceb011ea5so29360075e9.2
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 06:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744032610; x=1744637410;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5yYQ8iH6g2DJrpmcWfAUZDWMJZm83Xuy4dF4K7MbYHo=;
 b=oRPDkksaSwRUG4jd+0AQmh6DJUCKArW+6Bt8ajyi2dPr1Xrt8T+65pf11naLwAWs6I
 vxAP7YjHb6piUkRHXmmbDaDXxlHjs4BDeZZOK5Pp0PfClXyijcvPx0B+YuyMmZN6epmk
 OkyiaEx0/uDRKqrtNJeQX4Vmk/sTgmB0F1l7WeHItv8yoFa2el0RGYnVurNvWhGx0pSY
 +FtEQfm1eMJ929XLCrPJq+tKmrb0hmNMkxSpZgxs0h7e1CYZLJIYkA12T1qXrFvNmYd9
 EJHmUF9K8rvs042d6Czfd8VQzit0SH7lCVQwdomfT8aCIo7IkJluQArs34/KKbWYouAF
 LFvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGFyb94QsCotU+Zxv7XxENFo42Mdg7nC3GQjnxRb8AET1iNNN+kYyTKdZQkK1wBijmi3RLfDupkVld@nongnu.org
X-Gm-Message-State: AOJu0Yx+dylqBgWy9goNPySuHSRZtNfWYBsaLyTrV5HHR47zcRpD8W17
 4QkvrT/7kj7LfKuDnLNkncZ6lZhPOKAfqgEf/slR94qeNqIqJkSD78tgXNxDtFhNu/YKyz3z7FI
 wAzZyuWz+AUOuHI6Q2ypuRFgL46MWGFL8KdJGGeL0hS2qHmQ3VoA/
X-Gm-Gg: ASbGncvBZ8kQcnooY6Ej7GyRrwMi/esIClKDsxHXy6YU9KL34opbyGKJXps+/9tH/Pc
 ugjjAn3QZ8lgiugUFutO2eZz9e+dBrie6Rh9llqNUWedSBnEkfz2u63SasKScL65XqxEqteEuf6
 jjecusB45hoZFyXQNodDiIwSPfrTJpcNlpl8Epiohq2Mvr8P6H2sEFriFSQcgzBc9JGEuHArJIY
 PNPCB9G7CJgIMlcjJTADptQHKkaHAwb9iCpOrsUPdbrt3Z3H6078PcCRTd8+7qw/zwhkDKgbzIt
 2CDNAlgup1jMICRlTmt8dHQK/YrVAHs4BiSwKvKWxnQDJVMc+gN4OOibdpXR1Ug=
X-Received: by 2002:a05:600c:3494:b0:43c:efed:732c with SMTP id
 5b1f17b1804b1-43ecfa0714emr99010235e9.28.1744032610386; 
 Mon, 07 Apr 2025 06:30:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoHlx3Rt22t8ImtxnUsKfWCWHkP+MD8J6/fQYdJTc1KICevZwBBwBiXEOQapotkW89rnJa2Q==
X-Received: by 2002:a05:600c:3494:b0:43c:efed:732c with SMTP id
 5b1f17b1804b1-43ecfa0714emr99009925e9.28.1744032609928; 
 Mon, 07 Apr 2025 06:30:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec364c959sm129643265e9.25.2025.04.07.06.30.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 06:30:09 -0700 (PDT)
Message-ID: <0a69bd8b-c053-46b7-80a9-c9f3ea374dd7@redhat.com>
Date: Mon, 7 Apr 2025 15:30:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v3 7/9] hw/arm/virt-acpi: Always build IORT table
 (even with GIC ITS disabled)
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Udo Steinberg <udo@hypervisor.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>
References: <20250403204029.47958-1-philmd@linaro.org>
 <20250403204029.47958-8-philmd@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250403204029.47958-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Philippe,

On 4/3/25 10:40 PM, Philippe Mathieu-Daudé wrote:
> Citing Gustavo [*]:
>
>   Gating IORT table generation entirely based on the presence
>   of ITS looks wrong because IORT table has data beyond GIC ITS,
>   like for SMMUv3 etc..
> [*] https://lore.kernel.org/qemu-devel/bae6e29a-7290-47d2-8caf-14702ee091f0@linaro.org/
>
> Reported-by: Gustavo Romero <gustavo.romero@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/arm/virt-acpi-build.c | 38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 1c389ef5cdb..e7e27951cb9 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -287,6 +287,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      uint32_t id = 0;
>      GArray *smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
>      GArray *its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
> +    bool has_its = its_enabled(vms);
>  
>      AcpiTable table = { .sig = "IORT", .rev = 3, .oem_id = vms->oem_id,
>                          .oem_table_id = vms->oem_table_id };
> @@ -325,9 +326,12 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  
>          nb_nodes = 3; /* RC, ITS, SMMUv3 */
>          rc_mapping_count = smmu_idmaps->len + its_idmaps->len;
> -    } else {
> +    } else if (has_its) {
>          nb_nodes = 2; /* RC, ITS */
>          rc_mapping_count = 1;
> +    } else {
> +        nb_nodes = 1; /* RC */
> +        rc_mapping_count = 1;
>      }
>      /* Number of IORT Nodes */
>      build_append_int_noprefix(table_data, nb_nodes, 4);
> @@ -336,17 +340,19 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      build_append_int_noprefix(table_data, IORT_NODE_OFFSET, 4);
>      build_append_int_noprefix(table_data, 0, 4); /* Reserved */
>  
> -    /* Table 12 ITS Group Format */
> -    build_append_int_noprefix(table_data, 0 /* ITS Group */, 1); /* Type */
> -    node_size =  20 /* fixed header size */ + 4 /* 1 GIC ITS Identifier */;
> -    build_append_int_noprefix(table_data, node_size, 2); /* Length */
> -    build_append_int_noprefix(table_data, 1, 1); /* Revision */
> -    build_append_int_noprefix(table_data, id++, 4); /* Identifier */
> -    build_append_int_noprefix(table_data, 0, 4); /* Number of ID mappings */
> -    build_append_int_noprefix(table_data, 0, 4); /* Reference to ID Array */
> -    build_append_int_noprefix(table_data, 1, 4); /* Number of ITSs */
> -    /* GIC ITS Identifier Array */
> -    build_append_int_noprefix(table_data, 0 /* MADT translation_id */, 4);
> +    if (has_its) {
> +        /* Table 12 ITS Group Format */
> +        build_append_int_noprefix(table_data, 0 /* ITS Group */, 1); /* Type */ //
> +        node_size =  20 /* fixed header size */ + 4 /* 1 GIC ITS Identifier */;
> +        build_append_int_noprefix(table_data, node_size, 2); /* Length */
> +        build_append_int_noprefix(table_data, 1, 1); /* Revision */
> +        build_append_int_noprefix(table_data, id++, 4); /* Identifier */
> +        build_append_int_noprefix(table_data, 0, 4); /* Number of ID mappings */
> +        build_append_int_noprefix(table_data, 0, 4); /* Reference to ID Array */
> +        build_append_int_noprefix(table_data, 1, 4); /* Number of ITSs */
> +        /* GIC ITS Identifier Array */
> +        build_append_int_noprefix(table_data, 0 /* MADT translation_id */, 4);
> +    }
Do we allow configs where we have SMMU and no ITS?

The IORT spec says "
ID mappings that are defined in an SMMU IORT node can only have an ITS
Group node as an output reference,
or no IDs in the case of a system that does not have ITS units. All
other object types are explicitly forbidden.
"
So in case we do not have any ITS we also need to take care of ID
mappings of SMMUs

Eric
>  
>      if (vms->iommu == VIRT_IOMMU_SMMUV3) {
>          int irq =  vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
> @@ -429,7 +435,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>              build_iort_id_mapping(table_data, range->input_base,
>                                    range->id_count, IORT_NODE_OFFSET);
>          }
> -    } else {
> +    } else if (has_its) {
>          /* output IORT node is the ITS group node (the first node) */
>          build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
>      }
> @@ -979,10 +985,8 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>                            vms->oem_table_id);
>      }
>  
> -    if (its_enabled(vms)) {
> -        acpi_add_table(table_offsets, tables_blob);
> -        build_iort(tables_blob, tables->linker, vms);
> -    }
> +    acpi_add_table(table_offsets, tables_blob);
> +    build_iort(tables_blob, tables->linker, vms);
>  
>  #ifdef CONFIG_TPM
>      if (tpm_get_version(tpm_find()) == TPM_VERSION_2_0) {


