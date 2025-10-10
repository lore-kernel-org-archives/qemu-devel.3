Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66519CAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 04:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v758G-00014B-5z; Fri, 10 Oct 2025 00:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v758D-000130-Di
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 00:53:29 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v7587-0000Uv-DI
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 00:53:28 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59A4r3YJ009482
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 10 Oct 2025 13:53:03 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=xEz5InqHxCqw7Z2NOeKPs12GC8ma43CrAcy8I1khDm8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:From:Subject:To;
 s=rs20250326; t=1760071983; v=1;
 b=jgOcpeNptkct9i6mA6gU9w6HAb5aJkHRxO/FQqRdgfvaYvfqUjm3jOBFQ/Q67q+i
 Onm1mGogH/Ns+ObcqN9d31L8N2jFChYmTn9aen9cGZmynh6itpSZnshC3b93JPPO
 YIjLNdrjXGwgVQ4Rd6Ipf76da2CfiNrlNfCSXoP55cALYExKnoKc9+85sTT81ugy
 1SWQLjqs/5NO+UFTsNQcQUWSrc4f3MFx95xR9T8WoLZ6kyP4R2s099O35R66ryr/
 xCnwMNJhOIo76lJIjRv0YOG5BSrrGCqnmTIb/Rv/k4ktggC3cU1vBcQPKpxAmLN6
 50oPsKGdjFBvha0nSOOlNQ==
Message-ID: <25cb995e-bb7f-4901-84e5-853d2a19b5c0@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 10 Oct 2025 13:53:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH v1 7/7] virtio-gpu-udmabuf: Create dmabuf for blobs
 associated with VFIO devices
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
 <20251003234138.85820-8-vivek.kasireddy@intel.com>
Content-Language: en-US
In-Reply-To: <20251003234138.85820-8-vivek.kasireddy@intel.com>
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

On 2025/10/04 8:36, Vivek Kasireddy wrote:
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

It is odd to handle VFIO DMA-BUF in a function named "udmabuf". The 
function and source file need to be renamed.

> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   hw/display/Kconfig              |   5 ++
>   hw/display/virtio-gpu-udmabuf.c | 143 ++++++++++++++++++++++++++++++--
>   2 files changed, 141 insertions(+), 7 deletions(-)
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
> diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
> index d804f321aa..bd06b4f300 100644
> --- a/hw/display/virtio-gpu-udmabuf.c
> +++ b/hw/display/virtio-gpu-udmabuf.c
> @@ -18,6 +18,7 @@
>   #include "ui/console.h"
>   #include "hw/virtio/virtio-gpu.h"
>   #include "hw/virtio/virtio-gpu-pixman.h"
> +#include "hw/vfio/vfio-device.h"
>   #include "trace.h"
>   #include "system/ramblock.h"
>   #include "system/hostmem.h"
> @@ -27,6 +28,33 @@
>   #include "standard-headers/linux/udmabuf.h"
>   #include "standard-headers/drm/drm_fourcc.h"
>   
> +static void vfio_create_dmabuf(VFIODevice *vdev,
> +                               struct virtio_gpu_simple_resource *res)
> +{
> +#if defined(VIRTIO_GPU_VFIO_BLOB)
> +    res->dmabuf_fd = vfio_device_create_dmabuf(vdev, res->iov, res->iov_cnt);
> +    if (res->dmabuf_fd < 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: VFIO_DEVICE_FEATURE_DMA_BUF: %s\n",
> +                      __func__, strerror(errno));
> +    }
> +#endif
> +}
> +
> +static VFIODevice *vfio_device_lookup(MemoryRegion *mr)
> +{
> +#if defined(VIRTIO_GPU_VFIO_BLOB)
> +    VFIODevice *vdev;
> +
> +    QLIST_FOREACH(vdev, &vfio_device_list, next) {
> +        if (vdev->dev == mr->dev) {
> +            return vdev;
> +        }
> +    }
> +#endif
> +    return NULL;
> +}
> +
>   static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
>   {
>       struct udmabuf_create_list *list;
> @@ -68,11 +96,73 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
>       g_free(list);
>   }
>   
> -static void virtio_gpu_remap_udmabuf(struct virtio_gpu_simple_resource *res)
> +static void *vfio_dmabuf_mmap(struct virtio_gpu_simple_resource *res,
> +                              VFIODevice *vdev)
> +{
> +    struct vfio_region_info *info;
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
> +        rcu_read_lock();
> +        rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
> +        rcu_read_unlock();

I don't think this RCU lock is necessary. The documentation of 
qemu_ram_block_from_host() says:
 > By the time this function returns, the returned pointer is not
 > protected by RCU anymore.  If the caller is not within an RCU critical
 > section and does not hold the BQL, it must have other means of
 > protecting the pointer, such as a reference to the memory region that
 > owns the RAMBlock.

This function is called with the BQL held, and a reference to the memory 
region is also taken in virtio_gpu_dma_memory_map().

> +
> +        if (!rb) {
> +            goto err;
> +        }
> +
> +#if defined(VIRTIO_GPU_VFIO_BLOB)
> +        ret = vfio_get_region_index_from_mr(rb->mr);
> +        if (ret < 0) {
> +            goto err;
> +        }
> +
> +        ret = vfio_device_get_region_info(vdev, ret, &info);
> +#endif
> +        if (ret < 0) {
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
> +static void virtio_gpu_remap_udmabuf(struct virtio_gpu_simple_resource *res,
> +                                     VFIODevice *vdev)
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
> @@ -130,18 +220,59 @@ bool virtio_gpu_have_udmabuf(void)
>   
>   void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
>   {
> +    VFIODevice *vdev = NULL;
>       void *pdata = NULL;
> +    ram_addr_t offset;
> +    RAMBlock *rb;
>   
>       res->dmabuf_fd = -1;
>       if (res->iov_cnt == 1 &&
>           res->iov[0].iov_len < 4096) {
>           pdata = res->iov[0].iov_base;
>       } else {
> -        virtio_gpu_create_udmabuf(res);
> -        if (res->dmabuf_fd < 0) {
> +        rcu_read_lock();
> +        rb = qemu_ram_block_from_host(res->iov[0].iov_base, false, &offset);
> +        rcu_read_unlock();
> +
> +        if (!rb) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Could not find ram block for host address\n",
> +                          __func__);
>               return;
>           }
> -        virtio_gpu_remap_udmabuf(res);
> +
> +        if (memory_region_is_ram_device(rb->mr)) {
> +            vdev = vfio_device_lookup(rb->mr);
> +            if (!vdev) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "%s: Could not find device to create dmabuf\n",
> +                              __func__);
> +                return;
> +            }
> +
> +            vfio_create_dmabuf(vdev, res);
> +            if (res->dmabuf_fd < 0) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "%s: Could not create dmabuf from vfio device\n",
> +                              __func__);
> +                return;
> +            }
> +        } else if (memory_region_is_ram(rb->mr) && virtio_gpu_have_udmabuf()) {

memory_region_is_ram_device() and memory_region_is_ram() should be 
called for all iov elements, not just the first one.

Calling virtio_gpu_have_udmabuf() here is redundant since 
virtio_gpu_device_realize() already calls it.

> +            virtio_gpu_create_udmabuf(res);
> +            if (res->dmabuf_fd < 0) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "%s: Could not create dmabuf from memfd\n",
> +                              __func__);
> +                return;
> +            }
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: memory region cannot be used to create dmabuf\n",
> +                          __func__);
> +            return;
> +        }
> +
> +        virtio_gpu_remap_udmabuf(res, vdev);
>           if (!res->remapped) {
>               return;
>           }
> @@ -153,9 +284,7 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
>   
>   void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res)
>   {
> -    if (res->remapped) {
> -        virtio_gpu_destroy_udmabuf(res);
> -    }
> +    virtio_gpu_destroy_udmabuf(res);
>   }
>   
>   static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf *dmabuf)


