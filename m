Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF21D41D4D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 14:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vThoO-0008Cw-JB; Thu, 11 Dec 2025 09:38:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vThoL-0008B5-ST
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 09:38:29 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vThoI-0002Ud-Mm
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 09:38:29 -0500
Received: from [192.168.10.110] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5BBEbk6J028585
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 11 Dec 2025 23:37:57 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=7GKqKjY96Qg1kt+GQoHAKaeiuah2SI8n1qL0KfY3CnQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1765463878; v=1;
 b=CetxFttUAEO3Sw/tBJoCrME/vWL5gPO0wB2rPjF2OBb4OSH2kOGQc2Pq2YH113S1
 Qd61VXSgtT/q7//IARapijzDTbjOuS3bRpynupRyBO0twTdWnUYP5gd7QAfht/DY
 w8RqDQxKLoNVQYCICpSRBGMcFP9kAGAvjK7QmwIO0CnxitJnuZ9px1HDdCuO1nLM
 F1bJ6uXiEIyzYNYt9BHXZLd6FZdkNWyiXZNPqywbDcLBll3xG5rDoX9TY58effxI
 7x6wXE4p+mF3Ee8D4hGy1ZXjZhfK8s2yjdeh3dExLr71B4FkNtuegkAnJxxhKVVZ
 O040cQ43cgtcePw4aB+S9Q==
Message-ID: <571f61ab-84a6-484e-9951-9b4275525834@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 11 Dec 2025 23:37:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v7 3/4] virtio-gpu: Destroy virgl resources on
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
References: <20251208214056.349645-1-dmitry.osipenko@collabora.com>
 <20251208214056.349645-4-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251208214056.349645-4-dmitry.osipenko@collabora.com>
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

On 2025/12/09 6:40, Dmitry Osipenko wrote:
> Properly destroy virgl resources on virtio-gpu reset to not leak resources
> on a hot reboot of a VM.
> 
> Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   hw/display/virtio-gpu-gl.c     |  5 +-
>   hw/display/virtio-gpu-virgl.c  | 84 +++++++++++++++++++++++++---------
>   include/hw/virtio/virtio-gpu.h |  5 +-
>   3 files changed, 71 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index b640900fc6f1..3726f5e33835 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -72,7 +72,9 @@ static void virtio_gpu_gl_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
>   
>       switch (gl->renderer_state) {
>       case RS_RESET:
> -        virtio_gpu_virgl_reset(g);
> +        if (virtio_gpu_virgl_reset(g)) {
> +            return;

I have just realized leaving gl->renderer_state to RS_RESET is not 
sufficient. virtio_gpu_virgl_resume_cmdq_bh() is called when the task is 
resumed, but it doesn't reach here. This code needs to be executed also 
when virtio_gpu_virgl_resume_cmdq_bh() is called.

Regards,
Akihiko Odaki

> +        }
>           /* fallthrough */
>       case RS_START:
>           if (virtio_gpu_virgl_init(g)) {
> @@ -201,6 +203,7 @@ static void virtio_gpu_gl_class_init(ObjectClass *klass, const void *data)
>       vgc->process_cmd = virtio_gpu_virgl_process_cmd;
>       vgc->update_cursor_data = virtio_gpu_gl_update_cursor_data;
>   
> +    vgc->resource_destroy = virtio_gpu_virgl_resource_destroy;
>       vdc->realize = virtio_gpu_gl_device_realize;
>       vdc->unrealize = virtio_gpu_gl_device_unrealize;
>       vdc->reset = virtio_gpu_gl_reset;
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 6a2aac0b6e5c..129eb51a47a5 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -304,14 +304,46 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
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
> @@ -324,27 +356,21 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
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
> @@ -1273,11 +1299,27 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
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
> index 718332284305..9e1473d1bb66 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -389,9 +389,12 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
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
>   
>   #endif


