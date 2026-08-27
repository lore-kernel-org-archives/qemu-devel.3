Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E354C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzaf2-0007n0-V1; Thu, 27 Aug 2026 10:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wzaf1-0007mf-9T
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:00:55 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wzaey-0002xt-LR
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:00:54 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67RE0hlv007335
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 27 Aug 2026 23:00:43 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=wIU1lZohPwLfjGP67roa75PGDHBcjZQTo34rPA0LQLk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1787839243; v=1;
 b=vcXn6cVG8ZbBFWREb1f1Sa3IvaOcnPBukCeNrFdFu3I4tfq8n1urawIv9uiPbsRC
 qtDyVD1vWHdupgu6OcnjWFC6p3attvrJn1zwPYm7YGQ9EcA9e7ytfzXc+pgDgYF8
 +2rJVf+mj90hTwsAsmNxyBJ/NltKDUCDr852wxG2zd8Wydj0zx4yvgVsy5Vnjzl3
 uPEJmGuqkZfqnI//LFgNu4ajA1LZIC66ZQDLqu3hHga42tJ0RMTIOV2vA/OoOkhR
 zux9UDFLOpXVW0i2a1krtGpFPmqdgxjyNiuZvwu7whKXbIOAQKre+Uqe5ZOSyfp+
 J4iIIwqshZz6IWds2WEeew==
Message-ID: <6deea473-2d79-4b90-a866-9f0eeed8cc31@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 27 Aug 2026 23:00:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/18] virtio-gpu/virgl: release dmabuf when a texture
 replaces a scanout
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Alex Williamson
 <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260825-virtio-gpu-cleanup-v1-0-d3bb612b9975@redhat.com>
 <20260825-virtio-gpu-cleanup-v1-13-d3bb612b9975@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260825-virtio-gpu-cleanup-v1-13-d3bb612b9975@redhat.com>
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
> Release the scanout dmabuf before installing the texture. A full
> virtio_gpu_disable_scanout() is not used because the scanout is
> reassigned immediately afterwards.
> 

Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/virtio-gpu-virgl.c  | 3 +++
>   hw/display/virtio-gpu.c        | 2 +-
>   include/hw/virtio/virtio-gpu.h | 2 ++
>   3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 6e298f997d66..532132e46031 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -586,6 +586,9 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
>                                                &cmd->error)) {
>               return;
>           }
> +
> +        virtio_gpu_release_scanout_dmabuf(g, ss.scanout_id);
> +
>           qemu_console_resize(g->parent_obj.scanout[ss.scanout_id].con,
>                               ss.r.width, ss.r.height);
>           virgl_renderer_force_ctx_0();
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index a74475dc6741..c50eb58917e8 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -387,7 +387,7 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
>       QTAILQ_INSERT_HEAD(&g->reslist, res, next);
>   }
>   
> -static void virtio_gpu_release_scanout_dmabuf(VirtIOGPU *g, int scanout_id)
> +void virtio_gpu_release_scanout_dmabuf(VirtIOGPU *g, int scanout_id)
>   {
>       struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[scanout_id];
>       g_autoptr(QemuDmaBuf) dmabuf = scanout->dmabuf;
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 1816cb21de76..22a38589d63d 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -360,6 +360,8 @@ bool virtio_gpu_check_scanout_bounds(uint32_t scanout_id, uint32_t resource_id,
>                                        const struct virtio_gpu_rect *r,
>                                        uint32_t *error);
>   
> +void virtio_gpu_release_scanout_dmabuf(VirtIOGPU *g, int scanout_id);
> +
>   /**
>    * virtio_gpu_scanout_blob_to_fb() - fill out fb based on scanout data
>    * fb: the frame-buffer descriptor to fill out
> 


