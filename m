Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F852D216AE
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 16:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRCM1-0000GD-5m; Thu, 04 Dec 2025 11:38:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vRCLt-0000FG-LG
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 11:38:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vRCLr-0000bC-HQ
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 11:38:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764866321;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oewJrQ4KqNNd66kSHO6werUV/k7nywfwlSZgyYIb6Do=;
 b=ObPf9NtVolj0NQY61+vu7r7wgKRXrtp83HhXur3QsqvaZgvX19EyWdObgLwf5zpCkJKdpa
 Us5IwJo6tRxc/uIJBV/swWiXNrRj3f/qgVTCF7550fMaOjTCZlr6J+G7KdHx8z1bjGeGoh
 MsKpoQ9wCyoDGluizNUXlpAn58xyCgs=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-bV-tQoSFO4CKhWxHS0L8UQ-1; Thu, 04 Dec 2025 11:38:38 -0500
X-MC-Unique: bV-tQoSFO4CKhWxHS0L8UQ-1
X-Mimecast-MFC-AGG-ID: bV-tQoSFO4CKhWxHS0L8UQ_1764866318
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-63e2d3351abso1213896d50.3
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 08:38:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764866318; x=1765471118;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oewJrQ4KqNNd66kSHO6werUV/k7nywfwlSZgyYIb6Do=;
 b=J9BH0tt4rqNu/HZfYWH2+PAV77wyaAJgx89Z1E2qxhSn/eysOjjhCFZXfz0ZP52KFR
 Ie7Uf18q9m4lKj2iy6dncfK/cq3zX0bduwflmNb4lXkWYlvnyMwI7PVGOyMMJAcJ+8n+
 sCDkFuUcfQLx/QFL7uxnTYVnK1fCYdlpxnDYuClq+zlJg967Oi3Y+md+hIa6y9rMbjQ5
 1zflwwKii74JphxvOJtbcrfEWSDutWW7diYr0UGLsu4GawI2BCmQju8qqSmg5v+CYH/L
 511rC3Gw9bcKBMkm6Z/LGyweacFlQ06zuzPsli1qRK9SsKZnY2rUj2eCIznGGm+mso94
 Pt/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9huW7dVS9Ssrjkn8qxl0cfL6sr4oDwDfuXUmD2QPIq1GFWUjlGB/hyVuVcPatGoDKSqyvLmv7WF2e@nongnu.org
X-Gm-Message-State: AOJu0YyjvmehPuXd/o/qbqh3n/oaYl+btMaBtBD4VIwC2OFeUIWFA1+2
 3LLqeYIiTX3uw/OdigsPMr9DnagNheq8a3p3VJyJgEcumXNvc7e/b85Y8PaTI64wMAJW7LNYyke
 klUXClg+DhNQFaDYm7m/crIt+qVwlpfJQv109g2oJkqnEGZZUL+QHIzQo
X-Gm-Gg: ASbGncscpiNbsLWn0cP4hcQn0cdrqRZ/8hLFF4+IvkYIdP8ZxLOwVoqQs2MP6w/tQqA
 w4D7NxhNh68tu/eqp5hJy5G51xQFA+TLz854qx7xHpuCfFXnQHUezM7rHnaM9jABs8WiqiqxQIg
 MgxC5iJz24VSpLiHL4r6XR9S+F49e4D0HER7LzyNePysrh3IbNnv7jCXrqu9GzhFG3JM2W7AhY6
 LFCFHFpRl1ZEwNVpssDuxdEQxiOsrUnTYVlJ/hU8PLzWZFCKKTvBQe4ZFM9PrMgAtm9SWSgLUWo
 9LWdOa6WRJO0x1LKopsARjr9ZMuWsrSXEnMzHoPCpK5eP5z3fnqDQqOAUgiuxthkX5Rmv31D4AL
 3b9DPzVlAuUTw8gIPdnZEXL3M/QSzLq/fI/ZpL0CPbQopkf0FZKjhIaK9HQ==
X-Received: by 2002:a05:690c:3691:b0:786:4fd5:e5db with SMTP id
 00721157ae682-78c188ffa06mr52435907b3.49.1764866318207; 
 Thu, 04 Dec 2025 08:38:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQFr2yGexdDYeOAWuKz7ZXziNe9Qrp9HSa7wzL0JGXiauI3eeRVm/LMvHN6hYDyt+NyF3zPQ==
X-Received: by 2002:a05:690c:3691:b0:786:4fd5:e5db with SMTP id
 00721157ae682-78c188ffa06mr52435477b3.49.1764866317775; 
 Thu, 04 Dec 2025 08:38:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:fa3:e4b0:95dc:ab11:92db:6f9e?
 ([2a01:e0a:fa3:e4b0:95dc:ab11:92db:6f9e])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6443f5bca83sm770072d50.25.2025.12.04.08.38.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 08:38:37 -0800 (PST)
Message-ID: <377d4c92-bfb0-4743-94d4-c4bf8dcb2934@redhat.com>
Date: Thu, 4 Dec 2025 17:38:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 16/33] hw/pci/pci: Introduce a callback to retrieve the
 MSI doorbell GPA directly
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 kjaju@nvidia.com, "Michael S . Tsirkin" <mst@redhat.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-17-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251120132213.56581-17-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/20/25 2:21 PM, Shameer Kolothum wrote:
> For certain vIOMMU implementations, such as SMMUv3 in accelerated mode,
> the translation tables are programmed directly into the physical SMMUv3
> in a nested configuration. While QEMU knows where the guest tables live,
> safely walking them in software would require trapping and ordering all
> guest invalidations on every command queue. Without this, QEMU could race
> with guest updates and walk stale or freed page tables.
>
> This constraint is fundamental to the design of HW-accelerated vSMMU when
> used with downstream vfio-pci endpoint devices, where QEMU must never walk
> guest translation tables and must rely on the physical SMMU for
> translation. Future accelerated vSMMU features, such as virtual CMDQ, will
> also prevent trapping invalidations, reinforcing this restriction.
>
> For vfio-pci endpoints behind such a vSMMU, the only translation QEMU
> needs is for the MSI doorbell used when setting up KVM MSI route tables.
> Instead of attempting a software walk, introduce an optional vIOMMU
> callback that returns the MSI doorbell GPA directly.
>
> kvm_arch_fixup_msi_route() uses this callback when available and ignores
> the guest provided IOVA in that case.
>
> If the vIOMMU does not implement the callback, we fall back to the
> existing IOMMU based address space translation path.
>
> This ensures correct MSI routing for accelerated SMMUv3 + VFIO passthrough
> while avoiding unsafe software walks of guest translation tables.
>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/pci/pci.c         | 17 +++++++++++++++++
>  include/hw/pci/pci.h | 17 +++++++++++++++++
>  target/arm/kvm.c     | 18 +++++++++++++++++-
>  3 files changed, 51 insertions(+), 1 deletion(-)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 55647a6928..201583603f 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2979,6 +2979,23 @@ bool pci_device_get_iommu_bus_devfn(PCIDevice *dev, PCIBus **piommu_bus,
>      return aliased;
>  }
>  
> +bool pci_device_iommu_msi_direct_gpa(PCIDevice *dev, hwaddr *out_doorbell)
> +{
> +    PCIBus *bus;
> +    PCIBus *iommu_bus;
> +    int devfn;
> +
> +    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
> +    if (iommu_bus) {
> +        if (iommu_bus->iommu_ops->get_msi_direct_gpa) {
> +            *out_doorbell = iommu_bus->iommu_ops->get_msi_direct_gpa(bus,
> +                                iommu_bus->iommu_opaque, devfn);
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
>  AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>  {
>      PCIBus *bus;
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index dd1c4483a2..0964049044 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -664,6 +664,22 @@ typedef struct PCIIOMMUOps {
>                              uint32_t pasid, bool priv_req, bool exec_req,
>                              hwaddr addr, bool lpig, uint16_t prgi, bool is_read,
>                              bool is_write);
> +    /**
> +     * @get_msi_direct_gpa: get the guest physical address of MSI doorbell
> +     * for the device on a PCI bus.
> +     *
> +     * Optional callback. If implemented, it must return a valid guest
> +     * physical address for the MSI doorbell
> +     *
> +     * @bus: the #PCIBus being accessed.
> +     *
> +     * @opaque: the data passed to pci_setup_iommu().
> +     *
> +     * @devfn: device and function number
> +     *
> +     * Returns: the guest physical address of the MSI doorbell.
> +     */
> +    uint64_t (*get_msi_direct_gpa)(PCIBus *bus, void *opaque, int devfn);
>  } PCIIOMMUOps;
>  
>  bool pci_device_get_iommu_bus_devfn(PCIDevice *dev, PCIBus **piommu_bus,
> @@ -672,6 +688,7 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
>  bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
>                                   Error **errp);
>  void pci_device_unset_iommu_device(PCIDevice *dev);
> +bool pci_device_iommu_msi_direct_gpa(PCIDevice *dev, hwaddr *out_doorbell);
>  
>  /**
>   * pci_device_get_viommu_flags: get vIOMMU flags.
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 0d57081e69..2372de6a6e 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -1620,26 +1620,42 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
>          return 0;
>      }
>  
> +    /*
> +     * We do have an IOMMU address space, but for some vIOMMU implementations
> +     * (e.g. accelerated SMMUv3) the translation tables are programmed into
> +     * the physical SMMUv3 in the host (nested S1=guest, S2=host). QEMU cannot
> +     * walk these tables in a safe way, so in that case we obtain the MSI
> +     * doorbell GPA directly from the vIOMMU backend and ignore the gIOVA
> +     * @address.
> +     */
> +    if (pci_device_iommu_msi_direct_gpa(dev, &doorbell_gpa)) {
> +        goto set_doorbell;
> +    }
> +
>      /* MSI doorbell address is translated by an IOMMU */
>  
> -    RCU_READ_LOCK_GUARD();
> +    rcu_read_lock();
what is the rationale behind the RCU changes?

Eric
>  
>      mr = address_space_translate(as, address, &xlat, &len, true,
>                                   MEMTXATTRS_UNSPECIFIED);
>  
>      if (!mr) {
> +        rcu_read_unlock();
>          return 1;
>      }
>  
>      mrs = memory_region_find(mr, xlat, 1);
>  
>      if (!mrs.mr) {
> +        rcu_read_unlock();
>          return 1;
>      }
>  
>      doorbell_gpa = mrs.offset_within_address_space;
>      memory_region_unref(mrs.mr);
> +    rcu_read_unlock();
>  
> +set_doorbell:
>      route->u.msi.address_lo = doorbell_gpa;
>      route->u.msi.address_hi = doorbell_gpa >> 32;
>  


