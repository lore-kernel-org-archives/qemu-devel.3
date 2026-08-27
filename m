Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B960EC61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzac6-0006Fw-O7; Thu, 27 Aug 2026 09:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wzac1-00069f-Tb
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 09:57:49 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wzaby-0001iL-Nd
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 09:57:49 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67RDvVug006239
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 27 Aug 2026 22:57:32 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=9SKvF98hBg2oOS2DxmFYBcqCm+LUrp1vFRDX4/T7Bqc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1787839052; v=1;
 b=K28s1X2R3XhEIhII9IEPMniEMmC0Sj+OeyFTWdoUswirbwZEszKaJMY/gxKId9wi
 /3nAmynPLbPNJPV9jCboaqrsyY43ljTyUGwcmovlnKH3CWsjhkuOMmQb8SXeuYYI
 468e6bUt9vCuvdoTDKkUVuDtkUisEZlRBQa2HjfHmWPwxX0taC2CU1+nvca0qIOI
 cqhOnHVnuApnBPWnyWQfMmfOxmtHH5osNIfJi/piMGKmna15Xjs6qa9Q99DpscV8
 PW0PqHqSmtD1S8pNtc+lkXJwKObZ8wVUPfZoDVd2d+g9X3o97EKkU2WUX8d5Yksx
 /tQ7rYC+D4EUEI8pkzyggA==
Message-ID: <a2db393a-9ae5-4e3d-aff1-9f48d6e5a065@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 27 Aug 2026 22:57:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/18] virtio-gpu: release dmabuf when switching to a
 surface
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Alex Williamson
 <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260825-virtio-gpu-cleanup-v1-0-d3bb612b9975@redhat.com>
 <20260825-virtio-gpu-cleanup-v1-12-d3bb612b9975@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260825-virtio-gpu-cleanup-v1-12-d3bb612b9975@redhat.com>
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
> A scanout may hold an active QemuDmaBuf when a SET_SCANOUT switches to
> CPU-backed display data. Force surface recreation and release the old
> buffer in this case.
> 

Fixes: 32db3c63ae11 ("virtio-gpu: Add virtio_gpu_set_scanout_blob")

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/virtio-gpu.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 5362f7a4c269..a74475dc6741 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -658,9 +658,11 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
>   {
>       struct virtio_gpu_scanout *scanout;
>       uint32_t bytes_pp = virtio_gpu_format_bytes_pp(fb->format);
> +    bool was_dmabuf;
>       uint8_t *data;
>   
>       scanout = &g->parent_obj.scanout[scanout_id];
> +    was_dmabuf = scanout->dmabuf != NULL;
>   
>       if (!virtio_gpu_check_scanout_bounds(scanout_id, res->resource_id,
>                                            fb->width, fb->height, r, error)) {
> @@ -687,12 +689,11 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
>   
>       if (res->blob) {
>           if (qemu_console_has_gl(scanout->con)) {
> -            if (!virtio_gpu_update_dmabuf(g, scanout_id, res, fb, r)) {
> -                virtio_gpu_update_scanout(g, scanout_id, res, fb, r);
> -            } else {
> +            if (virtio_gpu_update_dmabuf(g, scanout_id, res, fb, r)) {
>                   *error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
>                   return false;
>               }
> +            virtio_gpu_update_scanout(g, scanout_id, res, fb, r);
>               return true;
>           }
>   
> @@ -702,7 +703,8 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
>       }
>   
>       /* create a surface for this scanout */
> -    if ((res->blob && !qemu_console_has_gl(scanout->con)) ||
> +    if (was_dmabuf ||
> +        (res->blob && !qemu_console_has_gl(scanout->con)) ||
>           !scanout->ds ||
>           surface_data(scanout->ds) != data + fb->offset ||
>           scanout->width != r->width ||
> @@ -727,6 +729,9 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
>           qemu_displaysurface_set_share_handle(scanout->ds, res->share_handle, fb->offset);
>   
>           pixman_image_unref(rect);
> +        if (was_dmabuf) {
> +            virtio_gpu_release_scanout_dmabuf(g, scanout_id);
> +        }
>           qemu_console_set_surface(g->parent_obj.scanout[scanout_id].con,
>                                   scanout->ds);
>       }
> 


