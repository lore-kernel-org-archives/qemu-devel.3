Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DE8E83856
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 06:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsEfF-0006QD-7R; Tue, 17 Feb 2026 01:34:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vsEf7-0006Pj-9q
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 01:34:22 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vsEf4-0004Qd-5m
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 01:34:21 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61H6WCtF029340
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 17 Feb 2026 15:33:42 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=P/4xLX2g/W1/mYaojAwyVVHOpMfF05ph5kUzJocPcDw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1771310023; v=1;
 b=VNHOxBgma63YQ9cVF5dzDifNIfXbRf8nS17he2iNCE6rbBx83MDHT/CmHVkYnnYv
 v/2QICfW7BZ0L3C9TakSrjnzIuJxWP2PA7DVD9xFdOnoCtS6qIDgYEzjciSD6iH5
 kNfolaxfmUFJp4bk38Bqu3J3gjU97azh0EfeuDf5Aof9PJVfK9w6hJPlmeGSgXP3
 Rw+L/6ZBF+t/hoYUylEob2wJC689fOaCeGcE843WorslqSHLKjWvvXLsVazU5VjG
 jfqkiHwBVztoYPCTmFmE9i4qA4/BCeYIBUb0AQOyXAYvBbQbDl7nUNP/h2kKtkMA
 21oyS46QJel5v09vc79Y7Q==
Message-ID: <9116c5dd-d0ee-4a6e-b318-bbd410ad09ee@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 17 Feb 2026 15:32:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 06/18] virtio-gpu: Unset context after GL operations
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
References: <20260216191213.2556073-1-dmitry.osipenko@collabora.com>
 <20260216191213.2556073-7-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260216191213.2556073-7-dmitry.osipenko@collabora.com>
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

On 2026/02/17 4:12, Dmitry Osipenko wrote:
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
>   hw/display/virtio-gpu-virgl.c | 21 ++++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 0f754829fb71..cde1a7a8426f 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -896,14 +896,19 @@ static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
>   }
>   #endif
>   
> -void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
> -                                      struct virtio_gpu_ctrl_command *cmd)
> +static void virtio_gpu_virgl_unset_gl_context(void)
> +{
> +    dpy_gl_ctx_make_current(qemu_console_lookup_default(), NULL);

An appropriate console needs to be selected as 
virgl_make_context_current() does.

> +}
> +
> +static void
> +virtio_gpu_virgl_do_process_cmd(VirtIOGPU *g,

Although it is a common practice to differentiate functions with having 
a word like "do", I see it as a bad one. The word conveys no meaning at 
all. A more descriptive phrase like "with_ctx" may be better.

Regards,
Akihiko Odaki

> +                                struct virtio_gpu_ctrl_command *cmd)
>   {
>       bool cmd_suspended = false;
>   
>       VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
>   
> -    virgl_renderer_force_ctx_0();
>       switch (cmd->cmd_hdr.type) {
>       case VIRTIO_GPU_CMD_CTX_CREATE:
>           virgl_cmd_context_create(g, cmd);
> @@ -1010,6 +1015,14 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>       virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
>   }
>   
> +void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
> +                                  struct virtio_gpu_ctrl_command *cmd)
> +{
> +    virgl_renderer_force_ctx_0();
> +    virtio_gpu_virgl_do_process_cmd(g, cmd);
> +    virtio_gpu_virgl_unset_gl_context();
> +}
> +
>   static void virgl_write_fence(void *opaque, uint32_t fence)
>   {
>       VirtIOGPU *g = opaque;
> @@ -1136,8 +1149,10 @@ static void virtio_gpu_fence_poll(void *opaque)
>       VirtIOGPU *g = opaque;
>       VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
>   
> +    virgl_renderer_force_ctx_0();
>       virgl_renderer_poll();
>       virtio_gpu_process_cmdq(g);
> +    virtio_gpu_virgl_unset_gl_context();
>       if (!QTAILQ_EMPTY(&g->cmdq) || !QTAILQ_EMPTY(&g->fenceq)) {
>           timer_mod(gl->fence_poll, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 10);
>       }


