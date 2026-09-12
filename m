Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6981C88E45
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 05:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5GB3-0002lS-2z; Sat, 12 Sep 2026 01:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x5GB1-0002lH-9x
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 01:21:23 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x5GAy-0006ry-QI
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 01:21:22 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea4bfd1so442098a12.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 22:21:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789190479; cv=none;
 d=google.com; s=arc-20260327;
 b=eNygJmaJ+XvIZoXguBYkMSL6fA/437keTl3hE+a4BMFsJmx4kd2y/zVT0wetZuY/Jt
 k/7Whl/+zM+YKPemXDIgrchPF+cfc1xkxlJgJWGdkyjFNM2y8LOIDnlwGr0C7BCU8Ka4
 jdb13Cu9ocg1x/esEPqywNsqiCwl2uPR+f04YEGpFRjcvSp+wLqpsHgqbdPV0uInhRvj
 VA86Ny/X4/XUvgM/IFW6uOmKUmPBDNPURDNr8PWgeKoR4oR5HaxpKbx80BU0wwqCihq6
 LFtqCYMmTv8IK8iDL1QpXljzXEIXM3LXag42oxF+/ujDoQkEDFDQlWB3Ik3MKDy++s+T
 0Mvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=y2dFHiK+FuqH6kSYXctzfqAzd7KjZNcMOXDIkJI6MbE=;
 fh=ZBQ1Z12mvQWsXULf5YG9hdJM0SA1+dbyJslhEk5p1Fw=;
 b=Bw52GMdssHGD+OhhVTZjWtCZfq2MRG/aG6XFsYFFMc8r+BpO/ShjnnYaFToWGRFck+
 4LnSkzfoFsVjU0Wxpo4wbJyJwt468ctP//thxiqXchib1WUnvwC66TGragSGCmu2QuKr
 sOs9uakPji9sbCFIhE9bNu2m8G0LD8QwK9YvVH+aH+tlL2H78or8X3EpLPQxeShw419b
 CvOKTdUSjoMrobovUvkDyVGdA634QrxRL9iQyG2sM/LTyCCxNj8zBC7yNY1OxwbOTfHB
 u5RRMZXprN+6rvPcUDaOPKILsGJWp1/3CtNg0AP9HCFI9apBfdQf/02vxrZ225FyIYbu
 UsDg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789190479; x=1789795279; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=y2dFHiK+FuqH6kSYXctzfqAzd7KjZNcMOXDIkJI6MbE=;
 b=BG92XhSKLN4+65E5AfWI+gK1hJzsqXqTFYdjZYRqv44c739+iafAQrLjr2oU9n8wKe
 OxFoQhKRHoff9vH2/6Z/Mbo2YvdZdyNNW+m3zF1ZmcfvM5PmPX/drm0y3yqXPoGwt6gc
 cfzJQAk0+Y09aJ9bidCEf80VvvN6+b2A2cJUrnkRVjD1zIzOjiPqKcb+jsWkU05z/N3K
 vJYWUBDkroXYOWRO292WmMoflfSW05VoltQHgLD1cDie1Oirf3NnURPb6yW0tzdthWNk
 VB9tU5EAljT4e8y2Xl4/mcLE6XSpvQGcM9R1X9mxZW932/gWq9gGk8//omESIxvvztXZ
 vYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789190479; x=1789795279;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y2dFHiK+FuqH6kSYXctzfqAzd7KjZNcMOXDIkJI6MbE=;
 b=qhLDIHQ7HhkyVVxIFRsnKv/HiXVTjxwi4xMcUyYVXVptRpku7CBTVKanrfpmqmHgv7
 6L4l5320h2Qo/hWRcQqvq7stFnjhEWC7Uai2MFBq9R7wQEON4SoxJbfl9gtpXsXCya/R
 4Su6wFnl9nQxBJV34aHjNbhlzbMDXm8xKpJ6H9K9F65KwgqCVJMiy1yU1uyjRlDjmVOp
 GjvHh639qgSuJl9CV8zEcAtcZDdChZSfi/C+owmKcelBIX+llzbL3FYH5t1FCKLH57zt
 WpF6hvka0E5xn4lnhZoHOlSy9ogCRsM8NFB7IH8PZIfZGfm0Egmy4+ziyX/VDTtpOYi3
 Lwdg==
X-Gm-Message-State: AFuF++kYyOmgHvtJdyTxXzCYmU1g6Kt4jsoM1sYheGrr2af1lQEWxd1z
 GoZ0tHXvKOwvoGqvdbr71oHExuwYjJG4oCK/tQCOtEQud7mAnmPzMh0C75s8z5owgNgnmG8/WUj
 LSeTs89FIPQ1JZdaFIldBSQE1E1wfc6c=
X-Gm-Gg: AYBFou1yGby8wxuWr0kiMpi36MphMYE19Tg8aXprV1tW++MFJVCPO/gWYWQXqQOQLl+
 xcfLT33N1HqEVMk5mvLynH5CoSWbWZdFr6Hb6ZyzNokpJNGC8lx3yprmbAYBZJhRmgIJNUy48TG
 Z5QYzLbk20ghDvPRxdNDRU0UKkFkkpQue1FeoCxCjOS1gO2vGSb7nPhqIl4nKB7FKrEf0MpreL8
 q9mlYjc/j28zekvV8MXfLC+tXS3iIhWTDgoM0Cji2EPpbVXQKtyF/VXZSe0i4NOIeAIsEpK6PqZ
 dGduZkW+nVHBconRodthaVfp0Wp6hZ30ybbP/djdy4bIf080OUvp5wVPS4XGiKcGbUrhmWlByKR
 byOb081optAY=
X-Received: by 2002:a05:6a21:b82:b0:3d0:cc29:ff63 with SMTP id
 adf61e73a8af0-3daed342f1cmr13056653637.12.1789190478712; Fri, 11 Sep 2026
 22:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260912-crosvm-v2-1-11a8c4ecff2f@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260912-crosvm-v2-1-11a8c4ecff2f@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 12 Sep 2026 09:21:06 +0400
X-Gm-Features: AcwNN1X5sR_m_myzYUn7AqYpJHe1Kg31Vs9l_YbziKnB7qA69P__ENeOeg-wmYI
Message-ID: <CAJ+F1CKNiaRn+ZF0ubh2gKyzcBFXpGTaT2sSMy7QQ7m6vT_9GA@mail.gmail.com>
Subject: Re: [PATCH v2] docs/system: virtio-gpu: Update Rutabaga links
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pz2-x10.google.com
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

On Sat, Sep 12, 2026 at 9:18=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> Rutabaga was externalized from crosvm:
> https://chromium.googlesource.com/crosvm/crosvm/+/481338d967d5c8b506e17b8=
e335798f5cb89d7ee
>
> The latest code of gfxstream is now hosted on GitHub.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
> Changes in v2:
> - Update the gfxstream link to point to its GitHub repository.
> - Link to v1: https://lore.kernel.org/qemu-devel/20260901-crosvm-v1-1-942=
fb87c5e43@rsg.ci.i.u-tokyo.ac.jp
> ---
>  docs/system/devices/virtio/virtio-gpu.rst | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/docs/system/devices/virtio/virtio-gpu.rst b/docs/system/devi=
ces/virtio/virtio-gpu.rst
> index d05f8cb8e3f9..c5e07c60fe1a 100644
> --- a/docs/system/devices/virtio/virtio-gpu.rst
> +++ b/docs/system/devices/virtio/virtio-gpu.rst
> @@ -185,8 +185,9 @@ rendering and `Wayland display passthrough`_.  With t=
he gfxstream rendering
>  mode, GLES and Vulkan calls are forwarded to the host with minimal
>  modification.
>
> -The crosvm book provides directions on how to build a `gfxstream-enabled
> -rutabaga`_ and launch a `guest Wayland proxy`_.
> +rutabaga_gfx's documentation provides directions on how to build a
> +`gfxstream-enabled rutabaga`_. The crosvm book provides directions on
> +how to launch a `guest Wayland proxy`_.
>
>  This device does require host blob support (``hostmem`` field below). Th=
e
>  ``hostmem`` field specifies the size of virtio-gpu host memory window.
> @@ -212,9 +213,9 @@ Surfaceless is the default if ``wsi`` is not specifie=
d.
>         hostmem=3D8G,wayland-socket-path=3D/tmp/nonstandard/mock_wayland.=
sock,
>         wsi=3Dheadless
>
> -.. _gfxstream: https://android.googlesource.com/platform/hardware/google=
/gfxstream/
> +.. _gfxstream: https://github.com/google/gfxstream
>  .. _Wayland display passthrough: https://www.youtube.com/watch?v=3DOZJiH=
MtIQ2M
> -.. _gfxstream-enabled rutabaga: https://crosvm.dev/book/appendix/rutabag=
a_gfx.html
> +.. _gfxstream-enabled rutabaga: https://github.com/magma-gpu/rutabaga_gf=
x#rutabaga-c-api
>  .. _guest Wayland proxy: https://crosvm.dev/book/devices/wayland.html
>
>  .. list-table:: Linux Host Requirements
>
> ---
> base-commit: 209b2afaface001c7d4d981e38f186afe7b24a50
> change-id: 20260801-crosvm-658027011cb5
>
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>


--=20
Marc-Andr=C3=A9 Lureau

