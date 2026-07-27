Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DF0C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woFX8-0005rI-Pf; Mon, 27 Jul 2026 03:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1woFX4-0005qj-Dg
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:13:50 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1woFX3-0004qM-01
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:13:50 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2cf27856f9cso29682095ad.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 00:13:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785136427; cv=none;
 d=google.com; s=arc-20260327;
 b=ZDRgvjeXPvViuwgnAzLKvYJb2oD+E82lmELRde3FeTp1+Wi6GPR92NUI95Zu0/D6KY
 HFzMQCDCmZfDRixe04d8bjLM8XisT8Xhe0IAmqnptA/B40NHOh/3CaFXzJAK6RZ4qGxs
 tWCC3e2DxAyCrLH8rsCpjdAejRPUfByRsA5Y+MkCA69ygq2lbdN8VhBU9GGpbpRjqtDt
 W6i2QaOoR36xpkv7JsLVf6o44cYn4/dVNciAex6NRkQeoVSleWlWr5NnJ9w0FpI5BG3+
 Ozk65NbFRHmPGQjsk3DlU8kQ8f8Fi288aOC3sliFZ9RqzX+XYvlo5rPLZ0mKns1ZC4oh
 Wflw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Xyz1M2kJHz0aLucJvd64WAg72n6dkt39SnKi390eiG8=;
 fh=KnxVq+/dNMGR5XtbHr3cm7WMCtMcRbEU6z8PkW8LG2I=;
 b=B+ei873GA2HTpRUSrMF5p9At6LsxM5P7kPF03KENP9rXNBRwqzVdbrAdC9zhVJYuEP
 etfPmCW1qG7vfPFb5i+mYQ0D2FhNm1O90HKXNGFK6giSvEaMXBS6mGb+JmYYhKGBiUv6
 7uh3XJsQrpc1NBjkAPxD3Bqri1o7LTKIM5+bpfUvllgE8FVKxi79PmvOXAsQObHQsCuG
 lSdGx1YkEQNQDKCjSVtbr1Qk/7J5US6/Jl90uqNWVxWdjQwsx/HKW5gc+dumGHZGINIb
 +8p8vy/CkZGxYH7zVMYZlVL40uQPJ8gggsIBu8O4yrHTUdQfZRaMSWZsuRhdVaaaTrYP
 2wfg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785136427; x=1785741227; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Xyz1M2kJHz0aLucJvd64WAg72n6dkt39SnKi390eiG8=;
 b=mfQcB+0tjb1nabaxpArpY2EXF3AUCfh/cCIDtSxRllmBoMuVTTxjFRYt4Ik5SjsOS0
 DSWD/1PUC2oJYbsvmrC9zGyOo0tl64C6YuCsMeRxyCPv3Y/a4fecaz50PCYM0AmztIAX
 XH0xRBzankv3QEVED8ia1+VAzkKdft63+YlcfKLlRcGSpLhFUM95lpUuviv4QH1qCrHQ
 3sneDHF1iqx+KytLMucpdr6qxaKSqf0WyoYEI5HrckuxTmfdReHhMiU5F/enps9iLJ+u
 TFmdRTZAC5aFOwOJ2WBPlGjqg3ZBr/ozY1qboHi+ktBGUN/Of6N6BW9qiP1esiiiRQ7J
 Fl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785136427; x=1785741227;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xyz1M2kJHz0aLucJvd64WAg72n6dkt39SnKi390eiG8=;
 b=dobVOqaXdv0a+dSYi06NHxdRgpJwvNXAheQYC7/FIL1HpEVpM2lWHSF9NtmjGh8zpk
 F8oYPDgZg08eNZMcraQZPIkBIddDo7OvTLEVaWxG7XWhBkGGqHuFoQgK307J7IQDV6p5
 m/p1N/Ey2hq2VxwKvSAVocvPG46qI/8rl0ImdcgAKLo4Lj49Om4OhtC8DMP0VIOG/hqh
 P8lD8GKopK54D7t4nsVh3JOqkjXkK5an+JQ1JlTR+vUxgY5tud2uwVqDkQK8gA/X8zEG
 wOSIyIpKpVzT/eeUwu129KMvXJ5JcJPdxqrsv1c2XL90niQQ11wWw9W6VfcuQbBJgOC3
 x5mA==
X-Gm-Message-State: AOJu0YzPJz9BYyo3fQ2h5KKLBpSlkfMJuxsMHZu2zuRn4xt3KvsVbrO2
 extAIdSYOtcIBOBXraVspLKSY94sEI25a7t4GaIiT6rw00iWjn09sI5iqdzdC4XAGZvtStIH2Kg
 zjjaH4yqG9DAx2lXXlltKlV8/mGJVbqE=
X-Gm-Gg: AR+sD11J+VDsYbiS0fcosfxHRVAjh9Moenr6/znFWLxuWvmgzyNq4wcA4P2nMLHttHS
 ckSj5c8fdbcIG+A0SgQ/vh8bDA19LQ4JyAmz3vfro7C18hBd6eXvXbICAYloC0NRj2EN2yGvnRG
 oMk7D172CVaNACXzogTgGTy1OyzMGZS1NS89N9jcPsCTamfWP269qEGrqexm4TTAxgUZTeiI17a
 O77G//66qpvu9ORDjcakQdbJ7nsCxoAOfpNbW8CLlK8g3mGyTljwBJ3Vn6kn4rMpOwbe24qH622
 f9nZ96Ool0Fxm2gRrA==
X-Received: by 2002:a05:6a20:9d8f:b0:3c3:9835:e75e with SMTP id
 adf61e73a8af0-3c67e07db58mr7593152637.70.1785136427433; Mon, 27 Jul 2026
 00:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260725-rutabaga-v1-1-4832b56e679d@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260725-rutabaga-v1-1-4832b56e679d@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 27 Jul 2026 11:13:35 +0400
X-Gm-Features: AUfX_myeJJ8HW1-qD7A1ZkKjk4w3hMY8v9R5Cs2X9uYKMwoNcSSg4H1FaCGKBAw
Message-ID: <CAJ+F1CJ_+3GCHakJWbDovWq72hnRgerKMciusrsVNTv68CDVkA@mail.gmail.com>
Subject: Re: [PATCH] hw/display/virtio-gpu: Block Rutabaga migration
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pl1-x62f.google.com
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

On Sat, Jul 25, 2026 at 11:17=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> The migration stream encoding is not defined for Rutabaga yet.
>
> Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxst=
ream")
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/display/virtio-gpu-rutabaga.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rut=
abaga.c
> index 4d7d7b245929..ad5cfabf4ee9 100644
> --- a/hw/display/virtio-gpu-rutabaga.c
> +++ b/hw/display/virtio-gpu-rutabaga.c
> @@ -9,6 +9,7 @@
>  #include "hw/virtio/virtio-gpu.h"
>  #include "hw/virtio/virtio-gpu-pixman.h"
>  #include "hw/virtio/virtio-iommu.h"
> +#include "migration/blocker.h"
>
>  #include <glib/gmem.h>
>  #include <rutabaga_gfx/rutabaga_gfx_ffi.h>
> @@ -1078,6 +1079,7 @@ static void virtio_gpu_rutabaga_handle_ctrl(VirtIOD=
evice *vdev, VirtQueue *vq)
>
>  static void virtio_gpu_rutabaga_realize(DeviceState *qdev, Error **errp)
>  {
> +    ERRP_GUARD();
>      uint32_t num_capsets;
>      VirtIOGPUBase *bdev =3D VIRTIO_GPU_BASE(qdev);
>      VirtIOGPU *gpudev =3D VIRTIO_GPU(qdev);
> @@ -1087,12 +1089,17 @@ static void virtio_gpu_rutabaga_realize(DeviceSta=
te *qdev, Error **errp)
>      return;
>  #endif
>
> -    if (!virtio_gpu_rutabaga_init(gpudev, errp)) {
> +    error_setg(&bdev->migration_blocker, "rutabaga is not yet migratable=
");
> +    if (migrate_add_blocker(&bdev->migration_blocker, errp) < 0) {
>          return;
>      }
>
> +    if (!virtio_gpu_rutabaga_init(gpudev, errp)) {
> +        goto fail;
> +    }
> +
>      if (!virtio_gpu_rutabaga_get_num_capsets(gpudev, &num_capsets, errp)=
) {
> -        return;
> +        goto fail;
>      }
>
>      bdev->conf.flags |=3D (1 << VIRTIO_GPU_FLAG_RUTABAGA_ENABLED);
> @@ -1101,6 +1108,12 @@ static void virtio_gpu_rutabaga_realize(DeviceStat=
e *qdev, Error **errp)
>
>      bdev->virtio_config.num_capsets =3D num_capsets;
>      virtio_gpu_device_realize(qdev, errp);
> +    if (!*errp) {
> +        return;
> +    }
> +
> +fail:
> +    migrate_del_blocker(&bdev->migration_blocker);
>  }
>
>  static const Property virtio_gpu_rutabaga_properties[] =3D {
>
> ---
> base-commit: 006a22cb26998998385b104db1ff9466ef2f3153
> change-id: 20260725-rutabaga-090ad4172817
>
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
>


--=20
Marc-Andr=C3=A9 Lureau

