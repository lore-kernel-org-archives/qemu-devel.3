Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1FFECFC50C
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 08:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMisf-0006OQ-B0; Sat, 22 Nov 2025 03:22:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vMi0I-00027t-7H
 for qemu-devel@nongnu.org; Sat, 22 Nov 2025 02:25:56 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vMhzt-00036y-Bo
 for qemu-devel@nongnu.org; Sat, 22 Nov 2025 02:25:51 -0500
Received: from [192.168.10.110] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5AM7P6wU004541
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 22 Nov 2025 16:25:06 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=bSCUctkXhd05N9nQ7atYTBiZ4f8603RzqFt9EI0Tb40=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1763796306; v=1;
 b=TnSypq6C/kzZgJ58O9Gy55WTNAq3+lKL7k6xk+leAAMRppmSd9FSuXEXK+6BInyK
 w7cErz1JUnyPLTvGIu97xRmxs4mAUhPoo/vJFCMT5QcQEdrVDJLL97kYZRRXH1qx
 6rJ7lhaYodm3h4Xs9ABJcNN6oXDVtJsD/16OVObJbB0Fm+W4+t7+InUmUcC4HihP
 6arioACk96bi0BgEd+JcVIoncAj1Pu5zGNo0bx4tJ54NNYwS12cKXU1oR/ehFXcS
 zHpvIKiOM8Nidpgx7u3dTknVUFnfqTwtRDRmmvYRaCxClzG9V/Nr7uzCJd5Ks3CU
 ev/TVQt+khtVyiCTvQaMNw==
Message-ID: <74f4e219-a094-42b9-a30c-8de597692ab6@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 22 Nov 2025 16:25:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20251122064936.2948632-1-vivek.kasireddy@intel.com>
 <20251122064936.2948632-10-vivek.kasireddy@intel.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251122064936.2948632-10-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 2025/11/22 15:46, Vivek Kasireddy wrote:
> In addition to memfd, a blob resource can also have its backing
> storage in a VFIO device region. Therefore, we first need to figure
> out if the blob is backed by a VFIO device region or a memfd before
> we can call the right API to get a dmabuf fd created.
> 
> So, we first call virtio_gpu_create_udmabuf() which further calls
> ram_block_is_memfd_backed() to check if the blob's backing storage
> is located in a memfd or not. If it is not, we call vfio_create_dmabuf()
> which identifies the right VFIO device and eventually invokes the
> API vfio_device_create_dmabuf_fd() to have a dmabuf fd created.
> 
> Note that in virtio_gpu_remap_dmabuf(), we first try to test if
> the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> use the VFIO device fd directly to create the CPU mapping.
> 
> While at it, remove the unnecessary rcu_read_lock/rcu_read_unlock
> from virtio_gpu_create_udmabuf().
> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   hw/display/Kconfig             |   5 ++
>   hw/display/virtio-gpu-dmabuf.c | 122 ++++++++++++++++++++++++++++++---
>   2 files changed, 119 insertions(+), 8 deletions(-)
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
> index 258c48d31b..d121a2c9a7 100644
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
> @@ -40,10 +41,42 @@ static bool ram_block_is_memfd_backed(RAMBlock *rb)
>       return false;
>   }
>   
> +static void vfio_create_dmabuf(struct virtio_gpu_simple_resource *res)
> +{
> +#if defined(VIRTIO_GPU_VFIO_BLOB)
> +    VFIODevice *vbasedev;
> +    RAMBlock *first_rb;
> +    ram_addr_t offset;
> +
> +    first_rb = qemu_ram_block_from_host(res->iov[0].iov_base, false, &offset);
> +    if (!first_rb) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Could not find ramblock\n", __func__);
> +        return;
> +    }
> +
> +    vbasedev = vfio_device_lookup(first_rb->mr);
> +    if (!vbasedev) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: No VFIO device found to create dmabuf from\n",
> +                      __func__);
> +        return;
> +    }
> +
> +    res->dmabuf_fd = vfio_device_create_dmabuf_fd(vbasedev,
> +                                                  res->iov, res->iov_cnt);
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
> -    RAMBlock *rb;
> +    RAMBlock *rb, *first_rb;
>       ram_addr_t offset;
>       int udmabuf, i;
>   
> @@ -52,15 +85,17 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
>           return;
>       }
>   
> +    first_rb = qemu_ram_block_from_host(res->iov[0].iov_base, false, &offset);
> +    if (!ram_block_is_memfd_backed(first_rb)) {
> +        return;
> +    }
> +

We had an extensive discussion but I still don't understand the benefit 
of this change while I see it adds complexity by having another call of 
qemu_ram_block_from_host() and imposing an extra restriction that all 
elements need to belong to one RAMBlock.

If anyone else have some opinion on this, I'd like to hear.

Regards,
Akihiko Odaki

>       list = g_malloc0(sizeof(struct udmabuf_create_list) +
>                        sizeof(struct udmabuf_create_item) * res->iov_cnt);
>   
>       for (i = 0; i < res->iov_cnt; i++) {
> -        rcu_read_lock();
>           rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
> -        rcu_read_unlock();
> -
> -        if (!rb || rb->fd < 0) {
> +        if (rb != first_rb) {
>               g_free(list);
>               return;
>           }
> @@ -81,11 +116,77 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
>       g_free(list);
>   }
>   
> +static void *vfio_dmabuf_mmap(struct virtio_gpu_simple_resource *res)
> +{
> +    struct vfio_region_info *info = NULL;
> +    VFIODevice *vbasedev = NULL;
> +    ram_addr_t offset, len = 0;
> +    RAMBlock *first_rb, *rb;
> +    void *map, *submap;
> +    int i, ret = -1;
> +
> +    first_rb = qemu_ram_block_from_host(res->iov[0].iov_base, false, &offset);
> +    if (!first_rb) {
> +        return MAP_FAILED;
> +    }
> +#if defined(VIRTIO_GPU_VFIO_BLOB)
> +    vbasedev = vfio_device_lookup(first_rb->mr);
> +#endif
> +    if (!vbasedev) {
> +        return MAP_FAILED;
> +    }
> +
> +    /*
> +     * We first reserve a contiguous chunk of address space for the entire
> +     * dmabuf, then replace it with smaller mappings that correspond to the
> +     * individual segments of the dmabuf.
> +     */
> +    map = mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED, vbasedev->fd, 0);
> +    if (map == MAP_FAILED) {
> +        return map;
> +    }
> +
> +    for (i = 0; i < res->iov_cnt; i++) {
> +        rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
> +        if (rb != first_rb) {
> +            goto err;
> +        }
> +#if defined(VIRTIO_GPU_VFIO_BLOB)
> +        ret = vfio_get_region_index_from_mr(rb->mr);
> +        if (ret < 0) {
> +            goto err;
> +        }
> +
> +        ret = vfio_device_get_region_info(vbasedev, ret, &info);
> +#endif
> +        if (ret < 0 || !info) {
> +            goto err;
> +        }
> +
> +        submap = mmap(map + len, res->iov[i].iov_len, PROT_READ,
> +                      MAP_SHARED | MAP_FIXED, vbasedev->fd,
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
>   static void virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource *res)
>   {
>       res->remapped = mmap(NULL, res->blob_size, PROT_READ,
>                            MAP_SHARED, res->dmabuf_fd, 0);
>       if (res->remapped == MAP_FAILED) {
> +        res->remapped = vfio_dmabuf_mmap(res);
> +        if (res->remapped != MAP_FAILED) {
> +            return;
> +        }
>           warn_report("%s: dmabuf mmap failed: %s", __func__,
>                       strerror(errno));
>           res->remapped = NULL;
> @@ -146,6 +247,13 @@ void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
>       } else {
>           virtio_gpu_create_udmabuf(res);
>           if (res->dmabuf_fd < 0) {
> +            vfio_create_dmabuf(res);
> +        }
> +
> +        if (res->dmabuf_fd < 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: memory region cannot be used to create dmabuf\n",
> +                          __func__);
>               return;
>           }
>           virtio_gpu_remap_dmabuf(res);
> @@ -160,9 +268,7 @@ void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
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


