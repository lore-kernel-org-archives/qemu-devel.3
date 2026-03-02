Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2D1D58E5D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 05:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwwIb-0000m8-5u; Mon, 02 Mar 2026 00:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vwwIY-0000kS-OB
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 00:58:30 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vwwIV-0003Hr-M8
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 00:58:30 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6225vhQ0024972
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 2 Mar 2026 14:57:52 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=oR9kWT5n3qIUm/Mp/uVNy//JKrDDAObV7Puw3z7oIXw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1772431072; v=1;
 b=pc3in3rzRg1LAzqfqoT4OKc8TX3bWT6U6FNOmMFacnklLQ89xJlKFsqSo1I6JeNS
 2m9I+JX+y9aJmAl9BFis843DB5KUDJ/iDu77emnNVELTkrXtlQxUGNFu1lhx+h7C
 mz4sPYNkUR2B/CvxTtfQdyJX7aX6NibOuYHmreC52SQKWTlZpFEWjNF/RicNWNMu
 jWPTHZavMoO6UJUGmANwl0qG8aEqErW+zfV3gLbKNtUnXNOkVRyXW6UMO1OuO09X
 LZGyFuKuprHCqViltyBFAtCxxN2sn/UbXrkev2DVQOnHUVhAuYkmB6s4DidVqztN
 uUOZhA+0MnRxvV61FU/8kg==
Message-ID: <87bcde7a-1052-45ec-9d09-78bf875c2d46@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 2 Mar 2026 14:57:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 10/21] virtio-gpu: Bounce virtio_gpu_ctrl_bh() to
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
References: <20260301204838.596994-1-dmitry.osipenko@collabora.com>
 <20260301204838.596994-11-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260301204838.596994-11-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188, SPF_HELO_NONE=0.001,
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

On 2026/03/02 5:48, Dmitry Osipenko wrote:
> QEMU's display GL core is tied to main-loop thread and virtio-gpu
> interacts with display while processing GPU commands. virtio_gpu_ctrl_bh()
> works in generic AIO context that can be processed from vCPU thread, while
> GL and UI toolkits are bound to the main-loop thread. Bounce the ctrl-bh
> execution if running from a thread other than main to fix the problem.

I think you can make use of iohandler_get_aio_context() instead of bouncing.

Regards,
Akihiko Odaki

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
>   hw/display/virtio-gpu.c        | 12 +++++++++++-
>   include/hw/virtio/virtio-gpu.h |  2 ++
>   2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 643e91ca2a7a..d0737cbba8a2 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1126,7 +1126,16 @@ static void virtio_gpu_ctrl_bh(void *opaque)
>       VirtIOGPU *g = opaque;
>       VirtIOGPUClass *vgc = VIRTIO_GPU_GET_CLASS(g);
>   
> -    vgc->handle_ctrl(VIRTIO_DEVICE(g), g->ctrl_vq);
> +    /*
> +     * Bounce handling to main-loop thread as display UI toolkit
> +     * and GL context are bounded there.
> +     */
> +    if (qemu_get_thread_id() == g->thread_id) {
> +        vgc->handle_ctrl(VIRTIO_DEVICE(g), g->ctrl_vq);
> +    } else {
> +        aio_bh_schedule_oneshot(qemu_get_aio_context(),
> +                                virtio_gpu_ctrl_bh, g);
> +    }
>   }
>   
>   static void virtio_gpu_handle_cursor(VirtIODevice *vdev, VirtQueue *vq)
> @@ -1533,6 +1542,7 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>       QTAILQ_INIT(&g->reslist);
>       QTAILQ_INIT(&g->cmdq);
>       QTAILQ_INIT(&g->fenceq);
> +    g->thread_id = qemu_get_thread_id();
>   }
>   
>   static void virtio_gpu_device_unrealize(DeviceState *qdev)
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 58e0f91fda65..d3bd8ed0d28a 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -218,6 +218,8 @@ struct VirtIOGPU {
>       } dmabuf;
>   
>       GArray *capset_ids;
> +
> +    int thread_id;
>   };
>   
>   struct VirtIOGPUClass {


