Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63E2D6CFDC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 06:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjAqQ-0005Cr-QT; Fri, 23 Jan 2026 01:40:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vjAqO-0005By-86
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 01:40:32 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vjAqK-000533-UC
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 01:40:31 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60N6eKYT015269
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 23 Jan 2026 15:40:22 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=0a35ZzjdNmJUYI5vfIqTYykzMDt8NFX8C0u52bmUh3I=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1769150422; v=1;
 b=qvDS718Bw+xPVtRRzxT/j+dmS1PMvUj2FmCQBbtxkoLZyJDjl668Qem03p2ssD5X
 kLnQR4WU0SRZB3XPMK63jb42mOvjkp7vWFHrphXcV2A47MUx42ZIZ0LyuZs4q3sF
 xgOD7LBZOiRTzUsH3rXQs7A0Xgh5TsFWMTbB1lFu1o6E+urd3F5aLIAMdhjr2lnK
 AY96SBgmyTkLDlWIRX102Uu0nvzx2179f0RYxXldqGUYDseI9fffUBx9BrY58k4D
 FendYL909yy3Ke5efGCR12rrEWjcP3lv9qoyPhg80mxdaoFeZQi2AAklWvNSkkrK
 ohI7Z/a/CSAvCH37S5g+jQ==
Message-ID: <ef2f5779-a23b-44dc-b467-0da00e6b1243@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 23 Jan 2026 15:40:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260123062042.568703-1-vivek.kasireddy@intel.com>
 <20260123062042.568703-9-vivek.kasireddy@intel.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260123062042.568703-9-vivek.kasireddy@intel.com>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/01/23 15:17, Vivek Kasireddy wrote:
> In addition to memfd, a blob resource can also have its backing
> storage in a VFIO device region. Since, there is no effective way
> to determine where the backing storage is located, we first try to
> create a dmabuf assuming it is in memfd. If that fails, we try to
> create a dmabuf assuming it is in VFIO device region.
> 
> So, we first call virtio_gpu_create_udmabuf() to check if the blob's
> backing storage is located in a memfd or not. If it is not, we call
> vfio_create_dmabuf() which identifies the right VFIO device and
> eventually invokes the vfio_device_create_dmabuf_fd() API to have
> a dmabuf fd created.
> 
> Note that in virtio_gpu_remap_dmabuf(), we first try to test if
> the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> use the VFIO device fd directly to create the CPU mapping.
> 
> While at it, remove the unnecessary rcu_read_lock/rcu_read_unlock
> from virtio_gpu_create_udmabuf() and also replace warn_report()
> with qemu_log_mask().
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
>   hw/display/virtio-gpu-dmabuf.c | 117 ++++++++++++++++++++++++++++++---
>   2 files changed, 113 insertions(+), 9 deletions(-)
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
> index c34d4c85bc..2dfe70d7eb 100644
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
> @@ -27,6 +28,38 @@
>   #include "standard-headers/linux/udmabuf.h"
>   #include "standard-headers/drm/drm_fourcc.h"
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

This API design of vfio_device_create_dmabuf_fd() has some room of 
improvements.

First, this function requires to pass VFIODevice * which is derived from 
res->iov[0]. Since it is getting res->iov[0] anyway, such a parameter is 
redundant. vfio_device_create_dmabuf_fd() can call vfio_device_lookup() 
itself instead.

The second problem is the error handling. The error may not be caused by 
VFIO_DEVICE_FEATURE_DMA_BUF but may be caused by the guest passing 
regions that do not belong to one VFIO device. The two cases should be 
distinguished for a correct message.

> +#endif
> +}
> +
>   static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
>   {
>       struct udmabuf_create_list *list;
> @@ -43,10 +76,7 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
>                        sizeof(struct udmabuf_create_item) * res->iov_cnt);
>   
>       for (i = 0; i < res->iov_cnt; i++) {
> -        rcu_read_lock();
>           rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
> -        rcu_read_unlock();
> -
>           if (!rb || rb->fd < 0) {
>               g_free(list);
>               return;
> @@ -62,17 +92,84 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
>   
>       res->dmabuf_fd = ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
>       if (res->dmabuf_fd < 0) {
> -        warn_report("%s: UDMABUF_CREATE_LIST: %s", __func__,
> -                    strerror(errno));
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: UDMABUF_CREATE_LIST: %s\n",
> +                      __func__, strerror(errno));
>       }
>       g_free(list);
>   }

These changes of virtio_gpu_create_udmabuf() are independent so should 
go into separate patches with explanation.

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

It should have PROT_NONE instead of PROT_READ to prevent accidental 
accesses to the placeholder mapping.
Likewise, -1 should be passed instead of vbasedev->fd so that the 
placeholder mapping won't result in a mapping to real device.

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

This function can take rb->mr and call vfio_device_lookup() and 
vfio_get_region_index_from_mr() internally to simplify the API as 
similar can be done for vfio_device_create_dmabuf_fd().

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
> @@ -139,8 +236,12 @@ void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
>       } else {
>           virtio_gpu_create_udmabuf(res);
>           if (res->dmabuf_fd < 0) {
> -            return;
> +            vfio_create_dmabuf(res);
> +            if (res->dmabuf_fd < 0) {
> +                return;
> +            }
>           }
> +
>           virtio_gpu_remap_dmabuf(res);
>           if (!res->remapped) {
>               return;
> @@ -153,9 +254,7 @@ void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
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


