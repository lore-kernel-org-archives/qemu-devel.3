Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D79CD4F3E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 03:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKpWm-0003JP-A9; Sun, 16 Nov 2025 22:03:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vKpWk-0003JA-R9
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 22:03:38 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vKpWh-00027P-I1
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 22:03:38 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5AH33Cxq085714
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 17 Nov 2025 12:03:12 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=HbQrLu6T8v3Obp6bmkrjdcapbpdJHBGbuV9wTq3BujQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:From:To;
 s=rs20250326; t=1763348592; v=1;
 b=SZAZ6Yb9upmfZXia2U0GHC82USyb82tC7cSw4VAt79fh9cMBBaftVxAGoiwdmIyd
 /zUud88W0VCXPIpwd37ppj/JXgJ3UrnwTvD4H6k63ubZYbKlb9M//DwD1WHl7Vth
 Qe+YXQNZBPaNTv3ax4R7j3zY6HtON2ReSg0XYOz9g+j3OqKYQFiiRktJe3uXL3mQ
 Ka+e+oEs7AiIvNlspqD+eL9Hy06I5mPUwFq3ruf6RZiy4k8CyFvnBHXl7pB+JH4D
 8xkaSUDLsf1lcAPiTtFwga6e44U+kLOH9NKvP/29OUhHMM/Bu0NCSdBVhjnZqPJV
 tki4E6v47091Pz3pFuXocg==
Message-ID: <a8d15805-5b9b-495b-8e4b-05b6f77ccf39@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 17 Nov 2025 12:03:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/2] virtio-gpu: Support mapping hostmem blobs with
 map_fixed
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
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
References: <20251116141427.2325372-1-dmitry.osipenko@collabora.com>
 <20251116141427.2325372-3-dmitry.osipenko@collabora.com>
 <75560c73-2b86-46a6-ad91-cc4a6de92e13@rsg.ci.i.u-tokyo.ac.jp>
 <09a59805-e2e3-42b5-93ac-cf866272a7c1@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
In-Reply-To: <09a59805-e2e3-42b5-93ac-cf866272a7c1@rsg.ci.i.u-tokyo.ac.jp>
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

Sorry for sending a reply again. I keep missing some code...

On 2025/11/17 11:53, Akihiko Odaki wrote:
> On 2025/11/17 10:57, Akihiko Odaki wrote:
>> On 2025/11/16 23:14, Dmitry Osipenko wrote:
>>> Support mapping virgl blobs to a fixed location of a hostmem memory
>>> region using new virglrenderer MAP_FIXED API.
>>>
>>> This new feature closes multiple problems for virtio-gpu on QEMU:
>>>
>>> - Having dedicated memory region for each mapped blob works notoriously
>>> slow due to QEMU's memory region software design built around RCU that
>>> isn't optimized for frequent removal of the regions
>>>
>>> - KVM isn't optimized for a frequent slot changes too
>>>
>>> - QEMU/KVM has a limit for a total number of created memory regions,
>>> crashing QEMU when limit is reached
>>>
>>> This patch makes virtio-gpu-gl to pre-create a single anonymous memory
>>> region covering whole hostmem area to which blobs will be mapped using
>>> the MAP_FIXED API.
>>>
>>> Not all virgl resources will support mapping at a fixed memory 
>>> address. For
>>> them, we will continue to create individual nested memory sub- 
>>> regions. In
>>> particular, vrend resources may not have MAP_FIXED capability.
>>>
>>> Venus and DRM native contexts will largely benefit from the MAP_FIXED
>>> feature in terms of performance and stability improvement.
>>>
>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> ---
>>>   hw/display/virtio-gpu-gl.c     | 45 ++++++++++++++++++++-
>>>   hw/display/virtio-gpu-virgl.c  | 74 +++++++++++++++++++++++++++++++++-
>>>   include/hw/virtio/virtio-gpu.h |  3 ++
>>>   3 files changed, 119 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
>>> index b640900fc6f1..23e0dd26c67b 100644
>>> --- a/hw/display/virtio-gpu-gl.c
>>> +++ b/hw/display/virtio-gpu-gl.c
>>> @@ -121,7 +121,12 @@ static void virtio_gpu_gl_reset(VirtIODevice *vdev)
>>>   static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error 
>>> **errp)
>>>   {
>>>       ERRP_GUARD();
>>> -    VirtIOGPU *g = VIRTIO_GPU(qdev);
>>> +    VirtIOGPUBase *b = VIRTIO_GPU_BASE(qdev);
>>> +    VirtIOGPU *g = VIRTIO_GPU(b);
>>> +#if !defined(CONFIG_WIN32)
>>> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
>>> +    void *map;
>>> +#endif
>>>   #if HOST_BIG_ENDIAN
>>>       error_setg(errp, "virgl is not supported on bigendian platforms");
>>> @@ -152,6 +157,33 @@ static void 
>>> virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
>>>   #endif
>>>       virtio_gpu_device_realize(qdev, errp);
>>> +
>>> +    /*
>>> +     * Check whether virtio_gpu_device_realize() failed.
>>> +     */
>>> +    if (*errp) {
>>> +        return;
>>> +    }
>>> +
>>> +#if !defined(CONFIG_WIN32)
>>> +    if (virtio_gpu_hostmem_enabled(b->conf)) {
>>
>> hostmem should be kept enabled for Windows. I don't have any reason to 
>> believe hostmem does not work on Windows.
>>
>>> +        map = mmap(NULL, b->conf.hostmem, PROT_READ | PROT_WRITE,
>>> +                   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>>
>> Use qemu_ram_mmap() that installs a guard page.
>>
>>> +        if (map == MAP_FAILED) {
>>> +            error_setg(errp,
>>> +                       "virgl hostmem region could not be 
>>> initialized: %s",
>>> +                       strerror(errno));
>>> +            return;
>>> +        }
>>> +
>>> +        gl->hostmem_mmap = map;
>>> +        gl->hostmem_background = g_new0(MemoryRegion, 1);
>>
>> Embed hostmem_background to VirtIOGPUGL and avoid having g_new0(), 
>> just like hostmem of VirtIOGPUBase.
>>
>>> +        memory_region_init_ram_ptr(gl->hostmem_background, NULL,
>>> +                                   "hostmem-background", b- 
>>> >conf.hostmem,
>>> +                                   gl->hostmem_mmap);
>>> +        memory_region_add_subregion(&b->hostmem, 0, gl- 
>>> >hostmem_background);
>>> +    }
>>> +#endif
>>>   }
>>>   static const Property virtio_gpu_gl_properties[] = {
>>> @@ -165,6 +197,7 @@ static const Property virtio_gpu_gl_properties[] = {
>>>   static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
>>>   {
>>> +    VirtIOGPUBase *b = VIRTIO_GPU_BASE(qdev);
>>>       VirtIOGPU *g = VIRTIO_GPU(qdev);
>>>       VirtIOGPUGL *gl = VIRTIO_GPU_GL(qdev);
>>> @@ -187,6 +220,16 @@ static void 
>>> virtio_gpu_gl_device_unrealize(DeviceState *qdev)
>>>       gl->renderer_state = RS_START;
>>>       g_array_unref(g->capset_ids);
>>> +
>>> +    /*
>>> +     * It is not guaranteed that the memory region will be finalized
>>> +     * immediately with memory_region_del_subregion(), there can be
>>> +     * a remaining reference to gl->hostmem_mmap. VirtIO-GPU is not
>>> +     * hotpluggable, hence no need to worry about the leaked mapping.
>>> +     */
>>> +    if (gl->hostmem_background) {
>>> +        memory_region_del_subregion(&b->hostmem, gl- 
>>> >hostmem_background);
>>> +    }
>>
>> This memory_region_del_subregion() is unnecessary because b->hostmem 
>> and gl->hostmem_background belong to the same device and will be gone 
>> at the same time.
>>
>>>   }
>>>   static void virtio_gpu_gl_class_init(ObjectClass *klass, const void 
>>> *data)
>>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu- 
>>> virgl.c
>>> index a6860f63b563..5a663ad2acfa 100644
>>> --- a/hw/display/virtio-gpu-virgl.c
>>> +++ b/hw/display/virtio-gpu-virgl.c
>>> @@ -41,9 +41,14 @@
>>>        VIRGL_VERSION_MICRO >= (micro))
>>>   #endif
>>> +#if VIRGL_CHECK_VERSION(1, 2, 1) && !defined(CONFIG_WIN32)
>>> +    #define VIRGL_HAS_MAP_FIXED
>>> +#endif
>>
>> Simpler:
>>
>> #define VIRGL_HAS_MAP_FIXED VIRGL_CHECK_VERSION(1, 2, 1) && ! 
>> IS_ENABLED(CONFIG_WIN32)
>>
>> And you can use it like:
>> #if VIRGL_HAS_MAP_FIXED
>>
>>> +
>>>   struct virtio_gpu_virgl_resource {
>>>       struct virtio_gpu_simple_resource base;
>>>       MemoryRegion *mr;
>>> +    void *map_fixed;
>>>   };
>>>   static struct virtio_gpu_virgl_resource *
>>> @@ -116,6 +121,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>>>   {
>>>       struct virtio_gpu_virgl_hostmem_region *vmr;
>>>       VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
>>> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
>>>       MemoryRegion *mr;
>>>       uint64_t size;
>>>       void *data;
>>> @@ -126,6 +132,41 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>>>           return -EOPNOTSUPP;
>>>       }
>>> +#ifdef VIRGL_HAS_MAP_FIXED
>>> +    /*
>>> +     * virgl_renderer_resource_map_fixed() allows to create multiple
>>> +     * mappings of the same resource, while 
>>> virgl_renderer_resource_map()
>>> +     * not. Don't allow mapping same resource twice.
>>> +     */
>>> +    if (res->map_fixed || res->mr) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>> +                      "%s: failed to map(fixed) virgl resource: 
>>> already mapped\n",
>>> +                      __func__);
>>> +        return -EBUSY;
>>> +    }
>>> +
>>> +    ret = virgl_renderer_resource_map_fixed(res->base.resource_id,
>>> +                                            gl->hostmem_mmap + offset);
>>
>> I think you need a boundary check here.
>>
>>> +    switch (ret) {
>>> +    case 0:
>>> +        res->map_fixed = gl->hostmem_mmap + offset;
>>> +        return 0;
>>> +
>>> +    case -EOPNOTSUPP:
>>> +        /*
>>> +         * -MAP_FIXED is unsupported by this resource.

s/-MAP_FIXED/MAP_FIXED/

>>> +         * Mapping falls back to a blob subregion method in that case.
>>> +         */
>>> +        break;
>>> +
>>> +    default:
>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>> +                      "%s: failed to map(fixed) virgl resource: %s\n",
>>> +                      __func__, strerror(-ret));
>>> +        return ret;
>>> +    }
>>> +#endif
>>> +
>>>       ret = virgl_renderer_resource_map(res->base.resource_id, &data, 
>>> &size);
>>>       if (ret) {
>>>           qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map virgl 
>>> resource: %s\n",
>>> @@ -138,7 +179,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>>>       mr = &vmr->mr;
>>>       memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
>>> -    memory_region_add_subregion(&b->hostmem, offset, mr);
>>> +    memory_region_add_subregion_overlap(gl->hostmem_background, 
>>> offset, mr, 1);
>>
>> This should be:
>> memory_region_add_subregion_overlap(&b->hostmem, offset, mr, 1);
>>
>>>       /*
>>>        * MR could outlive the resource if MR's reference is held 
>>> outside of
>>> @@ -162,9 +203,28 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
>>>   {
>>>       struct virtio_gpu_virgl_hostmem_region *vmr;
>>>       VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
>>> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
>>>       MemoryRegion *mr = res->mr;
>>>       int ret;
>>> +#ifdef VIRGL_HAS_MAP_FIXED
>>> +    if (res->map_fixed) {
>>> +        res->map_fixed = mmap(res->map_fixed, res->base.blob_size,
>>> +                              PROT_READ | PROT_WRITE,
>>> +                              MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED,
>>> +                              -1, 0);
>>> +        if (res->map_fixed == MAP_FAILED) {
>>> +            ret = -errno;
>>> +            qemu_log_mask(LOG_GUEST_ERROR,
>>> +                          "%s: failed to unmap(fixed) virgl 
>>> resource: %s\n",
>>> +                          __func__, strerror(-ret));

This should be reported with error_report() since this error cannot be 
triggered by the guest.

>>> +            return ret;
>>
>> This code path leaves the blob mapped but overwrites res->map_fixed 
>> with MAP_FAILED.
>>
>> Regards,
>> Akihiko Odaki
>>
>>> +        }
>>> +
>>> +        res->map_fixed = NULL;
>>> +    }
>>> +#endif
>>> +
>>>       if (!mr) {
>>>           return 0;
>>>       }
>>> @@ -200,7 +260,7 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
>>>           b->renderer_blocked++;
>>>           /* memory region owns self res->mr object and frees it by 
>>> itself */
>>> -        memory_region_del_subregion(&b->hostmem, mr);
>>> +        memory_region_del_subregion(gl->hostmem_background, mr);
>>>           object_unparent(OBJECT(mr));
>>>       }
>>> @@ -1265,6 +1325,16 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
>>>   void virtio_gpu_virgl_reset(VirtIOGPU *g)
>>>   {
>>> +#ifdef VIRGL_HAS_MAP_FIXED
>>> +    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
>>> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
>>> +
>>> +    if (gl->hostmem_mmap &&
>>> +        mmap(gl->hostmem_mmap, b->conf.hostmem, PROT_READ | PROT_WRITE,
>>> +             MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0) == 
>>> MAP_FAILED) {
>>> +        error_report("failed to reset virgl hostmem: %s", 
>>> strerror(errno));
>>> +    }
>>> +#endif
> 
> Please call virgl_cmd_resource_unref() instead to cover both fixed and 
> conventional mappings.
> 
> vgc->resource_destroy also needs to be overriden or resources will be 
> gone before reaching virtio_gpu_virgl_reset().
> 
>>>       virgl_renderer_reset();
>>>       virtio_gpu_virgl_reset_async_fences(g);
>>> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/ 
>>> virtio-gpu.h
>>> index 718332284305..bfe85a4e0449 100644
>>> --- a/include/hw/virtio/virtio-gpu.h
>>> +++ b/include/hw/virtio/virtio-gpu.h
>>> @@ -263,6 +263,9 @@ struct VirtIOGPUGL {
>>>       QEMUBH *async_fence_bh;
>>>       QSLIST_HEAD(, virtio_gpu_virgl_context_fence) async_fenceq;
>>> +
>>> +    MemoryRegion *hostmem_background;
>>> +    void *hostmem_mmap;
>>>   };
>>>   struct VhostUserGPU {
>>
> 


