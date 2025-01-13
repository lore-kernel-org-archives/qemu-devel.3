Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74616C02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 22:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXSTq-0005xj-5h; Mon, 13 Jan 2025 17:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXSTn-0005vG-1I
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 17:00:15 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXSTk-00006z-TA
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 17:00:14 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d3f28a4fccso6986929a12.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 14:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736805611; x=1737410411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=55BBDENmM6cu46AOgNTcMXefMtSptM1jMpGa/LEO37Y=;
 b=KMWZB25hKHU4VPXnuhSPyxbUU8lu0N6cGVrd6THzhm/ipn0d4kW/RIDiT1t7k20lWS
 ZQXE3Z4WJWxm418nm/ZrNyIaMWWsscVNUndAWmIaFbMH402rzrZW7Z4fl/tEOm1g7Vii
 6cFQHMWKMSWAseFtf2YeHZqCjvShNo/nOhTEuTOOsmRyIEs+kNaszhT7EelN5/c/SS6+
 OBRSfKymdl2bKMPXs2VN7RSJZlzGFzN1b43HdHLU8gG+lZf0roERVTMTrKnN9Y7PQ1I6
 CI/tvRMJK684uoN2g+GNwXuH7/loeHeuCymuej3HJMW+2k6n8YUIJZHSKC9UpLrVifl0
 zMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736805611; x=1737410411;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=55BBDENmM6cu46AOgNTcMXefMtSptM1jMpGa/LEO37Y=;
 b=LHWN5BM8dxRX2WCSTmuR+fyuJETcguJNntZKYKsGSoYVbAl3NVljG8fB1LHm1ot62g
 tr5JjXYoZt6u29mzlI7Gy7JaKH5+uCJljQJt8LeJ71wsanu+UEdWJ2AiQmDAGDUnakZT
 G2RaVy4Uog7nxWv32KujbPhCYYCBm7Pg1078C0cV1dKbDIGFi+tYsQlMeU9mflSSLqHS
 ps/cHJq3HjGJbVMahCQZe23FXQQ+bMtCVkuHmjCL2Y65rh+zLCl2pYvS9/+wnnj1HNNp
 QADVgbPlOADHo3TcsOBW167Ra/m2nisLv6npbBlda7rMYV7Ys7OeEI1sHqKGft51N+lw
 wU4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhiqy4vm606cwpjKAaP0bfg3TM8Jb+d4V9mPPRcV+l68Hl91T6QAyj6WO6KgpXJa1AhyTNejwZ4A3L@nongnu.org
X-Gm-Message-State: AOJu0YxH0XeX+23F++jr5XJOI9OLPBVI0S4q+BtD70eFPHLkw8oK2YTM
 mVs0uu7u+8N5uzSqS0IA0aSkl6gsvgblFzIVxTD4FF2hbuNlIBONCz3NTROFP0w=
X-Gm-Gg: ASbGncvSxeXx+MCJVkPUuyd+d6mGeI8wwQX9YHx7lpUdo/HTa+nbAMf0f8Wj+L4Slyx
 J7QF/z/8WVGyD1cNbWxkcL4a1yHwQaUZgaqp78yNMHcdXs0F9OHzKTZbIUX0b/aBh1g00M0MLdv
 1spFcBsZhW++QeKU+EaTY2exC5APL7oI0heH+YNPWnlzYTY5WqY+SbkZZO4VefXperY/yUuSib+
 o9SoV+R/FjxvF04/MpyY6Zf3gxobz1XxD00VsfSrB0UlZKe4obTFWY=
X-Google-Smtp-Source: AGHT+IHrpzXdyP/UgGb+SRuoCgzanqVmRVwllBUcaxyYeQEPQwUHYNTASobUWKqtga8cv+Jt5HZHnw==
X-Received: by 2002:a05:6402:5244:b0:5d1:1024:97a0 with SMTP id
 4fb4d7f45d1cf-5d972dfb883mr22171685a12.6.1736805610598; 
 Mon, 13 Jan 2025 14:00:10 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d99046a17fsm5332315a12.62.2025.01.13.14.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 14:00:09 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2B06B5F8AB;
 Mon, 13 Jan 2025 22:00:08 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  Huang Rui
 <ray.huang@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Gert Wollny <gert.wollny@collabora.com>,
 qemu-devel@nongnu.org,  Gurchetan Singh <gurchetansingh@chromium.org>,
 Alyssa Ross <hi@alyssa.is>,  Roger Pau =?utf-8?Q?Monn=C3=A9?=
 <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,  Stefano Stabellini
 <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,  Honglei Huang
 <honglei1.huang@amd.com>,  Julia Zhang <julia.zhang@amd.com>,  Chen Jiqian
 <Jiqian.Chen@amd.com>,  Rob Clark <robdclark@gmail.com>,  Yiwei Zhang
 <zzyiwei@chromium.org>,  Sergio Lopez Pascual <slp@redhat.com>
Subject: Re: [PATCH v4 4/5] virtio-gpu: Support asynchronous fencing
In-Reply-To: <20241110221838.2241356-5-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Mon, 11 Nov 2024 01:18:36 +0300")
References: <20241110221838.2241356-1-dmitry.osipenko@collabora.com>
 <20241110221838.2241356-5-dmitry.osipenko@collabora.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 13 Jan 2025 22:00:08 +0000
Message-ID: <87plkqjrx3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> Support asynchronous fencing feature of virglrenderer. It allows Qemu to
> handle fence as soon as it's signalled instead of periodically polling
> the fence status. This feature is required for enabling DRM context
> support in Qemu because legacy fencing mode isn't supported for DRM
> contexts in virglrenderer.
>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  hw/display/virtio-gpu-gl.c     |   3 +
>  hw/display/virtio-gpu-virgl.c  | 141 ++++++++++++++++++++++++++++-----
>  include/hw/virtio/virtio-gpu.h |  13 +++
>  3 files changed, 135 insertions(+), 22 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index 7c0e448b4661..53d938f23f20 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -170,6 +170,9 @@ static void virtio_gpu_gl_device_unrealize(DeviceStat=
e *qdev)
>      if (gl->renderer_state >=3D RS_INITED) {
>  #if VIRGL_VERSION_MAJOR >=3D 1
>          qemu_bh_delete(gl->cmdq_resume_bh);
> +
> +        virtio_gpu_virgl_reset_async_fences(g);
> +        qemu_bh_delete(gl->async_fence_bh);
>  #endif
>          if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
>              timer_free(gl->print_stats);
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index a875c68a35e5..d59c7b6d48ed 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -891,6 +891,7 @@ static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
>  void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>                                        struct virtio_gpu_ctrl_command *cm=
d)
>  {
> +    VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(g);
>      bool cmd_suspended =3D false;
>      int ret;
>=20=20
> @@ -992,35 +993,73 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>=20=20
>      trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type=
);
>=20=20
> -    /*
> -     * Unlike other virglrenderer functions, this one returns a positive
> -     * error code.
> -     */
> -    ret =3D virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, 0);
> -    if (ret) {
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: virgl_renderer_create_fence error: %s",
> -                      __func__, strerror(ret));
> +    if (gl->context_fence_enabled &&
> +        (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX)) {
> +        uint32_t flags =3D 0;
> +
> +        ret =3D virgl_renderer_context_create_fence(cmd->cmd_hdr.ctx_id,=
 flags,
> +                                                  cmd->cmd_hdr.ring_idx,
> +                                                  cmd->cmd_hdr.fence_id);
> +        if (ret) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: virgl_renderer_context_create_fence error=
: %s",
> +                          __func__, strerror(-ret));
> +        }
> +    } else {
> +        /*
> +         * Unlike other virglrenderer functions, this one returns a posi=
tive
> +         * error code.
> +         */
> +        ret =3D virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, 0);
> +        if (ret) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: virgl_renderer_create_fence error: %s",
> +                          __func__, strerror(ret));
> +        }
>      }
>  }

This needs to be gated on support from virglrenderer:

  /display/virtio-gpu-virgl.c
  ../../hw/display/virtio-gpu-virgl.c: In function =E2=80=98virtio_gpu_virg=
l_process_cmd=E2=80=99:
  ../../hw/display/virtio-gpu-virgl.c:980:15: error: implicit declaration o=
f function =E2=80=98virgl_renderer_context_create_fence=E2=80=99; did you m=
ean =E2=80=98virgl_renderer_context_create=E2=80=99? [-Werror=3Dimplicit-fu=
nction-declaration]
    980 |         ret =3D virgl_renderer_context_create_fence(cmd->cmd_hdr.=
ctx_id, flags,
        |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        |               virgl_renderer_context_create
  ../../hw/display/virtio-gpu-virgl.c:980:15: error: nested extern declarat=
ion of =E2=80=98virgl_renderer_context_create_fence=E2=80=99 [-Werror=3Dnes=
ted-externs]
  ../../hw/display/virtio-gpu-virgl.c: At top level:
  ../../hw/display/virtio-gpu-virgl.c:1088:13: error: =E2=80=98virgl_write_=
context_fence=E2=80=99 defined but not used [-Werror=3Dunused-function]
   1088 | static void virgl_write_context_fence(void *opaque, uint32_t ctx_=
id,
        |             ^~~~~~~~~~~~~~~~~~~~~~~~~
  ../../hw/display/virtio-gpu-virgl.c:1002:13: error: =E2=80=98virtio_gpu_v=
irgl_async_fence_bh=E2=80=99 defined but not used [-Werror=3Dunused-functio=
n]
   1002 | static void virtio_gpu_virgl_async_fence_bh(void *opaque)
        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors

>=20=20
> -static void virgl_write_fence(void *opaque, uint32_t fence)
> +static void virtio_gpu_virgl_async_fence_bh(void *opaque)
>  {
> -    VirtIOGPU *g =3D opaque;
> +    QSLIST_HEAD(, virtio_gpu_virgl_context_fence) async_fenceq;
>      struct virtio_gpu_ctrl_command *cmd, *tmp;
> +    struct virtio_gpu_virgl_context_fence *f;
> +    VirtIOGPU *g =3D opaque;
> +    VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(g);
>=20=20
> -    QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
> -        /*
> -         * the guest can end up emitting fences out of order
> -         * so we should check all fenced cmds not just the first one.
> -         */
> -        if (cmd->cmd_hdr.fence_id > fence) {
> -            continue;
> +    QSLIST_MOVE_ATOMIC(&async_fenceq, &gl->async_fenceq);
> +
> +    while (!QSLIST_EMPTY(&async_fenceq)) {
> +        f =3D QSLIST_FIRST(&async_fenceq);
> +
> +        QSLIST_REMOVE_HEAD(&async_fenceq, next);
> +
> +        QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
> +            /*
> +             * the guest can end up emitting fences out of order
> +             * so we should check all fenced cmds not just the first one.
> +             */
> +            if (cmd->cmd_hdr.fence_id > f->fence_id) {
> +                continue;
> +            }
> +            if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX) {
> +                if (cmd->cmd_hdr.ring_idx !=3D f->ring_idx) {
> +                    continue;
> +                }
> +                if (cmd->cmd_hdr.ctx_id !=3D f->ctx_id) {
> +                    continue;
> +                }
> +            } else if (f->ring_idx >=3D 0) {
> +                /* ctx0 GL-query fences don't have ring info */
> +                continue;
> +            }
> +            virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_N=
ODATA);
> +            QTAILQ_REMOVE(&g->fenceq, cmd, next);
> +            g_free(cmd);
>          }
> -        trace_virtio_gpu_fence_resp(cmd->cmd_hdr.fence_id);
> -        virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODAT=
A);
> -        QTAILQ_REMOVE(&g->fenceq, cmd, next);
> -        g_free(cmd);
> +
> +        trace_virtio_gpu_fence_resp(f->fence_id);
> +        g_free(f);
>          g->inflight--;
>          if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
>              trace_virtio_gpu_dec_inflight_fences(g->inflight);
> @@ -1028,6 +1067,52 @@ static void virgl_write_fence(void *opaque, uint32=
_t fence)
>      }
>  }
>=20=20
> +void virtio_gpu_virgl_reset_async_fences(VirtIOGPU *g)
> +{
> +    struct virtio_gpu_virgl_context_fence *f;
> +    VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(g);
> +
> +    while (!QSLIST_EMPTY(&gl->async_fenceq)) {
> +        f =3D QSLIST_FIRST(&gl->async_fenceq);
> +
> +        QSLIST_REMOVE_HEAD(&gl->async_fenceq, next);
> +
> +        g_free(f);
> +    }
> +}
> +
> +static void
> +virtio_gpu_virgl_push_async_fence(VirtIOGPU *g, uint32_t ctx_id,
> +                                  int64_t ring_idx, uint64_t fence_id)
> +{
> +    struct virtio_gpu_virgl_context_fence *f;
> +    VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(g);
> +
> +    f =3D g_new(struct virtio_gpu_virgl_context_fence, 1);
> +    f->ctx_id =3D ctx_id;
> +    f->ring_idx =3D ring_idx;
> +    f->fence_id =3D fence_id;
> +
> +    QSLIST_INSERT_HEAD_ATOMIC(&gl->async_fenceq, f, next);
> +
> +    qemu_bh_schedule(gl->async_fence_bh);
> +}
> +
> +static void virgl_write_fence(void *opaque, uint32_t fence)
> +{
> +    VirtIOGPU *g =3D opaque;
> +
> +    virtio_gpu_virgl_push_async_fence(g, 0, -1, fence);
> +}
> +
> +static void virgl_write_context_fence(void *opaque, uint32_t ctx_id,
> +                                      uint32_t ring_idx, uint64_t fence)
> +{
> +    VirtIOGPU *g =3D opaque;
> +
> +    virtio_gpu_virgl_push_async_fence(g, ctx_id, ring_idx, fence);
> +}
> +
>  static virgl_renderer_gl_context
>  virgl_create_context(void *opaque, int scanout_idx,
>                       struct virgl_renderer_gl_ctx_param *params)
> @@ -1115,6 +1200,8 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
>          dpy_gfx_replace_surface(g->parent_obj.scanout[i].con, NULL);
>          dpy_gl_scanout_disable(g->parent_obj.scanout[i].con);
>      }
> +
> +    virtio_gpu_virgl_reset_async_fences(g);
>  }
>=20=20
>  void virtio_gpu_virgl_reset(VirtIOGPU *g)
> @@ -1132,6 +1219,12 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>      if (qemu_egl_display) {
>          virtio_gpu_3d_cbs.version =3D 4;
>          virtio_gpu_3d_cbs.get_egl_display =3D virgl_get_egl_display;
> +#if VIRGL_VERSION_MAJOR >=3D 1
> +        virtio_gpu_3d_cbs.write_context_fence =3D virgl_write_context_fe=
nce;
> +        flags |=3D VIRGL_RENDERER_ASYNC_FENCE_CB;
> +        flags |=3D VIRGL_RENDERER_THREAD_SYNC;
> +        gl->context_fence_enabled =3D true;
> +#endif
>      }
>  #endif
>  #ifdef VIRGL_RENDERER_D3D11_SHARE_TEXTURE
> @@ -1165,6 +1258,10 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>      gl->cmdq_resume_bh =3D aio_bh_new(qemu_get_aio_context(),
>                                      virtio_gpu_virgl_resume_cmdq_bh,
>                                      g);
> +
> +    gl->async_fence_bh =3D aio_bh_new(qemu_get_aio_context(),
> +                                    virtio_gpu_virgl_async_fence_bh,
> +                                    g);
>  #endif
>=20=20
>      return 0;
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index 553799b8cc72..99cc6286f473 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -227,6 +227,13 @@ struct VirtIOGPUClass {
>                               Error **errp);
>  };
>=20=20
> +struct virtio_gpu_virgl_context_fence {
> +    uint32_t ctx_id;
> +    int64_t ring_idx;
> +    uint64_t fence_id;
> +    QSLIST_ENTRY(virtio_gpu_virgl_context_fence) next;
> +};
> +
>  /* VirtIOGPUGL renderer states */
>  typedef enum {
>      RS_START,       /* starting state */
> @@ -244,6 +251,11 @@ struct VirtIOGPUGL {
>      QEMUTimer *print_stats;
>=20=20
>      QEMUBH *cmdq_resume_bh;
> +
> +    QEMUBH *async_fence_bh;
> +    QSLIST_HEAD(, virtio_gpu_virgl_context_fence) async_fenceq;
> +
> +    bool context_fence_enabled;
>  };
>=20=20
>  struct VhostUserGPU {
> @@ -358,5 +370,6 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);
>  void virtio_gpu_virgl_reset(VirtIOGPU *g);
>  int virtio_gpu_virgl_init(VirtIOGPU *g);
>  GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g);
> +void virtio_gpu_virgl_reset_async_fences(VirtIOGPU *g);
>=20=20
>  #endif

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

