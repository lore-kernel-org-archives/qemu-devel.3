Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E80C606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=MCNMqfOS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVUu0-0006og-UB; Mon, 23 Nov 2026 09:20:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xVUtx-0006mO-Ew
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 09:20:13 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xVUtu-0005ij-GV
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 09:20:13 -0500
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6ANEJwsY010558
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 23 Nov 2026 23:19:59 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=056VUd8ZtKJ4vpYqdL+Vr8KMg8gNNQ9GI6+p0yS2Q2g=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1795443599; v=1;
 b=MCNMqfOS0OQLFR2rv01h+lOWz3krrM6nxRZ4Y44Kd6Rj2Rp0Xz6JDjt7WNo4R2h2
 Ss9F03b9X4hVaMsZXqDNd/UkKnuijT3jjD7FJR31yFxnuhQHIvPxU4GQTY6UkKbY
 inalZ8nt/cCkeIP1ZKBQV/Sa9qQN+1mDeOp0j9OIw8TCwg/PVyuEQICUHcPxyVxR
 U6Yl29Lf1HXRhPOUt+LtU7siC/Zp7WSrDbP4TJcz6Sdas67nq0BG7t0QXgsxrSGr
 JQydPVgch+oi28fHslGhksx2rpmESwtLJVD48D4IbvD/JpjUBZksIDMqJXtsSk7c
 4/pXySINLIiety5HZ9/Wnw==
Message-ID: <4e967876-d729-40cb-a7e8-a6ba08783f44@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 23 Nov 2026 23:19:57 +0900
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH] virtio-gpu: run scanout reset cleanup on the main loop
 thread
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, meng ou <oumeng086@gmail.com>
References: <CAPSUqz14daiP8DvLBzcMwBzmpCmMe9B25Q2CFO6s8joCnfW-_Q@mail.gmail.com>
 <CAJ+F1CL4prP0P6g305J1ATXHq1bUKamLZfwEdmWiTv33QrAPyQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJ+F1CL4prP0P6g305J1ATXHq1bUKamLZfwEdmWiTv33QrAPyQ@mail.gmail.com>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026/11/17 5:19, Marc-André Lureau wrote:
> Akihiko
> 
> On Mon, Oct 26, 2026 at 4:58 PM meng ou <oumeng086@gmail.com> wrote:
>>
>> virtio-gpu: run scanout reset cleanup on the main loop thread
>>
>> virtio_gpu_gl_reset() executes in the context of the thread that wrote the
>> device reset register, i.e. a TCG vCPU thread.  It calls
>> virtio_gpu_virgl_reset_scanout() -> egl_scanout_disable() ->
>> egl_fb_destroy() -> glDeleteFramebuffers(), which requires the display EGL
>> context to be current on that thread.  It is not:
>>
>>    #01 egl_fb_destroy                ui/egl-helpers.c
>>    #02 egl_scanout_disable           ui/egl-headless.c
>>    #04 virtio_gpu_virgl_reset_scanout
>>    #05 virtio_gpu_gl_reset           hw/display/virtio-gpu-gl.c
>>    #11 do_st_mmio_leN                accel/tcg/cputlb.c
>>
>> Hosts whose GL implementation dereferences the missing context crash.  This
>> was reproduced on Android/aarch64 with both zink and llvmpipe, which makes
>> it a threading bug rather than a driver bug.
>>
>> Defer the cleanup to the main loop: add a VirtIOGPUClass reset_scanout
>> callback, invoke it from the existing virtio_gpu_reset_bh() before
>> reset_finished is signalled, and reduce virtio_gpu_gl_reset() to setting
>> renderer_state to RS_RESET.
>>
>> Signed-off-by: oumeng <q15817976513@163.com>
> 
> This look related to your fixes
> https://patchew.org/QEMU/20260908-gpu-v3-0-25332a85f909@rsg.ci.i.u-tokyo.ac.jp/
> can you take a look?

This patch and my series attempt to address the same issue, though their 
scopes differ. This patch has a narrower scope, but it covers one thing 
my series missed: the virtio_gpu_virgl_reset_scanout() call inside 
virtio_gpu_gl_reset().

Please note that this change leaves g unused in virtio_gpu_gl_reset(), 
which will break a -Werror build.

One issue common to both this patch and my series is that neither 
currently applies cleanly to master. Reworking my series may take a 
while, as the changes are quite involved and I have been busy recently.

Regards,
Akihiko Odaki

> 
> thanks
> 
>> ---
>>   hw/display/virtio-gpu-gl.c     | 13 ++++++++++++-
>>   hw/display/virtio-gpu.c        |  5 +++++
>>   include/hw/virtio/virtio-gpu.h |  1 +
>>   3 files changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
>> index 2b7a41c..9a93fdf 100644
>> --- a/hw/display/virtio-gpu-gl.c
>> +++ b/hw/display/virtio-gpu-gl.c
>> @@ -99,7 +99,8 @@ static void virtio_gpu_gl_reset(VirtIODevice *vdev)
>>        * thread, and when the renderer is unblocked.
>>        */
>>       if (gl->renderer_state == RS_INITED) {
>> -        virtio_gpu_virgl_reset_scanout(g);
>> +        /* scanout cleanup is deferred to virtio_gpu_reset_bh() which runs
>> +         * on the main loop thread (reset_scanout class callback). */
>>           gl->renderer_state = RS_RESET;
>>       }
>>   }
>> @@ -209,6 +210,15 @@ static void
>> virtio_gpu_gl_device_unrealize(DeviceState *qdev)
>>        */
>>   }
>>
>> +static void virtio_gpu_gl_reset_scanout(VirtIOGPU *g)
>> +{
>> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
>> +
>> +    if (gl->renderer_state == RS_INITED) {
>> +        virtio_gpu_virgl_reset_scanout(g);
>> +    }
>> +}
>> +
>>   static void virtio_gpu_gl_class_init(ObjectClass *klass, const void *data)
>>   {
>>       DeviceClass *dc = DEVICE_CLASS(klass);
>> @@ -222,6 +232,7 @@ static void virtio_gpu_gl_class_init(ObjectClass
>> *klass, const void *data)
>>       vgc->update_cursor_data = virtio_gpu_gl_update_cursor_data;
>>
>>       vgc->resource_destroy = virtio_gpu_virgl_resource_destroy;
>> +    vgc->reset_scanout = virtio_gpu_gl_reset_scanout;
>>       vdc->realize = virtio_gpu_gl_device_realize;
>>       vdc->unrealize = virtio_gpu_gl_device_unrealize;
>>       vdc->reset = virtio_gpu_gl_reset;
>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>> index 5d43ffb..4a2789f 100644
>> --- a/hw/display/virtio-gpu.c
>> +++ b/hw/display/virtio-gpu.c
>> @@ -1841,6 +1841,11 @@ static void virtio_gpu_reset_bh(void *opaque)
>>           qemu_console_set_surface(g->parent_obj.scanout[i].con, NULL);
>>       }
>>
>> +    /* scanout/GL cleanup must run here, on the main loop thread */
>> +    if (vgc->reset_scanout) {
>> +        vgc->reset_scanout(g);
>> +    }
>> +
>>       g->reset_finished = true;
>>       qemu_cond_signal(&g->reset_cond);
>>   }
>> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
>> index 631dfc6..91072b0 100644
>> --- a/include/hw/virtio/virtio-gpu.h
>> +++ b/include/hw/virtio/virtio-gpu.h
>> @@ -234,6 +234,7 @@ struct VirtIOGPUClass {
>>       void (*resource_destroy)(VirtIOGPU *g,
>>                                struct virtio_gpu_simple_resource *res,
>>                                Error **errp);
>> +    void (*reset_scanout)(VirtIOGPU *g);
>>   };
>>
>>   struct virtio_gpu_virgl_context_fence {
>> --
>> 2.53.0
>>
> 
> 

