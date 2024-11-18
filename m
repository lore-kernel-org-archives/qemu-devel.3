Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3C8D49208
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 10:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCyb2-0000vf-QM; Mon, 18 Nov 2024 05:03:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tCyaD-0000qJ-3K
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 05:02:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tCya9-0006cs-JU
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 05:02:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731924126;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8+cHbmttZqXAaMqsoD4PN/ATDMDNlBpVDagaXg0yE3A=;
 b=UvwLyzZDbIaIF+lifzuYbCh4nHY15DMXUbPr9zkQVybj+6ROxhZ5UriEkEV9a6Xj15jt7g
 zGK+JdAcEEMDWydDAEIZF6izp0FjvL4lmuGmQTZzyBmb1jpJuGQPHzkhwIfKMzHqsXRINu
 gJmC7eMXkyNqLLan4wszNN3RjceLA1E=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-6n8e4lFQPt-3MXCwbMi3WQ-1; Mon, 18 Nov 2024 05:02:05 -0500
X-MC-Unique: 6n8e4lFQPt-3MXCwbMi3WQ-1
X-Mimecast-MFC-AGG-ID: 6n8e4lFQPt-3MXCwbMi3WQ
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7181285c746so2143775a34.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 02:02:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731924125; x=1732528925;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8+cHbmttZqXAaMqsoD4PN/ATDMDNlBpVDagaXg0yE3A=;
 b=B8uAjUA20gQBKo0/vxavToQ96ju4+cixFC+XU3AHKG2wHO4pwJ3OVEpN4Pxzc5NVhJ
 j/TPxr1LC5mTctdwI6jdiTed0A6UoGlDzpawWX5YYFEQs8cuhe7tpsjziOqbKa/w7GoA
 XHoq0Vo4xQTuipaFwhY08NMwUQSn6EtWd16ue4SuUi5u8xeOrd7zaBABIvioyrEjYTAq
 0vGpag7p8ykXsIaWtP2AVd8JEmmOy8OU3UDPZnf1rKM8wKEMT4567rOXnMOB2rnEPJHZ
 sjOAR0mEaQaojmYQ6IEwWPXAcBk3QIKss6EiPX13Dvb3UCeh8fvmmplxLVwTCEXqLJBz
 GlZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK65iKSdLTswLA5fgRub3/WZQxr1BMTfdYHx96tc9Wz0UuCutq4ecezXi1yK92qResmorUDN0KKENc@nongnu.org
X-Gm-Message-State: AOJu0Yx4pgU36QLLItcU7/99PfXcmwQvY8F0lq1CqUeqodiKSUFBXe2+
 3Vhc3FmSorMLLyk/UQOkH37vqmg5NXItRoQPE4FdifFBTWVr2bRr6wPE2E6bEEohiHT3NurGr2z
 j6eKeyCIEJuo7R5iOWE84C1HVx3toQu9Ey4WBBHGr0oHZ4Fiog9fY
X-Received: by 2002:a05:6830:6582:b0:718:5bed:3596 with SMTP id
 46e09a7af769-71a77987cfbmr7810997a34.15.1731924124854; 
 Mon, 18 Nov 2024 02:02:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgnE+krKflDKodw/siJlHoey7WZZPWQutlF9OO3aUNLjJDD5yTTvmPuABZSZTNVX8a1JfkHw==
X-Received: by 2002:a05:6830:6582:b0:718:5bed:3596 with SMTP id
 46e09a7af769-71a77987cfbmr7810970a34.15.1731924124445; 
 Mon, 18 Nov 2024 02:02:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635a9f23besm56046481cf.30.2024.11.18.02.02.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 02:02:03 -0800 (PST)
Message-ID: <1dcea5ca-806f-4f51-8b13-faf5d62eb086@redhat.com>
Date: Mon, 18 Nov 2024 11:01:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] hw/arm/virt-acpi-build: Build IORT with multiple
 SMMU nodes
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-5-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20241108125242.60136-5-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Shameer,

On 11/8/24 13:52, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Now that we can have multiple user-creatable smmuv3-nested
> devices, each associated with different pci buses, update
> IORT ID mappings accordingly.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/virt-acpi-build.c | 34 ++++++++++++++++++++++++----------
>  include/hw/arm/virt.h    |  6 ++++++
>  2 files changed, 30 insertions(+), 10 deletions(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index e10cad86dd..ec4cdfb2d7 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -276,8 +276,10 @@ static void
>  build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  {
>      int i, nb_nodes, rc_mapping_count;
> -    size_t node_size, smmu_offset = 0;
> +    size_t node_size, *smmu_offset;
>      AcpiIortIdMapping *idmap;
> +    hwaddr base;
> +    int irq, num_smmus = 0;
>      uint32_t id = 0;
>      GArray *smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
>      GArray *its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
> @@ -287,7 +289,21 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      /* Table 2 The IORT */
>      acpi_table_begin(&table, table_data);
>  
> -    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
> +    if (vms->smmu_nested_count) {
> +        irq = vms->irqmap[VIRT_SMMU_NESTED] + ARM_SPI_BASE;
> +        base = vms->memmap[VIRT_SMMU_NESTED].base;
> +        num_smmus = vms->smmu_nested_count;
> +    } else if (virt_has_smmuv3(vms)) {
> +        irq = vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
> +        base = vms->memmap[VIRT_SMMU].base;
> +        num_smmus = 1;
> +    }
> +
> +    smmu_offset = g_new0(size_t, num_smmus);
> +    nb_nodes = 2; /* RC, ITS */
> +    nb_nodes += num_smmus; /* SMMU nodes */
> +
> +    if (virt_has_smmuv3(vms)) {
>          AcpiIortIdMapping next_range = {0};
>  
>          object_child_foreach_recursive(object_get_root(),
> @@ -317,10 +333,8 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>              g_array_append_val(its_idmaps, next_range);
>          }
>  
> -        nb_nodes = 3; /* RC, ITS, SMMUv3 */
>          rc_mapping_count = smmu_idmaps->len + its_idmaps->len;
>      } else {
> -        nb_nodes = 2; /* RC, ITS */
>          rc_mapping_count = 1;
>      }
>      /* Number of IORT Nodes */
> @@ -342,10 +356,9 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      /* GIC ITS Identifier Array */
>      build_append_int_noprefix(table_data, 0 /* MADT translation_id */, 4);
>  
> -    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
> -        int irq =  vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
> +    for (i = 0; i < num_smmus; i++) {
> +        smmu_offset[i] = table_data->len - table.table_offset;
>  
I would have expected changes in the smmu idmap has well. If a given
SMMU instance now protects a given bus hierarchy shouldn't it be
reflected in a differentiated SMMU idmap for each of them (RID subset of
SMMU->pci-bus mapping to a specific IORT SMMU node)? How is it done
currently?

Thanks

Eric
> -        smmu_offset = table_data->len - table.table_offset;
>          /* Table 9 SMMUv3 Format */
>          build_append_int_noprefix(table_data, 4 /* SMMUv3 */, 1); /* Type */
>          node_size =  SMMU_V3_ENTRY_SIZE + ID_MAPPING_ENTRY_SIZE;
> @@ -356,7 +369,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          /* Reference to ID Array */
>          build_append_int_noprefix(table_data, SMMU_V3_ENTRY_SIZE, 4);
>          /* Base address */
> -        build_append_int_noprefix(table_data, vms->memmap[VIRT_SMMU].base, 8);
> +        build_append_int_noprefix(table_data, base + (i * SMMU_IO_LEN), 8);
>          /* Flags */
>          build_append_int_noprefix(table_data, 1 /* COHACC Override */, 4);
>          build_append_int_noprefix(table_data, 0, 4); /* Reserved */
> @@ -367,6 +380,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          build_append_int_noprefix(table_data, irq + 1, 4); /* PRI */
>          build_append_int_noprefix(table_data, irq + 3, 4); /* GERR */
>          build_append_int_noprefix(table_data, irq + 2, 4); /* Sync */
> +        irq += NUM_SMMU_IRQS;
>          build_append_int_noprefix(table_data, 0, 4); /* Proximity domain */
>          /* DeviceID mapping index (ignored since interrupts are GSIV based) */
>          build_append_int_noprefix(table_data, 0, 4);
> @@ -405,7 +419,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      build_append_int_noprefix(table_data, 0, 3); /* Reserved */
>  
>      /* Output Reference */
> -    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
> +    if (virt_has_smmuv3(vms)) {
>          AcpiIortIdMapping *range;
>  
>          /* translated RIDs connect to SMMUv3 node: RC -> SMMUv3 -> ITS */
> @@ -413,7 +427,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>              range = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
>              /* output IORT node is the smmuv3 node */
>              build_iort_id_mapping(table_data, range->input_base,
> -                                  range->id_count, smmu_offset);
> +                                  range->id_count, smmu_offset[i]);
>          }
>  
>          /* bypassed RIDs connect to ITS group node directly: RC -> ITS */
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 50e47a4ef3..304ab134ae 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -219,4 +219,10 @@ static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
>              vms->highmem_redists) ? 2 : 1;
>  }
>  
> +static inline bool virt_has_smmuv3(const VirtMachineState *vms)
> +{
> +    return vms->iommu == VIRT_IOMMU_SMMUV3 ||
> +           vms->iommu == VIRT_IOMMU_SMMUV3_NESTED;
> +}
> +
>  #endif /* QEMU_ARM_VIRT_H */


