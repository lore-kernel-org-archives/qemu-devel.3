Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACC6CAC5BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 15:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3cG9-0004r3-AC; Tue, 30 Sep 2025 11:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3cG5-0004qu-Nk
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:27:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3cFx-00070i-Mr
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759246024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=g7lQPuDRa8NakgNyvz9ahzz5vZvQ7L3ZV56sK292JU0=;
 b=XvOcN0H4qLQgyju4Dchi1Z79gXLZLl05S+w/kM3Wd+MuaoGJeKEuNOW7Jp69eU6G0zf323
 gXF5GCWpAD7x+rH9jUoiqLl5CINu55pLQWMoGHyIzwJBX2R26icgawSkoXQRNYiKVEvzE1
 Ks5mDE5atOIBeBjTd+Yg6fuM3hCa/8M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-suQfkgXwNXCgpNkRIq9IvQ-1; Tue, 30 Sep 2025 11:27:02 -0400
X-MC-Unique: suQfkgXwNXCgpNkRIq9IvQ-1
X-Mimecast-MFC-AGG-ID: suQfkgXwNXCgpNkRIq9IvQ_1759246022
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e41c32209so25971285e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 08:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759246021; x=1759850821;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g7lQPuDRa8NakgNyvz9ahzz5vZvQ7L3ZV56sK292JU0=;
 b=WEVnCExINrsPRecwvgDrrF3asZHV0QYPlcKtoxOMmxob7EPat6VHuljssGHKgONGP2
 t9GDei36ilvAGDUcy10KMmEvgQfQuUF25HppUK1pkpA/L+LetDWXrve+GvLOcsjiPLMB
 kEEtYUsXoHjsxNItcaCUPw3WobTVZ1kLjiX5QiC21BSaIhcTGiVwkr+LzUbVK/6m6nWo
 NqEKQAQeA9u4y+u0TVFNx2dhm6G7MyeqmZHQZ01QtjUy3rPWEMbaBcAdLv7V79cTg8PD
 bBpcqUu5RXX87AqrAtjg3Uabxoq7TvPyozNZ8NBN1s3LH6F9XsAzstkXhohx9PGCWdb7
 WpUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWFvuivcB39msnV/LjbgSShuIt9QJFRcaWVLPvgdP/96b3fNs7NNvy1u12rJ2pkoblqO7PxkySVNMO@nongnu.org
X-Gm-Message-State: AOJu0Yz/+oKpzhpaw/Bd5HBjStWjEjKbUxjAkH3bgtzWYsMBLV0iy9In
 6zqsTAHd8Staq+JBLnYRPcKZF9p6EyEFhUNPgl/XK8DUngu97uazAYEFHb2eKiWyU8PPn0UM/xZ
 YJgVohp1LZI+R8dVUtvcFqbRgLAIe5clpWsTBB8QrmD3eQ+X9XlQwuDkR3dsjHib9
X-Gm-Gg: ASbGncvRvhTQwoHDBMm+DvZsBJ7HASW79cXcG51hj10JTZNBC99AOePOxsL65Jww8V7
 jPvTj+gLWFZOaWaCf6Lk8wOmaUjFSLzLosGaNSsQ16RbcR/h96IOZrV9jPku7a6xeNSd2+1E5dl
 8LEXdmCKmGnr+iDbW56TgYk2pF/ym2P6pohswL9IhfWAWUDphkhLvF2N91pssSyQ2lnnT5nGrLV
 lCtOgDrGMiwYoONC6qUijI/SxdFksy8wq64+VolXj6vpIE/34SnhmPtTPDnYMYwJ0MYa+BMbZgV
 N6+FZLrvy/VIEU6kmKv4VAYVtCELkBduO/cQawyJ7DxaFG/VNl20Pxu2udbhd2YcOD1+aasWt5r
 SnPV6Toov
X-Received: by 2002:a05:600c:3b08:b0:46e:4c90:81d0 with SMTP id
 5b1f17b1804b1-46e612624d6mr2204565e9.2.1759246021164; 
 Tue, 30 Sep 2025 08:27:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgjkeB8p3LSYEqFslS+0SQhCoMBb3iSB6ctC3FTcuhNpVsJ9pQWeAcWhgn9pzWkjdzHPDrLQ==
X-Received: by 2002:a05:600c:3b08:b0:46e:4c90:81d0 with SMTP id
 5b1f17b1804b1-46e612624d6mr2204295e9.2.1759246020723; 
 Tue, 30 Sep 2025 08:27:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e42eee0b6sm162895435e9.10.2025.09.30.08.26.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 08:27:00 -0700 (PDT)
Message-ID: <01f0b0eb-b036-4823-8020-fd6962b26d9d@redhat.com>
Date: Tue, 30 Sep 2025 17:26:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio/container: Support unmap all in one ioctl()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com,
 joao.m.martins@oracle.com
References: <20250924070254.1550014-1-zhenzhong.duan@intel.com>
 <20250924070254.1550014-2-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250924070254.1550014-2-zhenzhong.duan@intel.com>
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

On 9/24/25 09:02, Zhenzhong Duan wrote:
> VFIO type1 kernel uAPI supports unmapping whole address space in one call
> since commit c19650995374 ("vfio/type1: implement unmap all"). use the
> unmap_all variant whenever it's supported in kernel.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/container.c | 33 ++++++++++++++++++++-------------
>   1 file changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 030c6d3f89..2e13f04803 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -122,12 +122,12 @@ unmap_exit:
>   
>   static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,

Side note for rebase :

I would prefer internal routines of file hw/vfio/container.c,
which was renamed recently to hw/vfio/container-legacy.c, to
take a 'VFIOLegacyContainer *container' parameter.

The 'VFIOContainer *bcontainer' parameter should be kept for
high-level routines that wrap the IOMMU backend implementation.

>                                        hwaddr iova, ram_addr_t size,
> -                                     IOMMUTLBEntry *iotlb)
> +                                     uint32_t flags, IOMMUTLBEntry *iotlb)
>   {
>       const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
>       struct vfio_iommu_type1_dma_unmap unmap = {
>           .argsz = sizeof(unmap),
> -        .flags = 0,
> +        .flags = flags,
>           .iova = iova,>           .size = size,
>       };
> @@ -187,25 +187,32 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>                                    hwaddr iova, ram_addr_t size,
>                                    IOMMUTLBEntry *iotlb, bool unmap_all)
>   {
> +    uint32_t flags = 0;
>       int ret;
>   
>       if (unmap_all) {
> -        /* The unmap ioctl doesn't accept a full 64-bit span. */
> -        Int128 llsize = int128_rshift(int128_2_64(), 1);
> +        const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
>   
> -        ret = vfio_legacy_dma_unmap_one(bcontainer, 0, int128_get64(llsize),
> -                                        iotlb);
> +        assert(!iova && !size);

The assert deserves an explanation and so probably a new patch.

    
> -        if (ret == 0) {
> -            ret = vfio_legacy_dma_unmap_one(bcontainer, int128_get64(llsize),
> -                                            int128_get64(llsize), iotlb);
> -        }
> +        ret = ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UNMAP_ALL);
> +        if (ret) {
> +            flags = VFIO_DMA_UNMAP_FLAG_ALL;
> +        } else {
> +            /* The unmap ioctl doesn't accept a full 64-bit span. */
> +            Int128 llsize = int128_rshift(int128_2_64(), 1);
> +            size = int128_get64(llsize);
> +
> +            ret = vfio_legacy_dma_unmap_one(bcontainer, 0, size, flags, iotlb);
> +            if (ret) {
> +                return ret;
> +            }

Could we introduce an helper to test 'unmap_all' support in the host
kernel ? The result would be something like :

   if (unmap_all) {
         if (vfio_legacy_has_unmap_all(VFIO_IOMMU_LEGACY(bcontainer))) {
             flags = VFIO_DMA_UNMAP_FLAG_ALL;
         } else {
             /* The unmap ioctl doesn't accept a full 64-bit span. */
             Int128 llsize = int128_rshift(int128_2_64(), 1);
             ...
         }
   }


Thanks,

C.




> -    } else {
> -        ret = vfio_legacy_dma_unmap_one(bcontainer, iova, size, iotlb);
> +            iova = size;
> +        }
>       }
>   
> -    return ret;
> +    return vfio_legacy_dma_unmap_one(bcontainer, iova, size, flags, iotlb);
>   }
>   
>   static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,


