Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48364C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzbDN-00050A-Cx; Thu, 27 Aug 2026 10:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wzbDJ-0004qF-ID
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:36:23 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wzbDE-0002Ng-JD
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:36:20 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67REa3pM018382
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 27 Aug 2026 23:36:03 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=kPDkvTU/bBottwQtx1K3yyy9m8TgyneXaOFGyLdtMWo=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1787841363; v=1;
 b=YDUFAHvXcFYzrWt9vOBraytIaru8LcJSbJlkgRz3TbeMhb2MKiCrTt2EoSQT62FI
 EuQTO9On0+WMASHSF4hsdJ/CbRUVm2YIdd2QvqsNiN6wfIU/RtOV8urAbNC+C3iO
 Qa48wrAgZKQcyZwPMspTVph7fuGkDfWz6pNBQLnM60E8KBEzMnW607/0FzF3yD5X
 x8537l6HphvuwWwCGxfm5LIJJbqX98K6JPny/hkij/Qy3bwmg9fzlpVVmGXBF1sk
 OfYQu6VERdnTGr6etHtT8N3tMcrzsv+s6WBO2S/KZ06wkn4QdJowISZgGdj0m2nH
 uFglSk7M2618XqIRlnnFrw==
Message-ID: <2c793637-1bdf-4cf3-bb7a-72430185c496@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 27 Aug 2026 23:36:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/18] virtio-gpu/virgl: disable scanouts on resource unref
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Alex Williamson
 <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260825-virtio-gpu-cleanup-v1-0-d3bb612b9975@redhat.com>
 <20260825-virtio-gpu-cleanup-v1-16-d3bb612b9975@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260825-virtio-gpu-cleanup-v1-16-d3bb612b9975@redhat.com>
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
> Disable scanouts referencing a resource being unreferenced.
> 

Fixes: 9d9e152136bd ("virtio-gpu: add 3d mode and virgl rendering support.")

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/virtio-gpu-virgl.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index e2ad27343da5..8b27fe3980d6 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -412,6 +412,7 @@ virtio_gpu_virgl_resource_unref(VirtIOGPU *g,
>   {
>       struct iovec *res_iovs = NULL;
>       int num_iovs = 0;
> +    int i;
>   #if VIRGL_VERSION_MAJOR >= 1
>       int ret;
>   
> @@ -424,6 +425,12 @@ virtio_gpu_virgl_resource_unref(VirtIOGPU *g,
>       }
>   #endif
>   
> +    for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
> +        if (g->parent_obj.scanout[i].resource_id == res->base.resource_id) {
> +            virtio_gpu_disable_scanout(g, i);

This invokes synchronous frontend callbacks. GTK/EGL can finish with 
EGL_NO_CONTEXT, while GLArea leaves its widget context current. The 
function then calls virgl_renderer_resource_unref(), which directly 
performs GL object deletion.

Please add virgl_renderer_force_ctx_0() after the complete disable loop, 
before detach/unref. This guarantees a valid renderer context and 
resynchronizes virglrenderer’s cached context state. Without it, 
guest-triggered RESOURCE_UNREF can cause undefined GL calls or host 
GPU-resource leakage.

Regards,
Akihiko Odaki

> +        }
> +    }
> +
>       virgl_renderer_resource_detach_iov(res->base.resource_id,
>                                          &res_iovs,
>                                          &num_iovs);
> 


