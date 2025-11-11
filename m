Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C54FCCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 12:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vInUl-0000RT-4E; Tue, 11 Nov 2025 07:29:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vInTx-0008QN-Bj
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 07:28:28 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vInTt-0002mG-BL
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 07:28:20 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1762864077; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MbFm8B9QIF57OBa9Ot8v0HJa00Ukhr0v7wiHDMPLxsSpzks1Y2avmi9sXYv4oizBy/Kr2o7b8hfxQlW8GaNH6XiXhX0WdE+XLZ9rZ/a8E0XIipxm3fE2L6kl/Xs521K39QiqQNtE2XCUwq9c4jgfIqTpe2rPid6TzUcMn0OL7wM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1762864077;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ylUqIarbGf+7DK4gKzBv0KxwyIjQhRoxGDe5/6gix0Y=; 
 b=L0OSIy/hk0/IG7cqltazC+pYiRy5AF2YV8zxToAfTDFbgc+mv9WUbGrfLAekMtseRqIwn9IaW8kZEGU6czRyPKtQMP/ji02WmRIuEKDGZIaJDEmrEZcOv4ElZzAWDZWXSZ3wrCMnRA4j4aq/mHj9sRVosp6KN6UnBI2rJRERUyg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762864077; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=ylUqIarbGf+7DK4gKzBv0KxwyIjQhRoxGDe5/6gix0Y=;
 b=DM9GgDgyBLUQ80cEwlVGOiSrssCMs1P8RdgincJt6DCwfZN9RPDS4zGs84KeZgFA
 Fi1KxqmL6WDcMdxOrz4/sEZTxxTx8d1QyfWxFXXxjnNvpVOA/j9z5ZGfvkQXLA55a8A
 +8U0CLiERkWM73ydwOUV4S9eeQgPUDgi1182JJ7A=
Received: by mx.zohomail.com with SMTPS id 176286407551846.49917102360757;
 Tue, 11 Nov 2025 04:27:55 -0800 (PST)
Message-ID: <f2c322f2-c111-455d-a8b5-17162effac09@collabora.com>
Date: Tue, 11 Nov 2025 15:27:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 04/10] virtio-gpu: Support asynchronous fencing
To: Yiwei Zhang <zzyiwei@gmail.com>
Cc: Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Sergio Lopez Pascual <slp@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20251020233949.506088-1-dmitry.osipenko@collabora.com>
 <20251020233949.506088-5-dmitry.osipenko@collabora.com>
 <CAJ+hS_h4gwe+yaUrcQ5ibdEAFqya=SOb4KLT5HmgG_ZGtJnMSQ@mail.gmail.com>
 <CAJ+hS_gPoaSc-VfoOENgyHZRhFAkUzizoGHm3xJz2trb0jsZAg@mail.gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAJ+hS_gPoaSc-VfoOENgyHZRhFAkUzizoGHm3xJz2trb0jsZAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 11/11/25 05:29, Yiwei Zhang wrote:
> On Sat, Nov 8, 2025 at 3:56 AM Yiwei Zhang <zzyiwei@gmail.com> wrote:
>>
>> On Mon, Oct 20, 2025 at 4:42 PM Dmitry Osipenko
>> <dmitry.osipenko@collabora.com> wrote:
>>>
>>> Support asynchronous fencing feature of virglrenderer. It allows Qemu to
>>> handle fence as soon as it's signalled instead of periodically polling
>>> the fence status. This feature is required for enabling DRM context
>>> support in Qemu because legacy fencing mode isn't supported for DRM
>>> contexts in virglrenderer.
>>>
>>> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>> Tested-by: Alex Bennée <alex.bennee@linaro.org>
>>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> ---
>>>  hw/display/virtio-gpu-gl.c     |   5 ++
>>>  hw/display/virtio-gpu-virgl.c  | 130 +++++++++++++++++++++++++++++++++
>>>  include/hw/virtio/virtio-gpu.h |  11 +++
>>>  meson.build                    |   2 +
>>>  4 files changed, 148 insertions(+)
>>>
>>> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
>>> index c06a078fb36a..1468c6ed1467 100644
>>> --- a/hw/display/virtio-gpu-gl.c
>>> +++ b/hw/display/virtio-gpu-gl.c
>>> @@ -169,6 +169,11 @@ static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
>>>      if (gl->renderer_state >= RS_INITED) {
>>>  #if VIRGL_VERSION_MAJOR >= 1
>>>          qemu_bh_delete(gl->cmdq_resume_bh);
>>> +
>>> +        if (gl->async_fence_bh) {
>>> +            virtio_gpu_virgl_reset_async_fences(g);
>>> +            qemu_bh_delete(gl->async_fence_bh);
>>> +        }
>>>  #endif
>>>          if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
>>>              timer_free(gl->print_stats);
>>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
>>> index cd8b367f6fa6..0320d6deca76 100644
>>> --- a/hw/display/virtio-gpu-virgl.c
>>> +++ b/hw/display/virtio-gpu-virgl.c
>>> @@ -24,6 +24,23 @@
>>>
>>>  #include <virglrenderer.h>
>>>
>>> +/*
>>> + * VIRGL_CHECK_VERSION available since libvirglrenderer 1.0.1 and was fixed
>>> + * in 1.1.0. Undefine bugged version of the macro and provide our own.
>>> + */
>>> +#if defined(VIRGL_CHECK_VERSION) && \
>>> +    VIRGL_VERSION_MAJOR == 1 && VIRGL_VERSION_MINOR < 1
>>> +#undef VIRGL_CHECK_VERSION
>>> +#endif
>>> +
>>> +#ifndef VIRGL_CHECK_VERSION
>>> +#define VIRGL_CHECK_VERSION(major, minor, micro) \
>>> +    (VIRGL_VERSION_MAJOR > (major) || \
>>> +     VIRGL_VERSION_MAJOR == (major) && VIRGL_VERSION_MINOR > (minor) || \
>>> +     VIRGL_VERSION_MAJOR == (major) && VIRGL_VERSION_MINOR == (minor) && \
>>> +     VIRGL_VERSION_MICRO >= (micro))
>>> +#endif
>>> +
>>>  struct virtio_gpu_virgl_resource {
>>>      struct virtio_gpu_simple_resource base;
>>>      MemoryRegion *mr;
>>> @@ -1051,6 +1068,106 @@ static void virgl_write_context_fence(void *opaque, uint32_t ctx_id,
>>>  }
>>>  #endif
>>>
>>> +void virtio_gpu_virgl_reset_async_fences(VirtIOGPU *g)
>>> +{
>>> +    struct virtio_gpu_virgl_context_fence *f;
>>> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
>>> +
>>> +    while (!QSLIST_EMPTY(&gl->async_fenceq)) {
>>> +        f = QSLIST_FIRST(&gl->async_fenceq);
>>> +
>>> +        QSLIST_REMOVE_HEAD(&gl->async_fenceq, next);
>>> +
>>> +        g_free(f);
>>> +    }
>>> +}
>>> +
>>> +#if VIRGL_CHECK_VERSION(1, 1, 2)
>>> +static void virtio_gpu_virgl_async_fence_bh(void *opaque)
>>> +{
>>> +    QSLIST_HEAD(, virtio_gpu_virgl_context_fence) async_fenceq;
>>> +    struct virtio_gpu_ctrl_command *cmd, *tmp;
>>> +    struct virtio_gpu_virgl_context_fence *f;
>>> +    VirtIOGPU *g = opaque;
>>> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
>>> +
>>> +    if (gl->renderer_state != RS_INITED) {
>>> +        return;
>>> +    }
>>> +
>>> +    QSLIST_MOVE_ATOMIC(&async_fenceq, &gl->async_fenceq);
>>> +
>>> +    while (!QSLIST_EMPTY(&async_fenceq)) {
>>> +        f = QSLIST_FIRST(&async_fenceq);
>>> +
>>> +        QSLIST_REMOVE_HEAD(&async_fenceq, next);
>>> +
>>> +        QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
>>> +            /*
>>> +             * the guest can end up emitting fences out of order
>>> +             * so we should check all fenced cmds not just the first one.
>>> +             */
>>> +            if (cmd->cmd_hdr.fence_id > f->fence_id) {
>>> +                continue;
>>> +            }
>>> +            if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX) {
>>> +                if (cmd->cmd_hdr.ring_idx != f->ring_idx) {
>>> +                    continue;
>>> +                }
>>> +                if (cmd->cmd_hdr.ctx_id != f->ctx_id) {
>>> +                    continue;
>>> +                }
>>> +            } else if (f->ring_idx >= 0) {
>>> +                /* ctx0 GL-query fences don't have ring info */
>>> +                continue;
>>> +            }
>>> +            virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODATA);
>>> +            QTAILQ_REMOVE(&g->fenceq, cmd, next);
>>> +            g_free(cmd);
>>> +        }
>>
>> Conditions above are a little bit confusing. Skipping unsignaled
>> fences first makes sense to me. Next we can use f->ctx_id == 0 to
>> distinguish ctx0 fence vs context fence. Then:
>> - for f->ctx_id == 0, skip any RING_IDX
>> - for f->ctx_id > 0, only care about RING_IDX along with comparing
>> ctx_id and ring_idx
>>
>> So, if we check the RING_IDX flag first like in the existing patch,
>> the else condition is only meaningful for the ctx0 fence, and
>> f->ring_idx >= 0 will never be evaluated to true. Can we drop the
>> "else if" part?
>>
>>> +
>>> +        trace_virtio_gpu_fence_resp(f->fence_id);
>>> +        g_free(f);
>>> +        g->inflight--;
>>> +        if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
>>> +            trace_virtio_gpu_dec_inflight_fences(g->inflight);
>>> +        }
>>> +    }
>>> +}
>>> +
>>> +static void
>>> +virtio_gpu_virgl_push_async_fence(VirtIOGPU *g, uint32_t ctx_id,
>>> +                                  int64_t ring_idx, uint64_t fence_id)
>>> +{
>>> +    struct virtio_gpu_virgl_context_fence *f;
>>> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
>>> +
>>> +    f = g_new(struct virtio_gpu_virgl_context_fence, 1);
>>> +    f->ctx_id = ctx_id;
>>> +    f->ring_idx = ring_idx;
>>> +    f->fence_id = fence_id;
>>> +
>>> +    QSLIST_INSERT_HEAD_ATOMIC(&gl->async_fenceq, f, next);
>>> +
>>> +    qemu_bh_schedule(gl->async_fence_bh);
>>> +}
>>> +
>>> +static void virgl_write_async_fence(void *opaque, uint32_t fence)
>>> +{
>>> +    VirtIOGPU *g = opaque;
>>> +
>>> +    virtio_gpu_virgl_push_async_fence(g, 0, -1, fence);
>>> +}
>>> +
>>> +static void virgl_write_async_context_fence(void *opaque, uint32_t ctx_id,
>>> +                                            uint32_t ring_idx, uint64_t fence)
>>> +{
>>> +    VirtIOGPU *g = opaque;
>>> +
>>> +    virtio_gpu_virgl_push_async_fence(g, ctx_id, ring_idx, fence);
>>> +}
>>> +#endif
>>> +
>>>  static virgl_renderer_gl_context
>>>  virgl_create_context(void *opaque, int scanout_idx,
>>>                       struct virgl_renderer_gl_ctx_param *params)
>>> @@ -1150,6 +1267,8 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
>>>  void virtio_gpu_virgl_reset(VirtIOGPU *g)
>>>  {
>>>      virgl_renderer_reset();
>>> +
>>> +    virtio_gpu_virgl_reset_async_fences(g);
>>>  }
>>>
>>>  int virtio_gpu_virgl_init(VirtIOGPU *g)
>>> @@ -1162,6 +1281,12 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>>>      if (qemu_egl_display) {
>>>          virtio_gpu_3d_cbs.version = 4;
>>>          virtio_gpu_3d_cbs.get_egl_display = virgl_get_egl_display;
>>> +#if VIRGL_CHECK_VERSION(1, 1, 2)
>>> +        virtio_gpu_3d_cbs.write_fence         = virgl_write_async_fence;
>>> +        virtio_gpu_3d_cbs.write_context_fence = virgl_write_async_context_fence;
>>> +        flags |= VIRGL_RENDERER_ASYNC_FENCE_CB;
>>> +        flags |= VIRGL_RENDERER_THREAD_SYNC;
>>> +#endif
>>>      }
>>>  #endif
>>>  #ifdef VIRGL_RENDERER_D3D11_SHARE_TEXTURE
>>> @@ -1195,6 +1320,11 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>>>      gl->cmdq_resume_bh = aio_bh_new(qemu_get_aio_context(),
>>>                                      virtio_gpu_virgl_resume_cmdq_bh,
>>>                                      g);
>>> +#if VIRGL_CHECK_VERSION(1, 1, 2)
>>> +    gl->async_fence_bh = aio_bh_new(qemu_get_aio_context(),
>>> +                                    virtio_gpu_virgl_async_fence_bh,
>>> +                                    g);
>>> +#endif
>>>  #endif
>>>
>>>      return 0;
>>> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
>>> index 9f16f89a36d2..e15c16aa5945 100644
>>> --- a/include/hw/virtio/virtio-gpu.h
>>> +++ b/include/hw/virtio/virtio-gpu.h
>>> @@ -233,6 +233,13 @@ struct VirtIOGPUClass {
>>>                               Error **errp);
>>>  };
>>>
>>> +struct virtio_gpu_virgl_context_fence {
>>> +    uint32_t ctx_id;
>>> +    int64_t ring_idx;
>>
>> If I didn't miss anything above, we don't need -1 to tell anything.
>> Then the ring_idx here can be a uint32_t, and virgl_write_async_fence
>> can just pass 0.
>>
>>> +    uint64_t fence_id;
>>> +    QSLIST_ENTRY(virtio_gpu_virgl_context_fence) next;
>>> +};
>>> +
>>>  /* VirtIOGPUGL renderer states */
>>>  typedef enum {
>>>      RS_START,       /* starting state */
>>> @@ -250,6 +257,9 @@ struct VirtIOGPUGL {
>>>      QEMUTimer *print_stats;
>>>
>>>      QEMUBH *cmdq_resume_bh;
>>> +
>>> +    QEMUBH *async_fence_bh;
>>> +    QSLIST_HEAD(, virtio_gpu_virgl_context_fence) async_fenceq;
>>>  };
>>>
>>>  struct VhostUserGPU {
>>> @@ -379,5 +389,6 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);
>>>  void virtio_gpu_virgl_reset(VirtIOGPU *g);
>>>  int virtio_gpu_virgl_init(VirtIOGPU *g);
>>>  GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g);
>>> +void virtio_gpu_virgl_reset_async_fences(VirtIOGPU *g);
>>>
>>>  #endif
>>> diff --git a/meson.build b/meson.build
>>> index e96c28da09b6..e3d48150483e 100644
>>> --- a/meson.build
>>> +++ b/meson.build
>>> @@ -2597,6 +2597,8 @@ config_host_data.set('CONFIG_VNC_JPEG', jpeg.found())
>>>  config_host_data.set('CONFIG_VNC_SASL', sasl.found())
>>>  if virgl.found()
>>>    config_host_data.set('VIRGL_VERSION_MAJOR', virgl.version().split('.')[0])
>>> +  config_host_data.set('VIRGL_VERSION_MINOR', virgl.version().split('.')[1])
>>> +  config_host_data.set('VIRGL_VERSION_MICRO', virgl.version().split('.')[2])
>>>  endif
>>>  config_host_data.set('CONFIG_VIRTFS', have_virtfs)
>>>  config_host_data.set('CONFIG_VTE', vte.found())
>>> --
>>> 2.51.0
>>>
> 
> Friendly ping. My early comments here might have been missed ; )

I indeed missed that first part of the comment, thanks.

Could you please give a code sample of your suggestion?

The `if (f->ring_idx >= 0)` is a sanity-check for that we're not getting
a fence that has ring_idx without a set RING_IDX flag. All other fences
are processed by that fence-handling loop.

-- 
Best regards,
Dmitry

