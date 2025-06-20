Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CF2C71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 12:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSaPK-00073M-BX; Fri, 20 Jun 2025 07:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSaPG-00071B-0C
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 07:59:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSaP9-0003yd-9H
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 07:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750420772;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CpdhH4qI9RIkFGlQRd68NI4wwY50JC0GcDAsmlszAMo=;
 b=So34p578IS0GhH6z708gCOoKA4+bExaPyuMrTPomGtB8XFcHdORIGGmQcjlwevhj6ZOv0r
 +bKIK6j1hHUelT4ehAKZC2haAenf519Ibt+GA6ec2Jtnd0SbDO9OYfowKZgyCVprs9q7z4
 jdtspPLZA0NQSDbp7yOQWy2I/PG75hI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-XFXla7DKMXCDPEmXl5nrKg-1; Fri, 20 Jun 2025 07:59:30 -0400
X-MC-Unique: XFXla7DKMXCDPEmXl5nrKg-1
X-Mimecast-MFC-AGG-ID: XFXla7DKMXCDPEmXl5nrKg_1750420770
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f8fd1856so922952f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 04:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750420770; x=1751025570;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CpdhH4qI9RIkFGlQRd68NI4wwY50JC0GcDAsmlszAMo=;
 b=OWZIqvdYXJXL+rQvleFJFt0dGX0qCIUkRecjBDrP9SJXplSi3YVAH84/w//PMYxode
 cBoJoSjAEUBB453Z1NRyOz5Q8n0y0wmxbxdLdGA6NBMWPNl/EUkZzS79gVUgwnQB7Shx
 WngYpO7e38S87tRQsZ2HMMt0AJtDycsrhUTRSIOnUrgzFyOBzKgV8z/vKbJ5jNLC0xzK
 aNj4x/9nBJJD2AWnoLauwJgj4OMQqoK46porjk3eCBEukDGk7c8N6qk0JQZpm+cMgPX/
 ntnbFP1NOxbkPTHSivv/WWyHBP3gNd2SHBa1e4GTAz7UfjxeTPMN50Kf3JflFqaVmj1y
 6MWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqcFvh3WoY7IX9HSI6wIvczXWRNNUVCPNVrLy6w/K7TfoM9MnNN55EXLkrtUWBy9t5nQFNLr2CmamJ@nongnu.org
X-Gm-Message-State: AOJu0Yw1DfI3fuinTFJUI6uc8iHlpiqZyNNuqra3tiRS4nqqQ5wYY8Ba
 /2zqPH6SUrDGOf4PLqig1ep8z2QlThYdgrlX7LXRF6ENSjWNiwip1a1zD+djZ2FzXCDeDQMBDmb
 q38MF2TD9a7OsFAvjji/wX1N/FcaBPsj1mMcL9x5GRP92f+zzKHp8Irtd
X-Gm-Gg: ASbGncvMbGJPjVfb56E8nhGi2I9cwPw5H6guupSGf6a9H/eh/jU3nMyHXMXMoUBo/DP
 bXtLJc+2YPgNlBqy5qb98cRrual0DozxLgGC/7pkziNVHFDaUNFgRtZyEv8NGy7e5ybDeetvMVB
 g/EYu1CZx3dHG1SwCRlfEyX3s6xRKQSCMHLKtdoBZ1tBF0vh42qEJ9rt0gqEBJ+bjyrYVqaht3Z
 xRFPLIvDoHrCFgLxFDNWAxLF24YzcGx2dD4Hq1ZBqF+kR+F8NnX+2T2n6GtiBW0FHJ3aGJnMhUF
 jygAdc69IfDE/gFMpfZOkZl+W0i3YhlS8hZI8PVhqUrVQXEh2S67TLw+DLbHIoNyAj5Q3g==
X-Received: by 2002:a05:6000:387:b0:3a4:edf5:b952 with SMTP id
 ffacd0b85a97d-3a6d130453amr2502470f8f.36.1750420769787; 
 Fri, 20 Jun 2025 04:59:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjfhYUnI9YIkVMf4MwoC73mqDl5ZxEjINOhojb+cQxBF8+cDFfWIvHh3oD93EvHiBdlexc1Q==
X-Received: by 2002:a05:6000:387:b0:3a4:edf5:b952 with SMTP id
 ffacd0b85a97d-3a6d130453amr2502435f8f.36.1750420769388; 
 Fri, 20 Jun 2025 04:59:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f1808bsm1871692f8f.24.2025.06.20.04.59.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 04:59:28 -0700 (PDT)
Message-ID: <6d472e7f-864f-4456-a036-1b5f61516aaa@redhat.com>
Date: Fri, 20 Jun 2025 13:59:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/19] hw/pci: Export pci_device_get_iommu_bus_devfn()
 and return bool
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-6-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620071813.55571-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> Returns true if PCI device is aliased or false otherwise. This will be
> used in following patch to determine if a PCI device is under a PCI
> bridge.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/hw/pci/pci.h |  2 ++
>  hw/pci/pci.c         | 12 ++++++++----
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 829757b2c2..3029cdf26f 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -640,6 +640,8 @@ typedef struct PCIIOMMUOps {
>                              bool is_write);
>  } PCIIOMMUOps;
>  
> +bool pci_device_get_iommu_bus_devfn(PCIDevice *dev, PCIBus **piommu_bus,
> +                                    PCIBus **aliased_bus, int *aliased_devfn);
if I am correct you have a single caller of the helper using the
returned value, in intel_iommu.c, whereas all the existing callers are
not using the returned value. You may simply pass a non NULL aliased_bus
and aliased_devfn and check whether they differ from the original
bus/devfn. Besides the patch looks ok to me.

Thanks

Eric
>  AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
>  bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
>                                   Error **errp);
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index df1fb615a8..87f7c942b3 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2857,20 +2857,21 @@ static void pci_device_class_base_init(ObjectClass *klass, const void *data)
>   * For call sites which don't need aliased BDF, passing NULL to
>   * aliased_[bus|devfn] is allowed.
>   *
> + * Returns true if PCI device is aliased or false otherwise.
> + *
>   * @piommu_bus: return root #PCIBus backed by an IOMMU for the PCI device.
>   *
>   * @aliased_bus: return aliased #PCIBus of the PCI device, optional.
>   *
>   * @aliased_devfn: return aliased devfn of the PCI device, optional.
>   */
> -static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
> -                                           PCIBus **piommu_bus,
> -                                           PCIBus **aliased_bus,
> -                                           int *aliased_devfn)
> +bool pci_device_get_iommu_bus_devfn(PCIDevice *dev, PCIBus **piommu_bus,
> +                                    PCIBus **aliased_bus, int *aliased_devfn)
>  {
>      PCIBus *bus = pci_get_bus(dev);
>      PCIBus *iommu_bus = bus;
>      int devfn = dev->devfn;
> +    bool aliased = false;
>  
>      while (iommu_bus && !iommu_bus->iommu_ops && iommu_bus->parent_dev) {
>          PCIBus *parent_bus = pci_get_bus(iommu_bus->parent_dev);
> @@ -2907,6 +2908,7 @@ static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
>                  devfn = parent->devfn;
>                  bus = parent_bus;
>              }
> +            aliased = true;
>          }
>  
>          iommu_bus = parent_bus;
> @@ -2928,6 +2930,8 @@ static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
>      if (aliased_devfn) {
>          *aliased_devfn = devfn;
>      }
> +
> +    return aliased;
>  }
>  
>  AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)


