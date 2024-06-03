Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09498C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 13:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE7vd-0002Jx-LE; Mon, 03 Jun 2024 09:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sE7vZ-0002J7-CJ
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 09:40:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sE7vX-0003p9-Fz
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 09:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717422041;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L9kyZWEazs98FS/qKAng7yf8FR9B07vM6V+4gBDWu0M=;
 b=UF1w1PxJRvqN6h0s96tJ291DQbzu5xMeWh0dqAx8F/bOVSTXVXtY3mRznHyPJueEa1OIdn
 Ga21v8pHYbEsv0gvHT+35y6yj+ibekLxoHXXOBRpvcKm4xuDj2r+3jlIivcs2kxT1O49Lx
 vcQ7xxaYCSEvRqfbF+ZE5isVwcLfm1U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-msMDQVetO62HdMBFsLnuTQ-1; Mon, 03 Jun 2024 09:40:39 -0400
X-MC-Unique: msMDQVetO62HdMBFsLnuTQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4212e3418b1so17460965e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 06:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717422038; x=1718026838;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L9kyZWEazs98FS/qKAng7yf8FR9B07vM6V+4gBDWu0M=;
 b=qMRtHv72O2fWiYQjKuHWxfYwCUZOr0onwtBt0wFe4/wP2JGFQAGB7C2u8eMnAlRZbd
 jcwx8YRbFIUY8chHHvyXIGJVEjkJoJBi6KSnIMW+GbNgBr8FGysCFEvhN+pyGURtlgH7
 Ej/LGcM5T0VM6c7My471rM+mfsY7FBJ253ovFaPP1sHXWEH2ONlhGkfwUE61AWqXmVcE
 Fqb2mY1IN73iyPxt1QNd4lepqhIPeX0mXLu2JLe8DOz8KbDidYNWTfXBYPgwWI/fxETw
 GZpJQyTKUqTAVmmladMrKhisq3sH3uL9lzlI9+1SLXK6ROWffpLuUb+gpPPXFcx5F7hQ
 evKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeJKf83n2gGJs+EktB3uK/hUIPwhEG14lvkkOULlQmXtntRDhNdM2PqrEVkNCCBM6/+U3ID/AojkK9gV/T7U+PRd0TSLI=
X-Gm-Message-State: AOJu0YwqLJmJvlaM1Bq5My4t4Rb6KxjnJRBnQ1n73e23XtHdKELjiaMR
 KlRHmzxbhssFY5Gdjt6qZY9p8P2wtQSrBQTFBFGEmbSuwajhG/EH4CmkRC12E7oLernmg8k6+Tc
 v5x9wuxkvaWBZqyCflibxGghkYAkzk+4oAHjj7jxkNStfjLUZRZ1g
X-Received: by 2002:a05:600c:1d82:b0:418:2a57:380c with SMTP id
 5b1f17b1804b1-4212e0ae95emr73191385e9.26.1717422038266; 
 Mon, 03 Jun 2024 06:40:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdgy4l4j11Hr3o2/BA0DtlZMsRNyWu359YRUAQiTst009aWKq9diFHRTetGoqJYN+KFu0BlQ==
X-Received: by 2002:a05:600c:1d82:b0:418:2a57:380c with SMTP id
 5b1f17b1804b1-4212e0ae95emr73191105e9.26.1717422037851; 
 Mon, 03 Jun 2024 06:40:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd0630010sm8837098f8f.76.2024.06.03.06.40.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 06:40:37 -0700 (PDT)
Message-ID: <0c8af302-a583-449a-b8a2-92751b740259@redhat.com>
Date: Mon, 3 Jun 2024 15:40:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/19] hw/pci: Introduce helper function
 pci_device_get_iommu_bus_devfn()
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-15-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240603061023.269738-15-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 6/3/24 08:10, Zhenzhong Duan wrote:
> Extract out pci_device_get_iommu_bus_devfn() from
> pci_device_iommu_address_space() to facilitate
> implementation of pci_device_[set|unset]_iommu_device()
> in following patch.
>
> No functional change intended.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/pci/pci.c | 48 +++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 45 insertions(+), 3 deletions(-)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 324c1302d2..02a4bb2af6 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2648,11 +2648,27 @@ static void pci_device_class_base_init(ObjectClass *klass, void *data)
>      }
>  }
>  
> -AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> +/*
> + * Get IOMMU root bus, aliased bus and devfn of a PCI device
> + *
> + * IOMMU root bus is needed by all call sites to call into iommu_ops.
> + * For call sites which don't need aliased BDF, passing NULL to
> + * aliased_[bus|devfn] is allowed.
> + *
> + * @piommu_bus: return root #PCIBus backed by an IOMMU for the PCI device.
> + *
> + * @aliased_bus: return aliased #PCIBus of the PCI device, optional.
> + *
> + * @aliased_devfn: return aliased devfn of the PCI device, optional.
> + */
> +static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
> +                                           PCIBus **piommu_bus,
> +                                           PCIBus **aliased_bus,
> +                                           int *aliased_devfn)
>  {
>      PCIBus *bus = pci_get_bus(dev);
>      PCIBus *iommu_bus = bus;
> -    uint8_t devfn = dev->devfn;
> +    int devfn = dev->devfn;
>  
>      while (iommu_bus && !iommu_bus->iommu_ops && iommu_bus->parent_dev) {
>          PCIBus *parent_bus = pci_get_bus(iommu_bus->parent_dev);
> @@ -2693,7 +2709,33 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>  
>          iommu_bus = parent_bus;
>      }
> -    if (!pci_bus_bypass_iommu(bus) && iommu_bus->iommu_ops) {
> +
> +    assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
> +    assert(iommu_bus);
> +
> +    if (pci_bus_bypass_iommu(bus) || !iommu_bus->iommu_ops) {
> +        iommu_bus = NULL;
> +    }
> +
> +    *piommu_bus = iommu_bus;
> +
> +    if (aliased_bus) {
> +        *aliased_bus = bus;
> +    }
> +
> +    if (aliased_devfn) {
> +        *aliased_devfn = devfn;
> +    }
> +}
> +
> +AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> +{
> +    PCIBus *bus;
> +    PCIBus *iommu_bus;
> +    int devfn;
> +
> +    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
> +    if (iommu_bus) {
>          return iommu_bus->iommu_ops->get_address_space(bus,
>                                   iommu_bus->iommu_opaque, devfn);
>      }


