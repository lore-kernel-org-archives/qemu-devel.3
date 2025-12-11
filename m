Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA41D41C3A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 14:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vThH8-0004xG-Uq; Thu, 11 Dec 2025 09:04:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vThGo-0004v1-9j
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 09:04:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vThGm-0007WF-HO
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 09:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765461825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9vOkGnaYpVNEHhXjDFo3oHEtOXfp+I4qohL2mPbwIPw=;
 b=FlxzRubXw0eQ9MbKYbsaKOq5ooSN9egQebYbThBkMVUmBDPgouMdXmX1IIBy/PgY/8FBNA
 0qMqZV38NLKiecCo+Nwc0VKIWMUVlpZsHzm99GkiLQqlmxTqGYNNuFPiH5YwqJhLp0cMmO
 4bEpZ+J5KT1sKvSWyq3gvGX5OwDKdPk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-_bQwvr8nOZyRRSIx_gNisw-1; Thu, 11 Dec 2025 09:03:42 -0500
X-MC-Unique: _bQwvr8nOZyRRSIx_gNisw-1
X-Mimecast-MFC-AGG-ID: _bQwvr8nOZyRRSIx_gNisw_1765461821
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42b2b642287so72550f8f.2
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 06:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765461821; x=1766066621; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=9vOkGnaYpVNEHhXjDFo3oHEtOXfp+I4qohL2mPbwIPw=;
 b=e6ggMmtyB2//yxcs4qcwHV8BPEfvDU+NuxPfe4yXgj7POpNa6HbcK8X21LlEwabaeA
 DMLahguaiSYpbdlFDNDbHc+a+vNq3DifyoEUR4/9zXWZf+9nb5+QYW7qVL5V9ObKVBA6
 VyKk3HjwRhnTrnq8tS+P2Yxj/QRkqiI/c8OLwDLHAh5vl8e9a+UUxZ4qSKNd/Rl4/TUl
 YLVuSjjAP1WWsmAKRSCgXgNCMPkllgof1xB5/r9gj/P1gcgDfupqALIo85tmTbuiyPzz
 oTOaXec6ObOt3p6KKN1XG1mJQ8eNvuiK+vkGHTnUC8rxas4ATK5PDxXn/ANxecXD66GG
 iTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765461821; x=1766066621;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9vOkGnaYpVNEHhXjDFo3oHEtOXfp+I4qohL2mPbwIPw=;
 b=tCr2p0EKEz9l7262dTyzHe2oJHEDVtR/TIQa/MjYAlTZISXKuw+tX5eQ8hinGtruLm
 9G00fTOIQhS18YRt/k407hanWrW137wgQLqXCBK9cRlnij1JDZ556Yz5TLxWPgToSfJF
 7GAfDT/VWH9l/ngnPUGNq8rU6qQq2frdwFeAUYcEBPl8WDZ3UO8tMFiI/o+Sakmqipn7
 XI/T7BA6a3Uv8SWV+RxmrFao5oW2LB6PRzYVAxse7nBQ99iNuy6Y5ikityGgjH+j+H9s
 gUlJhjtoVBhcGoYUyPcg8KOcZFlldKgvxptAwIzAQbLGqkrF012wx6aK/HnLRZD4q433
 iGuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoHfGTLGO4lkQ4CN3nCHT/Pwx32NIEL1MhNE8DWkBaw3YR+qeyJn7vE6rk6dWG0P5aF9lDH9bh1y9x@nongnu.org
X-Gm-Message-State: AOJu0YxbGCi03zgGR7ZO1eS9CJJzcgIegsppUy79DXve48R3ZWRtWfW/
 u5cs6IbpokX/fQvOesflOwq/h0oiilBj7krlprtdNDifcuNhIdFtqgz8TrEdbXT6uZhUXI6frUm
 saozuGVct8CoH5Q7lJSXGduDQexyk5s0qoyVM4yOmp+6zqz1Sqooh+GwS
X-Gm-Gg: AY/fxX53NDIVyHSNwDGg5uOyAHIwDoLrbkfrOTepFffbls0WvGjaqtfKygr2ssSg7S7
 D54HxHuk0Vm+FPkdh1bb0RIiv0YxtSB4TCDK/42ID1jAxlBy2Mw3KQHezOxE3nef+qu4yXAIUk1
 oohdDGzCfpzr9VoIG+R98hkW7j5Fyy3ZxalrQDYj3jsKZa9RPbTtg3zKDfwhO5MG+v4eC8mdSRg
 LYavgEkeoXF0IiAAqzUGNKXXQL0llW01ZkY7zFlocTBWHf6dad3WgDLrHCBR+J01L69OcOkVIqM
 UX3XM2zF7b5a2WTyjmZ2w7FKm2xZ2dAXmbBnQaMGsDbCV38l4U2dr61HOZ3/MP6LgPqB9kVwJuO
 Z+KrYPZMt2bxSBYRS1ljC+blBkilGB8xchbXsKtTcYPyQGYKL
X-Received: by 2002:a5d:64e6:0:b0:42b:4185:e590 with SMTP id
 ffacd0b85a97d-42fa3b1f307mr7351521f8f.58.1765461821079; 
 Thu, 11 Dec 2025 06:03:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFpJoQNGwpkJ3NNwCHgNFo4+RgwZcYgYWsMxcu0d6Yk6cCUP2MenpUZxluya0KxMXj68WXKw==
X-Received: by 2002:a5d:64e6:0:b0:42b:4185:e590 with SMTP id
 ffacd0b85a97d-42fa3b1f307mr7351413f8f.58.1765461819826; 
 Thu, 11 Dec 2025 06:03:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b85ff5sm6433267f8f.24.2025.12.11.06.03.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 06:03:38 -0800 (PST)
Message-ID: <52dc1984-da99-47bc-87f4-cc29cbe6b749@redhat.com>
Date: Thu, 11 Dec 2025 15:03:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 17/33] hw/arm/smmuv3: Add support for providing a
 direct MSI doorbell GPA
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, jgg@nvidia.com,
 nicolinc@nvidia.com, ddutile@redhat.com, berrange@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, yi.l.liu@intel.com, kjaju@nvidia.com
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-18-skolothumtho@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251120132213.56581-18-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/20/25 14:21, Shameer Kolothum wrote:
> Accelerated SMMUv3 instances rely on the physical SMMUv3 for nested
> translation (Guest Stage-1, Host Stage-2). In this mode the guest’s
> Stage-1 tables are programmed directly into hardware, and QEMU should
> not attempt to walk them for translation since doing so is not reliably
> safe. For vfio-pci endpoints behind such a vSMMU, the only translation
> QEMU is responsible for is the MSI doorbell used during KVM MSI setup.
> 
> Add a device property to carry the MSI doorbell GPA from the virt
> machine, and expose it through a new get_msi_direct_gpa PCIIOMMUOp.
> kvm_arch_fixup_msi_route() can then use this GPA directly instead of
> attempting a software walk of guest translation tables.
> 
> This enables correct MSI routing with accelerated SMMUv3 while avoiding
> unsafe accesses to page tables.
> 
> For meaningful use of vfio-pci devices with accelerated SMMUv3, both KVM
> and a kernel irqchip are required. Enforce this requirement when accel=on
> is selected.

There are multiple changes in one patch. I suggest splitting.

> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   hw/arm/smmuv3-accel.c   | 10 ++++++++++
>   hw/arm/smmuv3.c         |  2 ++
>   hw/arm/virt.c           | 22 ++++++++++++++++++++++
>   include/hw/arm/smmuv3.h |  1 +
>   4 files changed, 35 insertions(+)
> 
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 65b577f49a..8f7c0cda05 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -392,6 +392,15 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
>       }
>   }
>   
> +static uint64_t smmuv3_accel_get_msi_gpa(PCIBus *bus, void *opaque, int devfn)
> +{
> +    SMMUState *bs = opaque;
> +    SMMUv3State *s = ARM_SMMUV3(bs);
> +
> +    g_assert(s->msi_gpa);
> +    return s->msi_gpa;
> +}
> +
>   /*
>    * Only allow PCIe bridges, pxb-pcie roots, and GPEX roots so vfio-pci
>    * endpoints can sit downstream. Accelerated SMMUv3 requires a vfio-pci
> @@ -496,6 +505,7 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
>       .get_viommu_flags = smmuv3_accel_get_viommu_flags,
>       .set_iommu_device = smmuv3_accel_set_iommu_device,
>       .unset_iommu_device = smmuv3_accel_unset_iommu_device,
> +    .get_msi_direct_gpa = smmuv3_accel_get_msi_gpa,
>   };
>   
>   /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 42c60b1ec8..f02e3ee46c 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1998,6 +1998,8 @@ static const Property smmuv3_properties[] = {
>        * Defaults to stage 1
>        */
>       DEFINE_PROP_STRING("stage", SMMUv3State, stage),
> +    /* GPA of MSI doorbell, for SMMUv3 accel use. */
> +    DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
>   };
>   
>   static void smmuv3_instance_init(Object *obj)
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 25fb2bab56..ea3231543a 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3052,6 +3052,14 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>               /* The new SMMUv3 device is specific to the PCI bus */
>               object_property_set_bool(OBJECT(dev), "smmu_per_bus", true, NULL);
>           }
> +        if (object_property_find(OBJECT(dev), "accel") &&
> +            object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
> +            if (!kvm_enabled() || !kvm_irqchip_in_kernel()) {
> +                error_setg(errp, "SMMUv3 accel=on requires KVM with "
> +                           "kernel-irqchip=on support");
> +                    return;

Couldn't these checks be done in the "smmuv3-accel" model realize
handler instead ?

  
> +            }
> +        }
>       }
>   }
>   
> @@ -3088,6 +3096,20 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>               }
>   
>               create_smmuv3_dev_dtb(vms, dev, bus);
> +            if (object_property_find(OBJECT(dev), "accel") &&
> +                object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
> +                hwaddr db_start;
> +
> +                if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
> +                    /* GITS_TRANSLATER page + offset */
> +                    db_start = base_memmap[VIRT_GIC_ITS].base + 0x10000 + 0x40;
> +                } else {
> +                    /* MSI_SETSPI_NS page + offset */
> +                    db_start = base_memmap[VIRT_GIC_V2M].base + 0x40;
> +                }
> +                object_property_set_uint(OBJECT(dev), "msi-gpa", db_start,
> +                                         &error_abort);

IIRC, this plug handler is called after the device realize handler
and setting properties after realize is strongly discouraged.

C.

> +            }
>           }
>       }
>   
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index e54ece2d38..5616a8a2be 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -67,6 +67,7 @@ struct SMMUv3State {
>       /* SMMU has HW accelerator support for nested S1 + s2 */
>       bool accel;
>       struct SMMUv3AccelState *s_accel;
> +    uint64_t msi_gpa;
>   };
>   
>   typedef enum {


