Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E55C3ABC9
	for <qemu-devel@archiver.kernel.org>; Sun, 18 May 2025 12:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGdUl-0004Bz-4Q; Sun, 18 May 2025 08:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uGdUi-0004BI-9s; Sun, 18 May 2025 08:51:56 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uGdUg-0002xB-2M; Sun, 18 May 2025 08:51:56 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9548355C0CD;
 Sun, 18 May 2025 14:50:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Nu2n_D-tkOOq; Sun, 18 May 2025 14:50:15 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8CFAE55BC02; Sun, 18 May 2025 14:50:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8A790745682;
 Sun, 18 May 2025 14:50:15 +0200 (CEST)
Date: Sun, 18 May 2025 14:50:15 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Yiwei Zhang <zzyiwei@gmail.com>
cc: qemu-devel@nongnu.org, dmitry.osipenko@collabora.com, 
 qemu-stable@nongnu.org
Subject: Re: [PATCH] virtio-gpu: support context init multiple timeline
In-Reply-To: <20250518064553.317209-1-zzyiwei@gmail.com>
Message-ID: <7cdf5107-2f54-8322-6103-dd7fa7a6c5f1@eik.bme.hu>
References: <20250518064553.317209-1-zzyiwei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, 17 May 2025, Yiwei Zhang wrote:
> Venus and later native contexts have their own fence context along with
> multiple timelines within. Fences wtih VIRTIO_GPU_FLAG_INFO_RING_IDX in
> the flags must be dispatched to be created on the target context. Fence
> signaling also has to be handled on the specific timeline within that
> target context.
>
> Before this change, venus fencing is completely broken if the host
> driver doesn't support implicit fencing with external memory objects.
> Frames can go backwards along with random artifacts on screen if the
> host driver doesn't attach an implicit fence to the render target. The
> sympton could be hidden by certain guest wsi backend that waits on a

Typo: symptom

> venus native VkFence object for the actual payload,

> but that luckiness
> only applies to limited present modes as well.

This part of the sentence does not make sense to me. Maybe rephrase?

Regards,
BALATON Zoltan

> After this change, everything related to venus fencing starts making
> sense. Confirmed this via guest and host side perfetto tracing.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 94d0ea1c1928 ("virtio-gpu: Support Venus context")
> Signed-off-by: Yiwei Zhang <zzyiwei@gmail.com>
> ---
> hw/display/virtio-gpu-virgl.c | 44 +++++++++++++++++++++++++++++++++++
> 1 file changed, 44 insertions(+)
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 145a0b3879..94ddc01f91 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -970,6 +970,15 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>     }
>
>     trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
> +#if VIRGL_VERSION_MAJOR >= 1
> +    if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX) {
> +        virgl_renderer_context_create_fence(cmd->cmd_hdr.ctx_id,
> +                                            VIRGL_RENDERER_FENCE_FLAG_MERGEABLE,
> +                                            cmd->cmd_hdr.ring_idx,
> +                                            cmd->cmd_hdr.fence_id);
> +        return;
> +    }
> +#endif
>     virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
> }
>
> @@ -983,6 +992,11 @@ static void virgl_write_fence(void *opaque, uint32_t fence)
>          * the guest can end up emitting fences out of order
>          * so we should check all fenced cmds not just the first one.
>          */
> +#if VIRGL_VERSION_MAJOR >= 1
> +        if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX) {
> +            continue;
> +        }
> +#endif
>         if (cmd->cmd_hdr.fence_id > fence) {
>             continue;
>         }
> @@ -997,6 +1011,29 @@ static void virgl_write_fence(void *opaque, uint32_t fence)
>     }
> }
>
> +#if VIRGL_VERSION_MAJOR >= 1
> +static void virgl_write_context_fence(void *opaque, uint32_t ctx_id,
> +                                      uint32_t ring_idx, uint64_t fence_id) {
> +    VirtIOGPU *g = opaque;
> +    struct virtio_gpu_ctrl_command *cmd, *tmp;
> +
> +    QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
> +        if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX &&
> +            cmd->cmd_hdr.ctx_id == ctx_id && cmd->cmd_hdr.ring_idx == ring_idx &&
> +            cmd->cmd_hdr.fence_id <= fence_id) {
> +            trace_virtio_gpu_fence_resp(cmd->cmd_hdr.fence_id);
> +            virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODATA);
> +            QTAILQ_REMOVE(&g->fenceq, cmd, next);
> +            g_free(cmd);
> +            g->inflight--;
> +            if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
> +                trace_virtio_gpu_dec_inflight_fences(g->inflight);
> +            }
> +        }
> +    }
> +}
> +#endif
> +
> static virgl_renderer_gl_context
> virgl_create_context(void *opaque, int scanout_idx,
>                      struct virgl_renderer_gl_ctx_param *params)
> @@ -1031,11 +1068,18 @@ static int virgl_make_context_current(void *opaque, int scanout_idx,
> }
>
> static struct virgl_renderer_callbacks virtio_gpu_3d_cbs = {
> +#if VIRGL_VERSION_MAJOR >= 1
> +    .version             = 3,
> +#else
>     .version             = 1,
> +#endif
>     .write_fence         = virgl_write_fence,
>     .create_gl_context   = virgl_create_context,
>     .destroy_gl_context  = virgl_destroy_context,
>     .make_current        = virgl_make_context_current,
> +#if VIRGL_VERSION_MAJOR >= 1
> +    .write_context_fence = virgl_write_context_fence,
> +#endif
> };
>
> static void virtio_gpu_print_stats(void *opaque)
>

