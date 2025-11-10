Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4069CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 04:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIJxS-0003iC-HY; Sun, 09 Nov 2025 23:56:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vIJx4-0003b8-By
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 23:56:30 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vIJwm-0001Kd-Ta
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 23:56:26 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5AA4txfP095605
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 10 Nov 2025 13:55:59 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=HVxaSRNdK+wiog9w+uejyKJlNo93wFfTKnX6l5rvKIw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1762750559; v=1;
 b=Gfv6gh7w7LnpKuayOZyMP2JZPkqvg39f3r9v/nme3vHH3AOS/3qaeAXT83zTpIyL
 /27lwLMBc6E4qv0fcsn0yne0tTAZNZdHPuc089wCdb/MqUcKT3mgt6om616hz/Q8
 6+hWzQ2ispRHulz1dWjCu4LPOJWeN6iZjf2LL1ZrmLfX3IU7Hsd14cC8zbWdJ7P8
 fqD1ofYUhtrw4eFCKyL+Wa03uvbvUCraWSYkf4MZd4gQtKcDMHXQyOVfAcmZTSPl
 P4UZPTXKOoiA2iUTYbRuhrTtUfPZvaVx+SodQvZjNoJXWX8SjFVlNQC6THiSA37o
 wFqPKpvdTjjIvHNsLbR16Q==
Message-ID: <5c224e00-8114-4586-b502-3819770bc8ff@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 10 Nov 2025 13:55:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
 <20251109053801.2267149-11-vivek.kasireddy@intel.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251109053801.2267149-11-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2025/11/09 14:33, Vivek Kasireddy wrote:
> In addition to memfd, a blob resource can also have its backing
> storage in a VFIO device region. Therefore, we first need to figure
> out if the blob is backed by a VFIO device region or a memfd before
> we can call the right API to get a dmabuf fd created.
> 
> So, once we have the ramblock and the associated mr, we rely on
> memory_region_is_ram_device() to tell us where the backing storage
> is located. If the blob resource is VFIO backed, we try to find the
> right VFIO device that contains the blob and then invoke the API
> vfio_device_create_dmabuf().
> 
> Note that in virtio_gpu_remap_udmabuf(), we first try to test if
> the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> use the VFIO device fd directly to create the CPU mapping.

I have just remembered that mremap() will work for either of udmabuf and 
VFIO. That will avoid having two different methods and make 
vfio_get_region_index_from_mr() and vfio_device_get_region_info() 
unnecessary.

> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   hw/display/Kconfig             |   5 ++
>   hw/display/virtio-gpu-dmabuf.c | 114 +++++++++++++++++++++++++++++++--
>   2 files changed, 112 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index 1e95ab28ef..0d090f25f5 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -106,6 +106,11 @@ config VIRTIO_VGA
>       depends on VIRTIO_PCI
>       select VGA
>   
> +config VIRTIO_GPU_VFIO_BLOB
> +    bool
> +    default y
> +    depends on VFIO
> +
>   config VHOST_USER_GPU
>       bool
>       default y
> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
> index 80143034d4..940b0e0411 100644
> --- a/hw/display/virtio-gpu-dmabuf.c
> +++ b/hw/display/virtio-gpu-dmabuf.c
> @@ -18,6 +18,7 @@
>   #include "ui/console.h"
>   #include "hw/virtio/virtio-gpu.h"
>   #include "hw/virtio/virtio-gpu-pixman.h"
> +#include "hw/vfio/vfio-device.h"
>   #include "trace.h"
>   #include "system/ramblock.h"
>   #include "system/hostmem.h"
> @@ -52,6 +53,19 @@ static bool qemu_iovec_same_memory_regions(const struct iovec *iov, int iov_cnt)
>       return true;
>   }
>   
> +static void vfio_create_dmabuf(VFIODevice *vdev,
> +                               struct virtio_gpu_simple_resource *res)
> +{
> +#if defined(VIRTIO_GPU_VFIO_BLOB)
> +    res->dmabuf_fd = vfio_device_create_dmabuf_fd(vdev, res->iov, res->iov_cnt);
> +    if (res->dmabuf_fd < 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: VFIO_DEVICE_FEATURE_DMA_BUF: %s\n",
> +                      __func__, strerror(errno));
> +    }
> +#endif
> +}
> +
>   static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
>   {
>       struct udmabuf_create_list *list;
> @@ -93,11 +107,69 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
>       g_free(list);
>   }
>   
> -static void virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource *res)
> +static void *vfio_dmabuf_mmap(struct virtio_gpu_simple_resource *res,
> +                              VFIODevice *vdev)
> +{
> +    struct vfio_region_info *info = NULL;
> +    ram_addr_t offset, len = 0;
> +    void *map, *submap;
> +    int i, ret = -1;
> +    RAMBlock *rb;
> +
> +    /*
> +     * We first reserve a contiguous chunk of address space for the entire
> +     * dmabuf, then replace it with smaller mappings that correspond to the
> +     * individual segments of the dmabuf.
> +     */
> +    map = mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED, vdev->fd, 0);
> +    if (map == MAP_FAILED) {
> +        return map;
> +    }
> +
> +    for (i = 0; i < res->iov_cnt; i++) {
> +        rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
> +	if (!rb) {
> +            goto err;
> +        }
> +#if defined(VIRTIO_GPU_VFIO_BLOB)
> +        ret = vfio_get_region_index_from_mr(rb->mr);
> +        if (ret < 0) {
> +            goto err;
> +        }
> +
> +        ret = vfio_device_get_region_info(vdev, ret, &info);
> +#endif
> +        if (ret < 0 || !info) {
> +            goto err;
> +        }
> +
> +        submap = mmap(map + len, res->iov[i].iov_len, PROT_READ,
> +                      MAP_SHARED | MAP_FIXED, vdev->fd,
> +                      info->offset + offset);
> +        if (submap == MAP_FAILED) {
> +            goto err;
> +        }
> +
> +        len += res->iov[i].iov_len;
> +    }
> +    return map;
> +err:
> +    munmap(map, res->blob_size);
> +    return MAP_FAILED;
> +}
> +
> +static void virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource *res,
> +                                    VFIODevice *vdev)
>   {
>       res->remapped = mmap(NULL, res->blob_size, PROT_READ,
>                            MAP_SHARED, res->dmabuf_fd, 0);
>       if (res->remapped == MAP_FAILED) {
> +        if (vdev) {
> +            res->remapped = vfio_dmabuf_mmap(res, vdev);
> +            if (res->remapped != MAP_FAILED) {
> +                return;
> +            }
> +        }
>           warn_report("%s: dmabuf mmap failed: %s", __func__,
>                       strerror(errno));
>           res->remapped = NULL;
> @@ -155,7 +227,10 @@ bool virtio_gpu_have_udmabuf(void)
>   
>   void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
>   {
> +    VFIODevice *vdev = NULL;
>       void *pdata = NULL;
> +    ram_addr_t offset;
> +    RAMBlock *rb;
>   
>       res->dmabuf_fd = -1;
>       if (res->iov_cnt == 1 &&
> @@ -166,11 +241,38 @@ void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
>               return;
>           }
>   
> -        virtio_gpu_create_udmabuf(res);
> -        if (res->dmabuf_fd < 0) {
> +        rb = qemu_ram_block_from_host(res->iov[0].iov_base, false, &offset);
> +        if (memory_region_is_ram_device(rb->mr)) {
> +            vdev = vfio_device_lookup(rb->mr);
> +            if (!vdev) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "%s: Could not find device to create dmabuf\n",
> +                              __func__);

This should say "VFIO device" since no other RAM device is supported.

> +                return;
> +            }
> +
> +            vfio_create_dmabuf(vdev, res);
> +            if (res->dmabuf_fd < 0) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "%s: Could not create dmabuf from vfio device\n",

Nitpick: let's make VFIO uppercase as other user-visible messages do.

> +                              __func__);
> +                return;
> +            }
> +        } else if (memory_region_is_ram(rb->mr)) {
 > +            virtio_gpu_create_udmabuf(res);> +            if 
(res->dmabuf_fd < 0) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "%s: Could not create dmabuf from memfd\n",
> +                              __func__);
> +                return;
> +            }
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: memory region cannot be used to create dmabuf\n",
> +                          __func__);
>               return;
>           }
> -        virtio_gpu_remap_dmabuf(res);
> +        virtio_gpu_remap_dmabuf(res, vdev);
>           if (!res->remapped) {
>               return;
>           }
> @@ -182,9 +284,7 @@ void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
>   
>   void virtio_gpu_fini_dmabuf(struct virtio_gpu_simple_resource *res)
>   {
> -    if (res->remapped) {
> -        virtio_gpu_destroy_dmabuf(res);
> -    }
> +    virtio_gpu_destroy_dmabuf(res);
>   }
>   
>   static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf *dmabuf)


