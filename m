Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F7CC3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrjD-0002EU-RY; Mon, 05 May 2025 05:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uBrjA-0002Dm-Ns
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:03:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uBrj9-0005MY-4P
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746435785;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TyY9ZWKBqb1FwPN0cigyPe53nVYEDy+HkebDiEQLDGY=;
 b=PpXxwDVSw/KWtRsks05rxUOAODOKt0crWghFGsQ5Ex0+rVt2icCCLRrze1MYBEeoW6aBsp
 y/rcSY9qGxaNBLT5AFU54uVlAiS7O3cFLoWZrwfbEkEZEWyFzVJqr9ifEJMjdkqVmw6Bem
 f9uIOcdaMZz9jHmk96YMeHQDFL+pmds=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-clItQ7ivO_Kfb-PC8LUrqw-1; Mon, 05 May 2025 05:03:04 -0400
X-MC-Unique: clItQ7ivO_Kfb-PC8LUrqw-1
X-Mimecast-MFC-AGG-ID: clItQ7ivO_Kfb-PC8LUrqw_1746435783
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39d917b105bso2069216f8f.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746435783; x=1747040583;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TyY9ZWKBqb1FwPN0cigyPe53nVYEDy+HkebDiEQLDGY=;
 b=ta+cAQre5bCSjgY3di/uwt5omTWd7qOa/iO6mW8IsN45ZsPW89ZgxIP9OOAO8KUTko
 2engARKZzDqwj6HzPovhY9DUtXyOlR+IWfsYJTTbbEnR0fCRIcxdLGlWfl47VUnxX90c
 a2h9uEJSUKVbgcG9zvw0cVgsIqxCWu6GNswYR4Zy1jKwBN0mTA5RhLd73bkbS3vk5JRZ
 fiZKrR5/guzgBMPRFju09VtC/5cP0d871LW/R3LrEkn2yZfWiW9PfFmYPaAfQIRlugHq
 n/IQn/+5QUlmcqNM/wjcW3UEuKNg4yzbMvfy0O6uj0haUTX5wZtvJRutmrG8pxILNeF0
 CQfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtDDLc4/TjBFfmzcKA3kXFMAb6AVD4GwNz/qoV1CfQ3LC3HiHw00Cuhwcsx9sptYRGP1I9YXmTJq+b@nongnu.org
X-Gm-Message-State: AOJu0YwbJ0vfS42ut+UoG4hDXjwoGeKSTCcgAuqNpp73IzU0A/fdjNdg
 HzCCmcJfFs9ptlyaOxYFPXWKXdlgGF0Kc9PHwFfADjJR9E2QEXh6DbB1EdlZYrW2UAaD54PShmR
 1Hq0VLtty30rKVCHKeDmlDjcZsbG4qvUh+VRNLDjXEtvF6D1L6x+v
X-Gm-Gg: ASbGncsalR6YCF94JujFKzUL4swTKTDmYT0OyMnfzmmZiJs0J2wZoVvPVLiWlyJ0Jdq
 R0pAA2sFV/F0QaxxtHc9IcC+/1akk9NJfDESMg7ZqPJNUMTaEn1j+Otu/EpRlgNy3yQMiesKKEY
 kV+UHv4Pjesq2jWUNFuBRJhzUbzEw1mY7Am9HlzPfShsEaZfC6/CHic5QWEnP4kOAC4ytetxxaq
 j4aFDeIO31UovZOpthjZerYHClNgR8stlFSYIl9NLj5I5QpNsmdpdLL57Q93KZTrmDqw+JBqHpN
 6LKwFOSy/ijvqfwzZex4EpG/ngwF25HZKeTF12xLeN8yc0zgD0fyD1CLd4s=
X-Received: by 2002:a5d:588b:0:b0:39e:cbef:95a7 with SMTP id
 ffacd0b85a97d-3a09fd76a77mr4635382f8f.18.1746435783144; 
 Mon, 05 May 2025 02:03:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGa4vWolFzyqNrq+1u/sojfWbqM3C6/iIRpcvsn2g9jdAfyrzeKv3TR16wFDrcbtbbxF1sTg==
X-Received: by 2002:a5d:588b:0:b0:39e:cbef:95a7 with SMTP id
 ffacd0b85a97d-3a09fd76a77mr4635356f8f.18.1746435782783; 
 Mon, 05 May 2025 02:03:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b0ffbfsm9563717f8f.80.2025.05.05.02.03.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 02:03:02 -0700 (PDT)
Message-ID: <ddb17a71-f5b3-478c-a61e-8bf75715a1f0@redhat.com>
Date: Mon, 5 May 2025 11:03:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] hw/arm/virt: Add an SMMU_IO_LEN macro
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-5-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250502102707.110516-5-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 5/2/25 12:27 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> This is useful as the subsequent support for new SMMUv3 dev will also
> use the same.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/virt.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 464e84ae67..e178282d71 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -147,6 +147,9 @@ static void arm_virt_compat_set(MachineClass *mc)
>  #define LEGACY_RAMLIMIT_GB 255
>  #define LEGACY_RAMLIMIT_BYTES (LEGACY_RAMLIMIT_GB * GiB)
>  
> +/* MMIO region size for SMMUv3 */
> +#define SMMU_IO_LEN 0x20000
> +
>  /* Addresses and sizes of our components.
>   * 0..128MB is space for a flash device so we can run bootrom code such as UEFI.
>   * 128MB..256MB is used for miscellaneous device I/O.
> @@ -178,7 +181,7 @@ static const MemMapEntry base_memmap[] = {
>      [VIRT_FW_CFG] =             { 0x09020000, 0x00000018 },
>      [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
>      [VIRT_UART1] =              { 0x09040000, 0x00001000 },
> -    [VIRT_SMMU] =               { 0x09050000, 0x00020000 },
> +    [VIRT_SMMU] =               { 0x09050000, SMMU_IO_LEN },
>      [VIRT_PCDIMM_ACPI] =        { 0x09070000, MEMORY_HOTPLUG_IO_LEN },
>      [VIRT_ACPI_GED] =           { 0x09080000, ACPI_GED_EVT_SEL_LEN },
>      [VIRT_NVDIMM_ACPI] =        { 0x09090000, NVDIMM_ACPI_IO_LEN},
> @@ -1453,7 +1456,6 @@ static void create_smmu(const VirtMachineState *vms,
>      int irq =  vms->irqmap[VIRT_SMMU];
>      int i;
>      hwaddr base = vms->memmap[VIRT_SMMU].base;
> -    hwaddr size = vms->memmap[VIRT_SMMU].size;
>      DeviceState *dev;
>  
>      if (vms->iommu != VIRT_IOMMU_SMMUV3 || !vms->iommu_phandle) {
> @@ -1473,7 +1475,7 @@ static void create_smmu(const VirtMachineState *vms,
>          sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
>                             qdev_get_gpio_in(vms->gic, irq + i));
>      }
> -    create_smmuv3_dt_bindings(vms, base, size, irq);
> +    create_smmuv3_dt_bindings(vms, base, SMMU_IO_LEN, irq);
>  }
>  
>  static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)


