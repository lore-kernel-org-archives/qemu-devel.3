Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E24CF6A80
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 08:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdlNC-0006s1-On; Thu, 08 Jan 2026 03:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vdlN8-0006pq-8L
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 03:27:58 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vdlN5-00048Y-6r
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 03:27:58 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6088RLni053125
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 8 Jan 2026 17:27:23 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=K3EbJJaipXU9ivTnjFtr9gCEY+XFN5f9eyS2HZMAAu0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1767860843; v=1;
 b=sw9+JH9MWfBz8kivcVIuq10tTPbJqUtE54iqBrVTg4/HOYTtzCmlV1ite0P0/EFv
 dTAC4jDxpBoKhOXJDtlnAk8ZyEfHsuT0Or2b/jQdoGdUF7rRKYcdPSTMGBfO3e4x
 zFlc2fuy6YKhOL4tVqWDEMVSYGwDWL9DNSJXG/PUuoAn8dB04eKYuwn3m+NsVPy6
 AB4xbVd1ieX4eLcOHcKX9BC9zxvTkizgRuQDz9FPlBNDkKAOaCuQ5c1rStRKr7Pk
 4RAADq1f4a3DklAJfjVGl3JdQIwBSV5o5IW1R9ndgQtQonwY9gMbkhjfCvTOk4lr
 celQL6Vd5UWvj3PYN4yXew==
Message-ID: <a0eda677-55f4-4588-896b-58b7afbee9b4@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 8 Jan 2026 17:27:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v8 3/4] virtio-gpu: Destroy virgl resources on
 virtio-gpu reset
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
References: <20260108061146.95497-1-dmitry.osipenko@collabora.com>
 <20260108061146.95497-4-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260108061146.95497-4-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2026/01/08 15:11, Dmitry Osipenko wrote:
> Properly destroy virgl resources on virtio-gpu reset to not leak resources
> on a hot reboot of a VM.
> 
> Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   hw/display/virtio-gpu-gl.c     |  18 +-----
>   hw/display/virtio-gpu-virgl.c  | 115 +++++++++++++++++++++++++++------
>   include/hw/virtio/virtio-gpu.h |   6 +-
>   3 files changed, 101 insertions(+), 38 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index b941e9a4b789..8b71dd6fc26f 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -63,29 +63,14 @@ static void virtio_gpu_gl_flushed(VirtIOGPUBase *b)
>   static void virtio_gpu_gl_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
>   {
>       VirtIOGPU *g = VIRTIO_GPU(vdev);
> -    VirtIOGPUGL *gl = VIRTIO_GPU_GL(vdev);
>       struct virtio_gpu_ctrl_command *cmd;
>   
>       if (!virtio_queue_ready(vq)) {
>           return;
>       }
>   
> -    switch (gl->renderer_state) {
> -    case RS_RESET:
> -        virtio_gpu_virgl_reset(g);
> -        /* fallthrough */
> -    case RS_START:
> -        if (virtio_gpu_virgl_init(g)) {
> -            gl->renderer_state = RS_INIT_FAILED;
> -            return;
> -        }
> -
> -        gl->renderer_state = RS_INITED;
> -        break;
> -    case RS_INIT_FAILED:
> +    if (!virtio_gpu_virgl_update_render_state(g)) {
>           return;
> -    case RS_INITED:
> -        break;
>       }
>   
>       cmd = virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_command));
> @@ -201,6 +186,7 @@ static void virtio_gpu_gl_class_init(ObjectClass *klass, const void *data)
>       vgc->process_cmd = virtio_gpu_virgl_process_cmd;
>       vgc->update_cursor_data = virtio_gpu_gl_update_cursor_data;
>   
> +    vgc->resource_destroy = virtio_gpu_virgl_resource_destroy;
>       vdc->realize = virtio_gpu_gl_device_realize;
>       vdc->unrealize = virtio_gpu_gl_device_unrealize;
>       vdc->reset = virtio_gpu_gl_reset;
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 6a2aac0b6e5c..867cb43ea2a8 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -80,10 +80,41 @@ to_hostmem_region(MemoryRegion *mr)
>       return container_of(mr, struct virtio_gpu_virgl_hostmem_region, mr);
>   }
>   
> +bool virtio_gpu_virgl_update_render_state(VirtIOGPU *g)
> +{
> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
> +
> +    switch (gl->renderer_state) {
> +    case RS_RESET:
> +        if (virtio_gpu_virgl_reset(g)) {
> +            return false;
> +        }
> +        /* fallthrough */
> +    case RS_START:
> +        if (virtio_gpu_virgl_init(g)) {
> +            gl->renderer_state = RS_INIT_FAILED;
> +            return false;
> +        }
> +
> +        gl->renderer_state = RS_INITED;
> +        break;
> +    case RS_INIT_FAILED:
> +        return false;
> +    case RS_INITED:
> +        break;
> +    }
> +
> +    return true;
> +}
> +
>   static void virtio_gpu_virgl_resume_cmdq_bh(void *opaque)
>   {
>       VirtIOGPU *g = opaque;
>   
> +    if (!virtio_gpu_virgl_update_render_state(g)) {
> +        return;
> +    }
> +
>       virtio_gpu_process_cmdq(g);
>   }
>   
> @@ -304,14 +335,46 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
>       virgl_renderer_resource_create(&args, NULL, 0);
>   }
>   
> +static int
> +virtio_gpu_virgl_resource_unref(VirtIOGPU *g,
> +                                struct virtio_gpu_virgl_resource *res,
> +                                bool *suspended)
> +{
> +    struct iovec *res_iovs = NULL;
> +    int num_iovs = 0;
> +#if VIRGL_VERSION_MAJOR >= 1
> +    int ret;
> +
> +    ret = virtio_gpu_virgl_unmap_resource_blob(g, res, suspended);
> +    if (ret) {
> +        return ret;
> +    }
> +    if (*suspended) {
> +        return 0;
> +    }
> +#endif
> +
> +    virgl_renderer_resource_detach_iov(res->base.resource_id,
> +                                       &res_iovs,
> +                                       &num_iovs);
> +    if (res_iovs != NULL && num_iovs != 0) {
> +        virtio_gpu_cleanup_mapping_iov(g, res_iovs, num_iovs);
> +    }
> +    virgl_renderer_resource_unref(res->base.resource_id);
> +
> +    QTAILQ_REMOVE(&g->reslist, &res->base, next);
> +
> +    g_free(res);
> +
> +    return 0;
> +}
> +
>   static void virgl_cmd_resource_unref(VirtIOGPU *g,
>                                        struct virtio_gpu_ctrl_command *cmd,
>                                        bool *cmd_suspended)
>   {
>       struct virtio_gpu_resource_unref unref;
>       struct virtio_gpu_virgl_resource *res;
> -    struct iovec *res_iovs = NULL;
> -    int num_iovs = 0;
>   
>       VIRTIO_GPU_FILL_CMD(unref);
>       trace_virtio_gpu_cmd_res_unref(unref.resource_id);
> @@ -324,27 +387,21 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
>           return;
>       }
>   
> -#if VIRGL_VERSION_MAJOR >= 1
> -    if (virtio_gpu_virgl_unmap_resource_blob(g, res, cmd_suspended)) {
> -        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
> -        return;
> -    }
> -    if (*cmd_suspended) {
> -        return;
> -    }
> -#endif
> +    virtio_gpu_virgl_resource_unref(g, res, cmd_suspended);
> +}
>   
> -    virgl_renderer_resource_detach_iov(unref.resource_id,
> -                                       &res_iovs,
> -                                       &num_iovs);
> -    if (res_iovs != NULL && num_iovs != 0) {
> -        virtio_gpu_cleanup_mapping_iov(g, res_iovs, num_iovs);
> -    }
> -    virgl_renderer_resource_unref(unref.resource_id);
> +void virtio_gpu_virgl_resource_destroy(VirtIOGPU *g,
> +                                       struct virtio_gpu_simple_resource *base,
> +                                       Error **errp)
> +{
> +    struct virtio_gpu_virgl_resource *res;
> +    bool suspended = false;
>   
> -    QTAILQ_REMOVE(&g->reslist, &res->base, next);
> +    res = container_of(base, struct virtio_gpu_virgl_resource, base);
>   
> -    g_free(res);
> +    if (virtio_gpu_virgl_resource_unref(g, res, &suspended)) {
> +        error_setg(errp, "failed to destroy virgl resource");
> +    }
>   }
>   
>   static void virgl_cmd_context_create(VirtIOGPU *g,
> @@ -1273,11 +1330,27 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
>       }
>   }
>   
> -void virtio_gpu_virgl_reset(VirtIOGPU *g)
> +int virtio_gpu_virgl_reset(VirtIOGPU *g)
>   {
> +    struct virtio_gpu_simple_resource *res, *tmp;
> +
> +    /*
> +     * Virgl blob resource unmapping can be suspended and
> +     * deferred on unref, ensure that destruction is completed.
> +     */
> +    QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
> +        virtio_gpu_virgl_resource_destroy(g, res, NULL);
> +    }
> +
> +    if (!QTAILQ_EMPTY(&g->reslist)) {
> +        return -EBUSY;
> +    }
> +
>       virgl_renderer_reset();
>   
>       virtio_gpu_virgl_reset_async_fences(g);
> +
> +    return 0;
>   }
>   
>   int virtio_gpu_virgl_init(VirtIOGPU *g)
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 718332284305..a0d83943b6ad 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -389,9 +389,13 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>                                     struct virtio_gpu_ctrl_command *cmd);
>   void virtio_gpu_virgl_fence_poll(VirtIOGPU *g);
>   void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);
> -void virtio_gpu_virgl_reset(VirtIOGPU *g);
> +int virtio_gpu_virgl_reset(VirtIOGPU *g);
>   int virtio_gpu_virgl_init(VirtIOGPU *g);
>   GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g);
>   void virtio_gpu_virgl_reset_async_fences(VirtIOGPU *g);
> +void virtio_gpu_virgl_resource_destroy(VirtIOGPU *g,
> +                                       struct virtio_gpu_simple_resource *res,
> +                                       Error **errp);
> +bool virtio_gpu_virgl_update_render_state(VirtIOGPU *g);

virtio_gpu_virgl_update_render_state() and virtio_gpu_virgl_reset() 
return values basically for the same purpose, but the values are 
different, and I find it confusing. Personally I prefer both to have bool.

>   
>   #endif


