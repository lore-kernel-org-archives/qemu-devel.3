Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8E8CD4F3A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 02:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJNSt-0008LN-7a; Wed, 12 Nov 2025 21:53:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vJNSM-0008Cx-JG
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 21:53:13 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vJNSH-0007NJ-NW
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 21:53:05 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5AD2qZap059579
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 13 Nov 2025 11:52:35 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=L93XjfXO5ZpAlphrs73s0ZlhfzmpL3Vw6Zui2AZl7Kc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1763002355; v=1;
 b=Wlu4NYCgOmulSwYxRJhg0F2Ou6s9yGZcLSAb3eXExPbMh1WLnTn5g0YGvZCo23Ea
 MwlY+cJayxjyZMXzPcC1ebo6uyxOl49htmWzZja745cvSwevXCSACI8csOjRB2am
 1mJOrm5jZ0bW/IU8X3xq1hCSIRJoNrvMQ+3VTJc8JUTrLB7FZbAyYMrEceHgtWGT
 1KhFx0HNwwP54KIuTIPOlBcHCDEupJKt/1p37WOtt4Z36RCCmjM4xopFr1TPWJpq
 0cE2I4i9VQWmlXrCvjqkggJ/+2IuIESh5Q/zsC61ANAJq8IqdQrRJoR4BR9+xKp6
 SVKSntuRPhoWgndP+rwJsw==
Message-ID: <4eceb841-8767-4d70-91b1-f6288e6f8a22@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 13 Nov 2025 11:52:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/1] virtio-gpu: Support mapping hostmem blobs with
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
References: <20251112233118.1475381-1-dmitry.osipenko@collabora.com>
 <20251112233118.1475381-2-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251112233118.1475381-2-dmitry.osipenko@collabora.com>
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

On 2025/11/13 8:31, Dmitry Osipenko wrote:
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
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   hw/display/virtio-gpu-gl.c     | 37 +++++++++++++++++
>   hw/display/virtio-gpu-virgl.c  | 72 +++++++++++++++++++++++++++++++++-
>   include/hw/virtio/virtio-gpu.h |  3 ++
>   3 files changed, 110 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index b640900fc6f1..e1481291948a 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -122,6 +122,9 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
>   {
>       ERRP_GUARD();
>       VirtIOGPU *g = VIRTIO_GPU(qdev);
> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
> +    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);

Nitpick: this order is slightly odd as VirtIOGPUBase is the base class 
of VirtIOGPU and VirtIOGPUGL. So let's do:

VirtIOGPUBase *b = VIRTIO_GPU_BASE(qdev); // super class of b
VirtIOGPU *g = VIRTIO_GPU(qdev); // base class of gl
VirtIOGPUGL *gl = VIRTIO_GPU_GL(qdev);

Arguments are unified to qdev for consistency with other functions.

> +    void *map;
>   
>   #if HOST_BIG_ENDIAN
>       error_setg(errp, "virgl is not supported on bigendian platforms");
> @@ -152,6 +155,31 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
>   #endif
>   
>       virtio_gpu_device_realize(qdev, errp);
> +
> +    /*
> +     * Check whether virtio_gpu_device_realize() failed.
> +     */
> +    if (!g->ctrl_bh) {

Instead, do:
if (*errp) {
     return;
}

With this change it is clear that it checks whether 
virtio_gpu_device_realize() failed so the comment will be unnecessary.

> +        return;
> +    }
> +
> +    if (virtio_gpu_hostmem_enabled(b->conf)) {
> +        map = mmap(NULL, b->conf.hostmem, PROT_NONE,
> +                   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

I think you need to check CONFIG_WIN32.

> +        if (map == MAP_FAILED) {
> +            error_setg(errp,
> +                       "virgl hostmem region could not be initialized: %s",
> +                       strerror(errno));
> +            return;
> +        }
> +
> +        gl->hostmem_mmap = map;
> +        gl->hostmem_mr = g_new0(MemoryRegion, 1);

Having "b->hostmem" and "gl->hostmem_mr" is rather confusing.

> +        memory_region_init_ram_ptr(gl->hostmem_mr, NULL, "hostmem-anon",

"anon" is misleading because virgl_renderer_resource_map_fixed() will 
map non-anonymous pages.

Looking for an alternative word, I found docs/devel/memory.rst refers 
this kind of memory region as "background".

> +                                   b->conf.hostmem, gl->hostmem_mmap);
> +        memory_region_add_subregion(&b->hostmem, 0, gl->hostmem_mr);
> +        memory_region_set_enabled(gl->hostmem_mr, true);

Calling memory_region_set_enabled() is unnecessary. I failed to point 
out this for commit 7c092f17ccee ("virtio-gpu: Handle resource blob 
commands")...

> +    }
>   }
>   
>   static const Property virtio_gpu_gl_properties[] = {
> @@ -167,6 +195,7 @@ static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
>   {
>       VirtIOGPU *g = VIRTIO_GPU(qdev);
>       VirtIOGPUGL *gl = VIRTIO_GPU_GL(qdev);
> +    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
>   
>       if (gl->renderer_state >= RS_INITED) {
>   #if VIRGL_VERSION_MAJOR >= 1
> @@ -187,6 +216,14 @@ static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
>       gl->renderer_state = RS_START;
>   
>       g_array_unref(g->capset_ids);
> +
> +    if (gl->hostmem_mr) {
> +        memory_region_set_enabled(gl->hostmem_mr, false);

This memory_region_set_enabled() is unnecessary either.

> +        memory_region_del_subregion(&b->hostmem, gl->hostmem_mr);
> +    }
> +    if (gl->hostmem_mmap) {
> +        munmap(gl->hostmem_mmap, b->conf.hostmem);
> +    }

Please remove munmap(). It is not guaranteed that the memory region will 
be finalized immediately with memory_region_del_subregion(), so there 
can be a remaining reference to gl->hostmem_mmap.

virtio-gpu is not hotpluggable so you don't have to worry about memory 
leaks.

>   }
>   
>   static void virtio_gpu_gl_class_init(ObjectClass *klass, const void *data)
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 5c9a9ee84392..d4188cf1d6b2 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -21,6 +21,7 @@
>   #include "hw/virtio/virtio-gpu-pixman.h"
>   
>   #include "ui/egl-helpers.h"
> +#include <stdio.h>
>   
>   #include <virglrenderer.h>
>   
> @@ -44,6 +45,7 @@
>   struct virtio_gpu_virgl_resource {
>       struct virtio_gpu_simple_resource base;
>       MemoryRegion *mr;
> +    void *map_fixed;
>   };
>   
>   static struct virtio_gpu_virgl_resource *
> @@ -116,6 +118,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>   {
>       struct virtio_gpu_virgl_hostmem_region *vmr;
>       VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
>       MemoryRegion *mr;
>       uint64_t size;
>       void *data;
> @@ -126,6 +129,40 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>           return -EOPNOTSUPP;
>       }
>   
> +#if VIRGL_CHECK_VERSION(1, 2, 1) && !defined(_WIN32)

Check CONFIG_WIN32 instead. scripts/checkpatch.pl has the following code:
# check of hardware specific defines
# we have e.g. CONFIG_LINUX and CONFIG_WIN32 for common cases
# where they might be necessary.
		if ($line =~ m@^.\s*\#\s*if.*\b__@) {
			WARN("architecture specific defines should be avoided\n" .  $herecurr);
		}

This combination of VIRGL_CHECK_VERSION(1, 2, 1) && 
!defined(CONFIG_WIN32) is rather frequent so perhaps defining a macro 
for this may be useful.

> +    /*
> +     * virgl_renderer_resource_map_fixed() allows to create multiple
> +     * mappings of the same resource, while virgl_renderer_resource_map()
> +     * not.
> +     */
> +    if (res->map_fixed || res->mr) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: failed to map(fixed) virgl resource: already mapped\n",
> +                      __func__);
> +        return -EBUSY;
> +    }
> +
> +    /*
> +     * -EOPNOTSUPP is returned if MAP_FIXED unsupported by this resource,
> +     * mapping falls back to a blob subregion method in that case.
> +     */
> +    ret = virgl_renderer_resource_map_fixed(res->base.resource_id,
> +                                            gl->hostmem_mmap + offset);
> +    if (ret && ret != -EOPNOTSUPP) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: failed to map(fixed) virgl resource: %s\n",
> +                      __func__, strerror(-ret));
> +        return ret;
> +    }
> +
> +    if (ret == 0) {
> +        fprintf(stderr, "virgl_renderer_resource_map_fixed\n");

I guess you forgot removing a debug log.

> +
> +        res->map_fixed = gl->hostmem_mmap + offset;
> +        return 0;
> +    }

I would restructure these statements as follows:

ret = virgl_renderer_resource_map_fixed(...);
switch (ret) {
case 0:
     ...
     return 0;

case -EOPNOTSUPP:
     /*
      * -MAP_FIXED is unsupported by this resource.
      * Mapping falls back to a blob subregion method in that case.
      */
     break;

default:
     ...
     return ret;
}

...so that you don't need to check ret before checking
ret != -EOPNOTSUPP and what case the comment on the fallback applies.

> +#endif
> +
>       ret = virgl_renderer_resource_map(res->base.resource_id, &data, &size);
>       if (ret) {
>           qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map virgl resource: %s\n",
> @@ -138,7 +175,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>   
>       mr = &vmr->mr;
>       memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
> -    memory_region_add_subregion(&b->hostmem, offset, mr);
> +    memory_region_add_subregion(gl->hostmem_mr, offset, mr);

docs/devel/memory.rst says having a subregion in a RAM reion is not 
preferred. Instead, memory_region_add_subregion_overlap() should be used 
for hostmem_mr to make it "background".

>       memory_region_set_enabled(mr, true);
>   
>       /*
> @@ -163,9 +200,27 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
>   {
>       struct virtio_gpu_virgl_hostmem_region *vmr;
>       VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
>       MemoryRegion *mr = res->mr;
>       int ret;
>   
> +#if VIRGL_CHECK_VERSION(1, 2, 1) && !defined(_WIN32)
> +    if (res->map_fixed) {
> +        res->map_fixed = mmap(res->map_fixed, res->base.blob_size, PROT_NONE,
> +                              MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED,
> +                              -1, 0);
> +        if (res->map_fixed == MAP_FAILED) {
> +            ret = -errno;
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: failed to unmap(fixed) virgl resource: %s\n",
> +                          __func__, strerror(-ret));
> +            return ret;
> +        }
> +
> +        res->map_fixed = NULL;
> +    }
> +#endif
> +
>       if (!mr) {
>           return 0;
>       }
> @@ -202,7 +257,7 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
>   
>           /* memory region owns self res->mr object and frees it by itself */
>           memory_region_set_enabled(mr, false);
> -        memory_region_del_subregion(&b->hostmem, mr);
> +        memory_region_del_subregion(gl->hostmem_mr, mr);
>           object_unparent(OBJECT(mr));
>       }
>   
> @@ -1270,9 +1325,22 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
>   
>   void virtio_gpu_virgl_reset(VirtIOGPU *g)
>   {
> +#if VIRGL_CHECK_VERSION(1, 2, 1) && !defined(_WIN32)
> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
> +    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
> +#endif
> +
>       virgl_renderer_reset();
>   
>       virtio_gpu_virgl_reset_async_fences(g);
> +
> +#if VIRGL_CHECK_VERSION(1, 2, 1) && !defined(_WIN32)
> +    if (gl->hostmem_mmap &&
> +        mmap(gl->hostmem_mmap, b->conf.hostmem, PROT_NONE,
> +             MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0) == MAP_FAILED) {
> +        error_report("failed to reset virgl hostmem: %s", strerror(errno));
> +    }
> +#endif

I think this is better to be done before virgl_renderer_reset() to avoid 
having dangling pages after virgl_renderer_reset() and before this 
mmap() call.

Regards,
Akihiko Odaki

>   }
>   
>   int virtio_gpu_virgl_init(VirtIOGPU *g)
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 172f5ffce3ed..e1122edd6eeb 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -263,6 +263,9 @@ struct VirtIOGPUGL {
>   
>       QEMUBH *async_fence_bh;
>       QSLIST_HEAD(, virtio_gpu_virgl_context_fence) async_fenceq;
> +
> +    MemoryRegion *hostmem_mr;
> +    void *hostmem_mmap;
>   };
>   
>   struct VhostUserGPU {


