Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65804C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 17:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMVb9-0006MQ-8m; Tue, 03 Jun 2025 13:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uMVb1-0006Ke-GE
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 13:38:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uMVaz-0006eh-Ix
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 13:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748972318;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LWmawOUUuGjE92WURAsxulO/5T0LZzhCRJgCi7zCMC4=;
 b=dnCD9AGhY1N2t5lDoK3w1qT3fbX6zFO1PZmAyielxIyqasHW8wXqoYgNF8gPXjhU42u1at
 pKiVBa3jLctKcrYqMEWoHxnTkm4ZX67qiLVuFWk5p+tno16lcf2gRWmeyllNi/LW1jPqww
 arZjY9ACEtXPIuE9AXcOpnyyM8NmW3U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606--AnG0zGhO6i2PQvya-fs8g-1; Tue, 03 Jun 2025 13:38:36 -0400
X-MC-Unique: -AnG0zGhO6i2PQvya-fs8g-1
X-Mimecast-MFC-AGG-ID: -AnG0zGhO6i2PQvya-fs8g_1748972316
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4eeed54c2so3739676f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 10:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748972315; x=1749577115;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LWmawOUUuGjE92WURAsxulO/5T0LZzhCRJgCi7zCMC4=;
 b=enadKOcA6XLlVkRPRJenoU8JyxldCT3eXl76h72CMwxEV/YUvjk3VkM0J4mhmfWB3j
 AHKdWdgApVfKqw6w+58C015+l1v/8IyG6KptfGNvDiNZDrLeGUug3/i4nitSbjY7Yh6n
 ef65N7K1LLH2n5pzFc+330Vc0HWy6uM8MBKpOxAinbLRPZ+XqzqZP/zPCAfrTSHKEF7r
 Ro8XUsEWMa0DX+2NKXYJPJ0C14/fFvUo+wMMow7CKANXGPqwT4y+bQpurhkMwv/QxM08
 DmaAv3foTCrt+oUFdj2JbWTQdoWFVUZziKPBefscYnwPc2qBJYmnhFZ9xD57hD4cBiDY
 z3iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuRWV4gsk+fC+F/KlsXvc9o9aO8nsql7oPNVrLlp1fpun8jZZHAGQUIaSzd3+XzW7YLz1strUat2RO@nongnu.org
X-Gm-Message-State: AOJu0YxtKzyNLcbKjPLSMk1zOOEemVH4RZkdQwERd4JAA3QyvWtotP7W
 ske0YNPFFxui1bd/+tGPj83bd/a7d7fn5wMKnGVLJcXu/5xQcFCeoyNoe/wz6icwCANMSWQL82q
 6Zwn2JLdsfnXUZxC3BFHBqo071jOdNyeOMGACpHwmtWkVOL3UULNGKzb4
X-Gm-Gg: ASbGncsW6K8m0QsM+lPl6QQB7dye5q09OWkMZVFehJsU6DwVekucj5oLk+OlSPM4OlE
 nWN3XROH010MhOz+BqtKpB9iTI9zKkaEMtpCtZcrUy7EHfMegOavPyUxY1mfFBdmXGrBNI7D8tX
 H6480uXVIMlHxWzea7lUDOr0VBSL83EAfi3cUBZnevRI8EalVASVrnllnaI/Ao9EgH3BHdyskl1
 b3lLn02L+XXEJkbDNatWVyhJWNAa9lgVuDMZv/or+rd8uirNZUYUoFu2C7X1QFzfzRnUoWXZBQ+
 ogpSMH+3w+35SOpjKJp7YEQpQUOOJlYCjJXveblAlGp6OzMTM7SrBywNVfg=
X-Received: by 2002:a05:6000:228a:b0:3a4:e706:5326 with SMTP id
 ffacd0b85a97d-3a4f89a47b2mr14021054f8f.3.1748972315663; 
 Tue, 03 Jun 2025 10:38:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXPd+9VVnRAP9f2TlGv4sbyACKFcgwR9CbAeeilt+fPov0bQA7JQg83EmhgzpXLY2GW/KV8w==
X-Received: by 2002:a05:6000:228a:b0:3a4:e706:5326 with SMTP id
 ffacd0b85a97d-3a4f89a47b2mr14021033f8f.3.1748972315235; 
 Tue, 03 Jun 2025 10:38:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b892sm19272555f8f.17.2025.06.03.10.38.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 10:38:33 -0700 (PDT)
Message-ID: <953530ba-0620-41c8-a2c9-39c67c4f37f6@redhat.com>
Date: Tue, 3 Jun 2025 19:38:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] vfio/iommufd: Implement [at|de]tach_hwpt handlers
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20250530093512.3959484-1-zhenzhong.duan@intel.com>
 <20250530093512.3959484-4-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250530093512.3959484-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/30/25 11:35 AM, Zhenzhong Duan wrote:
> Implement [at|de]tach_hwpt handlers in VFIO subsystem. vIOMMU
> utilizes them to attach to or detach from hwpt on host side.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/vfio/iommufd.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 5fde2b633a..d661737c17 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -810,6 +810,24 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, const void *data)
>      vioc->query_dirty_bitmap = iommufd_query_dirty_bitmap;
>  };
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
>  static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>                                        Error **errp)
>  {
> @@ -864,10 +882,14 @@ hiod_iommufd_vfio_get_page_size_mask(HostIOMMUDevice *hiod)
>  static void hiod_iommufd_vfio_class_init(ObjectClass *oc, const void *data)
>  {
>      HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
> +    HostIOMMUDeviceIOMMUFDClass *idevc = HOST_IOMMU_DEVICE_IOMMUFD_CLASS(oc);
>  
>      hiodc->realize = hiod_iommufd_vfio_realize;
>      hiodc->get_iova_ranges = hiod_iommufd_vfio_get_iova_ranges;
>      hiodc->get_page_size_mask = hiod_iommufd_vfio_get_page_size_mask;
> +
> +    idevc->attach_hwpt = host_iommu_device_iommufd_vfio_attach_hwpt;
> +    idevc->detach_hwpt = host_iommu_device_iommufd_vfio_detach_hwpt;
>  };
>  
>  static const TypeInfo types[] = {


