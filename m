Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A595CF64B6
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 05:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLx09-0001i3-74; Thu, 20 Nov 2025 00:14:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vLx03-0001hU-8r
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 00:14:31 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vLx00-0004Y3-61
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 00:14:31 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5AK5E4CZ041084
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Nov 2025 14:14:04 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=w37MSjc7HtnFq3wXe/JBjoIkWbskjOhQjTkHznL90Rs=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1763615645; v=1;
 b=r6tPN7Jeex1VyUjSiRkGZ9St9ziTqYFzgPYqIQURd/J5eRzw8lOnXly40OBslCEl
 Y1QUblHv6NjzP9NMJiXnKuVrzfJpPPA+fbKPEONlaXFGCe6+dasNz4jXDs8JBsAk
 WgBLo4gfcLh4h/kQK2/zdPJ6rNI00Guk7vVCuyZDJ996BMreuLwV9L4lYVr1lNyL
 dPtwRDOGX9Cma3gk/K/s9WVnD8jCcoQuBfJfx/xFomvUTVHTOU3kOFH1TV/6i2vq
 VZ8u2SieDW5YPfBggTe5NgJmQY+gh7JpMrjL4cBSKIHbgmrwbzN7/BvHlCkW1rpJ
 fw3OI8zbCfE/RqJixJerZQ==
Message-ID: <0d9d5573-8ab8-42b4-ae1f-82e01b4f4fe3@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 20 Nov 2025 14:14:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 7/7] virtio-gpu: Support mapping hostmem blobs with
 map_fixed
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yiwei Zhang <zzyiwei@gmail.com>,
 Sergio Lopez Pascual <slp@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>,
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>,
 Rob Clark <robdclark@gmail.com>, Robert Beckett <bob.beckett@collabora.com>
References: <20251120040632.4036204-1-dmitry.osipenko@collabora.com>
 <20251120040632.4036204-8-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251120040632.4036204-8-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2025/11/20 13:06, Dmitry Osipenko wrote:
> Support mapping virgl blobs to a fixed location of a hostmem memory
> region using new virglrenderer MAP_FIXED API.
> 
> This new feature closes multiple problems for virtio-gpu on QEMU:
> 
> - Having dedicated memory region for each mapped blob works notoriously
> slow due to QEMU's memory region software design built around RCU that
> isn't optimized for frequent removal of the regions
> 
> - KVM isn't optimized for a frequent slot changes too
> 
> - QEMU/KVM has a limit for a total number of created memory regions,
> crashing QEMU when limit is reached
> 
> This patch makes virtio-gpu-gl to pre-create a single anonymous memory
> region covering whole hostmem area to which blobs will be mapped using
> the MAP_FIXED API.
> 
> Not all virgl resources will support mapping at a fixed memory address. For
> them, we will continue to create individual nested memory sub-regions. In
> particular, vrend resources may not have MAP_FIXED capability.
> 
> Venus and DRM native contexts will largely benefit from the MAP_FIXED
> feature in terms of performance and stability improvement.
> 
> Tested-by: Yiwei Zhang <zzyiwei@gmail.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   hw/display/virtio-gpu-gl.c     | 43 ++++++++++++++++++++++++-
>   hw/display/virtio-gpu-virgl.c  | 57 +++++++++++++++++++++++++++++++++-
>   include/hw/virtio/virtio-gpu.h |  3 ++
>   3 files changed, 101 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index d65da4863923..097f3ce4cb71 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -13,6 +13,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu/iov.h"
> +#include "qemu/mmap-alloc.h"
>   #include "qemu/module.h"
>   #include "qemu/error-report.h"
>   #include "qapi/error.h"
> @@ -124,7 +125,12 @@ static void virtio_gpu_gl_reset(VirtIODevice *vdev)
>   static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
>   {
>       ERRP_GUARD();
> -    VirtIOGPU *g = VIRTIO_GPU(qdev);
> +    VirtIOGPUBase *b = VIRTIO_GPU_BASE(qdev);
> +    VirtIOGPU *g = VIRTIO_GPU(b);
> +#if !defined(CONFIG_WIN32)
> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
> +    void *map;
> +#endif
>   
>   #if HOST_BIG_ENDIAN
>       error_setg(errp, "virgl is not supported on bigendian platforms");
> @@ -155,6 +161,30 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
>   #endif
>   
>       virtio_gpu_device_realize(qdev, errp);
> +
> +    /*
> +     * Check whether virtio_gpu_device_realize() failed.
> +     */

It is obvious so this comment is unnecessary.

> +    if (*errp) {
> +        return;
> +    }
> +
> +    if (virtio_gpu_hostmem_enabled(b->conf)) {
> +        map = qemu_ram_mmap(-1, b->conf.hostmem, qemu_real_host_page_size(),
> +                            0, 0);

qemu_ram_mmap() shouldn't be called if !defined(CONFIG_WIN32).

> +        if (map == MAP_FAILED) {
> +            error_setg(errp,
> +                       "virgl hostmem region could not be initialized: %s",
> +                       strerror(errno));
> +            return;
> +        }
> +
> +        gl->hostmem_mmap = map;
> +        memory_region_init_ram_ptr(&gl->hostmem_background, NULL,
> +                                   "hostmem-background", b->conf.hostmem,
> +                                   gl->hostmem_mmap);
> +        memory_region_add_subregion(&b->hostmem, 0, &gl->hostmem_background);
> +    }
>   }
>   
>   static const Property virtio_gpu_gl_properties[] = {
> @@ -190,6 +220,17 @@ static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
>       gl->renderer_state = RS_START;
>   
>       g_array_unref(g->capset_ids);
> +
> +    /*
> +     * It is not guaranteed that the memory region will be finalized
> +     * immediately with memory_region_del_subregion(), there can be
> +     * a remaining reference to gl->hostmem_mmap. VirtIO-GPU is not
> +     * hotpluggable, hence no need to worry about the leaked mapping.
> +     *
> +     * The memory_region_del_subregion(gl->hostmem_background) is unnecessary
> +     * because b->hostmem  and gl->hostmem_background belong to the same
> +     * device and will be gone at the same time.
> +     */
>   }
>   
>   static void virtio_gpu_gl_class_init(ObjectClass *klass, const void *data)
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 35201d629b9c..2bd0ed6227cf 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -41,9 +41,12 @@
>        VIRGL_VERSION_MICRO >= (micro))
>   #endif
>   
> +#define VIRGL_HAS_MAP_FIXED VIRGL_CHECK_VERSION(1, 2, 1)
> +
>   struct virtio_gpu_virgl_resource {
>       struct virtio_gpu_simple_resource base;
>       MemoryRegion *mr;
> +    void *map_fixed;
>   };
>   
>   static struct virtio_gpu_virgl_resource *
> @@ -116,6 +119,9 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>   {
>       struct virtio_gpu_virgl_hostmem_region *vmr;
>       VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
> +#if VIRGL_HAS_MAP_FIXED
> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
> +#endif
>       MemoryRegion *mr;
>       uint64_t size;
>       void *data;
> @@ -134,6 +140,41 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>           return -1;
>       }
>   
> +#if VIRGL_HAS_MAP_FIXED
> +    /*
> +     * virgl_renderer_resource_map_fixed() allows to create multiple
> +     * mappings of the same resource, while virgl_renderer_resource_map()
> +     * not. Don't allow mapping same resource twice.
> +     */
> +    if (res->map_fixed || res->mr) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: failed to map(fixed) virgl resource: already mapped\n",
> +                      __func__);
> +        return -1;
> +    }
> +
> +    ret = virgl_renderer_resource_map_fixed(res->base.resource_id,
> +                                            gl->hostmem_mmap + offset);
> +    switch (ret) {
> +    case 0:
> +        res->map_fixed = gl->hostmem_mmap + offset;
> +        return 0;
> +
> +    case -EOPNOTSUPP:
> +        /*
> +         * MAP_FIXED is unsupported by this resource.
> +         * Mapping falls back to a blob subregion method in that case.
> +         */
> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: failed to map(fixed) virgl resource: %s\n",
> +                      __func__, strerror(-ret));
> +        return -1;
> +    }
> +#endif
> +
>       ret = virgl_renderer_resource_map(res->base.resource_id, &data, &size);
>       if (ret) {
>           qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map virgl resource: %s\n",
> @@ -146,7 +187,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>   
>       mr = &vmr->mr;
>       memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
> -    memory_region_add_subregion(&b->hostmem, offset, mr);
> +    memory_region_add_subregion_overlap(&b->hostmem, offset, mr, 1);
>   
>       /*
>        * MR could outlive the resource if MR's reference is held outside of
> @@ -173,6 +214,20 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
>       MemoryRegion *mr = res->mr;
>       int ret;
>   
> +#if VIRGL_HAS_MAP_FIXED
> +    if (res->map_fixed) {
> +        if (mmap(res->map_fixed, res->base.blob_size, PROT_READ | PROT_WRITE,
> +                 MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED,
> +                 -1, 0) == MAP_FAILED) {
> +            error_report("%s: failed to unmap(fixed) virgl resource: %s",
> +                          __func__, strerror(errno));
> +            return -1;
> +        }
> +
> +        res->map_fixed = NULL;
> +    }
> +#endif
> +
>       if (!mr) {
>           return 0;
>       }
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 9e1473d1bb66..420c6e2a2515 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -263,6 +263,9 @@ struct VirtIOGPUGL {
>   
>       QEMUBH *async_fence_bh;
>       QSLIST_HEAD(, virtio_gpu_virgl_context_fence) async_fenceq;
> +
> +    MemoryRegion hostmem_background;
> +    void *hostmem_mmap;
>   };
>   
>   struct VhostUserGPU {


