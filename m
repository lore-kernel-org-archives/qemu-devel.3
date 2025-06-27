Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C30C7EE32
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 11:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV7fG-0004Nw-Mh; Fri, 27 Jun 2025 07:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV7fC-0004NL-KV
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV7f5-00088m-EK
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751025267;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fbLM+YHNkL9L46MA1LTxpRhJggNUi0XejDoE6z2saa4=;
 b=gNEC0Fy31IEPi+biOeFJ8uQ8j1i01xF5+lOZN8WEQZWrSZDozvW7Gx1gLwNfLuATYWWkov
 X9QXa5PFpADo/fcLbSIc9AOfq0wWPRv2rE+YC+rxpFW1nfprNhj7jr0GHtfH1JUirhZRl0
 P57owttpRlGAPLUDxNBdbm5tgJZy31g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-rXOlXEaWO7q4utNVdk195Q-1; Fri, 27 Jun 2025 07:54:26 -0400
X-MC-Unique: rXOlXEaWO7q4utNVdk195Q-1
X-Mimecast-MFC-AGG-ID: rXOlXEaWO7q4utNVdk195Q_1751025265
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450d290d542so12927465e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 04:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751025265; x=1751630065;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fbLM+YHNkL9L46MA1LTxpRhJggNUi0XejDoE6z2saa4=;
 b=qfxr1zD1wnOu1T78urf08ACzmTsuE5xRdnYV09m/hcBaZRNzGqrWR5uuj/jokXx1pi
 GTuKj9lZW6nb+icB5ZsKG4neBDieIm5OEWql+vMJWY4zs3bI9Pat6RbEm3A3D+QX6ZuH
 6wrvSCAKB90E/SZAt28gCuItukSrZ0/Dm9nC9eTcgPeY8rEWcr5kDFMaPLHF+x89JOlE
 Z26LZFVNpwkaT1KtTNE/g3pns9ZrV0JxKL/yZIe2m6Z66DkXpLSS4DO6FQo2cFffUgvz
 OtS9i6oSpc1Oc/30C1PFyO0vRm9N0Bd1pF66np24l7W0lAotqb3yddRr4X0JD5mknIW2
 9biw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/HhEm8SE7d5PhI1Mo7EegEHAuO9oZAvQU5CMc0igVwUUmQK9Kg+KUKIPXDane6/86VtutokMVsgEd@nongnu.org
X-Gm-Message-State: AOJu0YynUY6TioWBf6z1laCqy7G2IHdIlm1eBaw59WBd0UyG0KR3PMbG
 /Vgq82IjCVlKH5DQHFO5WJ91ZWk7clfbT4ymmGeBQ1az+eJXjIkRv0NP9tahQmkun3a8p2JliQn
 LeVZ94GI5do3qnZnxu+X1gFNX0j9LNOaCvuTpkGs/mRZpyyT2DdNRc67I
X-Gm-Gg: ASbGncslzZ1YnfRErXQ8qMfCQHRZm0pC5KsskOhI53et9ezNt7qPhyvcLZSlV6/eNLp
 pSxNk665n/A9PAMKvpop+BmXNf/HZnEAhWXORFHUyWtjXoJHXdMD6FzWW+0N75t2sB6TcTZolej
 uZfMJdyhYsiUfTWtB23AjGcnxOVKLYux0wVKO6WXB03hoAUjkuVQl4zd5XkUL29h5uvgrc7o8qg
 C6BcSfSHPoMFXRwosViUwQGeUyVN6tU/3xNN4Ob/YK3byJU56C5y0+xOGT2rZ+/r2XXaZz0/kBk
 8pJOgH7pDwQNfGvacKFfobYdwNrbGhjHUB7jArSm1Ow7y2eV/0BGzg6bTuvfNI1T8SHxuA==
X-Received: by 2002:a05:600c:6745:b0:43c:fe5e:f040 with SMTP id
 5b1f17b1804b1-4539035972emr19140225e9.23.1751025264571; 
 Fri, 27 Jun 2025 04:54:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7IIytyJFiUwbus+g3SxZ2iEtyKh3egllQ+JQ72W8CiOTmhtcykuMooCfIIBTAd4rwByjTzQ==
X-Received: by 2002:a05:600c:6745:b0:43c:fe5e:f040 with SMTP id
 5b1f17b1804b1-4539035972emr19139855e9.23.1751025264035; 
 Fri, 27 Jun 2025 04:54:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5f44dsm2482871f8f.87.2025.06.27.04.54.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Jun 2025 04:54:23 -0700 (PDT)
Message-ID: <a25ab1b2-768c-4690-a7cd-9ffb86035621@redhat.com>
Date: Fri, 27 Jun 2025 13:54:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/11] hw/arm/virt-acpi-build: Re-arrange SMMUv3 IORT
 build
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, imammedo@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 gustavo.romero@linaro.org, linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250623094230.76084-1-shameerali.kolothum.thodi@huawei.com>
 <20250623094230.76084-3-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250623094230.76084-3-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/23/25 11:42 AM, Shameer Kolothum wrote:
> Introduce a new struct AcpiIortSMMUv3Dev to hold all the information
> required for SMMUv3 IORT node and use that for populating the node.
>
> The current machine wide SMMUv3 is named as legacy SMMUv3 as we will
> soon add support for user-creatable SMMUv3 devices. These changes will
> be useful to have common code paths when we add that support.
>
> Tested-by: Nathan Chen <nathanc@nvidia.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

> ---
>  hw/arm/virt-acpi-build.c | 109 +++++++++++++++++++++++++++------------
>  hw/arm/virt.c            |   1 +
>  include/hw/arm/virt.h    |   1 +
>  3 files changed, 77 insertions(+), 34 deletions(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 7e8e0f0298..28489cf59f 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -266,6 +266,34 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
>      return idmap_a->input_base - idmap_b->input_base;
>  }
>  
> +typedef struct AcpiIortSMMUv3Dev {
> +    int irq;
> +    hwaddr base;
> +    GArray *idmaps;
> +    /* Offset of the SMMUv3 IORT Node relative to the start of the IORT */
> +    size_t offset;
> +} AcpiIortSMMUv3Dev;
> +
> +static void populate_smmuv3_legacy_dev(GArray *sdev_blob)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
> +    AcpiIortSMMUv3Dev sdev;
> +
> +    sdev.idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
> +    object_child_foreach_recursive(object_get_root(), iort_host_bridges,
> +                                   sdev.idmaps);
> +    /*
> +     * There can be only one legacy SMMUv3("iommu=smmuv3") as it is a machine
> +     * wide one. Since it may cover multiple PCIe RCs(based on "bypass_iommu"
> +     * property), may have multiple SMMUv3 idmaps. Sort it by input_base.
> +     */
> +    g_array_sort(sdev.idmaps, iort_idmap_compare);
> +
> +    sdev.base = vms->memmap[VIRT_SMMU].base;
> +    sdev.irq = vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
> +    g_array_append_val(sdev_blob, sdev);
> +}
> +
>  /*
>   * Input Output Remapping Table (IORT)
>   * Conforms to "IO Remapping Table System Software on ARM Platforms",
> @@ -274,11 +302,12 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
>  static void
>  build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  {
> -    int i, nb_nodes, rc_mapping_count;
> -    size_t node_size, smmu_offset = 0;
> -    AcpiIortIdMapping *idmap;
> +    int i, j, nb_nodes, rc_mapping_count;
> +    AcpiIortSMMUv3Dev *sdev;
> +    size_t node_size;
> +    int num_smmus = 0;
>      uint32_t id = 0;
> -    GArray *smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
> +    GArray *smmuv3_devs = g_array_new(false, true, sizeof(AcpiIortSMMUv3Dev));
>      GArray *its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
>  
>      AcpiTable table = { .sig = "IORT", .rev = 3, .oem_id = vms->oem_id,
> @@ -286,28 +315,32 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      /* Table 2 The IORT */
>      acpi_table_begin(&table, table_data);
>  
> -    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
> -        AcpiIortIdMapping next_range = {0};
> -
> -        object_child_foreach_recursive(object_get_root(),
> -                                       iort_host_bridges, smmu_idmaps);
> -
> -        /* Sort the smmu idmap by input_base */
> -        g_array_sort(smmu_idmaps, iort_idmap_compare);
> +    nb_nodes = 2; /* RC, ITS */
> +    if (vms->legacy_smmuv3_present) {
> +        populate_smmuv3_legacy_dev(smmuv3_devs);
> +    }
>  
> +    num_smmus = smmuv3_devs->len;
> +    if (num_smmus) {
> +        AcpiIortIdMapping next_range = {0};
> +        int smmu_map_cnt = 0;
>          /*
>           * Split the whole RIDs by mapping from RC to SMMU,
>           * build the ID mapping from RC to ITS directly.
>           */
> -        for (i = 0; i < smmu_idmaps->len; i++) {
> -            idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
> -
> -            if (next_range.input_base < idmap->input_base) {
> -                next_range.id_count = idmap->input_base - next_range.input_base;
> -                g_array_append_val(its_idmaps, next_range);
> +        for (i = 0; i < num_smmus; i++) {
> +            sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
> +            for (j = 0; j < sdev->idmaps->len; j++) {
> +                AcpiIortIdMapping *idmap = &g_array_index(sdev->idmaps,
> +                                                          AcpiIortIdMapping, j);
> +                if (next_range.input_base < idmap->input_base) {
> +                    next_range.id_count = idmap->input_base -
> +                                          next_range.input_base;
> +                    g_array_append_val(its_idmaps, next_range);
> +                }
> +                next_range.input_base = idmap->input_base + idmap->id_count;
> +                smmu_map_cnt++;
>              }
> -
> -            next_range.input_base = idmap->input_base + idmap->id_count;
>          }
>  
>          /* Append the last RC -> ITS ID mapping */
> @@ -316,10 +349,9 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>              g_array_append_val(its_idmaps, next_range);
>          }
>  
> -        nb_nodes = 3; /* RC, ITS, SMMUv3 */
> -        rc_mapping_count = smmu_idmaps->len + its_idmaps->len;
> +        nb_nodes += num_smmus;
> +        rc_mapping_count = smmu_map_cnt + its_idmaps->len;
>      } else {
> -        nb_nodes = 2; /* RC, ITS */
>          rc_mapping_count = 1;
>      }
>      /* Number of IORT Nodes */
> @@ -341,10 +373,11 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      /* GIC ITS Identifier Array */
>      build_append_int_noprefix(table_data, 0 /* MADT translation_id */, 4);
>  
> -    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
> -        int irq =  vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
> +    for (i = 0; i < num_smmus; i++) {
> +        sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
> +        int irq = sdev->irq;
>  
> -        smmu_offset = table_data->len - table.table_offset;
> +        sdev->offset = table_data->len - table.table_offset;
>          /* Table 9 SMMUv3 Format */
>          build_append_int_noprefix(table_data, 4 /* SMMUv3 */, 1); /* Type */
>          node_size =  SMMU_V3_ENTRY_SIZE + ID_MAPPING_ENTRY_SIZE;
> @@ -355,7 +388,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          /* Reference to ID Array */
>          build_append_int_noprefix(table_data, SMMU_V3_ENTRY_SIZE, 4);
>          /* Base address */
> -        build_append_int_noprefix(table_data, vms->memmap[VIRT_SMMU].base, 8);
> +        build_append_int_noprefix(table_data, sdev->base, 8);
>          /* Flags */
>          build_append_int_noprefix(table_data, 1 /* COHACC Override */, 4);
>          build_append_int_noprefix(table_data, 0, 4); /* Reserved */
> @@ -404,15 +437,19 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      build_append_int_noprefix(table_data, 0, 3); /* Reserved */
>  
>      /* Output Reference */
> -    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
> +    if (num_smmus) {
>          AcpiIortIdMapping *range;
>  
>          /* translated RIDs connect to SMMUv3 node: RC -> SMMUv3 -> ITS */
> -        for (i = 0; i < smmu_idmaps->len; i++) {
> -            range = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
> -            /* output IORT node is the smmuv3 node */
> -            build_iort_id_mapping(table_data, range->input_base,
> -                                  range->id_count, smmu_offset);
> +        for (i = 0; i < num_smmus; i++) {
> +            sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
> +
> +            for (j = 0; j < sdev->idmaps->len; j++) {
> +                range = &g_array_index(sdev->idmaps, AcpiIortIdMapping, j);
> +                /* output IORT node is the smmuv3 node */
> +                build_iort_id_mapping(table_data, range->input_base,
> +                                      range->id_count, sdev->offset);
> +            }
>          }
>  
>          /* bypassed RIDs connect to ITS group node directly: RC -> ITS */
> @@ -428,8 +465,12 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      }
>  
>      acpi_table_end(linker, &table);
> -    g_array_free(smmu_idmaps, true);
>      g_array_free(its_idmaps, true);
> +    for (i = 0; i < num_smmus; i++) {
> +        sdev = &g_array_index(smmuv3_devs, AcpiIortSMMUv3Dev, i);
> +        g_array_free(sdev->idmaps, true);
> +    }
> +    g_array_free(smmuv3_devs, true);
>  }
>  
>  /*
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 9a6cd085a3..73bd2bd5f2 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1614,6 +1614,7 @@ static void create_pcie(VirtMachineState *vms)
>              create_smmu(vms, vms->bus);
>              qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map",
>                                     0x0, vms->iommu_phandle, 0x0, 0x10000);
> +            vms->legacy_smmuv3_present = true;
>              break;
>          default:
>              g_assert_not_reached();
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 9a1b0f53d2..8b1404b5f6 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -174,6 +174,7 @@ struct VirtMachineState {
>      char *oem_id;
>      char *oem_table_id;
>      bool ns_el2_virt_timer_irq;
> +    bool legacy_smmuv3_present;
>  };
>  
>  #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)


