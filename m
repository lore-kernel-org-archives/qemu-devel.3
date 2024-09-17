Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC20CC36008
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 10:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqV7x-0001fR-M7; Tue, 17 Sep 2024 06:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sqV7u-0001dc-AY
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:08:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sqV7r-0002ag-Tr
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726567682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UjqOVm8BIBGpQetOBinQqV/blceAth4lRLTe+lHo5tI=;
 b=cnNA7d1sIv1hMSLiKUKu5xV/8Ts+daGIDgg2CdhXub4PiyPWrAfWmhzXFye+FtD2D11Yxi
 Y0smJj6I+/AqXS6wmO455fYPpgmrSCySlz3cbD1PpbjLiketo1au+UgvyocXFWn6sU0my6
 PY1Nwe8RtDMzYGOvkm2aObXvDy3Sk8U=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103--QUarebfMVG29kCn2vStjw-1; Tue, 17 Sep 2024 06:08:01 -0400
X-MC-Unique: -QUarebfMVG29kCn2vStjw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5c24c92db25so4120013a12.0
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 03:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726567680; x=1727172480;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=UjqOVm8BIBGpQetOBinQqV/blceAth4lRLTe+lHo5tI=;
 b=MREaLvlGm43H/E1pk8wKfnjfLXqwP4fAifcyliaki/vwLDYsA9FmzOsjtcc2WQFWhS
 vq2iakLYVlxLCgL+xjUw6w9OXUV3f32lW2DOoVavYQprT/ZBTbGUh/XElFbKSV349gIS
 Qk6qEKc6guHAyz84rjl6rn7HnvqLXr0Ph8ztwYXw+rtSohJV1Kwft683TW1WHb3pOIck
 YgAxdwi0iAaocqnmQ2XtoFMUrNoi8mkRv/7MD/7xVxfmCQpb9S+lOfz/mKifbxA1j5zK
 h+nRkJybYJP9Fsq85qcqyDgTjUijiT4HQVD4d2lLoRtQOxUzYWwFSZzQDXvnqaiSVZqZ
 +FwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS9jaUBiT9RMSO6EeLZVe+yuZpU23VBqmyngBh+SgGgBG7hioaxKMDGG4JsovGFnbMOhBAq3u/N3PI@nongnu.org
X-Gm-Message-State: AOJu0Yyc4f/GGw8hSDXwyk6R2BNV1ec2YDo8oRCkzmsCR5MkoAPDrW0p
 asshGtyYDnbxwmU703H2m4dC17pPyKAsV1RjkWW8ePwo30cyWUCDsD3ccdRa4UVz39o/3fARG0B
 5AcAkddDYdAKYHvLuMz/IWr/FNePomtL4tFZALwl8Tyo9d4U1+V15
X-Received: by 2002:a05:6402:354f:b0:5c4:30fd:abf5 with SMTP id
 4fb4d7f45d1cf-5c430fdae0cmr8445465a12.7.1726567679793; 
 Tue, 17 Sep 2024 03:07:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF41gzQcM+s9CEyWBFHE5lHY2rn4TUboTZ7yrE4oY+RuT6HlSJMl3ZUgQUm1ZAs76ndsfPOLg==
X-Received: by 2002:a05:6402:354f:b0:5c4:30fd:abf5 with SMTP id
 4fb4d7f45d1cf-5c430fdae0cmr8445429a12.7.1726567679172; 
 Tue, 17 Sep 2024 03:07:59 -0700 (PDT)
Received: from [192.168.55.136] (tmo-067-108.customers.d1-online.com.
 [80.187.67.108]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bc8907asm3682402a12.85.2024.09.17.03.07.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2024 03:07:58 -0700 (PDT)
Message-ID: <abfd06b7-ad85-454b-a973-6c939c4588e3@redhat.com>
Date: Tue, 17 Sep 2024 12:07:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] vhost-user: Add VIRTIO Shared Memory map request
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, slp@redhat.com,
 hi@alyssa.is, mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>, stevensd@chromium.org
References: <20240912145335.129447-1-aesteve@redhat.com>
 <20240912145335.129447-2-aesteve@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240912145335.129447-2-aesteve@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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

On 12.09.24 16:53, Albert Esteve wrote:
> Add SHMEM_MAP/UNMAP requests to vhost-user to
> handle VIRTIO Shared Memory mappings.
> 
> This request allows backends to dynamically map
> fds into a VIRTIO Shared Memory Region indentified
> by its `shmid`. Then, the fd memory is advertised
> to the driver as a base addres + offset, so it
> can be read/written (depending on the mmap flags
> requested) while its valid.
> 
> The backend can munmap the memory range
> in a given VIRTIO Shared Memory Region (again,
> identified by its `shmid`), to free it. Upon
> receiving this message, the front-end must
> mmap the regions with PROT_NONE to reserve
> the virtual memory space.
> 
> The device model needs to create MemoryRegion
> instances for the VIRTIO Shared Memory Regions
> and add them to the `VirtIODevice` instance.
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>   hw/virtio/vhost-user.c                    | 122 ++++++++++++++++++++++
>   hw/virtio/virtio.c                        |  13 +++
>   include/hw/virtio/virtio.h                |   5 +
>   subprojects/libvhost-user/libvhost-user.c |  60 +++++++++++
>   subprojects/libvhost-user/libvhost-user.h |  52 +++++++++
>   5 files changed, 252 insertions(+)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 00561daa06..338cc942ec 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -115,6 +115,8 @@ typedef enum VhostUserBackendRequest {
>       VHOST_USER_BACKEND_SHARED_OBJECT_ADD = 6,
>       VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE = 7,
>       VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP = 8,
> +    VHOST_USER_BACKEND_SHMEM_MAP = 9,
> +    VHOST_USER_BACKEND_SHMEM_UNMAP = 10,
>       VHOST_USER_BACKEND_MAX
>   }  VhostUserBackendRequest;
>   
> @@ -192,6 +194,24 @@ typedef struct VhostUserShared {
>       unsigned char uuid[16];
>   } VhostUserShared;
>   
> +/* For the flags field of VhostUserMMap */
> +#define VHOST_USER_FLAG_MAP_R (1u << 0)
> +#define VHOST_USER_FLAG_MAP_W (1u << 1)
> +
> +typedef struct {
> +    /* VIRTIO Shared Memory Region ID */
> +    uint8_t shmid;
> +    uint8_t padding[7];
> +    /* File offset */
> +    uint64_t fd_offset;
> +    /* Offset within the VIRTIO Shared Memory Region */
> +    uint64_t shm_offset;
> +    /* Size of the mapping */
> +    uint64_t len;
> +    /* Flags for the mmap operation, from VHOST_USER_FLAG_* */
> +    uint64_t flags;
> +} VhostUserMMap;
> +
>   typedef struct {
>       VhostUserRequest request;
>   
> @@ -224,6 +244,7 @@ typedef union {
>           VhostUserInflight inflight;
>           VhostUserShared object;
>           VhostUserTransferDeviceState transfer_state;
> +        VhostUserMMap mmap;
>   } VhostUserPayload;
>   
>   typedef struct VhostUserMsg {
> @@ -1749,6 +1770,100 @@ vhost_user_backend_handle_shared_object_lookup(struct vhost_user *u,
>       return 0;
>   }
>   
> +static int
> +vhost_user_backend_handle_shmem_map(struct vhost_dev *dev,
> +                                    VhostUserMMap *vu_mmap,
> +                                    int fd)
> +{
> +    void *addr = 0;
> +    MemoryRegion *mr = NULL;
> +
> +    if (fd < 0) {
> +        error_report("Bad fd for map");
> +        return -EBADF;
> +    }
> +
> +    if (!dev->vdev->shmem_list ||
> +        dev->vdev->n_shmem_regions <= vu_mmap->shmid) {
> +        error_report("Device only has %d VIRTIO Shared Memory Regions. "
> +                     "Requested ID: %d",
> +                     dev->vdev->n_shmem_regions, vu_mmap->shmid);
> +        return -EFAULT;
> +    }
> +
> +    mr = &dev->vdev->shmem_list[vu_mmap->shmid];
> +
> +    if (!mr) {
> +        error_report("VIRTIO Shared Memory Region at "
> +                     "ID %d unitialized", vu_mmap->shmid);
> +        return -EFAULT;
> +    }
> +
> +    if ((vu_mmap->shm_offset + vu_mmap->len) < vu_mmap->len ||
> +        (vu_mmap->shm_offset + vu_mmap->len) > mr->size) {
> +        error_report("Bad offset/len for mmap %" PRIx64 "+%" PRIx64,
> +                     vu_mmap->shm_offset, vu_mmap->len);
> +        return -EFAULT;
> +    }
> +
> +    void *shmem_ptr = memory_region_get_ram_ptr(mr);
> +
> +    addr = mmap(shmem_ptr + vu_mmap->shm_offset, vu_mmap->len,
> +        ((vu_mmap->flags & VHOST_USER_FLAG_MAP_R) ? PROT_READ : 0) |
> +        ((vu_mmap->flags & VHOST_USER_FLAG_MAP_W) ? PROT_WRITE : 0),
> +        MAP_SHARED | MAP_FIXED, fd, vu_mmap->fd_offset);
> +

I'm sorry, but that looks completely wrong. You cannot just take some 
RAM memory region/ RAMBlock that has properly set flags/fd/whatssoever 
and map whatever you want in there.

Likely you would need a distinct RAMBlock/RAM memory region per mmap(), 
and would end up mmaping implicitly via qemu_ram_mmap().

Then, your shared region would simply be an empty container into which 
you map these RAM memory regions.

-- 
Cheers,

David / dhildenb


