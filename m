Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE77CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 16:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAsdq-0005Bb-NY; Mon, 20 Oct 2025 12:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vAsdo-00058Q-Q5
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 12:21:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vAsdk-0000xk-Lz
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 12:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760977302;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TMuhqLCiwvXGhWuHTfUFcUWo7NHSVOEqil3zUev/Yug=;
 b=a5of/dl43CDAcErQ3b7QJUnaHGkKr5h9gSplp1rzGplVnzQ6/7U8QPhGyOCCEhzyNo3d3V
 80HDgRvAQ6zBWe6zxw9CpK5hKxdC3cyZibWIYZI1ol+jTVTeQs/k1g8POulShCKBZvH3am
 8dmVt5fmxlg2Domh+rzzHR3sXG3iZuw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-bxxsV7GxPkqjb1RnU-WuBg-1; Mon, 20 Oct 2025 12:21:40 -0400
X-MC-Unique: bxxsV7GxPkqjb1RnU-WuBg-1
X-Mimecast-MFC-AGG-ID: bxxsV7GxPkqjb1RnU-WuBg_1760977299
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3f924ae2a89so5566670f8f.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 09:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760977299; x=1761582099;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TMuhqLCiwvXGhWuHTfUFcUWo7NHSVOEqil3zUev/Yug=;
 b=rtRetNdia5bzy/eCR9dqwnwyewC40Nq8lBBihVa7TzhZEtjX/b4itdJkjtgpHbrUID
 H8oLeq7elB8WcWwBfiblCXiMV+CjrLrgoYtVgkR8aP4a4wLcKQwI7pqiOPnjwliGYG8T
 Pi25CQArpJ5+YusF7ZMRNMNWh1uHdfeovj2/pag1beeLMA/vjYVlqZNNUO6/qLtylg7W
 BsDsvgwylw7m31JhD69nFXTJoEJm7SuvvEibj2G0Ha5wxQutYYAqyDpC21yuMnK0mUDb
 OHBvAPBkJECYAAsB/0ij5SHLT+2fbfXRvIZ5WgMF6PCYvuswm0btMDIdqYOXEMuUxxfI
 EvpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU485Bk6obFfNH4ITMkSNS4pQSvEv4f5wzQXmodNZ532+9kU1i5DHhpjyO45EHMVQaD4oQOmj0iG041@nongnu.org
X-Gm-Message-State: AOJu0YzMYzyILTw3EFeNDtggCXsBAHKl2PaWQju0csx51OVglfYkrxPP
 6tdXXwD9wmgjRfFgYDKm4Lv7sjGm+DhtexTIOf0TlCENNDZ5Yxg7+oxhjb715u+VK6QHsia0hjl
 gWVoOFjzk+vjNE0AbvCJ28eZPHJdDOXN80EucRI9+E/YSpQ7tGROEjvU+
X-Gm-Gg: ASbGncuaeUjhirzRnd4J0V57bG/X6Y0m74Hg3iPUE98uesUk2isjRNjCvJ7PvVIGLa4
 2AokA82apPGpC2m3qN1XwZBJuqvC04silCYRqcjXMfkgE31oqflvtyK2rDT4B6pMZE29/qGBBsz
 gwOTCef36aefNLi8A45RUEkEuAnm9H4fV5rpL43Vqed1hkSIkBWlnjdY+rzrggsDTV7Bm3nKjFX
 xYAd74SsTi0rGe+IK3e0gupBjsblqZ0UEW7YvZmI9HONoNbBPqW8v+RdYo5B2KFtINQskopWfYU
 VBeG3OHJ5bcVkF2Kfu+jEChwptGyoHJqa+6I1V1ZDXkb3DM7WViOXEvj3S9LzQL9HplwZ74b5Sv
 oSuoA
X-Received: by 2002:a05:6000:41f4:b0:427:614:83da with SMTP id
 ffacd0b85a97d-4270614850bmr9459390f8f.48.1760977298751; 
 Mon, 20 Oct 2025 09:21:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK1UI06KtBEwhhq8nnp2NmuOuW1bNA2Uh80dIcvi53PgnJznSKm7vuRcy8FWkfVEkUDEr3HA==
X-Received: by 2002:a05:6000:41f4:b0:427:614:83da with SMTP id
 ffacd0b85a97d-4270614850bmr9459371f8f.48.1760977298331; 
 Mon, 20 Oct 2025 09:21:38 -0700 (PDT)
Received: from [192.168.43.95] ([37.166.134.90])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5a0f19sm16190908f8f.9.2025.10.20.09.21.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 09:21:37 -0700 (PDT)
Message-ID: <94132491-1af5-491e-ac98-68e4313bf6af@redhat.com>
Date: Mon, 20 Oct 2025 18:21:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v4 11/27] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 shameerkolothum@gmail.com
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-12-skolothumtho@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250929133643.38961-12-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Shameer

On 9/29/25 3:36 PM, Shameer Kolothum wrote:
> On ARM, when a device is behind an IOMMU, its MSI doorbell address is
> subject to translation by the IOMMU. This behavior affects vfio-pci
> passthrough devices assigned to guests using an accelerated SMMUv3.
>
> In this setup, we configure the host SMMUv3 in nested mode, where
> VFIO sets up the Stage-2 (S2) mappings for guest RAM, while the guest
> controls Stage-1 (S1). To allow VFIO to correctly configure S2 mappings,
> we currently return the system address space via the get_address_space()
> callback for vfio-pci devices.
>
> However, QEMU/KVM also uses this same callback path when resolving the
> address space for MSI doorbells:
>
> kvm_irqchip_add_msi_route()
>   kvm_arch_fixup_msi_route()
>     pci_device_iommu_address_space()
>      get_address_space()
>
> This will cause the device to be configured with wrong MSI doorbell
> address if it return the system address space.
returns
> Introduce an optional get_msi_address_space() callback and use that in
> the above path if available. This will enable IOMMU implementations to
> make use of this if  required.
if required
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---	
>  hw/pci/pci.c         | 19 +++++++++++++++++++
>  include/hw/pci/pci.h | 16 ++++++++++++++++
>  target/arm/kvm.c     |  2 +-
>  3 files changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 1315ef13ea..6f9e1616dd 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2964,6 +2964,25 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
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
See my reply to Nicolin's comment. From a high level point of view the
semantic of

get_msi_address_space versus get_address_space
 does not look very clear. I have the impression for HW nested implementation you were forced to return the &system_address through the get_address_space
 although there is a protecting IOMMU and you need another callback for return a proper IOMMU as for MSIs. This is still unclear and looks hacky to me at this point. I think we need to get the semantic of get_msi_address_space vs get_address_space more solid and you need to explain why get_address_space
is mandated to return &system_address in our case. 
Maybe you explained that earlier in some thread but I fail to find those info again in the commit messages/comments and I think this is important.

> +        } else {
> +            return iommu_bus->iommu_ops->get_address_space(bus,
> +                                 iommu_bus->iommu_opaque, devfn);
> +        }
> +    }
> +    return &address_space_memory;
> +}
> +
>  int pci_iommu_init_iotlb_notifier(PCIDevice *dev, IOMMUNotifier *n,
>                                    IOMMUNotify fn, void *opaque)
>  {
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index c54f2b53ae..0d3b351903 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -652,6 +652,21 @@ typedef struct PCIIOMMUOps {
>                              uint32_t pasid, bool priv_req, bool exec_req,
>                              hwaddr addr, bool lpig, uint16_t prgi, bool is_read,
>                              bool is_write);
> +    /**
> +     * @get_msi_address_space: get the address space for MSI doorbell address
> +     * for devices
> +     *
> +     * Optional callback which returns a pointer to an #AddressSpace. This
> +     * is required if MSI doorbell also gets translated through IOMMU(eg: ARM)
IOMMU (

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
> @@ -660,6 +675,7 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
>  bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
>                                   Error **errp);
>  void pci_device_unset_iommu_device(PCIDevice *dev);
> +AddressSpace *pci_device_iommu_msi_address_space(PCIDevice *dev);
>  
>  /**
>   * pci_device_get_viommu_flags: get vIOMMU flags.
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index b8a1c071f5..10eb8655c6 100644
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
Thanks

Eric


