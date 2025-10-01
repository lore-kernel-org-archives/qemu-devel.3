Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3265FCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rAy-0003XI-Ov; Wed, 01 Oct 2025 03:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3rAs-0003Wy-28
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:22:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3rAh-0008Qy-0S
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759303344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KJZd+y0MD3WFZlpxdkG5JTA8NzD8q/fJR2eZ5tX//Hk=;
 b=BQbIXauUlfCAJbRIIKGjRxfRvsLvIF+WwK/6qqzY4cQqbZ+lNlcUhBeYhq9qb/as0m6NiG
 3BUfqrYmchzWHFNWoySbfUks8uXnoYDKiagu0/zSSIg2wPgc1KixCcHbM1cbAR629KjtDp
 yvViYjhdxxEka6TEMzgGWKPNus4Y6Ek=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-TkcO3nBWMRWPx2mV4O9zjA-1; Wed, 01 Oct 2025 03:22:23 -0400
X-MC-Unique: TkcO3nBWMRWPx2mV4O9zjA-1
X-Mimecast-MFC-AGG-ID: TkcO3nBWMRWPx2mV4O9zjA_1759303342
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ee1365964cso4816287f8f.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 00:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759303342; x=1759908142;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KJZd+y0MD3WFZlpxdkG5JTA8NzD8q/fJR2eZ5tX//Hk=;
 b=C2+12GXfEaqtyh792YTcoy3i1MXf9zoG2cmcyaDGFSB3XXVVT3MfhcGZXgunpIcFrG
 cits2mFzjgsMIs+qsxmjkGxOJms3vnzyv4lcDoBXwVjijP6llsCrqi3C+pE/B5yo0mIv
 9nvRDKS77Wb8QG/TEUK+0k6kdJOSinGP5OhHw0G81OMbgRFsxFPYTJd7OU3g6Opxl1tm
 n/xUgnVzlDRKV0IOQPlXAsRzfGy7Pk+8LGLb1RZk521bhnaIM3iFCcdLCN1dGkQtoUOw
 eAacOjBnvsy9PppC12mnvBfIFr1NSOZmwyp73K2gd0UeKZ471wJ5dKNq/rOrC9+3GQ2C
 +s4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEY7WSP2OOLyHQMWhAlP5Os8WHp5dqYLfhhuhqu08Ju8nzOnX/I8thB1ufmP5wPIjyDt0Tij+rPO1y@nongnu.org
X-Gm-Message-State: AOJu0YzS2evKwTGZvn4eUNAaNSn4a19UsfQskR+99Da0z8f9jyd28ut9
 iXOaKCteoERdwqZY2eVp8rliBe9B9ybGuJ4HTU8vKlm0H0ljjjfRdiIuxeDNF55vcohaF8Iw6En
 +9wVPcYTAyPFNpR4EvdiHXfmYb4SvroXfMXY9T0LNLf8J95sTNWyIJsBi
X-Gm-Gg: ASbGncuGXRp/C5I9792N+jIDNN3WttDNsKkViSzoxYFYtRs+cIsgePserQT6Vknx5Sl
 zLuVC2T6zn4EVddbuUqAI3gebA9rph/WkDNUVzna9LBPOxAHxYG6idMc20mPaISe9BMchC/5lBi
 31iXO/PrSECwyE7mgm4SuPG3dvcFH+MyJvtz0MYwyCTzWIzDjsnU5HTVuVdZCmCxTbMick39bhx
 49AKhlQSSxEBsCsH3Y1uNNWHW9KhmBgnCN5JnL8ATU5aHgyooxBBHpEzWs2VAeOnqI08cRFVCvz
 VSTVNMwEYJ4lpHufzhA6fGTv/ukS1ooM46Q2vqpSWh29qalDvxOJqAFHRnvNdiInznftB1c9J6Z
 yqRnHjtMa
X-Received: by 2002:a05:6000:22c8:b0:3ee:1296:d9e6 with SMTP id
 ffacd0b85a97d-42557820038mr1858105f8f.61.1759303341959; 
 Wed, 01 Oct 2025 00:22:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm76nSlk6fTgxJMjkKEV4pGRwObbWLuK9HDsKj3m2pUy2XWZhAalO4orG73GjBjwDnqsK+dw==
X-Received: by 2002:a05:6000:22c8:b0:3ee:1296:d9e6 with SMTP id
 ffacd0b85a97d-42557820038mr1858086f8f.61.1759303341527; 
 Wed, 01 Oct 2025 00:22:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc6921b7dsm25523599f8f.42.2025.10.01.00.22.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 00:22:21 -0700 (PDT)
Message-ID: <a87df072-82a9-4913-a385-0458c3d0994a@redhat.com>
Date: Wed, 1 Oct 2025 09:22:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] pci: Fix wrong parameter passing to
 pci_device_get_iommu_bus_devfn()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, yi.l.liu@intel.com, clement.mathieu--drif@eviden.com
References: <20250929034206.439266-1-zhenzhong.duan@intel.com>
 <20250929034206.439266-4-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250929034206.439266-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 9/29/25 05:42, Zhenzhong Duan wrote:
> The 2nd parameter of pci_device_get_iommu_bus_devfn() about root PCIBus
> backed by an IOMMU for the PCI device, the 3rd is about aliased PCIBus
> of the PCI device.
> 
> Meanwhile the 3rd and 4th parameters are optional, pass NULL if they
> are not needed.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

The commit log should mention potential consequences of this change.

Will this fix need to be backported ? up to ~9.1


Thanks,

C.



> ---
>   hw/pci/pci.c | 18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index c3df9d6656..d5ed89aab7 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2967,7 +2967,7 @@ int pci_iommu_init_iotlb_notifier(PCIDevice *dev, IOMMUNotifier *n,
>       PCIBus *iommu_bus;
>       int devfn;
>   
> -    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
> +    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
>       if (iommu_bus && iommu_bus->iommu_ops->init_iotlb_notifier) {
>           iommu_bus->iommu_ops->init_iotlb_notifier(bus, iommu_bus->iommu_opaque,
>                                                     devfn, n, fn, opaque);
> @@ -3025,7 +3025,7 @@ int pci_pri_request_page(PCIDevice *dev, uint32_t pasid, bool priv_req,
>           return -EPERM;
>       }
>   
> -    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
> +    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
>       if (iommu_bus && iommu_bus->iommu_ops->pri_request_page) {
>           return iommu_bus->iommu_ops->pri_request_page(bus,
>                                                        iommu_bus->iommu_opaque,
> @@ -3049,7 +3049,7 @@ int pci_pri_register_notifier(PCIDevice *dev, uint32_t pasid,
>           return -EPERM;
>       }
>   
> -    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
> +    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
>       if (iommu_bus && iommu_bus->iommu_ops->pri_register_notifier) {
>           iommu_bus->iommu_ops->pri_register_notifier(bus,
>                                                       iommu_bus->iommu_opaque,
> @@ -3066,7 +3066,7 @@ void pci_pri_unregister_notifier(PCIDevice *dev, uint32_t pasid)
>       PCIBus *iommu_bus;
>       int devfn;
>   
> -    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
> +    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
>       if (iommu_bus && iommu_bus->iommu_ops->pri_unregister_notifier) {
>           iommu_bus->iommu_ops->pri_unregister_notifier(bus,
>                                                         iommu_bus->iommu_opaque,
> @@ -3098,7 +3098,7 @@ ssize_t pci_ats_request_translation(PCIDevice *dev, uint32_t pasid,
>           return -EPERM;
>       }
>   
> -    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
> +    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
>       if (iommu_bus && iommu_bus->iommu_ops->ats_request_translation) {
>           return iommu_bus->iommu_ops->ats_request_translation(bus,
>                                                        iommu_bus->iommu_opaque,
> @@ -3122,7 +3122,7 @@ int pci_iommu_register_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
>           return -EPERM;
>       }
>   
> -    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
> +    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
>       if (iommu_bus && iommu_bus->iommu_ops->register_iotlb_notifier) {
>           iommu_bus->iommu_ops->register_iotlb_notifier(bus,
>                                              iommu_bus->iommu_opaque, devfn,
> @@ -3144,7 +3144,7 @@ int pci_iommu_unregister_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
>           return -EPERM;
>       }
>   
> -    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
> +    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
>       if (iommu_bus && iommu_bus->iommu_ops->unregister_iotlb_notifier) {
>           iommu_bus->iommu_ops->unregister_iotlb_notifier(bus,
>                                                           iommu_bus->iommu_opaque,
> @@ -3158,11 +3158,9 @@ int pci_iommu_unregister_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
>   int pci_iommu_get_iotlb_info(PCIDevice *dev, uint8_t *addr_width,
>                                uint32_t *min_page_size)
>   {
> -    PCIBus *bus;
>       PCIBus *iommu_bus;
> -    int devfn;
>   
> -    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
> +    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, NULL, NULL);
>       if (iommu_bus && iommu_bus->iommu_ops->get_iotlb_info) {
>           iommu_bus->iommu_ops->get_iotlb_info(iommu_bus->iommu_opaque,
>                                                addr_width, min_page_size);


