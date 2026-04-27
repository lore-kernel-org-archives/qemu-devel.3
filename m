Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06900FF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 11:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHK8l-0002z3-88; Mon, 27 Apr 2026 07:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wHK8g-0002y7-NS
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 07:28:35 -0400
Received: from mail-dy1-x132d.google.com ([2607:f8b0:4864:20::132d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wHK8e-0001p4-Tw
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 07:28:34 -0400
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-2ba895adfeaso10610814eec.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 04:28:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777289311; cv=none;
 d=google.com; s=arc-20240605;
 b=P48qOtDvkoNCNjXyqLQrGVIfA+nsGtLGWBjj1r9NTp15ZcWC/sBcNCHRszEnJme6Ct
 y1Kc3qVs7Hl5CaI0GYLG/T1m8cVJaNyJiSjeXwW4wEjAFHI/0yq7ZgrQ42OwxZFnc5OM
 OH7DFRzwIAbP9lmhL4uUbjadwc5hu8G3ltHVL2MEmIM7k1avQeIuhLpY5pqRnVLa85yN
 C7kLQqktlt5BibvTGJT9MTYM2042E7hHNhOO0TUnmU1XYV5RFcRxiWZ2Ej3TLxMaCqMH
 IZmQQ3yZOu6J+0qxZb/yo90soQbg2OB5j5ePmzVliUVCjAAXKI87YxxNsHUn1WsI7snC
 v81g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vQLvnw4QxKU5cN0CgGQAV7edA2AV7YwLlhj+dYIfuQU=;
 fh=h2lKAM/Y0SRwRZDK+PZXbiU5EMSVJW1NvKTr6JQuA2U=;
 b=eMj6KbXvrwHyjnNLo3R6stzrU7xjkBQirQSf4Y9Z4Z3SJBelTRgHotMHI+tL0Yddbs
 IyOtlS/Y/FzXaEE+UqDMsqpcGNHv9tDUqmuahGFfEL+OuuU3cR8fi2pYhAy2Hwi0un90
 ue2EKxhzcmrgqVra5CT5+UWEDh8NSWIia1bNuf3uH2wE/OQ92anKtdO70G8fdhxzRf9i
 IqyHM0Fs2H0B4SRC3rzD0JfHZZ/69MY8zv4VL9y9dciRf44c71SrwOFYSl6Rf9+piuLv
 3/MnDxXLZem6kL58uRk00rLKQ9Itj7UoGucxT/SEHHnO/XXftRL+im0KWcEWrxtFDyyB
 NXNQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777289311; x=1777894111; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vQLvnw4QxKU5cN0CgGQAV7edA2AV7YwLlhj+dYIfuQU=;
 b=aT5VfVs/RWJi4ojpw0G/nAOOT2U5FBN3NBLpS9w6YK8+HiEqw1tAVQ5zp7RPvNZzVX
 4IjlLUOMhKdILKe51lCOBnvgCKJ4PD8iAbr9uqckB4AIYI9/Ta8JXqOO/w3nZbUPIHQX
 ojt2PynxRHa+TmXGfMgzFNbLYHmE1G8eMb3Hagwe3wQo5SGN7mWOeR/bqQpjfEOAYHC5
 t4/wZZtHg7R1kc3HH1nhQBvSfHT9LljgLtCIHJwurayS3ZsjNbCvW9fV7ltCHLgCqnq3
 GA9QylTDvVCji5jwnBUsDaZWJ3yTpYVOnrKaJbYkhnj7/TattryyXDb45xHKe4qJSBAn
 V+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777289311; x=1777894111;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vQLvnw4QxKU5cN0CgGQAV7edA2AV7YwLlhj+dYIfuQU=;
 b=YmTlHVfg8q0VF2BBFZm+PHl5Kx9GEiDPL/QjmSq9RO4yNpvzFZzZgUPNWubP7UPJS/
 Xv/Z5pyTIf3nL+RBGhz1/LLwULbRc/ZljooA6XS63Kr4S5wQTwS/33dSTc3XDDV2i7o4
 HDIhSXAWuUe03VXP4/L0DOfjf6aqPJpxF866T6vjZY/IB7r0oFRnbzfO9Q24dAfG55sX
 CKJy92LoP6W/RcQjSEuNo/QqeF5jGv4xqSR6mj23yFGlQNn4RB92N8mhOhgvzh16tDc7
 ap5hzNrXGZAUUgnqyTAIY5Frt3xoeWRy76lft3iQmHrZaP62sP3rFZPajGsT2dOo1Isa
 8ETA==
X-Gm-Message-State: AOJu0YyHYtkrzRVfOwxQQEK7JUOEzmIa1byQNmAf0IcgakBig+B+bTXo
 355e8o+iUhr3YACVrEp90NLLMFGSMlWE9TyZDFZ0qrfdHPt5v0TQABqGA/eRR+K/E4ie20/mVyb
 54uTRu9eu0F4yqH/x2eyGTTJTVfmFOW8=
X-Gm-Gg: AeBDiev1KUv3upGsc44cwFbl5+f+elC57akqr7RdWZjaoVNKRn7YAEbQCcdpN+3n8Ap
 4Zu8nQPtrGjrqpLWQa9s+05M9Qhk8k+F/Ph/1tNOBsuE1P6OYUcSD75fLfdr6Lan8OcSRE8HRUc
 Mai3ZoMu/RMBozgxtJONn+MMXcjAcEWfqMNVNYApV5yFjhS5T3OWL8c3EMnutWpCQgvLHsJAdwV
 rhgrMe3XvFAsd0idS4hItPBGsJj1/yqu02NBtL/qSMX1GhqkqPvBQ8VApZM+W+Ei+mzQsHTeXMN
 XEy5faHBlYL6ozZSFOn8LgHQlCx0uWpUsRhZM6A+Q2nppruD0Tc=
X-Received: by 2002:a05:7301:4186:b0:2d9:a799:3c4f with SMTP id
 5a478bee46e88-2e478e0c6a5mr23831250eec.24.1777289311133; Mon, 27 Apr 2026
 04:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260427105531.75701-1-benno.fuenfstueck@neodyme.io>
In-Reply-To: <20260427105531.75701-1-benno.fuenfstueck@neodyme.io>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 27 Apr 2026 15:28:18 +0400
X-Gm-Features: AVHnY4LImAiqjTuHya80gWYMhUEQ9x1UlSp5Z52MIXnnQZAyzZjn4Vh8zXPGtMU
Message-ID: <CAJ+F1CLjdAvjvCe9m5uQ9-gcL7iq-eJ0hamp5A3tm2D-kG_wzA@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-gpu: fix inverted mouse cursor
To: =?UTF-8?B?QmVubm8gRsO8bnN0w7xjaw==?= <benno.fuenfstueck@neodyme.io>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132d.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 MXG_EMAIL_FRAG=0.099, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi

On Mon, Apr 27, 2026 at 2:57=E2=80=AFPM Benno F=C3=BCnst=C3=BCck
<benno.fuenfstueck@neodyme.io> wrote:
>
> From: Benno F=C3=BCnfst=C3=BCck <benno.fuenfstueck@neodyme.io>
>
> This is a fix for a bug in virglrenderer, where if the guest uses hardwar=
e mouse cursor acceleration then the mouse cursor can end up being a resour=
ce with the flag Y_0_TOP set.
> But virglrenderer does not honor this flag when reading the cursor data.
> This has been fixed in current virglrenderer master.
> For older virglrenderer, we need to make sure to flip the cursor data suc=
h that display clients render it correctly.
>
> For example, this fixes mouse cursor rendering for wlroots-based window m=
anagers (like Sway) in Linux guests.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2315
> Signed-off-by: Benno F=C3=BCnfst=C3=BCck <benno.fuenfstueck@neodyme.io>

In v1, Akihiko raised a valid concern that this might be backported
and fixed in earlier version of virgl:
https://patchew.org/QEMU/20260409144639.3610-1-benno.fuenfstueck@neodyme.io=
/#40fb4df5-20a7-49ce-a087-d9c048255d05@rsg.ci.i.u-tokyo.ac.jp


> ---
> Now with a version check, since the fix for this is in virlglrenderer mas=
ter so I think it is any version newer than the current one (which is 1.3.0=
).
> I copied the code from virtio-gpu-virgl.c for the version check for simpl=
icty, if I should instead move that code for some DRY feel free to say so.
>
>  hw/display/virtio-gpu-gl.c | 45 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index 2b7a41c466..6505a84f5e 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -26,6 +26,25 @@
>
>  #include <virglrenderer.h>
>
> +/*
> + * VIRGL_CHECK_VERSION available since libvirglrenderer 1.0.1 and was fi=
xed
> + * in 1.1.0. Undefine bugged version of the macro and provide our own.
> + */
> +#if defined(VIRGL_CHECK_VERSION) && \
> +    VIRGL_VERSION_MAJOR =3D=3D 1 && VIRGL_VERSION_MINOR < 1
> +#undef VIRGL_CHECK_VERSION
> +#endif
> +
> +#ifndef VIRGL_CHECK_VERSION
> +#define VIRGL_CHECK_VERSION(major, minor, micro) \
> +    (VIRGL_VERSION_MAJOR > (major) || \
> +     VIRGL_VERSION_MAJOR =3D=3D (major) && VIRGL_VERSION_MINOR > (minor)=
 || \
> +     VIRGL_VERSION_MAJOR =3D=3D (major) && VIRGL_VERSION_MINOR =3D=3D (m=
inor) && \
> +     VIRGL_VERSION_MICRO >=3D (micro))
> +#endif
> +
> +#define VIRGL_NEEDS_CURSOR_DATA_FLIP_FIX (!VIRGL_CHECK_VERSION(1, 3, 1))
> +
>  static void virtio_gpu_gl_update_cursor_data(VirtIOGPU *g,
>                                               struct virtio_gpu_scanout *=
s,
>                                               uint32_t resource_id)
> @@ -33,6 +52,11 @@ static void virtio_gpu_gl_update_cursor_data(VirtIOGPU=
 *g,
>      VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(g);
>      uint32_t width, height;
>      uint32_t pixels, *data;
> +#if VIRGL_NEEDS_CURSOR_DATA_FLIP_FIX
> +    bool y_0_top =3D true;
> +    int ret;
> +    struct virgl_renderer_resource_info info;
> +#endif
>
>      if (gl->renderer_state !=3D RS_INITED) {
>          return;
> @@ -49,8 +73,29 @@ static void virtio_gpu_gl_update_cursor_data(VirtIOGPU=
 *g,
>          return;
>      }
>
> +#if VIRGL_NEEDS_CURSOR_DATA_FLIP_FIX
> +    memset(&info, 0, sizeof(info));
> +    ret =3D virgl_renderer_resource_get_info(resource_id, &info);
> +    if (ret =3D=3D 0) {
> +        y_0_top =3D info.flags & VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP;
> +    }
> +#endif
> +
>      pixels =3D s->current_cursor->width * s->current_cursor->height;
> +#if VIRGL_NEEDS_CURSOR_DATA_FLIP_FIX
> +    if (y_0_top) {
> +        memcpy(s->current_cursor->data, data, pixels * sizeof(uint32_t))=
;
> +    } else {
> +        uint32_t *dst =3D s->current_cursor->data;
> +        for (uint32_t y =3D 0; y < height; y++) {
> +            memcpy(dst + y * width,
> +                   data + (height - 1 - y) * width,
> +                   width * sizeof(uint32_t));
> +        }
> +    }
> +#else
>      memcpy(s->current_cursor->data, data, pixels * sizeof(uint32_t));
> +#endif
>      free(data);
>  }
>
> --
> 2.51.2
>
>
> --
> Neodyme AG
> Sitz der Gesellschaft / Address: Dirnismaning 55 | Halle 13 |
> 85748 Garching b.M=C3=BCnchen
> Postanschrift: Rosenthaler Stra=C3=9Fe 72a | 10119
> Berlin
>
> Registergericht / Registry court: M=C3=BCnchen, HRB 269168
> Vorstand /
> Management Board: Thomas Lambertz | Tobias Madl
> Aufsichtsratsvorsitzender /
> Chairman of the Supervisory Board: Hendrik Hofstadt
>
>
>
>
>


--=20
Marc-Andr=C3=A9 Lureau

