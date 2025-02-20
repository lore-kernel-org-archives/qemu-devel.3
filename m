Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C277EC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 18:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlBUp-0000ml-K5; Thu, 20 Feb 2025 13:42:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlBUl-0000hW-63
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 13:41:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlBUj-0005ux-4A
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 13:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740076915;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JRVZyMauCAlDoOJhifm6qwrFvNvk+jcAKvi8PKPsUeo=;
 b=FLIq98Wpje4vQ+qZbQulNrEcMs2F/tz646N7M09tdRmAgl3PDwq1zGUjZ0u86YXC+X+Do5
 XAzDD0N9mSu0RW64vbRErSCvpkrYKpZivVsiXv+xtQI33pWTXV9JSCr09gz2E5yhpL4GWz
 VOrzvjo2T43AZWpwkse7CEfEOw0M0Do=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-skDhWvEzOLyaFokpY26UNA-1; Thu, 20 Feb 2025 13:41:53 -0500
X-MC-Unique: skDhWvEzOLyaFokpY26UNA-1
X-Mimecast-MFC-AGG-ID: skDhWvEzOLyaFokpY26UNA_1740076912
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f2f438fb6so1712405f8f.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 10:41:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740076912; x=1740681712;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JRVZyMauCAlDoOJhifm6qwrFvNvk+jcAKvi8PKPsUeo=;
 b=D1pChZKYxPYZQnoEFZ41w14yOZC1kiur/O8Cvv3Z0pA8tQNBSvRgJMjWOetzDqzsuf
 eOTMHKzrBy/NxZ/XMtjjrkKJ2fARXtNw9yCvBPIrNBqh4NWxbae9ru2qgbDB0dW7Ycyx
 1GrPXUwuz0hk9bM62SBDGJGhZ946ZWW0HG7JMZ2RE0ItK9PQgDQIP/eK7cRCQ7D6NzIj
 REQ0gM2BJOBoLBZGQDEEPZw8mM1t5SkY9z+kgiHMl4vPvnquFsN+VBCQaajFL8ssZvBK
 TEI7CtKxi59UOX8gXVh7TjFmGTy0Tcs2eKO+WUeDOU0msQfzk/hqHUCACMhaBBxF/DO6
 y8ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEaA4a5KQ38e7wIfgbmWYE5wfN9K8fZJJLtV/B9U0Ja8h+d0NqCAgLPYFGwKtFC4w4MnBFiHjY29eb@nongnu.org
X-Gm-Message-State: AOJu0YxM7uVmtiyZv7fwGSBXZA+/iEZM1a1Q8S9eQnlBo9BDGyHHYH2Z
 cFzCLjYiyK+IgS7E/UMwSY/qQwlI7ESMAqavOYFXTUTMFpvTZjhxmlQQdCZWB3JyewOtdDILJTU
 o5weK68pUxu7dsU50p6EfMPu0hl/8PXzbEs0a22+eW8TsoOANj5V9
X-Gm-Gg: ASbGncubkcwhxuyCIagKjVnaJZelDBwxFH7Zz07KGe0CPePNyV/7mxV45ZYHbZFgv83
 bTNFNJopAZmZ3lsM05ZW1BwVZK6a6v4ey3weCWWe26I71S+abEuFDED5wOfKaduN1HCELKO7dw4
 79yVAcB0S5uODh2V32cQFI87ZQpBXi5RJJOV+XMqY8LQPVv1eOAO3L6Ppx+tRmgAUUU064d96R+
 buMf1VxAN4kz2MomL3Y12giFW8mgktGfQu7HvoWqAoEM1anX6aoUbyGqZYHow5KDzZ3HXsRIqJj
 Ga95FV8Lel+Wmf41DWiRYcMW3A9LUcSFJ5wBFmzhGvuLPa+ruto+
X-Received: by 2002:a05:6000:154d:b0:38d:df29:e14f with SMTP id
 ffacd0b85a97d-38f6f09b237mr318162f8f.43.1740076912204; 
 Thu, 20 Feb 2025 10:41:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjMq6fwPzP1BLOH145i/zxlwZz4pW1imLehQygNm8OuEBc6a2g9FxaQn6tEcCccThL4jBunA==
X-Received: by 2002:a05:6000:154d:b0:38d:df29:e14f with SMTP id
 ffacd0b85a97d-38f6f09b237mr318147f8f.43.1740076911785; 
 Thu, 20 Feb 2025 10:41:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399600257asm82797115e9.4.2025.02.20.10.41.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 10:41:50 -0800 (PST)
Message-ID: <4f13004c-a6d9-4f45-938e-3fc8d49183d7@redhat.com>
Date: Thu, 20 Feb 2025 19:41:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 06/20] host_iommu_device: Define two new
 capabilities HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP]
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-7-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250219082228.3303163-7-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
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

Hi Zhenzhong,


On 2/19/25 9:22 AM, Zhenzhong Duan wrote:
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/system/host_iommu_device.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
> index df782598f2..18f8b5e5cf 100644
> --- a/include/system/host_iommu_device.h
> +++ b/include/system/host_iommu_device.h
> @@ -22,10 +22,16 @@
>   *
>   * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this represents
>   *           the @out_capabilities value returned from IOMMU_GET_HW_INFO ioctl)
> + *
> + * @nesting: nesting page table support.
> + *
> + * @fs1gp: first stage(a.k.a, Stage-1) 1GB huge page support.
>   */
>  typedef struct HostIOMMUDeviceCaps {
>      uint32_t type;
>      uint64_t hw_caps;
> +    bool nesting;
> +    bool fs1gp;
this looks quite vtd specific, isn't it? Shouldn't we hide this is a
vendor specific cap struct?
>  } HostIOMMUDeviceCaps;
>  
>  #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
> @@ -122,6 +128,8 @@ struct HostIOMMUDeviceClass {
>   */
>  #define HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE        0
>  #define HOST_IOMMU_DEVICE_CAP_AW_BITS           1
> +#define HOST_IOMMU_DEVICE_CAP_NESTING           2
> +#define HOST_IOMMU_DEVICE_CAP_FS1GP             3
>  
>  #define HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX       64
>  #endif

Maybe you could introduce the associated implementation of
hiod_iommufd_get_cap in this patch too?

Eric


