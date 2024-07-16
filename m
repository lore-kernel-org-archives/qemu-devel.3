Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2B9C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 09:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTeOJ-0007PA-T9; Tue, 16 Jul 2024 05:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTeOB-00073Q-Kw
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:22:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTeO9-0004HV-2u
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721121744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7J+9DCtfIaY3E6FvvRBauPvp4oQLML3lASC6CYLH6zE=;
 b=av5LNz7gMtw31+pUhAyY9b6jBzrE0nznJ58m96tKLzu6axPkgstFmIa6fpMNgTortfO3Gx
 eptWXTBt+C3UCRscmoTKCoFOxJPhC9a6z19UDHzY8es2+qaFVkRzeb1CwkUeNw0zAQu0R4
 ElpoaKQlrx/Cqmm82ns4VncTxoNguXY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-FZaKr2kSPMKAMRgUIJtgsg-1; Tue, 16 Jul 2024 05:22:21 -0400
X-MC-Unique: FZaKr2kSPMKAMRgUIJtgsg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-367962f0cb0so3714212f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 02:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721121740; x=1721726540;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7J+9DCtfIaY3E6FvvRBauPvp4oQLML3lASC6CYLH6zE=;
 b=CS/pMSZZix4qOOKvFcs7ZLHLCX2YFzc6cmMpDT8sXT3MgL5qFdkD+gpxZspHHrutLa
 L0kYNCgDQrVuxjPSVLbDYocxXDkk5eo2MU4IFKEduOSIyagFyQL+Z8NkSgg5/Aivse5a
 pZv8WNw4a65DEt1lFSiVwbnaEzcBBAMTikOPJh5jiSTvAbLMJT8i4uxzn5H0JXwslFkQ
 JI5qeMoU5HmHkbPmh8f0ciYx2Ve/L0Je9mUTKhAJirpg5kUM8Dqpgy+BoCGcJ3VObk1V
 kmC9B/P8FxS7lMz/wJzGy6zCBx7Qe+tLU7YQx1YO9YCAUWCbxl3kW4VIewt+Z7drgRAc
 jZ8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUvD6zMcCRFGs7qcwJhYnbo3OhyBmtSMGYb2cmzLc7UudrTU0HNG2t05CHpB9pvlcFYwo5PsQcHVOXxREPoyGoK4E3J3Y=
X-Gm-Message-State: AOJu0YymUNsRLBH+l5Ma7smReBsX6CGw34d8u3efCdbaU1UPcp2mgw0c
 gtunKMJWSmM6Sit/60n79h50WOa+Xv9zdys/b2cqZiEdyqKPe9PP/2+WgtmGdH4vNRHT4NMcrzJ
 NGBq952BkvKRQ/vrqnKynuIdPEvYPS4E1NH8XeaCC7uCR9cVRIfFB
X-Received: by 2002:a5d:5889:0:b0:367:f0f2:66c1 with SMTP id
 ffacd0b85a97d-368260af2b7mr1230897f8f.12.1721121740475; 
 Tue, 16 Jul 2024 02:22:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHV2iyn7XCa7dWyKSB8JIVFimH/xEKQdGKrZAvRGyyeQSnYBfz9T4FlXA6B7fQ0KG0DdMyjQ==
X-Received: by 2002:a5d:5889:0:b0:367:f0f2:66c1 with SMTP id
 ffacd0b85a97d-368260af2b7mr1230885f8f.12.1721121740248; 
 Tue, 16 Jul 2024 02:22:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:26c5:842:8baa:576b?
 ([2a01:e0a:9e2:9000:26c5:842:8baa:576b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f23981fsm153251945e9.4.2024.07.16.02.22.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 02:22:19 -0700 (PDT)
Message-ID: <225de763-21fc-4a44-89a5-2b86d8a81737@redhat.com>
Date: Tue, 16 Jul 2024 11:22:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/12] backends/iommufd: Extend
 iommufd_backend_get_device_info() to fetch HW capabilities
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-4-joao.m.martins@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240712114704.8708-4-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/12/24 13:46, Joao Martins wrote:
> The helper will be able to fetch vendor agnostic IOMMU capabilities
> supported both by hardware and software. Right now it is only iommu dirty
> tracking.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/sysemu/iommufd.h | 2 +-
>   backends/iommufd.c       | 4 +++-
>   hw/vfio/iommufd.c        | 4 +++-
>   3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
> index 9edfec604595..57d502a1c79a 100644
> --- a/include/sysemu/iommufd.h
> +++ b/include/sysemu/iommufd.h
> @@ -49,7 +49,7 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>                                 hwaddr iova, ram_addr_t size);
>   bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>                                        uint32_t *type, void *data, uint32_t len,
> -                                     Error **errp);
> +                                     uint64_t *caps, Error **errp);
>   
>   #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>   #endif
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 84fefbc9ee7a..2b3d51af26d2 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -210,7 +210,7 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>   
>   bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>                                        uint32_t *type, void *data, uint32_t len,
> -                                     Error **errp)
> +                                     uint64_t *caps, Error **errp)
>   {
>       struct iommu_hw_info info = {
>           .size = sizeof(info),
> @@ -226,6 +226,8 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>   
>       g_assert(type);
>       *type = info.out_data_type;
> +    g_assert(caps);
> +    *caps = info.out_capabilities;
>   
>       return true;
>   }
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index c2f158e60386..604eaa4d9a5d 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -628,11 +628,13 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>       union {
>           struct iommu_hw_info_vtd vtd;
>       } data;
> +    uint64_t hw_caps;
>   
>       hiod->agent = opaque;
>   
>       if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
> -                                         &type, &data, sizeof(data), errp)) {
> +                                         &type, &data, sizeof(data),
> +                                         &hw_caps, errp)) {
>           return false;
>       }
>   


