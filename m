Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933B9C79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 06:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3pan-0003JM-TU; Tue, 08 Sep 2026 02:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3pag-0003Ik-D6
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 02:46:01 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3pab-0003gN-NF
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 02:45:56 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6886jedb067564
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 8 Sep 2026 15:45:40 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=/lAFXk7uBgzVMP/VQOZF17r+4nAePlynYL1ffPhYcJk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1788849940; v=1;
 b=MFXywM8cQqy+LLm2rlHlx8EIr6JFDLGAzHJCVlIm98dHkhfkV0fYE/uXrBy6m6q8
 YHMC3GEN/NjVk+CSz2WRGia2NMAWB8ZMKafMeAfWJavxnfqWIw+LHCl0FJOINVQK
 HDCbvDDZe8YdSJrvaVdjKxQDdUnjgjYRuokHeF6zh3eH1BsEtxrWysXKCQa2+blH
 7D/rB8E9sa4G+aWAmEDnnnX9Jtrn7Ney66HPFhLvEbMFCe4ADKxJp1JuoFOjy0EG
 Qgg8FdTFolIcyamU6UAOJjT8qY9aIx7juxhKMrLqanfItn+qL6iWGp9g2TLJ+tkX
 IMO+6Cp8U2vhrHwNE4WeWA==
Message-ID: <0699b5e3-23de-4199-9689-c5b98a7c4583@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 8 Sep 2026 15:45:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/25] virtio-gpu: consolidate disabling scanout
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Alex Williamson
 <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
 <20260904-virtio-gpu-cleanup-v2-20-15b5ae6b0023@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260904-virtio-gpu-cleanup-v2-20-15b5ae6b0023@redhat.com>
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

On 2026/09/04 22:10, Marc-André Lureau wrote:
> Use the common virtio_gpu_disable_scanout() to reset the scanout state,
> including GL state if any.
> 
> Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/virtio-gpu-rutabaga.c | 4 +---
>   hw/display/virtio-gpu-virgl.c    | 6 ++----
>   hw/display/virtio-gpu.c          | 7 +++++--
>   3 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
> index 8a82e96b7461..8697dd6936ba 100644
> --- a/hw/display/virtio-gpu-rutabaga.c
> +++ b/hw/display/virtio-gpu-rutabaga.c
> @@ -312,9 +312,7 @@ rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
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
> index 79d4c0b569fb..87d1fc3d5f65 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -618,8 +618,7 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
>               ss.r.x, ss.r.y, ss.r.width, ss.r.height,
>               d3d_tex2d);
>       } else {
> -        qemu_console_set_surface(g->parent_obj.scanout[ss.scanout_id].con, NULL);
> -        qemu_console_gl_scanout_disable(g->parent_obj.scanout[ss.scanout_id].con);
> +        virtio_gpu_disable_scanout(g, ss.scanout_id);
>       }
>       g->parent_obj.scanout[ss.scanout_id].resource_id = ss.resource_id;
>   }
> @@ -1426,8 +1425,7 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
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
> index ae1f87ad68b2..cb096cb349cd 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -435,8 +435,11 @@ void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
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

GL needs to be always disabled when clearing a scanout.

Having scanout->dmabuf suppresses the explicit GL-disable callback. This 
misses a real reset path:
1. Reset a Virgl device displaying a hostmem-mapped blob.
2. virtio_gpu_virgl_resource_unref() starts asynchronous unmapping and
    returns before disabling its scanouts.
3. virtio_gpu_reset_bh() installs placeholder surfaces, changing the
    console to SCANOUT_SURFACE; virtio_gpu_base_reset() clears the
    resource IDs.
4. virtio_gpu_gl_reset() calls virtio_gpu_virgl_reset_scanout(). The new
    helper releases the retained DMA-BUF, but
    qemu_console_gl_release_dmabuf() invokes GL-disable only for
    SCANOUT_DMABUF.
5. GTK’s release callback clears the DMA-BUF pointer but leaves
    scanout_mode and its framebuffer. The queued redraw continues through
    the old framebuffer path instead of displaying the placeholder, blit
    in gd_gl_area_draw().

Before this patch, virtio_gpu_virgl_reset_scanout() always called 
GL-disable. Please ensure the disable helper actually disables the 
frontend even when releasing a wrapper whose console has already 
switched to a surface.

Regards,
Akihiko Odaki

>       qemu_console_set_surface(scanout->con, NULL);
>       scanout->resource_id = 0;
>       scanout->ds = NULL;
> 


