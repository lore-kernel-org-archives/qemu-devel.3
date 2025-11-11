Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B24ACCFA13
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 02:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIe8c-0004iS-8n; Mon, 10 Nov 2025 21:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>) id 1vIe8T-0004fo-Eo
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 21:29:36 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>) id 1vIe8R-00052K-DG
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 21:29:33 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b72db05e50fso577170766b.0
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 18:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762828169; x=1763432969; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YPZU5OLj+mriwXuDEOYOETP5NzC60LcIP/Y8uXXoqjc=;
 b=bStdNmbw69/HU1eh30x1wPvHeKom0DGzdqLMOPiKLdacQKLGRcRLd0UHI1Yy48/sJc
 R5vU8Yz8S0hAxzU0H1CUeJQBWQa44X2q91PVh1+oQEYgWMvwAp0HR+4B5GV8VP3d6DYF
 pH2GgKMvAsHrECHFNxfb7ZyiqvMPMeb0fe1ODKDWVCZpR4b3CMUviL5JIxBJn9ONg099
 K/RMtqZ+osczqoo6Mvn3sWLO+2oeqYsFQdzbmx0MdKu3LC9ISZD8X7uBza3Aox/LCI67
 547OWtzIB/L+XXedhAP3nyEx9TdDSx3s2Bjk6DEbub5huLaLkFJwaOduM8t5OP5vLLti
 icsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762828169; x=1763432969;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YPZU5OLj+mriwXuDEOYOETP5NzC60LcIP/Y8uXXoqjc=;
 b=YOKFcRHAu3gXQuPe7ArJEPD1jlDA0xRIZ9UBxS1aCnk9S1pxUS0kC+iRAte670Kvzw
 uMAuXD/2QYu/5vDceuLcOKrCzrMIHnFtG44TzLP8veoDuUhrtbdbiqfqqz8qbcGDLZcH
 GB+yi0CHLEmD/KwVZ9NANkwu4P4Zrnmdlbc1j2yuHfLdwq3B9oXUx3xpuQB+hKu4Q7FY
 wv+jk6FRJDxA5iNGlQIAu7aIc4q2Tjb1671Aa6sclVnpsmGJwXoHO7zUNWjJz3BTYM4X
 sz67MqJlJ8/vsq2xLvqbcYm9FN29osI5BUvoB/NsiEOj+PhwUebbcqRN+dZUseGrgQsN
 /RwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3tzZpHRPn72GN+da9vIhEuoYpkmBOckD0rlXtgNFAky/P2GuOT8Itm1ewn1v195l70D68AuapmDZW@nongnu.org
X-Gm-Message-State: AOJu0YzlENfGZ3u58Y+OirazPVSke0efFLEK6owP3ChHCuxaV9RlL4cV
 hDn/Rxmm17hxOHdE8uuZN5xBmM2HC8K1OmBtZf5499PuzkvhoUEeWlgd04kakbNrwIx8eluu8PF
 hCSUwmhkPW8g47NWk01gHZsEW4MHYQwE=
X-Gm-Gg: ASbGncuiduIjZ9Lz3T5DfyLevaQae92Fzx1pLycMKfpfJR0Ekb0dZ+7EjPzVCnbENaz
 csl5nDcEiOcE5ZWI4rgWZtbTPI6CUk/NMJ0uV2dF/XVBENucW04R0m6IfSbdfl905jJYlM8xPjx
 TKtQ9FCDkSKPIuBGjM3ccJPtZUFT0W7tID1KeWw37/k37lAV2O8fdK1H8zy8HkG3r1Sz/k3iP7P
 TvXbb70FCETlVuY8PswScUF1j7RSJJjs3/4I13FJwDsCVBHKbdNpjnHPY45geZ1pKZsF1vIQ2r8
 7Ll+RsEU6Z8asURIFg==
X-Google-Smtp-Source: AGHT+IHCChQPa96W1v81P2orqc6vXUhE4k0aiJAUV/DVX+mbBSrx4vavqFhwWge3y4x16L8EgLZ0b7GRA4dZmC3OeVE=
X-Received: by 2002:a17:907:60c8:b0:b4c:137d:89bb with SMTP id
 a640c23a62f3a-b72e037ab1amr1071041566b.29.1762828169098; Mon, 10 Nov 2025
 18:29:29 -0800 (PST)
MIME-Version: 1.0
References: <20251020233949.506088-1-dmitry.osipenko@collabora.com>
 <20251020233949.506088-5-dmitry.osipenko@collabora.com>
 <CAJ+hS_h4gwe+yaUrcQ5ibdEAFqya=SOb4KLT5HmgG_ZGtJnMSQ@mail.gmail.com>
In-Reply-To: <CAJ+hS_h4gwe+yaUrcQ5ibdEAFqya=SOb4KLT5HmgG_ZGtJnMSQ@mail.gmail.com>
From: Yiwei Zhang <zzyiwei@gmail.com>
Date: Mon, 10 Nov 2025 18:29:36 -0800
X-Gm-Features: AWmQ_bmE_ikITNl3_O1HMOb0vCR9vkCtPpLzOudU3QoG6Sjiw6ayk_VMU_MXqHI
Message-ID: <CAJ+hS_gPoaSc-VfoOENgyHZRhFAkUzizoGHm3xJz2trb0jsZAg@mail.gmail.com>
Subject: Re: [PATCH v14 04/10] virtio-gpu: Support asynchronous fencing
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Huang Rui <ray.huang@amd.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Gert Wollny <gert.wollny@collabora.com>,
 qemu-devel@nongnu.org, 
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>, 
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, 
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>, 
 Rob Clark <robdclark@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=zzyiwei@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, Nov 8, 2025 at 3:56=E2=80=AFAM Yiwei Zhang <zzyiwei@gmail.com> wrot=
e:
>
> On Mon, Oct 20, 2025 at 4:42=E2=80=AFPM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
> >
> > Support asynchronous fencing feature of virglrenderer. It allows Qemu t=
o
> > handle fence as soon as it's signalled instead of periodically polling
> > the fence status. This feature is required for enabling DRM context
> > support in Qemu because legacy fencing mode isn't supported for DRM
> > contexts in virglrenderer.
> >
> > Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > ---
> >  hw/display/virtio-gpu-gl.c     |   5 ++
> >  hw/display/virtio-gpu-virgl.c  | 130 +++++++++++++++++++++++++++++++++
> >  include/hw/virtio/virtio-gpu.h |  11 +++
> >  meson.build                    |   2 +
> >  4 files changed, 148 insertions(+)
> >
> > diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> > index c06a078fb36a..1468c6ed1467 100644
> > --- a/hw/display/virtio-gpu-gl.c
> > +++ b/hw/display/virtio-gpu-gl.c
> > @@ -169,6 +169,11 @@ static void virtio_gpu_gl_device_unrealize(DeviceS=
tate *qdev)
> >      if (gl->renderer_state >=3D RS_INITED) {
> >  #if VIRGL_VERSION_MAJOR >=3D 1
> >          qemu_bh_delete(gl->cmdq_resume_bh);
> > +
> > +        if (gl->async_fence_bh) {
> > +            virtio_gpu_virgl_reset_async_fences(g);
> > +            qemu_bh_delete(gl->async_fence_bh);
> > +        }
> >  #endif
> >          if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
> >              timer_free(gl->print_stats);
> > diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virg=
l.c
> > index cd8b367f6fa6..0320d6deca76 100644
> > --- a/hw/display/virtio-gpu-virgl.c
> > +++ b/hw/display/virtio-gpu-virgl.c
> > @@ -24,6 +24,23 @@
> >
> >  #include <virglrenderer.h>
> >
> > +/*
> > + * VIRGL_CHECK_VERSION available since libvirglrenderer 1.0.1 and was =
fixed
> > + * in 1.1.0. Undefine bugged version of the macro and provide our own.
> > + */
> > +#if defined(VIRGL_CHECK_VERSION) && \
> > +    VIRGL_VERSION_MAJOR =3D=3D 1 && VIRGL_VERSION_MINOR < 1
> > +#undef VIRGL_CHECK_VERSION
> > +#endif
> > +
> > +#ifndef VIRGL_CHECK_VERSION
> > +#define VIRGL_CHECK_VERSION(major, minor, micro) \
> > +    (VIRGL_VERSION_MAJOR > (major) || \
> > +     VIRGL_VERSION_MAJOR =3D=3D (major) && VIRGL_VERSION_MINOR > (mino=
r) || \
> > +     VIRGL_VERSION_MAJOR =3D=3D (major) && VIRGL_VERSION_MINOR =3D=3D =
(minor) && \
> > +     VIRGL_VERSION_MICRO >=3D (micro))
> > +#endif
> > +
> >  struct virtio_gpu_virgl_resource {
> >      struct virtio_gpu_simple_resource base;
> >      MemoryRegion *mr;
> > @@ -1051,6 +1068,106 @@ static void virgl_write_context_fence(void *opa=
que, uint32_t ctx_id,
> >  }
> >  #endif
> >
> > +void virtio_gpu_virgl_reset_async_fences(VirtIOGPU *g)
> > +{
> > +    struct virtio_gpu_virgl_context_fence *f;
> > +    VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(g);
> > +
> > +    while (!QSLIST_EMPTY(&gl->async_fenceq)) {
> > +        f =3D QSLIST_FIRST(&gl->async_fenceq);
> > +
> > +        QSLIST_REMOVE_HEAD(&gl->async_fenceq, next);
> > +
> > +        g_free(f);
> > +    }
> > +}
> > +
> > +#if VIRGL_CHECK_VERSION(1, 1, 2)
> > +static void virtio_gpu_virgl_async_fence_bh(void *opaque)
> > +{
> > +    QSLIST_HEAD(, virtio_gpu_virgl_context_fence) async_fenceq;
> > +    struct virtio_gpu_ctrl_command *cmd, *tmp;
> > +    struct virtio_gpu_virgl_context_fence *f;
> > +    VirtIOGPU *g =3D opaque;
> > +    VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(g);
> > +
> > +    if (gl->renderer_state !=3D RS_INITED) {
> > +        return;
> > +    }
> > +
> > +    QSLIST_MOVE_ATOMIC(&async_fenceq, &gl->async_fenceq);
> > +
> > +    while (!QSLIST_EMPTY(&async_fenceq)) {
> > +        f =3D QSLIST_FIRST(&async_fenceq);
> > +
> > +        QSLIST_REMOVE_HEAD(&async_fenceq, next);
> > +
> > +        QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
> > +            /*
> > +             * the guest can end up emitting fences out of order
> > +             * so we should check all fenced cmds not just the first o=
ne.
> > +             */
> > +            if (cmd->cmd_hdr.fence_id > f->fence_id) {
> > +                continue;
> > +            }
> > +            if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX) {
> > +                if (cmd->cmd_hdr.ring_idx !=3D f->ring_idx) {
> > +                    continue;
> > +                }
> > +                if (cmd->cmd_hdr.ctx_id !=3D f->ctx_id) {
> > +                    continue;
> > +                }
> > +            } else if (f->ring_idx >=3D 0) {
> > +                /* ctx0 GL-query fences don't have ring info */
> > +                continue;
> > +            }
> > +            virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK=
_NODATA);
> > +            QTAILQ_REMOVE(&g->fenceq, cmd, next);
> > +            g_free(cmd);
> > +        }
>
> Conditions above are a little bit confusing. Skipping unsignaled
> fences first makes sense to me. Next we can use f->ctx_id =3D=3D 0 to
> distinguish ctx0 fence vs context fence. Then:
> - for f->ctx_id =3D=3D 0, skip any RING_IDX
> - for f->ctx_id > 0, only care about RING_IDX along with comparing
> ctx_id and ring_idx
>
> So, if we check the RING_IDX flag first like in the existing patch,
> the else condition is only meaningful for the ctx0 fence, and
> f->ring_idx >=3D 0 will never be evaluated to true. Can we drop the
> "else if" part?
>
> > +
> > +        trace_virtio_gpu_fence_resp(f->fence_id);
> > +        g_free(f);
> > +        g->inflight--;
> > +        if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
> > +            trace_virtio_gpu_dec_inflight_fences(g->inflight);
> > +        }
> > +    }
> > +}
> > +
> > +static void
> > +virtio_gpu_virgl_push_async_fence(VirtIOGPU *g, uint32_t ctx_id,
> > +                                  int64_t ring_idx, uint64_t fence_id)
> > +{
> > +    struct virtio_gpu_virgl_context_fence *f;
> > +    VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(g);
> > +
> > +    f =3D g_new(struct virtio_gpu_virgl_context_fence, 1);
> > +    f->ctx_id =3D ctx_id;
> > +    f->ring_idx =3D ring_idx;
> > +    f->fence_id =3D fence_id;
> > +
> > +    QSLIST_INSERT_HEAD_ATOMIC(&gl->async_fenceq, f, next);
> > +
> > +    qemu_bh_schedule(gl->async_fence_bh);
> > +}
> > +
> > +static void virgl_write_async_fence(void *opaque, uint32_t fence)
> > +{
> > +    VirtIOGPU *g =3D opaque;
> > +
> > +    virtio_gpu_virgl_push_async_fence(g, 0, -1, fence);
> > +}
> > +
> > +static void virgl_write_async_context_fence(void *opaque, uint32_t ctx=
_id,
> > +                                            uint32_t ring_idx, uint64_=
t fence)
> > +{
> > +    VirtIOGPU *g =3D opaque;
> > +
> > +    virtio_gpu_virgl_push_async_fence(g, ctx_id, ring_idx, fence);
> > +}
> > +#endif
> > +
> >  static virgl_renderer_gl_context
> >  virgl_create_context(void *opaque, int scanout_idx,
> >                       struct virgl_renderer_gl_ctx_param *params)
> > @@ -1150,6 +1267,8 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
> >  void virtio_gpu_virgl_reset(VirtIOGPU *g)
> >  {
> >      virgl_renderer_reset();
> > +
> > +    virtio_gpu_virgl_reset_async_fences(g);
> >  }
> >
> >  int virtio_gpu_virgl_init(VirtIOGPU *g)
> > @@ -1162,6 +1281,12 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
> >      if (qemu_egl_display) {
> >          virtio_gpu_3d_cbs.version =3D 4;
> >          virtio_gpu_3d_cbs.get_egl_display =3D virgl_get_egl_display;
> > +#if VIRGL_CHECK_VERSION(1, 1, 2)
> > +        virtio_gpu_3d_cbs.write_fence         =3D virgl_write_async_fe=
nce;
> > +        virtio_gpu_3d_cbs.write_context_fence =3D virgl_write_async_co=
ntext_fence;
> > +        flags |=3D VIRGL_RENDERER_ASYNC_FENCE_CB;
> > +        flags |=3D VIRGL_RENDERER_THREAD_SYNC;
> > +#endif
> >      }
> >  #endif
> >  #ifdef VIRGL_RENDERER_D3D11_SHARE_TEXTURE
> > @@ -1195,6 +1320,11 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
> >      gl->cmdq_resume_bh =3D aio_bh_new(qemu_get_aio_context(),
> >                                      virtio_gpu_virgl_resume_cmdq_bh,
> >                                      g);
> > +#if VIRGL_CHECK_VERSION(1, 1, 2)
> > +    gl->async_fence_bh =3D aio_bh_new(qemu_get_aio_context(),
> > +                                    virtio_gpu_virgl_async_fence_bh,
> > +                                    g);
> > +#endif
> >  #endif
> >
> >      return 0;
> > diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-=
gpu.h
> > index 9f16f89a36d2..e15c16aa5945 100644
> > --- a/include/hw/virtio/virtio-gpu.h
> > +++ b/include/hw/virtio/virtio-gpu.h
> > @@ -233,6 +233,13 @@ struct VirtIOGPUClass {
> >                               Error **errp);
> >  };
> >
> > +struct virtio_gpu_virgl_context_fence {
> > +    uint32_t ctx_id;
> > +    int64_t ring_idx;
>
> If I didn't miss anything above, we don't need -1 to tell anything.
> Then the ring_idx here can be a uint32_t, and virgl_write_async_fence
> can just pass 0.
>
> > +    uint64_t fence_id;
> > +    QSLIST_ENTRY(virtio_gpu_virgl_context_fence) next;
> > +};
> > +
> >  /* VirtIOGPUGL renderer states */
> >  typedef enum {
> >      RS_START,       /* starting state */
> > @@ -250,6 +257,9 @@ struct VirtIOGPUGL {
> >      QEMUTimer *print_stats;
> >
> >      QEMUBH *cmdq_resume_bh;
> > +
> > +    QEMUBH *async_fence_bh;
> > +    QSLIST_HEAD(, virtio_gpu_virgl_context_fence) async_fenceq;
> >  };
> >
> >  struct VhostUserGPU {
> > @@ -379,5 +389,6 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);
> >  void virtio_gpu_virgl_reset(VirtIOGPU *g);
> >  int virtio_gpu_virgl_init(VirtIOGPU *g);
> >  GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g);
> > +void virtio_gpu_virgl_reset_async_fences(VirtIOGPU *g);
> >
> >  #endif
> > diff --git a/meson.build b/meson.build
> > index e96c28da09b6..e3d48150483e 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -2597,6 +2597,8 @@ config_host_data.set('CONFIG_VNC_JPEG', jpeg.foun=
d())
> >  config_host_data.set('CONFIG_VNC_SASL', sasl.found())
> >  if virgl.found()
> >    config_host_data.set('VIRGL_VERSION_MAJOR', virgl.version().split('.=
')[0])
> > +  config_host_data.set('VIRGL_VERSION_MINOR', virgl.version().split('.=
')[1])
> > +  config_host_data.set('VIRGL_VERSION_MICRO', virgl.version().split('.=
')[2])
> >  endif
> >  config_host_data.set('CONFIG_VIRTFS', have_virtfs)
> >  config_host_data.set('CONFIG_VTE', vte.found())
> > --
> > 2.51.0
> >

Friendly ping. My early comments here might have been missed ; )

