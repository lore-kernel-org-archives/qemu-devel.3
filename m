Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C566C61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 09:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzABS-0005CP-ID; Wed, 26 Aug 2026 05:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wzABQ-000574-4Y
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 05:44:36 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wzABN-0004Qp-7M
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 05:44:35 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67Q9iK4h024373
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 26 Aug 2026 18:44:21 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=j8pmMdcM38PKeh0P/vMG4nzYiWK53UQl8RElUgwoDWE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1787737461; v=1;
 b=wRKX83pGm0o8jemj7CicB6y5QA1YlSb0yD6QjuznmolRFyWFknYJMjEnWp66hfQg
 2wX+R295NTUH+1zmOO/03s1XDmh1Gj0scS9yk92OujmWB7mq7arl+WLYVA3IhiWb
 QDl9YTkbeiZY39iEvxRtnYL0Zptx+qtdzsOnnV1o2nnkF9nC+JhurYsDS/h3xbX2
 a085CBPDO+jpVQgKDGH6ZMN2H+hCXx4W+rUH6A15wAMZiiXvYd5CPIXNgHMKFWZW
 igm/9Sif/QbUsjRsUNLzHsYu5Jy/PImdg7hoA7eyWmfF11t96dStiozFTKzd0Huz
 9+zbjqVZnPxDSvQgZBrdtA==
Message-ID: <9da790ca-4b49-4393-83ae-6b782fd28eae@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 26 Aug 2026 18:44:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/18] virtio-gpu-rutabaga: fix scanout handling
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Alex Williamson
 <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260825-virtio-gpu-cleanup-v1-0-d3bb612b9975@redhat.com>
 <20260825-virtio-gpu-cleanup-v1-9-d3bb612b9975@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260825-virtio-gpu-cleanup-v1-9-d3bb612b9975@redhat.com>
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
> The rutabaga backend was misusing the scanout_bitmask field as a
> plain scanout ID instead of a bitmask.
> 
> Fix the scanout lookup to use scanout->resource_id directly. Also
> fix the missing resource_id clear when disabling a scanout, and
> flush all matching scanouts instead of just the first one.
> 

Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for 
gfxstream")

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/virtio-gpu-rutabaga.c | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
> index a054f8117f14..fcd9c94d580c 100644
> --- a/hw/display/virtio-gpu-rutabaga.c
> +++ b/hw/display/virtio-gpu-rutabaga.c
> @@ -154,8 +154,15 @@ virtio_gpu_rutabaga_resource_unref(VirtIOGPU *g,
>                                      Error **errp)
>   {
>       int32_t result;
> +    int i;
>       VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
>   
> +    for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
> +        if (g->parent_obj.scanout[i].resource_id == res->resource_id) {
> +            virtio_gpu_disable_scanout(g, i);
> +        }
> +    }
> +
>       result = rutabaga_resource_unref(vr->rutabaga, res->resource_id);
>       if (result) {
>           error_setg_errno(errp,
> @@ -259,7 +266,7 @@ rutabaga_cmd_resource_flush(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
>   
>       for (i = 0; i < vb->conf.max_outputs; i++) {
>           scanout = &vb->scanout[i];
> -        if (i == res->scanout_bitmask) {
> +        if (scanout->resource_id == res->resource_id) {
>               found = true;
>               break;
>           }
> @@ -283,7 +290,13 @@ rutabaga_cmd_resource_flush(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
>                                                rf.resource_id, &transfer,
>                                                &transfer_iovec);
>       CHECK(!result, cmd);
> -    qemu_console_update_full(scanout->con);
> +
> +    for (i = 0; i < vb->conf.max_outputs; i++) {
> +        scanout = &vb->scanout[i];
> +        if (scanout->resource_id == res->resource_id) {
> +            qemu_console_update_full(scanout->con);
> +        }
> +    }
>   }
>   
>   static void
> @@ -307,6 +320,7 @@ rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
>       scanout = &vb->scanout[ss.scanout_id];
>   
>       if (ss.resource_id == 0) {
> +        scanout->resource_id = 0;
>           qemu_console_set_surface(scanout->con, NULL);
>           qemu_console_gl_scanout_disable(scanout->con);
>           return;
> @@ -340,7 +354,7 @@ rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
>       scanout->ds = qemu_create_displaysurface_pixman(res->image);
>       qemu_console_set_surface(scanout->con, NULL);
>       qemu_console_set_surface(scanout->con, scanout->ds);
> -    res->scanout_bitmask = ss.scanout_id;
> +    scanout->resource_id = ss.resource_id;
>   }
>   
>   static void
> 


