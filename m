Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48880C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 07:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSWZP-0004rF-HC; Fri, 20 Jun 2025 03:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSWZN-0004r6-Dv
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:53:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSWZL-0003h8-DT
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750406029;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PCE8gMNfTMx1WtO8R0pol54VRJKd2w//iYIcb/hv+AY=;
 b=boSSmmSA31ipcE4dPzIjGchL+WT5ElX/9sPfguvCMBAi4exWrfTGp/ufPnJBw7GNNLxLZp
 d03739pFTLT7T7XtrzJ/D6E2Vok25Y75hXomIGWgTPH0IZ7GPiAanQtaq2E3jwa05mNN8Y
 94Q3vKBv+PzaxuRcsyF0OAFVKh23QfI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-zCLJjOVIPc-Gw5YCepF2UA-1; Fri, 20 Jun 2025 03:53:45 -0400
X-MC-Unique: zCLJjOVIPc-Gw5YCepF2UA-1
X-Mimecast-MFC-AGG-ID: zCLJjOVIPc-Gw5YCepF2UA_1750406024
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4530ec2c87cso8517195e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 00:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750406024; x=1751010824;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PCE8gMNfTMx1WtO8R0pol54VRJKd2w//iYIcb/hv+AY=;
 b=khrlUbY0WYFlI6iUjrNGRNGS8G63bfC5hPSc1E65lcKW6vOmUWYrjAtUXcXL1EeE40
 ZMYPGOXMO2MoFNY7Lj8XzC7QO8WtCbexwUQ2e99IuF0IzWUxh8KlHWJKOF8Cvj9IkDnD
 VUr+DJ4DM5Ujo/yJWMDGp5J584UWdLNoTZvjtLfUVCCdNoywmwj7gYgDDo3G4+Znzmm1
 SXH1ll83m4kt7o1mTuGrvNEdURex02r5zqG6aPKWvj/kASnos+9xZou5q387T4+NM38s
 82sJ9rXzSUutRekWj5SxzT3pvnBOVTkdY5ZBOjhklMm1fDaUlMAtQ6iyOIsH4P9Jgqof
 5N/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA6lEbLooxGcQwwBuSUcaKNGGVx086cvPUIfsshkLrX1HbRK77elsgSq4niCmiYt7DnUzAFrkmlfUi@nongnu.org
X-Gm-Message-State: AOJu0Yw2m/4Hjt4DObnOC1lgcvJSe3JgXdW//wBRMpWwHvHStlphN9Gy
 i09ggatmWIBAnmuKTNpqQk2gNRLc5FMdXS34mlz26f/4kqz+zsv09KPgZmJH9J3vphiILxxzGdw
 kqJsu9zdXj3JX0DMuZfYDi8czcKOv/uKf5jgFIqi57VxMkJpoztDV+ajm
X-Gm-Gg: ASbGncuDX4G1tyFknf4EH3fqmwBceqD2rXTGHP3c6Zi16LQt5I+aypjFTtdhCtze/IY
 NVpbGmV5nRi+0zb+VcSnwzUOahtmzrbh6jhnmiT/rGYYIdV973Hh4f5zhh3x9ewDFE2Czonw74n
 XpNcIfPstAcuf2z3YlLb73oce/BlmMLKkShLohPKavqywyrPWU3JwTwXIBLI/r5sEXNzpV+ur53
 0LL1e/HUZygTftdfQ9bzlYmL6fPcD1YFoW0uUm9Au5lXqz6KP28oX2Jxa1HFb4S74zijlctCfmJ
 KBabqGHZWq1IdDw4ce9CpGBWa3if/A0WnU0vDXHEkKxT+HIl0Su8CL+qCtsBfhOIU7q3JQ==
X-Received: by 2002:a05:600c:6206:b0:453:dbe:7574 with SMTP id
 5b1f17b1804b1-453659caa7dmr14371535e9.12.1750406024126; 
 Fri, 20 Jun 2025 00:53:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe5kepqOc7zcvyArVEYeNNaaoNy1kmxabrTWjtu9bh1O2c0ZNo/x3YCV5ETZpr6Ep/cDgerA==
X-Received: by 2002:a05:600c:6206:b0:453:dbe:7574 with SMTP id
 5b1f17b1804b1-453659caa7dmr14371165e9.12.1750406023641; 
 Fri, 20 Jun 2025 00:53:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45364703f1esm16464675e9.32.2025.06.20.00.53.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 00:53:42 -0700 (PDT)
Message-ID: <15fa4c74-347f-4374-b225-d97f340d045b@redhat.com>
Date: Fri, 20 Jun 2025 09:53:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/19] hw/pci: Introduce pci_device_get_viommu_cap()
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-3-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620071813.55571-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

Hi Zhenzhong,

On 6/20/25 9:17 AM, Zhenzhong Duan wrote:
> pci_device_get_viommu_cap() call pci_device_get_iommu_bus_devfn()
> to get iommu_bus->iommu_ops and call get_viommu_cap() callback to
> get a bitmap with each bit represents a vIOMMU exposed capability.
>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/hw/pci/pci.h | 22 ++++++++++++++++++++++
>  hw/pci/pci.c         | 11 +++++++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index df3cc7b875..829757b2c2 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -453,6 +453,18 @@ typedef struct PCIIOMMUOps {
>       * @devfn: device and function number of the PCI device.
>       */
>      void (*unset_iommu_device)(PCIBus *bus, void *opaque, int devfn);
> +    /**
> +     * @get_viommu_cap: get vIOMMU capabilities
> +     *
> +     * Optional callback, if not implemented, then vIOMMU doesn't
> +     * support exposing capabilities to other subsystem, e.g., VFIO.
> +     * vIOMMU can choose which capabilities to expose.
> +     *
> +     * @opaque: the data passed to pci_setup_iommu().
> +     *
> +     * Returns: 64bit bitmap with each bit represents a capability.
I think we need to clarify what this bitmap contains as capability bits
(enum type)

Thanks

Eric
> +     */
> +    uint64_t (*get_viommu_cap)(void *opaque);
>      /**
>       * @get_iotlb_info: get properties required to initialize a device IOTLB.
>       *
> @@ -633,6 +645,16 @@ bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
>                                   Error **errp);
>  void pci_device_unset_iommu_device(PCIDevice *dev);
>  
> +/**
> + * pci_device_get_viommu_cap: get vIOMMU capabilities.
> + *
> + * Returns a 64bit bitmap with each bit represents a vIOMMU exposed
> + * capability, 0 if vIOMMU doesn't support esposing capabilities.
> + *
> + * @dev: PCI device pointer.
> + */
> +uint64_t pci_device_get_viommu_cap(PCIDevice *dev);
> +
>  /**
>   * pci_iommu_get_iotlb_info: get properties required to initialize a
>   * device IOTLB.
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index c70b5ceeba..df1fb615a8 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2992,6 +2992,17 @@ void pci_device_unset_iommu_device(PCIDevice *dev)
>      }
>  }
>  
> +uint64_t pci_device_get_viommu_cap(PCIDevice *dev)
> +{
> +    PCIBus *iommu_bus;
> +
> +    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, NULL, NULL);
> +    if (iommu_bus && iommu_bus->iommu_ops->get_viommu_cap) {
> +        return iommu_bus->iommu_ops->get_viommu_cap(iommu_bus->iommu_opaque);
> +    }
> +    return 0;
> +}
> +
>  int pci_pri_request_page(PCIDevice *dev, uint32_t pasid, bool priv_req,
>                           bool exec_req, hwaddr addr, bool lpig,
>                           uint16_t prgi, bool is_read, bool is_write)


