Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B2DF34C49
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 13:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCHGd-0008Pc-4q; Mon, 13 Apr 2026 09:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wCHGZ-0008Nq-Sd
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 09:23:51 -0400
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wCHGY-0006yq-6I
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 09:23:51 -0400
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-1279eced0b9so5985995c88.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 06:23:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776086627; cv=none;
 d=google.com; s=arc-20240605;
 b=H6ykLhc5rfNV/dBhvg4Bqts0lCPsXjVwrt1TMcIJ7VDk5A+MTb3GPC9ws3Ae2FA+L9
 LkGnDP6f1RotL/SN/npbADN5uIHTt42/tMPm6VZcDKiFHxZTiFL6F791id1m8HPx9673
 W9LjgCRaO7J8opx4fwwX3gG2VKgmu06JYyAo1ry07lZ3BWoV1MBE0IAdJNZmbfecUvEi
 MHEibdPvjoW0yhXfiw7+xkwMfwdi+pEe+9SthEEEg8n8ts2++ELBgnc5agZ1VQtoAp5Z
 PADiPPK1XwpzKF9o79qixOv+asi6CFBezBcg3ThJTmnRsRZktlnJvw3cHL/5u+kUb51i
 wbGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=O2Mzf9zqVgF2e6DK87pOL11yPS6FLBmMBDRqYSvZSIE=;
 fh=h2lKAM/Y0SRwRZDK+PZXbiU5EMSVJW1NvKTr6JQuA2U=;
 b=GZOSm240I7kFCUSCXTxsCzFbvOr8vrvY2oao4uguxJO2ShFJNktZP6IdmLQTbJGOns
 sevduOxfIBmXMm783WTHPPBWh4xlj7J9mTJApLqU5uztO0RfC6YVv5RHJzNTFlDwKUZh
 HoTpYo2EBJdzJEk2dekeowYJDI+0iFmy53mvF9mAWQ8YFiOo8ingM0AsseVs4cW73Fvu
 WVW16oxb0nLWhlLUsQfQHXpKK+AWdt+1NF1EkK4KXdxjdE5TqJHD0CpbAp7SnH7xQ0d0
 dr+a/RVDf5A1TiNA4/2+C7QarQ1yEctd5yyXa1Ya1zZMa6aM7984CFHx05U9mP3zPiJh
 2LmA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776086627; x=1776691427; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O2Mzf9zqVgF2e6DK87pOL11yPS6FLBmMBDRqYSvZSIE=;
 b=URSG/MAwDB7M7eDhD4qTDq2sc+mHCXDw/Pt5aqmoQjqe1AxTlixXKCZBTQQej1lHdX
 dhgt1ku5k4i/pdY7cG3cAnZcPEgML2tkMwtRjrcJdvq4OR2bYUAr5WMqxmgsy2vHQ0up
 mCJwLz00qXRyBvB7/uIO/sMsfXiPuXvvezi4P3O2tpAuAftOvKJOfGneiKGsDLE9KghL
 baIDB0is95V37gtb0WaPvuxhf5ItgIUx495oR1U5cH0B6IwDTZ7BPM3cegL3FabHzPYG
 xh3cZY0spXCWeE2rSTuo7ELbuaqiU0/MVajeBTpHAF9ENMAo00BeVJrxKQs/qfd2D02C
 tqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776086627; x=1776691427;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O2Mzf9zqVgF2e6DK87pOL11yPS6FLBmMBDRqYSvZSIE=;
 b=HJh1DNgnwwoc62FsU1cj0GVqOxgLLsotqaE/kf2ALuSbyTQhBekPph0x64KyT41lgE
 g/pFfJA0tuMHsfW7GcwYQBIkE/9zAOatsWhpPooXO2l7R+hoOv6Q1U80i0lf8ZvjaMDM
 R0BxyiKvisypHaicGt6q+QkTYj2waoMhOih9gOiaUTPDrMK+iDOdMJlgZK3ai+NMneo8
 gR7yWsavl5yBQ9X7VSFEv3fx0jiKeaFZGIT/ZSwnIg2HUy/3Toz5+HGcKtFowdkZTs9d
 ++ls89CuODzEs12sCGlrLLg8TkvbBC8dBxSlJPwnowD3INQc1BQ4IX/MoxYrc9eqhv0b
 rWMg==
X-Gm-Message-State: AOJu0Yzw040fG23cyk+lez7lNigwL3gfKFF4LpwVG/aCD8BV+mdY7xaA
 ZxT1v+zWyHq7VuzKVeHNfB7oQqtXMJw+FcMK6VPIob7C7dsdZ5iI+gFBVQ4CEguTFucJlZFizvv
 BsjDvN7ULERfveD2URAZ3dlN9AgC+wVM=
X-Gm-Gg: AeBDieuxXEuqeriUrd6gzNMW9+YYirc8k3awBBSrmh2IsGJddqdKKXbZSFrdrPcFKVl
 O5Zvwovqdm055eTV7NcN5rkPDNqOKo8K0gaFhUzgoHVf7aA3eBX5JRlYEX4ZLz2nA4kZhBxqTvW
 jLfgeZ6iGNUmNIlFugBihzrMjVX8EGhHbfvKmvNBLpRmcU4azGYSx2PiVpWGzH3S00ZO1y2HJNl
 DkW1jmGnOPgWwMcps0DfFnVrcjWmO4UGGyOAzFc8jiofs+INrtqdiTb5cSjANBWCE67XMtUerHq
 VAcfBH3sxz0lMFpKnwwLiN4o1By2KgFF0KjNWGhP
X-Received: by 2002:a05:7022:eac7:b0:11a:fb3c:568b with SMTP id
 a92af1059eb24-12c34edefddmr7846538c88.17.1776086627050; Mon, 13 Apr 2026
 06:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260409144639.3610-1-benno.fuenfstueck@neodyme.io>
In-Reply-To: <20260409144639.3610-1-benno.fuenfstueck@neodyme.io>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 13 Apr 2026 17:23:34 +0400
X-Gm-Features: AQROBzBVnq8BbLZrmntZdrHyqczneBgXZSmfvsQBmg4kqXDpy-a9uc62n-Fj-QQ
Message-ID: <CAJ+F1CKYu4UfJyFJxPYLe9gjQhOD9QA7BrTmBXSCPuCDFgPf1A@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu: fix inverted mouse cursor
To: =?UTF-8?B?QmVubm8gRsO8bnN0w7xjaw==?= <benno.fuenfstueck@neodyme.io>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::122e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dl1-x122e.google.com
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

Hi Benno

On Thu, Apr 9, 2026 at 9:27=E2=80=AFPM Benno F=C3=BCnst=C3=BCck
<benno.fuenfstueck@neodyme.io> wrote:
>
> From: Benno F=C3=BCnfst=C3=BCck <benno.fuenfstueck@neodyme.io>
>
> When using virtio-gpu-gl, if the guest uses hardware mouse cursor acceler=
ation then the mouse cursor can end up being a resource with the flag Y_0_T=
OP set. In this case, we need to make sure to flip the cursor data such tha=
t display clients render it correctly.
>
> For example, this fixes mouse cursor rendering for wlroots-based window m=
anagers (like Sway) in Linux guests.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2315
> Signed-off-by: Benno F=C3=BCnfst=C3=BCck <benno.fuenfstueck@neodyme.io>

Arguably, this is a bug in virgl vrend_renderer_get_cursor_content(),
since the function doesn't return y0_top it should always return the
data in the correct orientation.

We may have a temporary workaround in qemu though for older virgl, but
I think it should be solved there too.

thanks

> ---
>  hw/display/virtio-gpu-gl.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index 2b7a41c466..4562d3405e 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -33,6 +33,9 @@ static void virtio_gpu_gl_update_cursor_data(VirtIOGPU =
*g,
>      VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(g);
>      uint32_t width, height;
>      uint32_t pixels, *data;
> +    bool y_0_top =3D true;
> +    int ret;
> +    struct virgl_renderer_resource_info info;
>
>      if (gl->renderer_state !=3D RS_INITED) {
>          return;
> @@ -49,8 +52,23 @@ static void virtio_gpu_gl_update_cursor_data(VirtIOGPU=
 *g,
>          return;
>      }
>
> +    memset(&info, 0, sizeof(info));
> +    ret =3D virgl_renderer_resource_get_info(resource_id, &info);
> +    if (ret =3D=3D 0) {
> +        y_0_top =3D info.flags & VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP;
> +    }
> +
>      pixels =3D s->current_cursor->width * s->current_cursor->height;
> -    memcpy(s->current_cursor->data, data, pixels * sizeof(uint32_t));
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
>      free(data);
>  }
>
> --
> 2.50.1 (Apple Git-155)
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

