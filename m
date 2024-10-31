Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C4FE6895A
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 07:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6PrE-0003Qo-7R; Thu, 31 Oct 2024 03:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t6PrB-0003PV-8q
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 03:44:37 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t6Pr8-0002kD-Ig
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 03:44:37 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7180dc76075so300581a34.3
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 00:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1730360673; x=1730965473;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0AWea0XA5ANAQQu2VT/ZrI+VQYT4UCthehopgukRlkk=;
 b=Z9k3GWPPXBztAW5Xqrq5JZ6998hhXxx6knrfppAPNlQq76Lyp+fvuhPDsF73z1FFa4
 Ov8vJzHPPRJrfWyw7LxjKgW06F9EihQG1A9OzD/g/u+LE8kTehUZbsEKMM2nkh4YyxlS
 eRp2/rh4Zsivqi8N+w8rNyr9MbpsgxrNWKBT/8Lis7gyCUVO5Sed76kgb+oqjbsJdPJb
 feV/9bcZ+cJAOw60rtbxEuU1BWDoC59v11j7CBmVj/5aw+ySmjusl1JMWrIgFkzryOEp
 Qn/JsnJQaC1FSP6KtJQKKrktBYtbvTPkv6DgOpnTrhmEoY+cZMJAsDp7P3YLuZK5DNb+
 vzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730360673; x=1730965473;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0AWea0XA5ANAQQu2VT/ZrI+VQYT4UCthehopgukRlkk=;
 b=T44EPqx6Z2P2on+rcCm9lVxx45mnGBpMMw+OheQ6zzwYtQLLZtAXjNYi2ewEwX8WPW
 qjPUcyWTfsPfA9Siq8o/wdgX6XgOYy7kdCPFdy6jd6AeSrI/UvDLwpzUhUFkIQo5BCP3
 zPPVZgU1eEaU1kwR2BgTXXu/sv9f2wBZx3Nb+a1a3ZmzwlbVqxmq9GoJwoqS1BT3djY3
 fKiUy8Cp7mvO6Nt5ZDx8kDyhLPRohKpoWP39n0H/kyNvjtTU4KhqR1f9Fbj+QkvbEREL
 ckG+bd+hUgR1LYF0OAUOJ/lB+bdHAuuH8XxRcHRRKfhdPPPKLz9ehoGAnug+7LIqE5Vb
 TmKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIsIalFbwKVX22XQEKvNVMW+jWCwgssgN1AdHmGkev9q1HLGliYJfjOYY220lCC6So77neIH26Sz1f@nongnu.org
X-Gm-Message-State: AOJu0YyGZzuD45z8/aqvQObzu//WZTKQBCGPvnpVMS4OqJcq9wsVJ/nc
 4hhcdSOO1hDJtjT+kwzcSoZVs/dbxYNPa8VYiWF/fFZg69CYSt4nH4iBx9ZH/eA=
X-Google-Smtp-Source: AGHT+IETxTz9W0JJtfB/iW7rcwsnmJ7FY06H1pJXFngpTqUg2pwDSSn9Qb45UV1+wCOv6J6374EnTw==
X-Received: by 2002:a05:6830:2b24:b0:710:fd8e:1727 with SMTP id
 46e09a7af769-7186822d203mr15137370a34.18.1730360672883; 
 Thu, 31 Oct 2024 00:44:32 -0700 (PDT)
Received: from [157.82.207.167] ([157.82.207.167])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc2f0c02sm704278b3a.179.2024.10.31.00.44.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2024 00:44:32 -0700 (PDT)
Message-ID: <02b3051b-c062-4418-9ebf-8c9011d87842@daynix.com>
Date: Thu, 31 Oct 2024 16:44:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] virtio-gpu: Support asynchronous fencing
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20241024233355.136867-1-dmitry.osipenko@collabora.com>
 <20241024233355.136867-6-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241024233355.136867-6-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::332;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/10/25 8:33, Dmitry Osipenko wrote:
> Support asynchronous fencing feature of virglrenderer. It allows Qemu to
> handle fence as soon as it's signalled instead of periodically polling
> the fence status. This feature is required for enabling DRM context
> support in Qemu because legacy fencing mode isn't supported for DRM
> contexts in virglrenderer.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   hw/display/virtio-gpu-gl.c     |   3 +
>   hw/display/virtio-gpu-virgl.c  | 138 +++++++++++++++++++++++++++------
>   include/hw/virtio/virtio-gpu.h |  13 ++++
>   3 files changed, 132 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index 7c0e448b4661..53d938f23f20 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -170,6 +170,9 @@ static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
>       if (gl->renderer_state >= RS_INITED) {
>   #if VIRGL_VERSION_MAJOR >= 1
>           qemu_bh_delete(gl->cmdq_resume_bh);
> +
> +        virtio_gpu_virgl_reset_async_fences(g);
> +        qemu_bh_delete(gl->async_fence_bh);
>   #endif
>           if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
>               timer_free(gl->print_stats);
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 3c564683820b..37b40e258398 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -891,6 +891,7 @@ static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
>   void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>                                         struct virtio_gpu_ctrl_command *cmd)
>   {
> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
>       bool cmd_suspended = false;
>       int ret;
>   
> @@ -992,34 +993,71 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>   
>       trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
>   
> -    /*
> -     * Unlike other virglrenderer functions, this one returns a positive
> -     * error code.
> -     */
> -    ret = virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, 0);
> -    if (ret)
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: virgl_renderer_create_fence error: %s",
> -                      __func__, strerror(ret));
> +    if (gl->context_fence_enabled &&
> +        (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX)) {
> +        uint32_t flags = 0;
> +
> +        ret = virgl_renderer_context_create_fence(cmd->cmd_hdr.ctx_id, flags,
> +                                                  cmd->cmd_hdr.ring_idx,
> +                                                  cmd->cmd_hdr.fence_id);
> +        if (ret)
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: virgl_renderer_context_create_fence error: %s",
> +                          __func__, strerror(-ret));
> +    } else {
> +        /*
> +         * Unlike other virglrenderer functions, this one returns a positive
> +         * error code.
> +         */
> +        ret = virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, 0);
> +        if (ret)
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: virgl_renderer_create_fence error: %s",
> +                          __func__, strerror(ret));
> +    }
>   }
>   
> -static void virgl_write_fence(void *opaque, uint32_t fence)
> +static void virtio_gpu_virgl_async_fence_bh(void *opaque)
>   {
> -    VirtIOGPU *g = opaque;
> +    QSLIST_HEAD(, virtio_gpu_virgl_context_fence) async_fenceq;
>       struct virtio_gpu_ctrl_command *cmd, *tmp;
> +    struct virtio_gpu_virgl_context_fence *f;
> +    VirtIOGPU *g = opaque;
> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
>   
> -    QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
> -        /*
> -         * the guest can end up emitting fences out of order
> -         * so we should check all fenced cmds not just the first one.
> -         */
> -        if (cmd->cmd_hdr.fence_id > fence) {
> -            continue;
> +    QSLIST_MOVE_ATOMIC(&async_fenceq, &gl->async_fenceq);
> +
> +    while (!QSLIST_EMPTY(&async_fenceq)) {
> +        f = QSLIST_FIRST(&async_fenceq);
> +
> +        QSLIST_REMOVE_HEAD(&async_fenceq, next);
> +
> +        QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
> +            /*
> +             * the guest can end up emitting fences out of order
> +             * so we should check all fenced cmds not just the first one.
> +             */
> +            if (cmd->cmd_hdr.fence_id > f->fence_id) {
> +                continue;
> +            }
> +            if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX) {
> +                if (cmd->cmd_hdr.ring_idx != f->ring_idx) {
> +                    continue;
> +                }
> +                if (cmd->cmd_hdr.ctx_id != f->ctx_id) {
> +                    continue;
> +                }
> +            } else if (f->ring_idx >= 0) {
> +                /* ctx0 GL-query fences don't have ring info */
> +                continue;
> +            }
> +            virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODATA);
> +            QTAILQ_REMOVE(&g->fenceq, cmd, next);
> +            g_free(cmd);
>           }
> -        trace_virtio_gpu_fence_resp(cmd->cmd_hdr.fence_id);
> -        virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODATA);
> -        QTAILQ_REMOVE(&g->fenceq, cmd, next);
> -        g_free(cmd);
> +
> +        trace_virtio_gpu_fence_resp(f->fence_id);
> +        g_free(f);
>           g->inflight--;
>           if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
>               trace_virtio_gpu_dec_inflight_fences(g->inflight);
> @@ -1027,6 +1065,50 @@ static void virgl_write_fence(void *opaque, uint32_t fence)
>       }
>   }
>   
> +void virtio_gpu_virgl_reset_async_fences(VirtIOGPU *g)
> +{
> +    struct virtio_gpu_virgl_context_fence *f, *f_tmp;
> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
> +
> +    QSLIST_FOREACH_SAFE(f, &gl->async_fenceq, next, f_tmp) {
> +        QSLIST_REMOVE(&gl->async_fenceq, f, virtio_gpu_virgl_context_fence,
> +                      next);

Replace QSLIST_FOREACH_SAFE() and QSLIST_REMOVE() with QSLIST_EMPTY(), 
QSLIST_FIRST() and QSLIST_REMOVE_HEAD() as you have done for 
virtio_gpu_virgl_async_fence_bh().

> +        g_free(f);
> +    }
> +}
> +
> +static void
> +virtio_gpu_virgl_push_async_fence(VirtIOGPU *g, uint32_t ctx_id,
> +                                  int64_t ring_idx, uint64_t fence_id)
> +{
> +    struct virtio_gpu_virgl_context_fence *f;
> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
> +
> +    f = g_new(struct virtio_gpu_virgl_context_fence, 1);
> +    f->ctx_id = ctx_id;
> +    f->ring_idx = ring_idx;
> +    f->fence_id = fence_id;
> +
> +    QSLIST_INSERT_HEAD_ATOMIC(&gl->async_fenceq, f, next);
> +
> +    qemu_bh_schedule(gl->async_fence_bh);
> +}
> +
> +static void virgl_write_fence(void *opaque, uint32_t fence)
> +{
> +    VirtIOGPU *g = opaque;
> +
> +    virtio_gpu_virgl_push_async_fence(g, 0, -1, fence);
> +}
> +
> +static void virgl_write_context_fence(void *opaque, uint32_t ctx_id,
> +                                      uint32_t ring_idx, uint64_t fence)
> +{
> +    VirtIOGPU *g = opaque;
> +
> +    virtio_gpu_virgl_push_async_fence(g, ctx_id, ring_idx, fence);
> +}
> +
>   static virgl_renderer_gl_context
>   virgl_create_context(void *opaque, int scanout_idx,
>                        struct virgl_renderer_gl_ctx_param *params)
> @@ -1114,6 +1196,8 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
>           dpy_gfx_replace_surface(g->parent_obj.scanout[i].con, NULL);
>           dpy_gl_scanout_disable(g->parent_obj.scanout[i].con);
>       }
> +
> +    virtio_gpu_virgl_reset_async_fences(g);
>   }
>   
>   void virtio_gpu_virgl_reset(VirtIOGPU *g)
> @@ -1131,6 +1215,12 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>       if (qemu_egl_display) {
>           virtio_gpu_3d_cbs.version = 4;
>           virtio_gpu_3d_cbs.get_egl_display = virgl_get_egl_display;
> +#if VIRGL_VERSION_MAJOR >= 1
> +        virtio_gpu_3d_cbs.write_context_fence = virgl_write_context_fence;
> +        flags |= VIRGL_RENDERER_ASYNC_FENCE_CB;
> +        flags |= VIRGL_RENDERER_THREAD_SYNC;
> +        gl->context_fence_enabled = true;
> +#endif
>       }
>   #endif
>   #ifdef VIRGL_RENDERER_D3D11_SHARE_TEXTURE
> @@ -1164,6 +1254,10 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>       gl->cmdq_resume_bh = aio_bh_new(qemu_get_aio_context(),
>                                       virtio_gpu_virgl_resume_cmdq_bh,
>                                       g);
> +
> +    gl->async_fence_bh = aio_bh_new(qemu_get_aio_context(),
> +                                    virtio_gpu_virgl_async_fence_bh,
> +                                    g);
>   #endif
>   
>       return 0;
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 553799b8cc72..99cc6286f473 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -227,6 +227,13 @@ struct VirtIOGPUClass {
>                                Error **errp);
>   };
>   
> +struct virtio_gpu_virgl_context_fence {
> +    uint32_t ctx_id;
> +    int64_t ring_idx;
> +    uint64_t fence_id;
> +    QSLIST_ENTRY(virtio_gpu_virgl_context_fence) next;
> +};
> +
>   /* VirtIOGPUGL renderer states */
>   typedef enum {
>       RS_START,       /* starting state */
> @@ -244,6 +251,11 @@ struct VirtIOGPUGL {
>       QEMUTimer *print_stats;
>   
>       QEMUBH *cmdq_resume_bh;
> +
> +    QEMUBH *async_fence_bh;
> +    QSLIST_HEAD(, virtio_gpu_virgl_context_fence) async_fenceq;
> +
> +    bool context_fence_enabled;
>   };
>   
>   struct VhostUserGPU {
> @@ -358,5 +370,6 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);
>   void virtio_gpu_virgl_reset(VirtIOGPU *g);
>   int virtio_gpu_virgl_init(VirtIOGPU *g);
>   GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g);
> +void virtio_gpu_virgl_reset_async_fences(VirtIOGPU *g);
>   
>   #endif


