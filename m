Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8973AC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 10:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKE2a-0000Fj-Oy; Wed, 28 May 2025 06:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uKE2Y-0000DE-88
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:29:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uKE2W-0003mR-BU
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748428178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6XySOKcmzpuDeocTZCzwcBJmiRipM17W39oQ/yo7VNw=;
 b=djdic07Ky8GJtNNUDmk2DR+jlcHaNqInmgAfDUS6/dptNM/kxZjLyOHZS3iXl6Ppd3r99Y
 eyeTomYwOeGkOQjqFefRaoN6y8E2MF1DkD6uDhPHvJL/6DNwKaYhhP40uNHRjU8eQ2bAp3
 NSa8DkY+ouNJ/94XadOVFtZ0C3a8rQg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-GB4XLBSYMeGq7Uk5K-DQMw-1; Wed, 28 May 2025 06:29:37 -0400
X-MC-Unique: GB4XLBSYMeGq7Uk5K-DQMw-1
X-Mimecast-MFC-AGG-ID: GB4XLBSYMeGq7Uk5K-DQMw_1748428177
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43eea5a5d80so27415005e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 03:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748428176; x=1749032976;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6XySOKcmzpuDeocTZCzwcBJmiRipM17W39oQ/yo7VNw=;
 b=P2VwDIItBPgF1tLnI6o0JDMxTVCDMEb05ygvBHoVhDNCfkOygOg2tF2Hqjrq7ZLp8w
 p+q0ojiEu8oRmeIJfFvHtxIOY5MwISxoaGox/qpjA6Y1kUw+CjmT28f+1bwgjZv7a3hh
 6Gdq577a5dI7KZBFb+OAt1lDts3teG0Fqk6UnyESVqLa1z97WUZdpf6xlZ1KIaEd0Nfx
 bor9LlAIc8h0iFWroJB7OhRvHiauySypzX9ExvHGVHFV5UyFG2s99KNE8sMRclqT52iN
 h4W0MB472vbmX83pikIp48uvNTmw28cOaYBqH3X04xP+mIOMMjG+Qqd6WSTjRPAYGj5V
 QWPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYPCYQqeDfwB47/JeqKFAtSQKGCBkqRFcxlAKt2Ov/W0KIjQqSWhgkdJZ2KqWXVzgK8Rt7AwbFz/e2@nongnu.org
X-Gm-Message-State: AOJu0YzGboDIgu5sLle4Oe5Zo7njH/PAQIm2FvCm/aaA+exwxhcxBTX1
 ee4/NunumviTZEKgTr+FGEWX9nD6SiaCOw9/JrLUb/f2cBd9V7xFGcnEpIEeTx0dCVbDdsdEla6
 jKFAe78cEjhcvhny0tMM3YrKEWIKhPB8zpahEN3Dy38+cDsSnDr2J4ASy
X-Gm-Gg: ASbGncvQRt8rgThQCsYJS00Xg2rGmUA6Ds96lRQ4WrSl7kdf7aOVzKGHq8+/ozGhMFf
 l+rv9oXO4BGwHGrzyR8M2rWIux2nCJCkfMeyJrskD4ZguDKXfzod9RT2625bQpC/3x2hQ8VoHl8
 4Ahk+3Mx1xsVh2sVNQAE55YtCFH3euwMFVE8VkQHgY2BttX3Ao07rsAzP+Rv8OfW9MsUe7L7APO
 CQU3hmYF5PDux7OQ3Laa9SK6NHNP6c2RZWA8MMHj3lg7NY5iA9qvYZLVlfgDGTuQVPyJN0M/Bl1
 ApvJVQ==
X-Received: by 2002:a05:600c:444f:b0:440:9b1a:cd78 with SMTP id
 5b1f17b1804b1-44c935dca8emr190866015e9.10.1748428176586; 
 Wed, 28 May 2025 03:29:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZJkjyUtZ9bH3g9RprGC4nhQQrTn/qMr6z7zMLuIAsCvvPuxVUZhMqb2kZ3C7wGiKZ+5gPDA==
X-Received: by 2002:a05:600c:444f:b0:440:9b1a:cd78 with SMTP id
 5b1f17b1804b1-44c935dca8emr190865765e9.10.1748428176169; 
 Wed, 28 May 2025 03:29:36 -0700 (PDT)
Received: from [10.0.5.211] ([91.126.222.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4eac7e96esm1102636f8f.38.2025.05.28.03.29.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 03:29:35 -0700 (PDT)
Message-ID: <a1947f0c-2c48-40a4-922c-05cb7d1f5bba@redhat.com>
Date: Wed, 28 May 2025 12:29:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/6] vfio/iommufd: Implement [at|de]tach_hwpt handlers
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20250528060409.3710008-1-zhenzhong.duan@intel.com>
 <20250528060409.3710008-5-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250528060409.3710008-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/28/25 08:04, Zhenzhong Duan wrote:
> Implement [at|de]tach_hwpt handlers in VFIO subsystem. vIOMMU
> utilizes them to attach to or detach from hwpt on host side.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/iommufd.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 5fde2b633a..d661737c17 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -810,6 +810,24 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, const void *data)
>       vioc->query_dirty_bitmap = iommufd_query_dirty_bitmap;
>   };
>   
> +static bool
> +host_iommu_device_iommufd_vfio_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +                                           uint32_t hwpt_id, Error **errp)
> +{
> +    VFIODevice *vbasedev = HOST_IOMMU_DEVICE(idev)->agent;
> +
> +    return !iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp);
> +}
> +
> +static bool
> +host_iommu_device_iommufd_vfio_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +                                           Error **errp)
> +{
> +    VFIODevice *vbasedev = HOST_IOMMU_DEVICE(idev)->agent;
> +
> +    return iommufd_cdev_detach_ioas_hwpt(vbasedev, errp);
> +}
> +
>   static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>                                         Error **errp)
>   {
> @@ -864,10 +882,14 @@ hiod_iommufd_vfio_get_page_size_mask(HostIOMMUDevice *hiod)
>   static void hiod_iommufd_vfio_class_init(ObjectClass *oc, const void *data)
>   {
>       HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
> +    HostIOMMUDeviceIOMMUFDClass *idevc = HOST_IOMMU_DEVICE_IOMMUFD_CLASS(oc);
>   
>       hiodc->realize = hiod_iommufd_vfio_realize;
>       hiodc->get_iova_ranges = hiod_iommufd_vfio_get_iova_ranges;
>       hiodc->get_page_size_mask = hiod_iommufd_vfio_get_page_size_mask;
> +
> +    idevc->attach_hwpt = host_iommu_device_iommufd_vfio_attach_hwpt;
> +    idevc->detach_hwpt = host_iommu_device_iommufd_vfio_detach_hwpt;
>   };
>   
>   static const TypeInfo types[] = {


