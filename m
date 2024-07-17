Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1051AC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 12:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU47D-0006yH-OE; Wed, 17 Jul 2024 08:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU47C-0006xW-0f
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 08:50:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU475-0006oG-96
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 08:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721220629;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KVOw9M4czvuxTQPp0H4VsReegax+qdztL6dorfuuqm8=;
 b=jEk6WG9eGRM1kGQiw6eK7YbAUTwaLWut88CHXYCOV4UfBFXn6IXrvcNT3gTCaV5NPoDAXD
 eKs74VovHdHDM+jTLHTqvXZxnM0SrKajz/D/D2YFE1/SndZIO9Ch/sPY2VllfH0XAI5g8+
 V8YKWVeCLC70GzJHG1LV8RtZ9PHSWhw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-OJ8EdCMlPsq7pJ_Z_4lqlA-1; Wed, 17 Jul 2024 08:50:24 -0400
X-MC-Unique: OJ8EdCMlPsq7pJ_Z_4lqlA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-367987e6ebcso4875628f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 05:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721220623; x=1721825423;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KVOw9M4czvuxTQPp0H4VsReegax+qdztL6dorfuuqm8=;
 b=WyfY8TqhItcQ5JWvgVa1lPo4GJvEyYSraSTJFHErrL4J2W/qN8AxdQvJKDZCT1xaYL
 KCbKhCIleV/BzkUK2zbeppQJJoij1ms2Du7nO8OtWWjaPqsxejaCKHO5jl5c+WS4Km2q
 eTp4zSSADgv+hTo6zKYmCLabgdIu474n7OtyTiPnCG5cGsz+v/Fx5M6cK0Gm0wW2S1WH
 nUSHYlm/OQ/d3ITI+tGGjOAOsFGLv876G4verTGxPjIqkIvy2mogLhIUKgtiKnz+sits
 xn59k9DfCwJGMo1NM53ePCZ/llxKUaAnVfceeaqWY+/HoTxmoaSslp7XcUaOrppfDXyD
 +ubQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjTyCyKTdAXseVr3uR1jtaORpbog6bdujkL7euMh+gdAVBa2Is0Q/BzvF8+iR7IregBi1N1iLyQSUGNLk8YuZHU27EsIU=
X-Gm-Message-State: AOJu0Yy3LkGaawJYt1RMJvMSeYPGzKxJaNmsJaEnkg6vbutE0BI2ISa1
 wqNwb1HDY9DSdC6XgSoPsa2rz7NAnaHPYoDh4q8rtBfu6kZsT4qadUJlmC3mzDHc8/SKdiejYfO
 T/R3WiX2rT/l5ZKz0HYQHu93JkWuonlbxMApNwBPoYvEQdrUbLTbN
X-Received: by 2002:adf:ce10:0:b0:367:8a68:e749 with SMTP id
 ffacd0b85a97d-3683165d26cmr1017476f8f.37.1721220623627; 
 Wed, 17 Jul 2024 05:50:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEepVmxMgAITl88vacE8DHiKFTOWeZA5Zrs9J02kyFLfEFTnt6sEGmH60MV3LKZuLxULQjL5Q==
X-Received: by 2002:adf:ce10:0:b0:367:8a68:e749 with SMTP id
 ffacd0b85a97d-3683165d26cmr1017465f8f.37.1721220623255; 
 Wed, 17 Jul 2024 05:50:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f09d1d8sm201719935e9.0.2024.07.17.05.50.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 05:50:22 -0700 (PDT)
Message-ID: <86cf8320-9c4a-42b3-97cb-36df0e2c91e1@redhat.com>
Date: Wed, 17 Jul 2024 14:50:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/12] vfio/iommufd: Implement
 VFIOIOMMUClass::query_dirty_bitmap support
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-11-joao.m.martins@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240712114704.8708-11-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 7/12/24 13:47, Joao Martins wrote:
> ioctl(iommufd, IOMMU_HWPT_GET_DIRTY_BITMAP, arg) is the UAPI
> that fetches the bitmap that tells what was dirty in an IOVA
> range.
>
> A single bitmap is allocated and used across all the hwpts
> sharing an IOAS which is then used in log_sync() to set Qemu
> global bitmaps.
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Eric
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  include/sysemu/iommufd.h |  4 ++++
>  backends/iommufd.c       | 29 +++++++++++++++++++++++++++++
>  hw/vfio/iommufd.c        | 27 +++++++++++++++++++++++++++
>  backends/trace-events    |  1 +
>  4 files changed, 61 insertions(+)
>
> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
> index 7416d9219703..869ca8b7ef59 100644
> --- a/include/sysemu/iommufd.h
> +++ b/include/sysemu/iommufd.h
> @@ -57,6 +57,10 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>                                  Error **errp);
>  bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
>                                          bool start, Error **errp);
> +bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
> +                                      uint64_t iova, ram_addr_t size,
> +                                      uint64_t page_size, uint64_t *data,
> +                                      Error **errp);
>  
>  #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>  
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 239f0976e0ad..46be719cae71 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -262,6 +262,35 @@ bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be,
>      return true;
>  }
>  
> +bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
> +                                      uint32_t hwpt_id,
> +                                      uint64_t iova, ram_addr_t size,
> +                                      uint64_t page_size, uint64_t *data,
> +                                      Error **errp)
> +{
> +    int ret;
> +    struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap = {
> +        .size = sizeof(get_dirty_bitmap),
> +        .hwpt_id = hwpt_id,
> +        .iova = iova,
> +        .length = size,
> +        .page_size = page_size,
> +        .data = (uintptr_t)data,
> +    };
> +
> +    ret = ioctl(be->fd, IOMMU_HWPT_GET_DIRTY_BITMAP, &get_dirty_bitmap);
> +    trace_iommufd_backend_get_dirty_bitmap(be->fd, hwpt_id, iova, size,
> +                                           page_size, ret ? errno : 0);
> +    if (ret) {
> +        error_setg_errno(errp, errno,
> +                         "IOMMU_HWPT_GET_DIRTY_BITMAP (iova: 0x%"HWADDR_PRIx
> +                         " size: 0x%"HWADDR_PRIx") failed", iova, size);
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>                                       uint32_t *type, void *data, uint32_t len,
>                                       uint64_t *caps, Error **errp)
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index da678315faeb..1fd1558fa0c0 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -25,6 +25,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/chardev_open.h"
>  #include "pci.h"
> +#include "exec/ram_addr.h"
>  
>  static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>                              ram_addr_t size, void *vaddr, bool readonly)
> @@ -146,6 +147,31 @@ err:
>      return -EINVAL;
>  }
>  
> +static int iommufd_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> +                                      VFIOBitmap *vbmap, hwaddr iova,
> +                                      hwaddr size, Error **errp)
> +{
> +    VFIOIOMMUFDContainer *container = container_of(bcontainer,
> +                                                   VFIOIOMMUFDContainer,
> +                                                   bcontainer);
> +    unsigned long page_size = qemu_real_host_page_size();
> +    VFIOIOASHwpt *hwpt;
> +
> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
> +        if (!iommufd_hwpt_dirty_tracking(hwpt)) {
> +            continue;
> +        }
> +
> +        if (!iommufd_backend_get_dirty_bitmap(container->be, hwpt->hwpt_id,
> +                                              iova, size, page_size,
> +                                              vbmap->bitmap, errp)) {
> +            return -EINVAL;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>  static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>  {
>      ERRP_GUARD();
> @@ -754,6 +780,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
>      vioc->detach_device = iommufd_cdev_detach;
>      vioc->pci_hot_reset = iommufd_cdev_pci_hot_reset;
>      vioc->set_dirty_page_tracking = iommufd_set_dirty_page_tracking;
> +    vioc->query_dirty_bitmap = iommufd_query_dirty_bitmap;
>  };
>  
>  static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
> diff --git a/backends/trace-events b/backends/trace-events
> index 28aca3b859d4..40811a316215 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -17,3 +17,4 @@ iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
>  iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
>  iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
>  iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
> +iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"


