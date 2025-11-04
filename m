Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931E7CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 14:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGHlX-0000el-Cd; Tue, 04 Nov 2025 09:12:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vGHlV-0000e0-6G
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 09:12:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vGHlS-0003qo-0g
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 09:12:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762265521;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+W/rlbcUCIlG2wZMrAl39YK3Gxl6GXuNT8/hI5nrCms=;
 b=SB1JUZb0eGzCYBaKojq2uqSisc6MtR2w5ZuHUB3v+Jxb16ktbqnrsFOGVB+4ByT+u7GmJU
 L8IU+3hVUoXVQ12Ckf22GT2j3lc+W2Sx+3f64cjUb68QMrs3rrmXyUrM8azknNDyr179tg
 9McJmFlg3MvHTwwi7AosFa7z2fn3Bbg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-95ZJVRQcMMeJxld2acKF7w-1; Tue, 04 Nov 2025 09:11:59 -0500
X-MC-Unique: 95ZJVRQcMMeJxld2acKF7w-1
X-Mimecast-MFC-AGG-ID: 95ZJVRQcMMeJxld2acKF7w_1762265518
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ecdb10a612so4406232f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 06:11:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762265518; x=1762870318;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+W/rlbcUCIlG2wZMrAl39YK3Gxl6GXuNT8/hI5nrCms=;
 b=npWADuZOqJJsyG5NAGV6LWtBQOQzzXuzn6YpZckjG/NCokGQ2aZ8DMfWGiGlaWBizm
 76m6401m8UfNiSDX1/4h/5SgS3MOeseKPlU1QOdyZ5Ncw4lC8VUYEMrLIPasFxUQaTG3
 orbI8liyOtFlU5gnq25tB9iOyu4Ye292gOlXZYEG5hlTxYbzKg4ZSRao2cQbieGqwKta
 RPW2aK+En8UrDrLemSEzcYLoZBBExr7STewIqBmdB6EN+xsMVHh1yVT9RWoYdsnCz/5N
 AEghM8cTKyHKoE8k/zx/0/PBIZARX4AEiVbFrxpFUC5YaAGrEDgaHX8vmw63goF+zjH/
 BVNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpDVl/9TfiOJav+i6r3whA6WjvjAe7BZYjsIWeOr53jKjLOw+Qd3OPHQGlUtPTDNvHMR5dVtkwNbSv@nongnu.org
X-Gm-Message-State: AOJu0YwMzW8OfXdDmXeLH2LbROp9JmUKplgIYZOeQZ/ndtLt13ws8qOK
 r+/JCtcQADEIptAub/Vtb1W0IwWSulSwwdSaxv4QsT7AL2AkYOjuP4CCTeuPDW2widcwPrmRrL7
 y3j1X+YKO4f5PwFvEUcNotOFqkdx7xRqOAERJ4huhIaz7TLrpWKzSWAp3
X-Gm-Gg: ASbGncvkr9XptOl05ggWl5/0WgExSmeRDSaiEnqq6BMMG/E/uqgQ59Lb1zKKGKUuWyW
 iuHWA30tqE01xYWdiTbO6t8wkYjdwSf1Vnsj6p/1PtnXoIk7yL4Rh8iWyhxZEfRz83vyWOtfkr1
 Xxv3plas+/M8Afwax9oRtvJ9jYjNcEhOYQjJ7/QtzTLwZdvTZu2bZ8YDcyEIF9ICLxvJHxccE/E
 A4vKESlISBy6Z372Y/wgs4sEhqjGd5p+u4lYuQLA9VOR3QE3pJPyO0zoqzLDqhNwAr+gWgFoip5
 XscKAJSL8VbZYPxsJC4HL+1TkxD+LAgCdU5fWUfgnFLyMCiy88RCH8hCTKO5lpDXN/WkJwauiOd
 t8oHwk4hWgvJw0jaKECRs9uvRUeT/3UlFrMKRLE2z48e/OA==
X-Received: by 2002:a05:6000:1a8a:b0:429:d19f:d922 with SMTP id
 ffacd0b85a97d-429d19fdff8mr8238757f8f.11.1762265517660; 
 Tue, 04 Nov 2025 06:11:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdsxE2ONO79JJE6ndykx6hmefcPbbe3rGe4soyRyb0AJo30Vn6ixBIGKovyJFPrgvUzEBxwA==
X-Received: by 2002:a05:6000:1a8a:b0:429:d19f:d922 with SMTP id
 ffacd0b85a97d-429d19fdff8mr8238712f8f.11.1762265517103; 
 Tue, 04 Nov 2025 06:11:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429dc192ac4sm5087448f8f.17.2025.11.04.06.11.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 06:11:56 -0800 (PST)
Message-ID: <318947de-4467-4ced-a5d2-929e3df210ef@redhat.com>
Date: Tue, 4 Nov 2025 15:11:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 kjaju@nvidia.com
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-16-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251031105005.24618-16-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Shameer, Nicolin,

On 10/31/25 11:49 AM, Shameer Kolothum wrote:
> On ARM, devices behind an IOMMU have their MSI doorbell addresses
> translated by the IOMMU. In nested mode, this translation happens in
> two stages (gIOVA → gPA → ITS page).
>
> In accelerated SMMUv3 mode, both stages are handled by hardware, so
> get_address_space() returns the system address space so that VFIO
> can setup stage-2 mappings for system address space.

Sorry but I still don't catch the above. Can you explain (most probably
again) why this is a requirement to return the system as so that VFIO
can setup stage-2 mappings for system address space. I am sorry for
insisting (at the risk of being stubborn or dumb) but I fail to
understand the requirement. As far as I remember the way I integrated it
at the old times did not require that change:
https://lore.kernel.org/all/20210411120912.15770-1-eric.auger@redhat.com/
I used a vfio_prereg_listener to force the S2 mapping.

What has changed that forces us now to have this gym


>
> However, QEMU/KVM also calls this callback when resolving
> MSI doorbells:
>
>   kvm_irqchip_add_msi_route()
>     kvm_arch_fixup_msi_route()
>       pci_device_iommu_address_space()
>         get_address_space()
>
> VFIO device in the guest with a SMMUv3 is programmed with a gIOVA for
> MSI doorbell. This gIOVA can't be used to setup the MSI doorbell
> directly. This needs to be translated to vITS gPA. In order to do the
> doorbell transalation it needs IOMMU address space.
>
> Add an optional get_msi_address_space() callback and use it in this
> path to return the correct address space for such cases.
>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/pci/pci.c         | 18 ++++++++++++++++++
>  include/hw/pci/pci.h | 16 ++++++++++++++++
>  target/arm/kvm.c     |  2 +-
>  3 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index fa9cf5dab2..1edd711247 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2982,6 +2982,24 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>      return &address_space_memory;
>  }
>  
> +AddressSpace *pci_device_iommu_msi_address_space(PCIDevice *dev)
> +{
> +    PCIBus *bus;
> +    PCIBus *iommu_bus;
> +    int devfn;
> +
> +    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
> +    if (iommu_bus) {
> +        if (iommu_bus->iommu_ops->get_msi_address_space) {
> +            return iommu_bus->iommu_ops->get_msi_address_space(bus,
> +                                 iommu_bus->iommu_opaque, devfn);
> +        }
> +        return iommu_bus->iommu_ops->get_address_space(bus,
> +                                 iommu_bus->iommu_opaque, devfn);
> +    }
> +    return &address_space_memory;
> +}
> +
>  int pci_iommu_init_iotlb_notifier(PCIDevice *dev, IOMMUNotifier *n,
>                                    IOMMUNotify fn, void *opaque)
>  {
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index dfeba8c9bd..b731443c67 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -664,6 +664,21 @@ typedef struct PCIIOMMUOps {
>                              uint32_t pasid, bool priv_req, bool exec_req,
>                              hwaddr addr, bool lpig, uint16_t prgi, bool is_read,
>                              bool is_write);
> +    /**
> +     * @get_msi_address_space: get the address space for MSI doorbell address
> +     * for devices
> +     *
> +     * Optional callback which returns a pointer to an #AddressSpace. This
> +     * is required if MSI doorbell also gets translated through vIOMMU(eg: ARM)
> +     *
> +     * @bus: the #PCIBus being accessed.
> +     *
> +     * @opaque: the data passed to pci_setup_iommu().
> +     *
> +     * @devfn: device and function number
> +     */
> +    AddressSpace * (*get_msi_address_space)(PCIBus *bus, void *opaque,
> +                                            int devfn);
>  } PCIIOMMUOps;
>  
>  bool pci_device_get_iommu_bus_devfn(PCIDevice *dev, PCIBus **piommu_bus,
> @@ -672,6 +687,7 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
>  bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
>                                   Error **errp);
>  void pci_device_unset_iommu_device(PCIDevice *dev);
> +AddressSpace *pci_device_iommu_msi_address_space(PCIDevice *dev);
>  
>  /**
>   * pci_device_get_viommu_flags: get vIOMMU flags.
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 0d57081e69..0df41128d0 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -1611,7 +1611,7 @@ int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level)
>  int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
>                               uint64_t address, uint32_t data, PCIDevice *dev)
>  {
> -    AddressSpace *as = pci_device_iommu_address_space(dev);
> +    AddressSpace *as = pci_device_iommu_msi_address_space(dev);
>      hwaddr xlat, len, doorbell_gpa;
>      MemoryRegionSection mrs;
>      MemoryRegion *mr;

Eric


