Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FD0C55184
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 09:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqpR4-0002Sw-K8; Mon, 03 Aug 2026 05:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wqpR1-0002Sb-VU
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 05:58:16 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wqpQy-00062u-RK
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 05:58:15 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6739w28e052161
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 3 Aug 2026 18:58:02 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=QoC8PFEm36TMopukt+N8QBdQXOVLCMyyzcO2oZsGwS8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785751082; v=1;
 b=mcZzqbU41jTgyDkdxvtaz5fS/GmBXGLED0h6UQdmbC1ThPZqpnq02vUGjJKhAUpn
 hBWiIPtEZm1v/C+686FRqH7LHV0QiRG7AhjV6BkQnfC7OpZLtRNp9knwAaRaBr3I
 kmUFsrX0QUCPbgbpPHbNWOL+gsAgzu29BPFyfgWPZF4Ue7wWV8pXb2s+83XTas4E
 LFafVCbfzRLGOh0XxJax17dfrJI2yZdLUlW0MVPgDIfu/0zOK9/Hm4+W4NsY2AqF
 udAsvDJFL5fNA96EpiDomKYxDs/1kXmAoagy7mC/GipFzkMBf5MsbLBA5uIXSqsC
 uMbYuzyq1POud8HHxncKrQ==
Message-ID: <774f5743-1d5a-4a22-a639-f42e08464219@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 3 Aug 2026 18:58:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/virtio-gpu: Always reject invalid scanout
 bounds
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260803-scanout-v1-1-c9831dafdab2@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260803-scanout-v1-1-c9831dafdab2@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Ccing Marc-André Lureau

On 2026/08/03 17:45, Akihiko Odaki wrote:
> virtio-gpu does not consistently check scanout bounds with wraparound
> handling. In the unchecked virgl SET_SCANOUT path, guest dimensions
> reach qemu_console_resize(), qemu_create_displaysurface(), and
> ultimately qemu_pixman_image_new_shareable(..., &error_abort), so an
> invalid rectangle can terminate QEMU. Implement a check with proper
> wraparound handling and apply it consistently.
> 
> Fixes: 9d9e152136bd ("virtio-gpu: add 3d mode and virgl rendering support.")
> Fixes: 32db3c63ae11 ("virtio-gpu: Add virtio_gpu_set_scanout_blob")
> Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")
> Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxstream")
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   include/hw/virtio/virtio-gpu.h   |  5 +++++
>   hw/display/virtio-gpu-rutabaga.c |  6 ++++++
>   hw/display/virtio-gpu-virgl.c    | 20 +++++++++-----------
>   hw/display/virtio-gpu.c          | 36 ++++++++++++++++++++++--------------
>   4 files changed, 42 insertions(+), 25 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 2f60c72078b3..287262228d33 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -363,6 +363,11 @@ void virtio_gpu_update_cursor_data(VirtIOGPU *g,
>                                      struct virtio_gpu_scanout *s,
>                                      uint32_t resource_id);
>   
> +bool virtio_gpu_check_scanout_bounds(uint32_t scanout_id, uint32_t resource_id,
> +                                     uint32_t width, uint32_t height,
> +                                     const struct virtio_gpu_rect *r,
> +                                     uint32_t *error);
> +
>   /**
>    * virtio_gpu_scanout_blob_to_fb() - fill out fb based on scanout data
>    * fb: the frame-buffer descriptor to fill out
> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
> index e28aad94eead..a054f8117f14 100644
> --- a/hw/display/virtio-gpu-rutabaga.c
> +++ b/hw/display/virtio-gpu-rutabaga.c
> @@ -315,6 +315,12 @@ rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
>       res = virtio_gpu_find_resource(g, ss.resource_id);
>       CHECK(res, cmd);
>   
> +    if (!virtio_gpu_check_scanout_bounds(ss.scanout_id, ss.resource_id,
> +                                         res->width, res->height, &ss.r,
> +                                         &cmd->error)) {
> +        return;
> +    }
> +
>       if (!res->image) {
>           pixman_format_code_t pformat;
>           pformat = virtio_gpu_get_pixman_format(res->format);
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index d9e5b0110497..6e298f997d66 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -560,7 +560,7 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
>       }
>       g->parent_obj.enable = 1;
>   
> -    if (ss.resource_id && ss.r.width && ss.r.height) {
> +    if (ss.resource_id) {
>           struct virgl_renderer_resource_info info;
>           void *d3d_tex2d = NULL;
>   
> @@ -581,6 +581,11 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
>               cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
>               return;
>           }
> +        if (!virtio_gpu_check_scanout_bounds(ss.scanout_id, ss.resource_id,
> +                                             info.width, info.height, &ss.r,
> +                                             &cmd->error)) {
> +            return;
> +        }
>           qemu_console_resize(g->parent_obj.scanout[ss.scanout_id].con,
>                               ss.r.width, ss.r.height);
>           virgl_renderer_force_ctx_0();
> @@ -987,16 +992,9 @@ static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
>           return;
>       }
>   
> -    if (ss.width < 16 ||
> -        ss.height < 16 ||
> -        ss.r.x + ss.r.width > ss.width ||
> -        ss.r.y + ss.r.height > ss.height) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout %d bounds for"
> -                      " resource %d, rect (%d,%d)+%d,%d, fb %d %d\n",
> -                      __func__, ss.scanout_id, ss.resource_id,
> -                      ss.r.x, ss.r.y, ss.r.width, ss.r.height,
> -                      ss.width, ss.height);
> -        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +    if (!virtio_gpu_check_scanout_bounds(ss.scanout_id, ss.resource_id,
> +                                         ss.width, ss.height, &ss.r,
> +                                         &cmd->error)) {
>           return;
>       }
>   
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 4d46a4eb10fa..3c0e38c1def0 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -622,6 +622,26 @@ static uint32_t virtio_gpu_format_bytes_pp(pixman_format_code_t format)
>       return DIV_ROUND_UP(PIXMAN_FORMAT_BPP(format), 8);
>   }
>   
> +bool virtio_gpu_check_scanout_bounds(uint32_t scanout_id, uint32_t resource_id,
> +                                     uint32_t width, uint32_t height,
> +                                     const struct virtio_gpu_rect *r,
> +                                     uint32_t *error)
> +{
> +    if (r->width < 16 ||
> +        r->height < 16 ||
> +        (uint64_t)r->x + r->width > width ||
> +        (uint64_t)r->y + r->height > height) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout %d bounds for"
> +                      " resource %d, fb %d %d, rect (%d,%d)+%d,%d\n",
> +                      __func__, scanout_id, resource_id, width, height,
> +                      r->x, r->y, r->width, r->height);
> +        *error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>   static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
>                                         uint32_t scanout_id,
>                                         struct virtio_gpu_framebuffer *fb,
> @@ -635,20 +655,8 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
>   
>       scanout = &g->parent_obj.scanout[scanout_id];
>   
> -    if (r->x > fb->width ||
> -        r->y > fb->height ||
> -        r->width < 16 ||
> -        r->height < 16 ||
> -        r->width > fb->width ||
> -        r->height > fb->height ||
> -        r->x + r->width > fb->width ||
> -        r->y + r->height > fb->height) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout %d bounds for"
> -                      " resource %d, rect (%d,%d)+%d,%d, fb %d %d\n",
> -                      __func__, scanout_id, res->resource_id,
> -                      r->x, r->y, r->width, r->height,
> -                      fb->width, fb->height);
> -        *error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +    if (!virtio_gpu_check_scanout_bounds(scanout_id, res->resource_id,
> +                                         fb->width, fb->height, r, error)) {
>           return false;
>       }
>   
> 
> ---
> base-commit: 299e7557ed15a9a325620698add379a3ce2d1d95
> change-id: 20260803-scanout-c7cf28c1890e
> 
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 


