Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71837C61CE8
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Jun 2025 08:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOBKH-0001uI-LJ; Sun, 08 Jun 2025 04:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uOBKB-0001ro-HD; Sun, 08 Jun 2025 04:24:15 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uOBK8-00006n-BW; Sun, 08 Jun 2025 04:24:15 -0400
Received: from [157.82.203.223] ([157.82.203.223]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5588NtIg024287
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 8 Jun 2025 17:23:55 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=5snAGZ1Sb2OalI/nwdKBEvqHjfEVYUGDrha5Ss4p2UA=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1749371035; v=1;
 b=AAsVg3GQZzyqcx08XG/iGMSEp+3obDRlOUVL39YRcRJeOQRdrhZLdoNuTPjj02dm
 G+3yv7TtCxkvckoy9b7Yifibnr0VDXzSntKQNwF00QU1incAeWYY3iNTDG1+O6Ls
 YAOtq36nFeLrA+sfrwMLUbh72g5z/YuwvseET/dHqJh+EsDtOJK8BB3CMj2y4iZj
 6juy2wtauM4jz3GX9Vldoe0T69NHfTyp2cJv5pm4GabWLCy5Q2PBlxgwqSZZyjWX
 +/vqjXQg38CGQlp3tlOjKGqDAdvniPjIpgEZI5nlpxNhWC09dy9mWPbPV3qaHluc
 +mqd+eGb0NymCxO7YmitwQ==
Message-ID: <d504e5de-cb7f-4eda-a046-9edef5d23749@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 8 Jun 2025 17:23:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 12/17] virtio-gpu: support context init multiple timeline
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yiwei Zhang <zzyiwei@gmail.com>, qemu-stable@nongnu.org,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
 <20250605162651.2614401-13-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250605162651.2614401-13-alex.bennee@linaro.org>
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

On 2025/06/06 1:26, Alex Bennée wrote:
> From: Yiwei Zhang <zzyiwei@gmail.com>
> 
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
> symptom could be hidden by certain guest wsi backend that waits on a
> venus native VkFence object for the actual payload with limited present
> modes or under special configs. e.g. x11 mailbox or xwayland.
> 
> After this change, everything related to venus fencing starts making
> sense. Confirmed this via guest and host side perfetto tracing.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 94d0ea1c1928 ("virtio-gpu: Support Venus context")

I suggest moving this in the front of the patch series to ease backporting.

I also wonder if "[PULL 11/17] ui/gtk-gl-area: Remove extra draw call in 
refresh" requires Cc: qemu-stable@nongnu.org. Fixing -display gtk,gl=on 
for Wayland sounds as important as this patch.

Regards,
Akihiko Odaki

> Signed-off-by: Yiwei Zhang <zzyiwei@gmail.com>
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Message-Id: <20250518152651.334115-1-zzyiwei@gmail.com>
> [AJB: remove version history from commit message]
> Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-ID: <20250603110204.838117-13-alex.bennee@linaro.org>
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index b4aa8abb96..cea2e12eb9 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -978,6 +978,15 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>       }
>   
>       trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
> +#if VIRGL_VERSION_MAJOR >= 1
> +    if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX) {
> +        virgl_renderer_context_create_fence(cmd->cmd_hdr.ctx_id,
> +                                            VIRGL_RENDERER_FENCE_FLAG_MERGEABLE,
> +                                            cmd->cmd_hdr.ring_idx,
> +                                            cmd->cmd_hdr.fence_id);
> +        return;
> +    }
> +#endif
>       virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
>   }
>   
> @@ -991,6 +1000,11 @@ static void virgl_write_fence(void *opaque, uint32_t fence)
>            * the guest can end up emitting fences out of order
>            * so we should check all fenced cmds not just the first one.
>            */
> +#if VIRGL_VERSION_MAJOR >= 1
> +        if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX) {
> +            continue;
> +        }
> +#endif
>           if (cmd->cmd_hdr.fence_id > fence) {
>               continue;
>           }
> @@ -1005,6 +1019,29 @@ static void virgl_write_fence(void *opaque, uint32_t fence)
>       }
>   }
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
>   static virgl_renderer_gl_context
>   virgl_create_context(void *opaque, int scanout_idx,
>                        struct virgl_renderer_gl_ctx_param *params)
> @@ -1039,11 +1076,18 @@ static int virgl_make_context_current(void *opaque, int scanout_idx,
>   }
>   
>   static struct virgl_renderer_callbacks virtio_gpu_3d_cbs = {
> +#if VIRGL_VERSION_MAJOR >= 1
> +    .version             = 3,
> +#else
>       .version             = 1,
> +#endif
>       .write_fence         = virgl_write_fence,
>       .create_gl_context   = virgl_create_context,
>       .destroy_gl_context  = virgl_destroy_context,
>       .make_current        = virgl_make_context_current,
> +#if VIRGL_VERSION_MAJOR >= 1
> +    .write_context_fence = virgl_write_context_fence,
> +#endif
>   };
>   
>   static void virtio_gpu_print_stats(void *opaque)


