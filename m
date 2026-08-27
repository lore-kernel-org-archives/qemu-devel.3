Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52118C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzav6-0003Ek-E2; Thu, 27 Aug 2026 10:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wzav4-0003E4-GN
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:17:30 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wzav1-0006zW-BK
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:17:30 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67REHFh0012927
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 27 Aug 2026 23:17:15 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=jYWq5inWub3zBWjQDIkQ/R2TCqIUTHiUoqOsJo6FjUU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1787840235; v=1;
 b=Yg4wCra4S+g5orbykErUyRf18LGdu478NIOfxPp7fiN3QLejywJwzrjiL4lvHKbc
 SzQABxu9YOPxLwPKcspTplPGoXssaJQHZ+W1IueT0uJLGgbzO2UC+TxvQr+Zl3dy
 1Pbw2YuqwuP0UT69zBWP2NK5JOKs21tVNrOqT1kdHu6uxSMXwzl7wOcN0pK8uw9w
 mHQTv2WDc12kbvPEN5rbPjP8nBwyjxe+3LlXVLDJJz7W+9YdUHm3V61T/heWfAK6
 n6EaDhUP561ATwkYBHG3X2N3/CJea2XEq7RajEYwDv5JrTVqaF9FuMmPGAGviAS9
 MKF0XnTh9KXRB8FaAB3hSg==
Message-ID: <a8b24bc2-42f5-476d-8972-a34257945b3b@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 27 Aug 2026 23:17:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/18] virtio-gpu: consolidate disabling scanout
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Alex Williamson
 <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260825-virtio-gpu-cleanup-v1-0-d3bb612b9975@redhat.com>
 <20260825-virtio-gpu-cleanup-v1-14-d3bb612b9975@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260825-virtio-gpu-cleanup-v1-14-d3bb612b9975@redhat.com>
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

On 2026/08/25 19:20, Marc-André Lureau wrote:
> Use the common virtio_gpu_disable_scanout() to reset the scanout state,
> including GL state if any.

This actually:

Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")

because it properly releases scanout->dmabuf.

Regards,
Akihiko Odaki

> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/virtio-gpu-rutabaga.c | 4 +---
>   hw/display/virtio-gpu-virgl.c    | 6 ++----
>   hw/display/virtio-gpu.c          | 7 +++++--
>   3 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
> index fcd9c94d580c..5344a5f9e26a 100644
> --- a/hw/display/virtio-gpu-rutabaga.c
> +++ b/hw/display/virtio-gpu-rutabaga.c
> @@ -320,9 +320,7 @@ rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
>       scanout = &vb->scanout[ss.scanout_id];
>   
>       if (ss.resource_id == 0) {
> -        scanout->resource_id = 0;
> -        qemu_console_set_surface(scanout->con, NULL);
> -        qemu_console_gl_scanout_disable(scanout->con);
> +        virtio_gpu_disable_scanout(g, ss.scanout_id);
>           return;
>       }
>   
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 532132e46031..6cb9365a714f 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -599,8 +599,7 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
>               ss.r.x, ss.r.y, ss.r.width, ss.r.height,
>               d3d_tex2d);
>       } else {
> -        qemu_console_set_surface(g->parent_obj.scanout[ss.scanout_id].con, NULL);
> -        qemu_console_gl_scanout_disable(g->parent_obj.scanout[ss.scanout_id].con);
> +        virtio_gpu_disable_scanout(g, ss.scanout_id);
>       }
>       g->parent_obj.scanout[ss.scanout_id].resource_id = ss.resource_id;
>   }
> @@ -1406,8 +1405,7 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
>       int i;
>   
>       for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
> -        qemu_console_set_surface(g->parent_obj.scanout[i].con, NULL);
> -        qemu_console_gl_scanout_disable(g->parent_obj.scanout[i].con);
> +        virtio_gpu_disable_scanout(g, i);
>       }
>   }
>   
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index c50eb58917e8..a7f549a6a8b9 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -404,8 +404,11 @@ void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
>   {
>       struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[scanout_id];
>   
> -    virtio_gpu_release_scanout_dmabuf(g, scanout_id);
> -
> +    if (scanout->dmabuf) {
> +        virtio_gpu_release_scanout_dmabuf(g, scanout_id);
> +    } else {
> +        qemu_console_gl_scanout_disable(scanout->con);
> +    }
>       qemu_console_set_surface(scanout->con, NULL);
>       scanout->resource_id = 0;
>       scanout->ds = NULL;
> 


