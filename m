Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5107FE67A60
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 04:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxHPk-0005IT-L3; Mon, 02 Mar 2026 23:31:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxHPi-0005I4-9R
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 23:31:18 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxHPe-0008Ks-Uj
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 23:31:18 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6234Ubdu052300
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 3 Mar 2026 13:30:45 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=whds1zuv6LLiTOQCq4HTNCMu0YkaFA4L5HxZ/MVJIN8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1772512246; v=1;
 b=Ya1vL5ZyQ5/OS3r9oFZntpMsj0H59DJc+D28xfEaiN6VFDdbYqCJH0HmIjSuUP4w
 U4O+gt5j+FihZJWvQ+z7iQbInp/C1wQJMSkziTG/D4xbEOz490gEzod+vMNzHj9w
 Dm8IlJovEPi2e7FKISWKWuCQl0vn5Tn8ZFvNZMjxfHi6/SfphnIUV8edxNhMpMVz
 4h6P0skBjcMZvurDW0uvIM4LoEdQFiG1ONSXOvI1B2YM1flxGyi+i62+GoPNmuGN
 RDQq4ymk4UOBB3mAhaow6rBcWiY4RP0pyuhHOkbzl/mMeeLTCXOE92wo6sNLpO/5
 monDoOtPVsNQcl7dHNH+ag==
Message-ID: <063213ce-204e-4c05-8bbb-4a2ec1a8e5cc@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 3 Mar 2026 13:30:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 07/18] virtio-gpu: Ensure BHs are invoked only from
 main-loop thread
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yiwei Zhang <zzyiwei@gmail.com>,
 Sergio Lopez Pascual <slp@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>,
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>,
 Rob Clark <robdclark@gmail.com>, Robert Beckett <bob.beckett@collabora.com>
References: <20260302145920.735423-1-dmitry.osipenko@collabora.com>
 <20260302145920.735423-8-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260302145920.735423-8-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/03/02 23:59, Dmitry Osipenko wrote:
> QEMU's display GL core is tied to main-loop thread and virtio-gpu
> interacts with display while processing GPU commands. Virtio-gpu BHs
> work in generic AIO context that can be invoked on vCPU thread, while
> GL and UI toolkits are bound to the main-loop thread.
> 
> Make virtio-gpu BHs use iohandler AIO context that is handled in a
> main-loop thread only.
> 
>   0  SDL_GL_MakeCurrent() (libSDL3)
>   1  SDL_GL_MakeCurrent_REAL() (libSDL2)
>   2  sdl2_gl_make_context_current() (ui/sdl2-gl.c:201)
>   3  make_current() (virglrenderer.c:639)
>   4  vrend_finish_context_switch() (vrend_renderer.c:11630)
>   5  vrend_hw_switch_context() (vrend_renderer.c:11613)
>   6  vrend_renderer_force_ctx_0() (vrend_renderer.c:12986)
>   7  virgl_renderer_force_ctx_0() (virglrenderer.c:460)
>   8  virtio_gpu_virgl_process_cmd() (virtio-gpu-virgl.c:1013)
>   9  virtio_gpu_process_cmdq() (virtio-gpu.c:1050)
>   10 virtio_gpu_gl_handle_ctrl() (virtio-gpu-gl.c:86)
>   11 aio_bh_poll() (util/async.c)
>   12 aio_poll() (util/aio-posix.c)
>   13 blk_pwrite() (block/block-gen.c:1985)
>   14 pflash_update() (pflash_cfi01.c:396)
>   15 pflash_write() (pflash_cfi01.c:541)
>   16 memory_region_dispatch_write() (system/memory.c:1554)
>   17 flatview_write() (system/physmem.c:3333)
>   18 address_space_write() (system/physmem.c:3453)
>   19 kvm_cpu_exec() (accel/kvm/kall-all.c:3248)
>   20 kvm_vcpu_thread_fn() (accel/kvm/kaccel-ops.c:53)
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   hw/display/virtio-gpu-virgl.c | 4 +---
>   hw/display/virtio-gpu.c       | 6 +++---
>   include/hw/virtio/virtio.h    | 7 +++++++
>   3 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 0f754829fb71..97baf9b8ca96 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -1203,9 +1203,7 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>       }
>   
>   #if VIRGL_VERSION_MAJOR >= 1
> -    gl->cmdq_resume_bh = aio_bh_new(qemu_get_aio_context(),
> -                                    virtio_gpu_virgl_resume_cmdq_bh,
> -                                    g);
> +    gl->cmdq_resume_bh = virtio_bh_io_new(virtio_gpu_virgl_resume_cmdq_bh, g);
>   #endif
>   
>       return 0;
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 643e91ca2a7a..0d88e7b3cdff 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1526,9 +1526,9 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>   
>       g->ctrl_vq = virtio_get_queue(vdev, 0);
>       g->cursor_vq = virtio_get_queue(vdev, 1);
> -    g->ctrl_bh = virtio_bh_new_guarded(qdev, virtio_gpu_ctrl_bh, g);
> -    g->cursor_bh = virtio_bh_new_guarded(qdev, virtio_gpu_cursor_bh, g);
> -    g->reset_bh = qemu_bh_new(virtio_gpu_reset_bh, g);
> +    g->ctrl_bh = virtio_bh_io_new(virtio_gpu_ctrl_bh, g);
> +    g->cursor_bh = virtio_bh_io_new(virtio_gpu_cursor_bh, g);
> +    g->reset_bh = virtio_bh_io_new(virtio_gpu_reset_bh, g);
>       qemu_cond_init(&g->reset_cond);
>       QTAILQ_INIT(&g->reslist);
>       QTAILQ_INIT(&g->cmdq);
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 9dd93cf965ae..bc1ddd3bc4e0 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -547,4 +547,11 @@ QEMUBH *virtio_bh_new_guarded_full(DeviceState *dev,
>   #define virtio_bh_new_guarded(dev, cb, opaque) \
>       virtio_bh_new_guarded_full((dev), (cb), (opaque), (stringify(cb)))
>   
> +/*
> + * The "_io" variant runs BH only on a main-loop thread, while generic BH
> + * may run on a vCPU thread.
> + */
> +#define virtio_bh_io_new(cb, opaque) \
> +    aio_bh_new(iohandler_get_aio_context(), (cb), (opaque))
> +

The reentrancy guard virtio_bh_new_guarded() implements should be preserved.

Regards,
Akihiko Odaki

>   #endif


