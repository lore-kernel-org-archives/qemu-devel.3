Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478BCCCFA13
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Nov 2025 12:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHhbr-0002yR-Ku; Sat, 08 Nov 2025 06:59:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>) id 1vHhbm-0002y5-Sc
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 06:59:56 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>) id 1vHhbk-000341-SG
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 06:59:54 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-640a3317b89so2539392a12.0
 for <qemu-devel@nongnu.org>; Sat, 08 Nov 2025 03:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762603191; x=1763207991; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hT3p6OfgwKgSkm8BBZgkKQfP33RLRR2VG+H9dHVlSM0=;
 b=e0TlpsaT9oIoPZWOciUuYheB+qedjg9SXr0sraQO7HMX9W3dnWI8qOkC9XDHo8Rkxa
 2U4JW03Wa3UO0ZewTn5PGxsw4KrypSZxL+qYyzz9aLSIMZgFRlFswyQmz11ayUCwRDLC
 aFjGHSdi8+wMmsA9Hgz20L2aL0pGouXzXKgdQySr0qJCs0WfmpECgrTKShVycAWZvh/9
 XoqKviOw1pucpQnX4CURPI6hl6goyJizjr1kj1Wmm73t+VXCgvNtsOo19/MYPC2nyw7k
 TwKfIHA8Cz+KL6yc4rV8BABvznSb6KUrune7G4Ue/3YzpxUpW1jSPN7AWlTmECOgGh4x
 7w3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762603191; x=1763207991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hT3p6OfgwKgSkm8BBZgkKQfP33RLRR2VG+H9dHVlSM0=;
 b=uOBsmxqVDcz0fpFokCHkqiQSVQpHm8M1fV2vv0P95YbG5lPP85JFCofmrrp+6n5OuH
 /vV2fR0yzXSVfTrhOvrp/2lvd6nrxTDRsjVUeuSiFtHmirCtERbawViOD8fBPnPl4tQH
 uF8FR4lx8/sWPK1aSBB2ZFqF9HJnY5LIiWvLYVYB+fuLqfDV9MeMaIQtEd88AvZrl51I
 xW5dPgQVxUVPDkD64v0Sbi5B5/3B4BI2wTUbmnDpfAnQqYnDJIv5J99g/9vtJ7bVTnbU
 5yFF98IvL5o0Jys49NFCe2Uy0W0+oxebFvoHiYUxTEbn/kN0krc7D0aQTkrqn0mn12oC
 8R+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmevI6fB7qI4eX9bhEugLwb7H9HKP5WF0CdCTwgTCTyxnOF/6vwO/OPCGxBzDNh3SQSj0ErrqBk0YT@nongnu.org
X-Gm-Message-State: AOJu0YwtdGZ+W8q7Jy2Amwc0lfYL7EhlrYCwV2/rJv4vTfCRL3wtzAUq
 AKyp/j4pJUNogxmNFjP2K+cuPbQsqVjrwfYEB/iHut15ozlWyoI2b4/reLYJUzDiRrbcp9anIY5
 yDHQWizy8bPW4YHA/fqMZxW4kZETfFoc=
X-Gm-Gg: ASbGncuiAUW9bzxVJ1XrLWsjaFv9T3ncJr4LBx7f3qd4UpNBLZ+/mZyYE6PJHW9ccpZ
 EEia3IUlUthwbD1RWfQqXwqyTYH1ZZ5JRxpdNwLlVtHok05Vr0/Dqx8ExxyrmMPzfEVF3lF6cuB
 7OhAlmGYpF0UPZO6LCz6lX3MSYR/felvWpHUvE/5fVfeZqOmRbQmmLWjC4LxyPnjdVufsMn97Dd
 xyNZ8XXXj0B8/MI0xqG4PJTAStORepcZP1u1dTTpKAqWq55MjJBi+jHhd3zoOGDEQBHUaMK6CTF
 fWZ7Wdepf1+5OJxD+fpc13M4h4yB
X-Google-Smtp-Source: AGHT+IGH0fB6Nbyesd1Cp3IwuO6W09rjHeQTzzndo7kNzv9TGTU14T+XZ/7GunjKubsLmbfPM4xqmNTa0Yb51JMqHmk=
X-Received: by 2002:a17:906:794d:b0:b72:6728:5bb1 with SMTP id
 a640c23a62f3a-b72e053d447mr250147766b.56.1762603190936; Sat, 08 Nov 2025
 03:59:50 -0800 (PST)
MIME-Version: 1.0
References: <20251020233949.506088-1-dmitry.osipenko@collabora.com>
 <20251020233949.506088-6-dmitry.osipenko@collabora.com>
In-Reply-To: <20251020233949.506088-6-dmitry.osipenko@collabora.com>
From: Yiwei Zhang <zzyiwei@gmail.com>
Date: Sat, 8 Nov 2025 03:59:56 -0800
X-Gm-Features: AWmQ_bmloFC77_4cNmFT05jS9ONkITRnrjIqFzq__Es6ZbCxRqdQ_jRWdLQR0rI
Message-ID: <CAJ+hS_jFpBerU9cU9wz2OOGdvZELiaP6Pmf+7RzSB6dy2YGY_w@mail.gmail.com>
Subject: Re: [PATCH v14 05/10] virtio-gpu: Support DRM native context
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
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=zzyiwei@gmail.com; helo=mail-ed1-x536.google.com
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

On Mon, Oct 20, 2025 at 4:42=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Add support for DRM native contexts to VirtIO-GPU. DRM context is enabled
> using a new virtio-gpu-gl device option "drm_native_context=3Don".
>
> Unlike Virgl and Venus contexts that operate on application API level,
> DRM native contexts work on a kernel UAPI level. This lower level results
> in a lightweight context implementations that yield better performance.
>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  docs/system/devices/virtio-gpu.rst | 11 +++++++++++
>  hw/display/virtio-gpu-gl.c         |  2 ++
>  hw/display/virtio-gpu-virgl.c      | 28 ++++++++++++++++++++++++++++
>  hw/display/virtio-gpu.c            | 15 +++++++++++++++
>  include/hw/virtio/virtio-gpu.h     |  3 +++
>  5 files changed, 59 insertions(+)
>
> diff --git a/docs/system/devices/virtio-gpu.rst b/docs/system/devices/vir=
tio-gpu.rst
> index b7eb0fc0e727..f20c60016376 100644
> --- a/docs/system/devices/virtio-gpu.rst
> +++ b/docs/system/devices/virtio-gpu.rst
> @@ -82,6 +82,17 @@ of virtio-gpu host memory window. This is typically be=
tween 256M and 8G.
>
>  .. _venus: https://gitlab.freedesktop.org/virgl/venus-protocol/
>
> +DRM native context is supported since release of `virglrenderer`_ v1.0.0
> +using `drm`_ protocol.  ``DRM`` virtio-gpu capability set ("capset") req=
uires
> +host blob support (``hostmem`` and ``blob`` fields) and should be enable=
d
> +using ``drm_native_context`` field.  The ``hostmem`` field specifies the=
 size
> +of virtio-gpu host memory window. This is typically between 256M and 8G.
> +
> +.. parsed-literal::
> +    -device virtio-gpu-gl,hostmem=3D8G,blob=3Don,drm_native_context=3Don
> +
> +.. _drm: https://gitlab.freedesktop.org/virgl/virglrenderer/-/tree/main/=
src/drm
> +
>  virtio-gpu rutabaga
>  -------------------
>
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index 1468c6ed1467..b640900fc6f1 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -159,6 +159,8 @@ static const Property virtio_gpu_gl_properties[] =3D =
{
>                      VIRTIO_GPU_FLAG_STATS_ENABLED, false),
>      DEFINE_PROP_BIT("venus", VirtIOGPU, parent_obj.conf.flags,
>                      VIRTIO_GPU_FLAG_VENUS_ENABLED, false),
> +    DEFINE_PROP_BIT("drm_native_context", VirtIOGPU, parent_obj.conf.fla=
gs,
> +                    VIRTIO_GPU_FLAG_DRM_ENABLED, false),
>  };
>
>  static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.=
c
> index 0320d6deca76..ccba1d8ee4f4 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -1298,6 +1298,25 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>      if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
>          flags |=3D VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVER;
>      }
> +    if (virtio_gpu_drm_enabled(g->parent_obj.conf)) {
> +        flags |=3D VIRGL_RENDERER_DRM;
> +
> +        if (!(flags & VIRGL_RENDERER_ASYNC_FENCE_CB)) {
> +            /*
> +             * Virglrenderer skips enabling DRM context support without
> +             * enabled async-fence feature. VirtIO-GPU will initialize
> +             * successfully, but DRM context won't be available in guest=
.
> +             *
> +             * For vrend async-fencing can be enabled only if EGL displa=
y
> +             * is used. Vrend can't be disabled in QEMU, hence DRM impli=
citly
> +             * requires EGL too.
> +             *
> +             * Async-fence was bugged in virglrenderer versions <=3D 1.1=
.1.
> +             */
> +            error_report("drm requires egl display and virglrenderer >=
=3D 1.2.0");
> +            return -EINVAL;
> +        }
> +    }
>  #endif
>
>      ret =3D virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
> @@ -1361,5 +1380,14 @@ GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
>          }
>      }
>
> +    if (virtio_gpu_drm_enabled(g->parent_obj.conf)) {
> +        virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_DRM,
> +                                   &capset_max_ver,
> +                                   &capset_max_size);
> +        if (capset_max_size) {
> +            virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_DR=
M);
> +        }
> +    }
> +
>      return capset_ids;
>  }
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 3a555125be60..ad36ea6ee319 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1510,6 +1510,21 @@ void virtio_gpu_device_realize(DeviceState *qdev, =
Error **errp)
>  #endif
>      }
>
> +    if (virtio_gpu_drm_enabled(g->parent_obj.conf)) {
> +#ifdef VIRGL_VERSION_MAJOR
> +    #if VIRGL_VERSION_MAJOR >=3D 1
> +        if (!virtio_gpu_blob_enabled(g->parent_obj.conf) ||
> +            !virtio_gpu_hostmem_enabled(g->parent_obj.conf)) {
> +            error_setg(errp, "drm requires enabled blob and hostmem opti=
ons");
> +            return;
> +        }
> +    #else
> +        error_setg(errp, "old virglrenderer, drm unsupported");
> +        return;
> +    #endif
> +#endif
> +    }
> +
>      if (!virtio_gpu_base_device_realize(qdev,
>                                          virtio_gpu_handle_ctrl_cb,
>                                          virtio_gpu_handle_cursor_cb,
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index e15c16aa5945..a4963508a469 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -100,6 +100,7 @@ enum virtio_gpu_base_conf_flags {
>      VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
>      VIRTIO_GPU_FLAG_VENUS_ENABLED,
>      VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED,
> +    VIRTIO_GPU_FLAG_DRM_ENABLED,
>  };
>
>  #define virtio_gpu_virgl_enabled(_cfg) \
> @@ -122,6 +123,8 @@ enum virtio_gpu_base_conf_flags {
>      (_cfg.hostmem > 0)
>  #define virtio_gpu_venus_enabled(_cfg) \
>      (_cfg.flags & (1 << VIRTIO_GPU_FLAG_VENUS_ENABLED))
> +#define virtio_gpu_drm_enabled(_cfg) \
> +    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_DRM_ENABLED))
>
>  struct virtio_gpu_base_conf {
>      uint32_t max_outputs;
> --
> 2.51.0
>

Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>

