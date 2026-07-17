Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC20C44514
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wke5n-0007F4-HM; Fri, 17 Jul 2026 04:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wke5m-0007Ev-5a
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 04:38:46 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wke5k-0002qr-Ko
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 04:38:45 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-381b831d535so4801079a91.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 01:38:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784277523; cv=none;
 d=google.com; s=arc-20260327;
 b=PPMpH4zjscdIUlo1f+36Q8dVWFaPmxnSFzlMdphI7CL2E1qr72K7B2ak+ZkIvKvMub
 7OwlmMprC/sPnL95KxSkWe0s2PSMKYJYJHfc+9sbzXB9TW8hs+3nCCzVLE1NnVdb+Hry
 Kuxh7DoEE99uxrD0iz6V459cjZpgROf9k9LrCMR4ptMaRlmoquvvIe95qPCCRXjIsM52
 iHmis/9ky0xflGl65rusZvP8Ed6ASGmKKJOOQRkHkpdEwHFBfzvPHbIGnA+i4BS+bwxr
 EkskgVobmnuIRRAtLDLzJqziBiuRi8zSK7RZDcHbRA+mx+F1YPZIaLqjLJn8BV7S1Xip
 6pWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gOTyrjMrNS07ducISMeb2JsCvm/i4WxJAwHBeZxv1BE=;
 fh=fWOTDz5YDRO8gq4Ddplx48s4Kmwze/7hZKKkVfzrGlw=;
 b=VN0IUCgxivxGwxBgvcwwOWt0QSH6ovEFHWBWg4TO2njyo4dooueMAcYGD/fzSSH1wB
 uYtGdrV1pOUDvX06s/++dZaCK2uW0Ezhzn+Ga9qYYYvS3y9Lq7OHtPb1esspXzGccNpw
 rVtD81gCWy1W91afDqdeQTMt7VGkWmSTN2iZTBwKbI2ew6XZMH23fCcq4YkB+TzyhjyI
 0o1fbqtZZ0bTfgvpxBjyQJnA7FpN1xA1KADoV9XHCxdtureT1QpmPHmmF9qYoUksq2bq
 b3cNyZOjNWTOwK5sIFhKD8vu4TkpLD36lNcMjDltIjw0T/OcDQ8INiKMDZc9N2J+YxfU
 0oWA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784277523; x=1784882323; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gOTyrjMrNS07ducISMeb2JsCvm/i4WxJAwHBeZxv1BE=;
 b=cW6ZMtR0V0v+jKPxXsgZR6qt57YcHoU9jW5mDJ8UtwoN1DqTFwShB6DllLAZRTKFZr
 ORPalQlnKVg+6ONW49w4XOQmkGpN/QoBS7Rrwl5dp7kd6u6K/3dR8mHGWILNoa+7QnDw
 pNeLqZZDgWWl1lwP9mAXZez6kP4h0UZXrSnwU6oZZFHvgjn5CzF406NOIocOamdc76ZB
 KsrLjWalaAqkYoBKD6Rl/b5AJLMjj20OFdCt+auoCuKjEVJFbZiITtY0z2VeI/nSTGZ1
 txp0fXBaeviv2SK0/Ej3c8oXkKGTH1+hCIVXtVuysRjEsHAOYgpXHRn2aKuzm4UXHemA
 KsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784277523; x=1784882323;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gOTyrjMrNS07ducISMeb2JsCvm/i4WxJAwHBeZxv1BE=;
 b=sDG4rvApQiRsNTer/yQT8ry6b/ZbA0fTv4z1jZxzVkyEBHs4pPmQolNxMYbwoQeBmo
 T2U0+624tod/tE8DEeFI4Wl1zn3EywRP5VYx/RxG5wfBED3p9bPP/otBdMq1GN1lBrl8
 C4Lm19XyAYArdgp2AA8Y7zyDUPU4VksSigEk9WVm4zaaueyTv0oeYnks9gjCAJrx3hcY
 hrSrqdBiDnOh+gKTe59KvyAu6CIYjoegE/65HdUbXhGzYzRBwVDI85rxsIHt0r6wWCgM
 tVR+ib55OjZoy5xMcma1YexlEQyxHPNtHuU48+av/TgTTSzG6F19MohiVedfY1DgPVvm
 xWpw==
X-Gm-Message-State: AOJu0YyD2uAAYIy3UAVjfldFrQh4NJWMvYyiwB05OWygaPHLjHliuqgV
 oZA2G9HSRf7MdYry0ffysM2qBvn2QI37EmQXKq45WDi/NCy5IrUcb+ZLOc/emkX7V5TnPN7go8g
 Ja50PXfSzmXCIg/gf2zpMxP6k2/buI4k=
X-Gm-Gg: AfdE7cnAa1CefqBrLfgOGRgcXQ1yUvoqs6LLT76MyKU7y1X/MhCW/7yoGpBTN5T2GjO
 GhOKzYzCafY4qdaZs4d3LrLp9O/BwabF4QpM+X4PNtrIl1iRZ8AV8B7ZOnZQZ/etzXIwSiimF0e
 GYW5AKbtEWJcsC/WUpcYVuz0JY3e98CCpoBBbkBW1mvWGg0I0I/uu77gS6r+0tglfm8NOHbxOv0
 nqHp5n2F5glR0Qr2b+b4lrjRszJfxpbX/kYfeL+hKsz90a9sdpfLhEnb2dyFnZ6OWE5vXd681Gl
 DZTspUYwDoa9PJ70Lg==
X-Received: by 2002:a17:90b:278e:b0:38a:c3f:3b87 with SMTP id
 98e67ed59e1d1-38e4b454f0bmr1617200a91.12.1784277522585; Fri, 17 Jul 2026
 01:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260717-int-v1-1-8aa05e1791a0@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260717-int-v1-1-8aa05e1791a0@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 17 Jul 2026 12:38:29 +0400
X-Gm-Features: AUfX_mxIaPcSyTlwpuE2dqe-_EnTMLg4xrRP0I8ig7p2UEpZUYIiLTAzS8_9wVs
Message-ID: <CAJ+F1CJuXiop8j5-XO4HM=B3-jLU2QSAZYz5ERo8QO=ByhF5ig@mail.gmail.com>
Subject: Re: [PATCH] hw/display/virtio-gpu: reject strides exceeding INT_MAX
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj1-x1030.google.com
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

On Fri, Jul 17, 2026 at 11:43=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> VIRTIO_GPU_CMD_SET_SCANOUT_BLOB supplies a guest-controlled uint32_t
> stride, but some downstream consumers take it as int. They may interpret
> a value greater than INT_MAX as negative and cause issues:
>
> - pixman_image_create_bits() takes the stride as int, and Pixman may
>   later access memory before the blob buffer.
>
> - eglCreateImageKHR() also takes the stride as EGLint when importing the
>   DMA-BUF, and Mesa rejects it.
>
> Reject such strides before scanout.
>
> The check in virtio_gpu_scanout_blob_to_fb() rejects unsupported blob
> configurations early. The check added in virtio_gpu_do_set_scanout()
> covers migration post_load.
>
> Fixes: 32db3c63ae11 ("virtio-gpu: Add virtio_gpu_set_scanout_blob")
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
> Based-on: <20260715201055.2465320-1-marcandre.lureau@redhat.com>
> ("[PATCH] hw/display/virtio-gpu: validate stride against width on scanout=
")
> ---
>  hw/display/virtio-gpu.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index e00fb6effa50..9b54207feb37 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -654,6 +654,14 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
>          return false;
>      }
>
> +    if (fb->stride > INT_MAX) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: stride is %" PRIu32
> +                      ", larger than the supported maximum (%d)\n",
> +                      __func__, fb->stride, INT_MAX);
> +        *error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +        return false;
> +    }
> +
>      g->parent_obj.enable =3D 1;
>
>      if (res->blob) {
> @@ -769,6 +777,13 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu=
_framebuffer *fb,
>          return false;
>      }
>
> +    if (fb->stride > INT_MAX) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: stride is %" PRIu32
> +                      ", larger than the supported maximum (%d)\n",
> +                      __func__, fb->stride, INT_MAX);
> +        return false;
> +    }
> +
>      fb->offset =3D ss->offsets[0] + ss->r.x * fb->bytes_pp + ss->r.y * f=
b->stride;
>
>      fbend =3D fb->offset;
>
> ---
> base-commit: d25b8018680d762145d55ceed4fa7a3a47ac646e
> change-id: 20260716-int-6c94d32875b1
>
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
>


--=20
Marc-Andr=C3=A9 Lureau

