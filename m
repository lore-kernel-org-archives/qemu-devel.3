Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3392C77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 12:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV7oh-0006pe-LN; Fri, 27 Jun 2025 08:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV7ob-0006nS-1a
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 08:04:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV7oY-0001oH-OX
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 08:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751025856;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ENW/yYAEX4aCalGIq9PH/vmJmhsT134PzJDpXwIjeIs=;
 b=h+9+geO8bKbOW+ErYaXlPOlLkaAerj53kKD57qz6L9fQxn65xNgk4CEO5rgeMySqo7tLlx
 W6ouZDALzU+xUTFpynODjyTCt1YvHH5QcIdfeink6WAdAVYoMIK9sDoom1fxAXnHF0+q09
 uHrzuB934MndjG/QZd8vH7LcPubaSlI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-CmXFrSJIOLObhv92zC3m_g-1; Fri, 27 Jun 2025 08:04:13 -0400
X-MC-Unique: CmXFrSJIOLObhv92zC3m_g-1
X-Mimecast-MFC-AGG-ID: CmXFrSJIOLObhv92zC3m_g_1751025852
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451d5600a54so16295035e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 05:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751025852; x=1751630652;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ENW/yYAEX4aCalGIq9PH/vmJmhsT134PzJDpXwIjeIs=;
 b=XEomMjtfGt9yUv/fwGP6ITy8t6BFZD4wICD3Hzm/ONHMNxC3zTSlitl0boirLP5ZUU
 js/0GzUfNRGBg19DMl9VOwlQ81vZVAuf1PhpmrJGG3VwfWEBsyIgsXfMBtUkzfOb8QHL
 k8YOvFQbdV/nqsInhSTT1DDl5KDcyVjtu6xIxA+h/M3XJBPOGMXQuv8mxcFqLrrCbt5N
 LDyrj7dpLr5P5hXydB+6A5G3FjCTSft6r7b5GDyFZoFci2fH608dR5aj7YG7Ut2kgdrb
 o/t7/u3dH3fD6a7iAfn/cjffWjlaHhQfOtdaLBsrJNgkHz85DgKk+Get174fzaeiK9UF
 Tiug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUckEBl+LFaATI7AMi0Kie9lgPByk7QiQ7Y1I8XlpeYziWQy9HtltAXQwML0bJZbo8Vxyna+nF2Szcp@nongnu.org
X-Gm-Message-State: AOJu0Yy+BVVw/9E+yDjEkY7AWxOVTYJoySvOzwPgArV4hraj/cFRHu6V
 8C9wHB33IxScMyKIBNKrC4XvUq4WMpGXyWR74beUwLmNduSFLJU64MxsWabRxfRRkLliVeOmTG9
 zg90fo8b2NnVNz5VAdDOfWpGBgmXTlmlVX4hJsCKzLowrUjfY7sZOet0t
X-Gm-Gg: ASbGncsfguCyde3L+ZhJigvXPryALyXDL720ufqD6u8hPJBFYz0ruUHbrPnhkQYFCpi
 r0owtRdz77SYRG4vaMW+ciVGiIDP0e7o0VrUYUyymkK6FxBNjq0ZFDxB4Po/ai+1c+gPe9vJQm+
 uZfKzfgMDOeyh+0Y/l5sWwznAC2X0k2it0cGPfUE7LHMsOKW9Z1/f3uyJ42pGpxQIomCzkfBaFc
 WvDMKqP3so3iUjaj0+6Iry2SLs928Cl8SofC3z28e/SzD2XlFg0qVasLziSA57pcmR2Zw+yhOUV
 jRKbfwUuUJMfrkxBLyjM2fTPufzHR50CpoRbliYb5Xwphz+Cn9TJWwKWxO+AlZheXZLhqw==
X-Received: by 2002:a05:600c:35c3:b0:442:f97f:8174 with SMTP id
 5b1f17b1804b1-4539264fd1amr14529145e9.18.1751025851773; 
 Fri, 27 Jun 2025 05:04:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmtWyL+fW7uBlXKxUFsNnEixaDiXlmBJUANmtCvLqPFjYHCUZS1YMesMw2aA3p6fH366Kx3g==
X-Received: by 2002:a05:600c:35c3:b0:442:f97f:8174 with SMTP id
 5b1f17b1804b1-4539264fd1amr14528335e9.18.1751025851101; 
 Fri, 27 Jun 2025 05:04:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a4213f0sm48812655e9.36.2025.06.27.05.04.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Jun 2025 05:04:10 -0700 (PDT)
Message-ID: <5af5e1a5-f81a-4ae8-80d1-3ebb749097f3@redhat.com>
Date: Fri, 27 Jun 2025 14:04:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/11] hw/pci: Introduce pci_setup_iommu_per_bus() for
 per-bus IOMMU ops retrieval
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, imammedo@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 gustavo.romero@linaro.org, linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250623094230.76084-1-shameerali.kolothum.thodi@huawei.com>
 <20250623094230.76084-7-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250623094230.76084-7-shameerali.kolothum.thodi@huawei.com>
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

Hi Shameer,

On 6/23/25 11:42 AM, Shameer Kolothum wrote:
> Currently, pci_setup_iommu() registers IOMMU ops for a given PCIBus.
> However, when retrieving IOMMU ops for a device using
> pci_device_get_iommu_bus_devfn(), the function checks the parent_dev
> and fetches IOMMU ops from the parent device, even if the current
> bus does not have any associated IOMMU ops.
>
> This behavior works for now because QEMU's IOMMU implementations are
> globally scoped, and host bridges rely on the bypass_iommu property
> to skip IOMMU translation when needed.
>
> However, this model will break with the soon to be introduced
> arm-smmuv3 device, which allows users to associate the IOMMU
> with a specific PCIe root complex (e.g., the default pcie.0
> or a pxb-pcie root complex).
>
> For example, consider the following setup with multiple root
> complexes:
>
> -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0 \
> ...
> -device pxb-pcie,id=pcie.1,bus_nr=8,bus=pcie.0 \
> -device pcie-root-port,id=pcie.port1,bus=pcie.1 \
> -device virtio-net-pci,bus=pcie.port1
>
> In Qemu, pxb-pcie acts as a special root complex whose parent is
> effectively the default root complex(pcie.0). Hence, though pcie.1
> has no associated SMMUv3 as per above, pci_device_get_iommu_bus_devfn()
> will incorrectly return the IOMMU ops from pcie.0 due to the fallback
> via parent_dev.
>
> To fix this, introduce a new helper pci_setup_iommu_per_bus() that
> explicitly sets the new iommu_per_bus field in the PCIBus structure.
> Update pci_device_get_iommu_bus_devfn() to use this when determining
> the correct IOMMU ops, ensuring accurate behavior for per-bus IOMMUs.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
> Please refer cover letter for more details on the issue that
> this is trying to fix.
> ---
>  hw/pci/pci.c             | 25 +++++++++++++++++++++++++
>  include/hw/pci/pci.h     |  2 ++
>  include/hw/pci/pci_bus.h |  1 +
>  3 files changed, 28 insertions(+)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index c70b5ceeba..e1940c05d9 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2909,6 +2909,19 @@ static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
>              }
>          }
>  
> +        /*
> +         * When multiple PCI Express Root Buses are defined using pxb-pcie,
> +         * the IOMMU configuration may be specific to each root bus. However,
> +         * pxb-pcie acts as a special root complex whose parent is effectively
> +         * the default root complex(pcie.0). Ensure that we retrieve the
I generally leave a space before the opening bracket. Here and elsewhere
> +         * correct IOMMU ops(if any) in such cases.
> +         */
> +        if (pci_bus_is_express(iommu_bus) && pci_bus_is_root(iommu_bus)) {
> +            if (!iommu_bus->iommu_per_bus && parent_bus->iommu_per_bus) {
> +                break;
> +            }
> +        }
> +
>          iommu_bus = parent_bus;
>      }
>  
> @@ -3169,6 +3182,18 @@ void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
>      bus->iommu_opaque = opaque;
>  }
>  
> +/*
> + * This is same as pci_setup_iommu() except it sets the iommu_per_bus
> + * to true indicating the iommu is specific to this bus and
> + * not applicable to any parent or child.
or child? if there are root ports below, doesn't it protect them as well?

Besides looks OK to me. However I would encourage you to add pci
maintainers (MST) in to.

besides,
Reviewed-by: Eric Auger <eric.auger@redhat.com>


Eric
> + */
> +void pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops,
> +                             void *opaque)
> +{
> +    pci_setup_iommu(bus, ops, opaque);
> +    bus->iommu_per_bus = true;
> +}
> +
>  static void pci_dev_get_w64(PCIBus *b, PCIDevice *dev, void *opaque)
>  {
>      Range *range = opaque;
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index df3cc7b875..a3e0870a15 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -764,6 +764,8 @@ int pci_iommu_unregister_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
>   */
>  void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque);
>  
> +void pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque);
> +
>  pcibus_t pci_bar_address(PCIDevice *d,
>                           int reg, uint8_t type, pcibus_t size);
>  
> diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
> index 2261312546..c738446788 100644
> --- a/include/hw/pci/pci_bus.h
> +++ b/include/hw/pci/pci_bus.h
> @@ -35,6 +35,7 @@ struct PCIBus {
>      enum PCIBusFlags flags;
>      const PCIIOMMUOps *iommu_ops;
>      void *iommu_opaque;
> +    bool iommu_per_bus;
>      uint8_t devfn_min;
>      uint32_t slot_reserved_mask;
>      pci_set_irq_fn set_irq;


