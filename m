Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E69C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 12:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMQdt-0001z7-PK; Tue, 03 Jun 2025 08:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uMQdq-0001yW-6W
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 08:21:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uMQdk-0004Sf-T1
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 08:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748953270;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=scPlUq9Lfm1c8uQjYpq3LAcBd6vSM6N5SAWEMqEsnPI=;
 b=bnm/szxOMqhRGnDH9aAvzyxNv5ZfWbNsfgIHTh//v00vNs1Rqthpz1rMapltrEGk6g4ako
 xaghKe7keCsZtQIC/uZjmwuVQylamQaBjKwjOGvfByZ26W/Ii2xzSaMaZCG+V6BFNXfQGt
 7VPtvFOftApHJkgsugUU6CHiwCn8P1g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-7ceHD4v0NkCW10XpagOUjA-1; Tue, 03 Jun 2025 08:21:09 -0400
X-MC-Unique: 7ceHD4v0NkCW10XpagOUjA-1
X-Mimecast-MFC-AGG-ID: 7ceHD4v0NkCW10XpagOUjA_1748953268
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4eee2398bso2144569f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 05:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748953268; x=1749558068;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=scPlUq9Lfm1c8uQjYpq3LAcBd6vSM6N5SAWEMqEsnPI=;
 b=ipdPjPufudHaJRzbbVoDD8UKKRY/bykv91U0l61iyK8XG5+mMHMw0S2vkArk/jOD1I
 x00opfxbvEx70rMV4bm0FdTrUbnRpoArNPnFC9vWfjwY1FUqBInGYC246DpmIUJHreHu
 bMYmhPDnsCuFGM3vug03CIgp43a2NTqbn3bzCb03PUusozInGS1Ej9Nnhy0QDWF4BXAC
 oSLfBPLTeKvGy3lxz/v5Fot2bmRxlTrEa7i0dJgNrrQPcCamiB4/jduaoyYvB233C33z
 mxlVf2KkKwMiCXllGp2iVwAeJ0YrIUpMZRVtNaW7kl5zx9Bim8YmzUtTWvdrlBr6vRay
 QvKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgCQPZv5LcQY3GhygeSRAuC8KpqB5XRd33rPOjZVRN0Tta/xniRNxJkMGNkeDhiQWqdhUkbQ5lLSBN@nongnu.org
X-Gm-Message-State: AOJu0Yy1jRKyrVKZSHkg28h+taU7c13YVz5YUeGbvKy5nVOTL3TEFnV5
 u9DSEwWfGj5u8wd07bZfjmYNd1ijLR/hmMzqBC4hqcDBYQeKQonCSrcFCRfWw1PYbQWQ23qkVKL
 qafK8ULLo3R1ZnmCEsO7ui28sfZzT2Ug2yqh15WNrgYthBdlkbZAUxUXe
X-Gm-Gg: ASbGnctsM5d7vvToZHAu0jDp2PGz5SMZaRWe69XSTpcMoJonFne+dBbnzUVqVO+UcTx
 XVyI1ZH4dfEZNG52bXQldH/kLkgNuNPTfibYqAWZBjHsNM7j5TBktjXNLMS5pTHzGGqIMh8nSf7
 nkqE2/JXmeSPw8PxM26j6rhLg/TNqoJkVGemB0kFB8VbQyBZx7RmawvU7xOUyHK5i+5oMFE4jGf
 B0mdJLSSaQwSRhZlAnQ/xC9l8rkSB6vJD7fY6S8v9dHXn74nu2l1a9B/s6KfucjWlqdZTjhqfZ9
 0peQlD16aJYcAEoKEncvy0JekE3mO8b2TcAU7tUX06rpedYRWeWw+0Hlxt8=
X-Received: by 2002:a05:6000:4205:b0:3a1:fcd9:f2ff with SMTP id
 ffacd0b85a97d-3a4f7a0255amr12140585f8f.12.1748953267971; 
 Tue, 03 Jun 2025 05:21:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESVfFunVkDXOlYWj/1WM5Fox07UWaQrPZc2kVKQLFM5rSOcNBDqEPKs1aV3PTxEpW9R+LK2g==
X-Received: by 2002:a05:6000:4205:b0:3a1:fcd9:f2ff with SMTP id
 ffacd0b85a97d-3a4f7a0255amr12140536f8f.12.1748953267488; 
 Tue, 03 Jun 2025 05:21:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b8b3sm18052148f8f.20.2025.06.03.05.21.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 05:21:06 -0700 (PDT)
Message-ID: <bcec7aeb-47c2-4edf-87f4-d09362e59715@redhat.com>
Date: Tue, 3 Jun 2025 14:21:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] backends/iommufd: Add a helper to invalidate
 user-managed HWPT
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20250530093512.3959484-1-zhenzhong.duan@intel.com>
 <20250530093512.3959484-2-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250530093512.3959484-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Zhenzhong,

On 5/30/25 11:35 AM, Zhenzhong Duan wrote:
> This helper passes cache invalidation request from guest to invalidate
> stage-1 page table cache in host hardware.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/system/iommufd.h |  4 ++++
>  backends/iommufd.c       | 36 ++++++++++++++++++++++++++++++++++++
>  backends/trace-events    |  1 +
>  3 files changed, 41 insertions(+)
>
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index cbab75bfbf..83ab8e1e4c 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -61,6 +61,10 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>                                        uint64_t iova, ram_addr_t size,
>                                        uint64_t page_size, uint64_t *data,
>                                        Error **errp);
> +bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
> +                                      uint32_t data_type, uint32_t entry_len,
> +                                      uint32_t *entry_num, void *data,
> +                                      Error **errp);
>  
>  #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>  #endif
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index b73f75cd0b..8bcdb60fe7 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -311,6 +311,42 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>      return true;
>  }
>  
> +bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
> +                                      uint32_t data_type, uint32_t entry_len,
> +                                      uint32_t *entry_num, void *data,
> +                                      Error **errp)
> +{
> +    int ret, fd = be->fd;
> +    uint32_t total_entries = *entry_num;
> +    struct iommu_hwpt_invalidate cache = {
> +        .size = sizeof(cache),
> +        .hwpt_id = id,
> +        .data_type = data_type,
> +        .entry_len = entry_len,
> +        .entry_num = total_entries,
> +        .data_uptr = (uintptr_t)data,
> +    };
> +
> +    ret = ioctl(fd, IOMMU_HWPT_INVALIDATE, &cache);
> +    trace_iommufd_backend_invalidate_cache(fd, id, data_type, entry_len,
> +                                           total_entries, cache.entry_num,
> +                                           (uintptr_t)data, ret ? errno : 0);
> +    *entry_num = cache.entry_num;
> +
> +    if (ret) {
> +        error_setg_errno(errp, errno, "IOMMU_HWPT_INVALIDATE failed:"
> +                         " total %d entries, processed %d entries",
> +                         total_entries, cache.entry_num);
> +    } else if (total_entries != cache.entry_num) {
> +        error_setg(errp, "IOMMU_HWPT_INVALIDATE succeed but with unprocessed"
> +                         " entries: total %d entries, processed %d entries."
> +                         " Kernel BUG?!", total_entries, cache.entry_num);
Can this happen? Isn't it a failure case?

Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>


Eric
> +        return false;
> +    }
> +
> +    return !ret;
> +}
> +
>  static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
>  {
>      HostIOMMUDeviceCaps *caps = &hiod->caps;
> diff --git a/backends/trace-events b/backends/trace-events
> index 40811a3162..7278214ea5 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -18,3 +18,4 @@ iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_
>  iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
>  iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
>  iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
> +iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"


