Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC633C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 17:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfj7n-0001Hw-6t; Wed, 05 Feb 2025 12:23:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfj7k-0001Hm-Bc
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 12:23:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfj7h-0007WU-E2
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 12:23:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738776215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FPv5AN7yZB1BDmWN7HGAS1m573WuuoQs+0/z/TJbm2k=;
 b=NwowvTuc8Bysj3sEUR/BErPwitUL5rbDOVjb9BJ8uj1xslQMxhCYpiphnhaU7Hbz1bo9Po
 h5MN8sd5nIeoWFBCN0EmK2r6TlUqA267rI701Plty726xydnyd+KnCdBWX5J5MZHkCEFAl
 i3N/ChngEzKCXs6TSy3Q/iwdyfzqcbs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-cziYz4r8P9W9Ta_6GPYzUQ-1; Wed, 05 Feb 2025 12:23:33 -0500
X-MC-Unique: cziYz4r8P9W9Ta_6GPYzUQ-1
X-Mimecast-MFC-AGG-ID: cziYz4r8P9W9Ta_6GPYzUQ
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b6e1b036e9so657405785a.1
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 09:23:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738776213; x=1739381013;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FPv5AN7yZB1BDmWN7HGAS1m573WuuoQs+0/z/TJbm2k=;
 b=vSXO2q1NZvVL9jOarPPUcxDBeXBYNw9+3jwT2wMB7aiwHoLqud0IATJWBzlUBhjDZ/
 RDp9obh3Dx2Q2QnuHxdIAJcu7qXyWIWVAXtv5Ol9NnWtvpf41SqxpAkEM6aRw3ENP7Rk
 8TFAwDwq86L40+s6cMXmrl0Z3s5h4gsQN37hlU7SvFtsJpPYE7BPvl3Pk0pGf+IvWoys
 CRO+BSGmV2dV3BpOyEvwLebOHp4udFrk+XJkOG83OXOcXCa1M2MXcMdJFLsHvxLNOcEL
 U3y/aDn6BQF6MrmlPKAtdpFlZZDBLHHosf7U0Um4FC6YEJTwjk6zV0QYPxuDavscZp0u
 ceiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7ObPnRojIkYBt2oN3zsqP7Je5o0IxKDf8tn/ufCpH9IZ09k2sWFCKMxfPiJpPuyUpiI0gx4YlkzmH@nongnu.org
X-Gm-Message-State: AOJu0Yw++U8MP7BXP2oHjjxtt/XMfV90dnQU0n8RIgpMXFKmZQbuspYW
 +UYKzHwu7wkExmczf3BRkhSybooPpd72ET89swShaKvgcbCyS8UDN0fQgXZsPX6WLESPQfzDVsR
 aZLMlcyS+KFnxI+p7ryKEUNuYuMfpcTLXDrZ4raQ7vMH7sl4horDj
X-Gm-Gg: ASbGncuezZKI1y7+yiyfDn/cX5mQzdmbakZf8nEqJEpbQ1jQ8mLTeGQNms6qJfoLNZo
 myPNmF+yuhgAOGpbAAwFCb6rPBPBpPRvD8p7lkXZa8J0qlFiBrKYnrBdXCVervnb1pcmcXaNXzP
 OMVwBCr+xSUCpuKXRiR/LRxL3YFd0I5y3i6FbBRiQ7ryLxA2T/PiilfZ4ptLHp8fgdoWp0usX3s
 0daWsUPYapVJTtzjHS1aNS00H4FDaML7S3ojJzuz8/FYbViScJYzEZT0R4+YzfTg/WefFI7zFCS
 fKkNFTQqlS1A/P8kSiNfpG42myO0MsOR1mN+ZwfOkO0=
X-Received: by 2002:a05:620a:278e:b0:7b6:d8da:9095 with SMTP id
 af79cd13be357-7c039fc3d82mr528452485a.13.1738776213154; 
 Wed, 05 Feb 2025 09:23:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEM0ArnMXFZYtgrk2WoWuak8mLMytdhTMnXOEPDrKi+TdY3c6oVTm7hme9xyjMrtGNpwNI2YA==
X-Received: by 2002:a05:620a:278e:b0:7b6:d8da:9095 with SMTP id
 af79cd13be357-7c039fc3d82mr528449185a.13.1738776212799; 
 Wed, 05 Feb 2025 09:23:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a8bcaf1sm772454785a.10.2025.02.05.09.23.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 09:23:32 -0800 (PST)
Message-ID: <94093d0a-f9bb-4327-b793-2f3145c7cba2@redhat.com>
Date: Wed, 5 Feb 2025 18:23:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 19/26] vfio/iommufd: use IOMMU_IOAS_MAP_FILE
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-20-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1738161802-172631-20-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 1/29/25 15:43, Steve Sistare wrote:
> Use IOMMU_IOAS_MAP_FILE when the mapped region is backed by a file.
> Such a mapping can be preserved without modification during CPR,
> because it depends on the file's address space, which does not change,
> rather than on the process's address space, which does change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   backends/iommufd.c                    | 36 +++++++++++++++++++++++++++++++++++
>   backends/trace-events                 |  1 +
>   hw/vfio/container-base.c              |  9 +++++++++
>   hw/vfio/iommufd.c                     | 13 +++++++++++++
>   include/exec/cpu-common.h             |  1 +
>   include/hw/vfio/vfio-container-base.h |  3 +++
>   include/system/iommufd.h              |  3 +++
>   system/physmem.c                      |  5 +++++
>   8 files changed, 71 insertions(+)
> 
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 7b4fc8e..6d29221 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -174,6 +174,42 @@ int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
>       return ret;
>   }
>   
> +int iommufd_backend_map_file_dma(IOMMUFDBackend *be, uint32_t ioas_id,
> +                                 hwaddr iova, ram_addr_t size,
> +                                 int mfd, unsigned long start, bool readonly)

Please introduce a patch for this new routine.

> +{
> +    int ret, fd = be->fd;
> +    struct iommu_ioas_map_file map = {
> +        .size = sizeof(map),
> +        .flags = IOMMU_IOAS_MAP_READABLE |
> +                 IOMMU_IOAS_MAP_FIXED_IOVA,
> +        .ioas_id = ioas_id,
> +        .fd = mfd,
> +        .start = start,
> +        .iova = iova,
> +        .length = size,
> +    };
> +
> +    if (!readonly) {
> +        map.flags |= IOMMU_IOAS_MAP_WRITEABLE;
> +    }
> +
> +    ret = ioctl(fd, IOMMU_IOAS_MAP_FILE, &map);
> +    trace_iommufd_backend_map_file_dma(fd, ioas_id, iova, size, mfd, start,
> +                                       readonly, ret);
> +    if (ret) {
> +        ret = -errno;
> +
> +        /* TODO: Not support mapping hardware PCI BAR region for now. */
> +        if (errno == EFAULT) {
> +            warn_report("IOMMU_IOAS_MAP_FILE failed: %m, PCI BAR?");

I am not sure this warning can occur when the PCI BARs are mmaped
in an VM with incompatible address spaces. My attempts produced EINVAL.
Let's keep it for now until it is clarified.


> +        } else {
> +            error_report("IOMMU_IOAS_MAP_FILE failed: %m");

please remove this error report. It's redundant with the callers which
will report the same.

> +        }
> +    }
> +    return ret;
> +}
> +
>   int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>                                 hwaddr iova, ram_addr_t size)
>   {
> diff --git a/backends/trace-events b/backends/trace-events
> index 40811a3..f478e18 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -11,6 +11,7 @@ iommufd_backend_connect(int fd, bool owned, uint32_t users) "fd=%d owned=%d user
>   iommufd_backend_disconnect(int fd, uint32_t users) "fd=%d users=%d"
>   iommu_backend_set_fd(int fd) "pre-opened /dev/iommu fd=%d"
>   iommufd_backend_map_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, void *vaddr, bool readonly, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" addr=%p readonly=%d (%d)"
> +iommufd_backend_map_file_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int fd, unsigned long start, bool readonly, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" fd=%d start=%ld readonly=%d (%d)"
>   iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping: iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>   iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>   iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 302cd4c..fbaf04a 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -21,7 +21,16 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>                              RAMBlock *rb)
>   {
>       VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> +    int mfd = rb ? qemu_ram_get_fd(rb) : -1;
>   
> +    if (mfd >= 0 && vioc->dma_map_file) {
> +        unsigned long start = vaddr - qemu_ram_get_host_addr(rb);
> +        unsigned long offset = qemu_ram_get_fd_offset(rb);
> +
> +        vioc->dma_map_file(bcontainer, iova, size, mfd, start + offset,
> +                           readonly);
> +        return 0;

This is CPR related. Please add a dma_map_file helper and move the
code abolve to a cpr file.

> +    }
>       g_assert(vioc->dma_map);
>       return vioc->dma_map(bcontainer, iova, size, vaddr, readonly);
>   }
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 42ba63f..a3e7edb 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -38,6 +38,18 @@ static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>                                      iova, size, vaddr, readonly);
>   }
>   
> +static int iommufd_cdev_map_file(const VFIOContainerBase *bcontainer,
> +                                 hwaddr iova, ram_addr_t size,
> +                                 int fd, unsigned long start, bool readonly)
> +{
> +    const VFIOIOMMUFDContainer *container =
> +        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
> +
> +    return iommufd_backend_map_file_dma(container->be,
> +                                        container->ioas_id,
> +                                        iova, size, fd, start, readonly);
> +}
> +
>   static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
>                                 hwaddr iova, ram_addr_t size,
>                                 IOMMUTLBEntry *iotlb)
> @@ -806,6 +818,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
>       vioc->hiod_typename = TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO;
>   
>       vioc->dma_map = iommufd_cdev_map;
> +    vioc->dma_map_file = iommufd_cdev_map_file;
>       vioc->dma_unmap = iommufd_cdev_unmap;
>       vioc->attach_device = iommufd_cdev_attach;
>       vioc->detach_device = iommufd_cdev_detach;
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index b1d76d6..0cab252 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -95,6 +95,7 @@ void qemu_ram_unset_idstr(RAMBlock *block);
>   const char *qemu_ram_get_idstr(RAMBlock *rb);
>   void *qemu_ram_get_host_addr(RAMBlock *rb);
>   ram_addr_t qemu_ram_get_offset(RAMBlock *rb);
> +ram_addr_t qemu_ram_get_fd_offset(RAMBlock *rb);
>   ram_addr_t qemu_ram_get_used_length(RAMBlock *rb);
>   ram_addr_t qemu_ram_get_max_length(RAMBlock *rb);
>   bool qemu_ram_is_shared(RAMBlock *rb);
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index d82e256..4daa5f8 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -115,6 +115,9 @@ struct VFIOIOMMUClass {
>       int (*dma_map)(const VFIOContainerBase *bcontainer,
>                      hwaddr iova, ram_addr_t size,
>                      void *vaddr, bool readonly);
> +    int (*dma_map_file)(const VFIOContainerBase *bcontainer,
> +                        hwaddr iova, ram_addr_t size,
> +                        int fd, unsigned long start, bool readonly);
>       int (*dma_unmap)(const VFIOContainerBase *bcontainer,
>                        hwaddr iova, ram_addr_t size,
>                        IOMMUTLBEntry *iotlb);
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index cbab75b..ac700b8 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -43,6 +43,9 @@ void iommufd_backend_disconnect(IOMMUFDBackend *be);
>   bool iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
>                                   Error **errp);
>   void iommufd_backend_free_id(IOMMUFDBackend *be, uint32_t id);
> +int iommufd_backend_map_file_dma(IOMMUFDBackend *be, uint32_t ioas_id,
> +                                 hwaddr iova, ram_addr_t size, int fd,
> +                                 unsigned long start, bool readonly);
>   int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
>                               ram_addr_t size, void *vaddr, bool readonly);
>   int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
> diff --git a/system/physmem.c b/system/physmem.c
> index 0bcfc6c..c41a80b 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -1569,6 +1569,11 @@ ram_addr_t qemu_ram_get_offset(RAMBlock *rb)
>       return rb->offset;
>   }
>   
> +ram_addr_t qemu_ram_get_fd_offset(RAMBlock *rb)
> +{
> +    return rb->fd_offset;
> +}

Should go in its own patch.

>   ram_addr_t qemu_ram_get_used_length(RAMBlock *rb)
>   {
>       return rb->used_length;


Thanks,

C.



