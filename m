Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8D8C36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 18:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx9K2-00031y-R1; Tue, 25 Mar 2025 14:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tx9JS-0002op-Oi
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 14:47:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tx9JQ-0002MD-Ks
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 14:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742928460;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ecBRK6/idrr79yrt1FrWPF/0qcfq7APLtQI3FRNLnLg=;
 b=KdMiWycl9GWgHCEXNhXiqZP7giqHha4y02V/faZfg60VZ1iSDFyrfE2sVpWHA/RPzymbBN
 2L0gcwbYkY2FpPlocr/7Nw04ZJQmPERvpnAhoIoyrVazr0dX1B6CDXgHtE86wsD88ewlnT
 ARctecBXN/EgVcWExPeQCQtA/jR1f0c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-m2jH54yKPcivTmhqcgMLHg-1; Tue, 25 Mar 2025 14:47:38 -0400
X-MC-Unique: m2jH54yKPcivTmhqcgMLHg-1
X-Mimecast-MFC-AGG-ID: m2jH54yKPcivTmhqcgMLHg_1742928457
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43935e09897so37842475e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 11:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742928457; x=1743533257;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ecBRK6/idrr79yrt1FrWPF/0qcfq7APLtQI3FRNLnLg=;
 b=jttuZ8VLRxEXo5HKJTJANa9CkMtICnV9+E88Q80wg1FiJVtp2y+g2rzuim+/eu0lc1
 ZTkkk/QIBqq0urw3ptRE4sM554YglbaiPWWodL2cwiKkqpJ7g6BoN36Vwbc3KEV8DvLv
 tPRbqa5R/65UHSm/wurpTVUc9AplnNLdh8LNEKLxWyt7wEL1jfXAPV/K97CEb2o4z6DF
 5GYkj8W4PFbOCOgc1GpwadMQpQzD9kuDwMupY6OWY6drB5XfbBZ6HW3dr8sFV6iRLWms
 buTEH9Ofd0inh0uTAoXKQxH0r6vg0CaNa2ts+gZnskb1Alu6U63dQHha1V+JCLidW9+T
 GdDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVH/zkk10vLyh4l8h+HfwtGfd6P/xPYTvsJWtn4hF1V+4XkuYu6Y3uORq4BxeqcjGQfuM1fwxvwz5N@nongnu.org
X-Gm-Message-State: AOJu0YwPQX75ZRTsMyjkCLI5XMI9iOOXhrsnv5R1dumT4+9eG4VPuC0J
 SoASh0+URLDqMOjN0krAP2QAPaU3JJ4a+ZGP3GvXOtqnjZuZ+KA+OioIlpkJnaV3rRQeH4Y3vAR
 fHHaAfr/qfNnitUIDkYbP1uqiVZgp8v7IeeL+0OsQhVso6Dz2yU5d
X-Gm-Gg: ASbGncv9uwavyH/MRcdRQYx+W0710ONbeQeqGrLW/vM7nGkILiIGvBYS5464wLi1etm
 DzD53FYYnrZG45Uh7PzV4STakOk8m7KKYtFB5KcxqNRhAl/Y6yzOSKnYgQ/YQRgpHY/TtMfLGYE
 hbfE5dcMaEm31vgwP/Oi6dg5PErt8+d4FtztGskRNv/cWn/y522Fiq2iWHaRxegVoR5/yhuKfIp
 SKtSvpp1o1HaouQVw+IO0fuDJuTXF/iIhmuham7i8ioTZkMyW2icjlQ+BvEQ3mL+BNgJZycPEGd
 GcnvWKu1iJcNkrNcsKpaZqTKUffPkckTr+3VrLVLleJSMD1epX9U7dmyhve1ZP4=
X-Received: by 2002:a05:600c:3c82:b0:43d:45a:8fbb with SMTP id
 5b1f17b1804b1-43d50a1d1ebmr156334355e9.22.1742928456754; 
 Tue, 25 Mar 2025 11:47:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAcjIb0bspmIq0cHWxH571JjnOKebjawvikxSgbCTep//7qY27IdN/usCfBBz50f60t8n5ig==
X-Received: by 2002:a05:600c:3c82:b0:43d:45a:8fbb with SMTP id
 5b1f17b1804b1-43d50a1d1ebmr156334075e9.22.1742928456312; 
 Tue, 25 Mar 2025 11:47:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fd9ec84sm155817855e9.26.2025.03.25.11.47.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 11:47:34 -0700 (PDT)
Message-ID: <ef8f208f-d92a-4f29-b4c9-65b4690b4c3f@redhat.com>
Date: Tue, 25 Mar 2025 19:47:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 12/20] hw/arm/smmuv3-accel: Return sysmem if
 stage-1 is bypassed
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-13-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250311141045.66620-13-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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



On 3/11/25 3:10 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> When nested translation is enabled, there are 2-stage translation
> occuring to two different address spaces: stage-1 in the iommu as,
> while stage-2 in the system as.
>
> If a device attached to the vSMMU doesn't enable stage-1 translation,
> e.g. vSTE sets to Config=Bypass, the system as should be returned,
> so QEMU can set up system memory mappings onto the stage-2 page table.
> This is crucial for an iommufd enabled VFIO device as the VFIO core
> code would register an iommu notifier and replay the address space
> which should be bypassed for this nested translation case.

I would suggest to get inspired of 90519b90539 ("virtio-iommu: Add
bypass mode support to assigned device") or similar patch on vtd
(558e0024a428 intel_iommu: allow dynamic switch of IOMMU region +
4b519ef1de9a  intel-iommu: optimize nodmar memory regions), ie. use the
same terminology and techniques/objects (switch_address_space) .
To me this is not related to HW acceleration but rather to VFIO in general.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmuv3-accel.c         | 22 +++++++++++++++++++++-
>  include/hw/arm/smmuv3-accel.h |  3 +++
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 056bd23b2e..76134d106a 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -18,6 +18,7 @@
>  static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *s, SMMUPciBus *sbus,
>                                                  PCIBus *bus, int devfn)
>  {
> +    SMMUv3AccelState *s_accel = ARM_SMMUV3_ACCEL(s);
>      SMMUDevice *sdev = sbus->pbdev[devfn];
>      SMMUv3AccelDevice *accel_dev;
>  
> @@ -29,6 +30,8 @@ static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *s, SMMUPciBus *sbus,
>  
>          sbus->pbdev[devfn] = sdev;
>          smmu_init_sdev(s, sdev, bus, devfn);
> +        address_space_init(&accel_dev->as_sysmem, &s_accel->root,
> +                           "smmuv3-accel-sysmem");
>      }
>  
>      return accel_dev;
> @@ -351,12 +354,23 @@ static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
>      SMMUPciBus *sbus;
>      SMMUv3AccelDevice *accel_dev;
>      SMMUDevice *sdev;
> +    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
> +    bool has_iommufd = false;
> +
> +    if (pdev) {
> +        has_iommufd = object_property_find(OBJECT(pdev), "iommufd");
> +    }
Refering to the discussion we had on how to set MSI RESV regions at
virt-acpi-build level depending on whether the SMMU was accelerated I
think we can use exactly the above method (checking accel property)
>  
>      sbus = smmu_get_sbus(s, bus);
>      accel_dev = smmuv3_accel_get_dev(s, sbus, bus, devfn);
>      sdev = &accel_dev->sdev;
>  
> -    return &sdev->as;
> +    /* Return the system as if the device uses stage-2 only */
> +    if (has_iommufd && !accel_dev->s1_hwpt) {
> +        return &accel_dev->as_sysmem;
> +    } else {
> +        return &sdev->as;
> +    }
>  }
>  
>  static int smmuv3_accel_pxb_pcie_bus(Object *obj, void *opaque)
> @@ -390,6 +404,12 @@ static void smmu_accel_realize(DeviceState *d, Error **errp)
>          error_propagate(errp, local_err);
>          return;
>      }
> +
> +    memory_region_init(&s_accel->root, OBJECT(s_accel), "root", UINT64_MAX);
> +    memory_region_init_alias(&s_accel->sysmem, OBJECT(s_accel),
> +                             "smmuv3-accel-sysmem", get_system_memory(), 0,
> +                             memory_region_size(get_system_memory()));
> +    memory_region_add_subregion(&s_accel->root, 0, &s_accel->sysmem);
>      bs->get_address_space = smmuv3_accel_find_add_as;
>      bs->set_iommu_device = smmuv3_accel_set_iommu_device;
>      bs->unset_iommu_device = smmuv3_accel_unset_iommu_device;
> diff --git a/include/hw/arm/smmuv3-accel.h b/include/hw/arm/smmuv3-accel.h
> index 54b217ab4f..58e68534c0 100644
> --- a/include/hw/arm/smmuv3-accel.h
> +++ b/include/hw/arm/smmuv3-accel.h
> @@ -51,12 +51,15 @@ typedef struct SMMUv3AccelDevice {
>      SMMUS1Hwpt  *s1_hwpt;
>      SMMUViommu *viommu;
>      SMMUVdev   *vdev;
> +    AddressSpace as_sysmem;
>      QLIST_ENTRY(SMMUv3AccelDevice) next;
>  } SMMUv3AccelDevice;
>  
>  struct SMMUv3AccelState {
>      SMMUv3State smmuv3_state;
>      SMMUViommu *viommu;
> +    MemoryRegion root;
> +    MemoryRegion sysmem;
>  };
>  
>  struct SMMUv3AccelClass {


