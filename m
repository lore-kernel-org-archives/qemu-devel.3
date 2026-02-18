Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7F0E9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 06:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsafN-0007kP-9q; Wed, 18 Feb 2026 01:04:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vsafI-0007jZ-Gv
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 01:04:01 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vsafF-0008DC-JM
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 01:04:00 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61I630S0014866
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 18 Feb 2026 15:03:24 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=WZ1XHjBgD6Nyjrh98YMdo7FQoH9ohUu2PKz8g+f7c3o=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1771394605; v=1;
 b=lRW/8eJAy+bcgw+uRTpOhy8pLVUaAmdG28VtlDZ+aEcZ5LFnHOtY3C95CT1xbfgG
 6F2uR6eoPVzlbeSChwakYRSB0b+nU1sTiiO2sp44sOGYOjBckvc/M482ozbq2yvD
 Grbimeufj8Wwq3bDlFYd1CECyeeLP0u8UEmWraX/LCudB5rVH52mB97EZYzm1fox
 r9aBlcn8O6ifPq3S1i7Y4/4vtfyX171oLE9AcEb5SOEsPEGgKdRkYGzFoDsQL+c/
 Ixc2htb+eORdOhOjjZHhZAEb3+xYqCZGggsc2daylvTt60hsIJeV7/LTD0Kqfmtr
 h8N8Pi4yVgNIVDYDiXGGIg==
Message-ID: <d36a0608-e1d9-44a0-87c4-26b4501a41ca@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 18 Feb 2026 15:02:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 07/19] virtio-gpu: Unset context after GL operations
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
References: <20260217214928.2970885-1-dmitry.osipenko@collabora.com>
 <20260217214928.2970885-8-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260217214928.2970885-8-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2026/02/18 6:49, Dmitry Osipenko wrote:
> VirtIO-GPU commands may be processed outside of main-loop, from a CPU
> thread. This results in GL context switch failure because context is held
> by main-loop thread when GL is invoked from CPU thread. Always release GL
> context after performing GL operations such that other threads could take
> over the context.
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
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   hw/display/virtio-gpu-virgl.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 0f754829fb71..0021df45d4b2 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -896,14 +896,20 @@ static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
>   }
>   #endif
>   
> -void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
> -                                      struct virtio_gpu_ctrl_command *cmd)
> +static void virtio_gpu_virgl_unset_ctx_0(VirtIOGPU *g)
> +{
> +    /* Virglrender always uses first scanout for GL. */
> +    dpy_gl_ctx_make_current(g->parent_obj.scanout[0].con, NULL);

"unset_ctx_0" is a misnomer. It uses the scanout with index 0, but "0" 
in virgl_renderer_force_ctx_0() refers to a context, not scanout.

virglrenderer creates multiple contexts; it creates contexts as the 
guest requests, and also creates one special context that performs 
operations not bound to the contexts the guest requested to create. The 
special context is called "ctx_0".

When unsetting a context, it does not matter what context is currently 
set, so it should just say "ctx", not "ctx_0".

By the way, writing this email, I found the use of phrase "setting a 
context" is unusual. "Binding" is more conventional, and that's what the 
EGL specification uses for eglMakeCurrent(). So, this function should be 
named "unbind_ctx" or something like that.

Regards,
Akihiko Odaki

