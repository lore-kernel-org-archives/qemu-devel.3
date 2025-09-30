Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D43DCCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 11:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Ydq-0005Xr-94; Tue, 30 Sep 2025 07:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3Ydn-0005XN-VI
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 07:35:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3Ydj-0001cp-8C
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 07:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759232123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Hciy+sB5BlacXRAoUmUWRR8EjJFbqJ0JnHCK9HENXw0=;
 b=UJ0r5iniP5mtzuzNzAeHJtczurjlUl9utHnWToZjBLV8VnHBeZ8UFalyisXS6XgEY8l7Mo
 zYRd2bAaCKNa9Z3GgQyo34GpCUm8hz4awknyiSi34LVFoXndxF/Zl7DWxu1iw/WCHElHGW
 pyWCC1k1JxZPd2yC11bm8TkI4tNEMfw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-kYLEYcBKMq-4gpfq-8pPJQ-1; Tue, 30 Sep 2025 07:35:20 -0400
X-MC-Unique: kYLEYcBKMq-4gpfq-8pPJQ-1
X-Mimecast-MFC-AGG-ID: kYLEYcBKMq-4gpfq-8pPJQ_1759232119
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e4d34ff05so13021475e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 04:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759232119; x=1759836919;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hciy+sB5BlacXRAoUmUWRR8EjJFbqJ0JnHCK9HENXw0=;
 b=PAL7I2o2BlJJDkaN0S5PuSgAaP8aEz2UYCIB3jBAYVJittZN4ERffyCGvFGNi002fS
 4gP/eDVatH/9HS9ZFCWqE56txW2yiq95jZP4BXl5LYoNWiJ0BEep7Sng5AX8TDhed1sD
 orOxHCXeAkKodF3IlRGRLiMzaW4YjNHqZToyez/NS9Pjs0sgi5VwL0cM72NO7X5AgtZd
 wpBbI0LIj2OAJ3RAqjwlvPJCOwMEx9dXEYMkFCIIa45wApzmlNTz2iA6/oKEbG/rBNNu
 NOOvvAe7x3+il5KBEkNekF2VQry6RdAIS7TSShtL8q0wk3vBXx7GKm4cbK5eQwABqQhz
 fx4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVre3zKmMx5NF7Og5aNNtE/CL78z8IeRU1uxpJCP0cm//OPbswzLs2C4r7twOG+NcbVaKDsfJwavF35@nongnu.org
X-Gm-Message-State: AOJu0Yx21GGDUJ+9jedfWUSBi795toJ+momQLd/gW/cOtmR7k2fBeKu4
 o5Ak1ksi0AgxrKjaHV1LoWVMx1IaLRxzpr1gxoIsPx2LVmu+t5Y/AaAi2JwXziLUdawK7ied3t/
 ZvXeMXdS+qOGpbncrGhacxtld7nRMycia2N/O6bEyy3uxC6ENoLBSgyTV
X-Gm-Gg: ASbGncta5bD/NbjHpP+m/FoJ3BUpE9J4MEetqn0aa+li92XLYobWb11NX0CgLNfEgbH
 7aWTjukAfkgJMfdCEwaJ46IiGuAGVpsxjqi1B7GGBSNiuEWAMnZiizmsTBpF/cYvbDHjcPSB5rl
 uT8QKqG/HxilA13KjTopWrcoMuLQX4FzP9w5ibl87k4tKpQfAHAkbG0BpWO8uqoKYuavthBPUHr
 JtaGv5FLZxBYAs7O5WXBqtl9fbcGWfNSN5J3nU4mHjfa13yPIjmfRuzy0k6BaTUKLaln4inddKU
 mNpVtceEKfB/z0g/no0zqCQMStnhTPRDyZ7NTqJ2kUJhwcI3p8XyRJq14dEKw9++dKGwIJO+tZ+
 vzBJ3iZu1
X-Received: by 2002:a05:600c:4689:b0:46e:32f5:2d4b with SMTP id
 5b1f17b1804b1-46e32f52ec4mr183794805e9.37.1759232119220; 
 Tue, 30 Sep 2025 04:35:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcTmd6tX0EJm8/+6R9r0BsvBpf3vxf8WmS0gY076rTigfyPeavfSQwXcXp3lyDph9qSO4b6A==
X-Received: by 2002:a05:600c:4689:b0:46e:32f5:2d4b with SMTP id
 5b1f17b1804b1-46e32f52ec4mr183794445e9.37.1759232118522; 
 Tue, 30 Sep 2025 04:35:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5873f2efsm49305565e9.4.2025.09.30.04.35.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 04:35:18 -0700 (PDT)
Message-ID: <d3e02afb-a7ec-4ae2-a5a5-74cf11ad4e05@redhat.com>
Date: Tue, 30 Sep 2025 13:35:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] system/iommufd: Use uint64_t type for IOVA mapping
 size
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Eric Auger
 <eric.auger@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, John Levon <john.levon@nutanix.com>
References: <20250930091456.34524-1-philmd@linaro.org>
 <20250930091456.34524-2-philmd@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250930091456.34524-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/30/25 11:14, Philippe Mathieu-Daudé wrote:
> The 'ram_addr_t' type is described as:
> 
>    a QEMU internal address space that maps guest RAM physical
>    addresses into an intermediate address space that can map
>    to host virtual address spaces.
> 
> This doesn't represent well an IOVA mapping size. Simply use
> the uint64_t type.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/system/iommufd.h | 6 +++---
>   backends/iommufd.c       | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index c9c72ffc450..a659f36a20f 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -45,12 +45,12 @@ bool iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
>                                   Error **errp);
>   void iommufd_backend_free_id(IOMMUFDBackend *be, uint32_t id);
>   int iommufd_backend_map_file_dma(IOMMUFDBackend *be, uint32_t ioas_id,
> -                                 hwaddr iova, ram_addr_t size, int fd,
> +                                 hwaddr iova, uint64_t size, int fd,
>                                    unsigned long start, bool readonly);
>   int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
> -                            ram_addr_t size, void *vaddr, bool readonly);
> +                            uint64_t size, void *vaddr, bool readonly);
>   int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
> -                              hwaddr iova, ram_addr_t size);
> +                              hwaddr iova, uint64_t size);
>   bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>                                        uint32_t *type, void *data, uint32_t len,
>                                        uint64_t *caps, Error **errp);
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 2a33c7ab0bc..fdfb7c9d671 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -197,7 +197,7 @@ void iommufd_backend_free_id(IOMMUFDBackend *be, uint32_t id)
>   }
>   
>   int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
> -                            ram_addr_t size, void *vaddr, bool readonly)
> +                            uint64_t size, void *vaddr, bool readonly)
>   {
>       int ret, fd = be->fd;
>       struct iommu_ioas_map map = {
> @@ -230,7 +230,7 @@ int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
>   }
>   
>   int iommufd_backend_map_file_dma(IOMMUFDBackend *be, uint32_t ioas_id,
> -                                 hwaddr iova, ram_addr_t size,
> +                                 hwaddr iova, uint64_t size,
>                                    int mfd, unsigned long start, bool readonly)
>   {
>       int ret, fd = be->fd;
> @@ -268,7 +268,7 @@ int iommufd_backend_map_file_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>   }
>   
>   int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
> -                              hwaddr iova, ram_addr_t size)
> +                              hwaddr iova, uint64_t size)
>   {
>       int ret, fd = be->fd;
>       struct iommu_ioas_unmap unmap = {


