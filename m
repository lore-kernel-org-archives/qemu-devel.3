Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC05C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9hl-00049V-8Y; Thu, 20 Feb 2025 11:47:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tl9hj-00049I-Ex
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:47:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tl9hh-00056P-Ny
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740070032;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5fmXLLVDE8QYA0m3HEI2adj8jpa2smiR1BS4AHWhhCc=;
 b=agd+B56V/5zWCYm8nmFJNjtVFg+Qm9nNY4t4ZMjrC3ToQXhQrA5YhyMbq2HfaqMu5SwKQD
 55Qr/6yQuCbRMWSgLR6BBTXLs3C3HFmjm7SraocJUA8RGnjzgPWwlqeJ4kNqU/ArmVm131
 cFZ5/F8FF4FO+Zo9fzsiMgIS7NpnROA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-HmQSqaGiOwmTUA7wGMQFAg-1; Thu, 20 Feb 2025 11:47:09 -0500
X-MC-Unique: HmQSqaGiOwmTUA7wGMQFAg-1
X-Mimecast-MFC-AGG-ID: HmQSqaGiOwmTUA7wGMQFAg_1740070028
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-439a5c4dfb2so5190815e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:47:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740070028; x=1740674828;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5fmXLLVDE8QYA0m3HEI2adj8jpa2smiR1BS4AHWhhCc=;
 b=Nn06i2XhYiRDy8bquKItNIuzu9w7aW5f/w6hzerxRVFK+Uy5mB9RyE2aj7eAdqw39A
 b46L4faJTOQI4GhgXhpztGR5xD3Ov/pEuuT7z/wnN2wJOtM5KweYQdQgcXxxFR5VeqdB
 RUCeb2ekvaRoh7xJcYkZGWT9CdLFsoG6EAu+kB2mXNCZxTAp+gpA//UAzHeEhPf2hMHC
 44Bkn5alnJsS+p+eLuJkuVxBWL16N4BJB0D/pm7qMdSF9IXolzcnVhhYljyCd2bzXaev
 oqFzV+nIr89AEzsvbzSYGllRj+ok3Ig7jj4xWGrMr81EK4hLxz+Nv121ZfL7hlAvCYgJ
 Jpsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj3mgvWN7QQLJ7tblgxM0Ln2Od9LHwNkhS1dzC7jkg8vJGQhPEJt0iHVH0rYjnjWRoCllwCphda70F@nongnu.org
X-Gm-Message-State: AOJu0YybKvQorIaCKF7sBiH7hWgwL0I3MKRlPOmcY99SiYO9nzenVxDJ
 dV/1pOLLn4i/xdIBFUKVjbA3zzqT/of4hSDBIssK3uor6NDZxgYq0GjXDd7JGh3+olf3i9b7SpT
 jZ8haOZ0lJkhcW7nyfaHUblF3LdtO9RdcEoTzDr5T3czw/G/T2BDU
X-Gm-Gg: ASbGnctgrk8i6PUbRlnd28MeSD+wsxxshui47cA2kzbJ8gcTKSHf568GHXgshW/r3UZ
 rKb7SPWO1AsP+lhd6wFUvgCKMIZdVduTMIa2Y3YGEdodR7+RDwr+BbjZrYX5XEITR2XOwuSzpIf
 07fhDeQpfwzlfwwG6R5BptzouQcbGLB/W9eE19o1S6rLbTfMJcCXN/d3er8kL5CuA6o/zt6Q7R5
 dXCBXaDWgIhilhaiijIsOVOsYZQqAB1TRmvij1zkeM3WuV6Dmm+aYZBbj9eOccbRtTlqCjIKhiO
 MYw4HJKtV1+80LlOQpIMh32KCsY+xHldBT2ML0a2ZyS2GP7O/gCg
X-Received: by 2002:a05:600c:511e:b0:434:fb65:ebbb with SMTP id
 5b1f17b1804b1-43999db07fdmr76367175e9.17.1740070028559; 
 Thu, 20 Feb 2025 08:47:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IER2FtcmTcOVUjqhG/mBVbF8AVgIhPy4dZxHbkTiBCClszhIOPEXvr9W/UWHFwejvMsvSlM2Q==
X-Received: by 2002:a05:600c:511e:b0:434:fb65:ebbb with SMTP id
 5b1f17b1804b1-43999db07fdmr76366945e9.17.1740070028199; 
 Thu, 20 Feb 2025 08:47:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43987396d3dsm114400735e9.36.2025.02.20.08.47.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 08:47:07 -0800 (PST)
Message-ID: <61f66ea9-7636-42d7-9098-bd911b2829ab@redhat.com>
Date: Thu, 20 Feb 2025 17:47:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 01/20] backends/iommufd: Add helpers for
 invalidating user-managed HWPT
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-2-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250219082228.3303163-2-zhenzhong.duan@intel.com>
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
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
in the title, there is only a single helper here. a small commit msg may
help the reader
> ---
>  include/system/iommufd.h |  3 +++
>  backends/iommufd.c       | 30 ++++++++++++++++++++++++++++++
>  backends/trace-events    |  1 +
>  3 files changed, 34 insertions(+)
>
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index cbab75bfbf..5d02e9d148 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -61,6 +61,9 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>                                        uint64_t iova, ram_addr_t size,
>                                        uint64_t page_size, uint64_t *data,
>                                        Error **errp);
> +int iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t hwpt_id,
> +                                     uint32_t data_type, uint32_t entry_len,
> +                                     uint32_t *entry_num, void *data_ptr);
>  
>  #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>  #endif
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index d57da44755..fc32aad5cb 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -311,6 +311,36 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>      return true;
>  }
>  
> +int iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t hwpt_id,
> +                                     uint32_t data_type, uint32_t entry_len,
> +                                     uint32_t *entry_num, void *data_ptr)
> +{
> +    int ret, fd = be->fd;
> +    struct iommu_hwpt_invalidate cache = {
> +        .size = sizeof(cache),
> +        .hwpt_id = hwpt_id,
> +        .data_type = data_type,
> +        .entry_len = entry_len,
> +        .entry_num = *entry_num,
> +        .data_uptr = (uintptr_t)data_ptr,
> +    };
> +
> +    ret = ioctl(fd, IOMMU_HWPT_INVALIDATE, &cache);
> +
> +    trace_iommufd_backend_invalidate_cache(fd, hwpt_id, data_type, entry_len,
> +                                           *entry_num, cache.entry_num,
> +                                           (uintptr_t)data_ptr, ret);
> +    if (ret) {
> +        *entry_num = cache.entry_num;
> +        error_report("IOMMU_HWPT_INVALIDATE failed: %s", strerror(errno));
nit: you may report *entry_num also.
Wouldn't it be useful to have an Error *errp passed to the function
> +        ret = -errno;
> +    } else {
> +        g_assert(*entry_num == cache.entry_num);
> +    }
> +
> +    return ret;
> +}
> +
>  static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
>  {
>      HostIOMMUDeviceCaps *caps = &hiod->caps;
> diff --git a/backends/trace-events b/backends/trace-events
> index 40811a3162..5a23db6c8a 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -18,3 +18,4 @@ iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_
>  iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
>  iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
>  iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
> +iommufd_backend_invalidate_cache(int iommufd, uint32_t hwpt_id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d hwpt_id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
Eric


