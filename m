Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253F6C3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 03:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0XJt-0004kX-Q6; Thu, 03 Apr 2025 23:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u0XJq-0004bC-7B
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 23:02:11 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u0XJn-00084n-9f
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 23:02:09 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-30362ee1312so1574774a91.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 20:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743735725; x=1744340525; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vw8QvdfLBmSPkoH0GrKgyqq86qhGTDGrJmvgU2pUblw=;
 b=ETj0DEfXD2Sl3dcoaC+t8d0Ym0NOdCZRc2q92VS3oP4mT7VG13S4Lat76Z0ZEFeqFQ
 U/t8iZyZuuCJ1tPJwWj2g0hzMZom6Fo16V7PyLSCFGx5n28Nv4Zq+VnQ6hDwP6kRLZBv
 kLKUL4E5ze89i6KLiQcOEbg+uRJYVT/Gx4tnxx0X+zIykDn/CEN5xDyrwZLdTW2gDtIY
 1oMhOQNADfHW3D9El0dbpvXUEmrRr9VDEtbOLiQLx15H6Z8lUWGq4xYEwSvRCemWOzSq
 5AX2zvqm2ApPQZAjaRsBw/fid+F1Yne0pZKJEZhwYz1I5z7WiFcBBSzJwMwWFrH75bKm
 H1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743735725; x=1744340525;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vw8QvdfLBmSPkoH0GrKgyqq86qhGTDGrJmvgU2pUblw=;
 b=nyxd7DcmZaRM6fgg/bMlmzFx84m1jaZh3kZXMS/LYMMJclUiOzvTkuFsBrmY/OgyU/
 nPtmJf4XX+msgY7R3XSzP673dmVN5mv7LdtmXtxxzv1+3WqgESutB2O1s55n3FMIMZtb
 gJsFrckiXFhVCX+aNEinMbKLm6TPQsiPdmCNVxn84EKBNXEkItU0Mf/RgEjNlTqX1Aaf
 M8MmyJ2gYHoUbrTa6v2wPiMrfsZEtNwBZjupwswq4fFEC0XahIvvRxBARo5VGW8t6f3e
 ZNZScQzTChHHBRpkpc4pIfBTVMQ45vcVSxALa5EWsGWemdfH+WRlmVI5rpeqspyY9Fvh
 FKNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/U5IHT4nfLVYrvj26+gRl/4eGsiYc62LTSVItLVNpMAMLHAJj0o+h80+V0zxMKUPYlVsLYzAki4Zi@nongnu.org
X-Gm-Message-State: AOJu0YwGfI6OBsFCkEiDuZQGwWToMubHtgZs8wA39UXrnd+uaKwQYZNc
 0ZFF7A1uW/3I0P0CKlsKiQQslbySmtBgV2lTS5irX9peJGOUzWGg5DYV9/WDTlA=
X-Gm-Gg: ASbGncv+9NcIEmVVp6fbGgp20huePiA8mmFTZ42P9O2YC+iF72MCNxKUqYKkyR2eMd8
 k0/opm+38KtuxxV1WArWuSsCcnjt75YTEGeT3a3kQRwLUoxlkkbEUffbeY4JsWRhaxCBZDw77iU
 tMRffpXBBVKfLLTmt0T9zyYFncSkJ7FRQXpzDNxv2PYKR5rLT/lIMGLSSGrAW/CDg7w+paiQD2a
 Dn/rH3p3s2kpcPCAuPxXSPOcVaP1PWjXCCTG1r6Z7wkmT4uVwqbCTIH7nWx1/IdmDtlidPes8E5
 pxbf25vvthWNNF4XgC18Dqzrk/X6wJyWIMM0Bo5oZviW7DNlNtETONLe
X-Google-Smtp-Source: AGHT+IGSJFAuAEwpv4fnhACcbtVeO+XMW+8oDDEM/WpYpcSZSytUy6Z0Qx1Fb6boId3dwJX6CS8s3A==
X-Received: by 2002:a17:90a:d604:b0:2ff:64a0:4a58 with SMTP id
 98e67ed59e1d1-306a4970dcdmr2167089a91.22.1743735725670; 
 Thu, 03 Apr 2025 20:02:05 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.49.46])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3057cb90bedsm2494408a91.43.2025.04.03.20.02.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 20:02:05 -0700 (PDT)
Message-ID: <ecf79fce-9406-4889-91a8-0e0fdf52eb4b@linaro.org>
Date: Fri, 4 Apr 2025 00:02:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v3 7/9] hw/arm/virt-acpi: Always build IORT table
 (even with GIC ITS disabled)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Udo Steinberg <udo@hypervisor.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>
References: <20250403204029.47958-1-philmd@linaro.org>
 <20250403204029.47958-8-philmd@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250403204029.47958-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x1031.google.com
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

Hi Phil,

On 4/3/25 17:40, Philippe Mathieu-Daudé wrote:
> Citing Gustavo [*]:
> 
>    Gating IORT table generation entirely based on the presence
>    of ITS looks wrong because IORT table has data beyond GIC ITS,
>    like for SMMUv3 etc..
> 
> [*] https://lore.kernel.org/qemu-devel/bae6e29a-7290-47d2-8caf-14702ee091f0@linaro.org/
> 
> Reported-by: Gustavo Romero <gustavo.romero@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Maybe it's worth to cite the "IO Remapping Table Platform Design Document",
in particular page 10, which reads:

"the IORT provides an ACPI description for IO topology, SMMUs, and GIC ITSs"

https://developer.arm.com/documentation/den0049/latest/

Now that the target is 10.1, let me thing a bit more about it.


Cheers,
Gustavo

> ---
>   hw/arm/virt-acpi-build.c | 38 +++++++++++++++++++++-----------------
>   1 file changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 1c389ef5cdb..e7e27951cb9 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -287,6 +287,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>       uint32_t id = 0;
>       GArray *smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
>       GArray *its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
> +    bool has_its = its_enabled(vms);
>   
>       AcpiTable table = { .sig = "IORT", .rev = 3, .oem_id = vms->oem_id,
>                           .oem_table_id = vms->oem_table_id };
> @@ -325,9 +326,12 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>   
>           nb_nodes = 3; /* RC, ITS, SMMUv3 */
>           rc_mapping_count = smmu_idmaps->len + its_idmaps->len;
> -    } else {
> +    } else if (has_its) {
>           nb_nodes = 2; /* RC, ITS */
>           rc_mapping_count = 1;
> +    } else {
> +        nb_nodes = 1; /* RC */
> +        rc_mapping_count = 1;
>       }
>       /* Number of IORT Nodes */
>       build_append_int_noprefix(table_data, nb_nodes, 4);
> @@ -336,17 +340,19 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>       build_append_int_noprefix(table_data, IORT_NODE_OFFSET, 4);
>       build_append_int_noprefix(table_data, 0, 4); /* Reserved */
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
>   
>       if (vms->iommu == VIRT_IOMMU_SMMUV3) {
>           int irq =  vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
> @@ -429,7 +435,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>               build_iort_id_mapping(table_data, range->input_base,
>                                     range->id_count, IORT_NODE_OFFSET);
>           }
> -    } else {
> +    } else if (has_its) {
>           /* output IORT node is the ITS group node (the first node) */
>           build_iort_id_mapping(table_data, 0, 0x10000, IORT_NODE_OFFSET);
>       }
> @@ -979,10 +985,8 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>                             vms->oem_table_id);
>       }
>   
> -    if (its_enabled(vms)) {
> -        acpi_add_table(table_offsets, tables_blob);
> -        build_iort(tables_blob, tables->linker, vms);
> -    }
> +    acpi_add_table(table_offsets, tables_blob);
> +    build_iort(tables_blob, tables->linker, vms);
>   
>   #ifdef CONFIG_TPM
>       if (tpm_get_version(tpm_find()) == TPM_VERSION_2_0) {


