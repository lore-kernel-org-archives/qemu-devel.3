Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21874CD4F3E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 05:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLwuP-0007ds-T8; Thu, 20 Nov 2025 00:08:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vLwuG-0007dY-8j
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 00:08:34 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vLwuB-00038b-8R
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 00:08:31 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5AK57uCW038561
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Nov 2025 14:07:57 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=+wCNk76i57smsbcl0hqpvqnTCJJ1/+WDBb7uELvSZtU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1763615277; v=1;
 b=s6XBMJDDItCDjTbdXTRwImwT3dZGzUL7KcrgOLxWt8pUJZUGPf50MNSKXYFCW3BY
 HbIxFXAClhdCTtMTL2Wowp6+c/XBsZW6XRkvntCBSSCpMHcoonWhwLPbJTcF2qQt
 yMZiTtR8X7YM8lt9BxlIkKrUJB84PWLZdVOdAPEJ6JFMGnH4eYnpNicP1/yNp01C
 23oOXK3TIDd1aj1VCnE4KQW89ojsoyTbacgXfxqWUl32ld9CTTDCsDzkH2249Ted
 AL4KWCu97fHiMiz3mQcgRP+/679rhZ/t9XbzEGERvnUidcoGyAXtptasLqrWNeiN
 tHFd4qkFnqYAdKhE8beGIw==
Message-ID: <94e92cb0-3e5a-48e3-bf3c-12d27c23c27f@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 20 Nov 2025 14:07:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 5/7] virtio-gpu: Destroy virgl resources on
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
References: <20251120040632.4036204-1-dmitry.osipenko@collabora.com>
 <20251120040632.4036204-6-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251120040632.4036204-6-dmitry.osipenko@collabora.com>
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
> Properly destroy virgl resources on virtio-gpu reset to not leak resources
> on a hot reboot of a VM.
> 
> Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   hw/display/virtio-gpu-gl.c     |  6 ++-
>   hw/display/virtio-gpu-virgl.c  | 79 +++++++++++++++++++++++++---------
>   include/hw/virtio/virtio-gpu.h |  5 ++-
>   3 files changed, 67 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index b640900fc6f1..bca7d489c1e3 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -72,7 +72,10 @@ static void virtio_gpu_gl_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
>   
>       switch (gl->renderer_state) {
>       case RS_RESET:
> -        virtio_gpu_virgl_reset(g);
> +        if (virtio_gpu_virgl_reset(g) < 0) {
> +            gl->renderer_state = RS_INIT_FAILED;
> +            return;
> +        }
>           /* fallthrough */
>       case RS_START:
>           if (virtio_gpu_virgl_init(g)) {
> @@ -201,6 +204,7 @@ static void virtio_gpu_gl_class_init(ObjectClass *klass, const void *data)
>       vgc->process_cmd = virtio_gpu_virgl_process_cmd;
>       vgc->update_cursor_data = virtio_gpu_gl_update_cursor_data;
>   
> +    vgc->resource_destroy = virtio_gpu_virgl_resource_destroy;
>       vdc->realize = virtio_gpu_gl_device_realize;
>       vdc->unrealize = virtio_gpu_gl_device_unrealize;
>       vdc->reset = virtio_gpu_gl_reset;
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index ae8de8ee47da..24d329022da9 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -311,14 +311,44 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
>       virgl_renderer_resource_create(&args, NULL, 0);
>   }
>   
> +static int
> +virtio_gpu_virgl_resource_unref(VirtIOGPU *g,
> +                                struct virtio_gpu_virgl_resource *res,
> +                                bool *cmd_suspended)
> +{
> +    struct iovec *res_iovs = NULL;
> +    int num_iovs = 0;
> +
> +#if VIRGL_VERSION_MAJOR >= 1
> +    if (virtio_gpu_virgl_unmap_resource_blob(g, res, cmd_suspended) < 0) {
> +        return -1;
> +    }
> +    if (*cmd_suspended) {
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
> @@ -331,27 +361,21 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
>           return;
>       }
>   
> -#if VIRGL_VERSION_MAJOR >= 1
> -    if (virtio_gpu_virgl_unmap_resource_blob(g, res, cmd_suspended) < 0) {
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
> +    if (virtio_gpu_virgl_resource_unref(g, res, &suspended) < 0) {
> +        error_setg(errp, "failed to destroy virgl resource");
> +    }
>   }
>   
>   static void virgl_cmd_context_create(VirtIOGPU *g,
> @@ -1270,11 +1294,24 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
>       }
>   }
>   
> -void virtio_gpu_virgl_reset(VirtIOGPU *g)
> +int virtio_gpu_virgl_reset(VirtIOGPU *g)
>   {
> +    struct virtio_gpu_simple_resource *res, *tmp;
> +
> +    QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
> +        virtio_gpu_virgl_resource_destroy(g, res, NULL);
> +    }
> +
> +    if (!QTAILQ_EMPTY(&g->reslist)) {
> +        error_report("failed to reset virgl resources");
> +        return -1;

It shouldn't report an error if suspended.

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


